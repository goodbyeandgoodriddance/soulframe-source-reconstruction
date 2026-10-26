local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.PlayerPetLib")

function TalismanEquipped(object, p, object2)
	if not gRegion:IsMaster() then
		return
	end

	module.WaitForLevel()
	module.WaitForLoginSequence()
	module.WaitForAiDir()
	Sleep(3)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	while not __wf_atom_7e8ad928(object2) and object2:__wf_atom_d21cd30a() == p do
		if object:__wf_atom_799d95f5() then
			while not __wf_atom_7e8ad928(object) and object:__wf_atom_799d95f5() do
				Sleep(2)
			end
		else
			local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

			if
				not __wf_atom_7e8ad928(__wf_atom_a96eb2aa)
				and __wf_atom_7e8ad928(module2.GetPetAvatar(__wf_atom_a96eb2aa))
				and module2.CanSummonPet(object)
			then
				local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
				local __wf_atom_dd7246c7 = __wf_atom_a96eb2aa:__wf_atom_dd7246c7()
				local v

				if __wf_atom_7e8ad928(__wf_atom_dd7246c7) then
					v = object:__wf_atom_a06d543c()
				else
					v = __wf_atom_dd7246c7:__wf_atom_a06d543c()
				end

				local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(
					__wf_atom_a2a18137 + __wf_atom_9341614d(v, Rotation(60, 0, 0)) * 2,
					1,
					5
				)

				if not __wf_atom_7e8ad928(__wf_atom_0e0a6fee) then
					local summonPlayerPet = module2.SummonPlayerPet(object, __wf_atom_0e0a6fee)

					while not __wf_atom_7e8ad928(summonPlayerPet) do
						Sleep(10)
					end
				end
			end

			Sleep(10)
		end
	end
end

function TalismanUnequipped(_) end