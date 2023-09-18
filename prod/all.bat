@echo off
rem フォルダー作成
    mkdir "C:\download"
    mkdir "C:\localadmin"
    rem downloadはpcmover;localadminは管理者権限用

echo ---------------------------------------------------
echo これはazureAD,pcmoverインストールバッチです。
echo これから準備しますが、これ以降PC作業しないでください。
echo もし作業中や、開いてるものがある場合は保存して閉じてください。
echo これから注意事項を説明します。
echo 準備ができましたらEnterをおしてください
echo ----------------------------------------------------

pause

echo.
echo ======================注意事項=========================
echo ・こちらは一回限りの.batになってます。
echo ・実行後再起動しますが、正常ですのでご安心ください。
echo ・再起動後通常通りログオンして手順書通りに設定を進めてください。
echo ・わからないことおかしなことがあった際は辻口に声をかけてください。
echo ======================================================
echo.

set /p answer="いっとく？ (y/n):" 
if "%answer%" == "y" (

    rem ユーザー確認テキスト吐き出し
    echo %username%> C:\localadmin\user.txt

    rem -----↓ここからpcmover用スクリプト
    
        rem スタート用.bat
        (
        echo @echo off
        echo powershell -ExecutionPolicy Bypass -File "C:\download\install.ps1"
        ) > "C:\download\start.bat"

        rem powershellでダウンロードしてインストール様.ps1
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

    rem -----↓ここから管理者権限用スクリプト
        rem スタート用.bat
        (
            echo @echo off
            echo powershell -ExecutionPolicy Bypass -File "C:\localadmin\localadmin_start.ps1"
        ) > "C:\localadmin\start.bat"

        rem powershell管理者権限で動かすためのスクリプト
        (
            echo # 管理者権限の情報を作成
            echo $securePassword = ConvertTo-SecureString -String "admin" -AsPlainText -Force
            echo $credential = New-Object System.Management.Automation.PSCredential^("admin", $securePassword^)
            echo.
            echo #コマンド変数定義
            echo $scriptpath = "C:\localadmin\local_admin.ps1"
            echo.
            echo #管理者権限の引数
            echo $arg = "Start-Process -FilePath powershell -ArgumentList '-ExecutionPolicy Bypass -File `"$scriptpath`"' -Verb RunAs"
            echo.
            echo #対象ファイルをユーザー指定で管理者権限実行
            echo Start-Process -FilePath powershell -Credential $credential -ArgumentList $arg -PassThru -Wait 
        ) > "C:\localadmin\localadmin_start.ps1"

        rem powerashell管理者権限で実行するファイルの生成
        (
            echo Start-Sleep -s 5
            echo.
            echo $user = Get-Content "C:\localadmin\user.txt"
            echo.
            echo #administratorsグループにユーザーを追加
            echo Add-LocalGroupMember -Group Administrators -Member $user
        ) > "C:\localadmin\local_admin.ps1"

    rem 説明
    echo 開始！
    echo.
        rem localadminスタート
        cd C:\localadmin
        call start.bat

        rem pcmoverスタート
        cd C:\download
        call start.bat

    echo 問題なく終了した場合はenterを投下してください。
    pause

    rem 削除
    cd C:\
    rd /s /q "C:\download"
    rd /s /q "C:\localadmin"

    rem 説明
    echo.
    echo.
    echo バッチファイルを自滅させます。
    echo 問題がある場合は辻口まで
    echo 問題なく終了した場合はenterを投下してください。

    pause
    shutdown -r -t 0
    rem 自分自身を削除する
    del /f "%~dp0%~nx0"
        

) else (
    echo 処理をキャンセルしました。
    exit
)
