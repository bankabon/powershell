set /p copy="コピー元の階層"
set /p right="コピー先の回送"

robocopy %copy% %right% /MIR /R:3 /W:5 /DCOPY:DAT 

