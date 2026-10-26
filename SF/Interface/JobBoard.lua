local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("SF.Scripts.Libs.TaleLib")
local module5 = require("SF.Scripts.Libs.QuestLib")
local module6 = require("Lotus.Interface.LotusUtilities")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = {}
local v7 = nil
local flag = false
local v8 = false
local v9 = nil
local mInitialOffset = 0
local v10 = 0
local v11 = { x = 0, y = 0 }
local v12 = 0

function ChildScriptInner(_, p)
	local decoded = cjson.decode(p)
	local mElement = v.mElements[decoded.pIndex]

	if __wf_atom_7e8ad928(mElement) or __wf_atom_7e8ad928(mElement.Info) then
		return
	end

	if not __wf_atom_7e8ad928(mElement.Info.marker) and mElement.Info.marker:IsEnabled() then
		return
	end

	mElement[decoded.pFunctionName](mElement.Info)

	if not __wf_atom_7e8ad928(mElement.Info.marker) then
		mElement.Info.marker:Enable()
	end
end

local function fn(p, pFunctionName)
	if __wf_atom_7e8ad928(gRegion) then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and __wf_atom_c4f78a8f == gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)
	then
		__wf_atom_c4f78a8f:__wf_atom_8a035cd5(
			Symbol("ChildScriptInner"),
			false,
			cjson.encode({ pIndex = p.mIndex, pFunctionName = pFunctionName })
		)
	end
end

local function fn2(tier, p, p2, p3, p4, p5)
	for i = 1, tier do
		local v13 = p .. "." .. p2 .. i

		if not mMovie:__wf_atom_253d7085(v13) then
			__wf_atom_86cbd68d(mMovie, p .. "." .. p2 .. "1.duplicateMovieClip", p2 .. i, i + 100)
		end

		mMovie:__wf_atom_c90af43a(v13, tierStarIcon)
		mMovie:__wf_atom_2dedec1a(v13, 13, true)
		mMovie:__wf_atom_e57658c2(v13, 5, p4 * 100)
		mMovie:__wf_atom_e57658c2(v13, 6, p4 * 100)

		if p5 then
			mMovie:OverrideMaterial(v13, _G.UIMaterial_VerticalVisibilityRange)
		end

		local v14

		if i <= tier / 2 then
			v14 = i * -1
		else
			v14 = i - math.ceil(tier / 2)
		end

		local v15, v16

		if tier % 2 == 1 then
			local v17

			if i == math.ceil(tier / 2) then
				v17 = 0
			elseif i < tier / 2 then
				v17 = v14 - 1
			else
				v17 = v14 + 1
			end

			v15 = p3 + math.abs(v17 * 4 * p4)
			v16 = v17 * 12 * p4
		else
			v16 = v14 * 14 * p4
			v15 = p3
		end

		mMovie:__wf_atom_e57658c2(v13, 0, v16)
		mMovie:__wf_atom_e57658c2(v13, 1, v15)
	end

	local v13 = tier + 1

	while mMovie:__wf_atom_253d7085(p .. "." .. p2 .. v13) do
		mMovie:__wf_atom_2dedec1a(p .. "." .. p2 .. v13, 13, false)
		v13 += 1
	end
end

local function fn3(p)
	__wf_atom_ec43d06e(mMovie, "GridContainer", 8, { 12 }, { 100 }, 0.3, 0)
	__wf_atom_ec43d06e(mMovie, "GridContainer.NoteGrid", 8, { 1 }, { 32 }, 0.3, 0)
	__wf_atom_ec43d06e(mMovie, "Title", 8, { 12 }, { 100 }, 0.3, 0)
	__wf_atom_ec43d06e(mMovie, "TitleBacker", 8, { 12 }, { 100 }, 0.3, 0)
	__wf_atom_ec43d06e(mMovie, "RefreshTimer", 8, { 12 }, { 70 }, 0.3, 0)
	mMovie:__wf_atom_2dedec1a("GridContainer", 67, true)
	local ternary = module.Ternary(p, 100, 0)
	local ternary2 = module.Ternary(p, 0, -5)
	local ternary3 = module.Ternary(p, 0, 20)
	local v13 = v11.x + module.Ternary(p, 0, -64)
	local v14 = v11.y + module.Ternary(p, 0, 64)
	mMovie:__wf_atom_2dedec1a("DetailsPanel", 67, p)
	__wf_atom_ec43d06e(
		mMovie,
		"DetailsPanel",
		8,
		{ 12, 19, 20, 0, 1 },
		{ ternary, ternary2, ternary3, v13, v14 },
		0.2,
		0
	)

	if v.mElements == nil or #v.mElements == 0 then
		mMovie:__wf_atom_2dedec1a("EmptyText", 13, true)
	else
		mMovie:__wf_atom_2dedec1a("EmptyText", 13, false)
	end

	v8 = p
end

local function fn4(p)
	if __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(__wf_atom_c67f9605) then
		return
	end

	if not v8 or p then
		v9:SetScrollValue(0, false, true)
		mMovie:__wf_atom_e57658c2("DetailsPanel", 12, 0)
		mMovie:__wf_atom_e57658c2("DetailsPanel", 19, -5)
		mMovie:__wf_atom_e57658c2("DetailsPanel", 20, 20)
		mMovie:__wf_atom_e57658c2("DetailsPanel", 0, v11.x - 64)
		mMovie:__wf_atom_e57658c2("DetailsPanel", 1, v11.y + 64)
		module.PlaySound(detailsOpenSound)
	end

	fn3(true)
	mMovie:__wf_atom_2dedec1a("DetailsPanel", 67, true)
	mMovie:__wf_atom_50d60589("DetailsPanel.Title", 36, v5.Name)
	mMovie:__wf_atom_50d60589("DetailsPanel.Description", 36, v5.Description)
	mMovie:__wf_atom_c90af43a("DetailsPanel.Divider", detailsDividerTexture)

	if v5.Subheading == nil or v5.Subheading == "" then
		mMovie:__wf_atom_2dedec1a("DetailsPanel.Difficulty", 13, false)
	else
		mMovie:__wf_atom_50d60589("DetailsPanel.Difficulty.Text", 36, v5.Subheading)
		mMovie:__wf_atom_2dedec1a("DetailsPanel.Difficulty", 13, true)
	end

	if v5.Tale == nil then
		mMovie:__wf_atom_50d60589("DetailsPanel.Title", 36, v5.Name)
		mMovie:__wf_atom_2dedec1a("DetailsPanel.Location", 13, false)
	else
		local __wf_atom_13d5b7e9 = __wf_atom_c67f9605:__wf_atom_13d5b7e9(module4.GetPlayerFaction())
		mMovie:__wf_atom_50d60589(
			"DetailsPanel.Location",
			36,
			mMovie:__wf_atom_8e9ac384(__wf_atom_13d5b7e9:__wf_atom_818ea3a7():c_str(), false)
		)
		mMovie:__wf_atom_2dedec1a("DetailsPanel.Location", 13, true)
	end

	if mMovie:__wf_atom_5e6e15c8("DetailsPanel.Title", 43) > 1 then
		mMovie:__wf_atom_e57658c2("DetailsPanel.Description", 1, mInitialOffset + 8)
		v9.mInitialOffset = mInitialOffset + 8
		v9.mContentOffset = -2
		mMovie:__wf_atom_e57658c2("DetailsPanel.Divider", 1, mInitialOffset - 8)
	else
		v9.mContentOffset = -2
		mMovie:__wf_atom_e57658c2("DetailsPanel.Description", 1, mInitialOffset)
		mMovie:__wf_atom_e57658c2("DetailsPanel.Divider", 1, mInitialOffset - 16)
		v9.mInitialOffset = mInitialOffset
	end

	v9:SetVisibleProp(v9.mHeight / mMovie:__wf_atom_5e6e15c8("DetailsPanel.Description", 41))
	local module7 = require("SF.Interface.Components.Button")

	if v4 == nil then
		v4 = module7.Create(
			mMovie,
			"DetailsPanel.AcceptButton",
			mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/AcceptTale", false)
		)
		v4:SetVariant(module7.VARIANTS.SPECIAL_BUTTON)
		v4:SetAnchor(module.CENTER_ALIGNED)
	end

	if v5.Info == nil or v5.Info.quest == nil or not module5.QuestIsAccepted(WeakResource(v5.Info.quest)) then
		v4:SetVisible(true)
	else
		v4:SetVisible(false)
	end

	if v5.Info == nil or v5.Info.quest == nil then
		if v5.Tale == nil or not (v5.Tale.state >= module4.STATE.ACCEPTED) then
			if v5.Tale == nil and v5.Quest == nil then
				v4:SetText(mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/SetWaypoint", false))
				v4.mOnPressedCallback = SetWaypoint
			else
				v4:SetText(mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/AcceptTale", false))
				v4.mOnPressedCallback = AcceptTale
			end
		else
			v4:SetText(mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/AbandonTale", false))
			v4.mOnPressedCallback = AbandonTale
		end
	else
		v4:SetText(mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/AcceptTale", false))
		v4.mOnPressedCallback = AcceptQuest
	end

	mMovie:__wf_atom_c90af43a("DetailsPanel.Icon", v5.Icon)
	fn2(v5.Tier or 0, "DetailsPanel", "TierStar", -596, 1)
end

local function fn5(focusMapMarker, p)
	if __wf_atom_7e8ad928(v3) then
		return
	end

	_T.FocusMapMarker = focusMapMarker

	if __wf_atom_7e8ad928(_T.FocusMapMarker) then
		return
	end

	_T.FocusMapOffset = { x = 328, y = 0 }
	v3:__wf_atom_f62a8704("FocusMapLocation", { "true", p and "true" or "false" })
end

local function fn6(p)
	if not __wf_atom_7e8ad928(p.Info) then
		fn(p, "SetupCallback")
	end

	local tale = p.Tale

	if __wf_atom_7e8ad928(tale) then
		if __wf_atom_7e8ad928(p.Info) then
			return
		end

		v7 = p
	else
		if tale.state == module4.STATE.ACCEPTED then
			return
		end

		local activeNode = tale:GetActiveNode()

		if not (__wf_atom_7e8ad928(activeNode) or __wf_atom_7e8ad928(activeNode.marker)) then
			return
		end

		local firstNode = tale:GetFirstNode()

		if __wf_atom_7e8ad928(firstNode) then
			return
		end

		if __wf_atom_7e8ad928(firstNode.marker) then
			v6[tale] = tale:CreatePathMarkers()
			tale:SetIsPreviewed(true)

			if not __wf_atom_7e8ad928(firstNode.marker) then
				firstNode.marker:__wf_atom_44962dd2(1)
				firstNode.marker:Enable()
			end
		end
	end
end

local function fn7(p)
	if not (__wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.Info)) then
		return p.Info.marker
	end

	local tale = p.Tale

	if __wf_atom_7e8ad928(tale) then
		return nil
	end

	local activeNode = tale:GetActiveNode()

	if not (__wf_atom_7e8ad928(activeNode) or __wf_atom_7e8ad928(activeNode.marker)) then
		return activeNode.marker
	end

	local firstNode = tale:GetFirstNode()

	if __wf_atom_7e8ad928(firstNode) then
		return nil
	end

	return firstNode.marker
end

local function fn8(p)
	_T.FocusCodexEntry = nil
	fn5(fn7(p))
end

local function fn9(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:ClearPathMarkers()
	object:ShowAreaMarkers(false)
	object:SetIsPreviewed(false)
end

local function fn10()
	for k, _ in pairs(v6) do
		fn9(k)
		k:SetIsPreviewed(false)
	end

	v6 = {}

	if v7 ~= nil and not __wf_atom_7e8ad928(v7.Info.marker) then
		v7.Info.marker:Disable()
		v7 = nil
	end
end

function SetWaypoint()
	fn5(fn7(v5), true)
end

local function fn11(p)
	if flag then
		return
	end

	if v5 ~= nil and v5 ~= p and v5.mClipName ~= nil then
		__wf_atom_ec43d06e(mMovie, v5.mClipName .. ".Inner", 8, { 5, 6, 1 }, { 100, 100, 0 }, 0.2, 0)

		if v5.Accepted then
			mMovie:__wf_atom_c90af43a(v5.mClipName .. ".Inner.Backer", noteBackerTextures[3])
		else
			mMovie:__wf_atom_c90af43a(v5.mClipName .. ".Inner.Backer", noteBackerTextures[1])
		end
	end

	v5 = p

	if p == nil then
		return
	end

	fn10()
	fn6(p)
	v2:AddTimer(0.2, function()
		fn8(p)
	end)
	fn4(true)

	if p.SelectedCallback ~= nil then
		fn(p, "SelectedCallback")
	end

	mMovie:__wf_atom_c90af43a(p.mClipName .. ".Inner.Backer", noteBackerTextures[2])
	module.PlaySound(listSelectSound)
end

local function fn12(p)
	if p and v5 ~= nil then
		mMovie:__wf_atom_2dedec1a("DetailsPanel", 67, false)
		__wf_atom_ec43d06e(mMovie, "DetailsPanel", 8, { 12 }, { 0 }, 0.25)
		v8 = false
		fn11()
		v5 = nil
	end

	local activeTales = {}

	for _, activeTale in ipairs(_T.ActiveTales) do
		local v13 = false

		for k, _ in pairs(v6) do
			if k ~= activeTale then
				continue
			end

			v13 = true
			break
		end

		if v13 then
			continue
		end

		fn9(activeTale)
		table.insert(activeTales, activeTale)
	end

	for _, v13 in ipairs(activeTales) do
		v6[v13] = nil
	end

	local v13

	if not __wf_atom_7e8ad928(_T.JobBoardEntity) then
		v13 = _T.JobBoardEntity:__wf_atom_e919fb8e()
		module4.GetJobRegion(nil, v13.region)
	end

	v:RemoveElements(true, true)
	local v14 = {}
	local v15 = {}
	local v16 = {}
	local v17 = {}

	for _, activeTale in ipairs(_T.ActiveTales) do
		local finalNode = activeTale:GetFinalNode()

		if activeTale.state == module4.STATE.ABANDONED then
			continue
		end

		local v18 = Resource(activeTale.introMarkerType)
		local subheading = activeTale.enemyLevel == nil and ""
			or activeTale.enemyLevel.minValue .. "-" .. activeTale.enemyLevel.maxValue
		local v19 = {}

		for k, descParam in pairs(activeTale.descParams) do
			v19[k] = mMovie:__wf_atom_8e9ac384(descParam, false)
		end

		local v20 = {
			Name = mMovie:__wf_atom_8e9ac384(activeTale.name, false),
			Description = mMovie:__wf_atom_8e9ac384(activeTale.desc, false, v19),
			LocationName = mMovie:__wf_atom_8e9ac384(finalNode.locationId, false),
			Icon = v18:__wf_atom_e32e2012(),
			CustomEntry = true,
			Tale = activeTale,
			SelectSound = listSelectSound,
			FocusSound = listFocusSound,
			Tier = activeTale.tier,
			Subheading = subheading
		}

		if not ((activeTale.jobBoardAction == nil or activeTale.jobBoardAction == _T.JobBoardEntity) and activeTale.state ~= module4.STATE.ACCEPTED and activeTale.state ~= module4.STATE.INPROGRESS) then
			continue
		end

		table.insert(v14, v20)
	end

	local function fn13(_) end

	if not (__wf_atom_7e8ad928(v13) or __wf_atom_7e8ad928(v13.eventInfo)) then
		for _, info in ipairs(v13.eventInfo) do
			local v18 = Resource(info.markerType)
			local icon

			if not __wf_atom_7e8ad928(v18) then
				icon = v18:__wf_atom_e32e2012()
			end

			local v19 = {
				Name = mMovie:__wf_atom_8e9ac384(info.name, false),
				Description = mMovie:__wf_atom_8e9ac384(info.description, false),
				LocationName = mMovie:__wf_atom_8e9ac384("", false),
				Icon = icon,
				CustomEntry = true,
				SetupCallback = info.setupCallback or fn13,
				SelectedCallback = info.selectedCallback or fn13,
				Info = info,
				SelectSound = listSelectSound,
				FocusSound = listFocusSound
			}

			if not __wf_atom_7e8ad928(info.enemyLevel) then
				v19.Subheading = info.enemyLevel.minValue .. "-" .. info.enemyLevel.maxValue
			end

			if __wf_atom_7e8ad928(info.quest) then
				table.insert(v15, v19)
			elseif not module5.QuestIsAccepted(v19.Info.quest) then
				table.insert(v16, v19)
			end
		end
	end

	if #v16 > 0 then
		for _, v18 in ipairs(v16) do
			v:AddElement(v18, true)
		end
	end

	for _, v18 in ipairs(v17) do
		v:AddElement(v18, true)
	end

	table.sort(v14, function(a, b)
		return a.Tier < b.Tier
	end)

	for _, v18 in ipairs(v14) do
		if #v17 > 0 then
			v18.IsDummy = true
		end

		v:AddElement(v18, true)
	end

	for _, v18 in ipairs(v15) do
		v:AddElement(v18, true)
	end

	v:Redraw(nil, true, true)

	if (v.mElements == nil or #v.mElements == 0) and not v8 then
		mMovie:__wf_atom_2dedec1a("EmptyText", 13, true)
	else
		mMovie:__wf_atom_2dedec1a("EmptyText", 13, false)
	end

	v12 = Time()
	_T.RefreshJobBoard = nil
end

function UpdateButtons()
	local v13 = {}

	if not flag then
		if Engine.IsPlayingWithController() then
			table.insert(v13, { Label = "/Lotus/Language/Menu/Pan", CallOut = "MENU_RIGHT_X" })
		end

		table.insert(v13, {
			Label = "/Lotus/Language/Menu/Exit",
			CallBack = AdvanceAndShutdown,
			CallOut = "MENU_CANCEL"
		})
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v13, getfenv(1))
	end
end

local function fn13(p)
	__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Inner", 8, { 5, 6, 1, 16 }, { 110, 110, -16, 0 }, 0.3, 0)
	module.PlaySound(listFocusSound)
end

local function fn14(p)
	if p ~= v5 then
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Inner", 8, { 5, 6, 1, 16 }, { 100, 100, 0, 0 }, 0.3, 0)
	end
end

local function fn15(data)
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner.IconBacker", 12, 0)
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner.Title", 92, 2)
	mMovie:__wf_atom_48bd5a59(data.mClipName, "Inner.Title", 97, "...")
	mMovie:__wf_atom_48bd5a59(data.mClipName, "Inner.Title", 36, data.Name)
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner.Title", 44, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner.Difficulty.Text", 44, _G.UIColor_DarkBrown)

	if mMovie:__wf_atom_cfc41e35(data.mClipName, "Inner.Title", 43) > 1 then
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner.Title", 1, v10)
	else
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner.Title", 1, v10 + 8)
	end

	local _accepted = data.Accepted or data == v5

	if data.Accepted then
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Inner.Accepted", 13, true)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Inner.Difficulty", 13, false)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Inner.Accepted.Icon", noteAcceptedIcon)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Inner.Accepted.Backer", noteAcceptedBacker)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Inner.Backer", noteBackerTextures[3])
	else
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Inner.Accepted", 13, false)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Inner.Difficulty", 13, true)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Inner.Backer", noteBackerTextures[1])
	end

	mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner", 12, 100)
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner", 19, 0)
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner", 20, 0)

	if v5 ~= nil and data.Tale == v5.Tale and data.Info == v5.Info then
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner", 5, 110)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner", 6, 110)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner", 16, 0)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner", 1, -16)

		if not data.Accepted then
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".Inner.Backer", noteBackerTextures[2])
		end
	end

	mMovie:__wf_atom_48bd5a59(data.mClipName, "Inner.Difficulty.Text", 36, data.Subheading)
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Btn", 12, 0)
	mMovie:__wf_atom_c90af43a(data.mClipName .. ".BackgroundString", stringTexture)
	mMovie:__wf_atom_c90af43a(data.mClipName .. ".Inner.Icon", data.Icon)
	mMovie:__wf_atom_c90af43a(data.mClipName .. ".Inner.Knot", noteKnotTexture)
	mMovie:__wf_atom_c90af43a(data.mClipName .. ".Inner.IconBacker", noteIconBackerTexture)
	mMovie:__wf_atom_c90af43a(data.mClipName .. ".Inner.Difficulty.Backer", noteDifficultyBackerTexture)
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Inner.Difficulty.Backer", 11, 11905169)

	if data.Subheading == nil or data.Subheading == "" then
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Inner.Difficulty.Backer", 13, false)
	else
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Inner.Difficulty.Backer", 13, true)
	end

	fn2(data.Tier or 0, data.mClipName .. ".Inner", "TierStar", 68, 0.75, true)
	mMovie:OverrideMaterial(data.mClipName .. ".Inner.Icon", _G.UIMaterial_VerticalVisibilityRange)
	mMovie:OverrideMaterial(data.mClipName .. ".Inner.Accepted.Icon", _G.UIMaterial_VerticalVisibilityRange)
	mMovie:OverrideMaterial(data.mClipName .. ".Inner.Accepted.Backer", _G.UIMaterial_VerticalVisibilityRange)
	mMovie:OverrideMaterial(data.mClipName .. ".Inner.Backer", _G.UIMaterial_VerticalVisibilityRange)
	mMovie:OverrideMaterial(data.mClipName .. ".Inner.Knot", _G.UIMaterial_VerticalVisibilityRange)
	mMovie:OverrideMaterial(data.mClipName .. ".Inner.IconBacker", _G.UIMaterial_VerticalVisibilityRange)
	mMovie:OverrideMaterial(data.mClipName .. ".Inner.Difficulty.Backer", _G.UIMaterial_VerticalVisibilityRange)
	mMovie:OverrideMaterial(data.mClipName .. ".BackgroundString", _G.UIMaterial_VerticalVisibilityRange)
	mMovie:OverrideMaterial(data.mClipName .. ".Inner.Title", _G.UIMaterial_VerticalVisibilityRangeText)
	mMovie:OverrideMaterial(data.mClipName .. ".Inner.Difficulty.Text", _G.UIMaterial_VerticalVisibilityRangeText)
	__wf_atom_86cbd68d(mMovie, data.mClipName .. ".swapDepths", 1000 - data.mIndex)
end

function Initialize()
	local module7 = require("Lotus.Interface.Libs.TimerMgr")
	v2 = module7.CreateTimerMgr()
	_T.JobBoardOpen = true
	module.PlaySound(jobBoardOpenSound)
	local module8 = require("EE.Interface.Components.Grid")
	v = module8.CreateNewGrid(getfenv(1), "GridContainer.NoteGrid.Element", {
		mRows = 2,
		mColumns = 3,
		mColumnSeparation = 182,
		mRowSeparation = 280
	})
	local mVisRangeMaterials = { _G.UIMaterial_VerticalVisibilityRange, _G.UIMaterial_VerticalVisibilityRangeText }
	v:AttachScrollBar("GridContainer.Scrollbar", {
		mVisRangeMaterials = mVisRangeMaterials,
		mHeight = 560,
		mVisRangeFadeSize = 32
	})
	v.mOnFocusedCallback = fn13
	v.mOnUnfocusedCallback = fn14
	v.mOnSelectedCallback = fn11
	v.mElementDrawCallback = fn15
	mMovie:__wf_atom_2dedec1a("DetailsPanel", 67, false)
	mMovie:__wf_atom_e57658c2("DetailsPanel", 12, 0)
	mMovie:SetCallbacks("DetailsPanel.Backer", nil, nil, "DetailsPanelBackerPressed", nil)
	mMovie:OverrideMaterial("DetailsPanel.Description", detailsTextMaterial)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Title", 92, 2)
	mMovie:__wf_atom_50d60589("DetailsPanel.Title", 97, "...")
	mMovie:__wf_atom_e57658c2("DetailsPanel.Difficulty.Text", 44, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Difficulty.Backer", 12, 80)
	mMovie:__wf_atom_c90af43a("RefreshTimer.Icon", refreshIcon)
	mMovie:__wf_atom_e57658c2("RefreshTimer.Text", 11, _G.UIColor_Brown)
	local module9 = require("SF.Interface.Components.Scrollbar")
	v9 = module9.CreateScrollBar(getfenv(1), "DetailsPanel.Scrollbar", {
		mVisRangeMaterials = { detailsTextMaterial }
	})
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.Description", 15)
	v9.mClipToScroll = "DetailsPanel.Description"
	v9.mCurrentScroll = 0
	v9:SetHeight(__wf_atom_5e6e15c8)
	mInitialOffset = mMovie:__wf_atom_5e6e15c8("DetailsPanel.Description", 1)
	v10 = mMovie:__wf_atom_5e6e15c8("GridContainer.NoteGrid.Element.Inner.Title", 1)
	v11.x = mMovie:__wf_atom_5e6e15c8("DetailsPanel", 0)
	v11.y = mMovie:__wf_atom_5e6e15c8("DetailsPanel", 1)
	v9.mInitialOffset = mInitialOffset
	mMovie:__wf_atom_50d60589("EmptyText", 36, mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/JobBoardNoJobs", false))
	mMovie:__wf_atom_e57658c2("EmptyText", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_2dedec1a("EmptyText", 13, false)
	mMovie:__wf_atom_50d60589("Title", 36, mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/JobBoardTitle", false))
	mMovie:__wf_atom_e57658c2("Title", 44, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_c90af43a("TitleBacker", titleBannerTexture)
	mMovie:__wf_atom_c90af43a("Backer", backerTexture)
	mMovie:__wf_atom_c90af43a("Shadow", shadowTexture)
	mMovie:__wf_atom_e57658c2("Shadow", 12, 40)
	mMovie:__wf_atom_e57658c2("GridContainer", 12, 0)
	mMovie:__wf_atom_e57658c2("Title", 12, 0)
	mMovie:__wf_atom_e57658c2("TitleBacker", 12, 0)
	mMovie:__wf_atom_e57658c2("Backer", 12, 0)
	mMovie:__wf_atom_e57658c2("RefreshTimer", 12, 0)
	mMovie:__wf_atom_e57658c2("Backer", 0, -196)
	mMovie:__wf_atom_c90af43a("DetailsPanel.Difficulty.Backer", noteDifficultyBackerTexture)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Difficulty.Backer", 11, 11905169)
	__wf_atom_ec43d06e(mMovie, "Backer", 2, { 12, 0 }, { 100, 0 }, 0.5, 0)
	__wf_atom_ec43d06e(mMovie, "RefreshTimer", 8, { 12 }, { 70 }, 0.5, 0)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("GridContainer", 1)
	mMovie:__wf_atom_e57658c2("GridContainer", 1, __wf_atom_5e6e15c8_2 - 32)
	__wf_atom_ec43d06e(mMovie, "Title", 8, { 12 }, { 100 }, 0.5, 0.2)
	__wf_atom_ec43d06e(mMovie, "TitleBacker", 8, { 12 }, { 100 }, 1 / 3, 0.2)
	fn12()
	__wf_atom_ec43d06e(mMovie, "GridContainer", 8, { 12, 1 }, { 100, __wf_atom_5e6e15c8_2 }, 0.5, 0.2)
	local total = 0.5
	v:RunForAllElements(function(p)
		if p.mClipName ~= nil then
			__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Inner", 4, { 16 }, { Random(-6, -3) }, 5, total)
			total += 0.1
		end
	end)
	v2:AddTimer(1.4, function()
		total = 0
		v:RunForAllElements(function(p)
			if p.mClipName ~= nil then
				__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Inner", 4, { 16 }, { 0 }, 10, total)
				total += 0.1
			end
		end)
	end)
	v2:AddTimer((total + 3.9) * 1, function()
		v:RunForAllElements(function(p)
			if p.mClipName ~= nil then
				mMovie:__wf_atom_290807ee(p.mClipName .. ".Inner")
			end
		end)
	end)
	module3.BlockFastTravel(true)
	_T.FocusCodexEntry = nil
	_T.MapRightStickPan = true
	local v13 = Resource("/SF/Interface/Map.swf")

	if __wf_atom_8e4fda44:__wf_atom_6b69b901(v13) then
		v3 = __wf_atom_8e4fda44:FindMovie(v13)
	else
		v3 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(v13)
	end

	v3:__wf_atom_b4ffb30f(true)
	v3:__wf_atom_40912f8e(true)
	v3:__wf_atom_2dedec1a("Banner", 13, false)
	v3:__wf_atom_2dedec1a("Currency", 13, false)
	v3:__wf_atom_2dedec1a("TimeOfDay", 13, false)
	module3.ShowBackground({ mFade = module.LEFT_ALIGNED })
	module3.RegisterHideHud(true)
	module2.SetChatVisible(false)
	mMovie:__wf_atom_c90af43a("DetailsPanel.IconBacker", detailsIconBackerTexture)
	mMovie:__wf_atom_c90af43a("DetailsPanel.Backer", detailsBackerTexture)
	mMovie:__wf_atom_c90af43a("DetailsPanel.Knot", detailsKnotTexture)
	mMovie:__wf_atom_c90af43a("DetailsPanel.LooseString", detailsLooseStringTexture)
	mMovie:__wf_atom_c90af43a("DetailsPanel.Divider", detailsDividerTexture)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.Title", 54, true)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.Location", 54, true)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.BgFill", 13, false)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.BgStart", 13, false)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.BgEnd", 13, false)
	mMovie:__wf_atom_c90af43a("DetailsPanel.BgFill", detailsBackerTextures[1])
	mMovie:__wf_atom_c90af43a("DetailsPanel.BgEnd", detailsBackerTextures[2])
	mMovie:__wf_atom_c90af43a("DetailsPanel.BgStart", detailsBackerTextures[2])
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgStart", 11, 12102554)
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgFill", 11, 12102554)
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgEnd", 11, 12102554)
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgStart", 12, 80)
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgFill", 12, 80)
	mMovie:__wf_atom_e57658c2("DetailsPanel.BgEnd", 12, 80)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Title", 44, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Location", 44, _G.UIColor_Brown)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Description", 44, _G.UIColor_Brown)
	UpdateButtons()
end

local function fn16()
	fn12()
	fn4()
	fn3(false)
end

function AcceptQuest()
	if flag or __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v5.Info.quest) then
		return
	end

	module5.StartQuest(v5.Info.quest, function()
		if v5 ~= nil and v5.Info ~= nil then
			module5.TrackQuest(v5.Info.quest, true)
			fn16()
		end
	end)
end

function AbandonTale()
	if flag or __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v5.Tale) then
		return
	end

	local function fn17(p)
		if p == 4 and not (flag or __wf_atom_7e8ad928(v5)) then
			v5.Tale.state = module4.STATE.ABANDONED
			fn12(true)
			module.PlaySound(abandonTaleSound)
			fn16()
		end
	end

	local v13 = Localize("/SF/Language/Quests/JobBoardConfirmAbandonTale", false)
	module.ShowYesOrNoMessage(v13, fn17)
end

function AcceptTale()
	if flag or __wf_atom_7e8ad928(v5) then
		return
	end

	local tale = v5.Tale

	if __wf_atom_7e8ad928(tale) then
		return
	end

	if tale.state ~= module4.STATE.ACCEPTED then
		v6[tale] = {}
		tale.state = module4.STATE.ACCEPTED
		module.PlaySound(acceptTaleSound)
	end

	fn16()
end

local function fn17()
	for i, mElement in ipairs(v.mElements) do
		if
			mElement.mClipName == nil
			or mMovie:__wf_atom_1b848254(mElement.mClipName .. ".Inner")
			or i == v.mCurrentElementIndex
			or mElement == v5
		then
			continue
		end

		local v13 = Noise(Time() * 0.05 + mElement.mIndex) * 5
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mElement.mClipName .. ".Inner", 16)
		mMovie:__wf_atom_4c1c1986(mElement.mClipName, "Inner", 16, __wf_atom_5e6e15c8 * 0.9 + v13 * 0.1)
	end
end

local function fn18()
	if __wf_atom_7e8ad928(_T.JobBoardEntity) then
		mMovie:__wf_atom_2dedec1a("RefreshTimer", 13, false)
		return
	end

	local __wf_atom_e919fb8e = _T.JobBoardEntity:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.lastGenTime == nil then
		mMovie:__wf_atom_2dedec1a("RefreshTimer", 13, false)
		return
	end

	if __wf_atom_e919fb8e.lastGenTime == 0 then
		mMovie:__wf_atom_2dedec1a("RefreshTimer", 13, false)
		return
	end

	local v13 = math.floor((math.max(
		0,
		(__wf_atom_e919fb8e.lastGenTime + module4.rerollTime - module6.GetSecondCount()) / 60
	)))
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/TimeFormat_MinutesShort", false)
	mMovie:__wf_atom_50d60589("RefreshTimer.Text", 36, tostring(v13) .. __wf_atom_8e9ac384)
	mMovie:__wf_atom_2dedec1a("RefreshTimer", 13, true)
end

function Update()
	local v13 = __wf_atom_084b3e93()
	local v14 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v14)

	if not __wf_atom_7e8ad928(v2) then
		v2:Update(v13)
	end

	if _T.RefreshJobBoard and v12 + 0.5 < Time() then
		fn3(false)
		fn12(true)
	end

	fn18()
	fn17()
end

function Shutdown()
	if not __wf_atom_7e8ad928(v3) then
		v3:Close()
	end

	_T.JobBoardOpen = false
	module3.HideBackground()
	module3.RegisterHideHud(false)
	module2.SetChatVisible(true)
	module3.BlockFastTravel(false)
	_T.MapRightStickPan = false
	fn10()

	for _, activeTale in ipairs(_T.ActiveTales) do
		activeTale:Update()

		if not activeTale:IsActive() then
			continue
		end

		activeTale:CreatePathMarkers()
		activeTale:ShowAreaMarkers(true)
	end

	if _T.OnJobBoardClosed ~= nil then
		_T.OnJobBoardClosed()
		_T.OnJobBoardClosed = nil
	end
end

function AdvanceAndShutdown()
	if v8 then
		fn3(false)
		v:UnfocusElement(v.mCurrentElementIndex)
		fn11(nil)
		v8 = false
	else
		if flag then
			return
		end

		flag = true
		UpdateButtons()

		if not __wf_atom_7e8ad928(v3) then
			v3:Execute("Hide", nil)
		end

		module3.DissolveOutAndClose(mMovie)
	end
end

function onKeyDown_MENU_CANCEL()
	AdvanceAndShutdown()
	return true
end

function OnGamepadTransition(_)
	UpdateButtons()
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if __wf_atom_7e8ad928(v) or flag then
		return false
	end

	local v13 = mMovie:__wf_atom_5e6e15c8("GridContainer.Scrollbar", 2) + 16
	local v14 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.Scrollbar", 2) + 16
	local __wf_atom_6efc7cd1, _ = mMovie:__wf_atom_6efc7cd1(mMovie:__wf_atom_79258be8(), 0)

	if v13 < __wf_atom_6efc7cd1 then
		if v8 and __wf_atom_6efc7cd1 < v14 then
			v9:ScrollDirection(p)
		else
			return false
		end
	else
		v.mScrollBar:ScrollDirection(p)
	end

	return true
end

function DetailsPanelBackerPressed() end