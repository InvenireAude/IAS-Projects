
IMPORT std::qs;
IMPORT std::default;

IMPORT std::fmt;

DEFINE Convert : "http://www.invenireaude.com/esbsd/tester" AS BEGIN

  fmtFrom AS String;
  fmtTo   AS String;

  dataFrom AS String;
  dataTo   AS String;

END;

PROGRAM ias::esbsd::web::tester::convert(VAR  ctx     AS Context : "http://www.invenireaude.org/qsystem/workers",
		   	    				    VAR  convert AS Convert : "http://www.invenireaude.com/esbsd/tester")
RETURNS Convert : "http://www.invenireaude.com/esbsd/tester" 			    	  			 			    	  			 			    	 
BEGIN


  WITH convert DO BEGIN
  
   dataTo = fmt::serialize(fmtTo, fmt::parse(fmtFrom, dataFrom));
  
   DELETE dataFrom;
   DELETE fmtFrom;
  
  END;
  
  RETURN convert;
   
END;
