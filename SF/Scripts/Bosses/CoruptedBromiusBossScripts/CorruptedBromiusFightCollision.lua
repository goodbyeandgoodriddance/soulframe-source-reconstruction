local v = Symbol("BromiusLegCollisionProxy")
local v2 = Symbol("BromiusHeadCollisionProxy")
local v3 = Symbol("BromiusBodyCollisionProxy")

function DisableCollision(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if
		__wf_atom_7e8ad928(__wf_atom_50a7d83e)
		or __wf_atom_50a7d83e:IsKilled()
		or __wf_atom_50a7d83e:__wf_atom_bedb4e3f()
	then
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v)

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		for _, v4 in ipairs(__wf_atom_2226b35c) do
			v4:FirePort("Hide")
		end
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v2)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("Hide")
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v3)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:FirePort("Hide")
	end

	Sleep(disableCollisionDuration)

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		for _, v4 in ipairs(__wf_atom_2226b35c) do
			if not __wf_atom_7e8ad928(v4) then
				v4:FirePort("Show")
			end
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("Show")
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:FirePort("Show")
	end
end