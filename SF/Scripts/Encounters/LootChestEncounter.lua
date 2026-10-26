local v = WeakResource("/SF/Types/PickUps/LootContainers/Actions/LootChestBaseAction")
local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local v2 = nil
local v3 = nil
local lootContainers = {}
local v4 = {}
local v5 = nil
local position = nil
local v6 = nil
local v7 = nil

local function fn()
	for i = #lootContainers, 1, -1 do
		if __wf_atom_7e8ad928(lootContainers[i]) then
			table.remove(lootContainers, i)
		else
			local __wf_atom_bb3e7833 = lootContainers[i]:__wf_atom_bb3e7833(v)

			if __wf_atom_7e8ad928(__wf_atom_bb3e7833) or __wf_atom_bb3e7833:__wf_atom_272baebc() then
				table.insert(v4, lootContainers[i])
				table.remove(lootContainers, i)
			end
		end
	end
end

local function fn2(chestTypeCommon)
	if not __wf_atom_7e8ad928(chestTypeCommon) then
		local pos = nil
		local rot = nil

		while __wf_atom_7e8ad928(pos) and #v7 > 0 do
			local v8 = __wf_atom_5784a397(1, #v7)

			if __wf_atom_7e8ad928(v7[v8].spawnPt) then
				pos, rot = module3.GetGroundAlignedSpawnPosRot(chestTypeCommon, v7[v8].pos, v7[v8].rot, false, 30)
			else
				pos = v7[v8].pos
				rot = v7[v8].rot
			end

			table.remove(v7, v8)
		end

		if not __wf_atom_7e8ad928(pos) then
			local lootContainer = module.SpawnLootContainer(chestTypeCommon, pos, rot, true, v3)
			table.insert(lootContainers, lootContainer)
			v3:__wf_atom_d494454b(lootContainer)

			if debugDraw then
				local v8 = Color(0, 255, 255)
				local v9

				if isDynamicEncounter then
					v8 = Color(255, 0, 255)
					v9 = "Dynamic Chest"
				else
					v9 = "Chest"
				end

				gRegion:__wf_atom_628723a6(position + Vector(0, 20, 0), position, v8, 20)
				gRegion:__wf_atom_5b35a0c8(pos, v8, v9, 1, 20)
				gRegion:__wf_atom_628723a6(pos + Vector(0, 2, 0), v3:GetPosition() + Vector(0, 20, 0), v8, 20)
			end
		end
	end
end

local function fn3()
	lootContainers = v3:__wf_atom_fe00d825() or {}
	fn()

	if not __wf_atom_7e8ad928(lootContainers) and #lootContainers > 0 then
		return
	end

	local v8 = Range(0, v6)
	local v9 = isDynamicEncounter and 2 or 0
	v7 = module.GetEncounterLootSpawns(
		position,
		v8,
		numChestsToSpawn + v9,
		spawnAtPlacedPoints,
		spawnAtRadialPoints,
		spawnAtRandomNavPoints,
		dynamicAvoidRoadDistance
	)
	math.min(numChestsToSpawn, #v7)
	local v10 = math.max(numChestsToSpawn - v5, 0)

	if v10 <= 0 then
		return
	end

	for _ = 1, v10 do
		fn2(chestTypeCommon)
	end
end

local function fn4()
	lootContainers = v3:__wf_atom_fe00d825() or {}
	fn()

	if not __wf_atom_7e8ad928(lootContainers) and #lootContainers > 0 then
		return
	end

	local v8 = Range(0, v6)
	local v9 = isDynamicEncounter and 2 or 0
	local count = 0

	for i = 1, #spawnCountChances do
		if math.random() <= spawnCountChances[i] then
			count += 1
		end
	end

	v7 = module.GetEncounterLootSpawns(
		position,
		v8,
		count + v9,
		spawnAtPlacedPoints,
		spawnAtRadialPoints,
		spawnAtRandomNavPoints,
		dynamicAvoidRoadDistance
	)
	local v10 = math.max(math.min(count, #v7) - v5, 0)

	if v10 <= 0 then
		return
	end

	local count2 = 0

	for _ = 1, v10 do
		local v11 = math.random()
		local chestTypeCommon2

		if __wf_atom_7e8ad928(chestTypeRare) or not (v11 <= spawnChanceRare and (rareCap <= 0 or count2 < rareCap)) then
			chestTypeCommon2 = chestTypeCommon
		else
			chestTypeCommon2 = chestTypeRare
			count2 += 1
		end

		fn2(chestTypeCommon2)
	end
end

local function fn5(p)
	v2 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(p) then
		print("Shutdown due to level streaming")
		return
	end

	v3 = p
	v5 = v3:__wf_atom_2b1fe281()
	position = v3:GetPosition()
	v6 = v3:__wf_atom_103377cc()

	if isDynamicEncounter then
		v6 = 40
	end

	v3:__wf_atom_8e6fec76(1)
end

local function fn6()
	v3:__wf_atom_8e6fec76(2)
	local total = 0

	while not __wf_atom_7e8ad928(v3) and not v3:ShouldShutDown() and #lootContainers > 0 do
		fn()
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v3) then
		print("Shutdown due to level streaming")
		return
	end

	if v3:ShouldShutDown() and #lootContainers > 0 then
		v3:__wf_atom_8776856a(#v4)
		v3:__wf_atom_8e6fec76(6)
	else
		v3:__wf_atom_050639fe()
		v3:__wf_atom_8776856a(0)
		v3:__wf_atom_8e6fec76(4)
	end

	while not __wf_atom_7e8ad928(v3) and v3:__wf_atom_e464a32f() > 0 and v2:__wf_atom_c6f505f2(v3) > 0 do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v3) then
		print("Shutdown due to level streaming")
		return
	end

	module.RemoveObjects(v3)
	Sleep(0)
end

function StartRandomChestEnconter(p)
	fn5(p)
	fn4()
	module2.StartPluginScripts(pluginScripts, p)
	fn6()
end

function StartFixedChestEnconter(p)
	fn5(p)
	fn3()
	module2.StartPluginScripts(pluginScripts, p)
	fn6()
end