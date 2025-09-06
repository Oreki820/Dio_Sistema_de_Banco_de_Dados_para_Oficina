-- =========================================
-- Banco de Dados: Oficina Mecânica
-- =========================================

-- ===============================
-- 1️⃣ Criação das Tabelas
-- ===============================

CREATE DATABASE IF NOT EXISTS Oficina;
USE Oficina;

-- Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(200),
    Telefone VARCHAR(20),
    Email VARCHAR(100),
    Data_Criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Veículo
CREATE TABLE IF NOT EXISTS Veiculo (
    ID_Veiculo INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(10) NOT NULL UNIQUE,
    Modelo VARCHAR(50),
    Marca VARCHAR(50),
    Ano INT,
    Tipo VARCHAR(20),
    ID_Cliente INT,
    Data_Criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Mecânico
CREATE TABLE IF NOT EXISTS Mecanico (
    ID_Mecanico INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(200),
    Especialidade VARCHAR(50),
    Data_Criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Equipe
CREATE TABLE IF NOT EXISTS Equipe (
    ID_Equipe INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Equipe VARCHAR(50) NOT NULL,
    Data_Criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Equipe_Mecanico (N:N)
CREATE TABLE IF NOT EXISTS Equipe_Mecanico (
    ID_Equipe INT,
    ID_Mecanico INT,
    PRIMARY KEY (ID_Equipe, ID_Mecanico),
    FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe),
    FOREIGN KEY (ID_Mecanico) REFERENCES Mecanico(ID_Mecanico)
);

-- Ordem de Serviço
CREATE TABLE IF NOT EXISTS Ordem_Servico (
    ID_OS INT PRIMARY KEY AUTO_INCREMENT,
    Numero_OS VARCHAR(20) NOT NULL UNIQUE,
    Data_Emissao DATE NOT NULL,
    Data_Conclusao DATE,
    Status VARCHAR(50) NOT NULL,
    Autorizado BOOLEAN DEFAULT FALSE,
    Valor_Total DECIMAL(10,2),
    ID_Veiculo INT,
    ID_Equipe INT,
    Data_Criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Veiculo) REFERENCES Veiculo(ID_Veiculo),
    FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe)
);

-- Serviço
CREATE TABLE IF NOT EXISTS Servico (
    ID_Servico INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Servico VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Valor_Mao_Obra DECIMAL(10,2) NOT NULL,
    Data_Criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- OS_Serviço (N:N)
CREATE TABLE IF NOT EXISTS OS_Servico (
    ID_OS INT,
    ID_Servico INT,
    Valor DECIMAL(10,2),
    PRIMARY KEY (ID_OS, ID_Servico),
    FOREIGN KEY (ID_OS) REFERENCES Ordem_Servico(ID_OS),
    FOREIGN KEY (ID_Servico) REFERENCES Servico(ID_Servico)
);

-- Peça
CREATE TABLE IF NOT EXISTS Peca (
    ID_Peca INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Peca VARCHAR(100) NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Data_Criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- OS_Peca (N:N)
CREATE TABLE IF NOT EXISTS OS_Peca (
    ID_OS INT,
    ID_Peca INT,
    Quantidade INT NOT NULL DEFAULT 1,
    Valor DECIMAL(10,2),
    PRIMARY KEY (ID_OS, ID_Peca),
    FOREIGN KEY (ID_OS) REFERENCES Ordem_Servico(ID_OS),
    FOREIGN KEY (ID_Peca) REFERENCES Peca(ID_Peca)
);

-- Tabela de Referência de Mão de Obra
CREATE TABLE IF NOT EXISTS Tabela_Referencia_Mao_Obra (
    ID_Referencia INT PRIMARY KEY AUTO_INCREMENT,
    Tipo_Servico VARCHAR(100) NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Data_Criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Data_Atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Histórico de OS
CREATE TABLE IF NOT EXISTS Historico_OS (
    ID_Historico INT PRIMARY KEY AUTO_INCREMENT,
    ID_OS INT,
    Status_Anterior VARCHAR(50),
    Status_Novo VARCHAR(50),
    Data_Alteracao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Observacao TEXT,
    FOREIGN KEY (ID_OS) REFERENCES Ordem_Servico(ID_OS)
);

-- ===============================
-- 2️⃣ Inserção de Dados de Teste
-- ===============================

-- Clientes
INSERT INTO Cliente (Nome, Endereco, Telefone, Email)
VALUES 
('Lucas Gomes', 'Rua A, 123', '55999969581', 'lucas@email.com'),
('Maria Silva', 'Av B, 456', '55999887766', 'maria@email.com');

-- Veículos
INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, Tipo, ID_Cliente)
VALUES 
('ABC1234', 'Civic', 'Honda', 2020, 'Sedan', 1),
('XYZ9876', 'Gol', 'Volkswagen', 2018, 'Hatch', 2);

-- Mecânicos
INSERT INTO Mecanico (Nome, Endereco, Especialidade)
VALUES 
('João Silva', 'Rua B, 45', 'Motor'),
('Pedro Santos', 'Rua C, 78', 'Elétrica');

-- Equipes
INSERT INTO Equipe (Nome_Equipe)
VALUES 
('Equipe Alpha'),
('Equipe Beta');

-- Equipe_Mecanico
INSERT INTO Equipe_Mecanico (ID_Equipe, ID_Mecanico)
VALUES 
(1, 1),
(1, 2),
(2, 2);

-- Serviços
INSERT INTO Servico (Nome_Servico, Descricao, Valor_Mao_Obra)
VALUES 
('Troca de Óleo', 'Substituição do óleo do motor', 150.00),
('Alinhamento', 'Alinhamento e balanceamento', 120.00);

-- Peças
INSERT INTO Peca (Nome_Peca, Valor)
VALUES 
('Filtro de Óleo', 50.00),
('Pneu', 300.00);

-- Ordem de Serviço
INSERT INTO Ordem_Servico (Numero_OS, Data_Emissao, Status, ID_Veiculo, ID_Equipe, Valor_Total)
VALUES 
('OS001', '2025-09-06', 'Em andamento', 1, 1, NULL),
('OS002', '2025-09-07', 'Concluída', 2, 2, NULL);

-- OS_Serviço
INSERT INTO OS_Servico (ID_OS, ID_Servico, Valor)
VALUES 
(1, 1, 150.00),
(2, 2, 120.00);

-- OS_Peca
INSERT INTO OS_Peca (ID_OS, ID_Peca, Quantidade, Valor)
VALUES 
(1, 1, 1, 50.00),
(2, 2, 4, 1200.00);

-- ===============================
-- 3️⃣ Queries de Exemplo
-- ===============================

-- a) Recuperação simples
SELECT Nome, Telefone, Email FROM Cliente;

-- b) Filtro com WHERE
SELECT * FROM Ordem_Servico
WHERE Status = 'Em andamento';

-- c) Atributo derivado (Valor total da OS)
SELECT o.Numero_OS,
       SUM(COALESCE(os.Valor,0) + COALESCE(op.Valor,0)) AS Valor_Total
FROM Ordem_Servico o
LEFT JOIN OS_Servico os ON o.ID_OS = os.ID_OS
LEFT JOIN OS_Peca op ON o.ID_OS = op.ID_OS
GROUP BY o.Numero_OS;

-- d) Ordenação
SELECT Nome, Marca, Modelo, Ano FROM Veiculo
ORDER BY Ano DESC;

-- e) HAVING
SELECT ID_Equipe, COUNT(ID_Mecanico) AS Total_Mecanicos
FROM Equipe_Mecanico
GROUP BY ID_Equipe
HAVING COUNT(ID_Mecanico) > 1;

-- f) Junção entre tabelas
SELECT c.Nome AS Cliente, v.Placa, o.Numero_OS, s.Nome_Servico, p.Nome_Peca
FROM Ordem_Servico o
JOIN Veiculo v ON o.ID_Veiculo = v.ID_Veiculo
JOIN Cliente c ON v.ID_Cliente = c.ID_Cliente
LEFT JOIN OS_Servico os ON o.ID_OS = os.ID_OS
LEFT JOIN Servico s ON os.ID_Servico = s.ID_Servico
LEFT JOIN OS_Peca op ON o.ID_OS = op.ID_OS
LEFT JOIN Peca p ON op.ID_Peca = p.ID_Peca;
