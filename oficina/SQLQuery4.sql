-- Etapa 2: Script SQL — Criação do Banco


CREATE DATABASE OficinaDB;
GO
USE OficinaDB;
GO

-- Clientes
CREATE TABLE Clientes (
    IdCliente INT PRIMARY KEY IDENTITY,
    Nome NVARCHAR(100) NOT NULL,
    Telefone NVARCHAR(20),
    Email NVARCHAR(100)
);

-- Veículos
CREATE TABLE Veiculos (
    IdVeiculo INT PRIMARY KEY IDENTITY,
    Placa CHAR(7) UNIQUE NOT NULL,
    Modelo NVARCHAR(50),
    Ano INT,
    IdCliente INT NOT NULL,
    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
);

-- Funcionários
CREATE TABLE Funcionarios (
    IdFuncionario INT PRIMARY KEY IDENTITY,
    Nome NVARCHAR(100),
    Cargo NVARCHAR(50)
);

-- Serviços
CREATE TABLE Servicos (
    IdServico INT PRIMARY KEY IDENTITY,
    Descricao NVARCHAR(100),
    Preco DECIMAL(10,2)
);

-- Peças
CREATE TABLE Pecas (
    IdPeca INT PRIMARY KEY IDENTITY,
    Nome NVARCHAR(100),
    Preco DECIMAL(10,2)
);

-- Ordem de Serviço
CREATE TABLE OrdemServico (
    IdOrdem INT PRIMARY KEY IDENTITY,
    IdVeiculo INT,
    IdFuncionario INT,
    IdServico INT,
    DataServico DATE DEFAULT GETDATE(),
    ValorTotal DECIMAL(10,2),
    FOREIGN KEY (IdVeiculo) REFERENCES Veiculos(IdVeiculo),
    FOREIGN KEY (IdFuncionario) REFERENCES Funcionarios(IdFuncionario),
    FOREIGN KEY (IdServico) REFERENCES Servicos(IdServico)
);

-- Peças utilizadas na ordem
CREATE TABLE OrdemPecas (
    IdOrdem INT,
    IdPeca INT,
    Quantidade INT CHECK (Quantidade > 0),
    PRIMARY KEY (IdOrdem, IdPeca),
    FOREIGN KEY (IdOrdem) REFERENCES OrdemServico(IdOrdem),
    FOREIGN KEY (IdPeca) REFERENCES Pecas(IdPeca)
);

-- Pagamentos
CREATE TABLE Pagamentos (
    IdPagamento INT PRIMARY KEY IDENTITY,
    IdOrdem INT,
    FormaPagamento NVARCHAR(50),
    ValorPago DECIMAL(10,2),
    FOREIGN KEY (IdOrdem) REFERENCES OrdemServico(IdOrdem)
);


-- Etapa 3: Inserção de Dados

INSERT INTO Clientes (Nome, Telefone, Email)
VALUES ('Beatriz Silva', '11999999999', 'beatriz@email.com');

INSERT INTO Veiculos (Placa, Modelo, Ano, IdCliente)
VALUES ('ABC1234', 'Fiat Uno', 2015, 1);

INSERT INTO Funcionarios (Nome, Cargo)
VALUES ('Carlos Mecânico', 'Mecânico');

INSERT INTO Servicos (Descricao, Preco)
VALUES ('Troca de óleo', 150.00);

INSERT INTO Pecas (Nome, Preco)
VALUES ('Filtro de óleo', 50.00);

INSERT INTO OrdemServico (IdVeiculo, IdFuncionario, IdServico, ValorTotal)
VALUES (1, 1, 1, 200.00);

INSERT INTO OrdemPecas (IdOrdem, IdPeca, Quantidade)
VALUES (1, 1, 1);

INSERT INTO Pagamentos (IdOrdem, FormaPagamento, ValorPago)
VALUES (1, 'Pix', 200.00);


-- Etapa 4: Consultas SQL Complexas

SELECT F.Nome, COUNT(O.IdOrdem) AS TotalServicos
FROM Funcionarios F
JOIN OrdemServico O ON F.IdFuncionario = O.IdFuncionario
GROUP BY F.Nome;

--- Clientes que gastaram mais de R$ 300:

SELECT C.Nome, SUM(O.ValorTotal) AS TotalGasto
FROM Clientes C
JOIN Veiculos V ON C.IdCliente = V.IdCliente
JOIN OrdemServico O ON V.IdVeiculo = O.IdVeiculo
GROUP BY C.Nome
HAVING SUM(O.ValorTotal) < 300;


--- Peças mais utilizadas:

SELECT P.Nome, SUM(OP.Quantidade) AS TotalUsado
FROM Pecas P
JOIN OrdemPecas OP ON P.IdPeca = OP.IdPeca
GROUP BY P.Nome
ORDER BY TotalUsado DESC;


