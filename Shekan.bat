@echo off

set adapterName="Wi-Fi"
set dns1=178.22.122.100
set dns2=185.51.200.2

echo Toggling DNS servers for adapter %adapterName%...

netsh interface ipv4 show dnsservers name=%adapterName% | findstr "%dns1% %dns2%"

if %errorlevel% == 0 (
    echo Removing DNS servers...
    netsh interface ipv4 set dns name=%adapterName% source=dhcp
    netsh interface ipv4 set dns name=%adapterName% dhcp
    echo DNS servers removed successfully.
) else (
    echo Setting DNS servers %dns1% and %dns2%...
    netsh interface ipv4 set dns name=%adapterName% static %dns1% primary
    netsh interface ipv4 add dns name=%adapterName% %dns2% index=2
    echo DNS servers set successfully.
)

pause
