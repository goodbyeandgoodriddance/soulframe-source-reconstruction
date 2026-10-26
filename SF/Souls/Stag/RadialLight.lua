local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = Symbol("StagRadialLightAbility")
local v2 = 18
local v3 = 15

local function fn(p, object)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		v3 = 3
		v2 = 8
	elseif p == 2 then
		v3 = 3.5
		v2 = 10
	elseif p == 3 then
		v3 = 4
		v2 = 12
	else
		v3 = 4.5
		v2 = 14
	end

	v3 *= magikForceCalc
	v2 *= magikForceCalc
end

function NpcEvaluateAbility(_, _)
	return 0
end

function ActivateAbility(object, object2, _, p)
	fn(p, object2)
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

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end

	module.RemoveCastImmunity(object2)
	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
	gRegion:CreateEntity(explosionFxType, __wf_atom_1c374cc9, __wf_atom_80368bb1, object2)
	local entity = gRegion:CreateEntity(explosionDecoType, __wf_atom_1c374cc9, __wf_atom_80368bb1, object2)

	if not __wf_atom_7e8ad928(entity) then
		entity:SetMeshScale(v2)
	end

	local v5 = {}
	local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_1c374cc9, 0, v2)
	local v6 = Symbol("BLINDED")
	Symbol("BLINDED_LOOP")
	local v7 = 0
	object:__wf_atom_6a4cf64f()

	if gRegion:IsMaster() then
		mOwner:__wf_atom_37768748()

		for _, v8 in ipairs(all) do
			if v8:__wf_atom_129d1aba(object2) then
				continue
			end

			table.insert(v5, v8)

			if not v8:IsA(__wf_atom_9e85eea2) then
				continue
			end

			local __wf_atom_30e3d82b = v8:__wf_atom_30e3d82b()

			if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				continue
			end

			__wf_atom_30e3d82b:__wf_atom_707fb30f(true, v3)

			if not __wf_atom_7e8ad928(v8) and __wf_atom_7e8ad928(v8:__wf_atom_bb3e7833(targetAttachFxType)) then
				local v9 = Symbol("GAME_C1_HEAD")

				if v8:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD")) then
					v9 = Symbol("GAME_C1_HEAD")
				elseif v8:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD1")) then
					v9 = Symbol("GAME_C1_HEAD1")
				elseif v8:__wf_atom_71a94e55(Symbol("GAME_C_HEAD")) then
					v9 = Symbol("GAME_C_HEAD")
				elseif v8:__wf_atom_71a94e55(Symbol("GAME_C1_HORN")) then
					v9 = Symbol("GAME_C1_HORN")
				end

				local v10 = v3

				if v8:__wf_atom_464a4772() then
					v10 /= 2
				end

				if v7 < v10 then
					v7 = v10
				end

				v8:__wf_atom_d50c5af7(
					targetAttachFxType,
					v9,
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					v10,
					object:__wf_atom_6009c8ed()
				)
			end

			v8:__wf_atom_58c8ffec(v6, false, 4, 1, false, __wf_atom_5784a397(0, v8:__wf_atom_1ba2008d(v6)))
			v8:__wf_atom_8a035cd5(Symbol("DoBlind"), false)
		end
	end

	mOwner:__wf_atom_a7328d06(true)
	mOwner:__wf_atom_d14eed1a()
	object:__wf_atom_6a4cf64f()

	while v7 > 0 do
		Sleep(0)
		v7 -= __wf_atom_084b3e93()
	end

	mOwner:__wf_atom_a7328d06(false)
end

function DeactivateAbility(_, _, _, _) end

function DoBlind(object)
	local v4 = Symbol("BLINDED")
	local v5 = Symbol("BLINDED_LOOP")
	mOwner:__wf_atom_37768748()
	local v6 = v3

	if object:__wf_atom_464a4772() then
		v6 /= 2
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	object:__wf_atom_51cd6126(v, "OnDamaged")

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	__wf_atom_30e3d82b:__wf_atom_30b587a4()

	while v6 > 0 and __wf_atom_30e3d82b:__wf_atom_11cb6d4a() do
		if not (object:__wf_atom_fc8d8e90(v4, false) or object:__wf_atom_fc8d8e90(v5, false)) then
			object:__wf_atom_58c8ffec(v5, false, 4, 2, false, __wf_atom_5784a397(0, object:__wf_atom_1ba2008d(v5)))
		end

		if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_11cb6d4a() then
			Sleep(0)
			v6 -= __wf_atom_084b3e93()
		else
			break
		end
	end

	if gRegion:IsMaster() and not (object:IsKilled() or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) then
		if object:__wf_atom_fc8d8e90(v4) or object:__wf_atom_fc8d8e90(v5) then
			object:__wf_atom_9b5dcd3b(nil, false, 4, 1, false)
		end

		__wf_atom_30e3d82b:__wf_atom_707fb30f(false)
		object:__wf_atom_3ede53b4(v)
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(targetAttachFxType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function OnDamaged(object)
	local v4 = Symbol("BLINDED")
	local v5 = Symbol("BLINDED_LOOP")

	if object:__wf_atom_fc8d8e90(v4) or object:__wf_atom_fc8d8e90(v5) then
		object:__wf_atom_9b5dcd3b(nil, false, 4, 1, false)
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_707fb30f(false)
	end

	object:__wf_atom_3ede53b4(v)

	if not (__wf_atom_7e8ad928(object) or object:IsKilled() or __wf_atom_7e8ad928(object:__wf_atom_9d766292()) or __wf_atom_7e8ad928(object:__wf_atom_9d766292():__wf_atom_483e7ddc())) then
		local __wf_atom_483e7ddc = object:__wf_atom_9d766292():__wf_atom_483e7ddc()
		local damageData = Engine.DamageData()
		local stabilityDamage = __wf_atom_483e7ddc.baseAmount * 5
		local v6 = __wf_atom_483e7ddc.criticalChance * 5
		local criticalChance = v6 > 0.25 and 0.25 or v6
		damageData:__wf_atom_7498285f(15, 1)
		damageData.criticalChance = criticalChance
		damageData.stabilityDamage = stabilityDamage
		damageData:__wf_atom_ee93f76c(__wf_atom_483e7ddc:__wf_atom_08baf7d0())
		object:__wf_atom_649bf33e(damageData)
	end
end