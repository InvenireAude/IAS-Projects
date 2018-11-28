/* ************************************** */

PROGRAM ias::esbsd::gen::inc::getInterface(VAR ints AS GetInterfaces   : "http://www.invenireaude.com/esbsd/esb/api",
									       VAR id   AS String)
RETURNS InterfaceDefinition   : "http://www.invenireaude.com/esbsd"
BEGIN

 WITH i AS ints.interfaces DO
   IF i.id == id THEN
 	  RETURN i;

END;

PROGRAM ias::esbsd::gen::inc::getPersistance(VAR interface AS InterfaceDefinition   : "http://www.invenireaude.com/esbsd")
RETURNS String
BEGIN

 WITH p AS interface.properties DO
   IF p.name == "PERSISTANCE" THEN
 	  RETURN p.value;

 RETURN "NO";

END;