local v = Type("/EE/Types/Physics/Ragdoll")
local v2 = Symbol("EffectsDeco")

function EnemyDeathByFire(object)
	Sleep(0)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local creator

	if useCreator then
		creator = object:GetCreator()
	else
		creator = object:__wf_atom_575542c8()
	end

	local v3 = WeakResource("/EE/Types/Effects/Spawner")
	local v4 = 8

	while (__wf_atom_7e8ad928(creator) or creator:IsA(v3)) and v4 > 0 do
		if useCreator then
			creator = object:GetCreator()
		else
			creator = object:__wf_atom_f7e7be53()
		end

		v4 -= 1
		Sleep(0)
	end

	if __wf_atom_7e8ad928(creator) then
		return
	end

	local v5

	if creator:IsA(v) then
		v5 = creator:__wf_atom_6009c8ed()
	else
		v5 = creator
	end

	Symbol("GAME_C1_HIP1")

	if __wf_atom_7e8ad928(v5) or not v5:IsA(__wf_atom_4ebf67cb) then
		return
	end

	local __wf_atom_bf9d0dc4 = v5:__wf_atom_7470861b():__wf_atom_bf9d0dc4(0)

	for i = 1, #pFX do
		creator:Attach(pFX[i], __wf_atom_bf9d0dc4)
	end

	creator:__wf_atom_bde21df6(burntBodyMat, false)
	local __wf_atom_f582136d = creator:__wf_atom_f582136d(__wf_atom_8d0b7f88)
	local v6 = false
	local v7 = false

	for i = 1, #__wf_atom_f582136d do
		local v8 = __wf_atom_f582136d[i]

		if v8:__wf_atom_db682341() == v2 or v8:IsA(__wf_atom_8973af3f) then
			continue
		end

		v8:__wf_atom_bde21df6(burntBodyMat, false)
	end

	local total = 0

	while total < 6 do
		v6 = not __wf_atom_7e8ad928(v5) and v5:__wf_atom_c6f1f83d() <= 0 and not v6 or v6

		if v6 and not (v7 or __wf_atom_7e8ad928(v5)) then
			local __wf_atom_f51f1faa = v5:__wf_atom_f51f1faa()

			if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
				__wf_atom_f51f1faa:__wf_atom_bde21df6(burntBodyMat, false)
				local __wf_atom_f582136d2 = __wf_atom_f51f1faa:__wf_atom_f582136d(__wf_atom_8d0b7f88)
				creator = __wf_atom_f51f1faa
				v7 = true

				for i = 1, #__wf_atom_f582136d2 do
					local v8 = __wf_atom_f582136d2[i]

					if v8:__wf_atom_db682341() == v2 or v8:IsA(__wf_atom_8973af3f) then
						continue
					end

					v8:__wf_atom_bde21df6(burntBodyMat, false)
				end

				for i = 1, #leadUpFxToKill do
					local __wf_atom_bb3e7833 = creator:__wf_atom_bb3e7833(leadUpFxToKill[i])

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_bb3e7833:Destroy()
					end
				end
			end
		end

		if not __wf_atom_7e8ad928(creator) then
			creator:__wf_atom_a763aa1a((math.pow(total / 6, 3)))
		end

		total += __wf_atom_084b3e93() * speed
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v5) then
		return
	end

	local __wf_atom_c6e1a103 = v5:__wf_atom_c6e1a103()

	if __wf_atom_c6e1a103 > 0 then
		for i = 0, __wf_atom_c6e1a103 - 1 do
			v5:__wf_atom_cbf8e541(i):Destroy()
		end
	else
		local __wf_atom_30e3d82b = v5:__wf_atom_30e3d82b()
		local __wf_atom_a96eb2aa = v5:__wf_atom_a96eb2aa()

		if
			__wf_atom_7e8ad928(__wf_atom_30e3d82b)
			or not __wf_atom_7e8ad928(__wf_atom_a96eb2aa)
			or v5:IsA(__wf_atom_7e6ed5fa)
		then
			return
		end

		if not __wf_atom_7e8ad928(v5) then
			v5:Destroy()
		end
	end
end