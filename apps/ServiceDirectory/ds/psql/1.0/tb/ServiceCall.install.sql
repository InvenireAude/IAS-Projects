CREATE TABLE ServiceCall (
     refId     VARCHAR(64) NOT NULL
  ,  tsBegin   TIMESTAMP NULL
  ,  svcTime   NUMERIC NULL
  ,  service   VARCHAR(64) NOT NULL
  ,  interface VARCHAR(64) NOT NULL
  ,  srcAppl   VARCHAR(64) NOT NULL
  ,  dstAppl   VARCHAR(64) NOT NULL
  , CONSTRAINT C_ServiceCall_PK PRIMARY KEY (tsBegin, refId)
);

-- TODO Partition on tsBegin
