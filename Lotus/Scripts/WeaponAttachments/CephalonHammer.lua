local v = Symbol("AlphaAtten")
local v2 = Symbol("RotateAmount")

function ConstantGlow(object)
	Sleep(0)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	if _T.cephHammer == nil then
		_T.cephHammer = {}
	end

	if _T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] == nil then
		_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] = 0.05
	end

	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	local isA = gGameRules:IsA(__wf_atom_e714d8ac)
	_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] = 0.05
	local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()
	local isA2 = gGameRules:IsA(__wf_atom_311a7128)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_afd78c4b)
	local v3 = true
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(flareType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:__wf_atom_008aae7f(0)
	end

	while not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(object)) do
		local equippedBaseLevelToAdd2 = math.max(
			baseLevel - 0.2,
			_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()]
		)

		if
			maxChargeWhileChanneling
			and not __wf_atom_7e8ad928(__wf_atom_21ed1a39)
			and __wf_atom_21ed1a39:__wf_atom_bb46daaa()
		then
			_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] = 3.5
			equippedBaseLevelToAdd2 = 3.5
		end

		local __wf_atom_2784da18 = __wf_atom_d2b2176d:__wf_atom_2784da18(0, __wf_atom_21ed1a39)

		if isA2 and equippedBaseLevelToAdd > 0 and __wf_atom_2784da18 then
			equippedBaseLevelToAdd2 = equippedBaseLevelToAdd
			_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] = equippedBaseLevelToAdd2
		end

		if __wf_atom_2784da18 then
			if not v3 then
				object:__wf_atom_fd3ec680(matParam, 3, 1, 0, 0, 0)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:__wf_atom_008aae7f(0)
				end
			end
		elseif v3 then
			object:__wf_atom_fd3ec680(matParam, 3, 0, 0, 0, 0)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:__wf_atom_008aae7f(1)
			end
		end

		if baseLevel - 0.2 < equippedBaseLevelToAdd2 then
			if equippedBaseLevelToAdd2 < baseLevel then
				equippedBaseLevelToAdd2 = baseLevel
			end

			object:__wf_atom_fd3ec680(matParam, 1, equippedBaseLevelToAdd2, 0, 0, 0)
			object:SetMaterialParam(v2, (math.pow(equippedBaseLevelToAdd2, 3)))

			if #__wf_atom_f582136d > 0 then
				v3 = __wf_atom_2784da18

				for i = #__wf_atom_f582136d, 1, -1 do
					local v4 = __wf_atom_f582136d[i]

					if __wf_atom_7e8ad928(v4) then
						table.remove(__wf_atom_f582136d, i)
					else
						v4:SetMaterialParam(v, (math.min(equippedBaseLevelToAdd2, 1)))
					end
				end
			else
				v3 = __wf_atom_2784da18
			end

			Sleep(0)
			local v4 = __wf_atom_084b3e93()

			if authoritative then
				_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] = math.max(
					baseLevel - 0.2,
					_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] - v4 * decayRate
				)

				if
					equippedBaseLevelToAdd > 0
					and _T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] < equippedBaseLevelToAdd
					and (__wf_atom_d2b2176d:__wf_atom_2784da18(0, __wf_atom_21ed1a39) or __wf_atom_6009c8ed:__wf_atom_611b620c())
				then
					_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] = math.min(
						equippedBaseLevelToAdd,
						_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] + v4 * decayRate * 2
					)
				end
			end
		else
			Sleep(0)
			v3 = __wf_atom_2784da18
		end

		if isA and not _T.ArsenalOpen and equippedBaseLevelToAdd2 <= baseLevel then
			break
		end
	end
end

function WeaponAttack(object)
	local __wf_atom_6009c8ed = object:__wf_atom_21ed1a39():__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) or not authoritative or _T.cephHammer == nil then
		return
	end

	if __wf_atom_7e8ad928(_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()]) then
		_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] = 0
	end

	_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] = math.min(
		3.5,
		_T.cephHammer[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] + valueScale
	)
end

function ScanFXOnKill(object, instance, p)
	local scanFX2 = nil

	if p == 8 then
		scanFX2 = scanFX
	elseif p == 3 or p == 8 then
		scanFX2 = scanfullFX
	end

	if not __wf_atom_7e8ad928(scanFX2) then
		local v3 = instance:Attach(scanFX2, EMPTY_SYMBOL)

		if not __wf_atom_7e8ad928(v3) and instance:IsA(__wf_atom_7e6ed5fa) and instance:__wf_atom_5d2fc50d() then
			v3:__wf_atom_1b57cb83(false)
		end
	end

	if object:__wf_atom_6009c8ed() then
		object:__wf_atom_6009c8ed():PlaySound(scanSound, false, 0, false)
	end
end

function OnDamageDone(object, object2, object3)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if
		gRegion:IsMaster()
		and not __wf_atom_7e8ad928(object3)
		and object3:IsKilled()
		and not __wf_atom_7e8ad928(__wf_atom_6009c8ed)
		and __wf_atom_6009c8ed:__wf_atom_7b82e9e1(30)
	then
		local __wf_atom_fea08f6b = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_fea08f6b()

		if not (__wf_atom_7e8ad928(__wf_atom_fea08f6b) or __wf_atom_fea08f6b:IsKilled()) then
			local v3 = (object2:__wf_atom_9232afe2() + object2:__wf_atom_4c2d7fc1() + object2:__wf_atom_ff55d141()) * healPct
			__wf_atom_fea08f6b:SetHealth((math.min(
				__wf_atom_fea08f6b:GetMaxHealth(),
				__wf_atom_fea08f6b:__wf_atom_c6f1f83d() + v3
			)))
		end
	end
end