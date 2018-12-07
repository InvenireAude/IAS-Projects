CREATE TABLE ServiceContent (
     refId       VARCHAR(64) NOT NULL
   , tsBegin   TIMESTAMP NULL
   , request   TEXT NULL
   , response  TEXT NULL
  , CONSTRAINT C_ServiceContent_PK PRIMARY KEY (tsBegin, refId)
);

-- TODO Partition on tsBegin
