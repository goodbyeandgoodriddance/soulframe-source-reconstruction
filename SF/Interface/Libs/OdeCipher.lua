module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")

function OdeCipher(p, p2, value)
	if p == nil or p2 == nil then
		return ""
	end

	if p2 <= 0 then
		return p
	end

	local v = __wf_atom_7aaffd4b(p)
	local count = #v
	local v2 = math.floor(p2 * count + 0.5)
	local v3 = {}

	for i = 1, count do
		if v2 > 0 then
			v3[i] = true
			v2 -= 1
		else
			v3[i] = false
		end
	end

	local v4 = __wf_atom_04d7eaaa()
	local v5 = __wf_atom_63c7031a(value)
	__wf_atom_01bfe5c4(v5)
	local seededShuffleTable = module.SeededShuffleTable(v3)
	__wf_atom_01bfe5c4(v4)
	local v6 = "<p>"
	local v7 = nil
	local v8 = string.find(value, "/[^/]*$")

	if v8 ~= nil then
		value = string.sub(value, v8 + 1)
	end

	local v9 = string.len(value)

	for i = 1, count do
		local v10 = seededShuffleTable[i] and "OdeBook" or "Spectral SC Regular"

		if v10 ~= v7 then
			if v7 then
				v6 ..= "</font>"
			end

			v6 ..= "<font face=\"" .. v10 .. "\">"
			v7 = v10
		end

		local v11 = v[i]

		if seededShuffleTable[i] and string.byte(v11, 1) > 127 then
			local v12 = (i - 1) % v9 + 1
			v6 ..= string.sub(value, v12, v12)
		else
			v6 ..= v11
		end
	end

	return v6 .. "</font></p>"
end

function FragmentCipher(object)
	if __wf_atom_7e8ad928(object) then
		return ""
	end

	local v = 1
	local v2 = 0
	local envoyInventoryControl = module2.GetEnvoyInventoryControl()

	if object:__wf_atom_7188fa33() then
		v = 1
		v2 = 1
	elseif not __wf_atom_7e8ad928(envoyInventoryControl) then
		v = object:__wf_atom_3563f9c2()
		v2 = math.min(envoyInventoryControl:__wf_atom_96a19f31(object), v)
	end

	local v3 = not (v > 0) and 0 or 1 - v2 / v
	local c_str = object:__wf_atom_014a76a2():c_str()
	local v4 = Localize(c_str, nil)
	return OdeCipher(v4, v3, c_str)
end

function ConvertDateToGame(p, p2, p3, p4)
	local v = Localize("/SF/Language/Codex/DayIndex" .. p2, {})

	if v == "" then
		v = p2
	end

	return p, v, Localize("/SF/Language/Codex/MonthIndex" .. p3, {}), tonumber(p4 + 2000) - 1100
end