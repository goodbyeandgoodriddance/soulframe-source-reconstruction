local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("EE.Interface.Utilities")
local v = nil
local v2 = nil
local include = true
local v3 = nil
local v4 = nil
local v5 = nil
local flag = true
local v6 = 0
local v7 = 0
local v8 = { Label = "", Filter = "" }
local v9 = { Label = "", Filter = "" }
local v10 = { Label = "", Filter = "" }
local fn
local fn2

function IsInputBlocked()
	return flag
end

function Shutdown()
	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, nil)
	end

	if not (__wf_atom_7e8ad928(v) or __wf_atom_7e8ad928(_T[v])) then
		_T[v]()
	end
end

local function fn3()
	mMovie:Close()
end

local function fn4(focusedElement)
	if focusedElement == nil then
		focusedElement = v4:GetFocusedElement()
	end

	v5:__wf_atom_1329cee2(v3, Engine.ChatFilter(focusedElement.Filter, focusedElement.Include))

	if focusedElement.mIndex == v4:GetHowManyElements() then
		v4:FocusPreviousElement()
	end

	v4:RemoveElement(focusedElement.mIndex)
	fn()
end

fn = function()
	local v11 = {}
	table.insert(v11, {
		Label = "/Lotus/Language/Menu/MissionStats_Done",
		CallBack = fn3,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v11, getfenv(1))
	end
end

local function fn5(p)
	local v11 = nil
	local __wf_atom_387f260e = mMovie:__wf_atom_387f260e("Input", 36)

	if p ~= nil then
		__wf_atom_387f260e = p
	end

	local filter = string.lower(__wf_atom_387f260e)
	local v12 = nil
	local v13 = nil

	if filter == "" then
		v11 = "/Lotus/Language/Menu/FilterMgr_ErrorEmptyFilter"
	else
		for i = 1, #v4.mElements do
			local mElement = v4.mElements[i]

			if mElement.Filter == filter then
				if include == mElement.Include then
					v11 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/FilterMgr_ErrorFilterExists", false, {
						FILTER = filter
					})
				else
					v12 = i
				end

				break
			elseif filter < mElement.Filter and v13 == nil then
				v13 = i
			end
		end
	end

	if not __wf_atom_7e8ad928(v11) then
		module2.ShowMessage(v11)
		return
	end

	v5:__wf_atom_1329cee2(v3, Engine.ChatFilter(filter, include))

	if v12 == nil then
		local v14 = { Filter = filter, Include = include }

		if v13 == nil then
			v4:AddElement(v14, true)
		else
			v4:InsertElement(v13, v14, true)
		end

		v4:Redraw(nil, true, true)
	else
		local elementInIndex = v4:GetElementInIndex(v12)

		if not __wf_atom_7e8ad928(elementInIndex) then
			elementInIndex.Include = not elementInIndex.Include
			v4.mElementDrawCallback(elementInIndex)
		end
	end

	mMovie:__wf_atom_50d60589("Input", 36, "")
end

function AddFilter()
	fn5()
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
	local __wf_atom_387f260e = mMovie:__wf_atom_387f260e("Input", 36)
	mMovie:__wf_atom_2dedec1a("InputBtn", 13, __wf_atom_387f260e ~= "")
	mMovie:__wf_atom_2dedec1a("InputPrompt", 13, __wf_atom_387f260e == "")
end

local function fn6()
	local module3 = require("EE.Interface.Components.List")
	v4 = module3.CreateList(mMovie, "FilterList.Element")
	v4:SetCallbacks("FilterSelected", "FilterFocused", "FilterUnfocused")
	v4.mForcedVerticalSeparation = 35
	v4.mVisibleElements = 5
	v4:AttachScrollBar("ScrollBar", -6)
	v4:EnableSmoothScroll()
	v4.mWrapAroundNavigation = false

	function v4.SetRemoveBtnVis(p, p2)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p.mClipName .. ".Label", 40)

		if __wf_atom_5e6e15c8 == nil then
			return
		end

		local v11 = __wf_atom_5e6e15c8 + module2.Ternary(not p2, 15, 37)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Bg", 14, v11)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Btn", 14, v11)
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Separator", 13, p2)
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "CrossIcon", 13, p2)
	end

	function v4.mOnFocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Bg",
			"RectEdgeColor",
			_G.UIColorObject_Yellow.r,
			_G.UIColorObject_Yellow.g,
			_G.UIColorObject_Yellow.b,
			0.9
		)
		v4.SetRemoveBtnVis(p, true)
	end

	function v4.mOnUnfocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Bg",
			"RectEdgeColor",
			_G.UIColorObject_White.r,
			_G.UIColorObject_White.g,
			_G.UIColorObject_White.b,
			0.25
		)
		v4.SetRemoveBtnVis(p, false)
	end

	function v4.mOnSelectedCallback(p)
		fn4(p)
	end

	function v4.mElementDrawCallback(data)
		if __wf_atom_7e8ad928(data.mClipName) then
			return
		end

		local focusedElement = v4:GetFocusedElement()
		local v11

		if focusedElement == nil then
			v11 = false
		else
			v11 = focusedElement.Id == data.Id
		end

		local v12 = "<p>"

		if not data.Include then
			v12 ..= "<font color=\"#C80406\">" .. mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/FilterMgr_ExcludeTag",
				false
			) .. " </font>"
		end

		local filter = data.Filter

		if filter == v8.Filter then
			filter = v8.Label
		elseif filter == v9.Filter then
			filter = v9.Label
		elseif filter == v10.Filter then
			filter = v10.Label
		end

		local v13 = v12 .. "<font color=\"#FFFFFF\">" .. filter .. "</font></p>"
		module2.SetFitText(mMovie, data.mClipName .. ".Label", "...")
		mMovie:__wf_atom_50d60589(data.mClipName .. ".Label", 36, v13)
		mMovie:OverrideMaterial(data.mClipName .. ".Bg", _G.UIMaterial_RectangleNoDepth)
		local ternary = module2.Ternary(v11, _G.UIColorObject_Yellow, _G.UIColorObject_White)
		local ternary2 = module2.Ternary(v11, 0.9, 0.25)
		mMovie:__wf_atom_1ca72041(data.mClipName .. ".Bg", "RectEdgeColor", ternary.r, ternary.g, ternary.b, ternary2)
		mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".Bg",
			"RectInnerColor",
			_G.UIColorObject_Black.r,
			_G.UIColorObject_Black.g,
			_G.UIColorObject_Black.b,
			0.75
		)
		v4.SetRemoveBtnVis(data, v11)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Label", 40)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Separator", 12, 25)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Separator", 0, __wf_atom_5e6e15c8 + 12)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".CrossIcon", _G.UITexture_ClearSearch)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "CrossIcon", 11, _G.UIColor_White)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "CrossIcon", 0, __wf_atom_5e6e15c8 + 23)
	end
end

local function fn7()
	local __wf_atom_0cff5ea1 = v5:__wf_atom_0cff5ea1(v3)
	local v11 = {}

	for i = 1, #__wf_atom_0cff5ea1 do
		table.insert(v11, {
			Filter = __wf_atom_0cff5ea1[i].filter,
			Include = __wf_atom_0cff5ea1[i].include
		})
	end

	table.sort(v11, function(a, b)
		return a.Filter < b.Filter
	end)

	for i = 1, #v11 do
		v4:AddElement(v11[i], true)
	end

	v4:Redraw()
	local v12 = v4:GetHowManyVisibleElements() * v4.mForcedVerticalSeparation
	mMovie:__wf_atom_e57658c2("FilterListMask", 15, v12)
	mMovie:__wf_atom_e57658c2("Bg", 15, v12 + 130)
	fn()
end

local function fn8()
	local isPlayingWithController = Engine.IsPlayingWithController()
	mMovie:__wf_atom_50d60589("Input", 57, module2.Ternary(isPlayingWithController, "dynamic", "input"))
	mMovie:__wf_atom_7d7314f1(
		"InputPrompt.text",
		module2.Ternary(
			isPlayingWithController,
			"/Lotus/Language/Menu/FilterMgr_PromptConsole",
			"/Lotus/Language/Menu/FilterMgr_Prompt"
		)
	)
	mMovie:__wf_atom_2dedec1a("InputCallout", 13, isPlayingWithController)
	mMovie:__wf_atom_7d7314f1("InputCallout.text", "<MENU_GENERIC1>")
	v2:SetVisible(not isPlayingWithController)
	mMovie:__wf_atom_e57658c2("InputBg", 14, v7 + module2.Ternary(isPlayingWithController, 82, 0))
	mMovie:__wf_atom_e57658c2("InputPrompt", 0, v6 + module2.Ternary(isPlayingWithController, 25, 0))
	local ternary = module2.Ternary(isPlayingWithController, mMovie:__wf_atom_8e9ac384("<MENU_GENERIC2> ", true), "")
	mMovie:__wf_atom_50d60589(
		"Include.Label",
		36,
		ternary .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/FilterMgr_IncludeLabel", false)
	)
end

function Initialize()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	v5 = __wf_atom_18a5d83b:Settings()
	v8.Label = string.lower("[" .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Appearance_Prefix", false) .. ":")
	v8.Filter = "[ff-"
	v9.Label = string.lower("[" .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Mod_Prefix", false) .. ":")
	v9.Filter = "[mod-"
	v10.Label = string.lower("[" .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Shawzin_Prefix", false) .. ":")
	v10.Filter = "[song-"
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	mMovie:__wf_atom_7df746cd(0)
	mMovie:__wf_atom_0cf0fdbe(0.9)
	module.AdjustBluerSize(mMovie, "Bluer")
	mMovie:OverrideMaterial("InputBg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"InputBg",
		"RectEdgeColor",
		_G.UIColorObject_White.r,
		_G.UIColorObject_White.g,
		_G.UIColorObject_White.b,
		0.5
	)
	mMovie:__wf_atom_1ca72041(
		"InputBg",
		"RectInnerColor",
		_G.UIColorObject_Black.r,
		_G.UIColorObject_Black.g,
		_G.UIColorObject_Black.b,
		0.75
	)
	mMovie:__wf_atom_50d60589("Input", 36, "")
	mMovie:__wf_atom_e57658c2("Input", 39, 32)

	if not Engine.IsPlayingWithController() then
		mMovie:__wf_atom_46a6af3b("Input")
	end

	mMovie:SetCallbacks("InputBtn", "InputBoxBtnFocused", "InputBoxBtnUnfocused", nil, "InputBoxBtnPressed")
	mMovie:__wf_atom_2dedec1a("InputBtn", 13, false)
	mMovie:__wf_atom_e57658c2("InputBtn", 12, 75)
	mMovie:__wf_atom_c90af43a("InputBtn", _G.UITexture_ClearSearch)
	mMovie:SetCallbacks("Include.Btn", nil, nil, nil, "IncludePressed")
	local module3 = require("Lotus.Interface.Components.Button")
	v2 = module3.CreateButton(
		mMovie,
		"AddFilterBtn",
		"/Lotus/Language/Menu/SocialOverlay_Add",
		"AddFilter",
		"",
		nil,
		nil,
		true
	)
	v2.mWidth = 75
	v2.mAlignment = "center"
	v2:Redraw()
	v6 = mMovie:__wf_atom_5e6e15c8("InputPrompt", 0)
	mMovie:__wf_atom_50d60589("InputPrompt", 57, "dynamic")
	v7 = mMovie:__wf_atom_5e6e15c8("InputBg", 14)
	__wf_atom_86cbd68d(mMovie, "Include.Checkbox.gotoAndStop", "On")
	mMovie:__wf_atom_7d7314f1("FiltersTitle.text", "/Lotus/Language/Menu/FilterMgr_ActiveFilters")
	fn8()
	fn6()
	mMovie:OverrideMaterial("Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"Bg",
		"RectEdgeColor",
		_G.UIColorObject_White.r,
		_G.UIColorObject_White.g,
		_G.UIColorObject_White.b,
		0.2
	)
	mMovie:__wf_atom_1ca72041(
		"Bg",
		"RectInnerColor",
		_G.UIColorObject_Black.r,
		_G.UIColorObject_Black.g,
		_G.UIColorObject_Black.b,
		0.2
	)
	fn()
end

function onViewportSizeChanged(_, _)
	module.AdjustBluerSize(mMovie, "Bluer")
end

function SetOnCloseFunction(p)
	v = p
end

function SetChannelName(value)
	local channel = string.upper(value)
	mMovie:__wf_atom_7d7314f1("Title.text", "/Lotus/Language/Menu/Chat_FilterMgrTitle", {
		CHANNEL = channel
	})
end

function SetChannel(p)
	v3 = p
	fn7()
	flag = false
end

fn2 = function()
	if flag then
		return
	end

	include = not include
	__wf_atom_86cbd68d(mMovie, "Include.Checkbox.gotoAndStop", module2.Ternary(include, "On", "Off"))
end

function IncludePressed()
	fn2()
end

function FilterSelected(p)
	if not (flag or __wf_atom_7e8ad928(v4)) then
		v4:SelectElementById((tonumber(p)))
	end
end

function FilterFocused(p)
	if not __wf_atom_7e8ad928(v4) then
		v4:FocusElementById((tonumber(p)))
	end
end

function FilterUnfocused(p)
	if not __wf_atom_7e8ad928(v4) then
		v4:UnfocusElementById((tonumber(p)))
	end
end

function InputBoxBtnFocused()
	mMovie:__wf_atom_e57658c2("InputBtn", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("InputBtn", 12, 75)
end

function InputBoxBtnUnfocused()
	mMovie:__wf_atom_e57658c2("InputBtn", 11, _G.UIColor_White)
	mMovie:__wf_atom_e57658c2("InputBtn", 12, 100)
end

function InputBoxBtnPressed()
	mMovie:__wf_atom_50d60589("Input", 36, "")
	mMovie:__wf_atom_46a6af3b("Input")
end

function OSKFilterTypedCallback(p, p2)
	if not p then
		fn5(p2)
	end
end

function FilterTypedCallback(p, _, p2)
	if not __wf_atom_7e8ad928(p2) and tonumber(p2) == 4 then
		fn5(p)
	end
end

function onKeyDown_MENU_GENERIC1()
	if not flag and Engine.IsPlayingWithController() then
		module.ShowInputDialog(
			mMovie,
			"/Lotus/Language/Menu/FilterMgr_AddFilter",
			mMovie:__wf_atom_387f260e("Input", 36),
			32,
			"FilterTypedCallback",
			"OSKFilterTypedCallback",
			{ isMultiline = false }
		)
	end
end

function onKeyDown_MENU_GENERIC2()
	if not flag then
		fn2()
	end
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not (flag or __wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(v4.mScrollBar)) then
		v4.mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

function onKeyDown_MENU_SELECT()
	if not Engine.IsPlayingWithController() then
		fn5()
	end
end

function OnGamepadTransition(_)
	mMovie:__wf_atom_2004c47f()
	fn8()
end