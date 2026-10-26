local v = 10
local v2 = 150
local v3 = 10
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Effects.IdolEffects")

function NpcEvaluateAbility(_, _)
	return 0
end

function GetAbilityUpgradeLevelInfo()
	mOwner = _T.AbilityLevelQueryParms.Ability
	local level = _T.AbilityLevelQueryParms.Level
	local avatar = _T.AbilityLevelQueryParms.Avatar
	local magikForceCalc = module.magikForceCalc(avatar, level, mOwner)

	if level == 1 then
		v = 3
		v2 = 50
	end

	if level == 2 then
		v = 5
		v2 = 75
	end

	if level == 3 then
		v = 6
		v2 = 100
	end

	if level >= 4 then
		v = 7
		v2 = 125
	end

	v *= magikForceCalc
	v2 *= magikForceCalc
	local abilityUpgradeLevelInfo = {}
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/DAMAGE",
		Value = v2,
		ValuePost = "/SF/Language/Menu/DT_SLASH"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/ABILITY_RADIUS",
		Value = v3,
		ValueUnit = "/Lotus/Language/Game/UNIT_METER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/POWER_DURATION",
		Value = v,
		ValueUnit = "/Lotus/Language/Game/UNIT_SECOND"
	})
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

function ActivateAbility(object, object2, _, _)
	module.EnableWeaponFiring(object2, mOwner, false)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	object2:__wf_atom_8a035cd5(Symbol("VirtueSwap"), false)
	object2:__wf_atom_8a035cd5(Symbol("AdjustTorso"), false)
	module.EnableWeaponSlot(object2, "Idol", true, 0)

	if object2:__wf_atom_4417a5d4() then
		object2:__wf_atom_d2b2176d():Equip(0, 0, 2)
	end

	module.SetForceAim(object2, mOwner, true)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v4

	if not __wf_atom_7e8ad928(pactFxType) then
		v4 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	object2:Attach(castFxType, EMPTY_SYMBOL)

	if object2:__wf_atom_59cb39a4() then
		if not module.PlayAnimAndSuspendUntilEvent(object, airAnim, "Cast", false, 2, 1, false) then
			return
		end
	elseif not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, false) then
		return
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end

	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
	local __wf_atom_28224c27 = object2:__wf_atom_d2b2176d():__wf_atom_28224c27(0)
	local v5

	if __wf_atom_7e8ad928(__wf_atom_28224c27) then
		v5 = __wf_atom_1c374cc9
	else
		v5 = __wf_atom_28224c27:__wf_atom_4227f14a()
	end

	local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()
	local entity = gRegion:CreateEntity(projectileType, v5, __wf_atom_4e50d390, object)

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8fcdea81(object2)
		entity:__wf_atom_c6dbdab6(object)
		entity:__wf_atom_129183dd(__wf_atom_1c374cc9, (object2:__wf_atom_d2b2176d():__wf_atom_74d951b0()))
		entity:__wf_atom_8a035cd5(Symbol("ProjWait"), false)
	end

	module.RemoveCastImmunity(object2)
	mOwner:__wf_atom_a7328d06(true)
	mOwner:__wf_atom_d14eed1a()
end

function DeactivateAbility(_, object, _, _)
	while
		not __wf_atom_7e8ad928(object)
		and (object:__wf_atom_c138b19b(activateAnim) or object:__wf_atom_c138b19b(airAnim))
	do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		module.EnableWeaponSlot(object, "Idol", false, 0)

		if object:__wf_atom_4417a5d4() then
			object:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
		end

		module.SetForceAim(object, mOwner, false)
		module.EnableWeaponFiring(object, mOwner, true)
	end
end

function AdjustTorso(object)
	object:__wf_atom_e919fb8e()
	local __wf_atom_59cb39a4 = object:__wf_atom_59cb39a4()

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, true)
	end

	local v4 = __wf_atom_10cd16b2(object:__wf_atom_9f57166e(), 0.5)
	v4:__wf_atom_09294a87(0)

	while not __wf_atom_7e8ad928(mOwner) and mOwner:IsActive() and not mOwner:__wf_atom_9e62504e() do
		if __wf_atom_59cb39a4 then
			if object:__wf_atom_59cb39a4() then
				v4:Update(__wf_atom_084b3e93())
				object:__wf_atom_4c3f8902(v4:__wf_atom_9e368823())
			else
				module.EnableAimGlide(object, mOwner, false)
				__wf_atom_59cb39a4 = false
			end
		end

		object:__wf_atom_187571ae(0, object:__wf_atom_ed1dbb61())
		Sleep(0)
	end

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, false)
	end

	object:__wf_atom_ae3321f6()
end

function FindSpawnPos(p, object)
	local v4 = Vector()
	local v5 = Vector()
	local position = object:GetPosition()
	local _ = v4 - position
	v5 -= position
	local y = p.y
	gRegion:__wf_atom_2202ffb6():__wf_atom_3c37bceb(p, 3)
	p.y = math.max(p.y, y)
	gRegion:Raycast(p + Vector(0, 0.5, 0), p - Vector(0, 5, 0), object, nil, p, true)
	return true
end

local function fn(object) -- 2 equivalent calls inferred from this helper
	if object:__wf_atom_f5ca3244() then
		mOwner = object:__wf_atom_e21e8409(WeakResource("/SF/Souls/Default/FeyDecoyAbilityPrime"))
	else
		mOwner = object:__wf_atom_e21e8409(WeakResource("/SF/Souls/Default/FeyDecoyAbility"))
	end
end

function DecoyImpact(object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local position, v4

	if __wf_atom_7e8ad928(object2) then
		if __wf_atom_7e8ad928(object) then
			object:Die()
			return
		else
			position = object:GetPosition()
			v4 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, object:__wf_atom_a06d543c())
		end
	else
		position = object2:GetPosition() + object2:__wf_atom_a06d543c() * 2
		v4 = __wf_atom_fa8d0177(position, object2:GetPosition())
	end

	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		object:Die()
		return
	end

	local __wf_atom_e55d02aa = __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		object:Die()
		return
	end

	fn(__wf_atom_e55d02aa) -- inferred equivalent call
	local __wf_atom_e8008ec5 = __wf_atom_e55d02aa:__wf_atom_e8008ec5(mOwner)
	local v5 = not (__wf_atom_e8008ec5 < __wf_atom_e55d02aa:__wf_atom_87a16e10()) and 1
		or __wf_atom_e55d02aa:__wf_atom_cc3c265a(__wf_atom_e8008ec5)
		or 1
	local magikForceCalc = module.magikForceCalc(__wf_atom_7be51ede, v5, mOwner)

	if v5 == 1 then
		v = 3
		v2 = 50
	end

	if v5 == 2 then
		v = 5
		v2 = 75
	end

	if v5 == 3 then
		v = 6
		v2 = 100
	end

	if v5 >= 4 then
		v = 7
		v2 = 125
	end

	v *= magikForceCalc
	v2 *= magikForceCalc

	if __wf_atom_7be51ede:__wf_atom_4417a5d4() and FindSpawnPos(position, __wf_atom_7be51ede) then
		local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
		secondaryScriptArgs:__wf_atom_37d0a93a(position)
		secondaryScriptArgs:__wf_atom_37d0a93a(__wf_atom_e97f3142(v4))
		secondaryScriptArgs:__wf_atom_079cbbd0(v)
		secondaryScriptArgs:__wf_atom_079cbbd0(v2)
		secondaryScriptArgs:__wf_atom_079cbbd0(v3)
		__wf_atom_e55d02aa:__wf_atom_e6831c5c(mOwner, Symbol("DoDecoy"), secondaryScriptArgs)
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.decoySpawned = true
	object:Die()
end

function ProjectileDie(object)
	if object:__wf_atom_e919fb8e().decoySpawned then
		return
	end

	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		local __wf_atom_e55d02aa = __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			fn(__wf_atom_e55d02aa) -- inferred equivalent call

			if not __wf_atom_7e8ad928(mOwner) then
				mOwner:__wf_atom_a7328d06(false)
			end
		end
	end
end

function ProjWait(object)
	Sleep(5)

	if not (__wf_atom_7e8ad928(mOwner) or object:__wf_atom_e919fb8e().decoySpawned) then
		mOwner:__wf_atom_a7328d06(false)
	end
end

local function fn2(__wf_atom_6be84646)
	if gRegion:IsMaster() and _T.decoy and _T.decoy[__wf_atom_6be84646] then
		local v4 = _T.decoy[__wf_atom_6be84646]

		if not __wf_atom_7e8ad928(v4.decoy) then
			if not __wf_atom_7e8ad928(decoyDestroyType) then
				gRegion:CreateEntity(decoyDestroyType, v4.decoy:GetPosition(), v4.decoy:__wf_atom_dc309f8a())
			end

			v4.decoy:Attach(destroyFxType, EMPTY_SYMBOL)
		end

		for _, v5 in pairs(v4.finisherOpen) do
			if not __wf_atom_7e8ad928(v5) then
				v5:__wf_atom_9373d0eb(11, false)
			end
		end

		_T.decoy[__wf_atom_6be84646] = nil
	end
end

local function fn3(object, entity)
	local __wf_atom_0d9c1a58 = object:__wf_atom_6009c8ed():__wf_atom_0d9c1a58()

	if __wf_atom_7e8ad928(__wf_atom_0d9c1a58:__wf_atom_a4299765():__wf_atom_ed5c034d(0, 0).mItemType) then
		local v4 = entity:GiveItem(Type(object:__wf_atom_1bb5b1ff()), true)

		if not __wf_atom_7e8ad928(v4) then
			v4:SetCustomization(object:__wf_atom_eb82ab1f())
		end
	else
		entity:__wf_atom_d2b2176d():__wf_atom_13a9a02f(__wf_atom_0d9c1a58, true)
	end
end

function DoDecoy(object, _, p, p2, p3, p4, p5)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	local __wf_atom_6be84646 = __wf_atom_6009c8ed:__wf_atom_0d9c1a58():__wf_atom_6be84646()
	fn2(__wf_atom_6be84646)
	local v4 = __wf_atom_fa8d0177(p, __wf_atom_6009c8ed:GetPosition())
	v4.pitch = 0
	v4.bank = 0
	local entity = gRegion:CreateEntity(decoyAvatarType, p, v4, object)

	if __wf_atom_7e8ad928(entity) then
		return
	end

	if _T.decoy == nil then
		_T.decoy = {}
	end

	_T.decoy[__wf_atom_6be84646] = { decoy = entity, finisherOpen = {} }
	v = p3
	v2 = p4
	v3 = p5
	entity:SetFaction(__wf_atom_6009c8ed:__wf_atom_e93896ba())
	entity:__wf_atom_2f3f52aa(5)
	entity:__wf_atom_51075230(__wf_atom_fa8d0177(__wf_atom_28d5d4aa, p2))
	entity:__wf_atom_72cd7949(__wf_atom_6009c8ed:__wf_atom_f115b657())
	fn3(object, entity)
	entity:__wf_atom_7470861b():__wf_atom_9fba31e6(EMPTY_SYMBOL, 26, 6, 0)
	entity:__wf_atom_921c1a5f(decoyAnim, false, 3, 2, true)
	entity:__wf_atom_cf012db6(decoyAnim)
	entity:__wf_atom_68f2c268(1)
	entity:SetVisibility(true)

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8a035cd5(Symbol("DecoyWait"), false)
	end
end

function DecoySequencer(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if not __wf_atom_7e8ad928(__wf_atom_575542c8) then
		local creator = __wf_atom_575542c8:GetCreator()

		if not __wf_atom_7e8ad928(creator) then
			object:__wf_atom_7ebba814(creator:__wf_atom_6009c8ed())
		end
	end
end

function DecoyWait(object)
	local v4 = v
	local baseAmount = v2
	local radius = v3
	local __wf_atom_c78fa517 = mOwner:__wf_atom_c78fa517()
	local __wf_atom_6009c8ed = __wf_atom_c78fa517:__wf_atom_6009c8ed()
	local __wf_atom_6be84646 = __wf_atom_6009c8ed:__wf_atom_0d9c1a58():__wf_atom_6be84646()
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local finisherOpen = _T.decoy[__wf_atom_6be84646].finisherOpen
	local v5 = -1
	local timerSound2 = timerSound
	local v6

	if __wf_atom_7e8ad928(timerSound2) then
		v6 = 0
	else
		v6 = timerSound2:__wf_atom_1e34340d()
	end

	while v4 > 0 and _T.decoy[__wf_atom_6be84646] ~= nil do
		local __wf_atom_e0730826 = __wf_atom_7d789620:__wf_atom_e0730826(object, radius + 10)
		local __wf_atom_50a7d83esBy__wf_atom_18aa6e58 = {}

		if __wf_atom_7e8ad928(__wf_atom_e0730826) and gRegion:IsMaster() then
			local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
			local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_a2a18137, 0, radius + 10)
			__wf_atom_e0730826 = {}

			for _, v7 in ipairs(all) do
				if v7:__wf_atom_129d1aba(__wf_atom_6009c8ed) or not v7:IsA(__wf_atom_9e85eea2) then
					continue
				end

				local __wf_atom_30e3d82b = v7:__wf_atom_30e3d82b()

				if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
					table.insert(__wf_atom_e0730826, __wf_atom_30e3d82b)
				end
			end
		end

		for _, v7 in ipairs(__wf_atom_e0730826) do
			local __wf_atom_50a7d83e = v7:__wf_atom_50a7d83e()

			if
				__wf_atom_7e8ad928(__wf_atom_50a7d83e)
				or __wf_atom_50a7d83e:IsKilled()
				or __wf_atom_50a7d83e:__wf_atom_129d1aba(object)
			then
				continue
			end

			local __wf_atom_18aa6e58 = __wf_atom_50a7d83e:__wf_atom_18aa6e58()

			if v7:__wf_atom_216d6edd() == object then
				__wf_atom_50a7d83e:__wf_atom_5b3d56b0(__wf_atom_6009c8ed)
				__wf_atom_50a7d83esBy__wf_atom_18aa6e58[__wf_atom_18aa6e58] = __wf_atom_50a7d83e
				finisherOpen[__wf_atom_18aa6e58] = nil
			end

			if not (v5 < 0 and __wf_atom_50a7d83e:__wf_atom_8a6b8fc3(object) <= radius) then
				continue
			end

			object:PlaySound(timerSound, false, 0, true)
			v5 = 4
		end

		for _, v7 in pairs(finisherOpen) do
			if not __wf_atom_7e8ad928(v7) then
				v7:__wf_atom_9373d0eb(11, false)
			end
		end

		_T.decoy[__wf_atom_6be84646].finisherOpen = __wf_atom_50a7d83esBy__wf_atom_18aa6e58

		if v5 > 0 then
			v5 -= 0.25

			if v5 <= 0 then
				break
			end
		end

		if not __wf_atom_7e8ad928(timerSound2) and v4 < v6 then
			object:PlaySound(timerSound2, false, 0, true)
			timerSound2 = nil
		end

		Sleep(0.25)
		v4 -= 0.25
		finisherOpen = __wf_atom_50a7d83esBy__wf_atom_18aa6e58
	end

	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = baseAmount
	radialDamageData.stabilityDamage = baseAmount / 3
	radialDamageData:__wf_atom_7498285f(2, 1)
	radialDamageData:__wf_atom_6b472125(__wf_atom_6009c8ed)
	radialDamageData:__wf_atom_34a8a27a(__wf_atom_c78fa517)
	radialDamageData.radius = radius
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = false
	radialDamageData:__wf_atom_98d98d81(object:__wf_atom_d0069154())
	radialDamageData.hostAuthoritative = true

	if _T.decoy[__wf_atom_6be84646] ~= nil and not __wf_atom_7e8ad928(_T.decoy[__wf_atom_6be84646].decoy) then
		_T.decoy[__wf_atom_6be84646].decoy:Attach(
			blastFxType,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			nil
		)
		_T.decoy[__wf_atom_6be84646].decoy:PlaySound(blastSound, false, 0, true)
	end

	gRegion:__wf_atom_f6ec80de(radialDamageData)

	if not __wf_atom_7e8ad928(__wf_atom_c78fa517) then
		__wf_atom_c78fa517:__wf_atom_e6831c5c(mOwner, Symbol("DoCooldownUnpause"), SF.SecondaryScriptArgs(false))
	end

	fn2(__wf_atom_6be84646)
end

function DoCooldownUnpause(_, _, _, _, _, _, _)
	mOwner:__wf_atom_a7328d06(false)
end

function VirtueSwap(p)
	module2.FeyVirtueSwap(p, 0.75)
end