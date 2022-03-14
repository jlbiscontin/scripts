# MKT RouterOS config backup v2, run @ Veeam server!

# NOTAS:
# Como call Task: -NonInteractive -NoLogo -ExecutionPolicy Bypass -File "C:\MKT_BKP_v2.ps1" -ID "RINGO" -IP "172.16.10.250" -Port "2222"
# Generated OpenSSH Key and imported on RouterOS for passwordless login! (no funcionaba -pw con PuTTY ni nada por el estilo)
# RouterOS Policies needed: ssh, ftp, read, write, policy, test, sensitive (write is ONLY needed for 'file remove')

# Declare variables, first the ones required to pass when calling the script!
param(
    [Parameter(Mandatory, HelpMessage="Enter MikroTik ID.")]
    [string] $ID,
    [Parameter(Mandatory, HelpMessage="Enter MikroTik IP.")]
    [string] $IP,
    [Parameter(Mandatory, HelpMessage="Enter MikroTik SSH Port.")]
    [string] $Port
)
$User = 'svcBKP'
$DestDisk = 'R:\Backups\MKTs\'

# Destination
$Date = (Get-Date).ToString('yyyy-MM-dd')
$ConfigScript = $DestDisk + 'MKT_' + $ID + '_' + $Date + '.rsc'
$ConfigBackup = $DestDisk + 'MKT_' + $ID + '_' + $Date + '.backup'

# Get MKTs config script
ssh -p $Port $User@$IP /export > $ConfigScript

# Create backup
ssh -p $Port $User@$IP /system backup save name=backup

# Backup transfer ( '*>$null' to hide error message from unexpected sftp console output! 'sftp : ...')
sftp -P $Port $User@${IP}:/backup.backup $ConfigBackup *>$null

# Backup cleanup / removal
ssh -p $Port $User@$IP /file remove [find type="backup"]
