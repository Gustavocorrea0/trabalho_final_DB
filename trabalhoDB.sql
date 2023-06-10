-- Scripts de Criação de Tabelas
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
	forma_pagamento varchar(1) not null, 
	plano_desejado varchar(20)
);

create table plano (
	id_plano int not null,
	nome_resumido varchar(100) not null,
	forma_pagamento varchar(1) not null, 
	plano_desejado varchar(20) not null
);

create table moeda (
	codigo_moeda int not null,
	nome varchar(100) not null,
	pais_moeda varchar(100) not null
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
	uf varchar(2) not null
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
	codigo_cliente int not null,
	nome varchar(100) not null,
	cpf varchar(11) not null,
	email varchar(100) not null,
	data_nascimento date not null,
	telefone varchar(11) not null,
	genero varchar(9) not null,
	contato varchar(100) not null,
	codigo_plano int not null,
	tipo_cliente varchar(1) not null, --  'P','E'(PESSOA OU EMPRESA)
	codigo_endereco int not null
);

create table conta (
	id_conta int not null,
	codigo_receita int not null,
	codigo_cliente int not null,
	saldo numeric(10, 2) not null,
	codigo_moeda int not null,
	tipo_conta varchar(20) not null
);

-- Scripts de Criação das Chaves Primárias

alter table despesas add constraint codigo_despesa primary key (codigo_despesa);
alter table historico_pagamento add constraint codigo_historico primary key (codigo_historico);
alter table plano add constraint id_plano primary key (id_plano);
alter table moeda add constraint codigo_moeda primary key (codigo_moeda);
alter table receita add constraint codigo_receita primary key (codigo_receita);
alter table estado add constraint codigo_estado primary key (codigo_estado);
alter table cidade add constraint codigo_cidade primary key (codigo_cidade);
alter table endereco add constraint codigo_endereco primary key (codigo_endereco);
alter table cliente add constraint codigo_cliente primary key (codigo_cliente);
alter table conta add constraint id_conta primary key (id_conta);

-- Scripts de Criação das Chaves Estrangeiras
alter table despesas add constraint codigo_conta foreign key (codigo_conta)  
	references conta (id_conta);
alter table receita add constraint codigo_conta foreign key (codigo_conta)  
	references conta (id_conta);
alter table historico_pagamento add constraint codigo_conta foreign key (codigo_conta)  
	references conta (id_conta);
alter table cliente add constraint codigo_endereco foreign key (codigo_endereco) 
	references endereco(codigo_endereco);
alter table cliente add constraint codigo_plano foreign key (codigo_plano) 
	references plano(id_plano);
alter table conta add constraint codigo_moeda foreign key (codigo_moeda) 
	references moeda (codigo_moeda);
alter table cidade add constraint codigo_estado foreign key (codigo_estado)  
	references estado (codigo_estado);
alter table endereco add constraint codigo_cidade foreign key (codigo_cidade) 
	references cidade (codigo_cidade);
alter table conta add constraint codigo_receita foreign key (codigo_receita) 
	references receita (codigo_receita);
alter table conta add constraint codigo_cliente foreign  key (codigo_cliente) 
	references cliente (codigo_cliente);
-- Scripts de Criação das Restrições Unique, Check e Index.

alter table cliente add constraint cliente_codigo_uk unique (codigo_cliente);
alter table despesas add constraint codigo_despesa_uk unique (codigo_despesa);
alter table conta add constraint conta_codigo_uk unique (id_conta); --saldo positivo
alter table plano add constraint codigo_plano_uk unique (id_plano);
alter table moeda add constraint codigo_moeda_uk unique (codigo_moeda); 
alter table receita add constraint codigo_receita_uk unique (codigo_receita);
alter table endereco add constraint codigo_endereco_uk unique (codigo_endereco);
alter table estado add constraint codigo_estado_uk unique (codigo_estado);
alter table cidade add constraint codigo_cidade_uk unique (codigo_cidade);
alter table cliente add constraint cpf_uk unique (cpf);
alter table cidade add constraint codigo_ibge_uk unique (codigo_IBGE);
alter table historico_pagamento add constraint codigo_historico_uk unique (codigo_historico);

alter table cliente add constraint codigo_cliente_positivo check (codigo_cliente > 0);
alter table despesas add constraint codigo_despesas_positivo check (codigo_despesa > 0);
alter table conta add constraint codigo_conta_positivo check (id_conta > 0);
alter table plano add constraint codigo_plano_positivo check (id_plano > 0);
alter table moeda add constraint codigo_moeda_positivo check (codigo_moeda > 0);
alter table receita add constraint codigo_receita_positivo check (codigo_receita > 0);
alter table endereco add constraint codigo_endereco_positivo check (codigo_endereco > 0);
alter table estado add constraint codigo_estado_positivo check (codigo_estado > 0);
alter table cidade add constraint codigo_cidade_positivo check (codigo_cidade > 0);
alter table historico_pagamento add constraint codigo_historico_positivo check (codigo_historico > 0);
alter table cliente add constraint checa_tipo_cliente check ( tipo_cliente in ('F', 'J') );	
alter table plano add constraint checa_tipo_forma_pagamento check ( forma_pagamento in ('DINHEIRO', 'PIX', 'CREDITO', 'DEBIDO') );
alter table cliente add constraint checa_genero check ( genero in ('FEMININO', 'MASCULINO', 'OUTRO'));
alter table receita add constraint valor_receita_positivo check (valor > 0);

create index codigo_cliente_idx on cliente (codigo_cliente);
create index codigo_despesas_idx on despesas (codigo_despesa);
create index codigo_conta_idx on conta (id_conta);
create index codigo_plano_idx on plano (id_plano);
create index codigo_moeda_idx on moeda (codigo_moeda);
create index codigo_receita_idx on receita (codigo_receita);
create index codigo_endereco_idx on endereco (codigo_endereco);
create index codigo_cidade_idx on cidade (codigo_cidade);
create index codigo_estado_idx on estado (codigo_estado);
create index codigo_historico_idx on historico_pagamento (codigo_historico);
create index cep_idx on endereco (cep);
create index nome_cidade_idx on cidade (nome);
create index codigo_ibge_idx on cidade (codigo_ibge);
create index endereco_cidade_idx on endereco (codigo_cidade);
create index cliente_endereco_idx on cliente (codigo_endereco);

-- Scripts de Criação das Restrições Default e Sequenciadores.
create sequence seq_cliente_codigo start with 1;
create sequence seq_despesas_codigo start with 1;
create sequence seq_conta_codigo start with 1;
create sequence seq_plano_codigo start with 1;
create sequence seq_moeda_codigo start with 1;
create sequence seq_receita_codigo start with 1;
create sequence seq_endereco_codigo start with 1;
create sequence seq_estado_codigo start with 1;
create sequence seq_cidade_codigo start with 1;
create sequence seq_historico_codigo start with 1;

alter table cliente alter column codigo_cliente set default nextval('seq_cliente_codigo');
alter table despesas alter column codigo_despesa set default nextval('seq_despesas_codigo');
alter table conta alter column id_conta set default nextval('seq_conta_codigo');
alter table plano alter column id_plano set default nextval('seq_plano_codigo');
alter table moeda alter column codigo_moeda set default nextval('seq_moeda_codigo');
alter table receita alter column codigo_receita set default nextval('seq_receita_codigo');
alter table endereco alter column codigo_endereco set default nextval('seq_endereco_codigo');
alter table estado alter column codigo_estado set default nextval('seq_estado_codigo');
alter table cidade alter column codigo_cidade set default nextval('seq_cidade_codigo');
alter table historico alter column codigo_historico set default nextval('seq_historico_codigo');
