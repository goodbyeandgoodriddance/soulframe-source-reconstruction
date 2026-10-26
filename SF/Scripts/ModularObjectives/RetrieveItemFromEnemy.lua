local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")
local module3 = require("SF.Scripts.Libs.EncounterLib")
local module4 = require("SF.Scripts.Libs.RaycastLib")
local module5 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module6 = require("Lotus.Scripts.Libs.Query")
local v = nil
local v2 = nil
local v3 = nil
local v4 = false
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil

local function fn()
	local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
	local dynamicEncounterTypes2 = {}

	for _, v12 in ipairs(dynamicEncounterTypes) do
		local __wf_atom_8b1357e3 = Resource(v12):__wf_atom_8b1357e3()

		if __wf_atom_7e8ad928(__wf_atom_8b1357e3) or #__wf_atom_8b1357e3 == 0 then
			table.insert(dynamicEncounterTypes2, v12)
		else
			for i = 1, #__wf_atom_8b1357e3 do
				if not __wf_atom_8b1357e3[i].ValidTime:Contains(__wf_atom_cb3427c9) then
					continue
				end

				table.insert(dynamicEncounterTypes2, v12)
				break
			end
		end
	end

	if #dynamicEncounterTypes2 == 0 then
		dynamicEncounterTypes2 = dynamicEncounterTypes
	end

	return dynamicEncounterTypes2[__wf_atom_5784a397(1, #dynamicEncounterTypes2)]
end

local function fn2(p)
	local __wf_atom_0e0a6fee = v8:__wf_atom_0e0a6fee(p)
	local groundPos = module4.GetGroundPos(__wf_atom_0e0a6fee)

	if __wf_atom_7e8ad928(v3) and not v4 then
		if detectDroppedPickup then
			local all = gRegion:FindAll(objectType, p, 0, 10)

			if #all > 0 then
				v3 = all[1]
			end
		end

		if __wf_atom_7e8ad928(v3) then
			local v12 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			print("Creating object: " .. tostring(p) .. " -> " .. tostring(__wf_atom_0e0a6fee) .. " -> " .. tostring(groundPos))

			if objectType:IsA(__wf_atom_3feeb44a) then
				groundPos += Vector(0, 0.1, 0)
			end

			v3 = gRegion:CreateEntity(objectType, groundPos, v12)
			v7:__wf_atom_d494454b(v3)
		else
			print("Found existing object")
		end
	elseif not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_e6ed03c8()
		v3:__wf_atom_0ed81088(true)
		local v12 = Vector()
		gRegion:__wf_atom_c20d246a(
			v3:GetPosition(),
			v3:GetPosition() - Vector(0, 5, 0),
			{
				__wf_atom_4ebf67cb,
				__wf_atom_3feeb44a,
				__wf_atom_43e0c427,
				__wf_atom_7b01f9ce,
				__wf_atom_3feeb44a
			},
			nil,
			v12
		)

		if v12 == __wf_atom_28d5d4aa then
			v3:SetPosition(__wf_atom_0e0a6fee + Vector(0, 0.25, 0))
		end

		v3:__wf_atom_03d03fec(false)
		v3:__wf_atom_1b57cb83(false)
		print("Unattached existing object")
	end

	if addSparrowDestination then
		module2.AddSparrowDestination(v3, v5, nil, module2.PRIORITY.HIGH, Range(6, v11 + 5))
	end
end

function OnKilled(object)
	for i = #v2, 1, -1 do
		if __wf_atom_7e8ad928(v2[i]) or v2[i] == object then
			table.remove(v2, i)
		end
	end

	local position = object:GetPosition()
	module2.RemoveSparrowDestination(v, v7)

	if detectDroppedPickup then
		Sleep(1.5)
	end

	fn2(position)
end

function EvaluateAction(object, p)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return true
	end

	return not (__wf_atom_575542c8:__wf_atom_3a6b0cbb() or __wf_atom_575542c8:__wf_atom_5314af3f(p))
end

local function fn3()
	local __wf_atom_103377cc = v5:__wf_atom_103377cc()
	local __wf_atom_fe00d825 = v5:__wf_atom_fe00d825()

	for _, v12 in ipairs(__wf_atom_fe00d825) do
		if not v12:IsA(__wf_atom_0f520c3c) then
			continue
		end

		v12:__wf_atom_400189c4(__wf_atom_103377cc)
		break
	end
end

local function fn4()
	if not (module3.WaitForParentEncounterActive(v7) or __wf_atom_7e8ad928(v7)) then
		v7:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(v5) then
		return
	end

	v2 = {}
	local __wf_atom_6199ef01 = v5:__wf_atom_6199ef01()
	local v12 = Symbol("Neutral")

	for i = #__wf_atom_6199ef01, 1, -1 do
		local __wf_atom_50a7d83e = __wf_atom_6199ef01[i]:__wf_atom_50a7d83e()

		if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled() or __wf_atom_50a7d83e:__wf_atom_e93896ba() == v12) then
			continue
		end

		table.remove(__wf_atom_6199ef01, i)
	end

	local position = v5:GetPosition()

	if __wf_atom_7e8ad928(__wf_atom_6199ef01) or #__wf_atom_6199ef01 == 0 then
		local v13 = fn()
		v8:AddEncounter(v13)
		v6 = v8:__wf_atom_c4c644af(v7:GetPosition(), v13, v5)

		if __wf_atom_7e8ad928(v6) then
			print("RetrieveItemFromEnemy failed to create new enemies")

			if not __wf_atom_7e8ad928(v7) then
				v7:__wf_atom_8e6fec76(6)
			end

			return
		else
			position = v6:GetPosition()
			local __wf_atom_4026dfb5 = v6:__wf_atom_4026dfb5()

			while not __wf_atom_7e8ad928(v6) and __wf_atom_4026dfb5 < 2 do
				__wf_atom_4026dfb5 = v6:__wf_atom_4026dfb5()

				if __wf_atom_4026dfb5 == 6 then
					break
				else
					Sleep(0)
				end
			end

			if not __wf_atom_7e8ad928(v6) then
				__wf_atom_6199ef01 = v6:__wf_atom_6199ef01()
			end
		end
	end

	for _, v13 in ipairs(__wf_atom_6199ef01) do
		local __wf_atom_50a7d83e = v13:__wf_atom_50a7d83e()

		if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled() then
			continue
		end

		if v13:IsA(carrierAgentType) then
			v = __wf_atom_50a7d83e
			break
		else
			table.insert(v2, __wf_atom_50a7d83e)
		end
	end

	if __wf_atom_7e8ad928(v) then
		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("VipSpawn"), position, 0, v11)
		local randomPointInRangeOnNav, v13

		if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			randomPointInRangeOnNav = v8:GetRandomPointInRangeOnNav(position, 1, 6, true, 0.5)
			v13 = __wf_atom_fa8d0177(randomPointInRangeOnNav, position)
		else
			randomPointInRangeOnNav = __wf_atom_f738b4af:GetPosition()
			v13 = __wf_atom_f738b4af:__wf_atom_dc309f8a()
		end

		local enemyLevel = module3.GetEnemyLevel(v5)
		local carrierAgentType2 = carrierAgentType

		if __wf_atom_7e8ad928(carrierAgentType) then
			carrierAgentType2 = module3.GetRandomEnemyAgentType(
				nil,
				nil,
				enemyLevel.maxValue,
				v5,
				0,
				carrierAgentRank,
				true
			)
		end

		if not __wf_atom_7e8ad928(carrierAgentType2) then
			local __wf_atom_402b3832 = v8:__wf_atom_402b3832(
				carrierAgentType2,
				randomPointInRangeOnNav,
				v13,
				Symbol("RandomTeam"),
				enemyLevel.maxValue
			)

			if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
				v5:__wf_atom_97f955c1(__wf_atom_402b3832)
				v = __wf_atom_402b3832:__wf_atom_50a7d83e()
				table.insert(v2, __wf_atom_402b3832:__wf_atom_50a7d83e())
			end
		end
	end

	if #v2 > 0 then
		if __wf_atom_7e8ad928(v) then
			v = v2[__wf_atom_5784a397(1, #v2)]
		end

		__wf_atom_55142dd4(v, "OnKilled")
		local attachBone2 = attachBone

		if attachItem then
			if attachBone ~= EMPTY_SYMBOL and not v:__wf_atom_71a94e55(attachBone) then
				attachBone2 = Symbol("GAME_C1_RIFLEATTACH")
			end

			v3 = v:Attach(objectType, attachBone2, attachOffset, attachRotationOffset)
			v3:__wf_atom_0ed81088(false)
		end

		if addSparrowDestination then
			module2.AddSparrowDestination(v, v5, nil, module2.PRIORITY.HIGH, Range(6, v11 * 2))
		end
	end
end

local function fn5()
	if __wf_atom_7e8ad928(unlockableItemType) then
		return true
	end

	local __wf_atom_28ce676a = v8:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(v7:GetPosition(), Range(0, 20), 3)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(spawnAngleLimit)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)

	if restrictSurfaces then
		__wf_atom_28ce676a:__wf_atom_28a1a374(Vector(0, -1, 0), validSpawnSurfaceTypes)
	end

	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("RetriveItemFromEnemy"), Color("0xFF00FF"))
	local positions = module6.GetPositions(20, __wf_atom_28ce676a)

	if __wf_atom_7e8ad928(positions) or #positions == 0 then
		return false
	end

	local position = positions[__wf_atom_5784a397(1, #positions)]
	local v12 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
	local groundAlignedSpawnPosRot, v13 = module4.GetGroundAlignedSpawnPosRot(unlockableItemType, position, v12)
	v9 = gRegion:CreateEntity(unlockableItemType, groundAlignedSpawnPosRot, v13)
	v7:__wf_atom_d494454b(v9)
	v7:__wf_atom_c53e1842(groundAlignedSpawnPosRot)

	if not __wf_atom_7e8ad928(v9) then
		v10 = v9:__wf_atom_bb3e7833(__wf_atom_0f45538d)
	end

	return true
end

function Main(object)
	print("Retrieve item from enemy encounter started")
	v8 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	object:__wf_atom_8e6fec76(1)
	v7 = object
	v5 = object:__wf_atom_26b04ea9() or v7
	v11 = v5:__wf_atom_103377cc()

	if not fn5() then
		object:__wf_atom_8e6fec76(6)
		return
	end

	fn4()
	fn3()

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_c1f3dd00 = object:__wf_atom_dd85e6db():__wf_atom_c1f3dd00()

	if not __wf_atom_7e8ad928(__wf_atom_c1f3dd00) and __wf_atom_c1f3dd00 ~= EMPTY_SYMBOL then
		module5.UpdateOrAddHudTask(object)
	end

	object:__wf_atom_8e6fec76(2)

	while not module3.PrimedMissionShouldShutDown(object, v5) do
		if not __wf_atom_7e8ad928(v3) then
			v4 = true
		end

		if requireItem and not v4 and __wf_atom_7e8ad928(v) and __wf_atom_7e8ad928(v3) then
			if #v2 > 0 then
				v = v2[__wf_atom_5784a397(1, #v2)]
				__wf_atom_55142dd4(v, "OnKilled")

				if addSparrowDestination then
					module2.AddSparrowDestination(v, v5, nil, module2.PRIORITY.HIGH, Range(6, v11 * 2))
				end
			else
				fn2(v5:GetPosition() + Vector(1, 1, 1))
			end
		end

		if requireUnlock and not __wf_atom_7e8ad928(v9) then
			if __wf_atom_7e8ad928(v10) or v10:__wf_atom_272baebc() then
				object:__wf_atom_8e6fec76(4)
				break
			end
		elseif requireUnlock and not requireItem then
			if __wf_atom_7e8ad928(v10) or v10:__wf_atom_272baebc() then
				object:__wf_atom_8e6fec76(4)
				break
			end
		else
			local v12

			if __wf_atom_7e8ad928(v3) then
				v12 = false
			else
				v12 = not v3:IsA(__wf_atom_3feeb44a) or v3:__wf_atom_93b324ab()
			end

			if v4 and not v12 then
				object:__wf_atom_8e6fec76(4)
				break
			end
		end

		if _T.DebugDrawDailyLocations and not __wf_atom_7e8ad928(v3) then
			gRegion:__wf_atom_5b35a0c8(v3:GetPosition(), Color(0, 255, 0), "Item", 1, 0)
		end

		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if object:__wf_atom_4026dfb5() == 4 then
		print("Retrieve item from enemy encounter succeeded")
		module5.CompleteHudTask(object)
		Sleep(4)

		if __wf_atom_7e8ad928(object) then
			return
		end

		module5.RemoveHudGroup(object)

		if transientTaskXp > 0 then
			module.GiveXpToPlayersInRadius(transientTaskXp, object:GetPosition(), 40)
		end

		while not __wf_atom_7e8ad928(v7) and v7:__wf_atom_e464a32f() > 0 and v8:__wf_atom_c6f505f2(v7) > 0 do
			Sleep(0)
		end
	else
		print("Retrieve item from enemy encounter shutdown")
		object:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	module5.RemoveHudGroup(object)
	module3.RemoveObjects(object)
	print("Retrieve item from enemy encounter done")
end

function ReturnItemToNavmesh(object)
	if gRegion:IsMaster() then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local count = 0
		local v12 = 0

		while not __wf_atom_7e8ad928(object) do
			if __wf_atom_7e8ad928(object:__wf_atom_3d96ddcd()) then
				count += 1

				if v12 >= 10 or count >= 10 then
					local position = object:GetPosition()
					local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(position, 100, 100)

					if Distance(position, __wf_atom_0e0a6fee) >= 1 then
						object:Teleport(__wf_atom_0e0a6fee + Vector(0, 0.5, 0), __wf_atom_80368bb1)
						print("Item teleported to navmesh")
					end

					count = 0
					v12 = 0
				end
			end

			Sleep(1)
		end
	end
end