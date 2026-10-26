local v = WeakResource("/SF/Types/Quests/AncestorProgression/VerminiaProgression/AncestorVerminiaDiscoveryQuest")
local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Scripts.Libs.StatsLib")
local module5 = require("SF.Scripts.Libs.DungeonLocationInfo")
local v2 = Type("/SF/Types/Game/AiSpecs/OverworldAiSpec")
local v3 = nil

local function fn(p, object)
	local __wf_atom_0958db03 = object:__wf_atom_0958db03()
	local v4 = {}

	for i = 1, #__wf_atom_0958db03 do
		local v5 = __wf_atom_0958db03[i]
		local agentType = Type(v5.agent)

		if __wf_atom_7e8ad928(agentType) then
			continue
		end

		v3:__wf_atom_2b33739c(agentType, v5.probability, v5.maxSimultaneous, p, v5.mergeSymbol)
		table.insert(v4, {
			agentType = agentType,
			probability = v5.probability,
			maxSim = v5.maxSimultaneous,
			tier = p + v5.tier,
			mergeSymbol = v5.mergeSymbol
		})
	end
end

local function fn2()
	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	while module2.IsStreamingLevel() do
		Sleep(0)
	end
end

function ProcLevelSetup()
	if not gRegion:IsMaster() then
		return
	end

	gRegion:__wf_atom_22941262():__wf_atom_5b41f63b()
	print("Running ProcLevelSetup")
	local procLevelSetupDone = _T.ProcLevelSetupDone
	_T.ProcLevelSetupDone = nil
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

	while not __wf_atom_2202ffb6:__wf_atom_2e66d28e() do
		Sleep(0.1)
	end

	fn2()
	gRegion:__wf_atom_2202ffb6():SetEnabled(true)
	gRegion:__wf_atom_2202ffb6():__wf_atom_eb583f1a(false)
	v3 = __wf_atom_2202ffb6:__wf_atom_7d789620()
	local v4 = not (disableEncounterHints or module2.HasStreamedLevel("UnderCityObjTotem") or module2.HasStreamedLevel("GarrenRoodBossArena"))

	if procLevelSetupDone then
		v3:__wf_atom_7a81edd9()
		v3:__wf_atom_4bacbe95()
	end

	module3.SetupSparrowResources(sparrowAgentType)

	if not v4 then
		local v5 = WeakResource("/SF/Types/Game/Encounters/CombatEncounterHint")
		local all = gRegion:FindAll(v5)

		for _, v6 in ipairs(all) do
			v6:Disable()
		end
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("LevelEntranceWp"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("ERROR: Missing entrance waypoint required for Ai Director")
	else
		v3:__wf_atom_5e16fe4a(__wf_atom_0a6a5887)
	end

	v3:__wf_atom_7a81edd9()
	v3:__wf_atom_4bacbe95()
	v3:__wf_atom_215c9598(false)
	v3:__wf_atom_c332844c(Symbol("DoNotUse"))
	v3:Enable(true)

	if not __wf_atom_7e8ad928(enemyLevelCalculator) then
		v3:__wf_atom_82817d9d(enemyLevelCalculator)
	end

	module2.WaitForAiDir()
	local v5 = module5.GetOverrideDungeonKey() or missionKeyDefault
	local v6

	if not __wf_atom_7e8ad928(v5) then
		v6 = v5:__wf_atom_72fc675e()
	end

	local enemySpec

	if not __wf_atom_7e8ad928(v6) then
		enemySpec = v6.enemySpec
	end

	local currentDungeonLevel = module5.GetCurrentDungeonLevel()

	if __wf_atom_7e8ad928(currentDungeonLevel) then
		v3:__wf_atom_4ea40bfd(1, 2)
	else
		v3:__wf_atom_4ea40bfd(currentDungeonLevel.minValue, currentDungeonLevel.maxValue)
	end

	if not __wf_atom_7e8ad928(enemySpec) then
		local __wf_atom_0958db03 = enemySpec:__wf_atom_0958db03()
		local v7 = {}

		for i = 1, #__wf_atom_0958db03 do
			local agent = __wf_atom_0958db03[i].agent

			if not __wf_atom_7e8ad928(agent) then
				table.insert(v7, agent:__wf_atom_5b41f63b())
			end
		end

		local __wf_atom_d74a2fe7 = enemySpec:__wf_atom_d74a2fe7()

		for i = 1, #__wf_atom_d74a2fe7 do
			local v8 = __wf_atom_d74a2fe7[i]

			if not __wf_atom_7e8ad928(v8) then
				table.insert(v7, v8:__wf_atom_5b41f63b())
			end
		end

		local __wf_atom_c0dbe47c = UISys.__wf_atom_c0dbe47c(v7)

		while not __wf_atom_c0dbe47c:__wf_atom_86399a47() do
			Sleep(0)
		end

		for i = 1, #__wf_atom_0958db03 do
			local v8 = __wf_atom_0958db03[i]
			local v9 = Type(v8.agent)

			if not __wf_atom_7e8ad928(v9) then
				v3:__wf_atom_2b33739c(v9, v8.probability, v8.maxSimultaneous, v8.tier, v8.mergeSymbol)
			end
		end

		for i = 1, #__wf_atom_d74a2fe7 do
			v3:AddEncounter(Type(__wf_atom_d74a2fe7[i]))
		end
	end

	v3:__wf_atom_b792aec3(1)
	v3:__wf_atom_7c91fbf5(true)
	v3:__wf_atom_faad8978(10)
	v3:__wf_atom_7d5796e2(0.66667)
	v3:__wf_atom_dfd9b10a()
	v3:__wf_atom_562d45ad(true)
	v3:__wf_atom_15114160(false)
	v3:__wf_atom_7e752f37(-1)
	v3:__wf_atom_8b1721d6(true)
	v3:__wf_atom_a4edeea0(Symbol("FiringSpot"))
	_T.ProcLevelSetupDone = true

	if not __wf_atom_7e8ad928(_G.StatsLoadingLevelName) then
		local v7 = __wf_atom_7e8ad928(__wf_atom_0a6a5887) and "" or __wf_atom_0a6a5887:__wf_atom_db682341()
		module4.TrackEnterLevel(_G.StatsLoadingLevelName, v7)
	end
end

function DemoLevelSetup() end

local function fn3()
	return module.HasCompletedQuest(v) and not module.QuestIsActive(v)
end

function OverworldLevelSetup()
	if not (gRegion:IsMaster() and (__wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) or gMatchingService:__wf_atom_1b24a1bb())) then
		return
	end

	local procLevelSetupDone = _T.ProcLevelSetupDone
	_T.ProcLevelSetupDone = nil
	module5.ClearCurrentLocation()
	v3 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	if procLevelSetupDone then
		v3:__wf_atom_7a81edd9()
		v3:__wf_atom_4bacbe95()
	end

	fn(0, v2)

	for i, v4 in ipairs(regionEnemySpecs) do
		fn(i, v4)
	end

	local __wf_atom_d74a2fe7 = v2:__wf_atom_d74a2fe7()

	for i = 1, #__wf_atom_d74a2fe7 do
		v3:AddEncounter(Type(__wf_atom_d74a2fe7[i]))
	end

	v3:__wf_atom_215c9598(false)

	if not __wf_atom_7e8ad928(enemyLevelCalculator) then
		v3:__wf_atom_82817d9d(enemyLevelCalculator)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("EncounterSystemObjective"))
	v3:__wf_atom_5e16fe4a(__wf_atom_0a6a5887)
	fn2()
	module2.WaitForLoginSequence()
	module3.SetupSparrowResources(sparrowAgentType)
	v3:Enable(true)
	v3:__wf_atom_b792aec3(1)
	v3:__wf_atom_d735830b(gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume")))
	v3:__wf_atom_7c91fbf5(true)
	v3:__wf_atom_da116715(300, 0, false, false)
	v3:__wf_atom_faad8978(10)
	v3:__wf_atom_7d5796e2(0.66667)
	v3:__wf_atom_dfd9b10a()
	v3:__wf_atom_562d45ad(true)
	v3:__wf_atom_15114160(false)
	v3:__wf_atom_7e752f37(-1)
	v3:__wf_atom_8b1721d6(true)
	v3:__wf_atom_4ea40bfd(minMaxEnemyLevel.minValue, minMaxEnemyLevel.maxValue)
	v3:__wf_atom_a4edeea0(Symbol("FiringSpot"))
	local v4 = {
		{
			tag = Symbol("UndercityPortalNearTower"),
			procLevel = WeakResource("/SF/Levels/Procs/UnderCityCliffTown")
		},
		{
			tag = Symbol("UndercityPortalSproutCave"),
			procLevel = WeakResource("/SF/Levels/Procs/UnderCityCliffCave")
		},
		{
			tag = Symbol("UndercityPortalAvakotWell"),
			procLevel = WeakResource("/SF/Levels/Procs/UnderCityNeighbourhood")
		},
		{
			tag = Symbol("UndercityPortalMine"),
			procLevel = WeakResource("/SF/Levels/Procs/UnderCityMill")
		},
		{
			tag = Symbol("UndercityPortalHillside"),
			procLevel = WeakResource("/SF/Levels/Procs/UnderCityPortCity")
		},
		{
			tag = Symbol("UndercityPortalGauntlet"),
			procLevel = WeakResource("/SF/Levels/Procs/UnderCityGauntlet")
		},
		{
			tag = Symbol("GladesProcEntrance"),
			procLevel = WeakResource("/SF/Levels/Procs/GladesofAndurin/GladesProcLevel")
		},
		{
			tag = Symbol("GladesTreeEntrance"),
			procLevel = WeakResource("/SF/Levels/Procs/GladesofAndurin/GladesProcLevel"),
			predicate = fn3
		},
		{
			tag = Symbol("GladesReturnEntrance"),
			procLevel = WeakResource("/SF/Levels/Procs/GladesofAndurin/GladesProcLevel")
		}
	}

	for _, v5 in ipairs(v4) do
		if not v5.predicate or v5.predicate() then
			module2.SetProcLevelForStreamingTunnel(v5.tag, v5.procLevel, module2.LEVEL_PRIORITY.NONE)
		end
	end

	_T.ProcLevelSetupDone = true
	gRegion:__wf_atom_2202ffb6():SetEnabled(true)
	gRegion:__wf_atom_2202ffb6():__wf_atom_eb583f1a(false)

	if not __wf_atom_7e8ad928(_G.StatsLoadingLevelName) then
		module4.TrackEnterLevel(_G.StatsLoadingLevelName, "overworld")
	end
end

function LevelCombatTestTrigger(_) end

local function fn4()
	while __wf_atom_7e8ad928(gMatchingService:__wf_atom_9c7c90fb()) do
		Sleep(0)
	end

	while module2.IsStreamingLevel() do
		Sleep(0)
	end
end

function SetupHubLevel()
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

	while not __wf_atom_2202ffb6:__wf_atom_2e66d28e() do
		Sleep(0.1)
	end

	gRegion:__wf_atom_2202ffb6():SetEnabled(true)
	gRegion:__wf_atom_2202ffb6():__wf_atom_eb583f1a(false)
	fn4()
	gMatchingService:SetSquadHostHubLevelName(hubName)
end

function RunScriptTrigger(object)
	fn2()
	object:FirePort("Execute")
end