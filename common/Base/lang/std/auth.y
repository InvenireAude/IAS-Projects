
PROGRAM std::auth::scramblePasswordForESB(
	VAR password AS String
) RETURNS String
BEGIN
	password = std::toBase64(
		 std::fromHex(
			std::sha256(std::fromHex(std::toHex(("KxVpvuMBE^#~1&>x)R/&QQa%VeROK%0hck*4" AS Raw)) + std::sha256(password)))
		 ) 
		);
		
	RETURN password;
END;
