local v = {
	Symbol("GAME_C1_WHIP17"),
	Symbol("GAME_C1_WHIP16"),
	Symbol("GAME_C1_WHIP15"),
	Symbol("GAME_C1_WHIP14"),
	Symbol("GAME_C1_WHIP13"),
	Symbol("GAME_C1_WHIP12"),
	Symbol("GAME_C1_WHIP11"),
	Symbol("GAME_C1_WHIP10"),
	Symbol("GAME_C1_WHIP9"),
	Symbol("GAME_C1_WHIP8"),
	Symbol("GAME_C1_WHIP7"),
	Symbol("GAME_C1_WHIP6"),
	Symbol("GAME_C1_WHIP5"),
	Symbol("GAME_C1_WHIP4"),
	Symbol("GAME_C1_WHIP3"),
	Symbol("GAME_C1_WHIP2")
}
local v2 = {
	{ boneCount = 5, meleeAssistDistance = 3, meleeStopDistance = 2, meleeSnapDistance = 1.2 },
	{ boneCount = 10, meleeAssistDistance = 2.5, meleeStopDistance = 1.75, meleeSnapDistance = 1.2 },
	{ boneCount = 16, meleeAssistDistance = 2, meleeStopDistance = 0.75, meleeSnapDistance = 0.75 }
}

function OnDamageDone(object)
	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292())
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292():__wf_atom_483e7ddc())
	then
		return
	end

	local __wf_atom_483e7ddc = object:__wf_atom_9d766292():__wf_atom_483e7ddc()
	local victim = __wf_atom_483e7ddc.victim

	if __wf_atom_7e8ad928(victim) or not victim:__wf_atom_464a4772() or not victim:__wf_atom_e919fb8e().BreakWeapon then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.CorruptedSwordType)
		or __wf_atom_e919fb8e.CorruptedSwordType ~= __wf_atom_483e7ddc:__wf_atom_c98157ce()
	then
		return
	end

	if __wf_atom_483e7ddc:__wf_atom_96aa57d5() == 3 then
		__wf_atom_e919fb8e.CorruptedSwordBroken = true
	end
end

function OnDamageTaken(object)
	local __wf_atom_483e7ddc = object:__wf_atom_9d766292():__wf_atom_483e7ddc()
	local __wf_atom_679ed446 = __wf_atom_483e7ddc:__wf_atom_679ed446()

	if
		__wf_atom_7e8ad928(__wf_atom_679ed446)
		or not __wf_atom_679ed446:IsA(__wf_atom_4ebf67cb)
		or not __wf_atom_679ed446:__wf_atom_464a4772()
		or not __wf_atom_679ed446:__wf_atom_e919fb8e().BreakWeapon
	then
		return
	end

	local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.CorruptedSwordType)
		or __wf_atom_e919fb8e.CorruptedSwordType ~= __wf_atom_35a10d3c:__wf_atom_1bb5b1ff()
	then
		return
	end

	if __wf_atom_483e7ddc:__wf_atom_6e062502() then
		__wf_atom_e919fb8e.CorruptedSwordBroken = true
		__wf_atom_e919fb8e.CorruptedSwordGrowthInterrupted = true
	end
end

function OnOwnerSet(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	while __wf_atom_7e8ad928(__wf_atom_6009c8ed) and not __wf_atom_7e8ad928(object) do
		__wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
		Sleep(0)
	end

	__wf_atom_6009c8ed:__wf_atom_b4529799(Symbol("CorruptedSwordDamageDone"), "OnDamageDone")
	__wf_atom_6009c8ed:__wf_atom_51cd6126(Symbol("CorruptedSwordDamageTaken"), "OnDamageTaken")
	local v3 = nil

	while __wf_atom_7e8ad928(v3) do
		v3 = object:__wf_atom_66088189(1, 0)
		Sleep(0)
	end

	local __wf_atom_9112f323 = object:__wf_atom_9112f323(false)
	local __wf_atom_c232e8c9 = object:__wf_atom_c232e8c9()
	local __wf_atom_973269a5 = object:__wf_atom_973269a5()
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.CorruptedSwordType = object:__wf_atom_1bb5b1ff()
	local v4 = 0
	local v5 = nil
	local v6 = 0
	local boneCount = 0
	local v7 = 1

	while not __wf_atom_7e8ad928(v3) do
		local flag = false
		local v8 = not __wf_atom_7e8ad928(__wf_atom_e919fb8e.CorruptedSwordBroken)
		local v9 = not __wf_atom_7e8ad928(__wf_atom_e919fb8e.CorruptedSwordGrowthInterrupted)

		if __wf_atom_7e8ad928(v3) then
			object:__wf_atom_66088189(1, 0)
		end

		if not __wf_atom_7e8ad928(v3) then
			if v8 then
				v4 = math.min(v4 + 1, #v2)
				boneCount = v2[v4].boneCount

				for i = 1, boneCount do
					v3:__wf_atom_83fac646(v[i], __wf_atom_80368bb1, __wf_atom_28d5d4aa, Vector(0.001, 0.001, 0.001))
				end

				v6 = 0
				v7 = 0.001
				flag = true
			end

			if v9 then
				v6 = 5

				if not __wf_atom_7e8ad928(v5) then
					v5:Destroy()
				end
			end

			if v6 > 0 then
				v6 -= __wf_atom_084b3e93()
			end

			if v6 <= 0 and boneCount > 0 then
				v7 = math.min(v7 + __wf_atom_084b3e93() * 1, 1)
				v3:__wf_atom_83fac646(v[boneCount], __wf_atom_80368bb1, __wf_atom_28d5d4aa, Vector(v7, v7, v7))

				if v7 >= 1 then
					boneCount -= 1
					v7 = 0.001

					if v4 > 1 and boneCount <= v2[v4].boneCount then
						v4 -= 1
						flag = true
					end
				end

				if boneCount > 0 then
					if __wf_atom_7e8ad928(v5) then
						v5 = v3:Attach(growfx, v[boneCount], __wf_atom_28d5d4aa, __wf_atom_80368bb1)
					elseif v5:__wf_atom_f5bac0e4() ~= v[boneCount] then
						v3:AttachEntity(v5, v[boneCount], __wf_atom_28d5d4aa, __wf_atom_80368bb1)
					end
				elseif not __wf_atom_7e8ad928(v5) then
					v5:Destroy()
					flag = true
					v4 = 0
				end
			end
		end

		if flag then
			if v4 > 0 then
				object:__wf_atom_68a890f0(
					v2[v4].meleeAssistDistance,
					v2[v4].meleeStopDistance,
					v2[v4].meleeSnapDistance
				)
			else
				object:__wf_atom_68a890f0(__wf_atom_9112f323, __wf_atom_c232e8c9, __wf_atom_973269a5)
			end
		end

		__wf_atom_e919fb8e.CorruptedSwordBroken = nil
		__wf_atom_e919fb8e.CorruptedSwordGrowthInterrupted = nil
		Sleep(0)
	end
end

function OnOwnerRemoved(_, object)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_af2dc07b(Symbol("CorruptedSwordDamageDone"))
		object:__wf_atom_3ede53b4(Symbol("CorruptedSwordDamageTaken"))
	end
end