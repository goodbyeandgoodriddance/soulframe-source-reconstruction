module(..., package.seeall)
local module = require("Lotus.Interface.UIStyleUtilities")
local module2 = require("Lotus.Interface.UIUtilities")
local module3 = require("EE.Interface.Utilities")
glowTexture = Resource("/Lotus/Interface/Graphics/Arcanes/ArcaneGlow.png")
sparklesMaterial = Resource("/Lotus/Interface/Materials/ThemedAbilitySpots")
visRangeMaterial = Resource("/Lotus/Interface/Materials/WarframeSelectVisibleRange")
shadowMaterial = Resource("/Lotus/Interface/Materials/AbilitiesIconShadow")
passiveIcon = Resource("/Lotus/Interface/Icons/Abilities/PassiveAbilityIcon.png")

local function fn(object, p, p2, suit, p3, moddedStats, baseOnly, object2, hideRankUp, forceOverrideDesc)
	local v = nil
	local abilityIndex = p - 1
	local v2

	if __wf_atom_1ef90898(suit) then
		v2 = Resource(suit)
	else
		v2 = suit
	end

	if p2 and not v2:__wf_atom_84b99eb9(abilityIndex) then
		return v
	end

	if __wf_atom_7e8ad928(object2) then
		if p3 then
			object2 = v2:__wf_atom_c497b0ae(abilityIndex)
		else
			object2 = v2:__wf_atom_e68785c4(abilityIndex)
		end
	end

	if __wf_atom_7e8ad928(object2) then
		return v
	end

	local __wf_atom_22941262 = v2:__wf_atom_22941262()
	local __wf_atom_87c63382 = v2:__wf_atom_87c63382(abilityIndex)
	local localizedDesc

	if forceOverrideDesc and object2:__wf_atom_64741537() ~= EMPTY_SYMBOL then
		localizedDesc = object:__wf_atom_8e9ac384(object2:__wf_atom_64741537():c_str(), true)
	else
		localizedDesc = object:__wf_atom_8e9ac384(object2:__wf_atom_3a3d2e39():c_str(), true)
	end

	return {
		IsAbility = true,
		CustomEntry = true,
		ForceOverrideDesc = forceOverrideDesc,
		Suit = suit,
		AbilityIndex = abilityIndex,
		Resource = object2,
		Name = string.upper(object:__wf_atom_8e9ac384(object2:__wf_atom_014a76a2():c_str(), false)),
		LocalizedDesc = localizedDesc,
		Level = v2:__wf_atom_cc3c265a(abilityIndex) - 1,
		Locked = __wf_atom_22941262 < __wf_atom_87c63382,
		Icon = object2:GetIconTexture(),
		IconColor = module3.Ternary(object2:__wf_atom_7941efb7(), 6, nil),
		Themed = not object2:__wf_atom_c9969a68(),
		ModdedStats = moddedStats,
		BaseOnly = baseOnly,
		HideRankUp = hideRankUp
	}
end

function GetElementForAbility(p, p2, p3, suit, p4, moddedStats, baseOnly, p5, hideRankUp, forceOverrideDesc)
	return (fn(p, p2, p3, suit, p4, moddedStats, baseOnly, p5, hideRankUp, forceOverrideDesc))
end

function Create(object, mParentClipName)
	local module4 = require("EE.Interface.Components.List")
	local list = module4.CreateList(object, mParentClipName .. ".Ability")
	list:SetCallbacks("AbilityPressed", "AbilityFocused", "AbilityUnfocused")
	list.mParentClipName = mParentClipName
	list.mVisibleElements = 4
	list.mForcedVerticalSeparation = 0
	list.mForcedHorizontalSeparation = 200
	list.mInitIconYPos = -45
	list.mIconFocusOffset = 15
	list.mIconHeight = 200
	list.mGlowWidth = 600
	list.mVisFadeSize = 0
	list.mIconDim = 110
	list.mUnderlineWidthOffset = 0
	list.mShowTitle = true
	list.mShowRank = true
	list.mSimplePopup = false
	list.mShowRankUp = true
	list.mInitRankYPos = object:__wf_atom_5e6e15c8(mParentClipName .. ".Ability.Rank", 1)
	list.mSparkleMaterial = sparklesMaterial
	list.mIconLoader = { Loader = nil, IsLoading = false, StuffToLoad = {} }

	function list.UpdateVisRanges(data)
		local v = { visRangeMaterial, shadowMaterial }
		local __wf_atom_5e6e15c8 = data.mMovie:__wf_atom_5e6e15c8(data.mParentClipName, 3)
		local visibilityCenter = module3.GetVisibilityCenter(data.mMovie, __wf_atom_5e6e15c8 - data.mIconHeight / 2)
		local visibilitySize = module3.GetVisibilitySize(data.mMovie, data.mIconHeight)

		for _, v2 in ipairs(v) do
			v2:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
			v2:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize - data.mVisFadeSize * 2)
			v2:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, data.mVisFadeSize)
		end
	end

	function list:Populate(p, p2, p3, p4, p5, list2, p6)
		self:RemoveElements(true, true)
		local v

		if __wf_atom_1ef90898(p) then
			v = Resource(p)
		else
			v = p
		end

		if self.mShowPassive then
			_T.PassiveInfo = nil
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f:__wf_atom_51009507(v:__wf_atom_4a011391(), Symbol("GetPassiveInfo"), false)
			end

			self:AddElement({
				IsPassive = true,
				CustomEntry = true,
				Name = string.upper(self.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Ability_Passive", false)),
				LocalizedDesc = self.mMovie:__wf_atom_8e9ac384(v:__wf_atom_3e0a2478():c_str(), true, _T.PassiveInfo),
				Icon = passiveIcon
			}, true)
		end

		local stuffToLoad = {}

		for i = 1, 4 do
			local v2 = fn(self.mMovie, i, p2, p, p3, p4, p5, nil, not self.mShowRankUp)

			if v2 == nil then
				continue
			end

			if not __wf_atom_7e8ad928(v2.Icon) then
				table.insert(stuffToLoad, v2.Icon:__wf_atom_5b41f63b())
			end

			if self.mSimplePopup then
				v2.IsAbility = false
			end

			self:AddElement(v2, true)
		end

		if list2 ~= nil then
			for i = 1, #list2 do
				local v2 = fn(self.mMovie, 1, p2, p, p3, p4, p5, Resource(list2[i]), not self.mShowRankUp)

				if v2 == nil then
					continue
				end

				if not __wf_atom_7e8ad928(v2.Icon) then
					table.insert(stuffToLoad, v2.Icon:__wf_atom_5b41f63b())
				end

				if self.mSimplePopup then
					v2.IsAbility = false
				end

				self:AddElement(v2, true)
			end
		end

		local v2

		if #stuffToLoad > 0 and #stuffToLoad == #list.mIconLoader.StuffToLoad then
			v2 = true

			for i = 1, #stuffToLoad do
				if stuffToLoad[i] == list.mIconLoader.StuffToLoad[i] then
					continue
				end

				v2 = false
				break
			end
		else
			v2 = false
		end

		if not v2 then
			list.mIconLoader.IsLoading = false
			list.mIconLoader.StuffToLoad = stuffToLoad

			if #list.mIconLoader.StuffToLoad > 0 then
				list.mIconLoader.Loader = UISys.__wf_atom_c0dbe47c(list.mIconLoader.StuffToLoad)
				list.mIconLoader.IsLoading = true
			end
		end

		if self.mSkipAbilityColorGet == nil or not self.mSkipAbilityColorGet then
			self.mAbilityColor1 = Color()
			self.mAbilityColor2 = Color()
			v:__wf_atom_8e1ec29f(self.mAbilityColor1)
			v:__wf_atom_8e1ec29f(self.mAbilityColor2, true)
		end

		list.mSparkleMaterial:__wf_atom_a042ff6c(
			Symbol("TintColor"),
			self.mAbilityColor1.red / 255,
			self.mAbilityColor1.green / 255,
			self.mAbilityColor1.blue / 255,
			1
		)
		list.mSparkleMaterial:__wf_atom_a042ff6c(
			Symbol("GlowColor"),
			self.mAbilityColor2.red / 128,
			self.mAbilityColor2.green / 128,
			self.mAbilityColor2.blue / 128,
			1
		)
		self:Redraw(nil, nil, p6)
		local v3 = self.mForcedHorizontalSeparation * self:GetHowManyElements() + self.mUnderlineWidthOffset

		if self.mShowPassive then
			v3 -= 30
		end

		module2.DrawSeparator(self.mMovie, self.mParentClipName .. ".Underline", v3)
		self.mMovie:__wf_atom_4c1c1986(self.mParentClipName, "Underline", 11, module.GetColor(9, true))

		if self.VisibleRangeInfo ~= nil then
			for _, v4 in pairs({ "UnderLine.Fill", "Underline.CapLeft", "Underline.CapRight" }) do
				self.mMovie:OverrideMaterial(self.mParentClipName .. "." .. v4, self.VisibleRangeInfo.BaseMaterial)
			end
		end
	end

	list.List_CalculateX = list.CalculateX

	function list.CalculateX(object2, p)
		return object2:List_CalculateX(p)
	end

	function list.mOnFocusedCallback(infoPopup_Data)
		if infoPopup_Data.mClipName == nil then
			return
		end

		__wf_atom_ec43d06e(
			list.mMovie,
			infoPopup_Data.mClipName .. ".Icon",
			2,
			{ 1 },
			{ list.mInitIconYPos - list.mIconFocusOffset },
			0.15
		)
		__wf_atom_ec43d06e(list.mMovie, infoPopup_Data.mClipName .. ".Glow", 2, { 12 }, { 100 }, 0.25)
		list:RunForAllElements(function(p)
			if infoPopup_Data.Id ~= p.Id then
				__wf_atom_ec43d06e(list.mMovie, p.mClipName .. ".Glow", 2, { 12 }, { 0 }, 0.25)
			end
		end)
		module2.SetItemInfoPopupRect(
			list.mMovie,
			infoPopup_Data,
			list.mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName .. ".Btn", 2),
			list.mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName .. ".Btn", 3),
			list.mForcedHorizontalSeparation - 15,
			list.mForcedHorizontalSeparation
		)
		_T.InfoPopup_Data = infoPopup_Data
		list:UpdateColors(infoPopup_Data, true)
	end

	function list.mOnUnfocusedCallback(p)
		_T.InfoPopup_Data = nil
		__wf_atom_ec43d06e(list.mMovie, p.mClipName .. ".Icon", 2, { 1 }, { list.mInitIconYPos }, 0.15)
		list:RunForAllElements(function(p2)
			__wf_atom_ec43d06e(list.mMovie, p2.mClipName .. ".Glow", 2, { 12 }, { 65 }, 0.25)
		end)
		list:UpdateColors(p, false)
	end

	function list:Update()
		if self.mIconLoader.IsLoading and self.mIconLoader.Loader:__wf_atom_86399a47() then
			self.mIconLoader.IsLoading = false
			self:RunForAllElements(function(p)
				if not p.IsPassive then
					self.mMovie:__wf_atom_7f57ab2f(p.mClipName, "Icon", 13, true)
					self:SetIconForElement(p)
				end
			end)
		end
	end

	function list:UpdateColors(p, p2)
		local color = module.GetColor(6, true)
		local color2 = module.GetColor(9, true)
		local color3 = module.GetColor(10, true)
		local __wf_atom_dcecedb0 = self.mAbilityColor1:__wf_atom_dcecedb0()
		local __wf_atom_dcecedb0_2 = self.mAbilityColor2:__wf_atom_dcecedb0()
		local v = { 0, 3342336, 8912896, 12255232 }
		self.mMovie:__wf_atom_4c1c1986(p.mClipName, "Icon.Icon", 11, color2)
		self.mMovie:__wf_atom_4c1c1986(p.mClipName, "Glow", 11, color3)
		self.mMovie:__wf_atom_4c1c1986(p.mClipName, "Icon.Shadow", 11, __wf_atom_dcecedb0)
		self.mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Icon.Shadow",
			"CheapGlowColor",
			self.mAbilityColor1.red / 255,
			self.mAbilityColor1.green / 255,
			self.mAbilityColor1.blue / 255,
			1
		)
		self.mMovie:__wf_atom_4c1c1986(p.mClipName, "Title", 11, p2 and color3 or color2)
		self.mMovie:__wf_atom_4c1c1986(p.mClipName, "Rank", 11, color)
		self.mMovie:__wf_atom_4c1c1986(p.mClipName, "Gradient", 12, 0)
		self.mMovie:__wf_atom_4c1c1986(p.mClipName, "Highlight.StarburstOne", 11, __wf_atom_dcecedb0_2)
		self.mMovie:__wf_atom_4c1c1986(p.mClipName, "Highlight.StarburstTwo", 11, __wf_atom_dcecedb0)
		self.mMovie:__wf_atom_4c1c1986(p.mClipName, "Sparkles", 11, v[1 + p.mIndex % #v])
	end

	function list:SetIconForElement(p)
		local v = Resource(p.Icon)
		self.mMovie:__wf_atom_933bbce0(p.mClipName .. ".Icon.Icon", v, visRangeMaterial)
		self.mMovie:__wf_atom_933bbce0(p.mClipName .. ".Icon.Shadow", v, shadowMaterial)
	end

	function list.mElementDrawCallback(data)
		if data.mClipName == nil then
			return
		end

		local focusedElement = list:GetFocusedElement()
		local v = not __wf_atom_7e8ad928(focusedElement) and focusedElement.Id == data.Id
		module2.SetItemInfoPopupRect(
			list.mMovie,
			data,
			list.mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Btn", 2),
			list.mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Btn", 3),
			list.mForcedHorizontalSeparation - 15,
			list.mForcedHorizontalSeparation
		)
		list.mMovie:__wf_atom_7f57ab2f(data.mClipName, "Title", 13, list.mShowTitle)
		local v2 = list.mForcedHorizontalSeparation - 10
		list.mMovie:__wf_atom_4c1c1986(data.mClipName, "Title", 14, v2)
		list.mMovie:__wf_atom_4c1c1986(data.mClipName, "Title", 0, -(module3.Round(v2 / 2) - 2))
		list.mMovie:__wf_atom_48bd5a59(
			data.mClipName,
			"Title",
			36,
			string.upper(list.mMovie:__wf_atom_8e9ac384(data.Name, true))
		)
		local __wf_atom_5e6e15c8 = list.mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Title", 43)

		if __wf_atom_5e6e15c8 ~= nil and list.mInitRankYPos ~= nil then
			list.mMovie:__wf_atom_4c1c1986(
				data.mClipName,
				"Rank",
				1,
				list.mInitRankYPos + (__wf_atom_5e6e15c8 - 1) * 19
			)
		end

		list.mMovie:__wf_atom_7f57ab2f(data.mClipName, "Rank", 13, list.mShowRank)

		if data.Locked then
			list.mMovie:__wf_atom_48bd5a59(
				data.mClipName,
				"Rank",
				36,
				TitleCase(list.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/FocusLocked", true))
			)
		else
			list.mMovie:__wf_atom_48bd5a59(
				data.mClipName,
				"Rank",
				36,
				TitleCase(list.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FormattedRankCaps", true, {
					RANK = data.Level
				}))
			)
		end

		local isPassive = data.IsPassive
			or not (__wf_atom_7e8ad928(list.mIconLoader.Loader) or list.mIconLoader.IsLoading)
		list.mMovie:__wf_atom_7f57ab2f(data.mClipName, "Icon", 13, isPassive)

		if isPassive then
			list:SetIconForElement(data)
		end

		local mIconDim = list.mIconDim
		list.mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 14, mIconDim)
		list.mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 15, mIconDim)
		list.mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 1, list.mInitIconYPos)
		list.mMovie:__wf_atom_7f57ab2f(data.mClipName, "Icon.Shadow", 13, false)
		list.mMovie:__wf_atom_c90af43a(data.mClipName .. ".Glow", glowTexture)
		list.mMovie:OverrideMaterial(data.mClipName .. ".Sparkles", list.mSparkleMaterial)
		list.mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 14, list.mGlowWidth)
		list.mMovie:__wf_atom_4c1c1986(data.mClipName, "Glow", 12, 65)

		if list.VisibleRangeInfo ~= nil then
			for _, v3 in pairs({
				"Icon.Icon",
				"Glow",
				"Highlight.StarburstOne.StarburstOne",
				"Highlight.StarburstTwo.StarburstTwo"
			}) do
				list.mMovie:OverrideMaterial(data.mClipName .. "." .. v3, list.VisibleRangeInfo.BaseMaterial)
			end
		end

		list:UpdateColors(data, v)
	end

	return list
end