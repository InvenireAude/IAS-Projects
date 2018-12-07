

IMPORT esb::broker::interface::common::handleReply;

PROGRAM esb::broker::interface::trans::handleReply(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	   		  					      		                  VAR data AS Routing  : "http://www.invenireaude.org/qsystem/workers")
BEGIN

  esb::broker::interface::common::handleReply(ctx,data);

END;