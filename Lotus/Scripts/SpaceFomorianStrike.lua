local v = Symbol("GAME_C1_HIP1")
local heading = 0
local pitch = 0
local flag = false
local v2 = WeakResource("/EE/Types/Engine/SafeVolume")

local function fn(p, p2) -- 1 equivalent call inferred from this helper
	local v3 = p + p2

	if v3 > 180 then
		return v3 - 360
	end

	if v3 < -180 then
		return v3 + 360
	end

	return v3
end

local function fn2(p, p2, p3)
	local v3

	if p2 - p > 180 then
		v3 = p2 - 360
	elseif p2 - p < -180 then
		v3 = p2 + 360
	else
		v3 = p2
	end

	local v4 = v3 - p

	if v4 - p3 > 180 then
		v4 -= 360
	elseif v4 - p3 < -180 then
		v4 += 360
	end

	if v4 - p3 > 0 then
		return fn(p, p3) -- inferred equivalent call
	else
		local v5

		if p - p2 > 180 then
			v5 = p - 360
		elseif p - p2 < -180 then
			v5 = p + 360
		else
			v5 = p
		end

		local v6 = v5 - p2

		if v6 - p3 > 180 then
			v6 -= 360
		elseif v6 - p3 < -180 then
			v6 += 360
		end

		if not (v6 - p3 > 0) then
			return p2
		end

		if p - p3 > 180 then
			p -= 360
		elseif p - p3 < -180 then
			p += 360
		end

		return p - p3
	end
end

function InitBeams(object)
	local v3

	while true do
		v3 = object:__wf_atom_f582136d(beamType)

		if #v3 > 0 then
			break
		end

		Sleep(0)
	end

	for i = 2, #v3 do
		local __wf_atom_fa6a8faf = v3[i]:__wf_atom_fa6a8faf()
		local v4 = __wf_atom_fa8d0177(__wf_atom_fa6a8faf, laserConvergeOffset)
		v3[i]:__wf_atom_e310f01f(__wf_atom_fa6a8faf, v4)
		v3[i]:__wf_atom_2ecde728(Length(laserConvergeOffset - __wf_atom_fa6a8faf))
	end
end

function BeamEffects(object)
	local v3 = 0

	while v3 < 1 do
		object:__wf_atom_400189c4(v3 * 0.6)
		object:SetMaterialParam(SF.__wf_atom_f35beb09, v3 * 5)
		v3 += __wf_atom_084b3e93() * 4
		Sleep(0)
	end

	Sleep(0.75)

	while v3 > 0 do
		object:__wf_atom_400189c4(v3 * 0.6)
		object:SetMaterialParam(SF.__wf_atom_f35beb09, v3 * 5)
		v3 -= __wf_atom_084b3e93() * 1
		Sleep(0)
	end
end

local function fn3(object)
	Sleep(0)
	local damageData = Engine.DamageData()
	damageData.baseAmount = beamDamagePerSecond * 0.1
	damageData:__wf_atom_7498285f(beamDamageType, 1)
	damageData:__wf_atom_812165c6(0)
	local v3 = 2
	local v4 = {}

	while v3 > 0 and not __wf_atom_7e8ad928(object) do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for i = 1, #__wf_atom_ef7900cf do
			local v5 = __wf_atom_ef7900cf[i]

			if
				__wf_atom_7e8ad928(v5)
				or v5:IsKilled()
				or not (object:__wf_atom_227ed600(v5:__wf_atom_a2a18137()) <= 1.25)
			then
				continue
			end

			local v6 = object:__wf_atom_a2a18137() - v5:__wf_atom_a2a18137()
			Normalize(v6)
			damageData:__wf_atom_12cf5317(v6)
			v5:__wf_atom_649bf33e(damageData)

			if v5:__wf_atom_a586ea4c(sphereType) then
				continue
			end

			table.insert(v4, v5)
			v5:Attach(sphereType, v)

			if not v5:__wf_atom_c138b19b(dmgAnim) then
				v5:__wf_atom_921c1a5f(dmgAnim, false, 2, 1, true)
			end
		end

		Sleep(0.1)
		v3 -= 0.1
	end

	Sleep(1)

	for i = 1, #v4 do
		local v5 = v4[i]

		if __wf_atom_7e8ad928(v5) then
			continue
		end

		local __wf_atom_bb3e7833 = v5:__wf_atom_bb3e7833(sphereType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function LaserWatch(object)
	while not __wf_atom_7e8ad928(object) and __wf_atom_7e8ad928(object:__wf_atom_3d96ddcd()) do
		Sleep(0)
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(beamType)

	if #__wf_atom_f582136d == 0 then
		return
	end

	local v3 = __wf_atom_f582136d[1]
	local v4 = nil

	while not __wf_atom_7e8ad928(object) do
		local isEnabled = object:IsEnabled()

		if v4 ~= isEnabled then
			if isEnabled then
				for i = 1, #__wf_atom_f582136d do
					if __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
						continue
					end

					__wf_atom_f582136d[i]:Enable()
					__wf_atom_f582136d[i]:__wf_atom_8a035cd5(Symbol("BeamEffects"), false)
				end

				__wf_atom_3d96ddcd:PlaySound(laserBeamSound, false, 0, false)

				if gRegion:IsMaster() and not __wf_atom_7e8ad928(v3) then
					fn3(v3)
					object:Disable()
				end
			else
				for i = 1, #__wf_atom_f582136d do
					if not __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
						__wf_atom_f582136d[i]:Disable()
					end
				end
			end
		end

		Sleep(0)
		v4 = isEnabled
	end
end

function LaserMoveWatcher(object)
	while not __wf_atom_7e8ad928(object) and __wf_atom_7e8ad928(object:__wf_atom_3d96ddcd()) do
		Sleep(0)
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(moveSequencerType)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	local v3 = nil

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_bb3e7833)) do
		local isEnabled = object:IsEnabled()

		if v3 ~= isEnabled then
			if isEnabled then
				__wf_atom_bb3e7833:Enable()
			else
				__wf_atom_bb3e7833:Disable()
			end
		end

		Sleep(0)
		v3 = isEnabled
	end
end

local function fn4(object, p)
	if object:__wf_atom_a2a18137() == p then
		return 0, 0
	end

	local v3 = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), p)
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()

	if v3.heading == __wf_atom_2f2bada0.heading and v3.pitch == __wf_atom_2f2bada0.pitch then
		return 0, 0
	end

	local v4 = __wf_atom_084b3e93() * eyeRotRate
	local heading2 = __wf_atom_2f2bada0.heading
	local heading3 = v3.heading

	if heading2 - heading3 > 180 then
		heading2 -= 360
	elseif heading2 - heading3 < -180 then
		heading2 += 360
	end

	if math.abs(heading2 - heading3) <= v4 then
		__wf_atom_2f2bada0.heading = v3.heading
	else
		__wf_atom_2f2bada0.heading = fn2(__wf_atom_2f2bada0.heading, v3.heading, v4)
	end

	local pitch2 = __wf_atom_2f2bada0.pitch
	local pitch3 = v3.pitch

	if pitch2 - pitch3 > 180 then
		pitch2 -= 360
	elseif pitch2 - pitch3 < -180 then
		pitch2 += 360
	end

	if math.abs(pitch2 - pitch3) <= v4 then
		__wf_atom_2f2bada0.pitch = v3.pitch
	else
		__wf_atom_2f2bada0.pitch = fn2(__wf_atom_2f2bada0.pitch, v3.pitch, v4)
	end

	local v5 = 0.5 * eyeFOVLock
	local heading4 = __wf_atom_2f2bada0.heading
	local v6 = heading

	if heading4 - v6 > 180 then
		heading4 -= 360
	elseif heading4 - v6 < -180 then
		heading4 += 360
	end

	local v7 = heading4 - v6
	local pitch4 = __wf_atom_2f2bada0.pitch
	local v8 = pitch

	if pitch4 - v8 > 180 then
		pitch4 -= 360
	elseif pitch4 - v8 < -180 then
		pitch4 += 360
	end

	local v9 = pitch4 - v8

	if v5 < math.abs(v7) then
		__wf_atom_2f2bada0.heading = heading + __wf_atom_421b01aa(v7, -v5, v5)
	end

	if v5 < math.abs(v9) then
		__wf_atom_2f2bada0.pitch = pitch + __wf_atom_421b01aa(pitch, -v5, v5)
	end

	object:__wf_atom_9b788a35(__wf_atom_2f2bada0)
	local heading5 = __wf_atom_2f2bada0.heading
	local heading6 = v3.heading

	if heading5 - heading6 > 180 then
		heading5 -= 360
	elseif heading5 - heading6 < -180 then
		heading5 += 360
	end

	local v10 = heading5 - heading6
	local pitch5 = __wf_atom_2f2bada0.pitch
	local pitch6 = v3.pitch

	if pitch5 - pitch6 > 180 then
		pitch5 -= 360
	elseif pitch5 - pitch6 < -180 then
		pitch5 += 360
	end

	return v10, pitch5 - pitch6
end

local function fn5(p)
	if __wf_atom_7e8ad928(_T.gWeaponAlreadyChosen) or not _T.gWeaponAlreadyChosen then
		_T.gWeaponAlreadyChosen = true
		flag = true
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MasterSafe"))
	local result = {}

	for i = 1, #__wf_atom_ef7900cf do
		local v3 = __wf_atom_ef7900cf[i]

		if __wf_atom_7e8ad928(v3) then
			continue
		end

		local __wf_atom_a96eb2aa = v3:__wf_atom_a96eb2aa()

		if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			continue
		end

		local __wf_atom_ef151cfd = __wf_atom_a96eb2aa:__wf_atom_ef151cfd()

		if __wf_atom_7e8ad928(_T.gSafePlayers[__wf_atom_ef151cfd]) then
			if flag then
				local all = gRegion:FindAll(v2)
				local safe = 0

				for j = 1, #all do
					if all[j]:IsTouching(v3) then
						safe = 1
					end
				end

				_T.gSafePlayers[__wf_atom_ef151cfd] = {
					safe = safe,
					duration = 0,
					warned = false,
					aborted = false,
					superWeaponSafe = 0
				}
			end

			table.insert(result, __wf_atom_a96eb2aa)
		else
			if v3:IsKilled() then
				if flag then
					_T.gSafePlayers[__wf_atom_ef151cfd] = {
						safe = 0,
						duration = 0,
						warned = false,
						aborted = false,
						superWeaponSafe = 0
					}
				end
			elseif
				_T.gSafePlayers[__wf_atom_ef151cfd].safe == 0
				or p and _T.gSafePlayers[__wf_atom_ef151cfd].superWeaponSafe == 0
			then
				if flag then
					_T.gSafePlayers[__wf_atom_ef151cfd].duration = _T.gSafePlayers[__wf_atom_ef151cfd].duration + __wf_atom_084b3e93()
				end

				table.insert(result, __wf_atom_a96eb2aa)
			end

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				if v3:__wf_atom_8a6b8fc3(__wf_atom_0a6a5887) < 1000 then
					_T.gSafePlayers[__wf_atom_ef151cfd].safe = 1
				else
					_T.gSafePlayers[__wf_atom_ef151cfd].safe = 0
				end
			end
		end
	end

	return result
end

local function fn6(object, p)
	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(object:__wf_atom_50a7d83e())
		or not (object:__wf_atom_50a7d83e():__wf_atom_d2b2176d():__wf_atom_53d05571() >= 10)
		or object:__wf_atom_50a7d83e():IsKilled()
		or __wf_atom_7e8ad928(_T.gSafePlayers)
		or __wf_atom_7e8ad928(_T.gSafePlayers[object:__wf_atom_ef151cfd()])
		or _T.gSafePlayers[object:__wf_atom_ef151cfd()].superWeaponSafe ~= 0
		or not (_T.gSafePlayers[object:__wf_atom_ef151cfd()].duration >= trackingThreshold and _T.gSafePlayers[object:__wf_atom_ef151cfd()].safe > 0)
	then
		return false
	end

	local v3 = __wf_atom_fa8d0177(p, object:__wf_atom_50a7d83e():__wf_atom_a2a18137())
	local v4 = 0.5 * eyeFOVLock
	local heading2 = v3.heading
	local v5 = heading

	if heading2 - v5 > 180 then
		heading2 -= 360
	elseif heading2 - v5 < -180 then
		heading2 += 360
	end

	if not (math.abs(heading2 - v5) <= v4) then
		return false
	end

	local pitch2 = v3.pitch
	local v6 = pitch

	if pitch2 - v6 > 180 then
		pitch2 -= 360
	elseif pitch2 - v6 < -180 then
		pitch2 += 360
	end

	if math.abs(pitch2 - v6) <= v4 then
		return true
	end

	return false
end

local function fn7(p, p2) -- 2 equivalent calls inferred from this helper
	if p - p2 > 180 then
		p -= 360
	elseif p - p2 < -180 then
		p += 360
	end

	return p - p2
end

function SuperWeapon(object)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	while __wf_atom_7e8ad928(__wf_atom_ef7900cf) do
		__wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		Sleep(1)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if __wf_atom_7e8ad928(_T.gSafePlayers) then
		_T.gSafePlayers = {}
	end

	for i = 1, #__wf_atom_ef7900cf do
		local __wf_atom_ef151cfd = __wf_atom_ef7900cf[i]:__wf_atom_a96eb2aa():__wf_atom_ef151cfd()

		if __wf_atom_7e8ad928(_T.gSafePlayers[__wf_atom_ef151cfd]) then
			_T.gSafePlayers[__wf_atom_ef151cfd] = {
				safe = 0,
				duration = 0,
				warned = false,
				superWeaponSafe = 0
			}
		end
	end

	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	heading = __wf_atom_2f2bada0.heading
	pitch = __wf_atom_2f2bada0.pitch
	local gGameRules = gGameRules
	_T.gFomorianDestroyed = false
	local chargeDelay2 = 0
	local v3 = nil
	local flag2 = false
	local v4 = false
	local newTargetDelay2 = 0
	local v5 = nil

	while not (__wf_atom_7e8ad928(gGameRules) or gGameRules:__wf_atom_8cc6640f() or _T.gFomorianDestroyed) do
		local v6 = fn5(true)

		if chargeDelay2 > 0 then
			chargeDelay2 -= __wf_atom_084b3e93()

			if chargeDelay2 <= 0 and (not __wf_atom_7e8ad928(v3) or flag2) then
				laserEnabler:Enable()
				v4 = true
			end
		end

		if v4 and not laserEnabler:IsEnabled() then
			if fn6(v3, object:__wf_atom_a2a18137()) then
				local __wf_atom_ef151cfd = v3:__wf_atom_ef151cfd()
				_T.gSafePlayers[__wf_atom_ef151cfd].duration = 0
				_T.gSafePlayers[__wf_atom_ef151cfd].warned = false
			end

			flag2 = false
			v4 = false
		end

		if newTargetDelay2 > 0 or v5 == nil and not fn6(v3, object:__wf_atom_a2a18137()) then
			if (v3 ~= nil or v5 ~= nil) and newTargetDelay > 0 then
				if newTargetDelay2 <= 0 then
					newTargetDelay2 = newTargetDelay

					if laserMoveEnabler:IsEnabled() then
						laserMoveEnabler:Disable()
					end
				else
					newTargetDelay2 -= __wf_atom_084b3e93()
				end
			end

			if newTargetDelay2 <= 0 and chargeDelay2 <= 0 then
				v3 = nil
				v5 = nil
			end
		elseif v5 == nil then
			local v7, v8 = fn4(
				object,
				v3:__wf_atom_50a7d83e():__wf_atom_d0069154() + v3:__wf_atom_50a7d83e():__wf_atom_278a2d05() * __wf_atom_084b3e93()
			)

			if not laserMoveEnabler:IsEnabled() then
				laserMoveEnabler:Enable()
			end

			if not v4 and math.abs(v7) < 15 and math.abs(v8) < 15 and chargeDelay2 <= 0 then
				chargeDelay2 = chargeDelay
			end
		else
			local eyeRotRate2 = eyeRotRate

			if flag2 then
				eyeRotRate *= 2
			end

			local v7, v8 = fn4(object, v5)
			eyeRotRate = eyeRotRate2

			if not v4 and chargeDelay2 <= 0 then
				if math.abs(v7) < 5 and math.abs(v8) < 5 then
					if flag2 then
						chargeDelay2 = 1
					else
						newTargetDelay2 = newTargetDelay
					end

					if laserMoveEnabler:IsEnabled() then
						laserMoveEnabler:Disable()
					end
				elseif not laserMoveEnabler:IsEnabled() then
					laserMoveEnabler:Enable()
				end
			end
		end

		if v3 == nil and #v6 > 0 then
			while #v6 > 0 do
				local v7 = __wf_atom_5784a397(1, #v6)

				if fn6(v6[v7], object:__wf_atom_a2a18137()) then
					v3 = v6[v7]

					if not _T.gSafePlayers[v3:__wf_atom_ef151cfd()].warned then
						_T.gSafePlayers[v3:__wf_atom_ef151cfd()].warned = true

						if __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(_G.UIMovie_TransmissionMovie))) then
							v3:__wf_atom_50a7d83e():GiveItem(transmissions[__wf_atom_5784a397(1, #transmissions)], true)
						end
					end

					v5 = nil
					break
				else
					table.remove(v6, v7)
				end
			end
		end

		if v3 == nil and (v5 == nil or not __wf_atom_7e8ad928(_T.fomorianSuperWeaponTarget)) then
			local fomorianSuperWeaponTarget = _T.fomorianSuperWeaponTarget
			local v7 = false

			if not __wf_atom_7e8ad928(fomorianSuperWeaponTarget) then
				local __wf_atom_a2a18137 = fomorianSuperWeaponTarget:__wf_atom_a2a18137()
				local v8 = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), __wf_atom_a2a18137)
				local v9 = fn7(v8.heading, heading) -- inferred equivalent call
				local v10 = fn7(v8.pitch, pitch) -- inferred equivalent call

				if math.abs(v9) <= eyeFOVLock * 0.5 and math.abs(v10) <= eyeFOVLock * 0.5 then
					_T.fomorianSuperWeaponTarget = nil
					v5 = __wf_atom_a2a18137
					v7 = true
					flag2 = true
					newTargetDelay2 = 0
				end
			end

			if not v7 and v5 == nil then
				local v8 = 0.2 * eyeFOVLock
				local v9 = heading + __wf_atom_5784a397(-v8, v8)
				local v10 = pitch + __wf_atom_5784a397(-v8, v8)
				v5 = object:__wf_atom_a2a18137() + __wf_atom_e97f3142(Rotation(v9, v10, 0))
				flag2 = false
			end
		end

		Sleep(0)
	end

	if flag and not __wf_atom_7e8ad928(_T.gWeaponAlreadyChosen) and _T.gWeaponAlreadyChosen then
		_T.gWeaponAlreadyChosen = false
	end
end

function EnterSafeZone(_, object)
	if __wf_atom_7e8ad928(object) or not object:__wf_atom_535d5cbb() then
		return
	end

	local v3 = not object:__wf_atom_535d5cbb() and 0 or object:__wf_atom_a96eb2aa():__wf_atom_ef151cfd()

	if __wf_atom_7e8ad928(_T.gSafePlayers) then
		_T.gSafePlayers = {}
	end

	if __wf_atom_7e8ad928(_T.gSafePlayers[v3]) then
		_T.gSafePlayers[v3] = { safe = 0, duration = 0, warned = false, superWeaponSafe = 0 }
	end

	_T.gSafePlayers[v3].safe = _T.gSafePlayers[v3].safe + 1
	_T.gSafePlayers[v3].duration = 0
	_T.gSafePlayers[v3].warned = false

	if superWeaponSafeZone then
		_T.gSafePlayers[v3].superWeaponSafe = _T.gSafePlayers[v3].superWeaponSafe + 1
	end
end

function ExitSafeZone(_, object)
	if __wf_atom_7e8ad928(object) or not object:__wf_atom_535d5cbb() then
		return
	end

	local v3 = not object:__wf_atom_535d5cbb() and 0 or object:__wf_atom_a96eb2aa():__wf_atom_ef151cfd()

	if __wf_atom_7e8ad928(_T.gSafePlayers) then
		_T.gSafePlayers = {}
	end

	if __wf_atom_7e8ad928(_T.gSafePlayers[v3]) then
		_T.gSafePlayers[v3] = { safe = 0, duration = 0, warned = false, superWeaponSafe = 0 }
	end

	_T.gSafePlayers[v3].safe = math.max(0, _T.gSafePlayers[v3].safe - 1)

	if superWeaponSafeZone then
		_T.gSafePlayers[v3].superWeaponSafe = math.max(0, _T.gSafePlayers[v3].superWeaponSafe - 1)
	end
end

function OpenSpaceExtraction()
	_T.AllowExtraction = true

	if not openSpaceExtraction then
		return
	end

	if __wf_atom_7e8ad928(_T.gSafePlayers) then
		_T.gSafePlayers = {}
	end

	while _T.AllowExtraction do
		local v3 = fn5(false)
		local __wf_atom_c3b255b8 = gRegion:__wf_atom_c3b255b8()

		for _, v4 in ipairs(v3) do
			local __wf_atom_ef151cfd = v4:__wf_atom_ef151cfd()

			if __wf_atom_7e8ad928(_T.gSafePlayers[__wf_atom_ef151cfd]) then
				continue
			end

			local __wf_atom_50a7d83e = v4:__wf_atom_50a7d83e()
			local v5 = not __wf_atom_7e8ad928(__wf_atom_50a7d83e)
				and __wf_atom_50a7d83e:__wf_atom_d2b2176d():__wf_atom_84479917()
			local v6 = _T.gSafePlayers[__wf_atom_ef151cfd].safe > 0 or not v5
			local duration = _T.gSafePlayers[__wf_atom_ef151cfd].duration
			local warned = _T.gSafePlayers[__wf_atom_ef151cfd].warned
			local aborted = _T.gSafePlayers[__wf_atom_ef151cfd].aborted

			if not __wf_atom_7e8ad928(__wf_atom_c3b255b8) or v6 then
				continue
			end

			if not warned and warningDelay < duration then
				_T.gSafePlayers[__wf_atom_ef151cfd].warned = true
				v4:__wf_atom_50a7d83e():GiveItem(transmissions[__wf_atom_5784a397(1, #transmissions)], true)
			end

			if not warned or not (extractionDelay < duration) or aborted then
				continue
			end

			_T.gSafePlayers[__wf_atom_ef151cfd].aborted = true
			v4:__wf_atom_50a7d83e():GiveItem(
				abortMissionTransmissions[__wf_atom_5784a397(1, #abortMissionTransmissions)],
				true
			)
			abortMissionInstance:__wf_atom_bbed7a6f(v4:__wf_atom_50a7d83e())
		end

		Sleep(0)
	end

	print("Open space extraction cancelled")
end

function ExitMission()
	local gGameRules = gGameRules

	if gMatchingService:__wf_atom_607c7363() == true then
		gGameRules:EndGame(2, 0)
	else
		gGameRules:OnPlayerQuitting("DbUpdateComplete")
	end
end

function DbUpdateComplete(_, _)
	print("DbUpdateComplete, disconnecting")

	if gGameRules:__wf_atom_3d21c15e() and not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_66a27504()
	end

	Engine.Disconnect(false)
end