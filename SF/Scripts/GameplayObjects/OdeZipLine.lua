local v = Vector(-0.222271, 2.113232, 0.0291628)
local v2 = Resource("/Lotus/Types/Input/NoMovementInteractionInputFilter")
local v3 = Symbol("EMPTY_SYMBOL")
local v4 = Symbol("Zipline")
local v5 = Symbol("GAME_L1_ARM3")
local v6 = Vector(0, 0.25, 0)
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.NightFoldLib")

local function fn(object, p)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if p then
		__wf_atom_7470861b:__wf_atom_6cbcca8d(v4, 26, 6, 0, 0)
		__wf_atom_7470861b:__wf_atom_77b5f32e(v4)
		__wf_atom_7470861b:__wf_atom_180051f1()
		object:__wf_atom_dd875cd8(true)
		object:__wf_atom_994cbb44(0, v4)
		object:__wf_atom_e3a5b02f(false)
	else
		__wf_atom_7470861b:__wf_atom_a8cf605f(v4)
		__wf_atom_7470861b:__wf_atom_9f17ac89(v4)
		__wf_atom_7470861b:__wf_atom_180051f1()
		object:__wf_atom_dd875cd8(false)
		object:__wf_atom_d61b16cd(0, v4)
		object:__wf_atom_e3a5b02f(true)
	end
end

local function fn2(p, position, p2)
	local v7 = (position + p2) / 2 + v6
	local v8, v9, v10, v11

	if p < 0.5 then
		v8 = p / 0.5
		v9 = v8 * v8
		v10 = (v8 - 1) * v9
		v11 = v7
		v7 = position
	else
		v8 = (p - 0.5) / 0.5
		v9 = v8 * v8
		v10 = ((v8 - 2) * v8 + 1) * v8
		v11 = p2
	end

	local v12 = (2 * v8 - 3) * v9 + 1
	local v13 = (-2 * v8 + 3) * v9
	return v7 * v12 + v11 * v13 + (p2 - position) * v10 * 0.5
end

function AttachToZipline(object, object2)
	if not gRegion:IsMaster() then
		return
	end

	object:Disable()

	if not __wf_atom_7e8ad928(mover) and showMoverOnlyWhenUsing then
		mover:FirePort("Show")
	end

	if not __wf_atom_7e8ad928(mover) then
		mover:FirePort("Beginning")
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
		__wf_atom_e919fb8e.inOdeZipLine = true
	end

	object2:EnableFootIK(false)
	object2:__wf_atom_d5dda77a(false)
	module.UnequipWeapon(object2, true)
	fn(object2, true)

	if not module2.IsNightfoldBlockedById(1) then
		module2.RegisterPreventNighfoldUsage(true, 1)
		module2.SetPreventNightfoldUsageReason(1)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v7 = not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f == object2

	if not __wf_atom_7e8ad928(pushTrigger) then
		pushTrigger:FirePort("Enable")
	end

	local v8 = 0
	local v9 = v
	local __wf_atom_c082fc3d = attachPoint:__wf_atom_c082fc3d()
	attachPoint:__wf_atom_dc309f8a()
	local __wf_atom_dc309f8a = object2:__wf_atom_dc309f8a()
	local position = object2:GetPosition()
	local __wf_atom_d9cb4b97 = object2:MotionControl():__wf_atom_d9cb4b97()
	local __wf_atom_dc309f8a2 = attachPoint:__wf_atom_dc309f8a()
	local v10 = attachPoint:GetPosition() - __wf_atom_9341614d(
		__wf_atom_9341614d(v9 - attachPointOffset, __wf_atom_dc309f8a),
		__wf_atom_dc309f8a2
	)

	if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(animEnter)) then
		object2:__wf_atom_921c1a5f(animEnter, false, 3, 1, false, 1)
	end

	while v8 < 0.4 do
		if not __wf_atom_7e8ad928(object2) then
			object2:Teleport(
				fn2(__wf_atom_24a82b69(v8 / 0.4), position, v10),
				(__wf_atom_9d2f097a(__wf_atom_d9cb4b97, __wf_atom_dc309f8a2, (math.sqrt(v8 / 0.4))))
			)
		end

		v8 = __wf_atom_421b01aa(v8 + __wf_atom_084b3e93(), 0, 1)
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_e310f01f(
			__wf_atom_9341614d(v9 - attachPointOffset, __wf_atom_dc309f8a) * -1 / __wf_atom_c082fc3d,
			__wf_atom_80368bb1
		)
		object2:__wf_atom_dc5956fc(attachPoint, v3)

		if not __wf_atom_7e8ad928(ziplineLatchSound) then
			object2:PlaySound(ziplineLatchSound, false, 1, true)
		end
	end

	Sleep(0.05)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

	if v7 then
		__wf_atom_8ad59546.postProcess:__wf_atom_54a04966(3)
		__wf_atom_8ad59546.postProcess:__wf_atom_f846a58a(2)
	end

	if not __wf_atom_7e8ad928(mover) then
		mover:FirePort("Start")
	end

	if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(animLoop)) then
		object2:__wf_atom_921c1a5f(animLoop, false, 3, 2, true, 1)
	end

	local __wf_atom_f1963b04 = mover:__wf_atom_f1963b04()
	local total = 0

	while mover:__wf_atom_97217c99() and total < __wf_atom_f1963b04 do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:EnableFootIK(true)
		object2:__wf_atom_d5dda77a(true)
		object2:__wf_atom_e6ed03c8()
	end

	if v7 then
		__wf_atom_8ad59546.postProcess:__wf_atom_54a04966(0)
		__wf_atom_8ad59546.postProcess:__wf_atom_f846a58a(1)
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_cf966a74(v2)
		fn(object2, false)
		module2.RegisterPreventNighfoldUsage(false, 1)
		module2.SetPreventNightfoldUsageReason(1)

		if pushPlayer then
			local v11 = __wf_atom_9341614d(
				object2:__wf_atom_a06d543c() * pushForce,
				Rotation(0, __wf_atom_421b01aa(0, pushAngle, 90), 0)
			)

			if pushDebug then
				gRegion:__wf_atom_628723a6(object2:GetPosition(), object2:GetPosition() + v11, Color(0, 255, 0), 10)
			end

			object2:MotionControl():__wf_atom_4bb21efc(v11)
		end

		if not __wf_atom_7e8ad928(animExit) then
			object2:PlaySound(ziplineEndSound, false, 1, true)
			object2:__wf_atom_921c1a5f(animExit, true, 2, 1, true, 1)
		end

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
			__wf_atom_e919fb8e.inOdeZipLine = false
		end
	end

	if not __wf_atom_7e8ad928(mover) then
		mover:FirePort("Beginning")
	end

	if not __wf_atom_7e8ad928(pushTrigger) then
		Sleep(0.05)
	end

	if not __wf_atom_7e8ad928(mover) and showMoverOnlyWhenUsing then
		mover:FirePort("Hide")
	end

	if not __wf_atom_7e8ad928(pushTrigger) then
		pushTrigger:FirePort("Disable")
	end

	if not usedOnlyOnce then
		object:Enable()
	end
end

function DebugArm(_, object)
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(v5)
	gRegion:__wf_atom_5b35a0c8(__wf_atom_1c374cc9, Color(0, 255, 0), "arm", 1, 10)
end