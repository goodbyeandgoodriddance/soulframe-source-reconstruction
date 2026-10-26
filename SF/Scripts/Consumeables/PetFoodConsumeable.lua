local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.PlayerPetLib")
local module3 = require("SF.Scripts.NightFoldLib")
local v = 0
local v2 = true
local v3 = WeakResource("/SF/Interface/HUD/PetStatus.swf")
local v4 = nil

function Evaluate(object, _)
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local movie = __wf_atom_8e4fda44:FindMovie(v3)
	local __wf_atom_cbbadcfc = __wf_atom_a96eb2aa:__wf_atom_cbbadcfc()
	local __wf_atom_4febbf37 = __wf_atom_a96eb2aa:__wf_atom_4febbf37()

	if
		__wf_atom_7e8ad928(object)
		or object:IsKilled()
		or object:__wf_atom_bedb4e3f()
		or __wf_atom_7e8ad928(__wf_atom_cbbadcfc)
	then
		return false
	end

	if
		object:__wf_atom_58dabbc7()
		or object:__wf_atom_47fbd15c()
		or module.PlayerIsInBattle(object)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar)
	then
		return false
	end

	if foodType == 6 then
		if __wf_atom_4febbf37.mMealsEaten >= __wf_atom_cbbadcfc:GetMaxStat(6) then
			__wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_921c1a5f(refuseFoodAnim, false, 4, 1, false)

			if not __wf_atom_7e8ad928(movie) then
				movie:Execute("OnPetStatusChanged", tostring(1) .. ",true")
			end

			return false
		end
	elseif foodType == 7 and __wf_atom_4febbf37.mSnacksEaten >= __wf_atom_cbbadcfc:GetMaxStat(7) then
		__wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_921c1a5f(refuseFoodAnim, false, 4, 1, false)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("OnPetStatusChanged", tostring(1) .. ",true")
		end

		return false
	end

	return true
end

function _CalloutPressed()
	v2 = false
end

function IsOverconsumptionLimit(object, p)
	if __wf_atom_7e8ad928(object) then
		print("Player missing on pet")
		return false
	end

	local __wf_atom_4febbf37 = object:__wf_atom_4febbf37()
	local __wf_atom_cbbadcfc = object:__wf_atom_cbbadcfc()

	if __wf_atom_7e8ad928(__wf_atom_cbbadcfc) then
		return false
	end

	local petStat = module2.GetPetStat(__wf_atom_4febbf37, p)

	if petStat == nil then
		print("Invalid food type")
		return false
	end

	local maxStat = __wf_atom_cbbadcfc:GetMaxStat(p)
	local v5 = petStat + 1

	if v5 <= maxStat and maxStat - v5 < overConsumptionDangerAmount and math.random() < earlyOverConsumptionChance then
		return true
	end

	return maxStat < v5
end

function PetEatSnackCountdown(object, p)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.PetSnackOverconsumptionActive = true
	Sleep(p)
	__wf_atom_e919fb8e.PetSnackOverconsumptionActive = false
end

local function fn(object)
	local movie = __wf_atom_8e4fda44:FindMovie(v3)
	local __wf_atom_4febbf37 = object:__wf_atom_4febbf37()
	local __wf_atom_cbbadcfc = object:__wf_atom_cbbadcfc()
	local petAvatar = module2.GetPetAvatar(object)

	if __wf_atom_7e8ad928(petAvatar) or __wf_atom_7e8ad928(__wf_atom_cbbadcfc) then
		return false
	end

	if not _T.PetFoodTimers then
		_T.PetFoodTimers = {}
	end

	local __wf_atom_6be84646 = object:__wf_atom_6be84646()

	if not _T.PetFoodTimers[__wf_atom_6be84646] then
		_T.PetFoodTimers[__wf_atom_6be84646] = {}
	end

	if IsOverconsumptionLimit(object, 7) then
		__wf_atom_4febbf37.mSnacksEaten = __wf_atom_cbbadcfc:GetMaxStat(7)
		_T.PetFoodTimers[__wf_atom_6be84646].SNACKS_UPGRADE = {
			Expiry = Engine.__wf_atom_4c4cfc2e(overconsuptionDuration),
			Upgrade = { Value = snackEnergyDrainMultiplier, UpgradeType = 238, OperationType = 2 },
			Fnc = function(p, p2)
				if not module2.IsOverconsumptionActive(p, 7) then
					PetEatSnackCountdown(p, p2)
				end
			end
		}
		module2.ApplyPetFoodUpgrades(petAvatar)

		if not __wf_atom_7e8ad928(pupOverfeedAnim) then
			petAvatar:__wf_atom_921c1a5f(pupOverfeedAnim, false, 4, 1, false)
		end

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("OnPetStatusChanged", tostring(1) .. ",true")
		end

		return true
	else
		__wf_atom_4febbf37.mSnacksEaten += 1
		local __wf_atom_003db090 = petAvatar:__wf_atom_d2b2176d():__wf_atom_003db090(
			Symbol("SNACKS_UPGRADE"),
			237,
			3,
			xpUpgradeMultiplier
		)
		local v5

		if __wf_atom_003db090 > 0 then
			v5 = stackingDurationIncrease + __wf_atom_003db090
		else
			v5 = upgradeDuration
		end

		_T.PetFoodTimers[__wf_atom_6be84646].SNACKS_UPGRADE = {
			Expiry = Engine.__wf_atom_4c4cfc2e(v5),
			Upgrade = { Value = xpUpgradeMultiplier, UpgradeType = 237, OperationType = 3 }
		}
		module2.ApplyPetFoodUpgrades(petAvatar, "SNACKS_UPGRADE")

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("OnPetStatusChanged", tostring(0) .. ",true")
		end

		return true
	end
end

function PetEatMealCountdown(object, p)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.PetMealOverconsumptionActive = true
	Sleep(p)
	__wf_atom_e919fb8e.PetMealOverconsumptionActive = false
end

local function fn2(object)
	local movie = __wf_atom_8e4fda44:FindMovie(v3)
	local __wf_atom_4febbf37 = object:__wf_atom_4febbf37()
	object:__wf_atom_50a7d83e()
	local __wf_atom_cbbadcfc = object:__wf_atom_cbbadcfc()
	local petAvatar = module2.GetPetAvatar(object)

	if __wf_atom_7e8ad928(petAvatar) or __wf_atom_7e8ad928(__wf_atom_cbbadcfc) then
		return false
	end

	if not _T.PetFoodTimers then
		_T.PetFoodTimers = {}
	end

	local __wf_atom_6be84646 = object:__wf_atom_6be84646()

	if not _T.PetFoodTimers[__wf_atom_6be84646] then
		_T.PetFoodTimers[__wf_atom_6be84646] = {}
	end

	if IsOverconsumptionLimit(object, 6) then
		__wf_atom_4febbf37.mMealsEaten = __wf_atom_cbbadcfc:GetMaxStat(6)
		_T.PetFoodTimers[__wf_atom_6be84646].MEALS_UPGRADE = {
			Expiry = Engine.__wf_atom_4c4cfc2e(overconsuptionDuration),
			Upgrade = {
				Value = -upgradeOverconsumptionSlowMultiplier,
				UpgradeType = 101,
				OperationType = 3
			},
			Fnc = function(p, p2)
				if not module2.IsOverconsumptionActive(p, 6) then
					PetEatMealCountdown(p, p2)
				end
			end
		}
		module2.ApplyPetFoodUpgrades(petAvatar, "MEALS_UPGRADE")

		if not __wf_atom_7e8ad928(pupOverfeedAnim) then
			petAvatar:__wf_atom_921c1a5f(pupOverfeedAnim, false, 4, 1, false)
		end

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("OnPetStatusChanged", tostring(1) .. ",true")
		end
	else
		__wf_atom_4febbf37.mEnergy = math.min(
			__wf_atom_4febbf37.mEnergy + energyIncreaseOnConsumption,
			__wf_atom_cbbadcfc:GetMaxStat(0)
		)
		__wf_atom_4febbf37.mMealsEaten += 1
		_T.PetFoodTimers[__wf_atom_6be84646].MEALS_UPGRADE = nil
		module2.ApplyPetFoodUpgrades(petAvatar, "MEALS_UPGRADE")

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("OnPetStatusChanged", tostring(0) .. ",true")
		end
	end

	return true
end

function GiveFood(object, object2, callback)
	module3.RegisterPreventNighfoldUsage(true, "GivePetFood", true)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar) or __wf_atom_7e8ad928(playerFeedAnim)) then
		v = __wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_ccd337ec(commandBbSymbol)
		__wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_cecb2d55(commandBbSymbol, petCommand)
		__wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_30e3d82b()
		v4 = __wf_atom_e919fb8e.PlayerWolfAvatar:Attach(playerFeedAnim, EMPTY_SYMBOL)
		local motionControl = object:MotionControl()
		motionControl:__wf_atom_fb8cb580(true, __wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_a2a18137(), 2)
		object:__wf_atom_d2b2176d():Unequip(0, 2)
		object:__wf_atom_921c1a5f(playerGiveStart, true, 4, 1, false)

		if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar) then
			return
		end

		object:__wf_atom_921c1a5f(playerWaitAnim, false, 4, 2, false)
		object:__wf_atom_aeb02c14(menuInputFilter)
		gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
			Symbol("GiveFood"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15(waitInput),
			_CalloutPressed
		)
		local __wf_atom_9af7625d = __wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_9af7625d(object)

		while __wf_atom_9af7625d > 4 and v2 and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar) do
			__wf_atom_9af7625d = __wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_9af7625d(object)
			Sleep(0.25)
		end

		motionControl:__wf_atom_3959d938(false)
		Sleep(0.5)

		if __wf_atom_7e8ad928(object) then
			return
		end

		if __wf_atom_7e8ad928(v4) or not v2 or __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar) then
			object:__wf_atom_921c1a5f(nil, true, 4, 1, false)
		else
			object:__wf_atom_921c1a5f(nil, true, 4, 1, false)
			v4:__wf_atom_a3d2b66b(object, Symbol("Envoy"))
			v4:__wf_atom_a3d2b66b(
				__wf_atom_e919fb8e.PlayerWolfAvatar,
				__wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_12695c30()
			)
			v4:StartRelative(Symbol("Envoy"), object:__wf_atom_a2a18137(), object:__wf_atom_2f2bada0())

			while not __wf_atom_7e8ad928(v4) and v4:__wf_atom_7d4910e4() do
				Sleep(0.5)
			end
		end

		gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
			Symbol("GiveFood"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15(waitInput)
		)
		object:__wf_atom_cf966a74(menuInputFilter)

		if
			not __wf_atom_7e8ad928(callback)
			and not __wf_atom_7e8ad928(object)
			and v2
			and callback((object:__wf_atom_a96eb2aa()))
		then
			object:__wf_atom_d2b2176d():__wf_atom_5106368a(object2:__wf_atom_e14d8a8c())
		end

		v2 = true

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar) then
			__wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_cecb2d55(commandBbSymbol, 0)
		end

		if not __wf_atom_7e8ad928(v4) then
			v4:Destroy()
		end
	end

	module3.ClearPreventNighfoldUsage("GivePetFood")
end

function GiveMeal(p, p2)
	GiveFood(p, p2, fn2)
end

function GiveSnack(p, p2)
	GiveFood(p, p2, fn)
end

function EMO_START(p)
	GiveFood(p, nil)
end