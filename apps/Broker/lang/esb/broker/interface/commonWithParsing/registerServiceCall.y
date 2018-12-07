IMPORT std::default;

PROGRAM esb::broker::interface::common::registerServiceCall(
	VAR refId_     AS String,
	VAR msgType_   AS String,
  VAR interface_ AS String,
  VAR service_   AS String,
	VAR srcApp_   AS String,
	VAR dstApp_   AS String,
	VAR data_      AS Service  : "http://www.invenireaude.com/esbsd/services/common",
  VAR tsBegin_   AS DateTime,
  VAR tsEnd_     AS DateTime,
	VAR headerOnly AS Boolean
)
BEGIN

  VAR data AS RegisterServiceCall : "http://www.invenireaude.com/esbsd/esb/collect";

  CREATE data.meta BEGIN
     refId   = refId_;

     IF NOT ISNULL(tsBegin_) THEN
       tsBegin = tsBegin_;

     IF NOT ISNULL(tsEnd_) THEN
       tsEnd = tsEnd_;

     msgType = msgType_;
  //   parentRefId ?= service_.header.parentId;
     srcApp = srcApp_;
     dstApp = dstApp_;
     service = service_;
     interface = interface_;
  END;

  IF headerOnly == TRUE AND ISSET(service_.header) THEN
  	 data.content = COPYOF(service_.header)
   ELSE
     data.content = service_;

  VAR ctx       AS Context  : "http://www.invenireaude.org/qsystem/workers";

  TRY BEGIN
    std::send("output.collect",ctx,data);
  END CATCH(VAR e AS AnyType) BEGIN

  END;


END;





