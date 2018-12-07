CREATE VIEW VW_ServiceContent AS
 SELECT
   refId
 , tsBegin
 , request
 , response
FROM
  ServiceContent
;
