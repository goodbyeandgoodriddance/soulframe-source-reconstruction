local module = require("EE.Interface.Utilities")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("Lotus.Interface.Libs.TimerMgr")
local module4 = require("SF.Scripts.Libs.EncounterLib")
local v = WeakResource("/SF/Types/Player/Ghost/SfSparrowGhostAvatar")
local module5 = require("Lotus.Scripts.Libs.Query")
local v2 = Symbol("ArenaSpec")
local v3 = {
	{
		Tier = 0,
		MaxSim = 2,
		Total = 4,
		Heavies = 0,
		HeavySpawn = 0
	},
	{
		Tier = 1,
		MaxSim = 3,
		Total = 6,
		Heavies = 0,
		HeavySpawn = 0
	},
	{
		Tier = 1,
		MaxSim = 3,
		Total = 6,
		Heavies = 0,
		HeavySpawn = 3
	},
	{
		Tier = 2,
		MaxSim = 4,
		Total = 8,
		Heavies = 0,
		HeavySpawn = 4
	},
	{
		Tier = 3,
		MaxSim = 3,
		Total = 3,
		Heavies = 2,
		HeavySpawn = 0
	}
}
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local modeState = 1
local v9 = nil
local v10 = false
local maxValue = 0
local v11 = nil
local v12 = 0
local count = 0
local count2 = 0
local count3 = 0
local v13 = 0
local v14 = 0
local v15 = {}
local v16 = {}
local heavies = 0
local count4 = 0
local v17 = nil
local v18 = {}

local function fn()
	for _, v19 in ipairs(v16) do
		if not __wf_atom_7e8ad928(v19) then
			v19:Destroy()
		end
	end

	v16 = {}
end

local function fn2() end

local function fn3(list, layerIndex)
	local result = {}

	for _, v19 in ipairs(list) do
		local __wf_atom_e800787c = v19:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) or __wf_atom_e800787c:GetLayerIndex() ~= layerIndex then
			continue
		end

		table.insert(result, v19)
	end

	return result
end

local function fn4(object)
	allAgentTypes = allAgentTypes
	v17 = object
	v4 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	v4:__wf_atom_24539216(v2, aiSpec)
	local __wf_atom_e800787c = object:__wf_atom_e800787c()
	assert(not __wf_atom_7e8ad928(__wf_atom_e800787c))
	local layerIndex = __wf_atom_e800787c:GetLayerIndex()
	v15 = fn3(gRegion:FindAll(gNpcSpawnPointType), layerIndex)
	print("Arena Spawn Points: " .. #v15)

	if object:GetState() == 1 then
		local all = gRegion:FindAll(__wf_atom_9e85eea2)

		for _, v19 in ipairs(all) do
			if v19:__wf_atom_e800787c() == __wf_atom_e800787c then
				table.insert(v16, v19)
			end
		end
	else
		v12 = module4.GetMaxGameEnemyLevel()
		maxValue = module4.GetEnemyLevel(object).maxValue
		v8:SetModeState(1)
	end
end

function FadeIn(object)
	if not __wf_atom_7e8ad928(object) then
		object:SetVisibility(true, true)
	end

	local v19 = 1

	while v19 >= 0 and not __wf_atom_7e8ad928(object) do
		v19 -= __wf_atom_084b3e93()
		object:__wf_atom_a763aa1a(__wf_atom_421b01aa(v19 / 1, 0, 1))
		Sleep(0)
	end
end

local function fn5()
	local v19 = {}
	local spawn = nil

	for k, v20 in pairs(v15) do
		v19[k] = v20
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	v18 = {}

	while not spawn and #v19 ~= 0 do
		local v20 = __wf_atom_5784a397(1, #v19)
		spawn = v19[v20]
		local _ = { spawn = spawn }
		local v21 = not __wf_atom_7e8ad928((gRegion:__wf_atom_e2db08ce(__wf_atom_67c46eba, spawn:GetPosition(), 5)))

		for _, v22 in ipairs(__wf_atom_ef7900cf) do
			if not (v22:__wf_atom_9af7625d(spawn) < 144 or v22:__wf_atom_0a6aa891(spawn) > 0.5) then
				continue
			end

			v21 = true
			break
		end

		if not v21 then
			continue
		end

		table.remove(v19, v20)
		spawn = nil
	end

	if spawn then
		return spawn
	end

	print("All spawns blocked by an avatar, choosing at random.")
	return v15[__wf_atom_5784a397(1, #v15)]
end

local function fn6()
	local v19 = v17
	local v20 = fn3(gRegion:__wf_atom_ef7900cf(), v17:__wf_atom_e800787c():GetLayerIndex())
	local flag

	if #v20 > 0 then
		v19 = v20[__wf_atom_5784a397(1, #v20)]
		flag = true
	else
		flag = false
	end

	local position = v19:GetPosition()
	local v21 = Range(7, 18)
	local __wf_atom_28ce676a = v4:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, v21, 4)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(30)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_0f52bdf4(position, v21, -4.8, 3.6, 1, 0.5, false)

	if flag then
		__wf_atom_28ce676a:__wf_atom_e275b192(position, __wf_atom_e97f3142(v19:__wf_atom_4e50d390()), 180)
	end

	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("ArenaSpawn"), Color("0xFF00FF"))
	local positions = module5.GetPositions(1, __wf_atom_28ce676a)

	if __wf_atom_7e8ad928(positions) then
		return
	else
		return positions[1]
	end
end

local function fn7(p)
	if not gRegion:IsMaster() then
		return
	end

	if v11 then
		if count3 >= v11.Total then
			v8:SetModeState(2)
			return
		end

		if count2 >= v11.Total or v13 >= v11.MaxSim then
			return
		end

		v14 -= p

		if v14 > 0 then
			return
		end

		if count3 >= v11.HeavySpawn then
			heavies = v11.Heavies
		end

		local ternary = module.Ternary(count4 < heavies, 5, v11.Tier)

		if __wf_atom_7e8ad928(v4) then
			v4 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		end

		local __wf_atom_debadc27 = v4:__wf_atom_debadc27(aiSpec, faction, 0, true, false, ternary, true)
		local v19, v20, v21

		if useTacPosQueryForSpawning then
			v19 = fn6()

			if __wf_atom_7e8ad928(v19) then
				return
			end

			v20 = gRegion:__wf_atom_06db1fb1(v19)
			local __wf_atom_80368bb1 = __wf_atom_80368bb1

			if not __wf_atom_7e8ad928(v20) then
				__wf_atom_80368bb1 = __wf_atom_fa8d0177(v19, v20:GetPosition())
			end

			v21 = v4:__wf_atom_402b3832(__wf_atom_debadc27, v19, __wf_atom_80368bb1, Symbol("RandomTeam"), maxValue)
		else
			v19 = fn5()

			if __wf_atom_7e8ad928(v19) then
				return
			end

			v20 = gRegion:__wf_atom_06db1fb1(v19:GetPosition())
			v21 = v4:CreateAgent(__wf_atom_debadc27, v19, EMPTY_SYMBOL, maxValue)
		end

		if __wf_atom_7e8ad928(v21) then
			v14 = 0.25
			local v22 = __wf_atom_7e8ad928(__wf_atom_debadc27) and "No agent types available."
				or __wf_atom_7e8ad928(v19) and "No spawns available."
				or ""
			print("Agent failed to spawn: " .. v22)
		else
			count2 += 1
			v13 += 1
			v14 = 2
			local __wf_atom_50a7d83e = v21:__wf_atom_50a7d83e()

			if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				__wf_atom_55142dd4(__wf_atom_50a7d83e, "OnKilled")
				table.insert(v16, __wf_atom_50a7d83e)
				__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("FadeIn"), false)
				__wf_atom_50a7d83e:__wf_atom_c6a78fe5(nil)
				v21:StormTarget(v20, 10)
				v21:__wf_atom_30b587a4()

				if count4 < heavies then
					count4 += 1
				end
			end
		end
	else
		v11 = v3[count % #v3 + 1]
		count += 1
		maxValue = math.min(maxValue + 2, v12)
		v14 = 2
		v13 = 0
		count2 = 0
		count3 = 0
		heavies = 0
		count4 = 0
		print("New wave:\n\tWave Number: " .. count .. "\n\tTier: " .. v11.Tier)
	end
end

local function fn8()
	if count > 20 then
		return true
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local count5 = 0

	for _, v19 in ipairs(__wf_atom_ef7900cf) do
		if not (__wf_atom_7e8ad928(v19) or v19:IsKilled() or v19:IsA(v)) then
			continue
		end

		count5 += 1
	end

	return count5 == #__wf_atom_ef7900cf
end

function OnKilled(p)
	for i, v19 in ipairs(v16) do
		if p ~= v19 then
			continue
		end

		table.remove(v16, i)
		break
	end

	count3 += 1
	v13 -= 1
end

local function fn9(p)
	if __wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(v5) then
		return
	end

	if modeState ~= 3 and fn8() then
		v8:SetModeState(3)
	end

	v7:Update(p)

	if modeState == 1 then
		fn7(p)
	end
end

local function fn10()
	v9 = nil
	v8:SetModeState(1)
end

local function fn11(p)
	if p == 1 then
		return
	end

	if p == 2 then
		if gRegion:IsMaster() then
			v11 = nil
			v9 = v7:AddTimer(3, fn10)
		end
	elseif p == 3 then
		if gRegion:IsMaster() then
			v4:__wf_atom_d6c097a3(v2)
			fn()
		end

		v10 = true
	end
end

function Mission(object)
	v8 = module2.CreateModeMgr(fn11)

	if gRegion:IsMaster() then
		fn4(object)
	end

	v5 = gRegion:__wf_atom_eab484a7()
	v6 = gGameRules:__wf_atom_b56d2aa8()
	v7 = module3.CreateTimerMgr()

	if gRegion:IsMaster() then
		object:SetState(1)
	end

	local flag = false

	while not v10 do
		fn2()
		Sleep(0)

		while __wf_atom_7e8ad928(gGameRules) do
			fn2()
			Sleep(0)

			if __wf_atom_7e8ad928(gGameRules) then
				continue
			end

			flag = true

			while not gGameRules:__wf_atom_adfb052a() do
				fn2()
				Sleep(0)
			end
		end

		if flag then
			if gPromotedToHost then
				fn4()
				v5 = gRegion:__wf_atom_eab484a7()
				v6 = gGameRules:__wf_atom_b56d2aa8()
				v7 = module3.CreateTimerMgr()
			end

			flag = false
		end

		v8:Update()
		modeState = v8:GetModeState()

		if gRegion:IsMaster() then
			fn9(__wf_atom_03df4e1d())
		end

		__wf_atom_03df4e1d()

		if not (__wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(v6)) then
			__wf_atom_7e8ad928(v5)
		end
	end

	if gRegion:IsMaster() then
		object:SetState(0)
	end
end