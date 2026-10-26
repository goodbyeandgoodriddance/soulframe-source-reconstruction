local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.StatsLib")
local module3 = require("SF.Scripts.Libs.RespawnLib")
local module4 = require("SF.Scripts.NightFoldLib")
require("Lotus.Scripts.Libs.AudioLib")
require("SF.Scripts.Libs.QuestLib")
require("SF.Interface.SFUtilities")
local module5 = require("SF.Scripts.Libs.ChallengeLib")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local flag = nil
local gGameRules2 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = Resource("/SF/Types/Player/NoAbilitiesInputFilter")
local v9 = Instance()
local v10 = Symbol("WaitToFight")
local modeState = 1
local v11 = {
	{ name = "Spawned", statsName = "SPAWN" },
	{ name = "IntroSkipped", statsName = "ResumeFight" },
	{ name = "Intro", statsName = "INTRO" },
	{ name = "Fight", statsName = "FIGHT" },
	{ name = "FloppetFlight", statsName = "Floppet" },
	{ name = "Fight Ended", statsName = "END" }
}
local _ = { 0.7, 0.4, 0.05 }
local v12 = nil
local v13 = 1
local v14 = 2
local names = nil

local function fn(p, object)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v15 in ipairs(__wf_atom_ef7900cf) do
		if v15:__wf_atom_4417a5d4() then
			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_a3d2b66b(v15, Symbol("Envoy"))
			end
		else
			v15:__wf_atom_a7ee9662(p, true)
		end
	end
end

local function fn2(agentType, p, spawnPoint, _, _, _)
	if __wf_atom_7e8ad928(agentType) or __wf_atom_7e8ad928(avatarType) then
		return
	end

	local maxHealth = 0
	local all = gRegion:FindAll(avatarType)
	local v15, v16

	if #all > 0 then
		v15 = all[1]
		v16 = v15:__wf_atom_30e3d82b()
	end

	local v17 = __wf_atom_7e8ad928(v15)

	if v17 then
		v16 = v3:__wf_atom_402b3832(
			agentType,
			spawnPoint:GetPosition(),
			spawnPoint:__wf_atom_dc309f8a(),
			sBossTeam,
			level
		)

		while __wf_atom_7e8ad928(v16) do
			v16 = v3:__wf_atom_402b3832(
				agentType,
				spawnPoint:GetPosition(),
				spawnPoint:__wf_atom_dc309f8a(),
				sBossTeam,
				level
			)
			Sleep(5)
		end
	end

	if not (v17 or p) then
		return v15, v16, maxHealth
	end

	v15 = v16:__wf_atom_50a7d83e()
	v15:SetBlackboardBool(v10, true)
	v15:__wf_atom_7c8621d6()
	maxHealth = v15:GetMaxHealth()

	if p then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ResetSpawn"))
		v15:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
	else
		v15:SetVisibility(false)
		v15:__wf_atom_30964595(false)
		v15:Teleport(spawnPoint:GetPosition(), spawnPoint:__wf_atom_dc309f8a())
	end

	if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
		_T.SetupBossAvatar(nil)
	end

	return v15, v16, maxHealth
end

local function fn3(_, p)
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	if not __wf_atom_7e8ad928(__wf_atom_3c8e1a7a) then
		v13 = #__wf_atom_3c8e1a7a
	end

	v3 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	while __wf_atom_7e8ad928(v3) do
		v3 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		Sleep(0)
	end

	gGameRules:HideGameSession(true)
	v = gRegion:__wf_atom_ef7900cf()
	v2 = gRegion:__wf_atom_d52d8448()
	module2.EndBossFight(statsBossFightName)
	v5, v6, v7 = fn2(agentType, p, spawnPoint, false, false, false)
	module2.StartBossFight(statsBossFightName, v13)
	module2.AddBossFightNpcEventTracking(statsBossFightName, v5)

	if gPromotedToHost or p then
		v4:SetModeState(2)
	else
		v4:SetModeState(1)
	end
end

local function fn4(_, _)
	gRegion:IsMaster()

	if __wf_atom_7e8ad928(v5) then
		v5 = gRegion:__wf_atom_0a6a5887(Symbol("CorruptedBromius"))
	end

	if __wf_atom_7e8ad928(v5) then
		print("CorruptedBromius not found, mBromiusAvatar will be null")
	end
end

local function fn5()
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

local function fn6(modeState2, _, _)
	if modeState2 == 2 or modeState2 == 3 then
		if v12 ~= false then
			module4.RegisterPreventNighfoldUsage(false)
			v12 = false
			_T.PreventingNightfold = false
		end
	elseif modeState2 == 4 or modeState2 == 5 then
		if v12 ~= true then
			module4.RegisterPreventNighfoldUsage(true)
			module4.SetPreventNightfoldUsageReason(module4.BT_COMBAT)
			v12 = true
			_T.PreventingNightfold = true
		end
	elseif v12 ~= false then
		module4.RegisterPreventNighfoldUsage(false)
		v12 = false
		_T.PreventingNightfold = false
	end

	if gRegion:IsMaster() then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(v11[modeState2]) then
			module2.SetBossFightStage(statsBossFightName, v11[modeState2].statsName)
		end

		if modeState2 == 1 then
			_T.BromiusFightCompleted = false
			v9 = gRegion:__wf_atom_0a6a5887(Symbol("DisabledShrine"))

			if not __wf_atom_7e8ad928(v9) then
				v9:__wf_atom_b811702e(Symbol("ResShrine"))
			end

			if not __wf_atom_7e8ad928(fightSetUpPortForwarder) then
				fightSetUpPortForwarder:FirePort("TriggerPort")
			end

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(false)
			end
		elseif modeState2 == 2 then
			module.SetImmunity(v5, true)
			print("SkipIntroCines")
			_T.disableNightfoldCombatCheck = true
		elseif modeState2 == 3 then
			local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
			__wf_atom_d2b2176d:Unequip(0, 0)
			module.DeactivateAbilities(true, false)

			while
				not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
				and not __wf_atom_c4f78a8f:IsKilled()
				and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14
			do
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(fightIntroPortForwarder) then
				fightIntroPortForwarder:FirePort("TriggerPort")
			end
		elseif modeState2 == 4 then
			module.Fade(false, 0.5, 1, false)

			if v12 ~= true then
				module4.RegisterPreventNighfoldUsage(true)
				module4.SetPreventNightfoldUsageReason(module4.BT_COMBAT)
				v12 = true
				_T.PreventingNightfold = true
			end

			v9 = gRegion:FindNearestTagged(Symbol("ResShrine"), v5:GetPosition())
			EnableBlightZoneRespawning()
			_T.disableNightfoldCombatCheck = nil
			v5:__wf_atom_15b36b95(true)

			for i = 1, #v do
				module.SetCustomLockOnSettings(v[i], lockonRadius, lockOnDist, lockOnDistFade, lockOnSizeFade)
			end

			module.SetImmunity(v5, false)

			if not v5:IsVisible() then
				v5:SetVisibility(true)
				v5:__wf_atom_30964595(true)
			end

			Sleep(1)
			v5:SetBlackboardBool(v10, false)

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar(v5)
			end

			if not __wf_atom_7e8ad928(fightStartPortForwader) then
				fightStartPortForwader:FirePort("TriggerPort")
			end
		elseif modeState2 == 5 then
			module.DeactivateAbilities(false, true)
			__wf_atom_c4f78a8f:__wf_atom_aeb02c14(v8)
			local __wf_atom_bedb4e3f = __wf_atom_c4f78a8f:__wf_atom_7470861b():__wf_atom_bedb4e3f()
			fn5()

			for _, v15 in v do
				if __wf_atom_7e8ad928(v15) or not v15:__wf_atom_4417a5d4() then
					continue
				end

				if not __wf_atom_7e8ad928(v15:__wf_atom_7470861b()) then
					v15:__wf_atom_7470861b():__wf_atom_9c80ef1a(6)
				end

				v15:Heal(v15, v15:GetMaxHealth())
			end

			if not __wf_atom_7e8ad928(v6) then
				v6:SetPaused(true, Symbol("FightEndPause"))
			end

			module.UnequipWeapon(__wf_atom_c4f78a8f, __wf_atom_bedb4e3f)

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar(nil)
			end

			if not __wf_atom_7e8ad928(floppetFlightStartPortForwarder) then
				floppetFlightStartPortForwarder:FirePort("TriggerPort")
			end
		elseif modeState2 == 6 then
			__wf_atom_c4f78a8f:__wf_atom_cf966a74(v8)
			fn5()
			module2.EndBossFightNpcEventTracking(statsBossFightName, v5)
			module2.EndBossFight(statsBossFightName)
			module5.NotifyBossComplete()

			if not __wf_atom_7e8ad928(v5) then
				v5:Destroy()
			end

			if not __wf_atom_7e8ad928(fightEndPortForwarder) then
				fightEndPortForwarder:FirePort("TriggerPort")
			end

			module.UnequipWeapon(__wf_atom_c4f78a8f, true)
			DisableBlightZoneRespawning()
		end
	else
		fn4()
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

				if v12 ~= true then
					module4.RegisterPreventNighfoldUsage(true)
					module4.SetPreventNightfoldUsageReason(module4.BT_COMBAT)
					v12 = true
					_T.PreventingNightfold = true
				end

				EnableBlightZoneRespawning()

				if not __wf_atom_7e8ad928(v5) then
					v5:__wf_atom_15b36b95(true)
				end

				for i = 1, #v do
					module.SetCustomLockOnSettings(v[i], lockonRadius, lockOnDist, lockOnDistFade, lockOnSizeFade)
				end

				if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
					_T.SetupBossAvatar(v5)
				end
			elseif modeState2 == 5 then
				__wf_atom_c4f78a8f:__wf_atom_aeb02c14(v8)

				for _, v15 in v do
					if __wf_atom_7e8ad928(v15) or not v15:__wf_atom_4417a5d4() then
						continue
					end

					if not __wf_atom_7e8ad928(v15:__wf_atom_7470861b()) then
						v15:__wf_atom_7470861b():__wf_atom_9c80ef1a(6)
					end

					v15:Heal(v15, v15:GetMaxHealth())
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

local function fn7(_, _, _)
	__wf_atom_4f3659d1("Fight Controls")
	__wf_atom_05a856ad("Select Fight Stage:")

	if __wf_atom_7e8ad928(names) then
		names = {}

		for _, v15 in ipairs(v11) do
			table.insert(names, v15.name)
		end
	end

	v14 = __wf_atom_fdfab732("##", v14, names)
	__wf_atom_78aeed31()

	if not __wf_atom_80afb308("Skip to selected") or modeState == v14 then
		return false
	end

	modeState = v14

	if modeState == 4 then
		v5:SetVisibility(true)
		v5:__wf_atom_30964595(true)
	end

	v4:SetModeState(modeState)
	return true
end

local function fn8()
	local v15

	if __wf_atom_489de21b("Boss Spawn Settings") then
		if v11[modeState] == nil then
			__wf_atom_05a856ad("Unknown Mode State " .. tostring(modeState))
			__wf_atom_48bcafdc()
			return
		else
			__wf_atom_05a856ad("Fight Stage: " .. modeState .. " - " .. v11[modeState].name)
			__wf_atom_07947f07()
			v15 = fn7()
			__wf_atom_07947f07()
			__wf_atom_07947f07()

			if
				not __wf_atom_7e8ad928(bossTester)
				and __wf_atom_80afb308("Attach Boss Tester")
				and not __wf_atom_7e8ad928(v5)
			then
				v5:Attach(Type(bossTester), EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				v5:SetVisibility(true)
				v5:__wf_atom_30964595(true)
				module.SetImmunity(v5, false)
			end

			__wf_atom_78aeed31()

			if __wf_atom_80afb308("Respawn Boss") and __wf_atom_7e8ad928(v5) then
				v5, v6, v7 = fn2(agentType, false, spawnPoint, false, false, false)
				v4:SetModeState(1)
			end

			__wf_atom_78aeed31()

			if __wf_atom_80afb308("Reset Fight") then
				ResetFight()
			end
		end
	else
		v15 = false
	end

	__wf_atom_48bcafdc()

	if v15 then
		fn6(modeState)
	end
end

local function fn9(_)
	v = gRegion:__wf_atom_ef7900cf()
	v2 = gRegion:__wf_atom_d52d8448()
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
		if not __wf_atom_7e8ad928(_T.IntroFinished) or _T.IntroFinished == true then
			v4:SetModeState(4)
		end
	elseif modeState < 6 and not __wf_atom_7e8ad928(v5) then
		if modeState == 4 then
			if _T.AllHeadsRemoved == true then
				v4:SetModeState(5)
			end

			if not __wf_atom_7e8ad928(_T.needsBarRestored) and _T.needsBarRestored then
				if v12 ~= true then
					module4.RegisterPreventNighfoldUsage(true)
					module4.SetPreventNightfoldUsageReason(module4.BT_COMBAT)
					v12 = true
					_T.PreventingNightfold = true
				end

				_T.PreventingNightfold = true
				_T.needsBarRestored = nil

				if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
					_T.SetupBossAvatar(v5)
				end
			end
		elseif modeState == 5 then
			fn5()

			if _T.FloppetFlightCompleted then
				v4:SetModeState(6)
			end
		end
	elseif modeState == 6 and _T.BromiusFightCompleted then
		flag = true
	end

	fn8()
end

local function fn10(_)
	if not gRegion:IsMaster() then
		v = gRegion:__wf_atom_ef7900cf()
		v2 = gRegion:__wf_atom_d52d8448()

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
				for _, v15 in v do
					if __wf_atom_7e8ad928(v15) or __wf_atom_7e8ad928(v15:__wf_atom_7470861b()) then
						continue
					end

					v15:__wf_atom_7470861b():__wf_atom_9c80ef1a(6)
				end
			end
		end
	end
end

function EnableBlightZoneRespawning()
	if __wf_atom_7e8ad928(v9) then
		print("Blighted Zone did not activate, Normal respawning enabled")
		return
	end

	module3.ActivateBlightZone(v9, true, true, false, ResetFight)
	print("Blighted Zone active")
end

function DisableBlightZoneRespawning()
	module3.DeactivateBlightZone(true)
end

function ResetFight()
	print("ResetFight")
	modeState = 2
	module.TaggedFirePorts(Symbol("ResetBossFight"), "TriggerPort")

	if not __wf_atom_7e8ad928(resumeFightTrigger) then
		resumeFightTrigger:Enable()
	end

	if not __wf_atom_7e8ad928(_T.BromiusSmogVFX) then
		_T.BromiusSmogVFX:PlayTriggeredFade()
		_T.BromiusSmogVFX = nil
	end

	if not __wf_atom_7e8ad928(fightResetPortForwarder) then
		fightResetPortForwarder:FirePort("TriggerPort")
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
	local v15 = false

	while not v15 do
		v15 = true

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

			v15 = false
			break
		end

		Sleep(0.2)
	end

	module3.RefillHealthPotions(5)
	fn3(false, true)
	fn4(false, true)
end

function StartScriptedFight()
	v4 = module.CreateModeMgr(fn6)

	if gRegion:IsMaster() then
		fn3(false, false)
	end

	fn4(false, true)
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
				fn3(true, false)
			end

			fn4(true, true)
			flag2 = false
		end

		v4:Update()
		modeState = v4:GetModeState(modeState)

		if gRegion:IsMaster() then
			fn9(__wf_atom_03df4e1d())
		end

		if not gRegion:IsMaster() then
			fn10(__wf_atom_03df4e1d())
		end
	until flag
end

function BromiusFightIntro(object)
	v = gRegion:__wf_atom_ef7900cf()
	v2 = gRegion:__wf_atom_d52d8448()

	for _, v15 in fightCinematicTags do
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v15)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:__wf_atom_7d4910e4() then
			module.WaitForCinematicToFinish(__wf_atom_0a6a5887)
		else
			__wf_atom_0a6a5887:SetInstigatorAvatar(v[1])
			__wf_atom_0a6a5887:FirePort("StartPlaying")

			while
				not __wf_atom_7e8ad928(__wf_atom_0a6a5887)
				and __wf_atom_0a6a5887:__wf_atom_7d4910e4()
				and not __wf_atom_0a6a5887:__wf_atom_e9546dc6()
			do
				Sleep(0)

				if __wf_atom_7e8ad928(object) or object:GetState() ~= 1 then
					continue
				end

				__wf_atom_0a6a5887:Skip()
			end

			if __wf_atom_0a6a5887:__wf_atom_e9546dc6() and not __wf_atom_7e8ad928(object) then
				if gRegion:IsMaster() then
					object:SetState(1)
				else
					object:__wf_atom_c063982d(1)
				end
			end

			fn(true, __wf_atom_0a6a5887)
		end
	end

	_T.IntroFinished = true
end

function BromiusFightEnd()
	module.Fade(false)

	if not gRegion:IsMaster() then
		return
	end

	v = gRegion:__wf_atom_ef7900cf()
	v2 = gRegion:__wf_atom_d52d8448()
	module.DespawnPlayerSummons()

	for _, v15 in fightCinematicTags do
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v15)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			continue
		end

		fn(false, __wf_atom_0a6a5887)
		__wf_atom_0a6a5887:SetInstigatorAvatar(v[1])
		__wf_atom_0a6a5887:FirePort("StartPlaying")

		while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end

		fn(true, __wf_atom_0a6a5887)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or not __wf_atom_0a6a5887:__wf_atom_e9546dc6() then
			continue
		end

		module.Fade(false)
	end

	_T.BromiusFightCompleted = true
end