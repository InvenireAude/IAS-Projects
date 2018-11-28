IMPORT std::default;
IMPORT std::qs;
IMPORT std::typeinfo;

PROGRAM ias::esbsd::cmd::tools::loadApplication(
   VAR appl      AS String
)
RETURNS Application : "http://www.invenireaude.com/esbsd"
BEGIN
     
  VAR ctx     AS Context  : "http://www.invenireaude.org/qsystem/workers";
  ctx.MID = appl + ".app.xml";
  
  RETURN std::receive("esbsd.apps", ctx);
END;

PROGRAM ias::esbsd::cmd::tools::saveApplication(
   VAR appl      AS String,
   VAR data      AS Application : "http://www.invenireaude.com/esbsd"
)

BEGIN
     
  VAR ctx     AS Context  : "http://www.invenireaude.org/qsystem/workers";
  ctx.MID = appl + ".app.xml";
  
  std::send("esbsd.apps", ctx, data);
  
END;

PROGRAM ias::esbsd::cmd::tools::loadInterface(
   VAR interface      AS String
)
RETURNS InterfaceDefinition : "http://www.invenireaude.com/esbsd"
BEGIN
     
  VAR ctx     AS Context  : "http://www.invenireaude.org/qsystem/workers";
  ctx.MID = interface + ".int.xml";
  
  RETURN std::receive("esbsd.ints", ctx);
END;


PROGRAM ias::esbsd::cmd::tools::checkService(
   VAR service   AS String,
   VAR interface AS String
)
BEGIN
 
  VAR ctx     AS Context  : "http://www.invenireaude.org/qsystem/workers";
  ctx.MID = interface + ".int.xml";
  
  VAR interfaceDefinition AS InterfaceDefinition : "http://www.invenireaude.com/esbsd";
  interfaceDefinition = ias::esbsd::cmd::tools::loadInterface(interface);
  
 
  VAR ti AS TypeInfo : "http://www.invenireaude.org/qsystem/typeinfo"; 
  ti = std::getTypeInfo("RootType", interfaceDefinition.namespace, FALSE, FALSE, FALSE); 
 
  VAR o AS Object : "http://www.invenireaude.org/qsystem/typeinfo"; 
  o = (ti AS Object : "http://www.invenireaude.org/qsystem/typeinfo");
    
 
  WITH p AS o.properties DO
   IF p.name == service THEN
     RETURN;
     
  THROW NEW Exception : "http://www.invenireaude.org/qsystem/workers" BEGIN
       name = "BadUsageException";
       info = "No service: " + service + " found in interface: " + interface;
     END;   
  
END;
