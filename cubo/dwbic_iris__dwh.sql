
              
  
-- DA RINOMINARE IN "PROGETTO" al singolare
-- progetto_dim
drop table tb_progetti_dim
;
create table tb_progetti_dim (
  id_progetto number(10) not null primary key,
  --da rivedere eco_noneco
 -- eco_noneco varchar2(10) not null,
  competitivo varchar2(10) not null,
  stato_progetto varchar2(10) not null,
  ruolo_ateneo varchar2(10) not null,
  progetto varchar2(2000) not null,
  dt_ini  date not null,
  dt_fin  date not null,
  --inserisco l'anno presentazione domanda
  anno_domanda number(4)
  
);


-- tb_finanziatore_dim
drop table tb_finanziatore_dim
;
create table tb_finanziatore_dim (
  id_finanziatore number(10) not null primary key,
  tipologia varchar2(25) not null,
  nazione varchar2(255) not null,
  europeo varchar2(10) not null,
  ragione_sociale varchar2(2000) not null
);


-- tb_dipartimento_dim
drop table tb_dipartimento_dim
;
create table tb_dipartimento_dim (
  id_dipartimento number(10) not null primary key,
  denominazione varchar2(2000) not null
);

-- tb_ssd_dim
drop table tb_ssd_dim
;
create table tb_ssd_dim (
  id_ssd number(10) not null primary key,
  des_ssd varchar2(2000) not null
);

-- tb_area_dim
drop table tb_area_dim
;
create table tb_area_dim (
  id_area number(10) not null primary key,
  des_area varchar2(2000) not null
);

-- tb_responsabile_dim
-- inserisco campo SESSO varchar2(10) not null
drop table tb_responsabile_dim
;
create table tb_responsabile_dim (
  id_responsabile number(10) not null primary key,
  responsabile varchar2(2000) not null,
  data_nascita date not null,
  person_id varchar2(25) not null,
  sesso varchar2(10) not null
);

-- tb_ruolo_dim
drop table tb_ruolo_dim
;
create table tb_ruolo_dim (
  id_ruolo number(10) not null primary key,
  des_ruolo varchar2(2000) not null
);


-- tb_macrotipologia_dim
drop table tb_macrotipologia_dim
;
create table tb_macrotipologia_dim (
  id_macrotipologia varchar2(10) not null primary key,
  des_macrotipologia varchar2(2000) not null
);


-- tb_tipologia_dim
drop table tb_tipologia_dim
;
create table tb_tipologia_dim (
  id_tipologia varchar2(10) not null primary key,
  des_tipologia varchar2(2000) not null
);

---- creazione fact table
drop table tb_progetti_fact
;
create table tb_progetti_fact (
  id_progetto number(10) not null,
  id_finanziatore number(10) not null,
  id_dipartimento number(10) not null,
  id_time number(28) not null,
  id_ssd number(10) not null,  --ODS_L1_RM_PERSON_POSITION_last.rm_org_unit_id
  id_area number(10) not null,
  id_ruolo number(10) not null,
  id_responsabile number(10) not null,
  id_macrotipologia varchar2(10) not null, --NAZ / INTERNAZ
  id_tipologia varchar2(10) not null,  -- sottotipologia
  --- measures
  progetti_pres_count number(10), -- nuova misura progetti presentati (non in corso)
  progetti_attivi_count number(10),	-- nuova misura progetti attivi (in corso)
  progetti_imp number(13,2),
  progetti_durata_mm number(20),
  CONSTRAINT "PK_PROGETTI_FACT" PRIMARY KEY (id_progetto, id_finanziatore, id_dipartimento, id_time, id_ssd, id_area, id_ruolo, id_responsabile, id_macrotipologia, id_tipologia)
  );
  
  
  alter table tb_progetti_fact
  add constraint fk_progetti_dim foreign key (id_progetto)
    references tb_progetti_dim (id_progetto) enable;
    
  alter table tb_progetti_fact
  add constraint fk_finanziatore_dim foreign key (id_finanziatore)
    references tb_finanziatore_dim (id_finanziatore) enable;    
    
  alter table tb_progetti_fact
  add constraint fk_dipartimento_dim foreign key (id_dipartimento)
    references tb_dipartimento_dim (id_dipartimento) enable;    
      
  alter table tb_progetti_fact
  add constraint fk_ssd_dim foreign key (id_ssd)
    references tb_ssd_dim (id_ssd) enable;    
    
  alter table tb_progetti_fact
  add constraint fk_area_dim foreign key (id_area)
    references tb_area_dim (id_area) enable;    
    
  alter table tb_progetti_fact
  add constraint fk_ruolo_dim foreign key (id_ruolo)
    references tb_ruolo_dim (id_ruolo) enable;        

  alter table tb_progetti_fact
  add constraint fk_responsabile_dim foreign key (id_responsabile)
    references tb_responsabile_dim (id_responsabile) enable;     
    
  alter table tb_progetti_fact
  add constraint fk_macrotipo_dim foreign key (id_macrotipologia)
    references tb_macrotipologia_dim (id_macrotipologia) enable;         
    
  alter table tb_progetti_fact
  add constraint fk_tipologia_dim foreign key (id_tipologia)
    references tb_tipologia_dim (id_tipologia) enable;     
    
    
    
  
  
  