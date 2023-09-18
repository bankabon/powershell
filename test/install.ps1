#変数定義
#フィアル置き場
$filepass = "\\10.0.0.200\setup\installer"
$installer = "C:\kitting"

#

#インストールファイル移行
Copy-Item $filepass -Destination $installer


