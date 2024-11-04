-- Active: 1730416021412@@127.0.0.1@5432@grupo_laranja

-- Criação do Banco de Dados
-- Execute este comando separadamente no terminal ou ferramenta de administração
--CREATE DATABASE "grupo_laranja";

-- Conecte-se ao banco de dados "grupo_laranja" antes de executar os comandos abaixo.

-- Criação do esquema
 CREATE SCHEMA IF NOT EXISTS "farmacia";

-- Criação da extensão para gerar UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tabela categoria
CREATE TABLE IF NOT EXISTS "farmacia"."categoria" (
    "id_categoria" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "nome_categoria" VARCHAR(100) NOT NULL,
    "descricao_categoria" TEXT,
    "pontos_categoria" INT DEFAULT 0
);

-- Tabela produto
CREATE TABLE IF NOT EXISTS "farmacia"."produto" (
    "id_produto" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "nome" VARCHAR(100) NOT NULL,
    "preco" DECIMAL(10, 2) NOT NULL,
    "data_validade" DATE,
    "dosagem" VARCHAR(50),
    "imagem" VARCHAR(255) NOT NULL,
    "id_fabricante" UUID,
    "id_categoria" UUID NOT NULL,
    "pontos_produto" INT DEFAULT 0,
    CONSTRAINT "fk_produto_categoria" FOREIGN KEY ("id_categoria") REFERENCES "farmacia"."categoria" ("id_categoria")
);

-- Tabela fornecedor
CREATE TABLE IF NOT EXISTS "farmacia"."fornecedor" (
    "id_fornecedor" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "nome_fornecedor" VARCHAR(100) NOT NULL,
    "vendedor" VARCHAR(100),
    "email" VARCHAR(100) UNIQUE,
    "telefone" VARCHAR(50),
    "endereco" VARCHAR(255)
);

-- Tabela loja
CREATE TABLE IF NOT EXISTS "farmacia"."loja" (
    "id_loja" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "nome_loja" VARCHAR(100) NOT NULL,
    "email" VARCHAR(100) UNIQUE,
    "endereco" VARCHAR(255),
    "telefone" VARCHAR(20)
);

-- Tabela estoque
CREATE TABLE IF NOT EXISTS "farmacia"."estoque" (
    "id_estoque" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "id_produto" UUID NOT NULL,
    "id_loja" UUID NOT NULL,
    "quantidade_disponivel" INT NOT NULL,
    CONSTRAINT "fk_estoque_produto" FOREIGN KEY ("id_produto") REFERENCES "farmacia"."produto" ("id_produto"),
    CONSTRAINT "fk_estoque_loja" FOREIGN KEY ("id_loja") REFERENCES "farmacia"."loja" ("id_loja")
);

-- Tabela cliente
CREATE TABLE IF NOT EXISTS "farmacia"."cliente" (
    "id_cliente" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "nome_cliente" VARCHAR(100) NOT NULL,
    "CPF" VARCHAR(14) UNIQUE,
    "data_nascimento" DATE,
    "genero" VARCHAR(20),
    "estado_civil" VARCHAR(20),
    "telefone" VARCHAR(20),
    "email" VARCHAR(100) UNIQUE,
    "endereco" VARCHAR(255),
    "pontos_totais" INT DEFAULT 0
);

-- Tabela funcionario
CREATE TABLE IF NOT EXISTS "farmacia"."funcionario" (
    "id_funcionario" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "nome_funcionario" VARCHAR(100) NOT NULL,
    "genero" VARCHAR(20),
    "data_nascimento" DATE,
    "cargo" VARCHAR(50),
    "salario" DECIMAL(10, 2) NOT NULL,
    "data_admissao" DATE NOT NULL,
    "id_loja" UUID NOT NULL,
    CONSTRAINT "fk_funcionario_loja" FOREIGN KEY ("id_loja") REFERENCES "farmacia"."loja" ("id_loja")
);

-- Tabela Meio de Pagamento
CREATE TABLE IF NOT EXISTS "farmacia"."meio_pagamento" (
    "id_meio_pagamento" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "descricao" VARCHAR(50) NOT NULL
);

-- Tabela Meio de Envio
CREATE TABLE IF NOT EXISTS "farmacia"."meio_envio" (
    "id_meio_envio" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "descricao" VARCHAR(50) NOT NULL
);

-- Tabela venda
CREATE TABLE IF NOT EXISTS "farmacia"."venda" (
    "id_venda" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "data_venda" DATE NOT NULL,
    "id_cliente" UUID NOT NULL,
    "id_loja" UUID NOT NULL,
    "valor_total" DECIMAL(10, 2) NOT NULL,
    "id_meio_pagamento" UUID NOT NULL,
    "id_meio_envio" UUID NOT NULL,
    "pontos_venda" INT DEFAULT 0,
    CONSTRAINT "fk_venda_cliente" FOREIGN KEY ("id_cliente") REFERENCES "farmacia"."cliente" ("id_cliente"),
    CONSTRAINT "fk_venda_loja" FOREIGN KEY ("id_loja") REFERENCES "farmacia"."loja" ("id_loja"),
    CONSTRAINT "fk_venda_meio_pagamento" FOREIGN KEY ("id_meio_pagamento") REFERENCES "farmacia"."meio_pagamento" ("id_meio_pagamento"),
    CONSTRAINT "fk_venda_meio_envio" FOREIGN KEY ("id_meio_envio") REFERENCES "farmacia"."meio_envio" ("id_meio_envio")
);

-- Tabela itens_venda
CREATE TABLE IF NOT EXISTS "farmacia"."itens_venda" (
    "id_itens_venda" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "id_venda" UUID NOT NULL,
    "id_produto" UUID NOT NULL,
    "quantidade" INT NOT NULL,
    "preco_unitario" DECIMAL(10, 2) NOT NULL,
    CONSTRAINT "fk_itensvenda_venda" FOREIGN KEY ("id_venda") REFERENCES "farmacia"."venda" ("id_venda"),
    CONSTRAINT "fk_itensvenda_produto" FOREIGN KEY ("id_produto") REFERENCES "farmacia"."produto" ("id_produto")
);

-- Tabela receita
CREATE TABLE IF NOT EXISTS "farmacia"."receita" (
    "id_receita" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "id_cliente" UUID NOT NULL,
    "nome_medico" VARCHAR(100) NOT NULL,
    "CRM_medico" VARCHAR(20) NOT NULL,
    "data_emissao" DATE NOT NULL,
    "validade_receita" DATE,
    CONSTRAINT "fk_receita_cliente" FOREIGN KEY ("id_cliente") REFERENCES "farmacia"."cliente" ("id_cliente")
);

-- Tabela itens_receita
CREATE TABLE IF NOT EXISTS "farmacia"."itens_receita" (
    "id_itens_receita" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "id_receita" UUID NOT NULL,
    "id_produto" UUID NOT NULL,
    "quantidade_prescrita" INT NOT NULL,
    CONSTRAINT "fk_itensreceita_receita" FOREIGN KEY ("id_receita") REFERENCES "farmacia"."receita" ("id_receita"),
    CONSTRAINT "fk_itensreceita_produto" FOREIGN KEY ("id_produto") REFERENCES "farmacia"."produto" ("id_produto")
);

-- Tabela compra
CREATE TABLE IF NOT EXISTS "farmacia"."compra" (
    "id_compra" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "valor_total" DECIMAL(10, 2) NOT NULL,
    "data_compra" DATE NOT NULL,
    "data_entrega" DATE NOT NULL,
    "id_fornecedor" UUID NOT NULL,
    "id_loja" UUID NOT NULL,
    CONSTRAINT "fk_compra_fornecedor" FOREIGN KEY ("id_fornecedor") REFERENCES "farmacia"."fornecedor" ("id_fornecedor"),
    CONSTRAINT "fk_compra_loja" FOREIGN KEY ("id_loja") REFERENCES "farmacia"."loja" ("id_loja")
);

-- Tabela Itens_compra
CREATE TABLE IF NOT EXISTS "farmacia"."Itens_compra" (
    "id_compra_item" UUID PRIMARY KEY DEFAULT uuid_generate_v4 (),
    "id_compra" UUID NOT NULL,
    "id_produto" UUID NOT NULL,
    "quantidade_comprada" INT NOT NULL,
    "preco_unitario" DECIMAL(10, 2) NOT NULL,
    CONSTRAINT "fk_compra_item_compra" FOREIGN KEY ("id_compra") REFERENCES "farmacia"."compra" ("id_compra"),
    CONSTRAINT "fk_compra_item_produto" FOREIGN KEY ("id_produto") REFERENCES "farmacia"."produto" ("id_produto")
);