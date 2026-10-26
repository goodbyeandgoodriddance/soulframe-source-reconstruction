local v = WeakResource("/SF/Types/Quests/AncestorProgression/VerminiaProgression/AncestorVerminiaDiscoveryQuest")
local v2 = Symbol("BlockingBehavior")
local module = require("SF.Scripts.Libs.ModifySkyLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")

function Evaluate(object, _)
	if __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return false
	end

	if
		object:__wf_atom_58dabbc7()
		or object:__wf_atom_47fbd15c()
		or object:__wf_atom_d2b2176d():__wf_atom_9f71ab59(true)
	then
		return false
	end

	if not module2.HasCompletedQuest(v) or module2.QuestIsActive(v) then
		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
			Symbol("NimrodAvatar"),
			object:__wf_atom_a2a18137(),
			0,
			usageRange
		)

		if __wf_atom_7e8ad928(__wf_atom_f738b4af) or __wf_atom_f738b4af:IsKilled() then
			_T.ShowImpactMessage(noTargetFound, 5)
			return false
		end

		if __wf_atom_f738b4af:__wf_atom_d2b2176d():__wf_atom_c1f9859f(366, nil, nil) then
			_T.ShowImpactMessage(skysCleard, 5)
			return false
		end
	elseif not module.IsSkyMain(Symbol("DefaultMainSky")) then
		return false
	end

	return true
end

local function fn(object)
	local v3 = 1

	while v3 > 0 do
		v3 = math.max(0, v3 - __wf_atom_084b3e93() * 0.25)
		_T.SpellFX = 1 - v3
		Sleep(0)
	end

	local total = 15

	if total < 0 then
		total += 24
	end

	module.SetTimeOfDay(total)

	if not __wf_atom_7e8ad928(object) then
		object:PlaySound(stormClearSound, false)
	end

	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local postProcess = __wf_atom_8ad59546.postProcess
	module.ClearWeatherAndDisableCycle(3)
	local spellFX = 1

	while spellFX > 0 and not __wf_atom_7e8ad928(__wf_atom_8ad59546) do
		spellFX = math.max(0, spellFX - __wf_atom_084b3e93() / 3)
		local v4 = __wf_atom_24a82b69(spellFX)
		local v5 = __wf_atom_104bfe98(total, 19, 1 - v4)
		module.SetTimeOfDay(v5)
		postProcess:__wf_atom_54a04966(v4 * 10)
		postProcess:__wf_atom_f846a58a(__wf_atom_104bfe98(1, 3, v4))
		_T.SpellFX = spellFX
		Sleep(0)
	end

	module.SetWeatherCycleEnabled(true, 1800)
end

function ClearSkyAfterPotion()
	_T.NimrodSkyClearStarted = false
	gRegion:__wf_atom_0a6a5887(Symbol("NimrodAvatar"))
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("NimrodAvatar"))
	_T.NimrodSkyCleared = true
	local v3

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled()) then
		v3 = __wf_atom_0a6a5887:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(v3) then
			v3:__wf_atom_b414eabf()
			v3:__wf_atom_aa4361c1(v2, __wf_atom_0a6a5887)
		end

		local __wf_atom_e55d02aa = __wf_atom_0a6a5887:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		for _, v4 in pairs(suitAblities) do
			local __wf_atom_e21e8409 = __wf_atom_e55d02aa:__wf_atom_e21e8409(v4)

			if __wf_atom_7e8ad928(__wf_atom_e21e8409) or not __wf_atom_e21e8409:IsActive() then
				continue
			end

			__wf_atom_e21e8409:DeactivateAbility()
		end

		__wf_atom_0a6a5887:__wf_atom_921c1a5f(skyClearReactAnim, false, 4, 1, true)

		if gRegion:IsMaster() then
			local __wf_atom_d2b2176d = __wf_atom_0a6a5887:__wf_atom_d2b2176d()
			__wf_atom_d2b2176d:AddUpgrade(366, 2, damageReduction)
			__wf_atom_d2b2176d:AddUpgrade(169, 3, stabityDamageMult)
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:PlaySound(skyClearSound, false)
	end

	fn(gRegion:__wf_atom_c4f78a8f())

	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_42b767a2(v2)
	end
end

function Activate(object, object2)
	if _T.NimrodSkyClearStarted ~= nil and _T.NimrodSkyClearStarted then
		return
	end

	_T.NimrodSkyClearStarted = true
	local questIsActive = module2.QuestIsActive(v)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_c4f78a8f ~= object and questIsActive then
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
		local __wf_atom_62abd325 = __wf_atom_d2b2176d:__wf_atom_62abd325(0)
		local __wf_atom_1bb5b1ff = object2:__wf_atom_1bb5b1ff()

		for i = 0, __wf_atom_62abd325 - 1 do
			local __wf_atom_ba1c3957 = __wf_atom_d2b2176d:__wf_atom_ba1c3957(i, 0)

			if
				__wf_atom_7e8ad928(__wf_atom_ba1c3957)
				or __wf_atom_ba1c3957:__wf_atom_1bb5b1ff() ~= __wf_atom_1bb5b1ff
			then
				continue
			end

			__wf_atom_d2b2176d:__wf_atom_8ea2254b(i, 0)
			break
		end
	end

	local motionControl = object:MotionControl()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(startCinTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887 = object:Attach(activationCinematic, EMPTY_SYMBOL)
	end

	if unequipWeapon then
		if unequipInstant then
			if object:__wf_atom_4417a5d4() then
				__wf_atom_d2b2176d:Unequip(0, 2)
			end
		else
			if object:__wf_atom_4417a5d4() then
				__wf_atom_d2b2176d:Unequip(0, 0)
			end

			while
				not __wf_atom_7e8ad928(object)
				and not object:IsKilled()
				and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14
			do
				Sleep(0)
			end
		end
	end

	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_0a6a5887)) then
		local sparrowForPlayer = module3.GetSparrowForPlayer(object)
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.sparrowShoulderPerching = false
		object:__wf_atom_be7f08c9(false)
		object:__wf_atom_5512b97b(false)
		gRegion:__wf_atom_dd1e4d10(sparrowForPlayer)
		__wf_atom_0a6a5887:SetInstigatorAvatar(object)
		__wf_atom_0a6a5887:StartRelative(
			Symbol("Envoy"),
			object:__wf_atom_a2a18137(),
			motionControl:__wf_atom_d9cb4b97()
		)
	end

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	if not (__wf_atom_7e8ad928(object) and object:IsKilled()) then
		Sleep(30)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Destroy()
		end
	end
end