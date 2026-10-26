local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("Lotus.Scripts.Libs.AudioLib")
Symbol("RandomTeam")
local v = Symbol("Grineer")
local v2 = nil
local position = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = false
local v8 = Symbol("activeGarrenEncounterStat")
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = 0

local function fn(_, _)
	if __wf_atom_7e8ad928(__wf_atom_fdac9dcb) then
		return
	end

	local v13 = Range(0, 3)
	local encounterLootSpawns = module.GetEncounterLootSpawns(position, v13)

	if not __wf_atom_7e8ad928(encounterLootSpawns) and #encounterLootSpawns > 0 then
		local v14 = __wf_atom_5784a397(1, #encounterLootSpawns)
		local pos = encounterLootSpawns[v14].pos
		local rot = encounterLootSpawns[v14].rot

		if __wf_atom_7e8ad928(encounterLootSpawns[v14].spawnPt) then
			pos, rot = module3.GetGroundAlignedSpawnPosRot(
				__wf_atom_fdac9dcb,
				encounterLootSpawns[v14].pos,
				encounterLootSpawns[v14].rot,
				false,
				30
			)
		end

		if __wf_atom_7e8ad928(pos) then
			pos = position
			rot = __wf_atom_80368bb1
		end

		v9 = module.SpawnLootContainer(__wf_atom_fdac9dcb, pos, rot, true, v3)
		table.remove(encounterLootSpawns, v14)
		v9:__wf_atom_68f2c268(0)
		v3:__wf_atom_d494454b(v9)
	end
end

local function fn2()
	position = module3.GetGroundPos(position)
	local groundAlignedSpawnPosRot, v13 = module3.GetGroundAlignedSpawnPosRot(
		summoningPitObejcts[1],
		position,
		Rotation(__wf_atom_5784a397(0, 360), 0, 0)
	)

	if #summoningPitObejcts > 0 then
		for _, v14 in ipairs(summoningPitObejcts) do
			if enableDebug then
				gRegion:__wf_atom_8d991675(groundAlignedSpawnPosRot, 3, SummoningPitDebugColour, 3)
			end

			local entity = gRegion:CreateEntity(v14, groundAlignedSpawnPosRot, v13)
			v3:__wf_atom_d494454b(entity)
		end
	end
end

local function fn3(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v13 = math.max(object:__wf_atom_4a0ffa6e(), 120)
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local enemyLevel = module.GetEnemyLevel(object)
	local v14 = Range(1, 20)
	local v15 = __wf_atom_421b01aa((enemyLevel.maxValue - v14.minValue) / (v14.maxValue - v14.minValue), 0, 1)
	local v16 = __wf_atom_104bfe98(xpAmount.minValue, xpAmount.maxValue, v15)
	local rounded = module2.Round(v16, -2)

	for _, v17 in pairs(__wf_atom_3c8e1a7a) do
		local playerAvatar = v17:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) then
			continue
		end

		local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

		if __wf_atom_7e8ad928(__wf_atom_d2b2176d) or not (playerAvatar:__wf_atom_1c8f7b2d(object) <= v13) then
			continue
		end

		local _ = playerAvatar:GetPosition() + playerAvatar:__wf_atom_acb19668() * 2
		__wf_atom_d2b2176d:__wf_atom_355b9a20(rounded, playerAvatar, EMPTY_SYMBOL)
	end
end

local function fn4(object, bonesToHide)
	for _, v13 in ipairs(bonesToHide) do
		object:__wf_atom_83fac646(v13, __wf_atom_80368bb1, __wf_atom_28d5d4aa, Vector(0.001, 0.001, 0.001))
	end
end

local function fn5(heardAgent, groundPos, p, p2, p3, p4)
	if __wf_atom_7e8ad928(heardAgent) then
		return
	end

	local all = gRegion:FindAll(heardAgent)
	local v13, v14

	if #all > 0 then
		v13 = all[1]
		v14 = v13:__wf_atom_30e3d82b()
	end

	if __wf_atom_7e8ad928(v13) then
		local v15 = Range(v2:__wf_atom_dcf48c53(), v2:__wf_atom_57203011())

		if module2.IsInOverworld() then
			v15 = module.GetEnemyLevel(v3)
		end

		local v16 = v15.maxValue + 5
		v14 = v2:__wf_atom_402b3832(heardAgent, groundPos, p, v, v16)

		if __wf_atom_7e8ad928(v14) then
			print(heardAgent:__wf_atom_5b41f63b() .. " agent faild to spawn")
			return
		else
			v3:__wf_atom_97f955c1(v14)
		end
	end

	local __wf_atom_50a7d83e = v14:__wf_atom_50a7d83e()
	__wf_atom_50a7d83e:Teleport(groundPos, p)
	__wf_atom_50a7d83e:__wf_atom_7c8621d6()
	__wf_atom_50a7d83e:GetMaxHealth()
	__wf_atom_50a7d83e:SetVisibility(p4)
	__wf_atom_50a7d83e:__wf_atom_d1b42aad(p2)
	__wf_atom_50a7d83e:__wf_atom_30964595(p2)
	__wf_atom_50a7d83e:__wf_atom_0ed81088(p2)
	__wf_atom_50a7d83e:SetDisableGravity(p3)
	__wf_atom_50a7d83e:SetBlackboardBool(Symbol("CanFight"), false)
	module2.SetImmunity(v6, true)
	fn4(__wf_atom_50a7d83e, bonesToHide)
	_T.ActiveWorldBossAvatar = __wf_atom_50a7d83e
	return __wf_atom_50a7d83e
end

function RemoveStag()
	module2.SetImmunity(v6, true)
	v6:SetBlackboardBool(Symbol("CanFight"), false)
	local v13 = Symbol("BossAwarenessTrigger")
	local __wf_atom_f582136d = v6:__wf_atom_f582136d(__wf_atom_589cefdb)

	for _, v14 in ipairs(__wf_atom_f582136d) do
		if __wf_atom_7e8ad928(v14) or v14:__wf_atom_db682341() ~= v13 then
			continue
		end

		v14:Disable()
	end

	if _T.MinibossRevealed ~= nil and _T.MinibossRevealed[v6] and not __wf_atom_7e8ad928(BossFailedAnim) then
		v6:__wf_atom_921c1a5f(BossFailedAnim, true, 3, 3, true)
	end

	v6:Destroy()
end

local function fn6() -- 2 equivalent calls inferred from this helper
	return (Symbol("VadagarStag-SubBoss"))
end

function EncounterSuccsess()
	local position2 = v6:GetPosition()
	local __wf_atom_dc309f8a = v6:__wf_atom_dc309f8a()

	while v6:__wf_atom_c138b19b(stagDeathAnim) do
		Sleep(0)
	end

	if not isTale then
		local v13 = fn6() -- inferred equivalent call
		gGameData:__wf_atom_a975522c(v13, 10800, true, "")
	end

	fn3(v3)
	fn(position2, __wf_atom_dc309f8a)
	local total = 0

	while not __wf_atom_7e8ad928(v9) or total <= chestLifeTime do
		if chestLifeTime <= total then
			v9:Destroy()
			break
		else
			total += __wf_atom_084b3e93()
			Sleep(0)
		end
	end
end

local function fn7(object)
	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 1 then
		local groundPos = module3.GetGroundPos(position)

		if not __wf_atom_7e8ad928(randomCombatBlockingContainerType) then
			v10 = module.SpawnCombatBlockingContainer(randomCombatBlockingContainerType, object:GetPosition())
		end

		if __wf_atom_7e8ad928(groundPos) then
			print("Error: Couldn't find ground position for mini garrenspawn, falling back to hint position!")
			groundPos = position
		end

		fn2()
		v6 = fn5(heardAgent, groundPos, object:__wf_atom_dc309f8a(), false, true, false)
		v5 = v3:__wf_atom_6199ef01()
		module.CleanUpOutOfRangeEnemies(v3, v5)

		if __wf_atom_7e8ad928(v3) then
			print("Shutdown due to level streaming")
			return
		end

		v11 = gRegion:__wf_atom_8ad59546()
		v3:__wf_atom_8e6fec76(2)
	else
		if __wf_atom_4026dfb5 == 2 then
			return
		end

		if __wf_atom_4026dfb5 == 5 then
			v3:__wf_atom_8e6fec76(6)
		elseif __wf_atom_4026dfb5 == 4 then
			if v7 and not __wf_atom_7e8ad928(musicTag) then
				module4.EnableTaggedSoundSysVolumes(musicTag, false)
			end

			v7 = false
		elseif __wf_atom_4026dfb5 == 6 then
			if v7 and not __wf_atom_7e8ad928(musicTag) then
				module4.EnableTaggedSoundSysVolumes(musicTag, false)
			end

			v7 = false

			if __wf_atom_7e8ad928(v3) then
				print("Shutdown due to level streaming")
				return
			end

			if module.ShouldShutDown(v3) then
				v3:__wf_atom_8776856a(#v5)
				module.RemoveAgents(v3)
				v10:Destroy()
			end

			while not __wf_atom_7e8ad928(v3) and v3:__wf_atom_e464a32f() > 0 and v2:__wf_atom_c6f505f2(v3) > 0 do
				Sleep(0)
			end

			if __wf_atom_7e8ad928(v3) then
				print("Shutdown due to level streaming")
				return
			end

			module.RemoveAgents(v3)
			module.RemoveObjects(v3)
			Sleep(0)
		elseif __wf_atom_4026dfb5 == 0 then
			print("encoutner status is currently none")
		end
	end
end

function Initialize(object)
	v2 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return
	end

	if not isTale then
		local v13 = fn6() -- inferred equivalent call

		if not gGameData:__wf_atom_20bf298d(v13) then
			return
		end
	end

	v3 = object
	v4 = object:__wf_atom_26b04ea9() or object
	position = object:GetPosition()
	object:__wf_atom_7dd025d4(fn7, v8)
	object:__wf_atom_8e6fec76(1)
	fn7(object)

	while not module.PrimedMissionShouldShutDown(v3, v4) do
		if object:__wf_atom_4026dfb5() == 2 then
			if module.ShouldShutDown(object, v4) then
				object:__wf_atom_8e6fec76(6)
			end

			v5 = v3:__wf_atom_6199ef01()
			module.CleanUpOutOfRangeEnemies(v3, v5)

			if not v7 and not __wf_atom_7e8ad928(v6) and _T.MinibossRevealed ~= nil and _T.MinibossRevealed[v6] then
				if not __wf_atom_7e8ad928(musicTag) then
					module4.EnableTaggedSoundSysVolumes(musicTag, true)
				end

				v7 = true
			end

			if __wf_atom_7e8ad928(v6) then
				print("Shutting down because Stag is null")
				object:__wf_atom_8e6fec76(6)
			elseif v6:IsKilled() then
				if v7 and not __wf_atom_7e8ad928(musicTag) then
					module4.EnableTaggedSoundSysVolumes(musicTag, false)
				end

				v7 = false
				object:__wf_atom_8e6fec76(4)
				EncounterSuccsess()
				break
			else
				local v13

				if not (isTale or encounterTODWIndowEnd < 0 or encounterTODWIndowEnd < 0) then
					v12 = v11:__wf_atom_cb3427c9()
					v13 = v12 >= 0 and v12 <= encounterTODWIndowEnd or v12 >= encounterTODWindowStart and v12 <= 24
				end

				if v13 == false then
					v6:__wf_atom_8a035cd5(Symbol("RemoveStag"), false)
					object:__wf_atom_8e6fec76(5)
				end
			end
		end

		Sleep(0)
	end

	if object:__wf_atom_4026dfb5() ~= 4 then
		object:__wf_atom_8e6fec76(6)
	end

	if _T.MinibossRevealed ~= nil then
		_T.MinibossRevealed[v6] = nil
	end

	module.RemoveAgents(object)
end