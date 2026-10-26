function GetCount(object)
	local __wf_atom_af937b39 = object:__wf_atom_af937b39()

	if __wf_atom_7e8ad928(__wf_atom_af937b39) or __wf_atom_7e8ad928((__wf_atom_af937b39:__wf_atom_9be88b01())) then
		return 0
	end

	local total = 0

	for _, mRecipe in __wf_atom_af937b39:__wf_atom_af5caba7().mRecipes do
		if mRecipe.type == nil then
			continue
		end

		for _, v in recipeTypes do
			if mRecipe.type ~= v then
				continue
			end

			total += mRecipe.timesCooked
			break
		end
	end

	return total
end

function MatchTagEvent(p, _)
	local v = GetCount(p)
	print(`[CheckRecipeTypesCooked User has {v} cooked count (when needed {countToPass})`)

	if countToPass <= v then
		print("[CheckRecipeTypesCooked] Queueing _T.PendingChallengeUpload")
		_T.PendingChallengeUpload = true
		return true
	else
		return false
	end
end