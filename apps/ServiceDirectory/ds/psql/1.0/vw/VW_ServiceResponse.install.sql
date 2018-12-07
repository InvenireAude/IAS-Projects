CREATE VIEW VW_ServiceResponse AS
 SELECT
   refId
 , tsBegin
 , response
FROM
  ServiceContent
;

CREATE OR REPLACE FUNCTION F_ServiceResponse_IIT()
  RETURNS trigger AS
$$
BEGIN

  INSERT INTO ServiceContent(
     refId
   , tsBegin
   , Response
  )VALUES(
     NEW.refId
   , NEW.tsBegin
   , NEW.Response
   ) ON CONFLICT(tsBegin, refId) DO UPDATE
   SET
     response   = NEW.response;

  RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER VW_ServiceResponse_IIT INSTEAD OF INSERT ON VW_ServiceResponse
FOR EACH ROW
EXECUTE PROCEDURE F_ServiceResponse_IIT();
