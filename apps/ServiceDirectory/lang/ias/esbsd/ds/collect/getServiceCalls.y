PROGRAM ias::esbsd::ds::collect::getServiceCalls(
 VAR selector AS Selector : "http://www.invenireaude.com/esbsd/collect/api"
)
RETURNS ARRAY OF MetaData : "http://www.invenireaude.com/esbsd/collect/api"
EXTERNAL "libIASQSystemLib:ias_qs_lang_db_proxy:WrappedStatement"
(
"ds.broker.collect",
"
SELECT ARRAY INTO result PAGE(selector.paging.pageOffset, selector.paging.pageSize)
    refId      => refId
  , interface  => interface
  , service    => service
  , srcAppl    => srcAppl
  , dstAppl    => dstAppl
  , tsBegin    => tsBegin
  , ? svcTime  => svcTime
FROM VW_ServiceCall
WHERE
  tsBegin <= selector.tsBeginTo   AND
  tsBegin >= selector.tsBeginFrom AND
? srcAppl   = selector.srcAppl    AND
? dstAppl   = selector.dstAppl    AND
? interface = selector.interface  AND
? service   = selector.service    AND
? refId     = selector.refId
");