
PROGRAM std::execute(VAR command    AS String,
	                   VAR arguments  AS ARRAY OF String)
RETURNS Integer	                  
EXTERNAL "libIASQSystemLib:ias_qs_lang_tools_proxy:ExecuteSystemCmdArray"();

PROGRAM std::execute(VAR command    AS String)
RETURNS Integer	                  
EXTERNAL "libIASQSystemLib:ias_qs_lang_tools_proxy:ExecuteSystemCmd"();

PROGRAM std::execute(VAR command    AS String,
				       VAR arg1       AS String)
RETURNS Integer	                  
EXTERNAL "libIASQSystemLib:ias_qs_lang_tools_proxy:ExecuteSystemCmd"();

PROGRAM std::execute(VAR command    AS String,
					   VAR arg1       AS String,
				       VAR arg2       AS String)
RETURNS Integer	                  
EXTERNAL "libIASQSystemLib:ias_qs_lang_tools_proxy:ExecuteSystemCmd"();

PROGRAM std::execute(VAR command    AS String,
				       VAR arg1       AS String,
				       VAR arg2       AS String,
				       VAR arg3       AS String)
RETURNS Integer	                  
EXTERNAL "libIASQSystemLib:ias_qs_lang_tools_proxy:ExecuteSystemCmd"();

PROGRAM std::execute(VAR command    AS String,
				       VAR arg1       AS String,
				       VAR arg2       AS String,
				       VAR arg3       AS String,
				       VAR arg4       AS String)
RETURNS Integer	                  
EXTERNAL "libIASQSystemLib:ias_qs_lang_tools_proxy:ExecuteSystemCmd"();

PROGRAM std::execute(VAR command    AS String,
				       VAR arg1       AS String,
				       VAR arg2       AS String,
				       VAR arg3       AS String,
				       VAR arg4       AS String,
				       VAR arg5       AS String)
RETURNS Integer	                  
EXTERNAL "libIASQSystemLib:ias_qs_lang_tools_proxy:ExecuteSystemCmd"();
