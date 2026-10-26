local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("Lotus.Scripts.Libs.Query")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil

local function fn() -- 2 equivalent calls inferred from this helper
	return Rotation(__wf_atom_5784a397(0, 360), 0, 0)
end

local function fn2()
	local position = v2:GetPosition()
	local __wf_atom_dd85e6db = v2:__wf_atom_dd85e6db()

	if snapToRoadNode then
		local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
		local v5 = Vector()
		__wf_atom_2202ffb6:__wf_atom_3cc125d0(position, v5)

		if not __wf_atom_7e8ad928(v5) then
			local __wf_atom_d7d7201a = __wf_atom_dd85e6db:__wf_atom_d7d7201a()

			for _, v6 in ipairs(__wf_atom_d7d7201a) do
				local __wf_atom_6e164b9d = v:__wf_atom_6e164b9d(v6)

				for _, v7 in ipairs(__wf_atom_6e164b9d) do
					if not (v7:IsEnabled() and v7:__wf_atom_a5304c35(v5) < v7:__wf_atom_8f18e876()) then
						continue
					end

					v5 = nil
					break
				end

				if __wf_atom_7e8ad928(v5) then
					break
				end
			end
		end

		if __wf_atom_7e8ad928(v5) then
			return false
		end

		position = v:__wf_atom_0e0a6fee(v5)
		v2:__wf_atom_c53e1842(position)
	end

	local __wf_atom_28ce676a = v:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(v2:GetPosition(), Range(0, 15), 4)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(15)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))

	if snapToRoadNode then
		__wf_atom_28ce676a:__wf_atom_09d2b44e(true)
	end

	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("TrapEncounter"), Color("0xFF00FF"))
	local positions = module4.GetPositions(1, __wf_atom_28ce676a)

	if #positions == 0 then
		return false
	end

	local position2 = positions[1]
	local trapType = trapTypes[__wf_atom_5784a397(1, #trapTypes)]
	local position3, v5 = module3.GetGroundAlignedSpawnPosRot(trapType, position2, fn(), false, 60) -- inferred equivalent call

	if __wf_atom_7e8ad928(position3) then
		return false
	end

	if useTrapWaypoints then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(trapWaypointSymbol, position, 0, 30)

		if #__wf_atom_439c0d29 > 1 then
			local v6 = __wf_atom_439c0d29[__wf_atom_5784a397(1, #__wf_atom_439c0d29)]
			position3 = v6:GetPosition()
			v5 = v6:__wf_atom_dc309f8a()
		end
	end

	v3 = gRegion:CreateEntity(trapType, position3, v5)
	v2:__wf_atom_d494454b(v3)

	if not __wf_atom_7e8ad928(v3) then
		local taggedChild = module2.FindTaggedChild(v3:__wf_atom_be0bea4a(), Symbol("LootChestAction"))

		if not __wf_atom_7e8ad928(taggedChild) then
			taggedChild:Disable()
		end
	end

	if #baitTypes > 0 and math.random() <= baitChance then
		local baitType = baitTypes[__wf_atom_5784a397(1, #baitTypes)]
		local groundAlignedSpawnPosRot, v6 = module3.GetGroundAlignedSpawnPosRot(baitType, position2, fn(), false, 30) -- inferred equivalent call

		if not __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
			v4 = gRegion:CreateEntity(baitType, groundAlignedSpawnPosRot, v6)
			v2:__wf_atom_d494454b(v4)
		end
	end

	return true
end

local function fn3(object)
	v = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return false
	end

	v2 = object
	local __wf_atom_26b04ea9 = object:__wf_atom_26b04ea9()

	if not __wf_atom_7e8ad928(__wf_atom_26b04ea9) then
		v2 = __wf_atom_26b04ea9
	end

	v2:__wf_atom_8e6fec76(1)
	return true
end

local function fn4()
	v2:__wf_atom_8e6fec76(2)
	local __wf_atom_26b04ea9 = v2:__wf_atom_26b04ea9()
	local total = 0

	while not module.ShouldShutDown(v2, __wf_atom_26b04ea9) do
		if __wf_atom_7e8ad928(v3) and __wf_atom_7e8ad928(v4) then
			return
		end

		if isTrapChest then
			local __wf_atom_bb3e7833 = v3:__wf_atom_bb3e7833(openChestActionWResource)

			if __wf_atom_7e8ad928(__wf_atom_bb3e7833) or __wf_atom_bb3e7833:__wf_atom_272baebc() then
				break
			end
		end

		local _debugDraw = debugDraw
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	while not __wf_atom_7e8ad928(v2) and v2:__wf_atom_e464a32f() > 0 and v:__wf_atom_c6f505f2(v2) > 0 do
		Sleep(0)
	end
end

local function fn5()
	if __wf_atom_7e8ad928(v2) then
		print("Shutdown due to level streaming")
		return
	end

	v2:__wf_atom_8e6fec76(6)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("FenceTrapCollision"), v2:GetPosition(), 0, 2)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		__wf_atom_f738b4af:Destroy()
	end

	module.RemoveObjects(v2)
end

function DynamicTrapEncounter(p)
	if not (fn3(p) and fn2()) then
		return
	end

	fn4()
	fn5()
end

function DynamicTrapEncounterEvaluate(p)
	if module.GetEnemyLevel(p).maxValue >= minLevelToSpawn then
		return 1
	end

	return 0
end