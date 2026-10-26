local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module4 = require("Lotus.Scripts.Libs.Query")
local v = nil
local v2 = nil
local v3 = nil
local position = nil
local total = 0
local total2 = 0
local v4 = {}
local v5 = 0
local v6 = 0
local v7 = nil
local entities = {}
local __wf_atom_bb3e7833s = {}
local v8 = nil
local flag = false
local v9 = 1
local v10 = nil
local v11 = Symbol("UseAction")
local v12 = { WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntNightAgent") }

function DitherIn(object)
	object:__wf_atom_68f2c268(1)
	local v13 = 1

	while not __wf_atom_7e8ad928(object) and v13 > 0 do
		v13 = __wf_atom_421b01aa(v13 - __wf_atom_084b3e93() / 2, 0, 1)
		object:__wf_atom_68f2c268(__wf_atom_24a82b69(v13))
		Sleep(0)
	end
end

function OnKilled(_) end

local function fn(instance)
	local __wf_atom_50a7d83e = instance:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_55142dd4(__wf_atom_50a7d83e, "OnKilled")
		__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("DitherIn"), false)
		instance:__wf_atom_30b587a4()
		local flag2 = false

		for _, className in ipairs(v12) do
			if instance:IsA(className) then
				flag2 = true
			end
		end

		if __wf_atom_7e8ad928(__wf_atom_bb3e7833s[v9]) then
			instance:StormTarget(v3, 15)
		elseif flag2 then
			instance:__wf_atom_aa4361c1(v11, __wf_atom_bb3e7833s[v9], 1.5)
		else
			instance:StormTarget(__wf_atom_bb3e7833s[v9], 8)
		end

		print("Spawned " .. __wf_atom_50a7d83e:__wf_atom_5b41f63b())
	end
end

local function fn2()
	local v13

	if module.IsInOverworld() then
		v13 = module2.GetEnemyLevel(v2, true)
	else
		local __wf_atom_57203011 = v:__wf_atom_57203011()
		v13 = Range(__wf_atom_57203011, __wf_atom_57203011)
	end

	return (Range(v13.maxValue, v13.maxValue + #v8))
end

local function fn3()
	local position2 = position

	if #entities > 0 and not __wf_atom_7e8ad928(entities[v9]) then
		position2 = entities[v9]:GetPosition()
	end

	local spawnDistanceFromTarget = spawnDistanceFromTarget
	local __wf_atom_28ce676a = v:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position2, spawnDistanceFromTarget, 4)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(60)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("WaveSpawnQuery"), Color("0x00FFFF"))
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v13 in ipairs(__wf_atom_ef7900cf) do
		local position3 = v13:GetPosition()
		__wf_atom_28ce676a:__wf_atom_0f52bdf4(
			position3,
			Range(0, spawnDistanceFromTarget.minValue),
			-1,
			0.4,
			1,
			1,
			false
		)
		__wf_atom_28ce676a:__wf_atom_60113517(position3, 2, 0.05, 1)
	end

	local positions = module4.GetPositions(3, __wf_atom_28ce676a)

	if __wf_atom_7e8ad928(positions) or not (#positions > 0) then
		return (v:GetRandomPointInRangeOnNav(position, 30, spawnDistanceFromTarget.maxValue, true, 0.5))
	end

	return positions[__wf_atom_5784a397(1, #positions)]
end

local function fn4(p)
	for i = #v4, 1, -1 do
		if not (__wf_atom_7e8ad928(v4[i]) or v4[i]:__wf_atom_4026dfb5() >= 3) then
			continue
		end

		table.remove(v4, i)
	end

	local flag2 = false
	local v13 = math.max(
		math.min(gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients"), 3),
		1
	)
	local v14 = v8[v13]

	if v5 == 0 then
		if #v4 == 0 and total >= waveInterval and module.AnyPlayerNearPos(position, 15, true) then
			v5 = 1
			v6 = 1
			flag2 = true
		else
			total += p
		end
	elseif not __wf_atom_7e8ad928(v14[v5]) then
		if v6 < #v14[v5] and #v4 < maxSimultaneousSquadsPerPlayer[v13] then
			if (total >= reinforceInterval or total >= waveInterval and #v4 == 0) and v6 < #v14[v5] and #v4 < 3 then
				v6 += 1
				flag2 = true
			else
				total += p
			end
		elseif #v4 == 0 and v6 >= #v14[v5] then
			if v5 >= #v14 then
				flag = true
				return
			end

			if total2 >= waveInterval or v5 % 2 == 1 and total2 >= waveInterval then
				v5 += 1
				v6 = 1
				flag2 = true
			else
				total2 += p
			end
		end
	end

	if flag2 then
		total = 0
		total2 = 0

		if #__wf_atom_bb3e7833s > 0 then
			local v15 = {}

			for i = 1, #__wf_atom_bb3e7833s do
				if i ~= v9 then
					table.insert(v15, i)
				end
			end

			v9 = v15[__wf_atom_5784a397(1, #v15)]
		end

		local v15 = fn2().minValue + v5 - 1
		v2:__wf_atom_252fae6e(v15)
		print("New enemy squad: " .. v5 .. "-" .. v6)
		local v16 = v14[v5][v6]

		if __wf_atom_7e8ad928(v16) then
			print("No encounter type!")
		else
			print("Encounter type: " .. v16:__wf_atom_5b41f63b())
			local v17 = fn3()
			v:AddEncounter(v16)
			local __wf_atom_c4c644af = v:__wf_atom_c4c644af(v17, v16, v2)

			if __wf_atom_7e8ad928(__wf_atom_c4c644af) then
				print("Failed to spawn encounter!")
				return
			end

			__wf_atom_c4c644af:__wf_atom_c361f7f8(fn, Symbol("WaveEnemyRegister"))
			table.insert(v4, __wf_atom_c4c644af)
		end
	end
end

local function fn5(object)
	v = module.WaitForAiDir()
	v2 = object:__wf_atom_26b04ea9()
	v7 = v2:__wf_atom_103377cc()
	position = v2:GetPosition()
	v3 = object
	v8 = {}
	local v13 = { waveCompositionOnePlayer, waveCompositionTwoPlayers, waveCompositionThreePlayers }

	for i = 1, #v13 do
		local v14

		if #v13[i] == 0 and i > 1 then
			v14 = i

			for j = i - 1, 1, -1 do
				if not (#v13[j] > 0) then
					continue
				end

				v14 = j
				break
			end
		else
			v14 = i
		end

		v8[v14] = {}

		for _, v15 in ipairs(v13[v14]) do
			local encounterTypes2 = {}
			tostring(v15):gsub("[^,]+", function(p)
				local encounterType = encounterTypes[tonumber(p) + 1]

				if not __wf_atom_7e8ad928(encounterType) then
					table.insert(encounterTypes2, encounterType)
				end
			end)

			if #encounterTypes2 > 0 then
				table.insert(v8[v14], encounterTypes2)
			end
		end
	end

	if __wf_atom_7e8ad928(v2) then
		v2 = object
	end

	if object:__wf_atom_4026dfb5() <= 1 then
		object:__wf_atom_8e6fec76(1)

		if module2.WaitForParentEncounterActive(object) then
			local v14 = fn2()
			v2:__wf_atom_252fae6e(v14.minValue)

			if #v4 == 0 and not __wf_atom_7e8ad928(guardWave) then
				if v2:__wf_atom_3634e6d2() > 0 then
					table.insert(v4, v2)
				else
					v:AddEncounter(guardWave)
					local __wf_atom_c4c644af = v:__wf_atom_c4c644af(position, guardWave, v2)
					table.insert(v4, __wf_atom_c4c644af)
				end
			end

			print("Setup completed")
		else
			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_8e6fec76(6)
			end

			print("Failed to start encounter")
		end
	else
		local __wf_atom_e529dedd = v2:__wf_atom_e529dedd()

		for _, v14 in ipairs(__wf_atom_e529dedd) do
			if v14 ~= object then
				table.insert(v4, v14)
			end
		end

		print("Host migrated")
		return true
	end
end

local function fn6(object)
	if __wf_atom_7e8ad928(defenseTargetType) then
		return
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(defenseTargetSpawnTag, position, 0, 100)

	if module.IsInOverworld() then
		local layerIndex = module.GetLayerIndex(v3)

		if not __wf_atom_7e8ad928(layerIndex) then
			__wf_atom_439c0d29 = module.FilterObjectsInLayerIndex(layerIndex, __wf_atom_439c0d29)
		end
	end

	local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa

	for i = 1, defenseTargetCount do
		local randomPointInRangeOnNav, v13

		if __wf_atom_7e8ad928(__wf_atom_439c0d29[i]) then
			randomPointInRangeOnNav = v:GetRandomPointInRangeOnNav(position, 0, v7, true, 0.5)
			v13 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
		else
			randomPointInRangeOnNav = __wf_atom_439c0d29[i]:GetPosition()
			v13 = __wf_atom_439c0d29[i]:__wf_atom_dc309f8a()
			__wf_atom_439c0d29[i]:FirePort("Disable")
		end

		local entity = gRegion:CreateEntity(defenseTargetType, randomPointInRangeOnNav, v13)
		table.insert(entities, entity)
		object:__wf_atom_d494454b(entity)
		__wf_atom_28d5d4aa += randomPointInRangeOnNav
		local __wf_atom_bb3e7833 = entity:__wf_atom_bb3e7833(__wf_atom_0f45538d)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			table.insert(__wf_atom_bb3e7833s, __wf_atom_bb3e7833)
		end
	end

	if not __wf_atom_7e8ad928(spiritAnimalType) then
		local v13 = __wf_atom_28d5d4aa / defenseTargetCount
		local __wf_atom_0e0a6fee = v:__wf_atom_0e0a6fee(v13)
		local __wf_atom_402b3832 = v:__wf_atom_402b3832(
			spiritAnimalType,
			__wf_atom_0e0a6fee,
			Rotation(__wf_atom_5784a397(0, 360), 0, 0),
			Symbol("Bunny"),
			1
		)
		v3:__wf_atom_97f955c1(__wf_atom_402b3832)
		v10 = __wf_atom_402b3832:__wf_atom_50a7d83e()
	end
end

local function fn7(object)
	print("Wave encounter ending...")
	Sleep(2)

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to streaming (Ended)")
		return
	end

	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 4 or __wf_atom_4026dfb5 == 5 then
		if __wf_atom_4026dfb5 == 4 then
			print("Succeeded")
			module3.CompleteHudTask(object)
		else
			print("Failed")
		end

		Sleep(4)

		if __wf_atom_7e8ad928(object) then
			print("Shutdown due to streaming (Completed or Failed)")
			return
		else
			object:__wf_atom_8e6fec76(__wf_atom_4026dfb5)
			module3.RemoveHudGroup(object)
		end
	else
		print("Shutdown")
		module3.RemoveHudGroup(v2)
		object:__wf_atom_8e6fec76(6)
	end

	print("Waves encounter ended")
end

function OnPrimed(object)
	module.WaitForLevel()
	v = module.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Streaming at start of OnPrimed")
		return
	end

	if object:__wf_atom_4026dfb5() > 0 then
		return
	end

	if not module.IsInOverworld() then
		local layerIndex = module.GetLayerIndex(object)

		if not __wf_atom_7e8ad928(layerIndex) then
			local v13 = WeakResource("/SF/Types/Game/Encounters/Ode/Hints/InteriorCombatEncounterHint")
			local all = gRegion:FindAll(v13, object:GetPosition(), 0, 50)
			local filterObjectsInLayerIndex = module.FilterObjectsInLayerIndex(layerIndex, all)

			for _, v14 in ipairs(filterObjectsInLayerIndex) do
				if v14 ~= object then
					v14:Disable()
				end
			end
		end
	end
end

function BasicWaveEncounter(object)
	print("Wave encounter started")

	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	fn5(object)
	object:__wf_atom_8e6fec76(2)

	while not module2.PrimedMissionShouldShutDown(object, v2, nil, nil, false) do
		fn4(__wf_atom_03df4e1d())

		if flag then
			object:__wf_atom_8e6fec76(4)
			break
		end

		if v:__wf_atom_c6f505f2(object) > 0 then
			module3.UpdateVisibility(true)
		end

		Sleep(0)
	end

	fn7(object)
end

function SpiritDefenseEncounter(object)
	print("Wave encounter started")

	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	fn5(object)
	fn6(object)
	object:__wf_atom_8e6fec76(2)
	_T.DrainBunny = nil

	while not module2.PrimedMissionShouldShutDown(object, v2, nil, nil, false) do
		fn4(__wf_atom_03df4e1d())

		for i = #entities, 1, -1 do
			if not (__wf_atom_7e8ad928(entities[i]) or entities[i]:__wf_atom_c6f1f83d() <= 0) then
				continue
			end

			table.remove(entities, i)
		end

		if flag then
			object:__wf_atom_8e6fec76(4)
			break
		end

		local _drainBunny = _T.DrainBunny

		if v:__wf_atom_c6f505f2(object) > 0 then
			module3.UpdateVisibility(true)
		end

		Sleep(0)
	end

	fn7(object)
end

function NpcIgniteAction(object, instance)
	if __wf_atom_7e8ad928(instance) or instance:IsKilled() or not instance:IsA(__wf_atom_9e85eea2) then
		return
	end

	object:Disable()

	if not __wf_atom_7e8ad928(igniteAnim) then
		instance:__wf_atom_921c1a5f(igniteAnim, true, 2, 1, true)
	end

	if __wf_atom_7e8ad928(instance) or instance:IsKilled() or instance:__wf_atom_1c8f7b2d(object) >= 2 then
		object:Enable()
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local v13

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		v13 = __wf_atom_3d96ddcd:Attach(fireAttachment, EMPTY_SYMBOL, Vector(0, 0.5, 0))
	end

	_T.DrainBunny = true
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("SpectralAnimal"), object:GetPosition(), 0, 50)
	local position2 = object:GetPosition()

	while
		not __wf_atom_7e8ad928(__wf_atom_f738b4af)
		and not __wf_atom_7e8ad928(object)
		and not __wf_atom_7e8ad928(instance)
		and not instance:IsKilled()
		and instance:__wf_atom_1c8f7b2d(object) <= 2
	do
		gRegion:__wf_atom_c189a462(
			position2 + Vector(0, 2, 0),
			__wf_atom_f738b4af:GetPosition() + Vector(0, 2, 0),
			Color(100, 100, 255),
			0
		)
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		_T.DrainBunny = nil
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		local v14 = __wf_atom_3d96ddcd:__wf_atom_95174740() / 2

		if not (__wf_atom_3d96ddcd:__wf_atom_c6f1f83d() - v14 <= 0) then
			if not __wf_atom_7e8ad928(v13) then
				v13:Destroy()
			end

			Sleep(20)

			if not __wf_atom_7e8ad928(object) then
				object:Enable()
			end
		end
	end

	_T.DrainBunny = nil
end