create table despesas(
	codigo_despesa int not null,
	valor numeric(10, 2) not null,
	data_lancamento date not null,
	descricao_significativa varchar(100) not null,
	codigo_conta int not null
);

create table historico_pagamento (
	codigo_historico int not null,
	codigo_conta int not null,
	descricacao varchar(100) not null,
	forma_pagamento varchar(1) not null -- 'D', 'C', 'D', 'P'
	plano_desejado varchar(20)
);

create table plano (
	codigo_plano int not null,
	nome_resumido varchar(100) not null,
	forma_pagamento varchar(1) not null -- 'D', 'C', 'D', 'P'
	plano_desejado varchar(20) not null
);

create table moeda (
	codigo_moeda int not null,
	nome varchar(100) not null,
	pais_moeda varchar(100) not null,
);

create table receita (
	codigo_receita int not null,
	valor numeric(10,2) not null,
	descricao_significativa varchar(100) not null,
	codigo_conta int not null
);

create table estado (
	codigo_estado int not null,
	nome varchar(100) not null,
	uf varchar(2) not null,
);

create table cidade (
	codigo_cidade int not null,
	nome varchar(100) not null,
	codigo_ibge int not null,
	codigo_estado int not null
);

create table endereco (
	codigo_endereco int not null,
	rua varchar(100) not null,
	numero_casa varchar(5) not null,
	cep varchar(8) not null,
	bairro varchar(100) not null,
	logradouro varchar(100) null,
	codigo_cidade int not null
);

create table cliente (
	nome varchar(100) not null,
	cpf varchar(11) not null,
	email varchar(100) not null,
	data_nascimento data not null,
	telefone varchar(11) not null,
	genero varchar(9) not null,
	contato varchar(100) not null,
	codigo_plano int not null,
	tipo_cliente varchar(1) not null, --  'P','E'(PESSOA OU EMPRESA)
	codigo_endereco int not null
);

create table conta (
	codigo_conta int not null,
	codigo_receita int not null,
	codigo_cliente int not null,
	saldo numeric(10, 2) not null,
	codigo_moeda int not null,
	tipo_conta varchar(20) not null
);