local module = require("EE.Interface.Utilities")
require("Lotus.Interface.UIUtilities")
local module2 = require("Lotus.Interface.StoreItemUtilities")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("SF.Interface.ProgressionUtilities")
require("SF.Interface.Libs.OdeCipher")
WeakResource("/SF/Upgrades/SFPactUpgrade")
WeakResource("/SF/Upgrades/SFWeaponUpgrade")
local fn
local v = nil
local v2 = nil
local grids = {}
local v3 = nil
local flag = false
local flag2 = false
local count = 0
local v4 = 0
local v5 = {
	TEXT_DISABLED = 5908767,
	TEXT_FOCUSED = 14524216,
	TEXT_UNFOCUSED = 12363651,
	ICON_BG = 10984574,
	BG = 2825751
}

local function fn2()
	if _T.DebugProgressionScreen then
		return true
	end

	if __wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(gGameData) then
		return false
	end

	local __wf_atom_a8354ad2 = gGameRules:__wf_atom_a8354ad2()
	local pactElement = module4.GetPactElement(mMovie, __wf_atom_a8354ad2, v)
	local weaponElement = module4.GetWeaponElement(mMovie, __wf_atom_a8354ad2, v)
	local secondaryWeaponElement = module4.GetSecondaryWeaponElement(mMovie, __wf_atom_a8354ad2, v)
	local factionElement = module4.GetFactionElement(__wf_atom_a8354ad2, syndicates, gGameData:__wf_atom_0cbd9965())
	local v6

	if not (_T.ProgressionOverrides == nil or _T.ProgressionOverrides.InfamyDelta == nil) then
		v6 = module4.GetInfamyElement(_T.ProgressionOverrides.InfamyDelta, syndicates, infamySyndicate)
	end

	local locationEncountersElement = module4.GetLocationEncountersElement(mMovie, __wf_atom_a8354ad2)
	local loreFragmentElement = module4.GetLoreFragmentElement(mMovie, __wf_atom_a8354ad2)
	local locationDiscoveryElement = module4.GetLocationDiscoveryElement(mMovie, __wf_atom_a8354ad2)
	local dracsElement = module4.GetDracsElement(mMovie, __wf_atom_a8354ad2)
	local itemsElements = module4.GetItemsElements(mMovie, __wf_atom_a8354ad2, v)

	if
		pactElement.Xp > 0
		or weaponElement.Xp > 0
		or secondaryWeaponElement.Xp > 0
		or factionElement ~= nil and factionElement.Xp > 0
	then
		return true
	end

	if v6 ~= nil and v6.Xp ~= 0 or locationEncountersElement.Count > 0 then
		return true
	end

	for i = 1, #loreFragmentElement.LoreFragments do
		if loreFragmentElement.LoreFragments[i].Count > 0 then
			return true
		end
	end

	if
		locationDiscoveryElement.Count > 0
		or dracsElement.Count - dracsElement.PreviousCount > 0
		or #itemsElements > 0
	then
		return true
	end
end

local function fn3(_, _)
	module.ScaleClipVisRangeMaterials(mMovie, "Panel.ListMask", false, {
		visibleRangeMaterial,
		visibleRangeTextMaterial,
		_G.UIMaterial_UnfocusedBorder,
		_G.UIMaterial_FocusedBorder,
		_G.UIMaterial_SelectedBorder
	})
	module.ScaleSlicedMaterials(mMovie, { progressBarBackerMaterial, progressBarFillMaterial })
end

local function fn4(state, p)
	local mClipName = state.mClipName
	state.StartXp = math.max(0, state.StartXp)
	state.EndXp = math.max(0, state.EndXp)
	local animLevel, startLevelXp

	if state.IsFactionXp then
		local _startLevel = state.StartLevel
		animLevel = state.AnimLevel
		startLevelXp = state.StartLevelXp
	else
		animLevel = __wf_atom_c67f9605:__wf_atom_b4a75eaa(state.EndXp, state.Type)
		local __wf_atom_b4a75eaa = __wf_atom_c67f9605:__wf_atom_b4a75eaa(state.StartXp, state.Type)
		state.CurrentLevelXp = __wf_atom_c67f9605:__wf_atom_89d4ac2a(animLevel, state.Type)
		state.StartLevelXp = __wf_atom_c67f9605:__wf_atom_89d4ac2a(__wf_atom_b4a75eaa, state.Type)

		if not state.AnimLevel then
			state.AnimLevel = __wf_atom_b4a75eaa
		end

		startLevelXp = __wf_atom_c67f9605:__wf_atom_89d4ac2a(state.AnimLevel, state.Type)
		local v6 = math.min(state.AnimLevel + 1, __wf_atom_c67f9605:__wf_atom_7da755e9(state.Type, 0))
		state.NextLevelXp = __wf_atom_c67f9605:__wf_atom_89d4ac2a(v6, state.Type)
	end

	local v6 = p or 0.5 * (state.mIndex - 1) + 0.25 + 0.25 + 0.5
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(mClipName, "List.ProgressBarXpGain.Fill", 14)
	local v7 = state.NextLevelXp - startLevelXp
	local v8 = math.max(state.StartXp - startLevelXp, 0)
	local v9 = math.max(v8 / v7, 0)
	local v10 = math.min((math.max(state.EndXp - startLevelXp, 0) - v8) / v7, 1 - v9)
	local v11 = __wf_atom_421b01aa(v10 + v9, 4 / __wf_atom_cfc41e35, (__wf_atom_cfc41e35 - 4) / __wf_atom_cfc41e35) - v9
	local v12 = __wf_atom_421b01aa(v9, 4 / __wf_atom_cfc41e35, (__wf_atom_cfc41e35 - 4) / __wf_atom_cfc41e35)
	mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarXpCurrent.Mask", 14, (math.max(1, v12 * __wf_atom_cfc41e35)))
	mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarXpGain.Mask", 14, 1)
	mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarXpGain.Mask", 0, (math.max(1, v12 * __wf_atom_cfc41e35)))
	local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35(mClipName, "List.ProgressBarXpGain", 0)
	local v13 = mMovie:__wf_atom_cfc41e35(mClipName, "List.ProgressBarXpGain", 5) / 100
	mMovie:__wf_atom_4c1c1986(
		mClipName,
		"List.ProgressBarCap1",
		0,
		__wf_atom_cfc41e35_2 + math.max(1, v12 * __wf_atom_cfc41e35 * v13)
	)
	mMovie:__wf_atom_4c1c1986(
		mClipName,
		"List.ProgressBarCap2",
		0,
		__wf_atom_cfc41e35_2 + math.max(1, v12 * __wf_atom_cfc41e35 * v13)
	)
	__wf_atom_ec43d06e(
		mMovie,
		mClipName .. ".List.ProgressBarXpGain.Mask",
		8,
		{ 14 },
		{ (math.max(1, v11 * __wf_atom_cfc41e35)) },
		1,
		v6
	)
	__wf_atom_ec43d06e(
		mMovie,
		mClipName .. ".List.ProgressBarCap2",
		8,
		{ 0 },
		{ __wf_atom_cfc41e35_2 + math.max(1, v12 * __wf_atom_cfc41e35 * v13) + math.max(1, v11 * __wf_atom_cfc41e35 * v13) },
		1,
		v6
	)

	if state.AnimLevel ~= animLevel then
		v3:AddTimer(v6 + 1, function()
			state.AnimLevel += 1
			fn4(state, 0)
		end)
	end
end

local function fn5(data)
	local mClipName = data.mClipName
	local v6 = mClipName .. ".List.ItemElement1"
	mMovie:__wf_atom_7f57ab2f(mClipName, "List.ItemElement1", 13, true)
	mMovie:__wf_atom_7f57ab2f(mClipName, "List.GridElement1", 13, false)
	mMovie:__wf_atom_48bd5a59(mClipName, "Title.Text", 36, data.Name)
	mMovie:__wf_atom_4c1c1986(mClipName, "Title.Text", 11, v5.TEXT_UNFOCUSED)
	local v7 = mMovie:__wf_atom_cfc41e35(mClipName, "Title.Text", 0) + mMovie:__wf_atom_cfc41e35(mClipName, "Title.Text", 40)
	mMovie:__wf_atom_4c1c1986(mClipName, "Title.Leaf", 0, v7)
	mMovie:OverrideMaterial(mClipName .. ".Title.Leaf", visibleRangeMaterial)
	mMovie:OverrideMaterial(mClipName .. ".Title.Text", visibleRangeTextMaterial)
	local showXp = data.ShowXp
	local v8 = showXp and 100 or 0
	mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarXpCurrent", 12, v8)
	mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarXpGain", 12, v8)
	mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarBacker", 12, v8)
	mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarCap1", 12, v8)
	mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarCap2", 12, v8)
	local v9 = data.StoreItem ~= nil and not data.IsLoot or data.IsFactionXp == true
	mMovie:__wf_atom_7f57ab2f(v6, "Status", 13, v9)
	mMovie:__wf_atom_7f57ab2f(v6, "Subheading", 13, true)
	mMovie:__wf_atom_4c1c1986(v6, "Name", 1, showXp and -41 or -25)
	mMovie:__wf_atom_4c1c1986(v6, "Status", 1, showXp and -41 or -25)
	mMovie:__wf_atom_4c1c1986(v6, "Status", 0, 172)
	mMovie:__wf_atom_4c1c1986(v6, "Subheading", 1, showXp and 5 or -3)
	mMovie:__wf_atom_48bd5a59(v6, "Subheading", 45, showXp and "right" or "left")
	mMovie:__wf_atom_4c1c1986(v6, "Subheading", 14, 456)
	module4.OnItemElementClipCreated(mMovie, data, gridItemTextures, visibleRangeMaterial, visibleRangeTextMaterial)

	if data.StoreItem == nil then
		if data.IsDiscovery or data.IsDracs then
			if data.IsDracs then
				local count2 = tonumber(data.Count) or 0
				local previousCount = tonumber(data.PreviousCount) or 0
				local formatNumber = module.FormatNumber(count2 - previousCount)
				local v10 = "(" .. count2 .. ")"
				local v11 = formatNumber .. " " .. (count2 == 1 and "" or v10)
				mMovie:__wf_atom_50d60589(mClipName .. ".List.ItemElement1.Subheading", 36, v11)
				mMovie:__wf_atom_e57658c2(mClipName .. ".List.ItemElement1.Subheading", 44, _G.UIColor_Tan)
			end
		elseif data.IsFactionXp then
			mMovie:__wf_atom_48bd5a59(v6, "Name", 36, mMovie:__wf_atom_8e9ac384(data.Name, false))

			if showXp then
				local v10 = math.max(data.StartXp - data.StartLevelXp, 0)
				local v11 = math.max(data.EndXp - data.StartLevelXp, 0)
				local v12

				if data.NextLevelXp == nil then
					v12 = v11
				else
					v12 = data.NextLevelXp - data.StartLevelXp
				end

				mMovie:__wf_atom_48bd5a59(v6, "Status", 36, module4.GetXpIncrease(mMovie, v10, v11, "<REPUTATION>"))
				module4.AnimateTextIncrease(
					mMovie,
					mClipName,
					v6 .. ".Subheading",
					"/SF/Language/Items/AmountRequired",
					v10,
					v11,
					v12,
					0.5 * (data.mIndex - 1) + 0.25 + 0.25 + 0.5,
					numberTickSound
				)
			else
				mMovie:__wf_atom_48bd5a59(
					v6,
					"Subheading",
					36,
					mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/MaxLevel", false)
				)
			end

			mMovie:__wf_atom_c90af43a(v6 .. ".Item.Icon", data.Icon)
			mMovie:__wf_atom_7f57ab2f(v6, "Item.Icon", 13, true)
			mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarXpCurrent.Fill", 11, _G.UIColor_BlueGreen)
			mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarXpGain.Fill", 11, _G.UIColor_Yellow)

			if showXp then
				fn4(data)
			end
		end
	else
		mMovie:__wf_atom_48bd5a59(v6, "Name", 36, data.Name)

		if showXp then
			local v10 = data.StartXp - data.StartLevelXp
			local v11 = data.EndXp - data.StartLevelXp
			local v12

			if data.NextLevelXp == nil then
				v12 = v11
			else
				v12 = data.NextLevelXp - data.StartLevelXp
			end

			mMovie:__wf_atom_48bd5a59(v6, "Status", 36, module4.GetXpIncrease(mMovie, v10, v11))
			module4.AnimateTextIncrease(
				mMovie,
				mClipName,
				v6 .. ".Subheading",
				"/SF/Language/Items/AmountRequired",
				v10,
				v11,
				v12,
				0.5 * (data.mIndex - 1) + 0.25 + 0.25 + 0.5,
				numberTickSound
			)
		else
			mMovie:__wf_atom_48bd5a59(
				v6,
				"Subheading",
				36,
				mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/MaxLevel", false)
			)
		end

		local count2 = tonumber(data.Count) or 0
		local startCount = tonumber(data.StartCount) or 0
		local formatNumber = module.FormatNumber(count2 - startCount)
		local v10 = "(" .. count2 .. ")"
		local v11 = formatNumber .. " " .. (count2 == 1 and "" or v10)
		mMovie:__wf_atom_50d60589(mClipName .. ".List.ItemElement1.Subheading", 36, v11)
		mMovie:__wf_atom_e57658c2(mClipName .. ".List.ItemElement1.Subheading", 44, _G.UIColor_Tan)
		local _ = data.StartCount == nil
		mMovie:__wf_atom_c90af43a(v6 .. ".Item.Icon", data.Icon)
		mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarXpCurrent.Fill", 11, _G.UIColor_BlueGreen)
		mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarXpGain.Fill", 11, _G.UIColor_Yellow)

		if showXp then
			fn4(data)
		end
	end

	mMovie:__wf_atom_4c1c1986(v6, "BgEndLeft", 12, 0)
	mMovie:__wf_atom_4c1c1986(v6, "BgEndRight", 12, 0)
	mMovie:__wf_atom_4c1c1986(v6, "BgFill", 12, 0)
end

local function fn6(state)
	local mClipName = state.mClipName
	mMovie:__wf_atom_7f57ab2f(mClipName, "List.ItemElement1", 13, false)
	mMovie:__wf_atom_7f57ab2f(mClipName, "List.GridElement1", 13, true)

	if not state.InitializedGrid then
		state.InitializedGrid = true
		mMovie:__wf_atom_e57658c2(mClipName, 100, #grids + 1)
		mMovie:__wf_atom_48bd5a59(mClipName, "Title.Text", 36, mMovie:__wf_atom_8e9ac384(state.Name, false))
		mMovie:__wf_atom_4c1c1986(mClipName, "Title.Text", 11, v5.TEXT_UNFOCUSED)
		local v6 = mMovie:__wf_atom_cfc41e35(mClipName, "Title.Text", 0) + mMovie:__wf_atom_cfc41e35(mClipName, "Title.Text", 40)
		mMovie:__wf_atom_4c1c1986(mClipName, "Title.Leaf", 0, v6)
		mMovie:OverrideMaterial(mClipName .. ".Title.Leaf", visibleRangeMaterial)
		mMovie:OverrideMaterial(mClipName .. ".Title.Text", visibleRangeTextMaterial)
		mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarXpCurrent", 12, 0)
		mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarXpGain", 12, 0)
		mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarBacker", 12, 0)
		mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarCap1", 12, 0)
		mMovie:__wf_atom_4c1c1986(mClipName, "List.ProgressBarCap2", 12, 0)
		local v7 = state.mClipName .. ".List.GridElement1"
		local module5 = require("EE.Interface.Components.Grid")
		local items = state.Items
		local v8 = math.ceil(#items / 5)
		local grid = module5.CreateGrid(mMovie, v7, nil, 5, v8)
		state.mGrid = grid
		table.insert(grids, grid)

		function grid.mClipCreatedCallback(p)
			mMovie:__wf_atom_7f57ab2f(p, "IconFlare", 13, false)
			mMovie:OverrideMaterial(
				p .. ".IconOutline",
				module.Ternary(false, _G.UIMaterial_FocusedBorder, _G.UIMaterial_UnfocusedBorder)
			)
			mMovie:OverrideMaterial(p .. ".Icon", visibleRangeMaterial)
			mMovie:OverrideMaterial(p .. ".IconFlare", visibleRangeMaterial)
			mMovie:OverrideMaterial(p .. ".IconBg", visibleRangeMaterial)
		end

		function grid.mElementDrawCallback(p)
			local mClipName2 = p.mClipName
			mMovie:__wf_atom_7f57ab2f(mClipName2, "RecipeIcon", 13, false)
			mMovie:__wf_atom_7f57ab2f(mClipName2, "StatusIconMini", 13, false)
			mMovie:__wf_atom_c90af43a(mClipName2 .. ".Icon", p.Icon)
			mMovie:__wf_atom_c90af43a(mClipName2 .. ".IconFlare", gridItemTextures[3])
			mMovie:__wf_atom_c90af43a(mClipName2 .. ".IconBg", gridItemTextures[4])
		end

		for i = 1, #items do
			local item = items[i]
			local v9 = fn(item.mItemType)

			if __wf_atom_7e8ad928(v9) or not v9:__wf_atom_1f093091() then
				continue
			end

			grid:AddElement(module2.GetStoreItemInfo(mMovie, v9, { ItemInfo = item }, nil, nil, true), true)
		end
	end

	state.mGrid:Redraw(nil, true, true)
end

local function fn7(p)
	if p.IsGrid then
		fn6(p)
	else
		fn5(p)
	end
end

local function fn8()
	local module5 = require("EE.Interface.Components.List")
	v2 = module5.CreateNewList(getfenv(1), "Panel.ListWrapper.ListEntry1")

	function v2.mClipCreatedCallback(mClipName, p)
		module4.OnItemElementClipCreated(
			mMovie,
			p or { mClipName = mClipName },
			gridItemTextures,
			visibleRangeMaterial,
			visibleRangeTextMaterial
		)
		mMovie:__wf_atom_4c1c1986(mClipName, "List.ItemShadow", 12, 70)
		mMovie:__wf_atom_4c1c1986(mClipName, "List.Glow", 12, 0)
		mMovie:__wf_atom_4c1c1986(mClipName, "List.Burst", 12, 0)
		mMovie:OverrideMaterial(mClipName .. ".List.ProgressBarXpCurrent.Fill", progressBarFillMaterial)
		mMovie:OverrideMaterial(mClipName .. ".List.ProgressBarXpGain.Fill", progressBarFillMaterial)
		mMovie:OverrideMaterial(mClipName .. ".List.ProgressBarBacker", progressBarBackerMaterial)
		mMovie:__wf_atom_e57658c2(mClipName, 12, 0)
		mMovie:__wf_atom_7f57ab2f(mClipName, "List.ItemElement1.Glow", 13, false)
	end

	function v2.mElementDrawCallback(p)
		fn7(p)
	end

	v2.CalculateYBase = v2.CalculateY

	function v2:CalculateY(p)
		local total = 0

		for i = 1, p.mIndex - 1 do
			local elementById = v2:GetElementById(i)

			if elementById ~= nil then
				total += 90
			end

			if elementById ~= nil and elementById.mGrid ~= nil then
				total += (elementById.mGrid.mRows - 1) * 96
			end
		end

		return self.mInitialY + total + 20
	end

	v2:Redraw(nil, true, true)
end

local function fn9()
	if __wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(gGameData) then
		mMovie:Close()
		return
	end

	count += 1
	local v6 = count

	if v4 + 3 < v6 then
		AdvanceAndShutdown()
		return
	end

	local __wf_atom_a8354ad2 = gGameRules:__wf_atom_a8354ad2()
	local v7 = _T.DebugProgressionScreen and {
		mDiscoveredLocations = 10,
		mRegularCreditsPrevious = 1,
		mRegularCredits = 3,
		mFactionXpPrevious = 5500,
		mFactionXp = 8000,
		mItemInfo = {
			{
				mItemCount = 1,
				mItemType = Resource("/SF/Types/Items/Kintsugi/Weapons/KintsugiUpgradeDefenseC")
			},
			{
				mItemCount = 15,
				mItemType = Resource("/SF/Types/Items/Kintsugi/Weapons/KintsugiWeaponUpgradeCasterC")
			},
			{
				mItemCount = 15,
				mItemType = Resource("/SF/Weapons/Melee/OneHand/FeySword/FeySwordMeleeWeapon")
			}
		}
	} or __wf_atom_a8354ad2
	local pactElement = module4.GetPactElement(mMovie, v7, v)
	local weaponElement = module4.GetWeaponElement(mMovie, v7, v)
	local secondaryWeaponElement = module4.GetSecondaryWeaponElement(mMovie, v7, v)
	local factionElement = module4.GetFactionElement(v7, syndicates, gGameData:__wf_atom_0cbd9965())
	local v8

	if not (_T.ProgressionOverrides == nil or _T.ProgressionOverrides.InfamyDelta == nil) then
		v8 = module4.GetInfamyElement(_T.ProgressionOverrides.InfamyDelta, syndicates, infamySyndicate)
	end

	local locationEncountersElement = module4.GetLocationEncountersElement(mMovie, v7)
	local loreFragmentElement = module4.GetLoreFragmentElement(mMovie, v7)
	local locationDiscoveryElement = module4.GetLocationDiscoveryElement(mMovie, v7)
	local dracsElement = module4.GetDracsElement(mMovie, v7)
	local itemsElements = module4.GetItemsElements(mMovie, v7, v)
	v4 = math.ceil((#itemsElements + 1) / 6) - 1

	local function fn10()
		__wf_atom_ec43d06e(
			mMovie,
			module.Ternary(count < v4 + 3, "Panel.ListWrapper", "_root"),
			8,
			{ 12 },
			{ 0 },
			0.5,
			6,
			function()
				v2:RunForAllVisibleElements(function(p)
					mMovie:__wf_atom_4c1c1986(p.mClipName, "List.Glow", 12, 0)
					mMovie:__wf_atom_4c1c1986(p.mClipName, "List.Burst", 12, 0)
				end)
				v2:RemoveElements()
				fn9()
			end
		)
	end

	if count == 1 then
		if
			pactElement.Xp <= 0
			and weaponElement.Xp <= 0
			and secondaryWeaponElement.Xp <= 0
			and (factionElement == nil or factionElement.Xp <= 0)
			and (v8 == nil or v8.Xp <= 0)
		then
			fn9()
			return
		end

		if factionElement ~= nil and factionElement.Xp ~= nil and factionElement.Xp > 0 then
			v2:AddElement(factionElement, true)
			_T.FactionTaleXpHack = 0
		end

		if pactElement.Xp > 0 then
			v2:AddElement(pactElement, true)
		end

		if weaponElement.Xp > 0 then
			v2:AddElement(weaponElement, true)
		end

		if secondaryWeaponElement.Xp > 0 then
			v2:AddElement(secondaryWeaponElement, true)
		end

		if v8 ~= nil and v8.Xp ~= nil and v8.Xp > 0 then
			v2:AddElement(v8, true)
		end
	elseif count == 2 then
		local v9

		if locationEncountersElement.Count > 0 then
			v2:AddElement(locationEncountersElement, true)
			v9 = true
		else
			v9 = false
		end

		for i = 1, #loreFragmentElement.LoreFragments do
			local loreFragment = loreFragmentElement.LoreFragments[i]

			if not (loreFragment.Count > 0) then
				continue
			end

			v2:AddElement(loreFragment, true)
			v9 = true
		end

		if locationDiscoveryElement.Count ~= nil and locationDiscoveryElement.Count > 0 then
			v2:AddElement(locationDiscoveryElement, true)
			v9 = true
		end

		if not v9 then
			fn9()
			return
		end
	elseif count >= 3 then
		local v9

		if count == 3 and dracsElement.Count ~= nil and dracsElement.Count - dracsElement.PreviousCount > 0 then
			v2:AddElement(dracsElement, true)
			v9 = true
		else
			v9 = false
		end

		local v10 = #v2.mElements
		local v11 = math.max(1, (count - 3) * 6 + v10)
		local v12 = (count - 3 + 1) * 6 - 1
		local v13 = #itemsElements < v12 and #itemsElements or v12

		if #itemsElements > 0 then
			for i = v11, v13 do
				v2:AddElement(itemsElements[i], true)
				v9 = true
			end
		end

		if not v9 then
			fn9()
			return
		end
	end

	v2:Redraw(nil, true, true)
	__wf_atom_ec43d06e(
		mMovie,
		"Panel.ListWrapper",
		8,
		{ 12 },
		{ 100 },
		module.Ternary(count == 1, 0.75, 1),
		0,
		function()
			fn10()
		end
	)
	v2:RunForAllVisibleElements(function(data)
		mMovie:__wf_atom_e57658c2(data.mClipName, 12, 0)
		local v9 = (data.mIndex - 1) * 0.5 + 0.25
		v3:AddTimer(v9 + 0.75, function()
			if not data.IsGrid then
				module.CreateUIParticles(mMovie, data.mClipName .. ".List.Burst", burstParticleSys, 0, 0)
			end
		end)
		v3:AddTimer(v9 + 0, function()
			module.PlaySound(sectionFadeInSound)

			if not data.IsGrid then
				module.PlaySound(burstParticleSound)
			end
		end)
		__wf_atom_ec43d06e(mMovie, data.mClipName, 8, { 12, 1 }, { 100, v2:CalculateY(data) - 20 }, 1, v9)
	end)
end

local function fn10()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_c4f78a8f:__wf_atom_799d95f5() then
		mMovie:__wf_atom_2dedec1a("Panel.TimeOfDay", 13, false)
		return
	end

	if not __wf_atom_c4f78a8f:__wf_atom_799d95f5() then
		module.PlaySound(openSound)
	end

	local isDaytime = module3.IsDaytime()
	mMovie:__wf_atom_e57658c2("Panel.TimeOfDay.TimeWheel", 16, isDaytime and -180 or 0)
	__wf_atom_ec43d06e(mMovie, "Panel.TimeOfDay.TimeWheel", 1, { 16 }, { isDaytime and 0 or -180 }, 0.75, 1)

	if isDaytime then
		mMovie:__wf_atom_50d60589(
			"Panel.TimeOfDay.TimeText",
			36,
			mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/DawnDesc_" .. tostring(math.random(1, 2)), true)
		)
		mMovie:__wf_atom_e57658c2("Panel.TimeOfDay.SunBacker.GlowBg", 11, _G.UIColor_Blue)
		mMovie:__wf_atom_e57658c2("Panel.TimeOfDay.SunBacker.Glow", 11, _G.UIColor_Yellow)
	else
		mMovie:__wf_atom_50d60589(
			"Panel.TimeOfDay.TimeText",
			36,
			mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/DuskDesc_" .. tostring(math.random(1, 1)), true)
		)
		mMovie:__wf_atom_e57658c2("Panel.TimeOfDay.SunBacker.GlowBg", 11, _G.UIColor_Yellow)
		mMovie:__wf_atom_e57658c2("Panel.TimeOfDay.SunBacker.Glow", 11, _G.UIColor_Blue)
	end

	mMovie:__wf_atom_e57658c2("Panel.TimeOfDay.SunBacker.Glow", 12, 0)
	__wf_atom_ec43d06e(mMovie, "Panel.TimeOfDay.SunBacker.GlowBg", 1, { 12 }, { 0 }, 0.75, 1)
	__wf_atom_ec43d06e(mMovie, "Panel.TimeOfDay.SunBacker.Glow", 1, { 12 }, { 100 }, 0.75, 1)
end

function Initialize()
	v = Resource("/Lotus/Types/Game/Store/ProductsManifest")

	if not fn2() then
		mMovie:Close()
		return
	end

	local module5 = require("Lotus.Interface.Libs.TimerMgr")
	v3 = module5.CreateTimerMgr()
	v5.TEXT_FOCUSED_HEX = module.ConvertColorNumberToHex(v5.TEXT_FOCUSED)
	v5.TEXT_UNFOCUSED_HEX = module.ConvertColorNumberToHex(v5.TEXT_UNFOCUSED)
	fn8()
	mMovie:__wf_atom_c90af43a("Panel.BgFill", panelBackerTextures[1])
	mMovie:__wf_atom_e57658c2("Panel.BgFill", 12, 0)
	mMovie:__wf_atom_c90af43a("Panel.BgEnd", panelBackerTextures[2])
	mMovie:__wf_atom_c90af43a("Panel.BgStart", panelBackerTextures[2])
	mMovie:__wf_atom_e57658c2("Panel", 5, 85)
	mMovie:__wf_atom_e57658c2("Panel", 6, 85)
	mMovie:__wf_atom_7df746cd(v5.BG)
	local module6 = require("SF.Interface.Components.Button")
	module6.Create(
		mMovie,
		"CloseBtn",
		mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/Generic_CloseBtn", false),
		"AdvanceAndShutdown"
	):SetVariant(module6.VARIANTS.SPECIAL_BUTTON)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("Panel.ListWrapper", 12, 0)
	v3:AddTimer(1.5, function()
		fn9()
	end)
	mMovie:__wf_atom_2dedec1a("Panel.CustomBanner", 13, _T.ProgressionOverrides ~= nil)

	if _T.ProgressionOverrides == nil then
		fn10()
	else
		local locArgs = _T.ProgressionOverrides.LocArgs or {}

		for k, locArg in pairs(locArgs) do
			locArgs[k] = mMovie:__wf_atom_8e9ac384(locArg, false)
		end

		mMovie:__wf_atom_2dedec1a("Panel.TimeOfDay", 13, false)
		mMovie:__wf_atom_50d60589(
			"Panel.CustomBanner.Label",
			36,
			mMovie:__wf_atom_8e9ac384(_T.ProgressionOverrides.Label, false, locArgs)
		)

		if _T.ProgressionOverrides.Encounter then
			module.PlaySound(encounterCompleteSound)
		end

		if _T.ProgressionOverrides.Icon then
			mMovie:__wf_atom_c90af43a("Panel.CustomBanner.Icon", _T.ProgressionOverrides.Icon)
		end
	end

	if not flag2 then
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 1, 0)
	end

	fn3(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	flag = true
end

function onViewportSizeChanged(p, p2)
	fn3(p, p2)
end

function Update()
	local v6 = __wf_atom_fa1258d0()
	local v7 = __wf_atom_084b3e93()

	if not __wf_atom_7e8ad928(v3) then
		v3:Update(v7)
	end

	mMovie:__wf_atom_88d9cd84(v6)
end

function Shutdown() end

fn = function(mItemType)
	if __wf_atom_7e8ad928(mItemType) or __wf_atom_7e8ad928(v) then
		return nil
	end

	return v:__wf_atom_232fd31d(mItemType)
end

function AdvanceAndShutdown()
	if flag2 then
		return
	end

	flag2 = true

	if flag then
		module.PlaySound(closeSound)
	end

	mMovie:__wf_atom_0c1c47f2(nil)
	_T.InfoPopup_Data = nil
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.5, 0, function()
		_T.InfoPopup_Data = nil
		mMovie:Close()
	end)
end

function onKeyDown_MENU_CANCEL(_, _)
	AdvanceAndShutdown()
	return true
end

function OpenFileFlashMovie()
	_T.DebugProgressionScreen = true
end