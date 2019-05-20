
PROGRAM cache::createBucket(VAR cache     AS String,
	                          VAR key       AS String)
EXTERNAL "libIASQSystemLib:ias_qs_lang_cache_proxy:CreateBucket"();


PROGRAM cache::fetchBucket(VAR cache     AS String,
	                         VAR key       AS String)
EXTERNAL "libIASQSystemLib:ias_qs_lang_cache_proxy:FetchBucket"();

PROGRAM cache::deleteBucket(VAR cache     AS String,
	                       VAR key       AS String)
EXTERNAL "libIASQSystemLib:ias_qs_lang_cache_proxy:DeleteBucket"();

PROGRAM cache::releaseBucket(VAR cache    AS String,
	                           VAR key       AS String)
EXTERNAL "libIASQSystemLib:ias_qs_lang_cache_proxy:ReleaseBucket"();

PROGRAM cache::getItem(VAR cache     AS String,
	                   VAR itemKey   AS String)
	                   RETURNS AnyType
EXTERNAL "libIASQSystemLib:ias_qs_lang_cache_proxy:GetItem"();


PROGRAM cache::createOrUpdate(VAR cache     AS String,
	                          VAR itemKey   AS String,
	                          VAR value     AS AnyType)
EXTERNAL "libIASQSystemLib:ias_qs_lang_cache_proxy:CreateOrUpdateItem"();
