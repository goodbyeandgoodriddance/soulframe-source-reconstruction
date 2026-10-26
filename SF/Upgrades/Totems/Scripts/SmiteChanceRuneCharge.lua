local v = 0.02
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(p, p2, object)
	local v2 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v3 = not module2.UpgradeMatchesSlotPolarity(object) and 1 or module2.totemForceCalc(p2, p, object)

	if v2 == 0 then
		if p == 1 then
			v = 0.005
		elseif p == 2 then
			v = 0.01
		elseif p == 3 then
			v = 0.015
		else
			v = 0.02
		end
	elseif v2 == 1 then
		if p == 1 then
			v = 0.01
		elseif p == 2 then
			v = 0.02
		elseif p == 3 then
			v = 0.03
		else
			v = 0.04
		end
	elseif p == 1 then
		v = 0.015
	elseif p == 2 then
		v = 0.025
	elseif p == 3 then
		v = 0.035
	else
		v = 0.045
	end

	v *= v3
end

local function fn2(object, __wf_atom_d2b2176d, object2)
	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) or __wf_atom_7e8ad928(object) then
		return nil
	end

	local weaponMoteAbility = module2.GetWeaponMoteAbility(object2)

	if not __wf_atom_7e8ad928(weaponMoteAbility) then
		local __wf_atom_b9421344 = object:__wf_atom_b9421344(weaponMoteAbility, object2)

		if __wf_atom_b9421344 < object:__wf_atom_87a16e10() then
			return object:__wf_atom_2e4994f1(__wf_atom_b9421344)
		end
	end

	return nil
end

function OnUpgradeApplied(object, object2, p, _, p2)
	if gRegion:IsMaster() then
		fn(p, object, p2)
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
		local v2 = 0

		while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2)) do
			local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
			local v3 = fn2(__wf_atom_e55d02aa, __wf_atom_d2b2176d, object2)

			if not __wf_atom_7e8ad928(v3) then
				local v4

				if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
					v4 = false
				else
					local __wf_atom_f3044fe0 = __wf_atom_e55d02aa:__wf_atom_f3044fe0(v3)
					v4 = 0

					while __wf_atom_f3044fe0 >= 50 do
						v4 += 1
						__wf_atom_f3044fe0 -= 50
					end
				end

				if v4 ~= v2 then
					if v2 > 0 then
						__wf_atom_d2b2176d:RemoveUpgrade(283, 1, v * v2, object2:__wf_atom_1bb5b1ff(), object2)
					end

					if v4 > 0 then
						__wf_atom_d2b2176d:AddUpgrade(283, 1, v * v4, object2:__wf_atom_1bb5b1ff(), object2)
					end

					v2 = v4
				end
			end

			Sleep(0.1)
		end
	end
end

function GetStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v2 = {
		BONUS = module.FormatNumber(v * 100, 1)
	}
	return cjson.encode(v2)
end