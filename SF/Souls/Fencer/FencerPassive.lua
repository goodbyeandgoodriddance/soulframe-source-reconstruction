local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Souls.Common.CommonPassive")
local module3 = require("EE.Interface.Utilities")
local v = Symbol("FencerBleedUpgrade")

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

function GetBaseProcChance(p, p2)
	local magikForceCalc = module.magikForceCalc(p2, p, mOwner)
	local v2 = 0

	if #baseBleedProcChance < p then
		v2 = baseBleedProcChance[#baseBleedProcChance]
	elseif p > 0 then
		v2 = baseBleedProcChance[p]
	end

	return v2 * magikForceCalc
end

function GetBaseBleedDamageBuff(p)
	return 1 + p * 0.2
end

function GetBaseDecoyCharges(object)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(
		0,
		0,
		__wf_atom_e55d02aa:__wf_atom_1bb5b1ff(),
		__wf_atom_e55d02aa,
		26,
		Symbol("DodgeyDecoy")
	)
	local magikForceCalc = module.magikForceCalc(object, __wf_atom_2a745663, mOwner)
	return (math.round(DecoyCharges[__wf_atom_421b01aa(__wf_atom_2a745663, 1, #DecoyCharges)] * magikForceCalc))
end

function DecoyWait(instance)
	if not __wf_atom_7e8ad928(instance) then
		local v2 = 0

		while v2 < 1 do
			v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() * 2, 0, 1)
			instance:__wf_atom_68f2c268(1 - v2 * 0.6)
			Sleep(0)
		end
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local creator = instance:GetCreator()
	local __wf_atom_e0730826 = __wf_atom_7d789620:__wf_atom_e0730826(instance, 10)
	local v2 = 0.75

	for _, v3 in ipairs(__wf_atom_e0730826) do
		local __wf_atom_50a7d83e = v3:__wf_atom_50a7d83e()

		if
			__wf_atom_7e8ad928(__wf_atom_50a7d83e)
			or __wf_atom_50a7d83e:IsKilled()
			or __wf_atom_50a7d83e:__wf_atom_129d1aba(instance)
			or v3:__wf_atom_216d6edd() ~= creator
		then
			continue
		end

		v3:__wf_atom_e4153bc7()
		__wf_atom_50a7d83e:__wf_atom_5b3d56b0(creator)
		v3:SetTarget(instance)
	end

	while v2 > 0 do
		Sleep(0.25)
		v2 -= __wf_atom_084b3e93() + 0.25
	end

	instance:__wf_atom_2f3f52aa(-5)
	__wf_atom_7e8ad928(creator)

	for _, v3 in ipairs(__wf_atom_e0730826) do
		if __wf_atom_7e8ad928(v3) then
			continue
		end

		local __wf_atom_50a7d83e = v3:__wf_atom_50a7d83e()

		if
			__wf_atom_7e8ad928(__wf_atom_50a7d83e)
			or __wf_atom_50a7d83e:IsKilled()
			or __wf_atom_50a7d83e:__wf_atom_129d1aba(instance)
			or v3:__wf_atom_216d6edd() ~= instance
		then
			continue
		end

		v3:__wf_atom_e4153bc7()
		v3:__wf_atom_920a5a62()
	end

	local v3 = 0

	while v3 < 1 do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() * 3, 0, 1)
		instance:__wf_atom_68f2c268(v3 * 0.4 + 0.6)
		Sleep(0)
	end

	instance:Destroy()
end

local function fn(object, _, _)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.MusicalDodgeCount == 0 then
		return
	end

	__wf_atom_e919fb8e.MusicalDodgeCount -= 1

	if __wf_atom_d2b2176d:__wf_atom_2a745663(0, 0, object:__wf_atom_1bb5b1ff(), object, 26, Symbol("DodgeyDecoy")) == 0 then
		return
	end

	local __wf_atom_a96eb2aa = __wf_atom_6009c8ed:__wf_atom_a96eb2aa()
	local __wf_atom_e93896ba = __wf_atom_6009c8ed:__wf_atom_e93896ba()
	local position = __wf_atom_6009c8ed:GetPosition()
	local __wf_atom_2f2bada0 = __wf_atom_6009c8ed:__wf_atom_2f2bada0()
	__wf_atom_6009c8ed:Attach(dodgeAttachFxType, EMPTY_SYMBOL)
	local entity = gRegion:CreateEntity(dodgeDecoyAvatarType, position, __wf_atom_2f2bada0, __wf_atom_6009c8ed, object)
	entity:__wf_atom_d2b2176d():__wf_atom_13a9a02f(__wf_atom_a96eb2aa, true)
	entity:__wf_atom_72cd7949(__wf_atom_6009c8ed:__wf_atom_f115b657())
	entity:SetFaction(__wf_atom_e93896ba)
	entity:__wf_atom_2f3f52aa(5)
	entity:__wf_atom_c274907d(__wf_atom_6009c8ed:__wf_atom_0d9c1a58())
	entity:__wf_atom_68f2c268(1)
	entity:SetVisibility(true)
	entity:Attach(
		GuitarAttachType,
		Symbol("GAME_L1_WEAPON1"),
		__wf_atom_28d5d4aa,
		Rotation(0, 90, 0),
		__wf_atom_6009c8ed
	)

	if not __wf_atom_e919fb8e.shuffledDodgeAnims or #__wf_atom_e919fb8e.shuffledDodgeAnims == 0 then
		__wf_atom_e919fb8e.shuffledDodgeAnims = module3.CopyTable(dodgeAnims)
		module3.ShuffleTable(__wf_atom_e919fb8e.shuffledDodgeAnims)
	end

	local shuffledDodgeAnim = __wf_atom_e919fb8e.shuffledDodgeAnims[1]
	table.remove(__wf_atom_e919fb8e.shuffledDodgeAnims, 1)

	if not __wf_atom_e919fb8e.dodgeSounds or #__wf_atom_e919fb8e.dodgeSounds == 0 then
		__wf_atom_e919fb8e.dodgeSounds = module3.CopyTable(dodgePluckSounds)
	end

	local dodgeSound = __wf_atom_e919fb8e.dodgeSounds[1]
	table.remove(__wf_atom_e919fb8e.dodgeSounds, 1)

	if not __wf_atom_7e8ad928(dodgeWhooshSound) then
		__wf_atom_6009c8ed:PlaySound(dodgeWhooshSound, false)
	end

	entity:__wf_atom_9b5dcd3b(shuffledDodgeAnim, false, 2, 3, true)
	entity:PlaySound(dodgeSound, false)

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8a035cd5(Symbol("DecoyWait"), false)
	end
end

function OnPerfectDodge(object, _, _)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local musicalDodgeCount = GetBaseDecoyCharges(__wf_atom_6009c8ed)
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.MusicalDodgeCount = musicalDodgeCount
end

function OnDodge(object, p, p2)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	fn(object, p, p2)

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()
		local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(
			0,
			0,
			object:__wf_atom_1bb5b1ff(),
			object,
			26,
			Symbol("PokeyPokey")
		)
		local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27((__wf_atom_d2b2176d:__wf_atom_aba9c26e(0)))

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) and __wf_atom_2a745663 > 0 then
			local v2 = GetBaseProcChance(__wf_atom_2a745663, __wf_atom_6009c8ed)
			local v3 = GetBaseBleedDamageBuff(__wf_atom_2a745663)
			__wf_atom_d2b2176d:RemoveUpgrade(410, 3, v3, nil, nil, 26, EMPTY_SYMBOL, false, 2)
			__wf_atom_d2b2176d:__wf_atom_c9ea4908(v)
			__wf_atom_d2b2176d:__wf_atom_56004282(
				v,
				319,
				0,
				v2,
				__wf_atom_28224c27:__wf_atom_1bb5b1ff(),
				__wf_atom_28224c27,
				26,
				Symbol(),
				2
			)

			while
				not __wf_atom_7e8ad928(__wf_atom_6009c8ed)
				and not __wf_atom_7e8ad928(__wf_atom_28224c27)
				and v2 >= 0
			do
				__wf_atom_d2b2176d:__wf_atom_c9ea4908(v)
				__wf_atom_d2b2176d:__wf_atom_56004282(
					v,
					319,
					0,
					v2 - 0.01,
					__wf_atom_28224c27:__wf_atom_1bb5b1ff(),
					__wf_atom_28224c27,
					26,
					Symbol(),
					2
				)
				Sleep(0.25)

				if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
					return
				else
					v2 = __wf_atom_d2b2176d:__wf_atom_07dc8ba3(v)
				end
			end

			__wf_atom_d2b2176d:RemoveUpgrade(410, 3, v3, nil, nil, 26, EMPTY_SYMBOL, false, 2)
			__wf_atom_d2b2176d:__wf_atom_c9ea4908(v)
		end
	end
end

function OnMeleeHit(object, _, _, _)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v)
	end
end

function AddUpgrade(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.MusicalDodgeCount = 0
	object:__wf_atom_520644d6(22, Symbol("OnPerfectDodge"), Symbol("OnPerfectDodgePassive"))
	object:__wf_atom_520644d6(19, Symbol("OnDodge"), Symbol("OnDodgePassive"))
	object:__wf_atom_520644d6(5, Symbol("OnMeleeHit"), Symbol("OnMeleeHitPassive"))

	if __wf_atom_6009c8ed:__wf_atom_535d5cbb() then
		module2.AddPactWeapon(__wf_atom_6009c8ed, weaponType, weaponEffectsType)
	end
end

function RemoveUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		module2.RemovePactWeapon(__wf_atom_6009c8ed, weaponType, weaponEffectsType)
	end

	object:__wf_atom_2a5bca4a(nil, Symbol("OnPerfectDodgePassive"))
	object:__wf_atom_2a5bca4a(nil, Symbol("OnDodgePassive"))
	object:__wf_atom_2a5bca4a(nil, Symbol("OnMeleeHitPassive"))
end