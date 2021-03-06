CREATE TABLE BROKER_AUTH_ROUTING(

  CLIENT    VARCHAR(64),
  INTERFACE VARCHAR(64),
  SERVICE   VARCHAR(64),
  PROVIDER  VARCHAR(64),
  MONREQUEST  VARCHAR(16),
  MONRESPONSE VARCHAR(16),
  PRIMARY KEY(CLIENT, INTERFACE, SERVICE)
);

CREATE TABLE BROKER_PROPERTIES(

  PNAME   VARCHAR(64),
  PVALUE  VARCHAR(64),

  PRIMARY KEY(PNAME)
);
