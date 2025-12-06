*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}         http://the-internet.herokuapp.com/login
${BROWSER}     Chrome
${VALID_USER}  tomsmith
${VALID_PASS}  SuperSecretPassword!
${INVALID_PASS}    Password!
${INVALID_USER}    tomholland

*** Test Cases ***

Login success
    [Documentation]    To verify that a user can login successfully when they put a correct username and password.
    Open Browser    ${URL}    ${BROWSER}
    Input Text    id=username    ${VALID_USER}
    Input Text    id=password    ${VALID_PASS}
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain  You logged into a secure area!
    Click Element    xpath=//a[@href="/logout"]
    Page Should Contain  You logged out of the secure area!
    Sleep    3s
    Close Browser

Login failed - Password incorrect
    [Documentation]    To verify that a user cannot login with correct username but wrong password.
    Open Browser    ${URL}    ${BROWSER}
    Input Text    id=username    ${VALID_USER}
    Input Text    id=password    ${INVALID_PASS}
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    Your password is invalid!
    Sleep    3s
    Close Browser

Login failed - Username not found
    [Documentation]    To verify that a user cannot login with a username that does not exist.
    Open Browser    ${URL}    ${BROWSER}
    Input Text    id=username    ${INVALID_USER}
    Input Text    id=password    ${INVALID_PASS}
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    Your username is invalid!
    Sleep    3s
    Close Browser