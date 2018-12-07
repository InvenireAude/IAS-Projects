IMPORT esb::broker::tools;
IMPORT esb::broker::ds::routing;
IMPORT std::qs;
IMPORT esb::broker::stats::stats;
IMPORT std::default;

PROGRAM esb::broker::interface::common::handleReply(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	   		  							    VAR data  AS Routing  : "http://www.invenireaude.org/qsystem/workers")
BEGIN

   ctx.REPLY_TO = esb::broker::getAttribute(ctx.attributes, "ESB_REPLY_TO");

   VAR tsStart AS DateTime;
   VAR tsEnd   AS DateTime;

   tsStart = esb::broker::getAttribute(ctx.attributes, "ESB");
   tsEnd   = std::getTime();

   ctx.attributes=esb::broker::newAttribute("ESB_FullTime",(std::getTimeDiffMS(tsEnd,tsStart) AS String));

   data.valid = TRUE;
   data.targets = "output.esb.collect";
   data.targets = "input";

   VAR ecr AS Record : "http://www.invenireaude.org/qsystem/workers/ec";
   ecr = esb::broker::stats::update(esb::broker::getAttribute(ctx.attributes, "XMLfName"), std::getTimeDiffMS(tsEnd,tsStart), tsEnd);

END;