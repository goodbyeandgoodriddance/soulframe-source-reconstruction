local v = 50
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v2 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v3 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v2 == 0 then
		if p == 1 then
			v = 4
		elseif p == 2 then
			v = 6
		elseif p == 3 then
			v = 8
		else
			v = 10
		end
	elseif v2 == 1 then
		if p == 1 then
			v = 5
		elseif p == 2 then
			v = 7
		elseif p == 3 then
			v = 9
		else
			v = 11
		end
	elseif p == 1 then
		v = 3
	elseif p == 2 then
		v = 4
	elseif p == 3 then
		v = 6
	else
		v = 8
	end

	v *= v3
end

local function fn2(lastSoulStealTargetAvatar, _, __wf_atom_e93896ba)
	if lastSoulStealTargetAvatar:__wf_atom_464a4772() then
		v /= 4
	end

	local __wf_atom_e93896ba2 = lastSoulStealTargetAvatar:__wf_atom_e93896ba()
	local __wf_atom_30e3d82b = lastSoulStealTargetAvatar:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	__wf_atom_30e3d82b:__wf_atom_e4153bc7()
	lastSoulStealTargetAvatar:SetFaction(__wf_atom_e93896ba)
	__wf_atom_30e3d82b:__wf_atom_920a5a62()

	while v > 0 do
		Sleep(0)
		v -= __wf_atom_084b3e93()
	end

	if
		not __wf_atom_7e8ad928(lastSoulStealTargetAvatar)
		and not lastSoulStealTargetAvatar:__wf_atom_bedb4e3f()
		and lastSoulStealTargetAvatar:__wf_atom_e93896ba() ~= Symbol("Neutral")
	then
		lastSoulStealTargetAvatar:SetFaction(__wf_atom_e93896ba2)

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_e4153bc7()
			__wf_atom_30e3d82b:__wf_atom_920a5a62()
		end
	end
end

function OnUpgradeApplied(object, p, p2, _, object2)
	if __wf_atom_7e8ad928((object2:__wf_atom_60ba1637())) or __wf_atom_7e8ad928(p) then
		return
	end

	local lastSoulStealTargetAvatar = object:__wf_atom_e919fb8e().LastSoulStealTargetAvatar

	if __wf_atom_7e8ad928(lastSoulStealTargetAvatar) or lastSoulStealTargetAvatar:__wf_atom_129d1aba(object) then
		return
	end

	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	fn(p2, object, object2)
	lastSoulStealTargetAvatar:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
	fn2(lastSoulStealTargetAvatar, object, __wf_atom_e93896ba)
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v2 = { BONUS = module2.FormatNumber(v, 0) }
	return cjson.encode(v2)
end