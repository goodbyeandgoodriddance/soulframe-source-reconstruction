local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.StatsLib")
local module3 = require("SF.Scripts.Libs.RespawnLib")
local module4 = require("SF.Scripts.NightFoldLib")
require("Lotus.Scripts.Libs.AudioLib")
require("SF.Scripts.Libs.QuestLib")
require("SF.Interface.SFUtilities")
local module5 = require("SF.Scripts.Libs.ChallengeLib")
local module6 = require("SF.Scripts.Libs.EncounterLib")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local flag = nil
local gGameRules2 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local activeFightController = nil
WeakResource("/SF/Types/Game/SFInstigatorCinematic")
local v8 = Resource("/SF/Types/Player/NoAbilitiesInputFilter")
local v9 = Symbol("WaitToFight")
local modeState = 1
local v10 = nil
local v11 = {
	{ name = "Spawned", statsName = "SPAWN" },
	{ name = "IntroSkipped", statsName = "ResumeFight" },
	{ name = "Intro", statsName = "INTRO" },
	{ name = "Fight", statsName = "FIGHT" },
	{ name = "Post Fight", statsName = "NightFold" },
	{ name = "Fight Ended", statsName = "END" }
}
local v12 = {}
local v13 = nil
local v14 = 1
local v15 = 2
local names = nil
local v16 = 1

local function fn()
	if __wf_atom_7e8ad928(mobAgentType) then
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(mobSpawnTag)

	if __wf_atom_7e8ad928(v10.MobAgents) then
		v10.MobAgents = {}
	end

	for k, v17 in pairs(__wf_atom_2226b35c) do
		local v18 = __wf_atom_5784a397(mobSpawnLevelRange.minValue, mobSpawnLevelRange.maxValue)
		local __wf_atom_402b3832 = v3:__wf_atom_402b3832(
			mobAgentType,
			v17:GetPosition(),
			v17:__wf_atom_dc309f8a(),
			sBossTeam,
			v18
		)
		local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()
		__wf_atom_50a7d83e:SetBlackboardBool(v9, true)
		__wf_atom_50a7d83e:SetVisibility(false, true)
		__wf_atom_402b3832:SetPaused(true, Symbol("ThralledAgent"))
		__wf_atom_50a7d83e:__wf_atom_30964595(false)
		__wf_atom_50a7d83e:__wf_atom_15b36b95(false)
		module.SetImmunity(__wf_atom_50a7d83e, true)
		table.insert(v10.MobAgents, k, { Agent = __wf_atom_402b3832, Avatar = __wf_atom_50a7d83e })
	end
end

local function fn2()
	local v17 = {
		fightSetupPluginScript,
		fightIntroPluginScript,
		fightLoopPluginScript,
		fightPostGameplaySequencePluginScript,
		fightEndPluginScript
	}

	for _, v18 in pairs(v17) do
		local v19 = activeFightController:Attach(v18, EMPTY_SYMBOL)

		if __wf_atom_7e8ad928(v19) then
			break
		else
			table.insert(v12, v19)
		end
	end
end

local function fn3(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(activeFightController) then
		return
	end

	local typeInTable = module.FindTypeInTable(v12, p)

	if not __wf_atom_7e8ad928(typeInTable) then
		typeInTable:FirePort("Execute")
		return
	end

	local v17 = activeFightController:Attach(p, EMPTY_SYMBOL)

	if __wf_atom_7e8ad928(v17) then
		return
	end

	v17:FirePort("Execute")
	table.insert(v12, v17)
end

local function fn4(agentType, p, spawnPoint, _, _, _)
	if __wf_atom_7e8ad928(agentType) or __wf_atom_7e8ad928(avatarType) or __wf_atom_7e8ad928(spawnPoint) then
		return
	end

	local maxHealth = 0
	local all = gRegion:FindAll(avatarType)
	local bossAvatar, bossAgent

	if #all > 0 then
		bossAvatar = all[1]
		bossAgent = bossAvatar:__wf_atom_30e3d82b()
	end

	local v17 = __wf_atom_7e8ad928(bossAvatar)

	if v17 then
		bossAgent = v3:__wf_atom_402b3832(
			agentType,
			spawnPoint:GetPosition(),
			spawnPoint:__wf_atom_dc309f8a(),
			sBossTeam,
			level
		)

		while __wf_atom_7e8ad928(bossAgent) do
			Sleep(0)
			bossAgent = v3:__wf_atom_402b3832(
				agentType,
				spawnPoint:GetPosition(),
				spawnPoint:__wf_atom_dc309f8a(),
				sBossTeam,
				level
			)
		end
	end

	if v17 or p then
		bossAvatar = bossAgent:__wf_atom_50a7d83e()
		bossAvatar:SetBlackboardBool(v9, true)
		bossAvatar:__wf_atom_7c8621d6()

		if v17 then
			bossAvatar:__wf_atom_4aa8ac56(false, false)
		end

		maxHealth = bossAvatar:GetMaxHealth()

		if p then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(fightRestartWPTag)
			bossAvatar:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
		else
			bossAvatar:SetVisibility(true)
			bossAvatar:__wf_atom_30964595(false)
			bossAvatar:Teleport(spawnPoint:GetPosition(), spawnPoint:__wf_atom_dc309f8a())
		end

		if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
			_T.SetupBossAvatar(nil)
		end
	end

	if __wf_atom_7e8ad928(v10.Actors) then
		v10.Actors = {}
	end

	table.insert(v10.Actors, 1, bossAvatar)
	v10.BossAgent = bossAgent
	v10.BossAvatar = bossAvatar
	return bossAvatar, bossAgent, maxHealth
end

local function fn5(_, p)
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	if not __wf_atom_7e8ad928(__wf_atom_3c8e1a7a) then
		v14 = #__wf_atom_3c8e1a7a
	end

	v3 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	while __wf_atom_7e8ad928(v3) do
		v3 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		Sleep(0)
	end

	gGameRules:HideGameSession(true)
	v, v2 = v10.UpdatePlayerAvatars()
	module2.EndBossFight(statsBossFightName)
	v5, v6, v7 = fn4(agentType, p, spawnPoint, false, false, false)
	fn()
	module2.StartBossFight(statsBossFightName, v14)
	module2.AddBossFightNpcEventTracking(statsBossFightName, v5)

	if gPromotedToHost or p then
		v4:SetModeState(2)
	else
		v4:SetModeState(1)
	end
end

local function fn6()
	for i = 1, #v do
		if
			__wf_atom_7e8ad928(v[i])
			or not v[i]:__wf_atom_bedb4e3f()
			or __wf_atom_7e8ad928((v[i]:__wf_atom_a96eb2aa()))
		then
			continue
		end

		v[i]:InstantRevive()
	end
end

local function fn7(list, p, p2)
	for _, v17 in ipairs(list) do
		if __wf_atom_7e8ad928(v17) then
			continue
		end

		local __wf_atom_92aa9d91 = v17:__wf_atom_92aa9d91()
		__wf_atom_92aa9d91:__wf_atom_1c1f6152(p)

		if __wf_atom_7e8ad928(p2) or not p then
			continue
		end

		__wf_atom_92aa9d91:__wf_atom_fdf2b1f7(p2)
	end
end

local function fn8(modeState2, _, _)
	if modeState2 == 2 or modeState2 == 3 then
		if v13 ~= false then
			module4.RegisterPreventNighfoldUsage(false)
			v13 = false
			_T.PreventingNightfold = false
		end
	elseif modeState2 == 4 or modeState2 == 5 then
		if v13 ~= true then
			module4.RegisterPreventNighfoldUsage(true)
			module4.SetPreventNightfoldUsageReason(module4.BT_COMBAT)
			v13 = true
			_T.PreventingNightfold = true
		end
	elseif v13 ~= false then
		module4.RegisterPreventNighfoldUsage(false)
		v13 = false
		_T.PreventingNightfold = false
	end

	if gRegion:IsMaster() then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(v11[modeState2]) then
			module2.SetBossFightStage(statsBossFightName, v11[modeState2].statsName)
		end

		if modeState2 == 1 then
			_T.BayorFightCompleted = false

			if not __wf_atom_7e8ad928(fightSetupPluginScript) then
				fn3(fightSetupPluginScript)
			end
		elseif modeState2 == 2 then
			module.SetImmunity(v5, true)
			print("SkipIntroCines")
			_T.disableNightfoldCombatCheck = true
		elseif modeState2 == 3 then
			module.DeactivateAbilities(true, false)
			local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
			__wf_atom_d2b2176d:Unequip(0, 0)

			while
				not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
				and not __wf_atom_c4f78a8f:IsKilled()
				and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14
			do
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(fightIntroPluginScript) then
				fn3(fightIntroPluginScript)
			end
		elseif modeState2 == 4 then
			module.Fade(false, 0.5, 1, false)

			if v13 ~= true then
				module4.RegisterPreventNighfoldUsage(true)
				module4.SetPreventNightfoldUsageReason(module4.BT_COMBAT)
				v13 = true
				_T.PreventingNightfold = true
			end

			EnableBlightZoneRespawning(v10.RespawnShrine)
			_T.disableNightfoldCombatCheck = nil
			v5:__wf_atom_15b36b95(true)
			fn7(v, true, v5)
			module.SetImmunity(v5, false)

			if not v5:IsVisible() then
				v5:SetVisibility(true)
			end

			v5:__wf_atom_30964595(true)
			Sleep(1)
			v5:SetBlackboardBool(v9, false)

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar(v5)
			end

			if not __wf_atom_7e8ad928(fightLoopPluginScript) then
				fn3(fightLoopPluginScript)
			end
		elseif modeState2 == 5 then
			module.DeactivateAbilities(false, true)
			__wf_atom_c4f78a8f:__wf_atom_aeb02c14(v8)
			local __wf_atom_bedb4e3f = __wf_atom_c4f78a8f:__wf_atom_7470861b():__wf_atom_bedb4e3f()
			fn6()

			for _, v17 in v do
				if __wf_atom_7e8ad928(v17) or not v17:__wf_atom_4417a5d4() then
					continue
				end

				if not __wf_atom_7e8ad928(v17:__wf_atom_7470861b()) then
					v17:__wf_atom_7470861b():__wf_atom_9c80ef1a(6)
				end

				v17:Heal(v17, v17:GetMaxHealth())
			end

			if not __wf_atom_7e8ad928(v6) then
				v6:SetPaused(true, Symbol("FightEndPause"))
			end

			module.UnequipWeapon(__wf_atom_c4f78a8f, __wf_atom_bedb4e3f)

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar(nil)
			end

			if not __wf_atom_7e8ad928(fightPostGameplaySequencePluginScript) then
				fn3(fightPostGameplaySequencePluginScript)
			end
		elseif modeState2 == 6 then
			__wf_atom_c4f78a8f:__wf_atom_cf966a74(v8)
			fn6()
			module2.EndBossFightNpcEventTracking(statsBossFightName, v5)
			module2.EndBossFight(statsBossFightName)
			module5.NotifyBossComplete()

			if not __wf_atom_7e8ad928(fightEndPluginScript) then
				fn3(fightEndPluginScript)
			end

			module.UnequipWeapon(__wf_atom_c4f78a8f, true)
			DisableBlightZoneRespawning()
		end
	else
		if gRegion:IsMaster() then
			if __wf_atom_7e8ad928(v5) then
				v5 = gRegion:__wf_atom_0a6a5887(bossAvatarTag)
			end

			if __wf_atom_7e8ad928(v5) then
				print("Boss avatar not found, mBossAvatar will be null")
			end
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if modeState2 == 1 then
			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(false)
			end
		else
			if modeState2 == 2 then
				return
			end

			if modeState2 == 3 then
				local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
				__wf_atom_d2b2176d:Unequip(0, 0)

				while
					not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
					and not __wf_atom_c4f78a8f:IsKilled()
					and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14
				do
					Sleep(0)
				end

				local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FightIntroCinematic"))

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
						Sleep(0)
					end
				end
			elseif modeState2 == 4 then
				module.Fade(false, 0.5, 1, false)

				if v13 ~= true then
					module4.RegisterPreventNighfoldUsage(true)
					module4.SetPreventNightfoldUsageReason(module4.BT_COMBAT)
					v13 = true
					_T.PreventingNightfold = true
				end

				EnableBlightZoneRespawning()

				if not __wf_atom_7e8ad928(v5) then
					v5:__wf_atom_15b36b95(true)
				end

				if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
					_T.SetupBossAvatar(v5)
				end
			elseif modeState2 == 5 then
				__wf_atom_c4f78a8f:__wf_atom_aeb02c14(v8)

				for _, v17 in v do
					if __wf_atom_7e8ad928(v17) or not v17:__wf_atom_4417a5d4() then
						continue
					end

					if not __wf_atom_7e8ad928(v17:__wf_atom_7470861b()) then
						v17:__wf_atom_7470861b():__wf_atom_9c80ef1a(6)
					end

					v17:Heal(v17, v17:GetMaxHealth())
				end

				module.UnequipWeapon(__wf_atom_c4f78a8f, false)

				if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
					_T.SetupBossAvatar(nil)
				end
			elseif modeState2 == 6 then
				__wf_atom_c4f78a8f:__wf_atom_cf966a74(v8)
				module.UnequipWeapon(__wf_atom_c4f78a8f, false)
				DisableBlightZoneRespawning()
			end
		end
	end
end

local function fn9()
	__wf_atom_4f3659d1("Fight Controls")
	__wf_atom_05a856ad("Select Fight Stage:")

	if __wf_atom_7e8ad928(names) then
		names = {}

		for _, v17 in ipairs(v11) do
			table.insert(names, v17.name)
		end
	end

	v15 = __wf_atom_fdfab732("##", v15, names)
	__wf_atom_78aeed31()

	if __wf_atom_80afb308("Skip to selected") and modeState ~= v15 then
		modeState = v15

		if modeState == 4 then
			v5:SetVisibility(true)
			v5:__wf_atom_30964595(true)
		end

		v4:SetModeState(modeState)
		return true
	else
		__wf_atom_07947f07()
		v16 = __wf_atom_3f9d4ca0(" ", v16, 0, 1)
		__wf_atom_78aeed31()

		if __wf_atom_80afb308("SetHealth") then
			local v17 = v7 * v16
			v5:SetHealth(v17, false)
		end

		__wf_atom_07947f07()

		if __wf_atom_80afb308("Force Pre Death") then
			v5:__wf_atom_7470861b():__wf_atom_befe3998(true)
		end

		return false
	end
end

local function fn10()
	__wf_atom_4f3659d1("Boss Testing")

	if
		not __wf_atom_7e8ad928(bossTester)
		and __wf_atom_80afb308("Attach Boss Tester")
		and not (__wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(bossTester))
	then
		_G.testModeEnabled = true
		v5:Attach(Type(bossTester), EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		v5:SetVisibility(true)
		v5:__wf_atom_30964595(true)
		module.SetImmunity(v5, false)
	end

	__wf_atom_78aeed31()

	if __wf_atom_80afb308("Respawn Boss") and __wf_atom_7e8ad928(v5) then
		v5, v6, v7 = fn4(agentType, false, spawnPoint, false, false, false)
		v4:SetModeState(1)
	end

	__wf_atom_78aeed31()

	if __wf_atom_80afb308("Reset Fight") then
		ResetFight()
	end
end

local function fn11()
	local v17

	if __wf_atom_489de21b("Boss Spawn Settings") then
		if v11[modeState] == nil then
			__wf_atom_05a856ad("Unknown Mode State " .. tostring(modeState))
			__wf_atom_48bcafdc()
			return
		else
			__wf_atom_05a856ad("Fight Stage: " .. modeState .. " - " .. v11[modeState].name)
			__wf_atom_07947f07()
			v17 = fn9()
			__wf_atom_07947f07()
			fn10()
			__wf_atom_07947f07()
			__wf_atom_07947f07()
		end
	else
		v17 = false
	end

	__wf_atom_48bcafdc()

	if v17 then
		fn8(modeState)
	end
end

local function fn12(_)
	v, v2 = v10.UpdatePlayerAvatars()
	module3.UpdateBlightZone()

	if modeState == 1 then
		if __wf_atom_7e8ad928(startFightTrigger) or not startFightTrigger:IsEnabled() then
			v4:SetModeState(3)
		end
	elseif modeState == 2 then
		if __wf_atom_7e8ad928(resumeFightTrigger) or not resumeFightTrigger:IsEnabled() then
			v4:SetModeState(4)
		end
	elseif modeState == 3 then
		if not __wf_atom_7e8ad928(v10.IntroFinished) or v10.IntroFinished == true then
			v4:SetModeState(4)
		end
	elseif modeState < 6 and not __wf_atom_7e8ad928(v5) then
		if modeState == 4 then
			if v10.FightloopCompleted == true then
				v4:SetModeState(5)
			end

			if not __wf_atom_7e8ad928(_T.needsBarRestored) and _T.needsBarRestored then
				if v13 ~= true then
					module4.RegisterPreventNighfoldUsage(true)
					module4.SetPreventNightfoldUsageReason(module4.BT_COMBAT)
					v13 = true
					_T.PreventingNightfold = true
				end

				_T.PreventingNightfold = true
				_T.needsBarRestored = nil

				if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
					_T.SetupBossAvatar(v5)
				end
			end
		elseif modeState == 5 then
			fn6()

			if v10.PostFightSequence then
				v4:SetModeState(6)
			end
		end
	elseif modeState == 6 and v10.BossFightCompleted == true then
		flag = true
	end

	fn11()
end

local function fn13(_)
	if not gRegion:IsMaster() then
		v, v2 = v10.UpdatePlayerAvatars()

		if modeState == 1 then
			return
		elseif modeState == 3 then
			return
		end

		if modeState < 6 and not __wf_atom_7e8ad928(v5) then
			if modeState == 4 then
				return
			end

			if modeState == 5 then
				for _, v17 in v do
					if __wf_atom_7e8ad928(v17) or __wf_atom_7e8ad928(v17:__wf_atom_7470861b()) then
						continue
					end

					v17:__wf_atom_7470861b():__wf_atom_9c80ef1a(6)
				end
			end
		end
	end
end

function EnableBlightZoneRespawning(p)
	if __wf_atom_7e8ad928(p) then
		print("Blighted Zone did not activate, Normal respawning enabled")
		return
	end

	module3.ActivateBlightZone(p, true, true, false, ResetFight)
	print("Blighted Zone active")
end

function DisableBlightZoneRespawning()
	module3.DeactivateBlightZone(true)
end

function ResetFight()
	print("ResetFight")
	modeState = 2
	v10.FightRestarting = false

	if not __wf_atom_7e8ad928(resumeFightTrigger) then
		resumeFightTrigger:Enable()
	end

	if not __wf_atom_7e8ad928(fightResetPluginScript) then
		fightResetPluginScript:FirePort("TriggerPort")
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:__wf_atom_4d75e5e7()
		Sleep(2)
		gRegion:__wf_atom_dd1e4d10(v5)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OpenVineWall"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_f0368285()
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("WarpPoint"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:FirePort("Disable")
	end

	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("ArenaBlocker"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
		__wf_atom_0a6a5887_3:Disable()
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local v17 = false

	while not v17 do
		v17 = true

		for i = 1, #__wf_atom_3c8e1a7a do
			local flag2 = false

			for j = 1, #v do
				if __wf_atom_7e8ad928(__wf_atom_3c8e1a7a[i]) or __wf_atom_3c8e1a7a[i]:__wf_atom_50a7d83e() ~= v[j] then
					continue
				end

				flag2 = true
				break
			end

			if not flag2 then
				continue
			end

			v17 = false
			break
		end

		Sleep(0.2)
	end

	module3.RefillHealthPotions(5)
	fn5(false, true)

	if not gRegion:IsMaster() then
		return
	end

	if __wf_atom_7e8ad928(v5) then
		v5 = gRegion:__wf_atom_0a6a5887(bossAvatarTag)
	end

	if __wf_atom_7e8ad928(v5) then
		print("Boss avatar not found, mBossAvatar will be null")
	end
end

function StartScriptedFight(p)
	module.WaitForLevel()
	activeFightController = p

	if not __wf_atom_7e8ad928(_T.ActiveFightController) then
		return
	end

	_T.ActiveFightController = activeFightController
	module6.SetEncounterHintsEnabledByTags(hintTags, false)
	v10 = activeFightController:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(v10) then
		if __wf_atom_7e8ad928(shrine) then
			shrine = gRegion:__wf_atom_0a6a5887(Symbol("DisabledShrine"))
		end

		if not __wf_atom_7e8ad928(shrine) then
			shrine:__wf_atom_b811702e(Symbol("ResShrine"))
		end

		v10.RespawnShrine = shrine
		v10.FightIntroCompleted = false
		v10.FightloopCompleted = false
		v10.PostFightSequence = false
		v10.FightRestarting = false
		v10.BossFightCompleted = false
		v10.MobAgents = {}

		function v10.UpdatePlayerAvatars()
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
			local __wf_atom_d52d8448 = gRegion:__wf_atom_d52d8448()
			v10.PlayerAvatars = __wf_atom_ef7900cf
			v10.SquadSize = __wf_atom_d52d8448
			return __wf_atom_ef7900cf, __wf_atom_d52d8448
		end

		function v10.SetCustomLockOnSettings(p2)
			fn7(v10.PlayerAvatars, p2, v5)
		end
	end

	fn2()
	v4 = module.CreateModeMgr(fn8)

	if gRegion:IsMaster() then
		fn5(false, false)
	end

	if gRegion:IsMaster() then
		if __wf_atom_7e8ad928(v5) then
			v5 = gRegion:__wf_atom_0a6a5887(bossAvatarTag)
		end

		if __wf_atom_7e8ad928(v5) then
			print("Boss avatar not found, mBossAvatar will be null")
		end
	end

	local flag2 = false
	gGameRules2 = gGameRules

	repeat
		Sleep(0)

		while __wf_atom_7e8ad928(gGameRules2) do
			Sleep(0)
			gGameRules2 = gGameRules

			if __wf_atom_7e8ad928(gGameRules2) then
				continue
			end

			flag2 = true

			while not gGameRules2:__wf_atom_adfb052a() do
				Sleep(0)
			end
		end

		if flag2 then
			print("Quest: Host migration")
			modeState = v4:GetModeState(modeState)

			if gPromotedToHost then
				fn5(true, false)
			end

			if gRegion:IsMaster() then
				if __wf_atom_7e8ad928(v5) then
					v5 = gRegion:__wf_atom_0a6a5887(bossAvatarTag)
				end

				if __wf_atom_7e8ad928(v5) then
					print("Boss avatar not found, mBossAvatar will be null")
				end
			end

			flag2 = false
		end

		v4:Update()
		modeState = v4:GetModeState(modeState)

		if gRegion:IsMaster() then
			fn12(__wf_atom_03df4e1d())
		elseif not gRegion:IsMaster() then
			fn13(__wf_atom_03df4e1d())
		end
	until flag
end