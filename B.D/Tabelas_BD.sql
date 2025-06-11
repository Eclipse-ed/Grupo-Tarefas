/*
                                   Integrantes Grupo 08(Eclipseed)
                                            Beatriz Pina
                                            Gabriel Oliveira
                                            Kauã Thieme
                                            Gustavo Vieck
                                            Willian Martins
*/



CREATE DATABASE Eclipseed;
USE Eclipseed;


-- CADASTRO E PLANTAÇÃO
CREATE DATABASE eclipseed;
USE eclipseed;

-- Tabela Endereco
CREATE TABLE Endereco (
  idEndereco INT PRIMARY KEY,
  cep CHAR(8) NOT NULL,
  estado CHAR(2) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  rua VARCHAR(45) NOT NULL,
  numeroLogradouro CHAR(5) NOT NULL,
  complemento VARCHAR(45)
);

INSERT INTO Endereco VALUES
(1, '12345678', 'SP', 'Sao Paulo', 'Centro', 'Rua A', '101', 'Apto 1');	

-- Tabela Empresa
CREATE TABLE Empresa (
  idEmpresa INT,
  razaoSocial VARCHAR(45) NOT NULL,
  cnpj CHAR(14) NOT NULL,
  fkEnderecoEmpresa INT,
  codigoAtivacao VARCHAR(45),
  CONSTRAINT pkComposta PRIMARY KEY(idEmpresa, fkEnderecoEmpresa),
  CONSTRAINT fk_Empresa_Endereco1 
    FOREIGN KEY (fkEnderecoEmpresa)
    REFERENCES Endereco(idEndereco)
);

INSERT INTO Empresa VALUES
(1, 'AgroTech Ltda', '12345678000195', 1, 'ATC2025XYZ');

-- Tabela Funcionario
CREATE TABLE Funcionario (
  idFuncionario INT,
  usuario VARCHAR(45) NOT NULL,
  senha VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  telefone CHAR(11) NOT NULL,
  fkEmpresa INT,
  fkEnderecoEmpresa INT NOT NULL,
  CONSTRAINT pkComposta2 PRIMARY KEY (idFuncionario, fkEmpresa, fkEnderecoEmpresa),
  CONSTRAINT fk_Funcionario_Empresa1 
    FOREIGN KEY (fkEmpresa, fkEnderecoEmpresa)
    REFERENCES Empresa(idEmpresa, fkEnderecoEmpresa)
);

INSERT INTO Funcionario VALUES
(1, 'joaosilva', 'senhaSegura123', 'joao@agrotech.com', '11987654321', 1, 1);

-- Tabela Plantacao
CREATE TABLE Plantacao (
  idPlantacao INT,
  nome VARCHAR(45) NOT NULL,
  quantHectareAtivo INT NOT NULL,
  fkEnderecoPlant INT,
  fkEmpresaPlant INT,
  fkEnderecoEmpresaPlant INT,
  CONSTRAINT pkComposta3 PRIMARY KEY (idPlantacao, fkEnderecoPlant, fkEmpresaPlant, fkEnderecoEmpresaPlant),
  CONSTRAINT fk_Plantacao_CepCadastro1 
    FOREIGN KEY (fkEnderecoPlant)
    REFERENCES Endereco(idEndereco),
  CONSTRAINT fk_Plantacao_Empresa1 
    FOREIGN KEY (fkEmpresaPlant, fkEnderecoEmpresaPlant)
    REFERENCES Empresa(idEmpresa, fkEnderecoEmpresa)
);

INSERT INTO Plantacao VALUES
(1, 'Plantação Sul', 20, 1, 1, 1);

-- Tabela Sensor
CREATE TABLE Sensor (
  idSensor INT PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
    statusSensor tinyint,
  fkPlantacao INT,
  fkEndPlantSensor INT,
  CONSTRAINT fk_Sensor_Plantacao1 
    FOREIGN KEY (fkPlantacao, fkEndPlantSensor)
    REFERENCES Plantacao(idPlantacao, fkEnderecoPlant)
);

INSERT INTO Sensor VALUES
(1, 'Sensor de Luminosidade','0', 1, 1),
(2 , 'Sensor de Luminosidade','0', 1, 1),
(3 , 'Sensor de Luminosidade','0', 1, 1),
(4 , 'Sensor de Luminosidade','0', 1, 1),
(5 , 'Sensor de Luminosidade','0', 1, 1),
(6 , 'Sensor de Luminosidade','0', 1, 1),
(7 , 'Sensor de Luminosidade','0', 1, 1),
(8 , 'Sensor de Luminosidade','0', 1, 1),
(9 , 'Sensor de Luminosidade','0', 1, 1),
(10 , 'Sensor de Luminosidade','0', 1, 1),
(11 , 'Sensor de Luminosidade','0', 1, 1),
(12 , 'Sensor de Luminosidade','0', 1, 1),
(13 , 'Sensor de Luminosidade','0', 1, 1),
(14 , 'Sensor de Luminosidade','0', 1, 1),
(15 , 'Sensor de Luminosidade','0', 1, 1),
(16 , 'Sensor de Luminosidade','0', 1, 1),
(17 , 'Sensor de Luminosidade','0', 1, 1),
(18 , 'Sensor de Luminosidade','0', 1, 1),
(19 , 'Sensor de Luminosidade','0', 1, 1),
(20 , 'Sensor de Luminosidade','0', 1, 1),
(21 , 'Sensor de Luminosidade','0', 1, 1),
(22 , 'Sensor de Luminosidade','0', 1, 1),
(23 , 'Sensor de Luminosidade','0', 1, 1),
(24 , 'Sensor de Luminosidade','0', 1, 1);

-- Tabela Registro
CREATE TABLE Registro (
  idRegistro INT,
  lux FLOAT NOT NULL,
  dtHora DATETIME NOT NULL,
  fkSensor INT,
  CONSTRAINT pkComposta4 PRIMARY KEY (idRegistro, fkSensor),
  CONSTRAINT fk_DadosSensor_Sensor1 
    FOREIGN KEY (fkSensor)
    REFERENCES Sensor(idSensor)
);

INSERT INTO Registro VALUES
(1, 455.6, '2025-06-11 09:45:00', 1),
(2, 455.6, '2025-06-11 09:45:10', 1),
(3, 455.6, '2025-06-11 09:45:50', 1),
(4, 455.6, '2025-06-11 09:46:10', 2);



SELECT 
	
	   p.nome as nome_plantacao, 	
	   round(sum(r.lux),2) as soma_lux,
       date_format(r.dtHora, '%H:%i') as hora_minuto_registro
FROM
    plantacao p JOIN sensor s
    ON p.idPlantacao = s.fkPlantacao
JOIN registro r
	ON s.idSensor = r.fkSensor
GROUP BY p.nome, hora_minuto_registro;

insert into sensor values
(25, 'Sensor de Luminosidade','1', 1, 1);



SELECT 
	  p.idPlantacao as 'identificador_plantacao',
	  sum(s.statusSensor) as 'sensores_ativos',
      count(s.statusSensor) - sum(s.statusSensor) as 'sensores_inativos'
FROM
	 plantacao p JOIN sensor s
ON
   p.idPlantacao = s.fkPlantacao
WHERE p.idPlantacao = 1
group by p.nome;
	  
