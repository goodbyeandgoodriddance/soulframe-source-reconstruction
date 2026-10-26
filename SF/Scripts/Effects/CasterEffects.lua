function HitProjectorAttach(object, instance)
	if not instance:IsA(__wf_atom_4ebf67cb) then
		return
	end

	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()

	if not __wf_atom_7e8ad928(instance) then
		gRegion:CreateEntity(hitFxType, position, __wf_atom_dc309f8a)
		local v = instance:Attach(hitProjectorType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

		if not __wf_atom_7e8ad928(v) then
			v:SetMaterialParam(Symbol("GradPos"), position.x, position.y, position.z)
		end
	end
end

local function fn(object) -- 2 equivalent calls inferred from this helper
	return not __wf_atom_7e8ad928(object) and (object:GetState() == 16 or object:GetState() == 17)
end

function EquipEmissive(object)
	if not __wf_atom_7e8ad928(TC2025Hack_HolsterCollisionResource) then
		local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

		for _, v in ipairs(__wf_atom_be0bea4a) do
			if v:IsA(TC2025Hack_HolsterCollisionResource) then
				v:__wf_atom_5e560c7f(false)
			end
		end
	end

	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()
	local v = 0

	while v < emissiveRampTime and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_21ed1a39)) do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93(), 0, emissiveRampTime)
		local v2 = __wf_atom_104bfe98(0, emissiveMapAtten, __wf_atom_24a82b69(v / emissiveRampTime))
		object:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, v2)
		Sleep(0)

		if fn(__wf_atom_21ed1a39) then -- inferred equivalent call
			break
		end
	end
end

function UnEquipEmissive(object)
	if not __wf_atom_7e8ad928(TC2025Hack_HolsterCollisionResource) then
		local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

		for _, v in ipairs(__wf_atom_be0bea4a) do
			if v:IsA(TC2025Hack_HolsterCollisionResource) then
				v:__wf_atom_5e560c7f(true)
			end
		end
	end

	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()
	local v = 0

	while v < emissiveRampTime and not __wf_atom_7e8ad928(object) do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93(), 0, emissiveRampTime)
		local v2 = __wf_atom_104bfe98(emissiveMapAtten, 0, __wf_atom_24a82b69(v / emissiveRampTime))
		object:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, v2)
		Sleep(0)

		if not fn(__wf_atom_21ed1a39) then -- inferred equivalent call
			break
		end
	end
end