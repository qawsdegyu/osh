@echo off
chcp 65001 > nul
cd /d "%~dp0"

echo ========================================================
echo        جاري رفع موقع عُش للعطور إلى GitHub
echo        المستودع: https://github.com/qawsdegyu/osh
echo ========================================================
echo.

:: 1. التحقق من وجود Git
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [خطأ]: برنامج Git غير مثبت أو غير مضاف إلى PATH!
    echo يرجى تثبيت Git من: https://git-scm.com/ ثم إعادة المحاولة.
    echo.
    pause
    exit /b 1
)

:: 2. تهيئة المستودع
if not exist ".git" (
    echo [1/4] تهيئة مستودع Git محلي...
    git init
    git branch -M main
    git remote add origin https://github.com/qawsdegyu/osh.git
) else (
    echo [1/4] مستودع Git مهيأ مسبقاً.
    git remote remove origin >nul 2>nul
    git remote add origin https://github.com/qawsdegyu/osh.git
    git branch -M main
)

:: 3. إضافة الملفات
echo.
echo [2/4] إضافة وتجهيز الملفات...
git add .

:: 4. عمل Commit
echo.
echo [3/4] إنشاء الـ Commit...
git commit -m "تثبيت الشعار ووسوم البحث والمشاركة وحفظ التصميم الأصلي"

:: 5. الرفع إلى GitHub
echo.
echo [4/4] جاري الرفع إلى فرع main...
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo --------------------------------------------------------
    echo [تنبيه] إذا كان المستودع على GitHub يحتوي على ملفات سابقة،
    echo جاري محاولة الرفع مع فرض التحديث (Force Push)...
    git push -u origin main --force
)

if %errorlevel% equ 0 (
    echo.
    echo ========================================================
    echo ✅ تم رفع الموقع بنجاح إلى GitHub!
    echo رابط المستودع: https://github.com/qawsdegyu/osh
    echo ========================================================
) else (
    echo.
    echo ❌ حدث خطأ أثناء الرفع. تأكد من تسجيل دخولك في Git أو صلاحيات الحساب.
)

echo.
pause
