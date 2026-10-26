local v = 20
local v2 = 6
local module = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(p, instance)
	local v3 = instance:GetAttribute(0) * 1
	local _ = instance:GetAttribute(1) * 1
	local v4 = instance:GetAttribute(2) * 1

	if p == 1 then
		v = 50 * (1 + v3 / 100)
		v2 = 6 + v4
	elseif p == 2 then
		v = 80 * (1 + v3 / 100)
		v2 = 7 + v4
	else
		v = 100 * (1 + v3 / 100)
		v2 = 12 + v4
	end
end

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

function NpcEvaluateAbility(_, _)
	return 0
end

local function fn2(object)
	if not object:__wf_atom_4417a5d4() or object:__wf_atom_d2b2176d():__wf_atom_9f71ab59(true) then
		return false
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

	if __wf_atom_7e8ad928(__wf_atom_28224c27) or __wf_atom_d2b2176d:__wf_atom_a028fd97(0) ~= 0 then
		return false
	end

	local state = __wf_atom_28224c27:GetState()

	if state ~= 0 and state ~= 15 and state ~= 7 then
		return false
	end

	if __wf_atom_d2b2176d:__wf_atom_8c72e763() == 2 then
		__wf_atom_d2b2176d:__wf_atom_76425737()
	end

	__wf_atom_28224c27:SetBehavior(0)
	__wf_atom_d2b2176d:__wf_atom_d5651846()
	__wf_atom_d2b2176d:__wf_atom_d3dcb68a(true, 0)
	return true
end

function ActivateAbility(object, object2, _, p)
	fn(p, object2)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local v3 = nil

	while not object2:IsKilled() do
		v3 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

		if not __wf_atom_7e8ad928(v3) then
			break
		end

		Sleep(0)
	end

	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	object:__wf_atom_6a4cf64f()
	local __wf_atom_4417a5d4 = object2:__wf_atom_4417a5d4()
	local __wf_atom_e8008ec5 = object:__wf_atom_e8008ec5(mOwner)
	local __wf_atom_cc34a29a = v3:__wf_atom_a07433fe():__wf_atom_cc34a29a()
	local v4 = false
	local v5 = false

	while not (object2:IsKilled() or __wf_atom_7e8ad928(v3)) do
		local v6 = __wf_atom_cc34a29a <= object:__wf_atom_f3044fe0() or module.InfiniteEnergy()

		if v4 ~= v6 then
			module.EnableWeaponSlot(object2, "Idol", v6, 0)
			v4 = v6
		end

		if __wf_atom_4417a5d4 then
			if object:__wf_atom_1177eb5d(__wf_atom_e8008ec5) then
				if not v5 then
					v5 = fn2(object2)

					if v5 then
						object:__wf_atom_244b2bb5()
					end
				end
			elseif v5 then
				__wf_atom_d2b2176d:__wf_atom_d3dcb68a(false, 0)

				if
					(v3:__wf_atom_dedeec57() or v3:__wf_atom_ead6242d())
					and not __wf_atom_d2b2176d:__wf_atom_d155ac2b()
				then
					__wf_atom_d2b2176d:__wf_atom_28cf035c()
				end

				v5 = v3:__wf_atom_dedeec57() or v3:__wf_atom_ead6242d()

				if not v5 then
					object:__wf_atom_6a4cf64f()
				end
			end
		end

		Sleep(0)
	end
end

function DeactivateAbility(object, object2, _, _)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

	if
		not __wf_atom_7e8ad928(__wf_atom_28224c27)
		and (__wf_atom_28224c27:__wf_atom_dedeec57() or __wf_atom_28224c27:__wf_atom_ead6242d())
	then
		__wf_atom_d2b2176d:__wf_atom_d3dcb68a(false, 0)
	end

	module.EnableWeaponSlot(object2, "Idol", false, 0)
	object:__wf_atom_6a4cf64f()
end