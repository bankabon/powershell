Start-Sleep -s 5

$user = Get-Content "C:\localadmin\user.txt"

Write-Output $user
pause

 #administratorsグループにユーザーを追加
Add-LocalGroupMember -Group Administrators -Member $user

