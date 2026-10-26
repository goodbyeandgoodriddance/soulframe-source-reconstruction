local v = Symbol("FeyWardDamageCallback")
require("Lotus.Scripts.Libs.AbilitiesLib")
local module = require("SF.Souls.Common.CommonPassive")
local v2 = 30
local v3 = 15
local v4 = 0
local v5 = 0
local v6 = nil
local v7 = WeakResource("/SF/Types/PickUps/Resources/ResourceManualPickup")
local v8 = 10
local v9 = 10
local v10 = Symbol("ThornBlade")
local v11 = 0.05
local v12 = Symbol("FEY_WARD_THORNS")
local v13 = 0.5
local v14 = 1
local v15 = 3
local v16 = 20
local v17 = 0.5
local v18 = 1.4
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(0, 0, nil, nil, 26, Symbol("SoulPulse"))
	local magikForceCalc = module2.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v2 = 5
	elseif __wf_atom_2a745663 == 2 then
		v2 = 7
	elseif __wf_atom_2a745663 == 3 then
		v2 = 9
	else
		v2 = 15
	end

	v3 = 15
	v2 *= magikForceCalc
	return true
end

local function fn2(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(0, 0, nil, nil, 26, Symbol("ThornBlade"))
	local magikForceCalc = module2.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v8 = 8
		v9 = 5
	elseif __wf_atom_2a745663 == 2 then
		v8 = 11
		v9 = 10
	elseif __wf_atom_2a745663 == 3 then
		v8 = 14
		v9 = 15
	else
		v8 = 20
		v9 = 25
	end

	v9 *= magikForceCalc
	return true
end

local function fn3(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(0, 0, nil, nil, 26, Symbol("WardThorns"))
	local magikForceCalc = module2.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v11 = 0.05
	elseif __wf_atom_2a745663 == 2 then
		v11 = 0.1
	elseif __wf_atom_2a745663 == 3 then
		v11 = 0.15
	elseif __wf_atom_2a745663 == 4 then
		v11 = 0.2
	end

	v11 *= magikForceCalc
	return true
end

local function fn4(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
		0,
		0,
		nil,
		nil,
		26,
		Symbol("StandingWater")
	)
	local magikForceCalc = module2.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v13 = 0.2
	elseif __wf_atom_2a745663 == 2 then
		v13 = 0.3
	elseif __wf_atom_2a745663 == 3 then
		v13 = 0.4
	elseif __wf_atom_2a745663 == 4 then
		v13 = 0.5
	end

	v13 *= magikForceCalc
	return true
end

local function fn5(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
		0,
		0,
		nil,
		nil,
		26,
		Symbol("SaboteurSteal")
	)
	local magikForceCalc = module2.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v14 = 1
		v15 = 1
	elseif __wf_atom_2a745663 == 2 then
		v14 = 1.25
		v15 = 0.85
	elseif __wf_atom_2a745663 == 3 then
		v14 = 1.5
		v15 = 0.75
	elseif __wf_atom_2a745663 == 4 then
		v14 = 1.75
		v15 = 0.5
	end

	v14 *= magikForceCalc
	return true
end

local function fn6(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(0, 0, nil, nil, 26, Symbol("KillersHand"))
	local magikForceCalc = module2.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v16 = 20
	elseif __wf_atom_2a745663 == 2 then
		v16 = 25
	elseif __wf_atom_2a745663 == 3 then
		v16 = 35
	elseif __wf_atom_2a745663 == 4 then
		v16 = 50
	end

	v16 *= magikForceCalc
	return true
end

local function fn7(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(0, 0, nil, nil, 26, Symbol("LastStand"))
	local magikForceCalc = module2.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v17 = 0.4
		v18 = 1.05
	elseif __wf_atom_2a745663 == 2 then
		v17 = 0.4
		v18 = 1.075
	elseif __wf_atom_2a745663 == 3 then
		v17 = 0.4
		v18 = 1.1
	elseif __wf_atom_2a745663 == 4 then
		v17 = 0.4
		v18 = 1.15
	end

	v18 *= magikForceCalc
	return true
end

local function fn8(object, object2, p, p2)
	if p then
		local position = object2:GetPosition()
		v4 = math.min(v4 + v3 * p2, v2)

		if not (v5 <= 0) then
			v5 -= p2
			return
		end

		if not v6 then
			v6 = {}
			module2.SetAbilityStats(object, "Passive", v6)
		end

		local all = gRegion:FindAll(__wf_atom_4ebf67cb, position, 0, v4)
		local all2 = gRegion:FindAll(v7, position, 0, v4)
		local __wf_atom_e93896ba = object2:__wf_atom_e93896ba()

		for _, v19 in ipairs(all) do
			if gGameRules:__wf_atom_8c3af1a5(__wf_atom_e93896ba, v19:__wf_atom_e93896ba()) then
				continue
			end

			local soulPulseEnemyFxType = soulPulseEnemyFxType
			local flag = true

			for k in pairs(v6) do
				if v19 ~= k then
					continue
				end

				flag = false
				break
			end

			if flag then
				v6[v19] = v19:Attach(soulPulseEnemyFxType, EMPTY_SYMBOL)
			end
		end

		for _, v19 in ipairs(all2) do
			if not v19:__wf_atom_93b324ab() then
				continue
			end

			local soulPulsePickupFxType = soulPulsePickupFxType
			local flag = true

			for k in pairs(v6) do
				if v19 ~= k then
					continue
				end

				flag = false
				break
			end

			if flag then
				v6[v19] = v19:Attach(soulPulsePickupFxType, EMPTY_SYMBOL)
			end
		end

		v5 += 0.2
	else
		if not v6 then
			v6 = module2.GetAbilityStats(object, "Passive", true)
		end

		for _, v19 in pairs(v6) do
			if __wf_atom_7e8ad928(v19) then
				continue
			end

			if v19:IsA(__wf_atom_9578cbaa) then
				v19:PlayTriggeredFade()
			else
				v19:Destroy()
			end
		end

		v6 = nil
		v4 = 0
		v5 = 0
	end
end

function FeyWardOnDamage(object)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if not (__wf_atom_9d766292:__wf_atom_871aeeac() ~= 7 and fn3(object)) then
		return
	end

	local __wf_atom_679ed446 = __wf_atom_9d766292:__wf_atom_679ed446()

	if
		gRegion:IsMaster()
		and not __wf_atom_7e8ad928(__wf_atom_679ed446)
		and __wf_atom_679ed446:IsA(__wf_atom_67c46eba)
		and not __wf_atom_679ed446:__wf_atom_129d1aba(object)
		and not __wf_atom_679ed446:HasTag(v12)
		and v11 >= math.random()
	then
		__wf_atom_679ed446:Attach(
			feyWardThornsAttachmentType,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			__wf_atom_e55d02aa
		)

		if not __wf_atom_7e8ad928(activateSound) then
			object:PlaySound(activateSound, false)
		end
	end
end

function AddUpgrade(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	module.AddPactWeapon(__wf_atom_6009c8ed, weaponType, weaponEffectsType)
	local _weaponAttachFxType = weaponAttachFxType
	local _snareAttachFxType = snareAttachFxType
	local v19 = Symbol("OnFinisher")
	object:__wf_atom_520644d6(15, v19, v19)

	if __wf_atom_6009c8ed:__wf_atom_8efce136() and fn(__wf_atom_6009c8ed) then
		local __wf_atom_92aa9d91 = __wf_atom_6009c8ed:__wf_atom_92aa9d91()

		while not __wf_atom_6009c8ed:IsKilled() do
			fn8(object, __wf_atom_6009c8ed, __wf_atom_92aa9d91:__wf_atom_3911136e(false), __wf_atom_084b3e93())
			Sleep(0)
		end
	end
end

function AddFeyWardUpgrade(object)
	AddUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	if isSpirit then
		local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.suitAttribute = 1
	end

	__wf_atom_6009c8ed:__wf_atom_51cd6126(v, FeyWardOnDamage)
	local v19

	if __wf_atom_6009c8ed:__wf_atom_0b8838a5() then
		local _ = __wf_atom_6009c8ed:__wf_atom_f105513b() - __wf_atom_6009c8ed:__wf_atom_a2a18137().y > 0
		v19 = 0
	else
		v19 = 0
	end

	while not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:IsKilled()) do
		if __wf_atom_6009c8ed:__wf_atom_4417a5d4() and fn4(__wf_atom_6009c8ed) then
			if
				v19 <= 0
				and __wf_atom_6009c8ed:__wf_atom_0b8838a5()
				and __wf_atom_6009c8ed:__wf_atom_f105513b() - __wf_atom_6009c8ed:__wf_atom_a2a18137().y > 0
			then
				local count = 0
				v19 = 0.1

				for i = 0, object:__wf_atom_87a16e10() - 1 do
					local __wf_atom_c497b0ae = object:__wf_atom_c497b0ae(i)

					if __wf_atom_7e8ad928(__wf_atom_c497b0ae) then
						continue
					end

					local __wf_atom_1fcd5380 = __wf_atom_c497b0ae:__wf_atom_1fcd5380()

					if not (__wf_atom_1fcd5380 > 0) then
						continue
					end

					count += 1
					__wf_atom_c497b0ae:__wf_atom_80e49f0d((math.max(0, __wf_atom_1fcd5380 - v13)))
				end

				local __wf_atom_bb3e7833 = __wf_atom_6009c8ed:__wf_atom_bb3e7833(waterChargeFxType)

				if count > 0 then
					if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_6009c8ed:Attach(waterChargeFxType, EMPTY_SYMBOL)
					end
				elseif not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end
			else
				v19 -= __wf_atom_084b3e93()
			end

			if not (__wf_atom_6009c8ed:__wf_atom_0b8838a5() and __wf_atom_6009c8ed:__wf_atom_f105513b() - __wf_atom_6009c8ed:__wf_atom_a2a18137().y > 0) then
				local __wf_atom_bb3e7833 = __wf_atom_6009c8ed:__wf_atom_bb3e7833(waterChargeFxType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end
			end
		end

		Sleep(0)
	end
end

function FeyChampionOnMeleeKill(object, _, _, object2)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) or not gRegion:IsMaster() then
		return
	end

	fn6(__wf_atom_6009c8ed)
	local __wf_atom_c6f1f83d = __wf_atom_6009c8ed:__wf_atom_c6f1f83d()

	if __wf_atom_c6f1f83d < __wf_atom_6009c8ed:GetMaxHealth() then
		__wf_atom_6009c8ed:Heal(__wf_atom_6009c8ed, v16, __wf_atom_6009c8ed)
		__wf_atom_6009c8ed:NotifyHeal(__wf_atom_6009c8ed:__wf_atom_a96eb2aa(), v16, 0, 1)
		module2.NotifyHeal(__wf_atom_6009c8ed, __wf_atom_6009c8ed:__wf_atom_c6f1f83d() - __wf_atom_c6f1f83d)
		local __wf_atom_f51f1faa = object2:__wf_atom_f51f1faa()

		if __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
			object2:Attach(championTargetKilledFxType, EMPTY_SYMBOL)
		else
			__wf_atom_f51f1faa:Attach(championTargetKilledFxType, EMPTY_SYMBOL)
		end

		__wf_atom_6009c8ed:Attach(championHealFxType, EMPTY_SYMBOL)
	end
end

function AddFeyChampionUpgrade(object)
	AddUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	if isCourage then
		local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.suitAttribute = 0
	end

	local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()

	if gRegion:IsMaster() then
		object:__wf_atom_520644d6(2, Symbol("FeyChampionOnMeleeKill"), Symbol("FeyChampionOnMeleeKill"))
	end

	local v19 = fn7(__wf_atom_6009c8ed)
	local v20 = false

	while not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:IsKilled()) do
		local v21 = __wf_atom_6009c8ed:__wf_atom_c6f1f83d() / __wf_atom_6009c8ed:GetMaxHealth()
		local v22 = v19 and v21 <= v17

		if v22 and not v20 then
			__wf_atom_d2b2176d:AddUpgrade(315, 2, v18, __wf_atom_77e05d3b, nil)
			__wf_atom_6009c8ed:Attach(championAttackSpeedFxType, EMPTY_SYMBOL)
			v20 = true
		end

		if not v22 and v20 then
			__wf_atom_d2b2176d:RemoveUpgrade(315, 2, v18, __wf_atom_77e05d3b, nil)
			local __wf_atom_bb3e7833 = __wf_atom_6009c8ed:__wf_atom_bb3e7833(championAttackSpeedFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end

			v20 = false
		end

		Sleep(0)
	end
end

function RemoveUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	module.RemovePactWeapon(__wf_atom_6009c8ed, weaponType, weaponEffectsType)
	object:__wf_atom_2a5bca4a(nil, Symbol("OnFinisher"))

	if __wf_atom_6009c8ed:__wf_atom_8efce136() then
		fn8(object, __wf_atom_6009c8ed, false, 0)
	end
end

function RemoveFeyWardUpgrade(object)
	RemoveUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	__wf_atom_6009c8ed:__wf_atom_3ede53b4(v)
end

function RemoveFeyChampionUpgrade(object)
	RemoveUpgrade(object)
	object:__wf_atom_2a5bca4a(nil, Symbol("FeyChampionOnMeleeKill"))
end

function AddFeySaboteurUpgrade(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	if isGrace then
		local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.suitAttribute = 2
	end

	module.AddPactWeapon(__wf_atom_6009c8ed, weaponType, weaponEffectsType)
	local v19 = __wf_atom_6009c8ed:__wf_atom_8efce136() and fn(__wf_atom_6009c8ed)
	local v20 = gRegion:IsMaster() and __wf_atom_6009c8ed:__wf_atom_535d5cbb() and fn5(__wf_atom_6009c8ed)
	local __wf_atom_92aa9d91 = __wf_atom_6009c8ed:__wf_atom_92aa9d91()
	local v21 = {}
	local v22 = 0
	local __wf_atom_e93896ba = __wf_atom_6009c8ed:__wf_atom_e93896ba()
	local v23, v24

	if v20 then
		if not _T.saboteurLootPassive then
			_T.saboteurLootPassive = {}
		end

		local __wf_atom_6be84646 = __wf_atom_6009c8ed:__wf_atom_a96eb2aa():__wf_atom_6be84646()

		if _T.saboteurLootPassive[__wf_atom_6be84646] then
			v23 = _T.saboteurLootPassive[__wf_atom_6be84646]
		else
			v23 = {}
			_T.saboteurLootPassive[__wf_atom_6be84646] = v23
		end

		v24 = __wf_atom_6009c8ed:Attach(
			saboteurLootTriggerType,
			Symbol("GAME_C1_HIP1"),
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			__wf_atom_6009c8ed
		)

		if not __wf_atom_7e8ad928(v24) then
			v24:__wf_atom_400189c4(v14)
		end
	end

	while not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:IsKilled()) do
		if v19 then
			fn8(object, __wf_atom_6009c8ed, __wf_atom_92aa9d91:__wf_atom_3911136e(false), __wf_atom_084b3e93())
		end

		if v20 and not __wf_atom_7e8ad928(v24) then
			v22 -= __wf_atom_084b3e93()

			if v22 <= 0 then
				v22 += 0.2

				for k, v25 in pairs(v23) do
					if __wf_atom_7e8ad928(v25) or v25:IsKilled() then
						v23[k] = nil
					end
				end

				local __wf_atom_6f4fd712 = v24:__wf_atom_6f4fd712()
				local v25 = {}

				for _, v26 in ipairs(__wf_atom_6f4fd712) do
					if
						__wf_atom_7e8ad928(v26)
						or v26:IsKilled()
						or v26:__wf_atom_464a4772()
						or not (v26:__wf_atom_2ffebb87() > 0)
					then
						continue
					end

					local __wf_atom_30e3d82b = v26:__wf_atom_30e3d82b()

					if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_04ea4887() then
						continue
					end

					local __wf_atom_bd7269ab = __wf_atom_30e3d82b:__wf_atom_bd7269ab(__wf_atom_6009c8ed)

					if
						not (__wf_atom_7e8ad928(__wf_atom_bd7269ab.avatar) or not __wf_atom_bd7269ab.visible)
						or gGameRules:__wf_atom_8c3af1a5(__wf_atom_e93896ba, v26:__wf_atom_e93896ba())
					then
						continue
					end

					local __wf_atom_18aa6e58 = v26:__wf_atom_18aa6e58()

					if v21[__wf_atom_18aa6e58] then
						v25[__wf_atom_18aa6e58] = v21[__wf_atom_18aa6e58] + 0.2
					else
						v25[__wf_atom_18aa6e58] = 0.2
					end

					local v27 = v25[__wf_atom_18aa6e58]

					if not (v15 <= v27) then
						continue
					end

					v25[__wf_atom_18aa6e58] = nil

					if v23[__wf_atom_18aa6e58] then
						continue
					end

					v23[__wf_atom_18aa6e58] = v26
					v26:Attach(stealFxType, Symbol("GAME_C1_SPINE3"))
					v26:__wf_atom_0097ee5c(1)
					v26:__wf_atom_d2b2176d():__wf_atom_45564ccc()
					v26:__wf_atom_0097ee5c(0)
				end

				v21 = v25
			end
		end

		Sleep(0)
	end
end

function RemoveFeySaboteurUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	module.RemovePactWeapon(__wf_atom_6009c8ed, weaponType, weaponEffectsType)
	__wf_atom_6009c8ed:__wf_atom_0650fed7(saboteurLootTriggerType)
end

function FeyWardThornsAttachmentLoop(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_67c46eba) then
		return
	end

	local creator = instance:GetCreator()

	while __wf_atom_7e8ad928(creator) do
		Sleep(0)
		creator = instance:GetCreator()
	end

	fn3(creator:__wf_atom_6009c8ed())
	local v19 = 5
	local v20 = __wf_atom_3d96ddcd:__wf_atom_464a4772() and v19 > 2.5 and 2.5 or v19
	__wf_atom_3d96ddcd:__wf_atom_78128d94(v12)

	while not __wf_atom_3d96ddcd:IsFrozenSolid() do
		__wf_atom_3d96ddcd:__wf_atom_a0a49499(1, __wf_atom_084b3e93() / 0.25)
		Sleep(0)
	end

	__wf_atom_3d96ddcd:__wf_atom_0fab63d3(false)
	__wf_atom_3d96ddcd:__wf_atom_d2b2176d():__wf_atom_28cf035c()
	__wf_atom_3d96ddcd:__wf_atom_d2b2176d():__wf_atom_d5651846()
	local __wf_atom_c6f1f83d = __wf_atom_3d96ddcd:__wf_atom_c6f1f83d()
	local flag = false

	while v20 > 0 do
		if __wf_atom_3d96ddcd:__wf_atom_c6f1f83d() < __wf_atom_c6f1f83d then
			flag = true
			break
		else
			v20 -= __wf_atom_084b3e93()
			Sleep(0)
		end
	end

	__wf_atom_3d96ddcd:RemoveTag(v12)

	if not __wf_atom_3d96ddcd:IsKilled() then
		__wf_atom_3d96ddcd:__wf_atom_d70bf41b(4)
		__wf_atom_3d96ddcd:__wf_atom_0fab63d3(true)

		if gRegion:IsMaster() then
			if flag then
				local damageData = Engine.DamageData()
				damageData:__wf_atom_d6f4d914(16, true)
				damageData:__wf_atom_12cf5317(__wf_atom_3d96ddcd:__wf_atom_7470861b():__wf_atom_55597fe3():__wf_atom_ac07a537())
				__wf_atom_3d96ddcd:__wf_atom_649bf33e(damageData)
			end

			local __wf_atom_30e3d82b = __wf_atom_3d96ddcd:__wf_atom_30e3d82b()

			if not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_04ea4887()) then
				__wf_atom_30e3d82b:__wf_atom_30b587a4()
			end
		end
	end

	instance:Destroy()
end

function OnFinisher(object, _, _, p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) and fn2(__wf_atom_6009c8ed) then
		_T.FeyThorns = _T.FeyThorns or {}
		_T.FeyThorns[__wf_atom_6009c8ed:__wf_atom_18aa6e58()] = v8

		if not __wf_atom_6009c8ed:HasTag(v10) then
			__wf_atom_6009c8ed:__wf_atom_8a035cd5(v10, false)
		end
	end
end

function ThornBlade(instance)
	instance:__wf_atom_78128d94(v10)
	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	local v19 = Symbol("OnCounter")
	local v20 = v9

	if gRegion:IsMaster() then
		__wf_atom_d2b2176d:AddUpgrade(366, 0, v20, __wf_atom_77e05d3b, nil)
		__wf_atom_e55d02aa:__wf_atom_520644d6(16, v19, v19)

		if not __wf_atom_7e8ad928(activateSound) then
			instance:PlaySound(activateSound, false)
		end
	end

	local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()

	if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		local __wf_atom_66088189 = __wf_atom_9fb9a1d6:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			local name = __wf_atom_66088189:GetName()

			if string.match(name, "Casting") then
				__wf_atom_66088189:Attach(castingAttachFxTypeR, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			else
				__wf_atom_66088189:Attach(weaponAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end
		end

		local __wf_atom_66088189_2 = __wf_atom_9fb9a1d6:__wf_atom_66088189(1, 1)

		if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
			local name = __wf_atom_66088189_2:GetName()

			if string.match(name, "Shield") then
				__wf_atom_66088189_2:Attach(shieldAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			elseif string.match(name, "Casting") then
				__wf_atom_66088189_2:Attach(castingAttachFxTypeL, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			else
				__wf_atom_66088189_2:Attach(weaponAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end
		end
	end

	local __wf_atom_18aa6e58 = instance:__wf_atom_18aa6e58()

	while _T.FeyThorns and _T.FeyThorns[__wf_atom_18aa6e58] > 0 do
		Sleep(0)
		_T.FeyThorns[__wf_atom_18aa6e58] -= __wf_atom_084b3e93()
	end

	if gRegion:IsMaster() then
		__wf_atom_d2b2176d:RemoveUpgrade(366, 0, v20, __wf_atom_77e05d3b, nil)

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_2a5bca4a(nil, v19)
		end

		if not __wf_atom_7e8ad928(deactivateSound) then
			instance:PlaySound(deactivateSound, false)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		local __wf_atom_66088189 = __wf_atom_9fb9a1d6:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(weaponAttachFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end

		local __wf_atom_66088189_2 = __wf_atom_9fb9a1d6:__wf_atom_66088189(1, 1)

		if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
			local weaponAttachFxType = weaponAttachFxType
			local name = __wf_atom_66088189_2:GetName()

			if string.match(name, "Shield") then
				weaponAttachFxType = shieldAttachFxType
			end

			local __wf_atom_bb3e7833 = __wf_atom_66088189_2:__wf_atom_bb3e7833(weaponAttachFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end

	_T.FeyThorns[__wf_atom_18aa6e58] = nil

	if not next(_T.FeyThorns) then
		_T.FeyThorns = nil
	end

	instance:RemoveTag(v10)
end

function OnCounter(p, _, _, instance)
	if gRegion:IsMaster() and not (__wf_atom_7e8ad928(instance) or instance:HasTag(Symbol("FeyEnsnare"))) then
		mOwner = p
		instance:__wf_atom_8a035cd5(Symbol("Ensnare"), false)
	end
end

function Ensnare(instance)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_4ebf67cb) then
		return
	end

	local v19 = Symbol("FeyEnsnare")
	instance:__wf_atom_78128d94(v19)
	instance:__wf_atom_d2b2176d():__wf_atom_28cf035c()
	local v20 = __wf_atom_7e8ad928(mOwner) and 0 or mOwner:__wf_atom_22941262() or 0
	local __wf_atom_68de036a = instance:__wf_atom_68de036a()
	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	local __wf_atom_c6f1f83d = instance:__wf_atom_c6f1f83d()
	local v21 = 0.5
	local v22 = 5
	local v23 = 3

	if __wf_atom_68de036a <= v20 then
		if v20 - __wf_atom_68de036a >= 5 then
			v23 = 10
			v21 = 0.1
			v22 = 10
		end
	elseif __wf_atom_68de036a - v20 >= 5 then
		v23 = 2
		v21 = 0.75
		v22 = 5
	end

	__wf_atom_7470861b:__wf_atom_9fba31e6(v19, 26, 6, v23)
	instance:__wf_atom_986f733d(v19, v21)
	local v24 = instance:Attach(snareAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	while v22 > 0 and not (instance:__wf_atom_c6f1f83d() < __wf_atom_c6f1f83d) do
		Sleep(0)
		v22 -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(v24) then
		v24:Destroy()
	end

	__wf_atom_7470861b:__wf_atom_63396172(v19)
	instance:__wf_atom_558ce619(v19)
	instance:RemoveTag(v19)
end