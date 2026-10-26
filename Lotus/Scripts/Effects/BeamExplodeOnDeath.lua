local v = Symbol("CloakHDR")
local v2 = Type("/EE/Types/Physics/Ragdoll")
local v3 = WeakResource("/SF/Types/Player/TennoAvatar")

function DissolveTheEnemy(object)
	Sleep(0)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		return
	end

	if __wf_atom_f7e7be53:IsA(v2) then
		__wf_atom_f7e7be53 = __wf_atom_f7e7be53:__wf_atom_6009c8ed()
	end

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) or not __wf_atom_f7e7be53:IsA(__wf_atom_4ebf67cb) then
		return
	end

	local creator = object:GetCreator()
	local baseEnergyColor = baseEnergyColor

	if not __wf_atom_7e8ad928(creator) and creator:IsA(__wf_atom_9df43583) then
		local colors = creator:__wf_atom_eb82ab1f():GetColors(0)

		if colors:Initialized(6) then
			baseEnergyColor = Color(colors.mEnergyColor)
		end
	end

	local v4 = false
	__wf_atom_f7e7be53:SetMaterialParam(
		v,
		baseEnergyColor.red / 50,
		baseEnergyColor.green / 50,
		baseEnergyColor.blue / 50,
		1
	)
	local __wf_atom_c6e1a103 = __wf_atom_f7e7be53:__wf_atom_c6e1a103()

	if __wf_atom_c6e1a103 > 0 then
		for i = 0, __wf_atom_c6e1a103 - 1 do
			local __wf_atom_cbf8e541 = __wf_atom_f7e7be53:__wf_atom_cbf8e541(i)

			if not __wf_atom_7e8ad928(__wf_atom_cbf8e541) then
				__wf_atom_cbf8e541:SetMaterialParam(
					v,
					baseEnergyColor.red / 50,
					baseEnergyColor.green / 50,
					baseEnergyColor.blue / 50,
					1
				)
			end
		end
	end

	local total = 0
	local count = 0

	while total < timeLength and not __wf_atom_7e8ad928(__wf_atom_f7e7be53) do
		v4 = not __wf_atom_7e8ad928(__wf_atom_f7e7be53) and __wf_atom_f7e7be53:__wf_atom_c6f1f83d() <= 0 and not v4
			or v4

		if v4 and not __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
			local __wf_atom_c6e1a103_2 = __wf_atom_f7e7be53:__wf_atom_c6e1a103()

			if __wf_atom_c6e1a103_2 > 0 then
				for i = 0, __wf_atom_c6e1a103_2 - 1 do
					local __wf_atom_cbf8e541 = __wf_atom_f7e7be53:__wf_atom_cbf8e541(i)

					if __wf_atom_7e8ad928(__wf_atom_cbf8e541) then
						continue
					end

					if count < 5 then
						__wf_atom_cbf8e541:SetMaterialParam(
							v,
							baseEnergyColor.red / 50,
							baseEnergyColor.green / 50,
							baseEnergyColor.blue / 50,
							1
						)

						for j = 1, #leadUpFxToKill do
							local __wf_atom_bb3e7833 = __wf_atom_cbf8e541:__wf_atom_bb3e7833(leadUpFxToKill[j])

							if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
								__wf_atom_bb3e7833:Destroy()
							end
						end
					end

					__wf_atom_cbf8e541:__wf_atom_a763aa1a(total / timeLength)
				end

				count += 1
			end
		end

		__wf_atom_f7e7be53:__wf_atom_a763aa1a(total / timeLength)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	Sleep(2)

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		return
	end

	local __wf_atom_c6e1a103_2 = __wf_atom_f7e7be53:__wf_atom_c6e1a103()

	if __wf_atom_c6e1a103_2 > 0 then
		for i = 0, __wf_atom_c6e1a103_2 - 1 do
			__wf_atom_f7e7be53:__wf_atom_cbf8e541(i):Destroy()
		end
	else
		local __wf_atom_30e3d82b = __wf_atom_f7e7be53:__wf_atom_30e3d82b()
		local __wf_atom_a96eb2aa = __wf_atom_f7e7be53:__wf_atom_a96eb2aa()

		if
			__wf_atom_7e8ad928(__wf_atom_30e3d82b)
			or not __wf_atom_7e8ad928(__wf_atom_a96eb2aa)
			or __wf_atom_f7e7be53:IsA(v3)
		then
			return
		end

		if not __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
			__wf_atom_f7e7be53:Destroy()
		end
	end
end