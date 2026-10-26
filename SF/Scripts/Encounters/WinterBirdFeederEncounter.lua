local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("Lotus.Scripts.Libs.Query")
local module5 = require("Lotus.Scripts.Libs.AudioLib")
local module6 = require("SF.Scripts.Libs.TransmissionSet")
local v = Range(10, 13)
local v2 = Symbol("RandomTeam")
Symbol("Grineer")
local v3 = nil
local v4 = nil
local v5 = nil
local position = nil
local mHint = nil
local v6 = {}
local v7 = {}
local v8 = {}
local v9 = nil
local v10 = nil
local v11 = false
local v12 = WeakResource("/SF/Types/Player/EnvoyAvatar")

local function fn(object, object2, p)
	local v13

	if __wf_atom_7e8ad928(nil) and not __wf_atom_7e8ad928(object) then
		v13 = object:__wf_atom_d2b2176d():__wf_atom_259e7653(true)
	end

	local __wf_atom_1dd35883 = object2:__wf_atom_1dd35883()
	local __wf_atom_49479502 = v13:__wf_atom_49479502()
	local mItemCount = 0

	for i = 1, #__wf_atom_49479502 do
		local v14 = __wf_atom_49479502[i]

		if v14.mItemType ~= WeakResource(object2) then
			continue
		end

		mItemCount = v14.mItemCount
		break
	end

	if p and __wf_atom_1dd35883 - 1 <= mItemCount then
		return true
	end

	return __wf_atom_1dd35883 <= mItemCount
end

local function fn2(instance, object, object2)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	if gRegion:IsMaster() then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local __wf_atom_e93896ba = __wf_atom_7d789620:__wf_atom_e93896ba(0)
		local __wf_atom_dcf48c53 = __wf_atom_7d789620:__wf_atom_dcf48c53()
		local __wf_atom_57203011 = __wf_atom_7d789620:__wf_atom_57203011()
		local v13 = __wf_atom_5784a397(__wf_atom_dcf48c53, __wf_atom_57203011)

		if dropLootForInstigatorOnly and not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_4ebf67cb) then
			object2:__wf_atom_0ad20b11(instance, instance, __wf_atom_e93896ba, v13)
		elseif giveDirectlyToPlayers then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

			for i = 1, #__wf_atom_ef7900cf do
				local v14 = __wf_atom_ef7900cf[i]

				if __wf_atom_ef7900cf[i]:__wf_atom_a5304c35(object:GetPosition()) < maxRewardDistance then
					object2:__wf_atom_0ad20b11(v14, __wf_atom_c4f78a8f, __wf_atom_e93896ba, v13)
				end
			end
		else
			object2:__wf_atom_6ba3aebe(instance, __wf_atom_e93896ba, v13, dropSpawnOffset)
		end

		_T.idleTimoutReset = true
	end
end

local function fn3(p, p2)
	local __wf_atom_28ce676a = v4:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, p, p2)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(15)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(1, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("WinterEventBirdFeederEncounter"), Color("0xFFCC00"))
	return __wf_atom_28ce676a
end

local function fn4()
	local v13 = fn3(v, 10)
	v6 = module4.GetPositions(1, v13)
	local v14 = fn3(v9, 3)
	v7 = module4.GetPositions(10, v14)

	if #poiTypes > 0 or useOuterSpawnRing then
		local v15 = fn3(v10, 4)
		v8 = module4.GetPositions(15, v15)
	end
end

local function fn5(object)
	local total = 0
	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()

	if not (__wf_atom_7e8ad928(__wf_atom_a0f6588f) and __wf_atom_7e8ad928(__wf_atom_21342f4a)) then
		local __wf_atom_af5caba7 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_af5caba7()

		for _, mEnemy in ipairs(__wf_atom_af5caba7.mEnemies) do
			if mEnemy.type ~= object then
				continue
			end

			total += mEnemy.kills + mEnemy.assists
			break
		end

		if not _T.WinterBirdFeederEncounterKills then
			_T.WinterBirdFeederEncounterKills = {}
		end

		if not _T.WinterBirdFeederEncounterKills[__wf_atom_5b41f63b] then
			_T.WinterBirdFeederEncounterKills[__wf_atom_5b41f63b] = 0
		end

		total += _T.WinterBirdFeederEncounterKills[__wf_atom_5b41f63b]
	end

	return (math.min(scaleCap, bossBaseLevel + math.round((math.pow(total, scallingFactor)))))
end

local function fn6()
	if mHint:__wf_atom_3634e6d2() > 0 then
		return
	end

	Vector(0, 2, 0)
	Vector()
	local count = 0

	for i = 1, #bossAgentType do
		local v13 = bossAgentType[i]

		if __wf_atom_7e8ad928(v13) then
			print("ERROR: Couldn't find enemy type to spawn!")
		else
			local randomPointInRangeOnNav, v14

			if #v6 > 0 then
				local v15 = __wf_atom_5784a397(1, #v6)
				randomPointInRangeOnNav = v6[v15]
				local v16 = __wf_atom_fa8d0177(randomPointInRangeOnNav, position)
				v14 = Rotation(v16.heading, 0, 0)
				table.remove(v6, v15)
			elseif useOuterSpawnRing and #v8 > 0 then
				local v15 = __wf_atom_5784a397(1, #v8)
				randomPointInRangeOnNav = v8[v15]
				v14 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
				table.remove(v8, v15)
			elseif useOuterSpawnRing or not (#v7 > 0) then
				randomPointInRangeOnNav = v4:GetRandomPointInRangeOnNav(position, v9.minValue, v9.maxValue, true, 0.5)
				v14 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			else
				local v15 = __wf_atom_5784a397(1, #v7)
				randomPointInRangeOnNav = v7[v15]
				v14 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
				table.remove(v7, v15)
			end

			if not __wf_atom_7e8ad928(randomPointInRangeOnNav) then
				local __wf_atom_402b3832 = v4:__wf_atom_402b3832(v13, randomPointInRangeOnNav, v14, v2, bossBaseLevel)

				if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
					local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()
					__wf_atom_50a7d83e:SetLevel((fn5(__wf_atom_50a7d83e:__wf_atom_1bb5b1ff())))
					__wf_atom_50a7d83e:SetHealth(__wf_atom_50a7d83e:GetMaxHealth())
					local __wf_atom_e919fb8e = __wf_atom_50a7d83e:__wf_atom_e919fb8e()
					__wf_atom_e919fb8e.IsEventAgent = true
					mHint:__wf_atom_97f955c1(__wf_atom_402b3832)
					count += 1
				end
			end
		end

		if i < #bossAgentType then
			Sleep(0)
		end

		if module.ShouldShutDown(mHint) then
			break
		end
	end
end

function TrapBirds(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v13 = object:GetPosition() + Vector(0, 2.5, 0)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.trappedDecos = {}
	local v14 = __wf_atom_5784a397(3, 7)
	local v15 = math.random(-180, 180)

	for i = 1, v14 do
		local trappedBirdMaleDeco2

		if math.random() >= 0.5 then
			trappedBirdMaleDeco2 = trappedBirdMaleDeco
		else
			trappedBirdMaleDeco2 = trappedBirdFemaleDeco
		end

		local v16 = __wf_atom_104bfe98(0.35, 0.6, math.random())
		local v17 = Vector(0, 0, v16)
		local v18 = math.modf(
			v15 + __wf_atom_104bfe98(-180, 180, i / v14) + __wf_atom_104bfe98(-45, 45, math.random()),
			360
		)
		local v19 = math.random(-50, -10)
		local v20 = __wf_atom_9341614d(v17, Rotation(v18, v19, 0))
		local v21 = __wf_atom_fa8d0177(v13 + v20, v13)
		local entity = gRegion:CreateEntity(trappedBirdMaleDeco2, v13 + v20, v21)
		entity:__wf_atom_921c1a5f(trappedAnims[__wf_atom_5784a397(1, #trappedAnims)], false, true)

		if __wf_atom_e919fb8e.mHint then
			__wf_atom_e919fb8e.mHint:__wf_atom_d494454b(entity)
		end

		table.insert(__wf_atom_e919fb8e.trappedDecos, entity)
	end
end

function HunterEncounter(object)
	mHint = object
	position = mHint:GetPosition()
	v5 = gRegion:__wf_atom_2202ffb6()
	v4 = v5:__wf_atom_7d789620()
	local __wf_atom_28ce676a = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(object:GetPosition(), Range(2, 15), 2)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(1, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(30)
	__wf_atom_28ce676a:__wf_atom_ce415137(1)
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_5c99220c(Vector(0, 5, 0), 1, 0)
	__wf_atom_28ce676a:Start()
	local total = 0

	while not __wf_atom_28ce676a:__wf_atom_2ddd6354() and total < 2 do
		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	local __wf_atom_5802ff81 = __wf_atom_28ce676a:__wf_atom_5802ff81()

	if __wf_atom_7e8ad928(__wf_atom_5802ff81) then
		return
	end

	local v13 = __wf_atom_5802ff81[1]
	local __wf_atom_0e0a6fee = v4:__wf_atom_0e0a6fee(v13)
	local groundPos = module3.GetGroundPos(__wf_atom_0e0a6fee, nil, Vector(0, -5, 0), nil, __wf_atom_28d5d4aa)
	local entity = gRegion:CreateEntity(birdFeederType, groundPos, __wf_atom_80368bb1, object, object)
	mHint:__wf_atom_d494454b(entity)
	v9 = Range(v.maxValue + 1, v.maxValue + 3)
	v10 = Range(v9.maxValue + 6, v9.maxValue + 10)
	mHint:__wf_atom_8e6fec76(1)
	fn4()
	fn6()
	local __wf_atom_e919fb8e = entity:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.mHint = mHint
	entity:__wf_atom_8a035cd5(Symbol("TrapBirds"), false)
	mHint:__wf_atom_8e6fec76(2)
	local flag = false

	while not module.ShouldShutDown(mHint) do
		if module.ShouldShutDown(mHint) then
			module.RemoveAgents(mHint)
			mHint:__wf_atom_8e6fec76(6)
			break
		else
			if not _T.WinterBirdFeederEncounterKillCB then
				_T.WinterBirdFeederEncounterKillCB = __wf_atom_21342f4a:__wf_atom_13f782e7(
					Symbol("KILL_ENEMY"),
					"OnEnemyKilled"
				)
				_T.WinterBirdFeederEncounterAssistCB = __wf_atom_21342f4a:__wf_atom_13f782e7(
					Symbol("KILL_ASSIST"),
					"OnEnemyKilled"
				)
				flag = true
			end

			Sleep(0)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		local total2 = 0

		if _T.WinterBirdFeederEncounterKills then
			if not _T.WinterBirdFeederEncounterKills["/SF/Types/Enemies/Sinecure/Hunter/RangedHunterDisguisedAvatar"] then
				_T.WinterBirdFeederEncounterKills["/SF/Types/Enemies/Sinecure/Hunter/RangedHunterDisguisedAvatar"] = 0
			end

			total2 += _T.WinterBirdFeederEncounterKills["/SF/Types/Enemies/Sinecure/Hunter/RangedHunterDisguisedAvatar"]
		end

		if enableEventDebug then
			__wf_atom_f2daf912((tostring(total2)))
		end
	end

	if flag then
		if _T.WinterBirdFeederEncounterKillCB and not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
			__wf_atom_21342f4a:__wf_atom_8936d915(Symbol("KILL_ENEMY"), _T.WinterBirdFeederEncounterKillCB)
			__wf_atom_21342f4a:__wf_atom_8936d915(Symbol("KILL_ASSIST"), _T.WinterBirdFeederEncounterAssistCB)
		end

		_T.WinterBirdFeederEncounterKillCB = nil
		_T.WinterBirdFeederEncounterAssistCB = nil
	end
end

local function fn7(object, taggedChildren)
	module6.PlayGlobalTransmission(transmissionSet, transmissionTag, true)
	mHint = gRegion:CreateEntity(encounterHint, object:GetPosition(), object:__wf_atom_dc309f8a(), nil, nil)
	position = mHint:__wf_atom_a2a18137()
	mHint:__wf_atom_8e6fec76(1)
	v9 = Range(15, 30)
	local v13 = fn3(v9, 3)
	v7 = module4.GetPositions(10, v13)
	local __wf_atom_d52d8448 = gRegion:__wf_atom_d52d8448()
	local v14 = dogsToSpawn[__wf_atom_d52d8448]

	if not __wf_atom_7e8ad928(v7) and v14 <= #v7 then
		for i = 1, v14 do
			local enemyLevel = module.GetEnemyLevel(mHint)
			local v15 = v7[i]
			local __wf_atom_402b3832 = v4:__wf_atom_402b3832(
				dogAgent,
				v15,
				__wf_atom_80368bb1,
				v2,
				__wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
			)

			if __wf_atom_7e8ad928(__wf_atom_402b3832) then
				continue
			end

			mHint:__wf_atom_97f955c1(__wf_atom_402b3832)
			local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

			if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				continue
			end

			__wf_atom_402b3832:__wf_atom_30b587a4()
			__wf_atom_50a7d83e:__wf_atom_2f3f52aa(5)
		end
	end

	Sleep(1)
	mHint:__wf_atom_8e6fec76(2)
	v11 = true
	gRegion:__wf_atom_c4f78a8f()
	mHint:__wf_atom_3634e6d2(true)

	while not module.ShouldShutDown(mHint) do
		local __wf_atom_3634e6d2 = mHint:__wf_atom_3634e6d2(true)
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if __wf_atom_3634e6d2 <= 0 then
			spawnBird(__wf_atom_c4f78a8f, birdAgentTypes[1], taggedChildren[1], true)
			Sleep(0.5)
			spawnBird(__wf_atom_c4f78a8f, birdAgentTypes[2], taggedChildren[2], true)
			mHint:__wf_atom_8e6fec76(4)
		end

		if module.ShouldShutDown(mHint) then
			module.RemoveAgents(mHint)
			mHint:__wf_atom_8e6fec76(6)
			break
		else
			Sleep(0)
		end
	end
end

function SpawnBirdTrap(object)
	Sleep(0)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.IsEventAgent) and __wf_atom_e919fb8e.IsEventAgent == true then
		return
	end

	object:SetLevel((fn5(object:__wf_atom_1bb5b1ff())))
	object:SetHealth(object:GetMaxHealth())

	if gRegion:__wf_atom_f738b4af(Symbol("OdeBirdTrap"), object:GetPosition(), 0, 150) then
		return
	end

	v5 = gRegion:__wf_atom_2202ffb6()
	v4 = v5:__wf_atom_7d789620()
	local v13 = spawnDistanceFromInstigator.minValue + math.random() * (spawnDistanceFromInstigator.maxValue - spawnDistanceFromInstigator.minValue)
	local v14 = object:GetPosition() + __wf_atom_9341614d(Vector(v13, 0, 0), __wf_atom_80368bb1)
	local __wf_atom_0e0a6fee = v4:__wf_atom_0e0a6fee(v14)
	local groundPos = module3.GetGroundPos(__wf_atom_0e0a6fee, nil, Vector(0, -5, 0), nil, __wf_atom_28d5d4aa)
	local entity = gRegion:CreateEntity(birdTrapType, groundPos, __wf_atom_80368bb1, object, object)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		local __wf_atom_e919fb8e_2 = entity:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e_2.mHint = __wf_atom_30e3d82b:__wf_atom_76724198()
	end

	entity:__wf_atom_8a035cd5(Symbol("TrapBirds"), false)
end

function UpdateSpeakerState(object, object2)
	local __wf_atom_679ed446 = object2:__wf_atom_679ed446()
	local creator = object:GetCreator()
	local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()

	if not __wf_atom_7e8ad928(__wf_atom_679ed446) then
		if __wf_atom_c6f1f83d <= 0 then
			if not __wf_atom_7e8ad928(creator) then
				local __wf_atom_e919fb8e = creator:__wf_atom_e919fb8e()

				if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.SpawnedLoudSpeakerTable) then
					local tableGetIndex = module2.TableGetIndex(__wf_atom_e919fb8e.SpawnedLoudSpeakerTable, object)

					if not __wf_atom_7e8ad928(tableGetIndex) then
						table.remove(__wf_atom_e919fb8e.SpawnedLoudSpeakerTable, tableGetIndex)
					end
				end
			end

			fn2(__wf_atom_679ed446, object, speakerDropTable)
		elseif __wf_atom_679ed446:IsA(v12) then
			gRegion:__wf_atom_2202ffb6():__wf_atom_192b9cb0(
				2,
				31,
				object:GetPosition(),
				object,
				0,
				loudSpeakerAlertPerceptionRadius,
				true
			)
		end
	end
end

function CleanUp(object, object2)
	local __wf_atom_679ed446 = object2:__wf_atom_679ed446()

	if not __wf_atom_7e8ad928(__wf_atom_679ed446) and __wf_atom_679ed446:IsA(v12) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.SpawnedLoudSpeakerTable) then
		for i = 1, #__wf_atom_e919fb8e.SpawnedLoudSpeakerTable do
			__wf_atom_e919fb8e.SpawnedLoudSpeakerTable[i]:Destroy()
		end
	end
end

local function fn8(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v13 = {
		__wf_atom_7b01f9ce,
		__wf_atom_d127f143,
		__wf_atom_43e0c427,
		__wf_atom_3feeb44a,
		__wf_atom_4ebf67cb
	}
	local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
	__wf_atom_4e50d390.bank = 0
	local v14 = 1 - __wf_atom_421b01aa(math.abs(__wf_atom_4e50d390.pitch / 90), 0, 1)
	local v15 = birdSummonOffset.z * v14
	local v16 = birdSummonOffset.y * v14
	local selected = object:EyePosition() + __wf_atom_9341614d(Vector(birdSummonOffset.x, v16, v15), __wf_atom_4e50d390)
	local v17 = Vector()

	if not __wf_atom_7e8ad928((gRegion:__wf_atom_fbb89790(object:EyePosition(), selected, 0.2, nil, v13, nil, v17))) then
		selected = v17
	end

	selected.y = object:EyePosition().y
	return selected
end

function spawnBird(p, p2, perchPoint, forcePerch)
	local __wf_atom_402b3832 = v5:__wf_atom_402b3832(
		p2,
		fn8(p),
		perchPoint:__wf_atom_dc309f8a(),
		EMPTY_SYMBOL,
		0,
		true,
		0,
		0
	)

	if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
		local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()
		local __wf_atom_e919fb8e = __wf_atom_50a7d83e:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.perchPoint) then
			__wf_atom_e919fb8e.perchPoint = perchPoint
		end

		__wf_atom_e919fb8e.ForcePerch = forcePerch
		__wf_atom_50a7d83e:SetMeshScale(2)
		__wf_atom_402b3832:__wf_atom_b783ff91(perchPoint:__wf_atom_a2a18137(), 0)
	end
end

local function fn9() -- 1 equivalent call inferred from this helper
	return gRegion:IsMaster() and 3 or 4
end

function CreateBirdFeeder(object, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return
	end

	object:Disable()
	object:__wf_atom_e95c24e1(object2:__wf_atom_a96eb2aa())
	module2.UnequipWeapon(object2, true)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local v13 = __wf_atom_3d96ddcd:__wf_atom_f582136d(WeakResource("/SF/Types/Gameplay/BirdFeederAttachPoint"))[#__wf_atom_3d96ddcd:__wf_atom_f582136d(birdFeederType) + 1]
	local v14 = __wf_atom_3d96ddcd:Attach(
		birdFeederType,
		EMPTY_SYMBOL,
		v13:__wf_atom_fa6a8faf(),
		v13:__wf_atom_45c0553e(),
		object2,
		fn9() -- inferred equivalent call
	)

	if not __wf_atom_7e8ad928(v14) then
		v14:SetMeshScale(v13:__wf_atom_c082fc3d(), true)
	end

	local v15 = math.random()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BirdFeederCine"))
	local flag = false
	local flag2 = false
	local maleBirdDrop2

	if v15 <= maleSpawnChance then
		v3 = birdAgentTypes[1]
		maleBirdDrop2 = maleBirdDrop
		flag = true
	else
		v3 = birdAgentTypes[2]
		maleBirdDrop2 = femaleBirdDrop
		flag2 = true
	end

	local v16 = {}

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		if flag then
			if
				fn(object2, Resource("/SF/Types/Recipes/Holiday/MaleCardinalBlueprint"), true)
				and fn(object2, Resource("/SF/Types/Recipes/Holiday/FemaleCardinalBlueprint"))
			then
				maleBirdDeco = Type()
				table.insert(v16, 1, (gRegion:CreateEntity(maleBirdDeco, __wf_atom_28d5d4aa, __wf_atom_80368bb1)))
				table.insert(v16, 2, (gRegion:CreateEntity(femaleBirdDeco, __wf_atom_28d5d4aa, __wf_atom_80368bb1)))
			else
				table.insert(v16, 1, (gRegion:CreateEntity(maleBirdDeco, __wf_atom_28d5d4aa, __wf_atom_80368bb1)))
			end
		elseif flag2 then
			if
				fn(object2, Resource("/SF/Types/Recipes/Holiday/MaleCardinalBlueprint"))
				and fn(object2, Resource("/SF/Types/Recipes/Holiday/FemaleCardinalBlueprint"), true)
			then
				table.insert(v16, 1, (gRegion:CreateEntity(maleBirdDeco, __wf_atom_28d5d4aa, __wf_atom_80368bb1)))
			end

			table.insert(v16, 2, (gRegion:CreateEntity(femaleBirdDeco, __wf_atom_28d5d4aa, __wf_atom_80368bb1)))
		end

		for k, v17 in pairs(v16) do
			local v18 = String("Cardinal" .. tostring(k))
			v17:__wf_atom_e5d015a7(Symbol(v18))
			__wf_atom_0a6a5887:ReinitializeGreenRoom()
			__wf_atom_0a6a5887:__wf_atom_a3d2b66b(v17, Symbol(v18))
		end

		__wf_atom_0a6a5887:SetInstigatorAvatar(object2)
		module2.PlayCinematicWithTagRelativeAndWait(
			Symbol("BirdFeederCine"),
			Symbol("Envoy"),
			object2:GetPosition(),
			object2:__wf_atom_dc309f8a(),
			0
		)

		for _, v17 in pairs(v16) do
			v17:__wf_atom_e5d015a7(Symbol(""))
			gRegion:__wf_atom_dd1e4d10(v17)
		end
	end

	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return
	end

	if not __wf_atom_7e8ad928(requiredItem) then
		__wf_atom_d2b2176d:__wf_atom_5106368a(requiredItem)
		fn2(object2, nil, maleBirdDrop2)
	end

	if not __wf_atom_7e8ad928(object) then
		object:Enable()
	end
end

function BirdFeederEntity(object)
	if not gRegion:IsMaster() then
		return
	end

	Sleep(0.5)
	v5 = gRegion:__wf_atom_2202ffb6()
	v4 = v5:__wf_atom_7d789620()
	local taggedChildren = module2.FindTaggedChildren(object:__wf_atom_be0bea4a(), Symbol("SparrowPerchPoint"))
	module2.WaitForCinematicWithTagToFinish(Symbol("BirdFeederCine"))
	Sleep(2)
	fn7(object, taggedChildren)

	while not __wf_atom_7e8ad928(mHint) and mHint:__wf_atom_4026dfb5() == 2 do
		Sleep(0)
	end

	module5.EnableNearestTaggedSoundSysVolume(Symbol("ThawtideMusic"), false, mHint:GetPosition())
end

function BirdRaiseHack(object)
	local total = 0

	while not __wf_atom_7e8ad928(object) and total < 1 do
		local position2 = object:GetPosition()
		total += __wf_atom_084b3e93() * 0.5
		position2.y += __wf_atom_084b3e93() * 1
		object:SetPosition(position2)
		Sleep(0)
	end
end

function BirdEscape(object)
	object:__wf_atom_8a035cd5(Symbol("BirdRaiseHack"), false)
	object:__wf_atom_921c1a5f(escapeAnims[__wf_atom_5784a397(1, #escapeAnims)], true, false, 12, EMPTY_SYMBOL, 0.75)
	gRegion:__wf_atom_dd1e4d10(object)
end

function FreeTheBirds(object, object2, _)
	if not __wf_atom_7e8ad928(playerFeedingAnim) then
		local __wf_atom_921c1a5f = object2:__wf_atom_921c1a5f(playerFeedingAnim, false, 4, 1, true)
		local v13 = playerFeedingAnim:__wf_atom_091354f5(Symbol("BreakTrap")) * __wf_atom_921c1a5f
		local total = 0

		while total < v13 do
			Sleep(0)
			total += __wf_atom_084b3e93()
		end
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_e919fb8e = __wf_atom_3d96ddcd:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e and __wf_atom_e919fb8e.trappedDecos then
		for i = 1, #__wf_atom_e919fb8e.trappedDecos do
			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.trappedDecos[i]) then
				__wf_atom_e919fb8e.trappedDecos[i]:__wf_atom_8a035cd5(Symbol("BirdEscape"), false)
			end
		end
	end

	__wf_atom_e919fb8e.trappedDecos = nil
	gRegion:__wf_atom_2202ffb6():__wf_atom_192b9cb0(2, 21, object2:GetPosition(), object2, 0, 60, true)
	__wf_atom_3d96ddcd:Destroy()
	fn2(object2, object, speakerDropTable)
	module5.PlaySound(thawtideBirdRescueStinger)
end

function OnEnemyKilled(p)
	if _T.WinterBirdFeederEncounterKills and _T.WinterBirdFeederEncounterKills[p] then
		_T.WinterBirdFeederEncounterKills[p] += 1
	end
end