
IMPORT std::qs;
IMPORT std::default;

PROGRAM qs::getStatistics()
RETURNS SystemStats : "http://www.invenireaude.org/qsystem/stats"
EXTERNAL "libIASQSystemLib:ias_qs_lang_msgs_proxy:GetStatistics"
("qs.APP");

PROGRAM ias::esbsd::web::qs::getStatistics(VAR ctx  AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				                       VAR msg  AS GetStatistics : "http://www.invenireaude.com/esbsd/qs/api")
RETURNS GetStatistics : "http://www.invenireaude.com/esbsd/qs/api"
BEGIN

  msg.systemStats = qs::getStatistics();
  msg.systemStats.registryAlias = "qs.APP";
  RETURN msg;
END;