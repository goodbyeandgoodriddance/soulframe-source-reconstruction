local v = false

function Evaluate(object, _)
	if v or __wf_atom_7e8ad928(object) then
		v = true
		return false
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if
		__wf_atom_7e8ad928(__wf_atom_30e3d82b)
		or __wf_atom_30e3d82b:__wf_atom_351e924e()
		or __wf_atom_30e3d82b:__wf_atom_211da8d8() < 1
	then
		v = true
		return false
	else
		return true
	end
end

function Activate(object, _)
	v = true
	Sleep(0)
	object:__wf_atom_921c1a5f(ambushAnim, false, 4, 1, true)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local v2 = ambushBeginPropagationDistanceFromAlly * ambushBeginPropagationDistanceFromAlly
	local v3 = rangeFromTargetToAmbush * rangeFromTargetToAmbush
	local __wf_atom_76724198 = __wf_atom_30e3d82b:__wf_atom_76724198()
	Sleep(0)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local v4 = false

	while not v4 do
		if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			return false
		end

		if
			__wf_atom_30e3d82b:__wf_atom_211da8d8() < 1
			or unburrowOnCombat and __wf_atom_30e3d82b:__wf_atom_351e924e()
		then
			break
		end

		local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

		if not __wf_atom_7e8ad928(__wf_atom_216d6edd) and __wf_atom_216d6edd:__wf_atom_9af7625d(object) <= v3 then
			break
		end

		local __wf_atom_694c2c5b = __wf_atom_30e3d82b:__wf_atom_694c2c5b()

		for i = 1, #__wf_atom_694c2c5b do
			local v5 = __wf_atom_694c2c5b[i]
			local __wf_atom_30e3d82b2 = v5:__wf_atom_30e3d82b()

			if
				__wf_atom_7e8ad928(__wf_atom_30e3d82b2)
				or not (not requireSameEncounterHintParentForPropagation or __wf_atom_76724198 == __wf_atom_30e3d82b2:__wf_atom_76724198())
			then
				continue
			end

			local __wf_atom_216d6edd2 = __wf_atom_30e3d82b2:__wf_atom_216d6edd()

			if
				__wf_atom_7e8ad928(__wf_atom_216d6edd2)
				or not (object:__wf_atom_9af7625d(v5) <= v2)
				or not (__wf_atom_216d6edd2:__wf_atom_9af7625d(v5) <= v3)
			then
				continue
			end

			v4 = true
			break
		end

		Sleep(0.1)
	end

	if not __wf_atom_7e8ad928(object) then
		object:Unburrow(false)
		Sleep(3)
	end

	return true
end

function Update(_, _) end

function Deactivate(_, _) end

function UnburrowRadialDamage(object)
	local __wf_atom_15197633 = object:__wf_atom_21ed1a39():__wf_atom_15197633()
	local radialDamageData = Engine.RadialDamageData()
	local __wf_atom_1c374cc9 = __wf_atom_15197633:__wf_atom_1c374cc9(unburrowRDBoneName)
	radialDamageData.radius = unburrowRDRadius
	radialDamageData.baseAmount = unburrowDamage
	radialDamageData.stabilityDamage = unburrowStabilityDamage
	radialDamageData.blockableProjType = 4
	radialDamageData:__wf_atom_98d98d81(__wf_atom_1c374cc9)

	if not __wf_atom_7e8ad928(__wf_atom_15197633) then
		radialDamageData:__wf_atom_6b472125(__wf_atom_15197633)
		radialDamageData:__wf_atom_34a8a27a(__wf_atom_15197633:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
	end

	gRegion:__wf_atom_f6ec80de(radialDamageData)
	gRegion:CreateEntity(unburrowFX, __wf_atom_1c374cc9, __wf_atom_80368bb1)
end