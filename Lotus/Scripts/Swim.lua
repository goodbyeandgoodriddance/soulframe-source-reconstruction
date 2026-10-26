local function fn(list, p)
	for i = 1, #list do
		list[i]:__wf_atom_c1782862(p)
	end
end

local function fn2(mixerArray, fn3, p, targetSwimOcclusion, fadeOutTime)
	local v = 1

	if _T.targetSwimOcclusion ~= targetSwimOcclusion then
		_T.targetSwimOcclusion = targetSwimOcclusion

		while v > 0 do
			fn3(mixerArray, (__wf_atom_104bfe98(targetSwimOcclusion, p, v)))
			local v2 = v - __wf_atom_fa1258d0() / fadeOutTime
			Sleep(0)
			v = _T.targetSwimOcclusion ~= targetSwimOcclusion and 0 or v2
		end
	end

	fn3(mixerArray, _T.targetSwimOcclusion)
end

local function fn3(object)
	if
		not __wf_atom_7e8ad928((object:CameraControl()))
		and object:__wf_atom_8efce136()
		and not __wf_atom_7e8ad928(cameraBreakSound)
	then
		object:PlaySound(cameraBreakSound, false)
	end

	object:__wf_atom_8efce136()

	if not __wf_atom_7e8ad928(mixerArray) then
		fn2(mixerArray, fn, maxOcclusionPercent, 0, fadeOutTime)
	end
end

function Swim(object)
	if not __wf_atom_7e8ad928(splashResource) then
		object:PlaySound(splashResource, false)
	end

	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	gRegion:CreateEntity(SplashFx, position, __wf_atom_dc309f8a)
end

function SwimExit(object)
	if not __wf_atom_7e8ad928(splashExitResource) then
		object:PlaySound(splashExitResource, false)
	end

	if skipCameraBreak then
		fn3(object)
	end

	skipCameraBreak = true

	if skipSwimBreak then
		local _gClient = gClient
	end

	skipSwimBreak = true

	if not __wf_atom_7e8ad928(wetFx) then
		object:Attach(wetFx, EMPTY_SYMBOL)
	end
end

function SwimBreak(object)
	if not __wf_atom_7e8ad928(splashBreakResource) then
		object:PlaySound(splashBreakResource, false)
	end

	local _gClient = gClient
	skipSwimBreak = false
end

function SwimUnder(object)
	if not __wf_atom_7e8ad928(splashResource) then
		object:PlaySound(splashResource, false)
	end

	if not __wf_atom_7e8ad928(splashUnderResource) then
		object:PlaySound(splashUnderResource, false)
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(wetFx)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	if
		object:__wf_atom_8efce136()
		and #gRegion:__wf_atom_a8553251() > 1
		and not gGameRules:__wf_atom_add6c374(object):MotionControl():__wf_atom_cb2d6ac4()
	then
	end
end

function SwimToEntity(object)
	if not __wf_atom_7e8ad928(targetEntity) then
		local position = targetEntity:GetPosition()
		local __wf_atom_dc309f8a = targetEntity:__wf_atom_dc309f8a()

		if not __wf_atom_7e8ad928(object) then
			object:MotionControl():__wf_atom_cb5d1631(position, __wf_atom_dc309f8a)
		end
	end
end

local function fn4(p, p2, p3)
	local all = gRegion:FindAll(__wf_atom_e1d1671b)
	local v = Symbol("Backdrop")
	local v2 = Symbol("FlyIn")
	local v3 = {}

	for i = 1, #all do
		if __wf_atom_7e8ad928(all[i]) or all[i]:__wf_atom_db682341() == v or all[i]:__wf_atom_b1dbf338() == v2 then
			continue
		end

		table.insert(v3, all[i]:__wf_atom_e800787c())
	end

	for i = 1, #v3 do
		if __wf_atom_7e8ad928(v3[i]) then
			continue
		end

		if p3 then
			v3[i]:__wf_atom_2b4f272f()
			v3[i]:__wf_atom_6fc6b948()
			v3[i]:__wf_atom_c858e813(false)
		else
			v3[i]:__wf_atom_e1bbff52(p)
			v3[i]:__wf_atom_248af10a(p2)
			v3[i]:__wf_atom_c858e813(true)
		end
	end
end

function CameraBreak(object)
	if object:__wf_atom_8efce136() then
		object:CameraControl():__wf_atom_5fda7557(PostFxMat)
		object:__wf_atom_0650fed7(camUnderAttach)

		if overrideFog then
			fn4(0, Color(), true)
		end

		local postProcess = gRegion:__wf_atom_8ad59546().postProcess
		postProcess.focalFarDepth = 0
		postProcess.focalFarPlane = 0
		postProcess:__wf_atom_351eef0b(aboveWaterPostFxMaterial)

		if TurnOnColorCorrectTint then
			postProcess:__wf_atom_be68c4d9(
				ColorCorrectTint.red / 255,
				ColorCorrectTint.green / 255,
				ColorCorrectTint.blue / 255,
				ColorCorrectTint.alpha / 255
			)
		end
	end

	skipCameraBreak = false
	fn3(object)
end

function CameraUnder(object)
	if object:__wf_atom_8efce136() then
		object:CameraControl():__wf_atom_2851d151(PostFxMat, 0.1, -1, 0.1)
		object:Attach(camUnderAttach, EMPTY_SYMBOL)
		local postProcess = gRegion:__wf_atom_8ad59546().postProcess
		postProcess.focalFarDepth = underWaterFarDepth
		postProcess.focalFarPlane = underWaterFarPlane
		postProcess:__wf_atom_351eef0b(underWaterPostFxMaterial)

		if TurnOnColorCorrectTint then
			postProcess:__wf_atom_be68c4d9(
				ColorCorrectTint.red / 255,
				ColorCorrectTint.green / 255,
				ColorCorrectTint.blue / 255,
				ColorCorrectTint.alpha / 255
			)
		end

		if overrideFog then
			fn4(underwaterFogDensity, underwaterFogColor, false)
		end

		if not __wf_atom_7e8ad928(mixerArray) then
			fn2(mixerArray, fn, 0, maxOcclusionPercent, fadeOutTime)
		end
	end
end