*** Settings ***
Resource    ../../resources/business object/api-get-requests.resource


*** Variables ***


*** Test Cases ***
Retrieve And Print All Books
    ${response}    Retrieve All Books
    Log To Console    ${response}

Retrieve Amount Of Books
    ${response}    Retrieve Amount Of Books
    Log To Console    ${response}[total_books]

Retrieve Book By ID
    ${response}    Retrieve Book By Id    id=1
    Log To Console    ${response}