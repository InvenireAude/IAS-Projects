
IMPORT std::qs;
IMPORT std::default;
IMPORT ias::esbsd::ds::collect::getServiceCalls;

PROGRAM ias::esbsd::web::collect::getMessageHistory(
  VAR ctx  AS Context  : "http://www.invenireaude.org/qsystem/workers",
	VAR msg  AS GetMessageHistory : "http://www.invenireaude.com/esbsd/collect/api")
RETURNS GetMessageHistory : "http://www.invenireaude.com/esbsd/collect/api"
BEGIN


  IF ISSET(msg.selector) THEN BEGIN
    CREATE msg.selector.paging BEGIN
      pageSize = (pageSize OR 50);
      pageOffset = (pageOffset OR 0);
    END;
    msg.messages = ias::esbsd::ds::collect::getServiceCalls(msg.selector);
  END;

  RETURN msg;
END;