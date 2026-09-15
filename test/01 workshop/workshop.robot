*** Settings ***
Library     RequestsLibrary


*** Variables ***



*** Test Cases ***
Get Book By By ID
    ${response}    Get    http://localhost:8000/books/1/

    Log To Console    ${response.json()}



*** Keywords ***
