local v = 0.02
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(p, p2, object)
	local v2 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v3 = not module2.UpgradeMatchesSlotPolarity(object) and 1 or module2.totemForceCalc(p2, p, object)

	if v2 == 0 then
		if p == 1 then
			v = 2
		elseif p == 2 then
			v = 2
		else
			if p == 3 then
			end

			v = 3
		end
	elseif v2 == 1 then
		if p == 1 then
			v = 3
		elseif p == 2 then
			v = 3
		elseif p == 3 then
			v = 4
		else
			v = 5
		end
	elseif p == 1 then
		v = 3
	elseif p == 2 then
		v = 4
	elseif p == 3 then
		v = 5
	else
		v = 6
	end

	v = math.round(v * v3)
end

local function fn2(object, __wf_atom_d2b2176d, p)
	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) or __wf_atom_7e8ad928(object) then
		return nil
	end

	local weaponMoteAbility = module2.GetWeaponMoteAbility(p)

	if not __wf_atom_7e8ad928(weaponMoteAbility) then
		local __wf_atom_b9421344 = object:__wf_atom_b9421344(weaponMoteAbility, p)

		if __wf_atom_b9421344 < object:__wf_atom_87a16e10() then
			return object:__wf_atom_2e4994f1(__wf_atom_b9421344)
		end
	end

	return nil
end

function OnUpgradeApplied(object, p, p2, _, p3)
	if gRegion:IsMaster() then
		fn(p2, object, p3)
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
		local v2 = 0
		local v3

		if useMagikArmour then
			v3 = 25
		else
			v3 = 21
		end

		while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p)) do
			local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
			local v4 = fn2(__wf_atom_e55d02aa, __wf_atom_d2b2176d, p)

			if not __wf_atom_7e8ad928(v4) then
				local v5

				if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
					v5 = false
				else
					local __wf_atom_f3044fe0 = __wf_atom_e55d02aa:__wf_atom_f3044fe0(v4)
					v5 = 0

					while __wf_atom_f3044fe0 >= 50 do
						v5 += 1
						__wf_atom_f3044fe0 -= 50
					end
				end

				if v5 ~= v2 then
					if v2 > 0 then
						__wf_atom_d2b2176d:RemoveUpgrade(20, 0, v * v2, nil, nil, v3)
					end

					if v5 > 0 then
						__wf_atom_d2b2176d:AddUpgrade(20, 0, v * v5, nil, nil, v3)
					end

					v2 = v5
				end
			end

			Sleep(0.1)
		end
	end
end

function GetStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v2 = { BONUS = module.FormatNumber(v, 0) }
	return cjson.encode(v2)
end