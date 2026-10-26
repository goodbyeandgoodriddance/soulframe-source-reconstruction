local v = nil
local v2 = Symbol("NextLevelCreated")
local v3 = Symbol("ArenaStream")

function StreamingCallback(object, p)
	if __wf_atom_7e8ad928(object) then
		print("ARENASTREAMING: Failed to stream level on layer " .. p)
		v = false
	else
		print("ARENASTREAMING: Streaming " .. object:__wf_atom_5b41f63b() .. " done, layer=" .. tostring(p))
		v = true
	end
end

function LevelDestroyed(p, p2)
	if __wf_atom_7e8ad928(p) then
		print("ARENASTREAMING: Failed to destroy level on layer " .. p2)
		v = false
	else
		print("ARENASTREAMING: Level on layer " .. p2 .. " fully destroyed")
		v = true
	end
end

local function fn(streamingLayer)
	v = nil
	local levelArgs = Engine.OpenLevelArgs()
	levelArgs.streamingLayer = streamingLayer
	levelArgs:__wf_atom_c4be912d("LevelDestroyed")
	Engine.__wf_atom_94cafc05(levelArgs)

	while v == nil do
		Sleep(0)
	end

	return v
end

local function fn2(arenaLevel, streamingLayer, position)
	if __wf_atom_7e8ad928(arenaLevel) then
		print("ARENASTREAMING: No level")
		return
	end

	if gGameRules:IsMaster() then
		gGameRules:HideGameSession(true)
	end

	if gRegion:IsMaster() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SafeSpot"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			gGameRules:__wf_atom_2286b86d(__wf_atom_0a6a5887:GetPosition())
		end
	end

	_T.isStreamingLevel = true

	if gRegion:IsMaster() then
		local __wf_atom_ade7f08f = gRegion:__wf_atom_ade7f08f()
		__wf_atom_ade7f08f.level = arenaLevel
		__wf_atom_ade7f08f.streamingLayer = streamingLayer
		__wf_atom_ade7f08f.streamingMode = 1
		__wf_atom_ade7f08f:__wf_atom_60471db9(position, Rotation())
		__wf_atom_ade7f08f:__wf_atom_c4be912d("StreamingCallback")
		__wf_atom_ade7f08f.isAutonomous = false

		if streamLowPriority then
			__wf_atom_ade7f08f.streamingPriority = 2
		else
			__wf_atom_ade7f08f.streamingPriority = 1
		end

		Engine.StreamRegion(__wf_atom_ade7f08f)
		v = nil

		while v == nil do
			Sleep(0)
		end
	else
		while not gClient:IsStreamingLevel() do
			Sleep(0)
		end

		while gClient:IsStreamingLevel() do
			Sleep(0.1)
		end
	end

	gGameRules:SignalMultiplayerFence(v2, v3)

	if gRegion:IsMaster() then
		gGameRules:__wf_atom_c1fe2f72(v2)
	end

	if destroyLevelInfo then
		local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
		gRegion:__wf_atom_dd1e4d10(__wf_atom_8ad59546)
	end

	_T.isStreamingLevel = nil
	gGameRules:__wf_atom_40af8feb(v3)
	print("ARENASTREAM: Streaming done")
end

function StreamArena()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ArenaOrigin"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("ARENASTREAM: Unable to find waypoint for arena spawn position")
		return
	end

	local position = __wf_atom_0a6a5887:GetPosition()
	fn2(_T.ArenaLevel, streamingLayerIndex, position)
	_T.ArenaDestroyLevel = false

	while not _T.ArenaDestroyLevel do
		Sleep(0)
	end

	_T.ArenaDestroyLevel = false
	fn(streamingLayerIndex)
end

function StreamAlternatingArenas()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ArenaOrigin"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("ARENASTREAM: Unable to find waypoint one for alternating stream")
		return
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("ArenaAlternateOrigin"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		print("ARENASTREAM: Unable to find waypoint two for alternating stream")
		return
	end

	_T.ArenaNextLevel = false
	_T.ArenaDestroyLevel = false
	local arenaStreamingLayerIndex = 255
	_T.ArenaStreamingLayerIndex = arenaStreamingLayerIndex
	fn2(_T.ArenaLevel, arenaStreamingLayerIndex, __wf_atom_0a6a5887:GetPosition())
	print("ARENASTREAM: streaming initial alternating layer " .. arenaStreamingLayerIndex)
	local arenaStreamingLayerIndex2 = 256

	while true do
		if _T.ArenaNextLevel then
			_T.ArenaNextLevel = false
			print("ARENASTREAM: streaming next alternating layer " .. arenaStreamingLayerIndex2)
			_T.ArenaStreamingLayerIndex = arenaStreamingLayerIndex2
			fn2(_T.ArenaLevel, arenaStreamingLayerIndex2, __wf_atom_0a6a5887_2:GetPosition())
			local v4 = __wf_atom_0a6a5887
			__wf_atom_0a6a5887 = __wf_atom_0a6a5887_2
			__wf_atom_0a6a5887_2 = v4
			v4 = arenaStreamingLayerIndex
			arenaStreamingLayerIndex = arenaStreamingLayerIndex2
			arenaStreamingLayerIndex2 = v4

			while not _T.ArenaDestroyLevel do
				Sleep(0)
			end

			_T.ArenaDestroyLevel = false

			if gRegion:IsMaster() then
				print("ARENASTREAM: destroying alternating layer " .. arenaStreamingLayerIndex2)
				fn(arenaStreamingLayerIndex2)
			end
		else
			Sleep(0)
		end
	end
end