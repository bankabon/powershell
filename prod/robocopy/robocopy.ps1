#ポリシー変更
Set-ExecutionPolicy RemoteSigned -Scope Process

#Robocopy用スクリプト
Write-Host "ロボコピのパワーシェルです。"
Start-Sleep -s 5

#コピー元指定
$west=Read-Host "コピー元の指定"

#コピー先の指定
$lloo=Read-Host "コピー先の指定"

#コピー先の確認
Write-Host "コピー先の最終確認です"
Write-Host $west
write-host $lloo

Pause

#コピーコマンド
Robocopy $west $lloo /MIR /DCOPY:DAT /r:1 /w:1 /MOT:1