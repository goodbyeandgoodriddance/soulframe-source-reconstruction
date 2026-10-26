function DamageBlocked(object, _, object2)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	gRegion:__wf_atom_c189a462(object:GetPosition(), object2:__wf_atom_3e5615f2(), Color(0, 125, 255), 1)
end

function SpawnFX(object)
	if not __wf_atom_7e8ad928(shieldFxType) then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_67c46eba) then
			__wf_atom_3d96ddcd:Attach(shieldFxType, shieldFXAttachBone, shieldFXOffset, __wf_atom_80368bb1)
		end
	end
end

function StateChange(object, p)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_67c46eba) then
		local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(shieldFxType)

		if not (__wf_atom_7e8ad928(__wf_atom_bb3e7833) or p) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function SpawnShield(_, _, object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_8914dfde(shieldSpawnAnimEvent, 2)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = shieldDamageRadius
	radialDamageData.baseAmount = shieldDamageAmount
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_98d98d81(object:__wf_atom_1c374cc9(shieldDecoAttachBone))
	radialDamageData.stabilityDamage = shieldStabilityDamage
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	gRegion:CreateEntity(shieldSpawnVFX, object:__wf_atom_1c374cc9(shieldDecoAttachBone), __wf_atom_80368bb1)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(shieldDecoType)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		object:Attach(shieldDecoType, shieldDecoAttachBone, shieldDecoOffset, __wf_atom_80368bb1, object, 1)
	else
		__wf_atom_bb3e7833:__wf_atom_6cf07262(0)
	end
end

function OnAbilityEnded(_, _, object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(shieldDecoType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:__wf_atom_6cf07262(shieldLifespanAfterCharge)
	end
end