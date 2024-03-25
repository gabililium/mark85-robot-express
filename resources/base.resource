*** Settings ***

Library        libs/database.py
Library        Browser
Library        JSONLibrary

Resource       env.resource

Resource       pages/components/Header.resource
Resource       pages/components/Alert.resource
Resource       pages/components/Notice.resource
Resource       pages/SignupPage.resource
Resource       pages/LoginPage.resource
Resource       pages/TaskCreatePage.resource
Resource       pages/TasksPage.resource

Resource       services.resource

*** Keywords ***
Start Session

    New Browser     browser=${BROWSER}    headless=False    #abre o navegador
    New Page        ${BASE_URL}


#Helpers para encandeamento
Get fixture
    [Arguments]        ${file_name}        ${scenario}
      
    ${data}    Load Json From File        
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8
       
    [Return]        ${data}[${scenario}]


Reset user from database
    [Arguments]        ${user}

    Clean user from database         ${user}[email]
    Insert user from database        ${user}

Create a new task from API
    [Arguments]        ${data}

    POST user Session        ${data}[user]
    POST a new task          ${data}[task]

Do login
    [Arguments]        ${user}

    Submit login form                ${user}
    User should be logged in         ${user}[name]

    
