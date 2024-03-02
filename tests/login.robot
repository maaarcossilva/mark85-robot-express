*** Settings ***

Documentation    Cenários de autenticação do usuário

Library    Collections
Resource    ../resources/base.resource

Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve poder logar com um usuário pré-cadastrado

    ${user}    Create Dictionary
    ...    name=Marcos Silva
    ...    email=magds.marcos@gmail.com
    ...    password=123456

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Submit login form    ${user}
    Sleep    2
    User should be logged in    ${user}[name]
    Sleep    2

Não deve logar com senha inválida

    ${user}    Create Dictionary
    ...    name=Steve Woz
    ...    email=woz@apple.com
    ...    password=123456

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Set To Dictionary    ${user}    password=abc123

    Submit login form    ${user}
    Sleep    2
    Notice should be    Ocorreu um erro ao fazer login, verifique suas credenciais.
    Sleep    2
    