local module = require("EE.Interface.Utilities")

function GetEmptyDescriptionInfo(_, _, _, _, _)
	return ""
end

function GetDescriptionInfo(p, _, object, p2, p3)
	if p2 == "" then
		p2 = object:__wf_atom_254ac1f5(p - 1)
	end

	local __wf_atom_6ac4d478 = object:__wf_atom_6ac4d478(p2)
	local __wf_atom_505b3c0es = {}

	for i = p3, #__wf_atom_6ac4d478 do
		local v = __wf_atom_6ac4d478[i]
		local __wf_atom_505b3c0e = v:__wf_atom_505b3c0e()
		local v2 = i - (p3 - 1)

		if v:__wf_atom_62831604() == 2 and multiplyDown[v2] then
			__wf_atom_505b3c0e = 1 - __wf_atom_505b3c0e
		end

		if absoluteValue[v2] == true then
			__wf_atom_505b3c0e = math.abs(__wf_atom_505b3c0e)
		end

		local v3 = __wf_atom_505b3c0e >= 0

		if displayAsPercent[v2] == true then
			__wf_atom_505b3c0e = module.FormatNumber(__wf_atom_505b3c0e * 100, maxDecimals[v2], false)
		elseif maxDecimals[v2] ~= nil and maxDecimals[v2] >= 0 then
			__wf_atom_505b3c0e = module.FormatNumber(__wf_atom_505b3c0e, maxDecimals[v2], false)
		end

		if addPlusses[v2] == true and v3 then
			__wf_atom_505b3c0e = "+" .. __wf_atom_505b3c0e
		end

		__wf_atom_505b3c0es["STAT" .. v2] = __wf_atom_505b3c0e
	end

	if _T.ModSetDescription ~= nil then
		__wf_atom_505b3c0es.EQUIPPED = _T.ModSetDescription.Equipped
		__wf_atom_505b3c0es.MAX = _T.ModSetDescription.Max
	end

	return cjson.encode(__wf_atom_505b3c0es)
end