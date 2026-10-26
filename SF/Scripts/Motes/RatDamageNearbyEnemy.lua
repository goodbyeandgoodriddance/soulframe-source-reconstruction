local module = require("EE.Interface.Utilities")
local v = Symbol("RatMoteSpillDamagePrimary")
local v2 = Symbol("RatMoteSpillDamageSecondary")

local function fn(object, __wf_atom_28224c27, victim, p, p2)
	local position = victim:GetPosition()
	local all = gRegion:FindAll(__wf_atom_9e85eea2, position, 0, 6)

	for i = #all, 1, -1 do
		local v3 = all[i]

		if not (__wf_atom_7e8ad928(v3) or v3:__wf_atom_129d1aba(object) or v3:IsKilled() or v3:__wf_atom_bedb4e3f() or v3 == victim) then
			continue
		end

		table.remove(all, i)
	end

	for _ = 1, p2 do
		if not (#all > 0) then
			continue
		end

		local v3 = math.floor((Random(1, #all)))
		local damageData = Engine.DamageData()
		damageData:__wf_atom_6d7ec072(Engine.UpgradedValue(p))
		damageData:__wf_atom_7498285f(15, 1)
		damageData:__wf_atom_6b472125(object)
		damageData:__wf_atom_34a8a27a(__wf_atom_28224c27)
		damageData.hitType = 6
		damageData.blockableProjType = 4

		if not __wf_atom_7e8ad928(victim) then
			victim:Attach(sourceFxType, Symbol("GAME_C1_SPINE3"))
		end

		if not __wf_atom_7e8ad928(all[v3]) then
			all[v3]:Attach(targetFxType, Symbol("GAME_C1_SPINE3"))
		end

		all[v3]:__wf_atom_649bf33e(damageData)
		table.remove(all, v3)
	end
end

local function fn2(p) -- 3 equivalent calls inferred from this helper
	return spillDamagePct + spillDamagePctPerLevel * (p - 1)
end

function DealDamageToNearbyFromPrimary(object)
	if not gRegion:IsMaster() or (__wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f()) then
		return
	end

	if
		__wf_atom_7e8ad928(object:__wf_atom_9d766292())
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292():__wf_atom_483e7ddc())
	then
		return
	end

	local __wf_atom_483e7ddc = object:__wf_atom_9d766292():__wf_atom_483e7ddc()

	if
		__wf_atom_483e7ddc.hitType == 7
		or __wf_atom_483e7ddc.hitType == 6
		or __wf_atom_483e7ddc.hitType == 5
		or __wf_atom_483e7ddc.hitType == 4
	then
		return
	end

	local __wf_atom_9232afe2 = __wf_atom_483e7ddc:__wf_atom_9232afe2()

	if __wf_atom_9232afe2 <= 0 then
		return
	end

	local __wf_atom_3371f607 = __wf_atom_483e7ddc:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	local __wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(5)

	if __wf_atom_7e8ad928(__wf_atom_28224c27) or __wf_atom_3371f607 ~= __wf_atom_28224c27 then
		return
	end

	local victim = __wf_atom_483e7ddc.victim

	if __wf_atom_7e8ad928(victim) or victim:__wf_atom_129d1aba(object) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.RatMoteSpillDamagePrimaryLevel) then
		return
	end

	local v3 = fn2(__wf_atom_e919fb8e.RatMoteSpillDamagePrimaryLevel) * __wf_atom_9232afe2 -- inferred equivalent call
	fn(object, __wf_atom_28224c27, victim, v3 < 1 and 1 or v3, 1)
end

function DealDamageToNearbyFromSecondary(object)
	if not gRegion:IsMaster() or (__wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f()) then
		return
	end

	if
		__wf_atom_7e8ad928(object:__wf_atom_9d766292())
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292():__wf_atom_483e7ddc())
	then
		return
	end

	local __wf_atom_483e7ddc = object:__wf_atom_9d766292():__wf_atom_483e7ddc()

	if
		__wf_atom_483e7ddc.hitType == 7
		or __wf_atom_483e7ddc.hitType == 6
		or __wf_atom_483e7ddc.hitType == 5
		or __wf_atom_483e7ddc.hitType == 4
	then
		return
	end

	local __wf_atom_9232afe2 = __wf_atom_483e7ddc:__wf_atom_9232afe2()

	if __wf_atom_9232afe2 <= 0 then
		return
	end

	local __wf_atom_3371f607 = __wf_atom_483e7ddc:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	local __wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(1)

	if __wf_atom_7e8ad928(__wf_atom_28224c27) or __wf_atom_3371f607 ~= __wf_atom_28224c27 then
		return
	end

	local victim = __wf_atom_483e7ddc.victim

	if __wf_atom_7e8ad928(victim) or victim:__wf_atom_129d1aba(object) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.RatMoteSpillDamageSecondaryLevel) then
		return
	end

	local v3 = fn2(__wf_atom_e919fb8e.RatMoteSpillDamageSecondaryLevel) * __wf_atom_9232afe2 -- inferred equivalent call
	fn(object, __wf_atom_28224c27, victim, v3 < 1 and 1 or v3, 1)
end

function OnUpgradeApplied(object, object2, p, _, _)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if object2:__wf_atom_0395f752() == 5 then
		object:__wf_atom_b4529799(v, "DealDamageToNearbyFromPrimary")
		__wf_atom_e919fb8e.RatMoteSpillDamagePrimaryLevel = p
	elseif object2:__wf_atom_0395f752() == 1 then
		object:__wf_atom_b4529799(v2, "DealDamageToNearbyFromSecondary")
		__wf_atom_e919fb8e.RatMoteSpillDamageSecondaryLevel = p
	end
end

function OnUpgradeUnapplied(object, object2, _, _, _)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if object2:__wf_atom_0395f752() == 5 then
			object:__wf_atom_af2dc07b(v)
			__wf_atom_e919fb8e.RatMoteSpillDamagePrimaryLevel = nil
		elseif object2:__wf_atom_0395f752() == 1 then
			object:__wf_atom_af2dc07b(v2)
			__wf_atom_e919fb8e.RatMoteSpillDamageSecondaryLevel = nil
		end
	end
end

function GetAbilityStats(p, _, _, _, _, _)
	local v3 = {
		BONUS = module.FormatNumber(fn2(p) * 100, 0) -- inferred equivalent call
	}
	return cjson.encode(v3)
end