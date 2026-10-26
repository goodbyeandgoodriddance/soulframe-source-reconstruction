local v = 1
local baseAmount = 125
local v2 = 3
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v3 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v4 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v3 == 0 then
		if p == 1 then
			v = 2
			baseAmount = 20
		elseif p == 2 then
			v = 3
			baseAmount = 40
		elseif p == 3 then
			v = 4
			baseAmount = 60
		else
			v = 5
			baseAmount = 80
		end
	elseif v3 == 1 then
		if p == 1 then
			v = 3
			baseAmount = 30
		elseif p == 2 then
			v = 5
			baseAmount = 60
		elseif p == 3 then
			v = 6
			baseAmount = 90
		else
			v = 7
			baseAmount = 120
		end
	elseif p == 1 then
		v = 3
		baseAmount = 30
	elseif p == 2 then
		v = 6
		baseAmount = 60
	elseif p == 3 then
		v = 9
		baseAmount = 90
	else
		v = 12
		baseAmount = 150
	end

	v *= v4
	baseAmount *= v4
end

function OnUpgradeApplied(object, p, p2, _, object2)
	if __wf_atom_7e8ad928((object2:__wf_atom_60ba1637())) or __wf_atom_7e8ad928(p) then
		return
	end

	local lastSoulStealTargetAvatar = object:__wf_atom_e919fb8e().LastSoulStealTargetAvatar

	if __wf_atom_7e8ad928(lastSoulStealTargetAvatar) or lastSoulStealTargetAvatar:__wf_atom_129d1aba(object) then
		return
	end

	fn(p2, object, object2)

	if lastSoulStealTargetAvatar:__wf_atom_464a4772() then
		v /= 4
		baseAmount /= 2
	end

	while not (__wf_atom_7e8ad928(object) or object:IsKilled() or __wf_atom_7e8ad928(lastSoulStealTargetAvatar) or lastSoulStealTargetAvatar:IsKilled()) do
		local v3 = object:GetPosition() - lastSoulStealTargetAvatar:GetPosition()
		v3.y = 0
		local v4 = Length(v3)

		if v4 < 3 or v2 < 0 then
			break
		end

		v2 -= __wf_atom_084b3e93()

		if not lastSoulStealTargetAvatar:__wf_atom_fc8d8e90(Symbol("SOUL_STEAL")) then
			lastSoulStealTargetAvatar:__wf_atom_58c8ffec(Symbol("SOUL_STEAL"), false, 4, 2, true)
		end

		lastSoulStealTargetAvatar:MotionControl():__wf_atom_4bb21efc(v3 / math.sqrt(v4) * v)
		Sleep(0)
	end

	if
		not __wf_atom_7e8ad928(lastSoulStealTargetAvatar)
		and lastSoulStealTargetAvatar:__wf_atom_fc8d8e90(Symbol("SOUL_STEAL"))
	then
		lastSoulStealTargetAvatar:__wf_atom_9b5dcd3b(nil, false, 2, 1, false)
	end

	if not (__wf_atom_7e8ad928(lastSoulStealTargetAvatar) or __wf_atom_7e8ad928(object)) then
		local damageData = Engine.DamageData()
		damageData.baseAmount = baseAmount
		damageData:__wf_atom_7498285f(15, 1)
		damageData:__wf_atom_6b472125(object)
		damageData:__wf_atom_34a8a27a(object)
		lastSoulStealTargetAvatar:__wf_atom_649bf33e(damageData)
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v3 = {
		RANGE = module2.FormatNumber(v, 0),
		BONUS = module2.FormatNumber(baseAmount, 0)
	}
	return cjson.encode(v3)
end