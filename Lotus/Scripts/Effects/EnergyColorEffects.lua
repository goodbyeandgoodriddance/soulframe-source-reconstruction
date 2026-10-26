local v = WeakResource("/Lotus/Types/Enemies/TennoReplicants/TennoReplicantAvatar")
local v2 = WeakResource("/Lotus/Types/Enemies/Stalker/StalkerAvatar")
local v3 = WeakResource("/Lotus/Types/Enemies/KuvaLich/KuvaLichAAvatar")
local v4 = WeakResource("/Lotus/Types/Enemies/KuvaLich/KuvaLichFemaleAAvatar")
local v5 = WeakResource("/Lotus/Types/Game/FlightJetPackItems/PlayerFlightJetPackItem")
local module = require("Lotus.Scripts.Effects.EffectsColorUtilities")
local v6 = { 0, 1, 5 }

local function fn(object, getParentFirst)
	local v7 = nil
	local creator

	if getParentFirst then
		creator = object:__wf_atom_575542c8()

		if __wf_atom_7e8ad928(creator) or not creator:IsA(__wf_atom_7e6ed5fa) then
			creator = object:__wf_atom_f7e7be53()
		end
	else
		creator = object:GetCreator()
	end

	if __wf_atom_7e8ad928(creator) then
		return
	end

	if creator:IsA(__wf_atom_9df43583) then
		creator:ApplyEnergyColor(object)
		return nil
	end

	if creator:IsA(__wf_atom_7e6ed5fa) then
		v7 = creator
	else
		local creator2 = creator:GetCreator()

		if __wf_atom_7e8ad928(creator2) then
			if creator:IsA(__wf_atom_baf9587d) then
				v7 = creator:__wf_atom_7be51ede()
			else
				v7 = creator:__wf_atom_f7e7be53()
			end
		elseif creator2:IsA(__wf_atom_7e616794) then
			v7 = creator2:__wf_atom_f7e7be53()
		elseif creator2:IsA(__wf_atom_d98e64fe) or creator2:IsA(v5) then
			v7 = creator2:__wf_atom_6009c8ed()
		end
	end

	if __wf_atom_7e8ad928(v7) then
		return nil
	end

	if v7:IsA(v) then
		return (Color(5, 145, 175, 255))
	end

	if v7:IsA(v2) then
		return (Color(255, 0, 0, 255))
	end

	if not (v7:IsA(__wf_atom_7e6ed5fa) or v7:IsA(__wf_atom_ee1ed4db) or v7:IsA(v3) or v7:IsA(v4)) then
		return nil
	end

	if not __wf_atom_7e8ad928(v7) or creator == v7 then
		local v8 = 8
		local v9 = nil

		while v8 > 0 and __wf_atom_7e8ad928(v9) and not __wf_atom_7e8ad928(v7) do
			if isArchwing then
				v9 = v7:__wf_atom_d2b2176d():__wf_atom_f7583f71()
			else
				v9 = v7:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
			end

			v8 -= 1
			Sleep(0)
		end

		if isPrimaryWeapon and not __wf_atom_7e8ad928(v7) then
			v9 = v7:__wf_atom_d2b2176d():__wf_atom_28224c27(1)
		end

		if isMeleeWeapon and not __wf_atom_7e8ad928(v7) then
			v9 = v7:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
		end

		if isSecondaryWeapon and not __wf_atom_7e8ad928(v7) then
			v9 = v7:__wf_atom_d2b2176d():__wf_atom_28224c27(0)
		end

		if not __wf_atom_7e8ad928(v9) then
			local __wf_atom_eb82ab1f = v9:__wf_atom_eb82ab1f()
			local v10 = 8

			while v10 > 0 and not (__wf_atom_eb82ab1f:Initialized() or __wf_atom_7e8ad928(v9)) do
				__wf_atom_eb82ab1f = v9:__wf_atom_eb82ab1f()
				v10 -= 1
				Sleep(0)

				if __wf_atom_7e8ad928(v9) then
					return nil
				end
			end

			local v11 = nil
			local colors

			if useAltEnergyColor then
				if Param == Symbol("TintColor") then
					v9:ApplyEnergyColor(object, true)
					return nil
				else
					colors = __wf_atom_eb82ab1f:GetColors(2)
				end
			elseif useOperatorEyes then
				colors = __wf_atom_eb82ab1f:GetColors(4)
			else
				local v12 = Color()

				if Param == Symbol("TintColor") then
					v9:ApplyEnergyColor(object)
					return nil
				end

				v9:__wf_atom_8e1ec29f(v12, false)
				return v12
			end

			if colors:Initialized(6) then
				return (Color(colors.mEnergyColor))
			end

			return v11
		end
	end
end

local function fn2(instance)
	local v7 = nil

	if isHitEffect then
		v7 = instance
	elseif projectileParents == 0 then
		v7 = instance:__wf_atom_f7e7be53()
	else
		local v8 = instance

		for _ = 1, projectileParents do
			v8 = v8:__wf_atom_3d96ddcd()
			v7 = v8
		end
	end

	Sleep(0)

	if __wf_atom_7e8ad928(v7) then
		return
	end

	local creator = nil

	if isAttachedToWeapon then
		if not (v7:IsA(__wf_atom_7e6ed5fa) or v7:IsA(__wf_atom_7e9106b6)) then
			return nil
		end

		if isMeleeWeapon then
			creator = v7:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
		elseif isSecondaryWeapon then
			creator = v7:__wf_atom_d2b2176d():__wf_atom_28224c27(0)
		else
			creator = v7:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
		end
	elseif isHitEffect then
		creator = v7:GetCreator()
	elseif v7:IsA(__wf_atom_baf9587d) then
		creator = v7:__wf_atom_9f2332e5()
	end

	if __wf_atom_7e8ad928(creator) or not creator:IsA(__wf_atom_9df43583) then
		return nil
	end

	if __wf_atom_7e8ad928(creator) then
		return
	end

	local v8

	if isSentinelWeapon then
		v8 = creator:__wf_atom_6009c8ed():__wf_atom_d2b2176d():__wf_atom_e55d02aa():__wf_atom_eb82ab1f()
	else
		local __wf_atom_95e72410 = creator:__wf_atom_95e72410()

		if not __wf_atom_7e8ad928(__wf_atom_95e72410) and __wf_atom_95e72410:IsA(__wf_atom_7e9106b6) then
			local particleQuality = module.ParticleQuality()

			if destroyIfIllusionAvatar then
				if particleQuality ~= 2 then
					instance:Destroy()
				end

				return
			elseif particleQuality < 1 then
				return
			end
		end

		v8 = creator:__wf_atom_eb82ab1f()
	end

	local v9 = 8

	while v9 > 0 and not (v8:Initialized() or __wf_atom_7e8ad928(creator)) do
		v8 = creator:__wf_atom_eb82ab1f()
		v9 -= 1
		Sleep(0)
	end

	local v10 = nil
	local colors

	if useAltEnergyColor then
		colors = v8:GetColors(2)
	elseif useOperatorEyes then
		colors = v8:GetColors(4)
	else
		colors = v8:GetColors(0)
	end

	if colors:Initialized(6) then
		return (Color(colors.mEnergyColor))
	end

	return v10
end

function ApplyEnergyColor(object)
	Color()

	if sleepFirst then
		Sleep(0)
	end

	local v7

	if isWeaponProjectile then
		v7 = fn2(object)
	else
		v7 = fn(object, getParentFirst)
	end

	if not __wf_atom_7e8ad928(v7) then
		if applyToParentColor then
			local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

			if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				object = __wf_atom_3d96ddcd
			end
		end

		if invertColor then
			v7.red = 255 - v7.red
			v7.green = 255 - v7.green
			v7.blue = 255 - v7.blue
		end

		object:SetMaterialParam(
			Param,
			module.SRGBToLinear(v7.red),
			module.SRGBToLinear(v7.green),
			module.SRGBToLinear(v7.blue),
			1,
			applyToChildren
		)

		if applyLowHigh then
			module.ApplyHighLow(object, v7)
		end
	end

	if isBaroDangle then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			local __wf_atom_c082fc3d = __wf_atom_3d96ddcd:__wf_atom_c082fc3d()
			local __wf_atom_fa6a8faf = object:__wf_atom_fa6a8faf()
			object:__wf_atom_e310f01f(
				Vector(__wf_atom_fa6a8faf.x * 1, __wf_atom_fa6a8faf.y * __wf_atom_c082fc3d, __wf_atom_fa6a8faf.z * 1),
				object:__wf_atom_45c0553e()
			)
		end
	end
end

function SetMaterialParam(object)
	if not __wf_atom_7e8ad928(object) then
		if sleepFirst then
			Sleep(0)
		end

		object:SetMaterialParam(
			Param,
			module.SRGBToLinear(newEnergyColor.red),
			module.SRGBToLinear(newEnergyColor.green),
			module.SRGBToLinear(newEnergyColor.blue),
			1
		)

		if applyToChildren then
			local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_8d0b7f88)

			if not __wf_atom_7e8ad928(__wf_atom_f582136d) then
				for i = 1, #__wf_atom_f582136d do
					__wf_atom_f582136d[i]:SetMaterialParam(
						Param,
						module.SRGBToLinear(newEnergyColor.red),
						module.SRGBToLinear(newEnergyColor.green),
						module.SRGBToLinear(newEnergyColor.blue),
						1
					)
				end
			end
		end
	end
end

local function fn3(instance)
	local v7 = instance
	local v8 = nil
	local v9 = nil

	repeat
		v7 = v7:__wf_atom_3d96ddcd()
	until __wf_atom_7e8ad928(v7) or v7:IsA(__wf_atom_4ebf67cb) or v7:IsA(__wf_atom_baf9587d)

	if not __wf_atom_7e8ad928(v7) then
		if v7:IsA(__wf_atom_4ebf67cb) then
			if isMeleeWeapon then
				v8 = v7:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
			elseif isSecondaryWeapon then
				v8 = v7:__wf_atom_d2b2176d():__wf_atom_28224c27(0)
			else
				v8 = v7:__wf_atom_d2b2176d():__wf_atom_28224c27(1)
			end

			v9 = v7
		elseif v7:IsA(__wf_atom_baf9587d) then
			Sleep(0)
			v9 = v7:__wf_atom_7be51ede()
			v8 = v7:__wf_atom_9f2332e5()
		end
	end

	if __wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(v9) then
		return nil
	end

	local v10

	if isSentinelWeapon then
		v10 = v8:__wf_atom_6009c8ed():__wf_atom_d2b2176d():__wf_atom_e55d02aa():__wf_atom_eb82ab1f()
	else
		if v9:IsA(__wf_atom_7e9106b6) then
			local particleQuality = module.ParticleQuality()

			if destroyIfIllusionAvatar then
				if particleQuality ~= 2 then
					instance:Destroy()
				end

				return
			elseif particleQuality < 1 then
				return
			end
		end

		v10 = v8:__wf_atom_eb82ab1f()
	end

	local v11 = 8

	while v11 > 0 and not (v10:Initialized() or __wf_atom_7e8ad928(v8)) do
		v10 = v8:__wf_atom_eb82ab1f()
		v11 -= 1
		Sleep(0)
	end

	local colors = v10:GetColors(not instance:IsA(__wf_atom_8c983b5d) and 0 or instance:__wf_atom_cf751e23())
	local v12

	if colors:Initialized(6) then
		return (Color(colors.mEnergyColor))
	end

	return v12
end

function ApplyEnergyColorDeco(object)
	Sleep(0)
	local v7 = fn3(object)

	if __wf_atom_7e8ad928(v7) then
		return
	end

	if applyToParentColor then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			object = __wf_atom_3d96ddcd
		end
	end

	if invertColor then
		v7.red = 255 - v7.red
		v7.green = 255 - v7.green
		v7.blue = 255 - v7.blue
	end

	object:SetMaterialParam(
		Param,
		module.SRGBToLinear(v7.red),
		module.SRGBToLinear(v7.green),
		module.SRGBToLinear(v7.blue),
		1
	)

	if applyLowHigh then
		module.ApplyHighLow(object, v7)
	end

	if applyToChildren then
		local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_8d0b7f88)

		if not __wf_atom_7e8ad928(__wf_atom_f582136d) then
			for i = 1, #__wf_atom_f582136d do
				local v8 = __wf_atom_f582136d[i]
				v8:SetMaterialParam(
					Param,
					module.SRGBToLinear(v7.red),
					module.SRGBToLinear(v7.green),
					module.SRGBToLinear(v7.blue),
					1
				)
				module.ApplyHighLow(v8, v7)
			end
		end
	end
end

function ApplyEnergyColorParticles(object, _)
	if sleepFirst then
		Sleep(0)
	end

	Color()
	local creator

	if passCreatorThrough then
		creator = object:GetCreator()

		if __wf_atom_7e8ad928(creator) then
			creator = object
		end
	else
		creator = object
	end

	local v7

	if isWeaponProjectile then
		v7 = fn2(creator)
	else
		v7 = fn(creator, getParentFirst)
	end

	local v8 = Color()

	if not __wf_atom_7e8ad928(v7) then
		if invertColor then
			v7.red = 255 - v7.red
			v7.green = 255 - v7.green
			v7.blue = 255 - v7.blue
		end

		v7.alpha = 191.25

		if applyLowHigh then
			module.ApplyHighLow(object, v7)
		end

		v8.red = v7.red
		v8.green = v7.green
		v8.blue = v7.blue
		v8.alpha = v7.alpha * minScale

		if isLightningParticle then
			v8.alpha = 0
			v7.alpha /= 0.75
		end

		if swapMinMax then
			object:__wf_atom_8cd234d5(v7, v8)
		else
			object:__wf_atom_8cd234d5(v8, v7)
		end
	end

	if disableParticles then
		Sleep(0)
		object:Disable()
	end
end

function ApplyEnergyColorLensflare(object)
	Sleep(0)
	Color()
	local creator

	if passCreatorThrough then
		creator = object:GetCreator()

		if __wf_atom_7e8ad928(creator) then
			creator = object
		end
	else
		creator = object
	end

	if getRootObjectColor then
		local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

		if not __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
			creator = __wf_atom_f7e7be53
		end
	end

	local v7

	if isWeaponProjectile then
		v7 = fn2(creator)
	else
		v7 = fn(creator, getParentFirst)
	end

	if not __wf_atom_7e8ad928(v7) then
		v7.red *= lensFlareAtten
		v7.green *= lensFlareAtten
		v7.blue *= lensFlareAtten

		if HueClamp then
			local alpha = v7.alpha
			local rgbToHSV, _, _ = module.RGBToHSV(v7)
			local newSaturate = newSaturate
			local newBrightness = newBrightness
			v7 = module.HSVToRGB(rgbToHSV, newSaturate, newBrightness)
			v7.alpha = alpha
		end

		object:__wf_atom_7fff6c98(v7)
	end
end

function ApplyEnergyColorLight(instance)
	Sleep(0)
	Color()
	local creator

	if passCreatorThrough then
		creator = instance:GetCreator()

		if __wf_atom_7e8ad928(creator) then
			creator = instance
		end
	else
		creator = instance
	end

	if destroyIfIllusionAvatar and isAttachedToWeapon then
		local __wf_atom_f7e7be53 = instance:__wf_atom_f7e7be53()

		if not __wf_atom_7e8ad928(__wf_atom_f7e7be53) and __wf_atom_f7e7be53:IsA(__wf_atom_7e9106b6) then
			instance:Destroy()
		end
	end

	local v7

	if isWeaponProjectile then
		v7 = fn2(creator)
	else
		v7 = fn(creator, getParentFirst)
	end

	if not __wf_atom_7e8ad928(v7) then
		if HueClamp then
			local alpha = v7.alpha
			local rgbToHSV, _, _ = module.RGBToHSV(v7)
			local newSaturate = newSaturate
			local newBrightness = newBrightness
			v7 = module.HSVToRGB(rgbToHSV, newSaturate, newBrightness)
			v7.alpha = alpha
		end

		instance:SetColor(v7)
	end
end

function ApplyEnergyColorWeaponTrail(instance)
	Sleep(0)

	while not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) do
		Sleep(0)
	end

	local v7 = 20

	while not instance:__wf_atom_f7e7be53():IsA(__wf_atom_4ebf67cb) and v7 > 0 do
		v7 -= 1
		Sleep(0)
	end

	Color()
	local creator

	if passCreatorThrough then
		creator = instance:GetCreator()

		if __wf_atom_7e8ad928(creator) then
			creator = instance
		end
	else
		creator = instance
	end

	local v8

	if isWeaponProjectile then
		v8 = fn2(creator)
	else
		v8 = fn(creator, getParentFirst)
	end

	if not __wf_atom_7e8ad928(v8) then
		instance:__wf_atom_7fff6c98(v8)

		if applyLowHigh then
			module.ApplyHighLow(instance, v8)
		end
	end

	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_e714d8ac) then
		instance:Destroy()
	end
end

function SetEnergyColor(instance)
	local v7 = nil
	local v8 = nil

	if instance:IsA(__wf_atom_d98e64fe) then
		if not __wf_atom_7e8ad928(instance) then
			v8 = instance:__wf_atom_6009c8ed()
		end

		v7 = instance
	else
		if getParentFirst then
			v8 = instance:__wf_atom_3d96ddcd()
		else
			v8 = instance
		end

		if __wf_atom_7e8ad928(v8) or not v8:IsA(__wf_atom_4ebf67cb) then
			return
		end

		local v9 = 15

		while __wf_atom_7e8ad928(v7) and v9 > 0 do
			v7 = v8:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
			v9 -= 1
			Sleep(0)
		end
	end

	if applyToWeaponsToo then
		local __wf_atom_d2b2176d = v8:__wf_atom_d2b2176d()

		for i = 1, #v6 do
			local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(v6[i])

			if __wf_atom_7e8ad928(__wf_atom_28224c27) then
				continue
			end

			local __wf_atom_eb82ab1f = __wf_atom_28224c27:__wf_atom_eb82ab1f()
			local colors = __wf_atom_eb82ab1f:GetColors(0)
			colors:SetColor(6, newEnergyColor)
			colors:__wf_atom_59cc106e(6, true)
			__wf_atom_eb82ab1f:__wf_atom_2754430f(0, colors)
			__wf_atom_28224c27:SetCustomization(__wf_atom_eb82ab1f)
		end
	end

	if
		useBossBar
		and not (__wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(_T.SetupBossAvatar) or __wf_atom_7e8ad928(gGameRules) or gGameRules:IsA(__wf_atom_311a7128))
	then
		_T.SetupBossAvatar(v8)
	end

	if __wf_atom_7e8ad928(v7) then
		return
	end

	local __wf_atom_eb82ab1f = v7:__wf_atom_eb82ab1f()
	local colors = __wf_atom_eb82ab1f:GetColors(0)
	colors:SetColor(6, newEnergyColor)
	colors:__wf_atom_59cc106e(6, true)
	__wf_atom_eb82ab1f:__wf_atom_2754430f(0, colors)
	v7:SetCustomization(__wf_atom_eb82ab1f)
end