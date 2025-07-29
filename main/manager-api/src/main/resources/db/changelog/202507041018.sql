DROP TABLE IF EXISTS ai_agent_voice_print;
create table ai_agent_voice_print (
  id varchar(32) NOT NULL COMMENT 'Voice Print ID',
  agent_id varchar(32)  NOT NULL COMMENT 'Associated Agent ID',
  source_name varchar(50)  NOT NULL COMMENT 'Name of Voice Print Source Person',
  introduce varchar(200) COMMENT 'Description of Voice Print Source Person',
  create_date DATETIME COMMENT 'Creation Time',
  creator bigint COMMENT 'Creator',
  update_date DATETIME COMMENT 'Update Time',
  updater bigint COMMENT 'Updater',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Agent Voice Print Table'