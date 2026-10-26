local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local v = nil
local position = nil
local v2 = nil
local module4 = require("Lotus.Scripts.Libs.Query")

local function fn()
	if v2:__wf_atom_3634e6d2() > 0 then
		return
	end

	local __wf_atom_402b3832 = gRegion:__wf_atom_2202ffb6():__wf_atom_402b3832(
		squidPlantParent,
		module3.GetGroundPos(position),
		Rotation(__wf_atom_5784a397(0, 360), 0, 0),
		Symbol("RandomTeam"),
		1
	)
	v2:__wf_atom_97f955c1(__wf_atom_402b3832)

	if debugDraw then
		gRegion:__wf_atom_8d991675(position, 1, Color(0, 255, 0, 125), 15)
	end

	local groundPos = {}
	local __wf_atom_28ce676a = v:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, spawnRadius, 1)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(1, 1, -1)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(30)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(1.5, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_09d2b44e(false)
	__wf_atom_28ce676a:__wf_atom_28a1a374(Vector(0, -1, 0), { 4, 27, 24 })

	if #groundPos == 0 then
		__wf_atom_28ce676a:__wf_atom_bacad54b()
	else
		for i = 1, #groundPos do
			__wf_atom_28ce676a:__wf_atom_37c09cee(groundPos[i], spawnRadiusBetweenChildren)
		end
	end

	local positions = module4.GetPositions(childSpawnCount, __wf_atom_28ce676a)

	if __wf_atom_7e8ad928(positions) or #positions == 0 then
		return
	end

	for _ = 1, childSpawnCount do
		if __wf_atom_7e8ad928(positions[1]) then
			break
		end

		local __wf_atom_0e0a6fee = v:__wf_atom_0e0a6fee(positions[1], 1, 0.5)
		local groundPos2 = module3.GetGroundPos(__wf_atom_0e0a6fee)
		local v3 = __wf_atom_fa8d0177(groundPos2, position)
		local v4 = Rotation(v3.heading, 0, 0)
		local squidPlantBaby = squidPlantBabies[__wf_atom_5784a397(1, #squidPlantBabies)]
		table.insert(groundPos, groundPos2)
		local __wf_atom_402b3832_2 = gRegion:__wf_atom_2202ffb6():__wf_atom_402b3832(
			squidPlantBaby,
			groundPos2,
			v4,
			Symbol("RandomTeam"),
			1
		)

		if debugDraw then
			gRegion:__wf_atom_8d991675(groundPos2, 0.5, Color(0, 255, 0, 125), 15)
		end

		v2:__wf_atom_97f955c1(__wf_atom_402b3832_2)
		table.remove(positions, 1)
	end

	if debugDraw then
		Color(0, 255, 255)
		local v3 = Color(255, 0, 255)
		gRegion:__wf_atom_628723a6(position + Vector(0, 40, 0), position, v3, 60)
		gRegion:__wf_atom_5b35a0c8(position + Vector(0, 40, 0), v3, "Squid Plant Encounter", 1, 60)
		gRegion:__wf_atom_628723a6(position + Vector(0, 2, 0), v2:GetPosition() + Vector(0, 40, 0), v3, 60)
	end
end

function Start(object)
	v = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return
	end

	v2 = object
	position = object:GetPosition()
	v2:__wf_atom_8e6fec76(1)
	local __wf_atom_28ce676a = v:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, Range(0, 25), 2)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(5, 5, -5)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(30)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(spawnRadius.maxValue, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_09d2b44e(false)
	__wf_atom_28ce676a:__wf_atom_28a1a374(Vector(0, -1, 0), { 4, 27, 24 })
	local positions = module4.GetPositions(1, __wf_atom_28ce676a)

	if __wf_atom_7e8ad928(positions) or __wf_atom_7e8ad928(positions[1]) then
		v2:__wf_atom_8e6fec76(6)
		return
	end

	v2:__wf_atom_c53e1842(positions[1])
	position = positions[1]
	fn()

	if __wf_atom_7e8ad928(v2) then
		print("Shutdown due to level streaming")
		return
	end

	v2:__wf_atom_8e6fec76(2)

	while not module.ShouldShutDown(v2) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v2) then
		print("Shutdown due to level streaming")
		return
	end

	if module.ShouldShutDown(v2) then
		module.RemoveObjects(v2)
		v2:__wf_atom_8e6fec76(6)
	else
		v2:__wf_atom_8e6fec76(4)

		if not module2.IsInOverworld() then
			v2:Disable()
		end
	end

	while not __wf_atom_7e8ad928(v2) and v2:__wf_atom_e464a32f() > 0 and v:__wf_atom_c6f505f2(v2) > 0 do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v2) then
		print("Shutdown due to level streaming")
		return
	end

	module.RemoveObjects(v2)
	Sleep(0)
end