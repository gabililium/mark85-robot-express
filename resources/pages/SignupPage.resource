#obs: padrão de nomenclatura PascalCase, diferente de camelCase e snake_case
*** Settings ***
Documentation        Elementos e ações da página de cadastro

Library         Browser

Resource        ../env.resource

*** Keywords ***
Go to signup page
    Go To        ${BASE_URL}/signup

    #Checkpoint- pontos de validação para saber se passa pelo fluxo correto
    Wait For Elements State        xpath=//h1[text()="Faça seu cadastro"]        visible      5
    Get Text                       css=h1                                        equal        Faça seu cadastro


Submit signup form
    [Arguments]       ${user}

    Fill Text         id=name          ${user}[name]
    Fill Text         css=#email       ${user}[email]
    Fill Text         css=#password    ${user}[password]
    #botão com xpath //button[text()="Cadastrar"] e #botão com css button[id="buttonSignup"]
    Click             css=button[type=submit] >> text=Cadastrar   #função de text da lib browser



       
     