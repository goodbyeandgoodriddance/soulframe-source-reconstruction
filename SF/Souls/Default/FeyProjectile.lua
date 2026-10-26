local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Effects.IdolEffects")

function EvaluateAbility(_, _)
	return true
end

function NpcEvaluateAbility(_, _)
	return 0
end

local function fn(object) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local state = object:GetState()
	return state == 0 or state == 15 or state == 7 or state == 11
end

function ActivateAbility(object, object2, _, _)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	mOwner:__wf_atom_a7328d06(ScriptCooldown)
	__wf_atom_d2b2176d:__wf_atom_ec33d862(0)
	module.SetForceAim(object2, mOwner, true)
	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

	while __wf_atom_7e8ad928(__wf_atom_28224c27) do
		Sleep(0)
		__wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)
	end

	while not __wf_atom_7e8ad928(__wf_atom_28224c27) do
		if fn(__wf_atom_28224c27) then -- inferred equivalent call
			break
		else
			Sleep(0)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
		for i = 1, __wf_atom_28224c27:__wf_atom_ca3e110b() - 1 do
			local __wf_atom_3d08948b = __wf_atom_28224c27:__wf_atom_3d08948b(i)

			if __wf_atom_7e8ad928(__wf_atom_3d08948b) or __wf_atom_3d08948b.projectileType ~= arrowType then
				continue
			end

			__wf_atom_28224c27:SetBehavior(i)
			break
		end
	end

	object2:__wf_atom_8a035cd5(Symbol("VirtueSwap"), false)

	if object2:__wf_atom_4417a5d4() then
		if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
			return
		end

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			__wf_atom_d2b2176d:__wf_atom_d3dcb68a(true, 0)
		end

		local __wf_atom_e8008ec5 = object:__wf_atom_e8008ec5(mOwner)
		object2:__wf_atom_d2b2176d():__wf_atom_b2e0aa60(271, 3, 1.05)
		local v = true

		while
			not __wf_atom_7e8ad928(__wf_atom_28224c27)
			and not __wf_atom_7e8ad928(object)
			and (object:__wf_atom_1177eb5d(__wf_atom_e8008ec5) or v)
		do
			Sleep(0)
			local __wf_atom_083a9e64 = __wf_atom_28224c27:__wf_atom_083a9e64()

			if not __wf_atom_083a9e64:IsA(__wf_atom_6a70dd22) then
				continue
			end

			v = __wf_atom_083a9e64:__wf_atom_a1fbf9e8()

			if mOwner:__wf_atom_5ddc32c4() == 0 then
				__wf_atom_083a9e64:__wf_atom_f09a0d43(0)
			end
		end

		object:DeactivateAbility(mOwner:__wf_atom_1bb5b1ff())
	else
		while true do
			Sleep(100)
		end
	end
end

function DeactivateAbility(_, object, _, _)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

	if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
		if object:__wf_atom_4417a5d4() then
			local __wf_atom_083a9e64 = __wf_atom_28224c27:__wf_atom_083a9e64()
			local __wf_atom_a07433fe = __wf_atom_28224c27:__wf_atom_a07433fe()

			if __wf_atom_083a9e64:__wf_atom_ff307e63() and __wf_atom_a07433fe:__wf_atom_1cda18ff() == arrowType then
				mOwner:__wf_atom_d14eed1a()
			end

			__wf_atom_d2b2176d:__wf_atom_d3dcb68a(false, 0)
		end

		repeat
			Sleep(0)
		until
			__wf_atom_7e8ad928(__wf_atom_28224c27)
			or __wf_atom_28224c27:GetState() ~= 1 and __wf_atom_28224c27:GetState() ~= 7

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			__wf_atom_28224c27:SetBehavior(0)
		end
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if object:__wf_atom_4417a5d4() then
		object:__wf_atom_d2b2176d():__wf_atom_84e3e21d(271, 3, 1.05)
	end

	module.EnableWeaponSlot(object, "", true, 0)
	module.SetForceAim(object, mOwner, false)
end

function VirtueSwap(p)
	module2.FeyVirtueSwap(p, 0.75)
end