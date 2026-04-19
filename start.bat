@echo off
title MeatStock Pro
color 0A
cls
echo.
echo  ╔════════════════════════════════════╗
echo  ║  🥩 MeatStock Pro v1.0.0          ║
echo  ╚════════════════════════════════════╝
echo.

echo ▶️ Запускаем базу данных...
net start postgresql-x64-15 >nul 2>&1
net start postgresql-x64-14 >nul 2>&1
net start postgresql >nul 2>&1
timeout /t 2 /nobreak >nul
echo ✅ База данных запущена

echo ▶️ Запускаем Backend...
cd backend
call venv\Scripts\activate
start "MeatStock-Backend" /MIN cmd /k "uvicorn app.main:app --host 127.0.0.1 --port 8000"
cd ..
timeout /t 4 /nobreak >nul
echo ✅ Backend запущен

echo ▶️ Запускаем Frontend...
cd frontend
start "MeatStock-Frontend" /MIN cmd /k "npm start"
cd ..
timeout /t 10 /nobreak >nul

echo.
echo  ╔══════════════════════════════════════════╗
echo  ║  ✅ MeatStock Pro запущен!               ║
echo  ║                                          ║
echo  ║  🌐 Сайт:   http://localhost:3000        ║
echo  ║  📚 API:    http://localhost:8000/api/docs║
echo  ║  👤 Логин:  admin                        ║
echo  ║  🔑 Пароль: Admin123!                    ║
echo  ╚══════════════════════════════════════════╝
echo.
start http://localhost:3000
pause