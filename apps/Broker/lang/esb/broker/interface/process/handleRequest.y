
IMPORT esb::broker::interface::common::handleRequest;

PROGRAM esb::broker::interface::process::handleRequest(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	   		  							     VAR data  AS Service  : "http://www.invenireaude.com/esbsd/services/common")
BEGIN

  esb::broker::interface::common::handleRequest(ctx,data);

END;