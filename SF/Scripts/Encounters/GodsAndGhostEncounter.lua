local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("Lotus.Scripts.Libs.Query")
local module5 = require("SF.Scripts.Libs.QuestLib")
local v = nil
local v2 = nil
local v3 = nil
local v4 = Symbol("UPGRADEGIVEN_GODANDGHOST")
local total = 0

local function fn()
	local v5 = {}
	local total2 = 0

	for i, v6 in ipairs(questResources) do
		if not module5.HasCompletedQuest(v6) then
			continue
		end

		table.insert(v5, npcResources[i])
		total += npcWeights[i]
	end

	if #v5 == 0 then
		return nil
	end

	local _dontUseRolledSeed = _G.DontUseRolledSeed == true
	local __wf_atom_774cdec4 = Engine.__wf_atom_774cdec4(86400)
	__wf_atom_01bfe5c4(__wf_atom_774cdec4)
	local v6 = __wf_atom_8d119bab(0, total)

	for k, v7 in pairs(v5) do
		total2 += npcWeights[k]

		if v6 <= total2 then
			return v7
		end
	end
end

local function fn2()
	local pointInstances = module.FindPointInstances(
		v2,
		WeakResource("/SF/Types/Game/EncounterCustomBoundsTrigger"),
		Symbol("EncounterCustomBoundsTrigger")
	)

	if __wf_atom_7e8ad928(pointInstances) or not (#pointInstances > 0) then
		return true
	end

	print("Waiting for custom trigger...")

	while not module.ShouldShutDown(v2) do
		local __wf_atom_b7c04e13 = v2:__wf_atom_b7c04e13()

		for _, pointInstance in ipairs(pointInstances) do
			if __wf_atom_7e8ad928(pointInstance) then
				return false
			end

			for _, v5 in ipairs(__wf_atom_b7c04e13) do
				if
					__wf_atom_7e8ad928(v5)
					or v5:IsKilled()
					or not pointInstance:__wf_atom_1eaf335c(v5:GetPosition())
				then
					continue
				end

				if not pointInstance:IsEnabled() then
					continue
				end

				print("Custom trigger, starting enemy spawns")
				return true
			end
		end

		Sleep(0.1)
	end

	return false
end

function DitherInEntity(object)
	object:__wf_atom_68f2c268(1)
	object:__wf_atom_a7ee9662(true)
	local v5 = 3

	while not __wf_atom_7e8ad928(object) and v5 > 0 do
		v5 = __wf_atom_421b01aa(v5 - __wf_atom_084b3e93() / 1.5, 0, 1)
		object:__wf_atom_68f2c268(__wf_atom_24a82b69(v5))
		Sleep(0)
	end
end

local function fn3() -- 1 equivalent call inferred from this helper
	return Rotation(__wf_atom_5784a397(0, 360), 0, 0)
end

local function fn4()
	local position = v2:GetPosition()
	v2:__wf_atom_dd85e6db()
	local _npcResources = npcResources
	local __wf_atom_28ce676a = v:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(v2:GetPosition(), Range(0, 15), 4)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(15)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("GodsAndGhostEncounter"), Color("0xFF00FF"))
	local positions = module4.GetPositions(1, __wf_atom_28ce676a)

	if #positions == 0 then
		return false
	end

	local v5 = fn()
	local v6 = {}

	if __wf_atom_7e8ad928(v5) then
		return nil
	end

	table.insert(v6, v5:__wf_atom_5b41f63b())
	local __wf_atom_c0dbe47c = UISys.__wf_atom_c0dbe47c(v6)

	while not __wf_atom_c0dbe47c:__wf_atom_86399a47() do
		Sleep(0.1)
	end

	local v7 = Type(v5)
	local position2 = positions[1]
	local position3, v8 = module3.GetGroundAlignedSpawnPosRot(v7, position2, fn3(), false, 60) -- inferred equivalent call

	if __wf_atom_7e8ad928(v7) then
		print("GodsAndGhostENC: Error - no available npcs for spawning")
		return false
	end

	if __wf_atom_7e8ad928(position3) then
		return false
	end

	if useWaypoints then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(npcWaypointSymbol, position, 0, 30)

		if #__wf_atom_439c0d29 > 1 then
			local v9 = __wf_atom_439c0d29[__wf_atom_5784a397(1, #__wf_atom_439c0d29)]
			position3 = v9:GetPosition()
			v8 = v9:__wf_atom_dc309f8a()
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		v8 = __wf_atom_fa8d0177(position3, __wf_atom_c4f78a8f:GetPosition())
	end

	v3 = gRegion:CreateEntity(v7, position3, v8)
	v3:__wf_atom_68f2c268(1)
	v2:__wf_atom_d494454b(v3)

	if not fn2() then
		print("GodsAndGhostENC: Shutdown due to level streaming")
		return false
	end

	v3:Attach(spawnAttachFxType, EMPTY_SYMBOL)
	DitherInEntity(v3)
	return true
end

local function fn5(object)
	v = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("GodsAndGhostENC: Shutdown due to level streaming")
		return false
	end

	if __wf_atom_7e8ad928(_G.EnableBoonTesting) then
		_G.EnableBoonTesting = false
	end

	if __wf_atom_7e8ad928(_G.DontUseRolledSeed) then
		_G.DontUseRolledSeed = false
	end

	if gGameData:__wf_atom_20bf298d(v4) then
		v2 = object
		local __wf_atom_26b04ea9 = object:__wf_atom_26b04ea9()

		if not __wf_atom_7e8ad928(__wf_atom_26b04ea9) then
			v2 = __wf_atom_26b04ea9
		end

		v2:__wf_atom_8e6fec76(1)
		return true
	else
		module.RemoveAgents(object)
		module.RemoveObjects(object)
		object:__wf_atom_8e6fec76(6)
		print("GodsAndGhostENC: Ending early due to boon timer being active")
		return false
	end
end

local function fn6()
	if __wf_atom_7e8ad928(v2) then
		return
	end

	v2:__wf_atom_8e6fec76(2)
	local __wf_atom_26b04ea9 = v2:__wf_atom_26b04ea9()
	local total2 = 0

	while not module.ShouldShutDown(v2, __wf_atom_26b04ea9) do
		if __wf_atom_7e8ad928(v3) then
			print("GodsAndGhostENC: Npc dosent exist, shutting down encounter")
			return
		end

		local _debugDraw = debugDraw
		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end

	while not (__wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(v) or __wf_atom_7e8ad928(gGameData)) do
		if v2:__wf_atom_e464a32f() > 0 and v:__wf_atom_c6f505f2(v2) > 0 and gGameData:__wf_atom_20bf298d(v4) then
			Sleep(0)
		else
			print("GodsAndGhostENC: is shutting down to no players in range or expiry timer is set")
			break
		end
	end
end

function DynamicGodsAndGhostsEncounter(p)
	if not fn5(p) then
		print("GodsAndGhostENC: start up failed, shutting down encounter")
		return
	end

	if not fn4() then
		print("GodsAndGhostENC: Boon Giver faild to spawn, shutting down encounter")
		return
	end

	fn6()

	if __wf_atom_7e8ad928(v2) then
		print("GodsAndGhostENC: Shutdown due to level streaming")
		return
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Destroy()
	end

	v2:__wf_atom_8e6fec76(6)
	module.RemoveObjects(v2)
end

function EnteredNpcMultiAvatarTrigger(object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	__wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_0f45538d)
	__wf_atom_3d96ddcd:GetPosition()

	if not __wf_atom_7e8ad928(proximitySound) then
		__wf_atom_3d96ddcd:Attach(proximitySound, EMPTY_SYMBOL)
	end
end