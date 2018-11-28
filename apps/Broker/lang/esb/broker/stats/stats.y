

PROGRAM esb::broker::stats::update(VAR key     AS String,
				   					VAR value   AS Integer,
				   					VAR ts      AS DateTime)
RETURNS Record : "http://www.invenireaude.org/qsystem/workers/ec"		
EXTERNAL "libIASQSystemLib:ias_qs_lang_ec_proxy:Update"("ec.timer");


PROGRAM esb::broker::stats::readAll(VAR reset AS String)
RETURNS ARRAY OF Record : "http://www.invenireaude.org/qsystem/workers/ec"		
EXTERNAL "libIASQSystemLib:ias_qs_lang_ec_proxy:ReadAll"("ec.timer");

