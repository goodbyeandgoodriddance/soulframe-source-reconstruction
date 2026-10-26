local v = WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")
local v2 = WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade")

function MatchAttackEvent(object, _, _)
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return false
	end

	local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)
	local __wf_atom_3371f607 = object:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) or not __wf_atom_3371f607:IsA(__wf_atom_2fc5c2e8) then
		return false
	end

	if
		__wf_atom_3371f607 ~= playerAvatar:__wf_atom_d2b2176d():__wf_atom_28224c27(5)
		and __wf_atom_3371f607 ~= playerAvatar:__wf_atom_d2b2176d():__wf_atom_28224c27(1)
	then
		return false
	end

	for i = 0, __wf_atom_3371f607:__wf_atom_06f3cb74() - 1 do
		local __wf_atom_b9a1f18c = __wf_atom_3371f607:__wf_atom_b9a1f18c(i)

		if #upgradeType == 0 then
			if __wf_atom_b9a1f18c:IsA(v) or __wf_atom_b9a1f18c:IsA(v2) then
				return true
			end
		else
			for _, className in ipairs(upgradeType) do
				if __wf_atom_b9a1f18c:IsA(className) then
					return true
				end
			end
		end
	end
end