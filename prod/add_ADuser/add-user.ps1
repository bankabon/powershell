#AD追加ユーザー追加.bat

#CSV読み込み
$csvname = "users.csv"
$users = Import-Csv $csvname

#OU情報
$ou = ""

#初期パスワード
$password = "Password@2023"

foreach($u in $users){
$username = $u.username
$surnname = $u.surnname
$givenname = $u.givename
$displayname = $u.displayname


New-ADUser $username `
-Surname $surnname -GivenName $givenname -DisplayName $displayname `
-Path $ou -AccountPassword $password -Enabled $true `
-UserPrincipalName $username

}