CREATE DATABASE IF NOT EXISTS blessed7;
USE blessed7;

-- Tabela base de acesso/roles
CREATE TABLE acesso (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome ENUM('GESTOR', 'FUNCIONARIO', 'CLIENTE') NOT NULL,
    descricao VARCHAR(45)
);



-- Tabela de endereço (usada por Cliente e Empresa)
CREATE TABLE endereco (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cep VARCHAR(9) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(45)
);

-- Tabela de empresa
CREATE TABLE empresa (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome_fantasia VARCHAR(45),
    cnpj VARCHAR(18),
    email VARCHAR(45),
    telefone VARCHAR(15),
    endereco_id BIGINT,
    FOREIGN KEY (endereco_id) REFERENCES endereco(id)
);

-- Tabela de cliente
CREATE TABLE cliente (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    email VARCHAR(45) UNIQUE,
    senha VARCHAR(255),
    url_foto VARCHAR(255),
    data_criacao DATETIME,
    data_nasc DATE,
    telefone VARCHAR(11),
    endereco_id BIGINT,
    acesso_id BIGINT,
    FOREIGN KEY (endereco_id) REFERENCES endereco(id),
    FOREIGN KEY (acesso_id) REFERENCES acesso(id)
);

-- Tabela de funcionário
CREATE TABLE funcionario (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    email VARCHAR(45) UNIQUE,
    senha VARCHAR(255),
    url_foto VARCHAR(255),
    data_criacao DATETIME,
    cpf VARCHAR(11) UNIQUE,
    empresa_id BIGINT,
    acesso_id BIGINT,
    FOREIGN KEY (empresa_id) REFERENCES empresa(id),
    FOREIGN KEY (acesso_id) REFERENCES acesso(id)
);

-- Tabela de avaliação
CREATE TABLE avaliacao (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nota INT,
    descricacao VARCHAR(255)
);

-- Tabela de serviço
CREATE TABLE servico (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    descricacao VARCHAR(100),
    preco DECIMAL(10,2),
    duracao INT,
    avaliacao_id BIGINT,
    FOREIGN KEY (avaliacao_id) REFERENCES avaliacao(id)
);

-- Tabela de produto
CREATE TABLE produto (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    preco DECIMAL(10,2),
    quantidade INT
);

-- Tabela de consulta
CREATE TABLE consulta (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    data_hora_inicio DATETIME,
    data_hora_fim DATETIME,
    tipo_pagamento ENUM('DINHEIRO', 'DEBITO', 'PIX', 'CREDITO'),
    data_pagamento DATE,
    local_consulta ENUM('CLINICA', 'DOMICILIO'),
    fk_cliente BIGINT,
    fk_funcionario BIGINT,
    FOREIGN KEY (fk_cliente) REFERENCES cliente(id),
    FOREIGN KEY (fk_funcionario) REFERENCES funcionario(id)
);

-- Tabela associativa consulta x serviço
CREATE TABLE consulta_servico (
    consulta_id BIGINT,
    servico_id BIGINT,
    PRIMARY KEY (consulta_id, servico_id),
    FOREIGN KEY (consulta_id) REFERENCES consulta(id),
    FOREIGN KEY (servico_id) REFERENCES servico(id)
);

-- Tabela associativa serviço x produto
CREATE TABLE servico_produto (
    servico_id BIGINT,
    produto_id BIGINT,
    PRIMARY KEY (servico_id, produto_id),
    FOREIGN KEY (servico_id) REFERENCES servico(id),
    FOREIGN KEY (produto_id) REFERENCES produto(id)
);

-- Roles
INSERT INTO acesso (nome, descricao) VALUES
('GESTOR', 'Acesso total ao sistema'),
('FUNCIONARIO', 'Acesso às consultas e clientes'),
('CLIENTE', 'Acesso ao agendamento e histórico');

-- Serviços (os mesmos que estão hardcoded no frontend)
INSERT INTO servico (nome, descricacao, preco, duracao) VALUES
('Limpeza de Pele', 'Tratamento profundo para remoção de impurezas e revitalização celular.', 280.00, 60),
('Massagem Relaxante', 'Equilíbrio perfeito entre técnicas ancestrais e óleos essenciais orgânicos.', 350.00, 60),
('Drenagem', 'Técnica especializada para redução de medidas e eliminação de toxinas corporais.', 220.00, 60);

select * from consulta;
select * from acesso;
select * from cliente;



