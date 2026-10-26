function OnDeath(object)
	Sleep(0)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()
	__wf_atom_575542c8:__wf_atom_68f2c268(0.2)

	if __wf_atom_575542c8:__wf_atom_8efce136() then
		object:Attach(localFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_575542c8)
		gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(-1)
		local postProcess = gRegion:__wf_atom_8ad59546().postProcess
		local cameraControl = __wf_atom_575542c8:CameraControl()
		cameraControl:__wf_atom_dc7b15db(deathColourCorrection, 0, -1, 0)
		cameraControl:__wf_atom_344d785e(deathColourCorrection, 1)

		if not __wf_atom_7e8ad928(postProcess) then
			postProcess.bnwBufferInvert = false
			postProcess.bnwBufferBias = 0
		end

		_T.DyingFade = true
		local v = 0

		while v < 1 and _T.DyingFade ~= nil do
			v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / 0.5, 0, 1)
			gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(1 - v)
			Sleep(0.02)
		end

		local v2 = 0

		while v2 < 1 do
			v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() / 25, 0, 1)

			if _T.DyingFade == nil then
				break
			end

			local _ = 1 - v2
			__wf_atom_575542c8:__wf_atom_68f2c268(v2 * 0.3 + 0.2)
			Sleep(0)
		end

		if _T.DyingFade == nil then
			Sleep(2.5)
		elseif not __wf_atom_72884638("Ghost.Sparrow") then
			__wf_atom_575542c8:__wf_atom_921c1a5f(failAnim, false, 3, 1)
			Sleep(4)
		end

		local v3 = 0

		while v3 < 1 do
			v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() / 0.5, 0, 1)
			Sleep(0.02)
			__wf_atom_575542c8:PlaySound(reviveWhiteOutSound, false)
		end
	else
		__wf_atom_575542c8:__wf_atom_a763aa1a(1)
		Sleep(0.5)
		local v = 0

		while v < 1 do
			v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / 25, 0, 1)
			__wf_atom_575542c8:__wf_atom_68f2c268(v * 0.3 + 0.2)
			Sleep(0)
		end

		__wf_atom_575542c8:__wf_atom_921c1a5f(failAnim, true, 3, 1)
	end
end

function ShrineGuide(instance)
	local __wf_atom_575542c8 = instance:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	if not __wf_atom_575542c8:__wf_atom_8efce136() then
		instance:Destroy()
	end

	local __wf_atom_a96eb2aa = __wf_atom_575542c8:__wf_atom_a96eb2aa()

	if not __wf_atom_7e8ad928(_T.PlayerShrinePosition) then
		local __wf_atom_ef151cfd = __wf_atom_a96eb2aa:__wf_atom_ef151cfd()
		__wf_atom_7e8ad928(_T.PlayerShrinePosition[__wf_atom_ef151cfd])
	end

	local position = instance:GetPosition()

	if __wf_atom_7e8ad928((gRegion:FindNearestTagged(Symbol("ResShrine"), position))) then
		instance:Destroy()
	end

	local __wf_atom_eff0517e = __wf_atom_a96eb2aa:__wf_atom_eff0517e()
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()
	instance:__wf_atom_e6ed03c8()
	local total = 0

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		local v = __wf_atom_084b3e93()
		total += v
		local position2 = __wf_atom_eff0517e:GetPosition()
		local position3 = __wf_atom_575542c8:GetPosition()
		local v2 = position2 - position3
		local v3 = Length(v2)
		Normalize(v2)
		position3.y = __wf_atom_575542c8:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE3")).y
		local v4 = position3 + v2 * localDistance
		local v5 = __wf_atom_104bfe98(0.2, 0.01, Length(position - v4))
		local v6 = __wf_atom_10cd16b2(position.y, v5)
		v6:__wf_atom_09294a87(v4.y)
		v6:Update(v)
		local v7 = Vector(v4.x, v6:__wf_atom_9e368823(), v4.z)
		local lookAtRotation = instance:GetLookAtRotation(position2)
		instance:SetMeshScale(__wf_atom_421b01aa(v3 / 10, 0, 1), true)
		instance:Teleport(v7, lookAtRotation)
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(nil) then
		(nil):Close()
	end

	instance:Destroy()
end