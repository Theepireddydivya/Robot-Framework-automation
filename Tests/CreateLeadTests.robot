*** Settings ***
Metadata    Version        2.0
Metadata    Release        Fastly - Smoke Test Suite
Metadata    Cycle        1

Resource    ../Resources/Keywords/LeadsKeywords.robot
Resource    ../Resources/Pages/CommonPage.robot
Variables    ../Resources/Variables/GlobalVariables.yml

Suite Setup    Initial Setup

*** Variables ***

*** Test Cases ***

Create and validate a Lead
    LeadsKeywords.Select Sales
    LeadsKeywords.Create a Lead5

#  Flow #1 Closed/Won Contract opportunity
Closed/Won Contract opportunity
    LeadsKeywords.Select Sales
    LeadsKeywords.Create a Lead
    LeadsKeywords.Convert Lead
    LeadsKeywords.afterLeadConversionVerifyAccount
    LeadsKeywords.afterLeadConversionVerifyContact
    LeadsKeywords.createNewOpportunity
    LeadsKeywords.createNewQuote
    LeadsKeywords.addProducts
    LeadsKeywords.selectProduct
    LeadsKeywords.ConfigureProducts
    LeadsKeywords.QuoteSave
    LeadsKeywords.CloseWonOpportunity
*** Keywords ***
Initial Setup
    CommonPage.Open browser and navigate to url  ${sf_url}    ${browser}
    LeadsKeywords.Login as a System Administrator
    #Go To  ${url} 