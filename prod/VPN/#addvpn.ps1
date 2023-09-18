#addvpn

$VpnName = "セールニーズ"
$VpnUrl = "homekota.aa0.netvolante.jp"
$PreKey = "homenet"

$RasExec = "C:\windows\system32\rasdial.exe"
$VpnUser = Read-Host "指定されたユーザーを打ち込んでください"
$VpnPass = Read-Host "指定されたPWを打ってください"

#Remove Vpn Adaptor
#Remove-VpnConnection -Name $VpnName -Force -PassThru

#Create VPN Adaptor
Add-VpnConnection -Name $VpnName `
                  -ServerAddress $VpnUrl `
                  -RememberCredential -L2tpPsk $PreKey `
                  -AuthenticationMethod MSChapv2 `
                  -AuthenticationMethod Chap `
                  -EncryptionLevel Required `
                  -TunnelType L2tp `
                  -Force

#Add User & Pass
cmd.exe /c $RasExec $VpnName $VpnUser $VpnPass

#Disconnect
cmd.exe /c $RasExec /Disconnect