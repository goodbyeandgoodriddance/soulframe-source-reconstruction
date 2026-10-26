local module = require("SF.Scripts.Effects.MaterialEffects")

function SplineUpdate(p)
	module.SplineUpdate(p, points, 0.3, 3, 2)
end

function AvatarMeshSplineWarp(instance)
	local __wf_atom_575542c8 = instance:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		instance:Destroy()
		return
	end

	if __wf_atom_7e8ad928(childDecoType) then
		return
	end

	local __wf_atom_be0bea4a = __wf_atom_575542c8:__wf_atom_be0bea4a()

	for _, v in ipairs(__wf_atom_be0bea4a) do
		if __wf_atom_7e8ad928(v) or not v:IsA(__wf_atom_8d0b7f88) then
			continue
		end

		local __wf_atom_b6b760b5 = v:__wf_atom_b6b760b5()

		if __wf_atom_7e8ad928(__wf_atom_b6b760b5) or not string.find(__wf_atom_b6b760b5:GetName(), "_skel") then
			continue
		end

		local v2 = instance:Attach(childDecoType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		v2:__wf_atom_45cf0e1a(__wf_atom_b6b760b5, false, true)
		v2:__wf_atom_8a035cd5(Symbol("SplineUpdate"), false)
	end

	local __wf_atom_b6b760b5 = __wf_atom_575542c8:__wf_atom_b6b760b5()

	if not (__wf_atom_7e8ad928(__wf_atom_b6b760b5) or __wf_atom_7e8ad928(instance)) then
		instance:__wf_atom_45cf0e1a(__wf_atom_b6b760b5, false, true)
		instance:__wf_atom_8a035cd5(Symbol("SplineUpdate"), false)
		module.SplineUpdate(instance, points, 0.3, 3, 2)
	end
end