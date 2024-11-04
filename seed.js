const { faker } = require("@faker-js/faker");
const { Client } = require("pg");
require("dotenv").config();

const client = new Client({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT),
  ssl: { rejectUnauthorized: false },
});

async function insertclientes() {
  let clientesInseridos = 0;
  let numClientes = 5000;

  for (let i = 1; i <= numClientes; i++) {
    let nome,
      cpf,
      telefone,
      email,
      endereco,
      pontos_totais,
      data_nascimento,
      genero,
      estado_civil;
    let cpfExistente, emailExistente;

    do {
      nome = faker.person.fullName();
      cpf = faker.helpers.replaceSymbols("###.###.###-##");
      telefone = faker.helpers.replaceSymbols("(11)9-####-####");
      email = faker.internet.email();
      endereco = faker.location.streetAddress({ fullAddress: true });
      pontos_totais = faker.number.int({ min: 10, max: 5000 });
      data_nascimento = faker.date.past({ years: 80, refDate: "2005-01-01" });
      genero = faker.helpers.arrayElement(["Masculino", "Feminino"]);
      estado_civil = faker.helpers.arrayElement([
        "Solteiro",
        "Casado",
        "Divorciado",
        "Viúvo",
      ]);

      cpfExistente = await client.query(
        'SELECT 1 FROM "farmacia"."cliente" WHERE "CPF" = $1 LIMIT 1',
        [cpf]
      );
      emailExistente = await client.query(
        'SELECT 1 FROM "farmacia"."cliente" WHERE "email" = $1 LIMIT 1',
        [email]
      );
    } while (cpfExistente.rows.length > 0 || emailExistente.rows.length > 0);

    await client.query(
      'INSERT INTO "farmacia"."cliente" ("nome_cliente", "CPF", "data_nascimento", "genero", "estado_civil", "telefone", "email", "endereco", "pontos_totais") VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)',
      [
        nome,
        cpf,
        data_nascimento,
        genero,
        estado_civil,
        telefone,
        email,
        endereco,
        pontos_totais,
      ]
    );

    clientesInseridos++;
    console.log(
      `cliente ${clientesInseridos}/${numClientes} inserido com sucesso.`
    );
  }

  console.log("Todos os clientes foram inseridos com sucesso!");
}

async function insertfuncionarios() {
  const lojasResult = await client.query(
    'SELECT "id_loja", "nome_loja" FROM "farmacia"."loja"'
  );
  const lojas = lojasResult.rows;

  for (const loja of lojas) {
    const id_loja = loja.id_loja;
    const nome_loja = loja.nome_loja;

    const cargosPermitidos = {
      Gerente: { min: 1, max: 50, count: 0 },
      Atendente: { min: 1, max: 4, count: 0 },
      Caixa: { min: 1, max: 3, count: 0 },
      Farmacêutico: { min: 1, max: 2, count: 0 },
      Estoquista: { min: 1, max: 3, count: 0 },
      Entregador: { min: 1, max: 2, count: 0 },
    };

    const salarioBase = 1450 + Math.floor(Math.random() * 250);
    let totalfuncionarios = 0;

    while (totalfuncionarios < 10) {
      const nome = faker.person.fullName();
      const genero = faker.helpers.arrayElement(["Masculino", "Feminino"]);
      const data_nascimento = faker.date.past({
        years: 65,
        refDate: "2007-01-01",
      });
      const data_admissao = faker.date.past({
        years: 15,
        refDate: "2024-09-01",
      });

      const cargosDisponiveis = Object.keys(cargosPermitidos).filter(
        (cargo) => cargosPermitidos[cargo].count < cargosPermitidos[cargo].max
      );
      const cargo = faker.helpers.arrayElement(cargosDisponiveis);
      cargosPermitidos[cargo].count++;
      totalfuncionarios++;

      let salario;
      if (cargo === "Gerente") {
        salario = salarioBase * 3;
      } else if (cargo === "Atendente") {
        salario = salarioBase * 1.5;
      } else if (cargo === "Caixa") {
        salario = salarioBase * 2.1;
      } else if (cargo === "Farmacêutico") {
        salario = salarioBase * 2.6;
      } else if (cargo === "Estoquista") {
        salario = salarioBase * 1.3;
      } else if (cargo === "Entregador") {
        salario = salarioBase;
      }

      await client.query(
        'INSERT INTO "farmacia"."funcionario" ("nome_funcionario", "genero", "data_nascimento", "cargo", "salario", "data_admissao", "id_loja") VALUES ($1, $2, $3, $4, $5, $6, $7)',
        [nome, genero, data_nascimento, cargo, salario, data_admissao, id_loja]
      );

      if (Object.values(cargosPermitidos).every((c) => c.count >= c.min)) {
        break;
      }
    }
    console.log(
      `Quadro de funcionários inseridos com sucesso na loja ${nome_loja}`
    );
  }
}

async function insertprodutos() {
  const categoriasResult = await client.query(
    'SELECT "id_categoria", "nome_categoria" FROM "farmacia"."categoria"'
  );
  const categorias = categoriasResult.rows;

  const prescricionais = [
    "Acetilmetadol",
    "Alfacetilmetadol",
    "Alfameprodina",
    "Alfametadol",
    "Alfaprodina",
    "Alfentanila",
    "Alilprodina",
    "Anileridina",
    "Bezitramida",
    "Benzetidina",
    "Benzilmorfina",
    "Betacetilmetadol",
    "Betameprodina",
    "Betametadol",
    "Betaprodina",
    "Buprenorfina",
    "Butorfanol",
    "Clonitazeno",
    "Codoxima",
    "Dextromoramida",
    "Diampromida",
    "Dietiltiambuteno",
    "Difenoxilato",
    "Difenoxina",
    "Diidromorfina",
    "Dimefeptanol",
    "Dimenoxadol",
    "Dimetiltiambuteno",
    "Dioxafetila",
    "Dipipanona",
    "Drotebanol",
    "Etilmetiltiambuteno",
    "Etonitazeno",
    "Etoxeridina",
    "Fenadoxona",
    "Fenampromida",
    "Fenazocina",
    "Fenomorfano",
    "Fenoperidina",
    "Fentanila",
    "Furetidina",
    "Hidrocodona",
    "Hidromorfinol",
    "Hidromorfona",
    "Hidroxipetidina",
    "Isometadona",
    "Levofenacilmorfano",
    "Levometorfano",
    "Levomoramida",
    "Levorfanol",
    "Metadona",
    "Metazocina",
    "Metildesorfina",
    "Metildiidromorfina",
    "Metopona",
    "Mirofina",
    "Morferidina",
    "Morfina",
    "Morinamida",
    "Nicomorfina",
    "Noracimetadol",
    "Norlevorfanol",
    "Normetadona",
    "Normorfina",
    "Norpipanona",
    "Ópio",
    "Oripavina",
    "Oxicodona",
    "Oximorfona",
    "Petidina",
    "Piminodina",
    "Piritramida",
    "Proeptazina",
    "Properidina",
    "Racemetorfano",
    "Racemoramida",
    "Racemorfano",
    "Remifentanila",
    "Sufentanila",
    "Tapentadol",
    "Tebacona",
    "Tebaína",
    "Tilidina",
    "Trimeperidina",
  ];
  const nomesMedicamentos = [
    "Paracetamol",
    "Ibuprofeno",
    "Aspirina",
    "Amoxicilina",
    "Diclofenaco",
    "Loratadina",
    "Omeprazol",
    "Ranitidina",
    "Dipirona",
    "Simeticona",
    "Captopril",
    "Losartana",
    "Enalapril",
    "Metformina",
    "Glibenclamida",
    "Alprazolam",
    "Diazepam",
    "Clonazepam",
    "Prednisona",
    "Hidroclorotiazida",
    "Fluconazol",
    "Azitromicina",
    "Cefalexina",
    "Doxiciclina",
    "Cetoconazol",
    "Amitriptilina",
    "Propranolol",
    "Benzilpenicilina",
    "Furosemida",
    "Cloridrato de Sertralina",
  ];
  const nomesSuplementos = [
    "Vitamina C",
    "Vitamina D",
    "Ômega 3",
    "Multivitamínico",
    "Cálcio + Vitamina D",
    "Magnésio",
    "Zinco",
    "Complexo B",
    "Creatina",
    "Whey Protein",
    "Colágeno",
    "Probioticos",
    "Biotina",
    "Melatonina",
    "Glutamina",
  ];
  const nomesHigiene = [
    "Sabonete Líquido",
    "Shampoo Anticaspa",
    "Condicionador",
    "Desodorante",
    "Enxaguante Bucal",
    "Creme Dental",
    "Escova de Dentes",
    "Fio Dental",
    "Sabonete Íntimo",
    "Gel Antisséptico",
    "Cotonetes",
    "Papel Higiênico",
    "Absorventes",
    "Lenços Umedecidos",
    "Protetor Solar",
  ];
  const nomesCosmeticos = [
    "Creme Hidratante",
    "Protetor Solar Facial",
    "Base de Maquiagem",
    "Batom",
    "Máscara para Cílios",
    "Sombra de Olhos",
    "Perfume",
    "Óleo Capilar",
    "Esmalte de Unhas",
    "Sérum Facial",
    "Tônico Facial",
    "Água Micelar",
    "Demaquilante",
    "Loção Corporal",
    "Shampoo Seco",
  ];

  const categoriasComDosagem = [
    "Medicamentos Prescricionais",
    "Medicamentos Não Prescricionais",
    "Suplementos Nutricionais",
  ];
  const dosagens = ["500mg", "1g", "250mg", "10mg", "50mg", "100mg", "750mg"];

  const values = [];
  for (let i = 0; i < 200; i++) {
    const categoriaEscolhida = faker.helpers.arrayElement(categorias);
    let nome;

    switch (categoriaEscolhida.nome_categoria) {
      case "Medicamentos Prescricionais":
        nome = faker.helpers.arrayElement(prescricionais);
        break;
      case "Medicamentos Não Prescricionais":
        nome = faker.helpers.arrayElement(nomesMedicamentos);
        break;
      case "Suplementos Nutricionais":
        nome = faker.helpers.arrayElement(nomesSuplementos);
        break;
      case "Higiene Pessoal e Saúde":
        nome = faker.helpers.arrayElement(nomesHigiene);
        break;
      case "Cosméticos e Cuidados com a Pele":
        nome = faker.helpers.arrayElement(nomesCosmeticos);
        break;
      default:
        nome = "produto Genérico";
    }

    const preco = parseFloat((Math.random() * (50 - 5) + 5).toFixed(2));
    const data_validade = faker.date.future(3);
    const imagem = `https:
      .toLowerCase()
      .replace(/ /g, "_")}.jpg`;
    const id_categoria = categoriaEscolhida.id_categoria;

    const getDosagemInMg = (dosagem) => {
      if (dosagem.includes("mg")) {
        return parseFloat(dosagem);
      } else if (dosagem.includes("g")) {
        return parseFloat(dosagem) * 1000;
      }
      return 1;
    };

    if (categoriasComDosagem.includes(categoriaEscolhida.nome_categoria)) {
      dosagens.forEach((dosagem) => {
        const fator = getDosagemInMg(dosagem);
        const precoBase = Math.random() * (30 - 5) + 5;
        const preco = parseFloat((precoBase * (fator / 250)).toFixed(2));

        values.push([
          nome,
          preco,
          data_validade,
          dosagem,
          imagem,
          id_categoria,
        ]);
      });
    } else {
      const preco = parseFloat((Math.random() * (50 - 5) + 5).toFixed(2));
      values.push([nome, preco, data_validade, null, imagem, id_categoria]);
    }
    console.log(`Produto ${nome} inserido com sucesso!`);
  }

  const insertQuery = `
    INSERT INTO "farmacia"."produto" 
    ("nome", "preco", "data_validade", "dosagem", "imagem", "id_categoria") 
    VALUES ${values
      .map(
        (_, idx) =>
          `($${idx * 6 + 1}, $${idx * 6 + 2}, $${idx * 6 + 3}, $${
            idx * 6 + 4
          }, $${idx * 6 + 5}, $${idx * 6 + 6})`
      )
      .join(", ")}
  `;

  const params = values.flat();
  await client.query(insertQuery, params);

  console.log(`produtos inseridos com sucesso!`);
}

async function insertcompras() {
  const fornecedoresResult = await client.query(
    'SELECT "id_fornecedor","nome_fornecedor" FROM "farmacia"."fornecedor"'
  );
  const fornecedores = fornecedoresResult.rows;

  const lojasResult = await client.query(
    'SELECT "id_loja", "nome_loja" FROM "farmacia"."loja"'
  );
  const lojas = lojasResult.rows;

  for (const loja of lojas) {
    const id_loja = loja.id_loja;
    const nome_loja = loja.nome_loja;

    for (const fornecedor of fornecedores) {
      const id_fornecedor = fornecedor.id_fornecedor;
      const nome_fornecedor = fornecedor.nome_fornecedor;

      const numCompras = faker.number.int({ min: 1, max: 3 });

      for (let i = 0; i < numCompras; i++) {
        const data_compra = faker.date.recent();
        const valor_total = parseFloat(faker.commerce.price());

        const data_entrega = new Date(data_compra);
        data_entrega.setDate(
          data_entrega.getDate() + faker.number.int({ min: 2, max: 5 })
        );

        const result = await client.query(
          'INSERT INTO "farmacia"."compra" ("data_compra", "valor_total", "id_loja", "data_entrega", "id_fornecedor") VALUES ($1, $2, $3, $4, $5) RETURNING "id_compra"',
          [data_compra, valor_total, id_loja, data_entrega, id_fornecedor]
        );

        const id_compra = result.rows[0].id_compra;

        for (let k = 0; k < faker.number.int({ min: 1, max: 10 }); k++) {
          const produtoResult = await client.query(
            'SELECT "id_produto", "nome" FROM "farmacia"."produto" OFFSET $1 LIMIT 1',
            [faker.number.int({ min: 0, max: 199 })]
          );

          const id_produto = produtoResult.rows[0].id_produto;
          const nome_produto = produtoResult.rows[0].nome;
          const quantidade = faker.number.int({ min: 1, max: 50 });
          const preco_unitario = parseFloat(faker.commerce.price());

          await client.query(
            'INSERT INTO "farmacia"."Itens_compra" ("id_compra", "id_produto", "quantidade_comprada", "preco_unitario") VALUES ($1, $2, $3, $4)',
            [id_compra, id_produto, quantidade, preco_unitario]
          );

          const estoqueResult = await client.query(
            'SELECT "quantidade_disponivel" FROM "farmacia"."estoque" WHERE "id_produto" = $1 AND "id_loja" = $2',
            [id_produto, id_loja]
          );

          if (estoqueResult.rows.length > 0) {
            await client.query(
              'UPDATE "farmacia"."estoque" SET "quantidade_disponivel" = "quantidade_disponivel" + $1 WHERE "id_produto" = $2 AND "id_loja" = $3',
              [quantidade, id_produto, id_loja]
            );
          } else {
            await client.query(
              'INSERT INTO "farmacia"."estoque" ("id_produto", "id_loja", "quantidade_disponivel") VALUES ($1, $2, $3)',
              [id_produto, id_loja, quantidade]
            );
          }

          console.log(`Comprou ${quantidade} ${nome_produto}`);
        }
        console.log(
          `Compra de valor ${valor_total.toFixed(
            2
          )} da loja ${nome_loja} no fornecedor ${nome_fornecedor}`
        );
      }
    }
  }

  console.log("Compras inseridas e estoque atualizado com sucesso!");
}

async function insertvendas() {
  const clientesResult = await client.query(
    'SELECT "id_cliente", "nome_cliente" FROM "farmacia"."cliente"'
  );
  const clientes = clientesResult.rows;

  for (const cliente of clientes) {
    const id_cliente = cliente.id_cliente;
    const nome_cliente = cliente.nome_cliente;
    const numvendas = faker.number.int({ min: 1, max: 10 });

    for (let j = 0; j < numvendas; j++) {
      const lojaResult = await client.query(
        'SELECT "id_loja" FROM "farmacia"."loja" ORDER BY RANDOM() LIMIT 1'
      );
      if (lojaResult.rows.length === 0) continue;

      const id_loja = lojaResult.rows[0].id_loja;
      const meio_pagamentoResult = await client.query(
        'SELECT "id_meio_pagamento" FROM "farmacia"."meio_pagamento" ORDER BY RANDOM() LIMIT 1'
      );
      if (meio_pagamentoResult.rows.length === 0)
        throw new Error("Nenhum meio de pagamento encontrado.");

      const id_meio_pagamento = meio_pagamentoResult.rows[0].id_meio_pagamento;
      const meioEnvioResult = await client.query(
        'SELECT "id_meio_envio" FROM "farmacia"."meio_envio" ORDER BY RANDOM() LIMIT 1'
      );
      if (meioEnvioResult.rows.length === 0)
        throw new Error("Nenhum meio de envio encontrado.");

      const id_meio_envio = meioEnvioResult.rows[0].id_meio_envio;
      const data_venda = faker.date.recent();
      const valor_total = parseFloat(faker.commerce.price());

      const vendaResult = await client.query(
        'INSERT INTO "farmacia"."venda" ("data_venda", "valor_total", "id_cliente", "id_loja", "id_meio_pagamento", "id_meio_envio") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id_venda"',
        [
          data_venda,
          valor_total,
          id_cliente,
          id_loja,
          id_meio_pagamento,
          id_meio_envio,
        ]
      );
      const id_venda = vendaResult.rows[0].id_venda;
      await client.query(
        'UPDATE "farmacia"."cliente" SET "pontos_totais" = "pontos_totais" + $1 WHERE "id_cliente" = $2',
        [Math.floor(valor_total / 10), id_cliente]
      );

      const produtos = [];
      const numprodutos = faker.number.int({ min: 1, max: 10 });
      const itensReceitaMap = new Map();
      let receitaId;

      for (let k = 0; k < numprodutos; k++) {
        const produtoResult = await client.query(
          'SELECT "id_produto", "id_categoria" FROM "farmacia"."produto" OFFSET $1 LIMIT 1',
          [faker.number.int({ min: 0, max: 199 })]
        );

        const id_produto = produtoResult.rows[0].id_produto;
        const id_categoria = produtoResult.rows[0].id_categoria;
        const quantidade = faker.number.int({ min: 1, max: 10 });
        const preco_unitario = parseFloat(faker.commerce.price());
        produtos.push({ id_produto, quantidade, preco_unitario });

        if (await isPrescribedCategory(id_categoria)) {
          if (itensReceitaMap.has(id_produto)) {
            itensReceitaMap.set(
              id_produto,
              itensReceitaMap.get(id_produto) + quantidade
            );
          } else {
            itensReceitaMap.set(id_produto, quantidade);
            if (!receitaId) {
              receitaId = await generateReceita(id_cliente);
            }
          }
        }

        await client.query(
          'UPDATE "farmacia"."estoque" SET "quantidade_disponivel" = "quantidade_disponivel" - $1 WHERE "id_produto" = $2 AND "id_loja" = $3',
          [quantidade, id_produto, id_loja]
        );
      }

      console.log(
        `Venda do Cliente ${nome_cliente} no valor de R$${valor_total} realizada com sucesso!`
      );

      const itensvendaPromises = produtos.map(
        async ({ id_produto, quantidade, preco_unitario }) => {
          await client.query(
            'INSERT INTO "farmacia"."itens_venda" ("id_venda", "id_produto", "quantidade", "preco_unitario") VALUES ($1, $2, $3, $4)',
            [id_venda, id_produto, quantidade, preco_unitario]
          );
        }
      );

      const itensReceitaPromises = [];
      for (const [id_produto, quantidade] of itensReceitaMap.entries()) {
        const existingItemResult = await client.query(
          'SELECT 1 FROM "farmacia"."itens_receita" WHERE "id_receita" = $1 AND "id_produto" = $2',
          [receitaId, id_produto]
        );

        if (existingItemResult.rows.length === 0) {
          itensReceitaPromises.push(
            client.query(
              'INSERT INTO "farmacia"."itens_receita" ("id_receita", "id_produto", "quantidade_prescrita") VALUES ($1, $2, $3)',
              [receitaId, id_produto, quantidade]
            )
          );
        } else {
          console.log(
            `Item com id_produto ${id_produto} já existe na receita ${receitaId}.`
          );
        }
      }

      await Promise.all(itensvendaPromises);
      await Promise.all(itensReceitaPromises);
    }
  }

  console.log("Vendas e receitas inseridas com sucesso!");
}

async function isPrescribedCategory(id_categoria) {
  const categoriaResult = await client.query(
    'SELECT "nome_categoria" FROM "farmacia"."categoria" WHERE "id_categoria" = $1',
    [id_categoria]
  );
  return (
    categoriaResult.rows[0]?.nome_categoria === "Medicamentos Prescricionais"
  );
}

async function generateReceita(id_cliente) {
  const nome_medico = faker.person.fullName();
  const CRM_medico = faker.helpers.replaceSymbols("CRM-##.###");
  const data_emissao = faker.date.past({ years: 1, refDate: "2024-09-01" });
  const validade_receita = faker.date.future();

  const receitaResult = await client.query(
    'INSERT INTO "farmacia"."receita" ("id_cliente", "nome_medico", "CRM_medico", "data_emissao", "validade_receita") VALUES ($1, $2, $3, $4, $5) RETURNING "id_receita"',
    [id_cliente, nome_medico, CRM_medico, data_emissao, validade_receita]
  );

  console.log(
    "Venda com medicamento Prescricional, Receita inserida com sucesso!"
  );

  return receitaResult.rows[0].id_receita;
}

async function main() {
  await client.connect();
  await client.query("SET search_path TO farmacia");
  console.log("Conectado ao PostgreSQL!");

  await insertclientes();
  await insertfuncionarios();
  await insertprodutos();
  await insertcompras();
  await insertvendas();

  await client.end();
}

main().catch((err) => console.error("Erro ao inserir dados:", err));
