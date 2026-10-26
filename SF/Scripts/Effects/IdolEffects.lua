local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")

function OdeIdolSpawn(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_575542c8:__wf_atom_bb3e7833(odeOrbType)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833 = __wf_atom_575542c8:Attach(
			odeOrbType,
			Symbol("GAME_R1_WEAPON1"),
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			__wf_atom_575542c8
		)
	end

	return __wf_atom_bb3e7833
end

function OdeIdolDestroy(instance, p, p2)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	if not instance:IsA(__wf_atom_67c46eba) then
		instance = instance:__wf_atom_575542c8()
	end

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local v

	if __wf_atom_7e8ad928(odeOrbType) then
		v = instance:__wf_atom_bb3e7833(p)
	else
		v = instance:__wf_atom_bb3e7833(odeOrbType)
	end

	if not __wf_atom_7e8ad928(v) then
		if p2 then
			local position = v:GetPosition()
			local __wf_atom_dc309f8a = v:__wf_atom_dc309f8a()
			gRegion:CreateEntity(
				Type("/SF/Fx/Equipment/Idols/TempestCannon/CannonOrbDestroyFX"),
				position,
				__wf_atom_dc309f8a
			)
		end

		v:Destroy()
	end
end

function OdeIdolAttachmentUpdate(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_e55d02aa = __wf_atom_3d96ddcd:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local v = nil
	local v2 = nil

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			v2 = __wf_atom_e55d02aa:__wf_atom_47fbd15c()
		end

		if module2.IsSoulModeActive(__wf_atom_3d96ddcd) then
			if not __wf_atom_3d96ddcd:__wf_atom_47fbd15c() then
				v = OdeIdolSpawn(__wf_atom_3d96ddcd)
			end
		elseif not (__wf_atom_7e8ad928(v) or v2) then
			OdeIdolDestroy(__wf_atom_3d96ddcd, true)
		end

		Sleep(0)
	end
end

function OdeIdolUpdate(object)
	Sleep(0)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if
		__wf_atom_7e8ad928(__wf_atom_575542c8)
		or __wf_atom_575542c8:IsKilled()
		or not __wf_atom_575542c8:IsA(__wf_atom_67c46eba)
	then
		return
	end

	local __wf_atom_28224c27 = __wf_atom_575542c8:__wf_atom_d2b2176d():__wf_atom_28224c27(0)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(odeTriOrbType)
	local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(odeEnergyType)
	local v = Rotation(0, 0, 0)
	local v2 = 0
	local total = 0
	local total2 = 0

	while not __wf_atom_7e8ad928(__wf_atom_28224c27) do
		if __wf_atom_28224c27:__wf_atom_ead6242d() then
			v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() * 0.5, 0, 1)
		else
			v2 = __wf_atom_421b01aa(v2 - __wf_atom_084b3e93() * 1, 0, 1)
		end

		total += __wf_atom_104bfe98(0, 5, v2) * __wf_atom_084b3e93()
		total2 += __wf_atom_104bfe98(4, 45, v2) * __wf_atom_084b3e93()
		local v3 = math.pow((math.sin(total2) + 1) * 0.5, v2 * 3 + 1)

		if not __wf_atom_7e8ad928(object) then
			object:SetMaterialParam(Symbol("EmissiveMapAtten"), v3 * (v2 + 0.25) * 25 + 0.025)
		end

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			local v4 = __wf_atom_104bfe98(60, 1600, v2) * __wf_atom_084b3e93()
			v += Rotation(30 * __wf_atom_084b3e93(), v4, 50 * __wf_atom_084b3e93())
			__wf_atom_bb3e7833:__wf_atom_e310f01f(Vector(0, 0, 0), v)
		end

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
			__wf_atom_bb3e7833_2:SetMaterialParam(Symbol("CustomTime"), total)
			__wf_atom_bb3e7833_2:SetMaterialParam(Symbol("UnlitAtten"), v2 * 10 + 2)
		end

		Sleep(0)
	end
end

function AvatarIdolUpdate(object)
	Sleep(0)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	local __wf_atom_e55d02aa = __wf_atom_575542c8:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	__wf_atom_575542c8:__wf_atom_bb3e7833(avatarFxType)
	local _avatarFxType = avatarFxType
	local v = nil
	local v2 = 0

	while not (__wf_atom_7e8ad928(__wf_atom_e55d02aa) or __wf_atom_7e8ad928(__wf_atom_575542c8)) do
		local v3 = __wf_atom_e55d02aa:__wf_atom_f3044fe0() / __wf_atom_e55d02aa:__wf_atom_6a5c92a7()
		local __wf_atom_e8008ec5 = __wf_atom_e55d02aa:__wf_atom_e8008ec5((__wf_atom_e55d02aa:__wf_atom_70e2e019()))
		local stealAbility = module.GetStealAbility(__wf_atom_575542c8)
		local __wf_atom_bb3e7833 = __wf_atom_575542c8:__wf_atom_bb3e7833(avatarFxType)

		if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833 = __wf_atom_575542c8:__wf_atom_bb3e7833(stolenChargeFxType)
		end

		local avatarFxType2

		if __wf_atom_7e8ad928(stealAbility) then
			avatarFxType2 = avatarFxType

			if
				not __wf_atom_7e8ad928(__wf_atom_bb3e7833)
				and stolenChargeFxType ~= avatarFxType
				and __wf_atom_bb3e7833:IsA(stolenChargeFxType)
			then
				__wf_atom_bb3e7833:Destroy()

				if v3 >= 1 then
					__wf_atom_bb3e7833 = __wf_atom_575542c8:Attach(
						avatarFxType2,
						EMPTY_SYMBOL,
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1
					)
				end
			end
		else
			avatarFxType2 = stolenChargeFxType

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:IsA(avatarFxType) then
				__wf_atom_bb3e7833:Destroy()

				if v3 >= 1 then
					__wf_atom_bb3e7833 = __wf_atom_575542c8:Attach(
						avatarFxType2,
						EMPTY_SYMBOL,
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1
					)
				end
			end
		end

		if (v3 ~= v or __wf_atom_e8008ec5 ~= v2) and v3 >= 1 and __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833 = __wf_atom_575542c8:Attach(
				avatarFxType2,
				EMPTY_SYMBOL,
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1
			)
		end

		if v3 <= 0 and not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end

		Sleep(0.02)
		v2 = __wf_atom_e8008ec5
		v = v3
	end
end

function FeyVirtueSwapAvatar(object)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local __wf_atom_3ab6968c = __wf_atom_e55d02aa:__wf_atom_3ab6968c()
	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()
	local v = {}

	for i = 1, #__wf_atom_be0bea4a do
		for j = 1, #typesToTint do
			if __wf_atom_be0bea4a[i]:IsA(typesToTint[j]) then
				table.insert(v, __wf_atom_be0bea4a[i])
			end
		end
	end

	Vector(0, 0, 0)
	local courageColors2

	if __wf_atom_3ab6968c == 1 then
		courageColors2 = courageColors
	elseif __wf_atom_3ab6968c == 2 then
		courageColors2 = spiritColors
	elseif __wf_atom_3ab6968c == 3 then
		courageColors2 = graceColors
	else
		courageColors2 = baseColors
	end

	for i = 1, #colorNames do
		local v2 = Vector(
			courageColors2[i]:__wf_atom_6f94332f(),
			courageColors2[i]:__wf_atom_5cad32b9(),
			courageColors2[i]:__wf_atom_0973634e()
		)

		for j = 1, #v do
			v[j]:SetMaterialParam(colorNames[i], v2.x, v2.y, v2.z, 255)
		end
	end
end

function SpellJuice(_)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local postProcess = __wf_atom_8ad59546.postProcess
	local postProcessBias = __wf_atom_8ad59546.postProcessBias
	local v = 0

	while v < 1 do
		if __wf_atom_7e8ad928(postProcessBias) then
			return
		end

		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() * 2, 0, 1)
		local spellFX = __wf_atom_24a82b69(v)
		_T.SpellFX = spellFX
		postProcessBias.bloom = spellFX * 1
		postProcess:__wf_atom_54a04966(spellFX * 3)
		postProcess:__wf_atom_f846a58a(spellFX * 1)
		postProcess:__wf_atom_2bd5152a(1, 1, 1, 1 + spellFX * 2)
		Sleep(0)
	end

	Sleep(0.4)
	local v2 = 0

	while v2 < 1 do
		if __wf_atom_7e8ad928(postProcessBias) then
			break
		end

		v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() * 2, 0, 1)
		local v3 = __wf_atom_24a82b69(1 - v2)
		_T.SpellFX = __wf_atom_24a82b69(v3)
		postProcessBias.bloom = v3 * 1
		postProcess:__wf_atom_54a04966(v3 * 3)
		postProcess:__wf_atom_f846a58a(v3 * 1)
		postProcess:__wf_atom_2bd5152a(1, 1, 1, 1 + v3 * 2)
		Sleep(0)
	end
end

function FeyVirtueSwap(instance, p, p2, p3)
	local v

	if instance:IsA(__wf_atom_67c46eba) then
		v = instance
	end

	if __wf_atom_7e8ad928(v) and instance:IsA(__wf_atom_56348098) then
		v = instance:__wf_atom_575542c8()
	end

	if __wf_atom_7e8ad928(v) then
		return
	end

	if not p3 and v:__wf_atom_8efce136() then
		local getfenv = getfenv(2)
		getfenv.SpellJuice = SpellJuice
		instance:__wf_atom_8a035cd5(Symbol("SpellJuice"), false)
	end

	local v2

	if instance:IsA(__wf_atom_56348098) then
		v2 = instance
	end

	if __wf_atom_7e8ad928(v2) and instance:IsA(__wf_atom_67c46eba) then
		local __wf_atom_28224c27 = v:__wf_atom_d2b2176d():__wf_atom_28224c27(0)

		if __wf_atom_7e8ad928(__wf_atom_28224c27) then
			return
		end

		v2 = __wf_atom_28224c27:__wf_atom_66088189(1, 1)

		if __wf_atom_7e8ad928(v2) then
			v2 = __wf_atom_28224c27:__wf_atom_66088189(1, 0)
		end
	end

	if __wf_atom_7e8ad928(v2) then
		return
	end

	local v3 = not __wf_atom_7e8ad928(string.find(v2:GetName(), "Bow"))

	if not __wf_atom_7e8ad928(string.find(v2:GetName(), "Arrow")) then
		v3 = false
	end

	local v4 = not __wf_atom_7e8ad928(string.find(v2:GetName(), "Ward"))
	local __wf_atom_e55d02aa = v:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local v5 = __wf_atom_7e8ad928(__wf_atom_e55d02aa) and 0 or __wf_atom_e55d02aa:__wf_atom_437fa2aa()
	local v6 = overrideAbilityIndex and 4 or v5

	if not __wf_atom_7e8ad928(p2) and p2 ~= 1 then
		v6 = p2
	end

	local transitionTime = transitionTime

	if not __wf_atom_7e8ad928(p) then
		transitionTime = p
	end

	local v7 = Color(255, 194, 123, 255)
	local v8 = Color(255, 194, 123, 255)
	local v9 = Color(255, 194, 123, 255)
	local v10 = Color(255, 194, 123, 255)

	if v6 == 1 then
		v7 = Color(255, 120, 60, 255)
		v8 = Color(184, 184, 184, 255)
		v9 = Color(115, 4, 4, 255)
		v10 = Color(255, 255, 255, 255)
	end

	if v6 == 2 then
		v7 = Color(180, 255, 140, 255)
		v8 = Color(90, 80, 70, 255)
		v9 = Color(100, 120, 90, 255)
		v10 = Color(153, 153, 153, 255)
	end

	if v6 == 3 then
		v7 = Color(160, 210, 255, 255)
		v8 = Color(110, 120, 130, 255)
		v9 = Color(80, 110, 160, 255)
		v10 = Color(20, 100, 255, 255)
	end

	if v6 == 4 then
		v7 = Color(255, 200, 135, 255)
		v8 = Color(51, 41, 28, 255)
		v9 = Color(61, 102, 87, 255)
		v10 = Color(180, 160, 140, 255)
	end

	local __wf_atom_21ed1a39 = v2:__wf_atom_21ed1a39()
	local v11 = {}

	while #v11 < 2 and not __wf_atom_7e8ad928(v2) do
		v11 = v2:__wf_atom_be0bea4a()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) or __wf_atom_7e8ad928(v2) then
		return
	end

	local v12 = {}

	for i = 1, #v11 do
		if __wf_atom_7e8ad928(v11[i]) or not v11[i]:IsA(__wf_atom_3ae8d73b) then
			continue
		end

		table.insert(v12, v11[i])
	end

	local v13 = nil

	if v3 then
		if v6 == 1 then
			for _, v14 in ipairs(v12) do
				if v14:IsA(Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowFlowersDeco")) then
					v14:Destroy()
				end

				if v14:IsA(Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowThornsDeco")) then
					v14:Destroy()
				end
			end

			if __wf_atom_7e8ad928(v13) then
				v13 = v2:Attach(
					Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowThornsDeco"),
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa
				)
				table.insert(v12, v13)
			end
		elseif v6 == 2 then
			for _, v14 in ipairs(v12) do
				if v14:IsA(Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowThornsDeco")) then
					v14:Destroy()
				end

				if v14:IsA(Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowFlowersDeco")) then
					v14:Destroy()
				end
			end

			if __wf_atom_7e8ad928(v13) then
				v13 = v2:Attach(
					Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowFlowersDeco"),
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa
				)
				table.insert(v12, v13)
			end
		else
			for _, v14 in ipairs(v12) do
				if not (v14:IsA(Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowFlowersDeco")) or v14:IsA(Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowThornsDeco"))) then
					continue
				end

				v14:Destroy()
			end
		end
	elseif v4 then
		if v6 == 1 then
			for _, v14 in ipairs(v12) do
				if v14:IsA(Type("/SF/Fx/Equipment/Pacts/Ward/WardCasterStaffFlowersDeco")) then
					v14:Destroy()
				end

				if v14:IsA(Type("/SF/Fx/Equipment/Pacts/Ward/WardCasterStaffThornsDeco")) then
					v14:Destroy()
				end
			end

			if __wf_atom_7e8ad928(v13) then
				v13 = v2:Attach(
					Type("/SF/Fx/Equipment/Pacts/Ward/WardCasterStaffThornsDeco"),
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa
				)
				table.insert(v12, v13)
			end
		elseif v6 == 2 then
			for _, v14 in ipairs(v12) do
				if v14:IsA(Type("/SF/Fx/Equipment/Pacts/Ward/WardCasterStaffThornsDeco")) then
					v14:Destroy()
				end

				if v14:IsA(Type("/SF/Fx/Equipment/Pacts/Ward/WardCasterStaffFlowersDeco")) then
					v13 = v14
				end
			end

			if __wf_atom_7e8ad928(v13) then
				v13 = v2:Attach(
					Type("/SF/Fx/Equipment/Pacts/Ward/WardCasterStaffFlowersDeco"),
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa
				)
				table.insert(v12, v13)
			end
		else
			for _, v14 in ipairs(v12) do
				if not (v14:IsA(Type("/SF/Fx/Equipment/Pacts/Ward/WardCasterStaffFlowersDeco")) or v14:IsA(Type("/SF/Fx/Equipment/Pacts/Ward/WardCasterStaffThornsDeco"))) then
					continue
				end

				v14:PlayTriggeredFade()
			end
		end
	end

	local v14 = Vector(0, 0, 0)

	if v2:__wf_atom_99150eda(Symbol("TintColor")) then
		v14.x = v2:__wf_atom_06adb5a9(Symbol("TintColor"), 1)
		v14.y = v2:__wf_atom_06adb5a9(Symbol("TintColor"), 2)
		v14.z = v2:__wf_atom_06adb5a9(Symbol("TintColor"), 3)
	end

	local v15 = Vector(0, 0, 0)
	local v16 = Vector(0, 0, 0)
	local v17 = Vector(0, 0, 0)
	local v18 = Vector(0, 0, 0)

	if v2:__wf_atom_99150eda(Symbol("LowColor")) then
		v17.x = v2:__wf_atom_06adb5a9(Symbol("LowColor"), 1)
		v17.y = v2:__wf_atom_06adb5a9(Symbol("LowColor"), 2)
		v17.z = v2:__wf_atom_06adb5a9(Symbol("LowColor"), 3)
	else
		v17.x = v7:__wf_atom_6f94332f()
		v17.y = v7:__wf_atom_5cad32b9()
		v17.z = v7:__wf_atom_0973634e()
	end

	if v2:__wf_atom_99150eda(Symbol("HighColor")) then
		v18.x = v2:__wf_atom_06adb5a9(Symbol("HighColor"), 1)
		v18.y = v2:__wf_atom_06adb5a9(Symbol("HighColor"), 2)
		v18.z = v2:__wf_atom_06adb5a9(Symbol("HighColor"), 3)
	else
		v18.x = v7:__wf_atom_6f94332f()
		v18.y = v7:__wf_atom_5cad32b9()
		v18.z = v7:__wf_atom_0973634e()
	end

	local v19 = Vector(v7:__wf_atom_6f94332f(), v7:__wf_atom_5cad32b9(), v7:__wf_atom_0973634e())
	local v20 = Vector(v8:__wf_atom_6f94332f(), v8:__wf_atom_5cad32b9(), v8:__wf_atom_0973634e())
	local v21 = Vector(v9:__wf_atom_6f94332f(), v9:__wf_atom_5cad32b9(), v9:__wf_atom_0973634e())
	local v22 = Vector(v10:__wf_atom_6f94332f(), v10:__wf_atom_5cad32b9(), v10:__wf_atom_0973634e())

	if transitionTime > 0 then
		local v23 = 0

		while v23 < 1 do
			if not __wf_atom_7e8ad928(v13) then
				v13:__wf_atom_8f04e01e(v23)
			end

			local v24 = __wf_atom_f55d6358(v14, v19, v23)
			__wf_atom_f55d6358(v15, v20, v23)
			__wf_atom_f55d6358(v16, v19, v23)
			__wf_atom_f55d6358(v17, v21, v23)
			__wf_atom_f55d6358(v18, v22, v23)

			for i = 1, #v12 do
				if __wf_atom_7e8ad928(v12[i]) then
					continue
				end

				v12[i]:SetMaterialParam(Symbol("TintColor"), v24.x, v24.y, v24.z, 1)
				v12[i]:SetMaterialParam(Symbol("LowColor"), v19.x, v19.y, v19.z, 1)
				v12[i]:SetMaterialParam(Symbol("HighColor"), v19.x, v19.y, v19.z, 1)
			end

			v23 = __wf_atom_421b01aa(v23 + __wf_atom_084b3e93() / transitionTime, 0, 1)
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(nil) then
			(nil):Destroy()
		end

		for i = 1, #v12 do
			if __wf_atom_7e8ad928(v12[i]) then
				continue
			end

			v12[i]:SetMaterialParam(Symbol("TintColor"), v19.x, v19.y, v19.z, 1)
			v12[i]:SetMaterialParam(Symbol("LowColor"), v19.x, v19.y, v19.z, 1)
			v12[i]:SetMaterialParam(Symbol("HighColor"), v19.x, v19.y, v19.z, 1)
		end

		if not __wf_atom_7e8ad928(v2) then
			v2:SetMaterialParam(Symbol("TintColor"), v19.x, v19.y, v19.z, 1)
			v2:SetMaterialParam(Symbol("LowColor"), v19.x, v19.y, v19.z, 1)
			v2:SetMaterialParam(Symbol("HighColor"), v19.x, v19.y, v19.z, 1)
		end
	else
		for i = 1, #v12 do
			if __wf_atom_7e8ad928(v12[i]) then
				continue
			end

			v12[i]:SetMaterialParam(Symbol("TintColor"), v14.x, v14.y, v14.z, 1)
			v12[i]:SetMaterialParam(Symbol("LowColor"), v19.x, v19.y, v19.z, 1)
			v12[i]:SetMaterialParam(Symbol("HighColor"), v19.x, v19.y, v19.z, 1)
		end

		if not __wf_atom_7e8ad928(v2) then
			v2:SetMaterialParam(Symbol("TintColor"), v14.x, v14.y, v14.z, 1)
			v2:SetMaterialParam(Symbol("LowColor"), v19.x, v19.y, v19.z, 1)
			v2:SetMaterialParam(Symbol("HighColor"), v19.x, v19.y, v19.z, 1)
		end
	end
end

function FeyIdolShowAttachments(object)
	local __wf_atom_bb3e7833s = {}

	while #__wf_atom_bb3e7833s < 1 and not __wf_atom_7e8ad928(object) do
		if isAltAttachment then
			for i = 1, #idolAltAttachmentFxTypes do
				local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(idolAltAttachmentFxTypes[i])

				if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833 = object:Attach(
						idolAltAttachmentFxTypes[i],
						EMPTY_SYMBOL,
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1
					)
				end

				table.insert(__wf_atom_bb3e7833s, __wf_atom_bb3e7833)
			end
		else
			for i = 1, #idolAttachmentFxTypes do
				local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(idolAttachmentFxTypes[i])

				if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833 = object:Attach(
						idolAttachmentFxTypes[i],
						EMPTY_SYMBOL,
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1
					)
				end

				table.insert(__wf_atom_bb3e7833s, __wf_atom_bb3e7833)
			end
		end

		Sleep(0)
	end

	FeyVirtueSwap(object, 0.2, nil, true)

	for _, v in ipairs(__wf_atom_bb3e7833s) do
		if not __wf_atom_7e8ad928(v) then
			v:__wf_atom_68f2c268(0)
		end
	end

	local v

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833s[1]) then
		v = 0
	else
		v = __wf_atom_bb3e7833s[1]:__wf_atom_54cda546()
	end

	while v < 1 do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / fadeTime, 0, 1)

		for _, v2 in ipairs(__wf_atom_bb3e7833s) do
			__wf_atom_7e8ad928(v2)
		end

		Sleep(0)
	end

	if not (__wf_atom_7e8ad928(idolShowSound) or __wf_atom_7e8ad928(object)) then
		object:PlaySound(idolShowSound, false, 0, false)
	end
end

function FeyIdolHideAttachments(object, p)
	if not p then
		if not __wf_atom_7e8ad928(idolHideSound) then
			object:PlaySound(idolHideSound, false, 0, false)
		end

		object:Attach(idolDestroyFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	local __wf_atom_bb3e7833s = {}

	if isAltAttachment then
		for i = 1, #idolAltAttachmentFxTypes do
			local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(idolAltAttachmentFxTypes[i])

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				table.insert(__wf_atom_bb3e7833s, __wf_atom_bb3e7833)
			end
		end
	else
		for i = 1, #idolAttachmentFxTypes do
			local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(idolAttachmentFxTypes[i])

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				table.insert(__wf_atom_bb3e7833s, __wf_atom_bb3e7833)
			end
		end
	end

	Sleep(0)
	local v = __wf_atom_7e8ad928(__wf_atom_bb3e7833s[1]) and 0 or 1 - __wf_atom_bb3e7833s[1]:__wf_atom_54cda546()

	if unattachOnHide then
		for _, v2 in ipairs(__wf_atom_bb3e7833s) do
			if not __wf_atom_7e8ad928(v2) then
				v2:__wf_atom_e6ed03c8()
			end
		end
	end

	while v < 1 do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / fadeTime, 0, 1)

		for _, v2 in ipairs(__wf_atom_bb3e7833s) do
			__wf_atom_7e8ad928(v2)
		end

		Sleep(0)
	end

	for _, v2 in ipairs(__wf_atom_bb3e7833s) do
		if not __wf_atom_7e8ad928(v2) then
			v2:Destroy()
		end
	end

	ClearCharge(object)
end

function Charge(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()
	local __wf_atom_66088189 = __wf_atom_21ed1a39:__wf_atom_66088189(1, 0)
	object:__wf_atom_b811702e(virtueTag)

	if not __wf_atom_7e8ad928(__wf_atom_66088189) then
		__wf_atom_66088189:__wf_atom_b811702e(virtueTag)
	end

	for i = 1, #chargeTypes do
		local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

		for j = 1, #__wf_atom_be0bea4a do
			if __wf_atom_be0bea4a[j]:IsA(chargeTypes[i]) then
				__wf_atom_be0bea4a[j]:Destroy()
			end
		end
	end

	local v = Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowChargeFX")
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()
	local v2 = 0

	if not __wf_atom_7e8ad928(__wf_atom_575542c8) then
		local __wf_atom_e55d02aa = __wf_atom_575542c8:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			v2 = __wf_atom_e55d02aa:__wf_atom_437fa2aa()
		end
	end

	if v2 == 1 then
		v = Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowChargeFXCourage")
	end

	if v2 == 2 then
		v = Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowChargeFXSpirit")
	end

	if v2 == 3 then
		v = Type("/SF/Fx/Equipment/Idols/ThornBow/ThornBowChargeFXGrace")
	end

	object:Attach(v, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local v3

	if not __wf_atom_7e8ad928(chargeDecoType) then
		v3 = object:Attach(chargeDecoType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	local v4

	if not __wf_atom_7e8ad928(perfectChargeDecoType) then
		v4 = object:Attach(perfectChargeDecoType, Symbol("GAME_C1_ARROW"), __wf_atom_28d5d4aa, Rotation(0, 90, 0))
	end

	local __wf_atom_083a9e64 = __wf_atom_21ed1a39:__wf_atom_083a9e64()

	if __wf_atom_083a9e64:IsA(__wf_atom_6a70dd22) then
		local postProcess = gRegion:__wf_atom_8ad59546().postProcess

		if not __wf_atom_7e8ad928(v3) then
			local v5 = 0

			while v5 < 1 and __wf_atom_21ed1a39:__wf_atom_dedeec57() do
				v5 = __wf_atom_083a9e64:__wf_atom_f9b5aca2()

				if not __wf_atom_7e8ad928(v3) then
					v3:__wf_atom_8f04e01e(v5)
				end

				if not __wf_atom_7e8ad928(v4) then
					v4:__wf_atom_8f04e01e(v5)
				end

				if not __wf_atom_7e8ad928(postProcess) then
					postProcess:__wf_atom_54a04966(v5 * 2)
					postProcess:__wf_atom_f846a58a(v5 * 2 + 1)
				end

				Sleep(0)
			end

			if not __wf_atom_7e8ad928(v4) then
				v4:Destroy()
			end
		end

		if not __wf_atom_7e8ad928(postProcess) then
			postProcess:__wf_atom_54a04966(0)
			postProcess:__wf_atom_f846a58a(0)
		end

		local __wf_atom_f9b5aca2 = __wf_atom_083a9e64:__wf_atom_f9b5aca2()

		if not __wf_atom_7e8ad928(perfectChargedAttachType) and __wf_atom_f9b5aca2 > 0.99 then
			object:Attach(perfectChargedAttachType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end

		Sleep(0)
	end
end

function ClearCharge(object)
	local __wf_atom_66088189 = object:__wf_atom_21ed1a39():__wf_atom_66088189(1, 0)

	if not __wf_atom_7e8ad928(__wf_atom_66088189) then
		local __wf_atom_be0bea4a = __wf_atom_66088189:__wf_atom_be0bea4a()

		for i = 1, #__wf_atom_be0bea4a do
			__wf_atom_be0bea4a[i]:Destroy()
		end
	end

	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

	for i = 1, #__wf_atom_be0bea4a do
		for j = 1, #chargeTypes do
			if not __wf_atom_be0bea4a[i]:IsA(chargeTypes[j]) then
				continue
			end

			if __wf_atom_be0bea4a[i]:IsA(__wf_atom_3ae8d73b) then
				__wf_atom_be0bea4a[i]:PlayTriggeredFade()
			else
				__wf_atom_be0bea4a[i]:Destroy()
			end
		end
	end

	local postProcess = gRegion:__wf_atom_8ad59546().postProcess

	if not __wf_atom_7e8ad928(postProcess) then
		postProcess:__wf_atom_54a04966(0)
		postProcess:__wf_atom_f846a58a(0)
	end
end