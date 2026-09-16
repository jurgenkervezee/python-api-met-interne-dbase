*** Settings ***
Library     RequestsLibrary


*** Variables ***



*** Test Cases ***
Get Book By By ID
    ${response}    Get    http://localhost:8000/books/1/

    Log To Console    ${response.json()}

# - We beginnen met wat code
# - Terug naar de basics
#     - Data types
#         - String
#         - Integer
#     - collecties
#         - list
#         - dictionary 
# - In de suite
#     - sections
# - Valideren
# - huiswerk opdrachten

*** Keywords ***
