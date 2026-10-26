module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local v = nil
local v2 = nil
local v3 = 1
local v4 = 0
local v5 = 1
local v6 = nil
local v7 = nil
local rounded = nil
local rounded2 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = 0
local v13 = 0
local v14 = true
local v15 = nil
local v16 = nil

local function fn()
	if v2 ~= nil then
		local v17 = string.sub(v2, 0, v3)
		local v18 = string.sub(v2, v3 + 1)
		v:__wf_atom_50d60589("Tip.InputFeedbackLeft", 36, v17)
		local __wf_atom_5e6e15c8 = v:__wf_atom_5e6e15c8("Tip.InputFeedbackLeft", 40)
		v:__wf_atom_50d60589("Tip.InputFeedbackRight", 36, v18)
		v:__wf_atom_e57658c2("Tip.Cursor", 0, __wf_atom_5e6e15c8 + 10)
		v:__wf_atom_e57658c2("Tip.InputFeedbackRight", 0, __wf_atom_5e6e15c8 + 11)
		v:__wf_atom_50d60589("Tip.InputFeedbackRight", 36, v18)
		local v19 = __wf_atom_5e6e15c8 + v:__wf_atom_5e6e15c8("Tip.InputFeedbackRight", 40) + 20
		v:__wf_atom_e57658c2("Tip.Bg2", 14, v19)
		v:__wf_atom_e57658c2("Tip.ChatCap", 0, v19)
	end
end

function IMESetTip(p, p2)
	if v == nil then
		v = p2
	end

	v12 = 0
	local v17 = tostring(p)

	for i = 1, string.len(v17) do
		if not (string.byte(v17, i) >= 48 and string.byte(v17, i) <= 57) then
			continue
		end

		v12 = 1
	end

	if v2 ~= p then
		v2 = p
		fn()
	end
end

function IMESetTipCursor(p, p2)
	if p2 ~= nil then
		v = p2
	end

	v3 = tonumber(p)
	fn()
end

local function fn2()
	if v13 < v5 then
		v5 = 1
	end

	for i = 1, 9 do
		v:__wf_atom_4c1c1986("Tip.Option" .. i, "Label", 44, module.Ternary(i == v5, 16777215, 0))
		v:__wf_atom_4c1c1986("Tip.Option" .. i, "Bg", 12, module.Ternary(i == v5, 100, 30))
	end
end

function IMESetFocusedOption(p, p2)
	if p2 ~= nil then
		v = p2
	end

	local v17 = __wf_atom_421b01aa(tonumber(p), 1, v13)
	local v18 = v5 ~= v17
	v5 = v17
	fn2()
	return v18
end

function IMESetOptions(p, p2, p3)
	v = p2
	v14 = p3
	local v17 = p == nil and "" or p
	local v18 = StringSplit("|", v17)
	local v19 = 10

	for i = 1, 9 do
		local v20 = i <= #v18
		v:__wf_atom_2dedec1a("Tip.Option" .. i, 13, v20)

		if not v20 then
			continue
		end

		v:__wf_atom_e57658c2("Tip.Option" .. i, 0, v19)

		if v14 == true then
			if v12 == 1 then
				v:__wf_atom_50d60589("Tip.Option" .. i .. ".Label", 36, string.char(97 + i - 1) .. "." .. v18[i])
			else
				v:__wf_atom_50d60589("Tip.Option" .. i .. ".Label", 36, i .. "." .. v18[i])
			end
		else
			v:__wf_atom_50d60589("Tip.Option" .. i .. ".Label", 36, v18[i])
		end

		local v21 = v:__wf_atom_5e6e15c8("Tip.Option" .. i .. ".Label", 40) + 7
		v:__wf_atom_4c1c1986("Tip.Option" .. i, "Bg", 14, v21)
		v19 = v19 + v21 + 5
	end

	if v17 == "" then
		v5 = 1
	end

	fn2()
	v13 = #v18
	v4 = math.max(v19 + 5, 200)
	__wf_atom_ec43d06e(v, "Tip.Bg", 2, { 14 }, { v4 }, 0.1)
end

local function fn3(p)
	if p then
		v:SetVisible(true)
		v:__wf_atom_2dedec1a("_root", 67, true)
		__wf_atom_ec43d06e(v, "Tip", 0, { 12 }, { 100 }, 0.15)
	elseif not __wf_atom_7e8ad928(v) and v:IsVisible() then
		__wf_atom_ec43d06e(v, "Tip", 0, { 12 }, { 0 }, 0.1, 0, function()
			v:SetVisible(false)
			v:__wf_atom_2dedec1a("_root", 67, false)
		end)
	end
end

function IMEGetFocusedValue(p)
	if p ~= nil then
		v = p
	end

	if v13 == 0 then
		if v2 == nil then
			return ""
		end

		return v2
	else
		local __wf_atom_387f260e = v:__wf_atom_387f260e("Tip.Option" .. v5 .. ".Label", 36)

		if v14 then
			__wf_atom_387f260e = string.sub(__wf_atom_387f260e, 3)
		end

		return __wf_atom_387f260e
	end
end

function IMEGetNumOptions(p)
	if p ~= nil then
		v = p
	end

	local v17 = v13
	return v13 > 9 and 9 or v17
end

function IMEGetFocusedIndex(_)
	return v5
end

function IMEClickedOption(p, p2)
	if p2 ~= nil then
		v = p2
	end

	v15 = p
end

function IMEGetAndClearClicked(_)
	if v16 == nil then
		return false
	end

	local v17 = v15
	v15 = nil
	return v17
end

function IMEMouseOver(p, _)
	v16 = p
end

function IMEMouseOff(p, _)
	if p == v16 then
		v16 = nil
	end
end

function IsVisible()
	return not __wf_atom_7e8ad928(v10)
end

function IMESetTargetField(p, p2, p3)
	if p3 ~= nil then
		v = p3
	end

	local v17 = not __wf_atom_7e8ad928(p)

	if v17 ~= not __wf_atom_7e8ad928(v10) then
		if v17 then
			v:SetVisible(true)
			v:__wf_atom_2dedec1a("_root", 67, true)
			__wf_atom_ec43d06e(v, "Tip", 0, { 12 }, { 100 }, 0.15)
		else
			__wf_atom_ec43d06e(v, "Tip", 0, { 12 }, { 0 }, 0.1, 0, function()
				v:SetVisible(false)
				v:__wf_atom_2dedec1a("_root", 67, false)
			end)
		end
	end

	v10 = p
	v11 = p2
end

function OpenIME(p)
	if p ~= nil then
		v = p
	end

	local __wf_atom_a96588a7 = __wf_atom_8e4fda44:__wf_atom_a96588a7()
	local v17 = not __wf_atom_7e8ad928(__wf_atom_a96588a7)

	if v17 ~= not __wf_atom_7e8ad928(v10) then
		fn3(v17)
	end

	v10 = __wf_atom_a96588a7
	v11 = nil

	if not __wf_atom_7e8ad928(v10) then
		fn3(true)
	end
end

function CloseIME(p)
	if v == nil then
		v = p
	end

	fn3(false)
	v10 = nil
end

local function fn4(p)
	if v == nil then
		v = p
	end

	if not __wf_atom_7e8ad928(v10) then
		local __wf_atom_5e6e15c8 = v10:__wf_atom_5e6e15c8("_root", 5)

		if __wf_atom_5e6e15c8 ~= v:__wf_atom_5e6e15c8("Tip", 5) then
			v:__wf_atom_e57658c2("Tip", 5, __wf_atom_5e6e15c8)
			v:__wf_atom_e57658c2("Tip", 6, __wf_atom_5e6e15c8)
		end

		local x, y

		if v11 == nil then
			local __wf_atom_dc0c6be5 = v10:__wf_atom_dc0c6be5()
			x = __wf_atom_dc0c6be5.x
			y = __wf_atom_dc0c6be5.y
		else
			local v17
			v17, y = module.GetRootBasedPosition(v10, v11)
			local __wf_atom_5e6e15c8_2 = v10:__wf_atom_5e6e15c8(v11, 82)
			local __wf_atom_5e6e15c8_3 = v10:__wf_atom_5e6e15c8(v11, 14)
			x = v17 + math.min(__wf_atom_5e6e15c8_2 - 4, __wf_atom_5e6e15c8_3)
		end

		local __wf_atom_a35a5fbb, v17 = v10:__wf_atom_a35a5fbb(x, y)
		local __wf_atom_0bcbc308, v18 = v:__wf_atom_0bcbc308(__wf_atom_a35a5fbb, v17)
		local rounded3 = module.Round(__wf_atom_0bcbc308)
		local rounded4 = module.Round(v18)
		local v19 = rounded4 + 0 > v:__wf_atom_c4f6543f() and -0 or 0

		if v8 ~= 0 or v9 ~= v19 then
			v6 = v8
			v7 = v9
			v8 = 0
			v9 = v19

			if __wf_atom_7e8ad928(v6) or __wf_atom_7e8ad928(v7) then
				rounded = 0
				rounded2 = v19
				v:__wf_atom_290807ee("_root")
			else
				local v20 = { function(p2)
						rounded = module.Round(v6 + (v8 - v6) * p2)
						rounded2 = module.Round(v7 + (v9 - v7) * p2)
					end }
				__wf_atom_ec43d06e(v, "_root", 0, v20, { 1 }, 0.15)
				__wf_atom_ec43d06e(v, "Tip.Pointer", 0, { 0 }, { 0 }, 0.15)
				v:__wf_atom_e57658c2("Tip.Pointer", 5, 100)
			end
		end

		v:__wf_atom_e57658c2("Tip", 0, rounded3 + rounded)
		v:__wf_atom_e57658c2("Tip", 1, rounded4 + rounded2)
	end
end

function Initialize(p)
	if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(p) then
		v = p
	end

	v:__wf_atom_e57658c2("Tip", 12, 0)
	v:__wf_atom_50d60589("Tip.Label", 36, "")
	v2 = nil

	for i = 1, 9 do
		local v17 = "Tip.Option" .. i
		v:__wf_atom_e57658c2(v17, 100, i)
		v:__wf_atom_4c1c1986(v17, "Bg", 100, i)
		v:SetCallbacks(v17 .. ".Bg", "TipOptionFocused", "TipOptionUnfocused", "TipOptionClicked", nil)
		v:__wf_atom_48bd5a59(v17, "Label", 36, "")
	end

	fn3(false)
end

function Update(p)
	if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(p) then
		v = p
	elseif __wf_atom_7e8ad928(v) then
		return
	end

	v:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
	fn4(v)
end