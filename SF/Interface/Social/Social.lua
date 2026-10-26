local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("Lotus.Interface.UIUtilities")
local module4 = require("Lotus.Interface.LotusUtilities")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local module6 = require("EE.Interface.AnchorMgr")
local module7 = require("SF.Scripts.Libs.QuestLib")
local module8 = require("SF.Interface.Components.Button")
local v = false
local v2 = nil
local v3 = false
local v4 = nil
local position = Vector()
local v5 = Rotation()
local v6 = 0
local heading = 0
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = {}
local v11 = {}
local socialLocation = nil
local v12 = "votes"
local v13 = "date"
local v14 = nil
local v15 = nil
local v16 = nil
local total = 0
local v17 = ""
local v18 = ""
local v19 = nil
local v20 = nil
local v21 = false
local v22 = false
local flag = false
local v23 = false
local v24 = nil
local v25 = nil
local v26 = {}
local v27 = nil
local mVisRangeMaterials = {}
local v28 = false
local v29 = nil
local uiTexture_ProfilePlaceHolder = nil
local v30 = false
local v31 = false
local flag2 = true
local v32 = nil
local v34 = nil
local v35 = nil
local total2 = 0
local mScroll = nil
local v36 = 100
local v37 = 100
local v38 = false
local v39 = nil
local v40 = nil
local v41 = false
local v42 = {}
local v43 = {}
local v44 = {}
local v45 = {}
local v46 = {}
local v47 = {}
local v48 = {}
local v49 = nil

local function fn()
	return #v26 > 0
end

local function fn2()
	return v24 ~= nil
end

local function fn3(value)
	if __wf_atom_b953295d():c_str() ~= "_en" then
		return ""
	end

	local v50

	if Engine.__wf_atom_fc67ba71() then
		local v51 = string.gsub(value, "_EAST$", "")
		v50 = string.gsub(v51, "_WEST$", "")
	else
		local v51 = string.gsub(value, "_EAST$", "_E")
		v50 = string.gsub(v51, "_WEST$", "_W")
	end

	local v51 = string.gsub(v50, "NORTH_AMERICA", "NA")
	local v52 = string.gsub(v51, "SOUTH_AMERICA", "SA")
	local v53 = string.gsub(v52, "OCEANIA", "AS")
	local v54 = string.gsub(v53, "SOUTH_AMERICA", "SA")

	if not string.find(v54, "_") and string.len(v54) > 2 then
		v54 = string.sub(v54, 1, 2)
	end

	return "_" .. v54
end

local function fn4()
	socialLocation = _T.SocialLocation

	if not socialLocation then
		socialLocation = ""
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_35ea3fce = __wf_atom_18a5d83b:Settings():__wf_atom_35ea3fce()
		socialLocation ..= string.upper(__wf_atom_b953295d():c_str())
		socialLocation ..= fn3(__wf_atom_35ea3fce:__wf_atom_74123a24())
	end
end

function SetCamSpot(p, value, object)
	if __wf_atom_7e8ad928(object) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			object = __wf_atom_c4f78a8f:CameraControl()
		end
	end

	local __wf_atom_1b3db7e0 = object:__wf_atom_1b3db7e0()
	object:__wf_atom_fd14c463(0)
	object:SetCameraSpot(p, value or 0.5)
	object:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
end

local function fn5(list)
	if #list > 0 then
		_T.gToolTip = mMovie:__wf_atom_8e9ac384(list, false)
	else
		_T.gToolTip = nil
	end
end

local function fn6(p, p2)
	module.PlaySound(_G.UISound_Focus)
	__wf_atom_ec43d06e(mMovie, p, 2, { 5, 6, 12 }, { 110, 110, 120 }, 0.334)
	fn5(p2)
end

local function fn7(p, value)
	module.PlaySound(_G.UISound_Unfocus)
	__wf_atom_ec43d06e(mMovie, p, 2, { 5, 6, 12 }, { 100, 100, value or 100 }, 0.334)
	fn5()
end

local function fn8()
	_T.InfoPopup_Data = nil
	fn5()
end

local function fn9()
	if not __wf_atom_7e8ad928(v15) then
		gRegion:__wf_atom_dd1e4d10(v15)
		SetCamSpot(nil, 1)
	end

	module.PlaySound(closeSound)
	RemoveMixEffect()
	module4.RegisterHideHud(false)
	module2.DissolveOutAndClose(mMovie)
	_T.MapRequestLocationCB = nil
	fn8()
end

local function fn10()
	v9:RemoveElements(true, true)
	module.PlaySound(showPostsSound)

	for _, v50 in v10 do
		v9:AddElement(v50, true)
	end

	if v38 then
		v9:AddElement({ FetchTimeline = true }, true)
	end

	if mScroll ~= nil then
		v9.mScroll = mScroll
	end

	v9:Redraw()
end

local function fn11()
	local _, v50 = module.GetScreenDimensions(mMovie)
	local v51 = v50 - (mMovie:__wf_atom_5e6e15c8("TopRight.Posts", 3) - 71)

	if _T.GetButtonBarOffset == nil then
		return v51 - mMovie:__wf_atom_54eeda24() * 0.05
	end

	return v51 - (_T.GetButtonBarOffset() + 20)
end

function OnPinned(p, _)
	if p then
		local v50 = v10[v32]
		v50.Pinned = not v50.Pinned
		fn10()
	end

	v32 = nil
end

function ConfirmPin(p)
	if tonumber(p) == 4 and not __wf_atom_7e8ad928(v32) then
		gGameData:__wf_atom_1904df18(v10[v32]._id, "OnPinned")
	else
		v32 = nil
	end
end

function PinRollOver(_, p)
	module.PlaySound(_G.UISound_Focus)
	__wf_atom_ec43d06e(mMovie, p, 8, { 5, 6, 12 }, { 88, 88, 100 }, 0.35)
end

function PinRollOut(p, p2)
	local v50 = v10[p]

	if v50 == nil then
		return
	end

	if v50.Pinned then
		__wf_atom_ec43d06e(mMovie, p2, 8, { 5, 6, 12 }, { 77, 77, 100 }, 0.35)
	else
		__wf_atom_ec43d06e(mMovie, p2, 8, { 5, 6, 12 }, { 77, 77, 35 }, 0.35)
	end
end

function PinPressed(p)
	local mPostId = p.mPostId
	local v50 = v10[mPostId]

	if v50 == nil then
		return
	end

	v32 = mPostId
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/PinPostMessage", true, {
		PLAYER_NAME = v50.N,
		TEXT = v50.T
	})

	if v50.Pinned then
		dialogSettings.firstString = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/RemovePinPostConfirm", true)
	else
		dialogSettings.firstString = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/PinPostConfirm", true)
	end

	dialogSettings.alignment = 0
	dialogSettings.icon = confirmIcon:__wf_atom_5b41f63b() .. ",100,100"
	dialogSettings:SetCallback("ConfirmPin")
	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
end

local function fn12(value)
	local v50 = string.gsub(value, "^%l", string.upper)
	return (string.gsub(v50, "[.?!]%s?%l", string.upper))
end

local function fn13(value, revealed)
	local v50 = string.find(value, "%[")

	if not v50 then
		return false, value
	end

	local v51 = {}

	while v50 do
		local v52 = string.sub(value, 1, v50 - 1)

		if v52 then
			table.insert(v51, v52)
		end

		local v53 = string.find(value, "%]")

		if not v53 or v53 < v50 then
			v53 = string.len(value) + 1
		end

		table.insert(v51, (string.sub(value, v50 + 1, v53 - 1)))
		value = string.sub(value, v53 + 1)
		v50 = string.find(value, "%[")
	end

	local v52 = 0
	local v53 = "<p>"
	local v54 = { "Spectral Italic", "OdeBook" }

	for i = 1, #v51 do
		if v52 == 1 and revealed then
			v53 ..= "<font face=\"" .. v54[1] .. "\" color=\"#303030\">" .. v51[i] .. "</font>"
		else
			v53 ..= "<font face=\"" .. v54[v52 + 1] .. "\" color=\"#000000\">" .. v51[i] .. "</font>"
		end

		v52 = (v52 + 1) % 2
	end

	return true, v53 .. "</p>"
end

local function fn14(value)
	local v50 = 0
	local result = {}

	while true do
		local v51 = string.find(value, "|", v50)
		local v52 = v51 and string.find(value, "|", v51 + 1)

		if not v52 then
			break
		end

		local v53 = string.sub(value, v51 + 1, v52 - 1)

		if v53 == "VERB" then
			table.insert(result, { "VERB", v48 })
		elseif v53 == "ADJ" then
			table.insert(result, { "ADJ", v47 })
		elseif v53 == "NOUN" then
			table.insert(result, { "NOUN", v46 })
		end

		v50 = v52 + 1
	end

	return result
end

local function fn15(list)
	local v50 = 1
	local v51 = ""

	while v50 <= #list do
		local c_str = list[v50]:c_str()
		local v52 = Localize("/SF/Language/Phrases/" .. c_str, "")
		v50 += 1

		if v51 ~= "" then
			v51 ..= "\r\n"
		end

		local v53 = fn14(v52)
		local v54 = { NOUN = "__", VERB = "__", ADJ = "__" }

		for i = 1, #v53 do
			if not (v50 <= #list) then
				continue
			end

			v54[v53[i][1]] = Localize("/SF/Language/Phrases/" .. list[v50]:c_str(), "")
			v50 += 1
		end

		v51 ..= Localize("/SF/Language/Phrases/" .. c_str, v54)
	end

	return v51
end

local function fn16(t)
	local v50 = {}

	for k in string.gmatch(t, "([^,]+)") do
		table.insert(v50, Symbol(k))
	end

	return fn15(v50)
end

local function fn17(slot)
	mMovie:__wf_atom_2dedec1a("TopLeft.Selector.Back", 13, false)
	v41 = true

	if v40 then
		v40:RemoveElements(true, true)
	end

	if not v40 then
		local module9 = require("EE.Interface.Components.Grid")
		v40 = module9.CreateNewGrid(getfenv(1), "TopLeft.Selector.Grid.Item", {
			mRows = 6,
			mColumns = 3,
			mColumnSeparation = 360,
			mRowSeparation = 100,
			mEasing = 7
		})
		mMovie:__wf_atom_4c1c1986("TopLeft.Selector", "TitleBar.Title.Text", 44, _G.UIColor_Yellow)
		mMovie:OverrideMaterial("TopLeft.Selector.TitleBar.Backer", _G.UIMaterial_FocusedTabBorder)
		v40:AttachScrollBar("TopLeft.Selector.ScrollBar", {
			mVisRangeMaterials = { _G.UIMaterial_VerticalVisibilityRangeText, _G.UIMaterial_VerticalVisibilityRange }
		})

		function v40.mClipCreatedCallback(p)
			mMovie:OverrideMaterial(p .. ".Bg", _G.UIMaterial_VerticalVisibilityRange)
			mMovie:OverrideMaterial(p .. ".Text", _G.UIMaterial_VerticalVisibilityRangeText)
		end

		function v40:mElementDrawCallback()
			local mClipName = self.mClipName
			local variation = self.mIndex % 4

			if self.variation ~= variation then
				self.variation = variation

				if variation == 1 then
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 5, -100)
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 6, 100)
				elseif variation == 2 then
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 6, -100)
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 5, 100)
				elseif variation == 3 then
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 5, -100)
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 6, -100)
				end
			end

			mMovie:__wf_atom_48bd5a59(mClipName, "Text", 36, self.T)
		end

		function v40.mOnSelectedCallback(p)
			table.insert(v43, p.V)
			module.PlaySound(writingSound)
			local v50 = fn14(p.TextAndTags)

			for i = 1, #v50 do
				table.insert(v42, v50[i][2])
			end

			mMovie:__wf_atom_50d60589("TopLeft.Send.Text", 36, fn15(v43))
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("TopLeft.Send.Text", 41)
			mMovie:__wf_atom_e57658c2("TopLeft.Send.Text", 1, -20 - __wf_atom_5e6e15c8 / 2)

			if v40.Slot < #v42 then
				v49:AddTimer(0, function()
					fn17(v40.Slot + 1)
				end)
			elseif table.find(v42, v45) == nil then
				table.insert(v42, v45)
				v49:AddTimer(0, function()
					fn17(v40.Slot + 1)
				end)
			else
				__wf_atom_ec43d06e(mMovie, "TopLeft.Selector", 2, { 5, 6, 12 }, { 80, 80, 0 }, 0.334)
				v41 = false
				v7:SetActive(true)
				v7:SetVisible(true)
			end
		end
	end

	local v50 = v42[slot]
	v40.Slot = slot
	local v51

	if v50 == v44 then
		v51 = "/SF/Language/Phrases/SelectPhrase"
	elseif v50 == v45 then
		v51 = "/SF/Language/Phrases/SelectAction"
	elseif v50 == v46 then
		v51 = "/SF/Language/Phrases/SelectNoun"
	elseif v50 == v47 then
		v51 = "/SF/Language/Phrases/SelectAdjective"
	elseif v50 == v48 then
		v51 = "/SF/Language/Phrases/SelectVerb"
	else
		v51 = ""
	end

	mMovie:__wf_atom_7d7314f1("TopLeft.Selector.TitleBar.Title.Text.text", v51)

	for k, _ in v50 do
		local v52 = "/SF/Language/Phrases/" .. v50[k]:c_str()
		local textAndTags = Localize(v52, "")
		local v54 = {
			T = Localize(v52, { NOUN = "_", VERB = "_", ADJ = "_" }),
			TextAndTags = textAndTags,
			V = v50[k]
		}
		v40:AddElement(v54, true)
	end

	v40:Redraw()
end

local function fn18()
	local v50 = MongoDateTime()
	v50.sec = string.format("%u", gGameRules:__wf_atom_93691ff2())
	local v51 = MongoDateTime()
	local module9 = require("EE.Interface.Components.List")
	v9 = module9.CreateNewList(getfenv(1), "TopRight.Posts.Post")
	v9.mForcedVerticalSeparation = 142
	v9.mElementTransitionTime = 0.5
	v9.mElementDelayTime = 0.05
	v9.mEasing = 7
	v9:AttachScrollBar("TopRight.Posts.ScrollBar", {
		mVisRangeMaterials = mVisRangeMaterials,
		mVisRangeFadeSize = 20,
		mHeight = fn11()
	})

	function v9.GetInterpolationProperties(_, _)
		return { 5, 6, 12 }, { 100, 100, 85 }
	end

	function v9.SetupPreInterpolationValues(_, p)
		local mClipName = p.mClipName
		mMovie:__wf_atom_e57658c2(mClipName, 5, 50)
		mMovie:__wf_atom_e57658c2(mClipName, 6, 50)
		mMovie:__wf_atom_e57658c2(mClipName, 12, 0)
		p.TransitionIn = true
	end

	function v9.OnElementTransitionEnded(p, p2)
		p2.TransitionIn = nil

		if p.mCurrentElementIndex == p2.mIndex then
			v9.mOnFocusedCallback(p2)
		end
	end

	function v9.CalculateX(_, p)
		if p.mIndex == 1 or not fn() then
			return 0
		end

		return 20
	end

	function v9.mClipCreatedCallback(p)
		mMovie:SetCallbacks(p .. ".AvatarImage", "ItemRollOver", "ItemRollOut", nil, nil)
		mMovie:SetCallbacks(p .. ".Location", "LocationRollOver", "LocationRollOut", "LocationPressed", nil)
		mMovie:SetCallbacks(
			p .. ".PostOptions.Btn",
			"ExpandMenuRollOver",
			"ExpandMenuRollOut",
			nil,
			"ExpandMenuPressed"
		)
		mMovie:SetCallbacks(p .. ".PostOptions.Options.Btn", "OptionsRollOver", "OptionsRollOut", nil, "OptionsPressed")
		mMovie:SetCallbacks(p .. ".Votes.Vote", "VoteRollOver", "VoteRollOut", "VoteReleased", "VotePressed")
		mMovie:__wf_atom_7f57ab2f(p, "Replies.Reply", 13, false)
		mMovie:SetCallbacks(p .. ".Reveal", "RevealRollOver", "RevealRollOut", nil, "RevealPressed")
		mMovie:__wf_atom_48bd5a59(p, "Age", 46, "bottom")
		mMovie:__wf_atom_4c1c1986(p, "Bg", 12, 85)
		mMovie:__wf_atom_4c1c1986(p, "Age", 12, 85)
		mMovie:__wf_atom_4c1c1986(p, "Location", 12, 130)
		mMovie:__wf_atom_4c1c1986(p, "PostOptions.Btn", 12, 35)
		mMovie:__wf_atom_4c1c1986(p, "PostOptions.Options", 12, 0)
		mMovie:__wf_atom_4c1c1986(p, "PostOptions.Options", 0, 0)
		mMovie:__wf_atom_4c1c1986(p, "PostOptions.Options", 1, 0)
		mMovie:__wf_atom_4c1c1986(p, "PostOptions.Options", 5, 1)
		mMovie:__wf_atom_4c1c1986(p, "PostOptions.Options", 6, 1)
		mMovie:__wf_atom_7f57ab2f(p, "PostOptions.Options", 13, false)
		mMovie:OverrideMaterial(p .. ".Bg", iconVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Location", iconVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Watermark", iconVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".PostOptions.Btn", iconVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".PostOptions.Btn.Cross", iconVisRangeMaterial)
		mMovie:__wf_atom_7f57ab2f(p, "Item1", 13, false)
		mMovie:OverrideMaterial(p .. ".Replies.Reply", iconVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Votes.Vote", iconVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Votes.Vote.Inner", iconVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Votes.Vote.Flame", heartMaterial)
		mMovie:OverrideMaterial(p .. ".Text", textVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Name", textVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Age", textVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Replies.Count", textVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Votes.Count", textVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".AvatarImage", motiffVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".AvatarBg", iconVisRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Reveal", iconVisRangeMaterial)
	end

	function v9:mElementDrawCallback()
		local mClipName = self.mClipName
		local mIndex = self.mIndex
		local v52 = not self.FetchTimeline
		mMovie:__wf_atom_7f57ab2f(mClipName, "Age", 13, v52)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Text", 13, v52)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Votes", 13, v52)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Replies", 13, v52)
		mMovie:__wf_atom_7f57ab2f(mClipName, "AvatarBg", 13, v52)
		mMovie:__wf_atom_7f57ab2f(mClipName, "AvatarImage", 13, v52)
		mMovie:__wf_atom_7f57ab2f(mClipName, "PostOptions", 13, v52)

		if self.FetchTimeline then
			mMovie:__wf_atom_7f57ab2f(mClipName, "Reveal", 13, false)
			mMovie:__wf_atom_7f57ab2f(mClipName, "Location", 13, false)
			mMovie:__wf_atom_7d7314f1(mClipName .. ".Name.text", "/SF/Language/Social/LoadMorePosts")
		else
			mMovie:__wf_atom_4c1c1986(mClipName, "AvatarImage", 100, mIndex)
			mMovie:__wf_atom_4c1c1986(mClipName, "Location", 100, mIndex)
			mMovie:__wf_atom_4c1c1986(mClipName, "PostOptions.Btn", 100, mIndex)
			mMovie:__wf_atom_4c1c1986(mClipName, "PostOptions.Options.Btn", 100, mIndex)
			mMovie:__wf_atom_4c1c1986(mClipName, "Votes.Vote", 100, mIndex)
			mMovie:__wf_atom_4c1c1986(mClipName, "Replies.Reply", 100, mIndex)
			mMovie:__wf_atom_4c1c1986(mClipName, "Reveal", 100, mIndex)
			local variation = mIndex % 4

			if self.variation ~= variation then
				self.variation = variation

				if variation == 1 then
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 5, -100)
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 6, 100)
				elseif variation == 2 then
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 6, -100)
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 5, 100)
				elseif variation == 3 then
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 5, -100)
					mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 6, -100)
				end
			end

			mMovie:__wf_atom_7f57ab2f(mClipName, "Location", 13, #self.C > 0)
			local v54 = fn16(self.T)

			if string.sub(v54, 1, 1) == "/" then
				v54 = mMovie:__wf_atom_8e9ac384(self.T, true)
			end

			local v55, v56 = fn13(v54, self.Revealed)
			mMovie:__wf_atom_48bd5a59(mClipName, "Text", 36, fn12(v56))

			if self.Revealed then
				v55 = false
			end

			mMovie:__wf_atom_7f57ab2f(mClipName, "Reveal", 13, v55)
			local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(mClipName, "Text", 41)
			mMovie:__wf_atom_4c1c1986(mClipName, "Text", 1, -__wf_atom_cfc41e35 / 2 - 5)
			mMovie:__wf_atom_48bd5a59(mClipName, "Name", 36, self.N)
			v51.sec = MongoId(self._id):__wf_atom_f1a88c30()
			local v58 = math.max(0, v51:__wf_atom_8f70d89f(v50))
			local v59

			if v58 <= 0 then
				v59 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/NowTime", false)
			else
				v59 = module4.SecondsToFormattedTime(mMovie, v58, "CompactOne")
				local v60 = __wf_atom_421b01aa(v58 / 2592000, 0, 1)
				mMovie:__wf_atom_4c1c1986(mClipName, "Age", 12, __wf_atom_104bfe98(100, 40, v60))
			end

			local v60 = fn()

			if v60 and v13 == "reports" or not v60 and v12 == "reports" then
				v59 ..= "\rreports: " .. self.X
			end

			mMovie:__wf_atom_48bd5a59(mClipName, "Age", 36, v59)

			if v11[self._id] or self.U == v17 then
				mMovie:__wf_atom_4c1c1986(mClipName, "Votes.Vote.Inner", 11, 16777215)
			else
				mMovie:__wf_atom_4c1c1986(mClipName, "Votes.Vote.Inner", 11, _G.UIColor_FadedTint)
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "Votes.Vote.Flame", 12, 0)

			if self.V > 0 then
				local v61

				if self.V < 1000 then
					v61 = tostring(self.V)
				else
					v61 = module.FormatNumber(self.V / 1000, 1) .. "k"
				end

				mMovie:__wf_atom_48bd5a59(mClipName, "Votes.Count", 36, v61)

				if self.V >= 100 then
					local v62 = __wf_atom_421b01aa((self.V - 100) / 500, 0.5, 1)
					mMovie:__wf_atom_4c1c1986(mClipName, "Votes.Vote.Flame", 12, 100)
					mMovie:__wf_atom_4c1c1986(mClipName, "Votes.Vote.Flame", 5, v62 * 112)
					mMovie:__wf_atom_4c1c1986(mClipName, "Votes.Vote.Flame", 6, v62 * 112)
				end
			else
				mMovie:__wf_atom_48bd5a59(mClipName, "Votes.Count", 36, "")
			end

			if self.R > 0 then
				local v61

				if self.R < 1000 then
					v61 = tostring(self.R)
				else
					v61 = module.FormatNumber(self.R / 1000, 1) .. "k"
				end

				mMovie:__wf_atom_48bd5a59(mClipName, "Replies.Count", 36, v61)
			else
				mMovie:__wf_atom_48bd5a59(mClipName, "Replies.Count", 36, "")
			end

			local uiTexture_ProfilePlaceHolder2 = _G.UITexture_ProfilePlaceHolder
			local __wf_atom_a6382ae5 = gGameData:__wf_atom_a4299765():__wf_atom_a6382ae5()

			if not (__wf_atom_7e8ad928(__wf_atom_a6382ae5) or __wf_atom_7e8ad928(__wf_atom_a6382ae5.mItemType)) then
				local v61 = Resource(__wf_atom_a6382ae5.mItemType)

				if not __wf_atom_7e8ad928(v61) then
					uiTexture_ProfilePlaceHolder2 = module5.GetIconTexture(v61, true)
				end
			end

			mMovie:__wf_atom_c90af43a(mClipName .. ".AvatarImage", uiTexture_ProfilePlaceHolder2)
		end
	end

	function v9.mOnFocusedCallback(data)
		if data.TransitionIn then
			return
		end

		module.PlaySound(_G.UISound_Focus)
		local mClipName = data.mClipName

		if mClipName ~= nil then
			mMovie:__wf_atom_e57658c2(mClipName, 12, 100)
			mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 12, 100)
		end

		local _fetchTimeline = data.FetchTimeline
	end

	function v9.mOnUnfocusedCallback(p)
		if p.TransitionIn then
			return
		end

		module.PlaySound(_G.UISound_Unfocus)
		local mClipName = p.mClipName

		if mClipName ~= nil then
			__wf_atom_ec43d06e(mMovie, mClipName, 8, { 12 }, { 85 }, 0.35)
			__wf_atom_ec43d06e(mMovie, mClipName .. ".Bg", 8, { 12 }, { 85 }, 0.35)
		end

		fn5()
	end

	function v9.mOnSelectedCallback(data)
		if data.FetchTimeline then
			FetchTimeline(nil, nil, true)
		else
			PostPressed(data.mIndex, data.mClipName)
		end
	end
end

function PostComplete(p, p2)
	flag = false

	if p and v29 then
		local decoded = cjson.decode(p2)
		v29._id = decoded.messageId["$oid"]
		table.insert(v10, 1, v29)
		v21 = false
		mMovie:__wf_atom_7d7314f1("TopLeft.Send.Input.text", "/SF/Language/Menu/PostText")
		fn10()
		InputTextChanged(1, "TopLeft.Send.Input")
	elseif p and fn2() then
		v22 = false

		if v24.R then
			v24.R += 1
		else
			v24.R = 1
		end

		if v24.R > 0 then
			local v50

			if v24.R < 1000 then
				v50 = tostring(v24.R)
			else
				v50 = module.FormatNumber(v24.R / 1000, 1) .. "k"
			end

			mMovie:__wf_atom_48bd5a59("TopRight.Posts.Post" .. v25, "Replies.Count", 36, v50)
		else
			mMovie:__wf_atom_48bd5a59("TopRight.Posts.Post" .. v25, "Replies.Count", 36, "")
		end

		InputTextChanged(2, "TopRight.Reply.Input")
	end

	v29 = nil
end

local function fn19(p)
	local formatNumber = module.FormatNumber(p, 1)
	return (string.gsub(formatNumber, ",", ""))
end

local function fn20(p, p2)
	module.PlaySound(postSound)
	flag = true
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local encoded = ""

	if v35 then
		if not __wf_atom_7e8ad928(_T.GetFlashMarker) then
			local flashMarker = _T.GetFlashMarker(playerMarkerInfo)

			if not __wf_atom_7e8ad928(flashMarker) then
				local v50 = {
					x = fn19(flashMarker.pos.x),
					y = fn19(flashMarker.pos.y),
					z = fn19(flashMarker.pos.z)
				}
				encoded = cjson.encode(v50)
			end
		end
	else
		local position2 = __wf_atom_c4f78a8f:GetPosition()
		local heading2 = __wf_atom_c4f78a8f:__wf_atom_4e50d390().heading
		local v50 = {
			x = fn19(position2.x),
			y = fn19(position2.y),
			z = fn19(position2.z),
			h = fn19(heading2)
		}
		encoded = cjson.encode(v50)
	end

	local v50 = socialLocation
	local v51 = {}
	local __wf_atom_35a10d3c = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
	local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		table.insert(v51, __wf_atom_35a10d3c:__wf_atom_1bb5b1ff())
	end

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		table.insert(v51, __wf_atom_e55d02aa:__wf_atom_1bb5b1ff())
	end

	if p2 == "" then
		v29 = {
			U = v17,
			L = v50,
			C = encoded,
			T = p,
			I = v51,
			V = 0,
			N = v18,
			R = 0
		}
	end

	v35 = false
	mMovie:__wf_atom_2dedec1a("TopLeft.Send.Location.Glow", 13, false)
	mMovie:__wf_atom_2dedec1a("TopRight.Reply.Location.Glow", 13, false)
	gGameData:__wf_atom_81736003(v50, encoded, p, v51, p2, "PostComplete")
end

local function fn21(cost, __wf_atom_7050e489)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	dialogSettings.locString = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/InsufficientDracs", true, {
		COST = cost,
		AMOUNT = __wf_atom_7050e489
	})
	dialogSettings:SetCallback("")
	dialogSettings.alignment = 0
	dialogSettings.icon = moneyIcon:__wf_atom_5b41f63b() .. ",100,100"
	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
end

local function fn22(value)
	if not v and string.sub(value, 1, 1) == "/" then
		value = string.sub(value, 2)
	end

	return (__wf_atom_f8f86fc5(value, 0))
end

function CharacterLimitReached()
	module.PlaySound(_G.UISound_Error)
end

function InputTextChanged(p, p2)
	local v50

	if p == 1 then
		v50 = v7
	else
		v50 = v8
	end

	if v50 == nil then
		return
	end

	local v51

	if p == 1 then
		v51 = v21
	else
		v51 = v22
	end

	v50:SetActive(v51 and #mMovie:__wf_atom_387f260e(p2, 36) > 0)
end

function PostButtonPressed()
	if flag then
		return
	end

	local __wf_atom_7050e489 = gGameData:__wf_atom_7050e489()

	if __wf_atom_7050e489 < 50 then
		fn21(50, __wf_atom_7050e489)
		return
	end

	if not v43 or #v43 < 1 then
		return
	end

	local v50 = ""

	for i = 1, #v43 do
		if i > 1 then
			v50 ..= ","
		end

		v50 ..= v43[i]:c_str()
	end

	fn20(v50, "")
	v28 = false
	__wf_atom_ec43d06e(mMovie, "TopLeft.Send", 2, { 5, 6, 12 }, { 96, 96, 0 }, 0.334)
	v7:SetActive(false)
	v7:SetVisible(false)
end

function ReplyButtonPressed()
	if flag then
		return
	end

	local __wf_atom_7050e489 = gGameData:__wf_atom_7050e489()

	if __wf_atom_7050e489 < 25 then
		fn21(25, __wf_atom_7050e489)
		return
	end

	local v50 = fn22(mMovie:__wf_atom_387f260e("TopRight.Reply.Input", 36))
	mMovie:__wf_atom_50d60589("TopRight.Reply.Input", 36, v50)
	fn20(v50, v24._id)
	v8:SetActive(false)
end

function OptionsRollOver(p)
	local v50 = v10[p]

	if v50 == nil or v50.mClipName == nil then
		return
	end

	local v51 = v50.mClipName .. ".PostOptions.Options.Btn"
	mMovie:__wf_atom_290807ee(v51)
end

function OptionsRollOut(p)
	local v50 = v10[p]

	if v50 == nil or v50.mClipName == nil then
		return
	end

	local v51 = v50.mClipName .. ".PostOptions.Options.Btn"
	__wf_atom_ec43d06e(mMovie, v51, 0, {}, {}, 0, 0.2, function()
		ToggleExpandedOptions(p, true)
	end)
end

function ExpandMenuRollOver(p, p2)
	fn6(p2, "/SF/Language/Social/Options")
	OptionsRollOver(p)
end

function ExpandMenuRollOut(p, p2)
	fn7(p2, 35)
	OptionsRollOut(p)
end

function ReportRollOver(_, p)
	fn6(p, "/SF/Language/Social/Report")
	__wf_atom_ec43d06e(mMovie, p .. ".Hover", 2, { 12 }, { 100 }, 0.334)
end

function ReportRollOut(_, p)
	fn7(p)
	__wf_atom_ec43d06e(mMovie, p .. ".Hover", 2, { 12 }, { 0 }, 0.334)
end

local function fn23(p)
	if p == nil then
		return "/SF/Language/Social/Error"
	end

	if p.U == v17 then
		return ""
	end

	if v11[p._id] then
		return "/SF/Language/Social/Voted"
	end

	return nil
end

function VoteRollOver(p, p2)
	if v30 or not v31 then
		return
	end

	local v51 = fn23(v10[p])

	if v51 then
		fn5(v51)
	else
		fn6(p2, "/SF/Language/Social/Vote")
	end
end

function VoteRollOut(_, p)
	v16 = nil
	fn7(p)
end

function VotePressed(p, p2)
	if v30 or not v31 or flag or fn23(v10[p]) then
		return
	end

	v19 = module.CreateUIParticles(mMovie, p2, purchaseHoldFx, 0, 0)
	v20 = module.PlaySound(purchaseHoldSound)
	v16 = p
	total = 0
end

function VoteReleased(_)
	v16 = nil

	if not __wf_atom_7e8ad928(v19) then
		v19:Destroy()
	end

	if not __wf_atom_7e8ad928(v20) then
		v20:Stop(false)
	end
end

local function fn24(p, p2)
	local mElement = v9.mElements[p]

	if mElement == nil then
		return
	end

	if p2 == false then
		local v50 = {
			mMovie:__wf_atom_5e6e15c8("TopRight.Posts", 0),
			mMovie:__wf_atom_5e6e15c8("TopRight.Posts", 1) + mMovie:__wf_atom_5e6e15c8(mElement.mClipName, 1)
		}
		__wf_atom_ec43d06e(mMovie, "TopRight.ReplyPost", 2, { 0, 1 }, v50, 0.3, 0, function()
			mMovie:__wf_atom_2dedec1a("TopRight.ReplyPost", 13, false)
			mMovie:__wf_atom_2dedec1a("TopRight.Posts", 67, true)
			mMovie:__wf_atom_2dedec1a("TopRight.SortButtons.TopPosts", 13, true)
			mMovie:__wf_atom_2dedec1a("TopRight.SortButtons.NewPosts", 13, true)
		end)
	else
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("TopRight.Posts", 0)

		if p == 1 and fn2() then
			fn()
		end

		mMovie:__wf_atom_e57658c2("TopRight.ReplyPost", 0, __wf_atom_5e6e15c8)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("TopRight.Posts", 1)
		mMovie:__wf_atom_e57658c2(
			"TopRight.ReplyPost",
			1,
			__wf_atom_5e6e15c8_2 + mMovie:__wf_atom_5e6e15c8(mElement.mClipName, 1)
		)
		mMovie:__wf_atom_2dedec1a("TopRight.ReplyPost", 13, true)
		__wf_atom_ec43d06e(mMovie, "TopRight.ReplyPost", 2, { 0, 1 }, { __wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2 }, 0.3)
		v9.mClipCreatedCallback("TopRight.ReplyPost")
		local mClipName = mElement.mClipName
		mElement.mClipName = "TopRight.ReplyPost"
		v9.mElementDrawCallback(mElement)
		mElement.mClipName = mClipName
	end
end

local function fn25()
	if not (fn2() and v9.mElements[v25] ~= nil) then
		return
	end

	__wf_atom_ec43d06e(mMovie, "TopRight.Reply", 2, { 12 }, { 0 }, 0.3, 0, function()
		mMovie:__wf_atom_2dedec1a("TopRight.Reply", 13, false)
	end)
	__wf_atom_ec43d06e(mMovie, "TopRight.Posts", 2, { 12 }, { 100 }, 0.2, 0.1)
	fn24(v25, false)
	v24 = nil
end

function ReplyRollOver(_, p)
	if v30 or not v31 then
		return
	end

	fn6(p, "/SF/Language/Social/Reply")
end

function ReplyRollOut(_, p)
	fn7(p)
end

function ReplyPressed(p)
	if v30 or not v31 or flag then
		return
	end

	if v28 then
		WritePostPressed()
	else
		module.PlaySound(_G.UISound_Select)
	end

	if fn2() then
		fn25()
	else
		if v9.mElements[p] == nil then
			return
		end

		v22 = false
		v24 = v10[p]
		v25 = p
		mMovie:__wf_atom_7d7314f1("TopRight.Reply.Input.text", "/SF/Language/Menu/ReplyText")
		__wf_atom_ec43d06e(mMovie, "TopRight.Reply", 2, { 12 }, { 100 }, 0.2, 0.1)
		mMovie:__wf_atom_2dedec1a("TopRight.Reply", 13, true)
		__wf_atom_ec43d06e(mMovie, "TopRight.Posts", 2, { 12 }, { 0 }, 0.2)
		mMovie:__wf_atom_2dedec1a("TopRight.Posts", 67, false)
		fn24(p)
	end

	UpdateButtons()
end

local function fn26()
	module.PlaySound(hidePostsSound)
	fn25()
	v9:RemoveElements(true, true)
end

function OnTimeline(p, p2)
	flag = false

	if not p then
		return
	end

	local decoded = cjson.decode(p2)
	local posts = decoded.Posts
	v38 = #posts == 25

	for i = 1, #decoded.Votes do
		v11[decoded.Votes[i].P["$oid"]] = true
	end

	if total2 == 0 then
		v10 = {}

		if fn() then
			table.insert(v10, v26[#v26])
		end
	end

	for _, post in ipairs(posts) do
		post._id = post._id["$oid"]

		if _G.ReportedPosts[post._id] then
			continue
		end

		post.U = post.U["$oid"]

		if not post.V then
			post.V = 0
		end

		if not post.R then
			post.R = 0
		end

		if not post.X then
			post.X = 0
		end

		if post.P then
			post.P = post.P["$oid"]
		end

		post.Pinned = false

		if post.V >= 10000000 then
			post.V -= 10000000
			post.Pinned = true
		end

		table.insert(v10, post)
	end

	local v50 = {}

	for _, v51 in ipairs(v10) do
		local v52 = WeakResource(v51.I[2] or v51.I[1])

		if not __wf_atom_7e8ad928(v52) then
			table.insert(v50, (v52:__wf_atom_5b41f63b()))
		end
	end

	v2 = UISys.__wf_atom_c0dbe47c(v50, true)
	v3 = false
end

function FetchTimeline(p, p2, p3)
	if flag then
		return
	end

	if fn() then
		if p == nil then
			p = v13
		else
			v13 = p
		end
	elseif p == nil then
		p = v12
	else
		v12 = p
	end

	if p3 then
		total2 += 25
		mScroll = v9.mScroll
	else
		total2 = 0
		mScroll = nil
	end

	local v50 = p2 == true

	if not p2 then
		fn26()
	end

	v36 = p == "date" and 100 or 50
	v37 = p == "votes" and 100 or 50
	local v51 = 100
	local v52 = v36 < 100 and 100 or v51
	__wf_atom_ec43d06e(mMovie, "TopRight.SortButtons.NewPosts", 2, { 5, 6, 12 }, { v52, v52, v36 }, 0.334)
	local v53 = v37 < 100 and 100 or v51
	__wf_atom_ec43d06e(mMovie, "TopRight.SortButtons.TopPosts", 2, { 5, 6, 12 }, { v53, v53, v37 }, 0.334)
	flag = true
	gGameData:__wf_atom_d4807e0f(socialLocation, p, total2, 25, v50, "OnTimeline")
	UpdateButtons()
end

local function fn27()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local position2 = __wf_atom_c4f78a8f:GetPosition()
	local nearestTagged = gRegion:FindNearestTagged(Symbol("MapTree"), position2)
	local nearestTagged2 = gRegion:FindNearestTagged(Symbol("BabyAncestralTree"), position2)

	if __wf_atom_7e8ad928(nearestTagged) or __wf_atom_7e8ad928(nearestTagged2) then
		return
	end

	local __wf_atom_1c8f7b2d = __wf_atom_c4f78a8f:__wf_atom_1c8f7b2d(nearestTagged)
	local __wf_atom_1c8f7b2d2 = __wf_atom_c4f78a8f:__wf_atom_1c8f7b2d(nearestTagged2)

	if __wf_atom_1c8f7b2d2 < __wf_atom_1c8f7b2d then
		flag2 = true
		nearestTagged = nearestTagged2
		__wf_atom_1c8f7b2d = __wf_atom_1c8f7b2d2
	end

	if __wf_atom_1c8f7b2d > 20 then
		return
	end

	local gameCamera = gRegion:GetGameCamera()
	position = gameCamera:GetPosition()
	v5 = gameCamera:__wf_atom_dc309f8a()
	v6 = 0
	heading = v5.heading
	v14 = nearestTagged
	v15 = gRegion:CreateEntity(cameraSpotType, position, v5)
	v15:__wf_atom_888efbe9(40)
	v15:__wf_atom_7e990320(5000)
	v15:__wf_atom_8c3d9704(10)
	SetCamSpot(v15, 0.5)
end

local function fn28(p)
	if not (__wf_atom_7e8ad928(v15) or __wf_atom_7e8ad928(v14)) then
		heading += p * 3

		if heading > 360 then
			heading -= 360
		end

		local v50, v51, v52

		if flag2 then
			v50 = 15
			v51 = 8
			v52 = 1
		else
			v50 = 30
			v51 = 15
			v52 = 10
		end

		local v53 = __wf_atom_9341614d(Vector(0, 0, -1) * v50, Rotation(heading, 0, 0))
		local v54 = v14:GetPosition() + Vector(0, v51, 0) + v53
		v6 = __wf_atom_421b01aa(v6 + p * 0.25, 0, 1)
		local v55 = __wf_atom_24a82b69(v6)
		local v56 = __wf_atom_f55d6358(position, v54, v55)
		local v57 = __wf_atom_fa8d0177(v56, v14:GetPosition() + Vector(0, v52, 0))
		local v58 = __wf_atom_9d2f097a(v5, v57, v55)
		v15:Teleport(v56, v58)
	end
end

function UploadVoteDone(_, _)
	flag = false
end

local function fn29(id)
	if flag or v11[id] then
		return
	end

	flag = true
	v11[id] = true
	gGameData:__wf_atom_931d921b(MongoId(id), "UploadVoteDone")
end

local function fn30(p)
	if not v16 then
		return
	end

	local mElement = v9.mElements[v16]

	if mElement == nil then
		return
	end

	total += p
	local v50 = __wf_atom_421b01aa(total, 0, 1)
	__wf_atom_24a82b69(v50)
	local mClipName = mElement.mClipName

	if total >= 1 then
		v10[v16].V = v10[v16].V + 1
		local v51

		if v10[v16].V < 1000 then
			v51 = tostring(v10[v16].V)
		else
			v51 = module.FormatNumber(v10[v16].V / 1000, 1) .. "k"
		end

		mMovie:__wf_atom_48bd5a59(mClipName, "Votes.Count", 36, v51)
		mMovie:__wf_atom_4c1c1986(mClipName, "Votes.Vote.Inner", 11, 16777215)
		fn29(v10[v16]._id)
		v16 = nil
		module.CreateUIParticles(mMovie, mClipName .. ".Votes.Vote", unlockedFx, 0, 0)
		module.PlaySound(purchaseDoneSound)

		if not __wf_atom_7e8ad928(v19) then
			v19:Destroy()
		end

		if not __wf_atom_7e8ad928(v20) then
			v20:Stop(false)
		end
	end
end

function Update()
	local v50 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v50)

	if not __wf_atom_7e8ad928(v49) then
		v49:Update(v50)
	end

	fn28(v50)

	if flag ~= v23 then
		v23 = flag

		if v23 then
			__wf_atom_ec43d06e(mMovie, "TopRight.Spinner", 5, { 5, 6, 12 }, { 100, 100, 100 }, 0.35)
		else
			__wf_atom_ec43d06e(mMovie, "TopRight.Spinner", 6, { 5, 6, 12 }, { 50, 50, 0 }, 0.35)
		end
	end

	fn30(v50)

	if not v3 and not __wf_atom_7e8ad928(v2) and v2:__wf_atom_86399a47() then
		v3 = true

		for k, appendInfo in v10 do
			local v52 = Resource(appendInfo.I[2] or appendInfo.I[1])
			v10[k] = module5.GetItemTypeWithStoreInfo(mMovie, v52, mStoreManifest, {
				AppendInfo = appendInfo
			})
		end

		fn10()
	end
end

function LocationRollOver(_, p)
	fn6(p, "/SF/Language/Social/Location")
end

function LocationRollOut(_, p)
	fn7(p)
end

function LocationPressed(p)
	local v50 = v10[p]

	if v50 == nil then
		return
	end

	local decoded = cjson.decode(v50.C)
	decoded.x = tonumber(decoded.x)
	decoded.z = tonumber(decoded.z)

	if decoded.x == nil or decoded.z == nil then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	if v34 ~= decoded then
		v34 = decoded
		__wf_atom_c4f78a8f:__wf_atom_4ec993ab(0, 0)
		__wf_atom_c4f78a8f:__wf_atom_4ec993ab(decoded.x, decoded.z)
	end

	__wf_atom_c4f78a8f:__wf_atom_4bf6f27a()
end

function RevealRollOver(_, p)
	fn6(p, "/SF/Language/Social/RevealSpoilers")
end

function RevealRollOut(_, p)
	fn7(p)
end

function RevealPressed(p)
	local v50 = v10[p]

	if v50 == nil then
		return
	end

	module.PlaySound(_G.UISound_Select)
	v50.Revealed = true
	v50.mForceRedraw = true
	v9:Redraw()
end

function OnInputPressed(_, p)
	module.PlaySound(_G.UISound_Focus)

	if not v21 then
		v21 = true
		mMovie:__wf_atom_50d60589(p, 36, "")
	end
end

function OnReplyPressed(_, p)
	module.PlaySound(_G.UISound_Focus)

	if not v22 then
		v22 = true
		mMovie:__wf_atom_50d60589(p, 36, "")
	end
end

function ItemRollOver(p, p2)
	module.PlaySound(_G.UISound_Focus)
	local mElement = v9.mElements[p]

	if mElement.MetaData == nil then
		mElement.MetaData = {}
	end

	mElement.MetaData.HidePrice = true
	module3.SetItemInfoPopupRect(
		mMovie,
		mElement,
		mMovie:__wf_atom_cfc41e35(p2, "Icon", 2),
		mMovie:__wf_atom_cfc41e35(p2, "Icon", 3),
		mMovie:__wf_atom_cfc41e35(p2, "Icon", 14),
		mMovie:__wf_atom_cfc41e35(p2, "Icon", 15)
	)
	_T.InfoPopup_Data = mElement
	__wf_atom_ec43d06e(mMovie, p2, 2, { 5, 6, 12 }, { 110, 110, 150 }, 0.334)
end

function ItemRollOut(_, p)
	_T.InfoPopup_Data = nil
	__wf_atom_ec43d06e(mMovie, p, 2, { 5, 6, 12 }, { 100, 100, 100 }, 0.334)
end

function WritePostRollOver(_, _) end

function WritePostRollOut(_, _) end

function WritePostRollOverLocked(_, _)
	if v30 then
		_T.gToolTip = Localize("/SF/Language/Phrases/PostLockedBanned", false)
	else
		_T.gToolTip = Localize("/SF/Language/Phrases/PostLockedQuest", false)
	end
end

function WritePostRollOutLocked(_, _)
	_T.gToolTip = nil
end

function WritePostPressed(_, _)
	module.PlaySound(_G.UISound_Select)
	v28 = not v28

	if v28 then
		__wf_atom_ec43d06e(mMovie, "TopLeft.Send", 2, { 5, 6, 12 }, { 120, 120, 100 }, 0.334)
		__wf_atom_ec43d06e(mMovie, "TopLeft.Selector", 2, { 5, 6, 12 }, { 100, 100, 100 }, 0.334)
		v42 = { v44 }
		fn17(1)
		v43 = {}
		mMovie:__wf_atom_50d60589("TopLeft.Send.Text", 36, "")
	else
		__wf_atom_ec43d06e(mMovie, "TopLeft.Send", 2, { 5, 6, 12 }, { 96, 96, 0 }, 0.334)
		__wf_atom_ec43d06e(mMovie, "TopLeft.Selector", 2, { 5, 6, 12 }, { 80, 80, 0 }, 0.334)
		v42 = {}
		v43 = {}
		mMovie:__wf_atom_50d60589("TopLeft.Send.Text", 36, "")
		v41 = false
	end
end

function TopPostsRollOver(_, p)
	fn6(p, "/SF/Language/Social/Top")
end

function TopPostsRollOut(_, p)
	fn7(p, v37)
end

function TopPostsPressed()
	FetchTimeline("votes")
end

function NewPostsRollOver(_, p)
	fn6(p, "/SF/Language/Social/Newest")
end

function NewPostsRollOut(_, p)
	fn7(p, v36)
end

function NewPostsPressed()
	FetchTimeline("date")
end

function BackRollOver(_, p)
	fn6(p, "/SF/Language/Social/Back")
end

function BackRollOut(_, p)
	fn7(p)
end

function BackPressed(_, _)
	if fn2() then
		module.PlaySound(_G.UISound_Select)
		ReplyPressed(v25)
	elseif fn() then
		module.PlaySound(_G.UISound_Select)
		PostPressed(1)
	end
end

function PostPressed(p, _)
	if flag then
		return
	end

	local v50

	if p == 1 and fn() then
		v26[#v26] = nil
		v50 = v26[#v26]

		if v50 == nil then
			fn4()
			FetchTimeline()
			return
		end
	else
		v50 = v10[p]

		if not v50 or not v50.R or v50.R <= 0 then
			return
		end

		table.insert(v26, v50)
	end

	socialLocation = "_" .. v50._id
	FetchTimeline()
end

function OnDelete()
	if v27 == nil then
		return
	end

	local v50 = v10[v27]

	if v50.P then
		for i = 1, #v10 do
			if v10[i]._id == v50.P then
				v10[i].R = v10[i].R - 1
			end
		end
	end

	table.remove(v10, v27)
	fn10()
	v27 = nil
end

function ConfirmDelete(p)
	if v27 == nil then
		return
	end

	if tonumber(p) == 4 then
		gGameData:__wf_atom_7daccc3e(v10[v27]._id, "OnDelete")
	else
		v27 = nil
	end
end

function DeletePressed(p)
	if flag then
		return
	end

	local mPostId = p.mPostId
	local v50 = v10[mPostId]

	if v50 == nil then
		return
	end

	v27 = mPostId
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/DeletePostMessage", true, {
		PLAYER_NAME = v50.N,
		TEXT = v50.T
	})
	dialogSettings.firstString = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/DeletePostConfirm", true)
	dialogSettings.titleString = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/DeletePostTitle", true)
	dialogSettings:SetCallback("ConfirmDelete")
	dialogSettings.alignment = 0
	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
end

function OnReport(p)
	if v27 == nil then
		return
	end

	if p == nil then
		v27 = nil
		return
	end

	local v50 = v10[v27]
	_G.ReportedPosts[v50._id] = true
	gGameData:__wf_atom_88dec687(v50._id, "OnDelete")
end

function ReportPressed(p)
	if flag then
		return
	end

	local mPostId = p.mPostId
	local v50 = v10[mPostId]

	if v50 == nil then
		return
	end

	v27 = mPostId
	gMatchingService:__wf_atom_7190444e()
	local n = v50.N

	if #Engine.__wf_atom_fe47f148(n) == 0 then
		n = Engine.__wf_atom_640a4779(0, n)
	end

	module2.ShowReportMenu(mMovie, n, OnReport, v50._id)
end

local function fn31(p)
	if v39 ~= nil and v39 == v10[p] then
		v39 = nil
	end
end

local function fn32(p)
	OptionsRollOver(p.mPostId)
end

local function fn33(p)
	OptionsRollOut(p.mPostId)
end

local function fn34(mPostId)
	local v50 = v10[mPostId]

	if v50 == nil or v50.mClipName == nil then
		return
	end

	v39 = v50
	local v51 = v39.mClipName .. ".PostOptions.Options"
	local v52 = v39.U == v17
	local mOptions = {}

	if v then
		table.insert(mOptions, "Pin")
	end

	if not v52 then
		table.insert(mOptions, "Report")
	end

	if v52 or v then
		table.insert(mOptions, "Delete")
	end

	local v54 = 0

	for k, v55 in mOptions do
		if not mMovie:__wf_atom_253d7085(v51 .. ".Option" .. k) then
			__wf_atom_86cbd68d(mMovie, v51 .. ".Option1.duplicateMovieClip", "Option" .. k, k)
		end

		local v56 = module8.Create(mMovie, v51 .. ".Option" .. k, "/SF/Language/Social/" .. v55, v55 .. "Pressed")
		v56.mOnFocusedCallback = fn32
		v56.mOnUnfocusedCallback = fn33
		v56.mPostId = mPostId
		v56:SetPosition(26, (k - 1) * 43 + 4 + 8)
		v54 = math.max(v54, v56.mWidth)
		mOptions[k] = v56
	end

	for _, v55 in mOptions do
		v55:SetWidth(v54)
	end

	local v55 = v54 + 52
	local v56 = #mOptions * 43 + 4 + 16
	mMovie:__wf_atom_4c1c1986(v51, "Backer", 14, v55)
	mMovie:__wf_atom_4c1c1986(v51, "Backer", 15, v56)
	mMovie:__wf_atom_4c1c1986(v51, "Btn", 14, v55 + 36)
	mMovie:__wf_atom_4c1c1986(v51, "Btn", 15, v56)
	mMovie:OverrideMaterial(v51 .. ".Backer", _G.UIMaterial_FocusedBackerBorder)
	v39.mOptions = mOptions
end

function ToggleExpandedOptions(mPostId, p)
	local v50 = v10[mPostId]

	if v50 == nil or v50.mClipName == nil then
		return
	end

	local v51 = v50.mClipName .. ".PostOptions.Options"

	if not p then
		if v39 == nil then
			p = false
		else
			p = v39 == v50
		end
	end

	if p then
		fn31(mPostId)
		__wf_atom_ec43d06e(mMovie, v51, 8, { 0, 1, 5, 6, 12 }, { 0, 0, 1, 1, 0 }, 0.35, 0, function()
			mMovie:__wf_atom_2dedec1a(v51, 13, false)
		end)
	else
		fn34(mPostId)
		mMovie:__wf_atom_2dedec1a(v51, 13, true)
		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v51, "Backer", 14)
		local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35(v51, "Backer", 15)
		__wf_atom_ec43d06e(mMovie, v51, 8, { 0, 1, 5, 6, 12 }, {
			-__wf_atom_cfc41e35 - 20,
			-__wf_atom_cfc41e35_2 / 2,
			100,
			100,
			100
		}, 0.35)
		fn5()
	end
end

function ExpandMenuPressed(p, _, _)
	ToggleExpandedOptions(p)
end

local function fn35()
	mMovie:Execute("onKeyDown_MENU_CANCEL", "")
end

function TreeSelected(socialLocation2)
	if _T.SocialLocation ~= socialLocation2 then
		_T.SocialLocation = socialLocation2
		fn4()
		FetchTimeline()
	end
end

local function fn36()
	local v50 = mMovie:PushChildMovie(_G.UIMovie_GenericMenu)

	if not __wf_atom_7e8ad928(v50) then
		v50:Execute("SetTitle", "Select World Tree")
		v50:__wf_atom_f62a8704("SetTitleCaseText", { "false" })

		function _T.TreeSelectionDone(list)
			_T.TreeSelectionDone = nil
			_T.GetTreeList = nil

			if not __wf_atom_7e8ad928(list) and list[1] ~= nil then
				mMovie:Execute("TreeSelected", list[1].mLocation)
			end
		end

		v50:Execute("SetCallBack", "TreeSelectionDone")

		function _T.GetTreeList()
			local result = {}
			table.insert(result, {
				mName = mMovie:__wf_atom_8e9ac384("/SF/Language/Locations/MapTreeNightfold", false),
				mLocation = "Nightfold"
			})
			local __wf_atom_22020464 = treeInfo:__wf_atom_22020464()

			for _, v51 in __wf_atom_22020464 do
				local c_str = v51:c_str()
				local v52 = string.gsub(c_str, "MapTreeLore", "MapTreeName")
				table.insert(result, {
					mName = mMovie:__wf_atom_8e9ac384(v52, false),
					mLocation = c_str
				})
			end

			table.insert(result, {
				mName = mMovie:__wf_atom_8e9ac384("/SF/Language/Locations/CircadeTombName", false),
				mLocation = "Circade"
			})
			return result
		end

		v50:Execute("SetElementsFunction", "GetTreeList")
	end
end

local function fn37()
	mMovie:Execute("FetchTimeline", "reports")
end

function UpdateButtons()
	if _T.SetButtons == nil then
		return
	end

	if fn2() or fn() then
		mMovie:__wf_atom_2dedec1a("TopRight.SortButtons.Back", 13, true)
	else
		mMovie:__wf_atom_2dedec1a("TopRight.SortButtons.Back", 13, false)
	end

	local v50 = {}

	if v then
		table.insert(v50, { Label = "[MOD] Change Tree", CallBack = fn36 })
		table.insert(v50, { Label = "[MOD] Sort by Reports", CallBack = fn37 })
	end

	table.insert(v50, {
		Label = "/SF/Language/Menu/Generic_CloseBtn",
		CallBack = fn35,
		CallOut = "MENU_CANCEL"
	})
	_T.SetButtons(mMovie, v50, getfenv(1))
end

function ConfirmConduct(p)
	if tonumber(p) == 4 then
		_G.ConductShown = true
	else
		fn9()
	end
end

function SendLocationRollOver(_, p)
	module.PlaySound(_G.UISound_Focus)
	__wf_atom_ec43d06e(mMovie, p, 8, { 5, 6, 12 }, { 35, 35, 130 }, 0.35)
end

function SendLocationRollOut(_, p)
	__wf_atom_ec43d06e(mMovie, p, 8, { 5, 6, 12 }, { 29, 29, 100 }, 0.35)
end

function SendLocationPressed(_, p)
	function _T.MapRequestLocationCB(p2)
		v35 = p2

		if p2 then
			mMovie:__wf_atom_7f57ab2f(p, "Glow", 13, true)
		else
			mMovie:__wf_atom_7f57ab2f(p, "Glow", 13, false)
		end

		_T.MapRequestLocationCB = nil
	end

	__wf_atom_8e4fda44:__wf_atom_8b74c30b(worldMapMovie)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	dialogSettings.locString = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/SocialPickLocation", true)
	dialogSettings.titleString = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/NoticeTitle", true)
	dialogSettings.alignment = 0
	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
	_T.MapSetLocation = false
end

function Initialize()
	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(true)
	end

	_G.ReportedPosts = _G.ReportedPosts or {}
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		mMovie:Close()
		return
	end

	local module9 = require("Lotus.Interface.Libs.TimerMgr")
	v49 = module9.CreateTimerMgr()
	gGameRules:__wf_atom_28869475("OnDeath")
	module4.RegisterHideHud(true)
	v17 = __wf_atom_18a5d83b:__wf_atom_e75653c3()
	v18 = __wf_atom_18a5d83b:__wf_atom_6be84646()
	v = gGameData:__wf_atom_12fadad6() or gGameData:__wf_atom_3078be09()
	v4 = module6.Create(mMovie)
	v4:Register(mMovie, "TopLeft", { v4.ANCHOR_V_TOP, v4.ANCHOR_H_LEFT })
	v4:Register(mMovie, "TopRight", { v4.ANCHOR_V_TOP, v4.ANCHOR_H_RIGHT })
	table.insert(mVisRangeMaterials, textVisRangeMaterial)
	table.insert(mVisRangeMaterials, iconVisRangeMaterial)
	table.insert(mVisRangeMaterials, motiffVisRangeMaterial)
	table.insert(mVisRangeMaterials, heartMaterial)
	fn4()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/Post", true, {
		COST = 50
	})
	v7 = module8.Create(mMovie, "TopLeft.Send.PostButton", __wf_atom_8e9ac384, "PostButtonPressed")
	v7:SetVariant(module8.VARIANTS.SPECIAL_BUTTON)
	v7:SetAnchor(module.CENTER_ALIGNED)
	v7:SetActive(false)
	v7:SetVisible(false)
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/Reply", true, {
		COST = 25
	})
	v8 = module8.Create(mMovie, "TopRight.Reply.PostButton", __wf_atom_8e9ac384_2, "ReplyButtonPressed")
	v8:SetVariant(module8.VARIANTS.SPECIAL_BUTTON)
	v8:SetAnchor(module.CENTER_ALIGNED)
	v8:SetActive(false)
	mMovie:SetCallbacks(
		"TopLeft.Send.Location",
		"SendLocationRollOver",
		"SendLocationRollOut",
		nil,
		"SendLocationPressed"
	)
	mMovie:__wf_atom_e57658c2("TopLeft.Send.Location", 12, 150)
	mMovie:__wf_atom_2dedec1a("TopLeft.Send.Location.Glow", 13, false)
	mMovie:__wf_atom_e57658c2("TopLeft.Send.Input", 100, 1)
	mMovie:__wf_atom_e57658c2("TopLeft.Send.Input", 81, 0)
	mMovie:__wf_atom_50d60589("TopLeft.Send.Input.Text", 46, "center")
	mMovie:SetFocusedCallbacks("TopLeft.Send.Input", nil, nil, "CharacterLimitReached", "InputTextChanged")
	mMovie:SetCallbacks("TopLeft.Send.Input", nil, nil, nil, "OnInputPressed")
	mMovie:__wf_atom_7d7314f1("TopLeft.Send.Input.text", "/SF/Language/Menu/PostText")
	mMovie:__wf_atom_e57658c2("TopLeft.Send.Input", 39, 128)
	mMovie:__wf_atom_50d60589("TopLeft.Send.Name", 36, v18)
	mMovie:__wf_atom_7d7314f1("TopLeft.Send.Age.text", "/SF/Language/Menu/NowTime")
	mMovie:__wf_atom_2dedec1a("TopLeft.Send.Votes", 13, false)
	mMovie:__wf_atom_2dedec1a("TopLeft.Send.Location", 13, true)
	mMovie:__wf_atom_2dedec1a("TopLeft.Send.Replies", 13, false)
	mMovie:__wf_atom_2dedec1a("TopLeft.Send.Item1", 13, false)
	mMovie:__wf_atom_2dedec1a("TopLeft.Send.Item2", 13, false)
	mMovie:OverrideMaterial("TopLeft.Send.AvatarImage", motiffVisRangeMaterial)
	mMovie:OverrideMaterial("TopLeft.Send.AvatarBg", iconVisRangeMaterial)
	mMovie:OverrideMaterial("TopRight.Reply.AvatarImage", motiffVisRangeMaterial)
	mMovie:SetCallbacks(
		"TopRight.Reply.Location",
		"SendLocationRollOver",
		"SendLocationRollOut",
		nil,
		"SendLocationPressed"
	)
	mMovie:__wf_atom_e57658c2("TopRight.Reply.Location", 12, 150)
	mMovie:__wf_atom_2dedec1a("TopRight.Reply.Location.Glow", 13, false)
	mMovie:__wf_atom_e57658c2("TopRight.Reply.Input", 100, 2)
	mMovie:__wf_atom_e57658c2("TopRight.Reply.Input", 81, 0)
	mMovie:__wf_atom_50d60589("TopRight.Reply.Input.Text", 46, "center")
	mMovie:SetFocusedCallbacks("TopRight.Reply.Input", nil, nil, "CharacterLimitReached", "InputTextChanged")
	mMovie:SetCallbacks("TopRight.Reply.Input", nil, nil, nil, "OnReplyPressed")
	mMovie:__wf_atom_7d7314f1("TopRight.Reply.Input.text", "/SF/Language/Menu/ReplyText")
	mMovie:__wf_atom_e57658c2("TopRight.Reply.Input", 39, 128)
	mMovie:__wf_atom_50d60589("TopRight.Reply.Name", 36, v18)
	mMovie:__wf_atom_7d7314f1("TopRight.Reply.Age.text", "/SF/Language/Menu/NowTime")
	mMovie:__wf_atom_2dedec1a("TopRight.Reply.Votes", 13, false)
	mMovie:__wf_atom_2dedec1a("TopRight.Reply.Location", 13, true)
	mMovie:__wf_atom_2dedec1a("TopRight.Reply.Replies", 13, false)
	mMovie:__wf_atom_2dedec1a("TopRight.Reply.Item1", 13, false)
	mMovie:__wf_atom_2dedec1a("TopRight.Reply.Item2", 13, false)
	mMovie:__wf_atom_e57658c2("TopRight.Reply", 12, 0)
	mMovie:__wf_atom_2dedec1a("TopRight.Reply", 13, false)
	mMovie:__wf_atom_2dedec1a("TopRight.ReplyPost", 13, false)
	mMovie:OverrideMaterial("TopRight.Vines", vineMaterial)
	mMovie:OverrideMaterial("TopLeft.SendVines", vineMaterial)
	v30 = gGameData:__wf_atom_b9149bcc()
	v31 = module7.HasCompletedQuest(requiredQuestForPost) or module7.IsQuestInReplay(requiredQuestForPost)

	if v30 or not v31 then
		mMovie:SetCallbacks("TopLeft.WritePost", "WritePostRollOverLocked", "WritePostRollOutLocked", nil, nil)
		mMovie:__wf_atom_e57658c2("TopLeft.WritePost.Feather", 12, 20)
		mMovie:__wf_atom_e57658c2("TopLeft.WritePost.Backer", 12, 40)
	else
		mMovie:SetCallbacks("TopLeft.WritePost", "WritePostRollOver", "WritePostRollOut", nil, "WritePostPressed")
		mMovie:__wf_atom_2dedec1a("TopLeft.WritePost.Lock", 13, false)
	end

	mMovie:SetCallbacks("TopRight.SortButtons.TopPosts", "TopPostsRollOver", "TopPostsRollOut", nil, "TopPostsPressed")
	mMovie:SetCallbacks("TopRight.SortButtons.NewPosts", "NewPostsRollOver", "NewPostsRollOut", nil, "NewPostsPressed")
	mMovie:SetCallbacks("TopRight.SortButtons.Back", "BackRollOver", "BackRollOut", nil, "BackPressed")
	mMovie:__wf_atom_2dedec1a("TopRight.SortButtons.Back", 13, false)
	mMovie:__wf_atom_e57658c2("TopRight.Spinner", 5, 50)
	mMovie:__wf_atom_e57658c2("TopRight.Spinner", 6, 50)
	mMovie:__wf_atom_e57658c2("TopRight.Spinner", 12, 0)
	v28 = false
	mMovie:__wf_atom_e57658c2("TopLeft.Send", 5, 96)
	mMovie:__wf_atom_e57658c2("TopLeft.Send", 6, 96)
	mMovie:__wf_atom_e57658c2("TopLeft.Send", 12, 0)
	uiTexture_ProfilePlaceHolder = _G.UITexture_ProfilePlaceHolder
	local __wf_atom_a6382ae5 = gGameData:__wf_atom_a4299765():__wf_atom_a6382ae5()

	if not (__wf_atom_7e8ad928(__wf_atom_a6382ae5) or __wf_atom_7e8ad928(__wf_atom_a6382ae5.mItemType)) then
		local v50 = Resource(__wf_atom_a6382ae5.mItemType)

		if not __wf_atom_7e8ad928(v50) then
			uiTexture_ProfilePlaceHolder = module5.GetIconTexture(v50, true)
		end
	end

	mMovie:__wf_atom_c90af43a("TopLeft.Send.AvatarImage", uiTexture_ProfilePlaceHolder)
	mMovie:__wf_atom_c90af43a("TopRight.Reply.AvatarImage", uiTexture_ProfilePlaceHolder)
	fn18()
	module2.DissolveIn(mMovie)
	module.PlaySound(openSound)
	AddMixEffect()
	FetchTimeline(nil, true)
	fn27()
	local v50 = __wf_atom_20f8a2ef("/SF/Language/Phrases/")

	for i = 1, #v50 do
		local v51 = v50[i]
		local c_str = v51:c_str()

		if string.find(c_str, "PHRASE") then
			table.insert(v44, v51)
		elseif string.find(c_str, "ACTION") then
			table.insert(v45, v51)
		elseif string.find(c_str, "NOUN") then
			table.insert(v46, v51)
		elseif string.find(c_str, "ADJ") then
			table.insert(v47, v51)
		elseif string.find(c_str, "VERB") then
			table.insert(v48, v51)
		end
	end

	mMovie:__wf_atom_e57658c2("TopLeft.Selector", 12, 0)
end

function Shutdown()
	fn8()

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(false)
	end
end

function onViewportSizeChanged(p, p2)
	if not __wf_atom_7e8ad928(v4) then
		v4:Update(p, p2)
	end

	if v9 ~= nil then
		v9:SetScroll(1, true)
		v9:UpdateScrollBarHeight(fn11())
		v9:Redraw()
	end
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if v40 and v41 and v40.mScrollBar ~= nil then
		v40.mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	elseif v9.mScrollBar then
		v9.mScrollBar:ScrollDirection(p)
	end
end

function onKeyDown_MENU_CANCEL()
	fn9()
end

function onKeyDown_HIDE_PAUSE_MENU()
	return true
end

function onKeyDown_SUICIDE()
	gRegion:__wf_atom_c4f78a8f():Suicide()
	return true
end

function OnDeath(object)
	local __wf_atom_6ce58983 = object:__wf_atom_6ce58983()

	if __wf_atom_7e8ad928(__wf_atom_6ce58983) or not __wf_atom_6ce58983:__wf_atom_8efce136() then
		return
	end

	fn9()
end

function AddMixEffect(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(__wf_atom_c4f78a8f, mixEffect, mixingGroup)
	end
end

function RemoveMixEffect(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(__wf_atom_c4f78a8f, mixEffect, mixingGroup)
	end
end