CREATE DATABASE Eclipseed;
USE Eclipseed;


-- CADASTRO E PLANTAÇÃO
CREATE TABLE cliente( 
	idCliente INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(50) NOT NULL UNIQUE,
        senha VARCHAR(50) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
	email VARCHAR(50) NOT NULL UNIQUE,
	CONSTRAINT chkEmail CHECK(email LIKE ('%@%')),
	contato CHAR(14) NOT NULL,
	cep CHAR(8) NOT NULL,
	numLogradouro VARCHAR(5) NOT NULL,
	complemento VARCHAR(50)
);


CREATE TABLE plantacao (
	idPlantacao INT,
    fkCliente int,
    constraint pkComposta primary key(idPlantacao,fkCliente),
    razaoSocial VARCHAR(45) NOT NULL,
	quantHectare INT NOT NULL,
    dtPlantio date not null,
    dtColheita date not null,
	cepPlantacao CHAR(8) NOT NULL,
    numLogradouroPlant VARCHAR(50) NOT NULL,
    constraint fkPlatCliente
    foreign key (fkCliente)
    references cliente(idCliente));



-- SENSOR E DADOS
CREATE TABLE sensor(
idSensor int primary key auto_increment,
nome VARCHAR(45) NOT NULL,
monitoramento VARCHAR(45) NOT NULL,
constraint chkMonitoramento check(monitoramento in('Funcionando','Instável'))
);



CREATE TABLE dadosSensor(
idDados int NOT NULL,
fkSensor int NOT NULL,
constraint pkComposta primary key(fkSensor,idDados),
luminosidade decimal(4,1) NOT NULL,
statusLuminosidade VARCHAR(45) NOT NULL,
dtHora datetime NOT NULL,
constraint chkLuminosidade check(statusLuminosidade in('Acima do recomendado','Abaixo do recomendado','Estável')),
constraint fkDadosSensor
foreign key (fkSensor)
references sensor(idSensor));



