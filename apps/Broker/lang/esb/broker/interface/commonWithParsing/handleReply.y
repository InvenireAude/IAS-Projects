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

   ctx.REPLY_TO = esb::broker::getAttribute(ctx.attributes, "ESB_REPLY_TO");

   VAR tsStart AS DateTime;
   VAR tsEnd   AS DateTime;

   tsStart = esb::broker::getAttribute(ctx.attributes, "ESB");
   tsEnd   = std::getTime();
   ctx.attributes=esb::broker::newAttribute("ESB_FullTime",(std::getTimeDiffMS(tsEnd,tsStart) AS String));

   std::send("input", ctx, data);



   VAR ecr AS Record : "http://www.invenireaude.org/qsystem/workers/ec";
   ecr = esb::broker::stats::update(esb::broker::getAttribute(ctx.attributes, "XMLfName"), std::getTimeDiffMS(tsEnd,tsStart), tsEnd);


   IF routing.monResponse == "FULL" THEN BEGIN
	   esb::broker::interface::common::registerServiceCall(ctx.MID, "RESPONSE", interface, service, client, routing.provider, data, (NULL AS DateTime), std::getTime(), FALSE);
   END ELSE IF routing.monResponse == "HEADER" THEN BEGIN
	   esb::broker::interface::common::registerServiceCall(ctx.MID, "RESPONSE", interface, service, client, routing.provider, data, (NULL AS DateTime), std::getTime(), TRUE);
   END;

END;