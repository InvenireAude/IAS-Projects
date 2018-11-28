
IMPORT std::qs;



PROGRAM ias::esbsd::gen::inc::shm::defInErr(VAR system  AS System : "http://www.invenireaude.org/qsystem", VAR base AS String)
BEGIN

 system.actions = NEW ActionCreateQueue : "http://www.invenireaude.org/qsystem" BEGIN
  CREATE queueDefinition BEGIN
    name = base + ".IN";
    size = 100;
    overwriteWhenFull = TRUE;
  END;
 END;

 system.actions = NEW ActionCreateQueue : "http://www.invenireaude.org/qsystem" BEGIN
  CREATE queueDefinition BEGIN
    name = base + ".ERR";
    size = 100;
    overwriteWhenFull = TRUE;
  END;
 END;

END;

PROGRAM ias::esbsd::gen::inc::shm::defAlias(VAR system  AS System : "http://www.invenireaude.org/qsystem", VAR from AS String, VAR to AS String, VAR persistance AS String)
BEGIN

 system.actions = NEW ActionCreateLink : "http://www.invenireaude.org/qsystem" BEGIN
  CREATE linkDefinition BEGIN
    name = from + ".OUT";
    target = to + ".IN";
  END;
 END;

END;

PROGRAM ias::esbsd::gen::inc::shm::defQRemote(
  VAR system1  AS System : "http://www.invenireaude.org/qsystem",
  VAR system2  AS System : "http://www.invenireaude.org/qsystem",
  VAR qname AS String, VAR persistance AS String)
BEGIN

  THROW "Not Supported in SHM";

END;

PROGRAM ias::esbsd::gen::inc::shm::compareAction(
  VAR a AS Action : "http://www.invenireaude.org/qsystem",
  VAR b AS Action : "http://www.invenireaude.org/qsystem"
)
RETURNS Boolean
BEGIN

  IF a ISINSTANCE(ActionCreateQueue : "http://www.invenireaude.org/qsystem") AND
     b ISINSTANCE(ActionCreateLink : "http://www.invenireaude.org/qsystem") THEN
    RETURN TRUE;

  RETURN FALSE;

END;