local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = 3.5
local npcDuration2 = 5
local npcDamage2 = 10
local v2 = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}
local v3 = Vector(0, 1, 0)

local function fn(p, object)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		npcDamage2 = 30
		npcDuration2 = 3
	elseif p == 2 then
		npcDamage2 = 60
		npcDuration2 = 3
	else
		if p == 3 then
			npcDamage2 = 75
		else
			npcDamage2 = 90
		end

		npcDuration2 = 5
	end

	npcDamage2 *= magikForceCalc
	npcDuration2 *= magikForceCalc

	if isNPC then
		npcDamage2 = npcDamage
		npcDuration2 = npcDuration
	end
end

function EvaluateAbility(_, _)
	return true
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return 0
	end

	local avatar = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar

	if
		__wf_atom_9a1e4ed3.visible
		and __wf_atom_9a1e4ed3:__wf_atom_a3309443()
		and npcUseRange:Contains(__wf_atom_9a1e4ed3.distanceToTarget)
	then
		object:__wf_atom_f7170fc9(avatar)
		return 1
	else
		return 0
	end
end

function HugTheGround(object)
	local v4 = Vector(0, 1, 0)
	local v5 = Vector(0, -10, 0)
	object:__wf_atom_b20d29c1(Random(8, 15))
	local __wf_atom_dcc5c1a1 = object:__wf_atom_dcc5c1a1()
	__wf_atom_dcc5c1a1.y = 0
	Normalize(__wf_atom_dcc5c1a1)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local v6 = false
	local v7

	while true do
		local __wf_atom_a2a18137_2 = object:__wf_atom_a2a18137()

		if not v6 then
			local __wf_atom_dcc5c1a1_2 = object:__wf_atom_dcc5c1a1()
			local v8 = Length(__wf_atom_dcc5c1a1_2)

			if v8 == 0 then
				v8 = object:__wf_atom_510474d7()
			end

			local v9 = __wf_atom_a2a18137_2 + __wf_atom_dcc5c1a1 * v8 * __wf_atom_084b3e93() * 2
			local v10 = Vector()
			local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(v9 + v4, v9 + v5, v2, nil, v10)

			if
				__wf_atom_c20d246a
				and (not __wf_atom_c20d246a:IsA(__wf_atom_8d0b7f88) or __wf_atom_c20d246a:__wf_atom_c6f1f83d() == 0)
			then
				local v11 = v10 + v3 - object:__wf_atom_a2a18137()
				Normalize(v11)
				object:__wf_atom_53bcb18b(v11 * v8)
			else
				__wf_atom_dcc5c1a1_2.y = 0
				Normalize(__wf_atom_dcc5c1a1_2)
				object:__wf_atom_53bcb18b(__wf_atom_dcc5c1a1_2 * v8)
			end
		end

		if v6 then
			if __wf_atom_a2a18137_2 - __wf_atom_a2a18137 ~= __wf_atom_28d5d4aa then
				local v8 = Vector()
				local v9 = __wf_atom_9341614d(Vector(0, 0.5, 0), object:__wf_atom_2f2bada0())
				v7 = gRegion:__wf_atom_c20d246a(__wf_atom_a2a18137 + v9, __wf_atom_a2a18137_2 + v9, v2, nil, v8)

				if v7 and not v7:HasTag(Symbol("TreeDeco")) then
					break
				end
			end

			__wf_atom_a2a18137 = object:__wf_atom_a2a18137()
		end

		Sleep(0)
		v6 = not v6
	end

	if v7:__wf_atom_83a62c41() ~= v7 then
		print(v7:__wf_atom_83a62c41())
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

function ActivateAbility(object, object2, _, p, _)
	fn(p, object2)
	module.AddCastImmunity(object2)
	module.Fear(object2, 10)
	local __wf_atom_0e1e5bc9 = object2:__wf_atom_0e1e5bc9()

	if not isNPC then
		object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
		Sleep(0)
		__wf_atom_0e1e5bc9 = object2:__wf_atom_4e50d390()
	end

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v4

	if not __wf_atom_7e8ad928(pactFxType) then
		v4 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	local __wf_atom_0dcd7684 = activateAnim:__wf_atom_0dcd7684()
	local __wf_atom_43e3d184 = activateAnim:__wf_atom_43e3d184()
	local __wf_atom_8bb4ded3 = activateAnim:__wf_atom_8bb4ded3()

	for i = 0, #__wf_atom_0dcd7684 do
		if __wf_atom_0dcd7684[i] == Symbol("Cast") then
			__wf_atom_8bb4ded3 = __wf_atom_43e3d184[i]
		end
	end

	if not module.PlayAnim(object, activateAnim, false, 4, 1, true, 1) then
		return
	end

	Sleep(0)
	local total = 0

	while object2:__wf_atom_c138b19b(activateAnim) and total < __wf_atom_8bb4ded3 do
		if shouldFaceTargetNPC and gRegion:IsMaster() then
			object2:MotionControl():__wf_atom_3959d938(true)
			local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
			local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()
			local __wf_atom_0e1e5bc9_2 = object2:__wf_atom_0e1e5bc9()

			if
				not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
				and not __wf_atom_7e8ad928(__wf_atom_216d6edd)
				and __wf_atom_216d6edd:IsVisible()
			then
				local position = __wf_atom_216d6edd:GetPosition()
				local v5 = __wf_atom_fa8d0177(object2:GetPosition(), position)
				local v6 = __wf_atom_9d2f097a(__wf_atom_0e1e5bc9_2, v5, total / __wf_atom_8bb4ded3)
				object2:__wf_atom_51075230(v6)
				object2:__wf_atom_84d66e8e(v6)
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if isNPC then
		__wf_atom_0e1e5bc9 = object2:__wf_atom_0e1e5bc9()
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end

	object:__wf_atom_6a4cf64f()
	module.RemoveCastImmunity(object2)

	if not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) then
		return
	end

	local v5 = __wf_atom_e97f3142(Rotation(__wf_atom_0e1e5bc9.heading, 0, 0))
	local v6 = __wf_atom_edfe0d73(v5, Vector(0, 1, 0))
	local position = object2:GetPosition()
	local v7 = npcDamage2 * 0.5
	local v8 = npcDuration2
	local v9 = 0

	while npcDuration2 > 0 do
		if gRegion:IsMaster() and v9 <= 0 then
			local v10 = math.pow(npcDuration2 / v8, 1.8)
			local v11 = math.pow(npcDuration2 / v8, 5)
			local v12 = __wf_atom_104bfe98(0.01, 0.5, 1 - v10)
			local v13 = __wf_atom_104bfe98(0, v7, 1 - v11)
			v9 += v12
			v -= v12 / 2
			local v14 = npcDamage2 - v13
			local v15 = v * Random(-1, 1)
			local v16 = position - v5 * 2 + v15 * v6
			gRegion:__wf_atom_c20d246a(v16 + Vector(0, 4, 0), v16 + Vector(0, -20, 0), v2, nil, v16)
			local entity = gRegion:CreateEntity(
				stagType,
				v16 + v3,
				__wf_atom_fa8d0177(__wf_atom_28d5d4aa, v5),
				object,
				object
			)

			if not __wf_atom_7e8ad928(entity) then
				entity:__wf_atom_8fcdea81(object2)
				entity:__wf_atom_c6dbdab6(object)
				entity:__wf_atom_54d7dce3(3.5)
				entity:__wf_atom_533c6916(v14)
				entity:__wf_atom_350ac13e(40)
				entity:__wf_atom_8a035cd5(Symbol("HugTheGround"), false)
			end
		end

		Sleep(0)
		npcDuration2 -= __wf_atom_084b3e93()
		v9 -= __wf_atom_084b3e93()
	end
end

function DeactivateAbility(_, _, _, _) end