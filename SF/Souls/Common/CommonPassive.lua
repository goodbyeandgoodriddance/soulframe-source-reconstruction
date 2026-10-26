local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function AddUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	if gRegion:IsMaster() then
		local mItemType = object:__wf_atom_d8e96504(4).mItemType

		if not __wf_atom_7e8ad928(mItemType) then
			__wf_atom_6009c8ed:GiveItem(Type(mItemType), false)
		end
	end

	__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_e704ac94(0)
end

function RemoveUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	if gRegion:IsMaster() then
		local mItemType = object:__wf_atom_d8e96504(4).mItemType

		if not __wf_atom_7e8ad928(mItemType) then
			__wf_atom_6009c8ed:RemoveItem(mItemType)
		end
	end

	__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_ec33d862(0)
end

function AddPactWeapon(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(p) then
		object:GiveItem(p, false)
	end

	module.EnableWeaponSlot(object, "Idol", false, 0)

	if not __wf_atom_7e8ad928(p2) then
		object:Attach(p2, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

function RemovePactWeapon(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(p) then
		object:RemoveItem(p)
	end

	module.EnableWeaponSlot(object, "Idol", true, 0)

	if not __wf_atom_7e8ad928(p2) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(p2)

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