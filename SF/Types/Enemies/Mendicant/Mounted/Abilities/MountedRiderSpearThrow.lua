local v = Symbol("RiderSpearThrowImmunity")

local function fn(object)
	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()
	local v2 = nil

	for _, v3 in pairs(__wf_atom_be0bea4a) do
		if v3:IsA(riderType) then
			v2 = v3
		end
	end

	if not __wf_atom_7e8ad928(v2) then
		return v2
	end

	print("Couldn't find attached Rider!")
end

local function fn2(object, p)
	local v2 = fn(object)
	local v3, v4

	if not __wf_atom_7e8ad928(v2) then
		v3 = v2:__wf_atom_1c374cc9(Symbol(throwBoneName))
		v4 = Engine.__wf_atom_2e1382d1(v3, p, throwProjType, true)
	end

	if not (__wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(v4)) then
		local entity = gRegion:CreateEntity(throwProjType, v3, v4, object, object)
		entity:__wf_atom_7c167bd0(object)
		entity:__wf_atom_7ebba814(object)
	end
end

local function fn3(object, p)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if p then
		__wf_atom_7470861b:__wf_atom_e2ff9126(19, v)
		__wf_atom_7470861b:__wf_atom_e2ff9126(16, v)
		__wf_atom_7470861b:__wf_atom_e2ff9126(17, v)
		__wf_atom_7470861b:__wf_atom_e2ff9126(18, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(7, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(0, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(3, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(4, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(5, v)
		object:__wf_atom_994cbb44(2, v)
	else
		__wf_atom_7470861b:__wf_atom_fbf4e632(19, v)
		__wf_atom_7470861b:__wf_atom_fbf4e632(16, v)
		__wf_atom_7470861b:__wf_atom_fbf4e632(17, v)
		__wf_atom_7470861b:__wf_atom_fbf4e632(18, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(7, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(0, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(3, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(4, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(5, v)
		object:__wf_atom_d61b16cd(2, v)
	end
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return 0
	end

	local avatar = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar

	if not (__wf_atom_9a1e4ed3.visible and __wf_atom_9a1e4ed3:__wf_atom_a3309443()) then
		return 0
	end

	local distanceToTarget = __wf_atom_9a1e4ed3.distanceToTarget
	local v2 = avatar:GetPosition() - object2:GetPosition()
	v2.y = 0
	local __wf_atom_a06d543c = object2:__wf_atom_a06d543c()
	__wf_atom_a06d543c.y = 0
	Normalize(v2)
	Normalize(__wf_atom_a06d543c)
	local v3 = math.abs((__wf_atom_d08b2f29(v2, __wf_atom_a06d543c)))

	if
		triggerDistance.minValue <= distanceToTarget
		and distanceToTarget <= triggerDistance.maxValue
		and v3 <= maxForwardAngleToActivate
	then
		object:__wf_atom_f7170fc9(avatar)
		return 1
	end

	return 0
end

local function fn4(object, object2) -- 1 equivalent call inferred from this helper
	local selected

	if __wf_atom_7e8ad928(object2) then
		selected = object:__wf_atom_0e1e5bc9()
	else
		selected = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), object2:__wf_atom_a2a18137())
	end

	selected.pitch = 0
	selected.bank = 0
	return selected
end

function ActivateAbility(_, object, object2, _)
	local v2 = 0
	local v3 = fn(object)
	local v4 = Vector(0, verticalThrowOffset, 0)
	local v5

	if __wf_atom_7e8ad928(object2) then
		v5 = object:GetPosition() + object:__wf_atom_a06d543c() * 10
	else
		v5 = object2:__wf_atom_a2a18137() + v4
	end

	if not __wf_atom_7e8ad928(v3) and gRegion:IsMaster() then
		v3:__wf_atom_cc999c7b(v5)
		local __wf_atom_66088189 = v3:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6():__wf_atom_66088189(1, 0)
		local spearChargeFX = __wf_atom_66088189:Attach(
			spearChargeFxType,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			__wf_atom_66088189,
			1
		)
		_T.spearChargeFX = spearChargeFX
	end

	if gRegion:IsMaster() then
		object:__wf_atom_cc999c7b(v5)
	end

	if not __wf_atom_7e8ad928(throwAnim) then
		fn3(object, true)
		local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(throwAnim, false, 2, 1, true)
		v2 = throwAnim:__wf_atom_091354f5(Symbol(throwAnimEvent)) * __wf_atom_921c1a5f
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	while v2 > 0 do
		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and gRegion:IsMaster() then
			local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

			if not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
				local v6 = fn4(object, __wf_atom_216d6edd) -- inferred equivalent call
				object:__wf_atom_cc999c7b(__wf_atom_216d6edd:__wf_atom_a2a18137())
				object:__wf_atom_51075230(v6)
			end
		end

		Sleep(0)
		v2 -= __wf_atom_084b3e93()

		if not __wf_atom_7e8ad928(object2) then
			v5 = object2:GetPosition() + v4
		end
	end

	if not __wf_atom_7e8ad928(v3) and gRegion:IsMaster() then
		v3:__wf_atom_d2b2176d():Unequip(0, 1)
	end

	Sleep(0.1)
	fn2(object, v5)

	if not __wf_atom_7e8ad928(_T.spearChargeFX) then
		_T.spearChargeFX:Destroy()
	end

	object:__wf_atom_8914dfde(showSpearAnimEvent, 2)

	if not __wf_atom_7e8ad928(v3) and gRegion:IsMaster() then
		v3:__wf_atom_d2b2176d():Equip(5, 0, 2)
	end

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(throwAnim) do
		Sleep(0.1)
	end

	fn3(object, false)
end

function DeactivateAbility(_, p, _, _)
	if not gRegion:IsMaster() then
		return
	end

	local v2 = fn(p)

	if not __wf_atom_7e8ad928(v2) then
		v2:__wf_atom_d2b2176d():Equip(5, 0, 2)
	end
end