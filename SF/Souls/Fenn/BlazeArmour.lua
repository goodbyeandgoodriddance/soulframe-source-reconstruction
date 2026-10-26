local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = 30
local radius = 10
local v2 = 1.5
local v3 = 1

local function fn(object, p)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		v2 = 1.15
		radius = 5
	elseif p == 2 then
		v2 = 1.25
		radius = 6
	elseif p == 3 then
		v2 = 1.35
		radius = 8
	else
		v2 = 1.5
		radius = 10
	end

	v2 *= magikForceCalc
	v3 *= magikForceCalc
	radius *= magikForceCalc
end

function ActivateAbility(object, object2, _, p)
	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	local isMaster = gRegion:IsMaster()
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	module.EnableWeaponFiring(object2, mOwner, false)
	module.AddCastImmunity(object2)
	module.Fear(object2, 10)
	fn(object2, p)
	module.EnableWeaponSlot(object2, "Idol", true, 0)

	if object2:__wf_atom_4417a5d4() then
		object2:__wf_atom_d2b2176d():Equip(0, 0, 2)
	end

	mOwner:__wf_atom_a7328d06(true)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v4

	if not __wf_atom_7e8ad928(pactFxType) then
		v4 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end

	module.RemoveCastImmunity(object2)
	local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(avatarAttachFxType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	object2:Attach(avatarAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if not __wf_atom_e919fb8e.FennOnFire then
		__wf_atom_e919fb8e.FennOnFire = true
	end

	object:__wf_atom_6a4cf64f()

	if isMaster then
		__wf_atom_d2b2176d:AddUpgrade(169, 2, 0.5)
	end

	module.SetAbilityStats(object, mOwner, { allies = {}, enemies = {}, damage = 0 })
	local v5 = Symbol(mOwner:__wf_atom_37768748():c_str() .. object2:__wf_atom_18aa6e58())
	object2:__wf_atom_51cd6126(v5, "OnDamaged")

	while not __wf_atom_7e8ad928(object2) and object2:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object2) then
		module.EnableWeaponFiring(object2, mOwner, true)
		module.EnableWeaponSlot(object2, "Idol", false, 0)

		if object2:__wf_atom_4417a5d4() then
			object2:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
		end
	end

	while not object2:IsKilled() do
		Sleep(0)
		v -= __wf_atom_084b3e93()

		if v <= 0 then
			break
		end
	end

	if not __wf_atom_7e8ad928(mOwner) then
		mOwner:__wf_atom_a7328d06(false)
	end

	object2:__wf_atom_3ede53b4(v5)

	if isMaster then
		__wf_atom_d2b2176d:RemoveUpgrade(169, 2, 0.5)
	end

	local __wf_atom_bb3e7833_2 = object2:__wf_atom_bb3e7833(avatarAttachFxType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
		__wf_atom_bb3e7833_2:Destroy()
	end
end

function DeactivateAbility(_, object, _, _)
	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.FennOnFire = false

	if not __wf_atom_7e8ad928(object) then
		module.EnableWeaponSlot(object, "Idol", false, 0)

		if object:__wf_atom_4417a5d4() then
			object:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
		end
	end

	module.EnableWeaponFiring(object, mOwner, true)
end

function OnDamaged(object)
	local __wf_atom_c78fa517 = mOwner:__wf_atom_c78fa517()

	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292())
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292():__wf_atom_483e7ddc())
	then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()
	local __wf_atom_9232afe2 = __wf_atom_9d766292:__wf_atom_9232afe2()

	if __wf_atom_9232afe2 <= 1 then
		return
	end

	local __wf_atom_679ed446 = __wf_atom_9d766292:__wf_atom_679ed446()
	local v4 = v2

	if
		not __wf_atom_7e8ad928(__wf_atom_679ed446)
		and __wf_atom_679ed446:IsA(__wf_atom_4ebf67cb)
		and __wf_atom_679ed446:__wf_atom_464a4772()
	then
		v4 = v3
	end

	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_34a8a27a(__wf_atom_c78fa517)
	radialDamageData.baseAmount = __wf_atom_9232afe2 * v4
	radialDamageData.radius = radius
	radialDamageData.stabilityDamage = __wf_atom_9232afe2 * 3
	radialDamageData:__wf_atom_7498285f(3, 1)
	radialDamageData.criticalChance = 0.15
	radialDamageData.fallOff = 0
	radialDamageData:__wf_atom_98d98d81(__wf_atom_1c374cc9)
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	gRegion:CreateEntity(explosionFxType, __wf_atom_1c374cc9, __wf_atom_80368bb1, object)
end