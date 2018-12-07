
IMPORT std::default;
IMPORT ias::esbsd::ds::collect::insertServiceCall;

IMPORT ias::esbsd::ds::collect::insertServiceRequest;
IMPORT ias::esbsd::ds::collect::insertServiceResponse;

PROGRAM ias::esbsd::svc::collect::insertMessage(VAR ctx      AS Context       : "http://www.invenireaude.org/qsystem/workers",
		   	         	                              VAR content  AS String)
BEGIN


  VAR meta AS MetaData : "http://www.invenireaude.com/esbsd/collect/api";

  WITH meta DO BEGIN
    msgType = "REQUEST";
    refId = ctx.MID;

    WITH a AS ctx.attributes DO
      IF a.name == "INTERFACE" THEN
        interface = a.value
    ELSE IF a.name == "TYPE" THEN
        service = a.value
    ELSE IF a.name == "SRCAPPL" THEN
        srcAppl = a.value
    ELSE IF a.name == "ESB_DST_APPL" THEN
        dstAppl = a.value
    ELSE IF a.name == "ESB_FullTime" THEN BEGIN
       msgType = "RESPONSE";
       svcTime = a.value;
    END
    ELSE IF a.name == "ESB" THEN
       tsBegin = a.value;


  END;

  ias::esbsd::ds::collect::insertServiceCall(meta);

  IF meta.msgType == "REQUEST" THEN
      ias::esbsd::ds::collect::insertServiceRequest(meta, content)
    ELSE
      ias::esbsd::ds::collect::insertServiceResponse(meta, content);


  //std::save("stdout",meta);
  //std::save("stdout",content);

END;