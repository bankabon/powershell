set /p copy="�R�s�[���̊K�w"
set /p right="�R�s�[��̉�"

robocopy %copy% %right% /MIR /R:3 /W:5 /DCOPY:DAT 

