@echo off
cls

:: Delete current GracePeriod key
REG DELETE "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\GracePeriod" /F

:: Restart server to re-generate GracePeriod key
SHUTDOWN /R /T 30
