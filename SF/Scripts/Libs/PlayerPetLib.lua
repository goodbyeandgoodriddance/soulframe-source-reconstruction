module(..., package.seeall)
require("Lotus.Scripts.Libs.AbilitiesLib")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")
local v = WeakResource("/SF/Interface/HUD/PetStatus.swf")
local v2 = Resource("/SF/Sounds/Dialog/TransmissionSets/WolfCubTransmissionset")
local v3 = Resource("/SF/Animations/Wildlife/WolfCub/Summon_anim.fbx")
local v4 = Resource("/SF/Sounds/Animals/WolfCubs/Abilities/WolfCubSummonAppearContainer")
local v5 = Type("/SF/Fx/Abilities/Common/Summon/WolfCubSummonAttachFX")
local v6 = Resource("/SF/Types/NeutralCreatures/Wolf/PerceptionInfo/SummonPerceptionInfo")
local v7 = {
	[1] = Symbol("GUARD_TRAINED"),
	[4] = Symbol("SEARCH_TRAINED"),
	[2] = Symbol("SPEED_TRAINED"),
	[3] = Symbol("STAMINA_TRAINED"),
	[5] = Symbol("SUPPORT_TRAINED")
}
local v8 = {
	{
		Temperment = 0,
		BuffableStats = { 1, 3 }
	},
	{
		Temperment = 2,
		BuffableStats = { 2, 3 }
	},
	{
		Temperment = 1,
		BuffableStats = { 5, 4 }
	}
}

function GetTempermentBuffMap(p)
	for _, v9 in pairs(v8) do
		if v9.Temperment == p then
			return v9
		end
	end

	return nil
end

function SetPlayerPetAppeanceSkin(_, _) end

function OpenPetStatusMovie()
	if not __wf_atom_7e8ad928(v) then
		__wf_atom_8e4fda44:__wf_atom_3e5e23c0(v, "")
	end
end

function CreatePet(p, p2, p3, p4, p5, p6, object)
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()
	local __wf_atom_402b3832 = gRegion:__wf_atom_2202ffb6():__wf_atom_402b3832(
		p,
		p2,
		p3,
		EMPTY_SYMBOL,
		0,
		true,
		0,
		0,
		p4 or nil
	)

	if __wf_atom_7e8ad928(__wf_atom_402b3832) or __wf_atom_7e8ad928(__wf_atom_402b3832:__wf_atom_50a7d83e()) then
		return nil
	end

	local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()
	__wf_atom_50a7d83e:PlaySound(p5 or nil, false, 1, false)
	__wf_atom_50a7d83e:__wf_atom_6a95c7b8(object)
	__wf_atom_50a7d83e:__wf_atom_8f0b611f(mOwner)
	__wf_atom_50a7d83e:__wf_atom_65fd9d84(object)
	__wf_atom_50a7d83e:__wf_atom_f0b3ae4d(object)

	if not __wf_atom_7e8ad928(p6) then
		__wf_atom_50a7d83e:Attach(p6, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	__wf_atom_402b3832:__wf_atom_2e7b29b1(false)
	local __wf_atom_ed5c034d = __wf_atom_a96eb2aa:__wf_atom_a4299765():__wf_atom_ed5c034d(1, 0)

	if __wf_atom_7e8ad928(__wf_atom_ed5c034d) then
		print("PLAYER PET: missing weaponInfo for pet")
		return __wf_atom_50a7d83e
	end

	if __wf_atom_7e8ad928((__wf_atom_50a7d83e:GiveItem(Type(__wf_atom_ed5c034d.mItemType), false))) then
		print("PLAYER PET: missing suit for pet")
		return __wf_atom_50a7d83e
	end

	object:__wf_atom_d2b2176d():SetSentinelForPlayer(__wf_atom_50a7d83e)
	return __wf_atom_50a7d83e
end

function SetPetResting(object, p)
	if not gRegion:IsMaster() or (__wf_atom_7e8ad928(object) or not object:__wf_atom_5e8fa1ad()) then
		return
	end

	local __wf_atom_4febbf37 = object:__wf_atom_4febbf37()
	local __wf_atom_6e22b0cc = __wf_atom_4febbf37:__wf_atom_6e22b0cc()

	if (__wf_atom_6e22b0cc > 0) == p then
		return
	end

	if not p then
		local __wf_atom_ed5c034d = object:__wf_atom_a4299765():__wf_atom_ed5c034d(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_ed5c034d.mItemType) then
			local maxStat = Type(__wf_atom_ed5c034d.mItemType):GetMaxStat(0)
			__wf_atom_4febbf37.mEnergy = math.min(maxStat, __wf_atom_4febbf37.mEnergy + __wf_atom_6e22b0cc * (2 / 225))

			if maxStat <= 0 or __wf_atom_4febbf37.mEnergy / maxStat > 0.8 then
				__wf_atom_4febbf37.mNeedsRest = false
			end
		end
	end

	__wf_atom_4febbf37:__wf_atom_9e75dfd5(p)
	object:__wf_atom_e712defd(__wf_atom_4febbf37)
end

function HasPetInNightfold(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return false
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return false
	end

	local __wf_atom_a4299765 = __wf_atom_a96eb2aa:__wf_atom_a4299765()

	if __wf_atom_7e8ad928(__wf_atom_a4299765.mPetAgentType) then
		return false
	end

	return not __wf_atom_7e8ad928(__wf_atom_a4299765:__wf_atom_ed5c034d(1, 0).mItemType)
end

function CanSummonPet(object, p)
	if __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return false
	end

	if object:__wf_atom_58dabbc7() or object:__wf_atom_47fbd15c() then
		if p then
			module2.PlayLocalTransmission(v2, Symbol("WolfCubHowl"), object, false)
		end

		return false
	elseif module.PlayerIsInBattle(object) then
		if p then
			module2.PlayLocalTransmission(v2, Symbol("WolfCubHowl"), object, false)
		end

		return false
	else
		local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

		if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			return false
		end

		local __wf_atom_a4299765 = __wf_atom_a96eb2aa:__wf_atom_a4299765()

		if
			__wf_atom_7e8ad928(__wf_atom_a4299765.mPetAgentType)
			or __wf_atom_7e8ad928(__wf_atom_a4299765:__wf_atom_ed5c034d(1, 0).mItemType)
		then
			return false
		end

		if HasEnergyToSummon(__wf_atom_a96eb2aa) then
			return true
		end

		if p then
			module2.PlayLocalTransmission(v2, Symbol("WolfSleepy"), object, false)
		end

		return false
	end
end

function SummonPlayerPet(object, p)
	if __wf_atom_7e8ad928(object) or not gRegion:IsMaster() then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar) then
		return
	end

	local __wf_atom_0d9c1a58 = object:__wf_atom_0d9c1a58()

	if __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
		return
	end

	local v9 = Type(__wf_atom_0d9c1a58:__wf_atom_a4299765().mPetAgentType)

	if __wf_atom_7e8ad928(v9) then
		return
	end

	gRegion:__wf_atom_2202ffb6():__wf_atom_5ed7114d(v6, object, object:GetPosition())
	object:__wf_atom_a2a18137()
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	local playerWolfAvatar = CreatePet(v9, p, __wf_atom_2f2bada0, v3, v4, v5, object)
	__wf_atom_e919fb8e.PlayerWolfAvatar = playerWolfAvatar
	SetPetResting(object:__wf_atom_a96eb2aa(), false)
	return playerWolfAvatar
end

function GetPetAvatar(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		return nil
	end

	return __wf_atom_50a7d83e:__wf_atom_e919fb8e().PlayerWolfAvatar
end

function IsOverconsumptionActive(object, p)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if p == 6 then
		return __wf_atom_e919fb8e.PetMealOverconsumptionActive or false
	end

	return p == 7 and (__wf_atom_e919fb8e.PetSnackOverconsumptionActive or false)
end

function GetPetEnergyPct(object, p)
	if __wf_atom_7e8ad928(object) or not object:__wf_atom_5e8fa1ad() then
		return 0
	end

	if __wf_atom_7e8ad928(object:__wf_atom_a4299765():__wf_atom_ed5c034d(1, 0).mItemType) then
		return 0
	end

	local v9

	if __wf_atom_7e8ad928(p) then
		v9 = object:__wf_atom_cbbadcfc()
	else
		v9 = Type(p)
	end

	if __wf_atom_7e8ad928(v9) then
		return 0
	end

	local maxStat = v9:GetMaxStat(0)

	if maxStat <= 0 then
		return 0
	end

	local __wf_atom_4febbf37 = object:__wf_atom_4febbf37()
	local __wf_atom_6e22b0cc = __wf_atom_4febbf37:__wf_atom_6e22b0cc()
	return (math.min(1, (__wf_atom_4febbf37.mEnergy + __wf_atom_6e22b0cc * (2 / 225)) / maxStat))
end

function HasEnergyToSummon(object, p)
	if __wf_atom_7e8ad928(object) or not object:__wf_atom_5e8fa1ad() then
		return false
	end

	local v9 = GetPetEnergyPct(object, p)
	return v9 > 0 and (not object:__wf_atom_4febbf37().mNeedsRest or v9 > 0.8)
end

function GetMaxStat(object, p)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		print("Missing player avatar")
		return 0
	end

	local __wf_atom_e919fb8e = __wf_atom_50a7d83e:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar) then
		print("Missing pet avatar")
		return 0
	end

	local __wf_atom_e55d02aa = __wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return nil
	end

	return (__wf_atom_e55d02aa:GetMaxStat(p))
end

function GetPetStat(data, p)
	if p == 1 then
		return data.mGuard
	elseif p == 4 then
		return data.mSearch
	elseif p == 2 then
		return data.mSpeed
	elseif p == 3 then
		return data.mStamina
	elseif p == 5 then
		return data.mSupport
	elseif p == 6 then
		return data.mMealsEaten
	elseif p == 7 then
		return data.mSnacksEaten
	end

	return nil
end

function GetPetMaxSkillLevel(object, p)
	local __wf_atom_cbbadcfc = object:__wf_atom_cbbadcfc()

	if __wf_atom_7e8ad928(__wf_atom_cbbadcfc) then
		return 0
	end

	return (__wf_atom_cbbadcfc:GetMaxStat(p))
end

function CheckPetEnergy(p)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	if p.mEnergy >= 100 or p.mEnergy >= 50 then
		return true
	end

	if p.mEnergy <= 10 then
		return false
	end

	return false
end

function IncreaseStats(p, object, p2, value, value2, _)
	if
		__wf_atom_7e8ad928(object)
		or not object:__wf_atom_5e8fa1ad()
		or __wf_atom_7e8ad928((object:__wf_atom_cbbadcfc()))
	then
		return
	end

	object:__wf_atom_cf81cc7a(p2, value or 0)
	object:__wf_atom_50a7d83e():__wf_atom_d2b2176d():__wf_atom_1915cc84()
	__wf_atom_539492fe:__wf_atom_1c2fdb1e(p, value2 or 10)
	_T.challangeCoolDown = nil
end

function TrainPet(p, p2, challangeCoolDown)
	_T.challangeCoolDown = challangeCoolDown
	__wf_atom_539492fe:__wf_atom_c2038c7a(p, v7[p2])
end

function GetPetMaturity(object)
	return object:__wf_atom_3fb1fc02()
end

function GetPetMaxMaturity(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		print("Missing player avatar")
		return 0
	end

	local __wf_atom_e919fb8e = __wf_atom_50a7d83e:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar) then
		print("Missing pet avatar")
		return 0
	end

	local __wf_atom_e55d02aa = __wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return (__wf_atom_e55d02aa:__wf_atom_d46b4a50())
	end

	print("Missing pet suit")
	return 0
end

function GetSkillEligibility(object, p)
	local __wf_atom_4febbf37 = object:__wf_atom_4febbf37()
	local __wf_atom_cbbadcfc = object:__wf_atom_cbbadcfc()

	if __wf_atom_7e8ad928(__wf_atom_cbbadcfc) then
		return 0
	end

	local v9 = math.max(
		0,
		__wf_atom_cbbadcfc:__wf_atom_d46b4a50() - (__wf_atom_4febbf37.mGuardSkill + __wf_atom_4febbf37.mSearchSkill + __wf_atom_4febbf37.mSpeedSkill + __wf_atom_4febbf37.mStaminaSkill + __wf_atom_4febbf37.mSupportSkill)
	)
	local mGuard, mGuardSkill

	if p == 1 then
		mGuard = __wf_atom_4febbf37.mGuard
		mGuardSkill = __wf_atom_4febbf37.mGuardSkill
	elseif p == 4 then
		mGuard = __wf_atom_4febbf37.mSearch
		mGuardSkill = __wf_atom_4febbf37.mSearchSkill
	elseif p == 2 then
		mGuard = __wf_atom_4febbf37.mSpeed
		mGuardSkill = __wf_atom_4febbf37.mSpeedSkill
	elseif p == 3 then
		mGuard = __wf_atom_4febbf37.mStamina
		mGuardSkill = __wf_atom_4febbf37.mStaminaSkill
	else
		if p ~= 5 then
			print("Invalid statType")
			return 0
		end

		mGuard = __wf_atom_4febbf37.mSupport
		mGuardSkill = __wf_atom_4febbf37.mSupportSkill
	end

	return (math.min(
		v9,
		math.min(__wf_atom_cbbadcfc:__wf_atom_82b1de4f(mGuard), __wf_atom_cbbadcfc:GetMaxStat(p)) - mGuardSkill
	))
end

function SetCanPet(p, p2, p3)
	local v9 = GetPetAvatar(p)

	if __wf_atom_7e8ad928(v9) then
		return
	end

	local __wf_atom_e919fb8e = v9:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.CanPetTable) then
		__wf_atom_e919fb8e.CanPetTable = {}
	end

	if p2 then
		__wf_atom_e919fb8e.CanPetTable[p3] = nil
	else
		__wf_atom_e919fb8e.CanPetTable[p3] = p2
	end

	ToggleCanPet(v9)
end

function GetCanPet(p)
	local v9 = GetPetAvatar(p)

	if __wf_atom_7e8ad928(v9) then
		return
	end

	local __wf_atom_e919fb8e = v9:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.CanPetTable) then
		__wf_atom_e919fb8e.CanPetTable = {}
	end

	return (__wf_atom_7e8ad928(next(__wf_atom_e919fb8e.CanPetTable)))
end

function ToggleCanPet(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Ctx) then
		return
	end

	if __wf_atom_7e8ad928(next(__wf_atom_e919fb8e.CanPetTable)) then
		__wf_atom_e919fb8e.Ctx:Enable()
	else
		__wf_atom_e919fb8e.Ctx:Disable()
	end
end

local v9 = nil

function RunPetFoodFnc(p)
	local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(v9.Expiry)
	v9.Fnc(p, __wf_atom_db2b0cee)
end

function ApplyPetFoodUpgrades(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6115a2e2 = object:__wf_atom_6115a2e2()

	if __wf_atom_7e8ad928(__wf_atom_6115a2e2) then
		return
	end

	local __wf_atom_a96eb2aa = __wf_atom_6115a2e2:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	local __wf_atom_6be84646 = __wf_atom_a96eb2aa:__wf_atom_6be84646()

	if not (_T.PetFoodTimers and _T.PetFoodTimers[__wf_atom_6be84646]) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	for k, v10 in pairs(_T.PetFoodTimers[__wf_atom_6be84646]) do
		if gRegion:IsMaster() then
			__wf_atom_d2b2176d:__wf_atom_e3f17301(Symbol(k))
		end

		local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(v10.Expiry)

		if __wf_atom_db2b0cee <= 0 then
			_T.PetFoodTimers[__wf_atom_6be84646][k] = nil
		else
			if gRegion:IsMaster() and v10.Upgrade then
				__wf_atom_d2b2176d:__wf_atom_4dafafc8(
					Symbol(k),
					__wf_atom_db2b0cee,
					v10.Upgrade.UpgradeType,
					v10.Upgrade.OperationType,
					v10.Upgrade.Value
				)
			end

			if v10.Fnc then
				v9 = v10
				local getfenv = getfenv(0)
				getfenv.RunPetFoodFnc = RunPetFoodFnc
				object:__wf_atom_8a035cd5(Symbol("RunPetFoodFnc"), false)
			end
		end
	end
end

function CalculatePetAuraUpgradeValue(p, p2, p3, p4, p5)
	if p == nil or p2 == nil or p <= 0 or p2 <= 0 then
		return 0
	end

	local v10 = not (p2 > 1) and 0 or math.max(0, (math.min((p - 1) / (p2 - 1), 1)))
	local v11 = p3 + (p4 - p3) * v10

	if p5 then
		return (math.floor(v11 + 0.5))
	end

	return v11
end

function GetPetAuraUpgradeValue(object, p, p2, p3, p4)
	local __wf_atom_4fec12f3 = object:__wf_atom_4fec12f3(p)
	local v10 = GetMaxStat(object, p)
	return
		CalculatePetAuraUpgradeValue(__wf_atom_4fec12f3, v10, p2, p3, p4),
		(__wf_atom_4fec12f3 == nil or v10 == nil or not (v10 > 0)) and 0 or math.max(0, (math.min(__wf_atom_4fec12f3 / v10, 1)))
end