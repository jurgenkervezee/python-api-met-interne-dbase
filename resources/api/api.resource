*** Settings ***
Library     RequestsLibrary


*** Variables ***
${url}    http://localhost:8000/


*** Keywords ***
Api Get Request
    [Documentation]    Sends a get request to a resource
    ...                - Returns `response of the api call` of type `response`.
    ...
    ...                Example:
    ...                | Api Get Request    resource=books/total/
    ...                |                    status string=404

    [Arguments]    ${resource}
    ...            ${status string}=200

    ${response}    Get    ${url}${resource}

    RETURN    ${response}