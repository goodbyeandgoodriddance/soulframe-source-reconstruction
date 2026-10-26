local module = require("SF.Scripts.Libs.CommonFunctionsLib")

function TriggerSetup(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.bbFadeTime = emissiveFadeTime
		__wf_atom_e919fb8e.bbColors = {
			tBody_EmissHi_On = Vector(
				bodyActiveEmissiveTintColorHi:__wf_atom_6f94332f(),
				bodyActiveEmissiveTintColorHi:__wf_atom_5cad32b9(),
				bodyActiveEmissiveTintColorHi:__wf_atom_0973634e()
			),
			tArmor_EmissLo_On = Vector(
				armorActiveEmissiveTintColorLo:__wf_atom_6f94332f(),
				armorActiveEmissiveTintColorLo:__wf_atom_5cad32b9(),
				armorActiveEmissiveTintColorLo:__wf_atom_0973634e()
			),
			tArmor_EmissHi_On = Vector(
				armorActiveEmissiveTintColorHi:__wf_atom_6f94332f(),
				armorActiveEmissiveTintColorHi:__wf_atom_5cad32b9(),
				armorActiveEmissiveTintColorHi:__wf_atom_0973634e()
			),
			tBody_EmissHi_Off = Vector(
				bodyInactiveEmissiveTintColorHi:__wf_atom_6f94332f(),
				bodyInactiveEmissiveTintColorHi:__wf_atom_5cad32b9(),
				bodyInactiveEmissiveTintColorHi:__wf_atom_0973634e()
			),
			tArmor_EmissLo_Off = Vector(
				armorInactiveEmissiveTintColorLo:__wf_atom_6f94332f(),
				armorInactiveEmissiveTintColorLo:__wf_atom_5cad32b9(),
				armorInactiveEmissiveTintColorLo:__wf_atom_0973634e()
			),
			tArmor_EmissHi_Off = Vector(
				armorInactiveEmissiveTintColorHi:__wf_atom_6f94332f(),
				armorInactiveEmissiveTintColorHi:__wf_atom_5cad32b9(),
				armorInactiveEmissiveTintColorHi:__wf_atom_0973634e()
			)
		}
		__wf_atom_3d96ddcd:SetMaterialParam(
			Symbol("EmissiveTintColorHi"),
			__wf_atom_e919fb8e.bbColors.tBody_EmissHi_Off.x,
			__wf_atom_e919fb8e.bbColors.tBody_EmissHi_Off.y,
			__wf_atom_e919fb8e.bbColors.tBody_EmissHi_Off.z,
			1,
			false
		)
		local taggedChild = module.FindTaggedChild(__wf_atom_3d96ddcd:__wf_atom_be0bea4a(), Symbol("ArmorDeco"))

		if not __wf_atom_7e8ad928(taggedChild) then
			taggedChild:SetMaterialParam(
				Symbol("EmissiveTintColorLo"),
				__wf_atom_e919fb8e.bbColors.tArmor_EmissLo_Off.x,
				__wf_atom_e919fb8e.bbColors.tArmor_EmissLo_Off.y,
				__wf_atom_e919fb8e.bbColors.tArmor_EmissLo_Off.z,
				1,
				true
			)
			taggedChild:SetMaterialParam(
				Symbol("EmissiveTintColorHi"),
				__wf_atom_e919fb8e.bbColors.tArmor_EmissHi_Off.x,
				__wf_atom_e919fb8e.bbColors.tArmor_EmissHi_Off.y,
				__wf_atom_e919fb8e.bbColors.tArmor_EmissHi_Off.z,
				1,
				true
			)
		end

		__wf_atom_e919fb8e.bbCurFade = 0
		__wf_atom_e919fb8e.bbInitialized = true
	end
end

function EnterTrigger(object, _)
	if __wf_atom_7e8ad928(object:__wf_atom_3d96ddcd()) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
		__wf_atom_e919fb8e.bbTriggerActive = true

		if #object:__wf_atom_6f4fd712() == 1 then
			object:__wf_atom_8a035cd5(Symbol("_LocalEmissiveFadeOn"), false)
		end
	end
end

function ExitTrigger(object, _)
	if __wf_atom_7e8ad928(object:__wf_atom_3d96ddcd()) then
		return
	end

	Sleep(0)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) and #object:__wf_atom_6f4fd712() <= 0 then
		__wf_atom_e919fb8e.bbTriggerActive = false
		object:__wf_atom_8a035cd5(Symbol("_LocalEmissiveFadeOff"), false)
	end
end

local function fn(object, object2, taggedChild, bbCurFade)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local v = __wf_atom_f55d6358(
		__wf_atom_e919fb8e.bbColors.tBody_EmissHi_Off,
		__wf_atom_e919fb8e.bbColors.tBody_EmissHi_On,
		bbCurFade
	)
	object2:SetMaterialParam(Symbol("EmissiveTintColorHi"), v.x, v.y, v.z, 1, false)

	if not __wf_atom_7e8ad928(taggedChild) then
		local v2 = __wf_atom_f55d6358(
			__wf_atom_e919fb8e.bbColors.tArmor_EmissLo_Off,
			__wf_atom_e919fb8e.bbColors.tArmor_EmissLo_On,
			bbCurFade
		)
		local v3 = __wf_atom_f55d6358(
			__wf_atom_e919fb8e.bbColors.tArmor_EmissHi_Off,
			__wf_atom_e919fb8e.bbColors.tArmor_EmissHi_On,
			bbCurFade
		)
		taggedChild:SetMaterialParam(Symbol("EmissiveTintColorLo"), v2.x, v2.y, v2.z, 1, true)
		taggedChild:SetMaterialParam(Symbol("EmissiveTintColorHi"), v3.x, v3.y, v3.z, 1, true)
	end
end

function _LocalEmissiveFadeOn(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbInitialized) then
		while __wf_atom_e919fb8e.bbTriggerActive and __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbInitialized) do
			if not __wf_atom_e919fb8e.bbTriggerActive then
				return
			end

			Sleep(0)
		end
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local taggedChild = module.FindTaggedChild(__wf_atom_3d96ddcd:__wf_atom_be0bea4a(), Symbol("ArmorDeco"))

	while __wf_atom_e919fb8e.bbCurFade < 1 and __wf_atom_e919fb8e.bbTriggerActive == true do
		__wf_atom_e919fb8e.bbCurFade += __wf_atom_084b3e93() / __wf_atom_e919fb8e.bbFadeTime
		fn(object, __wf_atom_3d96ddcd, taggedChild, __wf_atom_e919fb8e.bbCurFade)
		Sleep(0)
	end
end

function _LocalEmissiveFadeOff(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbInitialized) then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local taggedChild = module.FindTaggedChild(__wf_atom_3d96ddcd:__wf_atom_be0bea4a(), Symbol("ArmorDeco"))

	while __wf_atom_e919fb8e.bbCurFade > 0 and __wf_atom_e919fb8e.bbTriggerActive == false do
		__wf_atom_e919fb8e.bbCurFade -= __wf_atom_084b3e93() / __wf_atom_e919fb8e.bbFadeTime
		fn(object, __wf_atom_3d96ddcd, taggedChild, __wf_atom_e919fb8e.bbCurFade)
		Sleep(0)
	end
end