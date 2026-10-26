local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")
local module3 = require("EE.Interface.Utilities")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = {}
local v8 = nil
local v9 = false
local v10 = false
local v11 = false
local flag = false
local v12 = false
local flag2 = false
local flag3 = false
local v13 = nil
local v14 = false
local locString = nil
local flag4 = false

local function fn()
	local v15 = {
		{ Name = "MOVE_FORWARD", InputCode = "MOVE_Z", Filter = decoFilter, Invert = false },
		{ Name = "MOVE_LEFT", InputCode = "MOVE_X", Filter = decoFilter, Invert = true },
		{ Name = "MOVE_BACKWARD", InputCode = "MOVE_Z", Filter = decoFilter, Invert = true },
		{ Name = "MOVE_RIGHT", InputCode = "MOVE_X", Filter = decoFilter, Invert = false },
		{ Name = "MOVE_UP", InputCode = "MOVE_Y", Filter = decoFilter, Invert = false },
		{ Name = "MOVE_DOWN", InputCode = "MOVE_Y", Filter = decoFilter, Invert = true }
	}
	local v16 = {}
	local v17 = {
		{ Name = "PLACEMENT_ADD", InputCode = "DOJO_SELECTION_ADD", Invert = false },
		{ Name = "PLACEMENT_EDIT", InputCode = "DOJO_SELECTION_EDIT", Invert = false },
		{ Name = "PLACEMENT_PLACE", InputCode = "DOJO_SELECTION_PLACE", Invert = false },
		{ Name = "PLACEMENT_ROTATE", InputCode = "DOJO_SELECTION_ROTATE", Invert = false },
		{
			Name = "PLACEMENT_CHANGE_ROTATION",
			InputCode = "DOJO_SELECTION_CHANGE_ROTATION",
			Invert = false
		},
		{ Name = "PLACEMENT_SCALE", InputCode = "DOJO_SELECTION_SCALE", Invert = false },
		{ Name = "PLACEMENT_SCALE_UP", InputCode = "DOJO_SELECTION_SCALE_UP", Invert = false },
		{ Name = "PLACEMENT_SCALE_DOWN", InputCode = "DOJO_SELECTION_SCALE_DOWN", Invert = false },
		{ Name = "PLACEMENT_SNAP", InputCode = "DOJO_SELECTION_SNAP", Invert = false },
		{
			Name = "PLACEMENT_SURFACE_SNAP",
			InputCode = "DOJO_SELECTION_SURFACE_SNAP",
			Invert = false
		},
		{ Name = "PLACEMENT_PUSH_PULL", InputCode = "DOJO_SELECTION_PUSH_PULL", Invert = false },
		{ Name = "PLACEMENT_RESET", InputCode = "DOJO_SELECTION_RESET", Invert = false }
	}

	for i = 1, #v15 do
		table.insert(v16, {
			Value = __wf_atom_8e4fda44:__wf_atom_c2e9085e(v15[i].InputCode, v15[i].Invert, v15[i].Filter, false, false),
			Name = v15[i].Name
		})
	end

	local v18 = {}

	for i = 1, #v17 do
		table.insert(v18, {
			Value = __wf_atom_8e4fda44:__wf_atom_c2e9085e(
				v17[i].InputCode,
				v17[i].Invert,
				decoFilter,
				Engine.IsPlayingWithController(),
				false
			),
			Name = v17[i].Name
		})
	end

	for i = 1, #v18 do
		for j = 1, #v18[i].Value do
			for k = 1, #v16 do
				for i2 = 1, #v16[k].Value do
					if v18[i].Value[j] ~= v16[k].Value[i2] then
						continue
					end

					local v19 = "/Lotus/Language/Menu/Input_" .. v15[k].InputCode

					if v15[k].Invert then
						v19 ..= "_Invert"
					end

					local nkey = "<b>" .. mMovie:__wf_atom_8e9ac384(v19, true) .. "</b>"
					local dkey = "<b>" .. mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Menu/Input_" .. v17[i].InputCode,
						true
					) .. "</b>"
					locString = mMovie:__wf_atom_8e9ac384("/Lotus/Language/UiElements/InputConflictMsg", false, {
						NKEY = nkey,
						DKEY = dkey
					})
					print("illegal value!!!")
					return false
				end
			end
		end
	end

	return true
end

local function fn2()
	local height = v8:GetHeight()
	local maxTextWidth = v8.MaxTextWidth
	mMovie:__wf_atom_e57658c2("GenericMessage.MessageContainer", 0, -(maxTextWidth + 15))
	mMovie:__wf_atom_e57658c2("GenericMessage.Header", 0, -(maxTextWidth + 15))
	mMovie:__wf_atom_e57658c2("GenericMessage.Header", 1, -(height + 31))
	mMovie:__wf_atom_e57658c2("GenericMessage.Header", 14, maxTextWidth)
	mMovie:__wf_atom_e57658c2("GenericMessage.HeaderDeco", 0, (270 - maxTextWidth) / 2)
	mMovie:__wf_atom_e57658c2("GenericMessage.HeaderDeco", 1, -(height + 44))
	mMovie:__wf_atom_e57658c2("GenericMessage.Footer", 0, -(maxTextWidth + 15))
	mMovie:__wf_atom_e57658c2("GenericMessage.Footer", 14, maxTextWidth)
	mMovie:__wf_atom_e57658c2("GenericMessage.Bg", 15, height + 44)
	mMovie:__wf_atom_e57658c2("GenericMessage.Bg", 14, maxTextWidth + 30)
	mMovie:__wf_atom_e57658c2("GenericMessage.Blurer", 15, height + 44)
	mMovie:__wf_atom_e57658c2("GenericMessage.Blurer", 14, maxTextWidth + 30)
	v8:RunForAllVisibleElements(function(p)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Bg", 14, maxTextWidth + 30)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Setting", 0, maxTextWidth - 205)
	end)
end

local function fn3()
	local module4 = require("EE.Interface.Components.List")
	v8 = module4.CreateList(mMovie, "GenericMessage.MessageContainer.ListItem", 6)
	v8.MaxTextWidth = 270

	function v8.mClipCreatedCallback(p, _)
		mMovie:OverrideMaterial(p .. ".Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(p .. ".Bg", "RectEdgeColor", 0, 0, 0, 0)
		mMovie:__wf_atom_4c1c1986(p, "Text", 44, v7.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(p, "Callout", 44, v7.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(p, "Setting", 44, v7.FloatingContentHighlight)
	end

	function v8.mElementDrawCallback(data)
		if data.mClipName == nil then
			return
		end

		if data.mIndex % 2 == 0 then
			mMovie:__wf_atom_1ca72041(data.mClipName .. ".Bg", "RectInnerColor", 0, 0, 0, 0)
		else
			mMovie:__wf_atom_1ca72041(
				data.mClipName .. ".Bg",
				"RectInnerColor",
				v7.ContentObject.r,
				v7.ContentObject.g,
				v7.ContentObject.b,
				0.05
			)
		end

		local v15, label = string.match(data.Label, "^({!*[RMPSXYZ]+})(.*)")
		local v16 = 100

		if v15 == nil or label == nil then
			label = data.Label
		else
			if v15:find("[^!]+R") then
				v16 = module3.Ternary(v8.RotateMode, v16, 50)
			elseif v15:find("!R") then
				v16 = module3.Ternary(v8.RotateMode, 50, v16)
			end

			if v15:find("P") then
				v16 = module3.Ternary(v8.PushPullMode, 50, v16)
			end

			if v15:find("S") then
				v16 = module3.Ternary(v8.ScaleMode, 50, v16)
			end

			if v15:find("M[XYZ]") and v8.MoveAxis ~= 3 then
				if v15:find("MX") then
					v16 = module3.Ternary(v8.MoveAxis == 0, v16, 50)
				elseif v15:find("MY") then
					v16 = module3.Ternary(v8.MoveAxis == 1, v16, 50)
				elseif v15:find("MZ") then
					v16 = module3.Ternary(v8.MoveAxis == 2, v16, 50)
				end
			end
		end

		local v17 = label
		local v18 = nil
		local v19 = nil

		repeat
			local v20
			v20, v17 = string.match(v17, "^ ?(<.->)(.*)")

			if v20 ~= nil then
				if v18 == nil then
					v18 = v20
				else
					v18 ..= v20
				end
			end

			if v17 ~= nil then
				v19 = v17
			end
		until v17 == nil

		if v19 == nil then
			v19 = label
		end

		local v20, v21 = string.match(v19, "(.-)%[(.*)%]")

		if v20 ~= nil then
			v19 = v20
		end

		local v22 = v21 == nil and "" or v21
		mMovie:__wf_atom_7d7314f1(data.mClipName .. ".Setting.text", v22)
		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(data.mClipName, "Setting", 40)

		if v18 == nil then
			mMovie:__wf_atom_48bd5a59(data.mClipName, "Callout", 36, "")
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Text", 0, 0)
		else
			local __wf_atom_c7fa5e0c = mMovie:__wf_atom_c7fa5e0c(v18, decoFilter)
			mMovie:__wf_atom_48bd5a59(data.mClipName, "Callout", 36, __wf_atom_c7fa5e0c)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Text", 0, 55)
		end

		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v19, true)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Text", 12, v16)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Callout", 12, v16)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Setting", 12, v16)
		mMovie:__wf_atom_48bd5a59(data.mClipName, "Text", 36, __wf_atom_8e9ac384)
		local v23 = mMovie:__wf_atom_cfc41e35(data.mClipName, "Text", 40) + 55 + __wf_atom_cfc41e35
		v8.MaxTextWidth = math.max(v8.MaxTextWidth, v23)
	end

	function v8.CalculateY(object, p)
		local howManyElements = object:GetHowManyElements()
		return object.mInitialY - 30 * (howManyElements - p.mIndex)
	end

	function v8:GetHeight()
		return self:GetHowManyElements() * 30 + mMovie:__wf_atom_5e6e15c8("GenericMessage.Header", 41) - 16
	end

	v8._Redraw = v8.Redraw

	function v8:Redraw(p, p2, p3)
		self.MaxTextWidth = 270

		if self.HeaderLabel ~= nil then
			mMovie:__wf_atom_e57658c2("GenericMessage.Header", 93, 300)
			mMovie:__wf_atom_50d60589("GenericMessage.Header", 97, "...")
			mMovie:__wf_atom_50d60589("GenericMessage.Header", 36, self.HeaderLabel)
			self.MaxTextWidth = math.max(self.MaxTextWidth, mMovie:__wf_atom_5e6e15c8("GenericMessage.Header", 40))
		end

		self:_Redraw(p, p2, p3)
		fn2()
	end
end

local function fn4(value)
	v8.HeaderLabel = nil
	v8:RemoveElements(true, true)

	if string.len(value) == 0 then
		return
	end

	local flag5 = false
	v11 = false
	local v15, v16 = string.match(value, "(.*){A}(.*)")

	if v15 == nil then
		v15 = value
	end

	if v16 == nil then
		v16 = value
	end

	local ternary = module3.Ternary(v10, v16, v15)

	for k in string.gmatch(ternary, "[^\r\n]+") do
		if flag5 then
			if mMovie:__wf_atom_8e9ac384(k, true):find("<[%a_]+>") == nil then
				v8:AddElement({ Label = k }, true)
			end
		else
			local v17, v18 = string.match(k, "^({T})(.*)")

			if v18 == nil then
				v18 = k
			end

			local headerLabel = v18:gsub("{br}", "\r\n")
			v8.HeaderLabel = headerLabel
			v11 = v17 ~= nil
			v12 = k == Localize("/Lotus/Language/Labels/DecorationHeaderFreeCamera", nil)

			if flag2 or not v12 or v10 then
				if flag2 and (not v12 or v10) then
					gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
						Symbol("ShowHelp"),
						__wf_atom_8e4fda44:__wf_atom_e7d83c15("DOJO_SELECTION_RESET")
					)
					flag2 = false
				end
			else
				gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
					Symbol("ShowHelp"),
					__wf_atom_8e4fda44:__wf_atom_e7d83c15("DOJO_SELECTION_RESET"),
					"ShowHelp"
				)
				flag2 = true
			end

			mMovie:__wf_atom_e57658c2("GenericMessage.Footer", 12, module3.Ternary(v11, 100, 0))
			flag5 = true
		end
	end

	local __wf_atom_be6b2a2f = v3:__wf_atom_50a7d83e():__wf_atom_a1b79f95():__wf_atom_be6b2a2f()

	if not __wf_atom_7e8ad928(__wf_atom_be6b2a2f) and __wf_atom_be6b2a2f:IsA(__wf_atom_0097d4df) then
		v8.RotateMode = __wf_atom_be6b2a2f:__wf_atom_bed6d8d7()
		v8.PushPullMode = __wf_atom_be6b2a2f:__wf_atom_b8bf6c45()
		v8.ScaleMode = __wf_atom_be6b2a2f:__wf_atom_b144a592()
		v8.MoveAxis = __wf_atom_be6b2a2f:__wf_atom_37641da0()
	end

	v8:Redraw(nil, true, true)
end

local function fn5(value)
	fn4(string.gsub(value, "^true,", "", 1))
	local rotateMode = v8.RotateMode
	local pushPullMode = v8.PushPullMode or v8.ScaleMode or rotateMode
	mMovie:__wf_atom_2dedec1a("Hint", 13, true)

	if pushPullMode then
		mMovie:__wf_atom_e57658c2("Hint.Arrows", 16, module3.Ternary(rotateMode, 90, 0))
	end

	__wf_atom_ec43d06e(mMovie, "Hint", 8, { 12 }, { module3.Ternary(pushPullMode, 100, 0) }, 0.25, 0, function()
		if not pushPullMode then
			mMovie:__wf_atom_2dedec1a("Hint", 13, false)
		end
	end)
	mMovie:__wf_atom_2dedec1a("GenericMessage", 13, true)
	__wf_atom_ec43d06e(mMovie, "GenericMessage", 1, { 12 }, { 100 }, 0.2, 0)
end

local function fn6(mValue)
	if mValue == "" then
		mMovie:__wf_atom_2dedec1a("Hint", 13, false)
		mMovie:__wf_atom_2dedec1a("GenericMessage", 13, false)
		mMovie:__wf_atom_50d60589("GenericMessage.Text", 36, "")
	elseif flag3 then
		if not __wf_atom_7e8ad928(v13) then
			v:RemoveTimer(v13)
		end

		local __wf_atom_be6b2a2f = v3:__wf_atom_50a7d83e():__wf_atom_a1b79f95():__wf_atom_be6b2a2f()

		if __wf_atom_7e8ad928(__wf_atom_be6b2a2f) or not __wf_atom_be6b2a2f:__wf_atom_fb23dce8() then
			fn5(mValue)
		else
			v13 = v:AddTimer(0.1, function()
				fn5(mValue)
			end)
		end
	else
		fn5(mValue)
		flag3 = true
	end
end

local function fn7(_)
	fn6(v5.mValue)
end

function HandleConflict(p)
	if tonumber(p) == 4 then
		print("user wishes to continue")
		return
	end

	local screen = _T.OpenScreen("Settings")

	if not __wf_atom_7e8ad928(screen) then
		screen:Execute("ScrollToBottomOfScreen", "")
	end
end

local function fn8()
	local v15

	if Engine.IsPlayingWithController() then
		local __wf_atom_c2e9085e = __wf_atom_8e4fda44:__wf_atom_c2e9085e("LOOK_X", false, decoFilter, true, false)
		v15 = not (#__wf_atom_c2e9085e > 0) and "<GAMEPAD_RX>" or "<" .. __wf_atom_c2e9085e[1] .. ">"
	else
		v15 = "<MOUSE>"
	end

	mMovie:__wf_atom_7d7314f1("Hint.Callout.text", v15)
end

function Initialize()
	if fn() == false then
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 1
		dialogSettings.locString = locString
		dialogSettings.firstString = "/Menu/Confirm_Item_Ok"
		dialogSettings.secondString = "/Lotus/Language/UiElements/OpenOptionsToCorrect"
		dialogSettings:SetCallback("HandleConflict")
		module3.ShowCustomMessage(dialogSettings)
	end

	local module4 = require("Lotus.Interface.Libs.TimerMgr")
	v = module4.CreateTimerMgr()
	local module5 = require("EE.Interface.AnchorMgr")
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		v3 = __wf_atom_c4f78a8f:__wf_atom_a96eb2aa()
		v5 = module3.CreateObservable("", fn6)
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			v10 = __wf_atom_18a5d83b:Settings():__wf_atom_70da433f()
			v9 = v10
		end

		local __wf_atom_be6b2a2f = v3:__wf_atom_50a7d83e():__wf_atom_a1b79f95():__wf_atom_be6b2a2f()

		if not __wf_atom_7e8ad928(__wf_atom_be6b2a2f) and __wf_atom_be6b2a2f:IsA(__wf_atom_0097d4df) then
			__wf_atom_be6b2a2f:SetAdvancedMode(v10)
		end

		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Labels/DecorationAdvancedMode", true, {
			STATE = module3.Ternary(v10, "<CHECKMARK>", "<CHECKMARK_OUTLINE>")
		})
		local v15 = __wf_atom_8e9ac384:find("<DOJO_SELECTION_MODE>") ~= nil and "" or __wf_atom_8e9ac384
		mMovie:__wf_atom_50d60589("GenericMessage.Footer", 36, v15)
		gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
			Symbol("ToggleAdvancedMode"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15("DOJO_SELECTION_MODE"),
			"ToggleAdvancedMode"
		)
		flag = true
		v2 = module5.Create(mMovie)
		v2:Register(mMovie, "Hint", { v2.ANCHOR_V_BOTTOM, v2.ANCHOR_H_CENTRE })
		v2:Register(mMovie, "GenericMessage", { v2.ANCHOR_V_BOTTOM, v2.ANCHOR_H_RIGHT })
		v2:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
		v7.Background = module2.GetColor(2, true)
		v7.Content = module2.GetColor(6, true)
		v7.FloatingContent = module2.GetColor(9, true)
		v7.FloatingContentHighlight = module2.GetColor(10, true)
		v7.BackgroundObject = module3.ConvertColorNumberToProceduralRGB(v7.Background)
		v7.ContentObject = module3.ConvertColorNumberToProceduralRGB(v7.Content)
		v7.FloatingContentObject = module3.ConvertColorNumberToProceduralRGB(v7.FloatingContent)
		v7.ContentHex = module3.ConvertColorNumberToHex(v7.Content)
		v7.FloatingContentHex = module3.ConvertColorNumberToHex(v7.FloatingContent)
		mMovie:OverrideMaterial("GenericMessage.Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			"GenericMessage.Bg",
			"RectInnerColor",
			v7.BackgroundObject.r,
			v7.BackgroundObject.g,
			v7.BackgroundObject.b,
			0.7
		)
		mMovie:__wf_atom_1ca72041(
			"GenericMessage.Bg",
			"RectEdgeColor",
			v7.FloatingContentObject.r,
			v7.FloatingContentObject.g,
			v7.FloatingContentObject.b,
			0.9
		)
		mMovie:__wf_atom_e57658c2("Hint.Callout", 44, v7.FloatingContentHighlight)
		mMovie:__wf_atom_e57658c2("Hint.Arrows", 11, v7.FloatingContentHighlight)
		mMovie:__wf_atom_e57658c2("Hint.CircleBacker", 11, v7.Background)
		mMovie:__wf_atom_e57658c2("GenericMessage.Header", 44, v7.FloatingContentHighlight)
		mMovie:__wf_atom_e57658c2("GenericMessage.HeaderDeco.Image", 11, v7.FloatingContentHighlight)
		mMovie:__wf_atom_e57658c2("GenericMessage.HeaderDeco.Bg", 11, v7.Background)
		mMovie:__wf_atom_e57658c2("GenericMessage.Footer", 44, v7.FloatingContentHighlight)
		mMovie:__wf_atom_e57658c2("GenericMessage.Footer", 12, 0)
		mMovie:__wf_atom_e57658c2("GenericMessage", 12, 0)
		mMovie:__wf_atom_2dedec1a("GenericMessage", 13, true)
		mMovie:__wf_atom_2dedec1a("Reticle", 13, false)
		fn8()
		mMovie:__wf_atom_c90af43a("Hint.Arrows", arrowsTexture)
		mMovie:__wf_atom_e57658c2("Hint.Arrows", 14, 100)
		mMovie:__wf_atom_e57658c2("Hint.Arrows", 15, 100)
		local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

		if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
			__wf_atom_b56d2aa8:__wf_atom_2dedec1a("GenericMessage", 13, false)
		end
	end

	local movie = __wf_atom_8e4fda44:FindMovie(dojoMapLegendMovie)

	if not __wf_atom_7e8ad928(movie) then
		flag4 = true
		movie:Execute("HideLegend", "")
	end

	fn3()

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:StartTimer(Symbol("IN_SHIP_VIEW_TIME"), "SHIP_DECORATION_PLACEMENT")
	end

	v6 = module3.CreateInputDeviceObservable(fn7)
end

function Shutdown()
	if v10 ~= v9 then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			__wf_atom_18a5d83b:Settings():__wf_atom_62c2c7cb(v10)
			__wf_atom_a0f6588f:__wf_atom_507ce99c(0, "OnProfileSaved")
		end
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

		if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
			__wf_atom_b56d2aa8:__wf_atom_2dedec1a("GenericMessage", 13, true)
		end
	end

	if not (__wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7())) then
		if flag then
			gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
				Symbol("ToggleAdvancedMode"),
				__wf_atom_8e4fda44:__wf_atom_e7d83c15("DOJO_SELECTION_MODE")
			)
			flag = false
		end

		if flag2 then
			gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
				Symbol("ShowHelp"),
				__wf_atom_8e4fda44:__wf_atom_e7d83c15("DOJO_SELECTION_RESET")
			)
			flag2 = false
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("IN_SHIP_VIEW_TIME"), "SHIP_DECORATION_PLACEMENT")
	end

	if flag4 then
		local movie = __wf_atom_8e4fda44:FindMovie(dojoMapLegendMovie)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("ShowLegend", "")
		end
	end

	_T.PrevPlacedDecoInfo = nil
end

function Update()
	local v15 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v15)

	if not __wf_atom_7e8ad928(v) then
		v:Update(v15)
	end

	mMovie:__wf_atom_2dedec1a("_root", 13, not _T.HideDecoHud)

	if __wf_atom_7e8ad928(v4) and not __wf_atom_7e8ad928(v3) then
		v4 = v3:__wf_atom_301e8d97()

		if __wf_atom_7e8ad928(v4) then
			return
		end
	end

	mMovie:SetVisible(__wf_atom_7e8ad928(__wf_atom_392793db) and not v14)

	if not __wf_atom_7e8ad928(v4) then
		v5:Set(v4:__wf_atom_854c2301())
	end

	v6:Update()

	if not (__wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(v3:__wf_atom_50a7d83e())) then
		local __wf_atom_be6b2a2f = v3:__wf_atom_50a7d83e():__wf_atom_a1b79f95():__wf_atom_be6b2a2f()

		if
			__wf_atom_7e8ad928(__wf_atom_be6b2a2f)
			or not (__wf_atom_be6b2a2f:IsA(__wf_atom_0097d4df) and __wf_atom_be6b2a2f:__wf_atom_c8e0621e())
		then
			module3.PlaySound(_G.UISound_GridOpenTwo)
			mMovie:Close()
		end
	end
end

function onViewportSizeChanged(p, p2)
	if not __wf_atom_7e8ad928(v2) then
		v2:Update(p, p2)
	end
end

function Hide()
	v14 = true
end

function Show()
	v14 = false
end

local function fn9()
	fn8()

	if not (__wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(v3:__wf_atom_50a7d83e())) then
		local __wf_atom_be6b2a2f = v3:__wf_atom_50a7d83e():__wf_atom_a1b79f95():__wf_atom_be6b2a2f()

		if not __wf_atom_7e8ad928(__wf_atom_be6b2a2f) and __wf_atom_be6b2a2f:IsA(__wf_atom_0097d4df) then
			__wf_atom_be6b2a2f:__wf_atom_aa973855(true)
		end
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Labels/DecorationAdvancedMode", true, {
		STATE = module3.Ternary(v10, "<CHECKMARK>", "<CHECKMARK_OUTLINE>")
	})
	local v15 = __wf_atom_8e9ac384:find("<DOJO_SELECTION_MODE>") ~= nil and "" or __wf_atom_8e9ac384
	mMovie:__wf_atom_50d60589("GenericMessage.Footer", 36, v15)
end

function OnGamepadTransition(_)
	fn9()
end

function IconCacheFlushed()
	fn9()
end

function DecoResetConfirmed(value)
	local v15 = Localize("/Lotus/Language/UiElements/ResetShipDecosConfirmWord", false)

	if string.lower(value) ~= v15 then
		module3.ShowErrorMessage("/Lotus/Language/Dojo/VaultContributionDecoIncorrectConfirmWord")
		return
	end

	local __wf_atom_a96eb2aa = gRegion:__wf_atom_c4f78a8f():__wf_atom_a96eb2aa()
	local v16 = Localize("/Lotus/Language/Labels/DecorationHeaderFreeCamera", nil) .. "\r\n" .. Localize(
		"/Lotus/Language/Labels/DecorationModePlacement",
		nil
	)

	if not __wf_atom_7e8ad928(_T.PrevPlacedDecoInfo) then
		local v17 = Engine.IsPlayingWithController() and "Console" or ""
		v16 ..= "\r\n" .. Localize("/Lotus/Language/Dojo/DecoPlacePrevious" .. v17, nil)
	end

	local v17 = v16 .. "\r\n" .. Localize("/Lotus/Language/Labels/DecorationModeHelp", nil) .. "\r\n" .. Localize("/Lotus/Language/Labels/DecorationModeExit", nil)
	local v18 = v16 .. "\r\n" .. Localize("/Lotus/Language/Labels/DecorationModeExit", nil)
	__wf_atom_a96eb2aa:__wf_atom_301e8d97():__wf_atom_78443212(v17 .. "{A}" .. v18)
end

function OnShipDecosReset(_, _) end

function ResetShipDecos()
	if not v10 then
		return
	end

	local _, v15 = module.GetShipDecoRoom()
	local room = Localize(v15, false)
	local v16 = Localize("/Lotus/Language/UiElements/ResetShipDecosConfirmWord", false)
	local ternary = module3.Ternary(gGameRules:IsApartmentLevel(), "Apartment", "Orbiter")
	local v17 = "<font face=\"Roboto Regular\">" .. Localize(
		"/Lotus/Language/UiElements/ResetShipDecosConfirm_" .. ternary,
		{
			RESET = "<b>" .. string.upper(v16) .. "</b>",
			ROOM = "<b>" .. room .. "</b>"
		}
	) .. "</font>"
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/UiElements/ResetShipDecosShort1_" .. ternary,
		false,
		{ ROOM = room }
	)
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/UiElements/ResetShipDecosShort2", false, {
		RESET = string.upper(v16)
	})
	module.ShowConditionalWordConfirm(
		mMovie,
		string.lower(v16),
		v17,
		__wf_atom_8e9ac384,
		__wf_atom_8e9ac384_2,
		"DecoResetConfirmed"
	)
end

function OnProfileSaved() end

function ToggleAdvancedMode(p)
	if p == 0 or not v11 then
		return
	end

	v10 = not v10
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Labels/DecorationAdvancedMode", true, {
		STATE = module3.Ternary(v10, "<CHECKMARK>", "<CHECKMARK_OUTLINE>")
	})
	local v15 = __wf_atom_8e9ac384:find("<DOJO_SELECTION_MODE>") ~= nil and "" or __wf_atom_8e9ac384
	mMovie:__wf_atom_50d60589("GenericMessage.Footer", 36, v15)
	local __wf_atom_be6b2a2f = v3:__wf_atom_50a7d83e():__wf_atom_a1b79f95():__wf_atom_be6b2a2f()

	if not __wf_atom_7e8ad928(__wf_atom_be6b2a2f) and __wf_atom_be6b2a2f:IsA(__wf_atom_0097d4df) then
		__wf_atom_be6b2a2f:SetAdvancedMode(v10)
	end

	if flag2 or not v12 or v10 then
		if flag2 and (not v12 or v10) then
			gRegion:__wf_atom_eab484a7():__wf_atom_1006e6fc(
				Symbol("ShowHelp"),
				__wf_atom_8e4fda44:__wf_atom_e7d83c15("DOJO_SELECTION_RESET")
			)
			flag2 = false
		end
	else
		gRegion:__wf_atom_eab484a7():__wf_atom_6e3c1557(
			Symbol("ShowHelp"),
			__wf_atom_8e4fda44:__wf_atom_e7d83c15("DOJO_SELECTION_RESET"),
			"ShowHelp"
		)
		flag2 = true
	end

	fn4(v5.mValue)
end

function ShowHelp(p)
	if p == 0 then
		return false
	end

	local ascend, descend

	if Engine.IsPlayingWithController() then
		local __wf_atom_c2e9085e = __wf_atom_8e4fda44:__wf_atom_c2e9085e("MOVE_Y", false, decoFilter, true, false)

		if #__wf_atom_c2e9085e > 0 and __wf_atom_c2e9085e[1] ~= "" then
			ascend = "<" .. __wf_atom_c2e9085e[1] .. ">"
		else
			ascend = Localize("/Lotus/Language/Menu/UnboundKey", nil)
		end

		local __wf_atom_c2e9085e2 = __wf_atom_8e4fda44:__wf_atom_c2e9085e("MOVE_Y", true, decoFilter, true, false)

		if #__wf_atom_c2e9085e2 > 0 and __wf_atom_c2e9085e2[1] ~= "" then
			descend = "<" .. __wf_atom_c2e9085e2[1] .. ">"
		else
			descend = Localize("/Lotus/Language/Menu/UnboundKey", nil)
		end
	else
		ascend = "<MOVE_Y>"
		descend = "<MOVE_Y:INVERT=1>"
	end

	local locString2 = "<p><font color=\"" .. v7.ContentHex .. "\">" .. mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/UiElements/Deco_Help",
		true,
		{
			OPEN_COLOR = "<font color=\"" .. v7.FloatingContentHex .. "\">",
			CLOSE_COLOR = "</font>",
			ASCEND = ascend,
			DESCEND = descend
		}
	) .. "</font></p>"
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	dialogSettings.locString = locString2
	dialogSettings.firstString = "/Lotus/Language/Menu/ItemSelection_OK"
	dialogSettings.alignment = 0
	module3.ShowCustomMessage(dialogSettings)
end

function SupportsThemes()
	return true
end