local v = Symbol("impactPoint")
local v2 = Symbol("CloakHDR")
local v3 = Symbol("CloakVector")
local module = require("Lotus.Scripts.Effects.EffectsUtilities")

function MicrowaveTheEnemy(instance)
	Sleep(0)
	local __wf_atom_f5bac0e4 = instance:__wf_atom_f5bac0e4()
	local __wf_atom_f7e7be53 = instance:__wf_atom_f7e7be53()
	local creator = instance:GetCreator()
	local v4 = Color(26, 241, 201, 255)
	local v5

	if not (__wf_atom_7e8ad928(creator) or not creator:IsA(__wf_atom_9df43583)) then
		local colors = creator:__wf_atom_eb82ab1f():GetColors(0)

		if colors:Initialized(6) then
			v4 = Color(colors.mEnergyColor)
		end

		v5 = creator:__wf_atom_95e72410()
	end

	__wf_atom_f7e7be53:SetMaterialParam(v2, v4.red / 25, v4.green / 25, v4.blue / 25, 1)
	Vector()
	local v6 = __wf_atom_f7e7be53
	local total = 0
	local v7 = 3
	local v8 = { 0, 0.28, 0.15, 0 }
	local v9 = false
	local v10 = nil
	local v11 = false

	while total < v7 do
		local piecewise = module.Piecewise(total / v7, v8)

		if not (__wf_atom_7e8ad928(__wf_atom_f7e7be53) or __wf_atom_7e8ad928(v6)) then
			local __wf_atom_1c374cc9 = v6:__wf_atom_1c374cc9(__wf_atom_f5bac0e4)
			local __wf_atom_1c374cc9_2 = __wf_atom_f7e7be53:__wf_atom_1c374cc9(__wf_atom_f5bac0e4)
			__wf_atom_f7e7be53:SetMaterialParam(
				v3,
				__wf_atom_1c374cc9_2.x,
				__wf_atom_1c374cc9_2.y,
				__wf_atom_1c374cc9_2.z,
				2.5
			)
			__wf_atom_f7e7be53:__wf_atom_a763aa1a(piecewise)

			if __wf_atom_f7e7be53:__wf_atom_c6f1f83d() <= 0 and not v9 then
				gRegion:CreateEntity(burstEffect, __wf_atom_1c374cc9, __wf_atom_80368bb1, v5)
				v7 = total + 5
				v9 = true
				v8 = { 0, 0.38, 0.7, 1 }
			end

			if v9 and not v11 and __wf_atom_f7e7be53:IsA(__wf_atom_67c46eba) then
				v10 = __wf_atom_f7e7be53:__wf_atom_f51f1faa()

				if not __wf_atom_7e8ad928(v10) then
					v10:SetMaterialParam(v2, v4.red / 25, v4.green / 25, v4.blue / 25, 1)
					v6 = v10
					v11 = true
				end
			end
		end

		if not __wf_atom_7e8ad928(v10) then
			v10:__wf_atom_a763aa1a(piecewise)
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v10) then
		v10:Destroy()
	end

	__wf_atom_f7e7be53:__wf_atom_a763aa1a(0)
	__wf_atom_f7e7be53:SetMaterialParam(v3, 0, 0, 0, 0)
	__wf_atom_f7e7be53:SetMaterialParam(v2, 0, 0, 0, 1)
	instance:Destroy()
end

function ProjUpdateWorldPos(list)
	if __wf_atom_7e8ad928(list) then
		return
	end

	while not __wf_atom_7e8ad928(list) do
		local __wf_atom_a2a18137 = list[1]:__wf_atom_a2a18137()

		for _, v4 in ipairs(list) do
			v4:SetMaterialParam(v, __wf_atom_a2a18137.x, __wf_atom_a2a18137.y, __wf_atom_a2a18137.z)
		end

		Sleep(0)
	end
end