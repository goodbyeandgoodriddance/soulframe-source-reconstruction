local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local flag = false
local v = nil

function ExtraInsuranceForTC(object)
	while not __wf_atom_7e8ad928(v) do
		Sleep(0)
	end

	if flag then
		object:__wf_atom_d2b2176d():__wf_atom_84e3e21d(101, 4, 0)
		flag = false
	end
end

function IdolOrbiter(object)
	Sleep(0)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_d2b2176d = __wf_atom_3d96ddcd:__wf_atom_d2b2176d()
	local v2 = nil
	local v3 = 0
	local v4 = 0
	local v5 = false

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		v = object
		__wf_atom_3d96ddcd:__wf_atom_8a035cd5(Symbol("ExtraInsuranceForTC"), false)
	end

	object:__wf_atom_921c1a5f(idleAnimForward, false, true, 1)
	object:__wf_atom_017e8c6b(true)
	__wf_atom_d2b2176d:__wf_atom_f5bb7c84(2, 1)

	while not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(__wf_atom_21ed1a39) or __wf_atom_7e8ad928(object)) do
		local v6 = 0
		local v7 = 0

		if __wf_atom_21ed1a39:__wf_atom_dedeec57() or __wf_atom_21ed1a39:GetState() == 3 then
			if not flag then
				__wf_atom_3d96ddcd:__wf_atom_d2b2176d():__wf_atom_b2e0aa60(101, 4, 0)
				flag = true
			end
		elseif flag then
			__wf_atom_3d96ddcd:__wf_atom_d2b2176d():__wf_atom_84e3e21d(101, 4, 0)
			flag = false
		end

		if __wf_atom_21ed1a39:__wf_atom_dedeec57() or module.IsSoulModeActive(__wf_atom_3d96ddcd) then
			if v4 <= 0 then
				object:__wf_atom_921c1a5f(equipAnim, false, false, 0)
				object:__wf_atom_017e8c6b(false)
				__wf_atom_d2b2176d:__wf_atom_f5bb7c84(2, 0)
				v3 = 0
			end

			v4 = 0.1
			v5 = false
		elseif __wf_atom_21ed1a39:__wf_atom_ead6242d() then
			v4 = 0.5
			v5 = false
		elseif v4 > 0 and not object:__wf_atom_56a6b385(0) then
			v4 -= __wf_atom_084b3e93()

			if v4 <= 0 or not __wf_atom_3d96ddcd:__wf_atom_7b82e9e1(0) then
				object:__wf_atom_921c1a5f(unequipAnim, false, false, 0)
				v5 = true

				if not __wf_atom_7e8ad928(unequipSound) then
					object:PlaySound(unequipSound, false)
				end

				v4 = 0
				v3 = 0
			end
		elseif v5 and not object:__wf_atom_56a6b385(0) then
			object:__wf_atom_017e8c6b(true)
			__wf_atom_d2b2176d:__wf_atom_f5bb7c84(2, 1)
			v5 = false
		end

		if v4 > 0 and not object:__wf_atom_56a6b385(0) then
			local __wf_atom_ed1dbb61 = __wf_atom_3d96ddcd:__wf_atom_ed1dbb61()
			local idleAnimDown2, v8

			if __wf_atom_ed1dbb61 < animPitchForward then
				idleAnimDown2 = idleAnimDown
				v8 = (__wf_atom_ed1dbb61 - animPitchDown) / (animPitchForward - animPitchDown)
			else
				idleAnimDown2 = idleAnimUp
				v8 = (animPitchUp - __wf_atom_ed1dbb61) / (animPitchUp - animPitchForward)
			end

			v3 = math.min(1, v3 + __wf_atom_084b3e93() * 10)
			v6 = __wf_atom_104bfe98(1, __wf_atom_421b01aa(v8, 0, 1), v3)
			v7 = 1 - v6

			if idleAnimDown2 ~= v2 then
				object:__wf_atom_921c1a5f(idleAnimDown2, false, true, 2)
				v2 = idleAnimDown2
			end
		else
			v3 = 0
		end

		object:__wf_atom_c61c1d01(1, v6)

		if v2 then
			object:__wf_atom_c61c1d01(2, v7)
		end

		Sleep(0)
	end

	if flag and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:__wf_atom_d2b2176d():__wf_atom_84e3e21d(101, 4, 0)
		flag = false
	end
end

function IdolFired()
	_T.IdolFired = 1
end