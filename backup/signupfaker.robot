*** Settings ***
Documentation        Cenários de testes do cadastro de usuários

Resource       ../resources/base.resource
Library        FakerLibrary

*** Test Cases ***
Deve poder cadastrar um novo usuários

    ${name}        FakerLibrary.Name
    ${email}       FakerLibrary.Free Email
    ${password}    Set Variable        pwd123

    Start Session

    Go To    http://localhost:3000/signup

    # Checkpoint
    Wait For Elements State    css=h1        visible        5
    Get Text                   css=h1        equal          Faça seu cadastro

    # Prenchimento de dados
    Fill Text                  id=name           ${name}
    Fill Text                  id=email          ${email} 
    Fill Text                  id=password       ${password}  
    
    # Prenchimento de dados
    Click                      id=buttonSignup
    
    # Validação do cadastro
    Wait For Elements State    css=.notice p        visible        5
    Get Text                   css=.notice p        equal          Boas vindas ao Mark85, o seu gerenciador de tarefas.
