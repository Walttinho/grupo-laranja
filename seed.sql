-- Active: 1730416021412@@127.0.0.1@5432@grupo_laranja@farmacia
-- Dados iniciais para Meio de Pagamento
INSERT INTO
    "farmacia"."meio_pagamento" ("descricao")
VALUES ('Débito'),
    ('Crédito'),
    ('Dinheiro'),
    ('Pix'),
    ('Cheque');

-- Dados iniciais para Meio de Envio
INSERT INTO
    "farmacia"."meio_envio" ("descricao")
VALUES ('Retirada'),
    ('Motoboy');

-- Dados iniciais para categorias de Farmácias
INSERT INTO
    "farmacia"."categoria" (
        "nome_categoria",
        "descricao_categoria",
        "pontos_categoria"
    )
VALUES (
        'Medicamentos Prescricionais',
        'Farmácia especializada na venda de medicamentos que exigem prescrição médica, oferecendo uma ampla gama de tratamentos para condições crônicas e agudas, garantindo a saúde e o bem-estar dos pacientes.',
        100
    ),
    (
        'Medicamentos Não Prescricionais',
        'Estabelecimento dedicado à comercialização de medicamentos de venda livre, como analgésicos, antitérmicos e anti-inflamatórios, proporcionando alívio imediato para pequenas enfermidades e desconfortos.',
        80
    ),
    (
        'Suplementos Nutricionais',
        'Farmácia focada em uma vasta seleção de suplementos vitamínicos, minerais e outros produtos que promovem a saúde e o bem-estar, ajudando os clientes a alcançarem seus objetivos nutricionais e de saúde.',
        70
    ),
    (
        'Higiene Pessoal e Saúde',
        'Espaço que oferece uma variedade de produtos essenciais de higiene pessoal, incluindo sabonetes, desodorantes e cuidados dentais, promovendo a saúde e a higiene diária dos clientes.',
        60
    ),
    (
        'Cosméticos e Cuidados com a Pele',
        'Farmácia dedicada a cosméticos e produtos para cuidados com a pele e cabelo, oferecendo soluções para realçar a beleza e manter a saúde da pele, com opções para todos os tipos de pele.',
        50
    ),
    (
        'Perfumaria e Fragrâncias',
        'Estabelecimento que comercializa uma ampla gama de perfumes e fragrâncias, atendendo tanto a homens quanto a mulheres, com opções que variam de luxuosas a acessíveis, para todos os gostos.',
        40
    ),
    (
        'Acessórios de Saúde',
        'Farmácia que disponibiliza acessórios essenciais para a saúde, como termômetros, medidores de pressão arterial e equipamentos ortopédicos, contribuindo para o monitoramento e cuidado da saúde dos clientes.',
        30
    ),
    (
        'Outros produtos de Bem-Estar',
        'Espaço que oferece uma diversidade de produtos voltados ao bem-estar, incluindo itens para cuidados com os pés, ortopedia e primeiros socorros, promovendo uma vida saudável e ativa.',
        20
    );
-- Dados inicial para lojas
INSERT INTO
    "farmacia"."loja" (
        "nome_loja",
        "email",
        "telefone",
        "endereco"
    )
VALUES (
        'Filial São Paulo Jardim Paulista',
        'jardim@farmacia.com',
        '(11) 4564-4726',
        'Avenida Paulista, 456, São Paulo, SP'
    ),
    (
        'Filial São Paulo Vila Mariana',
        'vilamariana@farmacia.com',
        '(11) 4564-4727',
        'Rua Domingos de Morais, 789, São Paulo, SP'
    ),
    (
        'Filial São Paulo Moema',
        'moema@farmacia.com',
        '(11) 4564-4728',
        'Avenida Ibirapuera, 1000, São Paulo, SP'
    ),
    (
        'Filial São Paulo Pinheiros',
        'pinheiros@farmacia.com',
        '(11) 4564-4729',
        'Rua dos Três Irmãos, 300, São Paulo, SP'
    ),
    (
        'Filial São Paulo Itaim Bibi',
        'itaimbibi@farmacia.com',
        '(11) 4564-4730',
        'Rua Joaquim Floriano, 200, São Paulo, SP'
    ),
    (
        'Filial Santo Andre Centro',
        'santoandre@farmacia.com',
        '(11) 4564-4731',
        'Rua das Bandeiras, 150, Santo André, SP'
    ),
    (
        'Filial Osasco Centro',
        'osasco@farmacia.com',
        '(11) 4564-4732',
        'Avenida dos Autonomistas, 500, Osasco, SP'
    ),
    (
        'Filial São Bernardo Centro',
        'saobernardo@farmacia.com',
        '(11) 4564-4733',
        'Rua Marechal Deodoro, 400, São Bernardo do Campo, SP'
    ),
    (
        'Filial São Paulo Campo Limpo',
        'campolimpo@farmacia.com',
        '(11) 4564-4734',
        'Avenida Campo Limpo, 200, São Paulo, SP'
    ),
    (
        'Filial São Paulo Consolação',
        'consolacao@farmacia.com',
        '(11) 4564-4735',
        'Rua da Consolação, 600, São Paulo, SP'
    ),
    (
        'Filial Blumenau Centro',
        'centro@farmacia.com',
        '(47) 3333-1111',
        'Rua 7 de Setembro, 50, Blumenau, SC'
    ),
    (
        'Filial Blumenau Vila Formosa',
        'vilaf@farmacia.com',
        '(47) 3333-2222',
        'Rua José Ferreira, 120, Blumenau, SC'
    ),
    (
        'Filial Blumenau Garcia',
        'garcia@farmacia.com',
        '(47) 3333-3333',
        'Rua da Glória, 40, Blumenau, SC'
    ),
    (
        'Filial Blumenau Escola Agrícola',
        'escolag@farmacia.com',
        '(47) 3333-4444',
        'Rua São Paulo, 800, Blumenau, SC'
    ),
    (
        'Filial Blumenau Itoupava Norte',
        'itoupavanorte@farmacia.com',
        '(47) 3333-5555',
        'Rua Adolfo Konder, 1000, Blumenau, SC'
    ),
    (
        'Filial Blumenau Velha',
        'velha@farmacia.com',
        '(47) 3333-6666',
        'Rua Doutor Pedro Zimmermann, 1200, Blumenau, SC'
    ),
    (
        'Filial Blumenau Salto Weissbach',
        'salto@farmacia.com',
        '(47) 3333-7777',
        'Rua Santa Catarina, 250, Blumenau, SC'
    ),
    (
        'Filial Blumenau Ponta Aguda',
        'pontaaguda@farmacia.com',
        '(47) 3333-8888',
        'Rua Ponta Aguda, 900, Blumenau, SC'
    ),
    (
        'Filial Blumenau Badenfurt',
        'badenfurt@farmacia.com',
        '(47) 3333-9999',
        'Rua Waldemar W. D. Schmidt, 500, Blumenau, SC'
    ),
    (
        'Filial Blumenau Fortaleza',
        'fortaleza@farmacia.com',
        '(47) 3333-1010',
        'Rua Fortaleza, 300, Blumenau, SC'
    ),
    (
        'Filial Blumenau Progresso',
        'progresso@farmacia.com',
        '(47) 3333-2020',
        'Rua Progresso, 200, Blumenau, SC'
    );

-- Dados iniciais para fornecedores
INSERT INTO
    "farmacia"."fornecedor" (
        "nome_fornecedor",
        "vendedor",
        "email",
        "telefone",
        "endereco"
    )
VALUES (
        'Aché Laboratórios',
        'Ricardo Almeida',
        'contato@ache.com.br',
        '(11) 3322-1144',
        'Avenida Almirante Barroso, 1234, São Paulo, SP'
    ),
    (
        'Eurofarma',
        'Mariana Pinto',
        'vendas@eurofarma.com.br',
        '(11) 2233-4455',
        'Rua da Liberdade, 567, São Paulo, SP'
    ),
    (
        'Germed Pharma',
        'Thiago Costa',
        'suporte@germed.com.br',
        '(11) 5544-6677',
        'Avenida das Américas, 2345, São Paulo, SP'
    ),
    (
        'EMS Sigma Pharma',
        'Fernanda Lima',
        'vendas@ems.com.br',
        '(11) 9988-5566',
        'Rua dos Jacarandás, 678, São Paulo, SP'
    ),
    (
        'Hypera Pharma',
        'Bruno Martins',
        'info@hyperapharma.com.br',
        '(11) 7654-3210',
        'Avenida da Saúde, 4321, São Paulo, SP'
    ),
    (
        'Natulab',
        'Carla Rocha',
        'carla@natulab.com.br',
        '(11) 3322-6677',
        'Rua das Flores, 987, São Paulo, SP'
    ),
    (
        'União Química',
        'Eduardo Santos',
        'contato@uniaoquimica.com.br',
        '(11) 8899-1234',
        'Avenida do Comércio, 8765, São Paulo, SP'
    ),
    (
        'Biosintética',
        'Ana Beatriz',
        'ana@biosintetica.com.br',
        '(11) 5566-7788',
        'Rua do Progresso, 3456, São Paulo, SP'
    ),
    (
        'Bristol Myers Squibb',
        'Sofia Almeida',
        'sofia@bms.com.br',
        '(11) 3322-8899',
        'Avenida da Esperança, 234, São Paulo, SP'
    ),
    (
        'Laboratório Teuto',
        'Lucas Ferreira',
        'lucas@teuto.com.br',
        '(11) 4433-2211',
        'Rua da Independência, 876, São Paulo, SP'
    ),
    (
        'Cimed',
        'Juliana Freitas',
        'juliana@cimed.com.br',
        '(11) 5544-9988',
        'Avenida do Trabalho, 123, São Paulo, SP'
    ),
    (
        'Neo Química',
        'Gustavo Rocha',
        'gustavo@neoq.com.br',
        '(11) 3322-4567',
        'Rua do Limoeiro, 999, São Paulo, SP'
    ),
    (
        'Viva da Saúde',
        'Patrícia Sousa',
        'patricia@vivadasaude.com.br',
        '(11) 9988-1111',
        'Avenida das Palmeiras, 567, São Paulo, SP'
    ),
    (
        'MediFar',
        'Rafael Tavares',
        'rafael@medifar.com.br',
        '(11) 3344-5566',
        'Rua dos Girassóis, 321, São Paulo, SP'
    ),
    (
        'Pharma Quality',
        'Simone Nascimento',
        'simone@pharmaquality.com.br',
        '(11) 4455-6677',
        'Avenida do Futuro, 654, São Paulo, SP'
    ),
    (
        'Biofarm',
        'Bruno Sampaio',
        'bruno@biofarm.com.br',
        '(11) 2233-3344',
        'Rua das Acácias, 789, São Paulo, SP'
    ),
    (
        'Farma Pague Menos',
        'Clara Almeida',
        'clara@paguemenos.com.br',
        '(11) 9988-2233',
        'Avenida São João, 135, São Paulo, SP'
    ),
    (
        'Grupo DPSP',
        'Natália Lima',
        'natalia@dpsp.com.br',
        '(11) 8877-5566',
        'Rua da Saúde, 456, São Paulo, SP'
    ),
    (
        'Drogaria São Paulo',
        'Felipe Martins',
        'felipe@drogariasaopaulo.com.br',
        '(11) 9987-6655',
        'Avenida do Comércio, 1234, São Paulo, SP'
    ),
    (
        'Farmácias Pague Menos',
        'Mariana Ribeiro',
        'mariana@paguemenos.com.br',
        '(11) 9987-8899',
        'Rua do Sol, 789, São Paulo, SP'
    ),
    (
        'Laboratório Farmasa',
        'André Mendes',
        'andre@farmasa.com.br',
        '(11) 7777-4444',
        'Rua dos Limoeiros, 147, São Paulo, SP'
    ),
    (
        'Laboratório Sandoz',
        'Carmen Freitas',
        'carmen@sandoz.com.br',
        '(11) 6666-5555',
        'Avenida das Flores, 258, São Paulo, SP'
    ),
    (
        'Medley',
        'Fernando Alves',
        'fernando@medley.com.br',
        '(11) 8888-9999',
        'Rua das Acácias, 369, São Paulo, SP'
    );