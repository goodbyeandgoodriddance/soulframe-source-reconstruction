local v = 12
local v2 = 100
local module = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(p, p2)
	local magikForceCalc = module.magikForceCalc(p2, p, mOwner)
	module.magikEnergyCalc(p2, p, mOwner)

	if p == 1 then
		v2 = 100
		v = 6
	end

	if p == 2 then
		v2 = 150
		v = 8
	end

	if p == 3 then
		v2 = 200
		v = 10
	end

	if p >= 4 then
		v2 = 220
		v = 12
	end

	v2 *= magikForceCalc
	v *= magikForceCalc
end

function GetAbilityUpgradeLevelInfo()
	mOwner = _T.AbilityLevelQueryParms.Ability
	fn(_T.AbilityLevelQueryParms.Level, _T.AbilityLevelQueryParms.Avatar)
	local abilityUpgradeLevelInfo = {}
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/DAMAGE",
		Value = v2,
		ValuePost = "/SF/Language/Menu/DT_SLASH"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/ABILITY_RADIUS",
		Value = 5,
		ValueUnit = "/Lotus/Language/Game/UNIT_METER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/POWER_DURATION",
		Value = v,
		ValueUnit = "/Lotus/Language/Game/UNIT_SECOND"
	})
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

function FlockImpact(object, instance)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(birdType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_4ebf67cb) and instance:__wf_atom_39ae2374(0) then
		instance = nil
	end

	local position

	if __wf_atom_7e8ad928(instance) then
		if __wf_atom_7e8ad928(object) then
			object:Die()
			return
		else
			position = object:GetPosition()
		end
	else
		position = instance:__wf_atom_d0069154()
	end

	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		object:Die()
		return
	end

	local __wf_atom_e55d02aa = __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		object:Die()
		return
	end

	if __wf_atom_e55d02aa:__wf_atom_f5ca3244() then
		mOwner = __wf_atom_e55d02aa:__wf_atom_e21e8409(WeakResource("/SF/Souls/Default/FeyWardFlockAbilityPrime"))
	else
		mOwner = __wf_atom_e55d02aa:__wf_atom_e21e8409(WeakResource("/SF/Souls/Default/FeyWardFlockAbility"))
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.DelayCooldown = true
	local __wf_atom_e8008ec5 = __wf_atom_e55d02aa:__wf_atom_e8008ec5(mOwner)
	fn(
		not (__wf_atom_e8008ec5 < __wf_atom_e55d02aa:__wf_atom_87a16e10()) and 1 or __wf_atom_e55d02aa:__wf_atom_cc3c265a(__wf_atom_e8008ec5) or 1,
		__wf_atom_7be51ede
	)
	local v3 = 0
	local v4 = v2 / v * 0.25
	local __wf_atom_4417a5d4 = __wf_atom_7be51ede:__wf_atom_4417a5d4()
	local v5 = v2
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = 3
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = false
	radialDamageData:__wf_atom_7498285f(2, 1)
	radialDamageData:__wf_atom_6b472125(__wf_atom_7be51ede)
	radialDamageData:__wf_atom_34a8a27a(__wf_atom_e55d02aa)
	local fn2

	if __wf_atom_7e8ad928(instance) then
		fn2 = function(object2)
			if not __wf_atom_7e8ad928(object2) then
				local __wf_atom_f582136d = object2:__wf_atom_f582136d(targetAttachFxType)

				for i = 1, #__wf_atom_f582136d do
					if not __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
						__wf_atom_f582136d[i]:Destroy()
					end
				end
			end
		end
	else
		instance:Attach(targetAttachFxType, Symbol("GAME_C1_SPINE3"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		gRegion:__wf_atom_2202ffb6():__wf_atom_192b9cb0(2, 13, instance:GetPosition(), nil, 0, 7.5, false)

		fn2 = function(object2)
			if not __wf_atom_7e8ad928(object2) then
				local __wf_atom_f582136d = object2:__wf_atom_f582136d(targetAttachFxType)

				for i = 1, #__wf_atom_f582136d do
					if not __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
						__wf_atom_f582136d[i]:Destroy()
					end
				end
			end
		end
	end

	local v6 = nil
	local total = 0

	while v2 > 0 and __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) do
		if
			__wf_atom_7e8ad928(instance)
			or instance:IsKilled()
			or instance:__wf_atom_4402f880(__wf_atom_7be51ede)
			or not instance:IsVisible()
			or instance:__wf_atom_7b82e9e1(6)
		then
			if not __wf_atom_7e8ad928(instance) then
				v6 = instance
			end

			local all = gRegion:FindAll(__wf_atom_4ebf67cb, position, 0, 5)
			table.sort(all, function(a, b)
				return a:__wf_atom_c215662d(position) < b:__wf_atom_c215662d(position)
			end)
			instance = nil

			for _, v7 in ipairs(all) do
				if v7:__wf_atom_4402f880(__wf_atom_7be51ede) or v7:__wf_atom_39ae2374(0) then
					continue
				end

				if v7 == v6 then
					if #all == 1 then
						instance = v7
						break
					end
				else
					fn2(v6)
					v7:Attach(targetAttachFxType, Symbol("GAME_C1_SPINE3"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
					instance = v7
					break
				end
			end

			if __wf_atom_7e8ad928(instance) then
				break
			end
		end

		position = instance:__wf_atom_d0069154()
		total += __wf_atom_084b3e93()

		if v3 <= 0 then
			local v7 = 1
			instance:Attach(targetAttachFxType, Symbol("GAME_C1_SPINE3"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)

			if __wf_atom_4417a5d4 then
				radialDamageData.baseAmount = math.min(v2, v4 * (total + 1)) * v7
				radialDamageData.stabilityDamage = radialDamageData.baseAmount * (total + 1)
				local v8 = Vector(Random(-0.1, 0.1), 0, Random(-0.1, 0.1))
				radialDamageData:__wf_atom_98d98d81(instance:__wf_atom_d0069154() + v8)
				gRegion:__wf_atom_f6ec80de(radialDamageData)
			end

			v2 -= v4
			v3 = Random(0.25, 1)
			v4 = v5 / v * v3
		end

		if
			__wf_atom_7e8ad928(instance)
			or not (instance:__wf_atom_464a4772() and instance:__wf_atom_7470861b():__wf_atom_5d3f45d7() <= 0)
		then
			Sleep(0)
			v3 -= __wf_atom_084b3e93()
		else
			break
		end
	end

	if not __wf_atom_7e8ad928(mOwner) then
		mOwner:__wf_atom_a7328d06(false)
	end

	fn2(instance)
	fn2(v6)
	object:Die()
end