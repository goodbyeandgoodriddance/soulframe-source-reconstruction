local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Npc.SubbossRednightResourceSpawn")
local module3 = require("SF.Souls.Powers.EntitySoulModeScans")
local module4 = require("SF.Scripts.Libs.ChallengeLib")
local v = Symbol("BlockingBehavior")

function PostSpawn(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local v2 = nil

	for _, v3 in pairs(__wf_atom_3d96ddcd:__wf_atom_6199ef01()) do
		if v3:IsA(riderAgentType) then
			v2 = v3
		end
	end

	if __wf_atom_7e8ad928(v2) then
		print("ERROR - Mendicant Rider - No mounted agent found!")
		return
	end

	Sleep(1)
	local __wf_atom_3d96ddcd2 = v2:__wf_atom_50a7d83e():__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd2) then
		local __wf_atom_30e3d82b = __wf_atom_3d96ddcd2:__wf_atom_30e3d82b()
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("Mendicant Rider Subboss Encounter"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_30e3d82b:__wf_atom_243da0d3(__wf_atom_0a6a5887, true)
		end
	end
end

local function fn(object, __wf_atom_08baf7d0)
	local __wf_atom_c1ee12bd = object:__wf_atom_c1ee12bd(object:__wf_atom_dc309f8a())
	local v2 = __wf_atom_9341614d(__wf_atom_08baf7d0, __wf_atom_c1ee12bd)

	if math.abs(v2.z) > math.abs(v2.x) and math.abs(v2.z) > 0.1 then
		if v2.z < 0 then
			return 1
		end

		return 2
	elseif math.abs(v2.x) > 0.1 then
		if v2.x < 0 then
			return 4
		end

		return 3
	else
		return 0
	end
end

function RiderHealthEqualier(object)
	Sleep(0)
	local v2 = nil

	while not (__wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		if __wf_atom_7e8ad928(v2) then
			local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

			while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
				if __wf_atom_3d96ddcd:IsA(__wf_atom_47cae841) then
					v2 = __wf_atom_3d96ddcd
					break
				else
					__wf_atom_3d96ddcd = __wf_atom_3d96ddcd:__wf_atom_3d96ddcd()
				end
			end
		end

		if not __wf_atom_7e8ad928(v2) then
			if v2:IsKilled() then
				object:Suicide()
				break
			end

			if v2:__wf_atom_bedb4e3f() then
				object:__wf_atom_7470861b():__wf_atom_befe3998(true)
				break
			end

			object:SetHealth((math.max(
				v2:__wf_atom_bb81a9df() * object:GetMaxHealth(true),
				object:__wf_atom_7470861b():__wf_atom_b221774e() + 1
			)))
			local v3 = v2:__wf_atom_7470861b():__wf_atom_5d3f45d7() / v2:__wf_atom_7470861b():__wf_atom_96e24059()
			object:__wf_atom_7470861b():__wf_atom_8577591c(v2:__wf_atom_7470861b():__wf_atom_96e24059() * v3)
		end

		Sleep(0)
	end
end

function OnDamaged(object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if object2:__wf_atom_78650070(29) then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			__wf_atom_3d96ddcd:__wf_atom_80db4712(8, 0)
		end
	end

	if object2:__wf_atom_78650070(16) or object2:__wf_atom_78650070(17) or object2:__wf_atom_78650070(19) then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			__wf_atom_3d96ddcd:__wf_atom_80db4712(
				7,
				0,
				0,
				fn(__wf_atom_3d96ddcd, object2:__wf_atom_08baf7d0()),
				object2:__wf_atom_ae3d1b47(),
				0
			)
		end
	end

	if object2:__wf_atom_78650070(18) then
		__wf_atom_7e8ad928((object:__wf_atom_3d96ddcd()))
	end
end

function OnMountDamaged(object)
	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if
		__wf_atom_7e8ad928(__wf_atom_9d766292)
		or __wf_atom_7e8ad928(__wf_atom_9d766292:__wf_atom_679ed446())
		or __wf_atom_7e8ad928(__wf_atom_9d766292:__wf_atom_3371f607())
	then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.bbLastDamageSource = __wf_atom_9d766292:__wf_atom_679ed446()
	__wf_atom_e919fb8e.bbLastDamageSourceObject = __wf_atom_9d766292:__wf_atom_3371f607()
end

local function fn2(object)
	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()
	local v2 = nil

	for _, v3 in pairs(__wf_atom_be0bea4a) do
		if v3:IsA(riderAvatarType) then
			v2 = v3
		end
	end

	if not __wf_atom_7e8ad928(v2) then
		return v2
	end

	print("Couldn't find attached Rider!")
end

function RunPreDeathAnimOnUnattach(object, p)
	if not __wf_atom_7e8ad928(p) then
		return
	end

	object:__wf_atom_9b5dcd3b(nil, false)
	Sleep(0)

	if not __wf_atom_7e8ad928(object) and __wf_atom_7e8ad928(p) then
		object:__wf_atom_9b5dcd3b(predeathStartAnim, false, 4, 1, false)
	end

	local v2 = 1

	while v2 > 0 do
		v2 -= __wf_atom_084b3e93()

		if __wf_atom_7e8ad928(object) or object:__wf_atom_c138b19b(predeathStartAnim) or not __wf_atom_7e8ad928(p) then
			break
		end

		object:__wf_atom_9b5dcd3b(predeathStartAnim, false, 4, 1, false)
		Sleep(0)
	end
end

local function fn3(instance, object)
	local __wf_atom_f51f1faa = instance:__wf_atom_f51f1faa()

	if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
		instance:__wf_atom_8391ca00(__wf_atom_f51f1faa:__wf_atom_382d2379())
		instance:__wf_atom_5047e0ed(true)
		__wf_atom_f51f1faa:__wf_atom_41296388(false)
		__wf_atom_f51f1faa:__wf_atom_0bd69c3e(true, 7, false)
	end

	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()
	instance:__wf_atom_2f91774e()
	instance:__wf_atom_921c1a5f(nil, false, 3, 2)
	instance:__wf_atom_8d98f2fc(false, false, false)
	__wf_atom_7470861b:__wf_atom_9fba31e6(Symbol("POST_DEATH_ABILITY_ACTIVE"), 26, 6, 0)
	__wf_atom_7470861b:__wf_atom_77b5f32e(Symbol("POST_DEATH_ABILITY_ACTIVE"))

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v, instance, 1)
	end

	gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_b7b3b56a(instance)
	Sleep(0)

	if __wf_atom_7e8ad928(instance) or instance:IsKilled() then
		return
	end

	local previousRider = fn2(instance)
	instance:GetOffVehicle(previousRider)
	Sleep(0.1)
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.previousRider = previousRider

	if not __wf_atom_7e8ad928(predeathStartAnim) then
		local __wf_atom_921c1a5f = instance:__wf_atom_921c1a5f(predeathStartAnim, false, 4, 1, true)

		if __wf_atom_7e8ad928(object) then
			Sleep(__wf_atom_921c1a5f)
		else
			object:__wf_atom_921c1a5f(predeathStartAnim, false, 4, 1, true)
			Sleep(__wf_atom_921c1a5f - __wf_atom_921c1a5f / 2)
			object:SetVisibility(true)
			instance:SetVisibility(false)
			Sleep(__wf_atom_921c1a5f - __wf_atom_921c1a5f / 2)
		end
	end

	if not __wf_atom_7e8ad928(predeathLoopAnim) then
		instance:__wf_atom_921c1a5f(predeathLoopAnim, false, 4, 2, true)
	end
end

function _LocalShrink(object)
	Sleep(0)
	local __wf_atom_c082fc3d = object:__wf_atom_c082fc3d()
	local shrinkTime = shrinkTime

	while shrinkTime > 0 and not __wf_atom_7e8ad928(object) do
		shrinkTime -= __wf_atom_084b3e93()
		object:SetMeshScale(__wf_atom_104bfe98(meshScaleReduction, __wf_atom_c082fc3d, shrinkTime / 2))
		Sleep(0)
	end

	object:SetMeshScale(meshScaleReduction)
end

function OnMountPreDeath(instance)
	if not gRegion:IsMaster() then
		return
	end

	fn3(instance)
	local previousRider = instance:__wf_atom_e919fb8e().previousRider

	if not __wf_atom_7e8ad928(previousRider) then
		instance:GetOffVehicle(previousRider)
		previousRider:__wf_atom_7470861b():__wf_atom_befe3998(false)
		previousRider:Suicide()
	end

	instance:Attach(horsePurifySseType, Symbol("GAME_C1_HEAD"), __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance, 1)
	instance:__wf_atom_bb3e7833(horsePurifySseType)
	local recoveryTime = recoveryTime

	while recoveryTime > 0 and not __wf_atom_7e8ad928(instance) do
		recoveryTime -= __wf_atom_084b3e93()

		if __wf_atom_7e8ad928((instance:__wf_atom_bb3e7833(horsePurifySseType))) then
			return
		else
			Sleep(0)
		end
	end

	if not (__wf_atom_7e8ad928(instance) or instance:IsKilled()) then
		instance:__wf_atom_70c29967(1, 0, false)
		Sleep(1)
		instance:Destroy()
	end
end

function OnMountPreDeath_Warsong(instance)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_c082fc3d = instance:__wf_atom_c082fc3d()
	local v2 = module.WaitForAiDir()
	local __wf_atom_68de036a = gRegion:__wf_atom_c4f78a8f():__wf_atom_68de036a()
	local __wf_atom_a2a18137 = instance:__wf_atom_a2a18137()
	local __wf_atom_2f2bada0 = instance:__wf_atom_2f2bada0()

	if __wf_atom_7e8ad928(ridableHorseAgent) then
		print("ERROR - Failed to spawn ridable horse from Warsong Mendicant Rider.")
		return
	end

	local __wf_atom_402b3832 = v2:__wf_atom_402b3832(
		ridableHorseAgent,
		__wf_atom_a2a18137,
		__wf_atom_2f2bada0,
		EMPTY_SYMBOL,
		__wf_atom_68de036a
	)

	if __wf_atom_7e8ad928(__wf_atom_402b3832) then
		print("ERROR - Failed to spawn ridable horse from Warsong Mendicant Rider.")
		return
	end

	local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()
	__wf_atom_50a7d83e:SetVisibility(false)
	__wf_atom_50a7d83e:SetMeshScale(__wf_atom_c082fc3d, true)
	__wf_atom_50a7d83e:Teleport(__wf_atom_50a7d83e:__wf_atom_0d7d47e6(__wf_atom_a2a18137), __wf_atom_2f2bada0)
	__wf_atom_50a7d83e:__wf_atom_70f78a63(instance)
	_T.WarsongPlayerMountAvatar = __wf_atom_402b3832:__wf_atom_50a7d83e()
	instance:__wf_atom_8a035cd5(Symbol("_LocalShrink"), false)
	__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("_LocalShrink"), false)
	fn3(instance, __wf_atom_50a7d83e)
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	local previousRider = __wf_atom_e919fb8e.previousRider

	if not __wf_atom_7e8ad928(previousRider) then
		instance:GetOffVehicle(previousRider)
		previousRider:__wf_atom_7470861b():__wf_atom_befe3998(false)
		previousRider:Suicide()
	end

	Sleep(0)
	instance:__wf_atom_30d17f39(
		0,
		20,
		0,
		0,
		__wf_atom_e919fb8e.bbLastDamageSource,
		__wf_atom_e919fb8e.bbLastDamageSourceObject
	)
	instance:Destroy()
end

function StealStart(p, object)
	module3.GiveEnemyScan(p, object)

	if not __wf_atom_7e8ad928(soulStealEnvoyFX) then
		Sleep(0.3)
		object:Attach(soulStealEnvoyFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa)
	end
end

function SpawnRing(p)
	local v2 = {
		deco = mushroomDeco,
		spawn = mushroomToSpawn,
		delay = 0.5,
		variation = mushroomVariation,
		spawnDistanceFromInstigator = mushroomSpawnDistanceFromInstigator,
		waitRange = mushroomWaitRange,
		pickUp = mushroomPickup,
		sink = false,
		pickupFX = mushroomPickupFX,
		spawnSound = mushroomSpawnSound,
		finalSound = mushroomFinalSpawnSound
	}
	module2.SpawnRing(p, v2)
end

function OnPreDeathSteal(object, _)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) or __wf_atom_575542c8:IsKilled() then
		return
	end

	__wf_atom_575542c8:__wf_atom_45cf0e1a(horseBodyMesh, false, true)
	__wf_atom_575542c8:__wf_atom_8a035cd5(Symbol("_LocalShrink"), false)

	if not gRegion:IsMaster() then
		Sleep(3)
		return
	end

	local v2 = math.max(1, __wf_atom_575542c8:GetMaxHealth() * newHealthPostPredeathPct)
	__wf_atom_575542c8:SetHealth(__wf_atom_575542c8:__wf_atom_7470861b():__wf_atom_b221774e() + v2)
	__wf_atom_575542c8:SetFaction(Symbol("Neutral"))
	__wf_atom_575542c8:__wf_atom_921c1a5f(soulStealAnim, false, 3, 1, true)
	__wf_atom_575542c8:__wf_atom_d2b2176d():__wf_atom_45564ccc()
	local __wf_atom_f582136d = __wf_atom_575542c8:__wf_atom_f582136d(__wf_atom_baf9587d)

	for _, v3 in ipairs(__wf_atom_f582136d) do
		if not __wf_atom_7e8ad928(v3) then
			v3:Destroy()
		end
	end

	Sleep(0)

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	local __wf_atom_30e3d82b = __wf_atom_575542c8:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_892b354d(true)
		__wf_atom_30e3d82b:__wf_atom_c6afb966(0)
		__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(Symbol("Flee"), __wf_atom_575542c8, 1)
	end
end

function OnRiderDeath(instance)
	if instance:IsA(__wf_atom_43e0c427) and not __wf_atom_7e8ad928(instance:__wf_atom_6009c8ed()) then
		instance = instance:__wf_atom_6009c8ed()
	end

	if shouldSpawnMushroomRing then
		instance:__wf_atom_8a035cd5(Symbol("SpawnRing"), false)
	end

	if challengeTag:__wf_atom_8598f3a9() then
		module4.NotifyTagAllPlayers(challengeTag)
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:__wf_atom_7470861b():__wf_atom_befe3998(true)
	end
end