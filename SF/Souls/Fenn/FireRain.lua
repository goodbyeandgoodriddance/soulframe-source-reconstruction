local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = 5
local v2 = 50
local fennFireDuration = 0.75
local v3 = Vector()
local v4 = Vector()
local v5 = Vector()

local function fn(object, p)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		v = 2
		v2 = 10
	elseif p == 2 then
		v = 3
		v2 = 15
	elseif p == 3 then
		v2 = 20
		v = 4
	else
		v2 = 50
		v = 5
	end

	v2 *= magikForceCalc
	v *= magikForceCalc
end

function EvaluateAbility(object, object2, _)
	object:__wf_atom_e638fc23((object2:__wf_atom_d2b2176d():__wf_atom_74d951b0()))
	return true
end

function ActivateAbility(object, object2, _, p, _)
	fn(object2, p)
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.FennFireDuration = fennFireDuration
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	module.EnableWeaponSlot(object2, "Idol", true, 0)

	if object2:__wf_atom_4417a5d4() then
		object2:__wf_atom_d2b2176d():Equip(0, 0, 2)
	end

	object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	local __wf_atom_74d951b0 = __wf_atom_d2b2176d:__wf_atom_74d951b0()
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v6

	if not __wf_atom_7e8ad928(pactFxType) then
		v6 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	module.EnableWeaponFiring(object2, mOwner, false)

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, false) then
		return
	end

	module.EnableWeaponFiring(object2, mOwner, true)
	object:__wf_atom_6a4cf64f()
	module.RemoveCastImmunity(object2)
	v3 = object2:__wf_atom_a2a18137()
	local v7 = __wf_atom_74d951b0 - v3
	Normalize(v7)
	v5 = v3 + object2:__wf_atom_a06d543c() * Vector(1.5, 0, 1.5)
	gRegion:CreateEntity(castGroundFxType, v5, __wf_atom_80368bb1, object2)
	v4 = object2:__wf_atom_a2a18137()
	v4.y += 2
	Sleep(0.4)
	object2:__wf_atom_8a035cd5(Symbol("DoBarrage"), false)

	while not __wf_atom_7e8ad928(object2) and object2:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object2) then
		module.EnableWeaponSlot(object2, "Idol", false, 0)

		if object2:__wf_atom_4417a5d4() then
			__wf_atom_d2b2176d:__wf_atom_1870de39(true)
		end
	end

	Sleep(1)

	if not __wf_atom_7e8ad928(v6) then
		v6:Destroy()
	end
end

function DeactivateAbility(_, object)
	mOwner:__wf_atom_b5374ea1(Resource(mOwner:__wf_atom_1bb5b1ff()):__wf_atom_cb2fe64e(false))

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		module.EnableWeaponSlot(object, "Idol", false, 0)

		if object:__wf_atom_4417a5d4() then
			object:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
		end
	end

	module.EnableWeaponFiring(object, mOwner, true)
end

function DoBarrage(object)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local v6 = Vector()
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = v2
	radialDamageData.radius = 5
	radialDamageData:__wf_atom_7498285f(3, 1)
	radialDamageData.stabilityDamage = v2
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_34a8a27a(__wf_atom_e55d02aa)
	radialDamageData:__wf_atom_12cf5317(100)
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = true
	radialDamageData.staticCoverOnly = true
	local v7 = Vector()
	local v8 = nil
	local v9 = 0
	local count = 0
	local v10 = false
	local v11 = 1

	while
		not __wf_atom_7e8ad928(object)
		and v > 0
		and not (__wf_atom_7e8ad928(mOwner) or mOwner:__wf_atom_31446586())
	do
		if v9 <= 0 then
			local v12 = Random(-10, 10)
			local v13 = Random(-1, 1) * math.sqrt(100 - v12 * v12)
			v7.x = v3.x + v12
			v7.y = v3.y
			v7.z = v3.z + v13
			local v14 = v7 - v4 + v7

			if gRegion:Raycast(v4, v14, object, nil, v6) then
				count += 1
				v8 = gRegion:CreateEntity(crackTrackerFxType, v5, __wf_atom_80368bb1, object)
				v10 = true
			else
				v10 = false
			end

			v9 = Random(0.2, 0.35)
			v11 = v9
		end

		Sleep(0)
		v -= __wf_atom_084b3e93()
		v9 -= __wf_atom_084b3e93()

		if not __wf_atom_7e8ad928(v8) then
			v8:SetPosition((__wf_atom_f55d6358(v7, v5, v9 / v11)))
		end

		if not (v9 <= 0 and v10) then
			continue
		end

		radialDamageData:__wf_atom_98d98d81(v6)
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		local entity = gRegion:CreateEntity(fireVolume, v6, __wf_atom_80368bb1, object)

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_400189c4(2.5)
			entity:__wf_atom_7ebba814(object)
			entity:__wf_atom_34a8a27a(__wf_atom_e55d02aa)
			entity:__wf_atom_99fe2087(10)
		end

		if not __wf_atom_7e8ad928(v8) then
			v8:Destroy()
		end
	end

	if not __wf_atom_7e8ad928(v8) then
		v8:Destroy()
	end
end

function FireTimer(instance)
	fennFireDuration = instance:GetCreator():__wf_atom_e919fb8e().FennFireDuration
	local v6

	if __wf_atom_7e8ad928(fennFireDuration) then
		v6 = 1
	else
		v6 = fennFireDuration
	end

	while not __wf_atom_7e8ad928(instance) and v6 > 0 do
		Sleep(0)
		v6 -= __wf_atom_084b3e93()
	end

	instance:Destroy()
end