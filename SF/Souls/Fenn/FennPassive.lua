require("Lotus.Scripts.Libs.AbilitiesLib")
local module = require("SF.Souls.Common.CommonPassive")
local v = 2
local v2 = 0.25
local v3 = 5
local v4 = 10
local v5 = 10
local v6 = 30
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")
local v7 = Symbol("FennBuffPassive")

function EvaluateAbility(p, p2)
	return module2.EvaluateUltAbility(p, p2)
end

local function fn(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(0, 0, nil, nil, 26, Symbol("SlowBoil"))
	local magikForceCalc = module2.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v = 2
		v2 = 1
		v3 = 8
	elseif __wf_atom_2a745663 == 2 then
		v = 3
		v2 = 1
		v3 = 6
	elseif __wf_atom_2a745663 == 3 then
		v = 4
		v2 = 1
		v3 = 6
	else
		v = 5
		v2 = 1
		v3 = 5
	end

	v4 = 10
	v *= magikForceCalc
	return true
end

local function fn2(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
		0,
		0,
		nil,
		nil,
		26,
		Symbol("FanTheFlames")
	)
	local magikForceCalc = module2.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v5 = 0.05
		v6 = 30
	elseif __wf_atom_2a745663 == 2 then
		v5 = 0.075
		v6 = 40
	elseif __wf_atom_2a745663 == 3 then
		v5 = 0.15
		v6 = 50
	else
		v5 = 0.2
		v6 = 60
	end

	v5 *= magikForceCalc
	return true
end

function AddUpgrade(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	module.AddPactWeapon(__wf_atom_6009c8ed, weaponType, weaponEffectsType)
	local v8 = 1
	local v9 = 0
	local damageData = Engine.DamageData()
	local total = 0
	damageData.baseAmount = 0
	damageData:__wf_atom_7498285f(15, 1)
	damageData:__wf_atom_6b472125(__wf_atom_6009c8ed)
	damageData.injuryType = 17
	damageData:__wf_atom_34a8a27a(object)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = 100
	radialDamageData.radius = 4
	radialDamageData:__wf_atom_7498285f(3, 1)
	radialDamageData:__wf_atom_d6f4d914(3, true)
	radialDamageData:__wf_atom_6b472125(__wf_atom_6009c8ed)
	radialDamageData:__wf_atom_34a8a27a(object)
	radialDamageData:__wf_atom_12cf5317(100)
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = true
	radialDamageData.staticCoverOnly = true

	if gRegion:IsMaster() and fn2(__wf_atom_6009c8ed) then
		__wf_atom_6009c8ed:__wf_atom_51cd6126(v7, "OnDamaged")
	end

	local isMaster = gRegion:IsMaster()
	local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()
	local v10 = false

	while not __wf_atom_7e8ad928(__wf_atom_6009c8ed) do
		if gRegion:IsMaster() and fn(__wf_atom_6009c8ed) then
			local __wf_atom_5d790fbf = __wf_atom_6009c8ed:__wf_atom_92aa9d91():__wf_atom_5d790fbf()

			if __wf_atom_7e8ad928(__wf_atom_5d790fbf) or not __wf_atom_5d790fbf:IsA(__wf_atom_4ebf67cb) then
				damageData.baseAmount = 0
				v8 = 1
				v9 = 5
				total = 0
				v10 = false
			else
				v8 -= __wf_atom_084b3e93()

				if
					__wf_atom_5d790fbf:__wf_atom_7470861b():__wf_atom_b76d107d(3)
					and not __wf_atom_5d790fbf:__wf_atom_464a4772()
				then
					v9 -= __wf_atom_084b3e93() * 2
				else
					v9 -= __wf_atom_084b3e93()
				end

				if v9 <= 0 then
					local v11

					if __wf_atom_5d790fbf:__wf_atom_464a4772() then
						v11 = v2
						v9 = v4
					else
						v11 = v
						v9 = v3
					end

					total += v11
					damageData.baseAmount = total
				end

				if total > 6 and not (v10 or __wf_atom_5d790fbf:__wf_atom_464a4772()) then
					local __wf_atom_a2a18137 = __wf_atom_5d790fbf:__wf_atom_a2a18137()
					radialDamageData:__wf_atom_98d98d81(__wf_atom_a2a18137)
					gRegion:__wf_atom_f6ec80de(radialDamageData)
					gRegion:CreateEntity(burstFxType, __wf_atom_a2a18137, __wf_atom_80368bb1, __wf_atom_6009c8ed)
					v10 = true
				end

				if v8 <= 0 then
					if isMaster then
						__wf_atom_5d790fbf:__wf_atom_649bf33e(damageData)
						__wf_atom_5d790fbf:Attach(boilFxType, Symbol("GAME_C1_SPINE3"))
					end

					v8 = 1
				end
			end
		end

		if gRegion:IsMaster() and fn2(__wf_atom_6009c8ed) then
			local __wf_atom_7470861b = __wf_atom_6009c8ed:__wf_atom_7470861b()
			local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

			if not __wf_atom_e919fb8e.FennOnFire then
				__wf_atom_e919fb8e.FennOnFire = __wf_atom_7470861b:__wf_atom_b76d107d(3)
			end

			if __wf_atom_e919fb8e.FennOnFire then
				fn2(__wf_atom_6009c8ed)
				local v11 = v5

				if __wf_atom_d2b2176d:__wf_atom_003db090(v7, 401, 3, v11) <= 0 then
					__wf_atom_d2b2176d:__wf_atom_0f765e85(v7, v6, 401, 3, v11)
				else
					__wf_atom_d2b2176d:__wf_atom_4dafafc8(v7, v6, 401, 3, 0)
				end
			end
		end

		Sleep(0)
	end
end

function RemoveUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	module.RemovePactWeapon(__wf_atom_6009c8ed, weaponType, weaponEffectsType)

	if gRegion:IsMaster() then
		__wf_atom_6009c8ed:__wf_atom_3ede53b4(v7)
		local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()
		local __wf_atom_07dc8ba3 = __wf_atom_d2b2176d:__wf_atom_07dc8ba3(v7)

		if __wf_atom_07dc8ba3 > 0 then
			__wf_atom_d2b2176d:__wf_atom_066a9716(v7, 366, 0, __wf_atom_07dc8ba3)
		end
	end
end

function OnDamaged(object)
	local __wf_atom_483e7ddc = object:__wf_atom_9d766292():__wf_atom_483e7ddc()

	if __wf_atom_7e8ad928(__wf_atom_483e7ddc) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_483e7ddc:__wf_atom_bf612a92(3) * __wf_atom_483e7ddc:__wf_atom_6386920d():__wf_atom_37799654() <= 0 then
		__wf_atom_e919fb8e.FennOnFire = false
	else
		__wf_atom_e919fb8e.FennOnFire = true
	end
end