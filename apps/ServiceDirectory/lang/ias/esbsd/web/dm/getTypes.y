
IMPORT std::typeinfo;

PROGRAM ias::esbsd::web::dm::getTypes(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				 VAR msg   AS GetTypes : "http://www.invenireaude.com/esbsd/dm/api")
RETURNS GetTypes : "http://www.invenireaude.com/esbsd/dm/api" 			    	  			 			    	  			 			    	 
BEGIN

  WITH msg.selector DO
    msg.types = std::getTypes(typeNamespace);
  
  RETURN msg;
  
END;