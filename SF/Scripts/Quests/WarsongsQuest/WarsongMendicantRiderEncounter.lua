local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
require("SF.Scripts.Libs.RaycastLib")
require("SF.Scripts.Libs.QuestLib")
require("SF.Interface.SFUtilities")
require("SF.Interface.Libs.MusicCommon")
local module4 = require("SF.Scripts.Libs.RespawnLib")
local v = Symbol("WarsongMendicantRiderEncounter")
local v2 = Symbol("RiderSpawnPoint")
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local bbActiveMountAvatar = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = 0
local v17 = {}
local flag = false

function EnterTrigger(object, _)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_e919fb8e.bbAvatarEntered then
		__wf_atom_e919fb8e.bbAvatarEntered = true
	end
end

local function fn()
	module4.LockRespawnShrine(v7, disabledShrineTag)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(disabledShrineTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("Blighted Zone did not activate, Normal respawning enabled")
		return
	end

	module4.ActivateBlightZone(__wf_atom_0a6a5887, useBlightSpawning, true, false, ResetFight)
	print("Blighted Zone active")
end

local function fn2()
	print("---- Mendicant Rider Encounter - SPAWNING BOSS ----")

	if __wf_atom_7e8ad928(v7) or __wf_atom_7e8ad928(bossAgentType) then
		return
	end

	while not v15.bbAvatarEntered do
		Sleep(0)
	end

	Sleep(0)
	local __wf_atom_b7c04e13 = v7:__wf_atom_b7c04e13()
	local __wf_atom_dc309f8a = v6:__wf_atom_dc309f8a()

	if not __wf_atom_7e8ad928(__wf_atom_b7c04e13) and #__wf_atom_b7c04e13 > 0 then
		local v18 = __wf_atom_b7c04e13[1]
		__wf_atom_dc309f8a = __wf_atom_fa8d0177(v6:GetPosition(), v18:GetPosition())
	end

	v10 = v3:__wf_atom_402b3832(
		bossAgentType,
		v6:GetPosition(),
		__wf_atom_dc309f8a,
		module.DEFAULT_TEAM,
		questBossLevel,
		nil
	)
	_T.WarsongMendicantRiderPreDeath = false

	if __wf_atom_7e8ad928(v10) then
		return false
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		v10:__wf_atom_243da0d3(__wf_atom_0a6a5887, true)
	end

	v7:__wf_atom_97f955c1(v10)
	v11 = v10:__wf_atom_50a7d83e()
	local __wf_atom_e919fb8e_2 = v11:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e_2.bSpawnRotation = __wf_atom_dc309f8a
	v13 = module2.FindTaggedChild(v11:__wf_atom_be0bea4a(), Symbol("BossAwarenessTrigger"))

	if __wf_atom_7e8ad928(v13) then
		v13 = v11:Attach(
			Resource("/SF/Types/Enemies/Bosses/ReplicatedPlayerAwarenessScriptTrigger"),
			Symbol("GAME_C1_SPINE1"),
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)
	end

	v11:__wf_atom_7c8621d6()
	v11:SetVisibility(false)
	module2.SetImmunity(v11, true)

	if not (__wf_atom_7e8ad928(v11) or v11:IsKilled() or v11:__wf_atom_bedb4e3f()) then
		if flag then
			v11:SetVisibility(true)
		end

		if not __wf_atom_7e8ad928(v10) then
			v10:__wf_atom_920a5a62()
		end
	end

	module2.SetImmunity(v11, false)

	if not __wf_atom_7e8ad928(v13) then
		v13:Enable()
		v13:__wf_atom_400189c4(bossBarActivationRadius)
	end

	Sleep(0.1)
	v11:SetVisibility(true)
	local __wf_atom_e919fb8e = v11:__wf_atom_e919fb8e()

	while __wf_atom_7e8ad928(bbActiveMountAvatar) do
		bbActiveMountAvatar = __wf_atom_e919fb8e.bbActiveMountAvatar
		Sleep(0)
	end

	_T.WarsongMendicantRiderMountAvatar = bbActiveMountAvatar
	v12 = bbActiveMountAvatar:__wf_atom_30e3d82b()
	v10:__wf_atom_f54283ea()
	v12:__wf_atom_f54283ea()
end

local function fn3(p)
	v3 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(p) then
		print("Shutdown due to level streaming")
		return false
	end

	if __wf_atom_7e8ad928(v7) then
		v7 = p
		v4 = v7:__wf_atom_26b04ea9()
		v5 = v7:__wf_atom_dd85e6db()
		v6 = gRegion:__wf_atom_0a6a5887(v2)
		v9 = Range(0, v7:__wf_atom_103377cc())
		v17 = v7:__wf_atom_b7c04e13()
		v16 = #v17
	end

	if __wf_atom_7e8ad928(v14) then
		v14 = gRegion:__wf_atom_0a6a5887(bossAwarenessTriggerTag)
		v15 = v14:__wf_atom_e919fb8e()
	end

	if __wf_atom_7e8ad928(v15.bbAvatarEntered) then
		v15.bbAvatarEntered = false
	end

	local all = gRegion:FindAll(bossAgentType:__wf_atom_c6772fb4())

	if #all > 0 then
		if flag then
			v11 = all[1]
			v11:Destroy()
			bbActiveMountAvatar:Destroy()
		else
			v11 = all[1]
			v10 = v11:__wf_atom_30e3d82b()
			v13 = module2.FindTaggedChild(v11:__wf_atom_be0bea4a(), Symbol("BossAwarenessTrigger"))

			if __wf_atom_7e8ad928(v13) then
				v13 = v11:Attach(
					Resource("/SF/Types/Enemies/Bosses/ReplicatedPlayerAwarenessScriptTrigger"),
					Symbol("GAME_C1_SPINE1"),
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1
				)
			end

			if not __wf_atom_7e8ad928(v13) then
				v13:Enable()
				v13:__wf_atom_400189c4(bossBarActivationRadius)
			end

			v7:__wf_atom_2cc8420c(v7:__wf_atom_dd85e6db())
			return true
		end
	end

	if shouldEnableBlightedZone and __wf_atom_7e8ad928(_T.BlightZoneRespawning) and not _T.BlightZoneRespawning then
		fn()
	end

	fn2()
	Sleep(0)

	if __wf_atom_7e8ad928(v7) then
		print("Shutdown due to level streaming")
		return false
	end

	v7:__wf_atom_2cc8420c(v7:__wf_atom_dd85e6db())
	print("---- Mendicant Rider Encounter - START UP DONE ----")
	return true
end

local function fn4()
	print("---- Mendicant Rider Encounter - MAIN LOOP START ----")
	v7:__wf_atom_4026dfb5()

	while not module.ShouldShutDown(v7) or flag do
		v8 = v7:__wf_atom_6199ef01()
		module.CleanUpOutOfRangeEnemies(v7, v8)
		module4.UpdateBlightZone()

		if
			not __wf_atom_7e8ad928(bbActiveMountAvatar)
			and not __wf_atom_7e8ad928(v13)
			and bbActiveMountAvatar:__wf_atom_bedb4e3f()
			and not _T.WarsongMendicantRiderPreDeath
		then
			_T.WarsongMendicantRiderPreDeath = true
			v13:Disable()

			if gRegion:IsMaster() then
				for i = 1, #v17 do
					if
						__wf_atom_7e8ad928(v17[i])
						or not v17[i]:__wf_atom_bedb4e3f()
						or __wf_atom_7e8ad928((v17[i]:__wf_atom_a96eb2aa()))
					then
						continue
					end

					v17[i]:InstantRevive()
				end
			end
		end

		if __wf_atom_7e8ad928(bbActiveMountAvatar) or bbActiveMountAvatar:IsKilled() then
			v7:__wf_atom_8e6fec76(4)
			break
		else
			Sleep(1)
		end
	end

	if v7:__wf_atom_4026dfb5() == 4 and shouldEnableBlightedZone then
		module4.UnlockRespawnShrine(disabledShrineTag)
		module4.DeactivateBlightZone(true)
	end

	print("---- Mendicant Rider Encounter - MAIN LOOP END ----")
end

function ResetFight()
	print("---- Mendicant Rider Encounter - RESETTING ----")
	flag = true

	if not (__wf_atom_7e8ad928(v11) or __wf_atom_7e8ad928(v13)) then
		v13:Disable()
	end

	module3.CloseTransmissions()
	v17 = v7:__wf_atom_b7c04e13()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local v18 = false

	while not v18 do
		v18 = true

		for i = 1, #__wf_atom_3c8e1a7a do
			local flag2 = false

			for j = 1, #v17 do
				if
					__wf_atom_7e8ad928(__wf_atom_3c8e1a7a[i])
					or __wf_atom_3c8e1a7a[i]:__wf_atom_50a7d83e() ~= v17[j]
				then
					continue
				end

				flag2 = true
				break
			end

			if not flag2 then
				continue
			end

			v18 = false
			break
		end

		Sleep(0.2)
	end

	module4.RefillHealthPotions(5)
	Sleep(1)
	fn3(v7)
	fn4()
	flag = false
end

local function fn5()
	if __wf_atom_7e8ad928(v7) then
		print("Mendicant Rider Encounter: Shutdown due to level streaming")
		return
	end

	if v7:__wf_atom_3634e6d2() == 0 then
		v7:__wf_atom_050639fe()
		v7:__wf_atom_8776856a(0)
		v7:__wf_atom_8e6fec76(4)

		if module2.IsInOverworld() then
			while not __wf_atom_7e8ad928(v7) and v7:__wf_atom_e464a32f() > 0 and v3:__wf_atom_c6f505f2(v7) > 0 do
				Sleep(0)
			end
		else
			v7:Disable()
		end
	else
		v7:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(v7) then
		print("Mendicant Rider Encounter: Shutdown due to level streaming")
		return
	end

	if shouldEnableBlightedZone then
		module4.UnlockRespawnShrine(disabledShrineTag)
		module4.DeactivateBlightZone(true)
	end

	_T.WazzardPreDeath = nil
	module.RemoveAgents(v7)
	module.RemoveObjects(v7)
	Sleep(0)
	print("---- Mendicant Rider Encounter - SHUTDOWN ----")
end

function StartCombatEncounter(object)
	print("---- Mendicant Rider Encounter - START ----")

	if not fn3(object) then
		print("ERROR - Mendicant Rider Encounter failed to start properly.")
		return
	end

	object:__wf_atom_8e6fec76(2)
	fn4()
	fn5()
end