PROGRAM std::getTypeInfo(VAR type AS String, 
						 VAR typeNS AS String,
						 VAR directExtensions AS Boolean,
						 VAR allExtensions    AS Boolean,
						 VAR references       AS Boolean)
RETURNS TypeInfo : "http://www.invenireaude.org/qsystem/typeinfo"
EXTERNAL "libIASQSystemLib:ias_qs_lang_li_proxy:GetTypeInfo"();

PROGRAM std::getTypes(VAR typeNS AS String)
RETURNS ARRAY OF TypeInfo : "http://www.invenireaude.org/qsystem/typeinfo"
EXTERNAL "libIASQSystemLib:ias_qs_lang_li_proxy:GetTypes"();

PROGRAM std::getNamespaces()
RETURNS ARRAY OF String
EXTERNAL "libIASQSystemLib:ias_qs_lang_li_proxy:GetNamespaces"();


PROGRAM std::getPrograms(VAR name AS String)
RETURNS ARRAY OF Program : "http://www.invenireaude.org/qsystem/typeinfo"
EXTERNAL "libIASQSystemLib:ias_qs_lang_li_proxy:GetHTMLSource"();
