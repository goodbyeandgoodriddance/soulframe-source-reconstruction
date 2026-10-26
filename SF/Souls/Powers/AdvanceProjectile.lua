local flag = false
local v = Symbol("IgnoreCombatManagerOnce")
local v2 = Symbol("BlockingBehavior")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v3 = Symbol("AdvancedProjectile")
local v4 = Symbol("AdvanceProjectileOnDamge")

function NpcEvaluateAbility(_, object)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return 0
	end

	local __wf_atom_9a1e4ed3 = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3()
	local avatar = __wf_atom_9a1e4ed3.avatar

	if __wf_atom_7e8ad928(avatar) or avatar:IsKilled() or not __wf_atom_9a1e4ed3.visible then
		return 0
	end

	local __wf_atom_6b8adb0a = __wf_atom_30e3d82b:__wf_atom_6b8adb0a(v3)
	local v5 = Time()

	if not __wf_atom_7e8ad928(__wf_atom_6b8adb0a) and v5 - __wf_atom_6b8adb0a < minimumUseDelay then
		return 0
	end

	local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) or __wf_atom_35a10d3c:__wf_atom_dedeec57() then
		return 0
	end

	local __wf_atom_a07433fe = __wf_atom_35a10d3c:__wf_atom_a07433fe()

	if __wf_atom_7e8ad928(__wf_atom_a07433fe) or not __wf_atom_a07433fe:IsA(__wf_atom_ed85f483) then
		return 0
	end

	if not TrackHit then
		return 1
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerHit) and __wf_atom_e919fb8e.PlayerHit then
		local playerHitTime = __wf_atom_e919fb8e.PlayerHitTime

		if Time() - playerHitTime < trackUseDelay then
			return 0
		end

		__wf_atom_e919fb8e.PlayerHitTime = nil
		__wf_atom_e919fb8e.PlayerHit = false
	end

	return 1
end

function ActivateAbility(object, object2, _, _)
	flag = false

	if gRegion:IsMaster() then
		local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
		__wf_atom_30e3d82b:__wf_atom_11d3ea0f(v3, (Time()))
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v2, object2)
	end

	object2:Attach(chargeFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not module.PlayAnim(object, activateAnim, true, 4, 1, false) then
		return
	end

	if gRegion:IsMaster() then
		local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
		__wf_atom_30e3d82b:__wf_atom_42b767a2(v2)
		__wf_atom_30e3d82b:__wf_atom_5a0e15fd(v, 1)
	end

	local __wf_atom_35a10d3c = object2:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		return
	end

	module.SetAbilityStats(object, mOwner, __wf_atom_35a10d3c)
	local __wf_atom_66088189 = __wf_atom_35a10d3c:__wf_atom_66088189(1, 1)

	if not __wf_atom_7e8ad928(__wf_atom_66088189) then
		__wf_atom_66088189:Attach(activeFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	local __wf_atom_a07433fe = __wf_atom_35a10d3c:__wf_atom_a07433fe()

	if __wf_atom_7e8ad928(__wf_atom_a07433fe) or not __wf_atom_a07433fe:IsA(__wf_atom_ed85f483) then
		return
	end

	object:__wf_atom_6a4cf64f()
	__wf_atom_a07433fe:__wf_atom_18fa30ab(1)
	__wf_atom_a07433fe.advanceProjectileSequenceOnFire = true
	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
	object2:__wf_atom_51cd6126(v4, "OnDamaged")
	local v5 = 2

	while
		not __wf_atom_7e8ad928(__wf_atom_35a10d3c)
		and __wf_atom_a07433fe:__wf_atom_69525515() == 1
		and not __wf_atom_35a10d3c:__wf_atom_9f71ab59()
	do
		if flag then
			object2:Attach(interruptedAfterChargeFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			flag = false
			break
		else
			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				local __wf_atom_9a1e4ed3 = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3()
				local avatar = __wf_atom_9a1e4ed3.avatar

				if __wf_atom_7e8ad928(avatar) or avatar:IsKilled() or not __wf_atom_9a1e4ed3.visible then
					v5 -= __wf_atom_084b3e93()

					if v5 <= 0 then
						object:__wf_atom_e8954328()
						break
					end
				else
					v5 = 2
				end
			end

			Sleep(0)
		end
	end
end

local function fn(abilityStats)
	for i = 1, abilityStats:__wf_atom_ca3e110b() do
		if abilityStats:__wf_atom_3d08948b(i - 1):IsA(__wf_atom_ed85f483) then
			return abilityStats:__wf_atom_3d08948b(i - 1)
		end
	end

	return nil
end

function DeactivateAbility(p, object, _, _)
	object:__wf_atom_0650fed7(chargeFX)
	object:__wf_atom_3ede53b4(v4)
	local abilityStats = module.GetAbilityStats(p, mOwner)

	if not __wf_atom_7e8ad928(abilityStats) then
		local v5 = fn(abilityStats)

		if not __wf_atom_7e8ad928(v5) and v5:IsA(__wf_atom_ed85f483) then
			local __wf_atom_66088189 = abilityStats:__wf_atom_66088189(1, 1)

			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(activeFX)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end

				if v5:__wf_atom_69525515() == 0 then
					__wf_atom_66088189:Attach(shootFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				end
			end

			v5:__wf_atom_18fa30ab(0)
			v5.advanceProjectileSequenceOnFire = false
		end
	end
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if
		__wf_atom_9d766292:__wf_atom_78650070(16)
		or __wf_atom_9d766292:__wf_atom_78650070(17)
		or __wf_atom_9d766292:__wf_atom_78650070(19)
	then
		flag = true
	end
end