IMPORT std::default;
IMPORT ias::esbsd::cmd::tools::addServiceServer;

PROGRAM ias::esbsd::cmd::addServiceServer(
	VAR ctx     AS Context  : "http://www.invenireaude.org/qsystem/workers",
	VAR params  AS RunParameters : "http://www.invenireaude.org/qsystem/workers"
)
BEGIN
   
   VAR appl      AS String;
   VAR interface AS String;
   VAR service   AS String;
     
   IF SIZEOF(params.args) <> 3 THEN
      THROW NEW Exception : "http://www.invenireaude.org/qsystem/workers" BEGIN
        name = "BadUsageException";
        info = "Bad number of arguments";
      END;
      
   
   service      = params.args[0];
   appl         = params.args[1];
   interface    = params.args[2];
   
   
   ias::esbsd::cmd::tools::addServiceServer(appl, interface, service);
   
   
END;

