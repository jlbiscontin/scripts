# Public DNS files backup v2, run @ Veeam server!

# NOTAS:
# Copy-Item -FromSession REQUIRES PS 5.0+ on both sides! (I'm looking at you 2012r2...)
# Si esta fuera de dominio, antes de ejecutar el script agregar el PSSession hostname a los TrustedHosts
# del equipo en el cual se ejecutara el script (ej: en el server Veeam 2012r2std-64)
# Set-Item WSMan:\localhost\Client\TrustedHosts -Value 'SRVCLOUDTSOFT04.tsoftglobal.com' -Concatenate
# Y agregar el user a usar (ej: 'TSOFT\svcBKP') al grupo 'Administrators' del server al cual le apuntamos (ej: 'SRVCLOUDTSOFT04')
# Probe loguear via WinRM con el user en el grupo de 'Backup Operators' pero rebota, solo le gusta como 'Administrators'
# Como call Task: -NonInteractive -NoLogo -ExecutionPolicy Bypass -File "C:\DNS_BKP_v2.ps1" -VM "NS1" -HV "SRVCLOUDTSOFT04.tsoftglobal.com"


# Declare variables, first the ones required to pass when calling the script!
param(
    [Parameter(Mandatory, HelpMessage="Enter Virtual Machine name.")]
    [string] $VM,
    [parameter(Mandatory, HelpMessage="Enter Hyper-V host machine FQDN.")]
    [string] $HV
)
$DestDisk = 'R:\Backups\DNSs\'
$User = 'TSOFT\svcBKP'
$Pass = 'Kfe%Mhw$E3Cm88B@'
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, (ConvertTo-SecureString $Pass -AsPlainText -Force)


# Establish PS Session
$PSSession = New-PSSession -ComputerName $HV -Credential $Cred

# Source ($Using:LocalDeclaredVariable, $SrcDir= \* to copy ONLY directory contents, aka no 'DNS' subfolder on destination)
$SnapName = 'DNS_BKP_' + $VM
$SrcDisk = Invoke-Command -Session $PSSession -ScriptBlock {
    (Get-VM $Using:VM | Checkpoint-VM -SnapshotName $Using:SnapName -Passthru | %{Get-VHD -VMId $_.vmid} | 
    %{Mount-VHD $_.ParentPath -ReadOnly -Passthru} | Get-Disk | Get-Partition | Get-Volume | 
    Where-Object FileSystemLabel -ne 'System Reserved').DriveLetter}
$SrcDir = $SrcDisk + ':\Windows\System32\DNS\*'

# Destination
$Date = (Get-Date).ToString('yyyy-MM-dd')
$DestDir = $DestDisk + $SnapName + '_' + $Date + '\'

# Actual backup / copy
Copy-Item -Path $SrcDir -Destination $DestDir -Exclude *.log -FromSession $PSSession -Recurse -Force

# CleanUp
Invoke-Command -Session $PSSession -ScriptBlock {Get-VMSnapshot -VMName $Using:VM -Name $Using:SnapName | 
    %{Get-VHD -VMId $_.vmid} | %{Dismount-VHD $_.ParentPath} ; Remove-VMSnapshot -VMName $Using:VM -Name $Using:SnapName}
Remove-PSSession $PSSession
