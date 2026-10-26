local v = 0
local module = require("EE.Interface.Utilities")

local function fn(p) -- 2 equivalent calls inferred from this helper
	return upgradeBaseValue + upgradeValuePerLevel * (p - 1)
end

function GetAbilityStats(p, _, _, _, _, _)
	local v2 = { BONUS = module.FormatNumber(fn(p), 0) } -- inferred equivalent call
	return cjson.encode(v2)
end

function OrbitingGlaiveUpdate(object)
	while not object:__wf_atom_01084142() do
		Sleep(0)
	end

	object:__wf_atom_49c08f3b(fn(v)) -- inferred equivalent call
end

function OnNewProjectile(p, instance)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(p) or not instance:IsA(__wf_atom_a7ef6cab) then
		return
	end

	instance:__wf_atom_8a035cd5(Symbol("OrbitingGlaiveUpdate"), false)
end

function ApplyUpgrade(_, object, p, _, object2)
	if upgradeID == EMPTY_SYMBOL then
		print("BUGGED APPLY UPGRADE ID for ExtendOrbitDuration.lua")

		if not __wf_atom_7e8ad928(object2) then
			print(object2:__wf_atom_5b41f63b())
		end
	else
		if not __wf_atom_7e8ad928(object) then
			object:__wf_atom_f354682d(upgradeID, "OnNewProjectile")
		end

		v = p
	end
end

function UnapplyUpgrade(_, object, _, _, object2)
	if upgradeID == EMPTY_SYMBOL then
		print("BUGGED UNAPPLY UPGRADE ID for ExtendOrbitDuration.lua")

		if not __wf_atom_7e8ad928(object2) then
			print(object2:__wf_atom_5b41f63b())
		end
	elseif not __wf_atom_7e8ad928(object) then
		object:__wf_atom_308a9a4d(upgradeID)
	end
end