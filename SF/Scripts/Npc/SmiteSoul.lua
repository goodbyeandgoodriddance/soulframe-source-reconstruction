local v = false
local v2 = nil
local v3 = Vector(0, -0.15, 0)
local v4 = {}

local function fn()
	return _T.CombatTutorialEnded == nil
end

function SoulSpawn(object, p, p2, p3, p4)
	Sleep(0)

	if not gRegion:IsMaster() then
		return
	end

	if not __wf_atom_7e8ad928(p) then
		soulStealTypes = p
	end

	if __wf_atom_7e8ad928(p2) then
		v2 = Symbol("GAME_C1_SPINE3")
	else
		v2 = p2
	end

	if __wf_atom_7e8ad928(p3) then
		v3 = Vector(0, -0.15, 0)
	else
		v3 = p3
	end

	if
		not __wf_atom_7e8ad928(object)
		and object:__wf_atom_1bb5b1ff():IsA((WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeAxeOfficerAvatar")))
	then
		object:__wf_atom_51009507(Resource("/SF/Scripts/ZoneSpawnDropTableOverride.lua"), Symbol("OnSpawn"), false)
	end

	if not fn() then
		return
	end

	v = p4

	if gRegion:IsMaster() then
		if v then
			local v5 = getfenv(2)
			v5.OnDamagedEvaluateSoulSpawn = OnDamagedEvaluateSoulSpawn
			object:__wf_atom_51cd6126(Symbol("CritDamage"), "OnDamagedEvaluateSoulSpawn")
			v5.SoulSpawnLoop = SoulSpawnLoop
		else
			object:__wf_atom_51cd6126(Symbol("CritDamage"), "OnDamagedEvaluateSoulSpawn")
		end
	end
end

function SmiteSoulScript(object)
	Sleep(0)

	if not gRegion:IsMaster() then
		object:__wf_atom_51cd6126(Symbol("SmiteDamageCacher"), "OnDamaged")
		return
	end

	if not fn() then
		return
	end

	if overrideAttachBone == EMPTY_SYMBOL then
		SoulSpawn(object)
	else
		SoulSpawn(object, nil, overrideAttachBone)
	end

	while not (__wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		Sleep(0)
	end

	for k, _ in pairs(v4) do
		if __wf_atom_7e8ad928(v4[k].soul) or not v4[k].soul:__wf_atom_b2f8ef81() then
			continue
		end

		v4[k].soul:__wf_atom_e6ed03c8()
	end
end

local function fn2(player, sourceWeapon)
	local v5 = 5

	if not __wf_atom_7e8ad928(player) then
		local __wf_atom_50a7d83e = player:__wf_atom_50a7d83e()

		if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_7e8ad928(sourceWeapon)) then
			return (__wf_atom_50a7d83e:__wf_atom_d2b2176d():__wf_atom_2a745663(
				v5,
				461,
				sourceWeapon:__wf_atom_1bb5b1ff(),
				sourceWeapon,
				26,
				Symbol("SOUL_DURATION_WEAPON")
			))
		end
	end

	return v5
end

function SoulSpawnLoop(instance)
	local flag = true

	while flag do
		flag = false

		for k, _ in pairs(v4) do
			if not v4[k].soulattached then
				continue
			end

			if v4[k].windowTimer == nil then
				v4[k].windowTimer = fn2(v4[k].player, v4[k].sourceWeapon)
			end

			v4[k].windowTimer -= __wf_atom_084b3e93()

			if v4[k].windowTimer < 0 or __wf_atom_7e8ad928(v4[k].soul) then
				local v5 = not __wf_atom_7e8ad928(v4[k].soul) and v4[k].soul:__wf_atom_b2f8ef81()

				if v5 then
					v4[k].soul:Destroy()
				end

				if v and v5 and v4[k].attempts < 1 then
					v4[k].attempts = v4[k].attempts + 1
				else
					v4[k].attempts = 2
				end

				v4[k].soulattached = false
				v4[k].windowTimer = fn2(v4[k].player, v4[k].sourceWeapon)

				if v4[k].isLocal then
					instance:RemoveTag(Symbol("SoulRevealed"))
				end
			else
				flag = true
			end
		end

		Sleep(0)
	end
end

function RunSoulspawnLoop(object)
	object:__wf_atom_8a035cd5(Symbol("SoulSpawnLoop"), false)
end

function OnDamagedEvaluateSoulSpawn(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()
	local __wf_atom_483e7ddc = __wf_atom_9d766292:__wf_atom_483e7ddc()
	local __wf_atom_679ed446 = __wf_atom_9d766292:__wf_atom_679ed446()

	if __wf_atom_7e8ad928(__wf_atom_679ed446) or not __wf_atom_679ed446:IsA(__wf_atom_4ebf67cb) then
		return
	end

	local __wf_atom_a96eb2aa = __wf_atom_679ed446:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	local v5 = __wf_atom_a96eb2aa:__wf_atom_ef151cfd() + 1

	if v4[v5] == nil then
		v4[v5] = {
			player = __wf_atom_a96eb2aa,
			sourceWeapon = __wf_atom_9d766292:__wf_atom_3371f607(),
			isLocal = __wf_atom_a96eb2aa:IsLocal(),
			attempts = 0,
			soulattached = false,
			soul = nil
		}
	end

	if
		v4[v5].soulattached ~= true
		and __wf_atom_483e7ddc.criticalCount > 0
		and not __wf_atom_483e7ddc:__wf_atom_6e062502()
		and __wf_atom_7e8ad928(v4[v5].soul)
		and v4[v5].attempts <= 1
	then
		local v6 = __wf_atom_5784a397(1, 3)

		if __wf_atom_483e7ddc:__wf_atom_bf612a92(19) > 0 then
			return
		end

		OnDamaged(object)
		local soulStealType = soulStealTypes[v6]
		local __wf_atom_e55d02aa = __wf_atom_679ed446:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) and __wf_atom_e55d02aa:__wf_atom_a07f65c2() then
			soulStealType = soulStealCorruptTypes[v6]
		end

		local soul

		if object:IsKilled() then
			local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(v2, true)
			soul = gRegion:CreateEntity(
				soulStealType,
				__wf_atom_1c374cc9,
				__wf_atom_80368bb1,
				__wf_atom_a96eb2aa,
				__wf_atom_a96eb2aa,
				1
			)
		else
			local __wf_atom_f51f1faa = object:__wf_atom_f51f1faa()

			if __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
				soul = object:Attach(soulStealType, v2, v3, __wf_atom_80368bb1, __wf_atom_a96eb2aa, 1)
			else
				soul = __wf_atom_f51f1faa:Attach(soulStealType, v2, v3, __wf_atom_80368bb1, __wf_atom_a96eb2aa, 1)
			end
		end

		if __wf_atom_7e8ad928(soul) then
			__wf_atom_f2daf912("soul failed to spawn")
			return
		end

		v4[v5].soul = soul
		v4[v5].soulattached = true
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		local __wf_atom_bb3e7833 = soul:__wf_atom_bb3e7833(__wf_atom_faccb0cf)

		if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			print("!! No SoulStealEntity on " .. soul:__wf_atom_5b41f63b() .. ", will not receive rewards for soul steal")
			__wf_atom_f2daf912("!! No SoulStealEntity on " .. soul:__wf_atom_5b41f63b() .. ", will not receive rewards for soul steal")
		else
			__wf_atom_bb3e7833:__wf_atom_83cc9d29(object)
			__wf_atom_bb3e7833:__wf_atom_ab698c41(
				__wf_atom_e919fb8e.lastDamageSourceObject,
				__wf_atom_e919fb8e.lastDamageSource
			)
		end

		if v4[v5].isLocal then
			object:__wf_atom_78128d94(Symbol("SoulRevealed"))
		end
	end
end

function OnDamaged(lastSoulRevealTargetAvatar)
	local __wf_atom_9d766292 = lastSoulRevealTargetAvatar:__wf_atom_9d766292()

	if
		__wf_atom_7e8ad928(__wf_atom_9d766292)
		or __wf_atom_7e8ad928(__wf_atom_9d766292:__wf_atom_679ed446())
		or __wf_atom_7e8ad928(__wf_atom_9d766292:__wf_atom_3371f607())
	then
		return
	end

	local __wf_atom_e919fb8e = lastSoulRevealTargetAvatar:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e)
		or not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.lastDamageSourceObject) or __wf_atom_7e8ad928(lastSoulRevealTargetAvatar:__wf_atom_bb3e7833(baseSoulStealType)))
	then
		return
	end

	__wf_atom_e919fb8e.lastDamageSource = __wf_atom_9d766292:__wf_atom_679ed446()
	__wf_atom_e919fb8e.lastDamageSourceObject = __wf_atom_9d766292:__wf_atom_3371f607()
	local lastDamageSource = __wf_atom_e919fb8e.lastDamageSource

	if __wf_atom_7e8ad928(lastDamageSource) or not lastDamageSource:IsA(__wf_atom_4ebf67cb) then
		return
	end

	local __wf_atom_e919fb8e_2 = lastDamageSource:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e_2.lastSoulRevealTargetAvatar = lastSoulRevealTargetAvatar
	local __wf_atom_3371f607 = __wf_atom_9d766292:__wf_atom_3371f607()
	local __wf_atom_a96eb2aa = lastDamageSource:__wf_atom_a96eb2aa()

	if
		not __wf_atom_7e8ad928(__wf_atom_3371f607)
		and __wf_atom_3371f607:IsA(__wf_atom_2dc5c74e)
		and not __wf_atom_7e8ad928(__wf_atom_a96eb2aa)
	then
		__wf_atom_539492fe:__wf_atom_8b4524e6(
			__wf_atom_a96eb2aa,
			Symbol("SMITE_WEAPON"),
			__wf_atom_3371f607,
			__wf_atom_3371f607:__wf_atom_1bb5b1ff()
		)
	end
end