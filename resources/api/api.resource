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
    ...                |                    payload={ "payload": "json stuffs"}
    [Arguments]    ${resource}
    ...            ${status string}=200
    ...            ${payload}={}
    ...            ${params}={}
    ...            ${headers}={}

    ${response}    Get    ${url}${resource}
    ...                   json=${payload}
    ...                   params=${params}
    ...                   verify=${False}

    Should Be Equal As Strings    ${response.status_code}    ${status string}

    RETURN    ${response}