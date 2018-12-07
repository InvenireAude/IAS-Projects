CREATE VIEW VW_ServiceRequest AS
 SELECT
   refId
 , tsBegin
 , request
FROM
  ServiceContent
;

CREATE OR REPLACE FUNCTION F_ServiceRequest_IIT()
  RETURNS trigger AS
$$
BEGIN

  INSERT INTO ServiceContent(
     refId
   , tsBegin
   , request
  )VALUES(
     NEW.refId
   , NEW.tsBegin
   , NEW.request
   ) ON CONFLICT(tsBegin, refId) DO UPDATE
   SET
     request   = NEW.request;

  RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER VW_ServiceRequest_IIT INSTEAD OF INSERT ON VW_ServiceRequest
FOR EACH ROW
EXECUTE PROCEDURE F_ServiceRequest_IIT();
