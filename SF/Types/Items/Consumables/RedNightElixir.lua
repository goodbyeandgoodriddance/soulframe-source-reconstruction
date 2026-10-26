local module = require("SF.Scripts.Libs.RespawnLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.QuestLib")
local module4 = require("Lotus.Scripts.Libs.AudioLib")
local module5 = require("SF.Scripts.Libs.StatsLib")
local module6 = require("SF.Scripts.Libs.EncounterLib")
local module7 = require("SF.Scripts.NightFoldLib")
local v = Symbol("HardModeActive")
local v2 = Symbol("HardModeBossStarted")
local v3 = Symbol("AbandonHardMode")
local v4 = Symbol("HardModeEnemyLevel")
local v5 = Symbol("HardModeSubBossKillCount")
local v6 = Symbol("HardModedAbandoning")
local v7 = Symbol("HardModedAbandoned")
local v8 = Symbol("HardModeAbandonedRadius")
local v9 = Symbol("HardModeLevelIncrease")
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = false
local v15 = 0
local minEncounterAbandonRadius2 = nil
local v16 = Symbol("HARD_MODE_TIME")
local v17 = nil

local function fn()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ActiveSubBossHint"))

	for i = 1, #__wf_atom_2226b35c do
		local v18 = __wf_atom_2226b35c[i]

		if __wf_atom_7e8ad928(v18) or not (v18:__wf_atom_3634e6d2(true) > 0) then
			continue
		end

		local __wf_atom_6199ef01 = v18:__wf_atom_6199ef01()

		for j = 1, #__wf_atom_6199ef01 do
			local __wf_atom_50a7d83e = __wf_atom_6199ef01[j]:__wf_atom_50a7d83e()

			if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				continue
			end

			local __wf_atom_bb3e7833 = __wf_atom_50a7d83e:__wf_atom_bb3e7833(hardModeAttachFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end
end

function IsHardModeActive()
	return gGameRules:__wf_atom_d163c8e5(v, 0) ~= 0
end

function SetHardModeActive(p)
	if gRegion:IsMaster() then
		gGameRules:SetNetPersistentVar(v, p and 1 or 0)
		module4.EnableTaggedSoundSysVolumes(Symbol("RednightAmbience"), true)
	end
end

function HardModeZeroSubBossKillCount()
	if gRegion:IsMaster() then
		gGameRules:SetNetPersistentVar(v5, 0)
	end
end

function Evaluate(object, _)
	local v18 = module2.WaitForAiDir()
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return false
	end

	if
		object:__wf_atom_58dabbc7()
		or object:__wf_atom_47fbd15c()
		or object:__wf_atom_d2b2176d():__wf_atom_9f71ab59(true)
	then
		return false
	end

	if v18:__wf_atom_37241977(__wf_atom_a96eb2aa) then
		_T.ShowImpactMessage(playerInCombat, 5)
		return false
	end

	if not module6.IsHardModeActive() then
		return true
	end

	_T.ShowImpactMessage(hardmodeActive, 5)
	return false
end

function UndoRednightTransformSky()
	module2.ModifySky(timeOfDay, false, lerpTimeOfDay, false, 0, false)
end

function TransformSky()
	module2.ModifySky(timeOfDay, true, lerpTimeOfDay, false, skyTransitionTime, false, Symbol("RednightSky"))
end

function DrunkTransition()
	_T.DrunkBias = drunkBaisAmount
end

local function fn2()
	if gRegion:IsMaster() then
		local all = gRegion:FindAll(__wf_atom_f806fd7a)

		for _, v18 in ipairs(all) do
			local v19 = false

			for _, className in ipairs(shutdownEncounterExceptions) do
				if not v18:IsA(className) then
					continue
				end

				v19 = true
				break
			end

			if v19 then
				continue
			end

			local __wf_atom_4026dfb5 = v18:__wf_atom_4026dfb5()

			if __wf_atom_4026dfb5 ~= 0 and __wf_atom_4026dfb5 ~= 6 then
				v18:__wf_atom_8e6fec76(6)
			end
		end
	end
end

function WakeInNightfold()
	local v18 = { Label = modeEndedText, CacheIndex = 1 }

	if not __wf_atom_7e8ad928((gRegion:__wf_atom_c4f78a8f())) then
		module4.PlaySound(redNightEndTransitionSound)
	end

	module2.Fade(true, 0, 1)
	Sleep(1)
	module3.WakeUpInNightFold(5, nil, nil, true, v18)
	module2.Fade(false, 2, 1, false)
end

function KillPreDeathPlayers()
	gRegion:__wf_atom_ef7900cf()
	module2.Fade(true, 0.5, 4)
	local v18 = false

	while not v18 do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		v18 = true

		for i = 1, #__wf_atom_ef7900cf do
			local v19 = __wf_atom_ef7900cf[i]

			if not (__wf_atom_7e8ad928(v19) or v19:__wf_atom_bedb4e3f() or v19:IsKilled()) then
				continue
			end

			v18 = false
			break
		end

		Sleep(0)
	end

	Sleep(0.2)
	WakeInNightfold()
end

function AllPlayersKilled()
	if not __wf_atom_7e8ad928(gRegion) and gRegion:IsMaster() then
		SetHardModeActive(false)
	end
end

local function fn3()
	if not __wf_atom_7e8ad928(gRegion) and gRegion:IsMaster() then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_21342f4a:__wf_atom_0d1ea252(v16, "RedNightElixir")
			module5.LogEventWithContext("HARD_MODE_STOP", __wf_atom_c4f78a8f, nil, { h = 1 })
		end
	end

	gGameRules:__wf_atom_1033a361(hardModeDebuffAuraUpgrade)
	fn()
	_T.HideImpactMessage()
	KillPreDeathPlayers()
	module7.RegisterPreventNighfoldUsage(false)
	fn2()
	_T.hardModeLevelMod = 0
	_T.DrunkBias = 0
	module.DeactivateBlightZone(true)
	UndoRednightTransformSky()
	module4.EnableTaggedSoundSysVolumes(Symbol("RednightAmbience"), false)
	gGameRules:UnHideGameSession()
end

local function fn4(p, p2)
	gGameRules:SetNetPersistentVar(v6, p and 1 or 0)

	if p then
		gGameRules:__wf_atom_008b0b38(true, math.ceil(p2), "/SF/Language/Objectives/AbandonCogah")

		if p2 <= 0 and gRegion:IsMaster() then
			gGameRules:SetNetPersistentVar(v7, 1)
		end
	else
		gGameRules:__wf_atom_008b0b38(false, 0, "/SF/Language/Objectives/AbandonCogah")
	end
end

function UpdateAbanondCount(_)
	local v18 = {}

	while gGameRules:__wf_atom_d163c8e5(v2) == 1 do
		local v19 = v15

		for _, v20 in pairs(v17) do
			if __wf_atom_7e8ad928(v20) or v20:IsKilled() then
				continue
			end

			v13 = v20:__wf_atom_1c8f7b2d(v10)
			v15 = gGameRules:__wf_atom_d163c8e5(v3)

			if minEncounterAbandonRadius2 <= v13 and v15 <= gRegion:__wf_atom_d52d8448() then
				if not module2.TableContains(v18, v20) then
					v15 += 1
					gGameRules:SetNetPersistentVar(v3, v15)
					table.insert(v18, v20)
				end
			elseif v13 <= minEncounterAbandonRadius2 and v15 > 0 and module2.TableContains(v18, v20) then
				v15 -= 1

				if v15 < 0 then
					v15 = 0
				end

				gGameRules:SetNetPersistentVar(v3, v15)
				local tableGetIndex = module2.TableGetIndex(v18, v20)
				table.remove(v18, tableGetIndex)
			end
		end

		if isDebuggingEnabled and v19 ~= v15 then
			local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v3)
			print("Cogah Mode Abandon Thrshold Count: " .. tostring(__wf_atom_d163c8e5))
		end

		Sleep(0)
	end
end

local function fn5(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if gGameRules:__wf_atom_d163c8e5(v2) == 1 then
		if __wf_atom_7e8ad928(minEncounterAbandonRadius2) then
			if gRegion:IsMaster() and gGameRules:__wf_atom_d163c8e5(v8) == 0 then
				if __wf_atom_7e8ad928(v10) then
					Sleep(2)
					local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

					for _, v18 in ipairs(__wf_atom_ef7900cf) do
						v10 = gRegion:__wf_atom_f738b4af(Symbol("ActiveSubBossHint"), v18:__wf_atom_a2a18137(), 0, 30)

						if not __wf_atom_7e8ad928(v10) then
							break
						end
					end

					if __wf_atom_7e8ad928(v10) then
						return
					end

					if __wf_atom_7e8ad928(v11) then
						v11 = gRegion:CreateEntity(
							clientHintWpType,
							object:__wf_atom_a2a18137(),
							__wf_atom_80368bb1,
							object,
							object,
							1
						)
					end

					v11:Teleport(v10:__wf_atom_a2a18137(), v10:__wf_atom_2f2bada0())
					local v18 = v10:__wf_atom_4a0ffa6e() - (v10:__wf_atom_4a0ffa6e() - v10:__wf_atom_8f18e876())

					if minEncounterAbandonRadius < v18 then
						minEncounterAbandonRadius2 = v18
					else
						minEncounterAbandonRadius2 = minEncounterAbandonRadius
					end

					gGameRules:SetNetPersistentVar(v8, minEncounterAbandonRadius2)
					v10:__wf_atom_8a035cd5(Symbol("UpdateAbanondCount"), false)

					if isDebuggingEnabled then
						print("Hint Location is: " .. tostring(v10:GetPosition()))
						print("Client Hint Location is: " .. tostring(v11:GetPosition()))
						print("Encounter Abandoned Radius set = " .. tostring(minEncounterAbandonRadius2))
					end
				end
			elseif not gRegion:IsMaster() and gGameRules:__wf_atom_d163c8e5(v8) >= 1 then
				minEncounterAbandonRadius2 = gGameRules:__wf_atom_d163c8e5(v8)

				if isDebuggingEnabled then
					print("Client Hint Location is: " .. tostring(v10:GetPosition()))
					print("Client Encounter Abandoned Radius set = " .. tostring(minEncounterAbandonRadius2))
				end
			end
		elseif not __wf_atom_7e8ad928(minEncounterAbandonRadius2) then
			if __wf_atom_7e8ad928(v10) then
				return
			end

			v12 = object:__wf_atom_1c8f7b2d(v10)

			if minEncounterAbandonRadius2 <= v12 and not v14 then
				_T.DrunkBias = 2

				if not __wf_atom_7e8ad928((object:CameraControl())) then
					object:CameraControl():__wf_atom_25382a0d(0.7, false)
				end

				object:MotionControl():__wf_atom_99fc7a82(true)
				v14 = true
			elseif v12 < minEncounterAbandonRadius2 and v14 then
				_T.DrunkBias = 0.15
				local cameraControl = object:CameraControl()

				if not __wf_atom_7e8ad928(cameraControl) then
					cameraControl:__wf_atom_25382a0d(1, false)
				end

				object:MotionControl():__wf_atom_99fc7a82(false)
				v14 = false
			end
		end
	elseif gGameRules:__wf_atom_d163c8e5(v2) == 2 then
		if gRegion:IsMaster() then
			gGameRules:SetNetPersistentVar(v3, 0)
			gGameRules:SetNetPersistentVar(v8, 0)
			fn4(false, 0)
		end

		v14 = false
		minEncounterAbandonRadius2 = nil
		_T.DrunkBias = 0.15

		if not __wf_atom_7e8ad928((object:CameraControl())) then
			object:CameraControl():__wf_atom_25382a0d(1, false)
		end

		object:MotionControl():__wf_atom_99fc7a82(false)
	end
end

local function fn6()
	if gRegion:IsMaster() then
		for _, v18 in ipairs(gRegion:__wf_atom_ef7900cf()) do
			local __wf_atom_e919fb8e = v18:__wf_atom_e919fb8e()

			if __wf_atom_7e8ad928(__wf_atom_e919fb8e.hardMode) then
				__wf_atom_e919fb8e.hardMode = {}
			end

			if
				__wf_atom_7e8ad928(__wf_atom_e919fb8e.hardMode)
				or __wf_atom_7e8ad928(__wf_atom_e919fb8e.hardMode.subBossKillCallback)
			then
				continue
			end

			__wf_atom_e919fb8e.hardMode.subBossKillCallback(v18)
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local __wf_atom_e919fb8e = __wf_atom_c4f78a8f:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.hardMode.auraObj) then
			__wf_atom_e919fb8e.hardMode.auraObj = gRegion:CreateObject(hardModeDebuffAuraUpgrade, __wf_atom_c4f78a8f)
			gGameRules:__wf_atom_b714cf71(__wf_atom_e919fb8e.hardMode.auraObj)
		end
	end
end

local fn7

local function fn8()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local abandonTime2 = abandonTime
	local total = 0

	while not (gRegion:IsMaster() or module6.IsHardModeActive()) do
		Sleep(0)
	end

	while module6.IsHardModeActive() do
		Sleep(0)

		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		end

		if gRegion:IsMaster() then
			if __wf_atom_7e8ad928(v11) then
				v11 = gRegion:CreateEntity(
					clientHintWpType,
					__wf_atom_c4f78a8f:__wf_atom_a2a18137(),
					__wf_atom_80368bb1,
					__wf_atom_c4f78a8f,
					__wf_atom_c4f78a8f,
					1
				)
			end
		else
			while __wf_atom_7e8ad928(v10) do
				Sleep(0)
				v10 = gRegion:__wf_atom_0a6a5887(Symbol("ActiveCogahBossWP"))
			end
		end

		if _T.BlightZone == nil then
			local allPlayersKilled = AllPlayersKilled
			module.ActivateBlightZone(nil, true, true, false, allPlayersKilled)
		end

		module.UpdateBlightZone()
		fn5(__wf_atom_c4f78a8f)

		if not gRegion:IsMaster() then
			continue
		end

		if gGameRules:__wf_atom_d163c8e5(v2) == 1 then
			if gGameRules:__wf_atom_d163c8e5(v3) == gRegion:__wf_atom_d52d8448() then
				if abandonTime2 <= 0 then
					fn4(false, 0)
					local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

					for i = 1, #__wf_atom_ef7900cf do
						__wf_atom_ef7900cf[i]:Damage(99999)
					end

					gGameRules:SetNetPersistentVar(v2, 0)
				else
					fn4(true, abandonTime2)
					abandonTime2 -= __wf_atom_03df4e1d()
				end
			elseif abandonTime2 > 0 and abandonTime2 ~= abandonTime then
				fn4(false, 0)
				abandonTime2 = abandonTime
			end
		elseif gGameRules:__wf_atom_d163c8e5(v2) == 2 then
			if total >= 15 then
				gGameRules:SetNetPersistentVar(v2, 0)
			end

			total += __wf_atom_03df4e1d()
		elseif total >= 15 then
			total = 0
		end
	end

	fn3()

	if debugStayOnAfterDeath then
		local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()

		while __wf_atom_7e8ad928(__wf_atom_c4f78a8f2) do
			Sleep(1)
		end

		fn7(__wf_atom_c4f78a8f2)
	end
end

fn7 = function(object)
	module2.WaitForLevel()

	while __wf_atom_7e8ad928(object) do
		Sleep(0)
		object = gRegion:__wf_atom_c4f78a8f()
	end

	SetHardModeActive(true)

	if gRegion:IsMaster() then
		gGameRules:SetNetPersistentVar(v4, redNightBaseLevel)
		gGameRules:SetNetPersistentVar(v9, redNightLevelIncrease)
		gGameRules:SetNetPersistentVar(v3, 0)
		gGameRules:SetNetPersistentVar(v2, 0)
		gGameRules:SetNetPersistentVar(v7, 0)
		gGameRules:SetNetPersistentVar(v8, 0)
		v11 = gRegion:CreateEntity(clientHintWpType, object:__wf_atom_a2a18137(), __wf_atom_80368bb1, object, object, 1)
		v17 = gRegion:__wf_atom_ef7900cf()
	else
		while __wf_atom_7e8ad928(v10) do
			v10 = gRegion:__wf_atom_0a6a5887(Symbol("ActiveCogahBossWP"))
			Sleep(0)
		end
	end

	_T.hardModeLevelMod = 0
	_T.DrunkBias = 0.15

	while __wf_atom_7e8ad928(object) do
		Sleep(0)
		object = gRegion:__wf_atom_c4f78a8f()
	end

	if not __wf_atom_7e8ad928(loreDrop) then
		module2.GiveLoreFragment(object, loreDrop)
	end

	fn6()
	local allPlayersKilled = AllPlayersKilled
	module.ActivateBlightZone(nil, true, true, false, allPlayersKilled)
	fn8()
end

function GameModeStart()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if gRegion:IsMaster() then
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("AgaricMushroom"))

		for _, v18 in ipairs(__wf_atom_2226b35c) do
			if not __wf_atom_7e8ad928(v18) then
				v18:Destroy()
			end
		end

		gGameRules:HideGameSession(true)
	end

	fn2()
	fn7(__wf_atom_c4f78a8f)
end

function GameModeStartNoCin()
	TransformSky()
	DrunkTransition()
	GameModeStart()
end

function Activate(object)
	local motionControl = object:MotionControl()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(startCinTag)
	module2.WaitForLevel()

	if IsHardModeActive() then
		return
	end

	gGameRules:__wf_atom_5c7766b3()
	SetHardModeActive(true)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887 = object:Attach(activationCinematic, EMPTY_SYMBOL)
	end

	if unequipWeapon then
		if unequipInstant then
			if object:__wf_atom_4417a5d4() then
				__wf_atom_d2b2176d:Unequip(0, 2)
			end
		else
			if object:__wf_atom_4417a5d4() then
				__wf_atom_d2b2176d:Unequip(0, 0)
			end

			while
				not __wf_atom_7e8ad928(object)
				and not object:IsKilled()
				and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14
			do
				Sleep(0)
			end
		end
	end

	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_0a6a5887)) then
		__wf_atom_0a6a5887:SetInstigatorAvatar(object)
		__wf_atom_0a6a5887:StartRelative(
			Symbol("Envoy"),
			object:__wf_atom_a2a18137(),
			motionControl:__wf_atom_d9cb4b97()
		)
	end

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		HardModeZeroSubBossKillCount()
		__wf_atom_21342f4a:StartTimer(v16, "RedNightElixir")
		module5.LogEventWithContext("HARD_MODE_START", object, nil)
	end

	if not (__wf_atom_7e8ad928(object) or object:IsKilled()) then
		Sleep(10)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Destroy()
		end
	end
end