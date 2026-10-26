local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("Lotus.Scripts.Libs.PlacementUILib")
local module3 = require("SF.Interface.SFUtilities")
local total = 0
local v = nil
local v2 = false
local flag = false

local function fn()
	local __wf_atom_5b41f63b = gRegion:__wf_atom_22941262():__wf_atom_5b41f63b()
	local v3 = {
		Symbol("NPCGroupA"),
		Symbol("NPCGroupB"),
		Symbol("NPCGroupC"),
		Symbol("NPCGroupD"),
		Symbol("NPCGroupE")
	}
	local v4 = {
		{ "HydroidRelay", v3[1] }
	}
	local v5 = Symbol("NPCGroupA")

	for i = 1, #v4 do
		if string.find(__wf_atom_5b41f63b, v4[i][1]) == nil then
			continue
		end

		v5 = v4[i][2]
		break
	end

	for i = 1, #v3 do
		if v3[i] == v5 then
			continue
		end

		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v3[i])

		if not __wf_atom_2226b35c then
			continue
		end

		for j = 1, #__wf_atom_2226b35c do
			gRegion:__wf_atom_dd1e4d10(__wf_atom_2226b35c[j])
		end
	end
end

local function fn2()
	local all = gRegion:FindAll(__wf_atom_266572b1)

	if not __wf_atom_7e8ad928(all) then
		for i = 1, #all do
			all[i]:Disable()
		end
	end
end

local function fn3()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("DoorHint"))

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		for i = 1, #__wf_atom_2226b35c do
			__wf_atom_2226b35c[i]:FirePort("Lock")
		end
	end
end

local function fn4()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("PhotoBoothScript"))

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		for _, v3 in ipairs(__wf_atom_2226b35c) do
			v3:FirePort("Execute")
		end
	end
end

local function fn5()
	local v3 = { Symbol("Infested"), Symbol("CS1"), Symbol("Grate") }

	for i = 1, #v3 do
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v3[i])

		if __wf_atom_7e8ad928(__wf_atom_2226b35c) then
			continue
		end

		for j = 1, #__wf_atom_2226b35c do
			gRegion:__wf_atom_dd1e4d10(__wf_atom_2226b35c[j])
		end
	end

	local v4 = WeakResource("/Lotus/Fx/Env/Ice/IceGenericDeco")
	local v5 = WeakResource("/EE/Types/Alias/Decoration")
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("Ice"))

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		for i = #__wf_atom_2226b35c, 1, -1 do
			local isA = __wf_atom_2226b35c[i]:IsA(v4)

			if not (__wf_atom_2226b35c[i]:IsA(v5) or __wf_atom_2226b35c[i]:IsA(__wf_atom_8d0b7f88)) or isA then
				continue
			end

			gRegion:__wf_atom_dd1e4d10(__wf_atom_2226b35c[i])
			table.remove(__wf_atom_2226b35c, i)
		end
	end

	for i = 1, #typesToDestroy do
		local all = gRegion:FindAll(typesToDestroy[i])

		if __wf_atom_7e8ad928(all) then
			continue
		end

		for j = 1, #all do
			gRegion:__wf_atom_dd1e4d10(all[j])
		end
	end
end

local function fn6()
	local __wf_atom_5b41f63b = gRegion:__wf_atom_22941262():__wf_atom_5b41f63b()

	for i = 1, #playerShipPhotoboothLevels do
		if string.match(__wf_atom_5b41f63b, playerShipPhotoboothLevels[i]:__wf_atom_5b41f63b()) == nil then
			continue
		end

		flag = true
		break
	end

	local __wf_atom_589cefdb = __wf_atom_589cefdb

	if flag then
		__wf_atom_589cefdb = __wf_atom_0f45538d
	end

	local all = gRegion:FindAll(__wf_atom_589cefdb)

	if not __wf_atom_7e8ad928(all) then
		for i = 1, #all do
			local __wf_atom_db682341 = all[i]:__wf_atom_db682341()
			local v3 = false

			for j = 1, #triggerTagsToIgnore do
				if __wf_atom_db682341 ~= triggerTagsToIgnore[j] then
					continue
				end

				v3 = true
				break
			end

			if not v3 then
				for j = 1, #triggerTypesToIgnore do
					if not all[i]:IsA(triggerTypesToIgnore[j]) then
						continue
					end

					v3 = true
					break
				end
			end

			if not v3 then
				all[i]:Disable()
			end
		end
	end
end

local function fn7()
	for i = 1, #triggerTagsToDestroy do
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(triggerTagsToDestroy[i])

		if __wf_atom_7e8ad928(__wf_atom_2226b35c) or not (#__wf_atom_2226b35c > 0) then
			continue
		end

		for j = 1, #__wf_atom_2226b35c do
			__wf_atom_2226b35c[j]:Destroy()
		end
	end
end

local function fn8()
	if not __wf_atom_72884638("Photobooth.UseLevelPostProcess") then
		local all = gRegion:FindAll(__wf_atom_4d4372ee)

		if not __wf_atom_7e8ad928(all) then
			for i = 1, #all do
				if not all[i]:__wf_atom_1d13ef4d() then
					continue
				end

				all[i]:__wf_atom_d3890893(false)
				return
			end
		end
	end
end

local function fn9() -- 1 equivalent call inferred from this helper
	local all = gRegion:FindAll(__wf_atom_96b9d246)

	for i = 1, #all do
		all[i]:Disable()
	end
end

function OnLevelLoaded(_)
	if string.find(gRegion:__wf_atom_22941262():__wf_atom_5b41f63b(), "Relay") ~= nil then
		fn()
	end

	if not __wf_atom_72884638("Photobooth.UseLevelPostProcess") then
		fn2()
	end

	fn3()
	fn4()
	Sleep(0)
	fn5()
	fn6()
	fn7()
	fn9() -- inferred equivalent call
end

function OnHostShipSynced(p, _)
	if p then
		_T.WaitingForShipSync = false
	end
end

function OnUpdate(p, p2)
	if __wf_atom_7e8ad928(v) then
		v = module2.CreateFreeCam(
			cameraInputFilter,
			defaultCamSpeed,
			minCameraStartDistance,
			false,
			enterFreeCameraSound,
			exitFreeCameraSound,
			cameraSequencerType
		)
	end

	v:OnUpdate(p, p2)

	if gRegion:IsMaster() then
		total += __wf_atom_084b3e93()

		if total >= 3 then
			module3.UpdatePausedEnemies()
			total = 0
		end

		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for i = 1, #__wf_atom_ef7900cf do
			local __wf_atom_d2b2176d = __wf_atom_ef7900cf[i]:__wf_atom_d2b2176d()

			if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
				continue
			end

			local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				__wf_atom_e55d02aa:__wf_atom_9e7c0c61(__wf_atom_e55d02aa:__wf_atom_6a5c92a7())
			end

			local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

			if
				__wf_atom_7e8ad928(__wf_atom_35a10d3c)
				or __wf_atom_35a10d3c:__wf_atom_e5141e5b()
				or __wf_atom_35a10d3c:__wf_atom_89832c32() ~= 0
			then
				continue
			end

			__wf_atom_d2b2176d:__wf_atom_9b9a17f5()
		end
	end

	local isMaster = gRegion:IsMaster()
	local __wf_atom_5b41f63b = gRegion:__wf_atom_22941262():__wf_atom_5b41f63b()

	if not isMaster then
		for i = 1, #playerShipPhotoboothLevels do
			if string.match(__wf_atom_5b41f63b, playerShipPhotoboothLevels[i]:__wf_atom_5b41f63b()) == nil then
				continue
			end

			flag = true
			break
		end
	end

	if flag and not (v2 or __wf_atom_7e8ad928(_T.BackgroundMovie)) then
		local isApartmentLevel = module.IsApartmentLevel()

		if isMaster then
			_T.WaitingForShipSync = false
		else
			_T.WaitingForShipSync = true
			local v3 = { host = nil, shipInterior = nil }
			local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

			if __wf_atom_bb46d8b6 ~= nil then
				for i = 1, #__wf_atom_bb46d8b6 do
					local host = __wf_atom_bb46d8b6[i]

					if not host.isHost then
						continue
					end

					v3.host = host
					__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_30429067(
						"OnHostShipSynced",
						host.onlineId,
						host.name,
						gGameRules:__wf_atom_69121d20()
					)
					break
				end
			end

			if not isApartmentLevel then
				local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

				if __wf_atom_3c8e1a7a ~= nil then
					for i = 1, #__wf_atom_3c8e1a7a do
						local v4 = __wf_atom_3c8e1a7a[i]

						if __wf_atom_7e8ad928(v4) or v3.host.playerId ~= v4:__wf_atom_ef151cfd() then
							continue
						end

						v3.shipInterior = v4:__wf_atom_a4299765().mShipInterior
						break
					end
				end

				local all = gRegion:FindAll(__wf_atom_1e218e76)

				if all ~= nil and v3.shipInterior ~= nil then
					for i = 1, #all do
						local __wf_atom_e800787c = all[i]:__wf_atom_e800787c()

						if (__wf_atom_7e8ad928(__wf_atom_e800787c) and 1 or __wf_atom_e800787c:__wf_atom_dd89d98c()) ~= 261 then
							all[i]:__wf_atom_81175384(v3.shipInterior)
						end
					end
				end
			end
		end

		while _T.WaitingForShipSync do
			Sleep(0)
		end

		if isApartmentLevel then
			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("InitLandscape"))

			for _, v3 in ipairs(__wf_atom_2226b35c) do
				v3:FirePort("Execute")
			end
		end

		v2 = true
	end
end

function OnPlayerConnected(_, _) end

function OnPlayerSpawned(_, object)
	if gRegion:IsMaster() then
		local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
		gGameRules:__wf_atom_ff18602b(object, __wf_atom_50a7d83e)

		if not object:IsLocal() then
			module2.MakeAvatarInvincible(__wf_atom_50a7d83e)
			local __wf_atom_d2b2176d = __wf_atom_50a7d83e:__wf_atom_d2b2176d()

			if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
				local __wf_atom_1915cc84 = __wf_atom_d2b2176d:__wf_atom_1915cc84()

				if not __wf_atom_7e8ad928(__wf_atom_1915cc84) then
					module2.MakeAvatarInvincible(__wf_atom_1915cc84)
				end
			end
		end

		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if __wf_atom_eab484a7:__wf_atom_ce4e872c() then
			__wf_atom_eab484a7:ToggleFreeCamera()
			__wf_atom_eab484a7:__wf_atom_9efbf072(false)
		end
	end
end

function ApplyKahlCustomization(object, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		print("Cannot apply Kahl customization")
	end

	while not object:__wf_atom_d25abf5f() do
		Sleep(0)
	end

	local __wf_atom_e55d02aa = object2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		__wf_atom_e55d02aa:SetCustomization(object:__wf_atom_a4299765().mKahlCustomization.mCustomization)
	end
end

function OnLocalAvatarCreated(_, p)
	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_f1e607e3(true)
	end

	if not __wf_atom_72884638("Photobooth.UseLevelPostProcess") then
		fn8()
	end

	if not __wf_atom_7e8ad928(v) then
		v:InitCamera(
			p,
			freeCameraAvatar,
			cameraSpot,
			photoboothControlsMovie,
			arsenalTriggerType,
			arsenalTeleportTriggerType
		)
	end
end

function OnDeath(_, _, _, _, _) end

function CheckMissionRequirements(_)
	return ""
end

function ReceivedCustomRaidData(_, p, p2)
	if __wf_atom_7e8ad928(_T.RaidCustomData) then
		print("LotusGameRules.lua::ReceivedCustomRaidData - no global function defined")
	else
		_T.RaidCustomData(p, p2)
	end
end

function OnAgentCreated(p, p2)
	if _T.OnAgentSpawnedCallback then
		_T.OnAgentSpawnedCallback(p, p2)
	end
end

function CameraToggleControl()
	module2.CameraToggleControl(photoboothControlsMovie)
end