*** Settings ***

Library    SeleniumLibrary
Resource    ${CURDIR}${/}..${/}/Pages/SalesforceCommonPage.robot

*** Keywords ***

Enter credentials
    [Arguments]    ${username}    ${password}
    wait until page contains    Username    60 seconds
    SalesforceCommonPage.SendText    Username    ${username}
    SalesforceCommonPage.SendText    Password     ${password}
    click button    Log In to Sandbox
    sleep    3 seconds
    ${elem_size} =    Run Keyword And Return Status    Element Should Be Visible    //div[@id='header']//span[text()='Scheduled Maintenance']
    Run Keyword If    ${elem_size}    Click Element    //div[@id='message']//a[text()='Got it']
    wait until page contains    Home
    page should contain    Home