-- Active: 1730416021412@@127.0.0.1@5432@trabalho@farmacia
-- Listar todos os produtos
SELECT * FROM produto;

-- Listar todas as categorias
SELECT * FROM categoria;

-- Listar todos os fornecedores
SELECT * FROM fornecedor;

-- Listar todas as lojas
SELECT * FROM loja;

-- Listar todo o estoque
SELECT * FROM estoque;

-- Listar todos os clientes
SELECT * FROM cliente;

-- Listar todos os funcionários
SELECT * FROM funcionario;

-- Listar todas as vendas
SELECT * FROM venda;

-- Listar todos os itens de vendas
SELECT * FROM itens_venda;

-- Listar todas as receitas
SELECT * FROM receita;

-- Listar todos os itens de receitas
SELECT * FROM itens_receita;

-- Listar todas as compras
SELECT * FROM compra;

-- Média de preços dos produtos por categoria
SELECT c.nome_categoria, AVG(p.preco) AS media_preco
FROM produto p
    INNER JOIN categoria c ON p.id_categoria = c.id_categoria
GROUP BY
    c.nome_categoria;

-- valor produto mais caro por categoria
SELECT c.nome_categoria, MAX(p.preco) AS preco_maximo
FROM produto p
    INNER JOIN categoria c ON p.id_categoria = c.id_categoria
GROUP BY
    c.nome_categoria;

-- produto mais barato por categoria
SELECT c.nome_categoria, MIN(p.preco) AS preco_minimo
FROM produto p
    INNER JOIN categoria c ON p.id_categoria = c.id_categoria
GROUP BY
    c.nome_categoria;

-- Quantidade de produtos por categoria
SELECT c.nome_categoria, COUNT(p.id_produto) AS quantidade_produtos
FROM produto p
    INNER JOIN categoria c ON p.id_categoria = c.id_categoria
GROUP BY
    c.nome_categoria;

-- Quantidade de vendas por categoria
SELECT c.nome_categoria, COUNT(v.id_venda) AS quantidade_vendas
FROM
    venda v
    INNER JOIN itens_venda iv ON v.id_venda = iv.id_venda
    INNER JOIN produto p ON iv.id_produto = p.id_produto
    INNER JOIN categoria c ON p.id_categoria = c.id_categoria
GROUP BY
    c.nome_categoria;


-- Quantidade de vendas por loja
SELECT l.nome_loja, COUNT(v.id_venda) AS quantidade_vendas
FROM venda v
    INNER JOIN loja l ON v.id_loja = l.id_loja
GROUP BY
    l.nome_loja;

-- loja com maior quantidade de estoque
SELECT l.nome_loja, MAX(e.quantidade_disponivel) AS maior_estoque
FROM estoque e
    INNER JOIN loja l ON e.id_loja = l.id_loja
GROUP BY
    l.nome_loja;

-- Soma do valor total de vendas por cliente
SELECT cli.nome_cliente, SUM(v.valor_total) AS total_gasto
FROM venda v
    INNER JOIN cliente cli ON v.id_cliente = cli.id_cliente
GROUP BY
    cli.nome_cliente;

-- Media de vendas por cliente
SELECT cli.nome_cliente, AVG(v.valor_total) AS media_vendas
FROM venda v
    INNER JOIN cliente cli ON v.id_cliente = cli.id_cliente
GROUP BY
    cli.nome_cliente;

-- Maximo de vendas por cliente
SELECT cli.nome_cliente, MAX(v.valor_total) AS max_vendas
FROM venda v
    INNER JOIN cliente cli ON v.id_cliente = cli.id_cliente
GROUP BY
    cli.nome_cliente;

-- Minimo de vendas por cliente
SELECT cli.nome_cliente, MIN(v.valor_total) AS min_vendas
FROM venda v
    INNER JOIN cliente cli ON v.id_cliente = cli.id_cliente
GROUP BY
    cli.nome_cliente;

-- Quantidade de vendas por meio de pagamento
SELECT mp.descricao, COUNT(v.id_venda) AS quantidade_vendas
FROM venda v
    INNER JOIN meio_pagamento mp ON v.id_meio_pagamento = mp.id_meio_pagamento
GROUP BY
    mp.descricao;

-- Quantidade de vendas por meio de envio
SELECT me.descricao, COUNT(v.id_venda) AS quantidade_vendas
FROM venda v
    INNER JOIN meio_envio me ON v.id_meio_envio = me.id_meio_envio
GROUP BY
    me.descricao;

-- vendas com valor acima da média
SELECT v.id_venda, v.valor_total
FROM venda v
WHERE
    v.valor_total > (
        SELECT AVG(valor_total)
        FROM venda
    );


-- produtos sem estoque
SELECT p.nome, e.quantidade_disponivel
FROM produto p
    LEFT JOIN estoque e ON p.id_produto = e.id_produto
WHERE
    e.quantidade_disponivel IS NULL
    OR e.quantidade_disponivel = 0;


-- top 5 produtos mais vendidos
SELECT p.nome, SUM(iv.quantidade) AS quantidade_total
FROM itens_venda iv
    INNER JOIN produto p ON iv.id_produto = p.id_produto
GROUP BY
    p.nome
ORDER BY quantidade_total DESC
LIMIT 5;

-- top 5 produtos menos vendidos
SELECT p.nome, SUM(iv.quantidade) AS quantidade_total
FROM itens_venda iv
    INNER JOIN produto p ON iv.id_produto = p.id_produto
GROUP BY
    p.nome
ORDER BY quantidade_total ASC
LIMIT 10;

-- top 5 lojas com mais vendas
SELECT l.nome_loja, COUNT(v.id_venda) AS quantidade_vendas
FROM loja l
    INNER JOIN venda v ON l.id_loja = v.id_loja
GROUP BY
    l.nome_loja
ORDER BY quantidade_vendas DESC
LIMIT 5;

-- top 5 lojas com menos vendas
SELECT l.nome_loja, COUNT(v.id_venda) AS quantidade_vendas
FROM loja l
    INNER JOIN venda v ON l.id_loja = v.id_loja
GROUP BY
    l.nome_loja
ORDER BY quantidade_vendas ASC
LIMIT 5;

-- top 5 Salários mais altos
SELECT f.nome_funcionario, f.cargo, f.salario, l.nome_loja
FROM farmacia.funcionario f
    JOIN farmacia.loja l ON f.id_loja = l.id_loja
ORDER BY f.salario DESC
LIMIT 5;

-- top 5 Salários mais baixos
SELECT f.nome_funcionario, f.cargo, f.salario, l.nome_loja
FROM farmacia.funcionario f
    JOIN farmacia.loja l ON f.id_loja = l.id_loja
ORDER BY f.salario ASC
LIMIT 5;

-- lista de funcionarios
SELECT f.cargo, l.nome_loja, COUNT(f.id_funcionario) AS quantidade_funcionarios
FROM farmacia.funcionario f
    INNER JOIN farmacia.loja l ON f.id_loja = l.id_loja
GROUP BY
    f.cargo,
    l.nome_loja
ORDER BY f.cargo, quantidade_funcionarios DESC
LIMIT 120