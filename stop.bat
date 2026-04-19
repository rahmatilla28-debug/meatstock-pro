@echo off
echo 🛑 Останавливаем MeatStock Pro...
taskkill /F /FI "WINDOWTITLE eq MeatStock-Backend" >nul 2>&1
taskkill /F /FI "WINDOWTITLE eq MeatStock-Frontend" >nul 2>&1
taskkill /F /IM "node.exe" >nul 2>&1
echo ✅ Остановлено!
pause