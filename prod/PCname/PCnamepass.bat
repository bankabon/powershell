set /p name="�w�肵�����R���s���[�^�[��"

wmic computersystem where name="%computername%" call rename name="%name%"

echo
hostname

pause
shutdown /r /t 0
exit