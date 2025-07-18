:: Create and navigate to the spectre directory on the Desktop
set DESKTOP=%USERPROFILE%\Desktop
mkdir "%DESKTOP%\spectre"
cd "%DESKTOP%\spectre"

:: Download and unzip rusty-spectre
curl -OL https://github.com/spectre-project/rusty-spectre/releases/download/v0.3.16/rusty-spectre-v0.3.16-windows-gnullvm-amd64.zip
powershell -Command "Expand-Archive -Path 'rusty-spectre-v0.3.16-windows-gnullvm-amd64.zip' -DestinationPath ."
del rusty-spectre-v0.3.16-windows-gnullvm-amd64.zip
move bin\* .
rmdir /s /q bin

:: Download and unzip spr_bridge
cd "%DESKTOP%\spectre"
curl -OL https://spectredbase.com/windows/spr_bridge-v0.3.15-windows-x64.zip
powershell -Command "Expand-Archive -Path 'spr_bridge-v0.3.15-windows-x64.zip' -DestinationPath ."
del spr_bridge-v0.3.15-windows-x64.zip
move spr_bridge-v0.3.15-windows-x64\* .
rmdir /s /q spr_bridge-v0.3.15-windows-x64

:: Download and run startNodeBridge.bat
curl -OL https://spectredbase.com/windows/startNodeBridge.bat
start startNodeBridge.bat

cd "%DESKTOP%\
del installNodeBridge.bat