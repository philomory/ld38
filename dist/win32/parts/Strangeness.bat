@ECHO OFF

mkdir "%appdata%\Strangeness\"
mkdir "%appdata%\Strangeness\game"

set GF="%appdata%\Strangeness\game"

copy ld38.rb "%GF%\"
xcopy /s /y ruby "%GF%\ruby\"
xcopy /s /y src "%GF%\src\"
xcopy /s /y media "%GF%\media\"
xcopy /s /y data "%GF%\data\"

cd "%GF%"

ruby\bin\ruby.exe ld38.rb

cd ..

del /Q game