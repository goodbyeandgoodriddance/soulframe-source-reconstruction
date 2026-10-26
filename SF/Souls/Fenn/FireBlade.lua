local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

function NpcEvaluateAbility(_, _)
	return 0
end

local function fn(object)
	if not object:__wf_atom_4417a5d4() then
		return false
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

	if __wf_atom_d2b2176d:__wf_atom_8c72e763() == 2 then
		__wf_atom_d2b2176d:__wf_atom_76425737()
	end

	__wf_atom_28224c27:__wf_atom_01e1d257(19)
	return true
end

function ActivateAbility(object, object2, _, _)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local v = nil

	while not object2:IsKilled() do
		v = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

		if not __wf_atom_7e8ad928(v) then
			break
		end

		Sleep(0)
	end

	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	local __wf_atom_4417a5d4 = object2:__wf_atom_4417a5d4()
	object2:__wf_atom_92aa9d91():SetForceAim(true)
	local __wf_atom_e8008ec5 = object:__wf_atom_e8008ec5(mOwner)
	local v2 = mOwner:__wf_atom_cb2fe64e() * 0.25
	local v3 = 0
	local v4 = true
	local flag = false

	while not (__wf_atom_7e8ad928(object2) or object2:IsKilled() or __wf_atom_7e8ad928(v)) do
		if v3 > 0 then
			v3 -= __wf_atom_084b3e93()
		end

		local v5 = false

		if __wf_atom_4417a5d4 then
			local __wf_atom_1177eb5d = object:__wf_atom_1177eb5d(__wf_atom_e8008ec5)
			v3 = not v4 and __wf_atom_1177eb5d and 0.5 or v3
			local __wf_atom_75a0566d = v:__wf_atom_75a0566d()
			local v6

			if
				__wf_atom_7e8ad928(__wf_atom_75a0566d)
				or __wf_atom_75a0566d:__wf_atom_d6411cd7()
				or v:__wf_atom_0bde361f()
			then
				v6 = false
			else
				v6 = not v:__wf_atom_85821ed3()
			end

			if v6 then
				if flag then
					if v3 > 0 and (v2 <= object:__wf_atom_f3044fe0() or module.InfiniteEnergy()) then
						v5 = fn(object2)

						if v5 then
							object:__wf_atom_19516b62(-v2)
							v3 = 0
						end
					end
				else
					v5 = fn(object2)

					if v5 then
						v3 = 0
						flag = true
					end
				end
			end

			if v5 or v:__wf_atom_9f71ab59() then
				v4 = __wf_atom_1177eb5d
			else
				break
			end
		end

		Sleep(0)
	end
end

function DeactivateAbility(object, object2, _, _)
	if not __wf_atom_7e8ad928(object2) then
		object2:PlaySound(deactivateAbilitySound, false, 1, false)
		local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
		object2:__wf_atom_92aa9d91():SetForceAim(false)
		__wf_atom_d2b2176d:__wf_atom_d5651846()
		object:__wf_atom_6a4cf64f()
	end
end

function EquippFx(object, _)
	if not __wf_atom_7e8ad928((object:__wf_atom_f7e7be53())) and Random(0, 1) > 0.9 then
		module2.TransmissionPlaying()
	end
end