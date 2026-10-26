local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local numAttacks = nil
local v = 7
local buff = 2
local fn
local fn2

local function fn3(p, p2)
	local magikForceCalc = module.magikForceCalc(p2, p, mOwner)
	module.magikEnergyCalc(p2, p, mOwner)

	if p == 1 then
		buff = 1
		v = 3
	elseif p == 2 then
		buff = 1.15
		v = 3
	else
		if p == 3 then
			buff = 1.2
		else
			buff = 1.25
		end

		v = 4
	end

	buff *= magikForceCalc
	v = math.round((__wf_atom_104bfe98(v, 7, magikForceCalc - 1)))
end

function NpcEvaluateAbility(_, _)
	return 0
end

function GetAbilityUpgradeLevelInfo()
	mOwner = _T.AbilityLevelQueryParms.Ability
	fn3(_T.AbilityLevelQueryParms.Level, _T.AbilityLevelQueryParms.Avatar)
	local abilityUpgradeLevelInfo = {}
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/DAMAGE",
		Value = buff + 1,
		ValueUnit = "/Lotus/Language/Game/UNIT_MULTIPLIER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "Number of attacks",
		Value = v,
		ValueUnit = "/Lotus/Language/Game/UNIT_METER"
	})
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

function ActivateAbility(object, object2, _, p)
	fn3(p, object2)
	local v2 = {
		buff = buff,
		totalBuff = 0,
		numAttacks = v,
		hitThisSwing = false,
		projectiles = {},
		abilityProjectiles = {},
		totalAttacks = v
	}
	module.SetAbilityStats(object, mOwner, v2)

	if _T.SetAbilityTimer then
		_T.SetAbilityTimer(mOwner:__wf_atom_1bb5b1ff(), object2, 1)
		numAttacks = v
	end

	module.EnableWeaponFiring(object2, mOwner, false)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	Sleep(0)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v3

	if not __wf_atom_7e8ad928(pactFxType) then
		v3 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	object2:Attach(castFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Destroy()
	end

	object:__wf_atom_6a4cf64f()
	module.RemoveCastImmunity(object2)
	__wf_atom_7e8ad928((object2:__wf_atom_bb3e7833(attachFxType)))
	object2:Attach(WindType, EMPTY_SYMBOL, Vector(0, 1.25, 0), __wf_atom_80368bb1)
	object2:__wf_atom_b4529799(mOwner:__wf_atom_37768748(), "OnMeleeHit")
	mOwner:__wf_atom_74f6ca7b(Symbol("OnProjectile"), true)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:AddUpgrade(319, 4, 1, nil, nil, 26, Symbol(), false, 31)
	local v4 = nil
	local v5 = true
	local v6 = nil
	local v7 = false
	local v8 = nil

	while not (__wf_atom_7e8ad928(object2) or object2:IsKilled()) do
		if __wf_atom_7e8ad928(v4) or v4:__wf_atom_3e33d5dd() ~= 0 then
			fn2(v4)
			v4 = nil
			v8 = nil
			local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

			if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) and __wf_atom_35a10d3c:IsA(__wf_atom_77e05d3b) then
				local __wf_atom_75a0566d = __wf_atom_35a10d3c:__wf_atom_75a0566d()

				if not __wf_atom_7e8ad928(__wf_atom_75a0566d) then
					fn(__wf_atom_35a10d3c)
					v8 = __wf_atom_75a0566d
					v4 = __wf_atom_35a10d3c
				end
			end
		end

		if v5 and not object2:__wf_atom_c138b19b(activateAnim) then
			module.EnableWeaponFiring(object2, mOwner, true)
			v5 = false
		end

		if gRegion:IsMaster() and not (__wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(v8)) then
			v8:__wf_atom_fe33ffd0()

			for i = 1, v4:__wf_atom_ca3e110b() do
				local __wf_atom_414f70dd = v4:__wf_atom_414f70dd(i - 1)

				if __wf_atom_7e8ad928(__wf_atom_414f70dd) then
					continue
				end

				local __wf_atom_91859ed8 = __wf_atom_414f70dd:__wf_atom_91859ed8()

				for _, v9 in pairs(__wf_atom_91859ed8) do
					if __wf_atom_7e8ad928(v9) or v9:__wf_atom_69d7f48b() then
						continue
					end

					local __wf_atom_f7f6708f = v9:__wf_atom_f7f6708f()

					if v2.projectiles[__wf_atom_f7f6708f] ~= nil then
						continue
					end

					v2.projectiles[__wf_atom_f7f6708f] = v9
					v7 = true

					if __wf_atom_7e8ad928(v6) then
						v2.numAttacks -= 1
					end
				end
			end

			local __wf_atom_fe33ffd0 = v8:__wf_atom_fe33ffd0()

			if __wf_atom_fe33ffd0 ~= v6 then
				if not __wf_atom_7e8ad928(v6) then
					v2.numAttacks -= 1

					if not (v2.hitThisSwing or v7) then
						v2.numAttacks -= 1
					end
				end

				if not __wf_atom_7e8ad928(__wf_atom_fe33ffd0) then
					v2.hitThisSwing = false
				end

				v6 = __wf_atom_fe33ffd0
			end

			if __wf_atom_7e8ad928(__wf_atom_fe33ffd0) then
				v7 = false
			end

			for k, projectile in pairs(v2.projectiles) do
				if not (__wf_atom_7e8ad928(projectile) or projectile:__wf_atom_69d7f48b()) then
					continue
				end

				v2.projectiles[k] = nil
				v2.numAttacks -= 1
			end

			for k, abilityProjectile in pairs(v2.abilityProjectiles) do
				if abilityProjectile.count ~= #abilityProjectile.projs then
					continue
				end

				local flag = true

				for _, proj in ipairs(abilityProjectile.projs) do
					if __wf_atom_7e8ad928(proj) or proj:__wf_atom_69d7f48b() then
						continue
					end

					flag = false
					break
				end

				if not flag then
					continue
				end

				if not abilityProjectile.hit then
					v2.numAttacks -= 1
				end

				v2.abilityProjectiles[k] = nil
			end

			if _T.SetAbilityTimer and numAttacks ~= v2.numAttacks then
				numAttacks = v2.numAttacks
				_T.SetAbilityTimer(mOwner:__wf_atom_1bb5b1ff(), object2, v2.numAttacks / v2.totalAttacks)
			end

			if v2.numAttacks <= 0 then
				object:DeactivateAbility(mOwner:__wf_atom_1bb5b1ff())
				break
			end
		end

		Sleep(0)
	end
end

function DeactivateAbility(p, object, _, _)
	local abilityStats = module.GetAbilityStats(p, mOwner, true)

	if gRegion:IsMaster() and abilityStats and abilityStats.totalBuff > 0 then
		object:__wf_atom_d2b2176d():RemoveUpgrade(366, 3, abilityStats.totalBuff)
	end

	object:__wf_atom_af2dc07b(mOwner:__wf_atom_37768748())
	mOwner:__wf_atom_74f6ca7b(Symbol("OnProjectile"), false)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(attachFxType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	object:Attach(endFxType, Symbol("GAME_R1_WEAPON1"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:RemoveUpgrade(319, 4, 1, nil, nil, 26, Symbol(), false, 31)
	local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)
	fn2(__wf_atom_35a10d3c)

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	module.EnableWeaponFiring(object, mOwner, true)
end

fn = function(object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_66088189 = object:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			local name = __wf_atom_66088189:GetName()

			if string.match(name, "Casting") then
				if __wf_atom_7e8ad928((__wf_atom_66088189:__wf_atom_bb3e7833(castingAttachFxTypeR))) then
					__wf_atom_66088189:Attach(
						castingAttachFxTypeR,
						EMPTY_SYMBOL,
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1
					)
				end
			elseif __wf_atom_7e8ad928((__wf_atom_66088189:__wf_atom_bb3e7833(swordAttachFxType))) then
				__wf_atom_66088189:Attach(swordAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end
		end

		local __wf_atom_66088189_2 = object:__wf_atom_66088189(1, 1)

		if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
			local name = __wf_atom_66088189_2:GetName()

			if string.match(name, "Shield") then
				if __wf_atom_7e8ad928((__wf_atom_66088189_2:__wf_atom_bb3e7833(shieldAttachFxType))) then
					__wf_atom_66088189_2:Attach(
						shieldAttachFxType,
						EMPTY_SYMBOL,
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1
					)
				end
			elseif string.match(name, "Casting") then
				if __wf_atom_7e8ad928((__wf_atom_66088189_2:__wf_atom_bb3e7833(castingAttachFxTypeL))) then
					__wf_atom_66088189_2:Attach(
						castingAttachFxTypeL,
						EMPTY_SYMBOL,
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1
					)
				end
			elseif string.match(name, "Bow") then
				if __wf_atom_7e8ad928((__wf_atom_66088189_2:__wf_atom_bb3e7833(bowAttachFxType))) then
					__wf_atom_66088189_2:Attach(bowAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				end
			elseif __wf_atom_7e8ad928((__wf_atom_66088189_2:__wf_atom_bb3e7833(swordAttachFxType))) then
				__wf_atom_66088189_2:Attach(swordAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end
		end
	end
end

fn2 = function(object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_66088189 = object:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(swordAttachFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end

			local __wf_atom_bb3e7833_2 = __wf_atom_66088189:__wf_atom_bb3e7833(castingAttachFxTypeR)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
				__wf_atom_bb3e7833_2:Destroy()
			end
		end

		local __wf_atom_66088189_2 = object:__wf_atom_66088189(1, 1)

		if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
			local __wf_atom_bb3e7833 = __wf_atom_66088189_2:__wf_atom_bb3e7833(swordAttachFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end

			local __wf_atom_bb3e7833_2 = __wf_atom_66088189_2:__wf_atom_bb3e7833(castingAttachFxTypeL)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
				__wf_atom_bb3e7833_2:Destroy()
			end

			local __wf_atom_bb3e7833_3 = __wf_atom_66088189_2:__wf_atom_bb3e7833(shieldAttachFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_3) then
				__wf_atom_bb3e7833_3:Destroy()
			end

			local __wf_atom_bb3e7833_4 = __wf_atom_66088189_2:__wf_atom_bb3e7833(bowAttachFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_4) then
				__wf_atom_bb3e7833_4:Destroy()
			end
		end
	end
end

function OnMeleeHit(object)
	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292())
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292():__wf_atom_483e7ddc())
	then
		return
	end

	local __wf_atom_483e7ddc = object:__wf_atom_9d766292():__wf_atom_483e7ddc()
	local hitType = __wf_atom_483e7ddc.hitType
	local victim = __wf_atom_483e7ddc.victim

	if __wf_atom_483e7ddc:__wf_atom_6e062502() or hitType ~= 3 and hitType ~= 2 then
		return
	end

	gRegion:CreateEntity(hitFxType, __wf_atom_483e7ddc:__wf_atom_dce32a3f(), __wf_atom_80368bb1)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	local abilityStats = module.GetAbilityStats(__wf_atom_e55d02aa, mOwner)

	if not abilityStats then
		return
	end

	if hitType == 3 and not abilityStats.hitThisSwing then
		abilityStats.hitThisSwing = true
	else
		if hitType ~= 2 then
			return
		end

		local __wf_atom_5cb6b090 = __wf_atom_483e7ddc:__wf_atom_5cb6b090()

		if __wf_atom_7e8ad928(abilityStats.projectiles[__wf_atom_5cb6b090]) then
			if
				abilityStats.abilityProjectiles[__wf_atom_5cb6b090]
				and not abilityStats.abilityProjectiles[__wf_atom_5cb6b090].hit
			then
				abilityStats.abilityProjectiles[__wf_atom_5cb6b090].hit = true
			else
				return
			end
		else
			abilityStats.projectiles[__wf_atom_5cb6b090]:Attach(hitFxType, EMPTY_SYMBOL)
			abilityStats.projectiles[__wf_atom_5cb6b090] = nil
		end
	end

	if gRegion:IsMaster() then
		if abilityStats.totalBuff > 0 then
			__wf_atom_d2b2176d:RemoveUpgrade(366, 3, abilityStats.totalBuff)
		end

		local v2 = abilityStats.buff / (abilityStats.totalAttacks + (abilityStats.numAttacks / 2 - abilityStats.totalAttacks))

		if not __wf_atom_7e8ad928(victim) and victim:__wf_atom_464a4772() then
			v2 /= 2
		end

		abilityStats.totalBuff += v2
		__wf_atom_d2b2176d:AddUpgrade(366, 3, abilityStats.totalBuff)
	end
end

function OnProjectile(p, _, object, object2)
	if __wf_atom_7e8ad928(object) or object:__wf_atom_3e33d5dd() ~= 0 then
		return
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if not __wf_atom_e919fb8e.numberOfProjectiles then
		return
	end

	local abilityStats = module.GetAbilityStats(p, mOwner)

	if not abilityStats then
		return
	end

	local __wf_atom_f7f6708f = object2:__wf_atom_f7f6708f()

	if not abilityStats.abilityProjectiles[__wf_atom_f7f6708f] then
		abilityStats.abilityProjectiles[__wf_atom_f7f6708f] = {
			hit = false,
			count = __wf_atom_e919fb8e.numberOfProjectiles,
			projs = {}
		}
		abilityStats.numAttacks -= 1
	end

	table.insert(abilityStats.abilityProjectiles[__wf_atom_f7f6708f].projs, object2)
end