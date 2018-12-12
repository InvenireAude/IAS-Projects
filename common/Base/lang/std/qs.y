PROGRAM std::newAttribute(VAR name AS String, VAR value AS String)
RETURNS Attribute :  "http://www.invenireaude.org/qsystem/workers"
BEGIN
 VAR a AS Attribute :  "http://www.invenireaude.org/qsystem/workers";
 a.name=name;
 a.value=value;
 RETURN a;
END;

PROGRAM std::getAttribute(
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

PROGRAM std::send(VAR name     AS String,
				   VAR ctx      AS Context  : "http://www.invenireaude.org/qsystem/workers",
				   VAR data     AS AnyType)
EXTERNAL "libIASQSystemLib:ias_qs_lang_msgs_proxy:Send"
( "specyfikacja", "emita");


PROGRAM std::receive(VAR name     AS String,
				   	 VAR ctx      AS Context  : "http://www.invenireaude.org/qsystem/workers")
RETURNS AnyType
EXTERNAL "libIASQSystemLib:ias_qs_lang_msgs_proxy:Receive"
( "specyfikacja", "emita");


PROGRAM std::getNumMsgs(VAR name     AS String)
RETURNS Integer
EXTERNAL "libIASQSystemLib:ias_qs_lang_msgs_proxy:GetNumMessages"
( "specyfikacja", "getnummsgs");

PROGRAM std::preview(VAR request  AS PreviewMessages : "http://www.invenireaude.org/qsystem/service")
RETURNS PreviewMessages : "http://www.invenireaude.org/qsystem/service"
EXTERNAL "libIASQSystemLib:ias_qs_lang_msgs_proxy:MessagePreview"();
