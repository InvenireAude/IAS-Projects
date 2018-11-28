IMPORT std::default;
IMPORT std::qs;
IMPORT ias::esbsd::cmd::tools::common;

PROGRAM ias::esbsd::cmd::tools::addServiceServer(
   VAR appl      AS String,
   VAR interface AS String,
   VAR service   AS String
)
BEGIN
     
  
  VAR applSpecs AS Application : "http://www.invenireaude.com/esbsd";
  	  
  applSpecs = ias::esbsd::cmd::tools::loadApplication(appl);
    
  WITH i AS applSpecs.interfaceInstances DO
    IF i.id == interface THEN
    	IF i ISINSTANCE(ServerInterface : "http://www.invenireaude.com/esbsd") THEN
    	 ias::esbsd::cmd::tools::addService::addIfNeeded( (i AS ServerInterface : "http://www.invenireaude.com/esbsd"), service);
          
  ias::esbsd::cmd::tools::saveApplication(appl, applSpecs);
      
END;


PROGRAM ias::esbsd::cmd::tools::addService::addIfNeeded(
	VAR interface AS ServerInterface : "http://www.invenireaude.com/esbsd",
	VAR service   AS String
)
BEGIN
  
   WITH s AS interface.services DO
     IF s.name == service THEN
        RETURN;
        
  CREATE interface.services BEGIN
    name = service;
  END;
  
END;