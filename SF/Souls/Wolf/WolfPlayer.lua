local function fn(instance, playerAvatar)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(playerAvatar) then
		return
	end

	local __wf_atom_e55d02aa = instance:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_e55d02aa2 = playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) or __wf_atom_7e8ad928(__wf_atom_e55d02aa2) then
		return
	end

	for i = 0, math.min(__wf_atom_e55d02aa:__wf_atom_87a16e10(), __wf_atom_e55d02aa2:__wf_atom_87a16e10()) do
		local __wf_atom_c497b0ae = __wf_atom_e55d02aa:__wf_atom_c497b0ae(i)
		local __wf_atom_c497b0ae2 = __wf_atom_e55d02aa2:__wf_atom_c497b0ae(i)
		local __wf_atom_cc3c265a = __wf_atom_e55d02aa:__wf_atom_cc3c265a(i)

		if not (__wf_atom_7e8ad928(__wf_atom_c497b0ae) or __wf_atom_7e8ad928(__wf_atom_c497b0ae2)) then
			__wf_atom_e55d02aa2:__wf_atom_66c5fa3f(i, __wf_atom_cc3c265a)

			if __wf_atom_c497b0ae:__wf_atom_1bb5b1ff() == __wf_atom_c497b0ae2:__wf_atom_1bb5b1ff() then
				__wf_atom_c497b0ae2:__wf_atom_80e49f0d(__wf_atom_c497b0ae:__wf_atom_1fcd5380())
			end
		end

		local __wf_atom_2e4994f1 = __wf_atom_e55d02aa:__wf_atom_2e4994f1(i)
		__wf_atom_e55d02aa2:__wf_atom_9e7c0c61(
			__wf_atom_e55d02aa:__wf_atom_f3044fe0(__wf_atom_2e4994f1),
			__wf_atom_2e4994f1,
			true
		)
	end
end

local function fn2(instance, playerAvatar)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(playerAvatar) then
		return
	end

	local __wf_atom_e0730826 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e0730826(
		instance,
		50,
		false,
		false,
		summonWolfType
	)

	for i = 1, #__wf_atom_e0730826 do
		if
			__wf_atom_7e8ad928(__wf_atom_e0730826[i])
			or __wf_atom_7e8ad928(__wf_atom_e0730826[i]:__wf_atom_50a7d83e())
		then
			continue
		end

		if __wf_atom_e0730826[i]:__wf_atom_50a7d83e():__wf_atom_6115a2e2() ~= instance then
			continue
		end

		__wf_atom_e0730826[i]:__wf_atom_50a7d83e():__wf_atom_65fd9d84(playerAvatar)
	end
end

function EvaluateAbility(_, instance)
	instance:IsA(wolftype)
	return true
end

function NpcEvaluateAbility(_, _)
	return 0
end

function ActivateAbility(_, instance, _, _)
	local __wf_atom_a96eb2aa = instance:__wf_atom_a96eb2aa()
	local playerAvatar

	if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		playerAvatar = __wf_atom_a96eb2aa:GetPlayerAvatar(0)
	end

	if not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(playerAvatar)) then
		local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.stopCloak = true

		if playerAvatar:__wf_atom_4417a5d4() then
			playerAvatar:__wf_atom_a1b79f95():__wf_atom_2b40a711(true)
		end

		if gRegion:IsMaster() then
			fn(instance, playerAvatar)
			fn2(instance, playerAvatar)
			local __wf_atom_0d9c1a58 = playerAvatar:__wf_atom_0d9c1a58()

			if not __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
				__wf_atom_0d9c1a58:AssignAvatar(playerAvatar)
				playerAvatar:__wf_atom_68f2c268(1)
				instance:__wf_atom_68f2c268(1)
				playerAvatar:Attach(teleportInFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				playerAvatar:PlaySound(desummonWhoosh, false, 1, false, nil, 1)
				Sleep(0)
			end

			Sleep(0.2)
			local v = 0

			while not __wf_atom_7e8ad928(playerAvatar) and v < 1 do
				v = __wf_atom_421b01aa(v + __wf_atom_084b3e93(), 0, 1)
				playerAvatar:__wf_atom_68f2c268((math.pow(1 - v, 2)))
				Sleep(0)
			end

			playerAvatar:__wf_atom_68f2c268(0)
			local __wf_atom_bb3e7833 = playerAvatar:__wf_atom_bb3e7833(castFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end

			instance:Destroy()
		else
			playerAvatar:__wf_atom_68f2c268(1)
			instance:__wf_atom_68f2c268(1)
			playerAvatar:Attach(teleportInFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			playerAvatar:PlaySound(desummonWhoosh, false, 1, false, nil, 1)
			local v = 0

			while not __wf_atom_7e8ad928(playerAvatar) and v < 1 do
				v = __wf_atom_421b01aa(v + __wf_atom_084b3e93(), 0, 1)
				playerAvatar:__wf_atom_68f2c268((math.pow(1 - v, 2)))
				Sleep(0)
			end

			playerAvatar:__wf_atom_68f2c268(0)
			local __wf_atom_bb3e7833 = playerAvatar:__wf_atom_bb3e7833(castFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end
end

function DeactivateAbility(_, _, _, _, _) end

function OnWolfFinisherStart(_, object, _)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_7470861b():__wf_atom_28a77bdf(0)
	end
end