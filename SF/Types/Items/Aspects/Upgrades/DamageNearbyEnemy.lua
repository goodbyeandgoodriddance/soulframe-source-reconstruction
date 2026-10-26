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

local function fn2(object, p)
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

	local __wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(p)

	if __wf_atom_7e8ad928(__wf_atom_28224c27) or __wf_atom_3371f607 ~= __wf_atom_28224c27 then
		return
	end

	local victim = __wf_atom_483e7ddc.victim

	if __wf_atom_7e8ad928(victim) or victim:__wf_atom_129d1aba(object) then
		return
	end

	local spillDamagePct = spillDamagePct
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if p == 5 and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.RatMoteSpillDamagePrimaryNumUpgrades) then
		spillDamagePct *= __wf_atom_e919fb8e.RatMoteSpillDamagePrimaryNumUpgrades
	elseif p == 1 and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.RatMoteSpillDamageSecondaryNumUpgrades) then
		spillDamagePct *= __wf_atom_e919fb8e.RatMoteSpillDamageSecondaryNumUpgrades
	end

	local v3 = spillDamagePct * __wf_atom_9232afe2
	fn(object, __wf_atom_28224c27, victim, v3 < 1 and 1 or v3, 1)
end

function DealDamageToNearbyFromPrimary(p)
	fn2(p, 5)
end

function DealDamageToNearbyFromSecondary(p)
	fn2(p, 1)
end

function OnUpgradeApplied(object, object2, _, _, object3)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	local v3 = __wf_atom_7e8ad928(object3) and 1
		or math.max(1, object2:__wf_atom_b6c3ed85(object3:__wf_atom_1bb5b1ff()))
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if object2:__wf_atom_0395f752() == 5 then
		if v3 == 1 then
			object:__wf_atom_b4529799(v, "DealDamageToNearbyFromPrimary")
		end

		__wf_atom_e919fb8e.RatMoteSpillDamagePrimaryNumUpgrades = v3
	elseif object2:__wf_atom_0395f752() == 1 then
		if v3 == 1 then
			object:__wf_atom_b4529799(v2, "DealDamageToNearbyFromSecondary")
		end

		__wf_atom_e919fb8e.RatMoteSpillDamageSecondaryNumUpgrades = v3
	end
end

function OnUpgradeUnapplied(object, object2, _, _, object3)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	local v3 = __wf_atom_7e8ad928(object3) and 1
		or math.max(1, object2:__wf_atom_b6c3ed85(object3:__wf_atom_1bb5b1ff()))

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if object2:__wf_atom_0395f752() == 5 then
			if v3 == 1 then
				object:__wf_atom_af2dc07b(v)
			end

			__wf_atom_e919fb8e.RatMoteSpillDamagePrimaryNumUpgrades = v3 - 1
		elseif object2:__wf_atom_0395f752() == 1 then
			if v3 == 1 then
				object:__wf_atom_af2dc07b(v2)
			end

			__wf_atom_e919fb8e.RatMoteSpillDamageSecondaryNumUpgrades = v3 - 1
		end
	end
end

function GetAbilityStats(_, _, _, _, _, _)
	local v3 = {
		BONUS = module.FormatNumber(spillDamagePct * 100, 0)
	}
	return cjson.encode(v3)
end