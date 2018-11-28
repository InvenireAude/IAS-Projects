
DEFINE RoutingData : "http://www.invenireaude.com/esbsd/broker" AS
BEGIN
  provider AS String;
  monRequest  AS MonitoringMode : "http://www.invenireaude.com/esbsd";
  monResponse AS MonitoringMode : "http://www.invenireaude.com/esbsd";
END;

PROGRAM esb::broker::ds::fetchRouting(VAR client    AS String,
									   VAR interface AS String,
				                       VAR service   AS String)
RETURNS RoutingData : "http://www.invenireaude.com/esbsd/broker"
EXTERNAL "libIASQSystemLib:ias_qs_lang_db_proxy:WrappedStatement"
(
"ds.broker",
"SELECT ONCE 
   PROVIDER  => result.provider,
 ?  MONREQUEST => result.monRequest,
 ?  MONRESPONSE => result.monResponse
 FROM BROKER_AUTH_ROUTING
 WHERE
   client    = client    AND 
   interface = interface AND
   service   = service
");
