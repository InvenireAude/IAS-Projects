
IMPORT std::qs;
IMPORT std::default;
IMPORT ias::esbsd::ds::collect::getServiceContent;

PROGRAM ias::esbsd::web::collect::getMessageContent(
  VAR ctx  AS Context  : "http://www.invenireaude.org/qsystem/workers",
	VAR msg  AS GetMessageContent : "http://www.invenireaude.com/esbsd/collect/api")
RETURNS GetMessageContent : "http://www.invenireaude.com/esbsd/collect/api"
BEGIN


  IF ISSET(msg.selector) THEN
   ias::esbsd::ds::collect::getServiceContent(msg);

  RETURN msg;
END;