CREATE DATABASE Eclipseed;
USE Eclipseed;

CREATE TABLE Empresa( 
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa VARCHAR(50) NOT NULL UNIQUE,
    cnpj CHAR(14) NOT NULL UNIQUE,
	emailEmpresa VARCHAR(50) NOT NULL UNIQUE,
		CONSTRAINT chkEmail CHECK(emailEmpresa LIKE ('%@%')),
    senhaEmpresa VARCHAR(50) NOT NULL,
	contatoEmpresa CHAR(14) NOT NULL,
    contatoEmergencia CHAR(14),
	logradouroEmpresa VARCHAR(50) NOT NULL,
	numLogradouroEmpresa VARCHAR(5) NOT NULL,
	bairroEmpresa VARCHAR(50) NOT NULL,
	complementoEmpresa VARCHAR(50),
	cidadeEmpresa VARCHAR(50) NOT NULL,
	estadoEmpresa CHAR (2) NOT NULL,
	cepEmpresa CHAR(8) NOT NULL
);

INSERT INTO Empresa (
    nomeEmpresa, cnpj, emailEmpresa, senhaEmpresa, 
    contatoEmpresa, contatoEmergencia, logradouroEmpresa, 
    numLogradouroEmpresa, bairroEmpresa, complementoEmpresa, 
    cidadeEmpresa, estadoEmpresa, cepEmpresa) 
    VALUES 
    ('Fazenda Emanuel', 
    '86953563000110', 
    'emanuel.fazenda@gmail.com', 
    'emanuel123', 
    '1125633804', 
    '11992371176', 
    'Avenida Paulista', 
    '284', 
    'Vila Madalena', 
    'X', 
    'Taboão da Serra', 
    'SP',
    '06703600');
    
   SELECT 
    empresa.idEmpresa AS "ID", 
    empresa.nomeEmpresa AS "Nome da Empresa",
    empresa.cnpj AS "CNPJ",
    empresa.emailEmpresa AS "E-mail",
    empresa.contatoEmpresa AS "Telefone",
    empresa.contatoEmergencia AS "Emergência",
    CONCAT(empresa.logradouroEmpresa, ', ', empresa.numLogradouroEmpresa, ' ', empresa.bairroEmpresa) AS "Endereço",
    CONCAT(empresa.cidadeEmpresa, ' ', empresa.estadoEmpresa, ' ', empresa.cepEmpresa) AS "Localização"
FROM 
    Empresa;


CREATE TABLE Estoque (
	idEstoque INT PRIMARY KEY AUTO_INCREMENT,
	produto VARCHAR(30) NOT NULL,
	qtdProduto INT NOT NULL,
	entrada INT NOT NULL,
	saida INT NOT NULL,
	dtData DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
);

INSERT INTO Estoque (
    produto, qtdProduto, entrada, saida, dtData
) VALUES
    ('Sensor LDR', 920, 1100, 180, CURRENT_TIMESTAMP);
  
    SELECT 
    idEstoque AS "ID do Estoque",
    produto AS "Produto",
    qtdProduto AS "Quantidade Total",
    entrada AS "Quantidade de Entrada",
    saida AS "Quantidade de Saída",
    dtData AS "Data e Hora do Registro"
FROM 
    Estoque;

CREATE TABLE Plantio (
	idPlantio INT PRIMARY KEY AUTO_INCREMENT,
	tamanho DECIMAL NOT NULL,
    tipoPlantio VARCHAR(30) NOT NULL,
    -- Endereço do Plantio
    logradouroPlantio VARCHAR(50) NOT NULL,
	numLogradouroPlantio VARCHAR(5) NOT NULL,
	bairroPlantio VARCHAR(50) NOT NULL,
	complementoPlantio VARCHAR(50) NOT NULL,
	cidadePlantio VARCHAR(50) NOT NULL,
	estadoPlantio CHAR (2) NOT NULL,
	cepPlantio CHAR(8) NOT NULL
);

INSERT INTO Plantio (
    tamanho, tipoPlantio, logradouroPlantio, numLogradouroPlantio, 
    bairroPlantio, complementoPlantio, cidadePlantio, estadoPlantio, cepPlantio) 
    VALUES 
   ( 80, 'Soja', 'Avenida São Vicente', '892', 'Vila Oliveira', 'X', 'Suzano', 'SP', '06385320');

SELECT 
    idPlantio AS "ID do Plantio",
    tamanho AS "Tamanho (hectares)",
    tipoPlantio AS "Tipo de Plantio",
    logradouroPlantio AS "Logradouro",
    numLogradouroPlantio AS "Número do Logradouro",
    bairroPlantio AS "Bairro",
    complementoPlantio AS "Complemento",
    cidadePlantio AS "Cidade",
    estadoPlantio AS "Estado",
    cepPlantio AS "CEP"
FROM 
    Plantio;

CREATE TABLE historicoPlantio(
	idHistoricoPlantio INT PRIMARY KEY AUTO_INCREMENT,
	intensidadeLuz DECIMAL NOT NULL,                         
	statusLuz VARCHAR(50) NOT NULL,  
		CONSTRAINT chkStatusLuz CHECK (statusLuz IN ('Iluminação Adequada', 'Iluminação Excessiva', 'Iluminação Insuficiente')), 
	horarioAtt DATETIME
);

INSERT INTO historicoPlantio (
    intensidadeLuz, statusLuz, horarioAtt
) VALUES 
    (120.0, 'Iluminação Adequada', '2025-03-19 10:00:00'), 
    (180.0, 'Iluminação Excessiva', '2025-03-19 10:15:00'), 
    (40.0, 'Iluminação Insuficiente', '2025-03-19 10:30:00'),
    (130.0, 'Iluminação Adequada', '2025-03-19 10:45:00'), 
    (200.0, 'Iluminação Excessiva', '2025-03-19 11:00:00'), 
    (45.0, 'Iluminação Insuficiente', '2025-03-19 11:15:00'),  
    (110.0, 'Iluminação Adequada', '2025-03-19 11:30:00');
    
    SELECT 
    idHistoricoPlantio AS "ID do Histórico",
    intensidadeLuz AS "Intensidade de Luz (lux)",
    statusLuz AS "Status da Iluminação",
    horarioAtt AS "Horário da Atualização"
FROM 
    historicoPlantio
WHERE 
    intensidadeLuz > 150 OR intensidadeLuz < 50;

 CREATE TABLE Instalacao(
	idInstalacao INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa VARCHAR(50) NOT NULL,
    dtInstalacao DATE NOT NULL,
    valorInstalacao DECIMAL NOT NULL,
    validadeProduto DATE NOT NULL,
    qtdProdutoInstalado INT NOT NULL
 );
 
INSERT INTO Instalacao (
    nomeEmpresa, dtInstalacao, valorInstalacao, validadeProduto, qtdProdutoInstalado) 
    VALUES 
    ('Emanuel Fazendas', '2025-03-12', 130, '2026-09-12', 10);
    
   SELECT 
    idInstalacao AS "ID",
    nomeEmpresa AS "Empresa",
    CONCAT(DATE_FORMAT(dtInstalacao, '%d/%m/%Y'), ' - ', DATE_FORMAT(validadeProduto, '%d/%m/%Y')) AS "Datas"
FROM 
    Instalacao;
    
 CREATE TABLE Devolucao(
	idDevolucao INT PRIMARY KEY AUTO_INCREMENT,
	motivoDevolucao VARCHAR(255) NOT NULL,
    dtDevolucao DATE NOT NULL
 );
 
 INSERT INTO Devolucao(
    motivoDevolucao, dtDevolucao) 
    VALUES 
    ('Sensores com problema na instalação', '2026-12-27');

SELECT 
    idDevolucao AS "ID da Devolução",
    motivoDevolucao AS "Motivo da Devolução",
    dtDevolucao AS "Data da Devolução"
FROM 
    Devolucao;