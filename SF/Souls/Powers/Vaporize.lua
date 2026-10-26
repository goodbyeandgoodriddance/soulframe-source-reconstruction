local v = Symbol("CloakHDR")
local v2 = Symbol("CloakVector")

function OnEmbed(_, instance)
	Sleep(0)

	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_4ebf67cb) and instance:IsKilled() then
		Vector()
		local __wf_atom_f51f1faa = instance:__wf_atom_f51f1faa()

		if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
			__wf_atom_f51f1faa:SetMaterialParam(v, 8, 3, 0.5, 1)
			__wf_atom_f51f1faa:Attach(deathFx, EMPTY_SYMBOL)
		end

		local total = 0

		while total <= 1 do
			total += __wf_atom_084b3e93()
			local v3 = 1 - (1 - total) / 1

			if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
				__wf_atom_f51f1faa:__wf_atom_a763aa1a(v3)
				local __wf_atom_d0069154 = __wf_atom_f51f1faa:__wf_atom_d0069154()
				__wf_atom_f51f1faa:SetMaterialParam(
					v2,
					__wf_atom_d0069154.x,
					__wf_atom_d0069154.y,
					__wf_atom_d0069154.z,
					1.6
				)
			end

			Sleep(0)
		end
	end
end