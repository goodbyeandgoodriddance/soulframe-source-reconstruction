local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local duration = 30
local v = 0.5
local v2 = 15
local v3 = 1
local v4 = 5
local v5 = Range(0.1, 0.5)
local v6 = Symbol("CC_GROUND")
local v7 = Symbol("BlockingBehavior")
local v8 = nil
local v9 = {}

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

local function fn(object, object2, p)
	if p then
		object:AddUpgrade(257, 0, v4, object2:__wf_atom_1bb5b1ff(), object2, 26, v6)
	else
		object:RemoveUpgrade(257, 0, v4, object2:__wf_atom_1bb5b1ff(), object2, 26, v6)
	end
end

function OnKilled(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbMotherRuneTarget) or not __wf_atom_e919fb8e.bbMotherRuneTarget then
		return
	end

	__wf_atom_e919fb8e.bbMotherRuneTarget = nil

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbMotherRuneFx) then
		__wf_atom_e919fb8e.bbMotherRuneFx:Destroy()
		__wf_atom_e919fb8e.bbMotherRuneFx = nil
	end
end

local function fn2(object, object2, object3)
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbMotherRuneTarget) then
		__wf_atom_e919fb8e.bbMotherRuneTarget = true
	elseif __wf_atom_e919fb8e.bbMotherRuneTarget then
		return
	end

	__wf_atom_55142dd4(object2, "OnKilled")
	Symbol("GAME_C1_HEAD")

	if object2:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD")) then
		Symbol("GAME_C1_HEAD")
	elseif object2:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD1")) then
		Symbol("GAME_C1_HEAD1")
	elseif object2:__wf_atom_71a94e55(Symbol("GAME_C_HEAD")) then
		Symbol("GAME_C_HEAD")
	elseif object2:__wf_atom_71a94e55(Symbol("GAME_C1_HORN")) then
		Symbol("GAME_C1_HORN")
	end

	local __wf_atom_e919fb8e2 = object:__wf_atom_e919fb8e()
	local __wf_atom_0395f752 = object3:__wf_atom_0395f752()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e2.Runes[__wf_atom_0395f752].bbMotherRuneMarkedTargets) then
		__wf_atom_e919fb8e2.Runes[__wf_atom_0395f752].bbMotherRuneMarkedTargets = {}
	end

	if not module2.TableContains(__wf_atom_e919fb8e2.Runes[__wf_atom_0395f752].bbMotherRuneMarkedTargets, object2) then
		table.insert(__wf_atom_e919fb8e2.Runes[__wf_atom_0395f752].bbMotherRuneMarkedTargets, object2)
	end
end

function SwordMove(instance)
	local __wf_atom_a2a18137 = instance:__wf_atom_a2a18137()
	local v10 = 5
	local total = 0.1

	while v10 > 0 do
		__wf_atom_a2a18137.y -= total
		v10 -= total
		instance:SetPosition(__wf_atom_a2a18137)
		total += 0.1
		Sleep(0)
	end

	gRegion:CreateEntity(impactDirtFXType, instance:__wf_atom_a2a18137() + Vector(0, -3, 0), Rotation(0, -90, 0))
	instance:PlaySound(impactSoundSFX, false)
	Sleep(1)
	local total2 = 0

	while total2 < 1 do
		total2 += __wf_atom_084b3e93() * 0.6
		instance:__wf_atom_a763aa1a(__wf_atom_24a82b69(total2))
		Sleep(0)
	end

	instance:Destroy()
end

function DawnStab(object)
	local runeSource = object:__wf_atom_e919fb8e().RuneSource
	local isMaster = gRegion:IsMaster()
	local entity = gRegion:CreateEntity(MotherSword, object:__wf_atom_a2a18137() + Vector(0, 8, 0), Rotation(0, 180, 0))
	local v10 = Symbol("SwordMove")
	local __wf_atom_a2a18137 = entity:__wf_atom_a2a18137()
	Sleep(1)
	entity:__wf_atom_8a035cd5(v10, false)
	Sleep(0.1)
	local __wf_atom_07e250ed = object:__wf_atom_7470861b():__wf_atom_07e250ed(object, true)
	object:__wf_atom_7470861b():__wf_atom_f756036f(false)
	__wf_atom_07e250ed:Attach(DissolverFXType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if isMaster then
		local __wf_atom_fec6bb4d = __wf_atom_07e250ed:__wf_atom_fec6bb4d(1)

		if not __wf_atom_7e8ad928(__wf_atom_fec6bb4d) then
			local __wf_atom_7ab56047 = gRegion:__wf_atom_7ab56047(jointFXType)
			__wf_atom_7ab56047:SetAnchor(0, object:__wf_atom_1c374cc9(Symbol("GAME_C1_HIP1")))
			__wf_atom_7ab56047:__wf_atom_7d7cae54(1, __wf_atom_fec6bb4d)
		end
	end

	local baseAmount = object:GetMaxHealth(true) * 2
	local damageData = Engine.DamageData()
	damageData.baseAmount = baseAmount
	damageData:__wf_atom_7498285f(15, 1)
	damageData:__wf_atom_6b472125(runeSource)
	damageData.hitType = 6
	damageData.blockableProjType = 4
	local v11 = object:GetPosition() - __wf_atom_a2a18137
	Normalize(v11)
	damageData:__wf_atom_ee93f76c(v11)
	object:__wf_atom_649bf33e(damageData)
	local total = 0

	while total < 1 and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_07e250ed)) do
		total += __wf_atom_084b3e93() * 0.6
		object:__wf_atom_a763aa1a(1 - __wf_atom_24a82b69(total))
		__wf_atom_07e250ed:__wf_atom_a763aa1a(__wf_atom_24a82b69(total))
		Sleep(0)
	end
end

function BayorDawnStab(object)
	local runeSource = object:__wf_atom_e919fb8e().RuneSource
	gRegion:IsMaster()
	local entity = gRegion:CreateEntity(MotherSword, object:__wf_atom_a2a18137() + Vector(0, 8, 0), Rotation(0, 180, 0))
	local v10 = Symbol("SwordMove")
	local __wf_atom_a2a18137 = entity:__wf_atom_a2a18137()
	Sleep(1)
	entity:__wf_atom_8a035cd5(v10, false)
	Sleep(0.1)
	object:GetMaxHealth(true)
	local damageData = Engine.DamageData()
	damageData.baseAmount = 150
	damageData:__wf_atom_7498285f(15, 1)
	damageData:__wf_atom_6b472125(runeSource)
	damageData.hitType = 6
	damageData.blockableProjType = 4
	local v11 = object:GetPosition() - __wf_atom_a2a18137
	Normalize(v11)
	damageData:__wf_atom_ee93f76c(v11)
	object:__wf_atom_649bf33e(damageData)
	Sleep(1)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_707fb30f(false)
		__wf_atom_30e3d82b:SetPaused(false, Symbol("Mother"))
	end
end

function ProcMarkAfterDelay(runeSource)
	local ___wf_atom_5784a397 = __wf_atom_5784a397
	local __wf_atom_e919fb8e = runeSource:__wf_atom_e919fb8e()
	local motherGreatSwordLastHitTarget = __wf_atom_e919fb8e.MotherGreatSwordLastHitTarget
	local motherGreatSwordWeapon = __wf_atom_e919fb8e.MotherGreatSwordWeapon

	if __wf_atom_7e8ad928(motherGreatSwordLastHitTarget) or __wf_atom_7e8ad928(motherGreatSwordWeapon) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.MotherGreatSwordLastHitDamage) then
		local _motherGreatSwordLastHitDamage = __wf_atom_e919fb8e.MotherGreatSwordLastHitDamage
	end

	local position = motherGreatSwordLastHitTarget:GetPosition()
	local __wf_atom_ff1686f2 = v5:__wf_atom_ff1686f2()
	Sleep(__wf_atom_ff1686f2)
	local v10 = {}

	while true do
		local all = gRegion:FindAll(__wf_atom_9e85eea2, position, 0, 20)

		for i = #all, 1, -1 do
			local v11 = all[i]

			if not (__wf_atom_7e8ad928(v11) or v11:__wf_atom_129d1aba(runeSource) or v11:IsKilled() or v11:__wf_atom_bedb4e3f() or v11 == motherGreatSwordLastHitTarget or __wf_atom_7e8ad928(v11:__wf_atom_e919fb8e().bbMotherRuneTarget) or module2.TableContains(v10, v11)) then
				continue
			end

			table.remove(all, i)
		end

		local sortByDistance = module2.SortByDistance(all, position)

		if #sortByDistance == 0 then
			break
		end

		local v11 = Symbol("DawnStab")
		local v12 = sortByDistance[1]

		if not __wf_atom_7e8ad928(v12) then
			if v12:IsA(bayorType) then
				v11 = Symbol("BayorDawnStab")
			end

			local __wf_atom_e919fb8e_2 = v12:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e_2.RuneSource = runeSource
			v12:__wf_atom_2f3f52aa(-5)
			v12:__wf_atom_8a035cd5(v11, false)
			table.insert(v10, v12)
		end

		local __wf_atom_ff1686f2_2 = v5:__wf_atom_ff1686f2()
		Sleep(__wf_atom_ff1686f2_2)
	end
end

local function fn3(object, object2)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local __wf_atom_0395f752 = object2:__wf_atom_0395f752()

	for _, bbMotherRuneMarkedTarget in ipairs(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbMotherRuneMarkedTargets) do
		if __wf_atom_7e8ad928(bbMotherRuneMarkedTarget) or bbMotherRuneMarkedTarget:IsKilled() then
			continue
		end

		local __wf_atom_e919fb8e2 = bbMotherRuneMarkedTarget:__wf_atom_e919fb8e()

		if
			__wf_atom_7e8ad928(__wf_atom_e919fb8e2.bbMotherRuneTarget)
			or not __wf_atom_e919fb8e2.bbMotherRuneTarget
			or __wf_atom_7e8ad928(__wf_atom_e919fb8e2.bbMotherRuneFx)
		then
			continue
		end

		__wf_atom_e919fb8e2.bbMotherRuneFx:Destroy()
		__wf_atom_e919fb8e2.bbMotherRuneFx = nil
		__wf_atom_e919fb8e2.bbMotherRuneTarget = nil
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbMotherRuneMarkedTargets = nil
end

function GiveStun(object)
	local v10 = Symbol("DAWN")
	local v11 = Symbol("DAWN_LOOP")
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local v12

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		v12 = __wf_atom_30e3d82b:__wf_atom_50a7d83e()
	end

	if __wf_atom_7e8ad928(v12) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v7, v12, 1)
		v12:__wf_atom_7470861b():__wf_atom_b6bcaf97(false)
	end

	__wf_atom_30e3d82b:SetPaused(true, Symbol("Mother"))
	local __wf_atom_d2b2176d = v12:__wf_atom_d2b2176d()

	if not v12:IsA(bayorType) then
		__wf_atom_d2b2176d:Unequip(0, 2)
	end

	v12:__wf_atom_58c8ffec(v10, true, 4, 1, true, __wf_atom_5784a397(0, v12:__wf_atom_1ba2008d(v10)))

	while not v12:__wf_atom_fc8d8e90(v11, false) do
		v12:__wf_atom_58c8ffec(v11, false, 4, 2, true, __wf_atom_5784a397(0, v12:__wf_atom_1ba2008d(v11)))
		Sleep(0)
	end

	local v13 = Symbol("DawnStab")
	local v14

	if v12:IsA(bayorType) then
		v13 = Symbol("BayorDawnStab")
		v14 = 0.1
	else
		v14 = 1
	end

	v12:__wf_atom_2f3f52aa(-5)

	if not __wf_atom_7e8ad928(object) then
		Sleep(Random(0, v14))
		object:__wf_atom_8a035cd5(v13, false)
	end

	while
		not __wf_atom_7e8ad928(v12)
		and not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
		and __wf_atom_30e3d82b:__wf_atom_11cb6d4a()
	do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v12) then
		if v12:__wf_atom_fc8d8e90(v11, false) then
			v12:__wf_atom_921c1a5f(nil, false, 3, 1, true)
		end

		__wf_atom_d2b2176d:__wf_atom_1870de39(true)

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v7)
		end
	end
end

local function fn4(runeSource, object, object2, radius, p)
	local runeDamageBuff = module3.GetRuneDamageBuff(runeSource, p)
	local stabilityDamage = object2:__wf_atom_483e7ddc().stabilityDamage * runeDamageBuff
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = 0
	radialDamageData.stabilityDamage = stabilityDamage
	radialDamageData:__wf_atom_7498285f(3, 1)
	radialDamageData:__wf_atom_6b472125(runeSource)
	radialDamageData:__wf_atom_34a8a27a(object2)
	radialDamageData.radius = radius
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = false
	radialDamageData:__wf_atom_98d98d81(runeSource:__wf_atom_d0069154())
	local motherBlindHitTargets = {}
	radialDamageData:__wf_atom_a8149853(Symbol("RadialHit"))
	_T.motherBlindHitTargets = motherBlindHitTargets
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	_T.motherBlindHitTargets = nil
	local secondaryScriptArgs = SF.SecondaryScriptArgs(false)
	secondaryScriptArgs:__wf_atom_a17e41c6(object2)

	for _, v10 in ipairs(motherBlindHitTargets) do
		if
			__wf_atom_7e8ad928(v10)
			or not v10:IsA(__wf_atom_4ebf67cb)
			or (v10:IsKilled() or v10:__wf_atom_129d1aba(runeSource))
		then
			continue
		end

		secondaryScriptArgs:__wf_atom_a17e41c6(v10)
		local __wf_atom_e919fb8e = v10:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.RuneSource = runeSource
		table.insert(v9, v10)
	end

	if secondaryScriptArgs:__wf_atom_ad6e68e0() then
		object:__wf_atom_e6831c5c(mOwner, Symbol("DoBlind"), secondaryScriptArgs)
	end

	local v10 = runeSource:Attach(
		explosionFxType,
		Symbol("GAME_R1_WEAPON1"),
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		runeSource
	)

	if not __wf_atom_7e8ad928(v10) then
		v10:SetMeshScale(radialDamageData.radius)
	end
end

function DoBlind(object)
	local v10 = object:__wf_atom_7bd6bf56(mOwner)[1]
	local __wf_atom_7bd6bf56 = object:__wf_atom_7bd6bf56(mOwner)
	table.remove(__wf_atom_7bd6bf56, 1)
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
	local v11 = Symbol("GiveStun")
	local v12 = 5

	for _, v13 in ipairs(__wf_atom_7bd6bf56) do
		if __wf_atom_7e8ad928(v13) then
			continue
		end

		local v14 = Symbol("GAME_C1_HEAD")

		if v13:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD")) then
			v14 = Symbol("GAME_C1_HEAD")
		elseif v13:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD1")) then
			v14 = Symbol("GAME_C1_HEAD1")
		elseif v13:__wf_atom_71a94e55(Symbol("GAME_C_HEAD")) then
			v14 = Symbol("GAME_C_HEAD")
		elseif v13:__wf_atom_71a94e55(Symbol("GAME_C1_HORN")) then
			v14 = Symbol("GAME_C1_HORN")
		end

		if v13:IsA(bayorType) then
			return
		end

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(v13:__wf_atom_30e3d82b()) then
			if v13:__wf_atom_464a4772() then
				v12 /= 2
			end

			v13:__wf_atom_17db995b(__wf_atom_37768748)
			v13:__wf_atom_30e3d82b():__wf_atom_707fb30f(true, 40)
			v13:__wf_atom_8a035cd5(v11, false)
		end

		v13:__wf_atom_d50c5af7(
			targetMarkedFxType,
			v14,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			5,
			object:__wf_atom_6009c8ed()
		)
		fn2(object:__wf_atom_95e72410(), v13, v10)
	end

	v9 = {}
end

function RadialHit(_, p)
	table.insert(_T.motherBlindHitTargets, p)
end

function OnMeleeHit(object, _, motherGreatSwordWeapon, motherGreatSwordLastHitTarget, _, p, _, _, _, _, _, p2)
	if
		__wf_atom_7e8ad928(motherGreatSwordWeapon)
		or motherGreatSwordWeapon ~= mOwner:__wf_atom_3371f607()
		or __wf_atom_7e8ad928(p2)
	then
		return
	end

	if p <= 0 or __wf_atom_7e8ad928(motherGreatSwordLastHitTarget) then
		return
	end

	local __wf_atom_e919fb8e = motherGreatSwordLastHitTarget:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) and __wf_atom_e919fb8e.bbMotherRuneTarget then
		local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

		if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
			local __wf_atom_e919fb8e2 = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e2.MotherGreatSwordLastHitTarget = motherGreatSwordLastHitTarget
			__wf_atom_e919fb8e2.MotherGreatSwordLastHitDamage = p * v3
			__wf_atom_e919fb8e2.MotherGreatSwordWeapon = motherGreatSwordWeapon
			__wf_atom_6009c8ed:__wf_atom_8a035cd5(Symbol("ProcMarkAfterDelay"), false)
		end
	end

	if gRegion:IsMaster() then
		mOwner:__wf_atom_74f6ca7b(Symbol("OnMeleeHit"), false)
	end
end

function ActivateAbility(object, object2, _, p)
	if __wf_atom_7e8ad928((module.GetWeaponMote(mOwner:__wf_atom_3371f607()))) then
		return
	end

	if p == 1 then
		duration = 10
		v2 = 15
		v = 0.4
		v3 = 1
		v4 = 10
	elseif p == 2 then
		duration = 10
		v2 = 15
		v = 0.5
		v3 = 1.25
		v4 = 20
	elseif p == 3 then
		duration = 10
		v2 = 15
		v = 0.6
		v3 = 1.5
		v4 = 30
	else
		duration = 10
		v2 = 15
		v = 0.7
		v3 = 1.75
		v4 = 40
	end

	module.AddCastImmunity(object2)
	mOwner:__wf_atom_34c9b8f6(0)
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	v8 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(v8) or not v8:IsA(__wf_atom_77e05d3b) then
		return
	end

	local v10

	if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(v8)) then
		v10 = v8:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(v10) then
			v10:Attach(activeFxType, EMPTY_SYMBOL)
		end

		if gRegion:IsMaster() then
			fn(object2:__wf_atom_d2b2176d(), v8, true)
		end
	end

	object2:__wf_atom_d2b2176d():__wf_atom_d5651846()

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true) then
		return
	end

	module.RemoveCastImmunity(object2)
	module.NotifyRuneSuccess(object2, v8)
	local energySoundInstance = nil
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) then
		__wf_atom_e919fb8e.Runes = {}
	end

	local __wf_atom_0395f752 = v8:__wf_atom_0395f752()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752] = {}
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbMotherRuneActive = true

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance) then
		energySoundInstance = object2:PlaySound(energyLoopingSound, false, 1, false)
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance = energySoundInstance
	end

	object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))))
	duration = 3

	if gRegion:IsMaster() then
		local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
		object:__wf_atom_19516b62(-module3.GetRuneActivationCost(), __wf_atom_2e4994f1)
	end

	fn4(object2, object, v8, v2, v)
	local v11 = false
	local v12 = nil

	while not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(v8) and duration > 0 do
		local __wf_atom_35a10d3c = object2:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

		if
			__wf_atom_35a10d3c == v8
			or __wf_atom_7e8ad928(__wf_atom_35a10d3c)
			or __wf_atom_35a10d3c:__wf_atom_ed08f97f()
		then
			local v13 = v8:__wf_atom_9f71ab59() and true or false

			if v11 or not v13 then
				if v11 and not v13 then
					object2:__wf_atom_0650fed7(swingFxType)
					v11 = false
				end
			else
				if not __wf_atom_7e8ad928(v10) and __wf_atom_7e8ad928(v12) then
					v12 = v10:Attach(swingFxType, EMPTY_SYMBOL)
				end

				v11 = true
			end
		end

		duration -= __wf_atom_084b3e93()

		if duration <= 0 then
			fn3(object2, v8)
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbMotherRuneActive = nil

			if not __wf_atom_7e8ad928(energySoundInstance) then
				energySoundInstance:Stop(false)
			end
		end

		Sleep(0)
	end
end

function DeactivateAbility(_, object, _, _)
	mOwner:__wf_atom_34c9b8f6(0)
	v8 = mOwner:__wf_atom_3371f607()

	if not __wf_atom_7e8ad928(deactivateAbilitySound) then
		object:PlaySound(deactivateAbilitySound, false)
	end

	object:__wf_atom_0650fed7(activeFxType)
	object:__wf_atom_0650fed7(swingFxType)

	if gRegion:IsMaster() then
		mOwner:__wf_atom_74f6ca7b(Symbol("OnMeleeHit"), false)

		if __wf_atom_7e8ad928(v8) or not v8:IsA(__wf_atom_77e05d3b) then
			return
		end

		local __wf_atom_0395f752 = v8:__wf_atom_0395f752()
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance)) then
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance:Stop(false)
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance = nil
		end

		fn(object:__wf_atom_d2b2176d(), v8, false)
	end
end

function GetAbilityStats(p, _, _, _, _, _)
	if p == 1 then
		duration = 10
		v2 = 15
		v = 0.4
		v3 = 1
		v4 = 10
	elseif p == 2 then
		duration = 10
		v2 = 15
		v = 0.5
		v3 = 1.25
		v4 = 20
	elseif p == 3 then
		duration = 10
		v2 = 15
		v = 0.6
		v3 = 1.5
		v4 = 30
	else
		duration = 10
		v2 = 15
		v = 0.7
		v3 = 1.75
		v4 = 40
	end

	local v10 = { DURATION = duration }
	return cjson.encode(v10)
end