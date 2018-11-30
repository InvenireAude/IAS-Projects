
IMPORT std::typeinfo;


PROGRAM ias::esbsd::web::smgr::callServiceManager(
      VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		  VAR data  AS ServiceCall : "http://www.invenireaude.org/sm/api")
RETURNS ServiceCall : "http://www.invenireaude.org/sm/api"
EXTERNAL "qsmod_sm:ias_qs_lang_sm_proxy:ServiceManagerAction"();
