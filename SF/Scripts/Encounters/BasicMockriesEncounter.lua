local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("Lotus.Scripts.Libs.Query")
local module5 = require("EE.Interface.Utilities")
local v = Symbol("RandomTeam")
local v2 = nil
local position = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = 0
local count = 0
local v8 = 0
local v9 = 0

local function fn(p, p2)
	local __wf_atom_28ce676a = v2:__wf_atom_28ce676a()

	if p2 == 1 then
		__wf_atom_28ce676a:__wf_atom_267bfc41(v3:GetPosition(), Range(v6, v5), 2)
	elseif p2 == 2 then
		__wf_atom_28ce676a:__wf_atom_267bfc41(v3:GetPosition(), Range(5, 15), 2.5)
		print("WARNING - Mockery Encounter: Hint did not provide enough non-sloped space to spawn husks, attempting a larger range (5m-15m) with no road filter.")
	else
		__wf_atom_28ce676a:__wf_atom_267bfc41(v3:GetPosition(), Range(5, 20), 2.5)
		print("WARNING - Mockery Encounter: Hint did not provide enough non-sloped space to spawn husks, attempting another larger range (5m-20m) with no road filter.")
	end

	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -10)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(20)
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_c9dbb0ae(Range(0.5, 10), -1, 1, 1, 0, false)
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)

	if p2 == 1 then
		__wf_atom_28ce676a:__wf_atom_09d2b44e(false)
	end

	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("HuskSpawn"), Color("0x873260"))
	return module4.GetPositions(p, __wf_atom_28ce676a)
end

local function fn2(ternary)
	v7 = math.round(ternary * 0.5)
	local v10 = ternary + v7
	local v11 = nil
	local v12 = 1

	while __wf_atom_7e8ad928(v11) and v12 <= 3 do
		v11 = fn(v10, v12)
		v12 += 1
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v11) or #v11 <= 0 then
		print("ERROR - Mockery Encounter: Hint is placed such that even 2 attempts to increase query radius for husks failed, encounter will end as a result.")
		return
	end

	if #v11 < v10 then
		if #v11 <= 3 then
			v10 = 3
			v7 = 0
		else
			v10 = #v11 - 2
			v7 = 2
		end

		print("WARNING - Mockery Encounter: Hint did not provide enough non-sloped space to spawn as many Mockeries as this encounter desired.")
	end

	module5.ShuffleTable(v11)
	local count2 = 0
	local count3 = 0
	local v13 = {}

	for _ = 1, v10 - v7 do
		if count2 < v8 and not __wf_atom_7e8ad928(armoredMockeryHusk) then
			table.insert(v13, { type = armoredMockeryHusk, bArmored = true })
			count2 += 1
		elseif count3 < v9 and not __wf_atom_7e8ad928(spellcasterMockeryHusk) then
			table.insert(v13, { type = spellcasterMockeryHusk, bSpellcaster = true })
			count3 += 1
		elseif __wf_atom_7e8ad928(unarmoredMockeryHusk) then
			print("ERROR - Mockery Encounter: Requested Mockery Husks, but NO husk types were populated.")
		else
			table.insert(v13, { type = unarmoredMockeryHusk })
		end
	end

	if #v13 <= 0 then
		print("ERROR - Mockery Encounter: Improperly provided data, no husks spawned.")
		return
	end

	module5.ShuffleTable(v13)

	for _ = 1, v7 do
		local v14 = __wf_atom_5784a397(1, 2)

		if v14 == 1 then
			table.insert(v13, { type = armoredMockeryHusk })
		elseif v14 == 2 then
			table.insert(v13, { type = unarmoredMockeryHusk })
		end
	end

	local v14 = nil
	local v15 = 0

	for i = 1, #v13 do
		if __wf_atom_7e8ad928(v11[i]) or __wf_atom_7e8ad928(v13[i]) then
			continue
		end

		local kind = v13[i].type
		local v16 = v11[i]
		local v17 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)

		if spawnFacingEncounterHint then
			v17 = __wf_atom_fa8d0177(v16, position)
			local v18 = __wf_atom_5784a397(-45, 45)
			v17.heading += v18
		end

		local groundAlignedSpawnPosRot, v18 = module3.GetGroundAlignedSpawnPosRot(kind, v16, v17)

		if
			__wf_atom_7e8ad928(groundAlignedSpawnPosRot)
			or not module3.ObjTypeHasHeightClearance(kind, groundAlignedSpawnPosRot)
		then
			continue
		end

		local entity = gRegion:CreateEntity(kind, groundAlignedSpawnPosRot, v18)
		v3:__wf_atom_d494454b(entity)

		if not (i <= v10 - v7) then
			continue
		end

		local __wf_atom_e919fb8e = entity:__wf_atom_e919fb8e()
		count += 1

		if v13[i].bArmored then
			if __wf_atom_7e8ad928(v14) then
				v14 = {}

				for j = 1, #__wf_atom_e919fb8e.mockeryAgentTypes do
					table.insert(v14, j)
				end

				module5.ShuffleTable(v14)
				v15 = 1
			end

			__wf_atom_e919fb8e.bbForcedAgentIndex = v14[v15]
			local v19 = v15 + 1
			v15 = #v14 < v19 and 1 or v19
			__wf_atom_e919fb8e.bbForcedSpiritIndex = 1
		elseif v13[i].bSpellcaster then
			__wf_atom_e919fb8e.bbForcedSpiritIndex = 2
		else
			__wf_atom_e919fb8e.bbForcedSpiritIndex = 1
		end
	end
end

local function fn3(p)
	if not __wf_atom_7e8ad928(v3) then
		v4 = v3:__wf_atom_6199ef01()
		module.CleanUpOutOfRangeEnemies(v3, v4)
	end

	if #v4 > 0 or __wf_atom_7e8ad928(v3) then
		return
	end

	local __wf_atom_fe00d825 = v3:__wf_atom_fe00d825()

	if __wf_atom_7e8ad928(__wf_atom_fe00d825) or #__wf_atom_fe00d825 <= 0 then
		return
	end

	local v10 = Range(0.1, 0.4)
	local enemyLevel = module.GetEnemyLevel(v3)
	local __wf_atom_2b1fe281 = v3:__wf_atom_2b1fe281()
	local count2 = 0

	for i = 1, p do
		local bbForcedHusk = __wf_atom_fe00d825[i]

		if not __wf_atom_7e8ad928(bbForcedHusk) then
			local __wf_atom_e919fb8e = bbForcedHusk:__wf_atom_e919fb8e()

			if
				not __wf_atom_7e8ad928(__wf_atom_e919fb8e)
				and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbMockerySpiritAgentTypes)
				and #__wf_atom_e919fb8e.bbMockerySpiritAgentTypes > 0
			then
				local v11

				if
					__wf_atom_7e8ad928(__wf_atom_e919fb8e.bbForcedSpiritIndex)
					or __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbMockerySpiritAgentTypes[__wf_atom_e919fb8e.bbForcedSpiritIndex])
				then
					v11 = __wf_atom_e919fb8e.bbMockerySpiritAgentTypes[__wf_atom_5784a397(
						1,
						#__wf_atom_e919fb8e.mockerySpiritAgentTypes
					)]
				else
					v11 = __wf_atom_e919fb8e.bbMockerySpiritAgentTypes[__wf_atom_e919fb8e.bbForcedSpiritIndex]
				end

				if __wf_atom_7e8ad928(v11) then
					print("ERROR - Mockery Encounter: Couldn't find enemy type to spawn!")
				else
					local v12 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
					local v13 = bbForcedHusk:GetPosition() - position
					local v14 = math.max(Length(v13), v6 + math.random() * (v5 - v6))
					Normalize(v13)
					local v15 = position + v14 * v13
					local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(v15, 2, 5)
					local v16 = __wf_atom_fa8d0177(__wf_atom_0e0a6fee, position)
					local v17 = Rotation(v16.heading, 0, 0)

					if not __wf_atom_7e8ad928(__wf_atom_0e0a6fee) then
						local __wf_atom_402b3832 = v2:__wf_atom_402b3832(v11, __wf_atom_0e0a6fee, v17, v, v12)

						if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
							local __wf_atom_e919fb8e_2 = __wf_atom_402b3832:__wf_atom_50a7d83e():__wf_atom_e919fb8e()
							__wf_atom_e919fb8e_2.bbForcedHusk = bbForcedHusk
							__wf_atom_e919fb8e.bbReservedSpirit = __wf_atom_402b3832
							v3:__wf_atom_97f955c1(__wf_atom_402b3832)
							count2 += 1

							if __wf_atom_2b1fe281 > 0 and __wf_atom_2b1fe281 <= count2 then
								break
							end
						end
					end
				end
			end
		end

		if i < p then
			Sleep(__wf_atom_104bfe98(v10.minValue, v10.maxValue, math.random()))
		end

		if module.ShouldShutDown(v3) then
			break
		end
	end
end

function Start(object)
	v2 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Mockery Encounter: Shutdown due to level streaming")
		return
	end

	v3 = object
	position = object:GetPosition()
	v5 = object:__wf_atom_103377cc()

	if dynamicSpawnRandomRadius.minValue > 0 and dynamicSpawnRandomRadius.maxValue > 0 then
		v5 = __wf_atom_5784a397(dynamicSpawnRandomRadius.minValue, dynamicSpawnRandomRadius.maxValue)
	end

	v6 = math.floor(v5 / 3)
	v3:__wf_atom_8e6fec76(1)
	local v10 = math.min(gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients"), 3) > 2
	local ternary = module5.Ternary(
		v10,
		__wf_atom_5784a397(spawnCountHigh.minValue, spawnCountHigh.maxValue),
		__wf_atom_5784a397(spawnCountLow.minValue, spawnCountLow.maxValue)
	)

	if not __wf_atom_7e8ad928(armoredMockeryHusk) then
		v8 = module5.Ternary(
			v10,
			__wf_atom_5784a397(armoredToSpawnHigh.minValue, armoredToSpawnHigh.maxValue),
			__wf_atom_5784a397(armoredToSpawnLow.minValue, armoredToSpawnLow.maxValue)
		)
	end

	if not __wf_atom_7e8ad928(spellcasterMockeryHusk) then
		v9 = module5.Ternary(
			v10,
			__wf_atom_5784a397(maxSpellcastersHigh.minValue, maxSpellcastersHigh.maxValue),
			__wf_atom_5784a397(maxSpellcastersLow.minValue, maxSpellcastersLow.maxValue)
		)
	end

	fn2(ternary)

	if count == 0 then
		v3:__wf_atom_8e6fec76(6)
		return
	end

	Sleep(0.5)
	fn3(math.min(count, ternary))

	if not __wf_atom_7e8ad928(v3) then
		v4 = v3:__wf_atom_6199ef01()
		module.CleanUpOutOfRangeEnemies(v3, v4)
	end

	module2.StartPluginScripts(pluginScripts, object)

	if __wf_atom_7e8ad928(v3) then
		print("Mockery Encounter: Shutdown due to level streaming")
		return
	end

	v3:__wf_atom_8e6fec76(2)
	local total = 0

	while not module.ShouldShutDown(v3) and v3:__wf_atom_3634e6d2() > 0 do
		if not __wf_atom_7e8ad928(v3) then
			v4 = v3:__wf_atom_6199ef01()
			module.CleanUpOutOfRangeEnemies(v3, v4)
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v3) then
		print("Mockery Encounter: Shutdown due to level streaming")
		return
	end

	if module.ShouldShutDown(v3) then
		v3:__wf_atom_8776856a(#v4)
		module.RemoveAgents(v3)
		v3:__wf_atom_8e6fec76(6)
	else
		v3:__wf_atom_050639fe()
		v3:__wf_atom_8776856a(0)
		v3:__wf_atom_8e6fec76(4)

		if not module2.IsInOverworld() then
			v3:Disable()
		end
	end

	while not __wf_atom_7e8ad928(v3) and v3:__wf_atom_e464a32f() > 0 and v2:__wf_atom_c6f505f2(v3) > 0 do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v3) then
		print("Mockery Encounter: Shutdown due to level streaming")
		return
	end

	module.RemoveAgents(v3)
	module.RemoveObjects(v3)
	Sleep(0)
end

function AdjustLevelOfSPawnedAgentUsingRegion(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
	local enemyLevel = module.GetEnemyLevel(__wf_atom_50a7d83e, true)
	__wf_atom_50a7d83e:SetLevel((__wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)))
	__wf_atom_50a7d83e:SetHealth(__wf_atom_50a7d83e:GetMaxHealth())
end