function ShowTaggedEntities(p)
	local typeName = type(p)
	local cmdShowTaggedEntities = (typeName ~= "string" and typeName ~= "number" and typeName ~= "bool" or tostring(p) == "")
		and Symbol()
		or Symbol((tostring(p)))

	if cmdShowTaggedEntities == _T.CmdShowTaggedEntities then
		_T.CmdShowTaggedEntities = nil
	else
		_T.CmdShowTaggedEntities = nil
		Sleep(0)
		_T.CmdShowTaggedEntities = cmdShowTaggedEntities

		if cmdShowTaggedEntities == EMPTY_SYMBOL then
			__wf_atom_f2daf912("Showing all entities with tags, FYI this kills performance")
		else
			__wf_atom_f2daf912("Showing entities with tag \"" .. tostring(cmdShowTaggedEntities) .. "\"")
		end
	end

	while _T.CmdShowTaggedEntities ~= nil do
		local v

		if _T.CmdShowTaggedEntities == EMPTY_SYMBOL then
			v = gRegion:FindAll(__wf_atom_7e616794)
		else
			v = gRegion:__wf_atom_2226b35c(_T.CmdShowTaggedEntities)
		end

		for i = 1, #v do
			local v2 = v[i]

			if
				__wf_atom_7e8ad928(v2)
				or v2:IsA(__wf_atom_092a10b5)
				or not v2:__wf_atom_db682341():__wf_atom_8598f3a9()
			then
				continue
			end

			local position = v[i]:GetPosition()
			gRegion:__wf_atom_5b35a0c8(position, Color(255, 255, 255, 255), v2:__wf_atom_db682341():c_str(), 1, 0.2)
			gRegion:__wf_atom_8d991675(position, 0.0125, Color(255, 255, 255, 255), 0.2)
		end

		Sleep(0.2)
	end
end