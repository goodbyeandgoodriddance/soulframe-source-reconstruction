local vendorTransmissionSet = Resource()
local v = Symbol("SquareCenter")
local v2 = Symbol("SquareSize")
local v3 = Symbol("SquareFadeSize")
local v4 = {}
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("EE.Interface.AnchorMgr")
local module4 = require("SF.Interface.Libs.OdeCipher")
local module5 = require("Lotus.Interface.CardUtilitiesRedux")
local module6 = require("SF.Scripts.Libs.QuestLib")
local module7 = require("SF.Scripts.Libs.TransmissionSet")
local module8 = require("SF.Interface.SFUtilities")
require("Lotus.Interface.CodexUtilities")
local module9 = require("SF.Scripts.Libs.CodexLib")
local module10 = require("SF.Scripts.Libs.AdventCalendarLib")
local module11 = require("SF.Scripts.Libs.TaleLib")
local module12 = require("EE.Interface.Components.Grid")
local module13 = require("Lotus.Interface.StoreItemUtilities")
local module14 = require("SF.Interface.Libs.UIUtilities")
local module15 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local v5 = {}
local v6 = Resource("/Lotus/Types/Lore/PrimaryCodexManifest")
local v7 = Resource("/Lotus/Types/Game/Store/ProductsManifest")
local module16 = require("EE.Interface.Components.List")
local module17 = require("SF.Interface.Components.Scrollbar")
local v8 = 12363651
local v9 = getfenv(1)
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local asyncLoader = module14.CreateAsyncLoader()
local v14 = nil
local v15 = nil
local v16 = {}
local codexButtons = {}
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = nil
local v21 = nil
local v22 = 1
local mIndex = nil
local v23 = { "Codex.Background", "Codex.TabbedBackground" }
local v24 = nil
local v25 = nil
local mBulletEntryData = nil
local v26 = {}
local mTransmissions = nil
local v27 = nil
local mQuest = nil
local v28 = {}
local v29 = { "Resource" }
local v30 = 0
local v31 = 0
local v32 = false
local v33 = nil
local v34 = false
local mScanInfos = {}
local v35 = nil
local v36 = nil
local v37 = false
local mVisible = false
local v38 = false
local flag = false
local flag2 = false
local v39 = false
local v40 = 1
local v41 = 1
local flag3 = false
local v42 = nil
local v43 = nil
local v44 = nil
local _ = { ANIMAL = 1, FISH = 2 }
local v45 = {}
local v46 = 1
local v47 = 0
local v48 = nil
local v49 = 0
local v50 = 0
local v51 = {}
local v52 = {}
local v53 = nil
local mScans = nil
local UIColor_Black = _G.UIColor_Black
local UIColor_White = _G.UIColor_White

local function fn(p, p2)
	return p.mScanProgress > p2.mScanProgress
end

local function fn2(p, p2)
	return p == nil or p2 == nil or p.mName < p2.mName
end

local function fn3(p)
	mMovie:__wf_atom_1ca72041(p, "Dissolve", 1, 0, 1, 1)
	__wf_atom_ec43d06e(mMovie, p, 0, { function(p2)
			mMovie:__wf_atom_1ca72041(p, "Dissolve", 1 - p2, 0, 1, 1)
		end }, { 1 }, 0.65)
end

local function fn4()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()
	return not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) and __wf_atom_2ad5cd23:__wf_atom_6d61d595() == topMenuMovie
end

local function fn5(p, p2)
	if not __wf_atom_7e8ad928(v10) then
		v10:Update(p, p2)
	end

	module.ScaleSlicedMaterials(mMovie, {
		horizontalDividerMaterial,
		verticalDividerMaterial,
		locationBorderMaterial,
		locationBorderFocusedMaterial
	})
	module.ScaleClipVisRangeMaterials(mMovie, "Codex.Content.Body.ScrollArea", false, {
		horizontalDividerMaterial,
		verticalDividerMaterial,
		locationBorderMaterial,
		locationBorderFocusedMaterial,
		_G.UIMaterial_UnfocusedBorder,
		_G.UIMaterial_FocusedBorder,
		_G.UIMaterial_SelectedBorder
	})
	local screenDimensions, v54 = module.GetScreenDimensions(mMovie)

	for i = 1, #v23 do
		mMovie:__wf_atom_e57658c2(v23[i], 15, v54)
	end

	mMovie:__wf_atom_e57658c2("Blurer", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("Blurer", 15, v54)
end

local function fn6(p, p2)
	table.insert(v51, {
		p,
		0,
		p2,
		mMovie:__wf_atom_5e6e15c8(p, 0),
		mMovie:__wf_atom_5e6e15c8(p, 1)
	})
end

local function fn7(p)
	table.insert(v52, p)
	table.insert(v51, {
		p,
		0,
		nil,
		mMovie:__wf_atom_5e6e15c8(p, 0),
		mMovie:__wf_atom_5e6e15c8(p, 1)
	})
end

local function fn8()
	v51 = {}

	for i = 1, #v52 do
		table.insert(v51, {
			v52[i],
			0,
			nil,
			mMovie:__wf_atom_5e6e15c8(v52[i], 0),
			mMovie:__wf_atom_5e6e15c8(v52[i], 1)
		})
	end
end

function MoteFocused() end

function MoteUnfocused() end

function MoteReleased() end

function MotePressed()
	if not __wf_atom_7e8ad928(v48) then
		v48:__wf_atom_dd9b7ab8(0.001)
		v48:SetVisibility(false, true)
		v48 = nil
		v47 = math.random(10, 30)
		module.PlaySound(motePressSound)
		module.CreateParticles(mMovie, "Mote", motePressParticleSys, 0, 0)
		mMovie:__wf_atom_2dedec1a("Mote", 13, false)

		if not _T.MoteReactionPlayed then
			gRegion:__wf_atom_c4f78a8f():__wf_atom_1a73b1c2(moteReactionTransmission)
			_T.MoteReactionPlayed = true
		end

		__wf_atom_ec43d06e(mMovie, "Mote", 0, { function(_)
				for i = 1, #v51 do
					v51[i][2] = __wf_atom_421b01aa(v51[i][2] - __wf_atom_fa1258d0() / 0.65, 0, 1)
					local v54 = v51[i][1]
					mMovie:__wf_atom_1ca72041(v54, "Dissolve", v51[i][2], 0, 1, 1)
				end
			end }, { 1 }, 0.65)
	end
end

local function fn9(p, p2)
	for i = 1, #v51 do
		local v54 = v51[i][1]
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v54, 2)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v54, 3)
		local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(v54, 14)
		local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8(v54, 15)
		local __wf_atom_5e6e15c8_5 = mMovie:__wf_atom_5e6e15c8(v54, 40)
		local v55

		if __wf_atom_5e6e15c8_5 > 0 then
			v55 = __wf_atom_5e6e15c8_5
		else
			v55 = __wf_atom_5e6e15c8_3
		end

		local __wf_atom_5e6e15c8_6 = mMovie:__wf_atom_5e6e15c8(v54, 41)

		if not (__wf_atom_5e6e15c8_6 > 0) then
			__wf_atom_5e6e15c8_6 = __wf_atom_5e6e15c8_4
		end

		local v56 = __wf_atom_5e6e15c8 + v55
		local v57 = __wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8_6

		if v51[i][3] == 1 then
			__wf_atom_5e6e15c8 += __wf_atom_5e6e15c8_3 * 0.5 - __wf_atom_5e6e15c8_5 * 0.5
			v56 += __wf_atom_5e6e15c8_3 * 0.5 - __wf_atom_5e6e15c8_5 * 0.5
		elseif v51[i][3] == 2 then
			__wf_atom_5e6e15c8 -= __wf_atom_5e6e15c8_3 * 0.5
			v56 -= __wf_atom_5e6e15c8_3 * 0.5
			__wf_atom_5e6e15c8_2 -= __wf_atom_5e6e15c8_4 * 0.5
			v57 -= __wf_atom_5e6e15c8_4 * 0.5
		end

		if not (__wf_atom_5e6e15c8 <= p and p <= v56 and __wf_atom_5e6e15c8_2 <= p2 and p2 <= v57) then
			continue
		end

		local v58 = v51[i][2]
		local v59 = __wf_atom_421b01aa(v58 + __wf_atom_fa1258d0() * 0.5, 0, 0.8)
		v51[i][2] = v59
		mMovie:__wf_atom_1ca72041(v54, "Dissolve", v59, 0, 1, 1)
	end
end

local function fn10(_)
	mMovie:__wf_atom_e57658c2("Mote", 12, 1)
	local __wf_atom_97cd8326 = mMovie:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = mMovie:__wf_atom_54eeda24()

	if __wf_atom_7e8ad928(v48) then
		v47 -= __wf_atom_fa1258d0()
		mMovie:__wf_atom_2dedec1a("Mote", 13, false)
	else
		v49 += Noise(Time() * 0.2) * 3
		v50 += Noise(3.3 + Time() * 0.2) * 3

		if __wf_atom_97cd8326 < v49 then
			v49 -= __wf_atom_97cd8326
		elseif v49 < 0 then
			v49 += __wf_atom_97cd8326
		end

		if __wf_atom_54eeda24 < v50 then
			v50 -= __wf_atom_54eeda24
		elseif v50 < 0 then
			v50 += __wf_atom_54eeda24
		end

		mMovie:__wf_atom_e57658c2("Mote", 0, v49)
		mMovie:__wf_atom_e57658c2("Mote", 1, v50)
		fn9(v49, v50)
		local screenParticlesCoord, v54 = module.GetScreenParticlesCoord(mMovie, v49, v50, gRegion:GetGameCamera())
		local v55 = Vector(screenParticlesCoord, v54, 1)
		Normalize(v55)
		local v56 = v55 * 4
		v48:__wf_atom_e310f01f(v56, __wf_atom_80368bb1)
	end

	if __wf_atom_7e8ad928(v48) and v47 <= 0 then
		v47 = math.random(10, 30)
		v49 = math.random(0, __wf_atom_97cd8326)
		v50 = math.random(0, __wf_atom_54eeda24)
		mMovie:__wf_atom_e57658c2("Mote", 0, v49)
		mMovie:__wf_atom_e57658c2("Mote", 1, v50)
		v48 = module.CreateParticles(mMovie, "Mote", moteParticleSys, 0, 0)

		if not __wf_atom_7e8ad928(v48) then
			local v54 = math.random(1, 5)
			v48:__wf_atom_6cf07262(v54)
			v48:__wf_atom_f582136d(__wf_atom_8939e086)[1]:__wf_atom_dd9b7ab8(__wf_atom_421b01aa(v54 - 2.2, 1, 20))
			mMovie:__wf_atom_2dedec1a("Mote", 13, true)
		end
	end
end

function AbandonTale()
	local function fn11(p)
		if p == 4 then
			local mElement = v14.mElements[mIndex]

			if mElement.mData == nil then
				return
			end

			local tale = mElement.mData[1].Tale
			tale.state = module11.STATE.ABANDONED

			if tale.paused and not (__wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gGameRules)) then
				gGameData:__wf_atom_47a4a85f(module11.GetPlayerFaction(), tale.pathId, nil, 1, 0)
				gGameRules:CommitInventoryCheckpointToDB(0, 0)

				if module6.IsTrackedJournalEntry(mElement.mEntryId) then
					local id = mElement.mData[1].Id
					module9.RemoveTalesEntry(id)
				end
			end

			CloseCodex()
			module.PlaySound(abandonTaleSound)
		end
	end

	local talename = "<font color=\"#DD9F38\">" .. v14.mElements[mIndex].mLabel .. "</font>"
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/JobBoardConfirmAbandonTale", true, {
		TALENAME = talename
	})
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/JobBoardAbandonHeading", true)
	module.ShowYesOrNoMessage(__wf_atom_8e9ac384, fn11, nil, __wf_atom_8e9ac384_2)
end

local function fn11()
	local v54 = v12:IsActive() and 40 or 64
	mMovie:__wf_atom_e57658c2("Codex.Content.Body", 1, 330 - v54)
	mMovie:__wf_atom_e57658c2("Codex.Content.Body.Date", 1, v54 + 616)
	mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollArea", 15, v54 + 576)
	mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollArea", 1, v54 / 2 + 288)
	fn5(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	PopulateScrollbar(2, "Codex.Content.Body", "ScrollableBody", v30)
end

local function fn12(_)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/QuestElementTooltipTrack", false, {})
	return (string.gsub(__wf_atom_8e9ac384, "<MENU_CLICK> ", ""))
end

local function fn13(k, p)
	local v54 = "Codex.Content.Body.ScrollableBody.MainBody.Entries.Entry" .. k

	if v22 == v5.Journal and v25[mIndex] ~= nil then
		local isTrackedJournalEntry = module6.IsTrackedJournalEntry(v25[mIndex].mEntryId)
		p = p and isTrackedJournalEntry
	end

	mMovie:__wf_atom_4c1c1986(v54, "Glow", 12, module.Ternary(p, 100, 0))
	mMovie:__wf_atom_4c1c1986(v54, "Pip.Glow", 12, module.Ternary(p, 40, 0))
end

local function fn14(p, p2)
	if p == nil then
		return
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/QuestElementTooltipTrack", false, {})

	if p.mClipName ~= nil then
		mMovie:__wf_atom_2dedec1a(p.mClipName .. ".Icon", 13, p2)
		mMovie:__wf_atom_2dedec1a(p.mClipName .. ".Icon.StatusIcon", 13, p2)
	end

	if p2 then
		if p.mClipName ~= nil then
			mMovie:__wf_atom_c90af43a(p.mClipName .. ".Icon.StatusIcon", questTrackedIcon)
			mMovie:__wf_atom_e57658c2(p.mClipName .. ".Icon.StatusIcon", 11, 14524216)
		end

		v8 = 12363651
		__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/QuestElementTooltipUntrack", false, {})
	else
		v8 = 1774867
	end

	v17:SetSelected(p2)
	local v54 = string.gsub(__wf_atom_8e9ac384, "<MENU_CLICK> ", "")
	v17:SetTooltip(v54)
end

function TrackButtonPressed()
	if v25 == nil or mIndex == nil then
		return
	end

	local v54 = v25[mIndex]

	if v54.mQuestType == 1 then
		local mElement = v14.mElements[mIndex]

		if mElement.mData == nil then
			return
		end

		ToggleTrackedQuest(mElement.mEntryId)

		if mElement.mData[1].NodeIndex == nil then
			return
		end
	elseif v54.mQuestType == 0 then
		local v55 = mQuest

		if v55 == nil then
			return
		end

		if not module6.IsQuestTracked(v55) then
			ToggleTrackedQuest(v14.mElements[mIndex].mEntryId)
			return
		end

		ToggleTrackedQuest(nil)
		module6.ClearTrackedEntry()
	elseif v54.mQuestType == 2 then
		local mElement = v14.mElements[mIndex]
		local journalEntry = SF.JournalEntry(2, mElement.mEntryId)
		local _quest = mElement.mData[1].Quest
		local ancestorType = mElement.mData[1].AncestorType
		local ancestorRank = mElement.mData[1].AncestorRank
		ancestorType:__wf_atom_5e1f5995(ancestorRank + 1):c_str()
		local _ = ancestorType:__wf_atom_5b41f63b() .. "_" .. tostring(ancestorRank + 1)
		ancestorType:__wf_atom_5b41f63b()
		local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()
		local v55 = false

		for _, v57 in ipairs(__wf_atom_d10f2b47) do
			if journalEntry ~= v57 then
				continue
			end

			v55 = true
			break
		end

		if not v55 then
			ToggleTrackedQuest(mElement.mEntryId)
			return
		end

		module6.UntrackEntry(journalEntry.mId, journalEntry.mType)
		ToggleTrackedQuest(nil)
	elseif v54.mQuestType == 4 then
		local mElement = v14.mElements[mIndex]

		if mElement.mData == nil then
			return
		else
			ToggleTrackedQuest(mElement.mEntryId)
		end
	end
end

function ToggleTrackedQuest(p)
	local v54 = nil
	local v55 = nil

	for i = 1, #v14.mElements do
		local mEntryId = v14.mElements[i].mEntryId

		if mEntryId == nil then
			continue
		end

		if module6.IsTrackedJournalEntry(mEntryId) then
			v54 = v14.mElements[i]
		end

		if mEntryId == p then
			v55 = v14.mElements[i]
		end
	end

	if v54 ~= nil then
		module6.UntrackEntry(v54.mEntryId, v54.mQuestType)
		fn14(v54, false)

		for k, _ in v54.mBulletEntryData do
			fn13(k, false)
		end
	end

	if v55 ~= nil and v55 ~= v54 then
		module6.TrackEntry(v55.mEntryId, v55.mQuestType, true)
		fn14(v55, true)

		for k, _ in v55.mBulletEntryData do
			fn13(k, v55.mBulletEntryData[k].mActive)
		end
	end
end

local function fn15()
	local topMenuChildButtons = {}

	if mVisible then
		table.insert(topMenuChildButtons, {
			Label = "/SF/Language/Codex/ViewLocation",
			CallBack = ViewLocation,
			CallOut = "MENU_GENERIC2",
			Icon = locationIcon
		})
	end

	table.insert(topMenuChildButtons, {
		Label = v32 and "/Lotus/Language/Menu/Back" or "/Lotus/Language/Menu/Exit",
		CallBack = CloseCodex,
		CallOut = "MENU_CANCEL"
	})
	_T.TopMenuChildButtons = topMenuChildButtons
	_T.TopMenuChildButtonOptions = { DesiredRightX = 1734, DesiredViewportAnchor = 7 }

	if fn4() then
		if not __wf_atom_7e8ad928(_T.SetButtons) then
			_T.SetButtons(mMovie)
		end

		mMovie:__wf_atom_2ad5cd23():Execute("UpdateButtons", "")
	elseif not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, topMenuChildButtons, getfenv(1), nil, nil, _T.TopMenuChildButtonOptions)
	end

	HideAllCodexButtons()
	fn11()
end

local function fn16(p, p2)
	return string.format("<font color=\"%s\">%s</font>", module.ConvertColorNumberToHex(p2), p)
end

local function fn17(p)
	return string.format("<p><font >" .. p .. "</font></p>")
end

local function fn18(object)
	return "LORE_" .. string.upper(object:c_str())
end

local function fn19(p, p2)
	local v54 = math.max(2, p2 + 1)

	while mMovie:__wf_atom_253d7085(p .. v54) do
		__wf_atom_86cbd68d(mMovie, p .. v54 .. ".removeMovieClip")
		v26[v54] = nil
		v54 += 1
	end
end

function HideAllCodexButtons()
	for i = 1, #codexButtons do
		codexButtons[i]:SetVisible(false)
	end
end

function UpdateCodexButtonsPositions()
	if #codexButtons < 1 then
		return
	end

	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(codexButtons[1].mClipName, 0)
	local count = 0

	for i = 1, #codexButtons do
		if not codexButtons[i].IsVisible then
			continue
		end

		local v54 = not (count > 0) and 0 or mMovie:__wf_atom_5e6e15c8(codexButtons[count].mClipName, 14) - 25
		mMovie:__wf_atom_e57658c2(codexButtons[i].mClipName, 0, __wf_atom_5e6e15c8 - v54 * count)
		count += 1
	end
end

function OnCodexButtonPressed(p)
	local v54 = codexButtons[p]

	if v54 ~= nil and v54.OnPressed ~= nil then
		v54.OnPressed()
	end
end

function OnCodexButtonReleased(_) end

function OnCodexButtonUnfocused(p)
	local v54 = codexButtons[p]

	if v54 ~= nil then
		v54:OnUnfocused()
	end
end

function OnCodexButtonFocused(p)
	local v54 = codexButtons[p]

	if v54 ~= nil then
		v54:OnFocused()
	end
end

local function fn20(p, p2)
	local v54 = #codexButtons + 1
	local codexButton = module9.CreateCodexButton(mMovie, p, v54)
	codexButton:SetTooltip(p2)
	mMovie:__wf_atom_253d7085("Codex.Content." .. p .. ".IconBacker")
	mMovie:__wf_atom_e57658c2("Codex.Content." .. p .. ".IconBacker", 100, v54)
	mMovie:SetCallbacks(
		"Codex.Content." .. p .. ".IconBacker",
		"OnCodexButtonFocused",
		"OnCodexButtonUnfocused",
		"OnCodexButtonReleased",
		"OnCodexButtonPressed"
	)
	codexButtons[v54] = codexButton
	return codexButton
end

local function fn21()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/QuestElementTooltipTrack", false, {})
	local v54 = string.gsub(__wf_atom_8e9ac384, "<MENU_CLICK> ", "")
	mMovie:__wf_atom_2dedec1a("Codex.Content.Btn", 13, false)
	v18 = fn20("AbandonButton", mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/AbandonTale", false, {}))
	v18:SetTextures(abandonButtonTextures, 65)
	v18:SetOnPressedCallback(AbandonTale)
	v19 = fn20("ReplayButton", mMovie:__wf_atom_8e9ac384("/SF/Language/Codex/QuestReplay", true))
	v19:SetTextures(replayButtonTextures, 80)
	v19:SetOnPressedCallback(OnReplayButtonPressed)
	v20 = fn20("TransmissionButton", mMovie:__wf_atom_8e9ac384("/SF/Language/Codex/PlayTransmission", true))
	v20:SetTextures(transmissionButtonTextures, 80)
	v20:SetOnPressedCallback(OnTransmissionButtonPressed)
	v21 = fn20("ViewLocationButton", mMovie:__wf_atom_8e9ac384("/SF/Language/Codex/ViewLocation", true))
	v21:SetTextures(viewButtonTextures, 100)
	v21:SetOnPressedCallback(OnViewLocationButtonPressed)
	v17 = fn20("TrackButton", v54)
	v17:SetTextures(trackButtonTextures)
	v17:SetOnPressedCallback(function()
		v17:SetSelected(not v17.mSelected)
		TrackButtonPressed()
	end)
	UpdateCodexButtonsPositions()
end

local function fn22()
	local module18 = require("SF.Interface.Components.Button")
	v12 = module18.Create(
		mMovie,
		"Codex.Content.ClaimRewardBtn",
		"/SF/Language/Codex/ClaimReward",
		"ClaimReward",
		"<MENU_RTRIGGER1>"
	)
	v12:SetVariant(module18.VARIANTS.SPECIAL_BUTTON)
	v12:SetAnchor(module.CENTER_ALIGNED)
	v12:SetVisible(false)
	fn21()
	v16[2] = module17.CreateScrollBar(v9, "Codex.Content.Body.Scrollbar", {
		mVisRangeMaterials = { visibleRangeMaterial, visibleRangeTextMaterial, mainBodyImageMaterial },
		mContentOffset = -10
	})

	v16[2].mScrollValueChangedCallback = function()
		UpdateMainBodyMaskScroll()
	end
end

local function fn23(p)
	local v54 = v16[1]

	if
		v16[2] ~= nil
		and (v54 == nil or mMovie:__wf_atom_5e6e15c8("_root", 30) > mMovie:__wf_atom_5e6e15c8(
			"Codex.SideBar.Entries.Scrollbar",
			2
		) + 50)
	then
		v54 = v16[2]
	end

	if v54 ~= nil then
		v54:ScrollDirection(p)
	end
end

function PopulateScrollbar(p, p2, p3, p4)
	local v54 = v16[p]

	if v54 == nil then
		return
	end

	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(p2, "ScrollArea", 15)
	local v55 = math.max(__wf_atom_cfc41e35, p4 or mMovie:__wf_atom_cfc41e35(p2, p3, 15))
	v54.mClipToScroll = p2 .. "." .. p3
	v54.mCurrentScroll = 0
	v54:SetVisibleProp(__wf_atom_cfc41e35 / v55, nil, true)
	v54:SetHeight(__wf_atom_cfc41e35)
end

local function fn24(p)
	v33 = p

	for i = 1, #v27 do
		local v54 = "Codex.Content.Body.ScrollableRewards.Rewards.Entries.Entry" .. i

		if i == p then
			mMovie:OverrideMaterial(v54 .. ".Backer.Icon.Frame", _G.UIMaterial_SelectedBorder)
			mMovie:__wf_atom_e57658c2(v54, 12, 100)
			mMovie:__wf_atom_7f57ab2f(v54, "Backer.Glow", 13, true)
		else
			mMovie:__wf_atom_e57658c2(v54, 12, 60)
			mMovie:__wf_atom_7f57ab2f(v54, "Backer.Glow", 13, false)
		end
	end
end

local function fn25(mReward)
	local upgradeInfo = SF.UpgradeInfo()
	upgradeInfo.mItemType = mReward
	local cardFromArtifact = module5.CardFromArtifact(upgradeInfo)
	local stats = module5.GetStatsFromUpgrade(cardFromArtifact)
	local v54 = ""

	for i = 1, #stats do
		if v54 ~= "" then
			v54 ..= " "
		end

		v54 ..= stats[i]
	end

	return v54
end

local function fn26(p)
	local v54 = "Codex.Content.Body.ScrollableRewards.Rewards.Entries.Entry" .. p
	local v55 = v27[p]
	mMovie:__wf_atom_e57658c2(v54, 12, 100)
	mMovie:OverrideMaterial(v54 .. ".Divider", horizontalDividerMaterial)
	mMovie:__wf_atom_48bd5a59(v54, "Text.Name", 36, v55.mName)
	mMovie:__wf_atom_4c1c1986(v54, "Text.Name", 44, 4664607)
	mMovie:OverrideMaterial(v54 .. ".Text.Name", visibleRangeTextMaterial)
	mMovie:__wf_atom_48bd5a59(v54, "Text.Desc", 36, v55.mDesc)
	mMovie:__wf_atom_4c1c1986(v54, "Text.Desc", 44, 4664607)
	mMovie:OverrideMaterial(v54 .. ".Text.Desc", visibleRangeTextMaterial)
	mMovie:__wf_atom_48bd5a59(v54, "Text.Attunement", 36, fn25(v55.mReward))
	mMovie:__wf_atom_4c1c1986(v54, "Text.Attunement", 44, 4664607)
	mMovie:OverrideMaterial(v54 .. ".Text.Attunement", visibleRangeTextMaterial)
	mMovie:OverrideMaterial(v54 .. ".Backer.Icon.Frame", _G.UIMaterial_UnfocusedBorder)
	mMovie:__wf_atom_933bbce0(v54 .. ".Backer.Icon.Icon", v55.mIcon, visibleRangeMaterial)
	mMovie:__wf_atom_933bbce0(v54 .. ".Backer.Glow", glowIcon, visibleRangeMaterial)
	mMovie:OverrideMaterial(v54 .. ".Backer.Icon.Backer", visibleRangeMaterial)
	mMovie:__wf_atom_7f57ab2f(v54, "Backer.Glow", 13, false)
	mMovie:__wf_atom_4c1c1986(v54, "Backer.Icon.Backer", 12, 0)
	mMovie:__wf_atom_4c1c1986(v54, "Backer.Icon.Backer", 11, UIColor_Black)
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v54, "Backer.Icon.Frame", 15)
	local v56 = mMovie:__wf_atom_cfc41e35(v54, "Text.Desc", 1) + mMovie:__wf_atom_cfc41e35(v54, "Text.Desc", 41) + 10
	mMovie:__wf_atom_4c1c1986(v54, "Text.Attunement", 1, v56)
	local v57 = v56 + mMovie:__wf_atom_cfc41e35(v54, "Text.Attunement", 41)

	if __wf_atom_cfc41e35 < v57 then
		mMovie:__wf_atom_4c1c1986(v54, "Backer", 1, mMovie:__wf_atom_cfc41e35(v54, "Text", 1) + v57 / 2)
		__wf_atom_cfc41e35 = v57
	else
		mMovie:__wf_atom_4c1c1986(v54, "Text", 1, mMovie:__wf_atom_cfc41e35(v54, "Backer", 1) - v57 / 2)
	end

	mMovie:__wf_atom_4c1c1986(v54, "Backer.Hitbox", 15, __wf_atom_cfc41e35 + 60)
	mMovie:SetCallbacks(v54 .. ".Backer.Hitbox", "RewardFocused", "RewardUnfocused", "RewardReleased", "RewardPressed")
	mMovie:__wf_atom_4c1c1986(v54, "Backer.Hitbox", 100, p)
	mMovie:__wf_atom_7f57ab2f(v54, "Backer.Hitbox", 67, v33 == nil)
	return __wf_atom_cfc41e35
end

local function fn27()
	if #v27 == 0 then
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableRewards.Rewards", 13, false)
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableRewards.Title", 13, false)
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableRewards.Desc", 13, false)
	else
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableRewards.Rewards", 13, true)
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableRewards.Title", 13, true)
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableRewards.Desc", 13, true)
		local v54 = mMovie:__wf_atom_5e6e15c8("Codex.Content.Body.ScrollableRewards.Desc", 1) + mMovie:__wf_atom_5e6e15c8(
			"Codex.Content.Body.ScrollableRewards.Desc",
			41
		)
		mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableRewards.Rewards", 1, v54)
		mMovie:__wf_atom_4c1c1986("Codex.Content.Body.ScrollableRewards.Rewards", "Entries.Entry1", 0, 40)
		local v55 = fn26(1) + 76

		for i = 2, #v27 do
			local v56 = "Codex.Content.Body.ScrollableRewards.Rewards" .. ".Entries.Entry" .. i

			if not mMovie:__wf_atom_253d7085(v56) then
				__wf_atom_86cbd68d(
					mMovie,
					"Codex.Content.Body.ScrollableRewards.Rewards.Entries.Entry1.duplicateMovieClip",
					"Entry" .. i,
					i
				)
			end

			mMovie:__wf_atom_e57658c2(v56, 1, v55)
			v55 += fn26(i) + 76
		end

		fn19("Codex.Content.Body.ScrollableRewards.Rewards.Entries.Entry", #v27)
		v31 = v54 + v55
		mMovie:__wf_atom_4c1c1986("Codex.Content.Body.ScrollableRewards.Rewards", "Entries", 1, 38)

		if type(v33) == "number" then
			fn24(v33)
		end
	end
end

local function fn28()
	for _, mReward in ipairs(v13.mRewards) do
		local mReward2 = Resource(mReward)
		table.insert(v27, {
			mName = Localize(mReward2:__wf_atom_014a76a2():c_str(), nil),
			mDesc = Localize(mReward2:__wf_atom_3a3d2e39():c_str(), nil),
			mIcon = mReward2:GetIconTexture(),
			mReward = mReward2,
			mAttunement = 1
		})

		if not debugScrolling then
			continue
		end

		table.insert(v27, v27[#v27])
		table.insert(v27, v27[#v27])
	end

	v13 = nil
	fn27()
end

local function fn29()
	local v54 = v25[mIndex]

	if v54.mRewardsLoaded then
		return
	end

	v54.mRewardsLoaded = true

	if v54.mHasRewards and v54.mCompleted then
		local __wf_atom_e9f90795 = v54.mItemRes:__wf_atom_e9f90795()

		if #__wf_atom_e9f90795 > 0 then
			for i = 1, #__wf_atom_e9f90795 do
				__wf_atom_e9f90795[i] = __wf_atom_e9f90795[i]:__wf_atom_5b41f63b()
			end

			v13 = {
				mLoader = UISys.__wf_atom_c0dbe47c(__wf_atom_e9f90795),
				mRewards = __wf_atom_e9f90795
			}
		end
	end
end

local function fn30()
	local v54 = v25[mIndex]

	if v54.mNew and not v54.mHasRewards then
		v54.mNew = false
		v54.mScanInfo.mRead = true
		mMovie:__wf_atom_7f57ab2f(v14.mElements[mIndex].mClipName, "New", 13, false)
		table.insert(mScanInfos, v54.mScanInfo)
	end
end

local function fn31()
	module.PlaySound(confirmRewardSound)
	module7.PlayLocalTransmission(vendorTransmissionSet, Symbol("RewardClaimed"), gRegion:__wf_atom_c4f78a8f())
	local envoyInventoryControl = module8.GetEnvoyInventoryControl()

	if not __wf_atom_7e8ad928(envoyInventoryControl) then
		v25[mIndex].mRedeemed = true
		v25[mIndex].mScanInfo.mRedeemed = true
		v25[mIndex].mHasRewards = false
		fn30()
		envoyInventoryControl:__wf_atom_814eeeea(v25[mIndex].mItemRes)
		envoyInventoryControl:__wf_atom_e7ac08e7(v27[v33].mReward, "")
		v34 = true
	end

	for i = 1, #v27 do
		local v54 = "Codex.Content.Body.ScrollableRewards.Rewards.Entries.Entry" .. i
		mMovie:__wf_atom_7f57ab2f(v54, "Backer.Hitbox", 67, false)
	end
end

function SetClaimRewardButtonVisible(p)
	v12:SetVisible(p)
	fn11()
end

function OnReplayButtonPressed()
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.titleString = "/Lotus/Language/Menu/Confirm"
	dialogSettings.locString = "/SF/Language/Codex/ConfirmReplay"

	if
		not __wf_atom_7e8ad928(gRegion)
		and not __wf_atom_7e8ad928(gMatchingService)
		and #gRegion:__wf_atom_3c8e1a7a() > 1
	then
		dialogSettings.locString = "/SF/Language/Codex/ConfirmReplayCoop"
	end

	dialogSettings.firstString = "/SF/Language/Codex/QuestReplay"
	dialogSettings:SetCallback("OnReplayConfirm")
	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
end

function OnTransmissionButtonPressed()
	if v20.mSelected then
		v20:SetSelected(false)
		EndTransmission()
	else
		flag3 = true
		v20:SetSelected(true)
		PlayTransmission()
	end
end

function OnViewLocationButtonPressed()
	if v25 == nil then
		return
	end

	local v54 = v25[mIndex]

	if v54 == nil then
		return
	end

	if v54.mData ~= nil and v54.mData[1] ~= nil and v54.mData[1].Tale ~= nil then
		local tale = v54.mData[1].Tale
		local activeNode = tale:GetActiveNode()
		local firstNode = tale:GetFirstNode()
		local marker = nil

		if __wf_atom_7e8ad928(activeNode) then
			if not __wf_atom_7e8ad928(firstNode) then
				marker = firstNode.marker
			end
		elseif not __wf_atom_7e8ad928(activeNode.marker) then
			marker = activeNode.marker
		end

		_T.FocusMapMarker = marker

		if __wf_atom_7e8ad928(_T.FocusMapMarker) then
			return
		else
			FocusOnLocation()
		end
	end
end

function ResetTransmission()
	local v54 = "Codex.Content.Body.ScrollableBody.MainBody.Entries.Entry" .. v41 - 1
	v40 = 1
	v20:SetSelected(false)
	mMovie:__wf_atom_933bbce0(v54 .. ".Pip.Diamond", pipEmptyIcon, visibleRangeMaterial)
end

function PlayTransmission()
	local v54 = "Codex.Content.Body.ScrollableBody.MainBody.Entries.Entry" .. v40
	local v55 = "Codex.Content.Body.ScrollableBody.MainBody.Entries.Entry" .. v41
	mMovie:__wf_atom_933bbce0(v55 .. ".Pip.Diamond", pipEmptyIcon, visibleRangeMaterial)
	local mBulletEntryData2 = v25[mIndex].mBulletEntryData

	if mBulletEntryData2 == nil then
		return
	end

	mMovie:__wf_atom_933bbce0(v54 .. ".Pip.Diamond", pipHighlightIcon, visibleRangeMaterial)

	if v40 > 1 then
		local v56 = "Codex.Content.Body.ScrollableBody.MainBody.Entries.Entry" .. v40 - 1
		mMovie:__wf_atom_933bbce0(v56 .. ".Pip.Diamond", pipEmptyIcon, visibleRangeMaterial)
	end

	local v56 = mBulletEntryData2[v40]

	if v56 ~= nil and v56.mLocked ~= nil and not v56.mLocked then
		local mText = v56.mText
		module7.CloseTransmissions()

		if mText ~= "???" then
			module7.PlayLocalTransmission(
				empressTransmissionSet,
				Symbol("WorldTree" .. v40),
				gRegion:__wf_atom_c4f78a8f()
			)
		end
	end

	v41 = v40
	v40 += 1

	if v40 >= #mBulletEntryData2 + 1 then
		flag3 = false
	end
end

function OnReplayConfirm(p)
	if tonumber(p) ~= 4 then
		return
	end

	_T.ExitConversation = true
	module6.StartQuest(mQuest, nil)
	module6.ClearTrackedEntry()
	require("SF.Scripts.Libs.CommonFunctionsLib")
	WeakResource("/SF/Levels/MidrathRedux.level")
	local __wf_atom_ade7f08f = gRegion:__wf_atom_ade7f08f()
	__wf_atom_ade7f08f.restartLevel = true
	__wf_atom_ade7f08f.migrateServer = false
	Engine.OpenLevel(__wf_atom_ade7f08f)
end

local function fn32(p)
	if v22 == 5 then
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableBody", 13, true)
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableRewards", 13, false)
		PopulateScrollbar(2, "Codex.Content.Body", "ScrollableBody", v30)
	else
		local flag4 = true

		if p == nil then
			v32 = not v32
		else
			v32 = p
			flag4 = false
		end

		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableBody", 13, not v32)
		local v54 = v25[mIndex]
		local v55 = not __wf_atom_7e8ad928(v54) and not (v32 or __wf_atom_7e8ad928(v54.mImage) or v54.mResourceFormat)
		mMovie:__wf_atom_2dedec1a("Codex.Content.Watermark", 13, v55)
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableRewards", 13, v32)
		local v56 = v33 ~= nil

		if v32 then
			v12:SetActive(false)

			if v56 then
				v12:SetText("/SF/Language/Codex/RewardClaimed")
			else
				v12:SetText("/SF/Language/Codex/ConfirmReward")
				module7.PlayLocalTransmission(
					vendorTransmissionSet,
					Symbol("ClaimReward"),
					gRegion:__wf_atom_c4f78a8f()
				)
			end

			PopulateScrollbar(2, "Codex.Content.Body", "ScrollableRewards", v31)
		else
			fn29()
			v12:SetActive(true)

			if v56 then
				SetClaimRewardButtonVisible(false)

				if type(v33) == "number" then
					v12:SetText("/SF/Language/Codex/ViewReward")
				else
					v12:SetText("/SF/Language/Codex/RewardClaimed")
					v12:SetActive(false)
				end

				if flag4 then
					fn31()
				end
			else
				v12:SetText("/SF/Language/Codex/ClaimReward")
			end

			PopulateScrollbar(2, "Codex.Content.Body", "ScrollableBody", v30)
		end

		fn15()
	end
end

local function fn33()
	flag2 = false
	v38 = true
	mMovie:SetVisible(false)
	mMovie:__wf_atom_fbca497c(false)
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		__wf_atom_2ad5cd23:SetVisible(false)
	end

	if not __wf_atom_7e8ad928(_T.IsShowingBacker) then
		v39 = _T.IsShowingBacker()
		local v54 = { ForceHide = true }

		if not __wf_atom_7e8ad928(_T.HideBackground) then
			_T.HideBackground(v54)
		end
	end

	if not __wf_atom_7e8ad928(_T.SetButtonBarVisible) then
		_T.SetButtonBarVisible(false)
	end
end

function EndTransmission()
	mMovie:SetVisible(true)
	mMovie:__wf_atom_fbca497c(true)
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		__wf_atom_2ad5cd23:SetVisible(true)
	end

	if not __wf_atom_7e8ad928(_T.curTransmission) then
		module2.ClearTransmissionQueue()
		module2.InterruptTransmission()
	end

	if not __wf_atom_7e8ad928(_T.SetButtonBarVisible) then
		_T.SetButtonBarVisible(true)
	end

	v38 = false
	flag = false
	flag3 = false
	local mBulletEntryData2 = v25[mIndex].mBulletEntryData

	if mBulletEntryData2 ~= nil and v40 > #mBulletEntryData2 then
		ResetTransmission()
	end

	if v39 and not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground()
	end

	module7.CloseTransmissions()
end

local function fn34()
	if v32 then
		fn32(false)
		return true
	end

	if flag2 then
		return true
	end

	if not v38 then
		return
	end

	EndTransmission()
	return true
end

local function fn35(p)
	if fn34() and not p then
		return true
	end

	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	_T.gToolTip = nil

	if __wf_atom_7e8ad928(v11) and not __wf_atom_7e8ad928(gRegion) then
		v11 = gRegion:__wf_atom_0a6a5887(Symbol("Codex"))
	end

	if not __wf_atom_7e8ad928(v11) then
		v11:FirePort("Close")
	elseif not fn4() then
		mMovie:Close()
	end
end

function ViewLocation()
	if v25 == nil or mIndex == nil then
		return
	end

	local v54 = v25[mIndex]

	if v54 == nil or __wf_atom_7e8ad928(mMovie) then
		return
	end

	_T.FocusCodexEntry = v54.mItemRes
	_T.FocusCodexTab = codexTabs[v22]
	FocusOnLocation()
end

local function fn36(mDate)
	if #mDate == 0 then
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.Date", 13, false)
		return
	end

	mMovie:__wf_atom_2dedec1a("Codex.Content.Body.Date", 13, true)
	mMovie:__wf_atom_50d60589("Codex.Content.Body.Date.Text", 36, mDate)
	mMovie:__wf_atom_e57658c2("Codex.Content.Body.Date.Text", 44, 4664607)
	mMovie:__wf_atom_e57658c2(
		"Codex.Content.Body.Date.Backer",
		14,
		mMovie:__wf_atom_5e6e15c8("Codex.Content.Body.Date.Text", 40) + 102
	)
	mMovie:SetCallbacks(
		"Codex.Content.Body.ScrollBlocker",
		"ConsumeInput",
		"ConsumeInput",
		"ConsumeInput",
		"ConsumeInput"
	)
end

function RecallMemoryButtonFocused(p)
	local v54 = "Codex.Content.Body.ScrollableBody.MainBody.Entries.Entry" .. p
	mMovie:__wf_atom_e57658c2(v54 .. ".Pip.Diamond", 11, 14524216)
	mMovie:__wf_atom_e57658c2(v54 .. ".Pip", 14, 50)
	mMovie:__wf_atom_e57658c2(v54 .. ".Pip", 15, 50)
	module.PlaySound(_G.UISound_Focus)
	_T.gToolTip = Localize("/SF/Language/Menu/PlayCodexTransmission", true)
end

function RecallMemoryButtonUnfocused(p)
	local v54 = "Codex.Content.Body.ScrollableBody.MainBody.Entries.Entry" .. p
	mMovie:__wf_atom_e57658c2(v54 .. ".Pip.Diamond", 11, v8)
	mMovie:__wf_atom_e57658c2(v54 .. ".Pip", 14, 45)
	mMovie:__wf_atom_e57658c2(v54 .. ".Pip", 15, 45)
	module.PlaySound(_G.UISound_Unfocus)
	_T.gToolTip = nil
end

function RecallMemoryButtonClicked(p)
	if
		not __wf_atom_7e8ad928(mTransmissions)
		and not __wf_atom_7e8ad928(mTransmissions[p])
		and __wf_atom_7e8ad928(_T.curTransmission)
	then
		module2.CreateHudlessTransmission(mTransmissions[p])
		flag2 = true
	end

	module.PlaySound(_G.UISound_Select)
end

local function fn37(p, newGrid)
	local module18 = require("SF.Interface.Libs.ItemUtil")
	module18.Initialize(mMovie, p.mClipName, p, newGrid)
	local v54 = p.mClipName .. ".IconBg"
	mMovie:__wf_atom_933bbce0(v54, gridItemIconBacker, _G.UIMaterial_VerticalVisibilityRange)
	mMovie:__wf_atom_e57658c2(v54, 11, 8152122)
	mMovie:__wf_atom_e57658c2(v54, 12, 50)
	mMovie:__wf_atom_2dedec1a(p.mClipName .. ".IconOutline", 13, false)

	if p.mCogahDrop ~= nil then
		mMovie:__wf_atom_933bbce0(
			p.mClipName .. ".StatusIconMini.Icon",
			cogahIcon,
			_G.UIMaterial_VerticalVisibilityRange
		)
		mMovie:__wf_atom_2dedec1a(p.mClipName .. ".StatusIconMini", 13, p.mCogahDrop)
	end

	fn3(p.mClipName .. ".StatusIconMini.Icon")
	fn3(p.mClipName .. ".Icon")
	fn3(p.mClipName .. ".IconOutline")
	fn3(p.mClipName .. ".IconBg")
end

local function fn38(infoPopup_Data)
	_T.InfoPopup_Data = infoPopup_Data
	__wf_atom_ec43d06e(mMovie, infoPopup_Data.mClipName, 2, { 5, 6 }, { 130, 130 }, 0.15)
	local module18 = require("SF.Interface.Libs.UIUtilities")
	module18.SetItemInfoPopupRect(
		mMovie,
		infoPopup_Data,
		mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 2),
		mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 3),
		mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 14),
		mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 15)
	)
end

local function fn39(p)
	_T.InfoPopup_Data = nil
	__wf_atom_ec43d06e(mMovie, p.mClipName, 2, { 5, 6 }, { 122, 122 }, 0.15)
end

local function fn40(object, mRewards)
	local v54 = Resource("/SF/Types/Game/Ancestors/Orlick/OrlickAncestor")
	object:RemoveElements(true, true)

	for _, v55 in ipairs(mRewards) do
		if __wf_atom_7e8ad928(v55) or __wf_atom_7e8ad928(v7) then
			continue
		end

		local item, mCogahDrop

		if type(v55) == "table" then
			if v55.CustomEntry then
				object:AddElement(v55, true)
				continue
			else
				item = v55.item
				mCogahDrop = v55.mCogahDrop
			end
		else
			item = v55
			mCogahDrop = false
		end

		if item:IsA(__wf_atom_a75640c1) or item:IsA(__wf_atom_2dc5c74e) or item:IsA(__wf_atom_d5a2d4b7) then
			item = v7:__wf_atom_232fd31d(item)
		elseif not item:IsA(__wf_atom_cb425ff5) and item:IsA(__wf_atom_3feeb44a) then
			if item:IsA(WeakResource("/SF/Types/PickUps/DropTables/Defualts/DefaultRngWeaponPickup")) then
				item = item:GetStoreItem()
			else
				item = v7:__wf_atom_232fd31d(item:__wf_atom_1aa27d44())
			end
		end

		if not (item ~= nil and (__wf_atom_7e8ad928(v54) or not item:IsA(v54))) then
			continue
		end

		local storeItemInfo = module13.GetStoreItemInfo(mMovie, item)

		if storeItemInfo == nil then
			continue
		end

		storeItemInfo.mCogahDrop = mCogahDrop
		object:AddElement(storeItemInfo, true)
	end

	local v55 = Resource("/SF/Types/Game/Ancestors/Orlick/OrlickAncestor")
	local mQuest2 = v25[mIndex].mQuest

	if mQuest2 ~= nil then
		local __wf_atom_0942f434 = v55:__wf_atom_0942f434(WeakResource(mQuest2))

		for _, v56 in __wf_atom_0942f434 do
			if not module15.GetAncestorHasUpgradeTagAndQuestSet(v55, v56, mQuest2) then
				continue
			end

			local c_str = module15.GetAncestorRankLocalizeTag(v55, v56, mQuest2):c_str()
			local c_str2 = module15.GetAncestorRankLocalizeDescTag(v55, v56, mQuest2):c_str()
			local ancestorRankIcon = module15.GetAncestorRankIcon(v55, v56, mQuest2)
			object:AddElement(
				{
					Name = mMovie:__wf_atom_8e9ac384(c_str, true),
					Description = mMovie:__wf_atom_8e9ac384(c_str2, true),
					CustomEntry = true,
					Icon = ancestorRankIcon
				},
				true
			)
		end
	end

	object:Redraw(nil, true, true)
end

local function fn41(p)
	local newGrid = module12.CreateNewGrid(getfenv(1), p .. ".RewardItem", {
		mRows = 5,
		mColumns = 8,
		mColumnSeparation = 110,
		mRowSeparation = 110,
		mPadding = 15
	})
	newGrid.mOnFocusedCallback = fn38
	newGrid.mOnUnfocusedCallback = fn39

	function newGrid.mElementDrawCallback(p2)
		fn37(p2, newGrid)
	end

	mMovie:OverrideMaterial(p .. ".Vine", _G.UIMaterial_VerticalVisibilityRange)
	return newGrid
end

function OnBulletPointPressed(p)
	local v54 = v25[mIndex]

	if v54 == nil then
		return
	end

	local v55 = v54.mItemRes == WeakResource("/SF/Types/Lore/MapTreeLoreFragmentMidrath")
	local mBulletEntryData2 = v54.mBulletEntryData

	if mBulletEntryData2 == nil or not v55 then
		return
	end

	if mBulletEntryData2[p].mLocked ~= nil and not mBulletEntryData2[p].mLocked then
		v40 = tonumber(p)
		EndTransmission()
		PlayTransmission()
	end
end

local function fn42(p)
	local v54 = "Codex.Content.Body.ScrollableBody.MainBody.Entries.Entry" .. p
	local v55 = mBulletEntryData[p]
	local mText = v55.mText
	local mCompleted = v55.mCompleted or false
	local mActive = v55.mActive or false
	local mLocked

	if mBulletEntryData[p].mText == nil then
		mLocked = false
	else
		mText = mBulletEntryData[p].mText
		mLocked = mBulletEntryData[p].mLocked or false
	end

	local v56 = mText == "???" or mLocked
	local v57 = 0
	fn6(v54 .. ".Desc")
	mMovie:__wf_atom_48bd5a59(v54, "Desc", 36, mText)
	mMovie:__wf_atom_7f57ab2f(v54, "Desc", 13, not v56)
	mMovie:__wf_atom_7f57ab2f(v54, "IlegibleText", 13, v56)
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v54, "Desc", 41)
	mMovie:OverrideMaterial(v54 .. ".Desc", visibleRangeTextMaterial)
	mMovie:OverrideMaterial(v54 .. ".IlegibleText", visibleRangeTextMaterial)
	mMovie:__wf_atom_4c1c1986(v54, "Pip", 12, 100)
	mMovie:__wf_atom_7f57ab2f(v54, "Pip.Glow", 13, mActive)
	mMovie:__wf_atom_7f57ab2f(v54, "Pip.Pointer", 13, false)
	mMovie:__wf_atom_7f57ab2f(v54, "Pip.Shadow", 13, false)

	if v22 == v5.Journal and v25[mIndex] ~= nil then
		local isTrackedJournalEntry = module6.IsTrackedJournalEntry(v25[mIndex].mEntryId)
		mActive = mActive and isTrackedJournalEntry
	end

	mMovie:__wf_atom_4c1c1986(v54, "Glow", 12, module.Ternary(mActive, 100, 0))
	mMovie:__wf_atom_4c1c1986(v54, "Pip.Glow", 12, module.Ternary(mActive, 40, 0))

	if v56 then
		if mText ~= "???" then
			mText = module4.OdeCipher(mText, 100, "")
		end

		mMovie:__wf_atom_48bd5a59(v54, "IlegibleText", 36, mText)
		mMovie:__wf_atom_4c1c1986(v54, "IlegibleText", 44, 4664607)
		mMovie:__wf_atom_4c1c1986(v54, "IlegibleText", 12, 35)
		mMovie:__wf_atom_4c1c1986(v54, "Pip", 12, 35)
		mMovie:__wf_atom_4c1c1986(v54, "Pip", 11, _G.UIColor_White)
		mMovie:__wf_atom_7f57ab2f(v54, "Pip.Pointer", 13, false)
		mMovie:__wf_atom_7f57ab2f(v54, "Pip.Glow", 13, false)
		mMovie:__wf_atom_7f57ab2f(v54, "Pip.Shadow", 13, false)
		mMovie:__wf_atom_7f57ab2f(v54, "Button", 13, false)
		mMovie:__wf_atom_933bbce0(v54 .. ".Pip.Diamond", pipEmptyIcon, visibleRangeMaterial)
		fn3(v54 .. ".IlegibleText")
		return (math.max(__wf_atom_cfc41e35, mMovie:__wf_atom_cfc41e35(v54, "IlegibleText", 41)))
	else
		mMovie:__wf_atom_933bbce0(v54 .. ".Glow", glowTextIcon, visibleRangeMaterial)
		mMovie:__wf_atom_933bbce0(v54 .. ".Pip.Glow", glowIcon, visibleRangeMaterial)
		mMovie:__wf_atom_933bbce0(
			v54 .. ".Pip.Diamond",
			module.Ternary(mCompleted, pipFullIcon, pipEmptyIcon),
			visibleRangeMaterial
		)
		local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35(v54, "Desc", 40)
		local __wf_atom_cfc41e35_3 = mMovie:__wf_atom_cfc41e35(v54, "Desc", 41)
		mMovie:__wf_atom_4c1c1986(v54, "Glow", 0, __wf_atom_cfc41e35_2 / 2 - 25)
		mMovie:__wf_atom_4c1c1986(v54, "Glow", 1, __wf_atom_cfc41e35_3 / 2 - 5)
		mMovie:__wf_atom_4c1c1986(v54, "Glow", 14, __wf_atom_cfc41e35_2 * 1.3)
		mMovie:__wf_atom_4c1c1986(v54, "Glow", 15, __wf_atom_cfc41e35_3 * 4)
		mMovie:__wf_atom_4c1c1986(v54, "Mask", 1, __wf_atom_cfc41e35_3 / 2)
		mMovie:__wf_atom_4c1c1986(v54, "Mask", 15, __wf_atom_cfc41e35_3 * 3)
		mMovie:__wf_atom_4c1c1986(v54, "Desc", 44, 4664607)
		mMovie:__wf_atom_4c1c1986(v54, "Pip.Diamond", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(v54, "Pip.Glow", 11, 8152122)

		if p == #mBulletEntryData and not mCompleted then
			mMovie:__wf_atom_933bbce0(v54 .. ".Pip.Shadow", shadowIcon, visibleRangeMaterial)
			local v58 = v25[mIndex]

			if not v56 then
				if v58 and v58.mIsSparse then
					mMovie:__wf_atom_7f57ab2f(v54, "Pip.Shadow", 13, false)
					mMovie:__wf_atom_933bbce0(v54 .. ".Pip.Diamond", pipEmptyIcon, visibleRangeMaterial)
				else
					mMovie:__wf_atom_933bbce0(v54 .. ".Pip.Diamond", pipHighlightIcon, visibleRangeMaterial)
					__wf_atom_ec43d06e(mMovie, v54 .. ".Glow", 0, { 12 }, { 100 }, 0.65)
				end
			end
		else
			mMovie:__wf_atom_7f57ab2f(v54, "Pip.Shadow", 13, false)
		end

		if __wf_atom_7e8ad928(mTransmissions) or __wf_atom_7e8ad928(mTransmissions[p]) or mText == "???" then
			mMovie:__wf_atom_e57658c2(v54 .. ".Pip", 14, 50)
			mMovie:__wf_atom_e57658c2(v54 .. ".Pip", 15, 50)
			mMovie:SetCallbacks(v54 .. ".Pip.Diamond", nil, nil, nil, nil)
			mMovie:__wf_atom_7f57ab2f(v54, "Button", 13, false)
		else
			mMovie:__wf_atom_7f57ab2f(v54, "Button", 13, true)
			mMovie:__wf_atom_4c1c1986(v54, "Button", 1, __wf_atom_cfc41e35_3 + 13)

			if __wf_atom_7e8ad928(v26[p]) then
				mMovie:SetCallbacks(
					v54 .. ".Pip.Diamond",
					"RecallMemoryButtonFocused",
					"RecallMemoryButtonUnfocused",
					nil,
					"RecallMemoryButtonClicked"
				)
				mMovie:__wf_atom_e57658c2(v54 .. ".Pip.Diamond", 100, p)
				mMovie:__wf_atom_e57658c2(v54 .. ".Pip.Diamond", 11, 12363651)
				mMovie:__wf_atom_c90af43a(v54 .. ".Pip.Diamond", transmissionButtonTextures[1])
				mMovie:__wf_atom_c90af43a(v54 .. ".Pip.Glow", transmissionButtonTextures[3])
				mMovie:__wf_atom_2dedec1a(v54 .. ".Pip.Glow", 13, true)
				mMovie:__wf_atom_e57658c2(v54 .. ".Pip.Glow", 14, 45)
				mMovie:__wf_atom_e57658c2(v54 .. ".Pip.Glow", 15, 45)
				mMovie:__wf_atom_e57658c2(v54 .. ".Pip", 14, 45)
				mMovie:__wf_atom_e57658c2(v54 .. ".Pip", 15, 45)
				mMovie:__wf_atom_2dedec1a(v54 .. ".Pip.Diamond", 13, true)
				mMovie:__wf_atom_2dedec1a(v54 .. ".Pip.Glow", 13, true)
				mMovie:__wf_atom_e57658c2(v54 .. ".Pip.Glow", 12, 100)
				mMovie:__wf_atom_e57658c2(v54 .. ".Pip.Glow", 11, _G.UIColor_White)
			end
		end

		mMovie:SetCallbacks(v54 .. ".Mask", nil, nil, nil, "OnBulletPointPressed")
		mMovie:__wf_atom_4c1c1986(v54, "Mask", 100, p)
		fn3(v54 .. ".Pip.Glow")
		fn3(v54 .. ".Pip.Diamond")
		fn3(v54 .. ".Desc")
		return v57 + __wf_atom_cfc41e35_3
	end
end

local function fn43(data)
	mMovie:__wf_atom_c90af43a("Codex.Content.IconVines.QuestDecoSymbol.Icon", data.mIcon)

	if data.mTintIcon == nil or not data.mTintIcon then
		mMovie:__wf_atom_e57658c2("Codex.Content.IconVines.QuestDecoSymbol.Icon", 11, UIColor_White)
		mMovie:__wf_atom_e57658c2("Codex.Content.IconVines.QuestDecoSymbol.Icon", 12, 100)
	else
		mMovie:__wf_atom_e57658c2("Codex.Content.IconVines.QuestDecoSymbol.Icon", 11, UIColor_Black)
		mMovie:__wf_atom_e57658c2("Codex.Content.IconVines.QuestDecoSymbol.Icon", 12, 50)
	end

	if data.mSquareIcon then
		mMovie:OverrideMaterial("Codex.Content.IconVines.QuestDecoSymbol.Icon", nil)
	else
		mMovie:OverrideMaterial("Codex.Content.IconVines.QuestDecoSymbol.Icon", iconVisRangeMaterial)
	end

	mMovie:__wf_atom_e57658c2("Codex.Content.IconVines.QuestDecoSymbol.Icon", 14, 160)
	mMovie:__wf_atom_e57658c2("Codex.Content.IconVines.QuestDecoSymbol.Icon", 15, 160)
	fn3("Codex.Content.IconVines.QuestDecoSymbol.VineBacker")
	fn3("Codex.Content.IconVines.QuestDecoSymbol.Icon")
	fn3("Codex.Content.IconVines.QuestDecoSymbol.Gold")
end

function UpdateMainBodyMaskScroll()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Codex.Content.Body.ScrollableBody.BodyImage", 14)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Codex.Content.Body.ScrollableBody.BodyImage", 15)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("Codex.Content.Body.ScrollableBody.BodyImage", 2)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("Codex.Content.Body.ScrollableBody.BodyImage", 3)
	mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.BodyImage", 14, __wf_atom_5e6e15c8)
	mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.BodyImage", 15, __wf_atom_5e6e15c8_2)
	local v54 = __wf_atom_5e6e15c8 * 0.05
	local v55 = __wf_atom_5e6e15c8_2 * 0.05
	local screenDimensions, v56 = module.GetScreenDimensions(mMovie)
	local v57 = (mMovie:__wf_atom_97cd8326() - screenDimensions) / 2
	local v58 = (mMovie:__wf_atom_54eeda24() - v56) / 2
	local v59 = __wf_atom_5e6e15c8 - v54 * 2
	local v60 = __wf_atom_5e6e15c8_2 - v55 * 2

	if __wf_atom_5e6e15c8_3 < v57 then
		v59 += (__wf_atom_5e6e15c8_3 - v57) * 2

		if v59 < 0 then
			__wf_atom_5e6e15c8_3 = v57 + v59 / 2
		else
			__wf_atom_5e6e15c8_3 = v57
		end
	else
		local v61 = v57 + screenDimensions

		if v61 < __wf_atom_5e6e15c8_3 then
			v59 -= (__wf_atom_5e6e15c8_3 - v61) * 2

			if v59 < 0 then
				__wf_atom_5e6e15c8_3 = v61 - v59 / 2
			else
				__wf_atom_5e6e15c8_3 = v61
			end
		end
	end

	if __wf_atom_5e6e15c8_4 < v58 then
		v60 += (__wf_atom_5e6e15c8_4 - v58) * 2

		if v60 < 0 then
			__wf_atom_5e6e15c8_4 = v58 + v60 / 2
		else
			__wf_atom_5e6e15c8_4 = v58
		end
	else
		local v61 = v58 + v56

		if v61 < __wf_atom_5e6e15c8_4 then
			v60 -= (__wf_atom_5e6e15c8_4 - v61) * 2

			if v60 < 0 then
				__wf_atom_5e6e15c8_4 = v61 - v60 / 2
			else
				__wf_atom_5e6e15c8_4 = v61
			end
		end
	end

	mainBodyImageMaterial:__wf_atom_a042ff6c(
		v,
		module.GetVisibilityCenter(mMovie, __wf_atom_5e6e15c8_3, true),
		module.GetVisibilityCenter(mMovie, __wf_atom_5e6e15c8_4)
	)
	mainBodyImageMaterial:__wf_atom_a042ff6c(
		v2,
		module.GetVisibilitySize(mMovie, v59, true),
		module.GetVisibilitySize(mMovie, v60)
	)
	mainBodyImageMaterial:__wf_atom_a042ff6c(
		v3,
		module.GetVisibilitySize(mMovie, v54, true),
		module.GetVisibilitySize(mMovie, v55)
	)
end

local function fn44()
	local v54 = v25[mIndex]
	local _ = codexTabs[v22]
	local mLabel = v54.mLabel
	local mDesc = v54.mDesc
	local v55 = #mDesc > 0
	local v56 = not __wf_atom_7e8ad928(v54.mType)
		and v54.mType:IsA(WeakResource("/SF/Types/Gameplay/Fishing/Fish/SoulFishDecoration"))

	if v54.mLocked ~= nil and v54.mLocked and not v56 then
		if v54.mScanProgress ~= nil then
			mLabel = module4.OdeCipher(mLabel, 1 - v54.mScanProgress, v54.mUnlocalizedLabel)
		end

		v55 = false
	end

	mMovie:__wf_atom_50d60589("Codex.Content.Title.Label", 36, mLabel)
	fn3("Codex.Content.Title.Label")
	fn8()
	fn6("Codex.Content.Title.Label", 1)
	local v57 = -10

	if v55 then
		mMovie:__wf_atom_48bd5a59("Codex.Content.Body.ScrollableBody", "Desc", 36, mDesc)
		mMovie:OverrideMaterial("Codex.Content.Body.ScrollableBody.Desc", visibleRangeTextMaterial)
		mMovie:__wf_atom_4c1c1986("Codex.Content.Body.ScrollableBody", "Desc", 1, -15)
		fn3("Codex.Content.Body.ScrollableBody.Desc")
		fn6("Codex.Content.Body.ScrollableBody.Desc")
	end

	mMovie:__wf_atom_7f57ab2f("Codex.Content.Body.ScrollableBody", "Desc", 13, v55)
	mMovie:__wf_atom_7f57ab2f("Codex.Content.Body.ScrollableBody", "MainBody.Divider", 13, v55)
	mMovie:__wf_atom_4c1c1986("Codex.Content.Body.ScrollableBody", "MainBody.Divider", 12, 50)
	fn3("Codex.Content.Body.ScrollableBody.MainBody.Divider")
	fn36(v54.mDate)
	mMovie:__wf_atom_7f57ab2f(
		"Codex.Content.Body.ScrollableBody",
		"ResourceIcon",
		13,
		v55 and v54.mResourceFormat == true
	)

	if v54.mResourceFormat then
		mMovie:__wf_atom_4c1c1986("Codex.Content.Body.ScrollableBody", "ResourceIcon.Bg", 11, _G.UIColor_Beige)
		mMovie:OverrideMaterial(
			"Codex.Content.Body.ScrollableBody.ResourceIcon.Bg",
			_G.UIMaterial_VerticalVisibilityRange
		)
		mMovie:OverrideMaterial(
			"Codex.Content.Body.ScrollableBody.ResourceIcon.Outline",
			_G.UIMaterial_SelectedTabBorder
		)
		mMovie:__wf_atom_933bbce0(
			"Codex.Content.Body.ScrollableBody.ResourceIcon.Icon",
			v54.mImage,
			_G.UIMaterial_VerticalVisibilityRange
		)
		mMovie:__wf_atom_4c1c1986(
			"Codex.Content.Body.ScrollableBody",
			"Desc",
			0,
			mMovie:__wf_atom_cfc41e35("Codex.Content.Body.ScrollableBody", "ResourceIcon", 14) + 20
		)
		mMovie:__wf_atom_4c1c1986("Codex.Content.Body.ScrollableBody", "Desc", 14, 775)
	else
		mMovie:__wf_atom_4c1c1986("Codex.Content.Body.ScrollableBody", "Desc", 0, 0)
		mMovie:__wf_atom_4c1c1986("Codex.Content.Body.ScrollableBody", "Desc", 14, 918)
	end

	local v58 = "Codex.Content.Body.ScrollableBody.MainBody"
	local v59 = #mBulletEntryData == 0
	local v60 = v54.mBodyImage ~= nil
	local mLocked

	if v54.mLocked == nil then
		mLocked = false
	else
		mLocked = v54.mLocked
	end

	mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableBody.BodyImage", 13, v60)
	mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableBody.BodyImageBG", 13, v60)
	mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableBody.ScribbleBacker", 13, v60)

	if v60 then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Codex.Content.Body.ScrollableBody.BodyImage", 15)
		local v61 = v57 + __wf_atom_5e6e15c8 / 2 + 75
		mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.BodyImage", 1, v61)
		mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.BodyImageBG", 1, v61)
		mMovie:__wf_atom_933bbce0("Codex.Content.Body.ScrollableBody.BodyImage", v54.mBodyImage, mainBodyImageMaterial)
		mMovie:__wf_atom_933bbce0(
			"Codex.Content.Body.ScrollableBody.BodyImageBG",
			v54.mBodyImage,
			mainBodyImageMaterial
		)
		mMovie:OverrideMaterial("Codex.Content.Body.ScrollableBody.ScribbleBacker", visibleRangeMaterial)
		mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.BodyImage", 11, UIColor_White)
		mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.BodyImageBG", 11, UIColor_Black)
		mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.BodyImageBG", 12, 20)
		mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.ScribbleBacker", 11, 8152122)
		mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.ScribbleBacker", 12, 50)
		fn3("Codex.Content.Body.ScrollableBody.BodyImageBG")
		fn3("Codex.Content.Body.ScrollableBody.ScribbleBacker")
		v57 += __wf_atom_5e6e15c8 + 75 + 30
		local v62 = v54.mScanProgress == nil and 1 or v54.mScanProgress
		__wf_atom_ec43d06e(mMovie, "Reveal.Overlay", 0, { function(p)
				mMovie:__wf_atom_1ca72041("Codex.Content.Body.ScrollableBody.BodyImage", "Dissolve", 1 - p, 0, 1, 1)
			end }, { v62 }, 0.65)
		mMovie:__wf_atom_1ca72041("Codex.Content.Body.ScrollableBody.BodyImage", "Dissolve", 1, 0, 1, 1)
	end

	local v61 = "Codex.Content.Body.ScrollableBody.Stats"
	local v62

	if __wf_atom_7e8ad928(v54.mType) then
		v62 = false
	else
		v62 = v56 and not mLocked
	end

	mMovie:__wf_atom_2dedec1a(v61, 13, v62)

	if v62 then
		local v63 = Resource(v54.mType)
		local mSize = v63.mSize
		local minValue = v63.mSizeRange.minValue * mSize
		local maxValue = v63.mSizeRange.maxValue * mSize
		local v64 = Localize("/SF/Language/Fish/FishingFamily" .. v63:__wf_atom_df7ce91d(), nil)
		local _ = Localize("/SF/Language/Fish/FishSize", {
			NUMBER = string.format("%.2f", minValue)
		}) .. " - " .. Localize("/SF/Language/Fish/FishSize", {
			NUMBER = string.format("%.2f", maxValue)
		})
		local v65 = Localize(v63.mBiomeLocTag:c_str(), false)
		mMovie:__wf_atom_c90af43a("Codex.Content.Body.ScrollableBody.ScribbleBacker", fishMainBodyImageBackerTexture)
		mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.ScribbleBacker", 11, _G.UIColor_White)
		local v66 = v57
		local rarity = 0
		local v67 = "Codex.Content.Body.ScrollableBody.Stats.StatsItem1"
		local maxSize = 0

		for _, v68 in ipairs(v44.mFish) do
			if v54.mType ~= v68.type then
				continue
			end

			local _rarity = v68.rarity
			local _maxSize = v68.maxSize

			if not (rarity < v68.rarity) then
				continue
			end

			rarity = v68.rarity
			maxSize = v68.maxSize
		end

		local __wf_atom_5b41f63b = v54.mType:__wf_atom_5b41f63b()
		local __wf_atom_b4c3edde = __wf_atom_21342f4a:__wf_atom_b4c3edde(Symbol("FISH_MAX_SIZE"), __wf_atom_5b41f63b)
		local __wf_atom_b4c3edde2 = __wf_atom_21342f4a:__wf_atom_b4c3edde(Symbol("FISH_MAX_RARITY"), __wf_atom_5b41f63b)

		if
			__wf_atom_b4c3edde2 ~= nil
			and __wf_atom_b4c3edde ~= nil
			and (rarity < __wf_atom_b4c3edde2 or rarity == __wf_atom_b4c3edde2 and mSize < __wf_atom_b4c3edde)
		then
			maxSize = __wf_atom_b4c3edde
			rarity = __wf_atom_b4c3edde2
		end

		local v68 = {
			{
				Label = Localize("/SF/Language/Fish/FishRecordLabel", nil),
				Value = rarity,
				STARS = true
			},
			{
				Label = Localize("/SF/Language/Fish/FishBiomeLabel", nil),
				Value = v65
			},
			{
				Label = Localize("/SF/Language/Fish/FishFamilyLabel", nil),
				Value = v64
			}
		}

		if v54.mRaritySizeRange ~= nil then
			minValue = v54.mRaritySizeRange:__wf_atom_b10b4a73(rarity).minValue
			maxValue = v54.mRaritySizeRange:__wf_atom_b10b4a73(rarity).maxValue
		end

		mMovie:__wf_atom_e57658c2(v61 .. ".Vine", 1, v66)

		for i = 1, #v68 do
			local v69 = "StatsItem" .. i

			if i > 1 then
				__wf_atom_86cbd68d(mMovie, v67 .. ".duplicateMovieClip", v69, i)
			end

			local v70 = v61 .. "." .. v69
			mMovie:__wf_atom_e57658c2(v70 .. ".Backer", 14, 900)
			mMovie:__wf_atom_e57658c2(v70 .. ".Backer", 15, 60)
			mMovie:__wf_atom_e57658c2(v70, 1, v66 + 60 * (i - 1))
			local v71 = v70 .. ".Backer"
			mMovie:OverrideMaterial(v71, fishStatBackerMaterial)
			mMovie:__wf_atom_e57658c2(v71, 11, _G.UIColor_Orange)

			if i % 2 == 0 then
				mMovie:__wf_atom_e57658c2(v71, 12, 0)
			else
				mMovie:__wf_atom_e57658c2(v71, 12, 25)
			end

			local v72 = v70 .. ".Labels"
			local v73 = v70 .. ".Stats"
			mMovie:__wf_atom_50d60589(v72, 36, v68[i].Label)
			mMovie:__wf_atom_50d60589(v73, 36, v68[i].Value)
			mMovie:__wf_atom_e57658c2(v72, 11, _G.UIColor_Brown)
			mMovie:__wf_atom_e57658c2(v73, 11, _G.UIColor_DarkBrown)

			if v68[i].STARS then
				if maxSize > 0 then
					for j = 2, 5 do
						local v74 = "Star" .. j
						local v75 = v70 .. "." .. v74

						if not mMovie:__wf_atom_253d7085(v75) then
							__wf_atom_86cbd68d(mMovie, v70 .. ".Star1.duplicateMovieClip", v74, j)
						end
					end

					local v74 = maxValue - minValue
					local v75 = math.round(maxSize) / 1000
					local v76

					if v74 > 0 then
						math.clamp((v75 - minValue) / v74, 0, 1)
						v76 = math.floor(math.lerp(1, 5, (v75 - minValue) / v74) * 4 + 0.5) / 4
					else
						v76 = 1
					end

					module9.GenerateStars(mMovie, 885 - math.ceil(v76) * 50, v70 .. ".Star", v76, rarity)
					mMovie:__wf_atom_2dedec1a(v73, 13, false)
				else
					for j = 1, 5 do
						mMovie:__wf_atom_2dedec1a(v70 .. ".Star" .. j, 13, false)
					end

					mMovie:__wf_atom_2dedec1a(v73, 13, true)
					mMovie:__wf_atom_50d60589(v73, 36, Localize("/SF/Language/Fish/NoRecord", false))
				end
			else
				mMovie:__wf_atom_2dedec1a(v70 .. ".Star1", 13, false)
			end

			mMovie:__wf_atom_e57658c2(v72, 50, 15)
			local v74 = v70 .. ".Icon"
			local v75 = v70 .. ".Icon1"
			mMovie:__wf_atom_e57658c2(v74, 12, 0)
			mMovie:__wf_atom_e57658c2(v75, 12, 0)
			v57 += 65
		end
	else
		mMovie:__wf_atom_c90af43a("Codex.Content.Body.ScrollableBody.ScribbleBacker", mainBodyImageBackerTexture)
	end

	mMovie:__wf_atom_2dedec1a(v58, 13, not v59)

	if v59 then
		if v16[2] ~= nil then
			v16[2]:SetVisible(false)
		end

		fn32(false)
	else
		if v54.mBulletEntryTitles then
			mMovie:__wf_atom_7f57ab2f(v58, "Entries.Title", 13, true)
			mMovie:__wf_atom_48bd5a59(v58, "Entries.Title", 36, Localize(v54.mBulletEntryTitles, nil))
			mMovie:__wf_atom_4c1c1986(v58, "Entries.Title", 44, 4664607)
			mMovie:OverrideMaterial(v58 .. ".Entries.Title", visibleRangeTextMaterial)
			v57 += mMovie:__wf_atom_cfc41e35(v58, "Entries.Title", 41) + 27
			fn3(v58 .. ".Entries.Title")
			fn6(v58 .. ".Entries.Title")
		else
			mMovie:__wf_atom_7f57ab2f(v58, "Entries.Title", 13, false)
		end

		mMovie:OverrideMaterial(v58 .. ".Divider", horizontalDividerMaterial)
		mMovie:OverrideMaterial(v58 .. ".Entries.Bar", verticalDividerMaterial)
		mMovie:__wf_atom_2dedec1a(v58 .. ".Entries.Bar", 13, false)
		mMovie:__wf_atom_4c1c1986(v58, "Entries.Entry1", 1, v57)
		mMovie:__wf_atom_4c1c1986(v58, "Entries.Entry1", 0, 40)
		local v63 = 1
		local mText = mBulletEntryData[1]

		if mBulletEntryData[1].mText ~= nil then
			mText = mBulletEntryData[1].mText
		end

		if mText == "???" then
			mMovie:__wf_atom_2dedec1a(v58 .. ".Entries.Entry1", 13, false)
		else
			v57 = v57 + fn42(1) + 27
			v63 += 1
			mMovie:__wf_atom_2dedec1a(v58 .. ".Entries.Entry1", 13, true)
		end

		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v58, "Entries.Entry1", 0)

		for i = 2, #mBulletEntryData do
			local v64 = mBulletEntryData[i]
			local mText2 = mBulletEntryData[i]

			if v64.mText ~= nil then
				mText2 = v64.mText
			end

			if not (mText2 ~= "???" or v64.mShowCipher) then
				continue
			end

			local v65 = v58 .. ".Entries.Entry" .. v63

			if not mMovie:__wf_atom_253d7085(v65) then
				__wf_atom_86cbd68d(mMovie, v58 .. ".Entries.Entry1.duplicateMovieClip", "Entry" .. i, i)
			end

			local v66 = fn42(v63)
			mMovie:__wf_atom_e57658c2(v65, 0, __wf_atom_cfc41e35)
			mMovie:__wf_atom_e57658c2(v65, 1, v57)
			v57 += v66 + 27
			v63 += 1
		end

		fn19(v58 .. ".Entries.Entry", v63 - 1)
	end

	mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableBody.GridContainerLeft", 13, false)
	mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableBody.GridContainerRight", 13, false)
	local mRewards = v54.mRewards

	if v54.mDropTables ~= nil then
		mRewards = mRewards == nil and {} or mRewards
		local mDropTables = v54.mDropTables
		local mDropTablesBy__wf_atom_5b41f63b = {}

		for _, mDropTable in ipairs(mDropTables) do
			local __wf_atom_5b41f63b = mDropTable:__wf_atom_5b41f63b()

			if mDropTablesBy__wf_atom_5b41f63b[__wf_atom_5b41f63b] ~= nil then
				continue
			end

			mDropTablesBy__wf_atom_5b41f63b[__wf_atom_5b41f63b] = mDropTable
			local mCogahDrop = string.find(__wf_atom_5b41f63b, "RedNight") ~= nil
			local __wf_atom_d19a9538 = Resource(mDropTable):__wf_atom_d19a9538()

			for _, v64 in ipairs(__wf_atom_d19a9538) do
				local __wf_atom_5b41f63b2 = v64:__wf_atom_5b41f63b()
				local v65 = {}

				if mRewards[__wf_atom_5b41f63b2] == nil then
					v65.item = v64
					mRewards[__wf_atom_5b41f63b2] = v65
					table.insert(mRewards, v65)
				end

				v65.mCogahDrop = mCogahDrop
			end
		end
	end

	if v54.mFaction ~= nil then
		local mFaction = v54.mFaction
		local mIcon

		if mFaction ~= nil then
			mIcon = v4[tostring(mFaction)]

			if mIcon ~= nil then
				v54.mIcon = mIcon
			end
		end

		mMovie:__wf_atom_2dedec1a("Codex.Content.IconVines.QuestDecoSymbol", 13, mIcon ~= nil)
		v54.mSquareIcon = mIcon ~= nil
		fn43(v54)
	end

	if not mLocked and mRewards ~= nil and #mRewards > 0 then
		if v53 == nil then
			v53 = fn41("Codex.Content.Body.ScrollableBody.GridContainerLeft")
		end

		fn40(v53, mRewards)
		fn3("Codex.Content.Body.ScrollableBody.GridContainerLeft.Label")
		fn3("Codex.Content.Body.ScrollableBody.GridContainerLeft.Vine")
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableBody.GridContainerLeft", 13, true)
		local v63 = 450
		local v64 = v57 + mMovie:__wf_atom_cfc41e35("Codex.Content.Body.ScrollableBody", "Desc", 41) + 135

		if v63 <= v64 then
			v63 = v64
		end

		if v60 then
			v63 -= 160
		end

		local v65 = 100

		if v53 ~= nil and v53.mColumns ~= 0 then
			local v66 = #v53.mElements / v53.mColumns
			v65 = math.max((v53.mRowSeparation + 40) * v66, v65)
		end

		mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.GridContainerLeft", 1, v63)
		v57 += v65 - 100
	end

	v30 = v57 - 27 - 15
	mMovie:__wf_atom_4c1c1986(v58, "Entries.Bar", 15, v30)

	if v55 then
		local v63 = mMovie:__wf_atom_5e6e15c8("Codex.Content.Body.ScrollableBody.Desc", 1) + mMovie:__wf_atom_5e6e15c8(
			"Codex.Content.Body.ScrollableBody.Desc",
			41
		) + 15

		if v54.mResourceFormat then
			v63 = mMovie:__wf_atom_cfc41e35("Codex.Content.Body.ScrollableBody", "ResourceIcon", 1) + mMovie:__wf_atom_cfc41e35(
				"Codex.Content.Body.ScrollableBody",
				"ResourceIcon",
				15
			) - 36
		end

		mMovie:__wf_atom_e57658c2(v58, 1, v63)
		mMovie:__wf_atom_4c1c1986(v58, "Entries", 1, 30)
		mMovie:__wf_atom_7f57ab2f(v58, "Divider", 13, false)
		v30 += v63 + 30
	else
		mMovie:__wf_atom_e57658c2(v58, 1, 0)
		mMovie:__wf_atom_4c1c1986(v58, "Entries", 1, 0)
	end

	fn32(false)
	UpdateMainBodyMaskScroll()
end

local function fn45(state)
	local mClipName = state.mClipName

	if state.mClipName == nil then
		return
	end

	local _ = mIndex == state.mIndex
	fn7(mClipName .. ".Label")
	mMovie:__wf_atom_48bd5a59(mClipName, "Label", 46, "center")
	mMovie:__wf_atom_48bd5a59(mClipName, "Label", 36, state.mLabel)
	mMovie:__wf_atom_4c1c1986(mClipName, "Label", 44, 4664607)
	mMovie:__wf_atom_4c1c1986(mClipName, "Label", 0, 30)
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(mClipName, "Backer", 1)
	local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35(mClipName, "Label", 41)
	mMovie:__wf_atom_4c1c1986(mClipName, "Label", 1, __wf_atom_cfc41e35 - __wf_atom_cfc41e35_2 / 2 - 6)
	mMovie:__wf_atom_433c28ce(false)
	mMovie:OverrideMaterial(mClipName .. ".Label", visibleRangeTextLocationsMaterial)
	mMovie:OverrideMaterial(mClipName .. ".Icon.Frame", visibleRangeLocationsMaterial)
	mMovie:OverrideMaterial(mClipName .. ".Icon.Mask", visibleRangeLocationsMaterial)
	mMovie:OverrideMaterial(mClipName .. ".Divider", visibleRangeLocationsMaterial)
	mMovie:OverrideMaterial(mClipName .. ".Icon.StatusIcon", visibleRangeLocationsMaterial)
	mMovie:__wf_atom_933bbce0(
		mClipName .. ".Backer",
		state.mIndex == mIndex and locationBackerSelectedIcon or locationBackerIcon,
		visibleRangeLocationsMaterial
	)
	local v54 = mClipName .. ".Icon.Icon"
	mMovie:__wf_atom_933bbce0(v54, state.mIcon, iconVisRangeMaterial)
	mMovie:__wf_atom_2dedec1a(mClipName .. ".Icon.StatusIcon", 13, false)
	local v55 = state.mIcon ~= nil

	if v22 == v5.Journal and not (v55 or state.IsDivider) then
		state.mIcon = defaultEntryListIcon
	end

	mMovie:__wf_atom_933bbce0(mClipName .. ".New.Icon", staticAlertIcon, visibleRangeLocationsMaterial)
	mMovie:__wf_atom_7f57ab2f(mClipName, "New", 13, state.mNew)
	mMovie:__wf_atom_7f57ab2f(mClipName, "Glow", 13, false)
	mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 12, 100)

	if state.IsDivider == nil or not state.IsDivider then
		if state.mClipName ~= nil then
			mMovie:__wf_atom_2dedec1a(state.mClipName .. ".Backer", 13, true)
			mMovie:__wf_atom_e57658c2(state.mClipName .. ".Divider", 12, 0)
		end
	else
		state.mHeight = 45
		mMovie:__wf_atom_2dedec1a(state.mClipName, 67, false)
		mMovie:__wf_atom_2dedec1a(state.mClipName .. ".Backer", 13, false)
		mMovie:__wf_atom_e57658c2(state.mClipName .. ".Divider", 12, 20)
		mMovie:__wf_atom_2dedec1a(state.mClipName .. ".Divider", 13, true)
	end
end

local function fn46(data)
	if data == nil or data.mIndex == nil or data.mClipName == nil then
		return
	end

	if math.random() < 0.1 and not v36 then
		module7.PlayLocalTransmission(
			vendorTransmissionSet,
			Symbol("EntrySelectRank" .. 0),
			gRegion:__wf_atom_c4f78a8f()
		)
		v36 = true
	end

	local v54

	if not (mIndex == nil or v22 == v5.Codex_Enemies or v22 == v5.Codex_Wildlife) then
		v54 = v14.mElements[mIndex]
		local mClipName = v54.mClipName

		if mClipName ~= nil then
			local mLabel = v14.mElements[mIndex].mLabel
			mMovie:__wf_atom_48bd5a59(mClipName, "Label", 36, mLabel)
			local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(mClipName, "Backer", 1)
			local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35(mClipName, "Label", 41)
			mMovie:__wf_atom_4c1c1986(mClipName, "Label", 1, __wf_atom_cfc41e35 - __wf_atom_cfc41e35_2 / 2 - 6 + 2)
			mMovie:__wf_atom_c90af43a(mClipName .. ".Backer", locationBackerIcon)
			mMovie:__wf_atom_4c1c1986(mClipName, "Label", 44, 4664607)
			mMovie:__wf_atom_4c1c1986(mClipName, "Label", 5, 100)
			mMovie:__wf_atom_4c1c1986(mClipName, "Label", 6, 100)

			if v54.mTintIcon == nil or not v54.mTintIcon then
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon.Icon", 11, UIColor_White)
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon.Icon", 12, 70)
			else
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon.Icon", 11, UIColor_Black)
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon.Icon", 12, 20)
			end

			mMovie:__wf_atom_7f57ab2f(mClipName, "Glow", 13, false)
		end

		module.PlaySound(locationSelectSound)
	end

	mIndex = data.mIndex
	local v55 = v25[mIndex]
	mBulletEntryData = v55.mBulletEntryData
	mTransmissions = v55.mTransmissions
	v55.mRewardsLoaded = false
	v27 = {}
	mQuest = v55.mQuest
	mMovie:__wf_atom_933bbce0("Codex.Content.Watermark", v55.mImage, watermarkMaterial)
	mMovie:__wf_atom_2dedec1a(
		"Codex.Content.Watermark",
		13,
		not (__wf_atom_7e8ad928(v55.mImage) or v55.mResourceFormat)
	)
	fn3("Codex.Content.Watermark")
	mMovie:__wf_atom_2dedec1a("Codex.Content.Title", 13, true)
	mMovie:__wf_atom_2dedec1a("Codex.Content.Body", 13, true)
	local mClipName = data.mClipName
	local v56 = "<p><font size=\"22\"><b>" .. data.mLabel .. "</b></font></p>"
	mMovie:__wf_atom_48bd5a59(mClipName, "Label", 36, v56)
	mMovie:__wf_atom_c90af43a(mClipName .. ".Backer", locationBackerSelectedIcon)
	mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 12, 100)
	mMovie:__wf_atom_4c1c1986(mClipName, "Label", 44, 4664607)
	mMovie:__wf_atom_4c1c1986(mClipName, "Label", 5, 105)
	mMovie:__wf_atom_4c1c1986(mClipName, "Label", 6, 105)
	mMovie:__wf_atom_933bbce0(mClipName .. ".Glow", glowTextIcon, visibleRangeLocationsMaterial)
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(mClipName, "Label", 40)
	mMovie:__wf_atom_cfc41e35(mClipName, "Label", 41)
	local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35(mClipName, "Label", 0)
	local __wf_atom_cfc41e35_3 = mMovie:__wf_atom_cfc41e35(mClipName, "Label", 1)
	local __wf_atom_cfc41e35_4 = mMovie:__wf_atom_cfc41e35(mClipName, "Backer", 1)
	local __wf_atom_cfc41e35_5 = mMovie:__wf_atom_cfc41e35(mClipName, "Label", 41)
	local v57 = v54 == nil and 0 or 1
	mMovie:__wf_atom_4c1c1986(mClipName, "Label", 1, __wf_atom_cfc41e35_4 - __wf_atom_cfc41e35_5 / 2 - 6 + v57)
	mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 0, __wf_atom_cfc41e35 / 2 + __wf_atom_cfc41e35_2)
	mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 1, __wf_atom_cfc41e35_5 / 2 + __wf_atom_cfc41e35_3 + 6)
	mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 14, __wf_atom_cfc41e35 * 3)
	mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 15, __wf_atom_cfc41e35_5 * 3)
	mMovie:__wf_atom_7f57ab2f(mClipName, "Glow", 13, false)

	if v55.mRedeemed then
		v33 = true
	else
		v33 = nil
	end

	local v58 = data.mIcon ~= nil
	mMovie:__wf_atom_2dedec1a("Codex.Content.IconVines.QuestDecoSymbol", 13, v58)

	if v58 then
		fn43(data)
	end

	fn3("Codex.Content.IconVines")
	fn30()
	fn44()
	mVisible = false
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		local __wf_atom_cca6e0bc = __wf_atom_eab484a7:__wf_atom_cca6e0bc()

		if not __wf_atom_7e8ad928(__wf_atom_cca6e0bc) then
			mVisible = __wf_atom_cca6e0bc:__wf_atom_88eea4f9(v55.mItemRes).mVisible
		end
	end

	fn15()
	SetClaimRewardButtonVisible(false)
	local codexTab = codexTabs[v22]

	if codexTab == Symbol("Journal") then
		v55 = v25[mIndex]
		local isTrackedJournalEntry = module6.IsTrackedJournalEntry(v55.mEntryId)
		fn14(v55, isTrackedJournalEntry)
		local v59 = fn12(isTrackedJournalEntry)
		v17:SetVisible(true)
		v17:SetTooltip(v59)
		fn3(v17.mClipName .. ".Icon")
		fn3(v17.mClipName .. ".IconBacker")
		local v60 = v55.mData ~= nil and v55.mData[1] ~= nil and v55.mData[1].Tale ~= nil
		v18:SetVisible(v60)
		v21:SetVisible(v60)
		fn3(v18.mClipName .. ".Icon")
		fn3(v18.mClipName .. ".IconBacker")
		fn3(v21.mClipName .. ".Icon")
		fn3(v21.mClipName .. ".IconBacker")
	elseif codexTab == Symbol("Fables") then
		if not __wf_atom_7e8ad928(mQuest) then
			local __wf_atom_62750b0b = module6.GetQuestController():__wf_atom_62750b0b()
			local v59 = false

			for _, v60 in ipairs(__wf_atom_62750b0b) do
				if v60 == mQuest then
					v59 = v60:__wf_atom_f28ee798()
				end
			end

			v19:SetVisible(v59)
			fn3(v19.mClipName .. ".Icon")
			fn3(v19.mClipName .. ".IconBacker")
			SetClaimRewardButtonVisible(false)
		end
	elseif codexTab == Symbol("Locations") then
		local v59 = data.mItemRes == WeakResource("/SF/Types/Lore/MapTreeLoreFragmentMidrath")
		v20:SetVisible(v59)
		fn3(v20.mClipName .. ".Icon")
		fn3(v20.mClipName .. ".IconBacker")
	else
		SetClaimRewardButtonVisible(v55.mCompleted and v55.mHasRewards)
	end

	if v55.mRewardsRandom then
		mMovie:__wf_atom_50d60589(
			"Codex.Content.Body.ScrollableBody.GridContainerLeft.Label",
			36,
			Localize("/SF/Language/Codex/PossibleSpoils", nil)
		)
	else
		mMovie:__wf_atom_50d60589(
			"Codex.Content.Body.ScrollableBody.GridContainerLeft.Label",
			36,
			Localize("/SF/Language/Codex/Spoils", nil)
		)
	end

	UpdateCodexButtonsPositions()
end

local function fn47()
	if v14 ~= nil then
		local focusCodexEntry = _T.FocusCodexEntry

		if not __wf_atom_7e8ad928(focusCodexEntry) then
			for _, v54 in ipairs(v25) do
				if v54.mItemRes == focusCodexEntry then
					v14:SelectElement(v54.mIndex)
				end
			end
		end
	end
end

local function fn48(p)
	local mClipName = p.mClipName

	if __wf_atom_7e8ad928(mClipName) then
		return
	end

	if p.mIndex ~= mIndex then
		mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 12, 40)
		mMovie:__wf_atom_c90af43a(mClipName .. ".Backer", locationBackerSelectedIcon)
	end

	module.PlaySound(locationHoverSound)
end

local function fn49(p)
	local mClipName = p.mClipName

	if __wf_atom_7e8ad928(mClipName) then
		return
	end

	mMovie:__wf_atom_4c1c1986(mClipName, "Backer", 12, 100)
	mMovie:__wf_atom_c90af43a(
		mClipName .. ".Backer",
		p.mIndex == mIndex and locationBackerSelectedIcon or locationBackerIcon
	)
end

local function fn50(data)
	module.PlaySound(locationHoverSound)
	local mClipName = data.mClipName

	if not mMovie:__wf_atom_1b848254(mClipName) then
		__wf_atom_ec43d06e(mMovie, mClipName .. ".IconOutline", 2, { 12 }, { 100 }, 0.1)
		__wf_atom_ec43d06e(mMovie, mClipName .. ".IconFlare", 2, { 12 }, { 100 }, 0.1)
	end

	__wf_atom_ec43d06e(mMovie, mClipName .. ".Icon", 2, { 5, 6 }, { 315, 315 }, 0.1)
end

local function fn51(p, p2)
	if p == nil then
		return
	end

	local mClipName = p.mClipName

	if mClipName == nil then
		return
	end

	if p2 or not mMovie:__wf_atom_1b848254(mClipName) and v25[mIndex] ~= p then
		__wf_atom_ec43d06e(mMovie, mClipName .. ".IconOutline", 2, { 12 }, { 0 }, 0.1)
		__wf_atom_ec43d06e(mMovie, mClipName .. ".IconFlare", 2, { 12 }, { 0 }, 0.1)
	end

	__wf_atom_ec43d06e(mMovie, mClipName .. ".Icon", 2, { 5, 6 }, { 300, 300 }, 0.1)
end

local function fn52(data, p)
	local module18 = require("SF.Interface.Libs.ItemUtil")
	module18.Initialize(mMovie, data.mClipName, data, p)
	local v54 = data.mClipName .. ".Icon"
	local v55 = data.mClipName .. ".IconBg"
	local v56 = data.mClipName .. ".IconOutline"
	mMovie:__wf_atom_933bbce0(v55, gridItemIconBacker, visibleRangeLocationsMaterial)
	mMovie:__wf_atom_c90af43a(v54, data.mGridIcon)
	mMovie:__wf_atom_2dedec1a(v54, 13, true)

	if data.mLocked == nil or not data.mLocked then
		mMovie:__wf_atom_e57658c2(v54, 12, 100)
	else
		mMovie:__wf_atom_e57658c2(v54, 11, UIColor_Black)
		mMovie:__wf_atom_e57658c2(v54, 12, 20)
	end

	mMovie:__wf_atom_e57658c2(v56, 14, 110)
	mMovie:__wf_atom_e57658c2(v56, 15, 110)
	mMovie:OverrideMaterial(v56, gridBorderMaterial)
	mMovie:__wf_atom_e57658c2(v56, 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2(v55, 11, 8152122)
	mMovie:__wf_atom_e57658c2(v55, 12, 50)
	mMovie:__wf_atom_e57658c2(data.mClipName .. ".IconOutline", 12, 0)
	mMovie:__wf_atom_2dedec1a(data.mClipName .. ".IconFlare", 13, true)
	mMovie:__wf_atom_e57658c2(data.mClipName .. ".IconFlare", 12, 0)

	if v25[mIndex] == data then
		fn50(data)
	end
end

local function fn53(p)
	fn51(v25[mIndex], true)
	fn46(p)
	v14:SelectElement(p.mIndex)
	module.PlaySound(locationSelectSound)
end

local function fn54()
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35("Codex.SideBar.Entries", "ScrollArea", 15)

	if v15 == nil then
		v15 = module12.CreateNewGrid(getfenv(1), "Codex.SideBar.Entries.Scrollable.Completed.GridEntry", {
			mColumns = 3,
			mColumnSeparation = 130,
			mRowSeparation = 130,
			mPadding = 15
		})
	end

	v15.mOnSelectedCallback = fn53
	v15.mOnFocusedCallback = fn50
	v15.mOnUnfocusedCallback = fn51

	function v15.mElementDrawCallback(p)
		fn52(p, v15)
	end

	if v14 ~= nil then
		v14:RemoveElements(true)
	end

	v15.mRows = math.ceil(100 / 3)
	local count = 0

	for _, v54 in v25 do
		v15:AddElement(v54, true)

		if v54.mLocked ~= nil and v54.mLocked then
			count += 1
		end
	end

	v15.mRows = math.ceil(#v15.mElements / 3)
	v15:AttachScrollBar("Codex.SideBar.Entries.Scrollbar", {
		mHeight = __wf_atom_cfc41e35,
		mVisRangeMaterials = { visibleRangeLocationsMaterial, visibleRangeTextLocationsMaterial, gridBorderMaterial },
		mContentOffset = 12
	})
	v16[1] = v15.mScrollBar
	v15:Redraw(nil, true, true)
	mMovie:__wf_atom_2dedec1a("Codex.SideBar.CountText", 13, true)
	mMovie:__wf_atom_5e6e15c8("Codex.SideBar.Entries.Scrollbar", 0)
	mMovie:__wf_atom_e57658c2("Codex.SideBar.CountText", 44, 4664607)
	local v54 = #v25 - count .. " / " .. #v25
	mMovie:__wf_atom_50d60589("Codex.SideBar.CountText", 36, v54)
	local v55 = #v15.mElements == 0
	mMovie:__wf_atom_2dedec1a("Codex.SideBar.EmptyText", 13, v55)
	mMovie:__wf_atom_2dedec1a("Codex.AdventCalendar.EmptyState", 13, v55)
	mMovie:__wf_atom_2dedec1a("Codex.AdventCalendar.EmptyState", 13, v55)
	mMovie:__wf_atom_2dedec1a("Codex.Content", 13, not v55)
	v15:SelectElement(1)
end

local function fn55()
	v44 = {}

	if not (__wf_atom_7e8ad928(__wf_atom_a0f6588f) and __wf_atom_7e8ad928(__wf_atom_21342f4a)) then
		v44 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_af5caba7()
	end
end

function OnAnimalTabFocused(p)
	__wf_atom_ec43d06e(mMovie, v45[p], 2, { 12, 5, 6 }, { 100, 573.24, 286.62 }, 0.15)
end

function OnAnimalTabUnfocused(p)
	local v54 = v46 == p and 100 or 70
	__wf_atom_ec43d06e(mMovie, v45[p], 2, { 12, 5, 6 }, { v54, 562, 281 }, 0.15)
end

function OnAnimalTabReleased(_) end

function UpdateAnimalTabTextures(p)
	for i = 1, #v45 do
		if p == i then
			continue
		end

		mMovie:__wf_atom_c90af43a(v45[i], inactiveWildlifeTabIcons[i])
		mMovie:__wf_atom_e57658c2(v45[i], 12, 70)
	end

	mMovie:__wf_atom_c90af43a(v45[p], activeWildlifeTabIcons[p])
	mMovie:__wf_atom_e57658c2(v45[p], 12, 100)
end

function OnAnimalTabPressed(p)
	if p == v46 then
		return
	end

	v46 = p
	UpdateAnimalTabTextures(v46)
	SetActiveTab(v22)
end

local function fn56(p)
	mMovie:__wf_atom_e57658c2(v45[p], 100, p)
	mMovie:SetCallbacks(
		v45[p],
		"OnAnimalTabFocused",
		"OnAnimalTabUnfocused",
		"OnAnimalTabReleased",
		"OnAnimalTabPressed"
	)
	UpdateAnimalTabTextures(v46)
end

local function fn57()
	mMovie:__wf_atom_2dedec1a("Codex.SideBar.AnimalTabs", 13, true)
	v45[1] = "Codex.SideBar.AnimalTabs.LeftTab"
	v45[2] = "Codex.SideBar.AnimalTabs.RightTab"
	mMovie:__wf_atom_c90af43a(v45[1], inactiveWildlifeTabIcons[1])
	mMovie:__wf_atom_c90af43a(v45[2], activeWildlifeTabIcons[2])
	fn56(1)
	fn56(2)
	mMovie:__wf_atom_4c1c1986("Codex.SideBar.Entries", "ScrollArea", 15, v43 - 80)
	mMovie:__wf_atom_e57658c2("Codex.SideBar.Entries", 1, 200)
end

local function fn58()
	local v54 = fn16(mMovie:__wf_atom_8e9ac384("<LEAF_TINTED> ", true), 4664607) .. fn16(
		Localize("/SF/Language/Codex/CompletedResonance", nil),
		2825751
	)
	mMovie:__wf_atom_e57658c2("Codex.SideBar.Entries.Scrollable.Completed", 1, 0)
	mMovie:__wf_atom_48bd5a59("Codex.SideBar.Entries.Scrollable.Completed", "Title", 36, fn17(v54))
	mMovie:OverrideMaterial("Codex.SideBar.Entries.Scrollable.Completed.Title", visibleRangeTextMaterial)
	mMovie:__wf_atom_7f57ab2f("Codex.SideBar.Entries.Scrollable.Completed", "Title", 13, false)
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35("Codex.SideBar.Entries", "ScrollArea", 15)
	mMovie:__wf_atom_4c1c1986("Codex.SideBar.Entries.Scrollable.Completed", "Entry", 1, 40)

	if v14 == nil then
		v14 = module16.CreateNewList(v9, "Codex.SideBar.Entries.Scrollable.Completed.Entry")
		v14.mElementDrawCallback = fn45
		v14.mOnSelectedCallback = fn46
		v14.mOnFocusedCallback = fn48
		v14.mOnUnfocusedCallback = fn49
		v14.mForceHorizontalSeparation = 0
		v14.mForcedVerticalSeparation = 80
	else
		v14:RemoveElements(true)
	end

	for _, v55 in ipairs(v25) do
		v14:AddElement(v55, true)
	end

	v14:AttachScrollBar("Codex.SideBar.Entries.Scrollbar", {
		mHeight = __wf_atom_cfc41e35,
		mVisRangeMaterials = { visibleRangeLocationsMaterial, visibleRangeTextLocationsMaterial },
		mContentOffset = 15
	})
	v16[1] = v14.mScrollBar
	v14:Redraw(nil, true)
	v14:SelectElement(1)
	mMovie:__wf_atom_4c1c1986("Codex.SideBar.Entries.Scrollable", "Entry", 1, 0)

	if mIndex == nil then
		SetClaimRewardButtonVisible(false)
		mMovie:__wf_atom_2dedec1a("Codex.Content.Title", 13, false)
		mMovie:__wf_atom_2dedec1a("Codex.Content.Body", 13, false)
	end

	local v55 = #v25 == 0
	mMovie:__wf_atom_7f57ab2f("Codex.SideBar.Entries.Scrollable.Completed", "Entry", 13, not v55)
	mMovie:__wf_atom_2dedec1a("Codex.SideBar.CountText", 13, false)
	mMovie:__wf_atom_2dedec1a("Codex.SideBar.EmptyText", 13, v55)
	mMovie:__wf_atom_2dedec1a("Codex.AdventCalendar.EmptyState", 13, v55)
	mMovie:__wf_atom_2dedec1a("Codex.Content", 13, not v55)
end

local function fn59(p)
	__wf_atom_ec43d06e(mMovie, p, 2, { 12 }, { 50 }, 0.5, 0, function()
		__wf_atom_ec43d06e(mMovie, p, 1, { 12 }, { 0 }, 1, 0, function()
			fn59(p)
		end)
	end)
end

local function fn60(p, p2)
	if p then
		if not mMovie:__wf_atom_1b848254(p2) then
			fn59(p2)
		end
	else
		mMovie:__wf_atom_290807ee(p2)
		mMovie:__wf_atom_e57658c2(p2, 12, 0)
	end
end

local function fn61(items)
	local __wf_atom_13d5b7e9 = __wf_atom_c67f9605:__wf_atom_13d5b7e9(module11.GetPlayerFaction())

	if __wf_atom_13d5b7e9 ~= nil then
		local v54 = Resource(__wf_atom_13d5b7e9:__wf_atom_6e1dcf41())

		if not __wf_atom_7e8ad928(v54) then
			local __wf_atom_a838ae3a = v54:__wf_atom_a838ae3a()

			for _, item in items do
				if item.mQuestType ~= 1 then
					continue
				end

				item.mRewards = {}
				item.mRewardsRandom = true

				if not (item.mData ~= nil and item.mData[1] ~= nil) then
					continue
				end

				local entity = item.mData[1].Entity

				if entity == nil then
					continue
				end

				local v55 = __wf_atom_a838ae3a[entity.encounterSchema.mEncounterIdx + 1]

				if v55 == nil then
					continue
				end

				local mDifficultyTier = entity.encounterSchema.mDifficultyTier
				local mDifficultyTier2 = v55.mDifficultyTiers[mDifficultyTier + 1]

				if mDifficultyTier2 == nil then
					continue
				end

				table.insert(item.mRewards, {
					Name = mMovie:__wf_atom_8e9ac384("/SF/Language/Currency/StandingCurrencyName", true),
					Description = mMovie:__wf_atom_8e9ac384(
						"<REPUTATION>" .. tostring(mDifficultyTier2.mRewardSyndicateXP or 0),
						true
					),
					Icon = item.mIcon,
					CustomEntry = true
				})
				local mRewardManifest = mDifficultyTier2.mRewardManifest

				if __wf_atom_7e8ad928(mRewardManifest) then
					continue
				end

				for i = 0, mRewardManifest:__wf_atom_d1247c6c(mDifficultyTier) - 1 do
					local tieredItem = mRewardManifest:GetTieredItem(mDifficultyTier, i)
					table.insert(item.mRewards, tieredItem:GetStoreItem())
				end
			end
		end
	end
end

local function fn62(list)
	module9.GetJournalEntries(mMovie, list)

	if #list > 0 then
		mIndex = 1
		fn61(list)
	end
end

local function fn63()
	local v54 = false
	local v55 = nil

	if v22 == v5.Codex_Enemies then
		v55 = WeakResource("/SF/Types/Game/SFNpcAvatar")
	elseif v22 == v5.Codex_Wildlife then
		if v46 == 1 then
			v55 = WeakResource("/SF/Types/Game/CreatureBaseAvatar")
		else
			v55 = WeakResource("/SF/Types/Gameplay/Fishing/Fish/SoulFishHealthyDecoration")
			v54 = true
		end

		fn57()
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local v56

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		v56 = __wf_atom_18a5d83b:__wf_atom_af5caba7()
	end

	if v56 ~= nil then
		mScans = v56.mScans
	end

	UpdateMainBodyMaskScroll()
	module9.PopulateForCodexScans(v25, v6, mScans, v55, v54)
	table.sort(v25, fn)
end

local function fn64()
	v17:SetVisible(#v14.mElements > 0)
	mMovie:__wf_atom_933bbce0("Codex.Content.Watermark", emptyJournalWatermark, watermarkMaterial)
	local v54 = not __wf_atom_7e8ad928(emptyJournalWatermark) and #v14.mElements == 0
	mMovie:__wf_atom_2dedec1a("Codex.Content.Watermark", 13, v54)

	if v54 and v16[1] ~= nil then
		v16[1]:SetVisible(false)
	end

	local v55 = nil

	for i = 1, #v14.mElements do
		local mElement = v14.mElements[i]

		if not (module6.IsTrackedJournalEntry(mElement.mEntryId) or mElement.mQuest ~= nil and module6.IsQuestTracked(mElement.mQuest)) then
			continue
		end

		v55 = mElement
		break
	end

	if v55 ~= nil then
		v14:SelectElement(v55.mIndex)
		fn14(v55, true)
	end
end

function SetActiveTab(p)
	local codexTab = codexTabs[p]

	if codexTab == nil then
		return
	end

	mMovie:__wf_atom_2dedec1a("Codex.Tabs.Tab" .. v22, 13, true)
	v22 = p
	mIndex = nil
	local v54 = "Codex.Tabs.Tab" .. v22
	mMovie:__wf_atom_2dedec1a(v54, 13, false)
	mMovie:__wf_atom_2dedec1a("Codex.ActiveTab", 13, true)
	mMovie:__wf_atom_e57658c2("Codex.ActiveTab", 1, mMovie:__wf_atom_5e6e15c8(v54, 3))
	mMovie:__wf_atom_c90af43a("Codex.ActiveTab.Icon", codexTabActiveIcons[v22])
	mMovie:__wf_atom_2dedec1a("Codex.Content.Watermark", 13, false)
	mMovie:__wf_atom_2dedec1a("Codex.SideBar.AnimalTabs", 13, false)
	mMovie:__wf_atom_4c1c1986("Codex.SideBar.Entries", "ScrollArea", 15, v43)
	mMovie:__wf_atom_e57658c2("Codex.SideBar.Entries", 1, v42)
	v51 = {}
	v52 = {}
	v25 = {}
	local v55 = {}
	local v56 = v22 == v5.Journal
	local v57 = v22 == v5.Codex_Enemies or v22 == v5.Codex_Wildlife

	if v56 then
		InitializeAdventCalendar()
		fn62(v25)
	elseif v57 then
		fn63()
	else
		module9.PopulateFromScans(mMovie, v24, codexTab, v25, v55, debugScrolling)
		table.sort(v25, fn2)
	end

	mMovie:__wf_atom_2dedec1a("Codex.AdventCalendar", 13, v56 and #v25 <= 0)

	for i, v58 in ipairs(codexTabs) do
		fn60(v55[fn18(v58)], "Codex.Tabs.Tab" .. i .. ".Tab.PulseIcon")
	end

	v13 = nil
	local v58 = "/SF/Language/Codex/" .. codexTab:c_str()
	mMovie:__wf_atom_50d60589("Codex.SideBar.EmptyText", 36, Localize(v58 .. "EmptyText", nil))

	if v56 then
		local __wf_atom_10192cfa, v59 = gGameData:__wf_atom_10192cfa(Symbol("CodexTitleChoice"))

		if __wf_atom_10192cfa then
			v58 = v59
		end
	end

	mMovie:__wf_atom_50d60589("Codex.SideBar.Title", 36, Localize(v58, nil))
	mMovie:__wf_atom_2dedec1a("Codex.SideBar.Entries", 13, true)
	mMovie:__wf_atom_2dedec1a("Codex.SideBar.Entries.Scrollable.Completed.Entry", 13, not v57)
	mMovie:__wf_atom_2dedec1a("Codex.SideBar.Entries.Scrollable.Completed.GridEntry", 13, v57)

	if v15 ~= nil then
		v15:RemoveElements(true, true)
	end

	if v57 then
		fn54()
	else
		fn58()
	end

	fn15()

	if v56 then
		fn64()
	end

	fn47()
end

function FocusMapLocation()
	SetActiveTab(v5.Locations)
end

local function fn65(i)
	if i == v5.Journal then
		return true
	end

	if i == v5.Codex_Enemies then
		return module9.HasCodexScan(v6, WeakResource("/SF/Types/Game/SFNpcAvatar"))
	end

	if i == v5.Codex_Wildlife then
		return module9.HasCodexScan(v6, WeakResource("/SF/Types/Game/CreatureBaseAvatar"))
	end

	return module9.HasFragmentScan(v24, codexTabs[i])
end

local function fn66(p)
	local v54 = "Codex.Tabs.Tab" .. p
	local codexTabInactiveIcon = codexTabInactiveIcons[p]
	local codexTabActiveIcon = codexTabActiveIcons[p]
	mMovie:__wf_atom_c90af43a(v54 .. ".Tab.Icon", codexTabInactiveIcon)
	mMovie:__wf_atom_c90af43a(v54 .. ".Tab.Backer", tabInactiveIcon)
	mMovie:__wf_atom_c90af43a(v54 .. ".Tab.PulseIcon", codexTabActiveIcon)
	mMovie:SetCallbacks(v54 .. ".Hitbox", "TabFocused", "TabUnfocused", "TabReleased", "TabPressed")
	mMovie:__wf_atom_4c1c1986(v54, "Hitbox", 100, p)
	mMovie:__wf_atom_4c1c1986(v54, "Tab.PulseIcon", 12, 0)
end

local function fn67()
	fn66(1)
	local v54 = mMovie:__wf_atom_cfc41e35("Codex.Tabs", "Tab1", 1) + 82

	for i = 2, #codexTabActiveIcons do
		if not fn65(i) then
			continue
		end

		__wf_atom_86cbd68d(mMovie, "Codex.Tabs.Tab1.duplicateMovieClip", "Tab" .. i, i)
		mMovie:__wf_atom_4c1c1986("Codex.Tabs", "Tab" .. i, 1, v54)
		fn66(i)
		v54 += 82
	end

	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 100 }, 0.5)
	fn3("Codex.Background")
	fn3("Codex.TabbedBackground")

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	v22 = v5[tostring(_T.FocusCodexTab)] or v22
	_T.FocusCodexTab = nil
	SetActiveTab(v22)

	if _T.FocusCodexMovie then
		_T.FocusCodexMovie = nil
		_T.FocusCodexEntry = nil
	end
end

local function fn68()
	local localPlayerAncestors = module15.GetLocalPlayerAncestors()
	v24 = gGameData:GetInventory():__wf_atom_0dec86a1()

	if v24 == nil then
		v24 = {}
	end

	local codexEntriesOfType = module9.GetCodexEntriesOfType(
		v6,
		"Fragments",
		WeakResource("/SF/Types/Lore/TutorialLore/TutorialBaseLoreFragment")
	)

	for _, v54 in codexEntriesOfType do
		table.insert(v24, { mItemType = v54.type, mItemCount = 1, mRead = true })
	end

	if #v24 == 0 and #localPlayerAncestors == 0 then
		fn67()
		return
	end

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
	end

	local v54 = {}

	for _, v55 in ipairs(v24) do
		if not __wf_atom_7e8ad928(v55.mItemType) then
			table.insert(v54, v55.mItemType:__wf_atom_5b41f63b())
		end
	end

	local __wf_atom_13d5b7e9 = __wf_atom_c67f9605:__wf_atom_13d5b7e9(module11.GetPlayerFaction())

	if __wf_atom_13d5b7e9 ~= nil then
		local __wf_atom_6e1dcf41 = __wf_atom_13d5b7e9:__wf_atom_6e1dcf41()

		if not __wf_atom_7e8ad928(__wf_atom_6e1dcf41) then
			table.insert(v54, __wf_atom_6e1dcf41:__wf_atom_5b41f63b())
		end
	end

	local v55 = {}

	for _, localPlayerAncestor in ipairs(localPlayerAncestors) do
		table.insert(v55, localPlayerAncestor.mType:__wf_atom_5b41f63b())
	end

	v13 = {
		mLoader = UISys.__wf_atom_c0dbe47c(v54),
		mAncestorLoader = UISys.__wf_atom_c0dbe47c(v55),
		mCodexEntries = true
	}
end

local function fn69()
	for k, v54 in codexTabs do
		v5[tostring(v54)] = k
	end

	if #codexTabActiveIcons == 0 then
		mMovie:__wf_atom_2dedec1a("Codex.Tabs", 13, false)
		return
	end

	if #codexTabActiveIcons ~= #codexTabInactiveIcons or #codexTabActiveIcons ~= #codexTabs then
		LogBug(string.format(
			"Location icons not in sync; active: %d, inactive: %d, labels %d",
			#codexTabActiveIcons,
			#codexTabInactiveIcons,
			#codexTabs
		))
		return
	end

	mMovie:__wf_atom_2dedec1a("Codex.Tabs", 13, true)
	mMovie:__wf_atom_c90af43a("Codex.ActiveTab.Backer", tabActiveIcon)
	mMovie:__wf_atom_e57658c2("Codex.ActiveTab.PulseIcon", 12, 0)
	fn68()
end

local function fn70(p)
	local v54 = __wf_atom_421b01aa(p, 0, 1) * 100 + 1
	__wf_atom_86cbd68d(mMovie, "Codex.TitleBar.Progress.gotoAndStop", v54)
end

local function fn71()
	local v54 = {
		Inner = module.ConvertColorNumberToProceduralRGB(2825751),
		Edge = module.ConvertColorNumberToProceduralRGB(1710626)
	}
	mMovie:__wf_atom_7d7314f1("Codex.TitleBar.Title.Text", "/SF/Language/Codex/RecollectionsTitle")
	mMovie:__wf_atom_e57658c2("Codex.TitleBar.Title", 44, 14524216)
	mMovie:__wf_atom_e57658c2("Codex.TitleBar.CountText", 44, 14524216)
	mMovie:OverrideMaterial("Codex.TitleBar.Backer", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041("Codex.TitleBar.Backer", "RectInnerColor", v54.Inner.r, v54.Inner.g, v54.Inner.b, 0.8)
	mMovie:__wf_atom_1ca72041("Codex.TitleBar.Backer", "RectEdgeColor", v54.Edge.r, v54.Edge.g, v54.Edge.b, 0.8)
	mMovie:__wf_atom_c90af43a("Codex.TitleBar.Icon", recollectionsIcon)
	mMovie:__wf_atom_e57658c2("Codex.TitleBar.Icon", 0, 11)
	mMovie:__wf_atom_e57658c2("Codex.TitleBar.Icon", 1, -11)
	fn70(0)
	mMovie:__wf_atom_2dedec1a("Codex.TitleBar", 13, false)
end

function EmptyCallback(_, _) end

function _CommitInventoryCallback(p, _)
	if p and not __wf_atom_7e8ad928(gGameData) then
		gGameData:SyncInventoryFromDB("EmptyCallback")
	end
end

function Shutdown()
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil

	if v34 and not (__wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(gGameData)) then
		gGameRules:CommitInventoryCheckpointToDB(0, 0, 0, "_CommitInventoryCallback")
	end

	if #mScanInfos > 0 and not __wf_atom_7e8ad928(gGameData) then
		gGameData:MarkLoreFragmentsRead(mScanInfos, "EmptyCallback")
	end

	if not __wf_atom_7e8ad928(v35) then
		v35:Stop(false)
	end

	module2.RegisterHideHud(false)

	if not (__wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(gRegion)) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:__wf_atom_799d95f5() then
			__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("NIGHTFOLD_MENU_TIME"), "CODEX_TOTAL")
		end
	end
end

function FocusOnLocation()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if fn4() then
		__wf_atom_2ad5cd23:Execute("SelectTabByMovie", (tostring(worldMapMovie:__wf_atom_5b41f63b())))
		return
	end

	if __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		mMovie:PushChildMovie(worldMapMovie)
		return
	end

	__wf_atom_2ad5cd23:Execute("FocusMapLocation", "")
	fn35(true)
end

local v54 = {}

function InitializeAdventCalendar()
	v54 = module10.GetSuggestedActivities(3)

	if #v54 <= 0 then
		mMovie:__wf_atom_2dedec1a("Codex.AdventCalendar", 13, false)
		return
	end

	mMovie:__wf_atom_e57658c2("Codex.AdventCalendar.EmptyState.Text", 12, 87)
	mMovie:__wf_atom_50d60589(
		"Codex.AdventCalendar.EmptyState.Text",
		36,
		Localize("/SF/Language/Codex/JournalAdventCalendarEmptyText", nil)
	)
	mMovie:__wf_atom_2dedec1a("Codex.AdventCalendar", 13, true)
	mMovie:__wf_atom_e57658c2("Codex.AdventCalendar", 12, 0)
	__wf_atom_ec43d06e(mMovie, "Codex.AdventCalendar", 2, { 12 }, { 100 }, 0.5)

	for i = 1, 3 do
		local v55 = "Codex.AdventCalendar.ActionItem" .. i
		mMovie:__wf_atom_e57658c2(v55 .. ".Icon", 12, 0)
		mMovie:__wf_atom_e57658c2(v55, 12, 50)

		if i <= #v54 then
			local mIconScale = 100
			local mIconColor = 16777215
			local activity = v54[i].Activity

			if activity == nil then
				continue
			end

			if activity.mIconScale ~= nil then
				mIconScale = activity.mIconScale
			end

			if activity.mIconColor ~= nil then
				mIconColor = activity.mIconColor
			end

			mMovie:__wf_atom_c90af43a(v55 .. ".Icon", activity.mIcon)
			mMovie:__wf_atom_e57658c2(v55, 12, 100)
			mMovie:__wf_atom_e57658c2(v55 .. ".Icon", 5, mIconScale)
			mMovie:__wf_atom_e57658c2(v55 .. ".Icon", 6, mIconScale)
			mMovie:__wf_atom_e57658c2(v55 .. ".Icon", 12, 100)
			mMovie:__wf_atom_e57658c2(v55 .. ".Icon", 11, mIconColor)
			mMovie:__wf_atom_e57658c2(v55 .. ".Glow", 12, 0)
			mMovie:SetCallbacks(
				v55 .. ".Btn",
				"CalenderButtonRollOver",
				"CalenderButtonRollOut",
				nil,
				"CalenderButtonClicked"
			)
		end

		mMovie:__wf_atom_e57658c2(v55 .. ".Btn", 100, i)
		mMovie:__wf_atom_2dedec1a(v55 .. ".Selected", 13, false)
	end
end

function CalenderButtonRollOver(p)
	local v55 = "Codex.AdventCalendar.ActionItem" .. p
	local total = 100
	module.PlaySound(locationHoverSound)

	if p == 1 then
		total += 20
	end

	mMovie:__wf_atom_2dedec1a(v55 .. ".Selected", 13, true)
	__wf_atom_ec43d06e(mMovie, v55 .. ".Glow", 2, { 12 }, { 50 }, 0.15)
	__wf_atom_ec43d06e(mMovie, v55 .. ".Selected", 2, { 12 }, { 100 }, 0.15)
	__wf_atom_ec43d06e(mMovie, v55, 2, { 5, 6 }, { total, total }, 0.15)
end

function CalenderButtonRollOut(p)
	local v55 = "Codex.AdventCalendar.ActionItem" .. p
	local total = 90

	if p == 1 then
		total += 20
	end

	__wf_atom_ec43d06e(mMovie, v55 .. ".Selected", 2, { 12 }, { 0 }, 0.15)
	__wf_atom_ec43d06e(mMovie, v55 .. ".Glow", 2, { 12 }, { 0 }, 0.15)
	__wf_atom_ec43d06e(mMovie, v55, 2, { 5, 6 }, { total, total }, 0.15)
end

function CalenderButtonClicked(p)
	_T.FocusMapMarker = v54[p].Activity.mMarker

	if _T.FocusMapMarker ~= nil then
		FocusOnLocation()
	end
end

function Initialize()
	debugScrolling = debugScrolling and false

	if not __wf_atom_7e8ad928(musicLoop) and v35 == nil then
		v35 = module.PlaySound(musicLoop)
	end

	module.PlaySound(openSound)

	if _T.VendorTransmissionSet ~= nil then
		vendorTransmissionSet = _T.VendorTransmissionSet
	end

	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	local __wf_atom_19f75a1e = v6:__wf_atom_19f75a1e()

	for _, v55 in __wf_atom_19f75a1e do
		for _, v56 in v29 do
			if v55.tag:c_str() == v56 then
				table.insert(v28, v55)
			end
		end
	end

	v4 = {
		Grineer = factionIconTextures[1],
		Vadagar = factionIconTextures[2],
		Mendicant = factionIconTextures[3],
		Neutral = factionIconTextures[4],
		Mockeries = factionIconTextures[5],
		GhostKnight = factionIconTextures[6],
		OmenBeast = factionIconTextures[2]
	}
	v10 = module3.Create(mMovie)
	v10:Register(mMovie, "Codex", { v10.ANCHOR_V_TOP, v10.ANCHOR_H_CENTRE })
	v10:Register(mMovie, "AdventCalendar", { v10.ANCHOR_V_BOTTOM, v10.ANCHOR_H_LEFT })
	mMovie:OverrideMaterial("Codex.Background", largePaperPanelMaterial)
	mMovie:OverrideMaterial("Codex.TabbedBackground", smallPaperPanelMaterial)
	mMovie:__wf_atom_e57658c2("Codex.SideBar.Title", 44, 4664607)
	mMovie:__wf_atom_e57658c2("Codex.Content.Title.Label", 44, 4664607)
	mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.Desc", 44, 4664607)
	mMovie:__wf_atom_e57658c2("Codex.SideBar.EmptyText", 44, 4664607)
	mMovie:__wf_atom_e57658c2("Codex.SideBar.EmptyText", 12, 87)
	mMovie:__wf_atom_2dedec1a("Codex.Content.IconVines.QuestDecoSymbol", 13, false)
	mMovie:OverrideMaterial("Codex.Content.IconVines.QuestDecoSymbol.Icon", iconVisRangeMaterial)
	mMovie:__wf_atom_50d60589(
		"Codex.Content.Body.ScrollableRewards.Title",
		36,
		Localize("/SF/Language/Codex/ChooseReward", nil)
	)
	mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableRewards.Title", 44, 4664607)
	mMovie:OverrideMaterial("Codex.Content.Body.ScrollableRewards.Title", visibleRangeTextMaterial)
	mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableRewards.Title", 13, false)
	mMovie:__wf_atom_50d60589(
		"Codex.Content.Body.ScrollableRewards.Desc",
		36,
		Localize("/SF/Language/Codex/WordsOfPowerDesc", nil)
	)
	mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableRewards.Desc", 44, 4664607)
	mMovie:OverrideMaterial("Codex.Content.Body.ScrollableRewards.Desc", visibleRangeTextMaterial)
	mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableRewards.Desc", 13, false)
	mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableBody.GridContainerLeft", 13, false)
	mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableBody.GridContainerRight", 13, false)
	mMovie:__wf_atom_50d60589(
		"Codex.Content.Body.ScrollableBody.GridContainerLeft.Label",
		36,
		Localize("/SF/Language/Codex/Spoils", nil)
	)
	mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.GridContainerLeft.Label", 44, 4664607)
	mMovie:__wf_atom_50d60589(
		"Codex.Content.Body.ScrollableBody.GridContainerRight.Label",
		36,
		Localize("/SF/Language/Codex/GrantedItems", nil)
	)
	mMovie:__wf_atom_e57658c2("Codex.Content.Body.ScrollableBody.GridContainerRight.Label", 44, 4664607)
	mMovie:__wf_atom_2dedec1a("Codex.ActiveTab", 13, false)
	mMovie:__wf_atom_2dedec1a("Codex.Content.Watermark", 13, false)
	mMovie:__wf_atom_2dedec1a("Codex.SideBar.Entries", 13, false)
	mMovie:__wf_atom_2dedec1a("Codex.Content.Body", 13, false)
	mMovie:__wf_atom_2dedec1a("Codex.Content.Body.ScrollableRewards.Rewards", 13, false)
	v43 = mMovie:__wf_atom_cfc41e35("Codex.SideBar.Entries", "ScrollArea", 15)
	v42 = mMovie:__wf_atom_5e6e15c8("Codex.SideBar.Entries", 1)
	InitializeAdventCalendar()
	fn22()
	fn71()
	fn69()
	fn55()
	fn15()
	fn5(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	v47 = math.random(10, 30)
	mMovie:SetCallbacks("Mote", "MoteFocused", "MoteUnfocused", "MoteReleased", "MotePressed")
	module2.RegisterHideHud(true)

	if not (__wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(gRegion)) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:__wf_atom_799d95f5() then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("NIGHTFOLD_MENU_OPEN"), "CODEX")
			__wf_atom_21342f4a:StartTimer(Symbol("NIGHTFOLD_MENU_TIME"), "CODEX_TOTAL")
		end
	end

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground()
	end
end

local function fn72()
	if v13 == nil then
		return true
	end

	if not v13.mLoader:__wf_atom_86399a47() then
		return false
	end

	if v13.mAncestorLoader == nil or v13.mAncestorLoader:__wf_atom_86399a47() then
		return true
	end

	return false
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if __wf_atom_7e8ad928(mMovie:__wf_atom_2ad5cd23()) and not _T.BlockPauseMenu then
		gGameRules:ShowPauseMenu()
	end

	asyncLoader:Update()

	if v13 ~= nil and fn72() then
		if v13.mRewards == nil then
			if v13.mCodexEntries then
				fn67()
			end
		else
			fn28()
		end
	end

	fn10(__wf_atom_fa1258d0())

	if flag2 and not (v38 or __wf_atom_7e8ad928(_T.curTransmission)) then
		fn33()
	end

	if _T.curTransmission and flag3 then
		flag = true
	elseif flag then
		flag = false

		if flag3 then
			PlayTransmission()
		else
			EndTransmission()
		end
	end

	if not (flag2 or v38 or __wf_atom_7e8ad928(v26)) then
		for i = 1, #v26 do
			local v55 = v26[i]

			if not __wf_atom_7e8ad928(v55) then
				v55:SetActive((__wf_atom_7e8ad928(_T.curTransmission)))
			end
		end
	end
end

function PlayerDiscoveryUploadCallback(_, _) end

function SetTrigger(p)
	v11 = p
end

function onViewportSizeChanged(p, p2)
	fn5(p, p2)
end

function TabFocused(p, _)
	local codexTab = codexTabs[p]

	if codexTab then
		_T.gToolTip = "<p><font face=\"Spectral SC\">" .. Localize("/SF/Language/Codex/" .. codexTab:c_str(), nil) .. "</font></p>"
	end

	local v55 = "Codex.Tabs.Tab" .. p
	local v56 = { mMovie:__wf_atom_5e6e15c8("Codex.ActiveTab", 0) - mMovie:__wf_atom_5e6e15c8("Codex.Tabs", 0) }
	__wf_atom_ec43d06e(mMovie, v55, 2, { 0 }, v56, 0.1)
	module.PlaySound(_G.UISound_Focus)
end

function TabUnfocused(p, _)
	_T.gToolTip = nil
	local v55 = "Codex.Tabs.Tab" .. p
	__wf_atom_ec43d06e(mMovie, v55, 2, { 0 }, { 0 }, 0.1)
end

function TabReleased(p, _)
	SetActiveTab(p)
	module.PlaySound(tabSound)
end

function TabPressed(_, _) end

function RewardFocused(p, _)
	local v55 = "Codex.Content.Body.ScrollableRewards.Rewards.Entries.Entry" .. p .. ".Backer"
	__wf_atom_ec43d06e(mMovie, v55 .. ".Icon", 2, { 5, 6 }, { 104, 104 }, 0.1)

	if v33 == p then
		return
	end

	mMovie:OverrideMaterial(v55 .. ".Icon.Frame", _G.UIMaterial_FocusedBorder)
	module.PlaySound(_G.UISound_Focus)
end

function RewardUnfocused(p, _)
	local v55 = "Codex.Content.Body.ScrollableRewards.Rewards.Entries.Entry" .. p .. ".Backer"
	__wf_atom_ec43d06e(mMovie, v55 .. ".Icon", 2, { 5, 6 }, { 100, 100 }, 0.1)

	if v33 == p then
		return
	end

	mMovie:OverrideMaterial(v55 .. ".Icon.Frame", _G.UIMaterial_UnfocusedBorder)
end

function RewardReleased(p, _)
	module.PlaySound(rewardSelectSound)
	fn24(p)
	v12:SetActive(true)
end

function RewardPressed(_, _) end

function ClaimReward()
	fn32()
	module.PlaySound(claimRewardSound)
end

function ConsumeInput() end

function onKeyDown_MENU_MOUSE_Z(_, p)
	fn23(p)
end

function CloseCodex()
	fn35(true)
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		__wf_atom_2ad5cd23:Execute("Close", "")
	end

	_T.InfoPopup_Data = nil
	module.PlaySound(closeSound)
	_T.FocusCodexTab = nil
	return true
end

function OpenedFromPauseMenu()
	v37 = true

	if not (fn72() or __wf_atom_7e8ad928(_T.BackgroundMovie)) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
	end
end

function PrepareToClose(p)
	return fn35(p == "true")
end