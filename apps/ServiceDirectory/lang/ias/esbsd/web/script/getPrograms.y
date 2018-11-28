
IMPORT std::typeinfo;

PROGRAM ias::esbsd::web::script::getPrograms(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				 VAR msg  AS GetPrograms : "http://www.invenireaude.com/esbsd/lang/api")
RETURNS GetPrograms : "http://www.invenireaude.com/esbsd/lang/api"
BEGIN

  WITH msg.selector DO
    msg.programs = std::getPrograms(name);
  RETURN msg;

END;