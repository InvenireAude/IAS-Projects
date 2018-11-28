/*
 * File: lang/std/default.y
 * 
 * Copyright (C) 2015, Albert Krzymowski
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
PROGRAM dict::createDictionary(VAR dictionary AS Dictionary  : "http://www.invenireaude.org/qsystem/workers/dict")
EXTERNAL "libIASQSystemLib:ias_qs_lang_dict_proxy:CreateDictionary"();

PROGRAM dict::getValue(VAR dictionary AS String, VAR key AS String)
RETURNS AnyType
EXTERNAL "libIASQSystemLib:ias_qs_lang_dict_proxy:GetValue"();

PROGRAM dict::getValue(VAR dictionary AS String, VAR key AS String, VAR wait AS Integer)
RETURNS AnyType
EXTERNAL "libIASQSystemLib:ias_qs_lang_dict_proxy:GetValue"();

PROGRAM dict::newItem(VAR key AS String, VAR value AS AnyType)
RETURNS Item  : "http://www.invenireaude.org/qsystem/workers/dict"
BEGIN
 result.key = key;
 result.value = value;
END;
