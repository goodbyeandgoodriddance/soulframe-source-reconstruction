local v = {
	Symbol("CC_DODGE_CANCEL_RIGHT"),
	Symbol("CC_DODGE_CANCEL_LEFT"),
	Symbol("CC_DODGE_CANCEL_BACK"),
	Symbol("CC_DODGE_COUNTER_ATTACK"),
	Symbol("CC_DODGE_COUNTER_ATTACK_BACK")
}

function AddDuplicateDodgeUpgrades(object, object2, _, _, object3)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object3) or not gRegion:IsMaster() then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_06f3cb74 = object3:__wf_atom_06f3cb74()
	local __wf_atom_18aa6e58 = object3:__wf_atom_18aa6e58()

	for i = 1, #v do
		for j = 1, __wf_atom_06f3cb74 do
			local __wf_atom_b9a1f18c = object3:__wf_atom_b9a1f18c(j - 1)
			object2:__wf_atom_e85205e8(__wf_atom_b9a1f18c, __wf_atom_18aa6e58)
			__wf_atom_b9a1f18c:__wf_atom_6ff02bc5(v[i])
			__wf_atom_d2b2176d:AddUpgrade(__wf_atom_b9a1f18c)
		end
	end
end

function RemoveDuplicateDodgeUpgrades(object, object2, _, _, object3)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object3) or not gRegion:IsMaster() then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_06f3cb74 = object3:__wf_atom_06f3cb74()
	local __wf_atom_18aa6e58 = object3:__wf_atom_18aa6e58()

	for i = 1, #v do
		for j = 1, __wf_atom_06f3cb74 do
			local __wf_atom_b9a1f18c = object3:__wf_atom_b9a1f18c(j - 1)
			object2:__wf_atom_e85205e8(__wf_atom_b9a1f18c, __wf_atom_18aa6e58)
			__wf_atom_b9a1f18c:__wf_atom_6ff02bc5(v[i])
			__wf_atom_d2b2176d:RemoveUpgrade(__wf_atom_b9a1f18c)
		end
	end
end