local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("Lotus.Scripts.Libs.Query")
local module4 = require("SF.Scripts.Libs.RaycastLib")
local v = nil
local v2 = nil
local position = nil

local function fn(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_28ce676a = v:__wf_atom_28ce676a()
	local position2 = object:GetPosition()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position2, p2, 2)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(spawnAngleLimit)
	__wf_atom_28ce676a:__wf_atom_df6829ae(spawnRangeFromNavEdge)
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("AnimalEncounter"), Color("0x00FFCC"))

	if preferSpawnInWater then
		__wf_atom_28ce676a:__wf_atom_9699b67c(true)
	elseif not canSpawnInWater then
		__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	end

	if avoidSpawnOnRoads then
		__wf_atom_28ce676a:__wf_atom_09d2b44e(false)
	end

	if #validSpawnSurfaces > 0 then
		__wf_atom_28ce676a:__wf_atom_28a1a374(Vector(0, -1, 0), validSpawnSurfaces)
	end

	local __wf_atom_9c85bbdb = object:__wf_atom_9c85bbdb(300)
	local nearestObject = module2.NearestObject(position2, __wf_atom_9c85bbdb)

	if not (__wf_atom_7e8ad928(nearestObject) or nearestObject:IsKilled()) then
		__wf_atom_28ce676a:__wf_atom_60113517(nearestObject:GetPosition(), 1, 1, 0.2)
		local cameraControl = nearestObject:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			local __wf_atom_dd7246c7 = cameraControl:__wf_atom_dd7246c7()

			if not __wf_atom_7e8ad928(__wf_atom_dd7246c7) then
				__wf_atom_28ce676a:__wf_atom_9b7f7161(
					nearestObject:GetPosition(),
					__wf_atom_dd7246c7:__wf_atom_a06d543c(),
					-1,
					2,
					1,
					1,
					false
				)
			end
		end
	end

	return module3.GetPositions(p, __wf_atom_28ce676a) or {}
end

local function fn2(object)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
	local v3

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		v3 = 0.05
	else
		local v4 = __wf_atom_0a6a5887:GetColor(object:GetPosition(), true).red / 255
		v3 = __wf_atom_104bfe98(0.05, 0.15, v4)
	end

	local v4 = Random(0, 1)
	return 1 - v3 < v4
end

local function fn3(object)
	if object:__wf_atom_3634e6d2() > 0 then
		return
	end

	if spawnRange.maxValue <= 0 then
		spawnRange = Range(0, v2:__wf_atom_103377cc())
	end

	local v3 = __wf_atom_5784a397(numAnimalsToSpawn.minValue, numAnimalsToSpawn.maxValue)
	local v4 = fn(object, v3, spawnRange)

	if #v4 == 0 and preferSpawnInWater then
		preferSpawnInWater = false
		v4 = fn(object, v3, spawnRange)
	end

	local v5 = fn2(object)

	for _ = 1, math.min(v3, #v4) do
		local agentType = agentType

		if v5 and not __wf_atom_7e8ad928(rareAgentType) then
			agentType = rareAgentType
		end

		local v6 = __wf_atom_5784a397(1, #v4)
		local __wf_atom_402b3832 = v:__wf_atom_402b3832(
			agentType,
			v4[v6],
			Rotation(__wf_atom_5784a397(0, 360), 0, 0),
			EMPTY_SYMBOL,
			0
		)

		if __wf_atom_7e8ad928(__wf_atom_402b3832) then
			continue
		end

		local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

		if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			continue
		end

		__wf_atom_50a7d83e:__wf_atom_e5d015a7(EMPTY_SYMBOL)
		__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("DissolveIn"), false)
		object:__wf_atom_97f955c1(__wf_atom_402b3832)
		table.remove(v4, v6)

		if not (animalMeshScaleRangeMult.minValue ~= 1 or animalMeshScaleRangeMult.maxValue ~= 1) then
			continue
		end

		local v7 = __wf_atom_8d119bab(animalMeshScaleRangeMult.minValue, animalMeshScaleRangeMult.maxValue)
		__wf_atom_50a7d83e:SetMeshScale(__wf_atom_50a7d83e:__wf_atom_c082fc3d() * v7)
	end

	local v6 = __wf_atom_5784a397(numDecos.minValue, numDecos.maxValue)

	if #spawnableDecoTypes > 0 and v6 > 0 then
		for _ = 1, math.min(#fn(object, v6, decoSpawnRange), v6) do
			if #v4 == 0 then
				break
			end

			local v7 = __wf_atom_5784a397(1, #v4)
			local spawnableDecoType = spawnableDecoTypes[__wf_atom_5784a397(1, #spawnableDecoTypes)]
			local groundAlignedSpawnPosRot, v8 = module4.GetGroundAlignedSpawnPosRot(
				spawnableDecoType,
				v4[v7],
				Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			)
			local v9 = groundAlignedSpawnPosRot + Vector(0, decoSpawnYOffset, 0)

			if __wf_atom_7e8ad928(v9) then
				continue
			end

			local entity = gRegion:CreateEntity(spawnableDecoType, v9, v8)
			entity:__wf_atom_8a035cd5(Symbol("DissolveIn"), false)
			v2:__wf_atom_d494454b(entity)
		end
	end
end

function Start(object)
	if enableLogging then
		print("Wildlife encounter started")
	end

	v = module2.WaitForAiDir()
	v2 = object
	position = object:GetPosition()

	if __wf_atom_7e8ad928(object) then
		if enableLogging then
			print("Shutdown due to level streaming")
		end
	else
		object:__wf_atom_8e6fec76(1)
		fn3(object)

		if __wf_atom_7e8ad928(object) then
			return
		end

		object:__wf_atom_8e6fec76(2)

		while
			not module.ShouldShutDown(object)
			and object:__wf_atom_3634e6d2() > 0
			and (not (customShutdownRadius > 0) or #object:__wf_atom_9c85bbdb(customShutdownRadius) ~= 0)
		do
			Sleep(0.5)
		end

		if __wf_atom_7e8ad928(object) then
			if enableLogging then
				print("Shutdown due to level streaming")
			end
		else
			object:__wf_atom_8e6fec76(3)
			local __wf_atom_6199ef01 = object:__wf_atom_6199ef01()
			local v3 = Symbol("DissolveOut")

			for _, v4 in pairs(__wf_atom_6199ef01) do
				if __wf_atom_7e8ad928(v4) then
					continue
				end

				local __wf_atom_50a7d83e = v4:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					__wf_atom_50a7d83e:__wf_atom_8a035cd5(v3, false)
				end
			end

			while
				not __wf_atom_7e8ad928(object)
				and object:__wf_atom_0cc670d2() > 0
				and object:__wf_atom_e464a32f() > 0
			do
				Sleep(0)
			end

			module.RemoveObjects(object)

			if enableLogging then
				print("Wildlife encounter ended")
			end
		end
	end
end

function DissolveIn(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:SetVisibility(false)
	Sleep(0)
	local total = 0

	while total <= 3 and not __wf_atom_7e8ad928(object) do
		object:__wf_atom_68f2c268((__wf_atom_104bfe98(1, 0, (math.min(total / 3, 1)))))
		total += __wf_atom_084b3e93()
		object:SetVisibility(true)
		Sleep(0)
	end
end

function DissolveOut(instance)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	Sleep(5)
	local total = 0

	while total <= 5 and not __wf_atom_7e8ad928(instance) do
		instance:__wf_atom_68f2c268((__wf_atom_104bfe98(0, 1, (math.min(total / 5, 1)))))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:SetVisibility(false)
		instance:Destroy()
	end
end