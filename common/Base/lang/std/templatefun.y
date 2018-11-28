IMPORT std::default;

PROGRAM templatefun::formatDate(VAR date AS Date) 
RETURNS String
BEGIN
	RETURN std::formatDate("%d-%m-%Y",date);
END;

PROGRAM templatefun::formatDate(VAR date AS DateTime) 
RETURNS String
BEGIN
	RETURN std::formatDate("%d-%m-%Y",date);	 
END;

PROGRAM templatefun::formatDateTime(VAR date AS DateTime) 
RETURNS String
BEGIN		
	RETURN std::formatDate("%H:%M:%S %d-%m-%Y",date);	 
END;

PROGRAM templatefun::formatTime(VAR time AS DateTime) 
RETURNS String
BEGIN		
	RETURN std::formatDate("%H:%M:%S",time);	 
END;

PROGRAM templatefun::formatTime(VAR time AS Time) 
RETURNS String
BEGIN		
	RETURN std::formatDate("%H:%M:%S",(time AS DateTime));	 
END;
