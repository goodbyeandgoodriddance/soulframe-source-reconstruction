local module = require("SF.Scripts.Libs.RaycastLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("Lotus.Scripts.Libs.AudioLib")
local module4 = require("SF.Scripts.NightFoldLib")
local v = Symbol("WarpPoint")
local v2 = nil
local v3 = nil
local v4 = nil
local position = nil
local v5 = false
local v6 = 0
local isSpawnWarpPoint2 = false
local module5 = require("SF.Scripts.Libs.SparrowLib")

local function fn(p)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local __wf_atom_89894bd1 = __wf_atom_8ad59546:__wf_atom_89894bd1()
	local total = 0

	while total < 1 do
		__wf_atom_8ad59546:__wf_atom_47f0b80b(__wf_atom_104bfe98(__wf_atom_89894bd1, p, total / 1))
		total += __wf_atom_03df4e1d()
		Sleep(0)
	end

	__wf_atom_8ad59546:__wf_atom_47f0b80b(p)
end

local function fn2(shrine)
	if __wf_atom_7e8ad928(_T.activeShrineIndex) then
		_T.activeShrineIndex = {}
	end

	local activeShrineIndex = _T.activeShrineIndex

	for i = #activeShrineIndex, 1, -1 do
		if __wf_atom_7e8ad928(activeShrineIndex[i].shrine) then
			table.remove(activeShrineIndex, i)
		end
	end

	for i = 1, #activeShrineIndex do
		local v7 = activeShrineIndex[i]

		if v7.active == true and v7.shrine == shrine then
			return
		end
	end

	for i, v7 in ipairs(activeShrineIndex) do
		if v7.active and v7.shrine ~= shrine then
			activeShrineIndex[i].active = false
			activeShrineIndex[i].lastActive = true
		elseif v7.lastActive and v7.shrine ~= shrine then
			activeShrineIndex[i].lastActive = false
		end

		if v7.spawnShrine then
			isSpawnWarpPoint2 = true
		end
	end

	local v7 = nil
	local flag = true
	local v8

	for k, v9 in pairs(activeShrineIndex) do
		if v9.shrine ~= shrine then
			continue
		end

		v8 = true
		v7 = k
		flag = false
		break
	end

	if flag then
		v8 = false
		v7 = 0
	end

	v5 = v8
	v6 = v7

	if v5 then
		activeShrineIndex[v6].active = true
		activeShrineIndex[v6].lastActive = false
	else
		table.insert(activeShrineIndex, {
			shrine = shrine,
			active = true,
			lastActive = false,
			spawnShrine = isSpawnWarpPoint
		})

		if isSpawnWarpPoint2 == false then
			isSpawnWarpPoint2 = isSpawnWarpPoint
		end
	end

	if isSpawnWarpPoint2 == false then
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ResShrine"))

		for _, shrine2 in ipairs(__wf_atom_2226b35c) do
			if not shrine2:IsA(WeakResource("/SF/Objects/SpiritCreatures/DungeonShrines/DungeonReviveEntranceSpawnShrine")) then
				continue
			end

			table.insert(activeShrineIndex, {
				shrine = shrine2,
				active = false,
				lastActive = false,
				spawnShrine = true
			})
			print("LOG: SpawnShrine Added late: " .. shrine2:GetName())
			break
		end
	end

	_T.activeShrineIndex = activeShrineIndex
end

function HandleWarp(object)
	if gRegion:IsMaster() then
		v2:Disable()
	end

	module4.RegisterPreventNighfoldUsage(true)

	if __wf_atom_7e8ad928(v3) then
		print("WARNING: No Destination Set")

		if gRegion:IsMaster() then
			v2:Enable()
		end
	else
		local v7 = object:__wf_atom_8efce136() and 1 or 3

		if not __wf_atom_7e8ad928(warpActivateSound) then
			v2:PlaySound(warpActivateSound, false, 0, false, nil, v7)
		end

		object:MotionControl():__wf_atom_3a1d0c16(__wf_atom_fa8d0177(object:GetPosition(), v2:GetPosition()))

		if useRelativeRot then
			local position2 = v2:__wf_atom_3d96ddcd():GetPosition()
			v4 = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), position2)

			if position then
				v4 = __wf_atom_fa8d0177(Vector(position.x, v3.y, position.z), v3)
			end
		end

		if not __wf_atom_7e8ad928(object:__wf_atom_a96eb2aa()) and position then
			local __wf_atom_6be84646 = object:__wf_atom_a96eb2aa():__wf_atom_6be84646()

			if not _T.ShrinePulses then
				_T.ShrinePulses = {}
			end

			_T.ShrinePulses[__wf_atom_6be84646] = position
		end

		object:__wf_atom_9b5dcd3b(activateAnim, false, 4)
		local __wf_atom_8efce136 = object:__wf_atom_8efce136()

		if __wf_atom_8efce136 then
			fn(-1)
		else
			object:__wf_atom_70c29967(1, 0, false)

			while object:__wf_atom_a5304c35(v3) > 1 do
				Sleep(0)
			end
		end

		for i = 1, math.min(#objectTags, #objectPorts) do
			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(objectTags[i])

			for j, v8 in ipairs(__wf_atom_2226b35c) do
				v8:FirePort(objectPorts[j])
			end
		end

		object:Teleport(v3, v4)

		if __wf_atom_8efce136 then
			object:__wf_atom_51075230(v4)
		end

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(v2) then
			v2:Enable()
		end

		object:__wf_atom_9b5dcd3b(nil, false)
		object:__wf_atom_9b5dcd3b(deactivateAnim, false, 3)

		if __wf_atom_8efce136 then
			fn(0)
		else
			object:__wf_atom_c879fed7(true)
			object:__wf_atom_70c29967(1, 0, true)
		end

		module4.RegisterPreventNighfoldUsage(false)
	end
end

function OnActivated(object)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if not (__wf_atom_7e8ad928(__wf_atom_7be51ede) or __wf_atom_7be51ede:IsKilled()) then
		__wf_atom_7be51ede:__wf_atom_8a035cd5(Symbol("HandleWarp"), false)

		if useShrinesAsWarpPoints then
			return
		end

		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:__wf_atom_db682341() ~= v then
			return
		end

		if not __wf_atom_7e8ad928(v3) then
			local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v, v3, 0, 5)

			if #__wf_atom_439c0d29 > 0 then
				__wf_atom_439c0d29[1]:Enable()
				local entranceWaypoint = module2.GetEntranceWaypoint()
				module5.AddSparrowDestination(entranceWaypoint, nil, nil, module5.PRIORITY.EXIT, Range(0, 100))
			end
		end
	end
end

local function fn3(list, tag) -- 4 equivalent calls inferred from this helper
	for _, v7 in ipairs(list) do
		if v7:HasTag(tag) then
			return v7
		end
	end
end

function OnEnabled(object)
	if gRegion:IsMaster() then
		if __wf_atom_7e8ad928(v2) then
			v2 = fn3(object:__wf_atom_be0bea4a(), Symbol("WarpAction")) -- inferred equivalent call
		end

		v2:Enable()
	end

	if not useShrinesAsWarpPoints then
		object:SetVisibility(true, true)
	end

	module3.EnableTaggedSequencers(Symbol("SFXWarpLoop"), true)

	if __wf_atom_7e8ad928((object:__wf_atom_bb3e7833(activatedFxTriggerType))) then
		object:Attach(activatedFxTriggerType, EMPTY_SYMBOL, Vector(0, 0, 3), __wf_atom_80368bb1)
	end
end

function OnDisabled(object)
	if gRegion:IsMaster() then
		if __wf_atom_7e8ad928(v2) then
			v2 = fn3(object:__wf_atom_be0bea4a(), Symbol("WarpAction")) -- inferred equivalent call
		end

		v2:Disable()
	end

	object:SetVisibility(false, true)
	module3.EnableTaggedSequencers(Symbol("SFXWarpLoop"), false)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(activatedFxTriggerType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end
end

function WarpPoint(object)
	module2.WaitForLevel()
	gRegion:IsMaster()

	if useShrinesAsWarpPoints then
		while __wf_atom_7e8ad928(object:__wf_atom_3d96ddcd()) do
			Sleep(0)
		end

		object = object:__wf_atom_3d96ddcd()
	end

	if useShrinesAsWarpPoints or canWarpPointToShrine then
		fn2(object)
	end

	while __wf_atom_7e8ad928(v2) do
		v2 = fn3(object:__wf_atom_be0bea4a(), Symbol("WarpAction")) -- inferred equivalent call
		Sleep(0)
	end

	if gRegion:IsMaster() then
		if useShrinesAsWarpPoints then
			v2:Enable()
		elseif object:IsEnabled() then
			v2:Enable()

			if isSpawnWarpPoint then
				v2:ToggleText()
			end
		end
	end

	__wf_atom_55142dd4(v2, "OnActivated")
	__wf_atom_55142dd4(object, "OnEnabled")
	__wf_atom_55142dd4(object, "OnDisabled")

	if useShrinesAsWarpPoints then
		if isSpawnWarpPoint then
			if __wf_atom_7e8ad928(_T.activeShrineIndex) then
				fn2(object)
			end

			local activeShrineIndex = _T.activeShrineIndex

			for _, v7 in ipairs(activeShrineIndex) do
				if not (v7.lastActive and v7.shrine ~= object) then
					continue
				end

				local v8

				if not __wf_atom_7e8ad928(v7.shrine) then
					v8 = fn3(v7.shrine:__wf_atom_be0bea4a(), Symbol("TeleportPoint")) or v7.shrine -- inferred equivalent call
				end

				if __wf_atom_7e8ad928(v8) then
					print("Spawnpoint cannot be found. Entered shrine: " .. object:__wf_atom_5b41f63b())
					return
				end

				local position2 = v8:GetPosition()
				local groundPos = module.GetGroundPos(position2, Vector(0, 1, 1))
				v3 = Vector(position2.x, groundPos.y, groundPos.z)
				position = v7.shrine:GetPosition()
				print("LOG: Warp Dest set: " .. tostring(v3) .. " Shrine: " .. v7.shrine:GetName())
			end

			if __wf_atom_7e8ad928(v3) and gRegion:IsMaster() then
				v2:Disable()
			end
		else
			if __wf_atom_7e8ad928(_T.activeShrineIndex) then
				fn2(object)
			end

			local activeShrineIndex = _T.activeShrineIndex

			for _, v7 in ipairs(activeShrineIndex) do
				if not (v7.shrine ~= object and v7.spawnShrine) then
					continue
				end

				local v8

				if not __wf_atom_7e8ad928(v7.shrine) then
					local __wf_atom_be0bea4a = v7.shrine:__wf_atom_be0bea4a()
					local v9 = Symbol("TeleportPoint")

					for _, v10 in ipairs(__wf_atom_be0bea4a) do
						if not v10:HasTag(v9) then
							continue
						end

						v8 = v10
						break
					end
				end

				if __wf_atom_7e8ad928(v8) then
					print("Spawnpoint cannot be found. Entered shrine: " .. object:__wf_atom_5b41f63b())
					return
				end

				local position2 = v8:GetPosition()
				local groundPos = module.GetGroundPos(position2, Vector(0, 1, 1))
				v3 = Vector(position2.x, groundPos.y, groundPos.z)
				position = v7.shrine:GetPosition()
				print("LOG: Warp Dest set: " .. tostring(v3) .. " Shrine: " .. v7.shrine:GetName())
			end

			if __wf_atom_7e8ad928(v3) and gRegion:IsMaster() then
				v2:Disable()
			end
		end

		local activeShrineIndex = _T.activeShrineIndex

		if #activeShrineIndex >= 2 then
			for _, v7 in ipairs(activeShrineIndex) do
				if not v7.active or __wf_atom_7e8ad928(v7.shrine) then
					continue
				end

				if __wf_atom_7e8ad928((v7.shrine:__wf_atom_bb3e7833(shrineActiveFxType))) then
					v7.shrine:Attach(shrineActiveFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, Rotation(90, 0, 0))
				end

				v7.shrine:Attach(shrinePortalFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, Rotation(90, 0, 0))
				local __wf_atom_f582136d = v7.shrine:__wf_atom_f582136d(vineDecoType)

				for i = 1, #__wf_atom_f582136d do
					if not __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
						__wf_atom_f582136d[i]:PlayTriggeredFade()
					end
				end
			end
		end

		while not __wf_atom_7e8ad928(object) do
			Sleep(0)
		end

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(v2) then
			v2:Disable()
		end
	elseif warpToShrine then
		local activeShrineIndex = _T.activeShrineIndex

		for _, v7 in ipairs(activeShrineIndex) do
			if not (v7.shrine ~= object and v7.spawnShrine) then
				continue
			end

			local v8

			if not __wf_atom_7e8ad928(v7.shrine) then
				local __wf_atom_be0bea4a = v7.shrine:__wf_atom_be0bea4a()
				local v9 = Symbol("TeleportPoint")

				for _, v10 in ipairs(__wf_atom_be0bea4a) do
					if not v10:HasTag(v9) then
						continue
					end

					v8 = v10
					break
				end
			end

			if __wf_atom_7e8ad928(v8) then
				print("Spawnpoint cannot be found")
				return
			end

			local position2 = v8:GetPosition()
			local groundPos = module.GetGroundPos(position2, Vector(0, 1, 1))
			v3 = Vector(position2.x, groundPos.y, groundPos.z)
			position = v7.shrine:GetPosition()
			print("LOG: Warp Dest set: " .. tostring(v3) .. " Shrine: " .. v7.shrine:GetName())
		end

		while not __wf_atom_7e8ad928(object) do
			Sleep(0)
		end

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(v2) then
			v2:Disable()
		end
	else
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(destinationTag)

		for _, v7 in ipairs(__wf_atom_2226b35c) do
			local __wf_atom_e800787c = v7:__wf_atom_e800787c()

			if __wf_atom_7e8ad928(__wf_atom_e800787c) then
				continue
			end

			local __wf_atom_db682341 = __wf_atom_e800787c:__wf_atom_db682341()

			if not (not zoneTag:__wf_atom_8598f3a9() or not __wf_atom_7e8ad928(__wf_atom_e800787c) and __wf_atom_db682341 == zoneTag) then
				continue
			end

			v4 = v7:__wf_atom_dc309f8a()
			local v8 = {
				__wf_atom_4ebf67cb,
				__wf_atom_3feeb44a,
				__wf_atom_43e0c427,
				__wf_atom_7b01f9ce
			}
			local v9 = Vector()
			gRegion:__wf_atom_c20d246a(
				v7:GetPosition() + Vector(0, 1, 1),
				v7:GetPosition() - Vector(0, 5, 0),
				v8,
				nil,
				v9
			)
			v3 = v9
			break
		end

		while not __wf_atom_7e8ad928(object) do
			Sleep(0)
		end

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(v2) then
			v2:Disable()
		end
	end
end

function ResetShrine(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(shrinePortalFxType)

	for i = 1, #__wf_atom_f582136d do
		if __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
			continue
		end

		__wf_atom_f582136d[i]:Destroy()

		if not __wf_atom_7e8ad928(shrineDeactivateSound) then
			__wf_atom_3d96ddcd:PlaySound(shrineDeactivateSound, false)
		end
	end

	__wf_atom_3d96ddcd:Attach(vineDecoType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, Rotation(90, 0, 0))
end

function ClearActiveShrineData()
	_T.activeShrineIndex = nil
	_T.ShrinePulses = nil
end

function ActivateWarpPointFx(object)
	if __wf_atom_7e8ad928((object:__wf_atom_bb3e7833(warpActivateFxType))) then
		object:Attach(warpActivateFxType, EMPTY_SYMBOL, Vector(0, 0, -3), __wf_atom_80368bb1)
	end
end

function DeactivateWarpPointFx(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(warpActivateFxType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end
end