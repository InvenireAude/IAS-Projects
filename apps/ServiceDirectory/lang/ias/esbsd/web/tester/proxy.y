
IMPORT std::qs;
IMPORT std::default;

DEFINE TestService : "http://www.invenireaude.com/esbsd/tester" AS BEGIN
  appl      AS String;
  interface AS String;
  
  fetch   AS Boolean;
  
  ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers";
  data  AS AnyType;
END;

PROGRAM ias::esbsd::web::tester::proxy(VAR  ctx         AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				  VAR  testService AS TestService : "http://www.invenireaude.com/esbsd/tester")
RETURNS TestService : "http://www.invenireaude.com/esbsd/tester" 			    	  			 			    	  			 			    	 
BEGIN

  VAR esbReplyCtx  AS Context : "http://www.invenireaude.org/qsystem/workers";

  WITH testService DO BEGIN  
  
  TRY BEGIN
 
     VAR ioName AS String;
     ioName = "io."+appl+"."+interface;
     
     ctx.MID = "TST"+std::getTime();
     
     std::send(ioName, ctx, data);
   
     esbReplyCtx.CID = ctx.MID;
    
     IF NOT ISSET(testService.fetch) OR testService.fetch == TRUE THEN 
       data = std::receive(ioName, esbReplyCtx);

     ctx  = esbReplyCtx;
 
    END CATCH(VAR e AS AnyType) BEGIN
    	data = e;
    END;
  
  END;

 RETURN testService;
   
END;
