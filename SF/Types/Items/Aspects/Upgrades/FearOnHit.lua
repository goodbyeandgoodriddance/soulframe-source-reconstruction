local v = Symbol("FearOnHit")
local v2 = Symbol("CASTREACT")

local function fn(__wf_atom_483e7ddc)
	local v3 = true

	for _, v4 in ipairs(validDamageSymbolFilters) do
		if v4 == __wf_atom_483e7ddc.upgradeSymbol then
			return true
		end

		if v4 ~= EMPTY_SYMBOL then
			v3 = false
		end
	end

	return v3
end

local function fn2(object) -- 1 equivalent call inferred from this helper
	return object:__wf_atom_7b82e9e1(13) or object:__wf_atom_7b82e9e1(6) or object:__wf_atom_7b82e9e1(12)
end

function DoFearResponse(object)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or object:__wf_atom_39ae2374(9) then
		return
	end

	if __wf_atom_7e8ad928(object:__wf_atom_e919fb8e().isFleeing) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.isFleeing = true
	end

	__wf_atom_30e3d82b:__wf_atom_069163a3(false)
	__wf_atom_30e3d82b:__wf_atom_7a5ca808(false)
	__wf_atom_30e3d82b:__wf_atom_ae241dc9(false)
	__wf_atom_30e3d82b:__wf_atom_cd7076f3(false, 0)
	__wf_atom_30e3d82b:__wf_atom_6c491aa2(fearBehavior, false)
	object:__wf_atom_17db995b(v)
	local fearDuration = fearDuration
	local v3 = false

	while fearDuration > 0 and not (__wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_39ae2374(0)) do
		if not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or object:__wf_atom_39ae2374(9) or __wf_atom_30e3d82b:__wf_atom_5f8ed4be()) then
			__wf_atom_30e3d82b:__wf_atom_6c491aa2(fearBehavior, false)
		end

		if not (v3 or fn2(object)) then -- inferred equivalent call
			object:__wf_atom_58c8ffec(v2, false, 4, 1, false, __wf_atom_5784a397(0, object:__wf_atom_1ba2008d(v2)))
			v3 = true
		end

		Sleep(0)
		fearDuration -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_920a5a62()
	end

	if not __wf_atom_7e8ad928(object:__wf_atom_e919fb8e().isFleeing) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.isFleeing = nil
	end
end

local function fn3(object, p)
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

	if not fn(__wf_atom_483e7ddc) or __wf_atom_483e7ddc:__wf_atom_9232afe2() <= 0 then
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

	if
		__wf_atom_7e8ad928(victim)
		or victim:__wf_atom_464a4772()
		or victim:__wf_atom_129d1aba(object)
		or victim:IsKilled()
		or victim:__wf_atom_bedb4e3f()
	then
		return
	end

	if not __wf_atom_7e8ad928(victim:__wf_atom_e919fb8e().isFleeing) then
		return
	end

	local fearChance = fearChance
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if p == 5 and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FearTargetPrimaryChance) then
		fearChance = __wf_atom_e919fb8e.FearTargetPrimaryChance
	elseif p == 1 and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FearTargetSecondaryChance) then
		fearChance = __wf_atom_e919fb8e.FearTargetSecondaryChance
	end

	if fearChance < __wf_atom_7abf2d2f() then
		return
	end

	victim:__wf_atom_8a035cd5(Symbol("DoFearResponse"), false)
end

function FearTargetPrimary(p)
	fn3(p, 5)
end

function FearTargetSecondary(p)
	fn3(p, 1)
end

function OnUpgradeApplied(object, object2, _, _, object3)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) then
		return
	end

	local v3 = __wf_atom_7e8ad928(object3) and 1
		or math.max(1, object2:__wf_atom_b6c3ed85(object3:__wf_atom_1bb5b1ff()))
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if object2:__wf_atom_0395f752() == 5 then
		if v3 == 1 then
			object:__wf_atom_b4529799(primaryUpgradeSymbol, "FearTargetPrimary")
		end

		__wf_atom_e919fb8e.FearTargetPrimaryChance = fearChance * v3
	elseif object2:__wf_atom_0395f752() == 1 then
		if v3 == 1 then
			object:__wf_atom_b4529799(secondaryUpgradeSymbol, "FearTargetSecondary")
		end

		__wf_atom_e919fb8e.FearTargetSecondaryChance = fearChance * v3
	end
end

function OnUpgradeUnapplied(object, object2, _, _, object3)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) then
		return
	end

	local v3 = __wf_atom_7e8ad928(object3) and 1
		or math.max(1, object2:__wf_atom_b6c3ed85(object3:__wf_atom_1bb5b1ff()))
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(object) then
		if object2:__wf_atom_0395f752() == 5 then
			if v3 == 1 then
				object:__wf_atom_af2dc07b(primaryUpgradeSymbol)
			end

			__wf_atom_e919fb8e.FearTargetPrimaryChance = fearChance * v3
		elseif object2:__wf_atom_0395f752() == 1 then
			if v3 == 1 then
				object:__wf_atom_af2dc07b(secondaryUpgradeSymbol)
			end

			__wf_atom_e919fb8e.FearTargetSecondaryChance = fearChance * v3
		end
	end
end