
IMPORT esb::broker::interface::common::handleSend;

PROGRAM esb::broker::interface::event::handleRequest(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	   		  							     VAR data  AS Service  : "http://www.invenireaude.com/esbsd/services/common")
BEGIN

  esb::broker::interface::common::handleSend(ctx,data);

END;