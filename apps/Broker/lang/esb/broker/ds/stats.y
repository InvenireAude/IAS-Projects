


PROGRAM esb::broker::ds::insertStats(VAR ts AS DateTime, VAR r AS Record : "http://www.invenireaude.org/qsystem/workers/ec")
EXTERNAL "libIASQSystemLib:ias_qs_lang_db_proxy:WrappedStatement"
(
"ds.stats",
"INSERT INTO BROKER_STATS
   ts       => ts,
   r.key    => service,
   r.count  => count,
   r.min    => min,
   r.max    => max,
   r.avg    => avg
");