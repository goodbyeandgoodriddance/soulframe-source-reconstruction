local v = 0
local module = require("EE.Interface.Utilities")

local function fn(p) -- 2 equivalent calls inferred from this helper
	return upgradeBaseValue + upgradeValuePerLevel * (p - 1)
end

function GetAbilityStats(p, _, _, _, _, _)
	local v2 = { BONUS = module.FormatNumber(fn(p), 0) } -- inferred equivalent call
	return cjson.encode(v2)
end

local function fn2(object)
	if aerialAttack then
		local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

		if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) and __wf_atom_6009c8ed:__wf_atom_7b82e9e1(15) then
			return true
		end
	end

	if perfectDodgeAttack and object:__wf_atom_ca3e110b() > 1 then
		local __wf_atom_414f70dd = object:__wf_atom_414f70dd(1)

		if not __wf_atom_7e8ad928(__wf_atom_414f70dd) and __wf_atom_414f70dd:IsA(__wf_atom_1a007764) then
			return __wf_atom_414f70dd:__wf_atom_4161712a()
		end
	end

	return false
end

local function fn3(_, object)
	local __wf_atom_f017ce0f = object:__wf_atom_f017ce0f()

	if aerialAttack then
		return SF.__wf_atom_2cb11c8f(__wf_atom_f017ce0f)
	end

	if dodgeAttack then
		return SF.__wf_atom_36b7220f(__wf_atom_f017ce0f)
	end

	if perfectDodgeAttack then
		return __wf_atom_f017ce0f == 30 or __wf_atom_f017ce0f == 31
	end

	if sprintAttack then
		return __wf_atom_f017ce0f == 14 or __wf_atom_f017ce0f == 16
	end

	return false
end

local function fn4(object)
	local __wf_atom_414f70dd = object:__wf_atom_414f70dd(0)

	if __wf_atom_7e8ad928(__wf_atom_414f70dd) then
		return false
	end

	if __wf_atom_414f70dd:IsA(__wf_atom_7486ea74) then
		return fn2(object)
	end

	if __wf_atom_414f70dd:IsA(__wf_atom_f8238f9d) then
		return fn3(object, __wf_atom_414f70dd)
	end

	return false
end

function OnNewProjectile(p, object)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) then
		return
	end

	local __wf_atom_197d43b1 = object:__wf_atom_197d43b1()
	local v2 = false
	local v3 = false

	for _, v4 in ipairs(validProjUpgradeSymbol) do
		if v4 == EMPTY_SYMBOL then
			continue
		end

		v2 = true

		if v4 == __wf_atom_197d43b1 then
			v3 = true
		end
	end

	if v2 and not v3 or not fn4(p) then
		return
	end

	local v4 = fn(v) -- inferred equivalent call

	if staggerDamage then
		object:__wf_atom_746d4173(operationType, v4)
	else
		object:__wf_atom_9fba31e6(operationType, v4)
	end
end

function ApplyUpgrade(_, object, p, _, object2)
	if upgradeID == EMPTY_SYMBOL then
		print("BUGGED APPLY UPGRADE ID for DamageOnConditionalProjectile.lua")

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
		print("BUGGED UNAPPLY UPGRADE ID for DamageOnConditionalProjectile.lua")

		if not __wf_atom_7e8ad928(object2) then
			print(object2:__wf_atom_5b41f63b())
		end
	elseif not __wf_atom_7e8ad928(object) then
		object:__wf_atom_308a9a4d(upgradeID)
	end
end