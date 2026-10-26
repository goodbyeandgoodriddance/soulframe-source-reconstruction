local v = 0
local v2 = {
	Symbol("CC_GROUND_BRANCH_HEAVY"),
	Symbol("CC_GROUND_PERFECT_HEAVY"),
	Symbol("CC_RUN_BRANCH_HEAVY"),
	Symbol("CC_RUN_PERFECT_HEAVY"),
	Symbol("CC_AIR_HEAVY")
}
local module = require("EE.Interface.Utilities")

local function fn(p) -- 2 equivalent calls inferred from this helper
	return staggerDamage + staggerDamagePerLevel * (p - 1)
end

local function fn2(p) -- 2 equivalent calls inferred from this helper
	return staggerRadius + staggerRadiusPerLevel * (p - 1)
end

local function fn3(position, p, p2)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData:__wf_atom_6b472125(p2)
	radialDamageData:__wf_atom_34a8a27a(p)
	radialDamageData:__wf_atom_98d98d81(position)
	radialDamageData:__wf_atom_6d7ec072(Engine.UpgradedValue(0))
	radialDamageData.stabilityDamage = fn(v) -- inferred equivalent call
	radialDamageData.radius = fn2(v) -- inferred equivalent call
	radialDamageData:__wf_atom_7498285f(0, 1)
	radialDamageData.checkForCover = false
	radialDamageData.fallOff = 1
	radialDamageData.hostAuthoritative = false
	gRegion:__wf_atom_f6ec80de(radialDamageData)
end

function GetAbilityStats(p, _, _, _, _, _)
	local v3 = { BONUS = module.FormatNumber(fn(p), 0), RADIUS = module.FormatNumber(fn2(p), 0) } -- inferred equivalent call
	return cjson.encode(v3)
end

function WaveProjUpdate(object)
	local count = 0

	while true do
		local __wf_atom_efa9e2f4 = object:__wf_atom_efa9e2f4()

		while count < __wf_atom_efa9e2f4 do
			fn3(object:GetPosition(), object:__wf_atom_9f2332e5(), object:__wf_atom_7be51ede())
			count += 1
		end

		Sleep(0)
	end
end

function OnNewProjectile(p, instance)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(p) or not instance:IsA(__wf_atom_014b4ff7) then
		return
	end

	local __wf_atom_197d43b1 = instance:__wf_atom_197d43b1()

	for _, v3 in pairs(v2) do
		if __wf_atom_197d43b1 ~= v3 then
			continue
		end

		instance:__wf_atom_8a035cd5(Symbol("WaveProjUpdate"), false)
		break
	end
end

function ApplyUpgrade(_, object, p, _, object2)
	if upgradeID == EMPTY_SYMBOL then
		print("BUGGED APPLY UPGRADE ID for StaggerBombOnWaveProjPierce.lua")

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
		print("BUGGED UNAPPLY UPGRADE ID for StaggerBombOnWaveProjPierce.lua")

		if not __wf_atom_7e8ad928(object2) then
			print(object2:__wf_atom_5b41f63b())
		end
	elseif not __wf_atom_7e8ad928(object) then
		object:__wf_atom_308a9a4d(upgradeID)
	end
end