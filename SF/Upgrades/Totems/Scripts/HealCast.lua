local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v2 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v == 0 then
		if p == 1 then
			mHealDuration = 8
			healOverTimeAmount = 1.5
		elseif p == 2 then
			mHealDuration = 8
			healOverTimeAmount = 1.6
		elseif p == 3 then
			mHealDuration = 8
			healOverTimeAmount = 1.8
		else
			mHealDuration = 8
			healOverTimeAmount = 2
		end
	elseif v == 1 then
		if p == 1 then
			mHealDuration = 6
			healOverTimeAmount = 1.5
		elseif p == 2 then
			mHealDuration = 6
			healOverTimeAmount = 1.75
		elseif p == 3 then
			mHealDuration = 6
			healOverTimeAmount = 2.25
		else
			mHealDuration = 6
			healOverTimeAmount = 3
		end
	elseif p == 1 then
		mHealDuration = 4
		healOverTimeAmount = 2
	elseif p == 2 then
		mHealDuration = 4
		healOverTimeAmount = 3
	elseif p == 3 then
		mHealDuration = 4
		healOverTimeAmount = 4
	else
		mHealDuration = 4
		healOverTimeAmount = 5
	end

	mHealDuration *= v2
	healOverTimeAmount *= v2
end

function Heal(object)
	local maxHealth = object:GetMaxHealth()
	object:Attach(castFx, EMPTY_SYMBOL)
	local total = 0

	while
		gRegion:IsMaster()
		and not object:IsKilled()
		and not object:__wf_atom_bedb4e3f()
		and object:__wf_atom_c6f1f83d() ~= maxHealth
		and total < mHealDuration
	do
		object:Heal(object, healOverTimeAmount)
		Sleep(healOverTimeSpeed)
		total += healOverTimeSpeed
	end
end

function OnUpgradeApplied(p, _, p2, _, p3)
	fn(p2, p, p3)
	Heal(p)
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v = {
		BONUS = module2.FormatNumber(healOverTimeAmount * 10, 0),
		RANGE = module2.FormatNumber(mHealDuration, 0)
	}
	return cjson.encode(v)
end