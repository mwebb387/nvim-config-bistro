$CurPath = pwd 
cd $PSScriptRoot\src
fennel .\build.fnl .\ $env:LOCALAPPDATA\nvim\lua\
cd $CurPath
