

IMPORT esb::broker::interface::common::handleReply;

PROGRAM esb::broker::interface::process::handleReply(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	   		  							     VAR data  AS Service  : "http://www.invenireaude.com/esbsd/services/common")
BEGIN

  esb::broker::interface::common::handleReply(ctx,data);

END;