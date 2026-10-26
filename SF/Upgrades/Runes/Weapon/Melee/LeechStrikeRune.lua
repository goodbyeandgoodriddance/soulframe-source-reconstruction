local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("Lotus.Scripts.Libs.AudioLib")
local module3 = require("EE.Interface.Utilities")
local module4 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = 1
local bbLeechStrikeHealPct2 = 1
local v2 = 13
Symbol("VictimIsVIP")
local v3 = Symbol("CC_GROUND_PERFECT_HEAVY")
local v4 = Symbol("CC_GROUND_BRANCH_HEAVY")

function GetAbilityStats(p, _, object, _, _, _)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 0.75
			bbLeechStrikeHealPct2 = 0.15
		elseif p == 2 then
			v = 1
			bbLeechStrikeHealPct2 = 0.2
		elseif p == 3 then
			v = 1.25
			bbLeechStrikeHealPct2 = 0.25
		else
			v = 1.5
			bbLeechStrikeHealPct2 = 0.3
		end
	end

	local v5 = {
		DAMAGE = module3.FormatNumber(v * 100, 0),
		HEAL = module3.FormatNumber(bbLeechStrikeHealPct2 * 100, 0)
	}
	return cjson.encode(v5)
end

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module4.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

local function fn(object, object2, p, p2)
	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if (__wf_atom_7e8ad928(weaponMote) and 0 or weaponMote:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 0.75
			bbLeechStrikeHealPct2 = 0.15
		elseif p == 2 then
			v = 1
			bbLeechStrikeHealPct2 = 0.2
		elseif p == 3 then
			v = 1.25
			bbLeechStrikeHealPct2 = 0.25
		else
			v = 1.5
			bbLeechStrikeHealPct2 = 0.3
		end
	end

	local runeDamageBuff = module4.GetRuneDamageBuff(object, v)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if not gRegion:IsMaster() then
		return runeDamageBuff
	end

	if p2 then
		__wf_atom_d2b2176d:AddUpgrade(401, 0, runeDamageBuff, object2:__wf_atom_1bb5b1ff(), object2, v2)
		__wf_atom_d2b2176d:AddUpgrade(319, 4, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, Symbol(), false, 31)
		__wf_atom_d2b2176d:AddUpgrade(283, 4, 0, object2:__wf_atom_1bb5b1ff(), object2)
	else
		__wf_atom_d2b2176d:RemoveUpgrade(401, 0, runeDamageBuff, object2:__wf_atom_1bb5b1ff(), object2, v2)
		__wf_atom_d2b2176d:RemoveUpgrade(319, 4, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, Symbol(), false, 31)
		__wf_atom_d2b2176d:RemoveUpgrade(283, 4, 0, object2:__wf_atom_1bb5b1ff(), object2)
	end

	return runeDamageBuff
end

function ActivateAbility(object, object2, _, p)
	if __wf_atom_7e8ad928((module.GetWeaponMote(mOwner:__wf_atom_3371f607()))) then
		return
	end

	module.AddCastImmunity(object2)
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_3371f607)) then
		local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)
		__wf_atom_66088189:__wf_atom_d87c0fc8(v2)

		if not __wf_atom_7e8ad928(activeFxType) then
			mOwner:__wf_atom_7ccf4243(activeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_dc5956fc(
				__wf_atom_66088189,
				EMPTY_SYMBOL
			)
		end

		local __wf_atom_66088189_2 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

		if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
			__wf_atom_66088189_2:__wf_atom_d87c0fc8(v2)

			if not __wf_atom_7e8ad928(activeFxType) then
				mOwner:__wf_atom_7ccf4243(activeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_dc5956fc(
					__wf_atom_66088189_2,
					EMPTY_SYMBOL
				)
			end
		end
	end

	fn(object2, __wf_atom_3371f607, p, true)

	if gRegion:IsMaster() then
		mOwner:__wf_atom_74f6ca7b(Symbol("OnMeleeHit"), true)
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) then
		__wf_atom_e919fb8e.Runes = {}
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752] = {}
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbLeechStrikeRuneActive = true
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbLeechStrikeHealPct = bbLeechStrikeHealPct2
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbLeechStrikeHealProcced = false
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbHealFxType = healFxType
	local runeActivationCost = module4.GetRuneActivationCost()
	local v5 = true
	local v6 = false

	while not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(__wf_atom_3371f607) and v5 do
		Sleep(0)
		v5 = __wf_atom_3371f607:__wf_atom_9f71ab59() and not __wf_atom_3371f607:__wf_atom_160ce839() and true or false

		if v6 or not __wf_atom_3371f607:__wf_atom_745fda4a() then
			continue
		end

		v6 = true

		if gRegion:IsMaster() then
			local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
			object:__wf_atom_19516b62(-runeActivationCost, __wf_atom_2e4994f1)
		end

		module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
	end

	Sleep(0)
end

local function fn2(object, object2, bbLeechStrikeHealPct)
	if gRegion:IsMaster() then
		local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()
		local maxHealth = object:GetMaxHealth()

		if __wf_atom_c6f1f83d < maxHealth then
			object:Heal(object, maxHealth * bbLeechStrikeHealPct, object2)
			object:NotifyHeal(object2:__wf_atom_a96eb2aa(), maxHealth * bbLeechStrikeHealPct, 0, 1)
			module.NotifyHeal(object2, object:__wf_atom_c6f1f83d() - __wf_atom_c6f1f83d)
		end
	end
end

function OnMeleeHit(object, _, object2, p, _, p2, _, _, _, _, _, object3)
	if __wf_atom_7e8ad928(object2) or object2 ~= mOwner:__wf_atom_3371f607() or __wf_atom_7e8ad928(object3) then
		return
	end

	if p2 <= 0 or __wf_atom_7e8ad928(p) or not (object3:__wf_atom_2319699d(v4) or object3:__wf_atom_2319699d(v3)) then
		return
	end

	local __wf_atom_95e72410 = object:__wf_atom_95e72410()
	local __wf_atom_0395f752 = object2:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = __wf_atom_95e72410:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbLeechStrikeRuneActive)
	then
		return
	end

	if not __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbLeechStrikeHealProcced then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbLeechStrikeHealProcced = true
		local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_95e72410:__wf_atom_a2a18137(), 0, 4)

		for _, v5 in ipairs(all) do
			if
				__wf_atom_7e8ad928(v5)
				or not gGameRules:__wf_atom_8c3af1a5(__wf_atom_95e72410:__wf_atom_e93896ba(), v5:__wf_atom_e93896ba())
			then
				continue
			end

			fn2(v5, __wf_atom_95e72410, __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbLeechStrikeHealPct)
		end

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbHealFxType) then
			gRegion:CreateEntity(
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbHealFxType,
				__wf_atom_95e72410:__wf_atom_a2a18137(),
				Rotation(0, 90, 0),
				__wf_atom_95e72410,
				__wf_atom_95e72410
			)
		end
	end
end

function DeactivateAbility(_, object, _, p)
	module.RemoveCastImmunity(object)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:__wf_atom_d87c0fc8(Engine.__wf_atom_aee2d71e)
		end

		local __wf_atom_66088189_2 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

		if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
			__wf_atom_66088189_2:__wf_atom_d87c0fc8(Engine.__wf_atom_aee2d71e)
		end
	end

	module2.EnableTaggedSequencers(Symbol("SFXFireSwordLoop"), false)

	if gRegion:IsMaster() then
		mOwner:__wf_atom_74f6ca7b(Symbol("OnMeleeHit"), false)
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

	if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbLeechStrikeRuneActive = nil
	end

	fn(object, __wf_atom_3371f607, p, false)
end