PROGRAM ias::esbsd::ds::collect::insertServiceRequest(
 VAR meta AS MetaData : "http://www.invenireaude.com/esbsd/collect/api",
 VAR data  AS String
)
EXTERNAL "libIASQSystemLib:ias_qs_lang_db_proxy:WrappedStatement"
(
"ds.broker.collect",
"
INSERT INTO VW_ServiceRequest
    meta.refId     => refId
  , meta.tsBegin   => tsBegin
  , data           => request
");