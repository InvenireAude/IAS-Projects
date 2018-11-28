PROGRAM esb::broker::newAttribute(
  VAR name AS String,
  VAR value AS String)
RETURNS Attribute :  "http://www.invenireaude.org/qsystem/workers"
BEGIN
 VAR a AS Attribute :  "http://www.invenireaude.org/qsystem/workers";
 a.name=name;
 a.value=value;
 RETURN a;
END;

PROGRAM esb::broker::getAttribute(
  VAR attrs AS ARRAY OF Attribute :  "http://www.invenireaude.org/qsystem/workers",
	VAR aname  AS String)
RETURNS String
BEGIN
  WITH a AS attrs DO
    IF a.name == aname THEN
      RETURN a.value;

  THROW NEW Exception  : "http://www.invenireaude.org/qsystem/workers" BEGIN
    name="ItemNotFound";
    info="Attribute: "+aname;
  END;

END;