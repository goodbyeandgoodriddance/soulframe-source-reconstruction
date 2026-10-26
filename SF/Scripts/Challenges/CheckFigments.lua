local v = WeakResource("/SF/Types/Items/ColorPickerItem")

function GetCount(_)
	local inventory = gGameData:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		return 0
	end

	local count = 0
	local __wf_atom_da43e3f3 = inventory:__wf_atom_da43e3f3()

	if __wf_atom_7e8ad928(__wf_atom_da43e3f3) then
		return count
	end

	for _, v2 in __wf_atom_da43e3f3 do
		if __wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(v2.mItemType) or not v2.mItemType:IsA(v) then
			continue
		end

		count += 1
	end

	return count
end

function MatchTagEvent(p, _)
	print("[CheckFigments] start")
	local v2 = GetCount(p)
	print(`[CheckFigments] User has {v2} figments count (when needed {countToPass})`)

	if countToPass <= v2 then
		print("[CheckFigments] Queueing _T.PendingChallengeUpload")
		_T.PendingChallengeUpload = true
		return true
	else
		return false
	end
end