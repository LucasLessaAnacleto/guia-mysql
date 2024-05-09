# Guia MySQL

Esse repositório é um guia de instruções do MySQL. Meu objetivo era colocar em um único lugar, conceitos e exemplos de vários assuntos importantes do MySQL
de uma forma objetiva e prática, é útil para entender ou relembrar como algumas instruções funcionam. 

O MySQL é um dos sistemas de gerenciamento de banco de dados mais populares e amplamente utilizados em todo o mundo. 
Este guia foi criado para ajudá-lo a aprender e dominar os fundamentos do MySQL, desde conceitos básicos até técnicas 
avançadas de administração e consulta de bancos de dados.

[Documentação SQL da w3schools](https://www.w3schools.com/sql/default.asp), essa é uma documentação do SQL e tem vários artigos mais especificamente do MySQL, que utilizei muito
nos estudos de SQL/MySQL para criar esse guia.

Iremos dividir as sessões em DDL, DML, DQL, DCL que representam categorias de instruções ou comandos na linguagem SQL, cada uma com uma finalidade específica, e que é de extrema importancia para qualquer um que queira aprender SQL. [Veja aqui](https://raw.githubusercontent.com/LucasLessaAnacleto/guia-mysql/main/tipos_comandos_sql.jpg);

## ÍNDICE

1. **[Conexão](#conexão)**

2. **[Selecionar database](#selecionar-um-database)**

3. **[DDL (Data Definition Language)](#ddl-data-definition-language)**
    - **CREATE**
        1. [Database](#criar-um-database)
        2. [Table](#criar-uma-tabela)
        3. [View](#criar-uma-view)
        4. [Index](#criar-um-index)
        5. [Function](#criar-uma-function)
        6. [Procedure](#criar-uma-procedure)
        7. [Trigger](#criar-uma-trigger)    
    - **DROP**
        1. [Database](#dropar-um-database)
        2. [Table](#dropar-uma-tabela)
        3. [View](#dropar-uma-view)
        4. [Index](#dropar-um-index)
        5. [Function](#dropar-um-function)
        6. [Procedure](#dropar-uma-procedure)
        7. [Trigger](#dropar-uma-trigger)     
    - **ALTER**
        1. [Nova coluna](#adicionar-uma-nova-coluna)
        2. [Remover coluna](#remover-uma-coluna-existente)
        3. [Renomear coluna](#renomear-uma-coluna-existente)
        4. [Refinir coluna](#redefinir-uma-coluna-existente)
        5. [Renomear uma tabela](#renomear-uma-tabela)
    - **[CONSTRAINTS](#constraints)**
        1. [Chave primária](#chave-primária)
        2. [Chave estrangeira](#chave-estrangeira)

4. **[DML (Data Manipulation Language)](#dml-data-manipulation-language)**
    - **INSERT**
        1. [Sintaxe básica](#insert)
        2. [INSERT em todas as colunas](#insert-em-todas-as-colunas)
        3. [INSERT de Múltiplos Registros](#insert-de-múltiplos-registros)
        4. [INSERT a partir de uma consulta](#insert-a-partir-de-uma-consulta)
        5. [INSERT de dados binários ](#insert-de-dados-binários)
    - **UPDATE**
        1. [Sintaxe básica](#update)
        2. [UPDATE para múltiplas linhas](#update-para-múltiplas-linhas)
        3. [UPDATE com resultados de consultas](#update-com-resultados-de-consultas)
        4. [UPDATE com JOIN](#update-com-join)
        5. [UPDATE com CASE](#update-com-case)
    - **DELETE**
        1. [Sintaxe básica](#delete)
        2. [DELETE para múltiplas-linhas](#delete-para-múltiplas-linhas)
        3. [DELETE utilizando consultas](#delete-utilizando-consultas)
        4. [DELETE com JOIN](#delete-com-join)

5. **[DQL (Data Query Language)](#dql-data-query-language)**
    - [Aliases](#aliases)
    - **SELECT**
        1. [Sintaxe básica](#select)
        2. [WHERE](#where)
            - [Operadores comparativos](#operadores-comparativos)
            - [Operadores lógicos](#operadores-lógicos)
            - [Combinando condições](#combinando-condições)
            - [IN](#in)
            - [LIKE](#like)
            - [IS NULL](#is-null)
            - [BETWEEN](#between)
            - [EXISTS](#exists)
            - [ANY](#any)
            - [ALL](#all)
        3. [JOIN](#join)
        4. [GROUP BY](#group-by)
        5. [HAVING](#having)
        6. [ORDER BY](#order-by)
        7. [LIMIT](#limit)
        8. [DISTINCT](#distinct)
        9. [sub consultas](#sub-consultas)
        10. [CTE: Tabela temporária](#ctes)
        11. [REGEXP](#regexp)

6. **[DCL (Data Control Language)](#dcl-data-control-language)**
    1. [Gerenciamento de usuários no mysql](#gerenciamento-de-usuários-no-mysql)
    2. [Conceder privilégios a usuários](#conceder-privilégios-a-usuários)
    3. [Revogar privilégios a usuários](#revogar-privilégios-a-usuários)

7. **[SHOW](#show)**

8. **[CASE](#case)**

9. **[FUNCTION, PROCEDURE e TRIGGER](#functions-procedures-e-triggers)**

10. **[Relacionamentos de banco de dados](#relacionamentos)**

11. **[Funções MySQL](#funções-mysql)**
    1. [Funções: números](#funções-números)
    2. [Funções: strings](#funções-strings)
    3. [Funções: datas](#funções-datas)
        - [INTERVAL](#interval)
    4. [Funções de agregação](#funções-de-agregação)
    5. [CAST: conversão de tipos](#conversão-de-tipos)

# Conexão

```bash
mysql -u root -P 3306 -psenha
```
**instruções**:

**-u**: serve para especificar o usuario, geralmnete root

**-p**: serve para especificar a porta do banco, geralmente 3306

**-P**: serve para especificar a senha no mesmo comando sem que o mysql peça a senha para digitar depois, nesse caso 'senha'

# Selecionar um database
Sintaxe:
```sql
USE nome_database;
```
O comando USE serve para selecionar um banco de dados específico. Ao executar esse comando, você direciona todas as consultas subsequentes para o banco de dados selecionado.

Com um database selecionado, não é mais necessário específicar o database em todos os comandos, você pode usar o nome da tabela explicítamente.

Exemplos:
```sql
USE demontracao;
-- exemplo1:
SELECT * FROM produtos;
-- exemplo2:
CREATE TABLE itens_pedido(
    id INT AUTO_INCREMENT PRIMARY KEY,
    ...
);
-- exemplo3:
CREATE INDEX index_produtos_nome ON produtos;
-- ...
```
Depois que seleciona é possível colocar apenas o nome da tabela ao invés de 'nome_database.nome_table'.

```sql
SELECT DATABASE();
```
Esse comando retorna o nome do banco selecionado, retorna NULL caso nenhum esteja selecionado.


# DDL (Data Definition Language)
A Linguagem de Definição de Dados é usada para definir e modificar a estrutura de objetos no banco de dados. Isso inclui a criação, modificação e exclusão de tabelas, índices, visões, procedimentos armazenados, funções e outras estruturas de banco de dados.
Exemplos de comandos DDL incluem CREATE, ALTER e DROP.

## Criar um database

Sintaxe:
```sql
CREATE DATABASE nome_database;
```
criará um database cujo o nome foi dado.

```sql
CREATE DATABASE IF NOT EXISTS nome_database;
```
Isso é importante pois não dará erro caso o database já exista, pois ele só tentará criar o banco caso ele não exista.

Exemplo prático:
```sql
CREATE DATABASE IF NOT EXISTS demonstracao;
```

## Criar uma tabela

Sintaxe:
```sql
CREATE TABLE nome_database.nome_table(
    nome_coluna tipo_coluna constraints,
    ...
);
```
Após definir o nome da coluna, você deve dizer qual o tipo de valores que aquela coluna suporta, [MySQL DATA TYPES w3schools](https://www.w3schools.com/mysql/mysql_datatypes.asp) aqui você encontra todos os tipos disponíveis pelo o MySQL.<br>
É possível também adicionar uma constraint, disponível aqui [MySQL CONSTRAINTS](https://www.w3schools.com/mysql/mysql_constraints.asp), e abordamos esse tópico [aqui](#chave-primaria).

Exemplo prático:
```sql
CREATE TABLE IF NOT EXISTS demonstracao.clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    senha VARCHAR(20) NOT NULL
);
```
O 'IF NOT EXISTS' pode ser usado para rodar o comando CREATE TABLE caso essa tabela já exista.

## Criar uma view

Uma 'view' é uma consulta SQL armazenada no banco de dados que parece ser uma tabela virtual. Ela não armazena dados fisicamente, em vez disso, ela executa a consulta toda vez que é referenciada.<br>
As views são úteis para simplificar consultas complexas, ocultar detalhes de implementação e fornecer uma visão personalizada dos dados.

Sintaxe:
```sql
CREATE VIEW nome_database.nome_view AS consulta_sql;
```
Uma consulta SQL pode ser visto [aqui](#dql-(data-query-language)).

Exemplo prático:
```sql
CREATE VIEW demonstracao.view_eletronicos_barato AS (
	SELECT * FROM produtos
    WHERE categoria = "eletrônicos" 
    AND preco <= 119.99
);
```
Para consulta-lo é igual uma tabela normal.

## Criar um index

É usado para criar um índice em uma ou mais colunas de uma tabela, o que pode melhorar significativamente o desempenho das consultas, especialmente em tabelas grandes. Um índice é uma estrutura de dados que ajuda o banco de dados a localizar registros com mais eficiência.

Sintaxe:
```sql
CREATE INDEX nome_index ON nome_database.nome_table (coluna1, coluna2, ...);
```
Exemplo prático
```sql
CREATE INDEX idx_clientes_nome ON demonstracao.clientes (nome);
```

## Criar uma function

Funções são pedaços de códigos reutilizáveis que podem receber parâmetros e deve retornar um valor. Eles são ótimos para diminuir a repetição de código e melhorar a legibilidade.

Sintaxe:
```sql
DELIMITER $ -- Serve para trocar o delimitador, impedindo conflito com os delimitadores do corpo da função
CREATE FUNCTION nome_database.nome_function (parametro1 tipo_pararemetro, parametro2 tipo_parametro, ...)
RETURNS tipo_retorno DETERMINISTIC
BEGIN
    /* CORPO DA FUNÇÃO */
    RETURN valor_retorno;
END$
DELIMITER ; -- Voltando para o delimitador padrão
```
O 'tipo_parametro' e 'tipo_retorno' podem ser algum desses tipos: [MySQL DATA TYPES w3schools](https://www.w3schools.com/mysql/mysql_datatypes.asp).

Exemplo prático:
```sql
DELIMITER $
CREATE FUNCTION demonstracao.soma(a INT, b INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE resultado INT;
    SET resultado = a + b;
    RETURN resultado;
END$
DELIMITER ;
```
É possível declarar variáveis locais dentro de uma função.
E depois disso, é possível utiliza-lo em qualquer lugar.
```sql
SELECT demonstracao.soma(200, 55); -- Retorna a soma dos dois números
```
Para saber mais sobre o que é permitido utilizar dentro do escopo da function, veja aqui:
[funcitons, procedures e triggers](#functions_procedures_triggers)

## Criar uma procedure

É um conjunto de instruções SQL que fica encapsulado em um procedimento, e toda vez que é chamado um procedimento, todo o conjunto de instruções dentro dele é executado.

Sintaxe:
```sql
DELIMITER $ -- Serve para trocar o delimitador, impedindo conflito com os delimitadores do corpo da função
CREATE PROCEDURE nome_database.nome_procedure (parametro1 tipo_pararemetro, parametro2 tipo_parametro, ...)
BEGIN
    /* CORPO DO PROCEDIMENTO */
END$
DELIMITER ; -- Voltando para o delimitador padrão
```
Diferente de uma FUNCTION ele apenas executa instruções, ele não retorna nenhum tipo de valor.

Exemplo prático:
```sql
DELIMITER $
CREATE PROCEDURE demonstracao.alterar_nome_cliente (clienteID INT, clienteNome VARCHAR(100))
BEGIN
    UPDATE demonstracao.clientes 
    SET nome = clienteNome 
    WHERE id = clienteID;
END$
DELIMITER ;
```
Assim como uma função, é possível declarar variáveis locais.<br>
Para utilizar é preciso chamar o procedimento com o comando CALL.
```sql
CALL demonstracao.alterar_nome_cliente(15, "James Smith");
```
Para saber mais sobre o que é permitido utilizar dentro do escopo da procedure, veja aqui:
[funcitons, procedures e triggers](#functions_procedures_triggers)

## Criar uma trigger

Uma trigger é basicamente um bloco de código que é executado automáticamente quando um evento específico é acionado, pode ser utilizado para impor uma regra de negócio ou automatizar processos em um database.

Sintaxe:
```sql
DELIMITER $
CREATE TRIGGER nome_database.nome_trigger
BEFORE_OR_AFTER operacao_DML ON nome_table FOR EACH ROW 
BEGIN
    /* CORPO DO TRIGGER */
END$
DELIMITER ;
```
A trigger pode ser disparada antes da operação DML ou depois dela, BEFORE (antes) e AFTER (depois).

**Operacões DML**: INSERT, UPDATE e DELETE;

**Estados de registros**:
existem dois estados quando trabalhos com triggers, o 'OLD' é o estado do registro antes da operação acontecer e o 'NEW' é o estado do registro depois que a operação aconteceu;

INSERT: Não tem o estado 'OLD' do registro, mas tem o 'NEW';

UPDATE: Tem o estado 'OLD' e 'NEW' de registro;

DELETE: Tem o estado 'OLD' porém não tem o 'NEW' estado; 

Exemplo prático:
```sql
DELIMITER $
CREATE TRIGGER demonstracao.TG_itens_pedido_BEFORE_INSERT
BEFORE INSERT ON itens_pedido FOR EACH ROW
BEGIN
	DECLARE subtotal DECIMAL(10,2);
    SET subtotal = NEW.quantidade * (
        SELECT preco FROM produtos 
        WHERE id = NEW.produto_id
    );
    
	SET NEW.subtotal = subtotal;
END$
```
Neste exemplo, foi criado uma trigger que será disparada antes de ocorrer um INSERT na tabela 'itens_pedido', ele basicamente multiplica o preco do produto selecionado no pedido pela a quantidade e atualiza a coluna 'subtoal', tornando assim um processo automatico e evitando erros no caso se o subtotal fosse colocado manualmente no INSERT.

Para saber mais sobre o que é permitido utilizar dentro do escopo da trigger, veja aqui:
[funcitons, procedures e triggers](#functions_procedures_triggers)

## Dropar um database

Sintaxe:
```sql
DROP DATABASE nome_database;
```
Exemplo prático:
```sql
DROP DATABASE IF EXISTS demonstracao;
```
É interessante utilizar o IF EXISTS pois ele só excluirá o database caso ele exista, evitando erros.

## Dropar uma tabela

Sintaxe:
```sql
DROP TABLE nome_database.nome_table;
```
Exemplo prático:
```sql
DROP TABLE IF EXISTS demonstracao.clientes;
```
É interessante utilizar o IF EXISTS pois ele só excluirá a tabela caso ela exista, evitando erros.

## Dropar uma view

Sintaxe:
```sql
DROP VIEW nome_database.nome_view;
```
Exemplo prático:
```sql
DROP VIEW IF EXISTS demonstracao.view_eletronicos_barato;
```

## Dropar um index

Sintaxe:
```sql
DROP INDEX nome_index ON nome_database.nome_table;
```
Exemplo prático:
```sql
DROP INDEX idx_clientes_nome ON demonstracao.clientes;
```

## Dropar uma function

Sintaxe:
```sql
DROP FUNCTION nome_database.nome_function;
```
Exemplo prático:
```sql
DROP FUNCTION IF EXISTS demonstracao.soma;
```

## Dropar uma procedure

Sintaxe:
```sql
DROP PROCEDURE nome_database.nome_procedure;
```
Exemplo prático:
```sql
DROP PROCEDURE IF EXISTS demonstracao.alterar_nome_cliente;
```

## Dropar uma trigger

Sintaxe:
```sql
DROP TRIGGER nome_database.nome_trigger;
```
Exemplo prático:
```sql
DROP TRIGGER IF EXISTS demonstracao.TG_itens_pedido_BEFORE_INSERT;
```

## Adicionar uma nova coluna

Sintaxe:
```sql
ALTER TABLE nome_database.nome_table
ADD COLUMN nome_coluna tipo_coluna constraints;
```
A definição da nova coluna é igual na criação de uma tabela, [veja aqui](#criar-uma-tabela).

Exemplo prático:
```sql
ALTER TABLE demonstracao.clientes
ADD COLUMN CPF VARCHAR(20);
```

## Remover uma coluna existente

Sintaxe:
```sql
ALTER TABLE nome_database.nome_table
DROP COLUMN nome_coluna;
```
A definição da nova coluna é igual na criação de uma tabela, [veja aqui](#criar-uma-tabela).

Exemplo prático:
```sql
ALTER TABLE demonstracao.clientes
DROP COLUMN CPF;
```

## Renomear uma coluna existente

Sintaxe:
```sql
ALTER TABLE nome_database.nome_table
CHANGE nome_coluna novo_nome_coluna tipo_coluna constraints;
```
Além de só renomear a coluna, já tem a opção de mudar alguma restrição ou até o tipo da coluna, caso só queira mudar o nome da coluna, apenas coloque os mesmos tipos e definições antigos.

Exemplo prático:
```sql
ALTER TABLE demonstracao.clientes
CHANGE nome nome_cliente VARCHAR(100) NOT NULL;
```
Alterei o nome da coluna 'nome' para 'nome_cliente' na tabela clientes.

## Redefinir uma coluna existente

intaxe:
```sql
ALTER TABLE nome_database.nome_table
MODIFY nome_coluna tipo_coluna constraints;
```
É parecido com o CHANGE porém, você não altera o nome da coluna e sim apenas as definições de tipo e constraints.

Exemplo prático:
```sql
ALTER TABLE demonstracao.clientes
CHANGE nome nome_cliente VARCHAR(100) NOT NULL;
```
Alterei o nome da coluna 'nome' para 'nome_cliente' na tabela clientes.

## Renomear uma tabela

Sintaxe:
```sql
ALTER TABLE nome_database.nome_table
RENAME TO nome_database.novo_nome_table;
```
Exemplo prático:
```sql
ALTER TABLE demonstracao.itens_pedido
RENAME TO demonstracao.pedidos_item;
```

## CONSTRAINTS

CONSTRAINTS são regras que podemos definir para garantir que os dados atendam aos requisitos específicos, e são aplicadas a nível de tabela. Essas regras podem ser usadas para diversos propósitos, como garantir a unicidade de valores em uma coluna, definir relacionamentos entre tabelas e impor restrições sobre os dados inseridos, atualizados ou removidos.

É possível adicionar uma constraint de dois modos, no criação da tabela com o comando CREATE TABLE, ou adicionar a uma tabela já existente com o comando ALTER TABLE. Além disso algumas constraints podem ser adicionados diretamente na coluna, enquanto outras é preciso da instrução direta 'CONSTRAINT'.

[Documentação MySQL CONSTRAINTS](https://www.w3schools.com/mysql/mysql_constraints.asp).

## Chave Primária

A chave primária é um identificador único para cada registro em uma tabela de banco de dados. Ela garante que não haja duplicatas e é usada para indexação rápida e para estabelecer relacionamentos entre tabelas.

A PRIMARY KEY é uma das constraints que não precisam da instrução CONSTRAINT explicíto e por isso podem ser definidas diretamente na coluna.

CREATE:

```sql
-- SINTAXE:
CREATE TABLE nome_database.nome_table(
    nome_coluna tipo_coluna PRIMARY KEY, -- ou assim
    ...
    -- ou depois da definição das colunas:
    PRIMARY KEY(nome_coluna)
);

-- EXEMPLO PRÁTICO:
CREATE TABLE demonstracao.clientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    ...
);
```

ALTER:
```sql
-- SINTAXE:
ALTER TABLE nome_database.nome_table
ADD PRIMARY KEY(nome_coluna);

-- EXEMPLO PRÁTICO:
ALTER TABLE demonstracao.clientes
ADD PRIMARY KEY(id);
```
REMOVER:
```sql
ALTER TABLE demonstracao.clientes
DROP PRIMARY KEY;
```
OBS: Para a remoção for possível a tabela não pode ser tabela pai de nenhuma outra, e a coluna da pk não pode ser AUTO_INCREMENT.

## Chave Estrangeira

Uma chave estrangeira é uma constraint em um banco de dados relacional que estabelece uma relação entre duas tabelas. Essa CONSTRAINT garante a integridade referencial dos dados, exigindo que os valores em uma coluna de uma tabela (a tabela "filha") correspondam aos valores em uma coluna de outra tabela (a tabela "pai"). Isso cria uma associação entre as tabelas, permitindo que informações relacionadas sejam conectadas de forma estruturada e consistente. A chave estrangeira desempenha um papel fundamental na modelagem de relacionamentos entre tabelas e na garantia da consistência dos dados no banco de dados.

Quando falamos de relacionamento entre tabelas, a tabela filha é a tabela onde foi adicionado a foreign key, e a tabela pai, é a tabela que foi referenciada na foreign key.

CREATE:

```sql
-- SINTAXE:
CREATE TABLE nome_database.nome_table(
    nome_coluna tipo_coluna constraints,
    ...
    CONSTRAINT nome_constraint FOREIGN KEY (nome_coluna_fk) REFERENCES nome_tabela_pai(nome_coluna_pk) ON DELETE [opcao]
);

-- EXEMPLO PRÁTICO:
CREATE TABLE demonstracao.pedidos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE NOT NULL,
    cliente_id INT, -- A coluna fk
    ...
    CONSTRAINT fk_cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes(id) 
    -- Quando o ON DELETE não é específicado, por padrão é o NO ACTION
);
```

ALTER:
```sql
-- SINTAXE:
ALTER TABLE nome_database.nome_table
ADD CONSTRAINT nome_constraint FOREIGN KEY (nome_coluna_fk) REFERENCES nome_tabela_pai(nome_coluna_pk) ON DELETE [opcao];

-- EXEMPLO PRÁTICO:
ALTER TABLE demonstracao.pedidos
ADD CONSTRAINT fk_cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes(id);
```
A opcão do ON DELETE podem ser uma dessas:

**NO ACTION (padrão)**: Não realizará nenhuma ação ao excluir uma linha pai na tabela referenciada. Essa é a ação padrão se nenhuma outra ação for especificada.

**RESTRICT**: Impedirá a exclusão de uma linha pai na tabela referenciada se houver linhas filhas na tabela atual que dependem dela.

**CASCADE**: Fará com que, se uma linha pai na tabela referenciada for excluída, todas as linhas filhas na tabela atual também serão excluídas automaticamente.

**SET NULL**: Irá definir automaticamente os valores da coluna estrangeira nas linhas filhas como NULL se a linha pai na tabela referenciada for excluída.

REMOVER:
```sql
ALTER TABLE demonstracao.pedidos
DROP CONSTRAINT fk_cliente_id;
```

## NULL e NOT NULL

A constraint NULL e NOT NULL é utilizada para definir se uma coluna pode aceitar valores nulos (NULL) ou se é obrigatório ter um valor (NOT NULL). Quando uma coluna é definida como NULL, isso significa que ela pode armazenar valores nulos, o que indica a ausência de dados. Por outro lado, quando uma coluna é definida como NOT NULL, cada registro deve conter um valor válido para essa coluna, impedindo que valores nulos sejam inseridos.

NULL e NOT NULL são constraints definidas diretamente na coluna.

CREATE:

```sql
-- SINTAXE:
CREATE TABLE nome_database.nome_table(
    nome_coluna tipo_coluna NULL, -- Aceita o campo vazio
    nome_coluna tipo_coluna NOT NULL, -- Não aceita o campo vazio
    ...
);

-- EXEMPLO PRÁTICO:
CREATE TABLE demonstracao.clientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NULL,
    ...
);
```

ALTER:
```sql
-- SINTAXE:
ALTER TABLE nome_database.nome_table
MODIFY nome_coluna tipo_coluna NULL,
MODIFY nome_coluna tipo_coluna NOT NULL;

-- EXEMPLO PRÁTICO:
ALTER TABLE demonstracao.clientes
MODIFY nome VARCHAR(100) NULL,
MODIFY telefone VARCHAR(20) NOT NULL;
```
REMOVER:
```sql
ALTER TABLE demonstracao.clientes
MODIFY nome VARCHAR(100),
MODIFY telefone VARCHAR(20);
```

## UNIQUE

A constraint UNIQUE é utilizada para garantir que os valores em uma coluna sejam únicos em uma tabela. Isso significa que nenhum valor repetido é permitido na coluna definida como UNIQUE. Também é possível adicionar UNIQUE a um conjunto de colunas, nesse caso o banco garantirá que nenhuma linha da tabela tenha a combinações das colunas iguais.

CREATE:

```sql
-- SINTAXE:
CREATE TABLE nome_database.nome_table(
    nome_coluna tipo_coluna, 
    ...
    CONSTRAINT nome_constraint UNIQUE (nome_coluna, ...)
);

-- EXEMPLO PRÁTICO:
CREATE TABLE demonstracao.clientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    ...
    CONSTRAINT unique_email UNIQUE (email)
);
```

ALTER:
```sql
-- SINTAXE:
ALTER TABLE nome_database.nome_table
ADD CONSTRAINT nome_constraint UNIQUE (nome_coluna, ...);

-- EXEMPLO PRÁTICO:
ALTER TABLE demonstracao.clientes
ADD CONSTRAINT unique_email UNIQUE (email);
```
REMOVER:
```sql
ALTER TABLE demonstracao.clientes
DROP CONSTRAINT unique_email;
```

## DEFAULT

A constraint DEFAULT define um valor que será automaticamente inserido na coluna se nenhum outro valor for fornecido durante a operação de INSERT. Isso é útil para garantir que todas as linhas tenham um valor predefinido em uma determinada coluna, mesmo que nenhum valor seja explicitamente fornecido durante a inserção de dados.

O DEFAULT é igual o NULL e NOT NULL, é definido na própria coluna.

CREATE:

```sql
-- SINTAXE:
CREATE TABLE nome_database.nome_table(
    nome_coluna tipo_coluna DEFAULT valor_default, 
    ...
);

-- EXEMPLO PRÁTICO:
CREATE TABLE demonstracao.pedidos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE DEFAULT (CURRENT_DATE()),
    total DECIMAL(10,2) DEFAULT 0.00
    ...
);
```
ALTER:
```sql
-- SINTAXE:
ALTER TABLE nome_database.nome_table
MODIFY nome_coluna tipo_coluna DEFAULT valor_default;

-- EXEMPLO PRÁTICO:
ALTER TABLE demonstracao.pedidos
MODIFY data_pedido DATE DEFAULT (CURRENT_DATE()),
MODIFY total DECIMAL(10,2) DEFAULT 0.00;
```
Nesse exemplo a constraint DEFAULT está definido na coluna data_pedido, que será adicionado a data atual(CURRENT_DATE()) caso a coluna venha vazia na inserção, e na coluna total que será por padrão 0. 
As vezes será necessário o uso dos parênteses sobre o 'valor_default' como no caso do CURRENT_DATE.

REMOVER:
```sql
ALTER TABLE demonstracao.pedidos
MODIFY data_pedido DATE,
MODIFY total DECIMAL(10,2);
```

## CHECK

A constraint CHECK é usada para garantir que os valores em uma coluna atendam a uma determinada condição. Essa condição é especificada durante a criação da tabela e pode ser qualquer expressão que retorne um valor booleano (VERDADEIRO ou FALSO). Se a expressão retornar FALSO para uma determinada linha, a inserção ou atualização na tabela será rejeitada.

CREATE:

```sql
-- SINTAXE:
CREATE TABLE nome_database.nome_table(
    nome_coluna tipo_coluna, 
    ...
    CONSTRAINT nome_constraint CHECK (condicao_check)
);

-- EXEMPLO PRÁTICO:
CREATE TABLE demonstracao.clientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    ...
    CONSTRAINT check_email CHECK (email REGEX "^[a-zA-Z0-9.-%_+-]+[@][a-zA-Z0-9]+[.][a-zA-Z]{2,}")
);
```
ALTER:
```sql
-- SINTAXE:
ALTER TABLE nome_database.nome_table
ADD CONSTRAINT nome_constraint CHECK (condicao_check);

-- EXEMPLO PRÁTICO:
ALTER TABLE demonstracao.clientes
ADD CONSTRAINT check_email CHECK (email REGEX '^[a-zA-Z0-9.-%_+-]+[@][a-zA-Z0-9]+[.][a-zA-Z]{2,}$');
```
Eu utilizei uma validão com expressão regular para garantir que o email esteja no formato correto, mas pode ser para validações mais simples como garantir que o valor de uma coluna do tipo int seja positivo(maior ou igual a 0) e etc.

REMOVER:
```sql
ALTER TABLE demonstracao.clientes
DROP CONSTRAINT check_email;
```

# DML (Data Manipulation Language)

A Linguagem de Manipulação de Dados (DML) é usada para manipular dados em um banco de dados. Isso inclui a inserção, atualização, exclusão e recuperação de dados em tabelas e outros objetos de armazenamento de dados.
Exemplos de comandos DML incluem INSERT, UPDATE e DELETE.

## INSERT

Sintaxe:
```sql
INSERT INTO nome_database.nome_table (nome_coluna1, nome_coluna2, ...) VALUES (valor_coluna1, valor_coluna2, ...);
```
Você deve específicar as colunas em que quer inserir um valor, as colunas que são NOT NULL e que não possuem nenhum valor DEFAULT nem um AUTO_INCREMENT são obrigatórias no INSERT. E depois é necessários colocar os valores na mesma ordem das colunas e com os tipos de valores certos para cada coluna.

Exemplo prático:
```sql
INSERT INTO demonstracao.produtos (nome, categoria, preco) VALUES 
("Mouse gamer", "elêtronicos", 251.55);
```
Na inserção você fornece valores apenas para as colunas específicas que deseja preencher. As outras colunas podem ter valores padrão ou nulos, dependendo de como foram definidas na tabela. Neste caso não coloquei a coluna 'id' que tem valor padrão e a coluna 'descrição' que pode ser nula.

## INSERT em todas as colunas

Sintaxe:
```sql
INSERT INTO nome_database.nome_table VALUES 
(valor_coluna1, valor_coluna2, ...);
```
Quando for atribuir o valor em todas as colunas da tabela, não é necessário específicar nenhuma tabela. Lembrando que os valores devem seguir a ordem das colunas na criação da tabela.

Exemplo prático:
```sql
INSERT INTO demonstracao.clientes VALUES 
(DEFAULT, "John Smith", "john@example.com", "+554899112-3456", "john123");
```
O DEFAULT é para colunas que possuem um valor DEFAULT, definindo isso no valor, ele irá preencher a coluna com valor padrão, nesse caso é a coluna 'id' é AUTO_INCREMENT por padrão.

## INSERT de Múltiplos Registros

Sintaxe:
```sql
INSERT INTO nome_database.nome_table (nome_coluna1, nome_coluna2, ...) VALUES 
(valor_coluna1, valor_coluna2, ...),
(valor_coluna1, valor_coluna2, ...),
(valor_coluna1, valor_coluna2, ...),
...;
```
É possível adicionar quantas linhas que quiser em uma tabela, separando por vírgula cada linha de inserção.

Exemplo prático:
```sql
INSERT INTO demonstracao.clientes (nome, email, telefone, senha) VALUES
('John Smith', 'john@example.com', '1198765-4321', 'John123'),
('Mary Johnson', 'mary@example.com', '1198765-4321', 'mary456'),
('James Williams', 'james@example.com', '1198765-4321', 'password789');
```

## INSERT a partir de uma consulta

É possível insirir dados em uma tabela com base nos resultados de uma consulta feita em outra tabela. Isso é útil quando você deseja copiar dados de uma tabela para outra ou quando deseja transformar e inserir dados filtrados em uma nova tabela.

Sintaxe:
```sql
INSERT INTO nome_database.nome_table (nome_coluna1, nome_coluna2, ...)
SELECT nome_coluna1, nome_coluna2, ...
FROM ... -- É possível utilizar tudo que uma consulta SQL direito
```
Para entender mais de consultas: [veja nessa sessão](#select).

Exemplo prático:
```sql
INSERT INTO demonstracao.clientes_backup (nome, email, telefone, senha)
SELECT nome, email, telefone, senha
FROM demonstracao.clientes
WHERE data_cadastro = CURRENT_DATE();
```
Neste exemplo, é uma tabela de backup para a tabela de clientes, e que todo o dia é inserido as novas linhas da tabela clientes.

## INSERT de dados binários

A inserção de dados binários refere-se à adição de informações codificadas em formato binário, como imagens, arquivos PDF ou qualquer outro tipo de dado não textual, em uma tabela de banco de dados.

Esse tipo de INSERT é para colunas com tipo específico para armazenar valores binários.

O tipo de dados BLOB (Binary Large Object) no MySQL é usado para armazenar objetos binários grandes, como imagens, arquivos de áudio ou vídeo. Existem quatro variações do tipo BLOB, cada uma com capacidades de armazenamento diferentes:

**TINYBLOB**: Armazena até 255 bytes.

**BLOB**: Armazena até 65.535 bytes (64 KB).

**MEDIUMBLOB**: Armazena até 16.777.215 bytes (16 MB).

**LONGBLOB**: Armazena até 4.294.967.295 bytes (4 GB).

Sintaxe:
```sql
INSERT INTO nome_database.nome_table (nome_coluna_binaria, nome_coluna1, ...) VALUES
(LOAD_FILE('/caminho/para/o/seu/arquivo.[extensão do arquivo]'), valor_coluna1, ...);
```
Requisitos para o LOAD_FILE:

O nome completo do caminho do arquivo deve ser especificado. Portanto, se o seu arquivo estiver localizado no diretório inicial de um usuário, assumindo o nome de usuário w3r, você deverá especificar '/home/w3r/somefile.txt'.

O usuário que está executando o comando deve ter privilégio FILE. Você pode conceder privilégio FILE a um usuário com o seguinte "GRANT FILE on dbname.* TO user@localhost".

O arquivo em questão deve ser legível por todos. Se você estiver tentando carregar um arquivo que não está presente na hierarquia do diretório inicial dos usuários, certifique-se de ter permissão de leitura no arquivo.

Exemplo prático:
```sql
INSERT INTO demonstracao.imagens_produto (produto_id, imagem) VALUES
(12, LOAD_FILE("C:\Users\Public\Pictures\mysql-demonstracao\produto_12.jpg"));
```

## UPDATE

Sintaxe:
```sql
UPDATE nome_database.nome_table SET nome_coluna1 = valor_coluna1, 
nome_coluna2 = valor_coluna2, ...
WHERE condicao;
```
Essa é a forma de atualizar uma linha de uma tabela, você deve específicar qual linha deve ser alterada na condicao do WHERE.

Exemplo prático:
```sql
UPDATE demonstracao.clientes SET email = "johnsmith@example.com"
WHERE id = 1;
```
E se nenhuma condição for específicada, nesse exemplo, todas as linhas da tabela clientes, irão ter a coluna email alterada para "johnsmith@example.com".

## UPDATE para múltiplas linhas

É possível alterar mais de uma linha, para isso é só utilizar uma condição que abrange mais de uma linha da tabela.

Exemplo prático:
```sql
UPDATE demonstracao.produtos SET preco = preco - (preco * (10 / 100))
WHERE categoria = "domésticos";
```
Neste exemplo é como se estivesse tendo um desconto de 10% para todos produtos domésticos.

É possível fazer certas operações na atribuição, calculos matemáticos, somar uma coluna com outra e etc. Não é obrigatório colocar apenas o número puro.

## UPDATE com resultados de consultas

Isso permite atualizar uma tabela com base nos resultados de uma consulta a outra tabela. Essa abordagem pode ser útil em cenários onde você precisa atualizar registros com base em informações de outras tabelas.

Sintaxe:
```sql
UPDATE nome_database.nome_table
SET nome_coluna = (
    CONSULTA
)
WHERE condicao;
```
Caso queira entender sobre consultas SQL, [veja essa sessão](#select).

Exemplo prático:
```sql
SET @pedidoID = 61; -- Setei uma váriavel
UPDATE demonstracao.pedidos as pedido 
SET pedido.total = (
	SELECT SUM(item.subtotal)
    FROM demonstracao.itens_pedido as item
    WHERE item.pedido_id = pedido.id
) 
WHERE pedido.id = @pedidoID;
```
Aqui eu estou utilizando uma váriavel, você pode saber mais sobre váriavel lendo [essa sessão](#variaveis-no-mysql). Essa instrução UPDATE atualiza a coluna total de um pedido específico, neste caso o 61, e para saber o total do pedido é necessário somar todos os subtotais da tabela filha itens_pedido que estão relacionados com aquele pedido.

Obs: É possível utilizar consultas na condição do WHERE também.

## UPDATE com JOIN

Permite combinar dados de múltiplas tabelas para realizar a atualização. Isso é útil quando você precisa atualizar registros em uma tabela com base em informações de outra tabela.

Sintaxe:
```sql
UPDATE nome_database.nome_table
JOIN nome_database.nome_outra_table 
ON relacionamento
SET nome_table.nome_coluna1 = valor_coluna1,
nome_table.nome_coluna2 = valor_coluna2,
...
WHERE condicao;
```
Temos uma sessão sobre [relacionamentos de banco de dados](#relacionamentos).

Com o JOIN é possível utilizar dados da outra tabela no SET ou no WHERE.

Exemplo prático:
```sql
UPDATE pedidos AS pedido
JOIN (
    SELECT pedido_id, COUNT(*) AS total_itens
    FROM itens_pedido
    GROUP BY pedido_id
) AS item 
ON pedido.id = item.pedido_id
SET pedido.status = 'Grande Pedido'
WHERE item.total_itens > 5;
```
Neste exemplo utilizamos [JOIN](#join) e [aliases](#aliases).

## UPDATE com CASE

Exemplo prático:
```sql
UPDATE pedidos AS pedido
JOIN (
    SELECT pedido_id, COUNT(*) AS total_itens
    FROM itens_pedido
    GROUP BY pedido_id
) AS item 
ON pedido.id = item.pedido_id
SET pedido.status = (
    CASE item.total_itens > 5 THEN "Grande Pedido"
    ELSE "Pequeno Pedido" 
);
```
Obs: Talvez o 'safe update mode' do MySQL não permita que você utilize DELETE sem utilizar a pk no WHERE, até porque não é indicado, a não ser uma situação específica como essa. Veja como ativar ou desativar isso [aqui](https://www.geeksengine.com/database/manage-table/safe-update.php).

## DELETE

Sintaxe:
```sql
DELETE FROM nome_database.nome_tabela
WHERE condicao;
```
Essa é a forma de excluir linhas de uma tabela com base em uma condição especificada após a cláusula WHERE. Se a condição não for especificada, todas as linhas da tabela serão excluídas.

Exemplo prático:
```sql
DELETE FROM demonstracao.clientes
WHERE id = 11;
```
Neste exemplo, a linha da tabela clientes com o ID igual a 11 será excluída.

## DELETE para múltiplas linhas

Assim como no UPDATE, é possível excluir várias linhas de uma tabela de uma só vez, desde que a condição especificada na cláusula WHERE abranja múltiplas linhas.

Exemplo prático:
```sql
DELETE FROM demonstracao.produtos
WHERE categoria = "calçados" 
AND nome LIKE "%Nike%";
```
Para saber mais sobre o [LIKE](#like).

Esse exemplo deleta todos os calçados da Nike na tabela produto.

## DELETE utilizando consultas

Assim como no UPDATE, é possível excluir registros de uma tabela com base nos resultados de uma consulta a outra tabela. Isso pode ser útil em cenários onde você precisa excluir registros com base em informações de outras tabelas.

Sintaxe:
```sql
DELETE FROM nome_database.nome_table
WHERE condicao (
    CONSULTA
);
```
A consulta pode ser tão complexa quanto necessário para obter os registros que deseja excluir.

Exemplo prático:
```sql
DELETE FROM demonstracao.pedidos as pedido
WHERE NOT EXISTS (
	SELECT id
    FROM demonstracao.itens_pedido as item
    WHERE item.pedido_id = pedido.id
);
```
Neste exemplo estou deletando as linhas da tabela pedidos em que a consulta não retorne nada. Excluí os pedido que não possui nenhum item de pedido relacionado a ele.

Obs: Talvez o 'safe update mode' do MySQL não permita que você utilize DELETE sem utilizar a pk no WHERE, até porque não é indicado, a não ser uma situação específica como essa. Veja como ativar ou desativar isso [aqui](https://www.geeksengine.com/database/manage-table/safe-update.php).

## DELETE com JOIN

Assim como no UPDATE, o DELETE com JOIN permite combinar dados de múltiplas tabelas para realizar a exclusão de registros com base em informações de outra tabela. Isso pode ser útil em cenários onde você precisa excluir registros em uma tabela com base em critérios definidos em outra tabela.

Sintaxe:
```sql
DELETE nome_table 
FROM nome_database.nome_table
JOIN nome_database.nome_outra_table 
ON relacionamento
WHERE condicao;
```
A cláusula JOIN permite combinar os dados das tabelas envolvidas na exclusão, enquanto a cláusula WHERE define os critérios para a exclusão dos registros.

Exemplo prático:
```sql
DELETE item
FROM demonstracao.itens_produto AS item
JOIN demonstracao.pedidos as pedido
ON item.pedido_id = pedido.id
WHERE pedido.data_pedido < (CURRENT_DATE() - INTERVAL 1 YEAR);
```
Nesse exemplo, é deletado os itens dos pedidos que foram feitos a mais de um ano atrás.

# DQL (Data Query Language)

A Linguagem de Consulta de Dados (DQL) é usada para recuperar informações de um banco de dados. É principalmente utilizada para fazer consultas e extrair dados de tabelas e outros objetos de armazenamento de dados. 

Exemplos de comandos DQL incluem SELECT, que é usado para recuperar dados específicos de uma ou mais tabelas, e outras cláusulas como WHERE, ORDER BY e GROUP BY e muitas outras, que são usadas para filtrar, classificar e agrupar os resultados da consulta e etc.

Iremos utilizar bastante esse banco modelo [disponível aqui](https://github.com/LucasLessaAnacleto/guia-mysql/blob/main/modelo.sql);

## Aliases

Em consultas SQL, um alias é um nome alternativo que você pode atribuir a uma tabela ou a uma coluna temporariamente durante a execução de uma consulta. Os aliases são úteis para simplificar consultas complexas, tornando-as mais legíveis e concisas.

**Alias de tabela**
```sql
-- Exemplo 1:
SELECT c.id, c.nome, c.email FROM demonstracao.clientes AS c;

-- Exemplo 2:
SELECT c.id ,c.nome, c.email, p.total, p.data_pedido 
FROM demonstracao.clientes AS c
JOIN demonstracao.pedidos AS p
ON c.id = p.cliente_id;
```
Geralmente é usado as iniciais da tabela.

**Alias de coluna**
```sql
-- Exemplo 1:
SELECT nome AS clienteNome, email AS clienteEmail
FROM demonstracao.clientes;

-- Exemplo 2:
SELECT COUNT(*) AS qtdeClientes
FROM demonstracao.clientes;
```
Quando é utilizado um alias de coluna no SELECT principal, o nome das colunas na consulta é alterado.

## SELECT

É a instrução para realizar consultas SQL.

Sintaxe:
```sql
-- Seleciona todas as colunas da tabela
SELECT * FROM nome_database.nome_table;

-- Seleciona as colunas específicas
SELECT nome_coluna1, nome_coluna2, ... FROM nome_database.nome_table;
```
Essa é a forma mais básica de consultas SQL, mas o DQL vai muito além disso.

Exemplo práticos:
```sql
SELECT nome, email, telefone FROM demonstracao.clientes;
```

## Where

A cláusula WHERE é uma parte essencial das consultas SQL, pois permite filtrar os resultados retornados com base em condições específicas. Com a cláusula WHERE, você pode especificar uma condição que deve ser atendida para que uma linha seja incluída no conjunto de resultados.

### Operadores comparativos

Os operadores comparativos são usados na cláusula WHERE para comparar valores e fazer condições de filtragem. 

**Igualdade( = )**: Usado para comparar se duas expressões são iguais.
```sql
SELECT * FROM demonstracao.clientes
WHERE id = 7; -- Retorna a linha em que possui o ID: 7
```
**Diferença( != ou <> )**: Verifica se duas expressões são diferentes.
```sql
SELECT id FROM demonstracao.clientes
WHERE email != "john@example.com"; -- Todas as linhas, exceto as que o email é "john@example.com"
```
**Maior que ( > )**: Compara se a expressão a esquerda do operador é maior que a expressão a direita.
```sql
SELECT COUNT(*) as qtdeProdutos FROM demonstracao.produtos
WHERE preco > 999.99; -- conta as linhas em que o preço é de 1000.00 para cima
```
**Maior ou igual a ( >= )**: Compara se a expressão a esquerda do operador é maior ou igual que a expressão a direita.
```sql
SELECT COUNT(*) as qtdeProdutos FROM demonstracao.produtos
WHERE preco >= 799.99; -- conta as linhas em que o preço é de 799.99 para cima
```
**Menor que ( < )**: Compara se a expressão a esquerda do operador é menor que a expressão a direita.
```sql
SELECT cliente_id FROM demonstracao.pedidos
WHERE total < 100; -- retorna os clientes em que o total do seu pedido é de 99.00 para baixo
```
**Menor ou igual a ( <= )**: Compara se a expressão a esquerda do operador é menor ou igual que a expressão a direita.
```sql
SELECT * FROM demonstracao.itens_pedido
WHERE quantidade <= 2; -- apenas as linhas em que a quantidade é de 2 para baixo
```

### Operadores lógicos

Os operadores lógicos são utilizados para combinar múltiplas condições na cláusula WHERE e fazer consultas mais complexas.

**AND**: Ele retorna verdadeiro se todas as condições especificadas forem verdadeiras.
```sql
SELECT id FROM demonstracao.clientes
WHERE email = "john@example.com" AND senha = "john123"; 
-- Retorna o ID do cliente que tiver aquele email e senha específico, é como normalmente acontece em um sistema de login.
```
**OR**: Ele retorna verdeiro se ao menos uma das condições forem verdadeiras.
```sql
SELECT id as prodID, nome as prodNome, descricao FROM demonstracao.produtos
WHERE categoria = "eletrônicos" OR categoria = "domésticos"; 
-- Retorna o produto caso a categoria seja uma das duas.
```
**NOT**: Inverte o resultado de uma condição, retornando verdadeiro se a condição for falsa e falso se a condição for verdadeiro.
```sql
SELECT * FROM demonstracao.produtos
WHERE NOT (categoria = "eletrônicos" OR categoria = "domésticos"); 
-- Retorna o produto caso a categoria não seja nenhuma das duas.
```

### Combinando condições

**AND** + **OR**:
```sql
SELECT * FROM demonstracao.clientes
WHERE telefone LIKE "11%" 
AND telefone LIKE "%21" 
OR telefone = "5398765-4321";
```
Aqui a condição é a seguinte, retorna aquela linha da tabela clientes se a coluna telefone começar com "11" E terminar com número "21" OU for "5398765-4321".

Quando se tem mais de um operador lógico, para facilitar o entimento é indicado utilizar parentêses.
```sql
SELECT * FROM demonstracao.clientes
WHERE (telefone LIKE "11%" AND telefone LIKE "%21") 
OR telefone = "5398765-4321";
```
Com parentêses é possível acontecer o contrário:
```sql
SELECT * FROM demonstracao.clientes
WHERE telefone LIKE "11%" AND 
(telefone LIKE "%21" OR telefone = "5398765-4321");
```
Só mudando o parenteses já muda totalmente a consulta: retorna aquela linha da tabela clientes se a coluna telefone terminar com número "21" OU for "5398765-4321", se um desses for verdadeiro e se o número comece com 11.

**NOT** + **AND**
```sql
SELECT total FROM demonstracao.pedidos
WHERE NOT data_pedido = CURRENT_DATE() 
AND total > 700;
```
O NOT está sendo utilizado para negar a condição a frente dele, ou seja se o pedido NÃO tiver sido feito hoje e o total do pedido for maior que 700, retorne esse total na consulta.

Para mostrar como o parentêses faz diferença, se colocasse dessa forma:
```sql
SELECT total FROM demonstracao.pedidos
WHERE NOT (
    data_pedido = CURRENT_DATE() AND total > 700
);
```
Nesse caso a condição da consulta é diferente, basta uma das duas condições dentro do parentêses ser falsa para que o WHERE fique verdadeiro. Ou seja, se o pedido tiver sido feito hoje e o total do pedido for maior que 700 ele NÃO retornará o total, caso o contrário, ele retornará o total.

**NOT** + **OR**
```sql
SELECT * FROM demonstracao.clientes
WHERE NOT LENGTH(senha) > 6 
OR telefone = "4598765-4321";
```
Se a senha NÃO tiver mais que 6 caracteres OU o telefone for "4598765-4321", retorna todos os dado do cliente.

Se colocasse dessa forma:
```sql
SELECT * FROM demonstracao.clientes
WHERE NOT (
    LENGTH(senha) > 6 OR telefone = "4598765-4321"
);
```
se a senha tiver mais que 6 caracteres OU o telefone for "4598765-4321" ele não retornará o cliente, caso contrário o cliente será retornado na consulta.

**Outro exemplos**
```sql
-- Exemplo 1
SELECT * FROM demonstracao.produtos
WHERE (preco >= 100 AND preco <= 200) 
AND categoria = "vestimentas";
```
Se o preço do produto for maior ou igual a 100 e menor ou igual a 200, ou seja, se o preço estiver entre 100 a 200, E a categoria for de "vestimentas", então retornará todas as colunas na consulta.
```sql
-- Exemplo 2
SELECT * FROM demonstracao.pedidos
WHERE (total >= 1000 OR status = 'Em andamento')
AND data_pedido >= '2023-01-01';
```
Se o total do pedido for maior ou igual a 1000 OU o status estiver em andamento, se um dessas condições forem atendidas E a data do pedido for igual ou maior que 2023-01-01.
```sql
-- Exemplo 3
SELECT id FROM demonstracao.produtos
WHERE (preco >= 100 AND preco <= 500) 
AND (categoria = 'eletrônicos' OR categoria = 'domésticos') 
AND (estoque > 0 OR status = 'disponível');
```
Se o preço for entre 100 e 500 reais E se a categoria for "eletrônicos" ou "domésticos" E se o estoque for maior que 0 OU o status for disponível, então retorna o id desses produto.
```sql
-- Exemplo 4
SELECT * FROM demonstracao.clientes
WHERE (idade >= 25 AND idade <= 40) 
AND (cidade = 'São Paulo' OR cidade = 'Rio de Janeiro') 
OR (status = 'premium' OR (compras_totais > 1000 AND fidelidade >= 0.8));
```
Se a idade do cliente estiver entre 25 e 40 anos E a cidade do cliente for "São Paulo" ou "Rio de Janeiro" OU for um cliente premiu ou se compras_totais for maior que 1000 e fidelidade do cliente for maior ou igual a 0.8, nesse caso retorna todas as colunas do cliente.

Isso foi para mostrar algumas condições mais complexas que geralmente pode ser necessárias em um cenário real, porém a maioria das colunas utilizadas ai são fictícias para dar mais volume as consultas, porém não estão no banco de dados modelo: [modelo.sql](https://github.com/LucasLessaAnacleto/guia-mysql/blob/main/modelo.sql).

### IN

O operador IN é usado em consultas SQL para verificar se uma determinada expressão corresponde a qualquer valor em uma lista de valores. Ou seja, verificar se algum valor está contido dentro de uma lista de valores.

Exemplos práticos:
```sql
-- Exemplo 1:
SELECT * FROM demonstracao.produtos
WHERE categoria IN ('vestimentas', 'calçados');
```
Irá buscar todas as linhas em que sua categoria é igual a um dos itens da lista.
Nesse exemplo, retorna todos os produtos que são da categoria vestimentas ou calçados.

```sql
-- Exemplo 2:
SELECT id, nome, telefone FROM demonstracao.clientes
WHERE email IN ('john@example.com', 'james@example.com', 'robert@example.com');
```
Retornará na consulta as colunas específicadas das linhas da tabela clientes, em que o seu email for algum daqueles emails listados.
```sql
-- Exemplo 3:
SELECT id, nome, telefone FROM demonstracao.clientes
WHERE email NOT IN ('john@example.com', 'james@example.com', 'robert@example.com');
```
Também é possível utilizar o operador lógico NOT antes de IN, nesse caso irá buscar todos os clientes em que o email NÃO forem nenhum dos emails listados.

**Outra utilização**

o IN é muito utilizado também para verificar se uma coluna está contido ou não em uma sub consulta.
```sql
SELECT * FROM demonstracao.clientes
WHERE id IN (
    SELECT DISTINCT cliente_id 
    FROM demonstracao.pedidos
);
```
Isso retornará todos os clientes que já fizeram pedidos alguma vez. **Obs**: essa instrução obtém o mesmo resultados de um [JOIN](#join) com a tabela pedidos, que seria o jeito 'certo' de fazer.

Nessa outra sessão falamos sobre [sub consultas](#sub-consultas).

### LIKE

O operador LIKE é usado em consultas SQL para buscar padrões em dados de texto. Ele permite que você recupere registros que correspondam a um determinado padrão de caracteres, em vez de uma correspondência exata.

**% (símbolo de curinga):**

O **%** é usado para representar zero, um ou vários caracteres. Por exemplo, '%maria%' corresponderá a qualquer valor que contenha "maria" em qualquer posição.

Exemplos práticos:
```sql
SELECT * FROM demonstracao.clientes
WHERE nome LIKE 'maria%';
```
Isso retornará todos os clientes que começam com a string "maria" e que podem ter ou não mais caracteres depois disso, ou seja, todos os nomes que começam com "maria".
```sql
SELECT * FROM demonstracao.clientes
WHERE nome LIKE '%maria';
```
Isso retornará todos os clientes que começam com qualquer caracteres ou nennhum e que possuem a string "maria" no final, ou seja, todos os nomes que terminam com "maria".
```sql
SELECT * FROM demonstracao.clientes
WHERE nome LIKE '%maria%';
```
Isso retornará todos os clientes que começam com qualquer caracteres ou nennhum e que possuem a string "maria" e que podem ter ou não mais caracteres no final, ou seja, todos os nomes que apenas contém a string "maria" independente de qual posição esteja.

**_ (sublinhado):**

O **_** é usado para representar um único caractere. Por exemplo, '_ar_' corresponderá a qualquer valor que tenha "ar" como a terceira e quarta letra.

Exemplos práticos:
```sql
SELECT * FROM demonstracao.clientes
WHERE nome LIKE 'juli_';
```
Basicamente é qualquer nome em que comece com 'juli' e que o último caracteres seja aleatório, exemplo: "julia" e "julio".
```sql
SELECT * FROM demonstracao.clientes
WHERE nome LIKE 'a__ %';
```
Basicamente é qualquer nome em que comece a string 'a' e que tenha mais dois caractéres aleatório e depois um caractére de espaço, e depois qualquer caractére em qualquer quantidade. Por exemplo "ana" não irá ser buscado, mas "ana paula", "ana carolina" desde que tenha um espaço na posição 4.
```sql
SELECT * FROM demonstracao.clientes
WHERE nome LIKE '_ar%';
```
Qualquer nome que começar tiver um 'ar' na posição 2 e 3 da string. "Marcelo", "Carla", "Marcos" e etc.

### IS NULL

A cláusula IS NULL é usada em consultas SQL para verificar se um valor em uma coluna de banco de dados é nulo. Quando você usa IS NULL em uma condição, ela retorna verdadeiro se o valor da coluna for nulo e falso caso contrário. 

Exemplos práticos:
```sql
-- Exemplo 1
SELECT * FROM demonstracao.clientes
WHERE telefone IS NULL;
```
Ou seja, buscaria todos os clientes que ainda não possuem um telefone cadastrado.
```sql
-- Exemplo 2
SELECT prod.* FROM demonstracao.produtos as prod
WHERE (
    SELECT DISTINCT produto_id FROM demonstracao.itens_pedido
    WHERE produto_id = prod.id
) IS NULL;
```
Retornará os rodutos que não foram adicionados a nenhum pedido ainda.

```sql
-- Exemplo 3
SELECT * FROM demonstracao.produtos
WHERE descricao IS NOT NULL;
```
O IS NOT NULL também é comumente utilizado, para verificar se valores estão preenchidos, ou seja que NÃO são nulos.

### BETWEEN

A cláusula BETWEEN é usada em consultas SQL para selecionar valores dentro de um intervalo especificado. Ela permite filtrar resultados com base em um intervalo de valores para uma determinada coluna.

Exemplos práticos:
```sql
-- Exemplo 1:
SELECT nome FROM demonstracao.produtos
WHERE preco BETWEEN 50 AND 150;
```
Apenas os produtos que o preço estiverem entre o intervalo de 50 a 150 reais.
```sql
-- Exemplo 2:
SELECT * FROM demonstracao.pedidos
WHERE data_pedido BETWEEN '2024-01-01' AND '2024-12-31';
```
Também é muito utilizado com datas, nesse caso é para todos os pedidos feito entre 1 de janeiro a 31 de dezembro, ou seja, todos os pedidos feitos em 2024.
```sql
-- Exemplo 3:
SELECT * FROM demonstracao.clientes
WHERE SUBSTRING(nome, 1, 1) BETWEEN "A" AND "N";
```
Também funciona com strings, ele faz por ordem alfabética, ou seja, todo o nome em que o seu primeiro caracter esteja entre A a N na ordem alfabética.

Saiba mais sobre [substrings].
```sql
-- Exemplo 4:
SELECT * FROM demonstracao.clientes
WHERE SUBSTRING(nome, 1, 1) NOT BETWEEN "A" AND "N";
```
Também é possível o uso do operador lógico NOT nesse caso, retornaria todos os clientes que NÃO começam com as letras entre o A até o N.

### EXISTS

O operador EXISTS é utilizado em consultas SQL para verificar a existência de registros em uma subconsulta. Ele retorna verdadeiro se a subconsulta especificada retornar algum resultado, e falso caso contrário.

exemplos práticos:
```sql
-- Exemplo 1:
SELECT * FROM demonstracao.clientes as cliente
WHERE EXISTS (
    SELECT id FROM demonstracao.pedidos
    WHERE data_pedido >= "2024-01-01"                                        
    AND cliente_id = cliente.id
);
```
Todos os clientes que fizeram pedido no ano de 2024. 

Temos uma sessão abordando sobre [datas](#datas).
```sql
-- Exemplo 2:
SELECT * FROM demonstracao.produtos as prod
WHERE NOT EXISTS (
    SELECT id FROM demonstracao.itens_pedido
    WHERE produto_id = prod.id
);
```
Todos os produtos que ainda NÃO foram adicionados em nenhum pedido.

### ANY

A cláusula ANY é usada para comparar um valor com qualquer valor na lista retornada por uma subconsulta e retorna verdadeiro se pelo menos um dos valores na lista satisfizer a condição.

Sintaxe:
```sql
SELECT colunas FROM nome_database.nome_table
WHERE valor OPERADOR COMPARATIVO ANY (subconsulta);
```
Exemplos práticos:
```sql
-- Exemplo 1:
SELECT nome, descricao FROM demonstracao.produtos
WHERE preco > ANY (
    SELECT preco FROM demonstracao.produtos 
    WHERE categoria = "eletrônicos"
);
```
Retorna o nome do produto e sua descrição de qualquer produto com preço maior que qualquer um dos preços retornados da sub consulta, que busca todos os preços dos produtos da categoria "eletrônicos".
```sql
-- Exemplo 2:
SELECT * FROM demonstracao.pedidos
WHERE cliente_id = ANY (
    SELECT cliente_id FROM demonstracao.pedidos 
    WHERE MONTH(data_pedido) = 1 
    AND YEAR(data_pedido) = 2024
);
```
Os pedidos que foram feitos em janeiro de 2024.

### ALL

A cláusula ALL é usada para comparar um valor com todos os valores na lista retornada por uma subconsulta e retorna verdadeiro apenas se a condição for verdadeira para todos os valores na lista.

Sintaxe:
```sql
SELECT colunas FROM nome_database.nome_table
WHERE valor OPERADOR COMPARATIVO ALL (subconsulta);
```
Exemplos práticos:
```sql
-- Exemplo 1:
SELECT nome, preco FROM demonstracao.produtos
WHERE preco < ALL (
    SELECT preco FROM produtos 
    WHERE categoria = 'eletrônicos'
);
```
O produto em que seu preço seja maior que todos os precos retornados da sub consulta.
```sql
-- Exemplo 2:
SELECT item.* FROM demonstracao.itens_pedido as item
WHERE item.subtotal > ALL (
	SELECT subtotal FROM demonstracao.itens_pedido
    WHERE pedido_id = item.pedido_id
    AND id != item.id
);
```
Esse é um pouco mais complexo, ele retorna os itens de pedido com o maior subtotal de cada pedido. Basicamente a sub consulta retorna o subtotal de todos os itens do pedido, que não é o item da linha atual da consulta principal, ou seja, o item que está sendo comparado no WHERE, com isso a condição verifica se o subtotal é maior que todos os retornados na sub consulta.

## JOIN

O JOIN é uma cláusula usada para combinar linhas de duas ou mais tabelas com base em uma condição relacionada entre elas. Isso permite que você recupere dados de várias tabelas em uma única consulta, associando linhas com chaves comuns.

É necessário conhecimento sobre [relacionamentos de banco de dados](#relacionamentos).

Sintaxe:
```sql
SELECT table.colunas FROM nome_database.nome_table
JOIN nome_database.nome_outra_table
ON nome_table.PK = nome_outra_table.FK;
```
Os aliases são comumnente utilizados em JOINS para nomear cada tabela e não precisar colocar o nome completo da tabela na hora de utilizar as colunas.

Exemplos práticos:
```sql
-- Exemplo 1:
SELECT cliente.id, cliente.nome, cliente.email, pedido.total, 
pedido.data_pedido
FROM demonstracao.clientes AS cliente
JOIN demonstracao.pedidos AS pedido
ON cliente.id = pedido.cliente_id;
```
Esse exemplo, serve para consultar cada pedido que está linkado a um cliente, em um relacionamento 1 - N. e mostra o ID do cliente o nome do cliente, email, o total do pedido que aquele cliente fez, e quando ele fez o pedido.
```sql
-- Exemplo 2:
SELECT pedido.id, pedido.data_pedido, pedido.total, item.quantidade, item.subtotal
FROM demonstracao.pedidos AS pedido
JOIN demonstracao.itens_pedido AS item
ON pedido.id = item.pedido_id;
```
Esse exemplo já é fruto do relacionamento pedidos 1 - N itens_pedido, ela busca todos os itens de pedido e seu respectivo pedido.  
```sql
-- Exemplo 3:
SELECT pedido.id as pedidoID, pedido.data_pedido as dataPedido, prod.nome as produtoNome, prod.preco, item.quantidade as qtdeProduto, item.subtotal
FROM demonstracao.pedidos AS pedido
JOIN demonstracao.itens_pedido AS item
JOIN demonstracao.produtos AS prod
ON item.pedido_id = pedido.id
AND item.produto_id = prod.id;
```
É possível juntar mais de 2 tabelas, nesse exemplo juntamos a tabela pedido com o itens_pedido e produtos com itens_pedido. A consulta em si retorna todos os itens de pedido, mostrando a qual pedido ele pertence, e o nome e preco do produto linkado aquele item. 
```sql
-- Exemplo 4:
SELECT cliente.nome as clienteNome, cliente.email as clienteEmail, pedido.id as pedidoID, pedido.data_pedido as dataPedido, prod.nome as produtoNome, prod.preco, item.quantidade as qtdeProduto, item.subtotal, pedido.total as totalPedido
FROM demonstracao.pedidos AS pedido
JOIN demonstracao.itens_pedido AS item
JOIN demonstracao.produtos AS prod
JOIN demonstracao.clientes AS cliente
ON item.pedido_id = pedido.id
AND item.produto_id = prod.id
AND pedido.cliente_id = cliente.id;
```
E agora é com as 4 tabelas, mostrando assim todas as informações, cada pedido de cada cliente, todos os itens de cada pedido e o produto contigo no item de pedido.

## GROUP BY

A cláusula GROUP BY é usada em consultas SQL para agrupar linhas que possuem o mesmo valor em uma ou mais colunas específicas. Ela permite que você agregue dados e aplique funções de agregação, como COUNT, SUM, AVG, entre outras, a cada grupo de dados resultante.

Sintaxe:
```sql
SELECT colunas FROM nome_database.nome_table
WHERE condicao
GROUP BY coluna;
```
Exemplos práticos:
```sql
-- Exemplo 1:
SELECT pedido_id FROM demonstracao.itens_pedido
GROUP BY pedido_id;
```
Já que podem existir vários itens para um único pedido, a coluna pedido_id teria valores repetidos, e utilizando o GROUP BY pedido_id, ele agrupa os IDs dos pedidos que são iguais. Essa é a utilização mais básica.
```sql
-- Exemplo 2:
SELECT pedido_id, COUNT(id) as qtdeItens
FROM demonstracao.itens_pedido
GROUP BY pedido_id;
```
Um group by além de ser utilizado para unificar valores em uma consulta, também é muito usado junto com funções de agregação como nesse caso o COUNT. Essa consulta retorna a quantidade de itens dentro de cada pedido.
```sql
-- Exemplo 3:
SELECT cliente.nome, cliente.email, COUNT(pedido.id) as qtdePedidos, SUM(pedido.total) as "total dos pedidos" 
FROM demonstracao.pedidos as pedido 
JOIN demonstracao.clientes as cliente
ON pedido.cliente_id = cliente.id
GROUP BY cliente.id;
```
Um cliente pode ter vários pedidos, então agrupei por ID do cliente, e utilizei o COUNT para contar quantos pedidos foram feitos por um cliente, e o SUM para somar os totais de cada pedido e trazer o total definitivo.

### HAVING

o HAVING é uma extensão do GROUP BY que permite filtrar os resultados de uma consulta agregada com base em uma condição. Ele é usado para impor condições em grupos de linhas, semelhante ao WHERE, mas operando em grupos resultantes de operações de agregação.

Saiba mais sobre funções de agregação [nesta sessão aqui](#funções-de-agregação).

Sintaxe:
```sql
SELECT colunas, funcao_agregacao FROM nome_database.nome_table
GROUP BY colunas
HAVING condicao;
```
Exemplos práticos:
```sql
-- Exemplo 1:
SELECT categoria, COUNT(*) as qtdeProdutos FROM demonstracao.produtos
GROUP BY categoria
HAVING COUNT(*) > 50;
```
Isso filtrará para apenas as categorias que tiverem mais de 50 produtos registrados.
```sql
-- Exemplo 2:
SELECT pedido.id as pedidoID, COUNT(item.id) as qtdeItens, SUM(item.subtotal) as totalPedido
FROM demonstracao.pedidos as pedido
JOIN demonstracao.itens_pedido as item
ON pedido.id = item.pedido_id
GROUP BY pedido.id
HAVING SUM(item.subtotal) > 1000;
```
Neste exemplo, é retornado o ID do pedido, a quantidade de itens do pedido e o total a ser pago no pedido (a soma de todos os itens do pedido), e com o HAVING é feito filtro para apenas as linhas que a soma de todos os itens é maior que 1000 sejam retornados.

## ORDER BY

ORDER BY é uma cláusula em SQL que é usada para classificar os resultados de uma consulta de acordo com uma ou mais colunas específicas em ordem ascendente ou descendente. Ele é frequentemente usado para organizar os resultados de uma consulta em uma ordem específica antes de serem apresentados ao usuário.

Sintaxe:
```sql
SELECT colunas FROM nome_database.nome_table
ORDER BY coluna [ASC|DESC];
```
ASC: É na ordem crescente, se não colocar nem ASC e nem DESC, será por padrão em ASC.<br>
DESC: É na order decrescente.

Exemplos práticos:
```sql
-- Exemplo 1:
SELECT id, nome FROM demonstracao.clientes
ORDER BY nome;
```
Irá ordenar os clientes em ordem alfabética crescente, pelo o nome.
```sql
-- Exemplo 2:
SELECT id, nome, email FROM demonstracao.clientes
ORDER BY id DESC;
```
Nesse caso, em que o id é INT AUTO_INCREMENT, ordenando em order decrescente, está buscando os clientes mais recentes para os mais antigos.
```sql
-- Exemplo 3:
SELECT * FROM demonstracao.pedidos
ORDER BY data_pedido DESC;
```
É possível também ordenar por data, nesse exemplo é a ordernação decrescente, ou seja, os pedidos feitos mais recentes ficarão na frente.

## LIMIT

O LIMIT é uma cláusula em SQL que é usada para restringir o número de linhas retornadas por uma consulta. Ele é comumente utilizado para paginar os resultados de uma consulta ou para limitar o número total de resultados retornados, especialmente em consultas que podem retornar um grande número de linhas.

Exemplos práticos:
```sql
-- Exemplo 1:
SELECT * FROM demonstracao.produtos
LIMIT 100;
```
Com isso, mesmo havendo 300+ produtos cadastrados, só irá retornar os primeiros 100 registros.
```sql
-- Exemplo 2:
SELECT * FROM demonstracao.produtos
ORDER BY preco DESC
LIMIT 10;
```
Nesse exemplo, basicamente eu busco os 10 produtos mais caros, pois utilizo o ORDER BY preco DESC, ou seja, do produto com maior preco para o menor, e como limito para 10 registros, só vem na consulta os 10 mais caros.
```sql
-- Exemplo 3
SELECT cliente.nome, cliente.email, COUNT(pedido.id) as qtdePedidos, SUM(pedido.total) as "total dos pedidos" 
FROM demonstracao.pedidos as pedido 
JOIN demonstracao.clientes as cliente
ON pedido.cliente_id = cliente.id
GROUP BY cliente.id
ORDER BY SUM(pedido.total) DESC
LIMIT 1;
```
Esse é um exemplo um pouco mais complexo, onde é juntado a tabela clientes e pedidos, e utilizado as funções de agregação para acessar a quantidade de pedidos já feitos pelo o cliente, e a soma dos totais de todos os pedidos feitos por esse cliente, é feito a ordenação dessa soma em ordem decrescente e limitado a 1 registro, ou seja, com essa consulta buscamos o cliente que mais gastou dinheiro nesse determinado sistema.

## DISTINCT

O DISTINCT é usado em consultas SQL para remover duplicatas dos resultados. Ele retorna apenas valores únicos para uma determinada coluna ou combinação de colunas.

```sql
SELECT DISTINCT cliente_id FROM demonstracao.pedidos;
```
É um exemplo simples de como funciona, ele não permitirá linhas duplicadas, ou seja, mostrará todos os IDs dos clientes que fizeram pedidos.
```sql
SELECT COUNT(DISTINCT cliente_id) FROM demonstracao.pedidos;
```
É interessante usar o DISTINCT nesse caso, pois daria para saber exatamente a quantidade de clientes diferentes que fizeram pedidos.

## Sub consultas

As subconsultas, também conhecidas como consultas aninhadas, são consultas SQL aninhadas dentro de uma consulta externa. Elas permitem realizar consultas mais complexas ao usar o resultado de uma consulta interna como parte da condição de uma consulta externa. Podendo ser usada com SELECT, INSERT, UPDATE ou DELETE.

**Subconsultas Correlacionadas**: Uma subconsulta correlacionada refere-se a uma consulta interna que depende dos resultados da consulta externa. Isso significa que a subconsulta é executada repetidamente, uma vez para cada linha na consulta externa.

Exemplo 1: 

Suponha que queremos encontrar os clientes que todos os seus pedidos foram feitos depois de uma determinada data. Poderíamos usar uma subconsulta correlacionada para isso:
```sql
SELECT cliente.nome FROM demonstracao.clientes as cliente
WHERE "2024-03-20" < ALL (
    SELECT pedido.data_pedido
    FROM demonstracao.pedidos as pedido
    WHERE pedido.cliente_id = cliente.id
);
```
Quando utilizamos uma consulta dentro de outra (sub consulta), é necessário cobri-la com parênteses. Aqui é interessante perceber que essa sub consulta é executada a cada linha do select externo, para retornar a lista de datas de cada pedido feito daquele cliente específico, e para cada cliente ele verifica se a data "2024-03-20" é MENOR que todos os itens retornados na sub consulta com o uso do ALL.

Exemplo 2:
```sql
SELECT prod.id, prod.nome, prod.preco, prod.categoria FROM demonstracao.produtos AS prod
WHERE prod.preco > (
    SELECT AVG(prodAVG.preco) FROM demonstracao.produtos AS prodAVG
    WHERE prodAVG.categoria = prod.categoria
);
```
Neste exemplo, estamos selecionando todos os produtos cujo preço é maior do que a média de preço dos produtos da mesma categoria. A subconsulta interna calcula a média dos preços dos produtos para cada categoria, e a condição na consulta externa compara o preço de cada produto com a média correspondente à sua categoria. Isso é feito para cada linha na consulta externa, garantindo que a subconsulta esteja correlacionada com a consulta externa.

Exemplo 3:
```sql
SELECT cliente.id, cliente.nome, (
    SELECT COUNT(pedido.id) 
    FROM demonstracao.pedidos as pedido
    WHERE pedido.cliente_id = cliente.id
) as qtdePedidos
FROM demonstracao.clientes as cliente;
```
Neste exemplo, selecionamos o id e nome do cliente, e a quantidade de pedidos já feitos por esse cliente. Essa forma de sub consulta também é correlacionada pois a cada linha é necessário uma busca na tabela pedidos para retornar a quantidade de linhas em que a coluna cliente_id é igual ao id do cliente da linha atual da consulta externa.

É interessante entender que uma sub consulta não precisa ser utilizado apenas no WHERE mas também para originar uma nova coluna em uma consulta.

**Subconsulta Não Correlacionada**: Essas subconsultas são independentes da consulta externa e podem ser executadas apenas uma vez, antes de a consulta externa ser avaliada.

Exemplo 1: 

Um exemplo de subconsulta não correlacionada pode ser encontrar o cliente com o maior número de pedidos:
```sql
SELECT nome FROM demonstracao.clientes
WHERE id = (
    SELECT cliente_id
    FROM demonstracao.pedidos
    GROUP BY cliente_id
    ORDER BY COUNT(id) DESC
    LIMIT 1
);
```
Neste caso, a subconsulta é executada apenas uma vez para encontrar o cliente_id com o maior número de pedidos. Essa informação é então usada para recuperar o nome do cliente correspondente na consulta externa. Essa sub consulta agrupa a tabela pedidos pelo o cliente_id e ordena pela a quantidade de pedidos de forma decrescente, ou seja, do maior para o menor, e limita a 1 registro, retornando dessa sub consulta apenas o primeiro registro, que seria o id do cliente que mais fez pedidos.

Exemplo 2:
```sql
SELECT pedido.cliente_id, SUM(pedido.total) as total_pedidos
FROM demonstracao.pedidos as pedido
GROUP BY cliente_id
HAVING SUM(pedido.total) > (
	SELECT AVG(preco) FROM demonstracao.produtos
    WHERE categoria = "eletrônicos"
);
```
Neste exemplo agrupamos a tabela pedidos pela a coluna cliente_id, e somamos o total dos pedidos feitos por aquele cliente, e com o HAVING filtramos para apenas as linhas em que o total_pedidos seja > do que a média dos preços dos produtos da categoria eletrônicos, que é retornado de uma sub consulta.

Esse exemplo mostra que também é possível utilizar sub consultas no HAVING.

Exemplo 3:
```sql
SELECT * FROM demonstracao.clientes
WHERE id NOT IN (
    SELECT cliente_id
    FROM demonstracao.pedidos
    WHERE YEAR(data_pedido) = 2023
);
```
Esse exemplo utiliza uma sub consulta que não depende de nenhuma informação da consulta externa para funcionar, e retorna uma lista de IDs dos clientes que fizeram pedidos em 2023, e a consulta externa filtra para os clientes em que seu ID NÃO pertence a essa lista de resultados da consulta interna, com isso você descobre os clientes que não fizeram nenhum pedido em 2023.

Exemplo 4:
```sql
SELECT cliente.nome, cliente.email, MAX((
	SELECT COUNT(id) FROM demonstracao.pedidos
	WHERE cliente_id = cliente.id
)) as qtde_pedido 
FROM demonstracao.clientes AS cliente;
```
Nesse exemplo é utilizado uma sub cunsulta dentro de uma função de agregação.

**FROM e JOIN**: Quando usamos subconsultas no FROM ou no JOIN, estamos essencialmente criando uma "tabela temporária" que será usada na consulta principal. Essas subconsultas nos permitem realizar operações mais complexas ou obter conjuntos de dados específicos antes de executar a consulta principal. 

No caso de subconsultas no FROM, a subconsulta é tratada como uma tabela temporária dentro da consulta principal. Ela é executada primeiro e, em seguida, a consulta externa é aplicada a essa "tabela temporária" resultante.

Já no caso de subconsultas no JOIN, a subconsulta é usada para gerar um conjunto de dados que será mesclado com outra tabela na consulta principal. Isso permite combinar os resultados da subconsulta com os resultados da tabela principal com base em uma condição de junção.

Exemplo 1:
```sql
SELECT tb_cliente.nome, tb_cliente.email, tb_cliente.qtde_pedido FROM (
    SELECT cliente.*, (
		SELECT COUNT(id) FROM demonstracao.pedidos
        WHERE cliente_id = cliente.id
    ) AS qtde_pedido
    FROM demonstracao.clientes as cliente
) AS tb_cliente
WHERE tb_cliente.qtde_pedido > 4;
```
Isso é útil, pois aquela coluna fica reutilizável para utilizar no WHERE, ou em uma sub consulta ou em um HAVING, e se eu fizesse uma sub consulta diretamente da coluna invés de criar uma "tabela temporária" no FROM, eu não iria poder reutilizar o dado gerado. 

Como podes perceber, é possível utilizar várias sub consultas uma dentro da outra.

Exemplo 2:
```sql
SELECT id, nome, descricao, preco, IF(qtde_vendas IS NOT NULL, qtde_vendas, 0) as qtde_vendas
FROM (
	SELECT prod.*, (
		SELECT SUM(item.quantidade) FROM demonstracao.itens_pedido as item
        WHERE item.produto_id = prod.id
    ) AS qtde_vendas
    FROM demonstracao.produtos as prod
) AS produto;
```
Esse exemplo mostra que utilizar uma sub consulta como uma tabela temporária é bom para customizar uma tabela que já existe, nesse caso a de produtos. 
Adicionando a coluna qtde_vendas, que através de uma consulta interna, ela soma a quantidade de vezes que o produto da linha atual da consulta externa 
aparece na tabela itens_pedido, ou seja, quantidade de vendas da que produto.

Eu utilizei um IF para formatar a coluna, quando não retorna nenhum registro da coluna qtde_vendas, significa que não foi encontrado nenhum item de pedido 
com aquele produto, então caso qtde_vendas NÃO for nulo, retorna a qtde_vendas, caso o contrário retorna 0.

Exemplo 3:
```sql
SELECT produto.nome, produto.preco, produto.categoria, prodVendas.qtde_total, prodVendas.qtde_categoria
FROM demonstracao.produtos as produto
JOIN (
	SELECT prod.categoria, (
		SELECT SUM(quantidade) FROM demonstracao.itens_pedido
	) as qtde_total, (
		SELECT SUM(tb_item.quantidade) 
        FROM demonstracao.itens_pedido as tb_item
        JOIN demonstracao.produtos as tb_prod
        ON tb_item.produto_id = tb_prod.id
        WHERE tb_prod.categoria = prod.categoria
        GROUP BY tb_prod.categoria
    ) as qtde_categoria, (
		SELECT COUNT(DISTINCT categoria) FROM demonstracao.produtos
    ) as num_categorias
    FROM demonstracao.produtos as prod
    GROUP BY prod.categoria
) as prodVendas
ON produto.categoria = prodVendas.categoria
WHERE prodVendas.qtde_categoria > (prodVendas.qtde_total / prodVendas.num_categorias);
```
Esse é um exemplo mais complexo de sub consulta. Aqui juntamos a tabela produtos com uma tabela temporária que se originou de uma sub consulta, a qual apelidei de 'prodVendas' onde através de outras sub consultas, trás as seguintes informações: 'qtde_total' que é a quantidade total de produtos já vendidos, 'qtde_categoria' que é a quantidade de produtos já vendidos apenas da categoria do produto da linha atual da consulta externa e o número de categorias existentes. A tabela produtos e a tabela temporária 'prodVendas' são ligadas nesse caso através da coluna categoria. No final é feito uma condição que apenas os produtos que pertencem a uma categoria em que sua venda ultrapasse a média de produtos vendidos por categoria.

Esse é um ótimo exemplo para entender tudo o que se pode fazer com uma consulta.

## CTEs

CTEs, ou Common Table Expressions, são uma característica do SQL que permitem a criação de tabelas temporárias nomeadas (temporárias) dentro de uma consulta. Essas tabelas temporárias podem ser referenciadas na própria consulta, o que facilita a escrita de consultas complexas e legíveis.

Sintaxe:
```sql
WITH RECURSIVE nome_cte AS (
    -- CONSULTA QUE ORIGINARÁ OS DADOS DE UMA TABELA TEMPORÁRIA
)
[ CONSULTA ];
```
A consulta em seguida da CTE pode utiliza-lá em qualquer momento do SELECT quanto quiser, como se realmente fosse uma tabela.

Exemplos práticos:
```sql
-- Exemplo 1:
WITH RECURSIVE cte_info_totais as (
	SELECT 
	   (SELECT COUNT(*) FROM demonstracao.produtos) as totalProduto,
       (SELECT COUNT(*) FROM demonstracao.pedidos) as totalPedido	
)
SELECT * FROM cte_info_totais;
```
CTE contendo o total de produtos cadastrados e de pedidos cadastrados.
```sql
-- Exemplo 2:
WITH RECURSIVE cte_totais AS (
	SELECT COUNT(id) as clientes_sem_pedidos, 
    (SELECT COUNT(id) FROM demonstracao.clientes) as qtde_clientes, 
    (SELECT COUNT(id) FROM demonstracao.produtos) as qtde_produtos, (
		SELECT COUNT(id) FROM demonstracao.produtos
		WHERE NOT EXISTS(
			SELECT id FROM demonstracao.itens_pedido
			WHERE itens_pedido.produto_id = produtos.id
		)
	) as produtos_nao_pedidos
    FROM demonstracao.clientes
    WHERE NOT EXISTS (
		SELECT id FROM demonstracao.pedidos
        WHERE pedidos.cliente_id = clientes.id
    )
)
SELECT qtde_clientes as "total clientes", clientes_sem_pedidos as "nunca fizeram pedidos", CONCAT(FORMAT((clientes_sem_pedidos / qtde_clientes) * 100, 2), "%") as "nunca fizeram pedidos (%)", qtde_produtos as "total produtos", produtos_nao_pedidos as "não vendidos", CONCAT(FORMAT((produtos_nao_pedidos / qtde_produtos) * 100, 2), "%") as "nao vendidos (%)"
FROM cte_totais;
```
Nesse exemplo, a CTE serve para fornecer os totais de clientes e produtos, além dos clientes que não fizeram pedidos e dos produtos que não foram vendidos ainda. Essa é uma boa situação para no caso de precisar criar um gráfico ou algo mais analítico. O FORMAT serve para formatar um número flutuante, sendo o primeiro parâmetro o número que quer formatar e o segundo o número de casas de pois da vírgula que deseja, transformando um número como esse: 6.9361207412 em 6.93. Já o CONCAT serve para juntar uma string e formar uma string maior, nesse caso juntar o resultado do FORMAT com o "%", no exemplo torna o 6.9361207412 em 6.93%.

**CTE em outras DMLs**

Não é só no SELECT que as CTEs servem, também é possível utilizar em UPDATE, DELETE e até em INSERT. Veja o exemplo:
```sql
WITH RECURSIVE total_itens_por_pedido AS (
    SELECT pedido_id, COUNT(*) AS total_itens
    FROM itens_pedido
    GROUP BY pedido_id
)
UPDATE pedidos AS pedido
JOIN total_itens_por_pedido AS item 
ON pedido.id = item.pedido_id
SET pedido.porte = 'Grande Pedido'
WHERE item.total_itens > 5;
```
Em uma situação em que criamos uma coluna nova chamada 'porte' em que classifica os pedidos em pequeno porte, médio porte e grande porte. Nesse caso eu posso querer classificar itens que foram adicionados antes da nova coluna ser criada, por isso criei uma CTE para utilizar um UPDATE com JOIN e editar todos os pedidos que possuem mais de 5 itens de pedido como 'Grande Porte'. 

A CTE em questão, seleciona a tabela itens_pedido e agrupa por pedido_id, e conta quantos produtos está linkado a cada ID de pedido.

**CTE recursiva**

são um recurso avançado em SQL que permite realizar consultas que envolvem operações recursivas, ou seja, consultas que se referem a si mesmas durante sua execução.

Essas consultas são frequentemente usadas para trabalhar com dados hierárquicos armazenados em uma tabela de forma recursiva, como árvores genealógicas, organogramas empresariais, estruturas de diretórios em sistemas de arquivos, entre outros.

Para explicar esse tópico com um exemplo, não utilizarei a tabela modelo que estive utilizando até agora, irei pegar um exemplo fictícil.
```sql
WITH RECURSIVE hierarquia AS (
    -- Caso Base
    SELECT id, nome, superior_id, 1 as nivel
    FROM funcionarios
    WHERE superior_id IS NULL
    
    UNION ALL
    
    -- Passo Recursivo
    SELECT f.id, f.nome, f.superior_id, h.nivel + 1
    FROM funcionarios AS f
    JOIN hierarquia AS h ON f.superior_id = h.id
)
SELECT * FROM hierarquia;
```
No exemplo fornecido, a consulta visa construir uma hierarquia de funcionários. Ela começa com o caso base, que seleciona os funcionários que não têm um superior, ou seja, aqueles que ocupam a posição mais alta na hierarquia. Esses funcionários são identificados pela condição WHERE superior_id IS NULL.

Em seguida, temos o passo recursivo. Aqui, selecionamos os funcionários que têm um superior e unimos esses resultados com os resultados da hierarquia já existente. Isso é feito utilizando um JOIN entre a tabela de funcionários (funcionarios) e a CTE hierarquia, usando a coluna superior_id da tabela de funcionários e a coluna id da CTE para estabelecer a relação entre funcionários e seus superiores. A cada iteração recursiva, o nível é incrementado em 1.

Finalmente, a consulta externa seleciona todos os resultados da CTE hierarquia, que contém a hierarquia completa dos funcionários.

## REGEXP
a função REGEXP permite que você realize correspondências de padrões em strings usando expressões regulares. Com essa função, você pode buscar por padrões complexos em dados de texto de maneira eficiente.

Sintaxe:
```sql
texto REGEXP expressao_literal
```
O tema expressão literal é muito amplo, e esse não é o foco aqui, mas o básico sobre regExp será explicado.

```sql
-- Exemplo 1:
SELECT IF(
    ("John123" REGEXP "^[a-zA-Z]+[0-9]+$"), 
    "string válida", 
    "string inválida") AS validacao;
``` 
O IF é só para mostrar caso a REGEXP seja verdadeira ("string válida") e se for falsa ("string inválida"), se não utilizasse o IF iria funcionar igual, mas iria retornar 0 para falso e 1 para verdadeiro.

Basicamente, um regExp no MySQL é tratado como uma string, deve ser escrita entre aspas, ela serve para encontrar padrões de textos. No exemplo acima, ele tenta encontrar no texto "john123" uma string que comece '^' com letras do 'a' até o 'z' ou do 'A' até o 'Z', tanto letras minúsculas, quanto maiúsculas. O '+' significa que pode ser uma ocorrência daquele elemento ou mais. Em seguida deve conter um número de 0 até 9 e também pode ser uma ocorrência ou mais '+', e tem que terminar a string, que é o que '$' representa. E esse padrão é encontrado no texto "John123" ou seja, retorna verdadeiro.

```sql
-- Exemplo 2:
SELECT * FROM demonstracao.clientes
WHERE email REGEXP "@gmail.com$";
```
Por exemplo, digamos que queremos encontrar todos os emails do domínio GMAIL.
Isso filtrará a consulta para apenas os emails que tiveram o @gmail.com no final da string.

```sql
-- Exemplo 3:
CREATE TABLE testedb.testetb(
    ...
    senha VARCHAR(25) NOT NULL,
    CONSTRAINT check_senha CHECK (
		(senha REGEXP "^(.){6,}$") -- linha 1
		AND(senha REGEXP "[0-9]+") -- linha 2
		AND(senha REGEXP "[a-zA-Z]+") -- linha 3
		AND NOT(senha REGEXP "[""':,%/&$- ]") -- linha 4
		AND(senha REGEXP "[!._#?@]+") -- linha 5
	)
);
```
Digamos que queiramos validar a senha para garantir que nenhum registro estejá no formato inadequado. Vamos explicar o regExp de acordo com cada um dos comentários:

Na linha 1, verificamos se tem 6 ou mais caracteres na string, do começo '^' até o final '$' dela. o '(.)' serve para pegar QUALQUER caracter e o '{6,}' significa que o elemento '(.)' deve ser encontrada de 6 a mais vezes. Ou seja, para ser uma senha válida tem que ter pelo menos 6 caracteres.

Na linha 2, verificamos se tem um ou mais números de 0-9. Ou seja, para ser válido tem que conter um ou mais caractéres numéricos na senha.

Na linha 3, verificamos se tem letras no alfabeto, ou seja, para ser uma senha válida deve ter pelo menos uma letra.

Na linha 4, verificamos os caracteres que NÃO são permitidos, como aspas duplas, aspas simples, o dois pontos :, vírgula, porcentagem, espaços e entre outras. Ou seja para ser uma senha válida não pode ter esses caractéres.

Na linha 5, verifica se tem alguns daqueles caracteres especiais, ou seja, para ser uma senha válida é necessários conter pelo menos um daqueles caracteres especiais.

Por fim, um INSERT só será feito na tabela, caso a todas as condições da linha 1 até a 5 sejam atendidas, caso o contrário lançará um 'Check constraint ... is violated.'

OBS: Também é possível utilizar regExp na [constraint CHECK](#check).

## Função IF
A função IF é usada para realizar avaliações condicionais e retornar valores com base nessas condições. Mas é importante notar que esse IF é uma função, não uma declaração de controle de fluxo como o IF...THEN...ELSE usado em procedimentos armazenados ou triggers.

Sintaxe:
```sql
IF(condição, valor_se_verdadeiro, valor_se_falso)
```
Se a condição for verdadeira, ele retorna o valor do segundo argumento, se a condição for falsa, ele retorna o valor do terceiro argumento.

Exemplos práticos:
```sql
-- Exemplo 1:
SELECT u.*, IF(u.idade >= 18, "SIM", "NÃO") as "maior de idade"
FROM usuarios as u;
```
Digamos que tenha uma tabela de usuarios, essa consulta retorna todos os usuários e uma coluna chamda 'maior de idade', que tem o valor SIM se for maior de idade e NÃO se for menor de idade.
```sql
-- Exemplo 2:
SELECT nome, media_notas, frequencia_porcentagem, IF(media_notas >= 6.0 AND frequencia_porcentagem >= 70, 'Aprovado', 'Reprovado') AS status
FROM alunos;
```
Nesse exemplo temos uma tabela de alunos, e se a media de notas do aluno for maior ou igual que 6 e a frequencia for maior ou igual que 70% então a coluna status fica com a valor "Aprovado" se não a coluna fica com o valor "Reprovado".
```sql
-- Exemplo 3:
SELECT numero, 
    IF(numero > 0, 'Positivo', IF(numero < 0, 'Negativo', 'Zero') ) AS tipo_numero
FROM numeros;
```
Esse é um exemplo para mostrar que é possível utilizar um IF dentro de outro para em um caso que tiver mais de 2 opções, como é o caso ai, o número pode tanto ser positivo, quanto negativo e também pode ser 0. Se o número for maior que 0 mostra 'Positivo', se não for maior que 0, e se o número for menor que 0, mostra 'Negativo' e se não for menor que 0 ele só pode ser igual a 0, então mostraria 'Zero'.
```sql
SELECT c.id, c.nome, c.email, SUM(p.total) as totalGasto, COUNT(p.id) as qtdePedidos, IF(SUM(p.total) > 3000 OR COUNT(p.id) > 8, "Premium", "Regular") as tipoCliente
FROM demonstracao.pedidos as p
JOIN demonstracao.clientes as c
ON p.cliente_id = c.id
GROUP BY c.id;
```
Um exemplo utilizando relacionamento de tabelas, e funções de agregação na condição fo IF. Agrupos a consulta pelo o ID do cliente, com isso podemos saber quantos pedidos já foram feitos por cliente, a soma total de todos os pedidos de um cliente. Imagine que queiramos adicionar à consulta, o tipo de cliente, Premium ou Regular para dar algum privilégio dentro do meu sistema, o IF verifica se o total gasto pelo o cliente for maior que 3000 ou se o cliente já fez mais de 8 pedidos, ele é Premium, caso o contrário é Regular.

# DCL (Data Control Language)

O DCL (Data Control Language) é uma parte importante de um sistema de gerenciamento de banco de dados (SGBD) que trata do controle de acesso e privilégios sobre os dados armazenados. Ele consiste em um conjunto de comandos que permitem aos administradores de banco de dados conceder ou revogar permissões de acesso aos usuários e gerenciar a segurança dos dados. As principais operações realizadas pelo DCL incluem:

**GRANT**: Permite conceder permissões específicas a usuários ou papéis no banco de dados. Essas permissões podem incluir o direito de executar determinadas operações, como SELECT, INSERT, UPDATE, DELETE, entre outras, em tabelas específicas ou em todo o banco de dados.

**REVOKE**: Permite revogar permissões anteriormente concedidas a usuários ou papéis. Isso é útil quando é necessário restringir ou remover o acesso a certos recursos do banco de dados.

## Conceder privilégios a usuários:

Para conceder privilégios a um usuário em um banco de dados específico, você pode usar o comando GRANT:

```sql
GRANT tipo_privilegio ON nome_banco_de_dados.tabela_ou_* TO 'user'@'host';
```

**Os tipos de privilégios:**

<br>

**ALL PRIVILEGES** Concede todos os privilégios disponíveis em um banco de dados específico ou em todas as tabelas de um banco de dados.

**CREATE** Permite que o usuário crie novas tabelas e bancos de dados.

**DROP** Permite que o usuário exclua tabelas e bancos de dados.

**SELECT** Permite que o usuário leia dados de tabelas específicas.

**INSERT** Permite que o usuário insira novos registros em tabelas específicas.

**UPDATE** Permite que o usuário atualize registros em tabelas específicas.

**DELETE** Permite que o usuário exclua registros de tabelas específicas.

**ALTER** Permite que o usuário altere a estrutura de tabelas existentes.

**INDEX** Permite que o usuário crie e remova índices em tabelas.

**CREATE TEMPORARY TABLES** Permite que o usuário crie tabelas temporárias.

**SHOW VIEW** Permite que o usuário visualize a estrutura de visualizações.

**CREATE VIEW** Permite que o usuário crie visualizações.

**CREATE ROUTINE** Permite que o usuário crie rotinas (procedures e functions).

**ALTER ROUTINE** Permite que o usuário altere rotinas existentes.

**EXECUTE** Permite que o usuário execute rotinas.

**CREATE USER** Permite que o usuário crie, altere e remova outros usuários.

**FILE** Permite que o usuário execute operações de arquivo no servidor.

**PROCESS** Permite que o usuário veja todos os processos em execução no servidor.

**RELOAD** Permite que o usuário recarregue as configurações do servidor.

**SHUTDOWN** Permite que o usuário desligue o servidor MySQL.

**SUPER** Concede privilégios administrativos globais.

**REPLICATION CLIENT** Permite que o usuário consulte os eventos de replicação.

**REPLICATION SLAVE** Permite que o usuário se conecte como um escravo e leia os eventos de registro binário do mestre.

**SHOW DATABASES** Permite que o usuário veja todos os bancos de dados.

**LOCK TABLES** Permite que o usuário bloqueie tabelas para leitura e gravação.

#### Se você quiser conceder todas as permissões para um usuário no banco de dados, utilize o seguinte código:

```sql
GRANT ALL PRIVILEGES ON nome_database.* TO 'user'@'host';
```
Depois de conceder permissões, você precisa atualizar os privilégios para que eles entrem em vigor:

```sql
FLUSH PRIVILEGES;
```
Para verificar as permissões concedidas a um usuário, você pode usar o comando:
```sql
SHOW GRANTS FOR 'user'@'host';
```

## Revogar privilégios a usuários: 

Para revogar privilégios de um usuário em um banco de dados específico, você pode usar o comando **REVOKE**:

```sql
REVOKE tipo_privilegio ON nome_banco_de_dados.tabela_ou_* FROM 'user'@'host';
```
Os tipos de privilégios que podem ser revogados são os mesmos listados na seção de [conceder privilégios](#conceder-privilégios-a-usuários)!

Se você quiser revogar todas as permissões para um usuário em um banco de dados, utilize o seguinte código:

```sql
REVOKE ALL PRIVILEGES ON nome_banco_de_dados.* FROM 'user'@'host';
```
Depois de revogar permissões, você precisa atualizar os privilégios para que eles entrem em vigor:

```sql
FLUSH PRIVILEGES;
```
Para verificar as permissões revogadas de um usuário, você pode usar o comando:
```sql
SHOW GRANTS FOR 'user'@'host';
```

## Gerenciamento de usuários no mysql

#### Visualizar usuários:

```sql
SELECT User, Host FROM mysql.user;
```
Isso irá listar todos os usuários e os hosts de onde eles podem se conectar.

#### Criar um usuário:

```sql
CREATE USER 'user'@'host' IDENTIFIED BY 'password';
```
Substitua 'user' pelo nome que deseja dar ao usuário, 'host' pelo host de onde o usuário pode se conectar (geralmente 'localhost' para conexões locais) e 'password' pela senha que deseja atribuir ao usuário.

#### Excluir um usuário:

```sql
DROP USER 'user'@'host';
```
Substitua 'nome_usuario' pelo nome do usuário que deseja excluir e 'host' pelo host correspondente.

# SHOW

O comando SHOW é utilizado para recuperar informações sobre diversos aspectos do banco de dados, incluindo tabelas, índices, usuários, privilégios, variáveis de sistema e muito mais. Ele oferece uma série de subcomandos que permitem visualizar diferentes tipos de informações.

Os principais comandos:
```sql
SHOW DATABASES;
```
Com isso mostrará todos os databases disponíveis no servidor mysql.

```sql
SHOW TABLES;
```
Para listar as tabelas de um banco, ele precisa estar selecionado, [Selecionar um database](#selecionar-um-database). 

```sql
SHOW COLUMNS FROM nome_database.nome_table;
```
Isso listará as colunas de uma tabela, é necessário que um database esteja selecionado.

```sql
SHOW INDEX FROM nome_database.nome_table;
```
Isso listará os indexes daquela tabela em específico, por exemplo a 'primary key', as 'foreign keys' também. É necessário que um database esteja selecionado.

```sql
SHOW FUNCTION STATUS
WHERE Db = 'nome_database';
```
Exibe informações sobre todas as funções definidas no banco de dados. Caso não utilizar o WHERE Db, irá listar as funções do sistema inteiro.

```sql
SHOW PROCEDURE STATUS
WHERE Db = 'nome_database';
```
Mostra informações sobre todos os procedimentos armazenados definidos no banco de dados. Caso não utilizar o WHERE Db, irá listar as procedures do sistema inteiro.

```sql
SHOW TRIGGERS;
```
Retorna informações sobre todos os triggers definidos no banco de dados. O database precisa estar selecionado.
```sql
SHOW CREATE TABLE nome_database.nome_table;
SHOW CREATE VIEW nome_database.nome_view;
SHOW CREATE FUNCTION nome_database.nome_function;
SHOW CREATE PROCEDURE nome_database.nome_procedure;
SHOW CREATE TRIGGER nome_database.nome_trigger;
```
Os comandos SHOW CREATE são usados no MySQL para exibir a declaração SQL completa usada para criar diferentes tipos de objetos no banco de dados, como tabelas, visualizações, funções, procedimentos e gatilhos. Esses comandos são úteis para obter informações detalhadas sobre a estrutura e definições desses objetos, permitindo a visualização rápida das declarações SQL utilizadas para criá-los.

```sql
SHOW PROCESSLIST;
```
Lista informações sobre as conexões de clientes atuais com o servidor MySQL e os comandos que estão sendo executados.

```sql
SHOW VARIABLES;
```
Mostra variáveis de sistema configuráveis do MySQL e seus valores atuais.

```sql
SHOW VARIABLES LIKE 'variavel';
```
Retorna o valor de uma variável de sistema específica.

```sql
SHOW STATUS;
```
Exibe uma variedade de informações de status sobre o servidor MySQL em execução.

```sql
SHOW GRANTS FOR 'user'@'host';
```
Mostra os privilégios concedidos a um usuário específico.

# CASE

A cláusula CASE é uma construção condicional poderosa em SQL que permite realizar avaliações condicionais e retornar valores com base nessas condições.

Sintaxe:
```sql
CASE
    WHEN condição1 THEN resultado1
    WHEN condição2 THEN resultado2
    ...
    ELSE resultado_padrao
END
```
Exemplos práticos:
```sql
-- Exemplo 1:
SELECT nome, idade,
    CASE
        WHEN idade < 18 THEN 'Menor de idade'
        WHEN idade BETWEEN 18 AND 65 THEN 'Adulto'
        ELSE 'Idoso'
    END AS categoria
FROM usuarios;
```
Se tivessemos uma tabela chamada usuarios que tenha uma coluna de idade dos usuários.
poderia criar uma coluna 'categoria' onde mostra se é menor de idade, ou se é aduto ou se é idodo de acordo com as condições do CASE WHEN.
```sql
-- Exemplo 2:
SELECT nome, pontuacao,
    CASE
        WHEN pontuacao >= 90 THEN 'A'
        WHEN pontuacao >= 80 THEN 'B'
        WHEN pontuacao >= 70 THEN 'C'
        ELSE 'D'
    END AS classificacao
FROM alunos;
```
Neste exemplo, estamos classificando os alunos com base em suas pontuações. Aqueles com uma pontuação de 90 ou mais recebem uma classificação de 'A', entre 80 e 89 recebem 'B', entre 70 e 79 recebem 'C', e todos os outros recebem 'D'.
```sql
-- Exemplo 3:
UPDATE demonstracao.produtos
SET preco = (
	CASE
        WHEN preco >= 500 AND categoria = "eletrônicos" THEN preco - (preco * (10 / 100))
        WHEN preco >= 50 AND categoria = "domésticos" THEN preco - (preco * (15 / 100))
        WHEN categoria = "calçados" THEN preco - (preco * (7 / 100))
        ELSE preco
    END
);
```
Também é possível utilizar o CASE no UPDATE. Nesse exemplo é a aplicação de um desconto nos produtos de acordo com as condições. Se o preço do produto for maior ou igual que 500 reais e a categoria for eletrônicos, então o preço recebe um desconto de 10%, se for maior ou igual que 50 reais e a categoria for domésticos então o preço receber desconto de 15%, se a categoria for calçados então o desconto é de 7%, se o produto não cair em nenhuma dessas condições, então recebe o seu preço normal. 
```sql
-- Exemplo 4:
DELETE FROM clientes
WHERE CASE
    WHEN idade < 18 THEN 1
    WHEN ultima_atividade < DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) THEN 1
    ELSE 0
END = 1;
```
A utilização da cláusula CASE dentro de um comando DELETE pode ser um pouco incomum, pois normalmente a exclusão de linhas é feita com base em condições simples. Porém mostrarei esse exemplo apenas para saber que também é possível utilizar o CASE no DELETE.

Nesse exemplo em questão, estamos deletando todos os clientes em que a idade é menor que 18 ou se a ultima_atividade do cliente foi a mais de um ano atrás, caso contrário não deletará.

**Obs:** Talvez o 'safe update mode' do MySQL não permita que você utilize UPDATE ou DELETE sem utilizar a pk no WHERE, até porque não é indicado, a não ser uma situação específica como essa. Veja como ativar ou desativar isso [aqui](https://www.geeksengine.com/database/manage-table/safe-update.php).

Também é possível utilizar o CASE em FUNCTIONS, PROCEDURES e TRIGGERS, mas falaremos melhor sobre isso na [próxima sessão](#functions-procedures-e-triggers).

# FUNCTIONS, PROCEDURES e TRIGGERS

Nessa sessão irá ser abordado, o que se pode utilizar dentro do escopo desses 3 objetos do banco de dados MySQL. Para ver específicamente cada um deles, siga essas sessões: [functions](#criar-uma-function), [procedures](#criar-uma-procedure) e [trigger](#criar-uma-trigger).

**O que pode ser usado?**

- [Variáveis locais](#variáveis-locais)
- [IF](#if)
- [CASE](#estrutura-de-fluxo-case)
- [LOOP](#loop)
- [WHILE](#while)
- [REPEAT](#repeat)
- [Lançar exceções](#lançar-exceções)
- [Manipular exceção](#manipular-exceções)
- [Cursores](#cursores)

## Variáveis locais

Dentro de procedimentos armazenados, funções e gatilhos no MySQL, você pode declarar e usar variáveis locais para armazenar valores temporários durante a execução. Essas variáveis são acessíveis apenas dentro do escopo do objeto em que foram declaradas e são úteis para armazenar valores intermediários ou resultados parciais durante a execução do código.

Sintaxe:
```sql
DECLARE variavel [tipo];
SET variavel = valor;
```
Para declarar a variável deve utilizar o DECLARE, os tipos permitidos para a variável é os mesmos tipos disponíveis em colunas. Para definir um valor a variável é necessário utilizar o SET.

Exemplos práticos:
```sql
DELIMITER $
CREATE FUNCTION calcularDesconto(preco DECIMAL(10, 2)) 
RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
    DECLARE desconto DECIMAL(10, 2);
    DECLARE precoComDesconto DECIMAL(10, 2);
    
    IF preco >= 100 THEN
        SET desconto = 0.1; 
    ELSE
        SET desconto = 0;
    END IF;
    
    SET precoComDesconto = preco - (preco * desconto);
    
    RETURN precoComDesconto;
END $
DELIMITER ;
```
Esse exemplo é dentro de uma função que calcula o desconto de um preço que é passado no parâmetro. Foi declarado a variável desconto, que dependendo do preço do produto iria ter desconto de 10% ou nenhum desconto, a outra variável é onde calcula o preço menos o desconto.

```sql
DELIMITER $
CREATE PROCEDURE atualizarSaldoCliente(cliente_id INT, valorCompra DECIMAL(10, 2))
BEGIN
    DECLARE saldoAtual DECIMAL(10, 2);
    
    SELECT saldo INTO saldoAtual FROM clientes WHERE id = cliente_id;
    
    IF saldoAtual >= valorCompra THEN
        UPDATE clientes SET saldo = saldoAtual - valorCompra WHERE id = cliente_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente.';
    END IF;
END $
DELIMITER ;
```
Esse exemplo é em uma procedure que atualiza o saldo de um cliente. A variável local é o saldoAtual, que insere seu valor na consulta, ou seja, o resultado da consulta é atribuido na variável saldoAtual, ele verifica se o saldo atual é maior que o valorCompra passado no parâmetro para fazer a atualização do saldo do cliente, caso o contrário, ele emite um erro de Saldo insuficiente.

## IF

O IF no MySQL é uma estrutura de controle de fluxo que permite executar blocos de códigos com base em uma condições.

Exemplos práticos:
```sql
DELIMITER $
CREATE TRIGGER aplicar_desconto_pedido
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.total_pedido > 1000 THEN
        SET NEW.valor_desconto = 0.1 * NEW.total_pedido; 
    ELSE
        SET NEW.valor_desconto = 0;
    END IF;
END $
DELIMITER ;
```
Neste exemplo, o trigger aplicar_desconto_pedido é acionado antes de inserir um novo registro na tabela pedidos. Ele verifica se o total_pedido do novo pedido é superior a $1000 e, se for, aplica um desconto de 10% ao valor_desconto do novo pedido.

```sql
DELIMITER $
CREATE FUNCTION determinar_tipo_numero(numero INT) 
RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
    DECLARE tipo VARCHAR(20);
    
    IF numero > 0 THEN
        SET tipo = 'Positivo';
    ELSEIF numero < 0 THEN
        SET tipo = 'Negativo';
    ELSE
        SET tipo = 'Zero';
    END IF;
    
    RETURN tipo;
END $
DELIMITER ;
```
Neste exemplo, a função determinar_tipo_numero recebe um número como parâmetro e retorna uma string indicando se o número é positivo, negativo ou zero. Ele usa a estrutura IF para determinar o tipo com base no valor do número fornecido.

## CASE
O CASE no MySQL é uma estrutura de controle de fluxo que permite realizar várias comparações condicionais em cascata e executar diferentes blocos de código com base no resultado dessas comparações.

Exemplos práticos:
```sql
DELIMITER $
CREATE TRIGGER tg_before_insert_funcionarios
BEFORE INSERT ON funcionarios
FOR EACH ROW
BEGIN
    SET NEW.nivel = 
        CASE
            WHEN NEW.salario >= 5000 THEN 'Sênior'
            WHEN NEW.salario >= 3000 THEN 'Pleno'
            ELSE 'Júnior'
        END;
END $
DELIMITER ;
```
Neste exemplo, o trigger atribuir_nivel_funcionario é acionado antes de inserir um novo registro na tabela funcionarios. Ele verifica o salário do novo funcionário e atribui um nível com base no salário usando a estrutura CASE.
```sql
DELIMITER $
CREATE PROCEDURE calcular_custo_total_pedido(pedido_id INT)
BEGIN
    DECLARE custo_total DECIMAL(10,2);
    
    SET custo_total = (
        SELECT SUM(
            CASE
                WHEN quantidade > 10 THEN preco_unitario * quantidade * 0.9
                ELSE preco_unitario * quantidade
            END
        )
        FROM itens_pedido
        WHERE pedido_id = pedido_id
    );
    
    SELECT custo_total;
END $
DELIMITER ;
```
Suponha que você deseje criar uma procedure para calcular o custo total de um pedido com base nos produtos selecionados e em suas quantidades. 

Neste exemplo, a procedure calcular_custo_total_pedido recebe o ID de um pedido como parâmetro e calcula o custo total do pedido com base nos itens selecionados e em suas quantidades. Ele usa a estrutura CASE para aplicar descontos de 10% nos itens com mais de 10 unidades.

## LOOP

O loop é uma estrutura de controle que permite executar um bloco de código repetidamente enquanto uma condição específica for verdadeira. No MySQL, existem três tipos de loops: LOOP, WHILE e REPEAT.

Sintaxe básica:
```sql
nome_loop: LOOP
    -- código a ser repetido
    IF condição THEN
        LEAVE nome_loop;
    END IF;
END LOOP nome_loop;
```
Neste exemplo, nome_loop é um rótulo opcional para o loop, usado com as instruções LEAVE e ITERATE para controlar o fluxo do loop. O código dentro do loop será repetido até que a condição especificada seja atendida, momento em que o loop será interrompido com a instrução LEAVE. E aquela repetição pode ser pulada para a próxima iteração com ITERATE.

Exemplos práticos:
```sql
DELIMITER $
CREATE PROCEDURE loop_increment(limite INT)
BEGIN
    DECLARE cont INT DEFAULT 0;
    nomeLoop: LOOP
        SET cont = cont + 1;
        IF cont > limite THEN
            LEAVE nomeLoop;
        END IF;
        SELECT cont;
    END LOOP nomeLoop;
END $
DELIMITER ;
```
Neste exemplo, criamos um procedimento armazenado chamado loop_increment, que recebe um limite como entrada. Dentro do loop, incrementamos um contador até que atinja o limite especificado. O loop faz uma consulta com o valor do contador em cada iteração.
```sql
DELIMITER $
CREATE PROCEDURE loop_increment(inicio INT, limite INT)
BEGIN
    DECLARE cont INT DEFAULT inicio-1;
    nomeLoop: LOOP
		SET cont = cont + 1;
        IF cont > limite THEN
            LEAVE nomeLoop;
        END IF;
        IF (cont % 2) != 0 THEN
			ITERATE nomeLoop;
        END IF;
		SELECT cont;
    END LOOP nomeLoop;
END $
DELIMITER ;
```
Nesse exemplo, continua sendo uma procedure de incremento, porém é passado em qual número o loop começa e em qual número o loop termina, e dessa vez, ele verifica se o número do contador é ímpar, pois nesse caso ele passa para a próxima iteração sem que a consulta seja executada. Fazendo com que apenas os números pares sejam imprimidos.

## WHILE
O WHILE é uma estrutura de controle de fluxo em SQL que permite executar um bloco de código repetidamente enquanto uma condição específica for verdadeira.

Exemplos práticos:
```sql
DELIMITER $
CREATE FUNCTION potencia(base INT, expoente INT) 
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE resultado INT DEFAULT 1;
    DECLARE n INT DEFAULT 1;
    WHILE n <= expoente DO
        SET resultado = resultado * base;
        SET n = n + 1;
    END WHILE;

    RETURN resultado;
END $
DELIMITER ;
```
Nesse exemplo, é uma função que calcula a potência sendo necessario passar a base e o expoente. O WHILE irá repetir até a variável de incremento ser menor ou igual que o expoente, enquanto isso ser verdadeiro, o resultado irá continuar incrementando seu valor multriplicado com a base da potência. E quando acaba o loop ele retorna a variável resultado.
```sql
DELIMITER $
CREATE TRIGGER tg_before_update_produtos
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    DECLARE new_preco DECIMAL(10, 2);
    DECLARE max_preco DECIMAL(10, 2);

    SET new_preco = NEW.preco;
    SET max_preco = 1000; 

    WHILE new_preco > max_preco DO
        SET new_preco = new_preco * 0.95;
    END WHILE;

    SET NEW.preco = new_preco; 
END $
DELIMITER ;
```
Neste exemplo, o trigger update_produtos_preco é acionado antes de atualizar um registro na tabela produtos. Ele verifica se o novo preço (NEW.preco) é maior que o limite máximo especificado (1000 neste caso) e, se for, reduz o preço em 5% repetidamente até que ele fique abaixo do limite máximo. O loop WHILE garante que o preço seja ajustado conforme necessário antes de realizar a atualização no banco de dados.

## REPEAT

A instrução REPEAT é usada para criar um loop que executa um bloco de comandos repetidamente até que uma condição especificada seja atendida.

- REPEAT: Inicia um loop que executará um bloco de comandos repetidamente.
- UNTIL: Define a condição de término do loop. O loop continuará até que a condição especificada após o UNTIL seja avaliada como verdadeira.

Exemplos práticos:
```sql
DELIMITER $
CREATE TRIGGER tg_before_insert_beneficiario
BEFORE INSERT ON beneficiarios
FOR EACH ROW
BEGIN
	DECLARE qtdeFilhos INT;
    DECLARE salario FLOAT;
       
    DECLARE idadeFilho INT;
    
    DECLARE n INT DEFAULT 0;
   
    SET qtdeFilhos = (
		SELECT qtde_filhos FROM pais
		WHERE id = NEW.pai_id GROUP BY id
    );

    SET salario = (
        SELECT salario FROM pais 
        WHERE id = NEW.pai_id
    );
    
    IF qtdeFilhos = 0 OR salario > 2000.00 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deve ter pelo menos um filho e um salário inferior a 2000 reais.';
    END IF;
	  
    REPEAT
		
        SET n = n + 1; 
    
        SET idadeFilho =  (
			SELECT idade FROM filhos
            WHERE pai_id = NEW.pai_id 
            AND ordem = n
        );
        
        IF idadeFilho >= 18 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Todos os filhos devem ser menores de idade.';
        END IF;
                
    UNTIL n >= qtdeFilhos END REPEAT;
    
	SET NEW.valor_auxilio = qtdeFilhos * 400;
    
END$
DELIMITER ;
```
Esse é um exemplo com uma trigger que é acionada antes da inserção de um novo registro na tabela beneficiarios. Imagine que tenha um novo auxilio do governo que é dado aos pais que tem apenas filhos menores de idade. Nesse exemplo fictício existe uma tabela de pais com o seu ID, nome, salário e quantidade de filhos, e também existe uma tabela de filhos com seu ID, nome, idade e o ID do pai, já a beneficiarios tem o seu ID, o ID do pai que receberá o auxílio e o valor do auxílio dado, que deve ser 400 reais por filho. E essa trigger não pode permitir que qualquer um seja inserido, pois só pode receber o auxilio os pais que tem pelo menos 1 filho, que tenha o salário menor que 2000 e que todos os filhos seja menor de idade. E se todas as condições serem atendidas ele atualiza o valor do auxílio que o beneficiário receberá para 400 reais por filho.
```sql
DELIMITER $
CREATE FUNCTION porc_acertos(alvo INT, tentativas INT) 
RETURNS VARCHAR(105) DETERMINISTIC
BEGIN
	DECLARE random_num INT;
	DECLARE acertos INT DEFAULT 0;
    DECLARE n INT DEFAULT 0;
    REPEAT
        SET random_num = FLOOR(RAND() * 10+1);
        SET n = n + 1;
        IF random_num = alvo THEN
			SET acertos = acertos + 1;
        END IF;
    UNTIL n = tentativas END REPEAT;
    RETURN CONCAT(ROUND( (acertos / tentativas) * 100, 2), "%");
END $
DELIMITER ;
```
Esse é um exemplo de uma função que retorna quantos porcentos de acertos tiveram em uma quantidade de tentativas determinadas no parâmetro da função. O REPEAT é utilizado para ele continuar gerando números aleatórios e ir vendo se é um acerto ou não até que o número de repetições seja igual aos de tentativas passados no parâmetro. 

## Lançar exceções

Você pode definir suas próprias exceções personalizadas para sinalizar condições específicas de erro ou para impedir que alguma ação seja feita.

Exemplos práticos:
```sql
DELIMITER $
CREATE TRIGGER tg_before_insert_exemplo
BEFORE INSERT ON exemplo
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(NEW.nome) < 3 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'O nome deve ter pelo menos 3 caracteres';
    END IF;
END$
DELIMITER ;
```
Esse é um exemplo com trigger, ele impede uma inserção de uma registro caso o nome tenha menos de 3 caractéres.
```sql
DELIMITER $
CREATE PROCEDURE deleta_registro(registro_id INT)
BEGIN
    DECLARE existeRegistro INT;
    
    SELECT id INTO registro_existe FROM Exemplo WHERE id = registro_id;
    
    IF registro_existe IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível excluir esse registro! Esse ID não existe na tabela';
    ELSE
        DELETE FROM exemplo WHERE id = registro_id;
    END IF;
END$
DELIMITER ;
```
Neste exemplo, a procedure exclui_registro recebe um parâmetro registro_id, que é o ID do registro que se deseja excluir da tabela exemplo. Dentro da procedure, primeiro é verificado se o registro existe na tabela. Se não existir, uma exceção é lançada com a mensagem "O registro não existe na tabela". Caso contrário, o registro é excluído da tabela.

## Manipular exceção
A manipulação de exceções é uma técnica usada para lidar com situações de erros que podem ocorrer durante a execução de um programa ou operação. Uma exceção é um evento anormal que ocorre durante a execução de uma instrução e pode interromper o fluxo normal de execução.

Sintaxe:
```sql
DECLARE { EXIT | CONTINUE } HANDLER 
FOR condition_value [, condition_value] ... 
BEGIN
    -- tratamento da exceção
END;
```
**EXIT**: O procedimento armazenado será encerrado.<br>
**CONTINUE**: O procedimento armazenado continuará a execução.<br>
**FOR condition_value [, condition_value] ...**: especifica as condições que ativam o manipulador e você pode especificar diversas condições separando-as com vírgulas. <br>

a **condition_value** pode ser uma das seguintes:

- **mysql_error_code**: Este é um número inteiro que indica um código de erro do MySQL, como 1051.

- **SQLWARNING**: Este é um atalho para a classe de SQLSTATE que começa com '01'.

- **NOT FOUND**: Este é um atalho para a classe de SQLSTATE que começa com '02'.

- **SQLEXCEPTION**: Este é um atalho para a classe de SQLSTATE que não começam com '00', '01', ou '02'.

- **SQLSTATE [VALUE]**: Um SQLSTATE é uma string de cinco caracteres que fornece informações sobre o resultado de uma operação SQL. Um SQLSTATE consiste em duas partes: código da Classe (dois primeiros caracteres) que geralmente indica a categoria geral do erro. E o código da Subclasse (Próximos três caracteres) que fornece informações mais específicas sobre o erro dentro da categoria geral.

Exemplos práticos:
```sql
DELIMITER $
CREATE PROCEDURE insert_func(nome VARCHAR(60), salario FLOAT)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Não foi possível inserir na tabela' as error_message;
    END;

    INSERT INTO funcionario (nome, salario) VALUES (nome, salario);
END$
DELIMITER ;
```
Esse é um exemplo básico em uma procedure que insere registros, e o HANDLER é um EXIT ou seja, sai da procedure depois da manipulação da exceção, e ele intercepta qualquer SQLEXCEPTION que ocorrer durante o INSERT, por exemplo se eu chamar a procedure e passar o nome como NULL, irá mostrar a mensagem de erro.
```sql
DELIMITER $
CREATE TRIGGER tg_before_insert_exemplo
BEFORE INSERT ON exemplo
FOR EACH ROW
BEGIN

    DECLARE campo_erro TEXT;
    DECLARE msg_erro TEXT;
    
    DECLARE EXIT HANDLER FOR SQLSTATE '45000'
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
			campo_erro = MESSAGE_TEXT;

        SET msg_erro = CONCAT('Erro de validação dos dados de input! Campo inválido: ', campo_erro);
        INSERT INTO LogErros (mensagem) VALUES (msg_erro);
        
        RESIGNAL;
    END;

    valida_nome(NEW.nome);
    valida_email(NEW.email);
    valida_data_nasc(NEW.data_nasc);
    
END$
DELIMITER ;
```
Essa trigger tg_before_insert_exemplo é acionada antes de cada inserção na tabela exemplo. Ela tem o propósito de validar os dados inseridos nos campos nome, email e data_nasc utilizando as procedures específicas valida_nome, valida_email e valida_data_nasc, se passa na validação a procedure não faz nada, caso não passa na validação a procedure lança um SIGNAL SQLSTATE '45000' com o campo da validação como mensagem.

Dentro da trigger, é definido um manipulador de exceções DECLARE EXIT HANDLER FOR SQLSTATE '45000', que será acionado se alguma das procedures de validação lançar uma exceção com o SQLSTATE '45000'. Quando isso acontecer, o manipulador entra em ação, registrando um erro na tabela LogErros com uma mensagem que identifica qual campo falhou na validação, e logo em seguida interrompe a inserção na tabela com o RESIGNAL, para relançar a exceção que chamou o manipulador.

## Cursores
Um cursor no MySQL é uma estrutura de controle que permite iterar sobre um conjunto de resultados retornados por uma consulta SQL. Ele permite processar linha por linha os resultados de uma consulta, o que pode ser útil em situações em que você precisa realizar operações complexas em cada linha individualmente.

**Declaração de Cursor:**

A instrução DECLARE é usada para declarar um cursor no MySQL. Ela define um nome para o cursor e especifica a consulta SQL que será associada a ele. Aqui está um exemplo:
```sql
DECLARE cursor_name CURSOR FOR select_statement;
```
Neste exemplo, cursor_name é o nome do cursor que estamos declarando, e SELECT column1, column2 FROM table_name é a consulta SQL que o cursor irá executar.

**Abertura do Cursor:**

A instrução OPEN é usada para abrir um cursor previamente declarado. Uma vez aberto, o cursor começa a executar a consulta associada a ele
```sql
OPEN cursor_name;
```
Neste exemplo, cursor_name é o nome do cursor que queremos abrir. Após esta instrução, o cursor começa a processar os resultados da consulta associada.

**Leitura do Cursor:**

A instrução FETCH é usada para recuperar linhas de dados do resultado de uma consulta executada pelo cursor. Ela é usada dentro de um loop para iterar sobre os resultados linha por linha. 
```sql
FETCH cursor_name INTO variable1, variable2;
```
Neste exemplo, cursor_name é o nome do cursor do qual queremos recuperar uma linha de dados, e variable1, variable2, etc., são variáveis nas quais os valores das colunas recuperadas serão armazenados.

**Fechamento do Cursor:**

A instrução CLOSE é usada para fechar um cursor previamente aberto. Quando um cursor é fechado, ele não pode mais ser usado para recuperar dados. Aqui está um exemplo:
```sql
CLOSE cursor_name;
```
Neste exemplo, cursor_name é o nome do cursor que queremos fechar.

Em resumo, ao usar cursores em MySQL, você primeiro declara um cursor com a consulta desejada, depois o abre para começar a recuperar os resultados, usa a instrução FETCH dentro de um loop para recuperar linha por linha, e finalmente fecha o cursor quando terminar de usá-lo. Essas instruções permitem iterar sobre os resultados de uma consulta e processá-los linha por linha, conforme necessário.

Exemplos práticos:
```sql
DELIMITER $
CREATE FUNCTION monta_nomes()
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE concluido BOOLEAN DEFAULT FALSE;
    DECLARE nomes TEXT DEFAULT "";
    DECLARE usernome VARCHAR(100);

    DECLARE cur CURSOR FOR SELECT nome FROM exemplo;

    DECLARE CONTINUE HANDLER FOR NOT FOUND 
    BEGIN
        SET concluido = TRUE;
    END;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO usernome;
        
        IF concluido THEN
            LEAVE read_loop;
        END IF;

        SET nomes = CONCAT( IF(
			nomes = "", "", CONCAT(nomes, ", ")
		), LOWER(usernome));
    END LOOP;

    CLOSE cur;

    RETURN nomes;
END$
DELIMITER ;
```
É um exemplo de uma função que retorna todos os nomes registrados na tabela concatenados em um texto, separados por vírgula. Sempre que utilizar um LOOP para passar por todas as linhas, é necessário utilizar o manipulador com o NOT FOUND, pois quando der o FETCH la no lupe na última linha, a próxima linha não existe ou seja, lança uma exceção NOT FOUND, que o manipulador é acionado e seta a variavel concluido como TRUE, fazendo para o loop com o LEAVE read_loop.
```sql
DELIMITER $
CREATE PROCEDURE calcula_total_preco(OUT total_preco DECIMAL(10, 2))
BEGIN
    DECLARE concluido BOOLEAN DEFAULT FALSE;
    DECLARE total DECIMAL(10, 2) DEFAULT 0;
    DECLARE preco_produto DECIMAL(10, 2);

    DECLARE cur CURSOR FOR SELECT preco FROM produtos;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET concluido = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO preco_produto;
        IF concluido THEN
            LEAVE read_loop;
        END IF;

        SET total = total + preco_produto;
    END LOOP;

    CLOSE cur;

    SET total_preco = total;
END$
DELIMITER ;

CALL calcula_total_preco(@total_preco);
SELECT @total_preco as total_preco;
```
Este procedimento começa declarando variáveis para armazenar o estado do cursor (concluido), o preço total (total) e o preço de cada produto (preco_produto). Em seguida, declara um cursor que seleciona os preços dos produtos da tabela produtos. Um manipulador de exceção é definido para detectar quando o cursor alcança o final dos resultados.

Dentro de um loop, os preços dos produtos são recuperados usando a instrução FETCH e somados ao preço total. O loop continua até que não haja mais linhas para serem lidas. Por fim, o cursor é fechado e o preço total é armazenado na variável de saída total_preco.

# Relacionamentos

Um relacionamento em banco de dados refere-se à conexão lógica que existe entre tabelas em um banco de dados relacional. Essas conexões são estabelecidas através de chaves, que são colunas (ou conjunto de colunas) que identificam de forma única cada linha em uma tabela.

**Tipos de relacionamentos:**

- [Um para um (1:1)](#relacionamento-1-para-1)
- [Um para muitos (1:N)](#1-:-N)
- [Muitos para muitos (N:N)](#N-:-N)

## Relacionamento 1 para 1 

Um relacionamento 1 para 1 em bancos de dados é um tipo de conexão onde uma única linha em uma tabela está associada a apenas uma única linha em outra tabela, e vice-versa. Isso significa que cada registro em uma tabela tem uma correspondência direta com exatamente um registro em outra tabela. 

Exemplos práticos:

**Tabela de usuarios e tabela de contatos**

Suponha que você tenha uma tabela de usuarios e uma tabela com as redes sociais e contatos do usuário, por exemplo email, facebook, instagram e etc. Nesse caso, cada usuário pode ter apenas um linha da tabela de contatos, e cada linha de contato vai servir para apenas um usuário específico, ou seja, relacionamento 1:1 entre as tabelas.

Para isso as duas tabelas devem compartilhar uma coluna que possuem o mesmo ID do usuário ou o mesmo ID do contato, nesse caso não importa em qual tabela terá a chave estrangeira que relaciona na outra tabela. 
```sql
CREATE TABLE contatos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(120) NOT NULL,
    facebook VARCHAR(120) NOT NULL,
    instagram VARCHAR(120) NOT NULL,
    ...
);

CREATE TABLE usuarios(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    ...
    contato_id INT UNIQUE,
    CONSTRAINT fk_usuarios_contatos FOREIGN KEY(contato_id) REFERENCES contatos(id)
);
```
**Tabela de funcionarios e tabela de dados_bancarios**

Suponha que você esteja criando um sistema de gerenciamento de funcionários para uma empresa, onde cada funcionário tem informações pessoais e informações bancárias.
Essa também serve como um exemplo de relacionamento 1:1, pois cada funcionario só terá o seu próprio dado bancário, ou seja, cada linha da tabela funcionario só se relacionará com uma linha da tabela dados_bancarios, e vice e versa.

Nessa situação também tanto faz em qual tabela irá guardar o ID do outro.
```sql
CREATE TABLE dados_bancarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_conta VARCHAR(20) NOT NULL,
    banco VARCHAR(100) NOT NULL,
    agencia VARCHAR(20) NOT NULL,
    ...
);

CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    data_admissao DATE NOT NULL,
    ...
    dados_bancario_id INT UNIQUE,
    CONSTRAINT fk_funcionarios_dados_bancarios FOREIGN KEY(dados_bancarios_id) REFERENCES dados_bancarios(id)
);
```

## Relacionamento 1 para N

Um relacionamento 1 para muitos (1:N) em bancos de dados é um tipo de conexão onde uma única linha em uma tabela está associada a uma ou mais linhas em outra tabela, mas cada linha na segunda tabela está associada a apenas uma linha na primeira tabela. Isso significa que cada registro em uma tabela tem uma correspondência direta com um ou mais registros em outra tabela, mas os registros na segunda tabela estão relacionados a apenas um registro na primeira tabela.

Exemplos práticos:

**Tabela departamentos e tabela de funcionario**

Vamos considerar um cenário em que você está gerenciando uma empresa e precisa armazenar informações sobre os departamentos e os funcionários que trabalham nesses departamentos. Nessa situação em um departamento trabalham vários funcionários, mas um funcionário só trabalha e um departamento, nesse caso se originaria um relacionamento 1:N, mais especificamente departamentos 1 - N funcionarios.

Em relacionamentos 1:N, a chave estrangeira deve ficar na tabela em que são muitos. Nesse caso na tabela funcionarios.
```sql
CREATE TABLE departamentos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_departamento VARCHAR(100) NOT NULL,
    localizacao VARCHAR(100) NOT NULL,
    ...
);

CREATE TABLE funcionarios(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    ...
    departamento_id INT NOT NULL,
    CONSTRAINT fk_funcionarios_departamentos FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);
```
**Tabela produtos e tabela de imagens_produto**

Em um ecommerce por exemplo, um produto sempre precisa de várias imagens para mostrar para o cliente interessado. Nesse caso, uma prática comum é criar uma tabela só para as imagens dos produtos, criando um relacionamento produtos 1 - N imagens_produto, pois um produto pode ter várias imagens associadas a ele, enquanto uma imagem só pertence a um produto, se tornando um relacionamento 1:N.
```sql
CREATE TABLE produtos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    ...
);

CREATE TABLE imagens_produto(
    id INT AUTO_INCREMENT PRIMARY KEY,
    caminho_imagem VARCHAR(200) NOT NULL,
    produto_id INT NOT NULL,
    CONSTRAINT fk_produtos_imagens_produto FOREIGN KEY(produto_id) REFERENCES produtos(id)
);
```

## Relacionamento N para N

Um relacionamento muitos para muitos (N:N) em bancos de dados é um tipo de conexão onde várias linhas em uma tabela estão associadas a várias linhas em outra tabela. Isso significa que cada registro em uma tabela pode estar relacionado a um ou mais registros em outra tabela, e vice-versa.

Exemplos práticos:

**tabela alunos e tabela de disciplinas**

Um exemplo de relacionamento N:N seria em uma escola ou universidade, em que vários alunos faz uma disciplina, e cada aluno pode fazer várias disciplinas, ou seja, cada linha de uma tabela pode estar associado a uma ou mais linhas da outra tabela, e vice e versa.

Em relacionamentos muitos para muitos, a chave estrangeira não fica em nenhuma das duas tabelas, na verdade a chave estrangeira fica em uma outra tabela que é criada apenas para o relacionamento entre as duas tabelas, normalmente essa tabela criada possui o nome das duas tabelas do relacionamento separadas por hífen.
```sql
CREATE TABLE alunos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    turma VARCHAR(5) NOT NULL,
    data_nasc DATE,
    ...
);

CREATE TABLE disciplinas(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome_disciplina VARCHAR(50) NOT NULL,
	data_criacao DATE DEFAULT (CURRENT_DATE()),
    ...
);

CREATE TABLE alunos_disciplinas(
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT NOT NULL,
    disciplina_id INT NOT NULL,
    CONSTRAINT fk_alunos_disciplinas FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    CONSTRAINT fk_disciplinas_alunos FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id)
);
``` 
**Tabela de clientes e tabela de produtos**

Em um cenário como um ecommerce, que existem os clientes e os produtos, um cliente pode pedir vários produtos, e cada produto pode ser pedido por vários clientes diferentes. Ou seja um relacionamento N:N.

Nessa situação criamos uma tabela para esse relacionamento, em que ficará a chave estrangeira de ambos as tabelas.
```sql
CREATE TABLE clientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
    ...
);

CREATE TABLE produtos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    ...
):

CREATE TABLE pedidos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    ...
    CONSTRAINT fk_clientes_produtos FOREIGN KEY(cliente_id) REFERENCES clientes(id),
    CONSTRAINT fk_produtos_clientes FOREIGN KEY(produto_id) REFERENCES produtos(id),
);
```
# Funções MySQL

No MySQL existem várias funções nativas e disponíveis para se utilizar em selects, inserts, updates, deletes e até functions, procedures e triggers. Algumas dessas funções serão mostradas aqui.

## Funções: Números

As funções relacionadas a números no MySQL oferecem uma grande variedade de ferramentas para manipular e processar dados numéricos em consultas SQL. Essas funções podem ser utilizadas para realizar cálculos matemáticos, arredondamentos, formatação de números, extração de partes de números, entre outras operações.

**Lista de funções**:

- **ABS():** Retorna o valor absoluto de um número.
- **CEIL():** Arredonda um número para cima até o inteiro mais próximo.
- **FLOOR():** Arredonda um número para baixo até o inteiro mais próximo.
- **ROUND():** Arredonda um número para um número de casas decimais específico.
- **TRUNCATE():** Trunca um número para um número específico de casas decimais.
- **MOD():** Retorna o resto da divisão de dois números.
- **POW():** Calcula a potência de um número.
- **SQRT():** Calcula a raiz quadrada de um número.
- **EXP():** Calcula o valor da função exponencial.
- **LOG():** Calcula o logaritmo natural de um número.
- **LOG10():** Calcula o logaritmo na base 10 de um número.
- **RAND():** Retorna um número aleatório entre 0 e 1.
- **SIGN():** Retorna o sinal de um número (-1 para negativo, 0 para zero e 1 para positivo).
- **PI():** Retorna o valor de π (pi).
- **DEGREES():** Converte radianos para graus.
- **RADIANS():** Converte graus para radianos.
- **FORMAT():** Formata um número com separadores de milhares e uma quantidade específica de casas decimais.
- **BIT_COUNT():** Retorna o número de bits definidos em um valor inteiro.
- **BIN():** Converte um número decimal para binário.
- **HEX():** Converte um número decimal para hexadecimal.
- **OCT():** Converte um número decimal para octal.

Exemplos práticos:
```sql
-- ROUND e FORMAT
SELECT nome, ROUND(preco, 2) AS preco
FROM demonstracao.produtos;
```
Garante o arredondamento dos preços em 2 casas decimais, o FORMAT funciona exatamente igual, porém ele adiciona separador de milhar.
```sql
-- ABS
SELECT ABS(-10); -- Retorna 10
```
Traz só valor absoluto de um número.
```sql
-- MOD
SELECT id, IF( MOD(id, 2) = 0, "PAR", "IMPAR") as resultado 
FROM demonstracao.clientes;
```
Utilizei o MOD() dentro do IF, retornar o resto da divisão do ID atual com o 2, ou seja, se dividir o ID por 2 e não sobrar nada, significa que aquele número é divisível por 2, significando que é um número PAR, caso o contrário é um número IMPAR. 
```sql
-- SQRT
SELECT SQRT(16); -- Retorna 4
```
Realiza a raiz quadrada.
```sql
-- DEGRESS e RADIAN
SELECT nome, DEGREES(latitude) AS latitude_graus, DEGREES(longitude) AS longitude_graus
FROM localizacoes
WHERE latitude BETWEEN RADIANS(37) AND RADIANS(38)
AND longitude BETWEEN RADIANS(-122) AND RADIANS(-121);
```
Um exemplo fictício de uma tabela chamada localizacoes, onde possui as colunas latitude e longitude em radianos, para mostrar a utilização do DEGRESS, que converte um valor em radianos para graus, também existe o RADIANS, que faz o papel contrário, converte graus em radianos.
```sql
-- CEIL e FLOOR
SELECT id, usuario_id, pontuacao, CEIL(pontuacao) AS pontuacao_arredondada
FROM avaliacoes;
```
Um exemplo fictício de uma tabela de avaliacoes de usuarios, utilizando o CEIL para arredondar para um número inteiro, porém arredondando para cima, ou seja 3.2 -> 4, 4.7 -> 5. O FLOOR faz a mesma coisa, porém sempre arredonda para baixo, 3.2 -> 3, 4.7 -> 4 .
```sql
-- RAND
SELECT id, nome, preco
FROM demonstracao.produtos
ORDER BY RAND()
LIMIT 10;
```
Essa é uma dos exemplos de utilização do RAND, para ordenar aleatóriamente uma tabela.
```sql
-- EXP
SELECT id, valor_inicial, anos, EXP(taxa_crescimento * anos) AS valor_final
FROM investimentos;
```
Um exemplo fictício de uma tabela de investimentos, a taxa_crescimento representa a taxa de crescimento ou decaimento(caso seja negativo) exponencial do investimento, e anos representa o tempo de investimento. A função EXP(taxa_crescimento * anos) calcula o valor final do crescimento exponencial do investimento.
```sql
-- POW  e PI
SELECT id, diametro, POW(diametro / 2, 2) * PI() AS area
FROM circulos;
```
Um exemplo fictício de uma tabela on armazena informações de círculos, Podemos querer calcular a área de cada círculo, onde a área é calculada usando a fórmula 
𝜋 x raio², onde raio, é a metade do diametro. E para calcular o raio ao quadrado precisamos utilizar o POW colocando o valor base no primeiro argumento (diametro / 2) e o expoente no segundo argumento, que seria o 2 pois é uma potencia ao quadrado. E para obter a constante 𝜋, o MySQL já tem uma função com o valor dessa contante, que é a função PI().
```sql
-- HEX
SELECT nome_cor, RGB_R, RGB_G, RGB_B, CONCAT('#', HEX(RGB_R), HEX(RGB_G), HEX(RGB_B)) AS cor_hexadecimal
FROM cores;
```
Digamos que você tenha uma tabela de cores com os valores RGB (Red, Green, Blue) de cada cor em valores decimais e queira exibi-los como valores hexadecimais. Isso retornará o nome da cor e seus valores RGB convertidos para hexadecimal no formato #ffffff por exemplo, que seria preto.
```sql
-- BIN
SELECT BIN(10); -- retornaria 1010
```
Converte número decimal em binário.
```sql
-- OCT e CONV
SELECT nome_usuario, id_usuario, CONV(permissoes_octal, 8, 10) as permissoes 
FROM usuarios
WHERE permissoes_octal = OCT(12345);
```
O OCT converte um número decimal para octal.Suponha que você esteja trabalhando com permissões de acesso em um sistema e os números de permissão são representados em octal. Você pode querer exibir esses números de permissão como valores decimais para uma melhor compreensão. Já o CONV, ele converte um valor de um sistema de numeração para outro, o primeiro argumento é o valor a qual quer converter, o segundo argumento é o sistema do valor a ser convertido, e o terceiro argumento, é para qual sistema de numeração quer que converta.

## Funções: Strings

As funções de string são uma parte essencial da linguagem SQL, permitindo manipular e transformar dados de texto de várias maneiras. Com essas funções, podemos realizar operações como concatenar strings, extrair partes específicas de uma string, converter maiúsculas e minúsculas, e muito mais.

**Lista de funções**:

- **CONCAT():** Concatena duas ou mais strings.
- **LOWER():** Converte uma string para minúsculas.
- **UPPER():** Converte uma string para maiúsculas.
- **SUBSTRING():** Retorna uma parte de uma string.
- **REPLACE():** Substitui todas as ocorrências de uma substring por outra em uma string.
- **REGEX_REPLACE():**: Substitui todas as ocorrências por uma expressão literal em uma string, por outra string.
- **TRIM():** Remove espaços em branco ou outros caracteres específicos do início e do final de uma string.
- **LTRIM():** Remove espaços em branco ou outros caracteres específicos do início de uma string.
- **RTRIM():** Remove espaços em branco ou outros caracteres específicos do final de uma string.
- **CHAR_LENGTH():** Retorna o comprimento de uma string em caracteres.
- **LEFT():** Retorna os caracteres à esquerda de uma string.
- **RIGHT():** Retorna os caracteres à direita de uma string.
- **REVERSE():** Inverte uma string.
- **LOCATE():** Retorna a posição da primeira ocorrência de uma substring em uma string.
- **FORMAT():** Formata um número para uma string usando a configuração local.

Exemplos práticos:
```sql
-- CONCAT
SELECT CONCAT("Seja bem vindo, ", nome) as "saudação ao cliente" 
FROM demonstracao.clientes;
```
Esse é um exemplo utilizando o CONCAT, juntando a string "Seja bem vindo, " com o nome de cada cliente, por exemplo "Seja bem vindo, John Smith".
```sql
-- LOWER e UPPER
SELECT id, LOWER(nome) AS nome_minusculo, UPPER(nome) AS nome_maiusculo
FROM demonstracao.clientes;
```
Esse exemplo retorna uma das colunas em minusculo utilizando LOWER e outra maiusculo utilizando UPPER.
```sql
-- LTRIM, TRIM e RTRIM 
SELECT LTRIM("   Hello World   "), TRIM("   Hello World   "), RTRIM("   Hello World   ");
-- LTRIM: "Hello World   "
-- TRIM: "Hello World"
-- LTRIM: "   Hello World"
```
Removedor de espaços. (L) à esquerda, (R) à direita, enquanto TRIM remove todos os espaços à esquerda e à direita, porém, jamais espaços entre caracteres.
```sql
-- CHAR_LENGTH
SELECT CHAR_LENGTH("OLA MUNDO"); -- resultado: 9
```
O CHAR_LENGTH retorna a quantidade de caracteres exatas de uma string.
```sql
-- SUBSTRING
SELECT SUBSTRING('Hello World', 1, 5) AS exemplo1, SUBSTRING('Hello World', 7) AS exemplo2;
-- exemplo 1 'Hello'
-- exemplo 2 'World'
```
No exemplo 1 a função SUBSTRING() extrai uma parte da string começando na posição 7 até o final. Já no exemplo 2, a função SUBSTRING() extrai uma parte da string começando na posição 1 e com um comprimento de 5 caracteres.
```sql
-- REPLACE
SELECT REPLACE("www.mysql.com", ".com", ".com.br"); -- resultado: www.mysql.com.br
```
Onde ‘www.mysql.com’ é a string a ser modificada, ‘.com’ o que dever ser procurado e substituído por ‘.com.br’.
```sql
-- REGEX_REPLACE
SELECT REGEXP_REPLACE('abc123def456GUI789', '[a-zA-Z]', ''); -- Exemplo 1
SELECT REGEXP_REPLACE('20241208', '^([0-9]{4})([0-9]{2})([0-9]{2})$', '$3-$2-$1'); -- Exemplo 2
```
No exemplo 1, retorna "123456789", pois ele encontra todas as ocorrências em que se encontra uma letra do alfabeto de 'a' a 'z' e substitui por uma string vazia, ou seja, ficando apenas os números que sobraram, é possível utilizar qualquer tipo de REGEX ali dentro. 

Já no exemplo 2, retorna "08-12-2024", pois no regex é possível encontrar por grupo, com os parentêses, e utilizar a substring encontrada dentro de tal grupo, com o uso do $ acompanhado do número do grupo que deseja, dependendo da ordem da esquerda para a direita no REGEX.
```sql
-- LEFT
SELECT LEFT('Hello World', 5) AS resultado;
```
Retorna Hello, ele vai da posição 1 até o número especificado no segundo argumento.
```sql
-- RIGHT
SELECT RIGHT('Hello World', 5) AS resultado;
```
Retorna World, ele vai da posição especificada no segundo argumento até o último caractere.
```sql
-- REVERSE
SELECT REVERSE('123456') AS resultado;
```
Retorna '654321', ele inverte todos os caracteres da string deixando-a de trás pra frente.
```sql
-- LOCATE
SELECT LOCATE('or', 'Hello World') AS posicao;
```
Retorna 5, ou seja, a posição inicial da substring especificada no primeiro argumento, caso não seja encontrado, retorna 0.

## Funções: Datas

As funções relacionadas a datas são fundamentais para manipular e extrair informações de dados temporais em um banco de dados. Elas oferecem uma variedade de operações, desde extrair partes específicas de uma data até realizar cálculos de diferença entre datas. 

**Lista de funções:**

- **CURDATE():** Retorna a data atual.
- **CURTIME():** Retorna o horário atual.
- **NOW():** Retorna a data e hora atuais.
- **DATE():** Extrai a parte da data de um valor de data ou data/hora.
- **TIME():** Extrai a parte do horário de um valor de data ou data/hora.
- **YEAR():** Extrai o ano de uma data.
- **MONTH():** Extrai o mês de uma data.
- **DAY():** Extrai o dia de uma data.
- **HOUR():** Extrai a hora de uma data ou data/hora.
- **MINUTE():** Extrai o minuto de uma data ou data/hora.
- **SECOND():** Extrai o segundo de uma data ou data/hora.
- **DAYOFWEEK():** Extrai o dia da semana como um inteiro, indo do 1 (domingo) até 7 (sabado).
- **DAYOFMONTH():** Extrai o dia do mês de uma data, igual o DAY().
- **DAYOFYEAR():** Extrai o dia do ano que está, indo até 365 dias.
- **DAYNAME():** Retorna o nome do dia da semana de uma data.
- **MONTHNAME():** Retorna o nome do mês de uma data.
- **FROM_DAYS():** Converte um número de dias em uma data.
- **MAKEDATE:** Cria uma data com base no ano e no dia do ano fornecidos como argumentos.
- **DATE_FORMAT():** Formata uma data conforme o especificado.
- **TIMESTAMPDIFF():** Retorna a diferença entre duas datas em um formato específico (dias, horas, etc.).
- **TIMESTAMPADD():** Adiciona um intervalo a uma data.
- **DATEDIFF():** Retorna a diferença em dias entre duas datas.
- **STR_TO_DATE():** Converte uma string em um valor de data usando o formato especificado.
- **DATE_ADD():** Adiciona um intervalo a uma data.
- **DATE_SUB():** Subtrai um intervalo de uma data.

Exemplos práticos:
```sql
-- CURDATE
SELECT * FROM demonstracao.pedidos
WHERE data_pedido = CURDATE();
```
Retornará apenas os pedidos feitos na data do dia atual.
```sql
-- CURTIME
SELECT * FROM demonstracao.clientes
WHERE CURTIME() > "08:00:00";
```
Essa consulta só irá acontecer caso o horário atual seja depois das 8 da manhã.
```sql
-- NOW
INSERT INTO transacoes (id_cliente, valor, data_hora)
VALUES (123, 50.00, NOW());
```
É muito útil na hora de um INSERT, para inserir a data e hora atual que ocorreu tal registro.
```sql
-- DATE
SELECT DATE('2024-04-30 12:45:30'); -- Resultado: 2024-04-30
-- TIME
SELECT TIME('2024-04-30 12:45:30'); -- Resultado: 12:45:30
-- YEAR
SELECT YEAR('2024-04-30'); -- Resultado: 2024
-- MONTH
SELECT MONTH('2024-04-30'); -- Resultado: 4
-- DAY
SELECT DAY('2024-04-30'); -- Resultado: 30
-- HOUR
SELECT HOUR('2024-04-30 12:45:30'); -- Resultado: 12
-- MINUTE
SELECT MINUTE('2024-04-30 12:45:30'); -- Resultado: 45
-- SECOND
SELECT SECOND('2024-04-30 12:45:30'); -- Resultado: 30
```
Cada uma dessas funções são usadas para extrair apenas uma informação da data ou hora.
```sql
-- DAYOFWEEK
SELECT DAYOFWEEK('2024-04-30'); -- Resultado: 3 (terça-feira)
-- DAYOFMONTH
SELECT DAYOFMONTH('2024-04-30'); -- Resultado: 30
-- DAYOFYEAR
SELECT DAYOFYEAR('2024-04-30'); -- Resultado: 121
```
Essas funções extrai o dia de uma data em contextos diferentes, dia da semana, dia do mês e dia do ano.
```sql
-- DAYNAME
SELECT DAYNAME('2024-04-30'); -- Resultado: Tuesday
```
Retorna por extenso e em inglês o dia da semana extraido de uma data.
```sql
-- MONTHNAME
SELECT MONTHNAME('2024-04-30'); -- Resultado: April
```
Retorna por extenso e em inglês o nome do mês extraido de uma data.
```sql
-- FROM_DAYS
SELECT FROM_DAYS(737910); -- Retorna '2024-04-30'
```
o número de dias 737910 é convertido para a data correspondente, que é '2024-04-30'. Essa função é útil para converter valores numéricos que representam dias em datas legíveis.
```sql
-- MAKEDATE
SELECT MAKEDATE(2024, 1); -- Retorna '2024-01-01'
SELECT MAKEDATE(2023, 100); -- Retorna '2023-04-10'
SELECT MAKEDATE(2017, 175); -- Retorna '2017-06-24'
```
O primeiro argumento é o ano em que começa o calculo, e o segundo argumento é o número de dias, que utiliza para formar a data.
```sql
-- DATE_FORMAT
DATE_FORMAT(data, formato)
```
**data**: O valor da data ou hora que você deseja formatar.<br>
**formato**: A string de formato que define como a data ou hora será exibida. Isso pode incluir códigos de formato para diferentes partes da data ou hora, como ano, mês, dia, hora, minuto, segundo, etc.

Aqui estão alguns códigos de formato:

- %Y: Ano com quatro dígitos (ex: 2024).
- %y: Ano com dois dígitos (ex: 24).
- %m: Mês com dois dígitos (ex: 04 para abril).
- %d: Dia do mês com dois dígitos (ex: 30).
- %H: Hora em formato de 24 horas com dois dígitos (ex: 14 para 2 da tarde).
- %h: Hora em formato de 12 horas com dois dígitos (ex: 02 para 2 da tarde).
- %i: Minutos com dois dígitos (ex: 05).
- %s: Segundos com dois dígitos (ex: 30).

Exemplos práticos:
```sql
-- Formatando uma data para o formato 'YYYY-MM-DD'
SELECT DATE_FORMAT('2024-04-30', '%Y-%m-%d'); -- Resultado: 2024-04-30

-- Formatando uma data para o formato 'DD/MM/YYYY'
SELECT DATE_FORMAT('2024-04-30', '%d/%m/%Y'); -- Resultado: 30/04/2024

-- Formatando uma hora para o formato 'HH:MM:SS'
SELECT DATE_FORMAT('14:30:45', '%H:%i:%s'); -- Resultado: 14:30:45
```
Esses são alguns exemplos da utilidade do DATE_FORMAT.
```sql
-- TIMESTAMPDIFF

-- DAY
SELECT TIMESTAMPDIFF(DAY, '2024-04-30', '2024-05-05'); -- Retorna 5
-- MONTH
SELECT TIMESTAMPDIFF(MONTH, '2023-04-30', '2024-04-30'); -- Retorna 12
-- YEAR
SELECT TIMESTAMPDIFF(YEAR, '2023-04-30', '2024-04-30'); -- Retorna 1
-- HOUR
SELECT TIMESTAMPDIFF(HOUR, '2024-04-30 08:30:00', '2024-04-30 10:55:00'); -- Retorna 2
-- MINUTE
SELECT TIMESTAMPDIFF(MINUTE, '2024-04-30 08:30:00', '2024-04-30 10:55:00'); -- Retorna 145
-- SECOND
SELECT TIMESTAMPDIFF(SECOND, '2024-04-30 08:30:00', '2024-04-30 8:40:00'); -- Retorna 600
```
O primeiro argumento é em qual unidade deseja que seja a diferença, e os dois outros argumentos são as datas a qual quer saber a diferença.
```sql
-- TIMESTAMPADD
SELECT TIMESTAMPADD(MONTH, 3, '2024-04-30'); -- Retorna '2024-07-30'
```
O TIMESTAMPADD funciona bem parecido com o TIMESTAMPDIFF, porém invês de fazer uma operação da diferença entre datas, ele adiciona um certo tempo a uma data. No primeiro argumento fica a unidade de tempo, que assim como TIMESTAMPDIFF pode ser DAY, MONTH, YEAR, HOUR, MINUTE e SECOND. Já no segundo argumento é o valor a ser adicionado a data, e no terceiro argumento é a própria data.
```sql
-- DATEDIFF
SELECT DATEDIFF('2024-05-05', '2024-04-30'); -- Retorna 5
```
Calcula a diferença em dias entre '2024-05-05' e '2024-04-30', que são 5 dias.
```sql
-- DATE_ADD
SELECT DATE_ADD('2024-05-01', INTERVAL 5 DAY); -- Retorna '2024-05-06'
```
Adiciona o intervalo específico a data passada no primeiro argumento. Nesse caso 5 dias.
```sql
-- DATE_SUB
SELECT DATE_SUB('2024-06-15', INTERVAL 1 MONTH); -- Retorna '2024-05-15'
```
Subtrai 1 mês da data 2024-06-15, ficando 2024-05-15.

### INTERVAL

Com o INTERVAL, você pode adicionar ou subtrair intervalos de datas e horas de valores de data e hora existentes. Isso é útil para calcular datas futuras ou passadas com base em um período específico, como dias, meses ou anos. Você também pode usar o INTERVAL para calcular diferenças entre datas ou para extrair partes específicas de uma data ou hora.

Exemplos práticos:
```sql
SELECT CURDATE() + INTERVAL 7 DAY; 
``` 
Esse exemplo retorna a data de hoje mais 7 dias.
```sql
SELECT CURDATE() - INTERVAL 1 MONTH; 
```
Esse exemplo retorna a data de hoje menos 1 mês.

## Funções de agregação
As funções de agregação são recursos fundamentais em SQL que permitem realizar cálculos sobre conjuntos de dados para obter informações resumidas. Essas funções operam em grupos de linhas e retornam um único valor calculado com base nos valores de uma coluna ou expressão.

**Lista das funções:**

- **SUM:** Calcula a soma dos valores em uma coluna numérica.
- **AVG:** Calcula a média dos valores em uma coluna numérica.
- **COUNT:** Conta o número de linhas em um conjunto de resultados, geralmente usado para contar o número de registros.
- **MIN:** Retorna o valor mínimo em uma coluna.
- **MAX:** Retorna o valor máximo em uma coluna.

Exemplos práticos:
```sql
-- SUM
SELECT SUM(total) AS total_vendas
FROM demonstracao.pedidos
WHERE data_pedido >= (CURRENT_DATE() - INTERVAL 1 MONTH);
```
Retorna o total de vendas no último mês, o SUM soma todas as colunas 'total' retornadas na consulta e agrupa em uma única linha com apenas a soma deles.
```sql
-- AVG
SELECT AVG(idade) AS idade_media
FROM demonstracao.clientes;
```
Digamos que tenha uma coluna que armazena a idade, com o AVG ele soma todos os valores da coluna e divide pela a quantidade de colunas, ou seja a média das idades dos clientes registrados.
```sql
-- MIN
SELECT id, nome, descricao, MIN(preco) AS menor_preco, categoria 
FROM demonstracao.produtos
GROUP BY categoria;
```
Nesse exemplo, ele retorna o produto com menor preço de cada categoria, pois foi agrupo com o GROUP BY categoria.
```sql
-- MAX
SELECT id, produto_id, quantidade, max(subtotal)  
FROM demonstracao.itens_pedidos
WHERE data_pedido >= (CURRENT_DATE() - INTERVAL 1 MONTH)
GROUP BY cliente_id;
```
Nesse exemplo, ele retorna os itens de pedidos mais caros de cada cliente, considerando apenas os pedidos do último mês.
```sql
-- COUNT
SELECT COUNT(cliente.id) AS qtde_clientes 
FROM demonstracao.clientes as cliente
WHERE NOT EXISTS(
	SELECT pedido.cliente_id
    FROM demonstracao.pedidos as pedido
    WHERE cliente.id = pedido.cliente_id
);
```
O COUNT ele conta o números de ocorrências, de resultados daquela consulta. Nesse caso ele retorna a quantidade de clientes que não fizeram pedidos ainda.

## Conversão de tipos
Funções de conversão são úteis para transformar dados de um tipo em outro

### CAST
Converte um valor de um tipo para outro.

Exemplos práticos:
```sql
-- STR -> INT
SELECT CAST('123' AS INT);
```
Convertendo uma string para um número inteiro.
```sql
-- INT -> STR
SELECT CAST(456 AS VARCHAR);
```
Convertendo um número para uma string.
```sql
-- STR -> DATE
SELECT CAST('2024-04-30' AS DATE);
```
Convertendo uma string em uma data.
