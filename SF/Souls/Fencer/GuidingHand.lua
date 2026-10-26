local v = 0.5
local v2 = 10
local v3 = {}
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Interface.SFUtilities")

function NpcEvaluateAbility(_, object)
	if object:__wf_atom_58dabbc7() then
		return 0
	end

	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
	then
		return 0
	end

	local __wf_atom_be152500 = __wf_atom_d2b2176d:__wf_atom_be152500(0)

	if
		__wf_atom_7e8ad928(__wf_atom_be152500)
		or __wf_atom_d2b2176d:__wf_atom_9f71ab59()
		or __wf_atom_be152500:GetState() ~= 0
	then
		return 0
	end

	return 1
end

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

local function fn(p, object)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		v2 = 10
		v = 0.25
	elseif p == 2 then
		v2 = 12
		v = 0.3
	elseif p == 3 then
		v2 = 15
		v = 0.35
	else
		v2 = 20
		v = 0.4
	end

	v2 *= magikForceCalc
	v *= magikForceCalc
end

function OnMeleeHit(object)
	print("Fencer: OnMeleeHit")

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if __wf_atom_7e8ad928(__wf_atom_9d766292) or __wf_atom_7e8ad928((__wf_atom_9d766292:__wf_atom_483e7ddc())) then
		return
	end

	local __wf_atom_5ba147ac = __wf_atom_9d766292:__wf_atom_5ba147ac()

	if __wf_atom_7e8ad928(__wf_atom_5ba147ac) then
		return
	end

	local __wf_atom_37799654 = __wf_atom_5ba147ac:__wf_atom_6386920d():__wf_atom_37799654()
	__wf_atom_5ba147ac:__wf_atom_6d7ec072(Engine.UpgradedValue(__wf_atom_37799654 * v))
	table.insert(v3, { delay = mSecondaryHitDelay, dd = __wf_atom_5ba147ac })
end

function ActivateAbility(object, object2, _, p)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	Symbol("OnMeleeHit")
	Symbol("OnMeleeHitAbility")
	fn(p, object2)
	fn(p, object2)
	module.SetForceAim(object2, mOwner, true)
	module.EnableWeaponFiring(object2, mOwner, false)
	module.AddCastImmunity(object2)
	module.Fear(object2, 10)
	object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	Sleep(0)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v4

	if not __wf_atom_7e8ad928(pactFxType) then
		v4 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	object2:Attach(castFxType, EMPTY_SYMBOL)

	if object2:__wf_atom_ee4f0cba() > 1 then
		if not module.PlayUpperBodyAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 2, 1, false) then
			return
		end
	elseif not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end

	object:__wf_atom_6a4cf64f()
	module.EnableWeaponFiring(object2, mOwner, true)
	module.SetForceAim(object2, mOwner, false)
	object2:__wf_atom_b4529799(Symbol("OnMeleeHitFencer"), "OnMeleeHit")
	module.RemoveCastImmunity(object2)
	object2:__wf_atom_d2b2176d()
	local __wf_atom_a96eb2aa = object2:__wf_atom_a96eb2aa()
	object2:__wf_atom_e93896ba()
	object2:__wf_atom_0b636f17()
	local position = object2:GetPosition()
	local __wf_atom_2f2bada0 = object2:__wf_atom_2f2bada0()
	mOwner:__wf_atom_7ccf4243(avatarAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local entity = gRegion:CreateEntity(
		object2,
		position,
		__wf_atom_2f2bada0,
		object2,
		object,
		module2.GetReplicationMode()
	)
	entity:__wf_atom_0ed81088(false)
	entity:__wf_atom_30964595(false)
	entity:SetVisibility(false, true)
	entity:__wf_atom_72cd7949(object2:__wf_atom_f115b657())
	local __wf_atom_d2b2176d = entity:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:__wf_atom_13a9a02f(__wf_atom_a96eb2aa, true)
	entity:__wf_atom_e5d015a7(Symbol("AltClone"))
	local __wf_atom_aba9c26e = object2:__wf_atom_d2b2176d():__wf_atom_aba9c26e(0)
	local __wf_atom_28224c27 = object2:__wf_atom_d2b2176d():__wf_atom_28224c27(__wf_atom_aba9c26e)
	object2:__wf_atom_d2b2176d():__wf_atom_28224c27(0)
	entity:SetVisibility(true, true)
	__wf_atom_d2b2176d:Equip(5, 0, 1)
	entity:Attach(ghostAttachFxType, EMPTY_SYMBOL)
	entity:__wf_atom_4339a64c(false)
	local __wf_atom_be0bea4a = entity:__wf_atom_be0bea4a()

	for i = 1, #__wf_atom_be0bea4a do
		if not __wf_atom_7e8ad928(__wf_atom_be0bea4a[i]) then
			__wf_atom_be0bea4a[i]:__wf_atom_0ed81088(false)
		end
	end

	local total = 0
	local v5 = 0

	while not __wf_atom_7e8ad928(entity) and not __wf_atom_7e8ad928(object2) and not object2:IsKilled() and v2 > 0 do
		local v6 = __wf_atom_084b3e93()
		total += v6
		v2 -= v6
		local v7 = 0

		if v5 < 1 then
			v5 = __wf_atom_421b01aa(v5 + v6, 0, 1)
			entity:__wf_atom_68f2c268(1 - v5 * 0.5)
		end

		object2:__wf_atom_ad70ef85(true, entity)

		if mSecondaryHitDelay < total then
			entity:__wf_atom_bceb7324((total - mSecondaryHitDelay) / total)
		end

		for i = #v3, 1, -1 do
			if v3[i] == nil then
				continue
			end

			v3[i].delay -= v6

			if not (v3[i].delay < 0) then
				continue
			end

			v7 = i
			break
		end

		local __wf_atom_aba9c26e2 = object2:__wf_atom_d2b2176d():__wf_atom_aba9c26e(0)
		local __wf_atom_28224c27_2 = object2:__wf_atom_d2b2176d():__wf_atom_28224c27(__wf_atom_aba9c26e2)
		object2:__wf_atom_d2b2176d():__wf_atom_28224c27(0)

		if __wf_atom_28224c27_2 ~= __wf_atom_28224c27 then
			__wf_atom_d2b2176d:Unequip(0, 2)

			if not (__wf_atom_7e8ad928(__wf_atom_28224c27_2) or __wf_atom_d2b2176d:__wf_atom_d93821d0(__wf_atom_aba9c26e2)) then
				__wf_atom_d2b2176d:Equip(__wf_atom_aba9c26e2, 0, 2)
			end

			entity:__wf_atom_68f2c268(0.5)
			__wf_atom_28224c27 = __wf_atom_28224c27_2
		end

		for i = 1, v7 do
			if v3[i] == nil then
				continue
			end

			local dd = v3[i].dd

			if not (__wf_atom_7e8ad928(dd) or __wf_atom_7e8ad928(dd.victim) or dd.victim:IsKilled() or dd.victim:__wf_atom_bedb4e3f()) then
				local victim = dd.victim
				object2:__wf_atom_af2dc07b(Symbol("OnMeleeHitFencer"))
				victim:__wf_atom_649bf33e(dd)
				object2:__wf_atom_b4529799(Symbol("OnMeleeHitFencer"), "OnMeleeHit")
			end

			v3[i] = v3[v7 + i]
			v3[v7 + i] = nil
		end

		Sleep(0)
	end

	local v6 = 0

	while v6 < 1 and not __wf_atom_7e8ad928(entity) do
		v6 = __wf_atom_421b01aa(v6 + __wf_atom_084b3e93(), 0, 1)
		entity:__wf_atom_68f2c268(v6 * 0.5 + 0.5)
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:ClearHistory()
		entity:Destroy()
	end
end

function DeactivateAbility(_, object, _, _)
	print("DeactivateAbility: GuidingHand")
	module.EnableWeaponFiring(object, mOwner, true)
	object:__wf_atom_af2dc07b(Symbol("OnMeleeHitFencer"))
end