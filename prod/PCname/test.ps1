#PS1実行用ポリシー変更
Set-ExecutionPolicy RemoteSigned Process

#ユーザー名確認
Get-WmiObject Win32_UserAccount | ? { $_.LocalAccount -eq $true }

#追加したいユーザー名
$n=Read-Host "指定したい名前"

#追加
Add-LocalGroupMember -Group "Administrators" -Member $n