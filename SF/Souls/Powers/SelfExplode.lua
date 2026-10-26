local v = { Symbol("CC_DOWNED_ENEMY"), Symbol("CC_GAP_CLOSER_DOWNED_ENEMY") }
local v2 = Symbol("BlockingBehavior")
local v3 = Symbol("POST_DEATH_ABILITY_ACTIVE")
local v4 = Symbol("DEATH_ABILITY_COOLDOWN")
local v5 = Symbol("SYM_DYING_RIGHT_NOW")

local function fn(object)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return false
	end

	local __wf_atom_55597fe3 = object:__wf_atom_7470861b():__wf_atom_55597fe3()

	if __wf_atom_55597fe3:__wf_atom_bf612a92(19) > 0 then
		return false
	end

	for i = 1, #v do
		if __wf_atom_55597fe3.upgradeSymbol == v[i] then
			return false
		end
	end

	local __wf_atom_76724198 = __wf_atom_30e3d82b:__wf_atom_76724198()
	local __wf_atom_694c2c5b = __wf_atom_30e3d82b:__wf_atom_694c2c5b()

	for i = 1, #__wf_atom_694c2c5b do
		if
			__wf_atom_7e8ad928(__wf_atom_694c2c5b[i])
			or object == __wf_atom_694c2c5b[i]
			or __wf_atom_694c2c5b[i]:IsKilled()
		then
			continue
		end

		local __wf_atom_30e3d82b2 = __wf_atom_694c2c5b[i]:__wf_atom_30e3d82b()

		if
			not __wf_atom_7e8ad928(__wf_atom_30e3d82b2)
			and __wf_atom_76724198 == __wf_atom_30e3d82b2:__wf_atom_76724198()
		then
			return false
		end
	end

	local __wf_atom_6b8adb0a = __wf_atom_30e3d82b:__wf_atom_6b8adb0a(v4)

	if object:__wf_atom_52077f7a(v5) or not (Time() - __wf_atom_6b8adb0a < teamCooldownBetweenExplosions) then
		return not (__wf_atom_30e3d82b:__wf_atom_493d3cf5() > 1)
	end

	return false
end

function SelfExploderMarkOnSpawn(object)
	Sleep(0)

	if _T.CombatTutorialEnded ~= nil then
		return
	end

	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_0632f8bc(true)

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_7470861b) or object:IsKilled() or object:__wf_atom_bedb4e3f()) do
		if gRegion:IsMaster() and not object:__wf_atom_52077f7a(v5) then
			if object:__wf_atom_68de036a() >= minLevelForAgentToUse and fn(object) then
				object:SetBlackboardBool(v3, true)
				__wf_atom_7470861b:__wf_atom_b6bcaf97(true)
			else
				object:SetBlackboardBool(v3, false)
				__wf_atom_7470861b:__wf_atom_b6bcaf97(false)
			end
		end

		Sleep(0)
	end
end

function RunInPreDeath(object)
	if not gRegion:IsMaster() then
		return
	end

	local flag

	if __wf_atom_7e8ad928(object) or object:__wf_atom_52077f7a(v3) then
		flag = false
	else
		object:__wf_atom_ec1735df()
		flag = true
	end

	if flag then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	local damageData = Engine.DamageData()
	damageData.instantKill = true
	local __wf_atom_e065f642 = object:__wf_atom_7470861b():__wf_atom_e065f642()

	for i = 0, 12 do
		damageData:__wf_atom_7498285f(i, __wf_atom_e065f642:__wf_atom_bf612a92(i))
	end

	damageData:__wf_atom_6b472125(__wf_atom_e065f642:__wf_atom_679ed446())
	damageData:__wf_atom_34a8a27a(__wf_atom_e065f642:__wf_atom_3371f607())
	damageData.baseAmount = __wf_atom_e065f642.baseAmount

	if chanceToActuallyCast < 1 and math.random() > chanceToActuallyCast then
		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_11d3ea0f(v4, Time())
		end

		local __wf_atom_7470861b = object:__wf_atom_7470861b()
		__wf_atom_7470861b:__wf_atom_b6bcaf97(false)
		__wf_atom_7470861b:__wf_atom_09b81d58(0)
		object:__wf_atom_649bf33e(damageData)
	else
		object:SetBlackboardBool(v5, true)

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_11d3ea0f(v4, Time())
			__wf_atom_30e3d82b:__wf_atom_aa4361c1(v2, object, 1)
		end

		if not __wf_atom_7e8ad928(chargeFxType) then
			local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
			local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()

			if not (__wf_atom_7e8ad928(object) and object:IsKilled()) then
				gRegion:CreateEntity(chargeFxType, __wf_atom_a2a18137, __wf_atom_2f2bada0, object):__wf_atom_8a035cd5(
					Symbol("SelfDeathExplosion"),
					false
				)
			end
		end

		if object:__wf_atom_bedb4e3f() then
			local v6 = math.max(1, object:GetMaxHealth() * newHealthPostPredeathPct)
			object:SetHealth(object:__wf_atom_7470861b():__wf_atom_b221774e() + v6)
			Sleep(0)

			if __wf_atom_7e8ad928(object) then
				return
			end

			local __wf_atom_7470861b = object:__wf_atom_7470861b()
			__wf_atom_7470861b:__wf_atom_b6bcaf97(false)
			__wf_atom_7470861b:__wf_atom_09b81d58(0)
		end

		object:__wf_atom_921c1a5f(nil, false, 3, 2)
		Sleep(0)

		if __wf_atom_7e8ad928(object) then
			return
		end

		local flag2

		if __wf_atom_7e8ad928(object) or object:__wf_atom_52077f7a(v3) then
			flag2 = false
		else
			object:__wf_atom_ec1735df()
			flag2 = true
		end

		if flag2 then
			return
		end

		object:__wf_atom_921c1a5f(activateAnim, false, 4, 1, true)

		if invulnerableWhileActive then
			object:__wf_atom_8914dfde(invulnStartEvent, 0.5)

			if __wf_atom_7e8ad928(object) or object:IsKilled() or not object:__wf_atom_c138b19b(activateAnim) then
				return
			else
				__wf_atom_7e8ad928((object:__wf_atom_7470861b()))
			end
		end

		object:__wf_atom_8914dfde(animEvent, 5)

		if __wf_atom_7e8ad928(object) then
			return
		end

		object:__wf_atom_7470861b():__wf_atom_b6bcaf97(false)
		object:__wf_atom_649bf33e(damageData)
	end
end

function SelfDeathExplosion(object)
	Sleep(3)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.checkForCover = false
	radialDamageData.hostAuthoritative = true
	radialDamageData.radius = 5
	radialDamageData.burstEffectType = burstFxType
	radialDamageData.baseAmount = 150
	radialDamageData.stabilityDamage = 50
	radialDamageData:__wf_atom_7498285f(5, 0.5)
	radialDamageData:__wf_atom_7498285f(0, 0.5)
	radialDamageData:__wf_atom_d6f4d914(31, true)
	radialDamageData:__wf_atom_98d98d81(object:__wf_atom_d0069154())
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_34a8a27a(object)
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	object:PlaySound(burstSound, false, 1, true, nil, 1)
	object:Attach(deathFXSpawner, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
end