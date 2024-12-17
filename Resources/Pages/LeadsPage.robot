*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String
Resource    ${CURDIR}${/}..${/}/Pages/SalesforceCommonPage.robot
Resource    CommonPage.robot
Variables    ${CURDIR}${/}..${/}/Variables/GlobalVariables.yml
Variables    ${CURDIR}${/}..${/}/Variables/TestData.yml
Variables    ${CURDIR}${/}..${/}/Variables/SalesforceVariables.yml

*** Variables ***
@{window_handles}

*** Keywords ***
Verify the New button is displayed
    wait until element is visible    ${dashboard_new_button}    60 seconds
    page should contain element    ${dashboard_new_button}

Click on the New button
    click link    New

Verify the modal dialog is displayed
    SalesforceCommonPage.Verify ModalisDisplayed    New Lead

Click on "Next" button
    SalesforceCommonPage.Click ModalButton    Next

Verify the New Lead dialog screen is displayed
    SalesforceCommonPage.Verify ModalisDisplayed    New Lead

Enter the mandatory fields and create a Lead
    wait until page contains    New Lead
    page should contain    New Lead
    wait until page contains   Next
    page should contain    Next
    Sleep    3 seconds
    Click Element    ${next_button_locator}
    ${current_time}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${last_name}=    Set Variable    User${current_time}
    SalesforceCommonPage.SendText    Last Name    ${last_name}
    SalesforceCommonPage.SendText    First Name    ${lead.firstname}
    SalesforceCommonPage.SendText    Company    ${lead.company}
    ${lead.Email} =  Catenate  SEPARATOR=  ${current_time}  @example.com
    SalesforceCommonPage.SendText    Email    ${lead.Email}
    Sleep    3 seconds
    Double Click Element    ${save_button_locator}
    Wait Until Element Is Not Visible    ${save_button_locator}    60 seconds


Convert Lead
  wait until page contains  Convert
  page should contain    Convert
  Click Element   ${btnConvertLead}
  Sleep    10 seconds
  @{window_handles}    Get Window Handles
  Log  ${window_handles}
  ${parent_window}    Set Variable    ${window_handles}[0]
  ${child_window}    Set Variable    ${window_handles}[1]
  Switch Window    ${child_window}
  ${title}    Get Title
  Log Title
  Wait Until Element Is Visible    ${txtConvertLeadMessage}
  Scroll Element Into View    ${txtConvertLeadMessage}
  ${message}    Get Text    ${txtConvertLeadMessage}
  Run Keyword If    '${message}' == 'Convert Lead'  actions   

actions
  Sleep    6 seconds
  ${created_record_url}    Get Location
  Log    Convert Lead successfully: ${created_record_url}
  Wait Until Element Is Visible    ${btnDetailConvert}
  Select From List by Index    name=accid    1
  Click Element    ${btnDetailConvert}
  Sleep    5 seconds     
  Wait Until Element Is Visible    ${inputConvertNewLead}
  Click Element    ${inputConvertNewLead}
  ${createdRecordUrl} =    Get Location
  Log    Convert Lead successfully ${createdRecordUrl}
  Sleep    10 seconds 
  
afterLeadConversionVerifyAccount
  Wait Until Element Is Visible    ${accountTab}
  ${account_tab_visible}=  Page Should Contain Element  ${accountTab}
  Run Keyword If  ${account_tab_visible}  Click Element  ${accountTab}
  Wait Until Element Is Visible  ${accountDetailTab}
  ${account_detail_tab_visible}=  Page Should Contain Element  ${accountDetailTab}
  Run Keyword If  ${account_detail_tab_visible}  Click Element  ${accountDetailTab}
  ${createdRecordUrl} =    Get Location
  Log    Convert Lead successfully ${createdRecordUrl}
  ${accname}    Get Text    ${accountName}
  Run Keyword If    '${accname}' == '${lead.company}'  Log  Converted Account record verified successfully! Account Name: ${accname}
afterLeadConversionVerifyContact
  @{window_handles}    Get Window Handles
  Log  ${window_handles}
  ${parent_window}    Set Variable    ${window_handles}[0]
  ${child_window}    Set Variable    ${window_handles}[1]
  Switch Window    ${parent_window}
  Close Window
  Switch Window    ${child_window}
  ${title}    Get Title
  Log Title
  Wait Until Element Is Visible    ${accountRelatedShowAll}
  Scroll Element Into View  ${accountRelatedShowAll}
  Sleep   3 seconds
  Click Element  ${accountRelatedShowAll}
  Sleep   3 seconds
  Wait Until Element Is Visible    ${accountContactsLinkClick}
  Click Element  ${accountContactsLinkClick}
  Wait Until Element Is Visible    ${contactNameLinkClick}
  Click Element  ${contactNameLinkClick}
  Sleep   3 seconds
  ${createdRecordUrl} =    Get Location
  Log    Convert Lead successfully ${createdRecordUrl}
  ${accname}    Get Text    ${accountName}
  Run Keyword If    '${accname}' == '${lead.company}'  Log  Converted contact record verified successfully! Account Name: ${accname}
  Wait Until Element Is Visible    ${btnoppty}

createNewOpportunity
  Click Element  ${btnoppty}
  Wait Until Element Is Visible    ${btnoppty}
  Sleep   3 seconds
  Select From List by Value    name=selectRecordType    Standard
  Wait Until Element Is Visible    ${newOpptyNext}
  Click Element  ${newOpptyNext}
  Sleep   3 seconds
  ${popUpopptyname}    Get Text    ${newOpportunityStandard}
  Run Keyword If    '${popUpopptyname}' == '${Opportunity.NewOpportunityStandard}'  Log  Oppty pop is displayed: ${popUpopptyname}
  #Wait Until Element Is Visible    ${opptyName}
  #wait until page contains  ${opptyName}
  SalesforceCommonPage.SendText    Opportunity Name    ${lead.company}
  Sleep   3 seconds
  Run Keyword And Ignore Error  Scroll Element Into View  ${opptyStage}
  Scroll Element Into View  ${opptyStage}
  #Scroll Element Into View    ${opptyStage}
  #Select from Dropdown  Stage  Qualification
  #wait until page contains  ${opptyStage}
  #page should contain  ${opptyStage}
  #Execute JavaScript  document.getElementByXpath("//label[contains(text(),'Stage')]/../descendant::button").onclick();
  ${ele}    Get WebElement    //label[contains(text(),'Stage')]/../descendant::button
  Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
  #Click Element  ${opptyStage}
  #Sleep   3 seconds
  #wait until page contains  ${opptyStageQualification}
  Click Element  ${opptyStageQualification}
  Sleep   3 seconds
  ${CloseDate}  Get WebElement  //label[contains(text(),'Close Date')]/../descendant::button
  #Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
  Sleep   3 seconds
  ${date_string}    Get Current Date    result_format=%m/%d/%Y
  Run Keyword And Ignore Error  Scroll Element Into View  ${CloseDate}
  SalesforceCommonPage.SendText  Close Date  ${date_string}
  Sleep   3 seconds
  ${ForecastedFastlyTraffic(TB)}  Get WebElement  //label[contains(text(),'Forecasted Fastly Traffic (TB)')]/../descendant::button
  Run Keyword And Ignore Error  Scroll Element Into View  ${ForecastedFastlyTraffic(TB)}
  SalesforceCommonPage.SendText  Forecasted Fastly Traffic (TB)  ${Opportunity.ForecastedFastlyTraffic}
  ${NorthAmerica}  Get WebElement  //label[contains(text(),'North America')]/../descendant::input
  Run Keyword And Ignore Error  Scroll Element Into View  ${NorthAmerica}
  SalesforceCommonPage.SendText  % North America  ${Opportunity.northAmerica}
  ${Europe}  Get WebElement  //label[contains(text(),'% Europe')]/../descendant::input
  Run Keyword And Ignore Error  Scroll Element Into View  ${Europe}
  SalesforceCommonPage.SendText  % Europe  ${Opportunity.europe}
  ${TotalRequests}  Get WebElement  //label[contains(text(),'Total Requests')]/../descendant::input
  Run Keyword And Ignore Error  Scroll Element Into View  ${TotalRequests}
  SalesforceCommonPage.SendText  Total Requests  ${Opportunity.totalRequests}
  ${EstimatedAnnualBookingAmount}  Get WebElement  //label[contains(text(),'Estimated Annual Booking Amount')]/../descendant::input
  Run Keyword And Ignore Error  Scroll Element Into View  ${EstimatedAnnualBookingAmount}
  SalesforceCommonPage.SendText  Estimated Annual Booking Amount  ${Opportunity.totalRequests}
  Click Element  ${optySave}
  Sleep   3 seconds
  ${createdRecordUrl} =    Get Location
  Log    opportunity created successfully ${createdRecordUrl}
  Sleep   20 seconds
  ${optyquotebuttonname}    Get Text    ${optyNewQuoteButton}
  Run Keyword If    '${optyquotebuttonname}' == '${Opportunity.newQuoteButton}'  Log  Opportunity created sucessfully! oppty record id: ${createdRecordUrl}
  Sleep   3 seconds

createNewQuote
  Wait Until Element Is Visible    ${optyNewQuoteButton}
  Click Element  ${optyNewQuoteButton}
  #Sleep   3 seconds
  #${ele1}  Get WebElement  ${newQuoteTemplateBtn}
  #Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele1}
  #Click Element  ${newQuoteTemplateNone}
  #Sleep   3 seconds
  #Click Element  ${newQuoteContinue}
  Sleep   40 seconds
addProducts
  Select Frame  ${iframequote}
  Sleep   20 seconds
  Execute JavaScript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-line-editor").shadowRoot.querySelector("#groupLayout").shadowRoot.querySelector("#Group_2").shadowRoot.querySelector("#groupActions > sb-custom-action").shadowRoot.querySelector("#mainButton").click();
  Unselect Frame
  Sleep   40 seconds
selectProduct
  wait_for_page_load
  Select Frame  ${iframequote}
  Sleep   10 seconds
  Input Text  dom:document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#typeahead").shadowRoot.querySelector("#itemLabel")  domainr
  Sleep   10 seconds
  Log To Console  step1
  Click Element  dom:document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#buttons > paper-button")
  Sleep   30 seconds
  Log To Console  step2
  Unselect Frame
ConfigureProducts
  Select Frame  ${iframequote}
  Sleep   10 seconds
  Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#lookupLayout").shadowRoot.querySelector("#tableRow").shadowRoot.querySelector("#selection").shadowRoot.querySelector("#g > div > sb-table-cell-select").shadowRoot.querySelector("#checkbox").click();
  #document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#lookupLayout").shadowRoot.querySelector("#tableRow").shadowRoot.querySelector("#selection").shadowRoot.querySelector("#g > div > sb-table-cell-select").shadowRoot.querySelector("#checkbox").shadowRoot.querySelector("#checkbox")
  Sleep   5 seconds
  Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#plSelect").click();
  Sleep   10 seconds
QuoteSave
 # ${EXPECTED_TEXT}  Expected Text
  Click Element  dom:document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-line-editor").shadowRoot.querySelector("#actions > sb-custom-action:nth-child(11)").shadowRoot.querySelector("#mainButton")
  Sleep   10 seconds
  Unselect Frame
  Sleep   5 seconds
  Wait Until Element Is Visible  ${quoteNumber}
  Sleep   3 seconds
CloseWonOpportunity
  Scroll Element Into View  ${opptyLinkClick}
  Sleep   10 seconds
  Double click Element  ${opptyLinkClick}
  Sleep   10 seconds
  Double click Element  ${Closed}
  Sleep   10 seconds
  Double click Element  ${Markstagecomplete}
  Sleep   10 seconds
  Double click Element  ${Done}
  Execute Javascript  ${Done}
  Sleep   30 seconds
  Wait Until Element Is Visible    ${ClosedWonContract}
  Sleep   20 seconds
  
Convert Lead By Uncheck Do not create a new opportunity upon conversion
  wait until page contains  Convert
  page should contain    Convert
  Click Element   ${btnConvertLead}
  Sleep    10 seconds
  @{window_handles}    Get Window Handles
  Log  ${window_handles}
  ${parent_window}    Set Variable    ${window_handles}[0]
  ${child_window}    Set Variable    ${window_handles}[1]
  Switch Window    ${child_window}
  ${title}    Get Title
  Log Title
  Wait Until Element Is Visible    ${txtConvertLeadMessage}
  Scroll Element Into View    ${txtConvertLeadMessage}
  ${message}    Get Text    ${txtConvertLeadMessage}
  Run Keyword If    '${message}' == 'Convert Lead'  actions1   

actions1
  Sleep    6 seconds
  ${created_record_url}    Get Location
  Log    Convert Lead successfully: ${created_record_url}
  Wait Until Element Is Visible    ${btnDetailConvert}
  Select From List by Index    name=accid    1
  Click Element    ${do_not_create_opty_xpath}
  Click Element    ${btnDetailConvert}
  Sleep    5 seconds     
  Wait Until Element Is Visible    ${inputConvertNewLead}
  Click Element    ${inputConvertNewLead}
  ${createdRecordUrl} =    Get Location
  Log    Convert Lead successfully ${createdRecordUrl}
  Sleep    10 seconds 

createNewQuotetest
  Wait Until Element Is Visible    ${optyNewQuoteButton}
  Click Element  ${optyNewQuoteButton}
  Sleep   3 seconds
  ${ele1}  Get WebElement  ${newQuoteTemplateBtn}
  Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele1}
  Click Element  ${newQuoteTemplateNone}
  Sleep   3 seconds
  Click Element  ${newQuoteContinue}
  Sleep   40 seconds
  Select Frame  ${iframequotetest}
  Sleep   10 seconds
  #Element Should Be Visible  ${isvisible1}  "Present"
  #${element}=  Execute JavaScript  return document.querySelector("#sbPageContainer")
  Execute JavaScript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-line-editor").shadowRoot.querySelector("#groupLayout").shadowRoot.querySelector("#Group_2").shadowRoot.querySelector("#groupActions > sb-custom-action").shadowRoot.querySelector("#mainButton").click();
  #Click Element  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-line-editor").shadowRoot.querySelector("#groupLayout").shadowRoot.querySelector("#Group_2").shadowRoot.querySelector("#groupActions > sb-custom-action").shadowRoot.querySelector("#mainButton")
  #Click Element    ${element1}
  Unselect Frame
  Sleep   20 seconds
  Select Frame  ${iframequotetest}
  Sleep   10 seconds
  Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#typeahead").shadowRoot.querySelector("#itemLabel").value = "Domainr"
  Sleep   3 seconds
  Press Keys  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#typeahead").shadowRoot.querySelector("#itemLabel")  ENTER
  #Press Keys  Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#typeahead").shadowRoot.querySelector("#itemLabel") \13
  #Log    Clickperformed
  #Execute JavaScript  var event = new KeyboardEvent('keydown', {key: 'Enter', code: 'Enter', keyCode: 13, which: 13, bubbles: true}); document.dispatchEvent(event);
  Sleep   30 seconds
  Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("sb-page-header > sb-search-bar").shadowRoot.querySelector("div > paper-button").click();
  Sleep   30 seconds
  Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#search").click();
  #Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#buttons").querySelectorAll("#search").click();
  #Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#buttons").click();
  #Press Keys  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#typeahead").shadowRoot.querySelector("#itemLabel")  ENTER
  Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#lookupLayout").shadowRoot.querySelector("#tableRow").shadowRoot.querySelector("#selection").shadowRoot.querySelector("#g > div > sb-table-cell-select").shadowRoot.querySelector("#checkbox").click();
  Sleep   10 seconds
  Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#plSelect").click();
  Sleep   20 seconds
  #Unselect Frame
  #Select Frame  ${iframequotetest}
  #Sleep   80 seconds
  Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-config").shadowRoot.querySelector("#bundles").shadowRoot.querySelector("#features").shadowRoot.querySelector("sb-product-feature-list").shadowRoot.querySelector("#featureList > sb-product-feature:nth-child(1)").shadowRoot.querySelector("#configAttributesTop").shadowRoot.querySelector("#firstColumn").shadowRoot.querySelector("#g > div > sb-attribute-item").shadowRoot.querySelector("#field").shadowRoot.querySelector("#picklist").shadowRoot.querySelector("#Monthly").click();
  #Sleep   80 seconds
  Select From List by Value  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-config").shadowRoot.querySelector("#bundles").shadowRoot.querySelector("#features").shadowRoot.querySelector("sb-product-feature-list").shadowRoot.querySelector("#featureList > sb-product-feature:nth-child(1)").shadowRoot.querySelector("#configAttributesTop").shadowRoot.querySelector("#firstColumn").shadowRoot.querySelector("#g > div > sb-attribute-item").shadowRoot.querySelector("#field").shadowRoot.querySelector("#picklist").shadowRoot.querySelector("#Monthly")  Monthly
  #Press Keys  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#typeahead").shadowRoot.querySelector("#itemLabel")  ENTER
  #Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#typeahead").shadowRoot.querySelector("#itemLabel").click();
  #Execute Javascript  document.querySelector("#sbPageContainer").shadowRoot.querySelector("#content > sb-product-lookup").shadowRoot.querySelector("#headersearch").shadowRoot.querySelector("#search").click();
  #Unselect Frame
  Sleep   60 seconds

  

