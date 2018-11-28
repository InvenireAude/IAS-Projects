
IMPORT std::qs;


DEFINE Base : "http://www.invenireaude.com/esbsd/esb/gen/wmq" AS BEGIN
  name         AS String;
  persistance  AS String;
END;

DEFINE InErrPair : "http://www.invenireaude.com/esbsd/esb/gen/wmq" AS 
EXTENSION OF  Base : "http://www.invenireaude.com/esbsd/esb/gen/wmq"
BEGIN
  presistantance  AS String;
END;

DEFINE QueueAlias : "http://www.invenireaude.com/esbsd/esb/gen/wmq" AS 
EXTENSION OF  Base : "http://www.invenireaude.com/esbsd/esb/gen/wmq"
BEGIN
  target    AS String;
END;

DEFINE QueueRemote : "http://www.invenireaude.com/esbsd/esb/gen/wmq" AS 
EXTENSION OF  Base : "http://www.invenireaude.com/esbsd/esb/gen/wmq"
BEGIN
  target      AS String;
  targetQMgr  AS String;
END;

PROGRAM ias::esbsd::gen::wmq::inc::generate(VAR qmgr AS String, VAR args AS Base : "http://www.invenireaude.com/esbsd/esb/gen/wmq")
BEGIN
  VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers";
  ctx.MID = qmgr + "#" + TYPE(args) + "." + args.name;
  std::send("output",ctx,args);	
END;


PROGRAM ias::esbsd::gen::wmq::inc::defInErr(VAR qmgr AS String, VAR base AS String)
BEGIN

  VAR pair  AS InErrPair : "http://www.invenireaude.com/esbsd/esb/gen/wmq";
  
  pair.name = base;
    
  ias::esbsd::gen::wmq::inc::generate(qmgr,pair);
  
END;

PROGRAM ias::esbsd::gen::wmq::inc::defAlias(VAR qmgr AS String, VAR from AS String, VAR to AS String, VAR persistance AS String)
BEGIN
  VAR alias  AS QueueAlias : "http://www.invenireaude.com/esbsd/esb/gen/wmq";   
  
  alias.name   = from + ".OUT";
  alias.target = to   + ".IN";
  alias.persistance = persistance;
  
  ias::esbsd::gen::wmq::inc::generate(qmgr, alias);
  
END;

PROGRAM ias::esbsd::gen::wmq::inc::defQRemote(VAR qmgrClient AS String, VAR qmgrServer AS String, VAR qname AS String, VAR persistance AS String)
BEGIN
  
  VAR qr  AS QueueRemote : "http://www.invenireaude.com/esbsd/esb/gen/wmq";   
  
  qname = qname + ".IN";
  
  qr.name   = qname;
  qr.target = qname;
  qr.targetQMgr = qmgrServer;
  qr.persistance = persistance;
  
  ias::esbsd::gen::wmq::inc::generate(qmgrClient, qr);
  
END;