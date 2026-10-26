local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = __wf_atom_10cd16b2(0, 0.2)

function OnAvatarSpawn(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:SetVisibility(false)
	local taggedChildren = module.FindTaggedChildren(object:__wf_atom_be0bea4a(), Symbol("SpiritDeco"))

	if #taggedChildren > 0 then
		for _, v2 in ipairs(taggedChildren) do
			local __wf_atom_be0bea4a = v2:__wf_atom_be0bea4a()

			for i = 1, #__wf_atom_be0bea4a do
				if __wf_atom_7e8ad928(__wf_atom_be0bea4a[i]) or not __wf_atom_be0bea4a[i]:IsA(__wf_atom_3ae8d73b) then
					continue
				end

				__wf_atom_be0bea4a[i]:PlayTriggeredFade()
			end

			v2:SetVisibility(true)
		end
	end

	Sleep(0.1)
	object:SetVisibility(true)
	object:__wf_atom_78ad8b9f(128, 0)
	object:__wf_atom_8a035cd5(Symbol("AdjustAvatarBendToTarget"), false)
end

function AdjustAvatarBendToTarget(object)
	Sleep(0)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	local v2 = nil

	while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
		local v3 = 0

		if not object:__wf_atom_bedb4e3f() then
			v2 = __wf_atom_30e3d82b:__wf_atom_216d6edd()
		end

		if not __wf_atom_7e8ad928(v2) then
			local v4 = v2:EyePosition() - object:EyePosition()
			Normalize(v4)
			local v5 = -math.deg((math.atan(v4.y)))
			v3 = __wf_atom_421b01aa(v5, minAngle, maxAngle)
		end

		local v4 = v:__wf_atom_2490589b(v3, object:__wf_atom_5439d809() * __wf_atom_084b3e93()) / 3
		local v5 = Rotation(v4, 0, 0)
		object:__wf_atom_e3c998ce(Symbol("GAME_C1_SPINE2"), v5, __wf_atom_28d5d4aa)
		object:__wf_atom_e3c998ce(Symbol("GAME_C1_SPINE3"), v5, __wf_atom_28d5d4aa)
		object:__wf_atom_e3c998ce(Symbol("GAME_C1_SPINE4"), v5, __wf_atom_28d5d4aa)
		object:__wf_atom_e3c998ce(Symbol("GAME_L1_CLAV1"), v5, __wf_atom_28d5d4aa)
		object:__wf_atom_e3c998ce(Symbol("GAME_R1_CLAV1"), v5, __wf_atom_28d5d4aa)
		Sleep(0)
	end
end