local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("Lotus.Scripts.Libs.TransmissionSet")
local module3 = require("Lotus.Scripts.Libs.RailjackUtilities")
local v = Symbol("BeaconInvuln")
local v2 = {
	A = "<MISSION_MARKER_A>",
	B = "<MISSION_MARKER_B>",
	C = "<MISSION_MARKER_C>",
	D = "<MISSION_MARKER_D>"
}
local v3 = { A = 1, B = 2, C = 3, D = 4 }
local v4 = WeakResource("/Lotus/Types/Game/MarkerInfos/OplinkDefendMarker")
local v5 = { ACTIVE = 1, INACTIVE = 2, DESTROYED = 3 }

local function fn(uiColor_Yellow) -- 2 equivalent calls inferred from this helper
	if __wf_atom_7e8ad928(uiColor_Yellow) then
		return "<font color=\"#FFFFFF\">"
	end

	return "<font color=\"#" .. string.format("%X", uiColor_Yellow) .. "\">"
end

local function fn2(data, p) -- 4 equivalent calls inferred from this helper
	local v6 = __wf_atom_7e8ad928(p) and 41 or p
	return "<font color=\"" .. data.Colorize(v6) .. "\">"
end

local function fn3(data, p, p2, __wf_atom_e78ee67e, flag)
	if __wf_atom_7e8ad928(data) then
		data = _T.GetHudTracker("Beacon" .. p)
	end

	if __wf_atom_7e8ad928(data) then
		data = _T.AddHudTracker("Beacon" .. p, module.HT_LABEL)
		flag = true
	end

	if flag then
		data.SetSortPriority(15 + v3[p], false)
		data.SetOffset(25, -14, true)
	end

	local v6 = v2[p]
	local __wf_atom_fe47f148 = Engine.__wf_atom_fe47f148(__wf_atom_e78ee67e)
	local __wf_atom_746f9d1b = Engine.__wf_atom_746f9d1b(__wf_atom_e78ee67e)

	if string.len(__wf_atom_746f9d1b) > 15 then
		__wf_atom_746f9d1b = string.sub(__wf_atom_746f9d1b, 1, 15)
	end

	local v7 = __wf_atom_746f9d1b .. __wf_atom_fe47f148

	if p2 > 0 then
		local v8 = fn(_G.UIColor_Yellow) -- inferred equivalent call
		local v9 = "<p>" .. v8 .. data.Localize(v6, {}) .. " " .. v7 .. " </font>" .. fn2(data, nil) .. Localize("/Lotus/Language/SquadLink/OpLinkHealth", {}) .. "</font>" -- inferred equivalent call
		data.SetLabel(v9 .. fn2(data, 23) .. "<b>  " .. p2 .. "</b></font></p>") -- inferred equivalent call
		return data
	else
		local v8 = fn(_G.UIColor_Yellow) -- inferred equivalent call
		local v9 = "<p>" .. v8 .. data.Localize(v6, {}) .. " " .. v7 .. " </font>" .. fn2(data, nil) .. Localize("/Lotus/Language/SquadLink/OpLinkHealth", {}) .. "</font>" -- inferred equivalent call
		data.SetLabel(v9 .. fn2(data, 13) .. "<b>  " .. p2 .. "</b></font></p>") -- inferred equivalent call
		return data
	end
end

function DeployScenarioBeacon(object, _)
	if not gRegion:IsMaster() or _T.OpLinkDeployDisabled then
		return
	end

	if _T.OpLinkGroundMission or _T.OpLinkSpaceMission then
		if __wf_atom_7e8ad928(_T.ScenarioBeacons) then
			_T.ScenarioBeacons = gRegion:FindAll(scenarioBeaconAvatarType)
		end

		if __wf_atom_7e8ad928(_T.ScenarioBeacons) then
			_T.ScenarioBeacons = {}
		end

		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local __wf_atom_6be84646 = object:__wf_atom_a96eb2aa():__wf_atom_6be84646()
		local count = 0
		local v6 = nil

		for _, scenarioBeacon in ipairs(_T.ScenarioBeacons) do
			if __wf_atom_7e8ad928(scenarioBeacon) then
				continue
			end

			if scenarioBeacon:IsVisible() then
				count += 1

				if scenarioBeacon:__wf_atom_e78ee67e() == __wf_atom_6be84646 then
					_T.ShowImpactMessage("/Lotus/Language/SquadLink/BeaconAlreadyActive", 2, false)
					print("OpLink: Migration: Can't deploy because this oplink is already active. Player: " .. __wf_atom_6be84646)
					return
				end
			elseif scenarioBeacon:__wf_atom_e78ee67e() == __wf_atom_6be84646 then
				v6 = scenarioBeacon
			end
		end

		local randomPointInRangeOnNav

		if count > 0 then
			if _T.OpLinkGroundMission then
				randomPointInRangeOnNav = __wf_atom_7d789620:GetRandomPointInRangeOnNav(
					_T.BeaconSpawn.pos,
					3,
					12,
					true,
					1
				)
			else
				randomPointInRangeOnNav = __wf_atom_7d789620:GetRandomPointInRangeOnNav(
					_T.BeaconSpawn.pos,
					3,
					8,
					true,
					1
				)
			end
		else
			randomPointInRangeOnNav = _T.BeaconSpawn.pos
		end

		local v7 = Rotation()
		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("CondrixObject"), _T.BeaconSpawn.pos, 0, 40)

		if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			v7 = __wf_atom_fa8d0177(_T.BeaconSpawn.pos, __wf_atom_f738b4af:GetPosition())
			v7.pitch = 0
		end

		local v8

		if __wf_atom_7e8ad928(v6) then
			if __wf_atom_7e8ad928(_T.EndlessModeEnemyLevel) then
				__wf_atom_7d789620:__wf_atom_dcf48c53()
			end

			v6 = __wf_atom_7d789620:__wf_atom_402b3832(
				scenarioBeaconAgent,
				randomPointInRangeOnNav,
				v7,
				Symbol("ScannerDefenseTeam")
			):__wf_atom_50a7d83e()
			v8 = v6:__wf_atom_bb3e7833(v4)
			v6:__wf_atom_a5a65f92(__wf_atom_6be84646)
			v6:__wf_atom_506144ee(20000)
			v6:SetHealth(20000)

			if #_T.ScenarioBeacons == 0 and _T.OpLinkSpaceMission then
				module2.PlayGlobalTransmission(_T.SquadLinkTransmissionSet, Symbol("BeaconDeployed"))
			end

			table.insert(_T.ScenarioBeacons, v6)
		else
			v6:__wf_atom_7470861b():__wf_atom_a8cf605f(v)
			v6:SetVisibility(true, true)
			v6:Teleport(randomPointInRangeOnNav, v7)
			v8 = v6:__wf_atom_bb3e7833(v4)
		end

		local v9 = count + 1

		if gGameRules:__wf_atom_0fa72b69() == 32 then
			v8:__wf_atom_14f387e1(Range(0, 20))
			v8:__wf_atom_30972565(false)
		end

		local v10 = "A"
		local v11 = 40
		local markerIconA = markerIconA

		if v9 == 2 then
			markerIconA = markerIconB
			v11 = 41
			v10 = "B"
		elseif v9 == 3 then
			markerIconA = markerIconC
			v11 = 42
			v10 = "C"
		elseif v9 == 4 then
			markerIconA = markerIconD
			v11 = 43
			v10 = "D"
		end

		v8:SetIcon(markerIconA)
		v8:__wf_atom_1c088186(v11)
		v8:Enable()
		object:PlaySound(activatedSound, false, 0, true)

		if not __wf_atom_7e8ad928(_T.ScenarioBeaconSpawnedCallback) then
			for _, v12 in ipairs(_T.ScenarioBeaconSpawnedCallback) do
				if __wf_atom_7e8ad928(v12) or type(v12) ~= "function" then
					continue
				end

				v12(v6)
			end
		end

		print("OpLink: Deployed beacon .. " .. v10 .. " for player: " .. __wf_atom_6be84646)
	else
		local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
		__wf_atom_4e50d390.pitch = 0
		__wf_atom_4e50d390.bank = 0
		local position = object:GetPosition()
		local v6 = __wf_atom_9341614d(Vector(0, 5, 3), __wf_atom_4e50d390)
		VectorAdd(v6, v6, position)

		if not gRegion:__wf_atom_2202ffb6():__wf_atom_3c37bceb(v6, 15) then
			return
		end

		local v7 = Vector()

		if __wf_atom_7e8ad928(gRegion:Raycast(v6, v6 + Vector(0, -20, 0), nil, nil, v7, true, true)) then
			return
		end

		local v8 = __wf_atom_fa8d0177(v7, position)
		v8.pitch = 0
		v8.bank = 0
		_T.ScenarioBeacon = gRegion:CreateEntity(scenarioBeaconType, v7, v8, object)

		while not gMatchingService:__wf_atom_d309183e() do
			Sleep(0)

			if __wf_atom_7e8ad928(_T.ScenarioBeacon) then
				return
			end
		end
	end
end

local function fn4(object, p) -- 7 equivalent calls inferred from this helper
	gGameRules:DisplayMessage(object:__wf_atom_a96eb2aa(), p, "", 0, 2, false)
end

function Evaluate(object, _)
	if not gRegion:IsMaster() then
		return
	end

	if not (_T.OpLinkGroundMission or _T.OpLinkSpaceMission) then
		object:PlaySound(deniedSound, false, 0, false)
		return
	end

	local __wf_atom_6be84646 = object:__wf_atom_a96eb2aa():__wf_atom_6be84646()
	local v6 = Symbol("OPLK_" .. __wf_atom_6be84646)
	local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v6)

	if __wf_atom_d163c8e5 == v5.DESTROYED then
		object:PlaySound(deniedSound, false, 0, false)
		fn4(object, "/Lotus/Language/SquadLink/OplinkDestroyed") -- inferred equivalent call
		print("OpLink: Can't deploy because this oplink was already destroyed. Player: " .. __wf_atom_6be84646 .. " State: " .. __wf_atom_d163c8e5)
		return false
	else
		for _, scenarioBeacon in ipairs(_T.ScenarioBeacons) do
			if __wf_atom_7e8ad928(scenarioBeacon) or scenarioBeacon:__wf_atom_e78ee67e() ~= __wf_atom_6be84646 then
				continue
			end

			if not scenarioBeacon:IsVisible() then
				break
			end

			object:PlaySound(deniedSound, false, 0, false)
			fn4(object, "/Lotus/Language/SquadLink/BeaconAlreadyActive") -- inferred equivalent call
			print("OpLink: Can't deploy because this oplink is already active. Player: " .. __wf_atom_6be84646 .. " State: " .. __wf_atom_d163c8e5)
			return false
		end

		if __wf_atom_7e8ad928(_T.BeaconSpawn) then
			object:PlaySound(deniedSound, false, 0, false)

			if _T.OpLinkGroundMission then
				fn4(object, "/Lotus/Language/SquadLink/NoCondrixToScan") -- inferred equivalent call
				print("OpLink: Can't deploy because there is no condrix available to scan. Player: " .. __wf_atom_6be84646 .. " State: " .. __wf_atom_d163c8e5)
			else
				fn4(object, "/Lotus/Language/SquadLink/NotOnboardMurex") -- inferred equivalent call
				print("OpLink: Can't deploy because player is not onboard a murex. Player: " .. __wf_atom_6be84646 .. " State: " .. __wf_atom_d163c8e5)
			end

			return false
		elseif object:__wf_atom_a5304c35(_T.BeaconSpawn.pos) > _T.BeaconSpawn.radius then
			object:PlaySound(deniedSound, false, 0, false)
			fn4(object, "/Lotus/Language/SquadLink/PlaceBeaconInMarkedArea") -- inferred equivalent call
			print("OpLink: Can't deploy because it's outside the marked area. Player: " .. __wf_atom_6be84646 .. " State: " .. __wf_atom_d163c8e5)
			return false
		elseif
			_T.OpLinkSpaceMission
			and (__wf_atom_7e8ad928(_T.IsSatelliteDeployed) or not _T.IsSatelliteDeployed())
		then
			object:PlaySound(deniedSound, false, 0, false)
			fn4(object, "/Lotus/Language/SquadLink/SatelliteNotDeployed") -- inferred equivalent call
			print("OpLink: Can't deploy because satellite is not deployed. Player: " .. __wf_atom_6be84646 .. " State: " .. __wf_atom_d163c8e5)
			return false
		else
			local count = 0

			for _, scenarioBeacon in ipairs(_T.ScenarioBeacons) do
				if __wf_atom_7e8ad928(scenarioBeacon) then
					continue
				end

				local v7 = Symbol("OPLK_" .. scenarioBeacon:__wf_atom_e78ee67e())

				if gGameRules:__wf_atom_d163c8e5(v7) == v5.ACTIVE then
					count += 1
				end
			end

			if not (count >= 4) then
				return true
			end

			object:PlaySound(deniedSound, false, 0, false)
			fn4(object, "/Lotus/Language/SquadLink/TooManyBeacons") -- inferred equivalent call
			print("OpLink: Can't deploy because there are currently 4 beacons. Player: " .. __wf_atom_6be84646 .. " State: " .. __wf_atom_d163c8e5)
			return false
		end
	end
end

function RemoveAction(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd = gRegion:FindNearestTagged(Symbol("ScenarioBeacon"), object:GetPosition())
	end

	if not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(closingAnim) or __wf_atom_7e8ad928(closedAnim)) then
		__wf_atom_3d96ddcd:__wf_atom_921c1a5f(closingAnim, true, false)
		__wf_atom_3d96ddcd:__wf_atom_921c1a5f(closedAnim, false, true)
		__wf_atom_3d96ddcd:PlayTriggeredFade(true)
		local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(activeEffect)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end

	if gRegion:IsMaster() then
		gGameRules:__wf_atom_ec96fe12("OnUnregisterForBeacon")
	end
end

function OnRegisterForBeacon(_, _)
	if not __wf_atom_7e8ad928(notificationMovie) then
		local __wf_atom_5d67a2c5 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(notificationMovie)

		if not __wf_atom_7e8ad928(__wf_atom_5d67a2c5) then
			__wf_atom_5d67a2c5:__wf_atom_f62a8704("SetCustom", {
				"/Lotus/Language/Railjack/Beacon_RecieverPlacedTitle",
				"/Lotus/Language/Railjack/Beacon_RecieverPlaceSubtitle",
				3
			})
		end
	end
end

function OnUnregisterForBeacon(_, _)
	if not __wf_atom_7e8ad928(notificationMovie) then
		local __wf_atom_5d67a2c5 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(notificationMovie)

		if not __wf_atom_7e8ad928(__wf_atom_5d67a2c5) then
			__wf_atom_5d67a2c5:__wf_atom_f62a8704("SetCustom", {
				"/Lotus/Language/Railjack/Beacon_RecieverRemovedTitle",
				"",
				3
			})
		end
	end

	if _T.ScenarioEventHandlers then
		_T.ScenarioEventHandlers.ScenarioOffered = nil
	end

	_T.ScenarioBeacon = nil
end

function ManageUploadFx(object)
	local v6 = Symbol("CodesUploading")

	while not __wf_atom_7e8ad928(object) do
		if gGameRules:__wf_atom_d163c8e5(v6) == 1 then
			if not object:__wf_atom_a586ea4c(uploadEffect) then
				object:Attach(uploadEffect, EMPTY_SYMBOL)
			end
		else
			local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(uploadEffect)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end

		Sleep(0)
	end
end

function ActivateScenarioBeacon(instance)
	if __wf_atom_7e8ad928(instance) or not gRegion:IsMaster() then
		return
	end

	local isA = instance:IsA(__wf_atom_9e85eea2)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_e78ee67e = instance:__wf_atom_e78ee67e()

	while __wf_atom_7e8ad928(__wf_atom_e78ee67e) or __wf_atom_e78ee67e == "" do
		Sleep(0)
		__wf_atom_e78ee67e = instance:__wf_atom_e78ee67e()
	end

	local v6 = Symbol("OPLK_" .. __wf_atom_e78ee67e)
	local v7

	if gGameRules:__wf_atom_d163c8e5(v6) == v5.INACTIVE then
		instance:SetVisibility(false, true)
		local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(v4)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Disable()
		end

		local __wf_atom_f582136d = instance:__wf_atom_f582136d(__wf_atom_465d956f)

		for _, v8 in ipairs(__wf_atom_f582136d) do
			v8:Disable()
		end

		v7 = false
	else
		v7 = true
	end

	while not v7 do
		Sleep(0)
		v7 = instance:IsVisible()
	end

	if isA then
		gGameRules:SetNetPersistentVar(v6, v5.ACTIVE)
		instance:__wf_atom_921c1a5f(openingAnim, true, 2, 1, true, 2)
		instance:__wf_atom_921c1a5f(openAnim, false, 2, 2, false)
	else
		instance:__wf_atom_7b7015c9(nil)
		instance:__wf_atom_921c1a5f(openingAnim, true, false)
		instance:__wf_atom_7b7015c9(openAnim)
		isA = false
	end

	if __wf_atom_7e8ad928((instance:__wf_atom_bb3e7833(activeEffect))) then
		instance:Attach(activeEffect, EMPTY_SYMBOL)
	end

	if gGameRules:__wf_atom_0fa72b69() == 32 then
		instance:__wf_atom_8a035cd5(Symbol("ManageUploadFx"), false)
	end

	if _T.OpLinkGroundMission and __wf_atom_7e8ad928((instance:__wf_atom_bb3e7833(scanningEffect))) then
		instance:Attach(scanningEffect, EMPTY_SYMBOL, Vector(0, 1.2, 0), Rotation(0, -10, 0))
	end

	if __wf_atom_7e8ad928(_T.ScenarioBeacons) then
		_T.ScenarioBeacons = {}
	end

	local v8 = false

	for _, scenarioBeacon in ipairs(_T.ScenarioBeacons) do
		if scenarioBeacon == instance then
			v8 = true
		end
	end

	if not v8 then
		table.insert(_T.ScenarioBeacons, instance)
	end

	if not __wf_atom_7e8ad928(_T.ScenarioBeaconCreated) then
		_T.ScenarioBeaconCreated(instance)
	end

	if
		__wf_atom_7e8ad928((gRegion:__wf_atom_f738b4af(
			Symbol("FragmentCausticsEffectsDeco"),
			instance:GetPosition(),
			0,
			40
		)))
		and not _T.OpLinkGroundMission
	then
		instance:Attach(causticsEffect, EMPTY_SYMBOL)
	end

	local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(v4)

	while __wf_atom_7e8ad928(__wf_atom_bb3e7833) do
		Sleep(0)
		__wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(v4)
	end

	local v9

	if __wf_atom_bb3e7833:MarkerType() == 41 then
		v9 = "B"
	elseif __wf_atom_bb3e7833:MarkerType() == 42 then
		v9 = "C"
	elseif __wf_atom_bb3e7833:MarkerType() == 43 then
		v9 = "D"
	else
		v9 = "A"
	end

	local __wf_atom_c6f1f83d = instance:__wf_atom_c6f1f83d()
	local v10 = nil
	local v11 = 0
	local maxHealth = instance:GetMaxHealth()
	local v12 = fn3(nil, v9, __wf_atom_c6f1f83d, __wf_atom_e78ee67e)
	local __wf_atom_f582136d = instance:__wf_atom_f582136d(__wf_atom_465d956f)

	if gGameRules:__wf_atom_d163c8e5(v6) == v5.INACTIVE then
		instance:SetVisibility(false, true)
	end

	local culledDamageDelay2 = culledDamageDelay

	while not (__wf_atom_7e8ad928(instance) or instance:IsKilled()) do
		instance:IsVisible()

		if culledDamageDelay2 <= 0 then
			if
				not __wf_atom_7d789620:__wf_atom_53fb0512(__wf_atom_7d789620:__wf_atom_9e1cc923(instance))
				and gGameRules:__wf_atom_d163c8e5(v6) == v5.ACTIVE
			then
				local damageData = Engine.DamageData()
				damageData.baseAmount = 1
				damageData:__wf_atom_7498285f(17, 1)

				if isA then
					damageData.baseAmount = instance:GetMaxHealth(true) * __wf_atom_8d119bab(culledDamagePctMin, culledDamagePctMax)
				else
					damageData.baseAmount = instance:__wf_atom_95174740() * __wf_atom_8d119bab(culledDamagePctMin, culledDamagePctMax)
				end

				instance:__wf_atom_649bf33e(damageData)
			end

			culledDamageDelay2 = culledDamageDelay
		end

		if instance:IsVisible() then
			__wf_atom_c6f1f83d = instance:__wf_atom_c6f1f83d()

			if __wf_atom_7e8ad928(v12) or __wf_atom_c6f1f83d ~= v10 and __wf_atom_c6f1f83d < maxHealth then
				fn3(v12, v9, __wf_atom_c6f1f83d, __wf_atom_e78ee67e)
				v11 = 0
			else
				v11 = v11 >= 0.1 and 0 or v11 + __wf_atom_084b3e93()
			end

			v10 = __wf_atom_c6f1f83d
		end

		if (__wf_atom_7e8ad928(v12.Data.Visible) or v12.Data.Visible) and not instance:IsVisible() then
			gGameRules:SetNetPersistentVar(v6, v5.INACTIVE)

			for _, v13 in ipairs(__wf_atom_f582136d) do
				if not __wf_atom_7e8ad928(v13) then
					v13:Disable()
				end
			end

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Disable()
			end

			if not __wf_atom_7e8ad928(v12) then
				v12.SetVisible(false)
			end
		elseif not v12.Data.Visible and instance:IsVisible() then
			gGameRules:SetNetPersistentVar(v6, v5.ACTIVE)
			instance:__wf_atom_506144ee(20000)

			for _, v13 in ipairs(__wf_atom_f582136d) do
				if not __wf_atom_7e8ad928(v13) then
					v13:Enable()
				end
			end

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Enable()
			end

			if not __wf_atom_7e8ad928(v12) then
				v12.SetVisible(true)

				if __wf_atom_bb3e7833:MarkerType() == 41 then
					v9 = "B"
				elseif __wf_atom_bb3e7833:MarkerType() == 42 then
					v9 = "C"
				elseif __wf_atom_bb3e7833:MarkerType() == 43 then
					v9 = "D"
				else
					v9 = "A"
				end

				fn3(v12, v9, __wf_atom_c6f1f83d, __wf_atom_e78ee67e, true)
			end
		end

		Sleep(0)
		culledDamageDelay2 -= __wf_atom_084b3e93()
	end

	gGameRules:SetNetPersistentVar(v6, v5.DESTROYED)

	if not __wf_atom_7e8ad928(v12) then
		fn3(v12, v9, 0, __wf_atom_e78ee67e)
		v12.SetVisible(false)
	end

	if not __wf_atom_7e8ad928(__wf_atom_f582136d) and #__wf_atom_f582136d > 0 then
		for _, v13 in ipairs(__wf_atom_f582136d) do
			if not __wf_atom_7e8ad928(v13) then
				v13:Disable()
			end
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Disable()
	end

	if not __wf_atom_7e8ad928(instance) and instance:IsKilled() and module3.GetNumBeaconsInInventories() > 1 then
		module2.PlayGlobalTransmission(_T.SquadLinkTransmissionSet, Symbol("BeaconDestroyed"))

		if module3.GetNumActiveBeacons() == 0 then
			module2.PlayGlobalTransmission(_T.SquadLinkTransmissionSet, Symbol("NeedBeacon"))
		end
	end
end