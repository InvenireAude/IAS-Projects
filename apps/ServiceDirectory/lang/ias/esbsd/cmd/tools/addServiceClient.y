IMPORT std::default;
IMPORT std::qs;
IMPORT ias::esbsd::cmd::tools::common;

PROGRAM ias::esbsd::cmd::tools::addServiceClient(
   VAR appl      AS String,
   VAR interface AS String,
   VAR service   AS String
)
BEGIN
     
  
  VAR applSpecs AS Application : "http://www.invenireaude.com/esbsd";
  	  
  applSpecs = ias::esbsd::cmd::tools::loadApplication(appl);
    
  WITH i AS applSpecs.interfaceInstances DO
    IF i.id == interface THEN
    	IF i ISINSTANCE(ClientInterface : "http://www.invenireaude.com/esbsd") THEN
    	 ias::esbsd::cmd::tools::addService::addIfNeeded( (i AS ClientInterface : "http://www.invenireaude.com/esbsd"), service);
          
  ias::esbsd::cmd::tools::checkService(service, interface);        
  //ias::esbsd::cmd::tools::saveApplication(appl, applSpecs);
      
END;


PROGRAM ias::esbsd::cmd::tools::addService::addIfNeeded(
	VAR interface AS ClientInterface : "http://www.invenireaude.com/esbsd",
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