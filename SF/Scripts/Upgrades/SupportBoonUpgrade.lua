local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = nil

local function fn(object, object2)
	if not gRegion:IsMaster() then
		return nil
	end

	local __wf_atom_68de036a = object:__wf_atom_68de036a()
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return nil
	end

	local __wf_atom_dd7246c7 = __wf_atom_a96eb2aa:__wf_atom_dd7246c7()
	local v2

	if __wf_atom_7e8ad928(__wf_atom_dd7246c7) then
		v2 = object:__wf_atom_a06d543c()
	else
		v2 = __wf_atom_dd7246c7:__wf_atom_a06d543c()
	end

	local __wf_atom_a97361bb = object:__wf_atom_a97361bb()
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	__wf_atom_2202ffb6:__wf_atom_7d789620()
	local __wf_atom_22941262 = object2:__wf_atom_22941262()
	local v3 = nil
	local __wf_atom_f2e7f4a9 = object:__wf_atom_d2b2176d():__wf_atom_f2e7f4a9()

	if
		not __wf_atom_7e8ad928(v3)
		and v3:__wf_atom_a3309443()
		and v3.visible
		and v3.distanceToTarget <= enemiesSearchRange
		and v3:__wf_atom_e93896ba() ~= Symbol("Neutral")
		and not v3:__wf_atom_50a7d83e():__wf_atom_464a4772()
	then
		v3 = __wf_atom_f2e7f4a9
	end

	if __wf_atom_7e8ad928(v3) then
		local all = gRegion:FindAll(__wf_atom_9e85eea2, object:__wf_atom_a2a18137(), 0, enemiesSearchRange)

		for i = 1, #all do
			if __wf_atom_7e8ad928(all[i]) or all[i]:IsKilled() or object:__wf_atom_129d1aba(all[i]) then
				continue
			end

			if all[i]:__wf_atom_e93896ba() == Symbol("Neutral") then
				continue
			end

			if
				all[i]:__wf_atom_464a4772()
				or all[i]:IsA(WeakResource("/SF/Types/Enemies/Sinecure/OdeAttackDog/OdeAttackDogAvatarBase"))
			then
				continue
			end

			v3 = all[i]
			break
		end
	end

	local v4, v5

	if __wf_atom_7e8ad928(v3) then
		v4 = 60
		v5 = 2
	else
		v4 = 110
		v5 = 5
	end

	local v6 = __wf_atom_a2a18137 + __wf_atom_9341614d(v2, Rotation(v4, 0, 0)) * v5

	if not __wf_atom_7e8ad928(v3) then
		__wf_atom_2f2bada0 = __wf_atom_fa8d0177(v6, v3:__wf_atom_a2a18137())
	end

	if not __wf_atom_7e8ad928(v3) and v3:IsA(__wf_atom_4ebf67cb) then
		local v7 = __wf_atom_fa8d0177(v3:__wf_atom_a2a18137(), v6)
		v7.pitch = 0
		v3:MotionControl():__wf_atom_3a1d0c16(v7)
	end

	local __wf_atom_402b3832 = __wf_atom_2202ffb6:__wf_atom_402b3832(
		agentType,
		v6,
		__wf_atom_2f2bada0,
		EMPTY_SYMBOL,
		__wf_atom_22941262,
		true,
		0,
		0,
		summonAnim
	)
	local v7

	if not (__wf_atom_7e8ad928(__wf_atom_402b3832) or __wf_atom_7e8ad928(__wf_atom_402b3832:__wf_atom_50a7d83e())) then
		v7 = __wf_atom_402b3832:__wf_atom_50a7d83e()
		v7:PlaySound(appearSound, false, 1, false)
		v7:SetFaction(__wf_atom_a97361bb)
		v7:__wf_atom_6a95c7b8(object)
		v7:__wf_atom_8f0b611f(mOwner)
		v7:Attach(perceptionHint, Symbol("GAME_C1_SPINE3"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		__wf_atom_402b3832:__wf_atom_2e7b29b1(false)
		module2.SetAbilityStats(object2, mOwner, v7)
	end

	if __wf_atom_7e8ad928(v7) then
		return nil
	end

	if __wf_atom_7e8ad928(v3) then
		return v7
	end

	local __wf_atom_a2a18137_2 = v7:__wf_atom_a2a18137()
	local __wf_atom_a2a18137_3 = v3:__wf_atom_a2a18137()
	local v8 = __wf_atom_fa8d0177(__wf_atom_a2a18137_2, __wf_atom_a2a18137_3)
	local v9 = __wf_atom_a2a18137_3 - __wf_atom_a2a18137_2
	Normalize(v9)
	local v10 = __wf_atom_a2a18137_3 - 1 * v9
	v7:__wf_atom_3c986cd9(v10, v8)
	v7:__wf_atom_921c1a5f(summonJumpInAnim, true, 3, 1, true, 2)
	v7:Teleport(v7:__wf_atom_0d7d47e6(v10), v8)
	v7:MotionControl():__wf_atom_2b8da3d2(__wf_atom_28d5d4aa)
	v7:MotionControl():__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
	v7:__wf_atom_921c1a5f(nil, false)
	v7:__wf_atom_9373d0eb(5, false)

	if doSummonAoe then
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.radius = aoeRadius
		radialDamageData.baseAmount = aoeDamage + damageRankMod * __wf_atom_68de036a
		radialDamageData.stabilityDamage = aoeStabilityDamage + stabilityDamageRankMod * __wf_atom_68de036a
		radialDamageData.hitAirborneTargets = hitAirborne
		radialDamageData.checkForCover = checkCover
		radialDamageData.baseProcChance = aoeDamageProcChance
		radialDamageData.blockableProjType = 4
		radialDamageData:__wf_atom_6b472125(v7)
		radialDamageData:__wf_atom_98d98d81(v7:__wf_atom_1c374cc9(damageSpawnBone))
		radialDamageData:__wf_atom_caac739b(Symbol("TENNO"))

		if waitForAnimEvent then
			v7:__wf_atom_8914dfde("Landed", 5)
		end

		gRegion:__wf_atom_f6ec80de(radialDamageData)
	end

	while not __wf_atom_7e8ad928(v7) and v7:__wf_atom_c138b19b(summonJumpInAnim) do
		Sleep(0)
	end

	if powersuitCast and not (__wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(__wf_atom_402b3832)) then
		__wf_atom_402b3832:__wf_atom_cca1dc04(powersuitCast, v3, true)
	end

	return v7
end

function DespawnImmediately(instance)
	if not __wf_atom_7e8ad928(despawnFxType) then
		instance:Attach(despawnFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance, 1)
	end

	local __wf_atom_921c1a5f = instance:__wf_atom_921c1a5f(despawnAnim, false, 3, 3, true, 1)
	local total = 0

	while total < __wf_atom_921c1a5f do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	instance:Destroy()
end

local function fn2(object, _)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	object:PlaySound(castSound, false, 0, false)

	if gRegion:IsMaster() then
		gRegion:__wf_atom_2202ffb6():__wf_atom_5ed7114d(summonPerceptionInfo, object, object:GetPosition())
		v = fn(object, __wf_atom_e55d02aa)

		if not (__wf_atom_7e8ad928(v) or v:IsKilled()) then
			v:__wf_atom_8a035cd5(Symbol("DespawnImmediately"), false)
		end
	else
		while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
			Sleep(0)
		end
	end
end

function OmenBeastSupportUpgrade(object, _, _, _, _)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()
	local v2 = module.WaitForAiDir()
	local total = 0
	local v3 = false
	local ambushSpawnDelaytime2 = 0

	while not (__wf_atom_7e8ad928(object) or object:IsKilled() or __wf_atom_7e8ad928(v2)) do
		if v2:__wf_atom_37241977(__wf_atom_a96eb2aa) and __wf_atom_7e8ad928(v) then
			v3 = waitBetweenSpawnTime < total and not v3 or v3

			if v3 and ambushSpawnDelaytime2 <= 0 then
				ambushSpawnDelaytime2 = ambushSpawnDelaytime
				gGameRules:__wf_atom_ae06b572(summonTransmission)
				Sleep(2.5)
				fn2(object)
				v3 = false
			end

			local v4 = __wf_atom_084b3e93()
			total += v4
			ambushSpawnDelaytime2 -= v4
		end

		Sleep(0)
	end
end

function DeactivateSupportUpgrade(_, _) end