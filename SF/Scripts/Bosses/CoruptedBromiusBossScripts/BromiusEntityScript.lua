require("SF.Scripts.Libs.CommonFunctionsLib")
local module = require("SF.Scripts.Npc.SmiteSoul")
local v = false
local v2 = false
local v3 = Symbol("GAME_L1_ELBOW")
local v4 = Symbol("GAME_R1_ELBOW")
Symbol("GAME_L1_KNEE")
Symbol("GAME_R1_KNEE")
local v5 = Symbol("GAME_LEFT_FACE_C1_SKIN_HEADCONNECT")
local v6 = Symbol("GAME_RIGHT_FACE_C1_SKIN_HEADCONNECT")
local v7 = Symbol("GAME_C1_SPINE1")
local v8 = Symbol("GAME_C1_BELL_BODY")

local function fn(object)
	object:__wf_atom_25954492(v3, false, false, false)
	object:__wf_atom_25954492(v4, false, false, false)
	object:__wf_atom_25954492(v5, false, false, false)
	object:__wf_atom_25954492(v6, false, false, false)
	object:__wf_atom_25954492(v7, true, true, true)
	object:__wf_atom_25954492(v8, false, true, false)
end

local function fn2(object)
	object:__wf_atom_25954492(v3, true, true, true)
	object:__wf_atom_25954492(v4, true, true, true)
	object:__wf_atom_25954492(v5, false, true, false)
	object:__wf_atom_25954492(v6, false, true, false)
	object:__wf_atom_25954492(v7, false, false, false)
	object:__wf_atom_25954492(v8, true, true, true)
end

function CheckBipedModeLoop(object)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	local v9 = object:__wf_atom_3d840c93(128) == 0

	if v9 then
		fn(__wf_atom_7470861b)
	else
		fn2(__wf_atom_7470861b)
	end

	while not __wf_atom_7e8ad928(object) do
		Sleep(0)
		local v10 = object:__wf_atom_3d840c93(128) == 0

		if v10 == v9 then
			continue
		end

		if v10 then
			fn(__wf_atom_7470861b)
		else
			fn2(__wf_atom_7470861b)
		end

		v9 = v10
	end
end

function CanSpawnSoul(p)
	module.SoulSpawn(p, critSpawns, v8, critSpawnOfset, true)
end

function BromiusEntityScript(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local maxHealth = object:GetMaxHealth()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	object:__wf_atom_cecb2d55(Symbol("RemaningHeads"), 3)
	object:__wf_atom_78ad8b9f(128, 1)
	object:__wf_atom_8a035cd5(Symbol("CheckBipedModeLoop"), false)
	object:__wf_atom_8a035cd5(Symbol("CanSpawnSoul"), false)
	object:__wf_atom_52077f7a(bromiusFinisherBBVarSymbol)

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_52077f7a = object:__wf_atom_52077f7a(bromiusFinisherBBVarSymbol)

		if object:__wf_atom_c6f1f83d() <= maxHealth * finisher1HpThreshold and not v then
			object:SetBlackboardBool(Symbol("CanStartHeadFinisher"), true)
			print("Bromius Will attemp his first finisher now, hopefully...")
			v = true
		elseif object:__wf_atom_c6f1f83d() <= maxHealth * finisher2HpThreshold and not v2 then
			object:SetBlackboardBool(Symbol("CanStartHeadFinisher"), true)
			print("Bromius Will attemp his second finisher now, hopefully...")
			v2 = true
		end

		if gRegion:IsMaster() then
			if __wf_atom_52077f7a == true and not __wf_atom_d2b2176d:__wf_atom_c1f9859f(169, nil, nil) then
				__wf_atom_d2b2176d:AddUpgrade(169, 3, stabityDamageMult)
			elseif __wf_atom_52077f7a == false and __wf_atom_d2b2176d:__wf_atom_c1f9859f(169, nil, nil) then
				__wf_atom_d2b2176d:RemoveUpgrade(169, 3, stabityDamageMult)
			end
		end

		Sleep(0)
	end
end