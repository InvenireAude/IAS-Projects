
IMPORT esb::broker::interface::common::handleRequest;

PROGRAM esb::broker::interface::raw::handleRequest(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	   		  							                     VAR data AS Routing  : "http://www.invenireaude.org/qsystem/workers")
BEGIN

  esb::broker::interface::common::handleRequest(ctx,data);

END;