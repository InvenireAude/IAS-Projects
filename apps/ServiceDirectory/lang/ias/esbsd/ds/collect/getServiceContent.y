PROGRAM ias::esbsd::ds::collect::getServiceContent(
  VAR msg  AS GetMessageContent : "http://www.invenireaude.com/esbsd/collect/api"
)
EXTERNAL "libIASQSystemLib:ias_qs_lang_db_proxy:WrappedStatement"
(
"ds.broker.collect",
"
SELECT ONCE
  ? response => msg.response
, ? request  => msg.request
FROM VW_ServiceContent
WHERE

  refId    = msg.selector.refId
");