# �Ǘ��Ҍ����̏����쐬
$securePassword = ConvertTo-SecureString -String "admin" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("admin", $securePassword)

#�R�}���h�ϐ���`
$scriptpath = "C:\azureAD\administrator_user.ps1"


#�Ǘ��Ҍ����̈���
$arg = "Start-Process -FilePath powershell -ArgumentList '-ExecutionPolicy Bypass -File `"$scriptpath`"' -Verb RunAs"

#�Ώۃt�@�C�������[�U�[�w��ŊǗ��Ҍ������s
Start-Process -FilePath powershell -Credential $credential -ArgumentList $arg -PassThru -Wait 

