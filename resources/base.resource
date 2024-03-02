*** Settings ***

Library    libs/database.py
Library    Browser
Library     JSONLibrary

Resource    env.resource
Resource    pages/components/Notice.resource
Resource    pages/components/Header.resource
Resource    pages/components/alert.resource
Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource
Resource    pages/TaskCreatePage.resource
Resource    pages/TasksPage.resource
Resource    services.resource

*** Keywords ***

Start Session
    New Browser    browser=${BROWSER}    headless=False
    New Page       ${BASE_URL}

Get fixture
    [Arguments]    ${file_name}    ${scenario}

    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8

    [Return]    ${data}[${scenario}]

Reset user from database
    [Arguments]    ${user}

    Clean user from database    ${user}[email]
    Insert user from database   ${user}

Create a new tasks from API
    [Arguments]    ${data}

    POST user session     ${data}[user]
    POST a new task    ${data}[task]

Do login
    [Arguments]    ${user}

    Submit login form    ${user}
    User should be logged in    ${user}[name]

Short password
    [Arguments]    ${short_pass}

    ${user}    Create Dictionary
    ...        name=Marcos Silva    
    ...        email=Marcossilva@gmail.com
    ...        password=${short_pass}

    Go to signup page
    Submit signup form    ${user}

    Alert should be    Informe uma senha com pelo menos 6 digitos