local v = WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade")
local v2 = WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")
local v3 = WeakResource("/SF/Upgrades/Skins/Totem/TotemBaseItem")

function MatchTagEvent(_, _, _, _)
	if __wf_atom_7e8ad928(gGameData) then
		return false
	end

	local inventory = gGameData:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		return false
	end

	if matchMotes then
		local v4 = inventory:__wf_atom_4259c789() or {}
		local v5 = inventory:__wf_atom_4f67b86c() or {}
		table.move(v5, 1, #v5, #v4 + 1, v4)

		for i = 1, #v4 do
			local __wf_atom_43563387 = inventory:__wf_atom_43563387(v4[i], 0)

			for _, v6 in __wf_atom_43563387 do
				if __wf_atom_7e8ad928(v6.mItemType) then
					continue
				end

				if #motes == 0 then
					if v6.mItemType:IsA(v) or v6.mItemType:IsA(v2) then
						return true
					end
				else
					for _, className in ipairs(motes) do
						if v6.mItemType:IsA(className) then
							return true
						end
					end
				end
			end
		end
	end

	if not (matchTalismans or matchSkins) then
		return false
	end

	local playerAvatar = gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)

	if __wf_atom_7e8ad928(playerAvatar) then
		return false
	end

	local __wf_atom_e55d02aa = playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return false
	end

	local __wf_atom_eb82ab1f = __wf_atom_e55d02aa:__wf_atom_eb82ab1f()

	if matchTalismans then
		local __wf_atom_d78fd481 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(5)

		if __wf_atom_d78fd481 == nil then
			__wf_atom_d78fd481 = __wf_atom_eb82ab1f:__wf_atom_035fdfa8(5)
		end

		if __wf_atom_d78fd481.mItemType ~= nil and __wf_atom_d78fd481.mItemType:IsA(v3) then
			return true
		end
	end

	if not matchSkins then
		return false
	end

	for _, v4 in ipairs({ 4, 6, 0, 2, 3, 5 }) do
		local __wf_atom_d78fd481 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(v4)

		for _, className in ipairs(skins) do
			if __wf_atom_d78fd481.mItemType:IsA(className) then
				return true
			end
		end
	end

	return false
end