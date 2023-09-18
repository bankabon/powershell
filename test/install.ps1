#変数定義
#フィアル置き場
$filepass = "\\10.0.0.200\setup\installer"
$installer = "C:\kitting"

#ディレクトリ作成
mkdir C:\kitting

#インストールファイル移行
Copy-Item $filepass -Destination $installer

#googlechromeサイレントインストール
Start-Process -pass "$(installer)\googlechromestandaloneenterprise64.msi" -ArgumentList "/VERYSILENT /NORESTART" -Wait

#vscodeサイレントインストール
Start-Process -pass "$(installer)\VSCodeUserSetup-x64-1.82.0.exe" -ArgumentList "/VERYSILENT /NORESTART" -Wait

#terratermサイレントインストール
Start-Process -pass "$(installer)\WinSCP-6.1.1-Setup.exe" -ArgumentList "/VERYSILENT /NORESTART" -Wait
