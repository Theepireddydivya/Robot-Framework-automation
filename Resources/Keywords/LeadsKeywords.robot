*** Settings ***

Library    SeleniumLibrary
Resource    ${CURDIR}${/}..${/}/Pages/LoginPage.robot
Resource    ${CURDIR}${/}..${/}/Pages/DashboardPage.robot
Resource    ${CURDIR}${/}..${/}/Pages/LeadsPage.robot
Resource    ${CURDIR}${/}..${/}/Pages/SalesforceCommonPage.robot
Variables    ${CURDIR}${/}..${/}/Variables/SalesforceVariables.yml

*** Keywords ***

Login as a System Administrator
    LoginPage.Enter credentials    ${login_sys_admin.username}    ${login_sys_admin.password}

Select Sales
    DashboardPage.Select "Sales" from the menu grid

Create a Lead
    DashboardPage.Select "Leads" tab
    Sleep    3 seconds
    LeadsPage.Verify the New button is displayed
    Sleep    3 seconds
    LeadsPage.Click on the New button
    Sleep    3 seconds
    LeadsPage.Verify the New Lead dialog screen is displayed
    Sleep    3 seconds
    LeadsPage.Enter the mandatory fields and create a Lead
    
Convert Lead By Uncheck Do not create a new opportunity upon conversion
  Sleep    3 seconds
    LeadsPage.Convert Lead By Uncheck Do not create a new opportunity upon conversion

Convert Lead
  Sleep    3 seconds
    LeadsPage.Convert Lead  
afterLeadConversionVerifyAccount
  Sleep    3 seconds
    LeadsPage.afterLeadConversionVerifyAccount

afterLeadConversionVerifyContact
  Sleep    3 seconds
    LeadsPage.afterLeadConversionVerifyContact

createNewOpportunity
  Sleep    3 seconds
    LeadsPage.createNewOpportunity
createNewQuote
  Sleep    3 seconds
    LeadsPage.createNewQuote

addProducts
  Sleep    3 seconds
    LeadsPage.addProducts

selectProduct
  Sleep    3 seconds
    LeadsPage.selectProduct   

createNewQuotetest
  Sleep    3 seconds
    LeadsPage.createNewQuotetest

ConfigureProducts
  Sleep    3 seconds
  LeadsPage.ConfigureProducts

QuoteSave
...   Sleep    3 seconds
  LeadsPage.QuoteSave
CloseWonOpportunity
  Sleep    3 seconds
  LeadsPage.CloseWonOpportunity



    

 
 

    


    

