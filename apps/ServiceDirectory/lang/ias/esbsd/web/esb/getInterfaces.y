
IMPORT std::qs;
IMPORT std::default;

PROGRAM ias::esbsd::web::esb::getInterfaces(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				       VAR msg  AS GetInterfaces : "http://www.invenireaude.com/esbsd/esb/api")
RETURNS GetInterfaces : "http://www.invenireaude.com/esbsd/esb/api" 			    	  			 			    	  			 			    	 
BEGIN

	VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers";
	
	TRY BEGIN
  	 WHILE 1 == 1 DO BEGIN

  	  VAR int AS Interface : "http://www.invenireaude.com/esbsd";
   
      CREATE ctx;
      
   	  int = (std::receive("esbsd.ints",ctx) AS Interface : "http://www.invenireaude.com/esbsd");
	  
	  IF NOT ISSET(msg.selector.id) OR msg.selector.id == int.id THEN
	      result.interfaces = int;
	  
	 END;
	END 
	 CATCH (VAR e AS Exception  : "http://www.invenireaude.org/qsystem/workers") BEGIN
	     IF e.name <> "EndOfDataException" THEN
	       THROW e;
	 END;  
	
  
END;