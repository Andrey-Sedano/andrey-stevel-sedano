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


27
create table tipo_ambiente(
	id int4 primary key,
	tipo varchar(50) not null,
	descripcion varchar(100)not null,
	estado varchar(40) not null,
	constraint uk_tipo_ambiente unique (tipo)
);

28
create table sede(
	id int4 primary key,
	nombre_sede varchar(50)not null,
	direccion varchar(400)not null,
	estado varchar(40)not null,
	constraint uk_sede unique (nombre_sede)
);

29
create table ambiente(
	id int4 primary key,
	id_sede int4 not null,
	numero_ambiente varchar(50)not null,
	descripcion varchar(1000)not null,
	estado varchar(40) not null,
	limitacion varchar(40)not null,
	id_tipo_ambiente int4 not null,
	constraint fk_tiam_ambi foreign key (id_tipo_ambiente) references tipo_ambiente (id),
	constraint fk_sede_ambi foreign key (id_sede) references sede (id),
	constraint uk_ambiente unique (id_sede,numero_ambiente)	
); 

30
create table limitacion_ambiente(
	id int4 primary key,
	id_resultado_aprendizaje int4 not null,
	id_ambiente int4 not null,
	constraint fk_ambi_liam foreign key (id_ambiente) references ambiente (id),
	constraint fk_reap_liam foreign key (id_resultado_aprendizaje) references resultado_aprendizaje (id),
	constraint uk_limitacion_ambiente unique (id_resultado_aprendizaje,id_ambiente)
);

31
create table lista_chequeo(
	id int4 primary key,
	id_programa int4 not null,
	lista varchar(50) not null,
	estado int4 not null,
	constraint fk_prog_lich foreign key (id_programa) references programa (id),
	constraint uk_lista unique (lista)
);

32
create table valoracion(
	id int4 primary key,
	tipo_valoracion varchar(50)not null,
	estado varchar(40)not null,
	constraint uk_valoracion unique (tipo_valoracion)
);

33
create table grupo_proyecto(
	id int4 primary key,
	id_ficha int4 not null,
	numero_grupo int4 not null,
	nombre_proyecto varchar(300)not null,
	estado_grupo_proyecto varchar(40)not null,
	constraint fk_fich_grup_proy foreign key (id_ficha) references ficha (id),
	constraint uk_grupo_proyecto unique (id_ficha,numero_grupo)
);

34
create table lista_ficha(
	id int4 primary key,
	id_ficha int4 not null,
	id_lista_chequeo int4 not null,
	estado varchar(40)not null,
	constraint fk_lich_lifc_ foreign key (id_lista_chequeo) references lista_chequeo (id),
	constraint fk_fic_lifi foreign key (id_ficha) references ficha (id),
	constraint uk_lista_ficha unique (id_ficha,id_lista_chequeo)
	
);

35
create table observacion_general(
	id int4 primary key,
	numero int4 not null,
	id_grupo_proyecto int4 not null,
	observacion varchar(500)not null,
	jurado varchar(500)not null,
	fecha timestamp not null,
	id_cliente int4 not null,
	constraint fk_grpr_obge foreign key (id_grupo_proyecto) references grupo_proyecto (id),
	constraint fk_clie_obge foreign key (id_cliente) references cliente (id),
	constraint uk_observacion_general unique (numero,id_grupo_proyecto)
);

36
create table integrantes_grupo(
	id int4 primary key,
	id_aprendiz int4 not null,
	id_grupo_proyecto int4 not null,
	constraint fk_apre_ingr foreign key (id_aprendiz) references aprendiz (id),
	constraint fk_grpr_ingr foreign key (id_grupo_proyecto) references grupo_proyecto (id),
	constraint uk_integrantes_grupo unique (id_aprendiz,id_grupo_proyecto)
);

37
create table item_lista(
	id int4 primary key,
	id_lista_chequeo int4 not null,
	numero_item int4 not null,
	pregunta varchar(1000) not null,
	id_resultado_aprendizaje int4 not null,
	constraint fk_lich_itli foreign key (id_lista_chequeo) references lista_chequeo (id),
	constraint fk_reap_itli foreign key (id_resultado_aprendizaje) references resultado_aprendizaje (id),
	constraint uk_item_lista unique (id_lista_chequeo,numero_item)
);

38
create table respuesta_grupo(
	id int4 primary key,
	id_item_lista int4 not null,
	id_grupo_proyecto int4 not null,
	id_valoracion int4 not null,
	fecha timestamp not null,
	constraint fk_grpr_regr foreign key (id_grupo_proyecto) references grupo_proyecto (id),
	constraint fk_val_regr foreign key (id_valoracion) references valoracion (id),
	constraint fk_itli_regr foreign key (id_item_lista) references item_lista (id),
	constraint uk_respuesta_grupo unique (id_item_lista,id_grupo_proyecto)
);

39
create table observacion_respuesta(
	id int4 primary key,
	numero_observacion int4 not null,
	id_respuesta_grupo int4 not null,
	observacion varchar(400)not null,
	jurados varchar(400)not null,
	fecha timestamp not null,
	id_cliente int4 not null,
	constraint fk_clie_obre foreign key (id_cliente) references cliente (id),
	constraint fk_regr_obre foreign key (id_respuesta_grupo) references respuesta_grupo (id),
	constraint uk_observacion_respuesta unique (numero_observacion,id_respuesta_grupo)
);

40
create table year(
	id int4 primary key,
	number_year int4 not null,
	estado varchar(40) not null,
	constraint uk_year unique (number_year)
);

41
create table area(
	id int4 primary key,
	nombre_area varchar(40)not null,
	estado varchar(40)not null,
	url_logo varchar(1000),
	constraint uk_area unique (nombre_area)
);

42
create table instructor(
	id int4 primary key,
	id_cliente int4 not null,
	estado varchar(40)not null,
	constraint fk_clien_inst foreign key (id_cliente) references cliente (id),
	constraint uk_instructor unique (id_cliente)
);

43
create table vinculacion(
	id int4 primary key,
	tipo_vinculacion varchar(40) not null,
	horas int4 not null,
	estado varchar(40)not null,
	constraint uk_vinculacion unique (tipo_vinculacion)
);

44
create table jornada_instructor(
	id int4 primary key,
	nombre_jornada varchar(80) not null,
	descripcion varchar(200)not null,
	estado varchar(40)not null,
	constraint uk_nombre_jornada1 unique (nombre_jornada)
);

45
create table area_instructor(
	id int4 primary key,
	id_area int4 not null,
	id_instructor int4 not null,
	estado varchar(40) not null,
	constraint fk_intr_esin foreign key (id_instructor) references instructor (id),
	constraint fk_area_esin foreign key (id_area) references area (id),
	constraint uk_area_instructor unique (id_area,id_instructor)
);

46
create table vinculacion_instructor(
	id int4 primary key,
	id_year int4 not null,
	fecha_inicio date not null,
	fecha_fin date not null,
	id_vinculacion int4 not null,
	id_instructor int4 not null,
	constraint fk_year_vins foreign key (id_year) references year (id),
	constraint fk_ins_vins foreign key (id_instructor) references instructor (id),
	constraint fk_vinc_vins foreign key (id_vinculacion) references vinculacion (id),
	constraint uk_vinculacion_instructor unique (id_year,fecha_inicio,fecha_fin,id_vinculacion,id_instructor)
); 

47
create table disponibilidad_horaria(
	id int4 primary key,
	id_jornada_instructor int4 not null,
	id_vinculacion_instructor int4 not null,
	constraint fk_vins_diho foreign key (id_vinculacion_instructor) references vinculacion_instructor (id),
	constraint fk_jorn_diho foreign key (id_jornada_instructor) references jornada_instructor (id),
	constraint uk_disponibilidad_horaria unique (id_jornada_instructor,id_vinculacion_instructor)
);

48
create table disponibilidad_competencia(
	id int4 primary key,
	id_competencia int4 not null,
	id_vinculacion_instructor int4 not null,
	constraint fk_comp_disco foreign key (id_competencia) references competencia (id),
	constraint fk_vins_disco foreign key (id_vinculacion_instructor) references vinculacion_instructor (id),
	constraint uk_disp_comp unique (id_competencia,id_vinculacion_instructor)
);

49
create table dia(
	id int4 primary key,
	nombre_dia varchar(40) not null,
	estado varchar(40)not null,
	constraint uk_dia unique (nombre_dia)
);

50
create table dia_jornada(
	id int4 primary key,
	id_jornada_instructores int4 not null,
	id_dia int4 not null,
	hora_inicio int4 not null,
	hora_fin int4 not null,
	constraint fk_join_diajo foreign key (id_jornada_instructores) references jornada_instructor (id),
	constraint fk_dia_diajo foreign key (id_dia) references dia(id),
	constraint uk_dia_jornada unique (id_jornada_instructores,id_dia,hora_inicio,hora_fin)
);










