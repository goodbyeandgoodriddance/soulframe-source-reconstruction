local v = Symbol("OdeDroneSiegeSpawnPoint")
local v2 = WeakResource("/SF/Types/Enemies/Sinecure/OdeDrone/OdeDroneAgent")
local v3 = Symbol("OdeDroneMineWaypoint")
local v4 = {}
local position = nil
local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("Lotus.Scripts.Libs.Query")

function SpawnMineLayingOdeDrone(object)
	if __wf_atom_7e8ad928(object) then
		print("Failed to spawn siege ode drone: scriptTrigger null")
		return
	end

	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		print("Failed to spawn siege ode drone: hint null")
		return
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v, __wf_atom_f7e7be53:GetPosition(), 0, 100)

	if __wf_atom_7e8ad928(__wf_atom_439c0d29) or #__wf_atom_439c0d29 == 0 then
		print("Failed to spawn siege ode drone: Could not find any spawn waypoints in area")
		return
	end

	local v5 = __wf_atom_439c0d29[math.random(#__wf_atom_439c0d29)]

	if __wf_atom_7e8ad928(v5) then
		print("Failed to spawn siege ode drone: No valid spawn waypoints in area")
		return
	end

	local enemyLevel = module.GetEnemyLevel(__wf_atom_f7e7be53)
	local agent = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():CreateAgent(
		Type(v2),
		v5,
		Symbol("RandomTeam"),
		__wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
	)

	if __wf_atom_7e8ad928(agent) then
		print("Failed to spawn siege ode drone: Agent null")
		return
	end

	local __wf_atom_50a7d83e = agent:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		print("Failed to spawn siege ode drone: Avatar null")
		return
	end

	__wf_atom_f7e7be53:__wf_atom_97f955c1(agent)
	Sleep(0)
	__wf_atom_50a7d83e:SetBlackboardBool(Symbol("SiegeMineLaying"), true)
	agent:__wf_atom_5a0e15fd(Symbol("RandomPatrol"), 1)
	print("Successfully spawned siege mine-laying drone")
end

local function fn(object)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(v4) or #v4 == 0 then
		return nil
	end

	local v5 = {}

	for _, v6 in ipairs(v4) do
		if __wf_atom_7e8ad928(v6) then
			continue
		end

		local __wf_atom_a56d7910 = gRegion:__wf_atom_a56d7910(v6:GetPosition(), 3, { mineType })

		if not (__wf_atom_7e8ad928(__wf_atom_a56d7910) or not (#__wf_atom_a56d7910 > 0)) then
			continue
		end

		local v7 = false

		for _, v8 in ipairs(gRegion:__wf_atom_ef7900cf()) do
			if __wf_atom_7e8ad928(v8) or v8:IsKilled() then
				continue
			end

			if not (__wf_atom_a93b9922(v6:GetPosition(), v8:GetPosition()) < 100) then
				continue
			end

			v7 = true
			break
		end

		if not v7 then
			table.insert(v5, v6)
		end
	end

	return v5[math.random(#v5)]
end

function Evaluate(object, _)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	if not __wf_atom_7e8ad928(position) then
		return true
	end

	if object:__wf_atom_52077f7a(Symbol("SiegeMineLaying")) ~= true then
		return false
	end

	v4 = gRegion:__wf_atom_439c0d29(v3, object:GetPosition(), 0, 100)
	local v5 = fn(object)

	if __wf_atom_7e8ad928(v5) then
		local position2 = object:GetPosition()
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local __wf_atom_05ef28b9 = __wf_atom_30e3d82b:__wf_atom_05ef28b9()
		local v6

		if __wf_atom_7e8ad928(__wf_atom_05ef28b9) then
			v6 = 30
		else
			print(__wf_atom_05ef28b9:__wf_atom_5b41f63b())
			position2 = __wf_atom_05ef28b9:GetPosition()
			local __wf_atom_0aa77159 = __wf_atom_05ef28b9:__wf_atom_0aa77159()
			local __wf_atom_ee03557f = __wf_atom_05ef28b9:__wf_atom_ee03557f()
			v6 = math.min(__wf_atom_ee03557f.x - __wf_atom_0aa77159.x, __wf_atom_ee03557f.z - __wf_atom_0aa77159.z) / 2
		end

		local __wf_atom_28ce676a = __wf_atom_7d789620:__wf_atom_28ce676a()
		__wf_atom_28ce676a:__wf_atom_267bfc41(position2, Range(0, v6), 2)
		__wf_atom_28ce676a:__wf_atom_62a3e89b(1, 2, -2)
		__wf_atom_28ce676a:__wf_atom_4a7833f4()
		__wf_atom_28ce676a:__wf_atom_655394dc()
		__wf_atom_28ce676a:__wf_atom_06c7577b()
		__wf_atom_28ce676a:__wf_atom_7e9d12f8(15)
		__wf_atom_28ce676a:__wf_atom_df6829ae(Range(1, 3.4028234663852886e38))
		__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("OdeDroneSiegeMine"), Color("0x0000FF"))

		for _, v7 in ipairs(gRegion:__wf_atom_ef7900cf()) do
			if not (__wf_atom_7e8ad928(v7) or v7:IsKilled()) then
				__wf_atom_28ce676a:__wf_atom_37c09cee(v7:GetPosition(), spawnRadiusBetweenMines)
			end
		end

		local __wf_atom_a56d7910 = gRegion:__wf_atom_a56d7910(object:GetPosition(), 100, { mineType })

		for _, v7 in ipairs(__wf_atom_a56d7910) do
			if not __wf_atom_7e8ad928(v7) then
				__wf_atom_28ce676a:__wf_atom_37c09cee(v7:GetPosition(), spawnRadiusBetweenMines)
			end
		end

		local positions = module2.GetPositions(1, __wf_atom_28ce676a)

		if not __wf_atom_7e8ad928(positions) and #positions > 0 then
			position = positions[1]
		end
	else
		position = v5:GetPosition()
	end

	if not __wf_atom_7e8ad928(position) then
		return true
	end

	print("ERROR, could not find valid position to drop next mine")
	return false
end

function Activate(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if __wf_atom_7e8ad928((object:__wf_atom_30e3d82b())) then
	end
end

function Update(object, _)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return false
	end

	if not __wf_atom_7e8ad928(position) then
		for _, v5 in ipairs(gRegion:__wf_atom_ef7900cf()) do
			if
				__wf_atom_7e8ad928(v5)
				or v5:IsKilled()
				or not (__wf_atom_a93b9922(position, v5:GetPosition()) < 100)
			then
				continue
			end

			position = nil
			return false
		end

		if __wf_atom_a93b9922(object:GetPosition(), position) < 9 then
			if #gRegion:__wf_atom_a56d7910(object:GetPosition(), 100, { mineType }) < maxMineCount then
				local v5 = (object:__wf_atom_1c374cc9(Symbol("GAME_L1_HAND")) + object:__wf_atom_1c374cc9(Symbol("GAME_R1_HAND"))) / 2 + Vector(0, -1, 0)
				local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
				gRegion:CreateEntity(mineType, v5, __wf_atom_2f2bada0)
			end

			position = nil
			return true
		else
			__wf_atom_30e3d82b:__wf_atom_b783ff91(position)

			if debugDrawMinePlacement then
				gRegion:__wf_atom_12f21926(
					position,
					position,
					0.2,
					Vector(1, 0, 0),
					Vector(0, 1, 0),
					Color(255, 0, 0),
					5
				)
				gRegion:__wf_atom_628723a6(object:GetPosition(), position, Color(0, 0, 255), 0.1)
			end
		end
	end
end

function Deactivate(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	__wf_atom_30e3d82b:__wf_atom_24ddbdc3()
end