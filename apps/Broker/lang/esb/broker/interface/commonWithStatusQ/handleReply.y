IMPORT esb::broker::tools;
IMPORT esb::broker::ds::routing;
IMPORT std::qs;
IMPORT esb::broker::stats::stats;
IMPORT std::default;
IMPORT esb::broker::interface::common::registerServiceCall;

PROGRAM esb::broker::interface::common::handleReply(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	   		  							    VAR data  AS Service  : "http://www.invenireaude.com/esbsd/services/common")
BEGIN

   VAR statData   AS Service  : "http://www.invenireaude.com/esbsd/services/common";
   VAR statCtx    AS Context  : "http://www.invenireaude.org/qsystem/workers";

   VAR client      AS String;
   VAR service     AS String;
   VAR interface   AS String;
   VAR routing     AS RoutingData : "http://www.invenireaude.com/esbsd/broker";

   interface = esb::broker::getAttribute(ctx.attributes, "INTERFACE");
   service   = esb::broker::getAttribute(ctx.attributes, "XMLfName");
   client    = esb::broker::getAttribute(ctx.attributes, "SRCAPPL");

   routing    = esb::broker::ds::fetchRouting(client, interface, service);

   statCtx.MID=ctx.CID;

   statData=std::receive("input.status", statCtx);

   ctx.REPLY_TO = esb::broker::getAttribute(ctx.attributes, "ESB_REPLY_TO");

   std::send("input", ctx, data);

   VAR tsStart AS DateTime;
   VAR tsEnd   AS DateTime;

   tsStart = esb::broker::getAttribute(ctx.attributes, "ESB");
   tsEnd   = std::getTime();

   VAR ecr AS Record : "http://www.invenireaude.org/qsystem/workers/ec";
   ecr = esb::broker::stats::update(esb::broker::getAttribute(ctx.attributes, "XMLfName"), std::getTimeDiffMS(tsEnd,tsStart), tsEnd);


   IF routing.monResponse == "FULL" THEN BEGIN
	   esb::broker::interface::common::registerServiceCall(ctx.MID, "RESPONSE", client, routing.provider, data, FALSE);
   END ELSE IF routing.monResponse == "HEADER" THEN BEGIN
	   esb::broker::interface::common::registerServiceCall(ctx.MID, "RESPONSE", client, routing.provider, data, TRUE);
   END;

END;