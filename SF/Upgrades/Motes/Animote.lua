local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")
local module3 = require("SF.Interface.SFUtilities")

function AddPassive(object, object2, _, _, object3)
	if not (gRegion:IsMaster() or object:IsClientOnly()) then
		return
	end

	local passiveSlotPolarity = module2.GetPassiveSlotPolarity(object3)
	local attackUpgrade2 = nil

	if passiveSlotPolarity == 1 then
		attackUpgrade2 = attackUpgrade
	elseif passiveSlotPolarity == 2 then
		attackUpgrade2 = defenseUpgrade
	elseif passiveSlotPolarity == 3 then
		attackUpgrade2 = utilityUpgrade
	end

	if __wf_atom_7e8ad928(attackUpgrade2) then
		return
	end

	local object4 = gRegion:CreateObject(attackUpgrade2, object2)
	object4:__wf_atom_eaa00d7a(object3:__wf_atom_f298d802(), object2:__wf_atom_1bb5b1ff())
	object2:AddUpgrade(object4)
end

function RemovePassive(object, object2, _, _, p)
	if not (gRegion:IsMaster() or object:IsClientOnly()) then
		return
	end

	local passiveSlotPolarity = module2.GetPassiveSlotPolarity(p)
	local attackUpgrade2 = nil

	if passiveSlotPolarity == 1 then
		attackUpgrade2 = attackUpgrade
	elseif passiveSlotPolarity == 2 then
		attackUpgrade2 = defenseUpgrade
	elseif passiveSlotPolarity == 3 then
		attackUpgrade2 = utilityUpgrade
	end

	if __wf_atom_7e8ad928(attackUpgrade2) then
		return
	end

	local __wf_atom_7a2a76fa = object2:__wf_atom_7a2a76fa(attackUpgrade2)

	if not __wf_atom_7e8ad928(__wf_atom_7a2a76fa) then
		object2:RemoveUpgrade(__wf_atom_7a2a76fa, true)
	end
end

function GetStatsDescription(p, p2, object, object2)
	local attackUpgrade2 = nil

	if p2 == 1 then
		attackUpgrade2 = attackUpgrade
	elseif p2 == 2 then
		attackUpgrade2 = defenseUpgrade
	elseif p2 == 3 then
		attackUpgrade2 = utilityUpgrade
	elseif p2 == 8 then
		attackUpgrade2 = object:__wf_atom_1bb5b1ff()
	elseif p2 == 0 then
		return (("" .. "<MOTE_ATTACK_ICON>" .. module3.WrapStringWithFont(
			GetStatsDescription(p, 1, object, object2),
			_G.UIColor_Beige
		)) .. "\r\n\r\n" .. "<MOTE_DEFENSE_ICON>" .. module3.WrapStringWithFont(
			GetStatsDescription(p, 2, object, object2),
			_G.UIColor_Beige
		)) .. "\r\n\r\n" .. "<MOTE_TACTIC_ICON>" .. module3.WrapStringWithFont(
			GetStatsDescription(p, 3, object, object2),
			_G.UIColor_Beige
		)
	end

	if __wf_atom_7e8ad928(attackUpgrade2) then
		return ""
	end

	local v

	if not __wf_atom_7e8ad928(object2) then
		v = object2:__wf_atom_1bb5b1ff()
	end

	local object3 = gRegion:CreateObject(Type(attackUpgrade2))
	object3:__wf_atom_eaa00d7a(p, v)
	local v2 = ""
	local __wf_atom_70b880cb = object3:__wf_atom_70b880cb(p)

	if __wf_atom_70b880cb.affixes ~= nil then
		for _, affix in ipairs(__wf_atom_70b880cb.affixes) do
			if v2 ~= "" then
				v2 ..= "\r\n"
			end

			v2 ..= affix
		end
	end

	gRegion:__wf_atom_dd1e4d10(object3)
	return v2
end

function GetForcedProcChanceLoc(_, _, object, _, p, _)
	local v = {}

	if __wf_atom_7e8ad928(object) then
		return cjson.encode(v)
	end

	local __wf_atom_505b3c0e = object:__wf_atom_b9a1f18c(p - 1):__wf_atom_505b3c0e()
	v.EFFECT = Localize(forcedProcChanceEffectLoc, nil)
	v.CHANCE = module.FormatNumber(__wf_atom_505b3c0e * 100, 0)

	if __wf_atom_505b3c0e > 0 then
		v["1_IN_X"] = Localize("/SF/Language/Motes/1InX", nil) .. module.FormatNumber(1 / __wf_atom_505b3c0e, 0)
	end

	return cjson.encode(v)
end