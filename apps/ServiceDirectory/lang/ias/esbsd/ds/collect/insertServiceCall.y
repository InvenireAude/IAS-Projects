PROGRAM ias::esbsd::ds::collect::insertServiceCall(
 VAR meta AS MetaData : "http://www.invenireaude.com/esbsd/collect/api"
)
EXTERNAL "libIASQSystemLib:ias_qs_lang_db_proxy:WrappedStatement"
(
"ds.broker.collect",
"INSERT INTO VW_ServiceCall
    meta.refId      => refId
  , meta.interface  => interface
  , meta.service  => service
  , meta.srcAppl  => srcAppl
  , meta.dstAppl  => dstAppl
  , meta.tsBegin  => tsBegin
  , meta.svcTime  => svcTime
");