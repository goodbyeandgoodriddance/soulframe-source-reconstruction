local v = WeakResource("/SF/Types/Game/SFCasterMeleeWeapon")
local v2 = nil

local function fn(object)
	if aerialAttack then
		local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

		if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) and __wf_atom_6009c8ed:__wf_atom_7b82e9e1(15) then
			return true
		end
	end

	if perfectDodgeAttack and object:__wf_atom_ca3e110b() > 1 then
		local __wf_atom_414f70dd = object:__wf_atom_414f70dd(1)

		if not __wf_atom_7e8ad928(__wf_atom_414f70dd) and __wf_atom_414f70dd:IsA(__wf_atom_1a007764) then
			return __wf_atom_414f70dd:__wf_atom_4161712a()
		end
	end

	return false
end

local function fn2(object) -- 2 equivalent calls inferred from this helper
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if
			not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillStacks)
			and __wf_atom_e919fb8e.FocusedSkillStacks >= 4
		then
			return true
		end
	end

	return false
end

local function fn3(object, object2)
	if casterFullGroundedCharge then
		if fn2(object:__wf_atom_6009c8ed()) then -- inferred equivalent call
			return true
		end

		return false
	else
		local __wf_atom_f017ce0f = object2:__wf_atom_f017ce0f()

		if aerialAttack then
			return SF.__wf_atom_2cb11c8f(__wf_atom_f017ce0f)
		end

		if dodgeAttack then
			return SF.__wf_atom_36b7220f(__wf_atom_f017ce0f)
		end

		if perfectDodgeAttack then
			return __wf_atom_f017ce0f == 30 or __wf_atom_f017ce0f == 31
		end

		if sprintAttack then
			return __wf_atom_f017ce0f == 14 or __wf_atom_f017ce0f == 16
		end

		return false
	end
end

local function fn4(instance)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(v) then
		return false
	end

	for i = 0, instance:__wf_atom_ca3e110b() - 1 do
		if instance:__wf_atom_3d08948b(i):IsA(__wf_atom_b734e29f) then
			return true
		end
	end

	return false
end

local function fn5(object)
	local __wf_atom_414f70dd = object:__wf_atom_414f70dd(0)

	if __wf_atom_7e8ad928(__wf_atom_414f70dd) then
		return false
	end

	if __wf_atom_414f70dd:IsA(__wf_atom_7486ea74) then
		return fn(object)
	end

	if __wf_atom_414f70dd:IsA(__wf_atom_f8238f9d) then
		return fn3(object, __wf_atom_414f70dd)
	end

	return false
end

function OnNewProjectile(object, object2)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_197d43b1 = object2:__wf_atom_197d43b1()
	local v3 = false
	local v4 = false

	for _, v5 in ipairs(validProjUpgradeSymbol) do
		if v5 == EMPTY_SYMBOL then
			continue
		end

		v3 = true

		if v5 == __wf_atom_197d43b1 then
			v4 = true
		end
	end

	if v3 and not v4 or not fn5(object) then
		return
	end

	local v5 = 1
	local __wf_atom_7be51ede = object2:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		local __wf_atom_e919fb8e = __wf_atom_7be51ede:__wf_atom_e919fb8e()
		local upgradeID = tostring(upgradeID)

		if
			object:__wf_atom_0395f752() == 5
			and not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.ConditionalProjectileTemperCountPrimary) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.ConditionalProjectileTemperCountPrimary[upgradeID]))
		then
			v5 = __wf_atom_e919fb8e.ConditionalProjectileTemperCountPrimary[upgradeID]
		elseif
			object:__wf_atom_0395f752() == 1
			and not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.ConditionalProjectileTemperCountSecondary) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.ConditionalProjectileTemperCountSecondary[upgradeID]))
		then
			v5 = __wf_atom_e919fb8e.ConditionalProjectileTemperCountSecondary[upgradeID]
		end
	end

	if upgradeDamage > 0 then
		object2:__wf_atom_9fba31e6(operationType, upgradeDamage * v5)
	end

	if upgradeStaggerDamage > 0 then
		object2:__wf_atom_746d4173(operationType, upgradeStaggerDamage * v5)
	end
end

function ManageGroundedUpgrade(object)
	local v3 = false

	while not (__wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(object) or object:IsKilled()) do
		local v4 = false

		if casterFullGroundedCharge then
			v4 = fn2(v2:__wf_atom_6009c8ed()) and true or false -- inferred equivalent call
		end

		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			if v3 or not v4 then
				if v3 and not v4 then
					v3 = false

					for _, v5 in validProjUpgradeSymbol do
						__wf_atom_d2b2176d:RemoveUpgrade(366, 1, upgradeDamage, v2:__wf_atom_1bb5b1ff(), v2, 26, v5)
						__wf_atom_d2b2176d:RemoveUpgrade(
							456,
							1,
							upgradeStaggerDamage,
							v2:__wf_atom_1bb5b1ff(),
							v2,
							26,
							v5
						)
					end
				end
			else
				v3 = true

				for _, v5 in validProjUpgradeSymbol do
					__wf_atom_d2b2176d:AddUpgrade(366, 1, upgradeDamage, v2:__wf_atom_1bb5b1ff(), v2, 26, v5)
					__wf_atom_d2b2176d:AddUpgrade(456, 1, upgradeStaggerDamage, v2:__wf_atom_1bb5b1ff(), v2, 26, v5)
				end
			end
		end

		Sleep(0.1)
	end
end

function ApplyUpgrade(object, object2, _, _, object3)
	if upgradeID == EMPTY_SYMBOL then
		print("BUGGED APPLY UPGRADE ID for DamageOnConditionalProjectile.lua")

		if not __wf_atom_7e8ad928(object3) then
			print(object3:__wf_atom_5b41f63b())
		end
	else
		if not __wf_atom_7e8ad928(object2) then
			object2:__wf_atom_f354682d(upgradeID, "OnNewProjectile")
			v2 = object2
		end

		if fn4(object2) and not __wf_atom_7e8ad928(object) and casterFullGroundedCharge and gRegion:IsMaster() then
			object:__wf_atom_8a035cd5(Symbol("ManageGroundedUpgrade"), false)
		end

		local v3 = __wf_atom_7e8ad928(object3) and 1
			or math.max(1, object2:__wf_atom_b6c3ed85(object3:__wf_atom_1bb5b1ff()))
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.ConditionalProjectileTemperCountPrimary) then
			__wf_atom_e919fb8e.ConditionalProjectileTemperCountPrimary = {}
		end

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.ConditionalProjectileTemperCountSecondary) then
			__wf_atom_e919fb8e.ConditionalProjectileTemperCountSecondary = {}
		end

		local upgradeID = tostring(upgradeID)

		if object2:__wf_atom_0395f752() == 5 then
			__wf_atom_e919fb8e.ConditionalProjectileTemperCountPrimary[upgradeID] = v3
		elseif object2:__wf_atom_0395f752() == 1 then
			__wf_atom_e919fb8e.ConditionalProjectileTemperCountSecondary[upgradeID] = v3
		end
	end
end

function UnapplyUpgrade(object, object2, _, _, object3)
	if upgradeID == EMPTY_SYMBOL then
		print("BUGGED UNAPPLY UPGRADE ID for DamageOnConditionalProjectile.lua")

		if not __wf_atom_7e8ad928(object3) then
			print(object3:__wf_atom_5b41f63b())
		end
	else
		if __wf_atom_7e8ad928(object2) then
			return
		end

		local v3 = __wf_atom_7e8ad928(object3) and 1
			or math.max(1, object2:__wf_atom_b6c3ed85(object3:__wf_atom_1bb5b1ff()))
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.ConditionalProjectileTemperCountPrimary) then
			__wf_atom_e919fb8e.ConditionalProjectileTemperCountPrimary = {}
		end

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.ConditionalProjectileTemperCountSecondary) then
			__wf_atom_e919fb8e.ConditionalProjectileTemperCountSecondary = {}
		end

		local upgradeID2 = tostring(upgradeID)

		if object2:__wf_atom_0395f752() == 5 then
			__wf_atom_e919fb8e.ConditionalProjectileTemperCountPrimary[upgradeID2] = v3
		elseif object2:__wf_atom_0395f752() == 1 then
			__wf_atom_e919fb8e.ConditionalProjectileTemperCountSecondary[upgradeID2] = v3
		end

		if not __wf_atom_7e8ad928(object2) and v3 <= 1 then
			object2:__wf_atom_308a9a4d(upgradeID)
		end
	end
end