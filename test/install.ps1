#�ϐ���`
#�t�B�A���u����
$filepass = "\\10.0.0.200\setup\installer"
$installer = "C:\kitting"

#�f�B���N�g���쐬
mkdir C:\kitting

#�C���X�g�[���t�@�C���ڍs
Copy-Item $filepass -Destination $installer

#googlechrome�T�C�����g�C���X�g�[��
Start-Process -pass "$(installer)\googlechromestandaloneenterprise64.msi" -ArgumentList "/VERYSILENT /NORESTART" -Wait

#vscode�T�C�����g�C���X�g�[��
Start-Process -pass "$(installer)\VSCodeUserSetup-x64-1.82.0.exe" -ArgumentList "/VERYSILENT /NORESTART" -Wait

#terraterm�T�C�����g�C���X�g�[��
Start-Process -pass "$(installer)\WinSCP-6.1.1-Setup.exe" -ArgumentList "/VERYSILENT /NORESTART" -Wait
