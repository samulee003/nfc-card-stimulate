@echo off
echo ========================================
echo  Git Repository Cleanup Script
echo ========================================
echo.
echo This script will remove large files from Git history
echo and force push the cleaned repository.
echo.
echo WARNING: This will rewrite Git history!
echo.
pause

echo.
echo [1/4] Removing large files from Git cache...
git rm --cached -r java-* 2>nul
git rm --cached -r jdk* 2>nul
git rm --cached -r OpenJDK* 2>nul
git rm --cached -r SimpleNFCCardApp/gradle-* 2>nul
git rm --cached -r SimpleNFCCardApp/OpenJDK* 2>nul
git rm --cached SimpleNFCCardApp/*.zip 2>nul
git rm --cached *.zip 2>nul

echo.
echo [2/4] Adding .gitignore changes...
git add .gitignore

echo.
echo [3/4] Committing cleanup...
git commit -m "Clean up: Remove large files and update .gitignore"

echo.
echo [4/4] Force pushing to remote (this will rewrite history)...
git push --force-with-lease origin main

echo.
echo ========================================
echo  Cleanup completed!
echo ========================================
pause 