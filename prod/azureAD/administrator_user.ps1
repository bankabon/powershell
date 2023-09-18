write-output "モジュールインストール中"

#モジュールのインストール
Install-Module -Name AzureAD
Install-Module -Name Microsoft.Graph.Intune
#インポートモジュール
Import-Module AzureAD
Import-Module Microsoft.Graph.Intune

pause

Write-Output "テナント指定してazureAD接続中"
#クレデンシャル作成
$securePassword = ConvertTo-SecureString -String "Kota0725747123" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("ktsujiguchi@iyell.jp", $securePassword)

#テナントの指定
$tenantId = "3ee722ef-8981-4682-a5b3-ebd961613210"
Connect-AzureAD -TenantId $tenantId -Credential $credential

#デバイス名
$deviceName = $env:COMPUTERNAME
Write-Output $deviceName

#ユーザー情報
$userPrincipalName = "test-intune@iyell.jp" # ユーザーの UPN
Write-Output $userPrincipalName

# ユーザーのオブジェクト ID を取得
$userObjectId = Get-AzureADUser -SearchString $userPrincipalName

#deviceOSver取得
$osver1 = Get-WmiObject Win32_OperatingSystem
$osver =$osver1.Version

# デバイスのオブジェクト ID を取得
$device = Get-AzureADDevice -SearchString $deviceName
if($device -eq $null){
    $key = [System.Text.Encoding]::Unicode.GetBytes("X509:<SHA1-TP-PUBKEY><Thumbprint>")
     $altsecid = New-Object -TypeName PSObject -Property @{
     'Key' = $key
     'Type' = "2" }
     
     Write-Output $altsecid
     pause

        $guid = New-Guid
            #デバイス新規登録
            $device = New-AzureADDevice -AccountEnabled $true -DisplayName $deviceName -AlternativeSecurityIds $altsecid -DeviceId $guid -DeviceOSType "windows" -DeviceOSVersion $osver
            }
pause

#デバイス所有者登録
Add-AzureADDeviceRegisteredOwner -ObjectId $device.ObjectId -RefObjectId $userObjectId.ObjectId
Add-AzureADDeviceRegisteredUser -ObjectId $device.ObjectId -RefObjectId $userObjectId.ObjectId



pause