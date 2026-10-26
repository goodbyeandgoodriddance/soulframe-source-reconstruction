local v = { "Objective", "Intermediate", "Connector", "Dead-End" }
local _ = {
	ANY = 0,
	OBJECTIVE = 1,
	INTERMEDIATE = 2,
	CONNECTOR = 3,
	DEADEND = 4
}
local module = require("SF.Scripts.Libs.CommonFunctionsLib")

local function fn(object, p, p2)
	object:SetVisibility(p)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_589cefdb)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		if p then
			if p2 then
				__wf_atom_bb3e7833:Enable()
			else
				__wf_atom_bb3e7833:Disable()
			end
		else
			__wf_atom_bb3e7833:Disable()
		end
	end
end

function SpawnMockeries(_)
	local v2 = {}
	local v3 = {}
	local layerIndexes = {}
	local v4 = {}

	for _, v5 in pairs(mockeryTypes) do
		local all = gRegion:FindAll(v5)
		v2 = module.MergeTables(v2, all, false)
	end

	if #v2 == 0 then
		return
	end

	for _, v5 in pairs(v2) do
		fn(v5, false, false)
	end

	for _, v5 in pairs(v2) do
		local layerIndex = module.GetLayerIndex(v5)

		if __wf_atom_7e8ad928(v3[layerIndex]) then
			v3[layerIndex] = {}
			table.insert(layerIndexes, layerIndex)
			table.insert(v4, (tostring(v5:__wf_atom_e800787c():__wf_atom_db682341())))
		end

		table.insert(v3[layerIndex], v5)
	end

	local v5 = math.min(maxSpawnPerProc, #v2)
	local count = 0

	while count < v5 do
		local v6 = __wf_atom_5784a397(1, #layerIndexes)
		local v7 = layerIndexes[v6]
		local v8 = v3[v7]

		if not __wf_atom_7e8ad928(v8) then
			local count2 = 0
			local maxSpawnPerTile = maxSpawnPerTile
			local minSpawnPerTile = minSpawnPerTile

			if not __wf_atom_7e8ad928(v4[v6]) then
				local v9 = v4[v6]
				local v10 = nil

				for k, v11 in pairs(v) do
					if v11 == v9 then
						v10 = k
					end
				end

				if not __wf_atom_7e8ad928(v10) then
					maxSpawnPerTile = maxSpawnsPerTile[v10]
					minSpawnPerTile = minSpawnsPerTile[v10]
				end
			end

			local v9 = math.min(__wf_atom_5784a397(minSpawnPerTile, maxSpawnPerTile), #v8)

			while count2 < v9 and #v3[v7] ~= 0 do
				local v10 = __wf_atom_5784a397(1, #v8)
				local v11 = v8[v10]

				if not __wf_atom_7e8ad928(v11) then
					if math.random() <= aliveMockeryRatio then
						fn(v11, true, true)
					else
						fn(v11, true, false)
					end

					table.remove(v3[v7], v10)
					count2 += 1
					count += 1
				end

				Sleep(0)
			end

			table.remove(v3, v7)
			table.remove(layerIndexes, v6)
			table.remove(v4, v6)
		end

		Sleep(0)
	end
end