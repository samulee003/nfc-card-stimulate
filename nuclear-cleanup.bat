@echo off
echo ========================================
echo  NUCLEAR Git Cleanup Script
echo ========================================
echo.
echo WARNING: This will COMPLETELY REWRITE Git history!
echo All large files will be permanently removed from ALL commits.
echo.
echo Large files to be removed:
echo - All JDK directories (java-*, jdk*, OpenJDK*)
echo - All Gradle zips (gradle-*.zip)
echo - All other .zip files (except gradle-wrapper.jar)
echo.
echo This process may take several minutes...
echo.
pause

echo.
echo [1/6] Backing up current branch...
git branch backup-before-cleanup

echo.
echo [2/6] Removing large files from Git history (this may take a while)...
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch -r java-* jdk* OpenJDK* SimpleNFCCardApp/gradle-* SimpleNFCCardApp/OpenJDK* SimpleNFCCardApp/jdk* SimpleNFCCardApp/*.zip *.zip" --prune-empty --tag-name-filter cat -- --all

echo.
echo [3/6] Cleaning up Git references...
git for-each-ref --format="delete %(refname)" refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo.
echo [4/6] Updating .gitignore...
git add .gitignore

echo.
echo [5/6] Making final commit...
git commit -m "Final cleanup: Remove all large files from history"

echo.
echo [6/6] Force pushing clean history...
git push --force origin main

echo.
echo ========================================
echo  Nuclear cleanup completed!
echo  Repository size should now be minimal.
echo ========================================
pause 