@echo off
title MeatStock Pro - Установка
color 0A
cls
echo.
echo  ╔════════════════════════════════════╗
echo  ║  🥩 MeatStock Pro - Установка     ║
echo  ╚════════════════════════════════════╝
echo.

echo [1/5] Создаём Python окружение...
cd backend
python -m venv venv
call venv\Scripts\activate
pip install -r requirements.txt --quiet
echo ✅ Python окружение готово

echo [2/5] Создаём базу данных...
set PGPASSWORD=password
psql -U postgres -h localhost -c "CREATE DATABASE meatstock;" 2>nul
echo ✅ База данных создана

echo [3/5] Создаём таблицы...
python -c "
from app.database import Base, engine
from app.models.user import User
from app.models.supplier import Supplier
from app.models.raw_material import RawMaterial
from app.models.batch import Batch
from app.models.stock_movement import StockMovement
from app.models.recipe import Recipe, RecipeItem
from app.models.production_order import ProductionOrder
from app.models.invoice import Invoice
Base.metadata.create_all(bind=engine)
print('Таблицы созданы!')
"

echo [4/5] Создаём администратора...
python -c "
from app.database import SessionLocal
from app.models.user import User, UserRole, UserLanguage
from app.utils.auth import get_password_hash
db = SessionLocal()
if not db.query(User).filter(User.username == 'admin').first():
    db.add(User(
        full_name='Администратор',
        username='admin',
        hashed_password=get_password_hash('Admin123!'),
        role=UserRole.admin,
        language=UserLanguage.ru,
        is_active=True
    ))
    db.commit()
    print('Администратор создан!')
else:
    print('Администратор уже существует')
db.close()
"
cd ..

echo [5/5] Устанавливаем Frontend...
cd frontend
npm install --quiet
cd ..

echo.
echo  ╔════════════════════════════════════╗
echo  ║  ✅ Установка завершена!           ║
echo  ║                                    ║
echo  ║  Запустите: start.bat              ║
echo  ║  Логин:     admin                  ║
echo  ║  Пароль:    Admin123!              ║
echo  ╚════════════════════════════════════╝
pause