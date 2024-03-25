*** Settings ***
Documentation        Cenários de testes do cadastro de usuário


Resource        ../resources/base.resource

Suite Setup            Log    Tudo aqui ocorre antes da suíte (antes de todos os testes)
Suite Teardown         Log    Tudo aqui ocorre depois da suíte (depois de todos os testes)

Test Setup        Start Session  #gancho que será executado antes de cada teste
Test Teardown     Take Screenshot   #ganho que será executado depois de cada teste


Library    OperatingSystem

*** Test Cases ***
Deve poder cadastrar um novo usuário
    #supervariável
    ${user}            Create Dictionary
    ...        name=Gabriela Lima        
    ...        email=gabrielateste@hotmail.com        
    ...        password=teste123

   # exemplo de variável solta ${name}            Set Variable        Gabriela Lima
  
    Remove user from database      ${user}[email]            

    Go to signup page
    Submit signup form    ${user}
    Notice should be      Boas vindas ao Mark85, o seu gerenciador de tarefas.
    

    
Não deve permitir o cadastro com email duplicado

    [Tags]        dup

    ${user}            Create Dictionary
    ...        name=Gabriela Lima        
    ...        email=gabrielateste@hotmail.com        
    ...        password=teste123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}            #antes podia enviar assim: Insert user from database    ${name}    ${email}    ${password} 
   

    Go to signup page  #Checkpoint- pontos de validação para saber se passa pelo fluxo correto
    Submit signup form    ${user}
    Notice should be      Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Tags]        required

    ${user}        Create Dictionary
    ...            name=${EMPTY}
    ...            email=${EMPTY}
    ...            password=${EMPTY}
    
    Go to signup page
    Submit signup form        ${user}

    Alert should be        Informe seu nome completo
    Alert should be        Informe seu e-email
    Alert should be        Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com email incorreto
    [Tags]        inv_email

    ${user}        Create Dictionary
    ...            name=Charles Xavier
    ...            email=xavier.com.
    ...            password=123456
    
    Go to signup page
    Submit signup form        ${user}
    Alert should be           Digite um e-mail válido

Não deve cadastrar com senha muito curta
    [Tags]        temp

    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
        ${user}        Create Dictionary
        ...            name=Gabriela 
        ...            email=templateteste@gmail.com
        ...            password=${password}
    
    Go to signup page
    Submit signup form        ${user}

    Alert should be        Informe uma senha com pelo menos 6 digitos
        
    END

Não deve cadastrar com senha de 1 digito
    [Tags]        short_pass
    [Template]
    Short password    1

Não deve cadastrar com senha de 2 digitos
    [Tags]        short_pass
    [Template]
    Short password    12

Não deve cadastrar com senha de 3 digitos
    [Tags]        short_pass
    [Template]
    Short password    123

Não deve cadastrar com senha de 4 digitos
    [Tags]        short_pass
    [Template]
    Short password    1234

Não deve cadastrar com senha de 5 digitos
    [Tags]        short_pass
    [Template]
    Short password    12345
   
*** Keywords ***
Short password
    [Arguments]        ${short_pass}
   
    ${user}        Create Dictionary
    ...            name=Gabriela 
    ...            email=templateteste@gmail.com
    ...            password=${short_pass}
    
    Go to signup page
    Submit signup form        ${user}

    Alert should be        Informe uma senha com pelo menos 6 digitos



   