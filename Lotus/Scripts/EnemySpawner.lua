local module = require("Lotus.Interface.CrossPlatformUtilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("EE.Interface.Utilities")
local module4 = require("SF.Interface.SFUtilities")
local v = Symbol("AvatarPause")
local gGameRules2 = gGameRules
local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
local v2 = {}
local v3 = nil
local v4 = {}

local function fn()
	if #v2 > 0 then
		local v5 = v2[1]

		if not __wf_atom_7e8ad928(v5) then
			local __wf_atom_eff0517e = v5:__wf_atom_eff0517e()

			if not __wf_atom_7e8ad928(__wf_atom_eff0517e) and __wf_atom_eff0517e:IsKilled() then
				gGameRules2:RespawnPlayer(v5, false)
				local __wf_atom_50a7d83e = v5:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					if v5:IsLocal() then
						__wf_atom_c4f78a8f = __wf_atom_50a7d83e
					end

					__wf_atom_50a7d83e:__wf_atom_d2b2176d():__wf_atom_2f2822cb(false)
				end
			end
		end

		table.remove(v2, 1)
	end
end

function KillEnemies()
	module4.KillEnemies()
end

function OpenEnemySelector(_, object)
	if __wf_atom_7e8ad928(object:__wf_atom_a96eb2aa()) or not object:__wf_atom_a96eb2aa():IsLocal() then
		if gRegion:IsMaster() then
			module4.KillEnemies()
		end
	else
		local enemySelectorScreen = enemySelectorScreen

		if __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(enemySelectorScreen))) then
			_T.SelectingEnemies = true
			_T.SelectingEnemiesManifest = codexManifest
			__wf_atom_8e4fda44:__wf_atom_5d67a2c5(enemySelectorScreen)
		end
	end
end

function ShowImpactMessage(object, numenemies)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(_T.ShowImpactMessage) then
		return
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local v5

	if #__wf_atom_3c8e1a7a == 1 then
		v5 = "/Lotus/Language/Game/" .. module3.Ternary(
			numenemies == 1,
			"SoloPlayerSpawnedEnemy",
			"SoloPlayerSpawnedEnemies"
		)
	else
		v5 = "/Lotus/Language/Game/" .. module3.Ternary(numenemies == 1, "PlayerSpawnedEnemy", "PlayerSpawnedEnemies")
	end

	local crossPlatformUniquePlayerName = module.GetCrossPlatformUniquePlayerName(
		object:__wf_atom_6be84646(),
		__wf_atom_3c8e1a7a,
		nil,
		true
	)
	_T.ShowImpactMessage(
		Localize(v5, { PLAYERNAME = crossPlatformUniquePlayerName, NUMENEMIES = numenemies }),
		5,
		true,
		nil,
		false
	)
end

local function fn2(list, p, _)
	for i = 1, #list do
		gGameRules:__wf_atom_64e46d98(list[i].SourceType, p, list[i].Count, list[i].IsLeader)
	end

	gGameRules:__wf_atom_136b7a7f(gRegion:__wf_atom_eab484a7())
end

local function fn3(list, p)
	_T.KillingSimulacrumEnemies = false
	local spawnTime = Time()

	if __wf_atom_7e8ad928(_T.spawnCounter) or not __wf_atom_7e8ad928(_T.spawnTime) and spawnTime - _T.spawnTime > 5 then
		_T.spawnCounter = 1
	end

	_T.spawnTime = spawnTime
	local v5 = Symbol("Enemy")
	__wf_atom_7d789620:__wf_atom_1b81c75e(#list)
	__wf_atom_7d789620:__wf_atom_c3293b12(0, 300, 0, 5, false, false, false)
	__wf_atom_7d789620:__wf_atom_ad5ab5be(true)
	local v6 = {}
	local v7 = {}

	if __wf_atom_7e8ad928(spawnPoints) or #spawnPoints < 1 then
		if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_469b1d97) then
			local all = gRegion:FindAll(gNpcSpawnPointType)

			for i = 1, #all do
				local c_str = all[i]:__wf_atom_db682341():c_str()

				if not (c_str ~= "TurretSpawn" and c_str ~= "CameraSpawn" and c_str ~= "DoNotUse") then
					continue
				end

				table.insert(v6, all[i]:GetPosition())
				table.insert(v7, all[i]:__wf_atom_dc309f8a())
			end
		else
			for i = 1, #list do
				for _ = 1, list[i].Count do
					table.insert(
						v6,
						(__wf_atom_7d789620:__wf_atom_6acb01b3(
							gRegion:__wf_atom_c4f78a8f(),
							math.random(10, 30),
							math.random(30, 60)
						))
					)
					table.insert(v7, __wf_atom_80368bb1)
				end
			end
		end
	else
		for i = 1, #spawnPoints do
			table.insert(v6, spawnPoints[i]:GetPosition())
			table.insert(v7, spawnPoints[i]:__wf_atom_dc309f8a())
		end
	end

	if __wf_atom_7e8ad928(v6) or #v6 < 1 then
		print("Failed to find enemy spawn positions!")
		return
	end

	for i = 1, #list do
		for _ = 1, list[i].Count do
			local v8 = list[i].IsLeader and 1 or 0
			local __wf_atom_402b3832 = __wf_atom_7d789620:__wf_atom_402b3832(
				Resource(list[i].SourceType),
				v6[_T.spawnCounter],
				v7[_T.spawnCounter],
				v5,
				p,
				nil,
				v8
			)

			if __wf_atom_7e8ad928(_T.spawnedAgents) then
				_T.spawnedAgents = {}
			end

			table.insert(_T.spawnedAgents, __wf_atom_402b3832)

			if __wf_atom_7e8ad928(__wf_atom_402b3832) then
				print("Problem spawning " .. list[i].Name)
			else
				local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

				if _T.PauseAI and not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					__wf_atom_402b3832:SetPaused(true, v)

					if __wf_atom_50a7d83e:IsA(__wf_atom_47cae841) then
						Sleep(0)
						Sleep(0)
						local __wf_atom_4221009f = __wf_atom_50a7d83e:__wf_atom_4221009f()

						if not __wf_atom_7e8ad928(__wf_atom_4221009f) then
							local __wf_atom_30e3d82b = __wf_atom_4221009f:__wf_atom_30e3d82b()

							if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
								__wf_atom_30e3d82b:SetPaused(true, v)
							end
						end
					end
				end

				__wf_atom_50a7d83e:__wf_atom_c6a78fe5(dropTableOverride)
				_T.spawnCounter = _T.spawnCounter + 1

				if _T.spawnCounter > #v6 then
					_T.spawnCounter = 1
				end
			end
		end
	end
end

function SpawnEnemy(sourceType, p, count, isLeader)
	fn3({
		{
			Name = sourceType:__wf_atom_5b41f63b(),
			SourceType = sourceType,
			Count = count,
			IsLeader = isLeader
		}
	}, p, false)
end

function InitializeLevelForTutorial()
	if not __wf_atom_7e8ad928(gGameRules2) then
		gGameRules2:__wf_atom_71cbae00(false)
	end

	__wf_atom_eab484a7:__wf_atom_36f9fac5(playerSpawnPoint)
end

function OnPlayersChanged()
	if not __wf_atom_7e8ad928(gRegion) then
		v4 = gRegion:__wf_atom_3c8e1a7a()
		local all = gRegion:FindAll(__wf_atom_0916f346)

		if not __wf_atom_7e8ad928(all) and #all > 0 then
			for i = 1, #v4 do
				v4[i]:__wf_atom_36f9fac5(all[1])
			end
		end
	end
end

function InitializeLevel()
	local module5 = require("Lotus.Interface.Libs.TimerMgr")
	v3 = module5.CreateTimerMgr()

	if not __wf_atom_7e8ad928(gGameRules2) then
		gGameRules2:__wf_atom_71cbae00(false)
	end

	__wf_atom_eab484a7:__wf_atom_36f9fac5(playerSpawnPoint)
	v4 = gRegion:__wf_atom_3c8e1a7a()
	gRegion:__wf_atom_2202ffb6():__wf_atom_32d771c9(dropTableOverride)
	__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_2f2822cb(false)
	__wf_atom_7d789620:Enable(true)
	__wf_atom_7d789620:__wf_atom_ac65571b(true)
	__wf_atom_7d789620:__wf_atom_5e16fe4a(__wf_atom_c4f78a8f)
	__wf_atom_7d789620:__wf_atom_4ea40bfd(0, 500)
	__wf_atom_7d789620:__wf_atom_c3293b12(10, 100, 0, 5, false, false, false)
	__wf_atom_7d789620:__wf_atom_ad5ab5be(true)

	if gGameRules2:IsA(__wf_atom_2564b701) then
		gGameRules2:__wf_atom_b3a89a0d(gRegion:__wf_atom_0a6a5887(Symbol("Arsenal")))
	end

	gGameRules2:__wf_atom_f747acaf(false)
	gGameRules2:__wf_atom_f1e607e3(true)
	gGameRules2:__wf_atom_f8d64ecf(true)

	if gGameRules:IsA(__wf_atom_2564b701) then
		_T.SpawnEnemies = fn2
	else
		_T.SpawnEnemies = fn3
	end

	local v5 = { nil, nil }
	local v6 = { nil, nil }
	local v7 = { nil, nil }

	if not gGameRules:IsA(__wf_atom_469b1d97) then
		__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_3f7ee611(5)
	end

	_T.InSimulacrum = true
	module2.UpdateUIConsoleTriggers(true)

	if gRegion:IsMaster() and not gGameRules2:IsA(__wf_atom_469b1d97) then
		gRegion:__wf_atom_d5ede414("OnPlayersChanged")

		while not __wf_atom_7e8ad928(gGameRules2) do
			v3:Update(__wf_atom_084b3e93())

			for i = 1, 2 do
				if __wf_atom_7e8ad928(v5[i]) then
					v5[i] = gRegion:CreateEntity(
						nil,
						energyRefillStations[i]:GetPosition() + Vector(0, 0.5, 0),
						__wf_atom_80368bb1
					)
				end

				if __wf_atom_7e8ad928(v6[i]) then
					v6[i] = gRegion:CreateEntity(
						nil,
						healthRefillStations[i]:GetPosition() + Vector(0, 0.5, 0),
						__wf_atom_80368bb1
					)
				end

				if __wf_atom_7e8ad928(v7[i]) then
					v7[i] = gRegion:CreateEntity(
						nil,
						ammoRefillStations[i]:GetPosition() + Vector(0, 0.5, 0),
						__wf_atom_80368bb1
					)
				end
			end

			for i = 1, #v4 do
				local v8 = false

				for j = 1, #v2 do
					if v4[i] ~= v2[j] then
						continue
					end

					v8 = true
					break
				end

				if v8 then
					continue
				end

				local __wf_atom_eff0517e = v4[i]:__wf_atom_eff0517e()

				if __wf_atom_7e8ad928(__wf_atom_eff0517e) or not __wf_atom_eff0517e:IsKilled() then
					continue
				end

				v3:AddTimer(3, fn, false)
				table.insert(v2, v4[i])
			end

			Sleep(0)
		end
	end
end