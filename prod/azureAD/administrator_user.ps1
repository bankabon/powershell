write-output "���W���[���C���X�g�[����"

#���W���[���̃C���X�g�[��
Install-Module -Name AzureAD
Install-Module -Name Microsoft.Graph.Intune
#�C���|�[�g���W���[��
Import-Module AzureAD
Import-Module Microsoft.Graph.Intune

pause

Write-Output "�e�i���g�w�肵��azureAD�ڑ���"
#�N���f���V�����쐬
$securePassword = ConvertTo-SecureString -String "Kota0725747123" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("ktsujiguchi@iyell.jp", $securePassword)

#�e�i���g�̎w��
$tenantId = "3ee722ef-8981-4682-a5b3-ebd961613210"
Connect-AzureAD -TenantId $tenantId -Credential $credential

#�f�o�C�X��
$deviceName = $env:COMPUTERNAME
Write-Output $deviceName

#���[�U�[���
$userPrincipalName = "test-intune@iyell.jp" # ���[�U�[�� UPN
Write-Output $userPrincipalName

# ���[�U�[�̃I�u�W�F�N�g ID ���擾
$userObjectId = Get-AzureADUser -SearchString $userPrincipalName

#deviceOSver�擾
$osver1 = Get-WmiObject Win32_OperatingSystem
$osver =$osver1.Version

# �f�o�C�X�̃I�u�W�F�N�g ID ���擾
$device = Get-AzureADDevice -SearchString $deviceName
if($device -eq $null){
    $key = [System.Text.Encoding]::Unicode.GetBytes("X509:<SHA1-TP-PUBKEY><Thumbprint>")
     $altsecid = New-Object -TypeName PSObject -Property @{
     'Key' = $key
     'Type' = "2" }
     
     Write-Output $altsecid
     pause

        $guid = New-Guid
            #�f�o�C�X�V�K�o�^
            $device = New-AzureADDevice -AccountEnabled $true -DisplayName $deviceName -AlternativeSecurityIds $altsecid -DeviceId $guid -DeviceOSType "windows" -DeviceOSVersion $osver
            }
pause

#�f�o�C�X���L�ғo�^
Add-AzureADDeviceRegisteredOwner -ObjectId $device.ObjectId -RefObjectId $userObjectId.ObjectId
Add-AzureADDeviceRegisteredUser -ObjectId $device.ObjectId -RefObjectId $userObjectId.ObjectId



pause