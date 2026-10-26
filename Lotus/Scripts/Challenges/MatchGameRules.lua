local function fn() -- 3 equivalent calls inferred from this helper
	return not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(gameRules)
end

function MatchTagEvent(_, _)
	return fn() -- inferred equivalent call
end

function MatchAttackEvent(_, _)
	return fn() -- inferred equivalent call
end

function MatchItemEvent(_, _)
	return fn() -- inferred equivalent call
end