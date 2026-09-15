*** Settings ***
Resource    ../../resources/api/api.resource

*** Variables ***


*** Keywords ***
Retrieve All Books
    ${response}    Api Get Request    resource=books/all/
    RETURN    ${response.json()}

Retrieve Amount Of Books
    ${response}    Api Get Request    resource=books/total/
    RETURN    ${response.json()}

Retrieve Book By Id
    [Arguments]    ${id}
    ${response}    Api Get Request    resource=books/${id}
    RETURN    ${response.json()}