
/* ************************************** */

PROGRAM ias::esbsd::gen::inc::insertRouting(VAR client     AS String,
											VAR interface AS String,
											VAR service   AS String,
											VAR provider  AS String,
											VAR monRequest  AS MonitoringMode : "http://www.invenireaude.com/esbsd",
     										VAR monResponse AS MonitoringMode : "http://www.invenireaude.com/esbsd")
EXTERNAL "libIASQSystemLib:ias_qs_lang_db_proxy:WrappedStatement"
("ds.broker","
  INSERT INTO BROKER_AUTH_ROUTING
    client    => CLIENT,
    interface => INTERFACE,
    service   => SERVICE,
    provider  => PROVIDER,
 ?  monRequest => monRequest,
 ?  monResponse => monResponse
");

/* ************************************** */

PROGRAM ias::esbsd::gen::inc::insertProperty(VAR pname   AS String,
										     VAR pvalue  AS String)
EXTERNAL "libIASQSystemLib:ias_qs_lang_db_proxy:WrappedStatement"
("ds.broker","
  INSERT INTO BROKER_PROPERTIES
    pname   => PNAME,
    pvalue  => PVALUE
");