local module = require("Lotus.Scripts.Effects.EffectsColorUtilities")
local v = Symbol("EffectsDeco")
local v2 = Symbol("BuildingEffect")
local v3 = Symbol("UseLisetColors")
local v4 = Symbol("TintColor")
local v5 = Symbol("TintColor0")
local v6 = Symbol("TintColor1")
local v7 = Symbol("TintColor2")
local v8 = Symbol("TintColor3")
local v9 = Symbol("AuxTintColor")
local v10 = Symbol("AuxBlendStrength")
local v11 = Symbol("EmissiveTintColor")
local v12 = Symbol("EmissiveTintColorHi")
local v13 = Symbol("EmissiveTintColorLo")
local v14 = Symbol("MorphAmount")
local module2 = require("Lotus.Scripts.Libs.EasingLib")

local function fn()
	local color = Color(212, 227, 255, 255)

	if gRegion:IsMaster() then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				local mShipInterior = __wf_atom_9be88b01:__wf_atom_247a5d2e(true).mShipInterior

				if not __wf_atom_7e8ad928(mShipInterior) then
					return mShipInterior.mColors.mEnergyColor
				end
			end
		end
	else
		local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

		for i = 1, #__wf_atom_bb46d8b6 do
			local v15 = __wf_atom_bb46d8b6[i]

			if not v15.isHost then
				continue
			end

			local decoded = cjson.decode(v15.loadout)

			if __wf_atom_7e8ad928(decoded.ShipInterior) then
				continue
			end

			local colors = decoded.ShipInterior.Colors

			if colors.en == nil then
				continue
			end

			local customizationColorPalette = SF.CustomizationColorPalette()
			customizationColorPalette:__wf_atom_6685afab(6, colors.en)
			customizationColorPalette:__wf_atom_59cc106e(6, true)
			color = customizationColorPalette:GetColor(6)
		end
	end

	return color
end

local function fn2()
	local mEnergyColor = Color(212, 227, 255, 255)
	local mTintColor0 = Color(108, 117, 125, 128)
	local mTintColor1 = Color(179, 179, 179, 128)
	local mTintColor2 = Color(101, 111, 133, 128)
	local mTintColor3 = Color(114, 114, 120, 128)
	local mEnergyColor1 = Color(128, 128, 128, 128)
	local v15 = 1

	if not __wf_atom_7e8ad928(gGameRules) then
		local mShipInterior = nil

		if gGameRules:IsA(__wf_atom_311a7128) or gGameRules:IsA(__wf_atom_469b1d97) then
			mShipInterior = gGameRules:__wf_atom_d7816255()
		else
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

				if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
					mShipInterior = __wf_atom_9be88b01:__wf_atom_a4299765().mShipInterior
				end
			end
		end

		if not __wf_atom_7e8ad928(mShipInterior.mSkinFlavourItem) or _T.ColoringLisetInt == true then
			if mShipInterior.mColors:Initialized(0) then
				mTintColor0 = mShipInterior.mColors.mTintColor0
			end

			if mShipInterior.mColors:Initialized(1) then
				mTintColor1 = mShipInterior.mColors.mTintColor1
			end

			if mShipInterior.mColors:Initialized(2) then
				mTintColor2 = mShipInterior.mColors.mTintColor2
			end

			if mShipInterior.mColors:Initialized(3) then
				mTintColor3 = mShipInterior.mColors.mTintColor3
			end

			if mShipInterior.mColors:Initialized(6) then
				mEnergyColor = mShipInterior.mColors.mEnergyColor
			end

			if mShipInterior.mColors:Initialized(7) then
				mEnergyColor1 = mShipInterior.mColors.mEnergyColor1
				v15 = mEnergyColor1.alpha / 128
			end
		end
	end

	mEnergyColor.alpha = 255
	return
		module.SRGBToLinear255(mEnergyColor),
		mEnergyColor,
		module.SRGBToLinear255(mTintColor0),
		module.SRGBToLinear255(mTintColor1),
		module.SRGBToLinear255(mTintColor2),
		module.SRGBToLinear255(mTintColor3),
		module.SRGBToLinear255(mEnergyColor1),
		v15
end

local function fn3(object, data, data2, data3, data4, data5, p)
	object:SetMaterialParam(v5, data.red / 255, data.green / 255, data.blue / 255, 0.5)
	object:SetMaterialParam(v6, data2.red / 255, data2.green / 255, data2.blue / 255, 0.5)
	object:SetMaterialParam(v7, data3.red / 255, data3.green / 255, data3.blue / 255, 0.5)
	object:SetMaterialParam(v8, data4.red / 255, data4.green / 255, data4.blue / 255, 0.5)
	object:SetMaterialParam(v9, data5.red / 128, data5.green / 128, data5.blue / 128, 0.25)
	object:SetMaterialParam(v10, p)
end

local function fn4()
	local v15, v16, v17, v18, v19, v20, v21, v22 = fn2()

	for _, v23 in ipairs(colorButNoFlickerDecos) do
		v23:SetMaterialParam(SF.__wf_atom_3b7bc4af, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
		v23:SetMaterialParam(v11, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
		v23:SetMaterialParam(v12, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
		v23:SetMaterialParam(v13, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
		fn3(v23, v17, v18, v19, v20, v21, v22)
	end

	for _, v23 in ipairs(effectsDecos) do
		if __wf_atom_7e8ad928(v23) then
			continue
		end

		v23:SetMaterialParam(SF.__wf_atom_3b7bc4af, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
		module.ApplyHighLowOnParticleSysChildren(v23, v15)
		Effects.__wf_atom_d147188c(v23, __wf_atom_ca04301b, v15, v15)
		local __wf_atom_f582136d = v23:__wf_atom_f582136d(__wf_atom_9578cbaa)

		for i = 1, #__wf_atom_f582136d do
			local v24 = __wf_atom_f582136d[i]
			v24:SetMaterialParam(SF.__wf_atom_3b7bc4af, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
			v24:SetMaterialParam(Symbol("offsetColor"), v15.red / 255, v15.green / 255, v15.blue / 255, 1)
		end

		local __wf_atom_f582136d2 = v23:__wf_atom_f582136d(__wf_atom_fac7b40a)

		for i = 1, #__wf_atom_f582136d2 do
			__wf_atom_f582136d2[i]:__wf_atom_7fff6c98(v15)
		end

		local __wf_atom_f582136d3 = v23:__wf_atom_f582136d(__wf_atom_8d0b7f88)

		for i = 1, #__wf_atom_f582136d3 do
			local v24 = __wf_atom_f582136d3[i]

			if not (v24:__wf_atom_db682341() == v or v24:__wf_atom_db682341() == v2) then
				continue
			end

			v24:SetMaterialParam(v11, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
			v24:SetMaterialParam(SF.__wf_atom_3b7bc4af, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
		end
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v3)

	for _, v23 in ipairs(__wf_atom_2226b35c) do
		v23:SetMaterialParam(SF.__wf_atom_3b7bc4af, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
		v23:SetMaterialParam(v11, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
		v23:SetMaterialParam(v12, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
		v23:SetMaterialParam(v13, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
		fn3(v23, v17, v18, v19, v20, v21, v22)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("JUKEBOX_SEQUENCER"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetMaterialParam(SF.__wf_atom_3b7bc4af, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("MiniOctavia"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:SetMaterialParam(
			SF.__wf_atom_0d13bbda,
			v15.red / 255,
			v15.green / 255,
			v15.blue / 255,
			1,
			true
		)
		__wf_atom_0a6a5887_2:SetMaterialParam(v12, v15.red / 255, v15.green / 255, v15.blue / 255, 1, true)
	end

	local rgbToHSV, v23, v24 = module.RGBToHSV(v16)

	for _, v25 in ipairs(lightsToChange) do
		local color = v25:GetColor()
		local _, _, v26 = module.RGBToHSV(color)
		v25:SetColor((module.HSVToRGB(rgbToHSV, v23 * 0.05, v26)))
	end

	Color()
	local hsvToRGB = module.HSVToRGB(rgbToHSV, v23 * 0.3, v24 * 0.6)
	hsvToRGB.alpha = 80

	if not __wf_atom_7e8ad928(dustParticles) then
		dustParticles:__wf_atom_8cd234d5(hsvToRGB, hsvToRGB)
	end
end

function FlickerDecorations()
	Sleep(1)

	while not __wf_atom_a0f6588f:__wf_atom_f89aa44a() do
		Sleep(0)
	end

	Sleep(1)

	if __wf_atom_7e8ad928(_T.ApplyPlayerLisetColors) then
		_T.ApplyPlayerLisetColors = false
	end

	fn4()

	while true do
		if not __wf_atom_7e8ad928(_T.ApplyPlayerLisetColors) and _T.ApplyPlayerLisetColors then
			fn4()
			_T.ApplyPlayerLisetColors = false
		end

		Sleep(0)
	end
end

function EntityColorButNoFlicker(object)
	local v15, _, v16, v17, v18, v19, v20, v21 = fn2()
	object:SetMaterialParam(SF.__wf_atom_3b7bc4af, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
	object:SetMaterialParam(v11, v15.red / 255, v15.green / 255, v15.blue / 255, 1)
	object:SetMaterialParam(v12, 1, 1, 1, 1)
	object:SetMaterialParam(v13, 1, 1, 1, 1)
	fn3(object, v16, v17, v18, v19, v20, v21)
end

local function fn5(object, data)
	object:SetMaterialParam(v4, data.red / 255, data.green / 255, data.blue / 255, 1)
	module.ApplyHighLow(object, data)
	object:SetMaterialParam(Symbol(v12), data.red / 255, data.green / 255, data.blue / 255, 1)
	object:SetMaterialParam(Symbol(v13), data.red / 255, data.green / 255, data.blue / 255, 1)
end

function ColorParticleSys(object)
	Sleep(sleepTime)

	while not __wf_atom_a0f6588f:__wf_atom_f89aa44a() do
		Sleep(0)
	end

	local v15 = fn()
	object:__wf_atom_8cd234d5(v15, v15)
	module.ApplyHighLow(object, v15)
end

function ApplyShipEnergyColor(instance)
	Sleep(sleepTime)

	while not __wf_atom_a0f6588f:__wf_atom_f89aa44a() do
		Sleep(0)
	end

	if instance:IsA(__wf_atom_0ee166be) then
		local __wf_atom_bea1f978 = instance:__wf_atom_bea1f978()

		while __wf_atom_bea1f978 == 1 do
			__wf_atom_bea1f978 = instance:__wf_atom_bea1f978()
			Sleep(0)
		end
	end

	local v15 = fn()

	if instance:IsA(__wf_atom_d00f34c2) then
		instance:SetColor(v15)
	else
		fn5(instance, v15)
	end

	if applyToChildren then
		module.ApplyHighLowOnParticleSysChildren(instance, v15)
		Effects.__wf_atom_d147188c(instance, __wf_atom_ca04301b, v15, v15)
		local __wf_atom_f582136d = instance:__wf_atom_f582136d(__wf_atom_7e616794)

		for i = 1, #__wf_atom_f582136d do
			local v16 = __wf_atom_f582136d[i]

			if __wf_atom_7e8ad928(v16) then
				continue
			end

			if v16:IsA(__wf_atom_d00f34c2) then
				v16:SetColor(v15)
			elseif not v16:IsA(__wf_atom_8939e086) then
				fn5(v16, v15)
			end
		end
	end
end

function ApplyShipEnergyColorToSelected(instance)
	Sleep(sleepTime)

	while not __wf_atom_a0f6588f:__wf_atom_f89aa44a() do
		Sleep(0)
	end

	local v15 = fn()

	if applyColorToMe then
		if instance:IsA(__wf_atom_d00f34c2) then
			instance:SetColor(v15)
		else
			fn5(instance, v15)
		end
	end

	module.ApplyHighLowOnParticleSysChildren(instance, v15)

	for i = 1, #applyToTheseChildren do
		Effects.__wf_atom_d147188c(instance, applyToTheseChildren[i], v15, v15)
	end

	local __wf_atom_f582136d = instance:__wf_atom_f582136d(__wf_atom_7e616794)

	for i = 1, #__wf_atom_f582136d do
		local v16 = __wf_atom_f582136d[i]

		for j = 1, #applyToTheseChildren do
			if __wf_atom_7e8ad928(v16) or not v16:IsA(applyToTheseChildren[j]) then
				continue
			end

			if v16:IsA(__wf_atom_d00f34c2) then
				v16:SetColor(v15)
			elseif not v16:IsA(__wf_atom_8939e086) then
				fn5(v16, v15)
			end
		end
	end
end

function InfestedReactionDeco(object)
	Sleep(0)

	while not __wf_atom_a0f6588f:__wf_atom_f89aa44a() do
		Sleep(0)
	end

	Sleep(1)
	Engine.__wf_atom_878bebe4(object)
	local position = object:GetPosition()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v15 = __wf_atom_9341614d(Vector(0, 0, 1), object:__wf_atom_dc309f8a())
	local v16 = Vector()
	local total = 0
	local v17 = 0

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f)) do
		local v18 = math.sin(total) * 0.05 + 0.05
		__wf_atom_c4f78a8f:__wf_atom_c5f1c61a(v16)
		__wf_atom_c37ab6c1(v16, v16, position)
		local v19 = Length(v16)
		Normalize(v16)
		local v20 = math.max(0, Dot(v16, v15))
		local v21 = __wf_atom_421b01aa((5 - v19) / 5, 0, 1) * v20
		v17 = __wf_atom_104bfe98(v17, v21, 0.02)
		object:__wf_atom_9e6bceb0(0, v18 + v17 * 0.9)
		Sleep(0)
		total += __wf_atom_084b3e93() * 2
	end
end

function planterDSpinOnProximity(instance)
	Sleep(sleepTime)

	while not __wf_atom_a0f6588f:__wf_atom_f89aa44a() do
		Sleep(0)
	end

	if applyColorToMe then
		local v15 = fn()

		if instance:IsA(__wf_atom_d00f34c2) then
			instance:SetColor(v15)
		else
			fn5(instance, v15)
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local position = instance:GetPosition()
	local __wf_atom_be0bea4a = instance:__wf_atom_be0bea4a()
	local v15 = nil

	for i = 1, #__wf_atom_be0bea4a do
		if __wf_atom_be0bea4a[i]:IsA(StreamChild) then
			v15 = __wf_atom_be0bea4a[i]
		end
	end

	local v16 = false

	while not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f)) do
		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local __wf_atom_d5fda8be = __wf_atom_c4f78a8f:__wf_atom_d5fda8be(position)
			local total = 0

			if __wf_atom_d5fda8be <= MaxDistance then
				while total < SpinTransTimeLength and v16 == false do
					local v17 = module2.inOutQuad(total, 0, 1, SpinTransTimeLength)

					if not __wf_atom_7e8ad928(v15) then
						v15:SetMaterialParam(v14, v17)
					end

					instance:__wf_atom_3322b766(0, v17 * (MaxAniSpd - MinAniSpd) + MinAniSpd)
					Sleep(0)
					total += __wf_atom_084b3e93()
				end

				v16 = true
			elseif MaxDistance < __wf_atom_d5fda8be and v16 == true then
				while total < SpinTransTimeLength and true == true do
					local v17 = module2.inOutQuad(total, 1, -1, SpinTransTimeLength)

					if not __wf_atom_7e8ad928(v15) then
						v15:SetMaterialParam(v14, v17)
					end

					instance:__wf_atom_3322b766(0, v17 * (MaxAniSpd - MinAniSpd) + MinAniSpd)
					Sleep(0)
					total += __wf_atom_084b3e93()
				end

				v16 = false
			end
		end

		Sleep(1)
	end
end

function FoundryGlow(object)
	local v15 = Symbol("nScalesWorldPos")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FoundryBakingEffectDeco"))
	Vector()

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		if object:IsVisible() then
			local position = object:GetPosition()
			__wf_atom_0a6a5887:SetMaterialParam(v15, position.x, position.y, position.z, 1)
		else
			__wf_atom_0a6a5887:SetMaterialParam(v15, 0, 0, 0, 1)
			Sleep(2)
		end

		Sleep(0)
	end
end