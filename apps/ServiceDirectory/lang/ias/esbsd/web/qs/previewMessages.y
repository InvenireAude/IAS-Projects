
IMPORT std::qs;
IMPORT std::default;

PROGRAM ias::esbsd::web::qs::previewMessages(VAR ctx  AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				                         VAR request  AS PreviewMessages : "http://www.invenireaude.org/qsystem/service")
RETURNS PreviewMessages : "http://www.invenireaude.org/qsystem/service"
EXTERNAL "libIASQSystemLib:ias_qs_lang_msgs_proxy:MessagePreview"();
