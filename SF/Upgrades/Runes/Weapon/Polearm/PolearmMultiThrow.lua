local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = 0.2
local v2 = 0.2
local v3 = Symbol("PolearmMultiThrowRune")
local v4 = Symbol("Neutral")
local v5 = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}

local function fn(object, position, __wf_atom_a06d543c)
	local __wf_atom_e49a399c = object:__wf_atom_e49a399c()
	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	local result = {}

	for i = 1, #__wf_atom_e49a399c do
		if
			__wf_atom_e49a399c[i]:__wf_atom_8c3af1a5(__wf_atom_e93896ba)
			or __wf_atom_e49a399c[i]:__wf_atom_e93896ba() == v4
			or __wf_atom_e49a399c[i]:IsKilled()
		then
			continue
		end

		local v6 = __wf_atom_e49a399c[i]:GetPosition() - position
		Normalize(v6)

		if not (Dot(v6, __wf_atom_a06d543c) > 0) then
			continue
		end

		for _ = 1, __wf_atom_5784a397(2, 5) do
			table.insert(result, __wf_atom_e49a399c[i])
		end
	end

	return result
end

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

local function fn2(object, object2) -- 1 equivalent call inferred from this helper
	return not __wf_atom_7e8ad928(object2)
		and not (object2:IsKilled() or object2:__wf_atom_129d1aba(object))
		and not __wf_atom_7e8ad928(mOwner)
		and object2:IsVisible()
end

function SpawnProjectilesNew(object)
	local polearmMultiThrowRuneWeapon = object:__wf_atom_e919fb8e().PolearmMultiThrowRuneWeapon

	if __wf_atom_7e8ad928(polearmMultiThrowRuneWeapon) then
		return
	end

	local position = object:GetPosition()
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	Sleep(0.5)
	local v6 = fn(object, position, __wf_atom_a06d543c)
	local v7 = __wf_atom_edfe0d73(__wf_atom_a06d543c, Vector(0, 1, 0))
	local v8 = v7 * 4.5 * 2
	local v9 = position - v7 * 4.5 - __wf_atom_a06d543c * 8
	local __wf_atom_6271f57d = polearmMultiThrowRuneWeapon:__wf_atom_6271f57d()
	polearmMultiThrowRuneWeapon:__wf_atom_f4afee75()
	local __wf_atom_f7f6708f = polearmMultiThrowRuneWeapon:__wf_atom_f7f6708f()

	if __wf_atom_7e8ad928((polearmMultiThrowRuneWeapon:__wf_atom_3d08948b(__wf_atom_6271f57d))) then
		return
	end

	local count = 0
	local v10 = 0.01
	local v11 = 0

	while
		not __wf_atom_7e8ad928(polearmMultiThrowRuneWeapon)
		and count < 35
		and not __wf_atom_7e8ad928(projType)
		and v10 > 0
	do
		local __wf_atom_3d08948b = polearmMultiThrowRuneWeapon:__wf_atom_3d08948b(__wf_atom_6271f57d)
		v10 -= __wf_atom_084b3e93()

		if
			v10 <= 0
			and not __wf_atom_7e8ad928(object)
			and object:__wf_atom_8efce136()
			and not __wf_atom_7e8ad928(__wf_atom_3d08948b)
		then
			local v12 = Random(0.01, 0.5)

			if count % 2 == 0 then
				v12 += 0.5
			end

			local v13 = count / 35 + 0.12
			local v14 = nil
			local v15 = 1

			while __wf_atom_7e8ad928(v14) and v15 <= #v6 do
				if fn2(object, v6[v15]) and v6[v15]:__wf_atom_a5304c35(position) < 28 then -- inferred equivalent call
					local v16 = v6[v15]
					local v17 = v16:__wf_atom_7470861b():__wf_atom_96c119f5(0) + v16:MotionControl():__wf_atom_0cf4ee4b() * 0.1
					local v18 = v17 - v9
					local v19 = Dot(v8, v18) / Dot(v8, v8)

					if v19 >= 0 and v19 <= 1 then
						local v20 = __wf_atom_421b01aa(v16:__wf_atom_a5304c35(position) / 28, 0, 1)

						if v20 <= v11 then
							v13 = v20 - Random(0.05, 0.1)
							table.remove(v6, v15)
							v12 = v19
							v14 = v17
						end
					end
				end

				v15 += 1
			end

			local v16 = Random(10, 12)
			local v17 = v9 + v8 * v12 + v13 * 25 * __wf_atom_a06d543c
			v17.y += v16
			local v18

			if __wf_atom_7e8ad928(v14) then
				local v19 = Random(35, 50)
				local v20 = __wf_atom_a1467d4b(Vector(0, -1, 0), __wf_atom_a06d543c, v19)
				v18 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v20)
				v11 = v13
			else
				v18 = __wf_atom_fa8d0177(v17, v14)
			end

			local v19 = Vector()
			local v20 = v16 + 1
			local v21 = v17 + __wf_atom_9341614d(Vector(0, 0, v20), v18)
			local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(v21, v17, v5, nil, v19)

			if
				__wf_atom_c20d246a
				and (not __wf_atom_c20d246a:IsA(__wf_atom_8d0b7f88) or __wf_atom_c20d246a:__wf_atom_c6f1f83d() == 0)
				and v19.y - v21.y >= 2
			then
				v17 = v19
			end

			__wf_atom_3d08948b:__wf_atom_2f00a1b2(v17, v18, projType, 0, count, __wf_atom_f7f6708f)
			count += 1
			v10 = Random(0.02, 0.05)
		end

		Sleep(0)
	end
end

function OnNewProjectile(object, object2)
	local __wf_atom_7be51ede = object2:__wf_atom_7be51ede()

	if __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		return
	end

	if object2:__wf_atom_1c9b5d2a() ~= 1 then
		local __wf_atom_b6645301 = object:__wf_atom_3d08948b(1):__wf_atom_b6645301()

		if not __wf_atom_7e8ad928(__wf_atom_b6645301) then
			object2:__wf_atom_3b3c58ec(__wf_atom_b6645301)
		end

		local __wf_atom_e919fb8e = __wf_atom_7be51ede:__wf_atom_e919fb8e()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.PolearmMultiThrowDamageModifier) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.PolearmMultiThrowStaggerDamageModifier)) then
			object2:__wf_atom_9fba31e6(2, __wf_atom_e919fb8e.PolearmMultiThrowDamageModifier)
			object2:__wf_atom_746d4173(2, __wf_atom_e919fb8e.PolearmMultiThrowStaggerDamageModifier)
		end

		local upgradedValue = Engine.UpgradedValue(0)
		upgradedValue:__wf_atom_fae96c2e(4, 0)
		object2:__wf_atom_7c5964b8(upgradedValue)
		local __wf_atom_66088189 = object:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			object2:__wf_atom_45cf0e1a(__wf_atom_66088189:__wf_atom_b6b760b5(), false, true)
		end
	end
end

function ActivateAbility(object, object2, _, p)
	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if __wf_atom_7e8ad928(weaponMote) then
		return
	end

	if (__wf_atom_7e8ad928(weaponMote) and 0 or weaponMote:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 0.4
		elseif p == 2 then
			v = 0.6
		elseif p == 3 then
			v = 0.8
		else
			v = 1
		end

		v2 = 2
	end

	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) or not __wf_atom_3371f607:IsA(__wf_atom_77e05d3b) then
		return
	end

	if gRegion:IsMaster() then
		object2:__wf_atom_d2b2176d():AddUpgrade(283, 4, 0, __wf_atom_3371f607:__wf_atom_1bb5b1ff(), __wf_atom_3371f607)
	end

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
				activeFxType,
				EMPTY_SYMBOL,
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1
			)

			if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
				__wf_atom_7ccf4243:__wf_atom_dc5956fc(__wf_atom_66088189, EMPTY_SYMBOL)
			end
		end
	end

	Sleep(0)
	local runeActivationCost = module3.GetRuneActivationCost()
	local v6 = false

	while
		not __wf_atom_7e8ad928(object2)
		and not __wf_atom_7e8ad928(__wf_atom_3371f607)
		and __wf_atom_3371f607:__wf_atom_9f71ab59()
		and not v6
	do
		if __wf_atom_3371f607:__wf_atom_160ce839() then
			v6 = true

			if gRegion:IsMaster() then
				local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
				object:__wf_atom_19516b62(-runeActivationCost, __wf_atom_2e4994f1)
			end

			module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
			object2:__wf_atom_8a035cd5(Symbol("SpawnProjectilesNew"), false)
		end

		Sleep(0)
	end

	Sleep(0.1)
end

function DeactivateAbility(_, object, _, p)
	mOwner:__wf_atom_74f6ca7b(Symbol("OnMeleeHit"), false)

	if (__wf_atom_7e8ad928(nil) and 0 or (nil):__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 0.4
		elseif p == 2 then
			v = 0.6
		elseif p == 3 then
			v = 0.8
		else
			v = 1
		end

		v2 = 2
	end

	if not __wf_atom_7e8ad928(deactivateAbilitySound) then
		object:PlaySound(deactivateAbilitySound, false)
	end

	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	if gRegion:IsMaster() then
		object:__wf_atom_d2b2176d():RemoveUpgrade(
			283,
			4,
			0,
			__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
			__wf_atom_3371f607
		)
	end
end

function ApplyRuneUpgrade(object, polearmMultiThrowRuneWeapon, p, _, object2)
	if not __wf_atom_7e8ad928(polearmMultiThrowRuneWeapon) and polearmMultiThrowRuneWeapon:IsA(__wf_atom_77e05d3b) then
		if
			polearmMultiThrowRuneWeapon:__wf_atom_55da7898() ~= 5
			and polearmMultiThrowRuneWeapon:__wf_atom_55da7898() ~= 1
		then
			return
		end

		if not __wf_atom_7e8ad928(runeBehaviorUpgradeType) and runeBehaviorUpgradeType:IsA(__wf_atom_ac456965) then
			polearmMultiThrowRuneWeapon:__wf_atom_bc7d3d16(runeBehaviorUpgradeType)
		end

		if (__wf_atom_7e8ad928(object2) and 0 or object2:__wf_atom_a8dac107()) == 0 then
			if p == 1 then
				v = 0.4
			elseif p == 2 then
				v = 0.6
			elseif p == 3 then
				v = 0.8
			else
				v = 1
			end

			v2 = 2
		end

		local runeDamageBuff = module3.GetRuneDamageBuff(object, v)
		local runeDamageBuff2 = module3.GetRuneDamageBuff(object, v2)

		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.PolearmMultiThrowDamageModifier = runeDamageBuff
			__wf_atom_e919fb8e.PolearmMultiThrowStaggerDamageModifier = runeDamageBuff2
			__wf_atom_e919fb8e.PolearmMultiThrowRuneWeapon = polearmMultiThrowRuneWeapon
		end

		polearmMultiThrowRuneWeapon:__wf_atom_f354682d(v3, "OnNewProjectile")
	end
end

function RemoveRuneUpgrade(object, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		instance:__wf_atom_c3534aa7()
		instance:__wf_atom_308a9a4d(v3)
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if
			not __wf_atom_7e8ad928(__wf_atom_e919fb8e.PolearmMultiThrowRuneWeapon)
			and __wf_atom_e919fb8e.PolearmMultiThrowRuneWeapon == instance
		then
			__wf_atom_e919fb8e.PolearmMultiThrowDamageModifier = nil
			__wf_atom_e919fb8e.PolearmMultiThrowStaggerDamageModifier = nil
			__wf_atom_e919fb8e.PolearmMultiThrowRuneWeapon = nil
		end
	end
end

function GetAbilityStats(p, _, object, _, _, _)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 0.4
		elseif p == 2 then
			v = 0.6
		elseif p == 3 then
			v = 0.8
		else
			v = 1
		end

		v2 = 2
	end

	local v6 = {
		BONUS = module2.FormatNumber(v * 100, 0)
	}
	return cjson.encode(v6)
end