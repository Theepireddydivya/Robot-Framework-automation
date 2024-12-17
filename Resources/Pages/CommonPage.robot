*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource    LoginPage.robot
Variables    ${CURDIR}${/}..${/}/Variables/GlobalVariables.yml

*** Keywords ***

Open browser and navigate to url
    [Arguments]    ${sf_url}    ${browser}
    #Set Environment Variable    webdriver.chrome.driver    ${EXECDIR}\\Tests\\Bin\\chromedriver.exe
    Open Browser    ${sf_url}    ${browser}
    maximize browser window
    set browser implicit wait    10 seconds
    
wait_for_page_load
    Wait For Condition  return document.readyState == "complete"