set /p name="指定したいコンピューター名"

wmic computersystem where name="%computername%" call rename name="%name%"

echo
hostname

pause
shutdown /r /t 0
exit