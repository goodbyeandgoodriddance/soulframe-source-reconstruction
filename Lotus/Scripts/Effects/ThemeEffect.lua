local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")
local module3 = require("Lotus.Scripts.Effects.EffectsColorUtilities")

function ApplyEffectThemeColors(instance)
	local primaryColor = primaryColor
	local secondaryColor = secondaryColor

	if overridePrimaryColorTag ~= "" and _T[overridePrimaryColorTag] ~= nil then
		primaryColor = _T[overridePrimaryColorTag]
	end

	if overrideSecondaryColorTag ~= "" and _T[overrideSecondaryColorTag] ~= nil then
		secondaryColor = _T[overrideSecondaryColorTag]
	end

	local convertHEX2RGB255 = module.ConvertHEX2RGB255(module2.GetColor(primaryColor, true))
	local convertHEX2RGB255_2 = module.ConvertHEX2RGB255(module2.GetColor(secondaryColor, true))

	if instance:IsA(__wf_atom_8939e086) then
		instance:__wf_atom_8cd234d5(convertHEX2RGB255, convertHEX2RGB255_2)
	elseif instance:IsA(__wf_atom_fac7b40a) then
		instance:__wf_atom_7fff6c98(convertHEX2RGB255)
	end
end

function ApplyEffectHudColors(instance)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local v = Color(__wf_atom_18a5d83b:Settings():__wf_atom_fd5d793e(hudColor))
	local v2 = Color(v.red * hudColorModifier, v.green * hudColorModifier, v.blue * hudColorModifier)

	if instance:IsA(__wf_atom_8939e086) then
		instance:__wf_atom_8cd234d5(v, v2)
	end
end

function ApplyEffectWeaponColors(instance)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

			if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
				local v = Color()
				__wf_atom_35a10d3c:__wf_atom_8e1ec29f(v, false)

				if instance:IsA(__wf_atom_8939e086) then
					if not fadeToSecondaryColor then
						instance:__wf_atom_8cd234d5(v, v)
						return
					end

					local v2 = Color()
					__wf_atom_35a10d3c:__wf_atom_8e1ec29f(v2, true)
					instance:__wf_atom_8cd234d5(v, v2)
				elseif instance:IsA(__wf_atom_fac7b40a) then
					instance:__wf_atom_7fff6c98(v)
				end
			end
		end
	end
end

function ApplyEnergyColors(p)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				__wf_atom_e55d02aa:ApplyEnergyColor(p)
			end
		end
	end
end

function ApplyFogSphereColors(object)
	local v = Symbol("TintColor0")
	local v2 = Symbol("TintColor1")
	local color = module2.GetColor(2, false)
	local v3 = math.min(1, 1.8 - math.max(color.red, (math.max(color.green, color.blue))) * 1.5 / 255)
	object:SetMaterialParam(
		Symbol("TintColor"),
		module3.SRGBToLinear(color.red * v3),
		module3.SRGBToLinear(color.green * v3),
		module3.SRGBToLinear(color.blue * v3),
		1
	)
	local color2 = module2.GetColor(3, false)
	local v4 = math.min(1, 1.5 - math.max(color2.red, (math.max(color2.green, color2.blue))) / 255)
	object:SetMaterialParam(
		Symbol("VerticalTintColor"),
		module3.SRGBToLinear(color2.red * v4),
		module3.SRGBToLinear(color2.green * v4),
		module3.SRGBToLinear(color2.blue * v4),
		1
	)

	if isKuvaLich then
		return
	end

	local v5 = 10
	local v6 = nil

	while v5 > 0 and __wf_atom_7e8ad928(v6) do
		v6 = object:__wf_atom_a5040fdf():__wf_atom_e2db08ce(__wf_atom_7e6ed5fa, object:GetPosition(), 2)
		Sleep(0)
		v5 -= 1
	end

	if not __wf_atom_7e8ad928(v6) and v6:IsA(__wf_atom_7e6ed5fa) then
		local v7 = Vector()

		if v6:__wf_atom_99150eda(v) then
			v7.x = v6:__wf_atom_06adb5a9(v, 1)
			v7.y = v6:__wf_atom_06adb5a9(v, 2)
			v7.z = v6:__wf_atom_06adb5a9(v, 3)
			object:SetMaterialParam(Symbol("TintColor"), v7.x, v7.y, v7.z, 1)
		else
			local __wf_atom_3de89c8e = v6:__wf_atom_3de89c8e(0)

			if not __wf_atom_7e8ad928(__wf_atom_3de89c8e) then
				v7.x = __wf_atom_3de89c8e:__wf_atom_b90af225(v, 1)
				v7.y = __wf_atom_3de89c8e:__wf_atom_b90af225(v, 2)
				v7.z = __wf_atom_3de89c8e:__wf_atom_b90af225(v, 3)
				object:SetMaterialParam(Symbol("TintColor"), v7.x, v7.y, v7.z, 1)
			end
		end

		if v6:__wf_atom_99150eda(v2) then
			v7.x = v6:__wf_atom_06adb5a9(v2, 1) / 2
			v7.y = v6:__wf_atom_06adb5a9(v2, 2) / 2
			v7.z = v6:__wf_atom_06adb5a9(v2, 3) / 2
			object:SetMaterialParam(Symbol("VerticalTintColor"), v7.x, v7.y, v7.z, 1)
		else
			local __wf_atom_3de89c8e = v6:__wf_atom_3de89c8e(0)

			if not __wf_atom_7e8ad928(__wf_atom_3de89c8e) then
				v7.x = __wf_atom_3de89c8e:__wf_atom_b90af225(v2, 1) / 2
				v7.y = __wf_atom_3de89c8e:__wf_atom_b90af225(v2, 2) / 2
				v7.z = __wf_atom_3de89c8e:__wf_atom_b90af225(v2, 3) / 2
				object:SetMaterialParam(Symbol("VerticalTintColor"), v7.x, v7.y, v7.z, 1)
			end
		end

		local __wf_atom_e55d02aa = v6:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			local all = object:__wf_atom_a5040fdf():FindAll(__wf_atom_fac7b40a)

			for i = 1, #all do
				__wf_atom_e55d02aa:ApplyEnergyColor(all[i])
			end
		end
	end
end