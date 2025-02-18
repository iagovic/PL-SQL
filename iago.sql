-- Forma 1 : toda tabela tem que ter no minimo uma chave primaria

-- Forma 2: todos os atributos tem que ser dependentes da chave primaria

-- Forma 3: nÃ£o pode atributos compostos ou transitorios (tirar todos os dados que repetem dos atributos e transformar em outra tabela)
 
 
----------------------------------------------------------------------------------------
 
 
-- DDL (Data Definition Label)

-- Exemplo:

--CREATE TABLE END_CLIENTE(

--Logradouro,

--Numero,

--Cep,

--Estado, -- REPETE

--Cidade, -- REPETE

--Bairro, -- REPETE

--complemento, 

--pais, -- REPETE

--id_cliente

--);
 
-- Porem os dados se repetem (PAIS, ESTADO, CIDADE, BAIRRO) 

CREATE TABLE PAIS (

    id_pais INTEGER PRIMARY KEY,

    nome_pais VARCHAR2(30)

);
 
CREATE TABLE ESTADO (

    id_estado INTEGER PRIMARY KEY,

    nome_estado VARCHAR2(50),

    id_pais NUMBER

);

ALTER TABLE ESTADO

    ADD CONSTRAINT fk_PAIS FOREIGN KEY (id_pais)

    REFERENCES PAIS (id_pais);
 
CREATE TABLE CIDADE (

    id_cidade NUMBER PRIMARY KEY,

    nome_cidade VARCHAR(100),

    id_estado NUMBER

);

ALTER TABLE CIDADE

    ADD CONSTRAINT fk_ESTADO FOREIGN KEY (id_estado)

    REFERENCES ESTADO (id_estado);
 
CREATE TABLE BAIRRO (

    id_bairro NUMBER PRIMARY KEY,

    nome_bairro VARCHAR(30),

    id_cidade NUMBER

);

ALTER TABLE BAIRRO

    ADD CONSTRAINT fk_CIDADE FOREIGN KEY (id_cidade)

    REFERENCES CIDADE (id_cidade);
 
CREATE TABLE END_CLIENTE (

    id_endereco NUMBER PRIMARY KEY,

    cep NUMBER,

    logradouro VARCHAR2(50),

    numero NUMBER,

    complemento VARCHAR2(50),

    id_bairro NUMBER

);

ALTER TABLE END_CLIENTE

    ADD CONSTRAINT fk_END_CLIENTE FOREIGN KEY (id_bairro)

    REFERENCES BAIRRO (id_bairro);

-- Caso precise dropar as tabelas (ordem inversa da criaÃ§Ã£o)

DROP TABLE END_CLIENTE;

DROP TABLE BAIRRO;

DROP TABLE CIDADE;

DROP TABLE ESTADO;

DROP TABLE PAIS;
 
 
----------------------------------------------------------------------------------------
 
 
-- INSERTS

-- Inserindo dados na tabela PAIS

INSERT INTO PAIS (id_pais, nome_pais) 

VALUES (1, 'Brasil');
 
INSERT INTO PAIS (id_pais, nome_pais) 

VALUES (2, 'Argentina');
 
INSERT INTO PAIS (id_pais, nome_pais) 

VALUES (3, 'Rússia');
 
-- Inserindo dados na tabela ESTADO

INSERT INTO ESTADO (id_estado, nome_estado, id_pais) 

VALUES (1, 'São Paulo', 1);
 
INSERT INTO ESTADO (id_estado, nome_estado, id_pais) 

VALUES (2, 'Buenos Aires', 2);
 
-- Inserindo dados na tabela CIDADE

INSERT INTO CIDADE (id_cidade, nome_cidade, id_estado) 

VALUES (1, 'São Paulo', 1);
 
INSERT INTO CIDADE (id_cidade, nome_cidade, id_estado) 

VALUES (2, 'La Plata', 2);
 
-- Inserindo dados na tabela BAIRRO

INSERT INTO BAIRRO (id_bairro, nome_bairro, id_cidade) 

VALUES (1, 'Centro', 1);
 
INSERT INTO BAIRRO (id_bairro, nome_bairro, id_cidade) 

VALUES (2, 'Villa Elisa', 2);
 
-- Inserindo dados na tabela END_CLIENTE

INSERT INTO END_CLIENTE (id_endereco, cep, logradouro, numero, complemento, id_bairro) 

VALUES (1, 12345678, 'Rua das Flores', 100, 'Apt 101', 1);
 
INSERT INTO END_CLIENTE (id_endereco, cep, logradouro, numero, complemento, id_bairro) 

VALUES (2, 23456789, 'Avenida Brasil', 200, 'Bloco B', 2);
 
 
----------------------------------------------------------------------------------------
 
 
-- JOINS

--INNER vai yrazer apenas os itens da tabela que deu match

SELECT 

    A.NOME_PAIS PAIS,

    COUNT (B.NOME_ESTADO) "QDE ESTADOS"

FROM 

        PAIS A 

    INNER JOIN ESTADO B ON ( a.id_pais = b.id_pais )

GROUP BY

    A.NOME_PAIS;

-- LEFT JOIN FAZ COM QUE TODOS OS ITENS VENHAM

SELECT 

    A.NOME_PAIS PAIS,

    COUNT (B.NOME_ESTADO) "QDE ESTADOS"

FROM 

        PAIS A 

    LEFT JOIN ESTADO B ON ( a.id_pais = b.id_pais )

GROUP BY

    A.NOME_PAIS;
 
-- Trazendo todos os paises e todos os estados com WHERE sem JOIN

SELECT 

    a.nom_pais   pais,

    COUNT (b.nom_estado)"QDE ESTADO"

FROM

    pf1788.pais   a,

    pf1788.estado b

where

    a.cod_pais = b.cod_pais(+)

GROUP BY

    a.nom_pais;
 
-- Ordenando as tabelas com ASC e DESC

SELECT 

    A.NOME_PAIS PAIS,

    COUNT (B.NOME_ESTADO) "QDE ESTADOS"

FROM 

        PAIS A 

    LEFT JOIN ESTADO B ON ( a.id_pais = b.id_pais )

GROUP BY

    A.NOME_PAIS

ORDER BY 2 DESC; -- Pode colocar ASC ou DESC
 
-- Usando o HAVING que funciona como um WHERE para que esteja entre 1 e 5

SELECT 

    A.NOME_PAIS PAIS,

    COUNT (B.NOME_ESTADO) "QDE ESTADOS"

FROM 

        PAIS A 

    LEFT JOIN ESTADO B ON ( a.id_pais = b.id_pais )

GROUP BY

    A.NOME_PAIS

HAVING COUNT (b.nome_estado) BETWEEN 1 AND 5

ORDER BY 2 DESC;
 
-- Usando HAVING para trazer estados menores que 5

SELECT 

    A.NOME_PAIS PAIS,

    COUNT (B.NOME_ESTADO) "QDE ESTADOS"

FROM 

        PAIS A 

    LEFT JOIN ESTADO B ON ( a.id_pais = b.id_pais )

GROUP BY

    A.NOME_PAIS

HAVING COUNT (b.nome_estado) > 5

ORDER BY 2 DESC;

select 
    a.nom_pais    pais,
    b.nom_estado estado,
    count(c.nom_cidade)"qdt cidades"
    From
        pf1788.pais a
    join pf1788.estado b ON (a.cod_pais = b.cod_pais)
    left join pf1788.cidade c on (b.cod_estado = c.cod_estado)
group  by 
    a.nom_pais,
        b.nom_estado
order by 3 desc,1,2
 