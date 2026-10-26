local v = false

local function fn(object, object2)
	if __wf_atom_7e8ad928(object2) or object2:IsKilled() or object2:__wf_atom_bedb4e3f() then
		if __wf_atom_7e8ad928(customFailAnim) then
			return
		end

		object:__wf_atom_921c1a5f(customFailAnim, false, 4, 1, false)
	else
		if gRegion:IsMaster() and not __wf_atom_7e8ad928(meleeWeaponFinisher) then
			object:__wf_atom_70ca09b9(meleeWeaponFinisher, object2)
		end

		local v2

		if not __wf_atom_7e8ad928(instigatorFxType) then
			v2 = object:Attach(instigatorFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
		end

		local v3

		if not __wf_atom_7e8ad928(targetFxType) then
			v3 = object2:Attach(targetFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
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

		if not __wf_atom_7e8ad928(v2) then
			v2:Destroy()
		end

		if not __wf_atom_7e8ad928(v3) then
			v3:Destroy()
		end
	end
end

function CheckForFinisher(object)
	if #weaponBones == 0 then
		table.insert(weaponBones, object:__wf_atom_f5bac0e4())
	end

	local __wf_atom_6009c8ed = object:__wf_atom_21ed1a39():__wf_atom_6009c8ed()
	local v2 = {}

	if gRegion:IsMaster() and isFinisherParryable then
		__wf_atom_6009c8ed:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")
	end

	for i = 1, #weaponBones do
		table.insert(v2, __wf_atom_6009c8ed:__wf_atom_1c374cc9(weaponBones[i]))
	end

	local v3 = nil
	local total = 0

	while __wf_atom_7e8ad928(v3) and not (sweepTimeOut <= total or v) do
		for i = 1, #weaponBones do
			local __wf_atom_1c374cc9 = __wf_atom_6009c8ed:__wf_atom_1c374cc9(weaponBones[i], true)

			if drawFinisherTraceDebug then
				gRegion:__wf_atom_8d991675(__wf_atom_1c374cc9, meleeRange, damageDebugTraceColour, 0.5)
			end

			local __wf_atom_4ea726bc = gRegion:__wf_atom_4ea726bc(
				v2[i],
				__wf_atom_1c374cc9,
				meleeRange,
				acceptedTargetsTypes,
				nil
			)

			for _, v4 in pairs(__wf_atom_4ea726bc) do
				if __wf_atom_7e8ad928(v4) or v4:IsKilled() or v4:__wf_atom_bedb4e3f() then
					continue
				end

				v3 = v4
			end

			v2[i] = __wf_atom_1c374cc9
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v3) or v then
		if not __wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(customFailAnim) then
			return
		end

		__wf_atom_6009c8ed:__wf_atom_921c1a5f(customFailAnim, false, 4, 1, false)
	else
		fn(__wf_atom_6009c8ed, v3)
		print("Imma do a finsher now raw xd")
	end
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(mOwner) then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if __wf_atom_9d766292:__wf_atom_78650070(21) or __wf_atom_9d766292:__wf_atom_78650070(29) then
		v = true
	end
end