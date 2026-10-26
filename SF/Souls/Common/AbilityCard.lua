local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function ApplyUpgrade(object, object2, _, _, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(WeaponType) then
		v = object:GiveItem(WeaponType, false)
	end

	module.EnableWeaponSlot(object, "Idol", enableWeapon, 0)

	if not __wf_atom_7e8ad928(EffectsType) then
		object:Attach(EffectsType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	if not __wf_atom_7e8ad928(v) and v:__wf_atom_0c701b2c() then
		while not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(v)) do
			local __wf_atom_22941262 = object2:__wf_atom_22941262()

			if __wf_atom_22941262 ~= v:__wf_atom_22941262() then
				v:__wf_atom_5de8eac1((__wf_atom_c67f9605:__wf_atom_89d4ac2a(__wf_atom_22941262, WeaponType)))
			end

			Sleep(0.25)
		end
	end
end

function UnapplyUpgrade(object, _, _, _, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(WeaponType) then
		object:RemoveItem(WeaponType)
	end

	module.EnableWeaponSlot(object, "Idol", true, 0)

	if not __wf_atom_7e8ad928(EffectsType) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(EffectsType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end

	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_032e921b)

	for _, v in ipairs(__wf_atom_f582136d) do
		if v:HasTag(Symbol("IdolAvatarAttach")) then
			v:Destroy()
		end
	end
end