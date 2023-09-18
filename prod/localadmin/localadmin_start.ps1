#現在のユーザー確認
$users = Get-ChildItem Env:\USERNAME
$user = $users.Value

Write-Output $user | Out-File user.txt



# 管理者権限の情報を作成
$securePassword = ConvertTo-SecureString -String "admin" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("admin", $securePassword)

#コマンド変数定義
$scriptpath = "C:\localadmin\local_admin.ps1"


#管理者権限の引数
$arg = "Start-Process -FilePath powershell -ArgumentList '-ExecutionPolicy Bypass -File `"$scriptpath`"' -Verb RunAs"

#対象ファイルをユーザー指定で管理者権限実行
Start-Process -FilePath powershell -Credential $credential -ArgumentList $arg -PassThru -Wait 


