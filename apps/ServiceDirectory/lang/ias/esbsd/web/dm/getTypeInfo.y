
IMPORT std::typeinfo;

PROGRAM ias::esbsd::web::dm::getTypeInfo(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				    VAR msg  AS GetTypeInfo : "http://www.invenireaude.com/esbsd/dm/api")
RETURNS GetTypeInfo : "http://www.invenireaude.com/esbsd/dm/api" 			    	  			 			    	  			 			    	 
BEGIN
     
  WITH msg.selector DO BEGIN

  	IF NOT ISSET(directExtensions) THEN
     directExtensions = FALSE;

  	IF NOT ISSET(allExtensions) THEN
     allExtensions = FALSE;

	IF NOT ISSET(references) THEN
     references = FALSE;

    msg.response = std::getTypeInfo(typeName, typeNamespace, directExtensions, allExtensions, references);
  
  RETURN msg;

 END;
   
END;