@echo off
rem �t�H���_�[�쐬
    mkdir "C:\download"
    mkdir "C:\localadmin"
    rem download��pcmover;localadmin�͊Ǘ��Ҍ����p

echo ---------------------------------------------------
echo �����azureAD,pcmover�C���X�g�[���o�b�`�ł��B
echo ���ꂩ�珀�����܂����A����ȍ~PC��Ƃ��Ȃ��ł��������B
echo ������ƒ���A�J���Ă���̂�����ꍇ�͕ۑ����ĕ��Ă��������B
echo ���ꂩ�璍�ӎ�����������܂��B
echo �������ł��܂�����Enter�������Ă�������
echo ----------------------------------------------------

pause

echo.
echo ======================���ӎ���=========================
echo �E������͈������.bat�ɂȂ��Ă܂��B
echo �E���s��ċN�����܂����A����ł��̂ł����S���������B
echo �E�ċN����ʏ�ʂ胍�O�I�����Ď菇���ʂ�ɐݒ��i�߂Ă��������B
echo �E�킩��Ȃ����Ƃ������Ȃ��Ƃ��������ۂ͒Ҍ��ɐ��������Ă��������B
echo ======================================================
echo.

set /p answer="�����Ƃ��H (y/n):" 
if "%answer%" == "y" (

    rem ���[�U�[�m�F�e�L�X�g�f���o��
    echo %username%> C:\localadmin\user.txt

    rem -----����������pcmover�p�X�N���v�g
    
        rem �X�^�[�g�p.bat
        (
        echo @echo off
        echo powershell -ExecutionPolicy Bypass -File "C:\download\install.ps1"
        ) > "C:\download\start.bat"

        rem powershell�Ń_�E�����[�h���ăC���X�g�[���l.ps1
        (
            echo $securePassword = ConvertTo-SecureString -String "admin" -AsPlainText -Force
            echo $credential = New-Object System.Management.Automation.PSCredential^("admin", $securePassword^)
            echo.
            echo # �_�E�����[�h
            echo Invoke-WebRequest "https://store.laplink.com/59/purl-20200408-Page-PPMfree-dl" -OutFile "C:\download\pcmoverpmce_ml.exe"
            echo.
            echo # �C���X�g�[���[�̃p�X
            echo $InstallerPath = "C:\download\pcmoverpmce_ml.exe"
            echo.
            echo # �C���X�g�[���[�̃R�}���h���C���������w�肵�ăT�C�����g�C���X�g�[�������݂��
            echo $ArgumentList = "-WindowStyle Hidden -command `"Start-Process '$InstallerPath'`" -verb runas"
            echo.
            echo # ���s
            echo Start-Process -FilePath powershell.exe -ArgumentList $ArgumentList -Credential $credential -Wait
        ) > "C:\download\install.ps1"

    rem -----����������Ǘ��Ҍ����p�X�N���v�g
        rem �X�^�[�g�p.bat
        (
            echo @echo off
            echo powershell -ExecutionPolicy Bypass -File "C:\localadmin\localadmin_start.ps1"
        ) > "C:\localadmin\start.bat"

        rem powershell�Ǘ��Ҍ����œ��������߂̃X�N���v�g
        (
            echo # �Ǘ��Ҍ����̏����쐬
            echo $securePassword = ConvertTo-SecureString -String "admin" -AsPlainText -Force
            echo $credential = New-Object System.Management.Automation.PSCredential^("admin", $securePassword^)
            echo.
            echo #�R�}���h�ϐ���`
            echo $scriptpath = "C:\localadmin\local_admin.ps1"
            echo.
            echo #�Ǘ��Ҍ����̈���
            echo $arg = "Start-Process -FilePath powershell -ArgumentList '-ExecutionPolicy Bypass -File `"$scriptpath`"' -Verb RunAs"
            echo.
            echo #�Ώۃt�@�C�������[�U�[�w��ŊǗ��Ҍ������s
            echo Start-Process -FilePath powershell -Credential $credential -ArgumentList $arg -PassThru -Wait 
        ) > "C:\localadmin\localadmin_start.ps1"

        rem powerashell�Ǘ��Ҍ����Ŏ��s����t�@�C���̐���
        (
            echo Start-Sleep -s 5
            echo.
            echo $user = Get-Content "C:\localadmin\user.txt"
            echo.
            echo #administrators�O���[�v�Ƀ��[�U�[��ǉ�
            echo Add-LocalGroupMember -Group Administrators -Member $user
        ) > "C:\localadmin\local_admin.ps1"

    rem ����
    echo �J�n�I
    echo.
        rem localadmin�X�^�[�g
        cd C:\localadmin
        call start.bat

        rem pcmover�X�^�[�g
        cd C:\download
        call start.bat

    echo ���Ȃ��I�������ꍇ��enter�𓊉����Ă��������B
    pause

    rem �폜
    cd C:\
    rd /s /q "C:\download"
    rd /s /q "C:\localadmin"

    rem ����
    echo.
    echo.
    echo �o�b�`�t�@�C�������ł����܂��B
    echo ��肪����ꍇ�͒Ҍ��܂�
    echo ���Ȃ��I�������ꍇ��enter�𓊉����Ă��������B

    pause
    shutdown -r -t 0
    rem �������g���폜����
    del /f "%~dp0%~nx0"
        

) else (
    echo �������L�����Z�����܂����B
    exit
)
