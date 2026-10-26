local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.ModifySkyLib")
local v = Symbol("RandomTeam")
local v2 = Symbol("Grineer")
local v3 = Range(90, 130)
local v4 = nil
local v5 = nil
local randomPointInRangeOnNav = nil
local v6 = nil
local v7 = nil
local patrolRoute = {}
local looping = false
local v8 = false
local v9 = nil
local v10 = nil
local v11 = true
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = {}
local v16 = 1

local function fn()
	v6 = v5:__wf_atom_6199ef01()

	if not v11 and (__wf_atom_7e8ad928(v12) or v12:IsKilled()) then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		if not __wf_atom_7e8ad928(__wf_atom_ef7900cf) and #__wf_atom_ef7900cf > 0 then
			v12 = __wf_atom_ef7900cf[__wf_atom_5784a397(1, #__wf_atom_ef7900cf)]
		end
	end
end

local function fn2()
	for i = #v6, 1, -1 do
		if __wf_atom_7e8ad928(v6[i]) then
			table.remove(v6, i)
			table.remove(v15, i)
		else
			local __wf_atom_50a7d83e = v6[i]:__wf_atom_50a7d83e()

			if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled() then
				table.remove(v6, i)
				table.remove(v15, i)
			else
				for j, v17 in ipairs(v15[i]) do
					if not (v6[i]:__wf_atom_049aa7d4() == v17 or __wf_atom_50a7d83e:__wf_atom_a5304c35(v17) <= 3) then
						continue
					end

					v16 = math.max(v16, j)
				end
			end
		end
	end

	v6 = v5:__wf_atom_6199ef01()
end

local function fn3()
	local points = {}
	local v17 = nil
	local isInOverworld = module2.IsInOverworld()

	if not __wf_atom_7e8ad928(v9) then
		if not __wf_atom_7e8ad928(_T.CustomPatrols) then
			local __wf_atom_db682341 = v9:__wf_atom_db682341()

			if not __wf_atom_7e8ad928(__wf_atom_db682341) then
				local v18 = tostring(__wf_atom_db682341)

				if not __wf_atom_7e8ad928(_T.CustomPatrols[v18]) then
					points = _T.CustomPatrols[v18].points
					v17 = _T.CustomPatrols[v18].points[#_T.CustomPatrols[v18].points]
					looping = _T.CustomPatrols[v18].looping
				end
			end
		end

		if #points == 0 then
			local pointInstances = module.FindPointInstances(v9 or v5, nil, Symbol("RegionPatrolRoute"))

			if __wf_atom_7e8ad928(pointInstances) or not (#pointInstances > 0) then
				if not __wf_atom_7e8ad928(v9) then
					local __wf_atom_103377cc = v9:__wf_atom_103377cc()

					if not isInOverworld then
						__wf_atom_103377cc = v9:__wf_atom_8f18e876()
					end

					local position = v9:GetPosition()
					local v18 = __wf_atom_5784a397(4, 6)
					local v19 = __wf_atom_5784a397(0, 180)

					for i = 1, v18 do
						local v20 = __wf_atom_103377cc * __wf_atom_8d119bab(0.2, 0.8)
						local v21 = i * (360 / v18) + v19
						table.insert(points, position + __wf_atom_9341614d(Vector(v20, 0, 0), Rotation(v21, 0, 0)))
					end

					local v20 = Vector()
					v10:__wf_atom_3cc125d0(randomPointInRangeOnNav, v20)
					randomPointInRangeOnNav = v20
				end
			else
				local pointInstance = pointInstances[__wf_atom_5784a397(1, #pointInstances)]

				if pointInstance:IsA(__wf_atom_3a0953be) then
					local __wf_atom_31c6f706 = pointInstance:__wf_atom_31c6f706()

					for _, v18 in ipairs(__wf_atom_31c6f706) do
						if not __wf_atom_7e8ad928(v18) then
							table.insert(points, v18:GetPosition())
						end
					end
				else
					v13 = pointInstance
				end
			end

			if #points > 0 then
				looping = true
				v8 = true
			end
		end
	end

	if __wf_atom_7e8ad928(points) or not (#points > 0) then
		if huntingParty then
			randomPointInRangeOnNav = v4:GetRandomPointInRangeOnNav(randomPointInRangeOnNav, 0, 15, true, 0.5)
			local randomSpawnsOnNavInRange = module.FindRandomSpawnsOnNavInRange(randomPointInRangeOnNav, v3, 10, 20)
			local v18 = nil
			local __wf_atom_4e9476e3 = v4:__wf_atom_4e9476e3(randomPointInRangeOnNav)

			if not __wf_atom_7e8ad928(__wf_atom_4e9476e3) then
				randomSpawnsOnNavInRange = module2.SortPositionsByDistance(
					randomSpawnsOnNavInRange,
					__wf_atom_4e9476e3:GetPosition()
				)
			end

			while #randomSpawnsOnNavInRange > 0 do
				local v19 = __wf_atom_5784a397(1, (math.ceil(#randomSpawnsOnNavInRange * 0.5)))

				if module.IsValidDestinationForEncounter(randomSpawnsOnNavInRange[v19], v5) then
					v18 = randomSpawnsOnNavInRange[v19]
					break
				else
					table.remove(randomSpawnsOnNavInRange, v19)
				end
			end

			if not __wf_atom_7e8ad928(v18) then
				table.insert(patrolRoute, randomPointInRangeOnNav)
				table.insert(patrolRoute, v18)
			end
		elseif isInOverworld or not pathToDungeonSpawnOrExit then
			if __wf_atom_7e8ad928(v13) then
				local v18 = Vector()
				v10:__wf_atom_3cc125d0(randomPointInRangeOnNav, v18)

				if spawnOnRoad and v5:__wf_atom_a5304c35(v18) <= 25 then
					randomPointInRangeOnNav = v18
				end

				patrolRoute = module.GetRoadPatrolPts(
					randomPointInRangeOnNav,
					generatePatrolRange,
					v5,
					ignoreDisallowedHints
				)

				if not __wf_atom_7e8ad928(patrolRoute) then
					if #patrolRoute <= 1 or Distance(patrolRoute[1], patrolRoute[#patrolRoute]) < 10 then
						patrolRoute = {}
					else
						local total = 0

						for i = 2, #patrolRoute do
							total += Distance(patrolRoute[i - 1], patrolRoute[i])
						end

						if total < generatePatrolRange.minValue then
							patrolRoute = {}
						end
					end
				end
			end
		else
			local all = gRegion:FindAll(__wf_atom_f806fd7a)
			local position = nil

			while #all > 0 do
				local v18 = __wf_atom_5784a397(1, #all)

				if v5 == all[v18] or not v10:__wf_atom_e58b162a(randomPointInRangeOnNav, all[v18]:GetPosition()) then
					table.remove(all, v18)
				else
					position = all[v18]:GetPosition()
					break
				end
			end

			if not __wf_atom_7e8ad928(position) then
				table.insert(patrolRoute, position)
				table.insert(patrolRoute, randomPointInRangeOnNav)
			end
		end
	else
		patrolRoute = {}
		local v18 = nil

		for _, point in ipairs(points) do
			local v19 = Vector()
			v10:__wf_atom_3cc125d0(point, v19)

			if not __wf_atom_7e8ad928(v18) then
				local roadPointsBetweenPositions = module.GetRoadPointsBetweenPositions(v18, v19)
				local v20 = module2.RemoveDuplicatesFromTable(roadPointsBetweenPositions)
				module2.MergeTables(patrolRoute, v20)
			end

			v18 = v19
		end

		if looping then
			local roadPointsBetweenPositions = module.GetRoadPointsBetweenPositions(points[#points], points[1])
			local v19 = module2.RemoveDuplicatesFromTable(roadPointsBetweenPositions)
			module2.MergeTables(patrolRoute, v19)
		elseif not __wf_atom_7e8ad928(v17) then
			table.insert(patrolRoute, v17)
		end

		print("Done generating patrol route")
	end

	for i = 1, #patrolRoute do
		patrolRoute[i] = v4:__wf_atom_0e0a6fee(patrolRoute[i])
		patrolRoute[i].y = patrolRoute[i].y + i * 0.01
	end
end

local function fn4()
	local v17 = 0
	v7 = gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients")
	v7 = __wf_atom_421b01aa(v7, 1, 3)
	local v18 = ({ spawnCountOnePlayer, spawnCountTwoPlayer, spawnCountThreePlayer })[v7]

	if v18.minValue > 0 and v18.maxValue > 0 then
		v17 = __wf_atom_5784a397(v18.minValue, v18.maxValue)
	end

	local v19 = math.max(v17, 1)
	local v20 = false
	local v21

	if not __wf_atom_7e8ad928(customSquadList) then
		v21 = module.GetRandomSquadList(v19, customSquadList)

		if not __wf_atom_7e8ad928(v21) and #v21 > 0 then
			v19 = #v21
			v20 = true
		end
	end

	return v19, v20, v21
end

function DissolveIn(object)
	local v17 = 0

	while v17 < 0.5 do
		v17 = __wf_atom_421b01aa(v17 + __wf_atom_084b3e93(), 0, 1)
		object:__wf_atom_68f2c268(1 - v17 / 0.5)
		Sleep(0)
	end

	object:__wf_atom_68f2c268(0)
end

local function fn5()
	if #v6 == 0 then
		print("Spawning agents")
		local v17, v18, v19 = fn4()

		if v17 == 0 then
			return false
		end

		local enemyLevel = module.GetEnemyLevel(v5)
		local v20 = randomPointInRangeOnNav

		if not __wf_atom_7e8ad928(patrolRoute) and #patrolRoute > 0 then
			if spawnOnRoad then
				v20 = module2.NearestPositionToObject(v5, patrolRoute)

				if __wf_atom_7e8ad928(v20) then
					v20 = v4:__wf_atom_0e0a6fee(randomPointInRangeOnNav)
				end
			else
				v20 = v4:__wf_atom_0e0a6fee(randomPointInRangeOnNav)
			end
		end

		local v21 = false

		if not __wf_atom_7e8ad928(nightTorchBearerType) then
			local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
			v21 = (__wf_atom_cb3427c9 >= 22 or __wf_atom_cb3427c9 < 6 or module3.IsOvercast() or module3.IsRaining())
				and true
				or false
		end

		local v22 = patrolRoute[2] or randomPointInRangeOnNav
		local randomPointInRangeOnNav2 = v20

		for i = 1, v17 do
			local v23 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
			local agentType

			if v18 then
				if v19[i].useCustomAgentType then
					agentType = v19[i].agentType
				else
					agentType = module.GetRandomEnemyAgentType(
						nil,
						v2,
						v23,
						v5,
						v19[i].agentSpec.archetype,
						v19[i].agentSpec.rank,
						v19[i].agentSpec.exclusiveRank
					)
				end
			elseif #customAgentTypes > 0 then
				if randomizeCustomTypes or __wf_atom_7e8ad928(customAgentTypes[i]) then
					agentType = customAgentTypes[__wf_atom_5784a397(1, #customAgentTypes)]
				else
					agentType = customAgentTypes[i]
				end
			else
				agentType = module.GetRandomEnemyAgentType(nil, v2, v23, v5)
			end

			if v21 and agentType == agentToReplaceWithNight then
				agentType = nightTorchBearerType
				v21 = false
			end

			if __wf_atom_7e8ad928(agentType) then
				print("ERROR: Couldn't find enemy type to spawn!")
			else
				local v24 = 2 + math.random() * 0.5
				local v25 = __wf_atom_fa8d0177(v22, v20)
				local v26 = randomPointInRangeOnNav2 + __wf_atom_9341614d(Vector(0, 0, v24), v25)
				randomPointInRangeOnNav2 = v4:__wf_atom_0e0a6fee(v26, 5, 20)

				if not v10:__wf_atom_e58b162a(v20, randomPointInRangeOnNav2) then
					randomPointInRangeOnNav2 = v4:GetRandomPointInRangeOnNav(v20, 0, 10, true, 0.5)
				end

				local v27 = __wf_atom_fa8d0177(randomPointInRangeOnNav2, v20)
				local __wf_atom_402b3832 = v4:__wf_atom_402b3832(agentType, randomPointInRangeOnNav2, v27, v, v23)

				if debugDraw then
					gRegion:__wf_atom_49268b3c(randomPointInRangeOnNav2, v27, Color(255, 0, 0), 1, 60)
				end

				if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
					v5:__wf_atom_97f955c1(__wf_atom_402b3832)

					if neverPauseAgents then
						__wf_atom_402b3832:__wf_atom_b1da7683(true)
					end

					if __wf_atom_7e8ad928(v13) then
						if not __wf_atom_7e8ad928(patrolRoute) and #patrolRoute > 0 then
							if i == 1 then
								v14 = __wf_atom_402b3832
							end

							local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

							if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
								__wf_atom_402b3832:__wf_atom_b783ff91(
									module2.NearestPositionToObject(__wf_atom_50a7d83e, patrolRoute),
									0
								)
								__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("DissolveIn"), false)
							end

							__wf_atom_402b3832:__wf_atom_ce40066e(Symbol("ShouldPatrol"), true)
						end
					else
						__wf_atom_402b3832:SetPatrolRoute(v13)
					end
				end
			end

			if i < v17 then
				Sleep(0.2 + math.random() * 0.1)
			else
				Sleep(0)
			end

			if not module.ShouldShutDown(v5, v9) then
				continue
			end

			print("SpawnAgents shutdown, likely streaming")
			return
		end

		print("Done spawning agents")
	else
		print("Agents already spawned, assigning patrol destinations")
		print("Done assigning destinations")
	end

	fn()
	return true
end

local function fn6(object)
	v4 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming (1)")
		return false
	end

	v5 = object
	v9 = v5:__wf_atom_26b04ea9()
	randomPointInRangeOnNav = object:GetPosition()
	v10 = gRegion:__wf_atom_2202ffb6()
	v11 = module2.IsInOverworld()
	v5:__wf_atom_8e6fec76(1)
	return true
end

local function fn7()
	fn3()
	fn()

	if bailIfNoPatrolRoute and (__wf_atom_7e8ad928(patrolRoute) or #patrolRoute == 0) then
		print("Shutdown due to no patrol route and bailIfNoPatrolRoute=true")
		return false
	end

	if not fn5() then
		return false
	end

	if __wf_atom_7e8ad928(v5) then
		print("Shutdown due to level streaming (2)")
		return false
	end

	local __wf_atom_e919fb8e = v5:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.patrolRoute = patrolRoute
	return true
end

local function fn8()
	print("Patrol encounter ending...")

	if __wf_atom_7e8ad928(v5) then
		print("Shutdown due to level streaming (3)")
		return
	end

	if v5:__wf_atom_3634e6d2() == 0 then
		print("Patrol encounter succeeded")
		v5:__wf_atom_8e6fec76(4)
	else
		print("Patrol encounter is shutting down")
		v5:__wf_atom_8e6fec76(6)
	end

	for _, v17 in ipairs(v6) do
		if not __wf_atom_7e8ad928(v17) then
			v17:__wf_atom_ce40066e(Symbol("ShouldPatrol"), false)
		end
	end

	if module.ShouldShutDown(v5) then
		print("Removing agents")
		module.RemoveAgents(v5)
	end

	Sleep(1)
end

function FindFurthestAgent(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
	local v17 = 0
	local v18 = nil

	for i = 1, #v6 do
		if object == v6[i] then
			continue
		end

		local __wf_atom_1c8f7b2d = v6[i]:__wf_atom_50a7d83e():__wf_atom_1c8f7b2d(__wf_atom_50a7d83e)

		if not (v17 < __wf_atom_1c8f7b2d) then
			continue
		end

		v18 = v6[i]
		v17 = __wf_atom_1c8f7b2d
	end

	return v18
end

function ReverseFormation()
	if __wf_atom_7e8ad928(v14) and #v6 ~= 0 then
		v14 = v6[1]
		local __wf_atom_50a7d83e = v14:__wf_atom_50a7d83e()
		local nearestPositionToObject = module2.NearestPositionToObject(__wf_atom_50a7d83e, patrolRoute)
		v14:__wf_atom_b783ff91(nearestPositionToObject, 0)
	end

	if Distance(patrolRoute[1], patrolRoute[#patrolRoute]) < 7 or #v6 <= 1 then
		patrolRoute = module.ReversePatrolRoute(patrolRoute, { v14 })
		return
	end

	patrolRoute = module.ReversePatrolRoute(patrolRoute, { v14 })
	local v17 = FindFurthestAgent(v14)

	if __wf_atom_7e8ad928(v17) then
		return
	end

	local v18 = Symbol("BlockingBehavior")
	v14:__wf_atom_24ddbdc3()

	for i = 1, #v6 do
		v6[i]:__wf_atom_ce40066e(Symbol("ShouldPatrol"), false)
		local __wf_atom_50a7d83e = v6[i]:__wf_atom_50a7d83e()
		v6[i]:__wf_atom_aa4361c1(v18, __wf_atom_50a7d83e)
	end

	local v19 = v14

	if v17 ~= v14 then
		v14 = v17
		local __wf_atom_50a7d83e = v14:__wf_atom_50a7d83e()
		local nearestPositionToObject = module2.NearestPositionToObject(__wf_atom_50a7d83e, patrolRoute)
		v14:__wf_atom_b783ff91(nearestPositionToObject, 0)
	end

	Sleep(2)

	if not __wf_atom_7e8ad928(v19) then
		v19:__wf_atom_24ddbdc3()
	end

	for i = 1, #v6 do
		if __wf_atom_7e8ad928(v6[i]) then
			continue
		end

		v6[i]:__wf_atom_ce40066e(Symbol("ShouldPatrol"), true)
		v6[i]:__wf_atom_42b767a2(v18)
	end
end

function Start(p)
	print("Patrol encounter started")

	if not (fn6(p) and fn7()) then
		return
	end

	print("Encounter setup complete")
	module2.StartPluginScripts(pluginScripts, p)
	v5:__wf_atom_8e6fec76(2)
	local _randomizeCustomTypes = randomizeCustomTypes
	local randomDebugDrawColor = module2.GetRandomDebugDrawColor()
	local v17 = Vector(0, math.random() * 2, 0) + Vector(0, 0.5, 0)
	local name = v5:__wf_atom_dd85e6db():GetName()
	local pausePatrols = false
	local total = 0
	local total2 = 0

	while not module.ShouldShutDown(v5, v9) and v5:__wf_atom_3634e6d2() > 0 do
		fn()

		if not __wf_atom_7e8ad928(_T.PausePatrols) and pausePatrols ~= _T.PausePatrols then
			for _, v18 in ipairs(v6) do
				if _T.PausePatrols then
					v18:__wf_atom_24ddbdc3()
				elseif __wf_atom_7e8ad928(v13) then
					if #patrolRoute > 0 then
						local __wf_atom_50a7d83e = v18:__wf_atom_50a7d83e()

						if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled()) then
							local nearestPositionToObject = module2.NearestPositionToObject(
								__wf_atom_50a7d83e,
								patrolRoute
							)

							if v18 == v14 then
								v18:__wf_atom_b783ff91(nearestPositionToObject)
							end
						end
					end
				else
					v18:SetPatrolRoute(v13)
				end
			end

			pausePatrols = _T.PausePatrols
		end

		if total >= 3 then
			if huntingParty then
				module.UpdateDestinations(v6, patrolRoute, true)
			elseif #patrolRoute > 0 then
				if looping then
					module.UpdateDestinations(v6, patrolRoute, true, v5, v8)
				elseif module.UpdateDestinations(v6, patrolRoute, false, v5, v8 or ignoreDisallowedHints) then
					ReverseFormation()
				end
			elseif not __wf_atom_7e8ad928(v12) and __wf_atom_7e8ad928(v13) then
				for _, v18 in ipairs(v6) do
					if __wf_atom_7e8ad928(v18) or v18 ~= v14 then
						continue
					end

					v18:__wf_atom_b783ff91(v12:GetPosition())
				end
			end
		else
			total += __wf_atom_084b3e93()
		end

		if total2 >= 10 and not __wf_atom_7e8ad928(v6[1]) then
			local __wf_atom_50a7d83e = v6[1]:__wf_atom_50a7d83e()

			if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				randomPointInRangeOnNav = __wf_atom_50a7d83e:GetPosition()
				v5:__wf_atom_c53e1842(randomPointInRangeOnNav)
			end

			total2 = 0
		else
			total2 += __wf_atom_084b3e93()
		end

		if debugDraw or not __wf_atom_7e8ad928(v9) and _T.DebugDrawDailyLocations then
			module.DebugDrawPatrolRoute(patrolRoute, v17, randomDebugDrawColor, 0, name, huntingParty or looping)
			module.DebugDrawAgents(v6, randomDebugDrawColor)
			gRegion:__wf_atom_628723a6(
				randomPointInRangeOnNav,
				randomPointInRangeOnNav + Vector(0, 20, 0),
				Color(0, 0, 255),
				0
			)
			gRegion:__wf_atom_b5c21154(
				randomPointInRangeOnNav,
				v5:__wf_atom_103377cc(),
				Color(255, 255, 0),
				Rotation(0, 90, 0),
				0
			)
			gRegion:__wf_atom_b5c21154(
				randomPointInRangeOnNav,
				v5:__wf_atom_8f18e876(),
				Color(0, 255, 0),
				Rotation(0, 90, 0),
				0
			)
			gRegion:__wf_atom_b5c21154(
				randomPointInRangeOnNav,
				v5:__wf_atom_4a0ffa6e(),
				Color(255, 0, 0),
				Rotation(0, 90, 0),
				0
			)
		end

		Sleep(0)
	end

	fn8()
	print("Patrol encounter ended")
end

local function fn9(__wf_atom_0e0a6fee, __wf_atom_0e0a6fee2, p)
	local v17 = math.ceil(p / 20)
	local result = { __wf_atom_0e0a6fee }

	for i = 1, v17 do
		table.insert(
			result,
			(v4:__wf_atom_0e0a6fee(__wf_atom_f55d6358(__wf_atom_0e0a6fee, __wf_atom_0e0a6fee2, i / v17), 5, 100))
		)
	end

	return result
end

local function fn10()
	fn()
	local enemyLevel = module.GetEnemyLevel(v5)
	local v17 = __wf_atom_5784a397(generatePatrolRange.minValue, generatePatrolRange.maxValue)
	local v18 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
	local v19 = __wf_atom_9341614d(Vector(v17, 0, 0), v18)
	local v20 = { Vector(0, 0, -9), Vector(0, 0, -3), Vector(0, 0, 3), Vector(0, 0, 9) }
	Vector(0, 1, 0)
	local v21 = {}

	for _, v22 in ipairs(v20) do
		table.insert(v21, (__wf_atom_9341614d(v22, v18)))
	end

	local v22 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
	local randomSquadList = module.GetRandomSquadList(#v20, customSquadList)

	for i = 1, #v20 do
		local agentType

		if randomSquadList[i].useCustomAgentType then
			agentType = randomSquadList[i].agentType
		else
			agentType = module.GetRandomEnemyAgentType(
				nil,
				v2,
				v22,
				v5,
				randomSquadList[i].agentSpec.archetype,
				randomSquadList[i].agentSpec.rank,
				randomSquadList[i].agentSpec.exclusiveRank
			)
		end

		if __wf_atom_7e8ad928(agentType) then
			print("Sweep encounter couldn't find agent type!")
		else
			local __wf_atom_0e0a6fee = v4:__wf_atom_0e0a6fee(randomPointInRangeOnNav + v21[i], 5, 100)
			local __wf_atom_0e0a6fee2 = v4:__wf_atom_0e0a6fee(__wf_atom_0e0a6fee + v19, 5, 100)
			local v23

			if #v6 == 0 then
				v23 = v4:__wf_atom_402b3832(agentType, __wf_atom_0e0a6fee, v18, v, v22)
				v5:__wf_atom_97f955c1(v23)

				if module.IsRangedAgent(v23) then
					v23:__wf_atom_50a7d83e():SetBlackboardBool(Symbol("ForceEquipWeapon"), true)
				end
			elseif __wf_atom_7e8ad928(v6[i]) then
				continue
			else
				v23 = v6[i]
			end

			local v24 = fn9(__wf_atom_0e0a6fee, __wf_atom_0e0a6fee2, v17)
			v23:__wf_atom_b783ff91(v24[2])
			table.insert(v15, v24)
		end
	end

	fn()
	local __wf_atom_e919fb8e = v5:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.patrolRoute = v15[2]
	return #v6 > 0
end

function SweepEncounter(p)
	print("Patrol encounter started")

	if not (fn6(p) and fn10()) then
		return
	end

	print("Encounter setup complete")
	module2.StartPluginScripts(pluginScripts, p)
	v5:__wf_atom_8e6fec76(2)
	local randomDebugDrawColor = module2.GetRandomDebugDrawColor()
	local v17 = Vector(0, math.random() * 2, 0) + Vector(0, 0.5, 0)
	local name = v5:__wf_atom_dd85e6db():GetName()
	local total = 0

	while not module.ShouldShutDown(v5, v9) and v5:__wf_atom_3634e6d2() > 0 do
		fn2()

		if debugDraw or not __wf_atom_7e8ad928(v9) and _T.DebugDrawDailyLocations then
			module.DebugDrawAgents(v6, randomDebugDrawColor)
		end

		if total >= 2 then
			local v18 = {}
			local count = 0

			for i, v19 in ipairs(v6) do
				local __wf_atom_50a7d83e = v19:__wf_atom_50a7d83e()

				if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					continue
				end

				if __wf_atom_50a7d83e:__wf_atom_a5304c35(v15[i][v16]) <= 3 then
					v18[i] = true
					count += 1
				else
					v18[i] = false
				end
			end

			local v19 = v15[1][v16]

			if randomPointInRangeOnNav ~= v19 and v19 ~= nil then
				v5:__wf_atom_c53e1842(v19)
				randomPointInRangeOnNav = v19
			end

			local count2 = 0

			for i, v20 in ipairs(v6) do
				local __wf_atom_e919fb8e = v20:__wf_atom_50a7d83e():__wf_atom_e919fb8e()

				if
					(not v18[i] or count == #v6 or __wf_atom_7e8ad928(v20:__wf_atom_049aa7d4()) and (not v20:__wf_atom_04ea4887() or __wf_atom_e919fb8e.fleeAlongPatrolRoute))
					and module.UpdateDestinations({ v20 }, v15[i], false, v5)
				then
					count2 += 1
				end

				if debugDraw or not __wf_atom_7e8ad928(v9) and _T.DebugDrawDailyLocations then
					module.DebugDrawPatrolRoute(v15[i], v17, randomDebugDrawColor, 0, name, false)
				end
			end

			if v16 == #v15[1] and count2 == #v6 then
				for i, v20 in ipairs(v6) do
					v15[i] = module.ReversePatrolRoute(v15[i], { v20 })
				end
			end
		else
			total += __wf_atom_084b3e93()
		end

		Sleep(0)
	end

	fn8()
	print("Patrol encounter ended")
end