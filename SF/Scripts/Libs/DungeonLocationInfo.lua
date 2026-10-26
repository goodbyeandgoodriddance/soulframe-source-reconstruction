local function fn()
	if __wf_atom_7e8ad928(_G.LocationInfo) then
		_G.LocationInfo = {}
	end

	if __wf_atom_7e8ad928(_G.LocationInfo.entrances) then
		_G.LocationInfo.entrances = {}
	end
end

function OverrideDungeonKey(p, object)
	if __wf_atom_7e8ad928(p) or p == EMPTY_SYMBOL or __wf_atom_7e8ad928(object) then
		return
	end

	local v = "OverrideDungeonKey: " .. tostring(p) .. " : " .. object:__wf_atom_5b41f63b()
	print(v)
	fn()
	_G.LocationInfo.entrances[tostring(p)] = object
end

function GetOverrideDungeonKey()
	if
		__wf_atom_7e8ad928(_G.LocationInfo)
		or __wf_atom_7e8ad928(_G.LocationInfo.currentLocation)
		or __wf_atom_7e8ad928(_G.LocationInfo.entrances)
	then
		return
	else
		return _G.LocationInfo.entrances[_G.LocationInfo.currentLocation]
	end
end

function SetCurrentLocation(p)
	fn()
	local v = "SetCurrentLocation: " .. tostring(p)
	print(v)
	_G.LocationInfo.currentLocation = tostring(p)
end

function GetCurrentLocation()
	if __wf_atom_7e8ad928(_G.LocationInfo) then
		return
	else
		return _G.LocationInfo.currentLocation
	end
end

function ClearCurrentLocation()
	if not __wf_atom_7e8ad928(_G.LocationInfo) then
		print("ClearCurrentLocation")

		if not (__wf_atom_7e8ad928(_G.LocationInfo.entrances) or __wf_atom_7e8ad928(_G.LocationInfo.currentLocation)) then
			_G.LocationInfo.entrances[_G.LocationInfo.currentLocation] = nil
		end

		_G.LocationInfo.currentLocQuest = nil
		_G.LocationInfo.currentLocTask = nil
		_G.LocationInfo.currentLocation = nil
	end
end

function GetCurrentLocationQuest()
	if __wf_atom_7e8ad928(_G.LocationInfo) then
		return
	else
		return _G.LocationInfo.currentLocQuest, _G.LocationInfo.currentLocTask
	end
end

function SetCurrentLocationQuest(currentLocQuest, currentLocTask)
	fn()
	local v = "SetCurrentLocationQuest: " .. currentLocQuest:__wf_atom_5b41f63b() .. ": " .. tostring(currentLocTask)
	print(v)
	_G.LocationInfo.currentLocQuest = currentLocQuest
	_G.LocationInfo.currentLocTask = currentLocTask
end

function SetCurrentDungeonLevel(currentDungeonLevel)
	fn()
	local v = "SetCurrentDungeonLevel: " .. tostring(currentDungeonLevel.minValue) .. "-" .. tostring(currentDungeonLevel.maxValue)
	print(v)
	_G.LocationInfo.currentDungeonLevel = currentDungeonLevel
end

function GetCurrentDungeonLevel()
	if __wf_atom_7e8ad928(_G.LocationInfo) then
		return
	else
		return _G.LocationInfo.currentDungeonLevel
	end
end

function GetDungeonEntranceWaypointNearPos(p)
	local v = WeakResource("/SF/Types/Gameplay/DungeonEntranceWaypoint")
	local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(v, p, 80)

	if not __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
		return __wf_atom_e2db08ce
	end

	print("Can't find dungeon entrance waypoint!")
end

function GetActiveDungeonTaleInfo()
	if _G.LocationInfo == nil or _G.LocationInfo.currentLocation == nil then
		return
	end

	local currentLocation = _G.LocationInfo.currentLocation
	_G.DungeonEntranceInfo = _G.DungeonEntranceInfo or {}
	_G.DungeonEntranceInfo[currentLocation] = _G.DungeonEntranceInfo[currentLocation] or {}
	local _ = _G.DungeonEntranceInfo[currentLocation]
	return
		_G.DungeonEntranceInfo[currentLocation].activeMissionLocation,
		_G.DungeonEntranceInfo[currentLocation].activeMissionLevel,
		_G.DungeonEntranceInfo[currentLocation].activeMissionTag
end

function SetActiveDungeonTaleInfo(activeMissionLocation, activeMissionLevel, activeMissionTag)
	_G.DungeonEntranceInfo = _G.DungeonEntranceInfo or {}
	_G.DungeonEntranceInfo[activeMissionLocation] = _G.DungeonEntranceInfo[activeMissionLocation] or {}
	_G.DungeonEntranceInfo[activeMissionLocation].activeMissionLocation = activeMissionLocation
	_G.DungeonEntranceInfo[activeMissionLocation].activeMissionLevel = activeMissionLevel
	_G.DungeonEntranceInfo[activeMissionLocation].activeMissionTag = activeMissionTag
end

function SetDungeonEntranceSubboss(p, subbossAgent, subbossName)
	_G.DungeonEntranceInfo = _G.DungeonEntranceInfo or {}
	_G.DungeonEntranceInfo[p] = _G.DungeonEntranceInfo[p] or {}
	_G.DungeonEntranceInfo[p].subbossAgent = subbossAgent
	_G.DungeonEntranceInfo[p].subbossName = subbossName
end

function ClearDungeonTaleInfo(p)
	local v = p or GetCurrentLocation()
	_G.DungeonEntranceInfo = _G.DungeonEntranceInfo or {}
	_G.DungeonEntranceInfo[v] = _G.DungeonEntranceInfo[v] or {}
	_G.DungeonEntranceInfo[v].activeMissionLocation = nil
	_G.DungeonEntranceInfo[v].activeMissionLevel = nil
	_G.DungeonEntranceInfo[v].activeMissionTag = nil
end

function GetThisDungeonSubBoss()
	if __wf_atom_7e8ad928(_G.LocationInfo) then
		return
	end

	local currentLocation = _G.LocationInfo.currentLocation

	if not __wf_atom_7e8ad928(currentLocation) then
		local v = tostring(currentLocation)

		if not (__wf_atom_7e8ad928(_G.DungeonEntranceInfo) or __wf_atom_7e8ad928(_G.DungeonEntranceInfo[v])) then
			return
				_G.DungeonEntranceInfo[v].subbossAgent,
				_G.DungeonEntranceInfo[v].subbossName,
				_G.DungeonEntranceInfo[v].subbossTitle
		end
	end
end