*** Settings ***
Metadata    Version        2.0
Metadata    Release        Fastly - Smoke Test Suite
Metadata    Cycle        1

Resource    ../Resources/Keywords/LeadsKeywords.robot
Resource    ../Resources/Pages/CommonPage.robot
Variables    ../Resources/Variables/GlobalVariables.yml

#Suite Setup    Initial Setup

*** Variables ***

*** Test Cases ***

Create and validate a Lead
    Initial Setup
    LeadsKeywords.Select Sales
    LeadsKeywords.Create a Lead
    Close Browser
Convert Lead
    Initial Setup
    LeadsKeywords.Select Sales
    LeadsKeywords.Create a Lead
    LeadsKeywords.Convert Lead
    Close Browser
Convert Lead By Uncheck Do not create a new opportunity upon conversion
    Initial Setup
    LeadsKeywords.Select Sales
    LeadsKeywords.Create a Lead
    LeadsKeywords.Convert Lead By Uncheck Do not create a new opportunity upon conversion
    Close Browser
After LeadConversion Verify Account
    Initial Setup
    LeadsKeywords.Select Sales
    LeadsKeywords.Create a Lead
    LeadsKeywords.Convert Lead
    LeadsKeywords.afterLeadConversionVerifyAccount
    Close Browser

After LeadConversion Verify Contact
    Initial Setup
    LeadsKeywords.Select Sales
    LeadsKeywords.Create a Lead
    LeadsKeywords.Convert Lead
    LeadsKeywords.afterLeadConversionVerifyAccount
    LeadsKeywords.afterLeadConversionVerifyContact
    Close Browser

CreateNewOpportunity
    Initial Setup
    LeadsKeywords.Select Sales
    LeadsKeywords.Create a Lead
    LeadsKeywords.Convert Lead
    LeadsKeywords.afterLeadConversionVerifyAccount
    LeadsKeywords.afterLeadConversionVerifyContact
    LeadsKeywords.createNewOpportunity
    Close Browser
createNewQuote
    Initial Setup
    LeadsKeywords.Select Sales
    LeadsKeywords.Create a Lead
    LeadsKeywords.Convert Lead
    LeadsKeywords.afterLeadConversionVerifyAccount
    LeadsKeywords.afterLeadConversionVerifyContact
    LeadsKeywords.createNewOpportunity
    LeadsKeywords.createNewQuote
    Close Browser
AddProducts
    Initial Setup
    LeadsKeywords.Select Sales
    LeadsKeywords.Create a Lead
    LeadsKeywords.Convert Lead
    LeadsKeywords.afterLeadConversionVerifyAccount
    LeadsKeywords.afterLeadConversionVerifyContact
    LeadsKeywords.createNewOpportunity
    LeadsKeywords.createNewQuote
    LeadsKeywords.addProducts
    Close Browser
SelectProduct
    Initial Setup
    LeadsKeywords.Select Sales
    LeadsKeywords.Create a Lead
    LeadsKeywords.Convert Lead
    LeadsKeywords.afterLeadConversionVerifyAccount
    LeadsKeywords.afterLeadConversionVerifyContact
    LeadsKeywords.createNewOpportunity
    LeadsKeywords.createNewQuote
    LeadsKeywords.addProducts
    LeadsKeywords.selectProduct
    Close Browser
ConfigureProducts
    Initial Setup
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
    Close Browser
QuoteSave
    Initial Setup
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
    Close Browser
CloseWonOpportunity
    Initial Setup
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
    Close Browser
    
*** Keywords ***
Initial Setup
    CommonPage.Open browser and navigate to url  ${sf_url}    ${browser}
    LeadsKeywords.Login as a System Administrator
    #Go To  ${url}    
   
    