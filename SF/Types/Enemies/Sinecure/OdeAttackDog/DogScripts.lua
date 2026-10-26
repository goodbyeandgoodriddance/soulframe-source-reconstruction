local module = require("SF.Scripts.Npc.SubbossRednightResourceSpawn")
local module2 = require("SF.Souls.Powers.EntitySoulModeScans")
local module3 = require("SF.Scripts.Libs.ChallengeLib")
local v = Symbol("BlockingBehavior")

function OnPreDeath(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v2

	if __wf_atom_7e8ad928(object:__wf_atom_f51f1faa()) then
		v2 = object
	else
		v2 = object:__wf_atom_f51f1faa()
	end

	local __wf_atom_bb3e7833 = v2:__wf_atom_bb3e7833(dogHelmetType)

	if not (__wf_atom_7e8ad928(__wf_atom_bb3e7833) or __wf_atom_7e8ad928(dogHeadMesh) or __wf_atom_7e8ad928(dogHelmetDestructionType)) then
		__wf_atom_bb3e7833:__wf_atom_45cf0e1a(dogHeadMesh, false, true)
		v2:Attach(dogHelmetDestructionType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	if not gRegion:IsMaster() then
		return
	end

	object:SetFaction(Symbol("Neutral"))
	object:__wf_atom_8d98f2fc(false, false, false)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		print("DogPreDeath Agent missing!")
	else
		__wf_atom_30e3d82b:__wf_atom_892b354d(true)
		__wf_atom_30e3d82b:__wf_atom_c6afb966(0)
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(Symbol("Flee"), object, 10, 1)
	end

	object:__wf_atom_921c1a5f(nil, false, 3, 2)
	gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_b7b3b56a(object)
	Sleep(0)

	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	local __wf_atom_679ed446 = object:__wf_atom_7470861b():__wf_atom_e065f642():__wf_atom_679ed446()

	if not __wf_atom_7e8ad928(__wf_atom_679ed446) and __wf_atom_679ed446:IsA(__wf_atom_67c46eba) then
		local __wf_atom_d2b2176d = __wf_atom_679ed446:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			local __wf_atom_97c36659 = object:__wf_atom_97c36659()
			__wf_atom_d2b2176d:__wf_atom_355b9a20(__wf_atom_97c36659, object, EMPTY_SYMBOL)
			__wf_atom_d2b2176d:__wf_atom_1bdcfcae(__wf_atom_97c36659, object, object:__wf_atom_1bb5b1ff(), EMPTY_SYMBOL)
		end
	end

	object:__wf_atom_d2b2176d():__wf_atom_45564ccc()
	__wf_atom_7470861b:__wf_atom_9fba31e6(Symbol("POST_DEATH_ABILITY_ACTIVE"), 26, 6, 0)
	__wf_atom_7470861b:__wf_atom_77b5f32e(Symbol("POST_DEATH_ABILITY_ACTIVE"))

	if not __wf_atom_7e8ad928(object) and object == v2 then
		local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_baf9587d)

		for _, v3 in ipairs(__wf_atom_f582136d) do
			if not __wf_atom_7e8ad928(v3) then
				v3:Destroy()
			end
		end

		object:__wf_atom_2f91774e()
		object:__wf_atom_921c1a5f(predeathStartAnim, true, 4, 1, true)
	end

	Sleep(0)

	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local v3 = math.max(1, object:GetMaxHealth() * newHealthPostPredeathPct)
	object:SetHealth(object:__wf_atom_7470861b():__wf_atom_b221774e() + v3)
	__wf_atom_7470861b:__wf_atom_b6bcaf97(false)
end

function OnCorruptedPreDeath(object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_f51f1faa = object:__wf_atom_f51f1faa()

	if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
		object:__wf_atom_8391ca00(__wf_atom_f51f1faa:__wf_atom_382d2379())
		object:__wf_atom_5047e0ed(true)
		__wf_atom_f51f1faa:__wf_atom_41296388(false)
		__wf_atom_f51f1faa:__wf_atom_0bd69c3e(true, 7, false)
	end

	object:Attach(dogPurifySseType, Symbol("GAME_C1_HEAD"), __wf_atom_28d5d4aa, __wf_atom_80368bb1, object, 1)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	object:__wf_atom_bb3e7833(dogPurifySseType)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	object:__wf_atom_2f91774e()
	object:__wf_atom_921c1a5f(nil, false, 3, 2)
	object:__wf_atom_8d98f2fc(false, false, false)
	__wf_atom_7470861b:__wf_atom_9fba31e6(Symbol("POST_DEATH_ABILITY_ACTIVE"), 26, 6, 0)
	__wf_atom_7470861b:__wf_atom_77b5f32e(Symbol("POST_DEATH_ABILITY_ACTIVE"))

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v, object, 1)
	end

	gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_b7b3b56a(object)
	Sleep(0)

	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	object:__wf_atom_921c1a5f(predeathStartAnim, true, 4, 1, true)
	object:__wf_atom_921c1a5f(predeathLoopAnim, false, 4, 2, true)
	local recoveryTime = recoveryTime

	while recoveryTime > 0 and not __wf_atom_7e8ad928(object) do
		recoveryTime -= __wf_atom_084b3e93()

		if __wf_atom_7e8ad928((object:__wf_atom_bb3e7833(dogPurifySseType))) then
			return
		else
			Sleep(0)
		end
	end

	if not (__wf_atom_7e8ad928(object) or object:IsKilled() or __wf_atom_7e8ad928(__wf_atom_7470861b)) then
		object:InstantRevive()
		object:__wf_atom_921c1a5f(predeathStopAnim, true, 4, 1, true)
		local v2 = math.max(1, object:GetMaxHealth() * newHealthPostPredeathPct)
		object:SetHealth(object:__wf_atom_7470861b():__wf_atom_b221774e() + v2)
		__wf_atom_7470861b:__wf_atom_63396172(Symbol("POST_DEATH_ABILITY_ACTIVE"))
		__wf_atom_7470861b:__wf_atom_9f17ac89(Symbol("POST_DEATH_ABILITY_ACTIVE"))
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(dogPurifySseType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
		end

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
		end
	end
end

function OnDeath(object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(dogPurifySseType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
	end
end

function Shrink(object)
	Sleep(0)
	local __wf_atom_c082fc3d = object:__wf_atom_c082fc3d()
	local v2 = 1.5

	while v2 > 0 and not __wf_atom_7e8ad928(object) do
		v2 -= __wf_atom_084b3e93()
		object:SetMeshScale(__wf_atom_104bfe98(0.55, __wf_atom_c082fc3d, v2 / 2))
		Sleep(0)
	end

	object:SetMeshScale(0.55)
end

function StealStart(p, object)
	module2.GiveEnemyScan(p, object)

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
	module.SpawnRing(p, v2)
end

function OnPreDeathSteal(object, _)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	if not __wf_atom_7e8ad928(dogHelmetDestructionType) then
		__wf_atom_575542c8:Attach(
			dogHelmetDestructionType,
			EMPTY_SYMBOL,
			dogHelmetDestructionOffset,
			__wf_atom_80368bb1
		)
		__wf_atom_575542c8:Attach(dogHeadMeshType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	__wf_atom_575542c8:__wf_atom_45cf0e1a(dogBodyMesh, false, true)
	__wf_atom_575542c8:__wf_atom_8a035cd5(Symbol("Shrink"), false)

	if shouldSpawnMushroomRing then
		__wf_atom_575542c8:__wf_atom_8a035cd5(Symbol("SpawnRing"), false)
	end

	if challengeTag:__wf_atom_8598f3a9() then
		module3.NotifyTagAllPlayers(challengeTag)
	end

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

	local __wf_atom_30e3d82b = __wf_atom_575542c8:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_892b354d(true)
		__wf_atom_30e3d82b:__wf_atom_c6afb966(0)
		__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(Symbol("Flee"), __wf_atom_575542c8, 1)
	end

	local __wf_atom_679ed446 = __wf_atom_575542c8:__wf_atom_7470861b():__wf_atom_e065f642():__wf_atom_679ed446()

	if not __wf_atom_7e8ad928(__wf_atom_679ed446) and __wf_atom_679ed446:IsA(__wf_atom_67c46eba) then
		local __wf_atom_d2b2176d = __wf_atom_679ed446:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			local __wf_atom_97c36659 = __wf_atom_575542c8:__wf_atom_97c36659()
			__wf_atom_d2b2176d:__wf_atom_355b9a20(__wf_atom_97c36659, __wf_atom_575542c8, EMPTY_SYMBOL)
			__wf_atom_d2b2176d:__wf_atom_1bdcfcae(
				__wf_atom_97c36659,
				__wf_atom_575542c8,
				__wf_atom_575542c8:__wf_atom_1bb5b1ff(),
				EMPTY_SYMBOL
			)
		end
	end
end