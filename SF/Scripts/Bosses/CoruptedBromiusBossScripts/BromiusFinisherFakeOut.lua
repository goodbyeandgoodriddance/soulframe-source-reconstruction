local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.RaycastLib")
local v = WeakResource("/SF/Types/Player/Ghost/SfSparrowGhostAvatar")
local v2 = WeakResource("/SF/Types/Game/SFCloneAvatar")
local v3 = false

function Evaluate(object, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928((object:__wf_atom_30e3d82b())) then
		return false
	end

	if object:__wf_atom_7470861b():__wf_atom_bedb4e3f() or object2.visible and object2:__wf_atom_a3309443() then
		return true
	end

	return false
end

function CheckDistance(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_9a1e4ed3()

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return false
	end

	local avatar = __wf_atom_9a1e4ed3.avatar

	if __wf_atom_9a1e4ed3.visible and __wf_atom_9a1e4ed3:__wf_atom_a3309443() then
		local distanceToTarget = __wf_atom_9a1e4ed3.distanceToTarget

		if
			playerCloseRange.minValue <= distanceToTarget
			and distanceToTarget <= playerCloseRange.maxValue
			and avatar:__wf_atom_a2a18137().y - object:__wf_atom_a2a18137().y <= 2.5
		then
			return true
		end
	end

	return false
end

function GasPlayers(_)
	local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()
	local total = 0
	local v4 = nil
	local coughAnimation2

	if v3 then
		coughAnimation2 = coughAnimation
	else
		coughAnimation2 = coughWalkAnim
	end

	for _, v5 in __wf_atom_a8553251 do
		if not v5:__wf_atom_4417a5d4() or (v5:__wf_atom_7470861b():__wf_atom_bedb4e3f() or v5:IsA(v)) then
			continue
		end

		local __wf_atom_921c1a5f = v5:__wf_atom_921c1a5f(coughAnimation2, false, 4, 1, true)
		v4 = coughAnimation2:__wf_atom_091354f5(Symbol("StartDrunk")) * __wf_atom_921c1a5f
		v5:MotionControl():__wf_atom_99fc7a82(true)
		module.UnequipWeapon(v5, true)
	end

	while total < gasLength do
		for _, v5 in __wf_atom_a8553251 do
			if __wf_atom_7e8ad928(v5) or not v5:__wf_atom_4417a5d4() then
				continue
			end

			if v5:__wf_atom_7470861b():__wf_atom_bedb4e3f() or v5:IsA(v) then
				continue
			end

			if v4 ~= nil and v4 <= total then
				_T.DrunkBias = drunkBias
			end

			if v5:__wf_atom_40a4ba6c() or v5:__wf_atom_611b620c() then
				break
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	_T.DrunkBias = 0

	for _, v5 in __wf_atom_a8553251 do
		if not __wf_atom_7e8ad928(v5) then
			v5:MotionControl():__wf_atom_99fc7a82(false)
		end
	end
end

local function fn(p, __wf_atom_a2a18137) -- 1 equivalent call inferred from this helper
	local v4 = __wf_atom_fa8d0177(p, __wf_atom_a2a18137)
	v4.pitch = 0
	v4.bank = 0
	return v4
end

function TurnToFaceTarget(object, object2)
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	local __wf_atom_a2a18137 = object2:__wf_atom_a2a18137()
	local v4 = fn(object:__wf_atom_a2a18137(), __wf_atom_a2a18137) -- inferred equivalent call
	local v5 = __wf_atom_a2a18137 - object:__wf_atom_a2a18137()
	v5.y = 0
	local v6 = math.abs((__wf_atom_d08b2f29(v5, __wf_atom_a06d543c)))

	while v6 > 5 and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2)) do
		object:Teleport(object:__wf_atom_a2a18137(), v4)
		local v7 = object2:__wf_atom_a2a18137() - object:__wf_atom_a2a18137()
		local __wf_atom_a06d543c2 = object:__wf_atom_a06d543c()
		v6 = math.abs((__wf_atom_d08b2f29(v7, __wf_atom_a06d543c2)))
		Sleep(0)
	end

	object:Teleport(object:__wf_atom_a2a18137(), v4)
end

function Activate(object, instance)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(instance) or not instance:__wf_atom_535d5cbb() or instance:IsA(v) or instance:IsA(v2) then
		local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()
		local v4 = -1e300
		local v5 = nil

		for _, v6 in __wf_atom_a8553251 do
			if v6:IsA(v) or v6:IsA(v2) then
				continue
			end

			local v7 = v6:GetPosition() - object:GetPosition()
			Normalize(v7)
			local v8 = Dot(v7, object:__wf_atom_a06d543c())

			if not (v4 < v8) then
				continue
			end

			v5 = v6
			v4 = v8
		end

		if __wf_atom_7e8ad928(instance) then
			return
		end

		__wf_atom_30e3d82b:__wf_atom_f23858e5(v5)
		instance = v5
	end

	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(object) then
		return
	end

	TurnToFaceTarget(object, instance)
	v3 = CheckDistance(object, __wf_atom_30e3d82b)
	local bromisPounceToFinsiherAnimClose2

	if v3 then
		bromisPounceToFinsiherAnimClose2 = bromisPounceToFinsiherAnimClose
	else
		bromisPounceToFinsiherAnimClose2 = bromisPounceToFinsiherAnimFar
	end

	if not (__wf_atom_7e8ad928(smogVfx) and __wf_atom_7e8ad928(attachBone)) then
		object:Attach(smogVfx, attachBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	if object:__wf_atom_7470861b():__wf_atom_bedb4e3f() then
		object:SetHealth(9)
	end

	module.SetImmunity(object, true)
	module.DeactivateAbilities(false, true)
	module.BlockAbilities(true)
	local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(bromiusIdleFakeOutAnimLoop, false, 4, 1, true)
	object:PlaySound(bromCoughStinger, false, 1, true, nil, 1)
	local v4 = bromiusIdleFakeOutAnimLoop:__wf_atom_091354f5(Symbol("GasPlayer")) * __wf_atom_921c1a5f
	Sleep(0.1)
	local total = 0
	local v5 = false

	while object:__wf_atom_c138b19b(bromiusIdleFakeOutAnimLoop) do
		if not __wf_atom_7e8ad928(instance) then
			object:__wf_atom_5127af76(instance, instance:__wf_atom_a2a18137())
		end

		if v4 <= total and v5 == false then
			object:__wf_atom_8a035cd5(Symbol("GasPlayers"), false)
			v5 = true
		end

		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance) then
		return
	end

	TurnToFaceTarget(object, instance)
	object:__wf_atom_921c1a5f(bromisPounceToFinsiherAnimClose2, false, 4, 1, true)
	Sleep(0.1)

	while object:__wf_atom_c138b19b(bromisPounceToFinsiherAnimClose2) do
		if not __wf_atom_7e8ad928(instance) then
			object:__wf_atom_5127af76(instance, instance:__wf_atom_a2a18137())
		end

		if
			(object:__wf_atom_40a4ba6c() or object:__wf_atom_611b620c())
			and not __wf_atom_7e8ad928((object:__wf_atom_76a59b23()))
		then
			break
		else
			Sleep(0)
		end
	end

	module.BlockAbilities(false)
	module.SetImmunity(object, false)
	Sleep(0.5)
	local __wf_atom_76a59b23 = object:__wf_atom_76a59b23()

	if
		not __wf_atom_7e8ad928(__wf_atom_76a59b23)
		and not __wf_atom_76a59b23:__wf_atom_aea547fa()
		and (object:__wf_atom_40a4ba6c() or object:__wf_atom_611b620c())
	then
		__wf_atom_76a59b23:Teleport((module2.SweepAvatarToGround(
			__wf_atom_76a59b23,
			__wf_atom_76a59b23:__wf_atom_a2a18137(),
			{ __wf_atom_76a59b23, object },
			nil
		)))
	end

	while (object:__wf_atom_40a4ba6c() or object:__wf_atom_611b620c()) and not __wf_atom_7e8ad928(__wf_atom_76a59b23) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_56055f0b()
	end
end

function DeactivateAbility(_, object, _, _)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
		module.BlockAbilities(false)
		module.SetImmunity(object, false)
		__wf_atom_30e3d82b:__wf_atom_56055f0b()
	end
end