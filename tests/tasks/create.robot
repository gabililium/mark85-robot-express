*** Settings ***
Documentation        Cenários de cadastros de tarefas

Library        JSONLibrary

Resource        ../../resources/base.resource


Test Setup        Start Session  #gancho que será executado antes de cada teste
Test Teardown     Take Screenshot   #ganho que será executado depois de cada teste

*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    [Tags]        critical
    ${data}        Get fixture    tasks    create

    Reset user from database        ${data}[user]  
    
    Do login        ${data}[user]

    Go to task form
    Submit task form                 ${data}[task]
    Task should be registered        ${data}[task][name]
    
Não deve cadastrar tarefa com nome duplicado
    [Tags]         dup
    ${data}        Get fixture    tasks    duplicate

    #Dado que eu tenha um novo usuário
    Reset user from database        ${data}[user]  

    # E que esse usuário já cadastrou uma tarefa
    Create a new task from API    ${data}
    
    # E que estou logado na aplicação web
    Do login        ${data}[user]

    # Quando tento cadastrar essa mesma tarefa que já foi cadastrada
    Go to task form
    Submit task form                 ${data}[task]

    # Go to task form
    # Submit task form                 ${data}[task]  comentado pois no POST já está inserindo a tarefa
   
    #Então devo ver uma notificação de duplicidade
    Notice should be                 Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atinge o limite de tags
    [Tags]        tags_limit

    ${data}        Get fixture    tasks    tags_limit

    Reset user from database        ${data}[user]    
    
    Do login        ${data}[user]

    Go to task form
    Submit task form                 ${data}[task]

    Notice should be                 Oops! Limite de tags atingido.