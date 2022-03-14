# VPN server config backup v2, run @ Veeam server!

# NOTAS:
# Como call Task: -NonInteractive -NoLogo -ExecutionPolicy Bypass -File "C:\VPN_BKP_v2.ps1" -ID "229" -IP "172.16.10.1" -Port "5555"


# Declare variables, first the ones required to pass when calling the script!
param(
    [Parameter(Mandatory, HelpMessage="Enter VPN Server ID.")]
    [string] $ID,
    [Parameter(Mandatory, HelpMessage="Enter VPN Server IP.")]
    [string] $IP,
    [Parameter(Mandatory, HelpMessage="Enter VPN Server Port.")]
    [string] $Port
)
$Server = $IP + ':' + $Port
$Pass = 'softetherserverpass'
$DestDisk = 'R:\Backups\VPNs\'


# Destination
$Date = (Get-Date).ToString('yyyy-MM-dd')
$ConfigFile = $DestDisk + 'VPN_' + $ID + '_' + $Date + '.config'

# Get VPNs config files
VPNCMD /Server $Server /PASSWORD:$Pass /CMD ConfigGet $ConfigFile
