local module = require("SF.Scripts.Libs.TransmissionSet")
local v = { 0.99, 0.75, 0.5, 0.3 }
local v2 = { false, false, false, false }

local function fn(p, maxHealth, p2) -- 4 equivalent calls inferred from this helper
	return p <= maxHealth * p2
end

function OnHit()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraAvatar"))
	__wf_atom_0a6a5887:__wf_atom_7470861b()
	local maxHealth = __wf_atom_0a6a5887:GetMaxHealth()

	if fn(__wf_atom_0a6a5887:__wf_atom_c6f1f83d(), maxHealth, v[1]) and v2[1] == false then -- inferred equivalent call
		module.PlayGlobalTransmission(deoraTransmissionSet, Symbol("DeoraFirstHitBark"), true)
		v2[1] = true
	elseif fn(__wf_atom_0a6a5887:__wf_atom_c6f1f83d(), maxHealth, v[2]) and v2[2] == false then -- inferred equivalent call
		module.PlayGlobalTransmission(deoraTransmissionSet, Symbol("DeoraWeakening"), true)
		v2[2] = true
	elseif fn(__wf_atom_0a6a5887:__wf_atom_c6f1f83d(), maxHealth, v[3]) and v2[3] == false then -- inferred equivalent call
		module.PlayGlobalTransmission(deoraTransmissionSet, Symbol("DeoraHalfWayPoint"), true)
		v2[3] = true
	elseif fn(__wf_atom_0a6a5887:__wf_atom_c6f1f83d(), maxHealth, v[4]) and v2[4] == false then -- inferred equivalent call
		module.PlayGlobalTransmission(deoraTransmissionSet, Symbol("DeoraLastGasps"), true)
		v2[4] = true
	end
end