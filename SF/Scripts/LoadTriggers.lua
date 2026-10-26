local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.StatsLib")
local module3 = require("SF.Scripts.Libs.EncounterLib")
local module4 = require("SF.Scripts.Libs.RespawnLib")
local module5 = require("SF.Scripts.Libs.DungeonLocationInfo")

local function fn()
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_2a96b3c6 = __wf_atom_7d789620:__wf_atom_2a96b3c6(4, 8)

	for i = 1, #__wf_atom_2a96b3c6 do
		if not __wf_atom_7e8ad928(__wf_atom_2a96b3c6[i]) then
			module3.RemoveAgents(__wf_atom_2a96b3c6[i])
		end
	end

	local __wf_atom_02f900f5 = __wf_atom_7d789620:__wf_atom_02f900f5()

	for i = 1, #__wf_atom_02f900f5 do
		if not __wf_atom_7e8ad928(__wf_atom_02f900f5[i]) then
			module3.RemoveAgents(__wf_atom_02f900f5[i])
		end
	end

	__wf_atom_7d789620:__wf_atom_f18f0120()
	__wf_atom_7d789620:Enable(false)
	__wf_atom_7d789620:__wf_atom_b792aec3(4)
	gRegion:__wf_atom_2202ffb6():SetEnabled(false)
	gRegion:__wf_atom_2202ffb6():__wf_atom_eb583f1a(true)
end

function StreamTriggerSetup(object)
	module4.DeactivateBlightZone(true)

	if gRegion:IsMaster() then
		fn()
		local v = WeakResource("/SF/Types/Gameplay/DungeonEntranceWaypoint")
		local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(v, object:GetPosition(), 50)
		local v2

		if not __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
			v2 = __wf_atom_e2db08ce:__wf_atom_db682341()
			print("StreamTrigger location is " .. tostring(v2))
			module5.SetCurrentLocation(v2)
			module5.SetCurrentDungeonLevel(module3.GetDungeonEnemyLevelFromSurface(__wf_atom_e2db08ce))
		end

		local v3, v4

		if object:__wf_atom_ecc2d6d5() then
			v3 = object:__wf_atom_d7947b11()
			v4 = object:__wf_atom_e7c969ef()
		else
			v3 = object:__wf_atom_e7c969ef()
			v4 = object:__wf_atom_d7947b11()
		end

		local __wf_atom_db682341 = object:__wf_atom_e800787c():__wf_atom_db682341()

		if __wf_atom_7e8ad928(v2) then
			v2 = __wf_atom_db682341
		end

		if not __wf_atom_7e8ad928(v4) then
			module2.TrackExitLevel(v3, v4, v2)
		end

		local v5 = Symbol("Exit")

		if not module.IsInOverworld() and __wf_atom_db682341 == v5 then
			local taggedInTileType = module.FindTaggedInTileType(Symbol("LootChest"), v5)

			for _, v6 in ipairs(taggedInTileType) do
				object:AddTeleportEntity(v6)
				print("Teleported exit loot chest back to Midrath")
			end
		end
	end
end

function ClearAiDir(_)
	if gRegion:IsMaster() then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		__wf_atom_7d789620:__wf_atom_4bacbe95()
		__wf_atom_7d789620:__wf_atom_7a81edd9()
		__wf_atom_7d789620:__wf_atom_c5f29b47()
	end
end

function ReturnFromCrypt(_)
	if gRegion:IsMaster() then
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

		for i = 1, #__wf_atom_3c8e1a7a do
			if __wf_atom_7e8ad928(__wf_atom_3c8e1a7a[i]) then
				continue
			end

			local playerAvatar = __wf_atom_3c8e1a7a[i]:GetPlayerAvatar(0)

			if __wf_atom_7e8ad928(playerAvatar) or not playerAvatar:IsKilled() then
				continue
			end

			gGameRules:__wf_atom_bca0553b(__wf_atom_3c8e1a7a[i])
		end
	end
end

function HubTriggerDestreamStarted(p)
	StreamTriggerSetup(p)
end

function ReturningFromHub(object)
	if object then
		object:__wf_atom_8a035cd5(Symbol("WaitForPlayersAndClearHub"), false)
	end
end

function EnteringHub(_)
	print("Lua: EnteringHub")

	while __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_e714d8ac) do
		Sleep(1)
	end

	print("Lua: EnteringHub: GameRules ready")
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v in ipairs(__wf_atom_ef7900cf) do
		v:__wf_atom_92aa9d91():__wf_atom_8595f516()
		v:__wf_atom_aeb02c14(hubInputFilter)
	end

	if not __wf_atom_7e8ad928(_G.StatsLoadingLevelName) then
		module2.TrackEnterLevel(_G.StatsLoadingLevelName, "hub")
	end
end

function WaitForPlayersAndClearHub()
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

	while #__wf_atom_ef7900cf < #__wf_atom_bb46d8b6 do
		Sleep(0.5)
		__wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		__wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()
	end

	for _, v in ipairs(__wf_atom_ef7900cf) do
		v:__wf_atom_cf966a74(hubInputFilter)
	end
end

function HubTriggerDestreamCompleted(p)
	ClearAiDir(p)
end