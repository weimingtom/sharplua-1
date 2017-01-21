@del /F /Q /A:H *.suo
@del /F /Q *.user *.dll project.lock.json .gitignore .gitattributes
@rmdir /S /Q bin obj 
@pause
