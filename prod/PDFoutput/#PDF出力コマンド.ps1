#PDF出力コマンド
#-----------------------------------
# 処理名：自動印刷
#-----------------------------------
#対象フォルダ
$folder = Get-Location

#予告メッセージ
Write-Host "$folder フォルダ直下のファイルをすべて印刷する！"
Write-Host "※ファイル間のスリープ処理：2秒`r`n"

#ファイル名の昇順で印刷実行
Dir $folder | Sort Name | ForEach{

    #ファイル名表示後、実行
    Write-Host $_.Name
    Start-Process $_.FullName -Verb Print | Stop-Process

    #2秒スリープ
    Start-Sleep -s 2
}

Write-Host "`r`n完了！`r`n"
Read-Host "×ボタンで終了"