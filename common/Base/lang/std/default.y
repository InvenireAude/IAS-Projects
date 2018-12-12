/*
 * File: ZZZ-DemoCep/lang/std/default.y
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
PROGRAM std::substring(VAR strArgument AS String,
					   VAR iStart      AS Integer,
					   VAR iLength     AS Integer) RETURNS String
EXTERNAL "libIASLangLib:SubString3"();

PROGRAM std::substring(VAR strArgument AS String,
					   VAR iStart      AS Integer) RETURNS String
EXTERNAL "libIASLangLib:SubString2"();

PROGRAM std::find(VAR strArgument AS String,
				  VAR strPattern  AS String) RETURNS Integer
EXTERNAL "libIASLangLib:Find"();

PROGRAM std::find(VAR strArgument AS String,
				  VAR strPattern  AS String,
				  VAR iStart      AS Integer) RETURNS Integer
EXTERNAL "libIASLangLib:Find3"();

PROGRAM std::replace(VAR strArgument AS String,
					 VAR strPattern  AS String,
					 VAR strNewText  AS String) RETURNS String
EXTERNAL "libIASLangLib:Replace"();

PROGRAM std::partOfString(VAR strArgument AS String,
				                  VAR strPattern  AS String,
				                  VAR iFieldNo    AS Integer) RETURNS String
EXTERNAL "libIASLangLib:PartOfString"();

PROGRAM std::replaceRegExp(VAR strArgument AS String,
					        VAR strPattern  AS String,
					        VAR strNewText  AS String) RETURNS String
EXTERNAL "libIASLangLib:ReplaceRegExp"();

PROGRAM std::toLower(VAR strArgument AS String) RETURNS String
EXTERNAL "libIASLangLib:StrToLower"();

PROGRAM std::toUpper(VAR strArgument AS String) RETURNS String
EXTERNAL "libIASLangLib:StrToUpper"();

PROGRAM std::strlen(VAR strArgument AS String) RETURNS Integer
EXTERNAL "libIASLangLib:StrLen"();

/* ********************************************************************************* */

PROGRAM std::log(VAR priority AS String, VAR message AS String)
EXTERNAL "libIASLangLib:SysLog"();

/* ********************************************************************************* */

PROGRAM std::round(VAR arg AS Float)
RETURNS Float
BEGIN
  RETURN (((arg + "0.5") AS Integer) AS Float);
END;

PROGRAM std::roundPrice(VAR arg AS Float)
RETURNS Float
BEGIN
  RETURN (((arg * "100.0" + "0.5") AS Integer) AS Float) / 100;
END;

/* ********************************************************************************* */

PROGRAM std::gettime() RETURNS DateTime
EXTERNAL "libIASLangLib:GetTime"();

PROGRAM std::getTime() RETURNS DateTime
EXTERNAL "libIASLangLib:GetTime"();

PROGRAM std::str2ts(VAR strTs AS String,
	                VAR strFmt AS String) RETURNS DateTime
EXTERNAL "libIASLangLib:GetTimeFormated"();

/* ********************************************************************************* */

PROGRAM std::getYear(VAR date AS Date) RETURNS Integer
EXTERNAL "libIASLangLib:GetYear"();

PROGRAM std::getYear(VAR date AS DateTime) RETURNS Integer
EXTERNAL "libIASLangLib:GetYear"();

PROGRAM std::getMonth(VAR date AS Date) RETURNS Integer
EXTERNAL "libIASLangLib:GetMonth"();

PROGRAM std::getMonth(VAR date AS DateTime) RETURNS Integer
EXTERNAL "libIASLangLib:GetMonth"();

PROGRAM std::getDay(VAR date AS Date) RETURNS Integer
EXTERNAL "libIASLangLib:GetDay"();

PROGRAM std::getDay(VAR date AS DateTime) RETURNS Integer
EXTERNAL "libIASLangLib:GetDay"();

//TODO Built-in functions
PROGRAM std::getHour(VAR ts AS DateTime)
RETURNS Integer
BEGIN
 RETURN (std::substring((ts AS String),11,2) AS Integer);
END;

PROGRAM std::getMinute(VAR ts AS DateTime)
RETURNS Integer
BEGIN
 RETURN (std::substring((ts AS String),14,2) AS Integer);
END;

PROGRAM std::getSecond(VAR ts AS DateTime)
RETURNS Integer
BEGIN
 RETURN (std::substring((ts AS String),17,2) AS Integer);
END;

PROGRAM std::formatDate(VAR strFmt AS String, VAR dateTime AS DateTime) RETURNS String
EXTERNAL "libIASLangLib:FormatDateTime"();

PROGRAM std::formatDate(VAR strFmt AS String, VAR dateTime AS Date) RETURNS String
EXTERNAL "libIASLangLib:FormatDateTime"();

PROGRAM std::parseDate(VAR strFmt AS String, VAR strTs AS String) RETURNS DateTime
EXTERNAL "libIASLangLib:GetTimeFormated"();

/* ********************************************************************************* */

PROGRAM std::modifydate(VAR tTime AS DateTime,
					     VAR iDeltaYears   AS Integer,
					     VAR iDeltaMonths  AS Integer,
					     VAR iDeltaDays    AS Integer) RETURNS DateTime
EXTERNAL "libIASLangLib:ModifyDate"();

PROGRAM std::modifytime(VAR tTime AS DateTime,
					     VAR iDeltaHours   AS Integer,
					     VAR iDeltaMinutes  AS Integer,
					     VAR iDeltaSeconds AS Integer) RETURNS DateTime
EXTERNAL "libIASLangLib:ModifyTime"();

PROGRAM std::getTimeDiffMS(VAR arg1 AS DateTime,
					       VAR arg2 AS DateTime) RETURNS Integer
EXTERNAL "libIASLangLib:GetTimeDiff"();

PROGRAM std::load(VAR file AS String) RETURNS AnyType
EXTERNAL "libIASLangLib:Load"();

PROGRAM std::save(VAR file AS String,
				   VAR value  AS AnyType)
EXTERNAL "libIASLangLib:Save"();

PROGRAM std::rand() RETURNS Integer
EXTERNAL "libIASLangLib:GetRandom"();

PROGRAM std::randString(VAR length AS Integer) RETURNS String
EXTERNAL "libIASLangLib:GetRandomString"();

PROGRAM std::getHash(VAR value AS String) RETURNS Integer
EXTERNAL "libIASLangLib:GetHash"();

PROGRAM std::sha256(VAR strArgument AS String) RETURNS String
EXTERNAL "libIASLangLib:StrToSHA256"();

PROGRAM std::sha256(VAR bData AS Raw) RETURNS String
EXTERNAL "libIASLangLib:BinaryToSHA256"();

PROGRAM std::sha1(VAR strArgument AS String) RETURNS String
EXTERNAL "libIASLangLib:StrToSHA1"();

PROGRAM std::sha1(VAR bData AS Raw) RETURNS String
EXTERNAL "libIASLangLib:BinaryToSHA1"();

PROGRAM std::md5(VAR strArgument AS String) RETURNS String
EXTERNAL "libIASLangLib:StrToMD5"();

PROGRAM std::md5(VAR bData AS Raw) RETURNS String
EXTERNAL "libIASLangLib:BinaryToMD5"();

PROGRAM std::readCertificate(VAR strFileName AS String) RETURNS String
EXTERNAL "libIASLangLib:ReadCertificate"();

/* ********************************************************************************* */

PROGRAM std::fromBase64(VAR strArgument AS String)
RETURNS Raw
EXTERNAL "libIASLangLib:Base64ToBinary"();

PROGRAM std::toBase64(VAR bData AS Raw)
RETURNS String
EXTERNAL "libIASLangLib:BinaryToBase64"();

PROGRAM std::fromHex(VAR strArgument AS String)
RETURNS Raw
EXTERNAL "libIASLangLib:HexToBinary"();

PROGRAM std::toHex(VAR bData AS Raw)
RETURNS String
EXTERNAL "libIASLangLib:BinaryToHex"();

/* ******************* DO ZASTAPIENIA LEPSZA IMPLEMENTACJA ************************* */
PROGRAM std::ltrim(VAR strArgument AS String)
RETURNS String
BEGIN
	VAR pos AS Integer;
	pos = 0;

	WHILE std::substring(strArgument,pos,1) == " " DO
		pos = pos+1;

	IF pos > 0 THEN
		RETURN std::substring(strArgument, pos)
	ELSE
		RETURN strArgument;

END;

PROGRAM std::rtrim(VAR strArgument AS String)
RETURNS String
BEGIN
	VAR pos AS Integer;
	VAR len AS Integer;

	len = std::strlen(strArgument);
	pos = len-1;

	WHILE pos >= 0 AND std::substring(strArgument,pos,1) == " " DO
		pos = pos-1;

	IF pos < (len-1) THEN
		RETURN std::substring(strArgument, 0, pos+1)
	ELSE
		RETURN strArgument;

END;

PROGRAM std::trim(VAR strArgument AS String)
RETURNS String
BEGIN
	RETURN std::ltrim(std::rtrim(strArgument));
END;

/* ********************************************************************************* */

PROGRAM std::trimWholeWords(VAR strValue AS String, VAR maxLength AS Integer)
RETURNS String
BEGIN

  IF std::strlen(strValue) <= maxLength THEN
    RETURN strValue
  ;

  VAR elided AS String;
  elided = "...";
  maxLength = maxLength - std::strlen(elided);

  strValue = strValue + " ";

  VAR i AS Integer;
  VAR l AS Integer;
  i = 0;

  WHILE i < std::strlen(strValue) AND (i < maxLength) DO BEGIN
    i = std::find(strValue, " ", i + 1);
    IF i <= maxLength THEN
      l = i
    ;
  END;

  result = std::substring(strValue, 0, l) + elided;

END;

/* ********************************************************************************* */

PROGRAM std::tokenize(VAR s AS String, VAR d AS String)
RETURNS ARRAY OF String
BEGIN

  VAR i AS Integer;
  i = 0;

  WHILE i <= std::strlen(s) DO BEGIN

    std::save("stdout",i);

    VAR n AS Integer;
    n = std::find(s,d,i);

    IF n == -1 THEN
      n = std::strlen(s);

    result = std::substring(s, i, n - i);

    i = n + std::strlen(d);
  END;

END;


PROGRAM std::contains(VAR l AS ARRAY OF String, VAR v AS String)
RETURNS Boolean
BEGIN

  WITH s AS l DO
    IF v == s THEN
    	RETURN TRUE;

    RETURN FALSE;
END;
