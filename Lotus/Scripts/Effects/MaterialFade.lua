local module = require("Lotus.Scripts.Effects.EffectsColorUtilities")

local function fn(object, energyColorParam, getParentFirst)
	local creator

	if getParentFirst then
		creator = object:__wf_atom_f7e7be53()
	else
		creator = object:GetCreator()
	end

	if __wf_atom_7e8ad928(creator) then
		return
	end

	local v = WeakResource("/Lotus/Types/Enemies/TennoReplicants/TennoReplicantAvatar")

	if creator:IsA(v) then
		object:SetMaterialParam(energyColorParam, 1 / 51, 145 / 255, 175 / 255, alphaMult * 1)
		return
	end

	local creator2

	if creator:IsA(__wf_atom_7e6ed5fa) then
		creator2 = creator
	else
		if creator:IsA(__wf_atom_d98e64fe) then
			creator2 = creator
		else
			creator2 = creator:GetCreator()
		end

		if isWeapon then
			if not creator2:IsA((WeakResource("/SF/Types/Game/SFWeapon"))) then
				return nil
			end
		elseif __wf_atom_7e8ad928(creator2) or not creator2:IsA(__wf_atom_d98e64fe) then
			if __wf_atom_7e8ad928(creator2) then
				creator2 = creator:__wf_atom_f7e7be53()
			else
				creator2 = creator2:__wf_atom_f7e7be53()
			end
		else
			creator2 = creator2:__wf_atom_95e72410()
		end

		if creator2:IsA(v) then
			object:SetMaterialParam(energyColorParam, 1 / 51, 145 / 255, 175 / 255, alphaMult * 1)

			if applyLowHigh then
				module.ApplyHighLow(object, Color(5, 145, 175, alphaMult * 1))
			end

			return
		end
	end

	if not (creator2:IsA(__wf_atom_7e6ed5fa) or isWeapon) then
		return nil
	end

	if not __wf_atom_7e8ad928(creator2) then
		local v2

		if isWeapon then
			v2 = creator2
		elseif isArchwing then
			v2 = creator2:__wf_atom_d2b2176d():__wf_atom_f7583f71()
		else
			v2 = creator2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		end

		if isMeleeWeapon then
			v2 = creator2:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
		end

		if scaleForExplosionMod and creator2:IsA(__wf_atom_9df43583) then
			local __wf_atom_c082fc3d = object:__wf_atom_c082fc3d()
			object:SetMeshScale((creator2:__wf_atom_95e72410():__wf_atom_d2b2176d():__wf_atom_2a745663(
				__wf_atom_c082fc3d,
				312,
				creator2:__wf_atom_1bb5b1ff(),
				creator2
			)))
		end

		if not __wf_atom_7e8ad928(v2) then
			local colors = v2:__wf_atom_eb82ab1f():GetColors(0)

			if colors:Initialized(6) then
				local mEnergyColor = colors.mEnergyColor
				object:SetMaterialParam(
					energyColorParam,
					module.SRGBToLinear(mEnergyColor.red),
					module.SRGBToLinear(mEnergyColor.green),
					module.SRGBToLinear(mEnergyColor.blue),
					alphaMult * mEnergyColor.alpha / 255
				)

				if applyLowHigh then
					module.ApplyHighLow(object, mEnergyColor)
				end
			end
		end
	end
end

function MaterialFade(instance)
	if Delay >= 0 then
		Sleep(Delay)
	end

	if applyToParent then
		local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			instance = __wf_atom_3d96ddcd
		end
	elseif not __wf_atom_7e8ad928(childType) then
		instance = instance:__wf_atom_bb3e7833(childType)

		if __wf_atom_7e8ad928(instance) then
			return
		end
	end

	if applyEnergyColor then
		fn(instance, energyColorParam, getParentFirst)
	end

	local total = 0
	local v = 1

	if getCastingSpeed == true then
		local creator

		if gcsGetCreator then
			creator = instance:GetCreator()
		else
			creator = instance:__wf_atom_f7e7be53()
		end

		if not __wf_atom_7e8ad928(creator) then
			local __wf_atom_e55d02aa = creator:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
			v = creator:__wf_atom_d2b2176d():__wf_atom_2a745663(
				1,
				31,
				__wf_atom_e55d02aa:__wf_atom_1bb5b1ff(),
				__wf_atom_e55d02aa
			)
		end
	end

	if showAtStart then
		instance:SetVisibility(true)
	end

	while total < TimeLength do
		local v2 = __wf_atom_104bfe98(OriginalValue, NewValue, total / TimeLength)
		instance:SetMaterialParam(Param, v2, 0, 0, 0, applyToChildren)
		total += __wf_atom_084b3e93() * v
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:SetMaterialParam(Param, NewValue, 0, 0, 0, applyToChildren)

		if destroyAtEnd then
			instance:Destroy()
		elseif hideAtEnd then
			instance:SetVisibility(false)
		end
	end
end

function MaterialFadeMeshScale(instance)
	if Delay >= 0 then
		Sleep(Delay)
	end

	if applyEnergyColor then
		fn(instance, energyColorParam, getParentFirst)
	end

	local total = 0

	while total < TimeLength do
		local v = __wf_atom_104bfe98(OriginalValue, NewValue, total / TimeLength)
		instance:SetMaterialParam(Param, v)
		instance:SetMeshScale((__wf_atom_104bfe98(OriginalScale, NewScale, total / TimeLength)))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function MaterialFadePeak(instance)
	if Delay >= 0 then
		Sleep(Delay)
	end

	if applyEnergyColor then
		fn(instance, energyColorParam, getParentFirst)
	end

	if showAtStart then
		instance:SetVisibility(true)
	end

	local total = 0

	while total < TimeLength do
		local v

		if total < Peak then
			v = total / Peak
		else
			v = 1 - (total - Peak) / (TimeLength - Peak)
		end

		local v2 = v < 0 and 0 or v
		local v3 = __wf_atom_104bfe98(ValleyValue, PeakValue, v2)
		instance:SetMaterialParam(Param, v3)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	elseif hideAtEnd then
		instance:SetVisibility(false)
	end
end

function MaterialFadeFlatPeak(instance)
	if Delay >= 0 then
		Sleep(Delay)
	end

	if applyToParent then
		local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			instance = __wf_atom_3d96ddcd
		end
	end

	if applyEnergyColor then
		fn(instance, energyColorParam, getParentFirst)
	end

	local total = 0
	local valleyValue = ValleyValue

	if checkInstigator == true then
		local creator = instance:GetCreator()
		local v, v2

		if __wf_atom_7e8ad928(creator) then
			v = 1
		else
			v2 = creator:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
			v = __wf_atom_421b01aa(v2:__wf_atom_cc3c265a(instigatorPower), 1, #instigatorDuration)
		end

		local v3 = TimeLength - PeakEnd
		TimeLength = creator:__wf_atom_d2b2176d():__wf_atom_2a745663(
			instigatorDuration[v],
			3,
			v2:__wf_atom_1bb5b1ff(),
			v2
		)
		PeakEnd = TimeLength - v3
	end

	while total < TimeLength do
		local v

		if total < Peak then
			v = total / Peak
		elseif total < PeakEnd then
			v = 1
		else
			valleyValue = ValleyEndValue
			v = 1 - (total - PeakEnd) / (TimeLength - PeakEnd)
		end

		local v2 = v < 0 and 0 or v
		local v3 = __wf_atom_104bfe98(valleyValue, PeakValue, v2)
		instance:SetMaterialParam(Param, v3)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function MaterialFadeTargetted()
	if Delay >= 0 then
		Sleep(Delay)
	end

	if showAtStart and not __wf_atom_7e8ad928(TargetDeco) then
		for i = 1, #TargetDeco do
			TargetDeco[i]:SetVisibility(true)
		end
	end

	local total = 0

	while total < TimeLength do
		local v = __wf_atom_104bfe98(OriginalValue, NewValue, total / TimeLength)

		if not __wf_atom_7e8ad928(TargetDeco) then
			for i = 1, #TargetDeco do
				local v2 = TargetDeco[i]
				v2:SetMaterialParam(Param, v)

				if not applyToChildren then
					continue
				end

				local __wf_atom_f582136d = v2:__wf_atom_f582136d(__wf_atom_8d0b7f88)

				for j = 1, #__wf_atom_f582136d do
					local v3 = __wf_atom_f582136d[j]

					if not __wf_atom_7e8ad928(v3) then
						v3:SetMaterialParam(Param, v)
					end
				end
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(TargetDeco) then
		for i = 1, #TargetDeco do
			TargetDeco[i]:Destroy()
		end
	elseif hideAtEnd and not __wf_atom_7e8ad928(TargetDeco) then
		for i = 1, #TargetDeco do
			TargetDeco[i]:SetVisibility(false)
		end
	end
end

function MaterialFadePeakTargetted()
	if Delay >= 0 then
		Sleep(Delay)
	end

	if showAtStart and not __wf_atom_7e8ad928(TargetDeco) then
		for i = 1, #TargetDeco do
			TargetDeco[i]:SetVisibility(true)
		end
	end

	local total = 0

	while total < TimeLength do
		local v

		if total < Peak then
			v = total / Peak
		else
			v = 1 - (total - Peak) / (TimeLength - Peak)
		end

		local v2 = v < 0 and 0 or v
		local v3 = __wf_atom_104bfe98(ValleyValue, PeakValue, v2)

		if not __wf_atom_7e8ad928(TargetDeco) then
			for i = 1, #TargetDeco do
				TargetDeco[i]:SetMaterialParam(Param, v3)
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(TargetDeco) then
		for i = 1, #TargetDeco do
			TargetDeco[i]:Destroy()
		end
	end

	if hideAtEnd and not __wf_atom_7e8ad928(TargetDeco) then
		for i = 1, #TargetDeco do
			TargetDeco[i]:SetVisibility(false)
		end
	end
end

function DissolveFadeTargetted()
	if Delay >= 0 then
		Sleep(Delay)
	end

	local total = 0

	while total < TimeLength do
		local v = __wf_atom_104bfe98(OriginalValue, NewValue, total / TimeLength)

		if not __wf_atom_7e8ad928(TargetDeco) then
			for i = 1, #TargetDeco do
				if not __wf_atom_7e8ad928(TargetDeco[i]) then
					TargetDeco[i]:__wf_atom_a763aa1a(v)
				end
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

function DissolveFade(instance)
	if checkKilled and instance:IsA(__wf_atom_43e0c427) then
		local __wf_atom_6009c8ed = instance:__wf_atom_6009c8ed()

		while not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:IsKilled()) do
			Sleep(0)
		end

		if __wf_atom_7e8ad928(instance) then
			return
		end
	end

	if Delay >= 0 then
		Sleep(Delay)
	end

	if applyEnergyColor then
		fn(instance, energyColorParam, getParentFirst)
	end

	if showAtStart then
		instance:SetVisibility(true)
	end

	local total = 0

	while total < TimeLength do
		instance:__wf_atom_a763aa1a((__wf_atom_104bfe98(OriginalValue, NewValue, total / TimeLength)))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:__wf_atom_a763aa1a(NewValue)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	elseif hideAtEnd and not __wf_atom_7e8ad928(instance) then
		instance:SetVisibility(false)
	end
end

function DissolveFadeMeshScale(instance)
	if isRandomMeshScale then
		instance:SetMeshScale(Random(OriginalScale, NewScale))
	end

	if Delay >= 0 then
		Sleep(Delay)
	end

	if applyEnergyColor then
		fn(instance, energyColorParam, getParentFirst)
	end

	local total = 0

	while total < TimeLength do
		instance:__wf_atom_a763aa1a((__wf_atom_104bfe98(OriginalValue, NewValue, total / TimeLength)))

		if not isRandomMeshScale then
			instance:SetMeshScale((__wf_atom_104bfe98(OriginalScale, NewScale, total / TimeLength)))
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function SetValueTargetted()
	if Delay >= 0 then
		Sleep(Delay)
	end

	for i = 1, #TargetDeco do
		TargetDeco[i]:__wf_atom_fd3ec680(Param, materialSlot, NewValue, 0, 0, 0)
	end
end

function SetDissolveTargetted()
	if Delay >= 0 then
		Sleep(Delay)
	end

	for i = 1, #TargetDeco do
		TargetDeco[i]:__wf_atom_a763aa1a(NewValue)
	end
end

function DissolveFadeParent(object)
	if Delay >= 0 then
		Sleep(Delay)
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		local total = 0

		while total < TimeLength do
			local v = __wf_atom_104bfe98(OriginalValue, NewValue, total / TimeLength)

			if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				if ditherDissolve then
					__wf_atom_3d96ddcd:__wf_atom_68f2c268(v)
				else
					__wf_atom_3d96ddcd:__wf_atom_a763aa1a(v)
				end
			end

			total += __wf_atom_084b3e93()
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			if ditherDissolve then
				__wf_atom_3d96ddcd:__wf_atom_68f2c268(NewValue)
			else
				__wf_atom_3d96ddcd:__wf_atom_a763aa1a(NewValue)
			end
		end
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:Destroy()
	end
end

function MaterialFadeTwoParams(instance)
	instance:SetMaterialParam(Param, OriginalValue)
	instance:SetMaterialParam(ParamTwo, OriginalValueTwo)

	if applyEnergyColor then
		fn(instance, energyColorParam, getParentFirst)
	end

	if Delay >= 0 then
		Sleep(Delay)
	end

	local v = 1

	if getCastingSpeed == true then
		local creator

		if gcsGetCreator then
			creator = instance:GetCreator()
		else
			creator = instance:__wf_atom_f7e7be53()
		end

		if not __wf_atom_7e8ad928(creator) then
			local __wf_atom_e55d02aa = creator:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
			v = creator:__wf_atom_d2b2176d():__wf_atom_2a745663(
				1,
				31,
				__wf_atom_e55d02aa:__wf_atom_1bb5b1ff(),
				__wf_atom_e55d02aa
			)
		end
	end

	local total = 0

	while total < TimeLength do
		local v2 = total / TimeLength

		if powScale then
			if invertPowScale then
				v2 = 1 - math.pow(1 - v2, powerAmount)
			else
				v2 = math.pow(v2, powerAmount)
			end
		end

		local v3 = __wf_atom_104bfe98(OriginalValue, NewValue, v2)
		local v4 = __wf_atom_104bfe98(OriginalValueTwo, NewValueTwo, v2)
		instance:SetMaterialParam(Param, v3)
		instance:SetMaterialParam(ParamTwo, v4)
		total += __wf_atom_084b3e93() * v
		Sleep(0)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function DissolveFadeFlatPeak(instance)
	if Delay >= 0 then
		Sleep(Delay)
	end

	local valleyValue = ValleyValue
	local total = 0

	while total < TimeLength do
		local v

		if total < Peak then
			v = total / Peak
		elseif total < PeakEnd then
			v = 1
		else
			valleyValue = ValleyEndValue
			v = 1 - (total - PeakEnd) / (TimeLength - PeakEnd)
		end

		local v2 = v < 0 and 0 or v
		instance:__wf_atom_a763aa1a((__wf_atom_104bfe98(valleyValue, PeakValue, v2)))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function DissolveFadeFlatPeakMeshScale(instance)
	if Delay >= 0 then
		Sleep(Delay)
	end

	local valleyValue = ValleyValue
	local meshScaleValley = meshScaleValley
	local total = 0

	while total < TimeLength do
		local v

		if total < Peak then
			v = total / Peak
		elseif total < PeakEnd then
			v = 1
		else
			valleyValue = ValleyEndValue
			v = 1 - (total - PeakEnd) / (TimeLength - PeakEnd)
		end

		local v2 = v < 0 and 0 or v
		instance:__wf_atom_a763aa1a((__wf_atom_104bfe98(valleyValue, PeakValue, v2)))
		instance:SetMeshScale((__wf_atom_104bfe98(meshScaleValley, meshScalePeak, v2)))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function DissolveFadeFlatPeakRandomMeshScale(instance)
	if Delay >= 0 then
		Sleep(Delay)
	end

	local total = 0
	local valleyValue = ValleyValue

	if applyEnergyColor then
		fn(instance, energyColorParam, getParentFirst)
	end

	instance:SetMeshScale(Random(meshScaleValley, meshScalePeak))

	while total < TimeLength do
		local v

		if total < Peak then
			v = total / Peak
		elseif total < PeakEnd then
			v = 1
		else
			valleyValue = ValleyEndValue
			v = 1 - (total - PeakEnd) / (TimeLength - PeakEnd)
		end

		local v2 = v < 0 and 0 or v
		instance:__wf_atom_a763aa1a((__wf_atom_104bfe98(valleyValue, PeakValue, v2)))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function MaterialFadeWithAttractorParent(object)
	if Delay >= 0 then
		Sleep(Delay)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if applyEnergyColor then
		fn(object, energyColorParam, getParentFirst)
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		Sleep(__wf_atom_3d96ddcd:__wf_atom_0e78dc57() - Delay - 1)
	end

	local total = 0

	while total < TimeLength do
		if __wf_atom_7e8ad928(object) then
			break
		end

		local v = __wf_atom_104bfe98(OriginalValue, NewValue, total / TimeLength)
		object:SetMaterialParam(Param, v)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

function MaterialCurveFadePeakTargetted()
	if Delay >= 0 then
		Sleep(Delay)
	end

	if showAtStart and not __wf_atom_7e8ad928(TargetDeco) then
		for i = 1, #TargetDeco do
			TargetDeco[i]:SetVisibility(true)
		end
	end

	local total = 0

	while total < TimeLength do
		local v

		if total < Peak then
			v = total / Peak
		else
			v = 1 - (total - Peak) / (TimeLength - Peak)
		end

		local v2 = v < 0 and 0 or v
		local v3 = __wf_atom_104bfe98(ValleyValue, PeakValue, v2)

		if not __wf_atom_7e8ad928(TargetDeco) then
			for i = 1, #TargetDeco do
				TargetDeco[i]:SetMaterialParam(Param, v3)
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if destroyAtEnd and not __wf_atom_7e8ad928(TargetDeco) then
		for i = 1, #TargetDeco do
			TargetDeco[i]:Destroy()
		end
	end

	if hideAtEnd and not __wf_atom_7e8ad928(TargetDeco) then
		for i = 1, #TargetDeco do
			TargetDeco[i]:SetVisibility(false)
		end
	end
end