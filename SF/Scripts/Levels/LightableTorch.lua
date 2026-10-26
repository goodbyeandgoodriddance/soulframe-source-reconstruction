local v = WeakResource("/SF/Types/Game/SFEffectDecoration")
local v2 = WeakResource("/EE/Types/Engine/Sequencer")

local function fn(object, p)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(v)

	for _, v3 in ipairs(__wf_atom_f582136d) do
		if p then
			v3:SetVisibility(true)
		else
			v3:SetVisibility(false)
		end
	end

	local __wf_atom_f582136d2 = object:__wf_atom_f582136d(v2)

	for _, v3 in ipairs(__wf_atom_f582136d2) do
		if p then
			v3:Enable()
		else
			v3:Disable()
		end
	end

	if p then
		for _, v3 in ipairs(removeTypes) do
			local __wf_atom_f582136d3 = object:__wf_atom_f582136d(v3)

			for _, v4 in ipairs(__wf_atom_f582136d3) do
				v4:Destroy()
			end
		end
	end
end

function LightTorch(object, _)
	fn(object:__wf_atom_3d96ddcd(), true)
end