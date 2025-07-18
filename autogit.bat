@echo off
setlocal

REM --- Check if a commit message was provided ---
IF "%~1"=="" (
    echo.
    echo ERROR: You must provide a commit message.
    echo.
    echo Usage: %~n0 "Your commit message here"
    echo.
    goto :eof
)

REM --- Assign the full command line argument as the commit message ---
set "commitMessage=%*"

echo.
echo ===================================
echo  Automatic Git Upload Script
echo ===================================
echo.

echo [1/3] Staging all changes...
git add .
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Failed to stage files. Aborting.
    pause
    goto :eof
)
echo     Done.
echo.

echo [2/3] Committing changes with message:
echo     "%commitMessage%"
git commit -m "%commitMessage%"
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo WARNING: Commit failed. This might be because there are no new changes to commit.
    echo          Attempting to push existing commits...
) ELSE (
    echo     Done.
)
echo.

echo [3/3] Pushing to remote repository (origin main)...
git push origin main
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Failed to push changes to the remote repository.
    pause
    goto :eof
)
echo     Done.
echo.

echo ===================================
echo  Process completed successfully!
echo ===================================
echo.

endlocal 