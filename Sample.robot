*** Variables ***
${AutoIt}         C:\\Program Files (x86)\\AutoIt3\\AutoIt3.exe    # Path to AutoIt3
${ExpectedCreateFileContent}    Hello, this is a test\n    # Nội dung file sau khi tạo

*** Settings ***
Library           Process
Library           OperatingSystem
Library           DateTime

*** Test Cases ***
Create file notepad
    [Documentation]    Open notepad
    ...
    ...    Input text to edit area
    ...
    ...    Save file
    Log    Start test
    ${current_datetime}    Get Current Date
    Log    Run at: ${current_datetime}
    Start Process    ${AutoIt}    note.au3    ${current_datetime}
    ${result}    Wait For Process    timeout=10
    Should Be Equal As Strings    ${result.rc}    0
    ${content}    Get File    ${CURDIR}\\data\\test.txt
    Should Be Equal As Strings    ${content}    ${ExpectedCreateFileContent}${current_datetime}
    Log    End Test
