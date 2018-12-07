PROGRAM ias::esbsd::ds::collect::insertServiceResponse(
 VAR meta AS MetaData : "http://www.invenireaude.com/esbsd/collect/api",
 VAR data  AS String
)
EXTERNAL "libIASQSystemLib:ias_qs_lang_db_proxy:WrappedStatement"
(
"ds.broker.collect",
"
INSERT INTO VW_ServiceResponse
    meta.refId      => refId
  , meta.tsBegin    => tsBegin
  , data       => response
");