*** Settings ***
Library     RequestsLibrary


*** Variables ***



*** Test Cases ***
# - We beginnen met wat code
Get Book By By ID
    ${response}    Get    http://localhost:8000/books/1/

    Log To Console    ${response.json()}


# - In de suite
#     - sections
# - Valideren
# - huiswerk opdrachten

*** Keywords ***