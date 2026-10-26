local module = require("Lotus.Interface.StoreItemUtilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")
local module3 = require("Lotus.Interface.UIUtilities")
local v = nil
local flag = false
local v2 = nil

local function fn()
	if not __wf_atom_7e8ad928(v) then
		v:ClearTimers()
	end

	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.5, 0, function()
		flag = true
	end)
end

local function fn2()
	local module4 = require("Lotus.Interface.Components.CategorizedGrid")
	v2 = module4.CreateCategorizedGrid(mMovie, "RewardContainer.RewardItem", 1, 1)
	v2.mSelectedScale = 100
	v2.ElementWidth = 96
	v2.ElementHeight = 96
	v2.mShowLabels = false
	v2.mInnerAlpha = 100
	v2.mEdgeAlpha = 70

	function v2.mOnFocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		module3.OnGridItemFocusChanged(mMovie, v2, p, {
			IsFocused = true,
			ShowInfoPopup = false,
			IgnoreCount = true
		})
	end

	function v2.mOnUnfocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		module3.OnGridItemFocusChanged(mMovie, v2, p, { IsFocused = false, IgnoreCount = true })
	end

	function v2.mClipCreatedCallback(p, _)
		module3.OnGridItemCreated(mMovie, v2, p)
	end

	function v2.mElementDrawCallback(data)
		if data.mClipName == nil or __wf_atom_7e8ad928(gGameData) then
			return
		end

		local isFocused = data == v2:GetFocusedElement()
		local v3 = {
			HideOwned = true,
			IsFiller = data.Filler or data.EmptySlot,
			IsFocused = isFocused,
			NameOverride = data.Name,
			IgnoreCount = true
		}
		module3.DrawGridItem(mMovie, v2, data, v3)
		mMovie:__wf_atom_50d60589("RewardContainer.Name", 36, TitleCase(data.Name))
	end
end

local function fn3()
	mMovie:__wf_atom_2dedec1a("RewardContainer", 13, false)
	mMovie:__wf_atom_2dedec1a("RewardArrowLeft1", 13, false)
	mMovie:__wf_atom_2dedec1a("RewardArrowLeft2", 13, false)
	mMovie:__wf_atom_2dedec1a("RewardArrowRight1", 13, false)
	mMovie:__wf_atom_2dedec1a("RewardArrowRight2", 13, false)
end

function Initialize()
	local module4 = require("Lotus.Interface.Libs.TimerMgr")
	v = module4.CreateTimerMgr()
	fn2()
	local color = module2.GetColor(9, true)
	mMovie:__wf_atom_e57658c2("RewardContainer.Name", 44, color)
	local flag2 = false

	if _T.ScenarioInitiator then
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

		for i = 1, #__wf_atom_3c8e1a7a do
			if __wf_atom_3c8e1a7a[i]:__wf_atom_6be84646() ~= _T.ScenarioInitiator then
				continue
			end

			flag2 = true
			break
		end
	end

	if flag2 then
		fn3()
	else
		local v3 = Resource("/Lotus/StoreItems/Types/Items/MiscItems/AlloyPlate")
		local storeItemInfo = module.GetStoreItemInfo(mMovie, v3, nil, nil, nil, true)
		v2:AddElement(storeItemInfo)
		v2:Redraw(nil, true, true)
	end

	v:AddTimer(5, fn)
	mMovie:__wf_atom_7d7314f1("MissionName.Label.text", "/Lotus/Language/SquadLink/SquadLink")
	mMovie:__wf_atom_7d7314f1("Success.Label.text", "/Lotus/Language/SquadLink/Success")
	mMovie:__wf_atom_7d7314f1("Description.Label.text", "/Lotus/Language/SquadLink/SuccessDesc")
end

function Update()
	local v3 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v3)

	if not __wf_atom_7e8ad928(v) then
		v:Update(v3)
	end

	if flag then
		mMovie:Close()
	end
end

function SetFailed(p)
	if p == "true" then
		fn3()
		mMovie:__wf_atom_7d7314f1("Success.Label.text", "/Lotus/Language/SquadLink/Failed")
		mMovie:__wf_atom_50d60589("Description.Label", 36, "")
	end
end