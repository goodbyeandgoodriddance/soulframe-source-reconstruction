require("EE.Interface.Utilities")

function MaterialFadeIn(_, object)
	local v = 0

	while not __wf_atom_7e8ad928(object) and v < 1 do
		local v2 = v + __wf_atom_084b3e93()
		v = __wf_atom_421b01aa(v2, 0, 1)
		local v3 = __wf_atom_24a82b69(v) * 50
		object:SetMaterialParam(Symbol("EmissiveMapAtten"), v3, v3, v3, v3, true)
		Sleep(0)
	end
end

function MaterialFadeOut(_, object)
	local v = 1

	while v > 0 do
		local v2 = v - __wf_atom_084b3e93() * 0.5
		v = __wf_atom_421b01aa(v2, 0, 1)
		local v3 = math.pow(v, 2) * 50
		object:SetMaterialParam(Symbol("EmissiveMapAtten"), v3, v3, v3, v3, true)
		Sleep(0)
	end
end

function AlcaMagicStart(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("Sky"))
	gRegion:__wf_atom_0a6a5887(Symbol("Sun"))
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("Statues"))
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("StatueLights"))
	local __wf_atom_2226b35c3 = gRegion:__wf_atom_2226b35c(Symbol("RayMarch"))
	local __wf_atom_2226b35c4 = gRegion:__wf_atom_2226b35c(Symbol("Sinecure"))
	__wf_atom_0a6a5887:SetTimeOfDay(1)

	for i = 1, #__wf_atom_2226b35c2 do
		__wf_atom_2226b35c2[i]:TurnOn()
	end

	for i = 1, #__wf_atom_2226b35c do
		__wf_atom_2226b35c[i]:SetMaterialParam(Symbol("EmissiveMapAtten"), 10, 0, 0, 0)
	end

	for i = 1, #__wf_atom_2226b35c3 do
		__wf_atom_2226b35c3[i]:__wf_atom_4b91cbbc(Color(128, 128, 128, 255))
	end

	for i = 1, #__wf_atom_2226b35c4 do
		__wf_atom_2226b35c4[i]:__wf_atom_986f733d(Symbol("Stone"), 0)
	end
end

function AlcaMagicEnd(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("Sky"))
	gRegion:__wf_atom_0a6a5887(Symbol("Sun"))
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("Statues"))
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("StatueLights"))
	local __wf_atom_2226b35c3 = gRegion:__wf_atom_2226b35c(Symbol("RayMarch"))
	__wf_atom_0a6a5887:SetTimeOfDay(19)

	for i = 1, #__wf_atom_2226b35c2 do
		__wf_atom_2226b35c2[i]:TurnOff()
	end

	for i = 1, #__wf_atom_2226b35c do
		__wf_atom_2226b35c[i]:SetMaterialParam(Symbol("EmissiveMapAtten"), 0, 0, 0, 0)
	end

	for i = 1, #__wf_atom_2226b35c3 do
		__wf_atom_2226b35c3[i]:__wf_atom_4b91cbbc(Color(214, 214, 214, 255))
	end
end

function InitializeLoginCin(object)
	if not (__wf_atom_a0f6588f:__wf_atom_f89aa44a() or __wf_atom_a0f6588f:__wf_atom_7bd0381c()) then
		__wf_atom_a0f6588f:__wf_atom_aca7a6d6(false)
	end

	local v = 0
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			v = __wf_atom_9be88b01:__wf_atom_61255e50()
		end
	end

	local __wf_atom_59c6b81d = object:__wf_atom_59c6b81d()
	local v2 = Symbol("Envoy")
	local v3 = Symbol("Sparrow1")
	local v4 = {}

	for _, v5 in ipairs(__wf_atom_59c6b81d) do
		if __wf_atom_7e8ad928(v5) or v5:IsA(__wf_atom_4ebf67cb) then
			continue
		end

		local __wf_atom_12695c30 = v5:__wf_atom_12695c30()

		if __wf_atom_12695c30 ~= v2 and __wf_atom_12695c30 ~= v3 then
			table.insert(v4, v5)
		end
	end

	local v5 = { 1, 2, 3, 5, 7, 9, 11 }
	local v6 = v5[math.min(math.max(v, 1), #v5)]
	local v7 = not deericide and 0 or math.max(#v4 - v6, 0)

	if v7 < #v4 then
		local entity = gRegion:CreateEntity(snoreVolumeType, object:GetPosition(), __wf_atom_80368bb1, object)

		if not __wf_atom_7e8ad928(entity) then
			entity:AttachToInPlace(object, EMPTY_SYMBOL)
		end
	end

	for i = #v4 - v7 + 1, #v4 do
		gRegion:__wf_atom_dd1e4d10(v4[i])
	end

	if not __wf_atom_7e8ad928(loginLoopSound) then
		_T.LoginLoopSound = object:PlaySound(loginLoopSound, false)
	end
end

function TeardownLoginCin(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(snoreVolumeType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
	end

	if not __wf_atom_7e8ad928(_T.LoginLoopSound) then
		_T.LoginLoopSound:Stop(false)
		_T.LoginLoopSound = nil
	end
end

local function fn(p, p2, p3)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

	if __wf_atom_7e8ad928(__wf_atom_8ad59546) then
		return
	end

	local __wf_atom_89894bd1 = __wf_atom_8ad59546:__wf_atom_89894bd1()
	local v = math.max(0.00001, p2)
	local total = 0

	while total <= v do
		total += __wf_atom_084b3e93()

		if p then
			__wf_atom_8ad59546:__wf_atom_47f0b80b((__wf_atom_104bfe98(
				__wf_atom_89894bd1,
				p3,
				__wf_atom_421b01aa(total / v, 0, 1)
			)))
		else
			__wf_atom_8ad59546:__wf_atom_47f0b80b((__wf_atom_104bfe98(p3, 0, __wf_atom_421b01aa(total / v, 0, 1))))
		end

		if v <= total then
			break
		end

		if v > 0 then
			Sleep(0)
		end
	end

	if p then
		__wf_atom_8ad59546:__wf_atom_47f0b80b(p3)
	else
		__wf_atom_8ad59546:__wf_atom_47f0b80b(0)
	end
end

function FadeToBlack(p, p2)
	fn(p, p2, 1)
end

function FadeToWhite(p, p2)
	fn(p, p2, -1)
end

function FadeAndLaunchUI(p)
	__wf_atom_8e4fda44:__wf_atom_8b74c30b(flashMovie):__wf_atom_8fcdea81(p)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

	if __wf_atom_7e8ad928(__wf_atom_8ad59546) then
		return
	end

	local blur = 0

	while blur < 1 do
		blur = __wf_atom_421b01aa(blur + __wf_atom_084b3e93() * 0.25, 0, 1)
		__wf_atom_8ad59546.postProcess.blur = blur
		Sleep(0)
	end
end

function StartCinRelativeToPlayer()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local motionControl = __wf_atom_c4f78a8f:MotionControl()
	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(startCinTag)

	if unequipWeapon then
		if unequipInstant then
			__wf_atom_d2b2176d:Unequip(0, 2)
		else
			__wf_atom_d2b2176d:Unequip(0, 0)

			while
				not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
				and not __wf_atom_c4f78a8f:IsKilled()
				and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14
			do
				Sleep(0)
			end
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_0a6a5887:StartRelative(
			Symbol("Envoy"),
			__wf_atom_c4f78a8f:__wf_atom_a2a18137(),
			motionControl:__wf_atom_d9cb4b97()
		)
	end
end

function AttachDeco(_, object)
	if not __wf_atom_7e8ad928(object) then
		object:Attach(attachType, attachBone, attachLocalPos, attachLocalRot)
	end
end

function DetachDeco(_, object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(attachType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
		end
	end
end

local function fn2(p)
	gRegion:PlaySound(whiteFlashSound, Vector(0, 0, 0), false)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local v = 0

	while v < 1 do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93(), 0, 1)
		__wf_atom_8ad59546:__wf_atom_47f0b80b(-v)
		Sleep(0)

		if not (p and __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8())) then
			continue
		end

		__wf_atom_8ad59546:__wf_atom_47f0b80b(-1)
		break
	end
end

function KickOffOutro(object)
	fn2(true)
	object:Stop()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("QuestOutroCin"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("StartPlaying")
	end
end

function EyeClear(_, object)
	local v = 1

	while v > 0 do
		v = __wf_atom_421b01aa(v - __wf_atom_084b3e93() * 2, 0, 1)
		local v2 = __wf_atom_104bfe98(v * 3, v * 3 + math.abs((Noise(Time() * 3))) * 100, (math.pow(v, 2)))
		object:SetMaterialParam(Symbol("EmissiveMapAtten"), v2)
		Sleep(0)
	end
end

local function fn3()
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	if __wf_atom_7e8ad928(all) then
		return
	end

	for i = 1, #all do
		if all[i]:__wf_atom_1d13ef4d() then
			return all[i]
		end
	end

	return all[1]
end

function ActivateSky(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(skyTag)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local v = fn3()
		__wf_atom_0a6a5887:Enable(true)
		v:Enable(false)
	end
end

function ActivateMainSky(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(skyTag)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		fn3():Enable(true)
		__wf_atom_0a6a5887:Enable(false)
	end
end

local function fn4(p)
	local v = Vector()
	local v2, v3, v4

	repeat
		v2 = __wf_atom_0f9a3221(p, -1, 1)
		v3 = __wf_atom_0f9a3221(p, -1, 1)
		v4 = v2 * v2 + v3 * v3
	until not (v4 >= 1)

	local v5 = math.sqrt(1 - v4)
	v.x = 2 * v2 * v5
	v.y = 2 * v3 * v5
	v.z = 1 - 2 * v4
	local v6 = __wf_atom_e4cfeef7(__wf_atom_0f9a3221(p, 0, 1))
	v.x *= v6
	v.y *= v6
	v.z *= v6
	return v
end

function LightningStorm(object)
	local v = Vector(1, 0.3, 0.5)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(skyTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local v2 = __wf_atom_3e61816b(61973)
	local total = 0

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_7d4910e4() do
		local v3 = __wf_atom_0f9a3221(v2, 2, 5)
		Sleep(v3)
		total += v3
		gRegion:PlaySound(thunderSound, Vector(0, 0, 0), false)
		Vector(0, 0.5, 1)
		local v4 = fn4(v2)
		v4.y = math.abs(v4.y)
		__wf_atom_0a6a5887:__wf_atom_2ee34f0b(v4 + Vector(-0.2, 0.5, -1) * 2)
		local v5 = __wf_atom_0f9a3221(v2, 0.6, 1.5)

		while v5 > 0 do
			local v6 = __wf_atom_084b3e93()
			v5 -= __wf_atom_084b3e93()
			total += v6
			local v7 = math.abs((__wf_atom_482dad48(3, 0.8, total, 0.5)))
			local v8 = __wf_atom_104bfe98(1, 5, (math.sqrt(v7)))
			__wf_atom_0a6a5887:SetTimeOfDay(8)
			__wf_atom_0a6a5887:__wf_atom_e370b122(v8)
			__wf_atom_0a6a5887:__wf_atom_fdb3b9da(v8)
			Sleep(0)
		end

		__wf_atom_0a6a5887:SetTimeOfDay(1)
		__wf_atom_0a6a5887:__wf_atom_2ee34f0b(v)
		__wf_atom_0a6a5887:__wf_atom_fdb3b9da(1)
		local v6 = 1

		while v6 > 0 do
			local v7 = __wf_atom_084b3e93()
			local v8 = v6 - v7
			total += v7
			v6 = math.max(0, v8)
			__wf_atom_0a6a5887:__wf_atom_e370b122(1)
			Sleep(0)
		end

		Sleep(0)
	end
end

function SetWeatherEffect()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local cameraControl = __wf_atom_c4f78a8f:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			cameraControl:SpawnWeatherEffect(weatherType)
		end
	end
end

function SlamEmissive(_, object)
	_T.SlamEmissive = true
	object:SetMaterialParam(Symbol("EmissiveMapAtten"), 105, 105, 105, 105, true)
end

function PulseBell(_, object)
	local v = Symbol("BromiusBreathing")
	local v2 = nil

	while __wf_atom_7e8ad928(v2) and not __wf_atom_7e8ad928(object) do
		Sleep(0)
		v2 = gRegion:__wf_atom_c3b255b8()
	end

	while not (__wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(object) or _T.SlamEmissive) do
		v2 = gRegion:__wf_atom_c3b255b8()

		if not (__wf_atom_7e8ad928(v2) or v2:__wf_atom_e9546dc6()) then
			local __wf_atom_1b8be9b0 = v2:__wf_atom_1b8be9b0(v)

			if not __wf_atom_7e8ad928(__wf_atom_1b8be9b0) then
				local v3 = math.pow(math.max(0, __wf_atom_1b8be9b0:__wf_atom_31aab74c() - 0.1) / 0.9, 1)
				object:SetMaterialParam(Symbol("EmissiveMapAtten"), 2 + 10 * v3, 0, 0, 0, true)
			end
		end

		Sleep(0)
	end
end

function SetSkiesTimeEnableDefault()
	local v = Symbol("DefaultMainSky")
	_T.ForceTimeOfDay = forceTimeOfDay
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	for i = 1, #all do
		all[i]:SetTimeOfDay(math.mod(forceTimeOfDay, 24))
		all[i]:SetTimeOfDayRate(0)

		if all[i]:__wf_atom_db682341() == v then
			all[i]:Enable(true)
		else
			all[i]:Enable(false)
		end
	end
end