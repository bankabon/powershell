@echo off
mkdir "C:\download"

(
echo @echo off
echo powershell -ExecutionPolicy Bypass -File "C:\download\install.ps1"
) > "C:\download\start.bat"


(
echo $securePassword = ConvertTo-SecureString -String "admin" -AsPlainText -Force
echo $credential = New-Object System.Management.Automation.PSCredential^("admin", $securePassword^)
echo.
echo # ダウンロード
echo Invoke-WebRequest "https://store.laplink.com/59/purl-20200408-Page-PPMfree-dl" -OutFile "C:\download\pcmoverpmce_ml.exe"
echo.
echo # インストーラーのパス
echo $InstallerPath = "C:\download\pcmoverpmce_ml.exe"
echo.
echo # インストーラーのコマンドライン引数を指定してサイレントインストールを試みる例
echo $ArgumentList = "-WindowStyle Hidden -command `"Start-Process '$InstallerPath'`" -verb runas"
echo.
echo # 実行
echo Start-Process -FilePath powershell.exe -ArgumentList $ArgumentList -Credential $credential -Wait
) > "C:\download\install.ps1"

pause

cd C:\download
call start.bat

pause

cd C:\

rd /s /q "C:\download"

pause