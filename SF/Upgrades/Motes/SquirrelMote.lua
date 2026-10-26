local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = 10
local v2 = 0.2

local function fn(p, _, object)
	if __wf_atom_7e8ad928(object) then
		object = module2.GetWeaponMote(mOwner:__wf_atom_3371f607())
	end

	local v3 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()

	if v3 == 0 then
		if p == 1 then
			v = 12
			v2 = 0.06
		elseif p == 2 then
			v = 14
			v2 = 0.8
		elseif p == 3 then
			v = 16
			v2 = 0.1
		else
			v = 18
			v2 = 0.12
		end
	elseif v3 == 1 then
		if p == 1 then
			v = 12
			v2 = 0.14
		elseif p == 2 then
			v = 14
			v2 = 0.16
		elseif p == 3 then
			v = 16
			v2 = 0.18
		else
			v = 18
			v2 = 0.2
		end
	elseif v3 == 2 then
		if p == 1 then
			v = 12
			v2 = 0.24
		elseif p == 2 then
			v = 14
			v2 = 0.26
		elseif p == 3 then
			v = 16
			v2 = 0.28
		else
			v = 18
			v2 = 0.3
		end
	end
end

function NpcEvaluateAbility(_, _)
	return 0
end

function ActivateAbility(object, object2, _, p, _)
	fn(p, object2)
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_6a5c92a7 = object:__wf_atom_6a5c92a7((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))))
	mOwner:__wf_atom_34c9b8f6(__wf_atom_6a5c92a7 / v)

	if gRegion:IsMaster() then
		local upgrade = Game.Upgrade()
		upgrade:__wf_atom_be789bbd(315)
		upgrade:__wf_atom_d31be7a2(3)
		upgrade:SetValue(v2)
		upgrade:__wf_atom_60553695(30, true)
		upgrade:__wf_atom_f86ad724(mOwner:__wf_atom_3371f607())
		object2:__wf_atom_d2b2176d():AddUpgrade(upgrade)
	end

	if not __wf_atom_7e8ad928(object2) then
		local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

		if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
			local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				mOwner:__wf_atom_7ccf4243(activeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_dc5956fc(
					__wf_atom_66088189,
					EMPTY_SYMBOL
				)
			end

			local __wf_atom_66088189_2 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

			if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
				mOwner:__wf_atom_7ccf4243(activeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_dc5956fc(
					__wf_atom_66088189_2,
					EMPTY_SYMBOL
				)
			end
		end
	end

	while not __wf_atom_7e8ad928(object2) do
		if object2:__wf_atom_c138b19b(activateAnim) then
			Sleep(0)
		else
			module2.EnableWeaponFiring(object2, mOwner, true)
			break
		end
	end

	while not __wf_atom_7e8ad928(object2) do
		Sleep(0)
	end
end

function DeactivateAbility(_, object, _, p)
	mOwner:__wf_atom_34c9b8f6(0)
	fn(p, object)

	if gRegion:IsMaster() then
		local upgrade = Game.Upgrade()
		upgrade:__wf_atom_be789bbd(315)
		upgrade:__wf_atom_d31be7a2(3)
		upgrade:SetValue(v2)
		upgrade:__wf_atom_60553695(30, true)
		upgrade:__wf_atom_f86ad724(mOwner:__wf_atom_3371f607())
		object:__wf_atom_d2b2176d():RemoveUpgrade(upgrade)
	end

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	module2.EnableWeaponFiring(object, mOwner, true)
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, nil, p2)
	local v3 = {
		BONUS = module.FormatNumber(v2 * 100, 0)
	}
	return cjson.encode(v3)
end