
IMPORT std::adhoc;
IMPORT std::default;

DEFINE TestProgram : "http://www.invenireaude.com/esbsd/adhoc" AS BEGIN

  name    AS String;
  source  AS String;

  argument     AS AnyType;
  result       AS AnyType;

  exception    AS AnyType;

END;

PROGRAM ias::esbsd::web::adhoc::executeProgram(
  VAR  ctx         AS Context  : "http://www.invenireaude.org/qsystem/workers",
	VAR  msg         AS TestProgram : "http://www.invenireaude.com/esbsd/adhoc")
RETURNS TestProgram : "http://www.invenireaude.com/esbsd/adhoc"
BEGIN

 TRY BEGIN
  msg.result = std::execute(msg.name, msg.source, msg.argument);
 END CATCH(VAR e AS AnyType) BEGIN
  msg.exception = e;
 END;

 RETURN msg;

END;