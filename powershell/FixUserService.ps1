Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Serv*' | Select-Object -ExpandProperty Name | %{Add-WindowsCapability -Online -Name $_}
Set-Service -Name sshd -StartupType 'Automatic'
net user cloudbase-init /delete
sc.exe config cloudbase-init obj= .\LocalSystem
$newtext = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\cloudbase-init' -Name 'ImagePath' | Select-Object -ExpandProperty ImagePath | %{$_.replace(" cloudbase-init ", " NT-AUTHORITY\SYSTEM ")}
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\cloudbase-init' -Name 'ImagePath' -Value $newtext
Get-AppxPackage | Where-Object {$_.name -Like "*Language*"} | Remove-AppxPackage