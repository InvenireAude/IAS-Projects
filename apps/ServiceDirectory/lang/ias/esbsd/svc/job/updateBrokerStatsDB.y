
IMPORT std::default;
IMPORT ias::esbsd::ds::broker::insertStats;

PROGRAM esb::broker::stats::readAll(VAR reset AS Boolean)
RETURNS ARRAY OF Record : "http://www.invenireaude.org/qsystem/workers/ec"
EXTERNAL "libIASQSystemLib:ias_qs_lang_ec_proxy:ReadAll"("ec.timer");


PROGRAM ias::esbsd::svc::job::updateBrokerStatsDB(VAR ctx   AS Context       : "http://www.invenireaude.org/qsystem/workers",
		   	         	                                VAR ctrl  AS DaemonControl : "http://www.invenireaude.org/qsystem/workers")
BEGIN

 VAR roundTo AS Integer;
 VAR lastTs AS DateTime;
 VAR ts AS DateTime;

 VAR samples AS ARRAY OF Record : "http://www.invenireaude.org/qsystem/workers/ec";

 roundTo = 60 * 15;

 lastTs = NULL;
 lastTs ?= ctrl.applicationData;

 ctrl.applicationData = std::getTime();

 IF ISNULL(lastTs) THEN
  RETURN;

 ts = ((std::getTime() AS Integer) / roundTo) * roundTo;
 lastTs = ((lastTs AS Integer) / roundTo) * roundTo;

 IF ts == lastTs THEN
   RETURN;

 samples = esb::broker::stats::readAll(FALSE);

 WITH s AS samples DO BEGIN
   ias::esbsd::ds::broker::insertStats(ts, s);
 END;

END;