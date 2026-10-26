local v = Resource("/SF/Types/Player/ForceWalkGarrenBossFightInputFilter")
local v2 = Resource()
local v3 = nil
local v4 = nil
local v5 = Symbol("TeamGarren")
local v6 = Symbol("InvulSymbol")
local v7 = nil
local v8 = nil
local v9 = nil
local maxHealth = nil
local v10 = nil
local v11 = nil
local maxHealth2 = nil
local v12 = Resource("/SF/Fx/Characters/Deora/Corrupted/DeoraCorruptionGroundDeco")
local v13 = Resource("/SF/Weapons/Spear/DeoraSpear/Chunks/DeoraSpearDestructionFX")
local v14 = {
	{ name = "Spawned", statsName = "SPAWN" },
	{ name = "Intro", statsName = "INTRO" },
	{ name = "Lady Fight", statsName = "LADY_FIGHT" },
	{ name = "Enter The soul Plane", statsName = "SOUL_PLANE" },
	{ name = "CheckPoint", statsName = "CheckPoint" },
	{ name = "Garren Fight A", statsName = "GARREN_FIGHT" },
	{ name = "Fight Ended", statsName = "END" }
}
local v15 = Symbol("ActivePhase")
local v16 = { [3] = 0.1, [6] = 0.1 }
local v17 = { 0, 1.5, 2, 2.5 }
local v18 = 0
local v19 = Symbol("InteroSubState")
local v20 = { 39.5, 29, 25 }
local v21 = 0
local v22 = 2
local names = nil
local v23 = false
local v24 = false
local v25 = WeakResource("/SF/Types/Enemies/Bosses/LadyOfDendria/DeoraBossCombatTester")
local v26 = WeakResource("/SF/Types/Enemies/Bosses/GarrenRood/GarrenCombatTester")
local v27 = nil
local modeState = 0
local flag = false
local v28 = nil
local gGameRules2 = nil
local v29 = 1
local v30 = nil
local v31 = nil
local v32 = nil
local v33 = Vector(0, 0, 0)
local v34 = Rotation(0, 0, 0)
local v35 = nil
local position = Vector(0, 0, 0)
local v36 = Rotation(0, 0, 0)
local v37 = String("GroundStab")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.StatsLib")
local module3 = require("SF.Scripts.Libs.RespawnLib")
require("SF.Scripts.NightFoldLib")
local module4 = require("SF.Scripts.Libs.ChallengeLib")

local function fn(object, p, p2, p3)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local cameraControl = __wf_atom_c4f78a8f:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			cameraControl:__wf_atom_4dab66dd(object:GetPosition(), -1, p2, 2)

			if p then
				__wf_atom_c4f78a8f:__wf_atom_9b5dcd3b(playerStaggerAnim, false, 4, 1, true)
			end

			__wf_atom_eab484a7:__wf_atom_a6c0f1b8(4, 0.3, 0.3, p3)
		end
	end
end

local function fn2()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			for i = 0, 2 do
				__wf_atom_e55d02aa:__wf_atom_19516b62(100, i)
			end
		end
	end
end

local function fn3(list, list2) -- 3 equivalent calls inferred from this helper
	for i = 1, #list2 do
		list[#list + 1] = list2[i]
	end

	return list
end

local function fn4(p)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(legCollisionProxyTag)
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(bodyCollisionProxyTag)
	local __wf_atom_2226b35c3 = gRegion:__wf_atom_2226b35c(headCollisionProxyTag)
	local v38 = fn3(fn3(fn3({}, __wf_atom_2226b35c), __wf_atom_2226b35c2), __wf_atom_2226b35c3) -- inferred equivalent call

	for _, v39 in ipairs(v38) do
		if p then
			v39:__wf_atom_2d56d046(noCollisionPhysicsType)
		else
			v39:__wf_atom_2d56d046(defaultPhysicsType)
		end
	end
end

local function fn5(instance, p, attributeName) -- 2 equivalent calls inferred from this helper
	instance:__wf_atom_9189c3be(attributeName, instance:GetAttribute(attributeName) * p)
end

local function fn6(_)
	local all = gRegion:FindAll(garrenAgentType:__wf_atom_c6772fb4())

	if #all > 0 then
		v9 = all[1]
		v8 = v9:__wf_atom_30e3d82b()
	end

	if __wf_atom_7e8ad928(v9) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GarrenSpawnPoint"))
		v8 = v7:__wf_atom_402b3832(
			garrenAgentType,
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
			v5,
			mGarrenAgentLevel
		)

		if __wf_atom_7e8ad928(v8) then
			print("Garren rood agent failed to spawn")
			return
		else
			v9 = v8:__wf_atom_50a7d83e()
		end
	end

	v9:__wf_atom_7c8621d6()
	v9:SetVisibility(false)
	v9:__wf_atom_d1b42aad(false)
	v9:__wf_atom_30964595(false)
	v9:SetDisableGravity(true)
	v9:__wf_atom_0ed81088(false)
	fn4(true)

	if not __wf_atom_7e8ad928(v8) then
		v8:__wf_atom_b1da7683(true)
		v9:__wf_atom_c10fa976(false)
	end

	if v21 > 1 then
		fn5(v9, v17[v21], 1) -- inferred equivalent call
	end

	maxHealth = v9:GetMaxHealth()
	v9:__wf_atom_cecb2d55(v15, modeState)
	v9:SetBlackboardBool(Symbol("CanFight"), false)
end

local function fn7(p, p2)
	local all = gRegion:FindAll(deoraAgentType:__wf_atom_c6772fb4())

	if #all > 0 then
		v11 = all[1]
		v10 = v11:__wf_atom_30e3d82b()
	end

	local v38 = __wf_atom_7e8ad928(v11)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("LadyOfDendriaSpawnPoint"))

	if v38 then
		v10 = v7:__wf_atom_402b3832(
			deoraAgentType,
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
			v5,
			mDeoraAgentlevel
		)

		if __wf_atom_7e8ad928(v10) then
			print("Deora agent failed to spawn")
			return
		else
			v11 = v10:__wf_atom_50a7d83e()
		end
	end

	if v38 or p then
		v11:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
	end

	v11:__wf_atom_cecb2d55(v15, modeState)
	v11:__wf_atom_7c8621d6()

	if not __wf_atom_7e8ad928(v10) then
		v10:__wf_atom_b1da7683(true)
		v11:__wf_atom_c10fa976(false)
	end

	if v21 > 1 then
		fn5(v11, v17[v21], 1) -- inferred equivalent call
	end

	maxHealth2 = v11:GetMaxHealth()

	if p2 then
		v11:SetBlackboardBool(Symbol("DeoraHealed"), true)
		return
	end

	v11:SetBlackboardBool(Symbol("DeoraHealed"), false)

	if not v11:__wf_atom_a586ea4c(v12) then
		v11:Attach(v12, Symbol("GAME_C1_HIP1"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

local function fn8(object, p)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_7470861b = object:__wf_atom_7470861b()

		if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
			if p == true then
				__wf_atom_7470861b:__wf_atom_9fba31e6(v6, 26, 6, 0)
			else
				__wf_atom_7470861b:__wf_atom_63396172(v6)
			end
		end
	end
end

local function fn9()
	if __wf_atom_7e8ad928(v27) then
		return
	end

	for i = 1, #v27 do
		if __wf_atom_7e8ad928(v27[i]) then
			continue
		end

		local __wf_atom_a96eb2aa = v27[i]:__wf_atom_a96eb2aa()

		if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			continue
		end

		local __wf_atom_e55d02aa = __wf_atom_a96eb2aa:GetPlayerAvatar(0):__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			continue
		end

		__wf_atom_e55d02aa:__wf_atom_c31a704b(false)
		local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()

		for _, v38 in ipairs(__wf_atom_36b4a6e5) do
			if v38:IsActive() then
				v38:DeactivateAbility()
			end
		end
	end
end

local function fn10()
	if __wf_atom_7e8ad928(v27) then
		return
	end

	for i = 1, #v27 do
		if __wf_atom_7e8ad928(v27[i]) then
			continue
		end

		local __wf_atom_e55d02aa = v27[i]:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_c31a704b(true)
		end
	end
end

local function fn11(list, p)
	local v38 = nil

	if __wf_atom_7e8ad928(list) then
		return false
	end

	for i = 1, #list do
		local v39 = list[i]

		if __wf_atom_7e8ad928(v39) then
			continue
		end

		local v40 = Distance(
			v11:__wf_atom_a2a18137(),
			Vector(v39:__wf_atom_a2a18137().x, v11:__wf_atom_a2a18137().y, v39:__wf_atom_a2a18137().z)
		)

		if v40 <= p or __wf_atom_7e8ad928(v38) then
			v38 = v40
		end
	end

	return v38 <= p
end

local function fn12() -- 6 equivalent calls inferred from this helper
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return nil
	end

	return __wf_atom_eab484a7:GetPlayerAvatar(0)
end

local function fn13(p, p2)
	local v38 = p or p2
	local v39 = fn12() -- inferred equivalent call

	if gRegion:IsMaster() then
		if v18 == 1 then
			if not v38 then
				v11:__wf_atom_9b5dcd3b(fightIntroAnim, false, 4, 1, true)
				v11:__wf_atom_8914dfde(v37, 5)
			end

			module.DeactivateAbilities(false, true)
			Sleep(0)

			while __wf_atom_7e8ad928(v39) do
				Sleep(0)
				v39 = fn12() -- inferred equivalent call
			end

			v39:CameraControl():__wf_atom_25382a0d(0.7, false)
			v39:MotionControl():__wf_atom_99fc7a82(true)

			if not v38 then
				fn(v11, false, 6, 0.6)
				v32:__wf_atom_de14bbe2(false, true, false, 1)

				while v32:__wf_atom_ddf2c041() == false do
					Sleep(0)
				end

				v32:__wf_atom_f173c8ad(false)
			end

			if v30 ~= true then
				v30 = true
			end

			v39:__wf_atom_aeb02c14(v)
			fn9()
		elseif v18 == 2 then
			if not v38 then
				v11:__wf_atom_9b5dcd3b(fightIntroAnim, false, 4, 1, true)
				v11:__wf_atom_8914dfde(v37, 5)
				fn(v11, false, 6, 0.6)
				v32:__wf_atom_de14bbe2(false, true, false, 1)

				while v32:__wf_atom_ddf2c041() == false do
					Sleep(0)
				end

				v32:__wf_atom_f173c8ad(false)
			end
		elseif v18 == 3 then
			if not v38 then
				v11:__wf_atom_9b5dcd3b(fightIntroAnim, false, 4, 1, true)
				v11:__wf_atom_8914dfde(v37, 5)
				local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FightIntroCinematic"))

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					local playerAvatars = {}

					for i = 1, #v27 do
						if __wf_atom_7e8ad928(v27[i]) then
							continue
						end

						local __wf_atom_a96eb2aa = v27[i]:__wf_atom_a96eb2aa()

						if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
							continue
						end

						local playerAvatar = __wf_atom_a96eb2aa:GetPlayerAvatar(0)

						if __wf_atom_7e8ad928(playerAvatar) or fn11({ playerAvatar }, v20[3]) then
							continue
						end

						table.insert(playerAvatars, playerAvatar)
					end

					v39 = fn12() -- inferred equivalent call

					for _, v40 in playerAvatars do
						if not (__wf_atom_7e8ad928(v39) or __wf_atom_7e8ad928(v40)) then
							v40:Teleport(v39:__wf_atom_a2a18137())
						end
					end

					__wf_atom_0a6a5887:ReinitializeGreenRoom()
					__wf_atom_0a6a5887:FirePort("StartPlaying")

					while not (__wf_atom_0a6a5887:__wf_atom_7d4910e4() or __wf_atom_0a6a5887:__wf_atom_e9546dc6()) do
						Sleep(0)
					end

					while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
						Sleep(0)
					end

					v11:__wf_atom_9b5dcd3b(nil, false)
				end
			end

			while __wf_atom_7e8ad928(v39) do
				Sleep(0)
				v39 = fn12() -- inferred equivalent call
			end

			v27 = gRegion:__wf_atom_ef7900cf()
			v21 = gRegion:__wf_atom_d52d8448()

			if not (__wf_atom_7e8ad928(v39) or __wf_atom_7e8ad928(v39:CameraControl())) then
				v39:CameraControl():__wf_atom_25382a0d(1, false)
			end

			v10:__wf_atom_707fb30f(false)
			v10:__wf_atom_8c9ce280(false)

			for i = 1, #v27 do
				if __wf_atom_7e8ad928(v27[i]) then
					continue
				end

				local __wf_atom_a96eb2aa = v27[i]:__wf_atom_a96eb2aa()

				if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
					continue
				end

				local playerAvatar = __wf_atom_a96eb2aa:GetPlayerAvatar(0)

				if not __wf_atom_7e8ad928(playerAvatar) then
					playerAvatar:MotionControl():__wf_atom_99fc7a82(false)
				end
			end

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar(v11)
			end

			v18 = 4
			gGameRules:SetNetPersistentVar(v19, 4)
		end
	elseif v18 == 1 then
		if not v38 then
			v11:__wf_atom_9b5dcd3b(fightIntroAnim, false, 4, 1, true)
			v11:__wf_atom_8914dfde(v37, 5)
		end

		while __wf_atom_7e8ad928(v39) do
			Sleep(0)
			v39 = fn12() -- inferred equivalent call
		end

		local cameraControl = v39:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			cameraControl:__wf_atom_25382a0d(0.7, false)
		end

		v39:MotionControl():__wf_atom_99fc7a82(true)

		if not v38 then
			fn(v11, false, 6, 0.6)
			v32:__wf_atom_f173c8ad(false)
		end
	elseif v18 == 2 then
		if not v38 then
			v11:__wf_atom_9b5dcd3b(fightIntroAnim, false, 4, 1, true)
			v11:__wf_atom_8914dfde(v37, 5)
			fn(v11, false, 6, 0.6)

			if not gRegion:__wf_atom_0a6a5887(Symbol("FightIntroCinematic")):__wf_atom_7d4910e4() then
				v32:__wf_atom_f173c8ad(false)
			end
		end
	elseif v18 == 3 then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FightIntroCinematic"))

		if not v38 then
			v11:__wf_atom_9b5dcd3b(fightIntroAnim, false, 4, 1, true)
			v11:__wf_atom_8914dfde(v37, 5)
			fn(v11, false, 6, 0.6)

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887:ReinitializeGreenRoom()

				while not (__wf_atom_0a6a5887:__wf_atom_7d4910e4() or __wf_atom_0a6a5887:__wf_atom_e9546dc6()) do
					Sleep(0)
				end

				while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
					Sleep(0)
				end

				v11:__wf_atom_9b5dcd3b(nil, false)
			end
		end

		while __wf_atom_7e8ad928(v39) do
			Sleep(0)
			v39 = fn12() -- inferred equivalent call
		end

		v27 = gRegion:__wf_atom_ef7900cf()
		v21 = gRegion:__wf_atom_d52d8448()

		if not (__wf_atom_7e8ad928(v39) or __wf_atom_7e8ad928(v39:CameraControl())) then
			v39:CameraControl():__wf_atom_25382a0d(1, false)
		end

		for i = 1, #v27 do
			if __wf_atom_7e8ad928(v27[i]) then
				continue
			end

			local __wf_atom_a96eb2aa = v27[i]:__wf_atom_a96eb2aa()

			if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
				continue
			end

			local playerAvatar = __wf_atom_a96eb2aa:GetPlayerAvatar(0)

			if not __wf_atom_7e8ad928(playerAvatar) then
				playerAvatar:MotionControl():__wf_atom_99fc7a82(false)
			end
		end
	end
end

local function fn14(object, p, p2)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_92aa9d91 = object:__wf_atom_92aa9d91()

		if p == 0 and p2 == 0 then
			__wf_atom_92aa9d91:__wf_atom_5b5911cb(Resource(__wf_atom_92aa9d91:__wf_atom_1bb5b1ff()):__wf_atom_ab10ec5a())
			__wf_atom_92aa9d91:__wf_atom_35df58c3(0)
		else
			__wf_atom_92aa9d91:__wf_atom_5b5911cb(p)
			__wf_atom_92aa9d91:__wf_atom_35df58c3(p2)
		end
	end
end

local function fn15(p, p2, p3)
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	if not __wf_atom_7e8ad928(__wf_atom_3c8e1a7a) then
		v29 = #__wf_atom_3c8e1a7a
	end

	module2.EndBossFight("GARREN")
	module2.StartBossFight("GARREN", v29)
	v7 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	v27 = gRegion:__wf_atom_ef7900cf()
	v21 = gRegion:__wf_atom_d52d8448()

	if p3 then
		fn6()
		fn7(p2)
		_T.deoraFightSequence = false
	else
		fn6()
		fn7(p2)
		_T.deoraFightSequence = true
	end

	if not p2 then
		v31 = gRegion:__wf_atom_0a6a5887(Symbol("HealedGarren"))
		v32 = gRegion:__wf_atom_0a6a5887(Symbol("PartiallyCorruptedGarren"))
		v33 = v32:__wf_atom_a2a18137()
		v34 = v32:__wf_atom_2f2bada0()

		if not p3 then
			v2 = gRegion:__wf_atom_0a6a5887(Symbol(introtriggerTag))
			v31:SetVisibility(false)
		end

		v3 = gRegion:__wf_atom_0a6a5887(Symbol(arenaEntranceBlockerTag))
		v35 = gRegion:__wf_atom_0a6a5887(Symbol("ChildDeora"))
		position = v35:GetPosition()
		v36 = v35:__wf_atom_dc309f8a()
	end

	v35 = gRegion:__wf_atom_0a6a5887(Symbol("ChildDeora"))
	position = v35:GetPosition()
	v36 = v35:__wf_atom_dc309f8a()

	if __wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(v31) or __wf_atom_7e8ad928(v32) then
		__wf_atom_f2daf912("Start intro trigger or arena entrance blocker is missing")
	elseif not p then
		if p3 then
			v28:SetModeState(5)
		else
			v28:SetModeState(1)
		end
	end
end

local function fn16(_, p)
	if not gRegion:IsMaster() then
		if __wf_atom_7e8ad928(v2) then
			v2 = gRegion:__wf_atom_0a6a5887(Symbol(introtriggerTag))
		end

		if __wf_atom_7e8ad928(v3) then
			v3 = gRegion:__wf_atom_0a6a5887(Symbol(arenaEntranceBlockerTag))
		end

		if __wf_atom_7e8ad928(v31) then
			v31 = gRegion:__wf_atom_0a6a5887(Symbol("HealedGarren"))
			v31:SetVisibility(false)
		end

		if __wf_atom_7e8ad928(v32) then
			v32 = gRegion:__wf_atom_0a6a5887(Symbol("PartiallyCorruptedGarren"))
		end

		if p then
			Sleep(1)
		end

		if __wf_atom_7e8ad928(v11) then
			v11 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraAvatar"))
		end

		if __wf_atom_7e8ad928(v9) then
			v9 = gRegion:__wf_atom_0a6a5887(Symbol("GarrenRood"))
		end
	end
end

local function fn17(modeState2, p, p2)
	if modeState2 < 7 then
		if v30 ~= true then
			v30 = true
		end
	elseif v30 ~= false then
		v30 = false
	end

	if gRegion:IsMaster() then
		if modeState2 >= 2 and modeState2 <= 7 then
			if not __wf_atom_7e8ad928(v9) then
				v9:__wf_atom_cecb2d55(v15, modeState2)
			end

			if not __wf_atom_7e8ad928(v11) then
				v11:__wf_atom_cecb2d55(v15, modeState2)
			end
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not (p2 or __wf_atom_7e8ad928(v14[modeState2])) then
			module2.SetBossFightStage("GARREN", v14[modeState2].statsName)
		end

		if modeState2 == 1 then
			fn8(v11, true)
			fn8(v9, true)
			v32:__wf_atom_f173c8ad(false)
			v10:__wf_atom_707fb30f(true)
			v10:__wf_atom_8c9ce280(true)
			module2.AddBossFightNpcEventTracking("GARREN", v11)
			module2.AddBossFightNpcEventTracking("GARREN", v9)
		elseif modeState2 == 2 then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("RestrictAbilities"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887:Enable()
			end

			local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
			__wf_atom_d2b2176d:Unequip(0, 0)

			while
				not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
				and not __wf_atom_c4f78a8f:IsKilled()
				and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14
			do
				Sleep(0)
			end

			EnableBlightZoneRespawning()
			local v38 = v18

			for i = 1, v38 do
				v18 = i
				fn13(p2, i ~= v38)
			end

			v18 = v38
		elseif modeState2 == 3 then
			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("RestrictAbilities"))

			for _, v38 in ipairs(__wf_atom_2226b35c) do
				if not __wf_atom_7e8ad928(v38) then
					v38:Disable()
				end
			end

			v11:SetBlackboardBool(Symbol("IsInCombat"), true)
			v9:__wf_atom_15b36b95(false)
			v11:__wf_atom_15b36b95(true)
			__wf_atom_c4f78a8f:__wf_atom_cf966a74(v)

			for i = 1, #v27 do
				fn14(v27[i], deoraCustomLockOnRadius, 0)
			end

			fn10()
			fn8(v11, false)
			fn8(v9, true)

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar(v11)
			end

			if not p2 then
				fn2()
			end

			module2.ReplicateLogEvent("STAG_QUEST", "StartDeoraFight")
		elseif modeState2 == 4 then
			fn14(__wf_atom_c4f78a8f, 0, 0)
			fn8(v9, true)
			fn8(v11, true)

			if not p2 then
				v11:__wf_atom_7470861b():__wf_atom_befe3998(true)
			end

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar()
			end

			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraGroundDeco"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887:Destroy()
			end

			fn9()
			module2.ReplicateLogEvent("STAG_QUEST", "StartDeoraRescue")
		elseif modeState2 == 5 then
			module.SetImmunity(v9, true)
			v9:SetVisibility(true)
			v9:__wf_atom_15b36b95(true)
			v9:__wf_atom_d1b42aad(true)
			v9:__wf_atom_30964595(true)
			v9:SetDisableGravity(false)
			v9:__wf_atom_0ed81088(true)
			v9:SetBlackboardBool(Symbol("CanFight"), false)
			fn4(false)
			v11:__wf_atom_15b36b95(false)
			v11:__wf_atom_d1b42aad(false)
			v11:__wf_atom_30964595(false)
			v11:SetDisableGravity(true)
			v11:__wf_atom_0ed81088(false)
			v11:SetHealth(v11:GetMaxHealth())
			v11:SetVisibility(false)
			print("CheckedPointed")
			_T.disableNightfoldCombatCheck = true
		elseif modeState2 == 6 then
			_T.disableNightfoldCombatCheck = false
			v9:SetVisibility(true)
			v9:__wf_atom_15b36b95(true)
			v9:__wf_atom_d1b42aad(true)
			v9:__wf_atom_30964595(true)
			v9:SetDisableGravity(false)
			v9:__wf_atom_0ed81088(true)
			fn8(v9, false)
			fn4(false)
			RevivePreDeathPlayers()

			for i = 1, #v27 do
				fn14(v27[i], garrenCustomLockOnRadius, garrenCameraDistOffset)
			end

			v9:SetBlackboardBool(Symbol("CanFight"), true)

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar(v9)
			end

			if p then
				v11:SetMeshScale(1)
			end

			v11:__wf_atom_15b36b95(false)
			v11:__wf_atom_d1b42aad(false)
			v11:__wf_atom_30964595(false)
			v11:SetDisableGravity(true)
			v11:__wf_atom_0ed81088(false)
			v11:SetHealth(v11:GetMaxHealth())

			if not p2 then
				fn2()
			end

			module2.ReplicateLogEvent("STAG_QUEST", "StartStagFight")
			fn10()
		elseif modeState2 == 7 then
			v11:SetVisibility(false)
			v11:__wf_atom_d1b42aad(true)
			v11:__wf_atom_30964595(true)
			v11:SetDisableGravity(false)
			v11:__wf_atom_0ed81088(true)
			v11:SetFaction(Symbol("TENNO"))
			v9:__wf_atom_15b36b95(false)
			v9:SetBlackboardBool(Symbol("CanFight"), false)
			RevivePreDeathPlayers()
			__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(true)
			__wf_atom_c4f78a8f:Heal(__wf_atom_c4f78a8f, __wf_atom_c4f78a8f:GetMaxHealth())

			for i = 1, #v27 do
				fn14(v27[i], 0, 0)
			end

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar()
			end

			if not __wf_atom_7e8ad928(v9) then
				local __wf_atom_e55d02aa = v9:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

				if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
					__wf_atom_e55d02aa:__wf_atom_2ffcdee6()
				end
			end

			if not (p2 or p) then
				local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("HealGarrenCin"))

				if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(false)
				else
					__wf_atom_0a6a5887:FirePort("StartPlaying")
					v11:__wf_atom_d2b2176d():__wf_atom_f5bb7c84(0, 1)
					v11:__wf_atom_d2b2176d():__wf_atom_f5bb7c84(1, 1)

					while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
						Sleep(0)
					end
				end
			end

			while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
				__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			end

			__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(true)
			__wf_atom_c4f78a8f:CameraControl():__wf_atom_25382a0d(0.7, false)

			if not __wf_atom_7e8ad928(v9) then
				v9:SetVisibility(false)
				v9:__wf_atom_d1b42aad(false)
				v9:__wf_atom_30964595(false)
				v9:SetDisableGravity(true)
				v9:__wf_atom_0ed81088(false)
				v9:Destroy()
			end

			if not __wf_atom_7e8ad928(v31) then
				local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightGarren"))
				v31:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
				v31:SetVisibility(true)
			end

			if not __wf_atom_7e8ad928(v11) then
				local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightDeora"))
				v11:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
				v11:SetVisibility(true)
			end

			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightConvoTrigger"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887:Enable()
			end

			fn9()

			if v30 ~= false then
				v30 = false
			end

			local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("RestrictNightfold"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
				__wf_atom_0a6a5887_2:Disable()
			end

			DisableBlightZoneRespawning()
			module2.EndBossFightNpcEventTracking("GARREN", v11)
			module2.EndBossFightNpcEventTracking("GARREN", v9)
			module2.EndBossFight("GARREN")

			if p2 or p then
				Sleep(0)
				v11:__wf_atom_d2b2176d():__wf_atom_f5bb7c84(0, 1)
				v11:__wf_atom_d2b2176d():__wf_atom_f5bb7c84(1, 1)
			end

			module2.ReplicateLogEvent("STAG_QUEST", "EndStagFight")
			module4.NotifyBossComplete()
		end
	else
		fn16()
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
			Sleep(0)
			__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		end

		if modeState2 == 1 then
			v32:__wf_atom_f173c8ad(false)
		elseif modeState2 == 2 then
			if v30 ~= true then
				v30 = true
			end

			__wf_atom_c4f78a8f:__wf_atom_aeb02c14(v)
			local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
			__wf_atom_d2b2176d:Unequip(0, 0)

			while
				not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
				and not __wf_atom_c4f78a8f:IsKilled()
				and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14
			do
				Sleep(0)
			end

			EnableBlightZoneRespawning()
			local v38 = v18

			for i = 1, v38 do
				v18 = i
				fn13(p2, i ~= v38)
			end

			v18 = v38
		elseif modeState2 == 3 then
			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar(v11)
			end

			v11:__wf_atom_15b36b95(true)
			__wf_atom_c4f78a8f:__wf_atom_cf966a74(v)
		elseif modeState2 == 4 then
			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar()
			end

			v11:__wf_atom_15b36b95(false)
		elseif modeState2 == 6 then
			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar(v9)
			end

			v9:__wf_atom_15b36b95(true)
			v11:__wf_atom_15b36b95(false)
			v11:__wf_atom_d1b42aad(false)
			v11:__wf_atom_30964595(false)
			v11:SetDisableGravity(true)
			v11:__wf_atom_0ed81088(false)

			if not p2 then
				fn2()
			end
		elseif modeState2 == 7 then
			v11:__wf_atom_d1b42aad(true)
			v11:__wf_atom_30964595(true)
			v11:SetDisableGravity(false)
			v11:__wf_atom_0ed81088(true)

			if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
				_T.SetupBossAvatar()
			end

			if not __wf_atom_7e8ad928(v9) then
				v9:__wf_atom_15b36b95(false)
			end

			fn14(__wf_atom_c4f78a8f, 0, 0)

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f:Heal(__wf_atom_c4f78a8f, __wf_atom_c4f78a8f:GetMaxHealth())
			end

			if not (p2 or p) then
				local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("HealGarrenCin"))

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
						Sleep(0)
					end
				end
			end

			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			end

			__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(true)
			local cameraControl = __wf_atom_c4f78a8f:CameraControl()

			if not __wf_atom_7e8ad928(cameraControl) then
				cameraControl:__wf_atom_25382a0d(0.7, false)
			end

			if v30 ~= false then
				v30 = false
			end

			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("RestrictNightfold"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887:Disable()
			end

			DisableBlightZoneRespawning()
		end
	end
end

local function fn18()
	__wf_atom_4f3659d1("Lady Of Dendria Spawn Controls")

	if __wf_atom_80afb308("Spawn Lady") then
		fn7()
		v11:__wf_atom_cecb2d55(v15, 3)
	end

	__wf_atom_78aeed31()

	if __wf_atom_80afb308("Lower Deoras Health") and not __wf_atom_7e8ad928(v11) then
		v11:SetHealth(maxHealth2 * v16[3])
	end

	__wf_atom_78aeed31()

	if __wf_atom_80afb308("Attach Deora Boss Tester") then
		v11:Attach(Type(v25), EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	__wf_atom_07947f07()

	if __wf_atom_7e8ad928(v11) then
		if __wf_atom_7e8ad928(v11) then
			__wf_atom_05a856ad("Deora Avatar has been destroyed something has gone wrong")
			print("Deora Avatar has been destroyed something has gone wrong")
		end
	elseif __wf_atom_2ebdf85a("lady Stats") then
		local __wf_atom_c6f1f83d = v11:__wf_atom_c6f1f83d()
		__wf_atom_05a856ad("Lady Of Dendria Health: " .. __wf_atom_c6f1f83d .. "/" .. maxHealth2 .. " (" .. math.max(__wf_atom_c6f1f83d / maxHealth2, 0) .. ")")
		__wf_atom_05a856ad("Fight STATE: " .. modeState)

		if modeState == 2 then
			__wf_atom_05a856ad("Intro SubState: " .. v18)
		end

		__wf_atom_05a856ad("BB Active Phase: " .. v11:__wf_atom_ccd337ec(v15))
	end
end

local function fn19(p, p2) -- 2 equivalent calls inferred from this helper
	local _, v38 = __wf_atom_d2655286(p, p2 or false)
	return v38
end

local function fn20()
	__wf_atom_4f3659d1("Garren Spawn Controls")

	if __wf_atom_80afb308("Spawn Garren") then
		fn6()
		v9:__wf_atom_cecb2d55(v15, 3)
	end

	__wf_atom_78aeed31()

	if __wf_atom_80afb308("Lower Garrens Health") and not __wf_atom_7e8ad928(v9) then
		v9:SetHealth(maxHealth * v16[6])
	end

	local v38 = fn19("Freeze Garren", v23) -- inferred equivalent call

	if v38 ~= v23 then
		v23 = v38

		if not __wf_atom_7e8ad928(v9) then
			if v23 then
				v9:SetBlackboardBool(Symbol("CanFight"), false)
			elseif v23 == false then
				v9:SetBlackboardBool(Symbol("CanFight"), true)
			end
		end
	end

	__wf_atom_78aeed31()
	local v39 = fn19("Set Immunity", v24) -- inferred equivalent call

	if v39 ~= v24 then
		v24 = v39

		if v24 then
			fn8(v9, v24)
		elseif v24 == false then
			fn8(v9, v24)
		end
	end

	__wf_atom_78aeed31()

	if __wf_atom_80afb308("Attach Garren Boss Tester") and not __wf_atom_7e8ad928(v9) then
		v9:Attach(Type(v26), EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	__wf_atom_07947f07()

	if __wf_atom_7e8ad928(v9) then
		if __wf_atom_7e8ad928(v9) then
			__wf_atom_05a856ad("Garren Avatar has been destroyed something has gone wrong")
			print("Garren Avatar has been destroyed something has gone wrong")
		end
	elseif __wf_atom_2ebdf85a("Garren Stats") then
		local __wf_atom_c6f1f83d = v9:__wf_atom_c6f1f83d()
		__wf_atom_05a856ad("Garren Health: " .. __wf_atom_c6f1f83d .. "/" .. maxHealth .. " (" .. math.max(__wf_atom_c6f1f83d / maxHealth, 0) .. ")")
		__wf_atom_05a856ad("Fight STATE: " .. modeState)

		if modeState == 2 then
			__wf_atom_05a856ad("Intro SubState: " .. v18)
		end

		__wf_atom_05a856ad("BB Active Phase: " .. v9:__wf_atom_ccd337ec(v15))
	end
end

local function fn21()
	__wf_atom_4f3659d1("Fight Controls")
	__wf_atom_05a856ad("Select Fight Stage:")

	if __wf_atom_7e8ad928(names) then
		names = {}

		for _, v38 in ipairs(v14) do
			table.insert(names, v38.name)
		end
	end

	v22 = __wf_atom_fdfab732("", v22, names)
	__wf_atom_78aeed31()

	if __wf_atom_80afb308("Skip to selected") and modeState ~= v22 then
		modeState = v22
		gRegion:__wf_atom_c4f78a8f():MotionControl():__wf_atom_99fc7a82(false)
		gRegion:__wf_atom_c4f78a8f():CameraControl():__wf_atom_25382a0d(1, true)

		if modeState ~= 2 then
			v32:SetVisibility(false)
			v32:__wf_atom_3564c669(0)
			v10:__wf_atom_707fb30f(false)
			v10:__wf_atom_8c9ce280(false)
		end

		if modeState ~= 2 and modeState ~= 3 and modeState ~= 4 then
			v9:SetVisibility(true)
			v9:__wf_atom_d1b42aad(true)
			v9:__wf_atom_30964595(true)
			v9:SetDisableGravity(false)
			fn4(false)
			module.TaggedFirePorts(Symbol("BossFightDynMusic"), "TriggerPort")
		end

		if modeState ~= 2 and modeState ~= 3 then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraGroundDeco"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887:Destroy()
			end
		end

		return true
	else
		if __wf_atom_80afb308("Previous Phase") then
			v28:SetModeState((math.max(modeState - 1, 2)))
		end

		__wf_atom_78aeed31()

		if __wf_atom_80afb308("NextPhase") then
			v28:SetModeState((math.min(modeState + 1, 7)))
			gRegion:__wf_atom_c4f78a8f():MotionControl():__wf_atom_99fc7a82(false)
			gRegion:__wf_atom_c4f78a8f():CameraControl():__wf_atom_25382a0d(1, true)
		end

		__wf_atom_78aeed31()

		if __wf_atom_80afb308("Reset") then
			ResetFight()
		end

		return false
	end
end

local function fn22()
	local v38

	if __wf_atom_489de21b("Boss Spawn Settings") then
		if v14[modeState] == nil then
			__wf_atom_05a856ad("Unknown Mode State " .. tostring(modeState))
			__wf_atom_48bcafdc()
			return
		else
			__wf_atom_05a856ad("Fight Stage: " .. modeState .. " - " .. v14[modeState].name)
			__wf_atom_07947f07()
			fn20()
			__wf_atom_07947f07()
			fn18()
			__wf_atom_07947f07()
			v38 = fn21()
		end
	else
		v38 = false
	end

	__wf_atom_48bcafdc()

	if v38 then
		fn17(modeState)
	end
end

local function fn23()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightCin"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		if __wf_atom_0a6a5887:__wf_atom_7d4910e4() or __wf_atom_0a6a5887:__wf_atom_e9546dc6() then
			while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
				Sleep(0)
			end
		else
			return
		end
	end

	fn10()

	if not _T.GarrenFightEndMonitor then
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("HealedGarren"))
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightGarren"))

		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_2) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_3)) then
			__wf_atom_0a6a5887_2:SetPosition(__wf_atom_0a6a5887_3:GetPosition())
			__wf_atom_0a6a5887_2:__wf_atom_9b788a35(__wf_atom_0a6a5887_3:__wf_atom_dc309f8a())
			__wf_atom_0a6a5887_2:SetVisibility(true, true)
		end

		local __wf_atom_0a6a5887_4 = gRegion:__wf_atom_0a6a5887(Symbol("DeoraAvatar"))
		local __wf_atom_0a6a5887_5 = gRegion:__wf_atom_0a6a5887(Symbol("PostFightDeora"))

		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_4) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_5)) then
			__wf_atom_0a6a5887_4:SetVisibility(false)
			__wf_atom_0a6a5887_4:Teleport(__wf_atom_0a6a5887_5:GetPosition(), __wf_atom_0a6a5887_5:__wf_atom_dc309f8a())
			__wf_atom_0a6a5887_4:SetPosition(__wf_atom_0a6a5887_5:GetPosition())
			__wf_atom_0a6a5887_4:__wf_atom_9b788a35(__wf_atom_0a6a5887_5:__wf_atom_dc309f8a())
			__wf_atom_0a6a5887_4:SetVisibility(true, true)
		end

		module.Fade(false, 0.5)
	end

	flag = true
end

local function fn24(_)
	v27 = gRegion:__wf_atom_ef7900cf()
	v21 = gRegion:__wf_atom_d52d8448()
	module3.UpdateBlightZone()

	if modeState == 1 and v2:IsEnabled() == false then
		v28:SetModeState(2)
	elseif modeState == 2 and v18 < 4 then
		if v18 == 0 and fn11(v27, v20[1]) then
			v18 = 1
			gGameRules:SetNetPersistentVar(v19, 1)
			fn13()
		elseif v18 == 1 and fn11(v27, v20[2]) then
			v18 = 2
			gGameRules:SetNetPersistentVar(v19, 2)
			fn13()
		elseif v18 == 2 and fn11(v27, v20[3]) then
			v18 = 3
			gGameRules:SetNetPersistentVar(v19, 3)
			fn13()
		end
	elseif modeState == 2 and v18 >= 4 then
		v28:SetModeState(3)
	elseif modeState < 7 and not (__wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v11)) then
		if modeState == 3 then
			if v11:__wf_atom_bedb4e3f() or v11:__wf_atom_c6f1f83d() <= maxHealth2 * v16[modeState] then
				v28:SetModeState(4)
			end
		elseif modeState == 4 then
			if v11:__wf_atom_52077f7a(Symbol("DeoraHealed")) == true then
				v28:SetModeState(6)
			end
		elseif modeState == 5 then
			if fn11(v27, v20[2]) then
				v8:__wf_atom_f54283ea()
				module.TaggedFirePorts(Symbol("BossFightDynMusic"), "TriggerPort")
				v28:SetModeState(6)
			end
		elseif modeState == 6 and v9:__wf_atom_c6f1f83d() <= maxHealth * v16[modeState] then
			v28:SetModeState(7)
		end
	elseif modeState == 7 then
		fn23()
	end

	fn22()
end

local function fn25()
	if not gRegion:IsMaster() then
		v27 = gRegion:__wf_atom_ef7900cf()
		v21 = gRegion:__wf_atom_d52d8448()

		if modeState == 2 and v18 < 4 then
			if gGameRules:__wf_atom_d163c8e5(v19) == 1 and v18 == 0 then
				v18 = 1
				fn13()
			elseif gGameRules:__wf_atom_d163c8e5(v19) == 2 and v18 == 1 then
				v18 = 2
				fn13()
			elseif gGameRules:__wf_atom_d163c8e5(v19) == 3 and v18 == 2 then
				v18 = 3
				fn13()
			end
		else
			if modeState == 2 and v18 >= 4 then
				return
			end

			if modeState == 7 then
				fn23()
			end
		end
	end
end

function GarrenFight()
	v28 = module.CreateModeMgr(fn17)

	if gRegion:IsMaster() then
		fn15(false, false)
	end

	fn16(false, true)
	local flag2 = false
	gGameRules2 = gGameRules

	repeat
		Sleep(0)

		while __wf_atom_7e8ad928(gGameRules2) do
			Sleep(0)
			gGameRules2 = gGameRules

			if __wf_atom_7e8ad928(gGameRules2) then
				continue
			end

			flag2 = true

			while not gGameRules2:__wf_atom_adfb052a() do
				Sleep(0)
			end
		end

		if flag2 then
			print("Demo: Host migration")
			v18 = gGameRules:__wf_atom_d163c8e5(v19, 0)

			if gPromotedToHost then
				fn15(true, false)
			end

			fn16(true, true)
		end

		if not gClient:__wf_atom_a1d07c1c() then
			v28:Update(flag2)
			modeState = v28:GetModeState()

			if gRegion:IsMaster() then
				fn24(__wf_atom_03df4e1d())
			end

			fn25(__wf_atom_03df4e1d())
			flag2 = false
		end
	until flag

	if v30 == false then
		return
	end

	v30 = false
end

function SwitchGarrenMeshes()
	if __wf_atom_7e8ad928(v31) or __wf_atom_7e8ad928(v9) then
		return
	end

	v31:SetVisibility(true)
	v9:SetVisibility(false)
end

function OnPreDeath(object)
	if not __wf_atom_7e8ad928(object) then
		local v38 = 1.5
		local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(Symbol("ModeState"), 0)
		local v39 = __wf_atom_d163c8e5 > 4

		if not v39 then
			object:__wf_atom_8914dfde("DeoraWeaponBreak", 5)
		end

		local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
		SF.__wf_atom_4659f336(__wf_atom_9fb9a1d6, false, true)

		if v39 then
			if __wf_atom_d163c8e5 == 6 then
				object:SetVisibility(false)
			end
		else
			local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
			local __wf_atom_8e4cf043 = object:__wf_atom_8e4cf043(Symbol("GAME_R1_WEAPON1"))
			gRegion:CreateEntity(v13, __wf_atom_1c374cc9, __wf_atom_8e4cf043)
			fn(object, true, 15, 0.6)

			while v38 > 0 do
				Sleep(0)
				v38 -= __wf_atom_03df4e1d()
			end

			local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(finisherContextActionType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Enable()

				if not __wf_atom_7e8ad928(killObjectiveMarkerType) then
					local v40 = __wf_atom_bb3e7833:Attach(
						killObjectiveMarkerType,
						EMPTY_SYMBOL,
						__wf_atom_bb3e7833:__wf_atom_d32e11f8(),
						__wf_atom_80368bb1
					)
					v40:__wf_atom_30972565(false)
					v40:__wf_atom_14f387e1(Range(1, 5000))
				end
			end
		end
	end
end

function OnStabilityChanged()
	_T.deoraZeroStability = true
end

function EnableBlightZoneRespawning()
	if __wf_atom_7e8ad928(v4) then
		v4 = gRegion:__wf_atom_0a6a5887(disabledShrineTag)
	end

	module3.ActivateBlightZone(v4, true, true, false, ResetFight)
end

function DisableBlightZoneRespawning()
	module3.DeactivateBlightZone(true)
end

function ResetFight()
	print("ResetFight")
	local v38 = v28:GetModeState() == 6
	module.TaggedFirePorts(Symbol("ResetBossFight"), "TriggerPort")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OpenVineWall"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_f0368285()
	end

	module.TaggedFirePorts(arenaWarpPointTag, "Disable")
	module.TaggedFirePorts(arenaEntranceBlockerTag, "Disable")
	module.TaggedFirePorts(arenaEntranceTriggerTag, "Enable")
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local v39 = false

	while not v39 do
		v39 = true

		for i = 1, #__wf_atom_3c8e1a7a do
			local flag2 = false

			for j = 1, #v27 do
				if
					__wf_atom_7e8ad928(__wf_atom_3c8e1a7a[i])
					or __wf_atom_3c8e1a7a[i]:__wf_atom_50a7d83e() ~= v27[j]
				then
					continue
				end

				flag2 = true
				break
			end

			if not flag2 then
				continue
			end

			v39 = false
			break
		end

		Sleep(0.2)
	end

	if v38 then
		modeState = 5
	else
		v18 = 0
		modeState = 0
		gGameRules:SetNetPersistentVar(v19, v18)
		v28:SetModeState(modeState)
		v32:Teleport(v33, v34)
		v32:SetVisibility(true, true)
		v32:__wf_atom_3564c669(1)
		v32:__wf_atom_f173c8ad(false)
		v35:SetPosition(position)
		v35:__wf_atom_9b788a35(v36)
		v35:Teleport(position, v36)
		gRegion:__wf_atom_0a6a5887(Symbol("DeoraSongTrigger")):Enable()
		_T.MusicGameComplete = false
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:__wf_atom_4d75e5e7()
		gRegion:__wf_atom_dd1e4d10(v9)
	end

	if not __wf_atom_7e8ad928(v11) then
		v11:__wf_atom_4d75e5e7()
		gRegion:__wf_atom_dd1e4d10(v11)
	end

	module3.RefillHealthPotions(5)
	fn15(false, true, v38)
	fn16(false, true)
end

function RevivePreDeathPlayers()
	for i = 1, #v27 do
		if v27[i]:__wf_atom_bedb4e3f() then
			v27[i]:InstantRevive()
		end
	end
end