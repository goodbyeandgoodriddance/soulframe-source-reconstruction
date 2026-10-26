function Callback(p, p2)
	if not p then
		__wf_atom_f2daf912(p2)
	end
end

function CmdQuest(...)
	local v = { ... }

	if #v < 1 then
		__wf_atom_f2daf912("Must supply a quest")
		return
	end

	local v2 = v[1]
	local v3 = WeakResource(v2)

	if __wf_atom_7e8ad928(v3) then
		v3 = WeakResource("/SF/Types/Quests/" .. v2)
	end

	if __wf_atom_7e8ad928(v3) and not __wf_atom_7e8ad928(storeManifest) then
		local __wf_atom_caa82b8d = Resource(storeManifest):__wf_atom_caa82b8d(__wf_atom_cce305dd)

		for _, v4 in ipairs(__wf_atom_caa82b8d) do
			local item = v4:GetItem()

			if __wf_atom_7e8ad928(item) or not (item:GetName() == v2 or item:__wf_atom_5b41f63b() == v2) then
				continue
			end

			v3 = item
			break
		end
	end

	if __wf_atom_7e8ad928(v3) then
		__wf_atom_f2daf912("Invalid quest")
		return
	end

	local questController = gGameRules:GetQuestController()
	local v4 = not (#v > 1) and "start" or v[2]

	if v4 == "start" then
		questController:StartQuest(v3, true, Callback)
	elseif v4 == "advance" then
		questController:CompleteCurrentTask(v3, Callback)
	else
		__wf_atom_f2daf912("Invalid command, must be one of: start/advance")
	end
end