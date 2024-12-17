*** Settings ***

Library    SeleniumLibrary
Resource    ${CURDIR}${/}..${/}/Pages/SalesforceCommonPage.robot
Variables    ${CURDIR}${/}..${/}/Variables/GlobalVariables.yml
Variables    ${CURDIR}${/}..${/}/Variables/SalesforceVariables.yml

*** Keywords ***

Select "Sales" from the menu grid
    wait until element is visible    ${menu_dots_button}    60 seconds
    click element    ${menu_dots_button}
    wait until element is visible    ${app_search_text_box}    60 seconds
    input text    ${app_search_text_box}      Fastly Sales
    wait until element is visible    ${app_search_result_link}    60 seconds
    double click element    ${app_search_result_link}
    wait until element is not visible    ${app_launcher_menu}    60 seconds

Select "Accounts" tab
    SalesforceCommonPage.ClickTopNavigationTab    Accounts

Select "Leads" tab
    SalesforceCommonPage.ClickTopNavigationTab    Leads

Select "Contacts" tab
    SalesforceCommonPage.ClickTopNavigationTab    Contacts

Select "Opportunities" tab
    SalesforceCommonPage.ClickTopNavigationTab    Opportunities