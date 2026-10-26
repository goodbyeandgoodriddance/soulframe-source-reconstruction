local v = 50
local v2 = Symbol("BlockingBehavior")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v3 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()
	local v4 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v3 == 0 then
		if p == 1 then
			v = 4
		elseif p == 2 then
			v = 4.5
		elseif p == 3 then
			v = 5
		else
			v = 5.5
		end
	elseif v3 == 1 then
		if p == 1 then
			v = 4
		elseif p == 2 then
			v = 5
		elseif p == 3 then
			v = 7
		else
			v = 8
		end
	elseif p == 1 then
		v = 3
	elseif p == 2 then
		v = 4
	elseif p == 3 then
		v = 5
	else
		v = 6
	end

	v *= v4
end

local function fn2(object, object2, _)
	local v3 = Symbol("TotemBlind")
	local v4 = Symbol("GiveStun")
	local v5 = v

	if not __wf_atom_7e8ad928(object) and __wf_atom_7e8ad928(object:__wf_atom_bb3e7833(blindAttachFxType)) then
		local v6 = Symbol("GAME_C1_HEAD")

		if object:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD")) then
			v6 = Symbol("GAME_C1_HEAD")
		elseif object:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD1")) then
			v6 = Symbol("GAME_C1_HEAD1")
		elseif object:__wf_atom_71a94e55(Symbol("GAME_C_HEAD")) then
			v6 = Symbol("GAME_C_HEAD")
		elseif object:__wf_atom_71a94e55(Symbol("GAME_C1_HORN")) then
			v6 = Symbol("GAME_C1_HORN")
		end

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()) then
			if object:__wf_atom_464a4772() then
				v5 /= 4
			end

			object:__wf_atom_17db995b(v3)
			object:__wf_atom_30e3d82b():__wf_atom_707fb30f(true, object:__wf_atom_cbac6c9f(v3, v5))
			object:__wf_atom_8a035cd5(v4, false)
		end

		object:__wf_atom_d50c5af7(blindAttachFxType, v6, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v5, object2)
	end
end

function OnUpgradeApplied(object, p, p2, _, object2)
	if __wf_atom_7e8ad928((object2:__wf_atom_60ba1637())) or __wf_atom_7e8ad928(p) then
		return
	end

	local lastSoulRevealTargetAvatar = object:__wf_atom_e919fb8e().lastSoulRevealTargetAvatar

	if __wf_atom_7e8ad928(lastSoulRevealTargetAvatar) or lastSoulRevealTargetAvatar:__wf_atom_129d1aba(object) then
		return
	end

	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	fn(p2, object, object2)
	local __wf_atom_1c374cc9 = lastSoulRevealTargetAvatar:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
	local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_1c374cc9, 0, 8)

	for _, v3 in ipairs(all) do
		if not gGameRules:__wf_atom_8c3af1a5(__wf_atom_e93896ba, v3:__wf_atom_e93896ba()) then
			fn2(v3, object)
		end
	end
end

function GiveStun(object)
	local v3 = Symbol("BLINDED")
	local v4 = Symbol("BLINDED_LOOP")
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local v5

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		v5 = __wf_atom_30e3d82b:__wf_atom_50a7d83e()
	end

	if __wf_atom_7e8ad928(v5) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v2, v5, 1)
	end

	local __wf_atom_d2b2176d = v5:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Unequip(0, 2)
	v5:__wf_atom_58c8ffec(v3, false, 3, 1, true, __wf_atom_5784a397(0, v5:__wf_atom_1ba2008d(v3)))

	while
		not __wf_atom_7e8ad928(v5)
		and not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
		and __wf_atom_30e3d82b:__wf_atom_11cb6d4a()
	do
		if not (v5:__wf_atom_fc8d8e90(v3, false) or v5:__wf_atom_fc8d8e90(v4, false)) then
			v5:__wf_atom_58c8ffec(v4, false, 3, 2, true, __wf_atom_5784a397(0, v5:__wf_atom_1ba2008d(v4)))
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v5) then
		if v5:__wf_atom_fc8d8e90(v4, false) then
			v5:__wf_atom_921c1a5f(nil, false, 3, 1, true)
		end

		__wf_atom_d2b2176d:__wf_atom_1870de39(true)

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v2)
		end
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v3 = { BONUS = module2.FormatNumber(v, 0), RANGE = module2.FormatNumber(8, 0) }
	return cjson.encode(v3)
end