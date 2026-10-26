local module = require("SF.Scripts.Libs.PlayerPetLib")

function addWolfUpgrades(object, _, _, _, object2)
	if not gRegion:IsMaster() then
		return
	end

	Sleep(1)

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) or __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return
	end

	for i = 0, object2:__wf_atom_5515f328() - 1 do
		local __wf_atom_3e32b814 = object2:__wf_atom_3e32b814(i)
		local __wf_atom_7eb8181a = object2:__wf_atom_7eb8181a(i)
		local __wf_atom_f4a8fb82 = object2:__wf_atom_f4a8fb82(i)
		local __wf_atom_348dfac3 = object2:__wf_atom_348dfac3(i)

		if not __wf_atom_7e8ad928(_G.AuraUpgradesApplied) and _G.AuraUpgradesApplied[__wf_atom_3e32b814] ~= nil then
			print("PetAura Warning: We already have a cached value for this and didnt remove it maybe")
		end

		local __wf_atom_4fec12f3 = __wf_atom_a96eb2aa:__wf_atom_4fec12f3(upgradeRequiredStat)
		local petAuraUpgradeValue = module.CalculatePetAuraUpgradeValue(
			__wf_atom_4fec12f3,
			5,
			__wf_atom_f4a8fb82,
			__wf_atom_348dfac3,
			object2:__wf_atom_70f93b03(i)
		)

		if petAuraUpgradeValue == 0 then
			continue
		end

		_G.AuraUpgradesApplied = _G.AuraUpgradesApplied or {}
		_G.AuraUpgradesApplied[__wf_atom_3e32b814] = petAuraUpgradeValue
		__wf_atom_d2b2176d:AddUpgrade(__wf_atom_3e32b814, __wf_atom_7eb8181a, petAuraUpgradeValue)
	end
end

function RemoveWolfUpgrades(object, _, _, _, object2)
	if not gRegion:IsMaster() or (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2)) then
		return
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) or __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return
	end

	for i = 0, object2:__wf_atom_5515f328() - 1 do
		local __wf_atom_3e32b814 = object2:__wf_atom_3e32b814(i)
		local __wf_atom_7eb8181a = object2:__wf_atom_7eb8181a(i)
		object2:__wf_atom_f4a8fb82(i)
		object2:__wf_atom_348dfac3(i)

		if __wf_atom_7e8ad928(_G.AuraUpgradesApplied) or _G.AuraUpgradesApplied[__wf_atom_3e32b814] == nil then
			print("PetAura Warning: We dont have a cached value for this upgrade that should be removed")
		else
			local v = _G.AuraUpgradesApplied[__wf_atom_3e32b814] or 0
			_G.AuraUpgradesApplied[__wf_atom_3e32b814] = nil

			if v ~= 0 then
				__wf_atom_d2b2176d:RemoveUpgrade(__wf_atom_3e32b814, __wf_atom_7eb8181a, v)
			end
		end
	end
end