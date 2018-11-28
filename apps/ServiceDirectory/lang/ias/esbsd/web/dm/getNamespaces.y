
IMPORT std::typeinfo;

PROGRAM ias::esbsd::web::dm::getNamespaces(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				    VAR msg     AS GetNamespaces : "http://www.invenireaude.com/esbsd/dm/api")
RETURNS GetNamespaces : "http://www.invenireaude.com/esbsd/dm/api" 			    	  			 			    	  			 			    	 
BEGIN

  msg.namespaces = std::getNamespaces();
  
  RETURN msg;
  
END;