*** Settings ***
Documentation        Ações e elementos da página de Login


Library        Browser


*** Keywords ***

Submit login form

    [Arguments]        ${user}

    Fill Text      css=input[placeholder$=mail]    ${user}[email]        #o seletor significa o dolar o placeholder que termina com mail
    Fill Text    css=input[placeholder=Senha]    ${user}[password] 

    Click    css=button >> text=Entrar      # segunda opção xpath=//button[text()="Entrar"]




