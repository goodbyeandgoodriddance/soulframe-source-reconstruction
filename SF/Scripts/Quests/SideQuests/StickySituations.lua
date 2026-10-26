local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module4 = require("SF.Scripts.Libs.SparrowLib")
local v = false
local v2 = false
local _ = nil
local v3 = false
local completetime = module3.COMPLETETIME
local v4 = Type("/SF/Types/Gameplay/TeleportPlayersHereInstantlyScriptTrigger")

local function fn(object)
	if object:__wf_atom_7be51ede():__wf_atom_4417a5d4() or allowMultiplayer then
		object:Disable()
		v = true
	end
end

local function fn2(sparrowBehaviour, object, p)
	if sparrowBehaviour == 0 then
		return
	end

	local v5 = Range(5, 3.4028234663852886e38)
	local v6

	if sparrowBehaviour == 2 then
		v5 = Range(15, 3.4028234663852886e38)
		v6 = 40
	else
		v6 = 20
	end

	module4.AddQuestDestination(object, mOwner, p, v5)
	return (module.CreateAreaMarkerAtPos(object:GetPosition(), v6, __wf_atom_28d5d4aa, mOwner, p))
end

local function fn3(object, p)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(p) or not (p and __wf_atom_c4f78a8f:__wf_atom_8a6b8fc3(object) <= 50) then
		object:Attach(v4, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

function GotoLocation(p)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	module2.WaitForAiDir()
	v2 = false

	if v2 and _G.EnableDevTeleportToActiveStep and module.IsQuestTracked(mOwner) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(__wf_atom_95e89f02)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			fn3(__wf_atom_0a6a5887, true)
		end
	end

	if mOwner ~= nil then
		_ = module.GetQuestReplicationMode(mOwner)

		if mOwner:__wf_atom_6d0c070b() then
			v3 = true
		end
	end

	if gRegion:IsMaster() or v3 then
		local levelArgs = Engine.OpenLevelArgs()
		levelArgs.taggedLevelTags = levelTagsToStream
		Engine.StreamRegion(levelArgs)

		if entityTagToCheckForLayerLoaded ~= EMPTY_SYMBOL then
			while __wf_atom_7e8ad928((gRegion:__wf_atom_0a6a5887(entityTagToCheckForLayerLoaded))) do
				Sleep(0)
			end
		end

		module3.UpdateOrAddHudTask(mOwner, p)
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(locationTriggerTag)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Enable()
			__wf_atom_55142dd4(__wf_atom_0a6a5887, "OnTouched", fn)
			local v5 = fn2(sparrowBehaviour, __wf_atom_0a6a5887, p)

			while not v do
				Sleep(0.5)
			end

			if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				return
			end

			if startObjective then
				module3.CompleteHudTask(mOwner, nil, p, completetime)
			end

			if sparrowBehaviour ~= 0 then
				if not __wf_atom_7e8ad928(v5) then
					module.DestroyAreaMarker(v5)
				end

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					module4.RemoveSparrowDestination(__wf_atom_0a6a5887, p)
				end
			end

			Sleep(completetime)
			module.CompleteTaskWithID(mOwner, p)
		end
	end
end