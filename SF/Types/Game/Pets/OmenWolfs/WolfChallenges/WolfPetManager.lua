local module = require("SF.Scripts.Libs.PlayerPetLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.ModifySkyLib")
local v = Range(15, 25)
local v2 = WeakResource("/SF/Interface/HUD/PetStatus.swf")
local v3 = nil
local v4 = nil

local function fn()
	if __wf_atom_7e8ad928(v3) then
		return
	end

	if module3.IsRaining() then
		_T.PupIsWet = true
	end

	if module3.WasPreviouslyRaining() and not __wf_atom_7e8ad928(postRainAnim) then
		_T.PupIsWet = false

		while v3:__wf_atom_58dabbc7() do
			Sleep(0)
		end

		v3:__wf_atom_921c1a5f(postRainAnim, false, 4, 1, true)
	end
end

function IntializePet(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_6115a2e2 = __wf_atom_6009c8ed:__wf_atom_6115a2e2()

	if __wf_atom_7e8ad928(__wf_atom_6115a2e2) then
		return
	end

	local __wf_atom_a96eb2aa = __wf_atom_6115a2e2:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	module.ApplyPetFoodUpgrades(__wf_atom_6009c8ed)
	v3 = __wf_atom_6009c8ed

	if not (__wf_atom_7e8ad928(maturityChallenge) or __wf_atom_539492fe:__wf_atom_6bfc87da(maturityChallenge)) then
		local __wf_atom_5eeee535 = __wf_atom_539492fe:__wf_atom_5eeee535(
			maturityChallenge,
			__wf_atom_a96eb2aa,
			maturityChallenge:GetName()
		)

		if not __wf_atom_7e8ad928(__wf_atom_5eeee535) then
			__wf_atom_5eeee535:SetEnabled(true)
		end
	end

	if gRegion:IsMaster() then
		local __wf_atom_4febbf37 = __wf_atom_a96eb2aa:__wf_atom_4febbf37()
		local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.RankupAnim = rankUpAnimation
		__wf_atom_e919fb8e.CombatCounter = 0
		Sleep(1)

		if _T.LocalPlayerInNightFold or module2.IsInNightFold(__wf_atom_6115a2e2) then
			return
		end

		for _, v5 in ipairs(pupChallenges) do
			local __wf_atom_5eeee535 = __wf_atom_539492fe:__wf_atom_5eeee535(v5, __wf_atom_a96eb2aa, v5:GetName())

			if not __wf_atom_7e8ad928(__wf_atom_5eeee535) then
				__wf_atom_5eeee535:SetEnabled(true)
			end
		end

		_T.PupIsWet = false
		module3.AddWeatherCycleChangeCallback(fn)

		if module3.IsRaining() then
			_T.PupIsWet = true
		end

		if not (__wf_atom_7e8ad928(__wf_atom_6115a2e2) or __wf_atom_6115a2e2:IsKilled() or __wf_atom_7e8ad928(__wf_atom_4febbf37)) then
			local __wf_atom_e55d02aa = __wf_atom_6115a2e2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				for i, v5 in ipairs(pupUpgrades) do
					local __wf_atom_4fec12f3 = __wf_atom_a96eb2aa:__wf_atom_4fec12f3(upgradeRequiredStat[i])

					if not (upgradeRequiredStatLevel[i] <= __wf_atom_4fec12f3) then
						continue
					end

					local object2 = gRegion:CreateObject(Type(v5), __wf_atom_6115a2e2)

					if __wf_atom_7e8ad928(object2) then
						continue
					end

					object2:__wf_atom_eaa00d7a((object2:__wf_atom_254ac1f5(__wf_atom_4fec12f3)))
					__wf_atom_e55d02aa:AddUpgrade(object2)
				end
			end
		end
	end
end

function UninitializePet(_, object)
	local __wf_atom_6115a2e2 = object:__wf_atom_6115a2e2()

	if __wf_atom_7e8ad928(__wf_atom_6115a2e2) then
		return
	end

	if __wf_atom_6115a2e2 == gRegion:__wf_atom_c4f78a8f() and not __wf_atom_7e8ad928(v2) then
		local movie = __wf_atom_8e4fda44:FindMovie(v2)

		if not __wf_atom_7e8ad928(movie) then
			movie:Close()
		end
	end

	local __wf_atom_a96eb2aa = __wf_atom_6115a2e2:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	if not __wf_atom_7e8ad928(maturityChallenge) then
		local __wf_atom_f16c0cdd = __wf_atom_539492fe:__wf_atom_f16c0cdd(
			maturityChallenge,
			__wf_atom_a96eb2aa,
			maturityChallenge:GetName()
		)

		if not __wf_atom_7e8ad928(__wf_atom_f16c0cdd) then
			__wf_atom_f16c0cdd:SetEnabled(false)
		end
	end

	if gRegion:IsMaster() then
		for _, v5 in ipairs(pupChallenges) do
			local __wf_atom_f16c0cdd = __wf_atom_539492fe:__wf_atom_f16c0cdd(v5, __wf_atom_a96eb2aa, v5:GetName())

			if not __wf_atom_7e8ad928(__wf_atom_f16c0cdd) then
				__wf_atom_f16c0cdd:SetEnabled(false)
			end
		end

		if not (__wf_atom_7e8ad928(__wf_atom_6115a2e2) or __wf_atom_6115a2e2:IsKilled()) then
			local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

			if not __wf_atom_7e8ad928(__wf_atom_7d789620) then
				__wf_atom_7d789620:__wf_atom_8fd84534(v4, Symbol("PetOwnerEnterEncounter"))
			end

			local __wf_atom_e55d02aa = __wf_atom_6115a2e2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				for _, v5 in ipairs(pupUpgrades) do
					local __wf_atom_5b41f63b = v5:__wf_atom_5b41f63b()

					if __wf_atom_e55d02aa:__wf_atom_a72bba7b(WeakResource(__wf_atom_5b41f63b)) then
						__wf_atom_e55d02aa:RemoveUpgrade(__wf_atom_e55d02aa:__wf_atom_7a2a76fa(v5), true)
					end
				end
			end
		end
	end
end

local function fn2(p, object, p2, p3)
	if module.GetPetEnergyPct(object) <= 0 then
		return
	end

	local rankupAnim = nil
	local __wf_atom_1915cc84 = object:__wf_atom_50a7d83e():__wf_atom_d2b2176d():__wf_atom_1915cc84()

	if not __wf_atom_7e8ad928(__wf_atom_1915cc84) then
		local __wf_atom_e919fb8e = __wf_atom_1915cc84:__wf_atom_e919fb8e()

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.RankupAnim) then
			rankupAnim = __wf_atom_e919fb8e.RankupAnim
		end
	end

	local __wf_atom_cbbadcfc = object:__wf_atom_cbbadcfc()
	local petAvatar = module.GetPetAvatar(object)

	if __wf_atom_7e8ad928(petAvatar) or __wf_atom_7e8ad928(__wf_atom_cbbadcfc) then
		return
	end

	local __wf_atom_827307ac = __wf_atom_cbbadcfc:__wf_atom_827307ac()
	local v5 = __wf_atom_5784a397(__wf_atom_827307ac - fuzzyXpMod, __wf_atom_827307ac + fuzzyXpMod)
	local v6 = math.floor(petAvatar:__wf_atom_d2b2176d():__wf_atom_2a745663(
		v5,
		237,
		__wf_atom_cbbadcfc:__wf_atom_1bb5b1ff(),
		__wf_atom_cbbadcfc
	) + 0.5)
	module.IncreaseStats(p2, object, p, v6, p3, rankupAnim)
	local __wf_atom_2ea6e97c = __wf_atom_cbbadcfc:__wf_atom_2ea6e97c()
	local v7 = __wf_atom_5784a397(__wf_atom_2ea6e97c - fuzzyBondXpMod, __wf_atom_2ea6e97c + fuzzyBondXpMod)
	object:__wf_atom_cf81cc7a(
		8,
		(math.floor(petAvatar:__wf_atom_d2b2176d():__wf_atom_2a745663(
			v7,
			237,
			__wf_atom_cbbadcfc:__wf_atom_1bb5b1ff(),
			__wf_atom_cbbadcfc
		) + 0.5))
	)
	object:__wf_atom_53a74d3e(-petAvatar:__wf_atom_d2b2176d():__wf_atom_2a745663(
		baseEnergyConsumption,
		238,
		__wf_atom_cbbadcfc:__wf_atom_1bb5b1ff(),
		__wf_atom_cbbadcfc
	))
end

function OnSearchTrainingAction(p, p2)
	local v5

	if __wf_atom_7e8ad928(_T.challangeCoolDown) then
		v5 = __wf_atom_5784a397(v.minValue, v.maxValue)
	else
		v5 = _T.challangeCoolDown
	end

	fn2(4, p, p2, v5)
end

function OnGuardTrainingAction(p, p2)
	local v5

	if __wf_atom_7e8ad928(_T.challangeCoolDown) then
		v5 = __wf_atom_5784a397(v.minValue, v.maxValue)
	else
		v5 = _T.challangeCoolDown
	end

	fn2(1, p, p2, v5)
end

function OnSpeedTrainingAction(p, p2)
	local v5

	if __wf_atom_7e8ad928(_T.challangeCoolDown) then
		v5 = __wf_atom_5784a397(v.minValue, v.maxValue)
	else
		v5 = _T.challangeCoolDown
	end

	fn2(2, p, p2, v5)
end

function OnStaminaTrainingAction(p, p2)
	local v5

	if __wf_atom_7e8ad928(_T.challangeCoolDown) then
		v5 = __wf_atom_5784a397(v.minValue, v.maxValue)
	else
		v5 = _T.challangeCoolDown
	end

	fn2(3, p, p2, v5)
end

function OnSupportTrainingAction(p, p2)
	local v5

	if __wf_atom_7e8ad928(_T.challangeCoolDown) then
		v5 = __wf_atom_5784a397(v.minValue, v.maxValue)
	else
		v5 = _T.challangeCoolDown
	end

	fn2(5, p, p2, v5)
end

function GiveMatruityReward(_, _, _)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	local __wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()

	if
		not __wf_atom_7e8ad928(__wf_atom_eab484a7)
		and __wf_atom_eab484a7:IsLocal()
		and not (gGameData:GetInventory():__wf_atom_c9e583ca(wolfTotemType) > 0 or __wf_atom_50a7d83e:__wf_atom_d2b2176d():__wf_atom_ee725e9c(wolfTotemType) > 0)
	then
		if gRegion:IsMaster() then
			__wf_atom_50a7d83e:GiveItem(wolfTotemType, true)
		else
			__wf_atom_eab484a7:__wf_atom_36b99b9d(wolfTotemType, 1)
		end
	end
end

function MaxMaturityReached(object)
	local v5 = object:__wf_atom_a96eb2aa() == gRegion:__wf_atom_eab484a7()
		and not __wf_atom_7e8ad928(pupSummaryMovie)
		and __wf_atom_8e4fda44:FindMovie(pupSummaryMovie)

	if v5 then
		v5:Execute("TransitionOut", "")
	end

	local v6 = v3:Attach(pupMaturityIncreasedCine, EMPTY_SYMBOL)
	v6:__wf_atom_a3d2b66b(object, Symbol("Envoy"))
	v6:__wf_atom_a3d2b66b(v3, Symbol("WolfCub"))
	v6:StartRelative(Symbol("WolfCub"), v3:__wf_atom_a2a18137(), v3:__wf_atom_dc309f8a())

	while not __wf_atom_7e8ad928(v6) and v6:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	v6:Destroy()

	if not __wf_atom_7e8ad928(v3) and v3:IsA(__wf_atom_8d0b7f88) then
		v3:__wf_atom_f173c8ad(true)
	end
end

function PupMaturityIncreased(object, _)
	if __wf_atom_7e8ad928(v3) then
		v3 = module.GetPetAvatar(object)
	end

	if __wf_atom_7e8ad928(v3) then
		return
	end

	if not __wf_atom_7e8ad928(rankUpAnimation) then
		v3:__wf_atom_921c1a5f(rankUpAnimation, false, 4, 1, true)
	end

	local __wf_atom_e55d02aa = v3:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
	local __wf_atom_3fb1fc02 = object:__wf_atom_3fb1fc02()
	local __wf_atom_d46b4a50 = __wf_atom_e55d02aa:__wf_atom_d46b4a50()

	if
		not __wf_atom_7e8ad928(__wf_atom_50a7d83e)
		and not __wf_atom_7e8ad928(__wf_atom_e55d02aa)
		and __wf_atom_d46b4a50 <= __wf_atom_3fb1fc02
	then
		__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("MaxMaturityReached"), false)
	end
end

local function fn3(object)
	if __wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(v3) then
		return
	end

	local __wf_atom_a96eb2aa = v4:__wf_atom_a96eb2aa()

	if object:__wf_atom_4026dfb5() == 4 then
		local __wf_atom_9ecdf04b = object:__wf_atom_9ecdf04b()

		if __wf_atom_9ecdf04b:__wf_atom_8598f3a9() and not v4:__wf_atom_8c3af1a5(__wf_atom_9ecdf04b) then
			local __wf_atom_e919fb8e = v3:__wf_atom_e919fb8e()

			if __wf_atom_5784a397(combatCounterRange.minValue, combatCounterRange.maxValue) <= __wf_atom_e919fb8e.CombatCounter then
				__wf_atom_e919fb8e.CombatCounter = 0
				module.TrainPet(__wf_atom_a96eb2aa, 1, 60)
			else
				__wf_atom_e919fb8e.CombatCounter += 1
			end
		end
	end
end

local function fn4(object, p)
	if not __wf_atom_7e8ad928(v4) and p == v4 then
		object:__wf_atom_055a3c80(Symbol("EncounterHintCallback" .. v4:GetName()))
		Sleep(0)
		object:__wf_atom_8718c6b9(Symbol("PetOwnerLeftEncounter" .. v4:GetName()))
	end
end

local function fn5(object)
	if __wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_99476e23(fn4, Symbol("PetOwnerLeftEncounter" .. v4:GetName()))
	object:__wf_atom_7dd025d4(fn3, Symbol("EncounterHintCallback" .. v4:GetName()))
end

function OwnerCombatMonitor(object)
	Sleep(1)
	object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6115a2e2 = object:__wf_atom_6115a2e2()

	if __wf_atom_7e8ad928(__wf_atom_6115a2e2) then
		print("Pet has lost its owner !")
		return
	end

	v3 = object
	v4 = __wf_atom_6115a2e2

	if gRegion:IsMaster() then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

		if __wf_atom_7e8ad928(__wf_atom_7d789620) then
			return
		end

		__wf_atom_7d789620:__wf_atom_54bf4f2f(v4, fn5, Symbol("PetOwnerEnterEncounter"))
		local __wf_atom_3b708d5d = __wf_atom_7d789620:__wf_atom_3b708d5d(v4)

		for _, v5 in ipairs(__wf_atom_3b708d5d) do
			fn5(v5)
		end
	end

	local __wf_atom_a96eb2aa = v4:__wf_atom_a96eb2aa()

	while not __wf_atom_7e8ad928(v4) do
		local playerIsInBattle = module2.PlayerIsInBattle(__wf_atom_6115a2e2)

		if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			if playerIsInBattle or module2.IsStreamingLevel() then
				module.SetCanPet(__wf_atom_a96eb2aa, false, "InCombat")
			else
				module.SetCanPet(__wf_atom_a96eb2aa, true, "InCombat")
			end
		end

		Sleep(0)
	end
end

function PupEnergyMonitor(object)
	Sleep(0)
	local __wf_atom_6115a2e2 = object:__wf_atom_6115a2e2()
	local movie = __wf_atom_8e4fda44:FindMovie(v2)

	while not __wf_atom_7e8ad928(__wf_atom_6115a2e2) do
		if __wf_atom_7e8ad928(movie) then
			movie = __wf_atom_8e4fda44:FindMovie(v2)
		end

		if
			module.GetPetEnergyPct(__wf_atom_6115a2e2:__wf_atom_a96eb2aa()) <= 0.05
			and not __wf_atom_7e8ad928(movie)
		then
			movie:Execute("OnPetStatusChanged", tostring(2) .. ",false")
		end

		Sleep(2)
	end
end

function RewardMovement(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_6115a2e2():__wf_atom_a96eb2aa()

	if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		module.TrainPet(__wf_atom_a96eb2aa, 2, 60)
	end
end