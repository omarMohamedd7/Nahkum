@echo off
echo Fixing Android SDK Build Tools...

cd /d C:\Users\User\AppData\Local\Android\android-sdk\cmdline-tools\latest\bin

echo Uninstalling Build Tools 33.0.1...
call sdkmanager --uninstall "build-tools;33.0.1"

echo Installing Build Tools 33.0.1...
call sdkmanager --install "build-tools;33.0.1"

echo Installing latest Build Tools as backup...
call sdkmanager --install "build-tools;34.0.0"

echo Done! Please try building your app again.
pause 