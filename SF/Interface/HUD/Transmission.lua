local v = {
	TS_NONE = 0,
	TS_DELAY = 1,
	TS_OPEN = 3,
	TS_PLAYING = 4,
	TS_WAITING = 5,
	TS_CLOSE = 6,
	TS_CLOSING = 7
}
local v2 = { false, false, false, false }
local v3 = { 15658734, 15658734, 15658734, 15658734 }
local TS_NONE = v.TS_NONE
local v4 = 0
local transmissionSoundInstance = nil
local v5 = nil
local v6 = nil
local v7 = 0
local v8 = 0
local v9 = 0
local v10 = false
local v11 = 0
local v12 = 0
local scale = 100
local interpTime = 0.3
local imageAspect = 1
local total = 0
local v13 = 0
local v14 = 0
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("SF.Interface.HUD.TransmissionUtilities")
local v15 = 340.3
local v16 = 340.3
local v17 = 0
local v18 = 1
local gGameRules2 = nil
local v19 = nil
local transmissionOverrideMainClipName = "CommFrameAlt"
local mScale = 1
local v20 = Symbol("Scramble")
local v21 = Symbol("Scramble_NoMouth")
local v22 = Symbol("Scramble_Strong")
local v23 = Symbol("Scramble_Ends")
local v24 = Symbol("Scramble_Start")
local v25 = nil
local flag = false
local v26 = nil
local v27 = 100
local mPortrait = false
local v28 = nil
local mMovie2 = nil
local v29 = {
	UsingOverrideMovie = false,
	UsingSoftMask = false,
	MaterialIndex = 1,
	ForcedMaterialIndex = false
}
local v30 = nil
local v31 = nil
local v32 = nil
local v36 = false
local v37 = nil
local total2 = 0
local v38 = nil
local flag2 = false
local v39 = nil
local transmissions_Visible = true
local v40 = nil
local hudType = 0
local v41 = {}
local v42 = {
	mHeadsetFXInterval = 0,
	mHeadsetColorOn = Color(58, 177, 252, 0),
	mHeadsetColorOff = Color(0, 0, 0),
	mHeadsetCurrent = true
}
local v43 = nil
local flag3 = false
local v44 = false
local v45 = true
local v46 = false
local v47 = false
local v48 = false
local v49 = false
local v50 = nil
local v51 = nil
local v52 = Symbol("BACKGROUND_SEQUENCER")
local v53 = nil
local v54 = 0
local v55 = __wf_atom_10cd16b2(0, 0.1)

local function fn(object)
	if
		_T.QueuedTransmissions
		and #_T.QueuedTransmissions > 0
		and not __wf_atom_7e8ad928(_T.QueuedTransmissions[1].Transmission)
		and _T.QueuedTransmissions[1].Transmission:__wf_atom_5b41f63b() == object:__wf_atom_5b41f63b()
	then
		return
	end

	module2.QueueTransmission(object)
end

local function fn2()
	if not __wf_atom_7e8ad928(_T.curTransmission) then
		local __wf_atom_cb26a501 = _T.curTransmission:__wf_atom_cb26a501(_T.nextTransmissionTag)

		if not __wf_atom_7e8ad928(__wf_atom_cb26a501) then
			fn(__wf_atom_cb26a501)
		end
	end

	if TS_NONE == v.TS_CLOSING then
		_T.curTransmission = nil
		_T.nextTransmissionTag = nil
		v32 = nil

		if not __wf_atom_7e8ad928(v5) then
			v5:Stop(false)
		end
	end
end

local function fn3(p, value, _, typeSound, p2)
	if not (string.len(value) > 0) then
		mMovie2:__wf_atom_2dedec1a(p, 13, false)
		return
	end

	if p2 then
		module.AnimateTyping(mMovie2, typeSound, p, value, nil)
		mMovie2:__wf_atom_e57658c2(p, 12, v27)
	else
		mMovie2:__wf_atom_50d60589(p, 36, value)
	end

	mMovie2:__wf_atom_2dedec1a(p, 13, true)
end

local function fn4(p)
	if v38 == p then
		return
	end

	v38 = p

	if p == "" then
		mMovie2:__wf_atom_48bd5a59(transmissionOverrideMainClipName, "Message", 36, "")
		return
	end

	module.AnimateTyping(mMovie2, nil, transmissionOverrideMainClipName .. ".Message", p, nil)
	mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Message", 12, 150)
end

local function fn5(p)
	if p then
		v48 = true
		__wf_atom_ec43d06e(mMovie2, transmissionOverrideMainClipName .. ".Name", 8, { 12 }, { 100 }, 1, 0, function()
			v48 = false
		end)
	elseif not v51 then
		v48 = true
		__wf_atom_ec43d06e(mMovie2, transmissionOverrideMainClipName .. ".Message", 8, { 12 }, { 0 }, 2)
		__wf_atom_ec43d06e(mMovie2, transmissionOverrideMainClipName .. ".Name", 8, { 12 }, { 0 }, 2, 0, function()
			v48 = false
		end)
	end
end

local function fn6()
	if not v47 then
		return
	end

	if transmissionOverrideMainClipName == "CommFrameFull" then
		if __wf_atom_7e8ad928(v50) then
			v50 = __wf_atom_8e4fda44:FindMovie(subtitlesMovie)

			if not __wf_atom_7e8ad928(v50) then
				v50:SetVisible(transmissions_Visible)
			end
		end

		if not __wf_atom_7e8ad928(v50) then
			local __wf_atom_68d996b1 = mMovie2:__wf_atom_68d996b1()
			local v56 = v50:__wf_atom_54eeda24() - v50:__wf_atom_5e6e15c8(_T.SubtitleClipName, 1)
			local __wf_atom_5e6e15c8 = mMovie2:__wf_atom_5e6e15c8(transmissionOverrideMainClipName, 1)
			local _, v57 = module.GetProportionalScale(mMovie2)
			local v58 = v57 / 100
			local v59 = mMovie2:__wf_atom_54eeda24() / v58 / __wf_atom_68d996b1
			local v60 = v59 - (v59 - mMovie2:__wf_atom_54eeda24()) * 0.5 - v56 - __wf_atom_5e6e15c8
			mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Name", 1, v60 - 26)
		end
	elseif transmissionOverrideMainClipName == "CommFrame" or transmissionOverrideMainClipName == "CommFrameAlt" then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(transmissionOverrideMainClipName .. ".Name", 41)
		mMovie:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Name", 1, 80 - __wf_atom_5e6e15c8)
	end

	if __wf_atom_7e8ad928(transmissionSoundInstance) then
		if v49 == true then
			v49 = false
			fn5(false)
		end
	else
		local __wf_atom_b878f041 = transmissionSoundInstance:__wf_atom_b878f041()

		if v49 ~= __wf_atom_b878f041 then
			v49 = __wf_atom_b878f041
			fn5(v49)
		end
	end
end

local function fn7()
	if v37 == nil or #v37 == 0 then
		return
	end

	local v56 = false

	if v51 then
		fn4(v51.message)
	else
		local v57 = not __wf_atom_7e8ad928((gClient:__wf_atom_b3845a20()))

		for i = 1, #v37 do
			local v58 = v37[i]
			local time = v58.time
			local soundInstance = v58.soundInstance

			if total2 < time and (v57 and not __wf_atom_7e8ad928(soundInstance) or not v57) then
				fn4(mMovie2:__wf_atom_b4b867f2(v58.sentence))
				break
			elseif i == #v37 then
				v56 = true
			end
		end
	end

	if not v56 then
		total2 += __wf_atom_084b3e93()
		return
	end

	fn4("")
	v37 = nil
	total2 = 0
end

local function fn8()
	if not __wf_atom_7e8ad928(_T.curTransmission) then
		local __wf_atom_c2c66398 = _T.curTransmission:__wf_atom_c2c66398()
		mMovie2:__wf_atom_c90af43a(transmissionOverrideMainClipName .. ".ImageOuter.Image", __wf_atom_c2c66398)
		__wf_atom_ec43d06e(mMovie2, transmissionOverrideMainClipName .. ".ImageOuter.Image", 1, { 12 }, { 100 }, 0.2)
		mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 14, 248)
		mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 15, 248)
		v14 = 1
	end
end

local function fn9(transmission)
	if not _T.AllowedTransmissionTypeNames or __wf_atom_7e8ad928(transmission) then
		return true
	end

	if next(_T.AllowedTransmissionTypeNames) == nil then
		print("Transmission restrictions lifted.")
		_T.AllowedTransmissionTypeNames = nil
	else
		for k, _ in pairs(_T.AllowedTransmissionTypeNames) do
			if transmission:IsA(WeakResource(k)) then
				return true
			end
		end

		print("Transmission type restricted.")
		return false
	end

	return true
end

local function fn10()
	_T.curTransmission = nil
	_T.nextTransmissionTag = nil

	if not __wf_atom_7e8ad928(transmissionSoundInstance) then
		transmissionSoundInstance:Stop(true)
		transmissionSoundInstance = nil
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:Stop(true)
		v6 = nil
	end

	TS_NONE = v.TS_WAITING
	v4 = 0
	mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Waveform", 12, 0)

	if not Engine.__wf_atom_fc67ba71() and not __wf_atom_7e8ad928(v43) and v43:__wf_atom_f9098661() then
		v43:__wf_atom_ee244473(false)
	end
end

local function fn11()
	if not _T.QueuedTransmissions or #_T.QueuedTransmissions == 0 then
		return false
	end

	local transmission = _T.QueuedTransmissions[1].Transmission

	if not fn9(transmission) then
		table.remove(_T.QueuedTransmissions, 1)
		return false
	end

	if __wf_atom_7e8ad928(transmission) then
		return false
	end

	local __wf_atom_cb26a501 = _T.curTransmission:__wf_atom_cb26a501(_T.nextTransmissionTag)

	if not __wf_atom_7e8ad928(__wf_atom_cb26a501) and __wf_atom_cb26a501 ~= transmission then
		print("CheckAdvanceToNext - skipping, " .. _T.curTransmission:__wf_atom_5b41f63b() .. " has next transmission ")
		return false
	end

	if __wf_atom_1ef90898(transmission) then
		v31 = transmission
		v30 = UISys.__wf_atom_c0dbe47c({ transmission:__wf_atom_5b41f63b() }, true)
		print("CheckAdvanceToNext kicked off resloader: " .. transmission:__wf_atom_5b41f63b())
		return true
	else
		local curTransmission2 = Resource(transmission:__wf_atom_5b41f63b())

		if
			curTransmission2:__wf_atom_90737e8c() > 0
			or _T.curTransmission:__wf_atom_7ac7481e() ~= curTransmission2:__wf_atom_7ac7481e()
		then
			return false
		end

		local curTransmission = _T.curTransmission
		local v57

		if not flag3 then
			v57 = curTransmission:__wf_atom_fa9e9301()
		end

		local v58

		if not flag3 then
			v58 = curTransmission2:__wf_atom_fa9e9301()
		end

		if v57 ~= v58 then
			return false
		end

		if _T.ScenarioTransmissions ~= nil then
			for i = 1, #_T.ScenarioTransmissions do
				if _T.ScenarioTransmissions[i].transmission == transmission then
					return false
				end
			end
		end

		_T.curTransmission = curTransmission2
		print("CheckAdvanceToNext taking" .. curTransmission2:__wf_atom_5b41f63b())
		v32 = Type(curTransmission2)
		table.remove(_T.QueuedTransmissions, 1)
		v40 = nil
		TS_NONE = v.TS_OPEN
		v4 = 0.5
		return true
	end
end

function TransmissionActive()
	if __wf_atom_7e8ad928(transmissionSoundInstance) or __wf_atom_7e8ad928(_T.curTransmission) then
		return true
	end

	local __wf_atom_7456d5f7 = _T.curTransmission:__wf_atom_7456d5f7()

	if __wf_atom_7456d5f7 > 0 and transmissionSoundInstance:__wf_atom_946fdac0() <= __wf_atom_7456d5f7 then
		transmissionSoundInstance = nil
		return false
	else
		return true
	end
end

local function fn12()
	mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.TextBack", 15, 0.1)
	mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "TextBackOuter.TextBack", 15, 0.1)
	mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.LineBottom", 1, 0)

	if v25 and v25:IsLoading() or not (v4 <= 0) or _T.HideTransmissionComms then
		if _T.HideTransmissionComms then
			TS_NONE = v.TS_OPEN
		end
	else
		local __wf_atom_3637e6fb = _T.curTransmission:__wf_atom_3637e6fb()

		if not flag3 and v45 then
			local v56 = module.PlaySound(_T.curTransmission:__wf_atom_87ae2f14())

			if __wf_atom_3637e6fb < 0 then
				transmissionSoundInstance = v56
			else
				v5 = v56
				v4 = __wf_atom_3637e6fb
			end
		end

		v6 = nil
		TS_NONE = v.TS_OPEN
		local v56 = _T.curTransmission:__wf_atom_a3ca8256() + 1
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local settings = __wf_atom_18a5d83b:Settings()
			local v57 = v3[v56]

			if v2[v56] then
				v57 = settings:__wf_atom_fd5d793e(v57)
			end

			mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Name", 11, v57)
			mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Waveform", 11, v57)
		end

		if transmissionOverrideMainClipName == "CommFrameFull" then
			__wf_atom_ec43d06e(mMovie2, transmissionOverrideMainClipName, 8, { 12 }, { 100 }, interpTime, 0)
		else
			__wf_atom_ec43d06e(
				mMovie2,
				transmissionOverrideMainClipName,
				8,
				{ 12, 0, 1 },
				{ 100, v11, v12 },
				interpTime,
				0
			)
		end

		mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 12, 0)
		local portait3DTexture2 = _T.curTransmission:__wf_atom_a33ab313()

		if transmissionOverrideMainClipName ~= "CommFrameFull" and not v29.UsingOverrideMovie then
			if __wf_atom_7e8ad928(portait3DTexture2) then
				portait3DTexture2 = _T.curTransmission:__wf_atom_c2c66398()
				imageAspect = _T.curTransmission:__wf_atom_d14bccda()
				local v57 = imageAspect * 248
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 14, v57)
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 15, 248)
			else
				local v57 = v16
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 14, v15)
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 15, v57)
			end
		end

		local curTransmission = _T.curTransmission
		local v57

		if not flag3 then
			v57 = curTransmission:__wf_atom_fa9e9301()
		end

		if __wf_atom_7e8ad928(v57) then
			if transmissionOverrideMainClipName == "CommFrameFull" then
				__wf_atom_ec43d06e(
					mMovie2,
					transmissionOverrideMainClipName .. ".ImageOuter.Image",
					0,
					{ 12 },
					{ 0 },
					1,
					0
				)
			elseif not __wf_atom_7e8ad928(portait3DTexture2) then
				mMovie2:OverrideMaterial("CommFrame.ImageOuter.Image", portraitImageMaterial)
				local v58 = { function(p)
						local v59 = p * v27
						mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 12, v59)
						mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.TextBack", 12, v59)
						mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "TextBackOuter.TextBack", 12, v59)

						if transmissionOverrideMainClipName ~= "CommFrameFull" and not v29.UsingOverrideMovie then
							mMovie2:__wf_atom_4c1c1986(
								transmissionOverrideMainClipName,
								"ImageOuter.Frame",
								12,
								100 * p
							)
						end
					end }
				__wf_atom_ec43d06e(mMovie2, transmissionOverrideMainClipName .. ".ImageOuter.Image", 0, v58, { 1 }, 1.5)
			end
		else
			portait3DTexture2 = portait3DTexture

			if transmissionOverrideMainClipName ~= "CommFrameFull" and not v29.UsingOverrideMovie then
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 14, 393.75)
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 15, 262.5)
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter", 12, v27)
			end

			if hudType ~= 3 then
				mMovie2:__wf_atom_1ca72041(
					transmissionOverrideMainClipName .. ".ImageOuter.Image",
					"PixelateBias",
					0,
					1.2,
					0,
					0
				)
			end

			local v59 = { function(p)
					local v60 = p * v27
					mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 12, v60)
					mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.TextBack", 12, v60)
					mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "TextBackOuter.TextBack", 12, v60)

					if transmissionOverrideMainClipName ~= "CommFrameFull" and not v29.UsingOverrideMovie then
						mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Frame", 12, 100 * p)
					end
				end }
			__wf_atom_ec43d06e(mMovie2, transmissionOverrideMainClipName .. ".ImageOuter.Image", 0, v59, { 1 }, 1.5)
		end

		if transmissionOverrideMainClipName ~= "CommFrameFull" and not v29.UsingOverrideMovie then
			mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 1, 0)
		end

		mMovie2:__wf_atom_c90af43a(transmissionOverrideMainClipName .. ".ImageOuter.Image", portait3DTexture2)
		mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Waveform", 13, true)
		module3.mSmoothHead = nil
	end
end

local function fn13()
	v4 -= __wf_atom_fa1258d0()

	if TS_NONE == v.TS_DELAY then
		fn12()
	end

	if
		TS_NONE == v.TS_OPEN
		and v4 <= 0
		and __wf_atom_7e8ad928(transmissionSoundInstance)
		and not __wf_atom_7e8ad928(gRegion)
	then
		local __wf_atom_cefccdc5 = _T.curTransmission:__wf_atom_cefccdc5()
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and not _T.InSyndicateScreen and __wf_atom_7e8ad928(v39) then
			v39 = _T.curTransmission:__wf_atom_a1bf04a1()

			if __wf_atom_7e8ad928(v39) then
				if __wf_atom_cefccdc5:__wf_atom_8598f3a9() then
					local nearestTagged = gRegion:FindNearestTagged(
						__wf_atom_cefccdc5,
						__wf_atom_c4f78a8f:GetPosition()
					)

					if not __wf_atom_7e8ad928(nearestTagged) then
						v39 = nearestTagged
					end
				end
			else
				v39 = gRegion:__wf_atom_e2db08ce(v39, __wf_atom_c4f78a8f:GetPosition())
			end
		end

		if
			__wf_atom_7e8ad928(v39)
			and __wf_atom_cefccdc5:__wf_atom_8598f3a9()
			and not __wf_atom_7e8ad928(__wf_atom_392793db)
		then
			local nearestTagged = __wf_atom_392793db:FindNearestTagged(
				__wf_atom_cefccdc5,
				__wf_atom_c4f78a8f:GetPosition()
			)

			if not __wf_atom_7e8ad928(nearestTagged) then
				v39 = nearestTagged
			end
		end

		local text, v56 = module3:GetText(_T.curTransmission)
		local __wf_atom_00e6ce32 = _T.curTransmission:__wf_atom_00e6ce32(v56)
		v46 = false
		local _curTransmission = _T.curTransmission
		local __wf_atom_5b41f63b = _T.curTransmission:__wf_atom_5b41f63b()
		local v57 = _T.TransmissionDspOverrides and _T.TransmissionDspOverrides[__wf_atom_5b41f63b]

		if v57 and not __wf_atom_7e8ad928(v57) then
			_T.TransmissionDspOverrides[__wf_atom_5b41f63b] = nil
		elseif
			_T.TransmissionDspOverridesWRes
			and not __wf_atom_7e8ad928(_T.TransmissionDspOverridesWRes[__wf_atom_5b41f63b])
		then
			v57 = Resource(_T.TransmissionDspOverridesWRes[__wf_atom_5b41f63b])
			_T.TransmissionDspOverridesWRes[__wf_atom_5b41f63b] = nil
		else
			v57 = nil
		end

		if __wf_atom_7e8ad928(v39) then
			transmissionSoundInstance = gRegion:PlaySound(
				__wf_atom_00e6ce32,
				__wf_atom_28d5d4aa,
				false,
				0,
				nil,
				nil,
				v57
			)
		else
			transmissionSoundInstance = v39:PlaySound(__wf_atom_00e6ce32, false, 1, false, nil, 0, v57)
			v39:__wf_atom_f7e4d343(transmissionSoundInstance)

			if
				not __wf_atom_7e8ad928(_T.CurrentConversation)
				and _T.CurrentConversation.mHubNpc == v39
				and _T.CurrentConversation.IsUnmasked
			then
				v46 = true
			end

			if v39:IsA(__wf_atom_67c46eba) then
				v39 = nil
			end
		end

		v6 = transmissionSoundInstance

		for i = 1, #v53 do
			local v58 = v53[i]

			if __wf_atom_7e8ad928(v58) or not v58:IsA(__wf_atom_465d956f) then
				continue
			end

			v58:Disable()
		end

		v53 = nil
		local curTransmission = _T.curTransmission
		local v58

		if not flag3 then
			v58 = curTransmission:__wf_atom_fa9e9301()
		end

		if not (__wf_atom_7e8ad928(v58) or __wf_atom_7e8ad928(__wf_atom_4ec12570)) then
			v53 = __wf_atom_4ec12570:__wf_atom_2226b35c(v52)

			for i = 1, #v53 do
				local v59 = v53[i]

				if __wf_atom_7e8ad928(v59) or not v59:IsA(__wf_atom_465d956f) then
					continue
				end

				v59:Enable()
			end
		end

		TS_NONE = v.TS_PLAYING
		total = 0
		v4 = _T.curTransmission:__wf_atom_1e34340d()
		local typeSound = typeSound

		if not __wf_atom_7e8ad928(transmissionSoundInstance) then
			v4 = 0
		end

		_T.TransmissionSoundInstance = transmissionSoundInstance
		local __wf_atom_95e72410 = _T.curTransmission:__wf_atom_95e72410()

		if __wf_atom_7e8ad928(__wf_atom_95e72410) then
			__wf_atom_95e72410 = gRegion:__wf_atom_c4f78a8f()
		end

		_T.curTransmission:__wf_atom_8af44dad(__wf_atom_95e72410)

		if
			_T.curTransmission:__wf_atom_23aed91e()
			or _T.curTransmission:__wf_atom_efa2b0d3()
			or _T.curTransmission:__wf_atom_e193a78e()
		then
			local v59 = (not __wf_atom_7e8ad928(v6) or _T.curTransmission:__wf_atom_1ad17e9f()) and 0
				or _T.curTransmission:__wf_atom_1e34340d()
			gRegion:__wf_atom_1e97b9b5(v6, text, true, v59)
		elseif
			string.len(text) > 0
			and (not v29.UsingOverrideMovie or _T.TransmissionOverrideSubtitles)
			and (not flag3 or v44)
		then
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "TextBack", 13, true)
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Name", 13, true)
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Text", 13, true)
			local ternary = module.Ternary(
				v28,
				v28,
				mMovie2:__wf_atom_8e9ac384(tostring(_T.curTransmission:__wf_atom_7ac7481e()), false)
			)
			local v59 = string.upper(ternary)

			if not v36 then
				fn3(transmissionOverrideMainClipName .. ".Name", v59, false, typeSound, false)
			end

			mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Name", 12, 0)
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
			v47 = not __wf_atom_7e8ad928(__wf_atom_18a5d83b) and __wf_atom_18a5d83b:Settings():Subtitles()
			v49 = false
			v37 = Sound.__wf_atom_71ec202b(text, v6)
			total2 = 0
			local v60 = transmissionOverrideMainClipName .. ".Message"
			mMovie2:__wf_atom_2dedec1a(v60, 13, true)
			mMovie2:__wf_atom_50d60589(v60, 36, "")

			if v51 ~= nil then
				v38 = ""
			end

			v13 = 0.2
			v28 = nil
			v44 = false
		else
			gRegion:__wf_atom_1e97b9b5(v6, text)
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "TextBack", 13, false)
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Name", 13, false)
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Text", 13, false)
			v13 = 0
			v47 = false
		end

		if not Engine.__wf_atom_fc67ba71() and not __wf_atom_7e8ad928(v43) and v43:__wf_atom_f9098661() then
			v43:__wf_atom_ee244473(true, 3)
		end
	end

	if TS_NONE == v.TS_PLAYING then
		if __wf_atom_7e8ad928(transmissionSoundInstance) then
			if v4 <= 0 then
				TS_NONE = v.TS_WAITING
				v4 = v13 + _T.curTransmission:__wf_atom_fbd18c0e()
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Waveform", 12, 0)

				if not Engine.__wf_atom_fc67ba71() and not __wf_atom_7e8ad928(v43) and v43:__wf_atom_f9098661() then
					v43:__wf_atom_ee244473(false)
				end
			end
		else
			local flag4

			if __wf_atom_7e8ad928(transmissionSoundInstance) or __wf_atom_7e8ad928(_T.curTransmission) then
				flag4 = true
			else
				local __wf_atom_7456d5f7 = _T.curTransmission:__wf_atom_7456d5f7()

				if __wf_atom_7456d5f7 > 0 and transmissionSoundInstance:__wf_atom_946fdac0() <= __wf_atom_7456d5f7 then
					transmissionSoundInstance = nil
					flag4 = false
				else
					flag4 = true
				end
			end

			if flag4 then
				local __wf_atom_31aab74c = transmissionSoundInstance:__wf_atom_31aab74c()
				local v56 = __wf_atom_421b01aa(__wf_atom_31aab74c * 100, 0, 100)
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Waveform", 12, v56)
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Waveform", 6, v56 * 0.7)

				if not __wf_atom_7e8ad928(_T.curTransmission:__wf_atom_c2c66398()) then
					local __wf_atom_2490589b = v55:__wf_atom_2490589b(v56, __wf_atom_fa1258d0())
					mMovie2:__wf_atom_4c1c1986(
						transmissionOverrideMainClipName,
						"ImageOuter",
						5,
						100 + __wf_atom_2490589b * 0.05
					)
					mMovie2:__wf_atom_4c1c1986(
						transmissionOverrideMainClipName,
						"ImageOuter",
						6,
						100 + __wf_atom_2490589b * 0.05
					)
				end

				if total < 2 then
					total += __wf_atom_084b3e93()

					if total >= 2 and not __wf_atom_7e8ad928((_T.curTransmission:__wf_atom_c2c66398())) then
						__wf_atom_ec43d06e(
							mMovie2,
							transmissionOverrideMainClipName .. ".Image",
							1,
							{ 12 },
							{ 0 },
							0.2,
							0,
							fn8
						)
					end
				end

				if not Engine.__wf_atom_fc67ba71() and not __wf_atom_7e8ad928(v43) and v43:__wf_atom_f9098661() then
					if v42.mHeadsetFXInterval <= 0 then
						local mHeadsetColorOn = v42.mHeadsetColorOn
						local ternary = module.Ternary(v42.mHeadsetCurrent, mHeadsetColorOn, v42.mHeadsetColorOff)
						v43:__wf_atom_ee244473(true, 3)
						v43:__wf_atom_f76f7927(ternary)
						v43:__wf_atom_f3360646()
						v42.mHeadsetFXInterval = Random(0.1, 0.3)
						v42.mHeadsetCurrent = module.Ternary(v42.mHeadsetCurrent, false, true)
					else
						v42.mHeadsetFXInterval -= __wf_atom_084b3e93()
					end
				end
			elseif v4 <= 0 then
				TS_NONE = v.TS_WAITING
				v4 = v13 + _T.curTransmission:__wf_atom_fbd18c0e()
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Waveform", 12, 0)

				if not Engine.__wf_atom_fc67ba71() and not __wf_atom_7e8ad928(v43) and v43:__wf_atom_f9098661() then
					v43:__wf_atom_ee244473(false)
				end
			end
		end
	end

	if TS_NONE == v.TS_WAITING and v4 <= 0 then
		local __wf_atom_a3ca8256 = _T.curTransmission:__wf_atom_a3ca8256()
		local v56 = #_T.QueuedTransmissions

		if __wf_atom_a3ca8256 ~= 3 or v56 ~= 0 then
			if fn11() then
				return
			end

			if not _T.BlockTransmissionFadeOut then
				TS_NONE = v.TS_CLOSE
			end

			if not (flag3 or _T.BlockTransmissionFadeOut or __wf_atom_7e8ad928(_T.curTransmission)) then
				module.PlaySound(_T.curTransmission:__wf_atom_38ea5351())
			end

			if not __wf_atom_7e8ad928(__wf_atom_4ec12570) then
				v10 = not __wf_atom_7e8ad928(__wf_atom_4ec12570:__wf_atom_c3b255b8())
			end
		end
	end

	if
		TS_NONE == v.TS_CLOSE
		and __wf_atom_7e8ad928(transmissionSoundInstance)
		and (__wf_atom_7e8ad928(__wf_atom_4ec12570) or __wf_atom_7e8ad928(__wf_atom_4ec12570:__wf_atom_c3b255b8()))
	then
		TS_NONE = v.TS_CLOSING

		if __wf_atom_7e8ad928(mMovie2) then
			fn2()
			return
		end

		v39 = nil
		v18 = mMovie2:__wf_atom_9b8947bc()
		mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Waveform", 13, false)

		if not v48 then
			mMovie2:__wf_atom_48bd5a59(transmissionOverrideMainClipName, "Name", 36, "")
			mMovie2:__wf_atom_48bd5a59(transmissionOverrideMainClipName, "Message", 36, "")
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "TextBack", 13, false)
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Name", 13, false)
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Text", 13, false)
		end

		local v56 = (transmissionOverrideMainClipName == "CommFrameFull" or v29.UsingOverrideMovie) and 1.25 or 2
		local __wf_atom_5e6e15c8 = mMovie2:__wf_atom_5e6e15c8(
			transmissionOverrideMainClipName .. ".ImageOuter.Image",
			12
		)

		local function fn14(p)
			if p == 1 then
				fn2()
				return
			end

			local v57 = 1 - p
			mMovie2:__wf_atom_4c1c1986(
				transmissionOverrideMainClipName,
				"ImageOuter.Image",
				12,
				v57 * __wf_atom_5e6e15c8
			)
			mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.TextBack", 12, v57 * v27)
			mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "TextBackOuter.TextBack", 12, v57 * v27)

			if transmissionOverrideMainClipName ~= "CommFrameFull" and not v29.UsingOverrideMovie then
				mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Frame", 12, 100 * v57)
			end
		end

		if not _T.BlockTransmissionFadeOut then
			__wf_atom_ec43d06e(
				mMovie2,
				transmissionOverrideMainClipName .. ".ImageOuter.Image",
				7,
				{ fn14 },
				{ 1 },
				v56
			)
			return
		end

		if not __wf_atom_7e8ad928(_T.curTransmission) then
			local __wf_atom_cb26a501 = _T.curTransmission:__wf_atom_cb26a501(_T.nextTransmissionTag)

			if not __wf_atom_7e8ad928(__wf_atom_cb26a501) then
				fn(__wf_atom_cb26a501)
			end
		end

		fn11()
	end
end

function OnRelayPeerListChanged(_)
	if v51 then
		local __wf_atom_df6512ff = gMatchingService:__wf_atom_df6512ff()
		local v56 = false

		for _, v57 in pairs(__wf_atom_df6512ff) do
			if v51.name == v57 then
				v56 = true
			end
		end

		if not v56 then
			fn10()
		end
	end
end

local function fn14()
	if not v29.UsingOverrideMovie then
		transmissionOverrideMainClipName = "CommFrame"
	end

	mScale = 1
	v11 = v7
	v12 = v8
	local v56 = false
	local image = nil
	local v57 = imageAspect
	v19 = nil
	module3.mAnimateMouth = true

	if not (__wf_atom_7e8ad928(_T.curTransmission) or v29.UsingOverrideMovie) then
		image = _T.curTransmission:__wf_atom_5f1a56b0()
		v57 = _T.curTransmission:__wf_atom_d14bccda()
		v19 = _T.curTransmission:__wf_atom_69d31ac0()

		if v19:__wf_atom_8598f3a9() then
			if v19 == v21 then
				module3.mAnimateMouth = false
			end
		else
			v19 = nil
		end

		v56 = _T.curTransmission:__wf_atom_f7082041()
	end

	if _T.curTransmission:__wf_atom_e193a78e() then
		v27 = 75
		local __wf_atom_fa9e9301 = _T.curTransmission:__wf_atom_fa9e9301()

		if
			__wf_atom_7e8ad928(__wf_atom_fa9e9301)
			or not string.find(__wf_atom_fa9e9301:__wf_atom_5b41f63b(), "Natah")
		then
			mMovie2:OverrideMaterial("CommFrameFull.ImageOuter.Image", portraitOverlayMaterial)
		else
			mMovie2:OverrideMaterial("CommFrameFull.ImageOuter.Image", portraitOverlayMaterialAlt)
		end
	end

	if _T.curTransmission:__wf_atom_23aed91e() then
		v27 = 0
	else
		v27 = 100
	end

	if v56 or _T.transmissionOverrides and _T.transmissionOverrides.useAlt then
		transmissionOverrideMainClipName = "CommFrameAlt"
		mScale = -1
		local v58 = 393.75

		if mMovie2:__wf_atom_6e4667f6() then
			v58 *= mMovie:__wf_atom_68d996b1()
		end

		v11 = mMovie2:__wf_atom_97cd8326() - v58

		if mMovie2:__wf_atom_6e4667f6() then
			local v59 = mMovie2:__wf_atom_97cd8326() * 0.5
			local v60 = 1 / mMovie:__wf_atom_68d996b1()
			v11 = v59 + (v11 - v59) * v60
		end

		v12 = v9
		mMovie:__wf_atom_e57658c2(transmissionOverrideMainClipName, 0, v11)
	end

	if
		not v29.UsingOverrideMovie
		and not __wf_atom_7e8ad928(_T.curTransmission)
		and (_T.curTransmission:__wf_atom_23aed91e() or _T.curTransmission:__wf_atom_efa2b0d3() or _T.curTransmission:__wf_atom_e193a78e() or flag3)
	then
		transmissionOverrideMainClipName = "CommFrameFull"
		local v58 = _T.curTransmission:__wf_atom_e193a78e() or flag3
		mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "ImageOuter", 13, v58)

		if v58 and _T.curTransmission:__wf_atom_f7082041() then
			mMovie:__wf_atom_e57658c2(transmissionOverrideMainClipName, 0, v11)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(transmissionOverrideMainClipName .. ".Name", 14)
			local v59 = mMovie:__wf_atom_97cd8326() * 0.5 - __wf_atom_5e6e15c8 * 0.5
			mMovie:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "Name", 0, v59 - v11)
		end

		local __wf_atom_7de346f0 = _T.curTransmission:__wf_atom_7de346f0()

		if __wf_atom_7de346f0 ~= 0 then
			mMovie:__wf_atom_e57658c2(transmissionOverrideMainClipName, 0, __wf_atom_7de346f0)
			v36 = true
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "TextBack", 13, false)
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Name", 13, false)
			mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Text", 13, false)
		end
	end

	scale = 100
	interpTime = 0.3

	if _T.transmissionOverrides then
		if _T.transmissionOverrides.interpTime then
			interpTime = _T.transmissionOverrides.interpTime
		end

		if _T.transmissionOverrides.scale then
			scale = _T.transmissionOverrides.scale
		end

		if not __wf_atom_7e8ad928(_T.transmissionOverrides.Image) then
			image = _T.transmissionOverrides.Image
		end

		if _T.transmissionOverrides.ImageAspect then
			imageAspect = _T.transmissionOverrides.ImageAspect
		end
	end

	if __wf_atom_7e8ad928(image) then
		mMovie2:__wf_atom_2dedec1a("ImageFrame", 13, false)
	else
		mMovie2:__wf_atom_2dedec1a("ImageFrame", 13, true)
		mMovie2:__wf_atom_c90af43a("ImageFrame.Image", image)
		imageAspect = v57
		mMovie2:__wf_atom_e57658c2("ImageFrame", 5, imageAspect * 100)
	end

	if transmissionOverrideMainClipName ~= "CommFrameFull" and not v29.UsingOverrideMovie then
		mMovie2:__wf_atom_e57658c2(transmissionOverrideMainClipName, 5, scale)
		mMovie2:__wf_atom_e57658c2(transmissionOverrideMainClipName, 6, scale)
	end

	mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "TextBack", 13, false)
	mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Name", 13, false)
	mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Text", 13, false)
	v51 = nil

	if _T.ScenarioTransmissions ~= nil then
		for i = 1, #_T.ScenarioTransmissions do
			local scenarioTransmission = _T.ScenarioTransmissions[i]

			if scenarioTransmission.transmission ~= v32 then
				continue
			end

			v51 = {
				name = scenarioTransmission.playerName,
				message = mMovie2:__wf_atom_8e9ac384(scenarioTransmission.message, true)
			}
			table.remove(_T.ScenarioTransmissions, i)
			local __wf_atom_9c7c90fb = gMatchingService:__wf_atom_9c7c90fb()

			if __wf_atom_7e8ad928(__wf_atom_9c7c90fb) then
				break
			end

			if __wf_atom_9c7c90fb:__wf_atom_2d427a6a(v51.name) then
				gMatchingService:__wf_atom_aa1891ca("Transmission", "OnRelayPeerListChanged")
				break
			else
				fn10()
				return false
			end
		end
	end

	_T.transmissionOverrides = nil
	return true
end

local function fn15()
	hudType = _T.HudType
	local ternary = module.Ternary(hudType == nil, 0, hudType)
	v29.MaterialIndex = ternary + 1
	local v56 = v41[ternary] == nil and "StopNormal" or v41[ternary]
	__wf_atom_86cbd68d(mMovie, "CommFrame.ImageOuter.Frame.gotoAndStop", v56)
	__wf_atom_86cbd68d(mMovie, "CommFrameAlt.ImageOuter.Frame.gotoAndStop", v56)

	if hudType == 1 then
		mMovie:__wf_atom_e57658c2("CommFrame.ImageOuter.Frame.GrineerBorder", 11, 15954454)
		mMovie:__wf_atom_e57658c2("CommFrameAlt.ImageOuter.Frame.GrineerBorder", 11, 15954454)
	elseif hudType == 2 then
		mMovie:__wf_atom_e57658c2("CommFrame.ImageOuter.Frame.CorpusBorder", 11, 2779007)
		mMovie:__wf_atom_e57658c2("CommFrameAlt.ImageOuter.Frame.CorpusBorder", 11, 2779007)
	elseif hudType == 3 then
		mMovie:__wf_atom_e57658c2("CommFrame.ImageOuter.Frame.TeshinBorder", 11, 16769169)
		mMovie:__wf_atom_e57658c2("CommFrameAlt.ImageOuter.Frame.TeshinBorder", 11, 16769169)
	end
end

function Initialize()
	if __wf_atom_7e8ad928(_T.TransmissionOverrideMovie) then
		v27 = 100
		mMovie2 = mMovie
	else
		v29.UsingOverrideMovie = true
		mMovie2 = _T.TransmissionOverrideMovie
		transmissionOverrideMainClipName = _T.TransmissionOverrideMainClipName
		v29.UsingSoftMask = _T.TransmissionOverrideSoftMask
		v15 = module.Ternary(_T.TransmissionOverrideX, _T.TransmissionOverrideX, 0)
		v16 = module.Ternary(_T.TransmissionOverrideY, _T.TransmissionOverrideY, 0)
		local v56 = v16
		mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 14, v15)
		mMovie2:__wf_atom_4c1c1986(transmissionOverrideMainClipName, "ImageOuter.Image", 15, v56)
		mMovie:__wf_atom_e57658c2("_root", 12, 0)
		v27 = 100
		_T.TransmissionOverrideMovie = nil
		_T.TransmissionOverrideSoftMask = nil
	end

	local module4 = require("Lotus.Interface.Libs.DioramaLoader")
	v25 = module4.CreateDioramaLoader(mMovie2)
	v25.mSyncAvatars = false
	v25.mPortrait = true
	v41[0] = "StopNormal"
	v41[1] = "StopGrineer"
	v41[2] = "StopCorpus"
	v41[3] = "StopTeshin"
	mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "TextBack", 13, false)
	mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Name", 13, false)
	mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Text", 13, false)
	mMovie2:__wf_atom_7df746cd(0)

	if _T.HudType ~= hudType then
		fn15()
	end

	if v29.UsingOverrideMovie then
		v7 = mMovie2:__wf_atom_5e6e15c8(transmissionOverrideMainClipName, 0)
		v8 = mMovie2:__wf_atom_5e6e15c8(transmissionOverrideMainClipName, 1)
	else
		v7 = mMovie2:__wf_atom_5e6e15c8("CommFrame", 0)
		v8 = mMovie2:__wf_atom_5e6e15c8("CommFrame", 1) + 40
		v9 = mMovie2:__wf_atom_5e6e15c8("CommFrameAlt", 1) + 40

		if Engine.__wf_atom_fc67ba71() then
			local __wf_atom_97cd8326 = mMovie2:__wf_atom_97cd8326()
			v7 += __wf_atom_97cd8326 * 0.05
		end
	end

	if mMovie2 == mMovie and mMovie2:__wf_atom_6e4667f6() then
		local v56 = mMovie2:__wf_atom_97cd8326() * 0.5
		local v57 = 1 / mMovie:__wf_atom_68d996b1()
		v7 = v56 + (v7 - v56) * v57
	end

	local v56 = v29.UsingOverrideMovie and { transmissionOverrideMainClipName }
		or { "CommFrame", "CommFrameAlt", "CommFrameFull" }

	for i = 1, #v56 do
		transmissionOverrideMainClipName = v56[i]
		mMovie2:__wf_atom_e57658c2(transmissionOverrideMainClipName, 12, 0)
		mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Message", 13, false)
		mMovie2:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Waveform", 13, false)
		mMovie2:__wf_atom_48bd5a59(transmissionOverrideMainClipName, "Message", 36, "")
		mMovie2:__wf_atom_48bd5a59(transmissionOverrideMainClipName, "Name", 36, "")

		if
			v29.UsingOverrideMovie
			and _T.TransmissionOverrideMainClipName ~= "TransmissionFrame"
			and not _T.TransmissionMaskedMaterial
		then
			mMovie2:OverrideMaterial(transmissionOverrideMainClipName .. ".ImageOuter.Image", portraitMaterial)
		elseif v29.UsingSoftMask then
			mMovie2:OverrideMaterial(
				transmissionOverrideMainClipName .. ".ImageOuter.Image",
				portraitSoftMaskedMaterial[v29.MaterialIndex]
			)
		else
			mMovie2:OverrideMaterial(
				transmissionOverrideMainClipName .. ".ImageOuter.Image",
				portraitMaskedMaterial[v29.MaterialIndex]
			)
		end
	end

	mMovie2:OverrideMaterial("CommFrameFull.ImageOuter.Image", portraitOverlayMaterial)
	mMovie2:__wf_atom_e57658c2("CommFrameFull.ImageOuter", 0, 0)
	mMovie2:__wf_atom_e57658c2("ImageFrame", 12, 0)
	mMovie2:OverrideMaterial("ImageFrame.Image", imageMaterial)

	if v29.UsingOverrideMovie then
		v17 = mMovie2:__wf_atom_5e6e15c8(transmissionOverrideMainClipName, 0) + mScale * 100
	else
		v17 = mMovie2:__wf_atom_5e6e15c8("ImageFrame", 0) + mScale * 100
	end

	mMovie2:__wf_atom_50d60589("CommFrameAlt.Name", 45, "right")

	if
		not Engine.__wf_atom_fc67ba71()
		and not __wf_atom_7e8ad928(__wf_atom_539492fe)
		and __wf_atom_539492fe:IsA(__wf_atom_60862239)
	then
		v43 = __wf_atom_539492fe:__wf_atom_e108808f()
	end
end

local function fn16()
	if not __wf_atom_7e8ad928(__wf_atom_4ec12570) then
		gGameRules2 = gGameRules

		if __wf_atom_7e8ad928(_T.curTransmission) then
			return
		end

		if v29.UsingOverrideMovie and _T.TransmissionOverrideAspect then
			local v56 = mMovie2:__wf_atom_5e6e15c8(transmissionOverrideMainClipName .. ".ImageOuter", 14) / mMovie2:__wf_atom_5e6e15c8(
				transmissionOverrideMainClipName .. ".ImageOuter",
				15
			)
			__wf_atom_4ec12570:GetGameCamera():__wf_atom_7e50a9ad(v56)
			_T.TransmissionOverrideAspect = nil
		end

		if not __wf_atom_7e8ad928(gGameRules2) then
			local name

			if v51 ~= nil then
				name = v51.name
			end

			if name ~= "" then
				v28 = name
			end
		end
	end
end

local function fn17()
	if not v25:IsLoading() then
		return
	end

	if v51 ~= nil then
		local __wf_atom_9c7c90fb = gMatchingService:__wf_atom_9c7c90fb()

		if not (__wf_atom_7e8ad928(__wf_atom_9c7c90fb) or __wf_atom_9c7c90fb:__wf_atom_3179c2db(v51.name)) then
			return
		end
	end

	if v25:LoadingComplete() then
		if v29.UsingOverrideMovie and not __wf_atom_7e8ad928(mMovie2) then
			mMovie2:Execute("OnPortraitLoaded", "")
		end

		flag = true
		local v56 = true
		v45 = true

		if _T.KeepTransmissionBgRegion and not __wf_atom_7e8ad928(__wf_atom_392793db) then
			if __wf_atom_392793db:__wf_atom_22941262() == v25.mLevel then
				v56 = false
				v45 = false
			else
				__wf_atom_8e4fda44:__wf_atom_62a19abc()
			end
		end

		v25:FinishLoad(not v56)
		fn16()
	end
end

local function fn18()
	_T.OrdisSpeaking = nil

	if flag then
		flag = false

		if mPortrait then
			if not (__wf_atom_7e8ad928(__wf_atom_4ec12570) or __wf_atom_7e8ad928(v26)) then
				__wf_atom_4ec12570:__wf_atom_dd1e4d10(v26)
			end

			for i = 1, #v53 do
				local v56 = v53[i]

				if __wf_atom_7e8ad928(v56) or not v56:IsA(__wf_atom_465d956f) then
					continue
				end

				v56:Disable()
			end

			v53 = nil
			local __wf_atom_8e4fda44 = __wf_atom_8e4fda44
			local v56 = v10

			if not v56 then
				local ternary = module.Ternary
				local v57

				if transmissionOverrideMainClipName == _T.TransmissionOverrideMainClipName then
					v57 = not _T.TransmissionOverrideRecycle
				else
					v57 = false
				end

				v56 = ternary(v57, true, false)
			end

			__wf_atom_8e4fda44:__wf_atom_12ff8d19(v56)
			_T.TransmissionOverrideRecycle = nil
		elseif not _T.KeepTransmissionBgRegion then
			__wf_atom_8e4fda44:__wf_atom_62a19abc()

			if not __wf_atom_7e8ad928(gRegion) then
				gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(0, 1)
			end
		end
	end
end

local function fn19(p)
	if (p == nil or not p) and _T.curTransmission == nil and v31 == nil then
		return
	end

	_T.curTransmission = nil
	_T.nextTransmissionTag = nil

	if not __wf_atom_7e8ad928(transmissionSoundInstance) then
		transmissionSoundInstance:Stop(true)
	end

	if not __wf_atom_7e8ad928(mMovie) then
		mMovie:Close()
	end
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or __wf_atom_7e8ad928(mMovie2) then
		return
	end

	if _T.Transmissions_Visible ~= nil and transmissions_Visible ~= _T.Transmissions_Visible then
		transmissions_Visible = _T.Transmissions_Visible
		mMovie2:SetVisible(transmissions_Visible)

		if not __wf_atom_7e8ad928(v50) then
			v50:SetVisible(transmissions_Visible)
		end
	end

	if flag2 then
		fn10()
		flag2 = false
	end

	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	fn7()
	fn6()

	if __wf_atom_7e8ad928(_T.curTransmission) and (_T.QueuedTransmissions == nil or #_T.QueuedTransmissions == 0) then
		mMovie:Close()
		fn18()
	else
		fn17()

		if v31 ~= nil then
			if __wf_atom_7e8ad928(v30) or not v30:__wf_atom_86399a47() then
				return
			end

			if not (__wf_atom_7e8ad928(_T.QueuedTransmissions) or __wf_atom_7e8ad928(_T.QueuedTransmissions[1])) then
				_T.QueuedTransmissions[1].Transmission = Resource(_T.QueuedTransmissions[1].Transmission)
			end

			v31 = nil
		end

		if _T.velocityCoords and not v29.UsingOverrideMovie then
			mMovie2:__wf_atom_e57658c2("_root", 0, module.Round(_T.velocityCoords.x))
			mMovie2:__wf_atom_e57658c2("_root", 1, module.Round(_T.velocityCoords.y))
		end

		if _T.HudType ~= hudType then
			fn15()
		end

		if not v29.UsingOverrideMovie then
			mMovie2:__wf_atom_88d9cd84(__wf_atom_084b3e93())
		end

		if __wf_atom_7e8ad928(_T.curTransmission) and not (_T.pauseTransmissions or gClient:__wf_atom_449cc668()) then
			local transmission

			if #_T.QueuedTransmissions > 0 then
				transmission = _T.QueuedTransmissions[1].Transmission
			end

			if not fn9(transmission) then
				table.remove(_T.QueuedTransmissions, 1)
				return
			end

			if __wf_atom_1ef90898(transmission) then
				v31 = transmission
				local v56 = { transmission:__wf_atom_5b41f63b() }

				if _T.BlockTransmissionFadeOut and not __wf_atom_7e8ad928(_T.TransmissionOverrideFallback) then
					table.insert(v56, _T.TransmissionOverrideFallback:__wf_atom_5b41f63b())
				end

				v30 = UISys.__wf_atom_c0dbe47c(v56, true)
				return
			else
				table.remove(_T.QueuedTransmissions, 1)

				if __wf_atom_7e8ad928(transmission) then
					return
				end

				local __wf_atom_5b41f63b = transmission:__wf_atom_5b41f63b()
				local curTransmission2 = Resource(__wf_atom_5b41f63b)

				if curTransmission2:__wf_atom_40cc4be2() then
					local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

					if not (__wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_18a5d83b:Settings():__wf_atom_5a804a31() or _T.BlockTransmissionFadeOut) then
						return
					end
				end

				if
					not __wf_atom_7e8ad928(_T.BlockTransmissionsFromSender)
					and curTransmission2:__wf_atom_7ac7481e() == _T.BlockTransmissionsFromSender
				then
					return
				end

				if _T.TransmissionHistory == nil then
					_T.TransmissionHistory = {}
				end

				if curTransmission2:__wf_atom_1736c07d() < math.random() then
					return
				end

				local __wf_atom_8e1024e7 = curTransmission2:__wf_atom_8e1024e7()
				local __wf_atom_829200cf = curTransmission2:__wf_atom_829200cf()

				if __wf_atom_8e1024e7 >= 0 or __wf_atom_829200cf > 0 then
					local nextTime = Time()

					if _T.TransmissionHistory[__wf_atom_5b41f63b] == nil then
						_T.TransmissionHistory[__wf_atom_5b41f63b] = { nextTime = nextTime }

						if __wf_atom_8e1024e7 >= 0 then
							_T.TransmissionHistory[__wf_atom_5b41f63b].repeatsRemaining = __wf_atom_8e1024e7
						end
					elseif __wf_atom_8e1024e7 >= 0 then
						if _T.TransmissionHistory[__wf_atom_5b41f63b].repeatsRemaining == 0 then
							if
								_T.BlockTransmissionFadeOut
								and not __wf_atom_7e8ad928(_T.TransmissionOverrideFallback)
							then
								curTransmission2 = Resource(_T.TransmissionOverrideFallback)
							else
								return
							end
						else
							_T.TransmissionHistory[__wf_atom_5b41f63b].repeatsRemaining = _T.TransmissionHistory[__wf_atom_5b41f63b].repeatsRemaining - 1
						end
					end

					if __wf_atom_829200cf > 0 then
						if nextTime < _T.TransmissionHistory[__wf_atom_5b41f63b].nextTime then
							if
								_T.BlockTransmissionFadeOut
								and not __wf_atom_7e8ad928(_T.TransmissionOverrideFallback)
							then
								curTransmission2 = Resource(_T.TransmissionOverrideFallback)
							else
								return
							end
						else
							_T.TransmissionHistory[__wf_atom_5b41f63b].nextTime = nextTime + __wf_atom_829200cf
						end
					end
				end

				_T.TransmissionOverrideFallback = nil
				print("Updated pulled nextQueued: " .. transmission:__wf_atom_5b41f63b())
				v32 = Type(curTransmission2)
				_T.curTransmission = curTransmission2
				_T.nextTransmissionTag = EMPTY_SYMBOL
				local __wf_atom_cb26a501 = _T.curTransmission:__wf_atom_cb26a501(_T.nextTransmissionTag)
				local __wf_atom_7ac7481e = _T.curTransmission:__wf_atom_7ac7481e()
				local v57

				if not __wf_atom_7e8ad928(__wf_atom_cb26a501) then
					v57 = __wf_atom_cb26a501:__wf_atom_7ac7481e()
				end

				if
					__wf_atom_7e8ad928(__wf_atom_cb26a501)
					or __wf_atom_7ac7481e ~= v57
					or not (__wf_atom_cb26a501:__wf_atom_90737e8c() <= 0)
				then
					if __wf_atom_7e8ad928(__wf_atom_cb26a501) and not __wf_atom_7e8ad928(gRegion) then
						local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

						if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
							local transmissionResponse = module3:GetTransmissionResponse(
								_T.curTransmission:__wf_atom_db682341(),
								gGameData,
								__wf_atom_c4f78a8f
							)

							if not __wf_atom_7e8ad928(transmissionResponse) then
								__wf_atom_c4f78a8f:__wf_atom_1a73b1c2(transmissionResponse)
							end
						end
					end
				else
					fn(__wf_atom_cb26a501)
				end

				v40 = nil
				flag3 = false

				if not fn14() then
					return
				end

				local v58 = not curTransmission2:__wf_atom_efa2b0d3()

				if v58 ~= mPortrait then
					fn18()
				end

				TS_NONE = v.TS_DELAY
				v4 = _T.curTransmission:__wf_atom_90737e8c()
				local curTransmission = _T.curTransmission
				local v59

				if not flag3 then
					v59 = curTransmission:__wf_atom_fa9e9301()
				end

				mPortrait = v58
				flag = false

				if __wf_atom_7e8ad928(v59) then
					if not mPortrait and _T.KeepTransmissionBgRegion then
						flag = true
					end
				else
					v26 = nil
					v39 = nil
					v25.mPortrait = mPortrait
					v25:LoadDiorama(v59)
				end

				if not _T.KeepTransmissionBgRegion then
					module3.mZoomer = math.random()
				end
			end
		end

		if __wf_atom_7e8ad928(_T.curTransmission) then
			return
		end

		fn13()
		local __wf_atom_5e6e15c8 = mMovie2:__wf_atom_5e6e15c8(transmissionOverrideMainClipName, 12)
		mMovie2:__wf_atom_e57658c2("ImageFrame", 12, __wf_atom_5e6e15c8)
		mMovie2:__wf_atom_e57658c2("ImageFrame", 0, v17 - __wf_atom_5e6e15c8)
		local v56 = not __wf_atom_7e8ad928(_T.HideSubtitles) and tonumber(_T.HideSubtitles) > 0
		mMovie:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Name", 13, not v56)
		mMovie:__wf_atom_7f57ab2f(transmissionOverrideMainClipName, "Message", 13, not v56)

		if not __wf_atom_7e8ad928(v39) then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or not (__wf_atom_c4f78a8f:__wf_atom_312d8d57(v39) > 0) then
				v54 = __wf_atom_421b01aa(v54 + __wf_atom_084b3e93(), 0, 1)
			else
				v54 = __wf_atom_421b01aa(v54 - __wf_atom_084b3e93(), 0, 1)
			end

			mMovie2:__wf_atom_4c1c1986(
				transmissionOverrideMainClipName,
				"ImageOuter",
				12,
				__wf_atom_24a82b69(v54) * 100
			)
		end

		local v57 = Time()
		local v58 = __wf_atom_24a82b69(__wf_atom_a3cc989c(v57 * 0.025)) * 30
		local v59 = math.pow(Noise((7 + v57) * 0.025), 2) * 15

		if imageAspect == 1 and not v29.UsingOverrideMovie then
			mMovie2:__wf_atom_e57658c2("ImageFrame", 18, v59)
			mMovie2:__wf_atom_e57658c2("ImageFrame", 17, v58 - 15)
		end

		local v60 = math.min(1, (math.abs((__wf_atom_482dad48(3, 0.5, Time() * 0.5, 0)))))
		local __wf_atom_5e6e15c8_2 = mMovie2:__wf_atom_5e6e15c8(transmissionOverrideMainClipName, 0)
		local __wf_atom_5e6e15c8_3 = mMovie2:__wf_atom_5e6e15c8(transmissionOverrideMainClipName, 1)
		math.pow(math.max(math.abs(v11 - __wf_atom_5e6e15c8_2) / 200, math.abs(v12 - __wf_atom_5e6e15c8_3) / 200), 0.5)
		local v61 = __wf_atom_104bfe98(0, 0.05, v60 * v60)
		mMovie2:__wf_atom_1ca72041("ImageFrame.Image", "PlasmaStrength", v61, 0, 0, 0)

		if v19 == v20 or v19 == v21 then
			v60 = __wf_atom_421b01aa(math.abs((__wf_atom_482dad48(2, 0.5, Time() * 0.5, 0))) * 1.25, 0, 1)

			if not __wf_atom_7e8ad928(transmissionSoundInstance) then
				transmissionSoundInstance:__wf_atom_4ec021c2(1, __wf_atom_421b01aa(v60 * v60 * 2, 0, 1))
				transmissionSoundInstance:__wf_atom_4ec021c2(3, __wf_atom_421b01aa(v60 * v60 * 2, 0, 1))
			end
		end

		if v19 == v23 and not __wf_atom_7e8ad928(_T.curTransmission) then
			v60 = math.max(
				0,
				math.abs(0.5 - __wf_atom_421b01aa(math.abs(v4 / _T.curTransmission:__wf_atom_1e34340d()), 0, 1)) - 0.25
			) * 4

			if not __wf_atom_7e8ad928(transmissionSoundInstance) then
				transmissionSoundInstance:__wf_atom_4ec021c2(1, __wf_atom_421b01aa(v60 * v60 * 2, 0, 1))
				transmissionSoundInstance:__wf_atom_4ec021c2(3, __wf_atom_421b01aa(v60 * v60 * 2, 0, 1))
			end
		end

		if v19 == v24 and not __wf_atom_7e8ad928(_T.curTransmission) then
			v60 = math.max(0, 0.5 - __wf_atom_421b01aa(math.abs(v4 / _T.curTransmission:__wf_atom_1e34340d()), 0, 1)) * 2

			if not __wf_atom_7e8ad928(transmissionSoundInstance) then
				transmissionSoundInstance:__wf_atom_4ec021c2(1, __wf_atom_421b01aa(v60 * v60 * 2, 0, 1))
				transmissionSoundInstance:__wf_atom_4ec021c2(3, __wf_atom_421b01aa(v60 * v60 * 2, 0, 1))
			end
		end

		if v19 == v22 then
			local scramble_Strong = _T.Scramble_Strong or 1

			if hudType ~= 3 then
				mMovie2:__wf_atom_1ca72041(
					transmissionOverrideMainClipName .. ".ImageOuter.Image",
					"PixelateBias",
					0,
					0.2 + 0.7 * __wf_atom_421b01aa(1 - v60, 0, 0.8),
					0,
					0
				)
			end

			mMovie2:__wf_atom_1ca72041(
				transmissionOverrideMainClipName .. ".ImageOuter.Image",
				"PlasmaStrength",
				0.5 * scramble_Strong,
				0,
				0,
				0
			)

			if not __wf_atom_7e8ad928(transmissionSoundInstance) then
				local __wf_atom_31aab74c = transmissionSoundInstance:__wf_atom_31aab74c()
				mMovie2:__wf_atom_1ca72041(
					transmissionOverrideMainClipName .. ".ImageOuter.Image",
					"Atten",
					1,
					1,
					1,
					0.3 + __wf_atom_421b01aa(__wf_atom_31aab74c, 0, 1) * 0.7
				)
			end
		else
			if hudType ~= 3 then
				mMovie2:__wf_atom_1ca72041(
					transmissionOverrideMainClipName .. ".ImageOuter.Image",
					"PixelateBias",
					0,
					0.5 + __wf_atom_104bfe98(1.5, 0, v60 * v60),
					0,
					0
				)
			end

			mMovie2:__wf_atom_1ca72041(
				transmissionOverrideMainClipName .. ".ImageOuter.Image",
				"PlasmaStrength",
				0,
				0,
				0,
				0
			)
			mMovie2:__wf_atom_1ca72041(transmissionOverrideMainClipName .. ".ImageOuter.Image", "Atten", 1, 1, 1, 1)
		end

		if not (__wf_atom_7e8ad928(transmissionSoundInstance) or v46) then
			transmissionSoundInstance:__wf_atom_4ec021c2(0, __wf_atom_421b01aa(v60 * v60 * 2, 0, 1))
			transmissionSoundInstance:__wf_atom_4ec021c2(5, __wf_atom_421b01aa(v60 * v60 * 3, 0, 1))
		end

		module3.mScale = mScale
		local __wf_atom_392793db = __wf_atom_392793db

		if mPortrait then
			__wf_atom_392793db = __wf_atom_4ec12570
		end

		if not __wf_atom_7e8ad928(v39) then
			if not mPortrait then
				__wf_atom_392793db = gRegion
			end

			v40 = false
		end

		module3:UpdateRegion(v6, __wf_atom_392793db, not mPortrait, v39, v40)

		if module3.mForcedMaterialIndex == nil or not (module3.mForcedMaterialIndex <= #portraitMaskedMaterial) then
			if v29.ForcedMaterialIndex then
				v29.ForcedMaterialIndex = false

				if
					v29.UsingOverrideMovie
					and _T.TransmissionOverrideMainClipName ~= "TransmissionFrame"
					and not _T.TransmissionMaskedMaterial
				then
					mMovie2:OverrideMaterial(transmissionOverrideMainClipName .. ".ImageOuter.Image", portraitMaterial)
				elseif v29.UsingSoftMask then
					mMovie2:OverrideMaterial(
						transmissionOverrideMainClipName .. ".ImageOuter.Image",
						portraitSoftMaskedMaterial[v29.MaterialIndex]
					)
				else
					mMovie2:OverrideMaterial(
						transmissionOverrideMainClipName .. ".ImageOuter.Image",
						portraitMaskedMaterial[v29.MaterialIndex]
					)
				end
			end
		else
			v29.ForcedMaterialIndex = true

			if
				v29.UsingOverrideMovie
				and _T.TransmissionOverrideMainClipName ~= "TransmissionFrame"
				and not _T.TransmissionMaskedMaterial
			then
				mMovie2:OverrideMaterial(transmissionOverrideMainClipName .. ".ImageOuter.Image", portraitMaterial)
			elseif v29.UsingSoftMask then
				mMovie2:OverrideMaterial(
					transmissionOverrideMainClipName .. ".ImageOuter.Image",
					portraitSoftMaskedMaterial[module3.mForcedMaterialIndex]
				)
			else
				mMovie2:OverrideMaterial(
					transmissionOverrideMainClipName .. ".ImageOuter.Image",
					portraitMaskedMaterial[module3.mForcedMaterialIndex]
				)
			end
		end

		local v62

		if v19 == nil or _T[tostring(v19)] == nil then
			v62 = 0
		else
			local v63 = __wf_atom_421b01aa(tonumber(_T[tostring(v19)]), 0, 1)
			v62 = v63 * v63
		end

		mMovie2:__wf_atom_1ca72041("ImageFrame.Image", "Scramble", v62, 0, 0, 0)
		v14 = math.max(0, v14 - __wf_atom_084b3e93() * 2)

		if TS_NONE == v.TS_CLOSING then
			local v63 = __wf_atom_5e6e15c8 * 0.01 * v18
			mMovie2:__wf_atom_0cf0fdbe(v63)
		end
	end
end

function PreviewClose(p)
	fn19(p)
end

function QueueClose()
	flag2 = true
end

function Shutdown()
	_T.curTransmission = nil
	_T.nextTransmissionTag = nil
	v32 = nil
	fn18()

	if v29.UsingOverrideMovie and not __wf_atom_7e8ad928(mMovie2) then
		mMovie2:Execute("OnTransmissionDone", "")
	end
end

local v56 = {}

function TransmissionQueuedFromHud(p)
	table.insert(v56, Type(p))
end