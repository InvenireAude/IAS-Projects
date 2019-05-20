/* ************************************** */

PROGRAM ias::esbsd::gen::inc::getSharedRegistry()
RETURNS Registry  : "http://www.invenireaude.org/qsystem/workers/spec"
BEGIN

	VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers";


	result = std::receive("esbsd.shared.registry",ctx);

	INDEX result.io.connections USING alias;

  std::save("stdout",result);

END;


PROGRAM ias::esbsd::gen::inc::getQMGRName(
	VAR registry AS Registry  : "http://www.invenireaude.org/qsystem/workers/spec",
	VAR alias AS String
)
RETURNS String
BEGIN

    RETURN (registry.io.connections[[ alias ]].host OR "");
END;
