local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Scripts.Libs.ObjectiveHudLib")
local v = Symbol("Neutral")
local v2 = Symbol("TENNO")
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local __wf_atom_50a7d83es = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil

local function fn()
	local v14 = math.max(v4:__wf_atom_103377cc(), v8)

	if resizeMarkerAroundEnemies then
		for _, v15 in ipairs(__wf_atom_50a7d83es) do
			v14 = math.max(v15:__wf_atom_1c8f7b2d(v4) + 5, v14)
		end
	end

	local __wf_atom_fe00d825 = v4:__wf_atom_fe00d825()

	for _, v15 in ipairs(__wf_atom_fe00d825) do
		if not v15:IsA(__wf_atom_0f520c3c) then
			continue
		end

		v15:__wf_atom_400189c4(v14)
		break
	end
end

local function fn2(object)
	if not __wf_atom_7e8ad928(soulModeAttachType) then
		object:Attach(soulModeAttachType, EMPTY_SYMBOL)
	end

	__wf_atom_55142dd4(object, "OnKilled")
	__wf_atom_55142dd4(object, "OnFactionChanged")
	module3.AddSparrowDestination(object, v4, nil, module3.PRIORITY.HIGH, Range(6, v4:__wf_atom_103377cc() * 2))
end

local function fn3(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6199ef01 = object:__wf_atom_6199ef01()

	for _, v14 in ipairs(__wf_atom_6199ef01) do
		local __wf_atom_50a7d83e = v14:__wf_atom_50a7d83e()

		if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			continue
		end

		fn2(__wf_atom_50a7d83e)
		table.insert(__wf_atom_50a7d83es, __wf_atom_50a7d83e)
	end

	if #__wf_atom_50a7d83es > 0 and not __wf_atom_7e8ad928(__wf_atom_50a7d83es[1]) then
		v12 = __wf_atom_50a7d83es[1]:__wf_atom_e93896ba()
	end

	v5 = #__wf_atom_50a7d83es
end

local function fn4()
	v10 = v10 or v5

	for i = #__wf_atom_50a7d83es, 1, -1 do
		if __wf_atom_7e8ad928(__wf_atom_50a7d83es[i]) or __wf_atom_50a7d83es[i]:IsKilled() then
			table.remove(__wf_atom_50a7d83es, i)
		end
	end

	local __wf_atom_e0730826 = v3:__wf_atom_e0730826(v4, v8, true)

	for _, v14 in ipairs(__wf_atom_e0730826) do
		local __wf_atom_50a7d83e = v14:__wf_atom_50a7d83e()
		local __wf_atom_e93896ba = __wf_atom_50a7d83e:__wf_atom_e93896ba()

		if
			__wf_atom_50a7d83e:IsKilled()
			or not __wf_atom_50a7d83e:IsA(__wf_atom_9e85eea2)
			or __wf_atom_e93896ba == v
			or __wf_atom_e93896ba == v2
		then
			continue
		end

		if not (v12 == nil or v12 == EMPTY_SYMBOL or __wf_atom_e93896ba == v12) then
			continue
		end

		local v15 = false

		for _, v16 in ipairs(__wf_atom_50a7d83es) do
			if v16 ~= __wf_atom_50a7d83e then
				continue
			end

			v15 = true
			break
		end

		if v15 or not (__wf_atom_50a7d83e:__wf_atom_1c8f7b2d(v4) <= v8) then
			continue
		end

		print("Added tracking to avatar " .. __wf_atom_50a7d83e:GetName())
		fn2(__wf_atom_50a7d83e)
		table.insert(__wf_atom_50a7d83es, __wf_atom_50a7d83e)
	end

	for i = #__wf_atom_50a7d83es, 1, -1 do
		local __wf_atom_30e3d82b = __wf_atom_50a7d83es[i]:__wf_atom_30e3d82b()

		if
			__wf_atom_7e8ad928(__wf_atom_30e3d82b)
			or __wf_atom_30e3d82b:__wf_atom_76724198() == v4
			or __wf_atom_50a7d83es[i]:__wf_atom_1c8f7b2d(v4) <= v8
		then
			continue
		end

		print("Removing tracking to avatar " .. __wf_atom_50a7d83es[i]:GetName())
		local v14 = __wf_atom_50a7d83es[i]

		if not __wf_atom_7e8ad928(soulModeAttachType) then
			v14:__wf_atom_0650fed7(soulModeAttachType)
		end

		module3.RemoveSparrowDestination(v14)
		table.remove(__wf_atom_50a7d83es, i)
		v5 -= 1
	end

	if not v9 then
		v5 = math.max(v5, #__wf_atom_50a7d83es)
	end

	if v10 ~= v5 then
		fn()
	end
end

function OnKilled(object)
	local v14 = false

	for i = #__wf_atom_50a7d83es, 1, -1 do
		if not (__wf_atom_7e8ad928(__wf_atom_50a7d83es[i]) or __wf_atom_50a7d83es[i] == object) then
			continue
		end

		table.remove(__wf_atom_50a7d83es, i)
		v14 = true
	end

	if not v14 then
		return
	end

	v9 = true
	v6 += 1
	print("Enemies killed: " .. v6 .. " / " .. v5)

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_55597fe3 = object:__wf_atom_7470861b():__wf_atom_55597fe3()

		if not (__wf_atom_7e8ad928(__wf_atom_55597fe3) or __wf_atom_7e8ad928(__wf_atom_55597fe3:__wf_atom_679ed446())) then
			print("Killed by " .. __wf_atom_55597fe3:__wf_atom_679ed446():GetName())
		end
	end
end

function OnFactionChanged(object)
	if not __wf_atom_7e8ad928(object) and object:__wf_atom_e93896ba() == Symbol("Neutral") then
		OnKilled(object)
	end
end

function Main(object)
	print("Clear camp encounter started")
	v3 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	while not v3:__wf_atom_5e711c72() do
		Sleep(0)
	end

	v6 = 0
	v7 = 0
	v5 = 0
	__wf_atom_50a7d83es = {}
	v4 = object:__wf_atom_26b04ea9()
	v11 = false

	if __wf_atom_7e8ad928(v4) then
		print("Nil parent hint (1)")
		return
	end

	object:__wf_atom_8e6fec76(1)

	if removeCombatFromParentHint or module2.WaitForParentEncounterActive(object) then
		local v14 = false
		local v15

		if #requiredStrongPointHints > 0 then
			v15 = true

			for _, className in ipairs(requiredStrongPointHints) do
				if not v4:IsA(className) then
					continue
				end

				v15 = false
				break
			end
		else
			v15 = false
		end

		if v15 or dynamicOnly then
			print("Starting dynamic encounter since this isn't a strong-point hint")
			local dynamicCombatEncounterType = dynamicCombatEncounterTypes[__wf_atom_5784a397(1, #dynamicCombatEncounterTypes)]
			v3:AddEncounter(dynamicCombatEncounterType)
			v13 = v3:__wf_atom_c4c644af(object:GetPosition(), dynamicCombatEncounterType, v4)

			while not __wf_atom_7e8ad928(v13) and v13:__wf_atom_4026dfb5() <= 1 do
				Sleep(0.5)
			end

			if __wf_atom_7e8ad928(v13) then
				print("Dynamic encounter is nil!")
			else
				print("Done starting dynamic encounter")
			end

			fn3(v13)
		else
			while not __wf_atom_7e8ad928(v4) and v4:__wf_atom_4026dfb5() == 1 do
				Sleep(0.5)
			end

			if __wf_atom_7e8ad928(v4) then
				print("Nil parent hint (2)")
				return
			end

			fn3(v4)

			if v5 == 0 or v4:__wf_atom_4026dfb5() == 4 then
				print("0 enemy count!")
				Sleep(3)
				v14 = true

				if __wf_atom_7e8ad928(object) then
					return
				else
					object:__wf_atom_8e6fec76(4)
				end
			end
		end

		if __wf_atom_7e8ad928(object) then
			print("Nil hint")
			return
		end

		v8 = math.min(enemySearchRadius, v4:__wf_atom_103377cc() + 20)
		fn4()
		fn()
		module4.UpdateOrAddHudTask(object)
		object:__wf_atom_8e6fec76(2)
		local total = 0
		local v16 = false

		while not (module2.PrimedMissionShouldShutDown(object, v4) or v14) do
			if total >= 3 then
				fn4()
				local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
				local flag = false

				for _, v17 in ipairs(__wf_atom_ef7900cf) do
					for _, v18 in ipairs(__wf_atom_50a7d83es) do
						if not (v17:__wf_atom_1c8f7b2d(v18) <= 60) then
							continue
						end

						flag = true
						break
					end

					if not flag then
						continue
					end

					module4.UpdateVisibility(true)
					break
				end

				total = 0
			else
				total += __wf_atom_084b3e93()
			end

			if v6 ~= v7 then
				if showCounter then
					module4.UpdateOrAddHudCounterTask(object, nil, nil, v6, v5)
				end

				v7 = v6

				if v5 > 0 and v5 <= v6 then
					print("Completed, no enemies remaining")
					object:__wf_atom_8e6fec76(4)
					break
				elseif not v16 and v5 >= 3 and v6 >= math.ceil(v5 * 0.666) then
					local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

					for _, v17 in ipairs(__wf_atom_50a7d83es) do
						if __wf_atom_7e8ad928(v17) or v17:IsKilled() then
							continue
						end

						local nearestObject = module.NearestObject(v17:GetPosition(), __wf_atom_ef7900cf, 15)
						local __wf_atom_30e3d82b = v17:__wf_atom_30e3d82b()

						if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
							__wf_atom_30e3d82b:StormTarget(nearestObject)
						end
					end

					v16 = true
				end
			end

			if showCounter or __wf_atom_7e8ad928(v13) or v13:__wf_atom_4026dfb5() ~= 4 then
				if v11 and _T.DebugDrawDailyLocations then
					local v17 = v4:GetPosition() + Vector(0, 20, 0)

					for _, v18 in ipairs(__wf_atom_50a7d83es) do
						if not __wf_atom_7e8ad928(v18) then
							gRegion:__wf_atom_628723a6(v17, v18:GetPosition(), Color(0, 255, 0), 0)
						end
					end
				end

				if object:__wf_atom_4026dfb5() == 4 then
					break
				else
					Sleep(0)
				end
			else
				print("Dynamic encounter completed")
				object:__wf_atom_8e6fec76(4)
				break
			end
		end

		if __wf_atom_7e8ad928(object) then
			return
		end

		if object:__wf_atom_4026dfb5() == 4 then
			print("Npc.ES_SUCCEEDED")
			v6 = v5

			if not v14 and showCounter then
				module4.UpdateOrAddHudCounterTask(object, nil, nil, v6, v5)
			end

			module4.CompleteHudTask(object)
			Sleep(4)

			if __wf_atom_7e8ad928(object) then
				return
			end
		else
			print("Npc.ES_SHUTDOWN")
			object:__wf_atom_8e6fec76(6)
		end

		for _, v17 in ipairs(__wf_atom_50a7d83es) do
			if __wf_atom_7e8ad928(v17) or v17:IsKilled() then
				continue
			end

			local __wf_atom_bb3e7833 = v17:__wf_atom_bb3e7833(soulModeAttachType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end

		print("Clear camp encounter ended")
		module4.RemoveHudGroup(object)
		module2.RemoveAgents(object)
	else
		if not __wf_atom_7e8ad928(object) then
			print("Hint shut down early")
			object:__wf_atom_8e6fec76(6)
		end

		print("Early out, wait for active parent hint failed")
	end
end

function EncounterOnPrimed(object)
	if boostParentHintEnemyCount then
		module2.SetEncounterBoostEnemies(object, true)
		module2.EnableFortificationHints(object)
	end

	if removeCombatFromParentHint then
		local __wf_atom_19688c5e = object:__wf_atom_19688c5e()

		for _, v14 in ipairs(__wf_atom_19688c5e) do
			object:__wf_atom_61860938(v14)
		end
	end
end