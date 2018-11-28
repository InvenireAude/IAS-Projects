
IMPORT std::qs;
IMPORT std::default;

DEFINE GetTestCases : "http://www.invenireaude.com/esbsd/tc" AS BEGIN
  appl      AS String;
  interface AS String;
  
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
    
     data = std::receive(ioName, esbReplyCtx);

     ctx  = esbReplyCtx;
 
    END CATCH(VAR e AS AnyType) BEGIN
    	data = e;
    END;
  
  END;

 RETURN testService;
   
END;
