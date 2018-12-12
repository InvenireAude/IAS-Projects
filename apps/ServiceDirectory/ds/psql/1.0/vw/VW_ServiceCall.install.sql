CREATE VIEW VW_ServiceCall AS
 SELECT
     refId
   , parentId
   , tsBegin
   , svcTime
   , service
   , interface
   , srcAppl
   , dstAppl
 FROM
  ServiceCall
;

CREATE OR REPLACE FUNCTION F_ServiceCall_IIT()
  RETURNS trigger AS
$$
BEGIN

  INSERT INTO ServiceCall(
     refId
   , parentId
   , tsBegin
   , svcTime
   , service
   , interface
   , srcAppl
   , dstAppl
  )VALUES(
     NEW.refId
   , NEW.parentId
   , NEW.tsBegin
   , NEW.svcTime
   , NEW.service
   , NEW.interface
   , NEW.srcAppl
   , NEW.dstAppl
   ) ON CONFLICT(tsBegin, refId) DO UPDATE
   SET
     svcTime   = NEW.svcTime
   , parentId  = NEW.parentId
   , service = NEW.service
   , interface = NEW.interface
   , srcAppl = NEW.srcAppl
   , dstAppl = NEW.dstAppl;
  RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER VW_ServiceCall_IIT INSTEAD OF INSERT ON VW_ServiceCall
FOR EACH ROW
EXECUTE PROCEDURE F_ServiceCall_IIT();
