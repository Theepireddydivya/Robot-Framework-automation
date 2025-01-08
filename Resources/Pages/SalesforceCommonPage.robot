*** Settings ***

Library    SeleniumLibrary

*** Keywords ***

ClickTopNavigationTab
    [Arguments]    ${tab_name}
    wait until element is visible    xpath=//a[@title='${tab_name}']    60 seconds
    double click element    xpath=//a[@title='${tab_name}']
    Wait Until Element Is Visible    xpath=//lst-breadcrumbs//*[text()='${tab_name}']    60 seconds
    Sleep    1s

SendText
    [Arguments]    ${label_name}    ${value}
    Wait Until Element Is Visible    xpath=//input[@id=//label[text()='${label_name}']/@for]    60 seconds
    Input Text    xpath=//input[@id=//label[text()='${label_name}']/@for]    ${value}

Is Text Field Enabled
    [Arguments]    ${label_name}
    Wait Until Element Is Visible    xpath=//input[@id=//label[text()='${label_name}']/@for]    60 seconds
    ${enabled}    xpath=//input[@id=//label[text()='${label_name}']/@for]
    [Return]    ${enabled}

Select from Dropdown
    [Arguments]  ${dropdown_name}  ${dropdown_value}
    Wait Until Element Is Visible  xpath=//button[@id=//label[normalize-space(text())='${dropdown_name}']/@for]
    click element  xpath=//button[@id=//label[normalize-space(text())='${dropdown_name}']/@for]
    wait until page contains  ${dropdown_value}
    click element  //div[@id=//button[@id=//label[normalize-space(text())='${dropdown_value}']/@for]/@aria-controls]//span[@title='${dropdown_value}']

Select from Search Text Field
    [Arguments]    ${label_name}    ${value}
    Input Text    xpath=//input[@id=//label[text()='${label_name}']/@for]    ${value}
    Wait Until Element Is Visible    xpath=//div[@role='listbox']//lightning-base-combobox-item[@role='option']//lightning-base-combobox-formatted-text[@title='${value}']
    Click Element    xpath=//div[@role='listbox']//lightning-base-combobox-formatted-text[@title='${value}']

Verify ModalisDisplayed
    [Arguments]    ${dialog_title}
    Wait Until Element Is Visible    xpath=//div[@role='dialog'][@aria-modal='true']//h2[text()='${dialog_title}']    60 seconds
    Element Should Be Visible    xpath=//div[@role='dialog'][@aria-modal='true']//h2[text()='${dialog_title}']

Verify radioIsSelected
    [Arguments]    ${radio_value}
    element attribute value should be    //label//span[text()='${radio_value}']/ancestor::label//input[@value=//label/@for]    defaultchecked    true    ${radio_value} is not selected.

Click ModalButton
    [Arguments]    ${button_name}
    Click Element    xpath=//div[@aria-modal='true']//button//span[text()='${button_name}']
