@echo off
setlocal enabledelayedexpansion

:: Prompt the user for input
set /p input="Enter one or more words: "

:: Initialize an empty output string
set output=

:: Loop through each word in the input
for %%a in (%input%) do (
    set "word=%%a"
    set "firstLetter=!word:~0,1!"
    set "modified=!firstLetter!-!firstLetter!-%%a"
    set "output=!output! !modified!"
)

:: Display the result
echo %output%

:: Output the result to a text file
echo %output% > output.txt

:: Copy the result to the clipboard
echo %output% | clip

:: Notify the user
echo "Result saved to output.txt and copied to clipboard."

:: Pause so user can see reuslts.
pause
