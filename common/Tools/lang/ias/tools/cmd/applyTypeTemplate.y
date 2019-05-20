IMPORT std::default;
IMPORT std::typeinfo;

PROGRAM ias::tools::cmd::applyTypeTemplate(
	VAR ctx     AS Context  : "http://www.invenireaude.org/qsystem/workers",
	VAR params  AS RunParameters : "http://www.invenireaude.org/qsystem/workers"
)
RETURNS Object : "http://www.invenireaude.org/qsystem/typeinfo"
BEGIN

   VAR type       AS String;
   VAR typeNS     AS String;
   VAR template   AS String;

   IF SIZEOF(params.args) <> 3 THEN
      THROW NEW Exception : "http://www.invenireaude.org/qsystem/workers" BEGIN
        name = "BadUsageException";
        info = "Bad number of arguments";
      END;

   type      = params.args[0];
   typeNS    = params.args[1];
   template  = params.args[2];

   CREATE ctx.attributes BEGIN
      name  = "Template";
      value = "type/" + template + ".templ";
   END;


  result = std::getTypeInfo(type, typeNS, FALSE, FALSE, FALSE);

  WITH p AS result.properties DO
   IF p.typeName == "String" THEN p.typeName = "VARCHAR(64)"
   ELSE IF p.typeName == "Integer" THEN p.typeName = "NUMBER"
   ELSE IF p.typeName == "Boolean" THEN p.typeName = "NUMBER(1)";

  RETURN result;

END;

