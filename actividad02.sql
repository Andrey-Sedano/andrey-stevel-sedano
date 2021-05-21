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

8
create table estado_formacion(
	id int4 primary key,
	nombre_estado varchar(40)not null,
	estado varchar(40)not null,
	constraint uk_nombre_estado unique (nombre_estado)
);

9
create table estado_ficha(
	id int4 primary key,
	nombre_estado varchar(20)not null,
	estado int2 not null,
	constraint uk_nombre1_estado unique (nombre_estado)
);

10
create table jornada(
	id int4 primary key,
	sigla_jornada varchar(20)not null,
	nombre_jornada varchar(40)not null,
	descripcion varchar(100)not null,
	imagen_url varchar(1000),
	estado varchar(40)not null,
	constraint uk_sigla_jornada unique (sigla_jornada),
	constraint uk_nombre_jornada unique (nombre_jornada)
);

11
create table nivel_formacion(
	id int4 primary key,
	nivel varchar(40),
	estado varchar(40),
	constraint uk_nivel unique (nivel)
);

12
create table programa(
	id int4 primary key,
	codigo varchar(40)not null,
	version varchar(40)not null,
	nombre varchar(500)not null,
	sigla varchar(40)not null,
	estado varchar(40)not null,
	id_nivel_formacion int4 not null,
	constraint fk_nifo_prog foreign key (id_nivel_formacion) references nivel_formacion (id),
	constraint uk_programa unique (codigo,version)
);

13
create table ficha(
	id int4 primary key,
	id_programa int4 not null,
	numero_ficha varchar(100)not null,
	fecha_inicio date not null,
	fecha_fin date not null,
	ruta varchar(40) not null,
	id_estado_ficha int4 not null,
	id_jornada int4 not null,
	constraint fk_prog_fich foreign key (id_programa) references programa (id),
	constraint fk_exfi_fich foreign key (id_estado_ficha) references estado_ficha (id),
	constraint fk_jorn_fich foreign key (id_jornada) references jornada (id),
	constraint uk_ficha unique (numero_ficha)
);

14
create table aprendiz(
	id int4 primary key,
	id_cliente int4 not null,
	id_ficha int4 not null,
	id_estado_formacion int4 not null,
	constraint fk_clie_apre foreign key (id_cliente) references cliente (id),
	constraint fk_esta_apre foreign key (id_ficha) references estado_formacion (id),
	constraint fk_fich_apre foreign key (id_estado_formacion) references ficha (id),
	constraint uk_aprendiz unique (id_cliente,id_ficha)
);

15
create table trimestre(
	id int4 primary key,
	nombre_trimestre int4 not null,
	id_jornada int4 not null,
	id_nivel_formacion int4 not null,
	estado varchar(40)not null,
	constraint fk_jorn_trim foreign key (id_jornada) references jornada (id),
	constraint fk_nifo_trim foreign key (id_nivel_formacion) references nivel_formacion (id),
	constraint uk_trimestre unique (nombre_trimestre,id_jornada,id_nivel_formacion)
);

16
create table ficha_has_trimestre(
	id int4 primary key,
	id_ficha int4 not null,
	id_trimestre int4 not null,
	constraint fk_fi_fihas foreign key (id_ficha) references ficha (id),
	constraint fk_trim_fitr foreign key (id_trimestre) references trimestre (id),
	constraint uk_ficha_has_trimestre unique (id_ficha,id_trimestre)
);

17
create table planeacion(
	id int4 primary key,
	codigo varchar(40)not null,
	fecha date not null,
	estado varchar(40)not null,
	constraint uk_codigo unique (codigo)
);

18
create table ficha_planeacion(
	id int4 primary key,
	id_ficha int4 not null,
	id_planeacion int4 not null,
	estado varchar(40)not null,
	constraint fk_fi_fipla foreign key (id_ficha) references ficha (id),
	constraint fk_pla_fipla foreign key (id_planeacion) references planeacion (id),
	constraint uk_ficha_planeacion unique (id_ficha,id_planeacion)
);

19
create table competencia(
	id int4 primary key,
	id_programa int4 not null,
	codigo_competencia varchar(50)not null,
	denominacion varchar(1000)not null,
	constraint fk_prog_comp foreign key (id_programa) references programa (id),
	constraint uk_competencia unique (id_programa,codigo_competencia)
);

20
create table resultado_aprendizaje(
	id int4 primary key,
	codigo_resultado varchar(40) not null,
	id_competencia int4 not null,
	denominacion varchar(1000) not null,
	constraint fk_com_reap foreign key (id_competencia) references competencia (id),
	constraint uk_resultado_aprendizaje unique (codigo_resultado,id_competencia)
);


21
create table resultados_vistos(
	id int4 primary key,
	id_resultado_aprendizaje int4 not null,
	id_ficha_has_trimestre int4 not null,
	id_planeacion int4 not null,
	constraint fk_fitr_revi foreign key (id_ficha_has_trimestre) references ficha_has_trimestre (id),
	constraint fk_pla_revi foreign key (id_planeacion) references planeacion (id),
	constraint fk_reap_revi foreign key (id_resultado_aprendizaje) references resultado_aprendizaje (id),
	constraint uk_resultados_vistos unique (id_ficha_has_trimestre,id_planeacion,id_resultado_aprendizaje)
);

22
create table programacion_trimestre(
	id int4 primary key,
	id_resultado_aprendizaje int4 not null,
	id_trimestre int4 not null,
	id_planeacion int4 not null,
	constraint fk_reap_pltr foreign key (id_resultado_aprendizaje) references resultado_aprendizaje (id),
	constraint fk_plan_pltr foreign key (id_planeacion) references planeacion (id),
	constraint fk_trim_pltr foreign key (id_trimestre) references trimestre (id),
	constraint uk_programacion_trimestre unique (id_resultado_aprendizaje,id_trimestre,id_planeacion)
);

23
create table proyecto(
	id int4 primary key,
	codigo varchar(40)not null,
	nombre varchar(500) not null,
	estado varchar(40)not null,
	id_programa int4 not null,
	constraint fk_prog_proy foreign key (id_programa) references programa (id),
	constraint uk_codigo1 unique (codigo)
);

24
create table fase(
	id int4 primary key,
	id_proyecto int4 not null,
	nombre varchar(40)not null,
	estado varchar(40)not null,
	constraint fk_proy_fase foreign key (id_proyecto) references proyecto (id),
	constraint uk_fase unique (id_proyecto,nombre)
);

25
create table actividad_proyecto(
	id int4 primary key,
	id_fase int4 not null,
	numero_actividad int4 not null,
	descripcion_actividad varchar(400)not null,
	estado varchar(40)not null,
	constraint fk_fase_acti foreign key (id_fase) references fase (id),
	constraint uk_actividad_proyecto unique (id_fase,numero_actividad)
);



26
create table actividad_planeacion(
	id int4 primary key,
	id_actividad_proyecto int4 not null,
	id_programacion_trimestre int4 not null,
	constraint fk_prtr_acpl foreign key (id_programacion_trimestre) references programacion_trimestre (id),
	constraint fk_acpr_acpl foreign key (id_actividad_proyecto) references actividad_proyecto (id),
	constraint uk_actividad_planeacion unique (id_programacion_trimestre,id_actividad_proyecto)
);