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

CREATE TABLE cep(
idCep int primary key auto_increment,
cep CHAR(9) not null,
estado CHAR(2) not null,
cidade VARCHAR(45) not null,
bairro VARCHAR(45) not null,
rua VARCHAR(45) not null
);

CREATE TABLE cadastro( 
	idCadastro INT AUTO_INCREMENT,
    usuario VARCHAR(50) NOT NULL UNIQUE,
        senha VARCHAR(50) NOT NULL,
	razaoSocial VARCHAR(45) NOT NULL UNIQUE,
    cnpj CHAR(18) NOT NULL UNIQUE,
	email VARCHAR(50) NOT NULL UNIQUE,
	CONSTRAINT chkEmail CHECK(email LIKE ('%@%')),
	telefone CHAR(14) NOT NULL,
    fkCepCadastro int not null,
    numLogradouro CHAR(2) not null,
    complemento CHAR(2),
    constraint cepCadastro
    foreign key (fkCepCadastro)
    references cep(idCep),
    constraint pkComposta primary key(idCadastro, fkCepCadastro)
);


CREATE TABLE plantacao (
	idPlantacao INT,
    nome VARCHAR(45),
	quantHectareAtivo INT NOT NULL,
    dtPlantio date not null,
    dtColheita date not null,
	fkCadastro int not null,
    fkCadastroCep int not null,
    fkCepPlant int,
    numLogradouro CHAR(2) not null,
    complemento CHAR(2),
    constraint cadastroPlant
    foreign key (fkCadastro)
    references cadastro(idCadastro),
    constraint CepCadPlant
    foreign key (fkCadastroCep)
    references cadastro(fkCepCadastro),
    constraint CepPlantacao
    foreign key (fkCepPlant)
    references cep(idCep),
    constraint pkComposta primary key(idPlantacao,fkCepPlant)
);


-- SENSOR E DADOS
CREATE TABLE sensor(
idSensor int primary key auto_increment,
nome VARCHAR(45) NOT NULL,
fkPlantacao int,
fkCepPlantSensor int,
constraint fkSensorPlant
foreign key (fkPlantacao)
references plantacao(idPlantacao),
constraint fkCepPlantSensor
foreign key (fkCepPlantSensor)
references plantacao(fkCepPlant)
);

CREATE TABLE dadosSensor(
idDados int NOT NULL,
fkSensor int NOT NULL,
constraint pkComposta primary key(fkSensor,idDados),
lux float NOT NULL,
statusLuminosidade VARCHAR(45) NOT NULL,
dtHora datetime NOT NULL,
constraint chkLuminosidade check(statusLuminosidade in('Acima do recomendado','Abaixo do recomendado','Estável')),
constraint fkDadosSensor
foreign key (fkSensor)
references sensor(idSensor));

INSERT INTO cep (cep, estado, cidade, bairro, rua) VALUES
('01001-000', 'SP', 'São Paulo', 'Bela Vista', 'Av. Paulista' ),
('13083-852', 'SP', 'Campinas', 'Barão Geraldo', 'Rua da Universidade' ),
('30140-070', 'MG', 'Belo Horizonte', 'Savassi', 'Rua da Graduação'),
('70040-010', 'DF', 'Brasília', 'Asa Norte', 'Quadra 5'),
('17010-001', 'SP', 'Bauru', 'Zona Rural', 'Estrada das Sementes'),
('14800-000', 'SP', 'Araraquara', 'Sitio Escola', 'Fazenda 1'),
('35680-000', 'MG', 'Pará de Minas', 'Fazenda Teste', 'Via Experimental'),
('72700-000', 'DF', 'Planaltina', 'Campus Rural', 'Área Verde');



INSERT INTO cadastro (usuario, senha, razaoSocial, cnpj, email, telefone, fkCepCadastro, numLogradouro, complemento) VALUES
('empjrsampa', 'senha123', 'Empresa Júnior SP', '00.000.000/0001-01', 'contato@empjrsp.com', '(11)98888-7777', 1,'15', ' A'),
('labcampinas', 'senha456', 'Laboratório Agrícola Campinas', '11.111.111/0001-11', 'agro@unicamp.com', '(11)99777-6666', 2, '30', ' B'),
('agrobh', 'senha789', 'Centro de Agro BH', '22.222.222/0001-22', 'contato@agrobh.com', '(31)99666-5555', 3, '12', ' C'),
('facdf', 'senha000', 'Faculdade DF Rural', '33.333.333/0001-33', 'rural@facdf.com', '(61)99555-4444', 4, '99', ' D');






INSERT INTO plantacao (idPlantacao, fkCepPlant,nome, quantHectareAtivo, dtPlantio, dtColheita, fkCadastro, fkCadastroCep, numLogradouro, complemento) VALUES
(1, 5,'Rancho Feliz' ,10, '2025-02-01', '2025-06-30', 1, 1, '10', ' A'),
(2, 6,'Rio Bravo' ,8, '2025-01-15', '2025-05-20', 2, 2, '20', ' B'),
(3, 7,'Fazendo do Pica-Pau' ,12, '2025-03-10', '2025-08-01', 3, 3, '30', ' C'),
(4, 8,'Sítio da Soja' ,15, '2025-04-01', '2025-09-01', 4, 4, '40', ' D');



INSERT INTO sensor (nome, fkPlantacao, fkCepPlantSensor) VALUES
('Sensor LDR', 1, 5),
('Sensor LDR', 2, 6),
('Sensor LDR', 3, 7),
('Sensor LDR', 4, 8);



INSERT INTO dadosSensor (idDados, fkSensor, lux, statusLuminosidade, dtHora) VALUES
(1 , 1, 15500.50, 'Estável', '2025-04-21 08:00:00'),
(2 , 1, 10000.30,'Estável','2025-04-21 09:00:00'),
(1 , 2, 120000.20, 'Acima do recomendado', '2025-04-21 09:00:00'),
(1, 3, 300.90, 'Abaixo do recomendado', '2025-04-21 10:00:00'),
(1, 4, 17000.80, 'Estável', '2025-04-21 11:00:00');


SELECT c.razaoSocial as 'Razão Social',
	   p.nome as 'Nome da Plantação',
       s.idSensor 'Identificador do Sensor',
       d.lux as 'Lux(lx)',
       d.statusLuminosidade as 'Status da Luminosidade',
       d.dtHora as 'Data e Hora Sensor'
       FROM cadastro as c join plantacao as p
       on c.idCadastro = p.fkCadastro
       join sensor as s
       on s.fkPlantacao = p.idPlantacao
       join dadosSensor as d
       on d.fkSensor = s.idSensor;
       
-- Dados Sensor da Fazenda Rancho Feliz
SELECT p.nome as 'Nome da Plantação',
       s.idSensor 'Identificador do Sensor',
       d.lux as 'Lux(lx)',
       d.statusLuminosidade as 'Status da Luminosidade',
       d.dtHora as 'Data e Hora Sensor'
       FROM plantacao as p join sensor as s
       on s.fkPlantacao = p.idPlantacao
       join dadosSensor as d
       on d.fkSensor = s.idSensor
       WHERE p.nome = 'Rancho Feliz';
       
 -- Endereço das Plantações em São Paulo      
 SELECT c.razaoSocial as 'Razão Social',
		p.nome as Fazenda,
        cep.cep as 'CEP  (Fazenda)',
		cep.estado as 'UF (Fazenda)',
        cep.cidade as 'Cidade (Fazenda)',
        cep.bairro as 'Bairro (Fazenda)',
        cep.rua as  'Rua 
(Fazenda)',
        concat(c.numLogradouro, c.complemento) as 'Número e Complemento (Fazenda)'
        from cadastro as c join plantacao as p 
        on c.idCadastro = p.fkCadastro
        join cep 
        on p.fkCepPlant = cep.idCep
        WHERE cep.estado = 'SP';
       
       
       
 -- Endereço das Empresas parceiras de Minas Gerais(MG) e Distrito Federal(DF)    
 SELECT c.razaoSocial as 'Razão Social',
        cep.cep as CEP,
		cep.estado as UF,
        cep.cidade as Cidade,
        cep.bairro as Bairro,
        cep.rua as Rua,
        concat(c.numLogradouro, c.complemento) as 'Número e Complemento'
        from cadastro as c join cep
        on cep.idCep = c.fkCepCadastro
        WHERE cep.estado = 'MG' or cep.estado ='DF';