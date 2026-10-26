local module = require("SF.Scripts.Libs.RaycastLib")

function Evaluate(object, _)
	local v

	if not __wf_atom_7e8ad928(object) then
		v = object:__wf_atom_6115a2e2()

		if __wf_atom_7e8ad928(v) then
			v = gRegion:__wf_atom_c4f78a8f()
		end
	end

	return not (__wf_atom_7e8ad928(v) or not v:__wf_atom_2b992e2b())
end

function Activate(object, _)
	local v

	if not __wf_atom_7e8ad928(object) then
		v = object:__wf_atom_6115a2e2()

		if __wf_atom_7e8ad928(v) then
			v = gRegion:__wf_atom_c4f78a8f()
		end
	end

	if __wf_atom_7e8ad928(v) then
		return false
	end

	local position = v:GetPosition()
	local __wf_atom_a06d543c = v:__wf_atom_a06d543c()
	local v2 = position + __wf_atom_9341614d(__wf_atom_a06d543c, sittingPositionRotationOffsetFromPlayer) * sittingPositionDistanceFromPlayer
	local sweepAvatarToGround = module.SweepAvatarToGround(object, v2, nil, { __wf_atom_67c46eba })
	local v3 = false
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return false
	end

	local movementTimeoutDuration = movementTimeoutDuration

	while movementTimeoutDuration > 0 and not __wf_atom_7e8ad928(object) do
		if __wf_atom_7e8ad928(v) or not v:__wf_atom_2b992e2b() then
			return false
		end

		if v:__wf_atom_a06d543c() ~= __wf_atom_a06d543c then
			__wf_atom_a06d543c = v:__wf_atom_a06d543c()
			local v4 = position + __wf_atom_9341614d(__wf_atom_a06d543c, sittingPositionRotationOffsetFromPlayer) * sittingPositionDistanceFromPlayer
			sweepAvatarToGround = module.SweepAvatarToGround(object, v4, nil, { __wf_atom_67c46eba })
		end

		__wf_atom_30e3d82b:StartMoving(sweepAvatarToGround, moveStyle, false, 1, stopDistance, false)
		movementTimeoutDuration -= __wf_atom_084b3e93()

		if object:__wf_atom_c215662d(sweepAvatarToGround) <= stopDistance * stopDistance then
			v3 = true
			break
		else
			Sleep(0)
		end
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	if not v3 then
		object:Teleport(sweepAvatarToGround, __wf_atom_fa8d0177(sweepAvatarToGround, position))
	end

	object:__wf_atom_921c1a5f(pupIdleLoopAnim, false, 3, 2)
	local v4 = Time()

	while not __wf_atom_7e8ad928(v) and v:__wf_atom_2b992e2b() and not __wf_atom_7e8ad928(object) do
		if v:__wf_atom_a463b19e() == 7 then
			if not object:__wf_atom_c138b19b(pupExcitedLoopAnim) then
				v4 = Time()

				if object:__wf_atom_c138b19b(pupBoredLoopAnim, true) then
					object:__wf_atom_921c1a5f(pupSitToStand, true, 3, 1)
				end

				object:__wf_atom_921c1a5f(pupExcitedLoopAnim, false, 3, 2)
			end
		elseif Time() - v4 > gettingBoredTime then
			if not object:__wf_atom_c138b19b(pupBoredLoopAnim) then
				object:__wf_atom_921c1a5f(pupSitToLay, true, 3, 1)
				object:__wf_atom_921c1a5f(pupBoredLoopAnim, false, 3, 2)
			end
		elseif v:__wf_atom_a463b19e() < 6 and not object:__wf_atom_c138b19b(pupIdleLoopAnim) then
			object:__wf_atom_921c1a5f(pupIdleLoopAnim, false, 3, 2)
		end

		Sleep(0.5)
	end
end

function Deactivate(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
	end

	if object:__wf_atom_c138b19b(pupBoredLoopAnim, true) then
		object:__wf_atom_921c1a5f(pupSitToStand, false, 3, 1)
	else
		object:__wf_atom_921c1a5f(nil, false, 3, 1, false)
	end
end