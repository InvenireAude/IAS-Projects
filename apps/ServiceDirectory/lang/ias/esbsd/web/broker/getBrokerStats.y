IMPORT std::qs;
IMPORT std::default;

PROGRAM esb::broker::stats::readAll(VAR reset AS Boolean)
RETURNS ARRAY OF Record : "http://www.invenireaude.org/qsystem/workers/ec"
EXTERNAL "libIASQSystemLib:ias_qs_lang_ec_proxy:ReadAll"("ec.timer");


PROGRAM ias::esbsd::web::broker::getBrokerStats(VAR ctx  AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				                            VAR msg  AS GetBrokerStats : "http://www.invenireaude.com/esbsd/broker/api")
RETURNS GetBrokerStats : "http://www.invenireaude.com/esbsd/broker/api"
BEGIN

 msg.records = esb::broker::stats::readAll(FALSE);

 RETURN msg;
END;