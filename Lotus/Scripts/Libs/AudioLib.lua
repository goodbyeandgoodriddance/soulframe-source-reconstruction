module(..., package.seeall)
local v = nil
local gGameRules2 = nil
WeakResource("/EE/Types/Engine/Sequencer")
local v2 = WeakResource("/EE/Types/Engine/SoundSysVolume")

local function fn(p, p2, p3, p4)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(gRegion) then
		return nil
	end

	if __wf_atom_7e8ad928(p2) then
		p2 = Vector()
	end

	if __wf_atom_7e8ad928(p3) then
		p3 = false
	end

	return (gRegion:PlaySound(p, p2, p3, 1, p4))
end

function PlaySound(p, p2, p3, p4)
	return (fn(p, p2, p3, p4))
end

function PlaySoundOnEntities(p, list, p2, p3, p4)
	if __wf_atom_7e8ad928(p) then
		return
	end

	if __wf_atom_7e8ad928(list and not __wf_atom_7e8ad928(p2) and p2 ~= EMPTY_SYMBOL) then
		if __wf_atom_7e8ad928(p3) or __wf_atom_7e8ad928(p4) then
			list = gRegion:__wf_atom_2226b35c(p2)
		else
			list = gRegion:__wf_atom_439c0d29(p2, p3, 0, p4)
		end
	end

	for _, v3 in ipairs(list) do
		if not __wf_atom_7e8ad928(v3) then
			v3:PlaySound(p, false)
		end
	end

	if __wf_atom_7e8ad928(list) or #list == 0 then
		print("Couldn't find entity with tag " .. tostring(p2) .. "!")
	end
end

local function fn2(data, p)
	local v3 = __wf_atom_104bfe98(0, data.endOcclusion, p)
	data.mixer:UpdateDynamicFilter(data.filter, v3)
end

local function fn3(data, p)
	local v3 = __wf_atom_104bfe98(data.startGainBias, data.endGainBias, p)
	data.mixer:__wf_atom_c2a0827a(v3)
end

local function fn4(data, p)
	local mixer = data.mixer
	local filter = data.filter

	if not __wf_atom_7e8ad928(filter) then
		mixer:UpdateDynamicFilter(filter, (__wf_atom_104bfe98(data.startOcclusion, 0, p)))
	end

	mixer:__wf_atom_c2a0827a((__wf_atom_104bfe98(data.startGainBias, 0, p)))
end

local function fn5(data)
	data.mixer:UpdateDynamicFilter(data.filter, data.endOcclusion)
end

local function fn6(p)
	p.mixer:__wf_atom_c2a0827a(p.endGainBias)
end

local function fn7(p)
	local mixer = p.mixer
	mixer:ClearSoundFilter()
	mixer:__wf_atom_c2a0827a(0)
end

local function fn8(object)
	local result = {}
	local __wf_atom_3cca14f4 = object:__wf_atom_3cca14f4()
	local __wf_atom_7976dac7 = object:__wf_atom_7976dac7()

	if __wf_atom_7e8ad928(__wf_atom_7976dac7) then
		return result
	end

	for i = 1, #__wf_atom_3cca14f4 do
		local v3 = __wf_atom_3cca14f4[i]
		local __wf_atom_607a5383 = v3:__wf_atom_607a5383()
		local __wf_atom_ae3d1b47 = v3:__wf_atom_ae3d1b47()

		if not __wf_atom_7e8ad928(__wf_atom_607a5383) then
			result[i] = {
				mixer = __wf_atom_607a5383,
				filter = __wf_atom_7976dac7,
				endOcclusion = __wf_atom_ae3d1b47
			}
		end
	end

	return result
end

local function fn9(object)
	local __wf_atom_686e54c7 = object:__wf_atom_686e54c7()
	local result = {}

	for i = 1, #__wf_atom_686e54c7 do
		local v3 = __wf_atom_686e54c7[i]
		local __wf_atom_607a5383 = v3:__wf_atom_607a5383()
		local __wf_atom_ae3d1b47 = v3:__wf_atom_ae3d1b47()

		if not __wf_atom_7e8ad928(__wf_atom_607a5383) then
			result[i] = {
				mixer = __wf_atom_607a5383,
				startGainBias = __wf_atom_607a5383:__wf_atom_55e92b1c(),
				endGainBias = __wf_atom_ae3d1b47
			}
		end
	end

	return result
end

local function fn10(object)
	local __wf_atom_5ce2f0d9 = object:__wf_atom_5ce2f0d9()
	local __wf_atom_7976dac7 = object:__wf_atom_7976dac7()
	local result = {}

	for i = 1, #__wf_atom_5ce2f0d9 do
		local mixer = __wf_atom_5ce2f0d9[i]

		if not __wf_atom_7e8ad928(mixer) then
			result[i] = {
				mixer = mixer,
				filter = __wf_atom_7976dac7,
				startOcclusion = mixer:__wf_atom_8dca847b(),
				startGainBias = mixer:__wf_atom_55e92b1c()
			}
		end
	end

	return result
end

function SetMixerConfiguration(p, p2)
	local activeMixerTransitions = {
		{ update = fn2, finish = fn5, parameters = fn8(p) },
		{ update = fn3, finish = fn6, parameters = fn9(p) },
		{ update = fn4, finish = fn7, parameters = fn10(p) }
	}
	_T.activeMixerTransitions = activeMixerTransitions

	if p2 > 0 then
		local v3 = 0

		while v3 < 1 do
			if _T.activeMixerTransitions == nil or _T.activeMixerTransitions ~= activeMixerTransitions then
				return
			end

			v3 = __wf_atom_421b01aa(v3 + __wf_atom_fa1258d0() / p2, 0, 1)

			for i = 1, #activeMixerTransitions do
				local v4 = activeMixerTransitions[i]
				local parameters = v4.parameters
				local update = v4.update

				for j = 1, #parameters do
					update(parameters[j], v3)
				end
			end

			Sleep(0)
		end
	end

	if _T.activeMixerTransitions == nil or _T.activeMixerTransitions ~= activeMixerTransitions then
		return
	end

	for _, v3 in ipairs(activeMixerTransitions) do
		local finish = v3.finish

		for _, parameter in ipairs(v3.parameters) do
			finish(parameter)
		end
	end

	_T.activeMixerTransitions = nil
end

function AddShakeSound(p, value, p2)
	if __wf_atom_7e8ad928(p) then
		print("No sound provided")
		return
	end

	if __wf_atom_7e8ad928(_T.ShakeSounds) then
		print("_T.SoundShakes is null, make sure SoundShake() is running on an entity in the level")
		return
	end

	local soundInstance = nil

	if __wf_atom_7e8ad928(p2) then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for k, v3 in pairs(__wf_atom_ef7900cf) do
			local __wf_atom_51eabc16 = v3:__wf_atom_51eabc16(p, false)

			if k == 1 then
				soundInstance = __wf_atom_51eabc16
			end
		end
	else
		soundInstance = gRegion:PlaySound(p, p2, false)
	end

	table.insert(_T.ShakeSounds, {
		soundInstance = soundInstance,
		shakeFactor = value or 1
	})
end

local function fn11(p, p2, className, p3, p4)
	if __wf_atom_7e8ad928(p) or p == EMPTY_SYMBOL then
		return
	end

	local v3

	if __wf_atom_7e8ad928(p3) or __wf_atom_7e8ad928(p4) then
		v3 = gRegion:__wf_atom_2226b35c(p)
	else
		v3 = gRegion:__wf_atom_439c0d29(p, p3, 0, p4)
	end

	for _, v4 in ipairs(v3) do
		if not (__wf_atom_7e8ad928(className) or v4:IsA(className)) then
			continue
		end

		if p2 then
			v4:Enable()
		else
			v4:Disable()
		end
	end
end

local function fn12(p, p2, className, p3)
	if __wf_atom_7e8ad928(p) or p == EMPTY_SYMBOL or __wf_atom_7e8ad928(p3) then
		return
	end

	local nearestTagged = gRegion:FindNearestTagged(p, p3)

	if not __wf_atom_7e8ad928(nearestTagged) and (__wf_atom_7e8ad928(className) or nearestTagged:IsA(className)) then
		if p2 then
			nearestTagged:Enable()
		else
			nearestTagged:Disable()
		end
	end
end

function PlaySoundOnTaggedEntity(p, p2)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p2)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("Couldn't find entity with tag " .. tostring(p2) .. "!")
	else
		__wf_atom_0a6a5887:PlaySound(p, false)
	end
end

function EnableTaggedSequencers(p, p2, p3, p4)
	fn11(p, p2, __wf_atom_465d956f, p3, p4)
end

function EnableTaggedSoundSysVolumes(p, p2, p3, p4)
	fn11(p, p2, v2, p3, p4)
end

function EnableTagged(p, p2, p3, p4)
	fn11(p, p2, nil, p3, p4)
end

function EnableNearestTaggedSequencer(p, p2, p3)
	fn12(p, p2, __wf_atom_465d956f, p3)
end

function EnableNearestTaggedSoundSysVolume(p, p2, p3)
	fn12(p, p2, v2, p3)
end

function EnableNearestTaggedSoundSysVolumeMulti(list, p, p2)
	for _, v3 in ipairs(list) do
		fn12(v3, p, v2, p2)
	end
end

function DestroyTaggedEntities(p, className, p2, p3)
	if __wf_atom_7e8ad928(p) or p == EMPTY_SYMBOL then
		return
	end

	local v3

	if __wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(p3) then
		v3 = gRegion:__wf_atom_2226b35c(p)
	else
		v3 = gRegion:__wf_atom_439c0d29(p, p2, 0, p3)
	end

	for _, v4 in ipairs(v3) do
		if __wf_atom_7e8ad928(className) or v4:IsA(className) then
			v4:Destroy()
		end
	end
end

local function fn13(p, list)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local result = {}

	for _, v3 in ipairs(list) do
		if not __wf_atom_7e8ad928(v3) then
			table.insert(result, (v3:Attach(p, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)))
		end
	end

	return result
end

local function fn14(object, p, p2, __wf_atom_465d956f2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if __wf_atom_7e8ad928(__wf_atom_465d956f2) then
		__wf_atom_465d956f2 = __wf_atom_465d956f
	end

	local v3 = __wf_atom_7e8ad928(p2) and true or p2
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_465d956f2)

	for _, v4 in ipairs(__wf_atom_f582136d) do
		if not (__wf_atom_7e8ad928(p) or v4:__wf_atom_db682341() == p) then
			continue
		end

		if v3 then
			v4:Enable()
		else
			v4:Disable()
		end
	end
end

function AttachTypeToEntities(p, p2)
	fn13(p, p2)
end

function AttachTypeToTagged(p, p2, p3, p4)
	if __wf_atom_7e8ad928(p2) or p2 == EMPTY_SYMBOL then
		return
	end

	local v3

	if __wf_atom_7e8ad928(p3) or __wf_atom_7e8ad928(p4) then
		v3 = gRegion:__wf_atom_2226b35c(p2)
	else
		v3 = gRegion:__wf_atom_439c0d29(p2, p3, 0, p4)
	end

	return fn13(p, v3)
end

function EnableSequencerAttachments(p, p2, p3)
	fn14(p, p3, p2, __wf_atom_465d956f)
end

function EnableAttachments(p, p2, p3, p4)
	fn14(p, p4, p2, p3)
end

function DestroyAttachments(object, __wf_atom_465d956f2, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if __wf_atom_7e8ad928(__wf_atom_465d956f2) then
		__wf_atom_465d956f2 = __wf_atom_465d956f
	end

	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_465d956f2)

	for _, v3 in ipairs(__wf_atom_f582136d) do
		if __wf_atom_7e8ad928(p) or v3:__wf_atom_db682341() == p then
			v3:Destroy()
		end
	end
end

MUSIC = {
	default = -1,
	forceOff = -2,
	heavyCombat = 0,
	midCombat = 1,
	lightCombat = 2,
	lightTarget = 3,
	lightFallback = 4,
	ambientFallback = 5,
	ambient = 6
}

function EnableDynamicMusic(p)
	if __wf_atom_7e8ad928(gGameRules2) then
		gGameRules2 = gGameRules
	end

	if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(gGameRules2) then
		v = gGameRules2:__wf_atom_a374c1f8()
	end

	if not __wf_atom_7e8ad928(v) then
		if p then
			v:__wf_atom_f9f0178d(true)
		else
			v:__wf_atom_f9f0178d(false)
			v:__wf_atom_117cb74f(MUSIC.FORCEOFF)
		end
	end
end

function GoToDynamicMusicState(p, default)
	if __wf_atom_7e8ad928(gGameRules2) then
		gGameRules2 = gGameRules
	end

	if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(gGameRules2) then
		v = gGameRules2:__wf_atom_a374c1f8()
	end

	if __wf_atom_7e8ad928(default) then
		default = MUSIC.DEFAULT
	end

	if not __wf_atom_7e8ad928(v) then
		v:__wf_atom_f9f0178d(false)

		if __wf_atom_7e8ad928(p) or p == EMPTY_SYMBOL then
			v:__wf_atom_117cb74f(default)
		else
			v:__wf_atom_cfa47f99(p)
		end
	end
end

function ResetDynamicMusic()
	if __wf_atom_7e8ad928(gGameRules2) then
		gGameRules2 = gGameRules
	end

	if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(gGameRules2) then
		v = gGameRules2:__wf_atom_a374c1f8()
	end

	if not __wf_atom_7e8ad928(v) then
		v:__wf_atom_f9f0178d(true)
	end
end

function StartLocalCustomMusicSequencer(p, p2, p3, p4, p5)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if
		__wf_atom_7e8ad928(__wf_atom_b3845a20)
		or not __wf_atom_7e8ad928(_T.LocalCustomMusicSequencer)
		or __wf_atom_7e8ad928(p)
	then
		return
	end

	local entity = gRegion:CreateEntity(p, __wf_atom_c4f78a8f:GetPosition(), __wf_atom_80368bb1)

	if __wf_atom_7e8ad928(entity) then
		return
	end

	entity:__wf_atom_c1933159(false)
	entity:__wf_atom_83eab41c(p2, p3)
	entity:__wf_atom_d39cdb17(p4)
	_T.LocalCustomMusicSequencer = entity

	if not __wf_atom_7e8ad928(p5) then
		__wf_atom_b3845a20:__wf_atom_66669661(__wf_atom_c4f78a8f, p5, nil)
	end
end

function StopLocalCustomMusicSequencer(p)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if __wf_atom_7e8ad928(__wf_atom_b3845a20) or __wf_atom_7e8ad928(_T.LocalCustomMusicSequencer) then
		return
	end

	_T.LocalCustomMusicSequencer:__wf_atom_a92b09e6()
	_T.LocalCustomMusicSequencer = nil

	if not __wf_atom_7e8ad928(p) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(__wf_atom_c4f78a8f, p, nil)
	end
end

function SetLocalCustomMusicSequencerState(p)
	if __wf_atom_7e8ad928(_T.LocalCustomMusicSequencer) then
		return
	end

	_T.LocalCustomMusicSequencer:__wf_atom_d39cdb17(p)
end