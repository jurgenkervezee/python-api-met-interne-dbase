*** Settings ***
Library     RequestsLibrary


*** Variables ***



*** Test Cases ***
# - We beginnen met wat code
Get Book By By ID
    ${response}    Get    http://localhost:8000/books/1/

    Log To Console    ${response.json()}


# Data types
Voorbeeld Van String

    ${string 1}    Set Variable    Henk
    ${string 2}    Set Variable    Truus

    Log To Console    ${string 1} en ${string 2}

Voorbeeld Van Integer

    ${int}    Set Variable    ${1}

    Log To Console    ${int}

# collecties
Voorbeeld Van list
    ${list}    Create List    abc    def    ghi    

    Log To Console    ${list}
    Log To Console    ${list}[1]

Voorbeeld Van Dictionary

    ${dict}    Create Dictionary    naam=Jurgen    functie=Tester    werkgever=Oelan

    Log To Console    ${dict}
    Log To Console    ${dict}[werkgever]

# - In de suite
#     - sections
# - Valideren
# - huiswerk opdrachten

*** Keywords ***