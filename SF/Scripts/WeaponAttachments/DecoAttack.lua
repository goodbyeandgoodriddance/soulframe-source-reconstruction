local function fn(object, p)
	local damageData = Engine.DamageData()
	damageData:__wf_atom_6b472125(p)
	damageData:__wf_atom_34a8a27a(p)
	damageData:__wf_atom_6d7ec072(Engine.UpgradedValue(damageAmount))
	damageData.stabilityDamage = stabilityDamage
	damageData:__wf_atom_7498285f(0, 1)
	object:__wf_atom_649bf33e(damageData)
end

local function fn2(object, object2)
	if __wf_atom_7e8ad928(object2) then
		if __wf_atom_7e8ad928(customFailAnim) then
			return
		end

		object:__wf_atom_921c1a5f(customFailAnim, false, 4, 1, false)
	else
		if gRegion:IsMaster() and not __wf_atom_7e8ad928(meleeWeaponFinisher) then
			object:__wf_atom_70ca09b9(meleeWeaponFinisher, object2)
		end

		local v

		if not __wf_atom_7e8ad928(instigatorFxType) then
			v = object:Attach(instigatorFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
		end

		local v2

		if not __wf_atom_7e8ad928(targetFxType) then
			v2 = object2:Attach(targetFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
		end

		local total = 0

		while not object:__wf_atom_611b620c() or not object:__wf_atom_40a4ba6c() and total < finisherTimeout do
			total += __wf_atom_084b3e93()
			Sleep(0)
		end

		local total2 = 0

		while object:__wf_atom_611b620c() or object:__wf_atom_40a4ba6c() and total2 < finisherTimeout do
			total2 += __wf_atom_084b3e93()
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(v) then
			v:Destroy()
		end

		if not __wf_atom_7e8ad928(v2) then
			v2:Destroy()
		end
	end
end

function TraceForMeleeAttack(_) end

function hideBones(object)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(boneList) then
		return
	end

	for _, v in ipairs(boneList) do
		object:__wf_atom_83fac646(v, __wf_atom_80368bb1, __wf_atom_28d5d4aa, Vector(0.001, 0.001, 0.001))
	end
end