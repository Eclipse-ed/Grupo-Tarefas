
CREATE DATABASE Eclipseed;
USE Eclipseed;


-- CADASTRO E PLANTAÇÃO

CREATE TABLE enderecoCadastro(
idEnderecoCad int primary key auto_increment,
cep CHAR(9) not null,
uf CHAR(2) not null,
cidade VARCHAR(45) not null,
bairro VARCHAR(45) not null,
rua VARCHAR(45) not null,
numLogradouro CHAR(2) not null,
complemento CHAR(2) );

CREATE TABLE cadastro( 
	idCadastro INT AUTO_INCREMENT,
    usuario VARCHAR(50) NOT NULL UNIQUE,
        senha VARCHAR(50) NOT NULL,
	razaoSocial VARCHAR(45) NOT NULL UNIQUE,
    cnpj CHAR(18) NOT NULL UNIQUE,
	email VARCHAR(50) NOT NULL UNIQUE,
	CONSTRAINT chkEmail CHECK(email LIKE ('%@%')),
	telefone CHAR(15) NOT NULL,
    fkEnderecoCad int,
    constraint EnderecoCad
    foreign key (fkEnderecoCad)
    references enderecoCadastro(idEnderecoCad),
    constraint pkComposta primary key(idCadastro, fkEnderecoCad)
);

CREATE TABLE enderecoPlantacao (
idEnderecoPlant int primary key auto_increment,
cep CHAR(9) not null,
uf CHAR(2) not null,
cidade VARCHAR(45) not null,
bairro VARCHAR(45) not null,
rua VARCHAR(45) not null,
numLogradouro CHAR(2) not null,
complemento CHAR(2) );

CREATE TABLE plantacao (
	idPlantacao INT,
    fkEnderecoPlant int,
    constraint pkComposta primary key(idPlantacao,fkEnderecoPlant),
    nome VARCHAR(45),
	quantHectareAtivo INT NOT NULL,
    dtPlantio date not null,
    dtColheita date not null,
	fkCadastro int,
    fkEnderecoCadPlant int,
    constraint cadastroPlant
    foreign key (fkCadastro)
    references cadastro(idCadastro),
    constraint enderecoCadPlant
    foreign key (fkEnderecoCadPlant)
    references cadastro(fkEnderecoCad),
    constraint enderecoPlant
    foreign key (fkEnderecoPlant)
    references enderecoPlantacao(idEnderecoPlant)
);



-- SENSOR E DADOS
CREATE TABLE sensor(
idSensor int primary key auto_increment,
nome VARCHAR(45) NOT NULL,
fkPlantacao int,
fkEnderecoPlantSensor int,
constraint fkSensorPlant
foreign key (fkPlantacao)
references plantacao(idPlantacao),
constraint fkEnderecoPlantSensor
foreign key (fkEnderecoPlantSensor)
references plantacao(fkEnderecoPlant)
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


INSERT INTO enderecoCadastro (cep, uf, cidade, bairro, rua, numLogradouro, complemento) VALUES
('01001-000', 'SP', 'São Paulo', 'Bela Vista', 'Av. Paulista', '15', ' A'),
('13083-852', 'SP', 'Campinas', 'Barão Geraldo', 'Rua da Universidade', '30', ' B'),
('30140-070', 'MG', 'Belo Horizonte', 'Savassi', 'Rua da Graduação', '12', ' C'),
('70040-010', 'DF', 'Brasília', 'Asa Norte', 'Quadra 5', '99', ' D');



INSERT INTO cadastro (usuario, senha, razaoSocial, cnpj, email, telefone, fkEnderecoCad) VALUES
('empjrsampa', 'senha123', 'Empresa Júnior SP', '00.000.000/0001-01', 'contato@empjrsp.com', '11988887777', 1),
('labcampinas', 'senha456', 'Laboratório Agrícola Campinas', '11.111.111/0001-11', 'agro@unicamp.com', '19997776666', 2),
('agrobh', 'senha789', 'Centro de Agro BH', '22.222.222/0001-22', 'contato@agrobh.com', '31996665555', 3),
('facdf', 'senha000', 'Faculdade DF Rural', '33.333.333/0001-33', 'rural@facdf.com', '61995554444', 4);



INSERT INTO enderecoPlantacao (cep, uf, cidade, bairro, rua, numLogradouro, complemento) VALUES
('17010-001', 'SP', 'Bauru', 'Zona Rural', 'Estrada das Sementes', '10', ' A'),
('14800-000', 'SP', 'Araraquara', 'Sitio Escola', 'Fazenda 1', '20', ' B'),
('35680-000', 'MG', 'Pará de Minas', 'Fazenda Teste', 'Via Experimental', '30', ' C'),
('72700-000', 'DF', 'Planaltina', 'Campus Rural', 'Área Verde', '40', ' D');


INSERT INTO plantacao (idPlantacao, fkEnderecoPlant,nome, quantHectareAtivo, dtPlantio, dtColheita, fkCadastro, fkEnderecoCadPlant) VALUES
(1, 1,'Rancho Feliz' ,10, '2025-02-01', '2025-06-30', 1, 1),
(2, 2,'Rio Bravo' ,8, '2025-01-15', '2025-05-20', 2, 2),
(3, 3,'Fazendo do Pica-Pau' ,12, '2025-03-10', '2025-08-01', 3, 3),
(4, 4,'Sítio da Soja' ,15, '2025-04-01', '2025-09-01', 4, 4);



INSERT INTO sensor (nome, fkPlantacao, fkEnderecoPlantSensor) VALUES
('Sensor Umidade Bauru', 1, 1),
('Sensor Luminosidade Araraquara', 2, 2),
('Sensor Temperatura BH', 3, 3),
('Sensor pH Solo DF', 4, 4);



INSERT INTO dadosSensor (idDados, fkSensor, lux, statusLuminosidade, dtHora) VALUES
(1 , 1, 550.50, 'Estável', '2025-04-21 08:00:00'),
(2 , 1, 1000.30,'Estável','2025-04-21 09:00:00'),
(1 , 2, 1200.20, 'Acima do recomendado', '2025-04-21 09:00:00'),
(1, 3, 300.90, 'Abaixo do recomendado', '2025-04-21 10:00:00'),
(1, 4, 700.80, 'Estável', '2025-04-21 11:00:00');


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
       
-- Dados Sensor
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
       on d.fkSensor = s.idSensor
       WHERE c.razaoSocial = 'Empresa Júnior SP';
       
 -- Endereço das Plantações em São Paulo      
 SELECT c.razaoSocial as 'Razão Social',
		p.nome as Fazenda,
        e.cep as 'CEP  (Fazenda)',
		e.uf as 'UF (Fazenda)',
        e.cidade as 'Cidade (Fazenda)',
        e.bairro as 'Bairro (Fazenda)',
        e.rua as  'Rua 
(Fazenda)',
        concat(e.numLogradouro, e.complemento) as 'Número e Complemento (Fazenda)'
        from cadastro as c join plantacao as p 
        on c.idCadastro = p.fkCadastro
        join enderecoPlantacao as e
        on p.fkEnderecoPlant = e.idEnderecoPlant
        WHERE e.UF = 'SP';
       
       
       
 -- Endereço das Empresas parceiras de Minas Gerais(MG) e Distrito Federal(DF)    
 SELECT c.razaoSocial as 'Razão Social',
        e.cep as CEP,
		e.uf as UF,
        e.cidade as Cidade,
        e.bairro as Bairro,
        e.rua as Rua,
        concat(e.numLogradouro, e.complemento) as 'Número e Complemento'
        from cadastro as c join enderecoCadastro as e
        on e.idEnderecoCad = c.fkEnderecoCad
        WHERE e.UF = 'MG' or e.UF ='DF';