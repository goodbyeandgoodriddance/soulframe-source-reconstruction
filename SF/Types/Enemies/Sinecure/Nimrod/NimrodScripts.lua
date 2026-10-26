local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("SF.Scripts.Libs.ChallengeLib")
local v = Symbol("NimrodScripts")
local v2 = Symbol("Ability Failed to activate")

local function fn(playerAvatar, nimrodCustomLockOnRadius, nimrodCameraDistOffset)
	if not __wf_atom_7e8ad928(playerAvatar) then
		local __wf_atom_92aa9d91 = playerAvatar:__wf_atom_92aa9d91()

		if nimrodCustomLockOnRadius == 0 and nimrodCameraDistOffset == 0 then
			__wf_atom_92aa9d91:__wf_atom_5b5911cb(Resource(__wf_atom_92aa9d91:__wf_atom_1bb5b1ff()):__wf_atom_ab10ec5a())
			__wf_atom_92aa9d91:__wf_atom_35df58c3(0)
		else
			__wf_atom_92aa9d91:__wf_atom_5b5911cb(nimrodCustomLockOnRadius)
			__wf_atom_92aa9d91:__wf_atom_35df58c3(nimrodCameraDistOffset)
		end
	end
end

function SelfDestruct(instance)
	if not (__wf_atom_7e8ad928(instance) or instance:IsKilled()) then
		instance:Destroy()
	end
end

function ShakePlayer(object, p, p2)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f)) then
		local cameraControl = __wf_atom_c4f78a8f:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			cameraControl:__wf_atom_4dab66dd(object:GetPosition(), -1, p, 2)
			__wf_atom_eab484a7:__wf_atom_a6c0f1b8(4, 0.3, 0.3, p2)
		end
	end
end

function SpawnNimrod()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodAvatar"))

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodAvatar"))
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled() then
		return
	end

	local playerAvatar = gRegion:GetPlayerAvatar()
	__wf_atom_0a6a5887:SetHealth(__wf_atom_0a6a5887:GetMaxHealth() * mHealthPercentageToStartPhase)
	local __wf_atom_bb81a9df = __wf_atom_0a6a5887:__wf_atom_bb81a9df()
	__wf_atom_0a6a5887:__wf_atom_8914dfde(animEventForBossBar, 10)
	playerAvatar:__wf_atom_97f3b941(__wf_atom_0a6a5887)
	local __wf_atom_e55d02aa = __wf_atom_0a6a5887:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local v3 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()[1]

	if __wf_atom_e55d02aa:__wf_atom_c497b0ae(1):IsActive() then
		__wf_atom_0a6a5887:__wf_atom_623b3028(v2)
	else
		__wf_atom_0a6a5887:__wf_atom_30e3d82b():__wf_atom_cca1dc04(v3, playerAvatar, true)
	end

	Sleep(5)
	__wf_atom_0a6a5887:__wf_atom_30e3d82b():__wf_atom_920a5a62()

	if mHealthPercentageToEndPhase > 0 then
		while mHealthPercentageToEndPhase <= __wf_atom_bb81a9df do
			if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled() then
				return
			end

			__wf_atom_bb81a9df = __wf_atom_0a6a5887:__wf_atom_bb81a9df()
			Sleep(0)
		end

		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled()) then
			module.SetImmunity(__wf_atom_0a6a5887, true)
			Sleep(0)
			__wf_atom_0a6a5887:__wf_atom_921c1a5f(retreatAnim, true, 3, 1, true)
			ShakePlayer(__wf_atom_0a6a5887, 6, 4)
			__wf_atom_0a6a5887:Destroy()
		end
	end
end

function NimrodIntro()
	module.TaggedFirePorts(Symbol("NimrodIntro"), "Disable")
	module3.PlayGlobalTransmission(transmissionSet, Symbol("Intro"), false)
	module.TaggedFirePorts(Symbol("NimrodIntroThunder"), "Enable")
end

function NimrodIntroTwo()
	module.TaggedFirePorts(Symbol("NimrodIntro"), "Disable")
	module3.PlayGlobalTransmission(transmissionSet, Symbol("IntroTwo"), false)
	module.TaggedFirePorts(Symbol("NimrodIntroThunder"), "Enable")
end

function NimrodIntroThree()
	module.TaggedFirePorts(Symbol("NimrodIntro"), "Disable")
	module3.PlayGlobalTransmission(transmissionSet, Symbol("IntroThree"), false)
	module.TaggedFirePorts(Symbol("NimrodIntroThunder"), "Enable")
end

local function fn2(object, __wf_atom_30e3d82b)
	gRegion:__wf_atom_a8553251()
	local v3 = false
	local v4 = false
	local v5 = false
	local total = 0

	while
		object
		and not (__wf_atom_7e8ad928(object) or object:IsKilled() or __wf_atom_7e8ad928(__wf_atom_30e3d82b) or v3)
	do
		local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

		for i = 1, #__wf_atom_a8553251 do
			if __wf_atom_7e8ad928(__wf_atom_a8553251[i]) then
				continue
			end

			v5 = __wf_atom_a8553251[i]:__wf_atom_7b82e9e1(7)
			v4 = __wf_atom_a8553251[i]:IsKilled()
		end

		if object:__wf_atom_bb81a9df() < 0.5 then
			v3 = true
		else
			if v4 then
				break
			end

			if v5 then
				total += __wf_atom_084b3e93()
			end
		end

		v3 = targetLastSeenTimeToRetreat < total or v3
		Sleep(0)
	end
end

function NimrodPhaseOne()
	print("Start NimrodPhaseOne")
	module.TaggedFirePorts(Symbol("NimrodPhaseOne"), "Disable")
	module3.PlayGlobalTransmission(transmissionSet, Symbol("PhaseOne"), false)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodAvatar"))

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodAvatar"))
		Sleep(0)
	end

	__wf_atom_0a6a5887:__wf_atom_8914dfde(animEventForBossBar, 10)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled() then
		return
	end

	local playerAvatar = gRegion:GetPlayerAvatar()
	local v3 = Symbol("BossAwarenessTrigger")
	local __wf_atom_f582136d = __wf_atom_0a6a5887:__wf_atom_f582136d(__wf_atom_589cefdb)

	for _, v4 in ipairs(__wf_atom_f582136d) do
		if __wf_atom_7e8ad928(v4) or v4:__wf_atom_db682341() ~= v3 then
			continue
		end

		v4:Enable()
	end

	fn(playerAvatar, nimrodCustomLockOnRadius, nimrodCameraDistOffset)
	local __wf_atom_e55d02aa = __wf_atom_0a6a5887:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()
	local __wf_atom_30e3d82b = __wf_atom_0a6a5887:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	local v4 = __wf_atom_36b4a6e5[1]

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) or not __wf_atom_e55d02aa:__wf_atom_c497b0ae(1):IsActive() then
		__wf_atom_30e3d82b:__wf_atom_cca1dc04(v4, playerAvatar, true)
	else
		__wf_atom_0a6a5887:__wf_atom_623b3028(v2)
	end

	Sleep(5)

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled() or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) then
		__wf_atom_30e3d82b:__wf_atom_920a5a62()
		__wf_atom_30e3d82b:__wf_atom_eda97f5a()
	end

	fn2(__wf_atom_0a6a5887, __wf_atom_30e3d82b)

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled()) then
		__wf_atom_0a6a5887:__wf_atom_7470861b():__wf_atom_77b5f32e(v)
		module.SetImmunity(__wf_atom_0a6a5887, true)
		Sleep(0)
		__wf_atom_0a6a5887:__wf_atom_921c1a5f(retreatAnim, true, 3, 1, true)
		ShakePlayer(__wf_atom_0a6a5887, 6, 4)
		__wf_atom_0a6a5887:Destroy()
	end

	print("End NimrodPhaseOne")
end

function NimrodPhaseTwo()
	print("Start NimrodPhaseTwo")
	module.TaggedFirePorts(Symbol("NimrodPhaseTwo"), "Disable")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodAvatar"))

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodAvatar"))
		Sleep(0)
	end

	__wf_atom_0a6a5887:__wf_atom_8914dfde(animEventForBossBar, 10)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled() then
		return
	end

	local playerAvatar = gRegion:GetPlayerAvatar()
	local v3 = Symbol("BossAwarenessTrigger")
	local __wf_atom_f582136d = __wf_atom_0a6a5887:__wf_atom_f582136d(__wf_atom_589cefdb)

	for _, v4 in ipairs(__wf_atom_f582136d) do
		if __wf_atom_7e8ad928(v4) or v4:__wf_atom_db682341() ~= v3 then
			continue
		end

		v4:Enable()
	end

	fn(playerAvatar, nimrodCustomLockOnRadius, nimrodCameraDistOffset)
	local __wf_atom_e55d02aa = __wf_atom_0a6a5887:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()
	local __wf_atom_30e3d82b = __wf_atom_0a6a5887:__wf_atom_30e3d82b()
	local v4 = __wf_atom_36b4a6e5[2]

	if __wf_atom_e55d02aa:__wf_atom_c497b0ae(1):IsActive() and not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_0a6a5887:__wf_atom_623b3028(v2)
	else
		__wf_atom_30e3d82b:__wf_atom_cca1dc04(v4, playerAvatar, true)
	end

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled() or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) then
		__wf_atom_30e3d82b:__wf_atom_920a5a62()
	end

	fn2(__wf_atom_0a6a5887, __wf_atom_30e3d82b)

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled()) then
		__wf_atom_0a6a5887:__wf_atom_7470861b():__wf_atom_77b5f32e(v)
		module.SetImmunity(__wf_atom_0a6a5887, true)
		Sleep(0)
		__wf_atom_0a6a5887:__wf_atom_921c1a5f(retreatAnim, true, 3, 1, true)
		ShakePlayer(__wf_atom_0a6a5887, 6, 4)
		__wf_atom_0a6a5887:Destroy()
	end

	print("End NimrodPhaseTwo")
end

function NimrodPhaseThree()
	print("Start NimrodPhaseThree")
	module.TaggedFirePorts(Symbol("NimrodPhaseThree"), "Disable")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodAvatar"))

	while __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodAvatar"))
		Sleep(0)
	end

	__wf_atom_0a6a5887:__wf_atom_8914dfde(animEventForBossBar, 10)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled() then
		return
	end

	local playerAvatar = gRegion:GetPlayerAvatar()
	local v3 = Symbol("BossAwarenessTrigger")
	local __wf_atom_f582136d = __wf_atom_0a6a5887:__wf_atom_f582136d(__wf_atom_589cefdb)

	for _, v4 in ipairs(__wf_atom_f582136d) do
		if __wf_atom_7e8ad928(v4) or v4:__wf_atom_db682341() ~= v3 then
			continue
		end

		v4:Enable()
	end

	fn(playerAvatar, nimrodCustomLockOnRadius, nimrodCameraDistOffset)
	local __wf_atom_e55d02aa = __wf_atom_0a6a5887:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()
	local __wf_atom_30e3d82b = __wf_atom_0a6a5887:__wf_atom_30e3d82b()
	local v4 = __wf_atom_36b4a6e5[2]

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_5a0e15fd(Symbol("RandomPatrol"), 1)
	end

	if __wf_atom_e55d02aa:__wf_atom_c497b0ae(1):IsActive() and not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_0a6a5887:__wf_atom_623b3028(v2)
	else
		__wf_atom_30e3d82b:__wf_atom_cca1dc04(v4, playerAvatar, true)
	end

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled() or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) then
		__wf_atom_30e3d82b:__wf_atom_920a5a62()
	end

	while not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled()) do
		Sleep(0)
	end

	Sleep(6)
	module4.NotifyBossComplete()
	module2.ShowProgressionScreen(false, {
		Label = "/SF/Language/Objectives/CompletedNimrodEncounter",
		CacheIndex = 1
	})
	print("End NimrodPhaseThree")
end