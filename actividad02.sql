1
create table authority(
	name varchar(50) primary key 
);

2
create table system_user_(
	id int4 primary key,
	login varchar(50) not null,
	password varchar(60)not null,
	email varchar(254)not null,
	activated int4,
	lang_key varchar(6)not null,
	image_url varchar(256),
	activation_key varchar(20),
	reset_key varchar(20),
	reset_date timestamp,
	constraint uk_login unique (login),
	constraint uk_email unique (email)
);

3
create table user_authority(
	name_rol varchar(50),
	id_system_user int4,
	constraint fk_aut_usa foreign key (name_rol) references authority (name),
	constraint fk_sys_usa foreign key (id_system_user) references system_user_ (id),
	constraint pk_usa primary key (name_rol,id_system_user)
);

5
create table cliente(
	id int4 primary key,
	id_tipo_documento int4 not null,
	numero_documento varchar(50) not null,
	primer_nombre varchar(50)not null,
	segundo_nombre varchar(50),
	primero_apellido varchar(50)not null,
	segundo_apellido varchar(50),
	id_system_user int4 not null,
	constraint fk_user_clien foreign key (id_system_user) references system_user_ (id),
	constraint uk_cliente unique (id_tipo_documento,numero_documento),
	constraint uk_user unique (id_system_user),
	constraint fk_tido_clie foreign key (id_tipo_documento) references tipo_documento (id)																					 
);

4
create table tipo_documento(
	id int4 primary key,
	sigla varchar(40)not null,
	nombre_documento varchar(100)not null,
	estado varchar(40)not null,
	constraint uk_sigla unique (sigla),
	constraint uk_nombre_documento unique (nombre_documento)
);

6
create table log_errores(
	id int4 primary key,
	nivel varchar(400)not null,
	log_name varchar(400)not null,
	mensaje varchar(400)not null,
	fecha date not null,
	id_cliente int4 not null,
	constraint fk_clie_log_erro foreign key (id_cliente) references cliente (id)
);

7
create table log_auditoria(
	id int4 primary key,
	nivel varchar(400)not null,
	log_name varchar(400)not null,
	mensaje varchar(400)not null,
	fecha date not null,
	id_cliente int4 not null,
	constraint fk_clie_log_audi foreign key (id_cliente) references cliente (id)
);