local v = Symbol("CloakHDR")
local v2 = Symbol("CloakVector")
local module = require("Lotus.Scripts.Effects.EffectsColorUtilities")
local v3 = Type("/EE/Types/Physics/Ragdoll")

function DissolveTheEnemy(object)
	Sleep(0)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	local cinematicColor2 = Color(246, 104, 0, 255)
	local v4 = Symbol("GAME_C1_HIP1")
	local v5

	if isCinematic then
		cinematicColor2 = cinematicColor
		v5 = __wf_atom_575542c8
		__wf_atom_575542c8 = nil
	else
		if __wf_atom_575542c8:IsA(v3) then
			local __wf_atom_6009c8ed = __wf_atom_575542c8:__wf_atom_6009c8ed()

			if __wf_atom_7e8ad928(__wf_atom_6009c8ed) or not (__wf_atom_6009c8ed:__wf_atom_c6e1a103() > 1) then
				v5 = __wf_atom_575542c8
				__wf_atom_575542c8 = __wf_atom_6009c8ed
			else
				local __wf_atom_e14d8a8c = object:__wf_atom_e14d8a8c()
				v5 = __wf_atom_575542c8
				__wf_atom_575542c8 = __wf_atom_6009c8ed

				for i = 0, __wf_atom_6009c8ed:__wf_atom_c6e1a103() - 1 do
					__wf_atom_7e8ad928((__wf_atom_575542c8:__wf_atom_cbf8e541(i):__wf_atom_bb3e7833(__wf_atom_e14d8a8c)))
				end
			end
		elseif __wf_atom_575542c8:IsA(__wf_atom_4ebf67cb) then
			v5 = __wf_atom_575542c8
		else
			return
		end

		if not __wf_atom_7e8ad928(__wf_atom_575542c8) then
			local __wf_atom_7470861b = __wf_atom_575542c8:__wf_atom_7470861b()

			if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
				local __wf_atom_5b93b030 = __wf_atom_7470861b:__wf_atom_5b93b030()

				if not __wf_atom_7e8ad928(__wf_atom_5b93b030) then
					local __wf_atom_3371f607 = __wf_atom_5b93b030:__wf_atom_3371f607()

					if not __wf_atom_7e8ad928(__wf_atom_3371f607) and __wf_atom_3371f607:IsA(__wf_atom_9df43583) then
						local colors = __wf_atom_3371f607:__wf_atom_eb82ab1f():GetColors(__wf_atom_3371f607:IsA(__wf_atom_d98e64fe) and __wf_atom_3371f607:__wf_atom_5d7344fc() and 2 or 0)

						if colors:Initialized(6) then
							cinematicColor2 = Color(colors.mEnergyColor)
						end
					end

					v4 = __wf_atom_7470861b:__wf_atom_bf9d0dc4(0)
				end
			end
		end
	end

	local energyHighColor = module.EnergyHighColor(cinematicColor2)
	local energyLowColor = module.EnergyLowColor(cinematicColor2)

	for i = 1, #pFX do
		local v6 = v5:Attach(pFX[i], v4)

		if __wf_atom_7e8ad928(v6) then
			continue
		end

		if v6:IsA(__wf_atom_8939e086) then
			v6:__wf_atom_8cd234d5(cinematicColor2, cinematicColor2)
		end

		module.ApplyEnergyTints(v6, cinematicColor2, energyHighColor, energyLowColor)
	end

	if not __wf_atom_7e8ad928(__wf_atom_575542c8) then
		for i = 1, #decoFx do
			local entity = gRegion:CreateEntity(
				decoFx[i],
				__wf_atom_575542c8:__wf_atom_1c374cc9(v4),
				__wf_atom_80368bb1
			)

			if not __wf_atom_7e8ad928(entity) then
				module.ApplyEnergyTints(entity, cinematicColor2, energyHighColor, energyLowColor)
			end
		end
	end

	v5:SetMaterialParam(
		v,
		cinematicColor2.red / cloakScale,
		cinematicColor2.green / cloakScale,
		cinematicColor2.blue / cloakScale,
		1
	)
	Vector()
	local total = 0
	local v6 = false
	local flag = false
	local __wf_atom_cbf8e541s = {}

	while total < timeLength do
		v6 = not __wf_atom_7e8ad928(__wf_atom_575542c8) and __wf_atom_575542c8:__wf_atom_c6f1f83d() <= 0 and not v6
			or v6

		if v6 and not (flag or __wf_atom_7e8ad928(__wf_atom_575542c8)) then
			for i = 0, __wf_atom_575542c8:__wf_atom_c6e1a103() - 1 do
				local __wf_atom_cbf8e541 = __wf_atom_575542c8:__wf_atom_cbf8e541(i)

				if __wf_atom_7e8ad928(__wf_atom_cbf8e541) then
					continue
				end

				__wf_atom_cbf8e541:SetMaterialParam(
					v,
					cinematicColor2.red / cloakScale,
					cinematicColor2.green / cloakScale,
					cinematicColor2.blue / cloakScale,
					1
				)
				v5 = nil
				flag = true

				for j = 1, #effectsToRemove do
					local __wf_atom_bb3e7833 = __wf_atom_cbf8e541:__wf_atom_bb3e7833(effectsToRemove[j])

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_bb3e7833:Destroy()
					end
				end

				table.insert(__wf_atom_cbf8e541s, __wf_atom_cbf8e541)
			end
		end

		if not __wf_atom_7e8ad928(v5) then
			v5:__wf_atom_a763aa1a(total / timeLength)

			if radialCloak then
				local __wf_atom_d0069154 = v5:__wf_atom_d0069154()
				v5:SetMaterialParam(v2, __wf_atom_d0069154.x, __wf_atom_d0069154.y, __wf_atom_d0069154.z, 2.5)
			end
		end

		for _, v7 in ipairs(__wf_atom_cbf8e541s) do
			if __wf_atom_7e8ad928(v7) then
				continue
			end

			v7:__wf_atom_a763aa1a(total / timeLength)

			if not radialCloak then
				continue
			end

			local __wf_atom_d0069154 = v7:__wf_atom_d0069154()
			v7:SetMaterialParam(v2, __wf_atom_d0069154.x, __wf_atom_d0069154.y, __wf_atom_d0069154.z, 2.5)
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	Sleep(2)

	if flag then
		for _, v7 in ipairs(__wf_atom_cbf8e541s) do
			if __wf_atom_7e8ad928(v7) then
				continue
			end

			v7:__wf_atom_d7f89019()
			v7:__wf_atom_ef78bb01()
		end
	end
end