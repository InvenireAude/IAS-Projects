
IMPORT std::default;
IMPORT esb::broker::stats::stats;
IMPORT esb::broker::ds::stats;


PROGRAM esb::broker::stats::updateDB(VAR ctx   AS Context       : "http://www.invenireaude.org/qsystem/workers",
		   	         	             VAR ctrl  AS DaemonControl : "http://www.invenireaude.org/qsystem/workers")   	         	            	  			 			    	  			 			    	 
BEGIN

 VAR samples AS ARRAY OF Record : "http://www.invenireaude.org/qsystem/workers/ec";

 samples = esb::broker::stats::readAll("true");

 VAR ts AS DateTime;
 ts = std::getTime();
 
 WITH s AS samples DO
   esb::broker::ds::insertStats(ts, s);
    
END;