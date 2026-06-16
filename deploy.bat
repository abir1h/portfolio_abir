@echo off
REM Flutter Portfolio Firebase Deployment Script

echo 🚀 Starting deployment process...
echo.

REM Check if Flutter is installed
where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Flutter is not installed or not in PATH
    exit /b 1
)

REM Check if Firebase CLI is installed
where firebase >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Firebase CLI is not installed
    echo Install it with: npm install -g firebase-tools
    exit /b 1
)

echo 📦 Building Flutter web app (release mode)...
flutter build web --release

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Build failed. Please fix errors and try again.
    exit /b 1
)

echo.
echo ✅ Build successful!
echo.
echo 🌐 Deploying to Firebase Hosting...
firebase deploy --only hosting

if %ERRORLEVEL% EQU 0 (
    echo.
    echo 🎉 Deployment successful!
    echo.
    echo Your portfolio is now live! Check the URL above.
) else (
    echo.
    echo ❌ Deployment failed. Please check the error messages above.
    exit /b 1
)

