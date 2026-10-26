local v = Symbol("TeamCircade")
local v2 = Symbol("CircadeSpawned")
local module = require("EE.Interface.Utilities")
local module2 = require("SF.Scripts.Libs.RaycastLib")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("SF.Scripts.Libs.RespawnLib")
local module5 = require("SF.Scripts.NightFoldLib")
local module6 = require("SF.Scripts.Libs.TransmissionSet")
local module7 = require("SF.Scripts.Libs.StatsLib")
local v3 = nil

local function fn()
	local __wf_atom_7e323ec3 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_7e323ec3()

	for _, v4 in pairs(__wf_atom_7e323ec3) do
		if v4:__wf_atom_a5a91da2() then
			return true
		end
	end

	return false
end

local function fn2()
	_T.RandomCircadeDefeated = _T.RandomCircadeDefeated or {}
	local circadeEnemies = circadeEnemies
	local shuffleTable = module.ShuffleTable(circadeEnemies)
	local v4 = __wf_atom_5784a397(1, #shuffleTable)
	local v5 = shuffleTable[v4]
	local v6 = false

	for _, v7 in pairs(shuffleTable) do
		for _, v8 in pairs(_T.RandomCircadeDefeated) do
			if v7 ~= v8 then
				continue
			end

			v6 = true
			break
		end

		if v6 then
			continue
		end

		table.insert(_T.RandomCircadeDefeated, v7)
		v5 = v7
		break
	end

	v3 = circadeNames[v4]
	return v5
end

local function fn3(list, items)
	local v4 = list[1]
	local flag = nil

	for _, v5 in pairs(list) do
		flag = true

		for _, item in pairs(items) do
			if not (Distance(v5:GetPosition(), item:GetPosition()) < 15) then
				continue
			end

			flag = false
		end

		if not flag then
			continue
		end

		v4 = v5
		break
	end

	if not flag then
		print("=== There where no better candidates on this proc ===")
	end

	return v4
end

local function fn4(object, object2)
	return object:__wf_atom_5b41f63b() < object2:__wf_atom_5b41f63b()
end

function SetUpSymbols()
	module3.WaitForLevel()

	while Game.__wf_atom_2b221245(false) do
		Sleep(0)
	end

	Sleep(5)
	print("Setting up crypt symbols ======")
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("CIRCADE_DESTINATION_RED"))
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("CIRCADE_DESTINATION_BLUE"))
	local __wf_atom_2226b35c3 = gRegion:__wf_atom_2226b35c(Symbol("CIRCADE_DESTINATION_GREEN"))

	if #__wf_atom_2226b35c < 0 or #__wf_atom_2226b35c2 < 0 or #__wf_atom_2226b35c3 < 0 then
		print("==== One of the symbols was not found ===")
		return
	end

	local v4 = __wf_atom_04d7eaaa()
	__wf_atom_01bfe5c4(gGameRules:__wf_atom_d7c43e35())

	for i = 1, #__wf_atom_2226b35c do
		__wf_atom_2226b35c[i]:SetVisibility(false, true)
	end

	for i = 1, #__wf_atom_2226b35c2 do
		__wf_atom_2226b35c2[i]:SetVisibility(false, true)
	end

	for i = 1, #__wf_atom_2226b35c3 do
		__wf_atom_2226b35c3[i]:SetVisibility(false, true)
	end

	table.sort(__wf_atom_2226b35c, fn4)
	table.sort(__wf_atom_2226b35c2, fn4)
	table.sort(__wf_atom_2226b35c3, fn4)
	local seededShuffleTable = module.SeededShuffleTable(__wf_atom_2226b35c)
	local seededShuffleTable2 = module.SeededShuffleTable(__wf_atom_2226b35c2)
	local seededShuffleTable3 = module.SeededShuffleTable(__wf_atom_2226b35c3)
	__wf_atom_01bfe5c4(v4)
	local v5 = { seededShuffleTable[1] }
	v5[2] = fn3(seededShuffleTable2, v5)
	v5[3] = fn3(seededShuffleTable3, v5)
	print("Setting up crypt symbols ======")
	v5[1]:SetVisibility(true, true)
	v5[2]:SetVisibility(true, true)
	v5[3]:SetVisibility(true, true)
	v5[1]:__wf_atom_b811702e(Symbol("RedCircadeRune"))
	v5[2]:__wf_atom_b811702e(Symbol("BlueCircadeRune"))
	v5[3]:__wf_atom_b811702e(Symbol("GreenCircadeRune"))
	v5[1]:Attach(
		redMuralHintSeq,
		Symbol("RedCircadeRune"),
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		nil,
		module.Ternary(gRegion:IsMaster(), 3, 4)
	)
	v5[2]:Attach(
		blueMuralHintSeq,
		Symbol("BlueCircadeRune"),
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		nil,
		module.Ternary(gRegion:IsMaster(), 3, 4)
	)
	v5[3]:Attach(
		greenMuralHintSeq,
		Symbol("BlueCircadeRune"),
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		nil,
		module.Ternary(gRegion:IsMaster(), 3, 4)
	)
end

local function fn5(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local taggedChild = module3.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("BossAwarenessTrigger"))

	if __wf_atom_7e8ad928(taggedChild) then
		taggedChild = object:Attach(
			Resource("/SF/Types/Enemies/Bosses/ReplicatedPlayerAwarenessScriptTrigger"),
			Symbol("GAME_C1_SPINE1"),
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)
	end

	if __wf_atom_7e8ad928(v3) then
		object:__wf_atom_17e77e5b(Localize("/SF/Language/Characters/CircadeGhost", nil))
	else
		object:__wf_atom_17e77e5b(Localize(v3, nil))
	end

	object:__wf_atom_5cb037b2(Symbol("/SF/Language/Characters/CircadeGhost"))
	taggedChild:Enable()
	taggedChild:__wf_atom_400189c4(20)
end

local function fn6(object, object2) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(object2) then
		return __wf_atom_80368bb1
	end

	local __wf_atom_a2a18137 = object2:__wf_atom_a2a18137()
	local v4 = __wf_atom_fa8d0177(object:GetPosition(), __wf_atom_a2a18137)
	v4.pitch = 0
	v4.bank = 0
	return v4
end

function StartFight()
	print("Starting fight ======")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CircadeEnemy"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("BossSpawnWp"))
	local v4 = fn2()

	if
		__wf_atom_7e8ad928(__wf_atom_0a6a5887)
		and not (__wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2))
	then
		local nearestTagged = gRegion:FindNearestTagged(Symbol("ChampionStatue"), __wf_atom_0a6a5887_2:GetPosition())

		if not __wf_atom_7e8ad928(nearestTagged) then
			local v5 = nearestTagged:GetPosition() + Vector(0, 2, 0)
			local v6 = __wf_atom_0a6a5887_2:GetPosition() + Vector(0, 0.15, 0)
			nearestTagged:Attach(deathStatueFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa)
			local entity = gRegion:CreateEntity(deathFX, v5, __wf_atom_80368bb1)
			Sleep(0.16)
			local v7 = 0
			local v8 = __wf_atom_f55d6358(v5, v6, v7)

			while v7 < 4 do
				v7 = __wf_atom_421b01aa(v7 + __wf_atom_084b3e93(), 0, 4)
				local v9 = -(math.cos(3.141592653589793 * v7 / 4) - 1) / 2
				v8 = __wf_atom_f55d6358(v5, v6, v9)
				entity:SetPosition(v8)
				Sleep(0)
			end

			entity:Destroy()
			gRegion:CreateEntity(spawnFX, v8, __wf_atom_80368bb1)
			local v9 = fn6(__wf_atom_0a6a5887_2, gRegion:__wf_atom_c4f78a8f()) -- inferred equivalent call
			__wf_atom_0a6a5887 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_402b3832(
				v4,
				__wf_atom_0a6a5887_2:GetPosition(),
				v9,
				v,
				3
			)

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				local __wf_atom_50a7d83e = __wf_atom_0a6a5887:__wf_atom_50a7d83e()
				__wf_atom_50a7d83e:__wf_atom_68f2c268(1)
				local v10 = 3
				local v11 = v10

				while not __wf_atom_7e8ad928(__wf_atom_50a7d83e) and v10 > 0 do
					v10 = __wf_atom_421b01aa(v10 - __wf_atom_084b3e93(), 0, v11)
					__wf_atom_50a7d83e:__wf_atom_68f2c268(v10 / v11)
					Sleep(0)
				end
			end

			Sleep(0.1)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		module6.PlayGlobalTransmission(circadeTransmissionSet, Symbol("Spawn"), false)
		fn5(__wf_atom_0a6a5887:__wf_atom_50a7d83e())
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

		if not __wf_atom_7e8ad928(__wf_atom_3c8e1a7a) then
			_T.StatsCircadeBossHandle = module7.StartSubBossFight(
				__wf_atom_0a6a5887:__wf_atom_50a7d83e(),
				#__wf_atom_3c8e1a7a,
				"Crypt",
				Range(3, 3)
			)
		end
	end
end

function SpawnCircadeInWorld(object)
	if
		not module3.IsInOverworld(gRegion:__wf_atom_c4f78a8f())
		or module3.IsInNightFold(object)
		or _T.circadeSpawnedAlready == true
		or fn()
	then
		return false
	end

	module5.RegisterPreventNighfoldUsage(true)
	module5.SetPreventNightfoldUsageReason(module5.BT_COMBAT)
	_T.circadeSpawnedAlready = true
	_T.CircadeAgent = nil
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CircadeEnemy"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("====== Spawning Circade in world ======")
		local v4 = object:GetPosition() + Vector(0, 1, 0)
		local entity = gRegion:CreateEntity(deathFX, __wf_atom_28d5d4aa, __wf_atom_80368bb1, nil, nil, 1)
		local randomPointInRangeOnNav = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():GetRandomPointInRangeOnNav(
			object:GetPosition(),
			5,
			20,
			true,
			0.1
		)
		object:Attach(deathStatueFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa)
		Sleep(0.16)
		local v5 = 0

		if not __wf_atom_7e8ad928(object) then
			local _ = object:GetPosition() + Vector(0, 2.8, 0)
			__wf_atom_f55d6358(v4, randomPointInRangeOnNav, v5)

			while not __wf_atom_7e8ad928(object) and v5 < 4 do
				v5 = __wf_atom_421b01aa(v5 + __wf_atom_084b3e93(), 0, 4)
				local v6 = -(math.cos(3.141592653589793 * v5 / 4) - 1) / 2
				local v7 = __wf_atom_f55d6358(v4, randomPointInRangeOnNav, v6)

				if not __wf_atom_7e8ad928(entity) then
					entity:SetPosition(v7)
				end

				Sleep(0)
			end

			if not __wf_atom_7e8ad928(entity) then
				entity:Destroy()
			end
		end

		if
			not __wf_atom_7e8ad928(circadeEnemy)
			and module3.IsInOverworld(object)
			and not module3.IsInNightFold(object)
		then
			local __wf_atom_402b3832 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_402b3832(
				circadeEnemy,
				randomPointInRangeOnNav,
				__wf_atom_80368bb1,
				v,
				3
			)

			if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
				print("====== Circade in world spawned ======")
				local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()
				__wf_atom_50a7d83e:__wf_atom_68f2c268(1)
				__wf_atom_55142dd4(__wf_atom_50a7d83e, "OnKilled")
				local v6 = 1

				while not __wf_atom_7e8ad928(__wf_atom_50a7d83e) and v6 > 0 do
					v6 = __wf_atom_421b01aa(v6 - __wf_atom_084b3e93(), 0, 1)
					__wf_atom_50a7d83e:__wf_atom_68f2c268(v6)
					Sleep(0)
				end

				fn5(__wf_atom_50a7d83e)
				gGameRules:__wf_atom_28869475("OnPlayerDeath")

				if __wf_atom_7e8ad928(__wf_atom_402b3832) then
					print("Streaming...")
				else
					__wf_atom_402b3832:__wf_atom_30b587a4()
					_T.CircadeAgent = __wf_atom_402b3832
					_T.CircadeInWorld = true
					_T.PlayerDiedDuringEncounter = false
				end
			end
		end
	else
		print("==== Circade already spawned in the world! Binding agent")
		__wf_atom_55142dd4(__wf_atom_0a6a5887, "OnKilled")
		fn5(__wf_atom_0a6a5887)
		gGameRules:__wf_atom_28869475("OnPlayerDeath")
		__wf_atom_0a6a5887:__wf_atom_30e3d82b():__wf_atom_30b587a4()
		_T.CircadeInWorld = true
		_T.PlayerDiedDuringEncounter = false
		_T.CircadeAgent = __wf_atom_0a6a5887:__wf_atom_30e3d82b()
	end

	return not __wf_atom_7e8ad928(_T.CircadeAgent)
end

function _HandleTotemBrightness(object)
	Sleep(1)

	if _T.HandlingTotemBrightness then
		return
	end

	_T.HandlingTotemBrightness = true
	local nearestTagged = gRegion:FindNearestTagged(Symbol("CircadeTotem"), object:GetPosition())

	while not (__wf_atom_7e8ad928(object) or object:HasItem(circadeDefeatedToken) or __wf_atom_7e8ad928(nearestTagged)) do
		local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
		nearestTagged = gRegion:FindNearestTagged(Symbol("CircadeTotem"), object:GetPosition())

		if not __wf_atom_7e8ad928(nearestTagged) then
			if __wf_atom_7e8ad928(gGameData) or gGameData:__wf_atom_20bf298d(v2) then
				if
					minInvasionTime - 1 <= __wf_atom_cb3427c9 and __wf_atom_cb3427c9 < minInvasionTime
					or minInvasionTime == 0 and __wf_atom_cb3427c9 >= 23
				then
					nearestTagged:SetMaterialParam(Symbol("EmissiveMapAtten"), 30)
				elseif minInvasionTime <= __wf_atom_cb3427c9 and __wf_atom_cb3427c9 <= maxInvasionTime then
					nearestTagged:SetMaterialParam(Symbol("EmissiveMapAtten"), 80)
				elseif maxInvasionTime < __wf_atom_cb3427c9 and __wf_atom_cb3427c9 <= maxInvasionTime + 1 then
					nearestTagged:SetMaterialParam(Symbol("EmissiveMapAtten"), 30)
				else
					nearestTagged:SetMaterialParam(Symbol("EmissiveMapAtten"), 10)
				end
			else
				nearestTagged:SetMaterialParam(Symbol("EmissiveMapAtten"), 10)
			end
		end

		Sleep(5)
	end

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:SetMaterialParam(Symbol("EmissiveMapAtten"), 0)
	end

	_T.HandlingTotemBrightness = false
end

function HandleCurse(circadeCursedPlayerAvatar)
	gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
	_T.circadeSpawnedAtDawn = _T.circadeSpawnedAtDawn or false
	_T.circadeSpawnedAtDusk = _T.circadeSpawnedAtDusk or false
	_T.circadeSpawnedAtMidnight = _T.circadeSpawnedAtMidnight or false
	local _ = minInvasionTime - 1
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("CircadeTotem"))

	while not (__wf_atom_7e8ad928(circadeCursedPlayerAvatar) or circadeCursedPlayerAvatar:HasItem(circadeDefeatedToken)) do
		local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()

		if _T.PlayerDiedDuringEncounter then
			gGameRules:__wf_atom_09f9b5f5("OnPlayerDeath")
		end

		__wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("CircadeTotem"))

		if
			module3.IsInOverworld(circadeCursedPlayerAvatar)
			and not _T.CircadeInWorld
			and not module3.IsInNightFold(circadeCursedPlayerAvatar)
			and gRegion:IsMaster()
		then
			print("======Player is in overworld so circade can spawn")
			print(module3.IsInOverworld())
			local v4 = not __wf_atom_7e8ad928(circadeDefeatedToken)
				and circadeCursedPlayerAvatar:HasItem(circadeDefeatedToken)
			_T.circadeSpawnedAlready = _T.circadeSpawnedAlready or v4

			if
				minInvasionTime <= __wf_atom_cb3427c9
				and __wf_atom_cb3427c9 <= maxInvasionTime
				and not _T.circadeSpawnedAlready
				and gGameData:__wf_atom_20bf298d(v2)
			then
				print("====== Circade Spawning for this totem, at time:")
				print(__wf_atom_cb3427c9)

				if SpawnCircadeInWorld(circadeCursedPlayerAvatar) then
					gGameData:__wf_atom_a975522c(v2, 1200, true, "")
					_T.circadeSpawnedAlready = true
					_T.CircadeCursedPlayerAvatar = circadeCursedPlayerAvatar
				end
			elseif
				(__wf_atom_cb3427c9 < minInvasionTime or maxInvasionTime < __wf_atom_cb3427c9)
				and _T.circadeSpawnedAlready
			then
				print("=== Circade spawned already, and now it off its time")
				_T.circadeSpawnedAlready = false
			else
				if not __wf_atom_7e8ad928(gGameData) then
					print(gGameData:__wf_atom_20bf298d(v2))
				end

				print(v4)
				print(_T.circadeSpawnedAlready)
				print(minInvasionTime)
				print(__wf_atom_cb3427c9)
			end
		else
			print("Can not spawn Circade, player is not in overworld or not logged in, or is a client")
		end

		Sleep(15)
	end

	for _, v4 in pairs(__wf_atom_2226b35c) do
		if not __wf_atom_7e8ad928(v4) then
			v4:SetMaterialParam(Symbol("EmissiveMapAtten"), 0)
		end
	end

	_T.circadeSpawnedAlready = false
	gGameRules:__wf_atom_09f9b5f5("OnPlayerDeath")
end

function CircadesCurse(object)
	while not __wf_atom_a0f6588f:__wf_atom_f89aa44a() do
		Sleep(0)
	end

	Sleep(5)

	if __wf_atom_7e8ad928(object) then
		object = gRegion:__wf_atom_c4f78a8f()
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_a96eb2aa()) then
		return
	end

	print("=== Player that owns the totem: ")
	print(object:__wf_atom_a96eb2aa():__wf_atom_ef151cfd())

	if not __wf_atom_7e8ad928(circadeDefeatedToken) and object:HasItem(circadeDefeatedToken) then
		print("-- Circade was already banished from this totem --")
		return
	end

	print("-- Circade is not yet banished from this totem, so he will torment the player --")

	if object == gRegion:__wf_atom_c4f78a8f() then
		object:__wf_atom_8a035cd5(Symbol("_HandleTotemBrightness"), false)
	end

	if gRegion:IsMaster() then
		Sleep(200)
		HandleCurse(object)
	end
end

local function fn7(notePickUp, object)
	if not __wf_atom_7e8ad928(notePickUp) then
		print("======= Create Note PickUp ======")
		local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(object:GetPosition())
		local groundPos = module2.GetGroundPos(__wf_atom_0e0a6fee, Vector(0, 1, 0), Vector(0, -10, 0))
		gRegion:CreateEntity(notePickUp, groundPos, Rotation(__wf_atom_5784a397(0, 360), 0, 0))
	end
end

function MoveFXToMural(instance)
	local v4 = 0
	local position = instance:GetPosition()

	if not __wf_atom_7e8ad928(_T.DestSymbol) then
		local nearestTagged = gRegion:FindNearestTagged(_T.DestSymbol, instance:GetPosition())

		if not __wf_atom_7e8ad928(nearestTagged) then
			local position2 = nearestTagged:GetPosition()
			__wf_atom_f55d6358(position, position2, v4)

			while not __wf_atom_7e8ad928(instance) and v4 < 4 do
				v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93(), 0, 4)
				local v5 = -(math.cos(3.141592653589793 * v4 / 4) - 1) / 2
				instance:SetPosition((__wf_atom_f55d6358(position, position2, v5)))
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(deathStatueFX) then
				gRegion:CreateEntity(
					deathStatueFX,
					nearestTagged:GetPosition() + Vector(0, -2, 0),
					nearestTagged:__wf_atom_dc309f8a(),
					nil,
					nil,
					1
				)
			end

			Sleep(0.5)
			local nearestTagged2 = gRegion:FindNearestTagged(Symbol("MuralInteractFX"), nearestTagged:GetPosition())

			if not __wf_atom_7e8ad928(nearestTagged2) then
				nearestTagged2:SetVisibility(true, true)
			end

			local nearestTagged3 = gRegion:FindNearestTagged(Symbol("RevealFrescoAction"), position2)

			if not __wf_atom_7e8ad928(nearestTagged3) then
				nearestTagged3:Enable()
			end

			if gRegion:IsMaster() then
				instance:Destroy()
			end
		end
	end
end

function OnBossKilled(object)
	if not __wf_atom_7e8ad928(object) then
		_T.DestSymbol = nil
		gRegion:__wf_atom_ef7900cf()

		if __wf_atom_7e8ad928(gRegion:__wf_atom_439c0d29(
			Symbol("RedCircadeRune"),
			object:GetPosition(),
			0,
			circleRadious
		)) then
			if __wf_atom_7e8ad928(gRegion:__wf_atom_439c0d29(
				Symbol("BlueCircadeRune"),
				object:GetPosition(),
				0,
				circleRadious
			)) then
				if __wf_atom_7e8ad928(gRegion:__wf_atom_439c0d29(
					Symbol("GreenCircadeRune"),
					object:GetPosition(),
					0,
					circleRadious
				)) then
					print("===== No nearby symbol found")
					module6.PlayGlobalTransmission(circadeTransmissionSet, Symbol("NoMural"), false)
					fn7(notePickUp, object)
				else
					print("======= SYMBOL NEARBY FOUND ======")

					if not __wf_atom_7e8ad928(greenPickUp) then
						gRegion:CreateEntity(greenPickUp, __wf_atom_28d5d4aa, __wf_atom_80368bb1, nil, nil, 1)
					end

					module6.PlayGlobalTransmission(circadeTransmissionSet, Symbol("GreenMural"), false)
					_T.DestSymbol = Symbol("GreenCircadeRune")
					local _greenCompletedMaterial = greenCompletedMaterial
				end
			else
				print("======= SYMBOL NEARBY FOUND ======")

				if not __wf_atom_7e8ad928(bluePickUp) then
					gRegion:CreateEntity(bluePickUp, __wf_atom_28d5d4aa, __wf_atom_80368bb1, nil, nil, 1)
				end

				module6.PlayGlobalTransmission(circadeTransmissionSet, Symbol("BlueMural"), false)
				_T.DestSymbol = Symbol("BlueCircadeRune")
				local _blueCompletedMaterial = blueCompletedMaterial
			end
		else
			print("======= SYMBOL NEARBY FOUND ======")

			if not __wf_atom_7e8ad928(redPickUp) then
				gRegion:CreateEntity(redPickUp, __wf_atom_28d5d4aa, __wf_atom_80368bb1, nil, nil, 1)
			end

			module6.PlayGlobalTransmission(circadeTransmissionSet, Symbol("RedMural"), false)
			_T.DestSymbol = Symbol("RedCircadeRune")
			local _redCompletedMaterial = redCompletedMaterial
		end

		object:__wf_atom_8914dfde("deathVFX", 2)
		local v4 = object:GetPosition() + Vector(0, 2, 0)

		if not __wf_atom_7e8ad928(_T.DestSymbol) then
			gRegion:CreateEntity(deathFX, v4, __wf_atom_80368bb1)
		end

		if not __wf_atom_7e8ad928(object) then
			DissolveGhost(object)
		end
	end

	module7.EndSubBossFight(_T.StatsCircadeBossHandle, 4)
	_T.StatsCircadeBossHandle = nil
end

function OnBossKilledInWorld(_) end

function OnPlayerDeath(object)
	local __wf_atom_6ce58983 = object:__wf_atom_6ce58983()

	if
		__wf_atom_7e8ad928(__wf_atom_6ce58983)
		or not __wf_atom_6ce58983:__wf_atom_535d5cbb()
		or _T.PlayerDiedDuringEncounter
	then
		return
	end

	_T.PlayerDiedDuringEncounter = true

	if not (__wf_atom_7e8ad928(_T.CircadeAgent) or __wf_atom_7e8ad928(_T.CircadeAgent:__wf_atom_50a7d83e())) then
		_T.CircadeAgent:__wf_atom_50a7d83e():Suicide()
	end

	module5.RegisterPreventNighfoldUsage(false)
end

function OnKilled(object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not module3.IsInOverworld(__wf_atom_c4f78a8f) or module3.IsInNightFold(__wf_atom_c4f78a8f) then
		return
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_8914dfde("deathVFX", 2)

		if not __wf_atom_7e8ad928(object) then
			local _ = object:GetPosition() + Vector(0, 2, 0)

			if not _T.PlayerDiedDuringEncounter then
				if not __wf_atom_7e8ad928(rewardTrigger) then
					gRegion:CreateEntity(rewardTrigger, __wf_atom_28d5d4aa, __wf_atom_80368bb1, nil, nil, 1)
				end

				print("==== Circade died in world, rewarding players having the totem ====")
				module6.PlayGlobalTransmission(circadeTransmissionSet, Symbol("DeathMidrath"), false)
			end

			_T.PlayerDiedDuringEncounter = false
		end
	end

	_T.CircadeInWorld = false
	module5.RegisterPreventNighfoldUsage(false)
end

function SetUpRespawning()
	Sleep(0)
	module4.ActivateBlightZone(nil, true, true, true, AllPlayersKilled)

	while true do
		Sleep(0)

		if _T.BlightZone == nil then
			break
		end

		module4.UpdateBlightZone()
	end
end

function AllPlayersKilled()
	module3.Fade(true, 0.9, 1, true)
	module7.EndSubBossFight(_T.StatsCircadeBossHandle, 5)
	_T.StatsCircadeBossHandle = nil

	if gRegion:IsMaster() then
		Sleep(1)
		local __wf_atom_ade7f08f = gRegion:__wf_atom_ade7f08f()

		if
			not string.match(__wf_atom_ade7f08f.level:GetName(), "Crypt")
			and __wf_atom_a0f6588f:__wf_atom_f89aa44a()
		then
			__wf_atom_ade7f08f.migrateServer = true
			__wf_atom_ade7f08f.level = gClient:__wf_atom_5bb4e2aa()
			local all = gRegion:FindAll(__wf_atom_bc9e92c8)

			for _, v4 in ipairs(all) do
				local __wf_atom_babe9f00 = v4:__wf_atom_babe9f00()

				if not (string.len(__wf_atom_babe9f00) > 0) then
					continue
				end

				__wf_atom_ade7f08f.contextTags = {}
				__wf_atom_ade7f08f:__wf_atom_98718663(__wf_atom_babe9f00)
				break
			end

			Engine.OpenLevel(__wf_atom_ade7f08f)
		end
	end
end

local function fn8()
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gGameData:GetInventory()) then
		return false
	end

	local __wf_atom_71d5cc00 = gGameData:GetInventory():__wf_atom_71d5cc00()

	for _, v4 in ipairs(__wf_atom_71d5cc00) do
		if v4.mItemType == totemItemType then
			return true
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_d2b2176d()) then
		return false
	end

	local __wf_atom_ae45a8b6 = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_ae45a8b6()

	for _, v4 in ipairs(__wf_atom_ae45a8b6) do
		if v4.mItemType == totemItemType then
			return true
		end
	end

	return false
end

function GiveTotemRewards(instance)
	if not fn8() then
		if gRegion:IsMaster() then
			print("Running on host")
			gRegion:__wf_atom_c4f78a8f():GiveItem(totemItemType, true)
		else
			print("Running on client")
			gRegion:__wf_atom_eab484a7():__wf_atom_36b99b9d(totemItemType, 1)
		end
	end

	Sleep(10)
	instance:Destroy()

	if gRegion:IsMaster() then
		Sleep(15)
		instance:Destroy()
	end
end

function GiveWorldRewards(_)
	print("Trying to reward player for killing circade")
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_d78fd481 = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa():__wf_atom_eb82ab1f():__wf_atom_d78fd481(5)

	if
		__wf_atom_7e8ad928(circadeDefeatedToken)
		or __wf_atom_c4f78a8f:HasItem(circadeDefeatedToken)
		or __wf_atom_d78fd481.mItemType ~= totemResource
	then
		if __wf_atom_7e8ad928(circadeDefeatedToken) or not __wf_atom_c4f78a8f:HasItem(circadeDefeatedToken) then
			if not __wf_atom_c4f78a8f:HasItem(totemResource) then
				print("=== Player does not have totem equiped")
			end
		else
			print("=== Player Killed Circade already with this totem")
		end
	else
		print("=== Circade killed with this totem")

		if gRegion:IsMaster() then
			if not __wf_atom_7e8ad928(recepyBlueprint) then
				__wf_atom_c4f78a8f:GiveItem(recepyBlueprint, false)
			end

			__wf_atom_c4f78a8f:GiveItem(circadeDefeatedToken, false)
		else
			print("Running on client")

			if not __wf_atom_7e8ad928(recepyBlueprint) then
				gRegion:__wf_atom_eab484a7():__wf_atom_36b99b9d(recepyBlueprint, 1)
			end

			gRegion:__wf_atom_eab484a7():__wf_atom_36b99b9d(circadeDefeatedToken, 1)
		end
	end
end

function DissolveGhost(object)
	local v4 = 0

	while not __wf_atom_7e8ad928(object) and v4 < 1 do
		v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93() * 0.5, 0, 1)
		object:__wf_atom_68f2c268(v4)
		Sleep(0)
	end
end