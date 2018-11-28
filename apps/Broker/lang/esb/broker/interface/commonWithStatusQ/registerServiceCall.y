IMPORT std::default;

PROGRAM esb::broker::interface::common::registerServiceCall(
	VAR refId_   AS String,
	VAR msgType_ AS String,
	VAR srcAppl_ AS String,
	VAR dstAppl_ AS String,
	VAR service_ AS Service  : "http://www.invenireaude.com/esbsd/services/common",
	VAR headerOnly AS Boolean
)
BEGIN

  /* VAR data AS RegisterServiceCall : "http://www.invenireaude.com/esbsd/services/esb/collect";

  CREATE data.meta BEGIN
     refId   = refId_;
     ts      = std::getTime();
     msgType = msgType_;
     parentRefId ?= service_.header.parentId;
     srcAppl = srcAppl_;
     dstAppl = dstAppl_;
     service = TYPE(service_);
  END;

  IF headerOnly == TRUE AND ISSET(service_.header) THEN
  	 data.service.header = COPYOF(service_.header)
   ELSE
     data.service = service_;

  VAR ctx       AS Context  : "http://www.invenireaude.org/qsystem/workers";

  TRY BEGIN
    std::send("output.collect",ctx,data);
  END CATCH(VAR e AS AnyType) BEGIN

  END; */


END;




