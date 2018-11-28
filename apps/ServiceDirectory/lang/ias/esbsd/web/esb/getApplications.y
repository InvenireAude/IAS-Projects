
IMPORT std::qs;
IMPORT std::default;

PROGRAM ias::esbsd::web::esb::getApplications(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				         VAR msg  AS GetApplications : "http://www.invenireaude.com/esbsd/esb/api")
RETURNS GetApplications : "http://www.invenireaude.com/esbsd/esb/api" 			    	  			 			    	  			 			    	 
BEGIN

	VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers";
	
	TRY BEGIN
  	 WHILE 1 == 1 DO BEGIN
  	  
  	  VAR app AS Application : "http://www.invenireaude.com/esbsd";
   
     CREATE ctx;
     
     app = (std::receive("esbsd.apps",ctx) AS Application : "http://www.invenireaude.com/esbsd");
	
	  IF NOT ISSET(msg.selector.id) OR msg.selector.id == app.id THEN
	  	result.applications = app;
	  
	 END;
	END 
	 CATCH (VAR e AS Exception  : "http://www.invenireaude.org/qsystem/workers") BEGIN
	 	     IF e.name <> "EndOfDataException" THEN
	       THROW e;
	 END;  
	
  
END;