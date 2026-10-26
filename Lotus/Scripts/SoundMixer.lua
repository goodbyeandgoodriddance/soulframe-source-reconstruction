local function fn(list, p)
	for i = 1, #list do
		list[i]:__wf_atom_c2a0827a(p)
	end
end

local function fn2(list, p)
	for i = 1, #list do
		list[i]:__wf_atom_c1782862(p)
	end
end

local function fn3(mixerArray, fn4, p, p2, p3)
	if p3 > 0 then
		local v = 1

		while v > 0 do
			fn4(mixerArray, (__wf_atom_104bfe98(p2, p, v)))
			v -= __wf_atom_fa1258d0() / p3
			Sleep(0)
		end
	end

	fn4(mixerArray, p2)
end

function FadeOut()
	if __wf_atom_7e8ad928(mixerArray) then
		return
	end

	fn3(mixerArray, fn, 0, maxCut, fadeOutTime)
end

function FadeIn()
	if __wf_atom_7e8ad928(mixerArray) then
		return
	end

	fn3(mixerArray, fn, maxCut, 0, fadeInTime)
end

function OcclusionOn()
	if __wf_atom_7e8ad928(mixerArray) then
		return
	end

	fn3(mixerArray, fn2, 0, maxOcclusionPercent, fadeOutTime)
end

function SetOcclusionArray()
	if __wf_atom_7e8ad928(mixerArray) then
		return
	end

	local maxOcclusionPercentArray = maxOcclusionPercentArray
	local v = {}

	for i = 1, #mixerArray do
		v[i] = mixerArray[i]:__wf_atom_85a11745()

		if not maxOcclusionPercentArray[i] then
			maxOcclusionPercentArray[i] = maxOcclusionPercent
		end
	end

	local v2 = 1

	while v2 > 0 do
		local v3 = v2 - __wf_atom_fa1258d0() / fadeInTime
		v2 = __wf_atom_421b01aa(v3, 0, 1)

		for i = 1, #mixerArray do
			local v4 = __wf_atom_104bfe98(maxOcclusionPercentArray[i], v[i], v2)

			if occlusionFilter then
				mixerArray[i]:UpdateDynamicFilter(occlusionFilter, v4)
			elseif occlusionFilterArray and not __wf_atom_7e8ad928(occlusionFilterArray[i]) then
				mixerArray[i]:UpdateDynamicFilter(occlusionFilterArray[i], v4)
			else
				mixerArray[i]:__wf_atom_c1782862(v4)
			end
		end

		Sleep(0)
	end
end

function OcclusionOff()
	if __wf_atom_7e8ad928(mixerArray) then
		return
	end

	fn3(mixerArray, fn2, maxOcclusionPercent, 0, fadeInTime)
end

function FadeOutWaitFadeIn()
	if __wf_atom_7e8ad928(mixerArray) then
		return
	end

	fn3(mixerArray, fn, 0, maxCut, fadeOutTime)
	Sleep(waitTime)
	fn3(mixerArray, fn, maxCut, 0, fadeInTime)
end

local function fn4()
	if __wf_atom_7e8ad928(occlusionFilter) or __wf_atom_7e8ad928(mixerArray) then
		return
	end

	if fadeInTime > 0 then
		local v = 1

		while v > 0 do
			local v2 = __wf_atom_104bfe98(filterAmount, 0, v)

			for i = 1, #mixerArray do
				mixerArray[i]:UpdateDynamicFilter(occlusionFilter, v2)
			end

			v -= __wf_atom_fa1258d0() / fadeInTime
			Sleep(0)
		end
	end

	for i = 1, #mixerArray do
		mixerArray[i]:UpdateDynamicFilter(occlusionFilter, filterAmount)
	end
end

function ApplySoundFilter()
	fn4()
end

local function fn5()
	if __wf_atom_7e8ad928(mixerArray) then
		return
	end

	if not __wf_atom_7e8ad928(occlusionFilter) and fadeOutTime > 0 then
		local v = 1

		while v > 0 do
			local v2 = __wf_atom_104bfe98(0, filterAmount, v)

			for i = 1, #mixerArray do
				if not __wf_atom_7e8ad928(mixerArray[i]) then
					mixerArray[i]:UpdateDynamicFilter(occlusionFilter, v2)
				end
			end

			v -= __wf_atom_fa1258d0() / fadeOutTime
			Sleep(0)
		end
	end

	for i = 1, #mixerArray do
		if not __wf_atom_7e8ad928(mixerArray[i]) then
			mixerArray[i]:ClearSoundFilter()
		end
	end
end

function ClearSoundFilter()
	fn5()
end

function PlayLocalSound()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		inTrigger and trigger:IsTouching(__wf_atom_c4f78a8f)
		or not (inTrigger or trigger:IsTouching(__wf_atom_c4f78a8f))
	then
		if initialDelay > 0 then
			Sleep(initialDelay)
		end

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:PlaySound(sound, false, 0, false)
		end
	end
end

function PlaySoundOnInstigator(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:PlaySound(sound, false, 0, false)
	end
end

function OcclusionVolumeEnter(_, object)
	_T.playerInOcclusion = true
	Sleep(0)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(object) and object == __wf_atom_c4f78a8f then
		object:PlaySound(sound, false, 0, false)

		if breachPlayer then
			object:__wf_atom_6a7da8c8(true)
		end
	end
end

function OcclusionVolumeExit(_, object)
	_T.playerInOcclusion = false
	Sleep(0)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(object) and object == __wf_atom_c4f78a8f then
		object:PlaySound(sound, false, 0, false)
		object:__wf_atom_6a7da8c8(false)
	end
end

local function fn6(object, p)
	object:__wf_atom_c2a0827a(p)
end

local function fn7(mixerArray, fn8, list, list2, p)
	if #mixerArray ~= #list2 or #mixerArray ~= #list then
		print("Mixer Update failed: #Mixers does not match #AdjustmentValues")
		return
	end

	if p > 0 then
		local v = 1

		while v > 0 do
			for i = 1, #mixerArray do
				local v2 = __wf_atom_104bfe98(list2[i], list[i], v)
				fn8(mixerArray[i], v2)
			end

			v -= __wf_atom_fa1258d0() / p
			Sleep(0)
		end
	end

	for i = 1, #mixerArray do
		fn8(mixerArray[i], list2[i])
	end
end

function Gain()
	if __wf_atom_7e8ad928(mixerArray) or __wf_atom_7e8ad928(mixerGainArray) then
		return
	end

	local v = {}

	for _ = 1, #mixerArray do
		table.insert(v, 0)
	end

	fn7(mixerArray, fn6, v, mixerGainArray, fadeInTime)

	if infiniteDuration then
		return
	end

	Sleep(waitTime)
	fn7(mixerArray, fn6, mixerGainArray, v, fadeOutTime)
end

function CancelGain()
	if __wf_atom_7e8ad928(mixerArray) then
		return
	end

	local v = {}

	for _ = 1, #mixerArray do
		table.insert(v, 0)
	end

	mixerGainArray = {}

	for i = 1, #mixerArray do
		local __wf_atom_55e92b1c = mixerArray[i]:__wf_atom_55e92b1c()
		table.insert(mixerGainArray, __wf_atom_55e92b1c)
	end

	fn7(mixerArray, fn6, mixerGainArray, v, fadeOutTime)
end

function AddMixEffect(p)
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(p, mixEffect, mixingGroup)
	end
end

function RemoveMixEffect(p)
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(p, mixEffect, mixingGroup)
	end
end