module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("SF.Interface.Libs.OdeCipher")
local v = Resource("/Lotus/PVP/PVPPowerSuitStatsModifier")
local UIColor_Yellow = _G.UIColor_Yellow
require("SF.Interface.Libs.StatsUtil")
local v2 = { 5, 10, 15, 20, 25 }

local function fn(formatNumber)
	return string.format(
		"<font color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_BrightOrange) .. "\">%s</font>",
		formatNumber
	)
end

local function fn2(__wf_atom_8e9ac384)
	return string.format(
		"<font color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\">%s</font>",
		__wf_atom_8e9ac384
	)
end

local function fn3(object, __wf_atom_966277ef)
	return (object:__wf_atom_8e9ac384("/SF/Language/Menu/Quality_" .. module3.GetQualityTag(__wf_atom_966277ef), false))
end

local function fn4(p, p2, p3, p4)
	local v3 = not p3 and 4473924 or ({
		[0] = p4 and 8083003 or 9450805,
		[2] = p4 and 4014418 or 4482163,
		[1] = p4 and 6253660 or 6124631
	})[p]
	local convertColorNumberToHex = module.ConvertColorNumberToHex(v3)
	return string.format("<font color=\"" .. convertColorNumberToHex .. "\">%s</font>", p2)
end

local function fn5(mName)
	return mName == nil or mName == ""
end

function Create(p, p2)
	local module5 = require("EE.Interface.Components.List")
	local list = module5.CreateList(p, p2)
	list.mPrefix = "StatCompare(" .. p2 .. ")::"
	list.mStats = {}
	list.mSort = true
	list.mWrapAroundNavigation = false
	list.mElementTransitionTime = 0.15
	list.GroupTitleColor = UIColor_Yellow
	list.LabelColor = _G.UIColor_White
	list.PreviousStatColor = _G.UIColor_White
	list.StatIncreasedColor = _G.UIColor_Green
	list.StatDecreasedColor = _G.UIColor_Red
	list.mGrowsUpwards = true
	list.mForcedVerticalSeparation = 23
	list.mOriginalElementHeight = list.mMovie:__wf_atom_5e6e15c8(p2, 15)
	list:SetCallbacks("StatSelected", "StatFocused", "StatUnfocused", "StatPressed")

	function list.Print(_, _) end

	function list.GetPreviousStatColor(_)
		return (string.format("%x", list.PreviousStatColor))
	end

	function list.GetCurrentStatColor(p3, p4, p5)
		local previousStatColor = list.GetPreviousStatColor()

		if p4 == nil or p5 == nil or p3.TextOnly then
			return previousStatColor
		end

		local v3 = p5 < p4

		if p3.SmallerIsBetter then
			v3 = p4 < p5
		end

		previousStatColor = module.Ternary(
			v3,
			string.format("%x", list.StatDecreasedColor),
			string.format("%x", list.StatIncreasedColor)
		)
		return previousStatColor
	end

	function list:mElementDrawCallback()
		local label = self.Label
		list.mMovie:__wf_atom_50d60589(self.mClipName .. ".Label", 36, label)
		list.mMovie:OverrideMaterial(self.mClipName .. ".Label", _G.UIMaterial_PlainText)
		list.mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 44, list.LabelColor)
		list.mMovie:OverrideMaterial(self.mClipName .. ".NewValue", _G.UIMaterial_PlainText)
		local ternary = module.Ternary(list.LabelAlpha ~= nil, list.LabelAlpha, 100)
		local total = 100

		if list.StatAltAlphaOffset ~= nil and self.mIndex % 2 == 0 then
			ternary += list.StatAltAlphaOffset
			total += list.StatAltAlphaOffset
		end

		list.mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 12, ternary)
		list.mMovie:__wf_atom_4c1c1986(self.mClipName, "NewValue", 12, total)
		local v3 = list.StatBgColor ~= nil
		list.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Bg", 13, v3)

		if v3 then
			list.mMovie:__wf_atom_4c1c1986(self.mClipName, "Bg", 11, list.StatBgColor)
			list.mMovie:__wf_atom_4c1c1986(
				self.mClipName,
				"Bg",
				12,
				module.Ternary(self.mIndex % 2 ~= 0, list.StatBgAlpha, 0)
			)
		end

		if list.mMovie:__wf_atom_a91463a8(self.mClipName .. ".Label", 52) then
			local __wf_atom_5e6e15c8 = list.mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Label", 41)
			list.mMovie:__wf_atom_4c1c1986(self.mClipName, "NewValue", 1, __wf_atom_5e6e15c8 / 2 - 9)
			list.mMovie:__wf_atom_4c1c1986(self.mClipName, "Line", 1, __wf_atom_5e6e15c8 + 7)
		end

		list.mMovie:__wf_atom_4c1c1986(self.mClipName, "Line", 15, 2.5)
		list.mMovie:OverrideMaterial(self.mClipName .. ".Line", _G.UIMaterial_SmoothEdgeNoDepthTest)
		local ternary2 = module.Ternary(__wf_atom_7e8ad928(self.ValueUnit), "", self.ValueUnit)

		if self.Previous == nil or self.Previous.StatValue == nil and self.Previous.DisplayValue == nil then
			if self.TextOnly then
				self.Previous = {
					StatValue = 0,
					DisplayValue = list.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Arsenal_Zero", false)
				}
			else
				self.Previous = { StatValue = 0, DisplayValue = "0" }
			end
		elseif self.Previous.DisplayValue == nil then
			self.Previous.DisplayValue = module.FormatNumber(self.Previous.StatValue)
		end

		if self.Current == nil or self.Current.StatValue == nil and self.Current.DisplayValue == nil then
			if self.TextOnly then
				self.Current = {
					StatValue = 0,
					DisplayValue = list.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Arsenal_Zero", false)
				}
			else
				self.Current = { StatValue = 0, DisplayValue = "0" }
			end
		elseif self.Current.DisplayValue == nil then
			self.Current.DisplayValue = module.FormatNumber(self.Current.StatValue)
		end

		local previousStatColor = list.GetPreviousStatColor(self)
		local v4

		if ternary2 == "" then
			v4 = "<p><font color=\"#" .. previousStatColor .. "\">" .. self.Previous.DisplayValue .. "</font>"
		else
			v4 = "<p><font color=\"#" .. previousStatColor .. "\">" .. list.mMovie:__wf_atom_8e9ac384(ternary2, true, {
				COUNT = self.Previous.DisplayValue
			}) .. "</font>"
		end

		local ternary3 = module.Ternary(self.TextOnly, self.Previous.DisplayValue, self.Previous.StatValue)
		local ternary4 = module.Ternary(self.TextOnly, self.Current.DisplayValue, self.Current.StatValue)

		if ternary3 ~= ternary4 then
			local __wf_atom_8e9ac384 = list.mMovie:__wf_atom_8e9ac384("<MINI_ARROW>", true)
			local currentStatColor = list.GetCurrentStatColor(self, ternary3, ternary4)

			if ternary2 == "" then
				v4 ..= "<font color=\"#" .. currentStatColor .. "\">" .. __wf_atom_8e9ac384 .. self.Current.DisplayValue .. "</font>"
			else
				v4 ..= "<font color=\"#" .. currentStatColor .. "\">" .. __wf_atom_8e9ac384 .. list.mMovie:__wf_atom_8e9ac384(ternary2, true, {
					COUNT = self.Current.DisplayValue
				}) .. "</font>"
			end
		end

		local v5 = v4 .. "</p>"
		list.mMovie:__wf_atom_50d60589(self.mClipName .. ".NewValue", 36, v5)
		local v6

		if self.mIndex == list:GetHowManyElements() then
			v6 = true
		else
			local elementInIndex = list:GetElementInIndex(self.mIndex + 1)
			v6 = self.Order ~= elementInIndex.Order
		end

		list.mMovie:__wf_atom_2dedec1a(self.mClipName, 13, not self.Filler)
		list.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Line", 13, not (v6 or self.Filler))
		local mMovie = list.mMovie
		local mClipName = self.mClipName
		local dotLink = list.DotLink

		if dotLink then
			local filler = self.Filler or self.Title
			dotLink = not filler
		end

		mMovie:__wf_atom_7f57ab2f(mClipName, "DotLine", 13, dotLink == true)

		if self.Filler or self.Title then
			list.mMovie:__wf_atom_50d60589(self.mClipName .. ".NewValue", 36, "")
		elseif list.DotLink and list.Width ~= nil then
			local __wf_atom_5e6e15c8 = list.mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Label", 40)
			local __wf_atom_5e6e15c8_2 = list.mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".NewValue", 40)
			local rounded = module.Round((list.Width - (__wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 + 10)) / 5)
			local v7 = rounded * 5
			list.mMovie:__wf_atom_1ca72041(self.mClipName .. ".DotLine", "TileRepeats", rounded, 1, 1, 1)
			list.mMovie:__wf_atom_4c1c1986(self.mClipName, "DotLine", 14, v7)
			list.mMovie:__wf_atom_4c1c1986(self.mClipName, "DotLine", 15, 5)
			list.mMovie:__wf_atom_4c1c1986(self.mClipName, "DotLine", 12, 10)
			list.mMovie:__wf_atom_4c1c1986(
				self.mClipName,
				"DotLine",
				0,
				list.mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Label", 0) + __wf_atom_5e6e15c8 + 5
			)

			if not __wf_atom_7e8ad928(list.DotLinkMat) then
				list.mMovie:OverrideMaterial(self.mClipName .. ".DotLine", list.DotLinkMat)
			end
		end
	end

	list._list_Redraw = list.Redraw

	function list:Redraw(p3, p4, p5)
		self:Populate()
		self:_list_Redraw(p3, p4, p5)
	end

	function list.SetupPreInterpolationValues(_, _) end

	list.GetInterpolationProperties = list.DefaultAlphaInterpolation

	function list.GetHeight(data)
		local v3 = 0

		for i = 1, #data.mElements do
			local mElement = data.mElements[i]

			if mElement.Filler then
				v3 += 10
			else
				local v4 = data.mMovie:__wf_atom_5e6e15c8(mElement.mClipName, 15) - data.mOriginalElementHeight
				v3 = v3 + data.mForcedVerticalSeparation + module.Ternary(v4 > 0, v4 + 3, 0)
			end
		end

		return v3
	end

	function list.CalculateY(data, p3)
		local mInitialY = data.mInitialY

		for i = 1, p3.Id - 1 do
			if data.mElements[i].Filler then
				mInitialY += module.Ternary(data.mGrowsUpwards, 10, -10)
			else
				local v3 = data.mMovie:__wf_atom_5e6e15c8(data.mElements[i].mClipName, 15) - data.mOriginalElementHeight
				local v4 = data.mForcedVerticalSeparation + module.Ternary(v3 > 0, v3 + 3, 0)
				mInitialY += module.Ternary(data.mGrowsUpwards, v4, -v4)
			end
		end

		return mInitialY
	end

	function list:Populate()
		self:RemoveElements(true, true)
		local ternary = module.Ternary(self.mGrowsUpwards, 1, 0)
		local v3 = ternary + 1
		local v4 = v3 + 1
		local v5 = v4 + 1
		local v6 = v5 + 1
		local v7 = v6 + 1
		local v8 = v7 + 1
		local v9 = v8 + 1
		local ternary2 = module.Ternary(self.mGrowsUpwards, 0, v9)
		local ternary3 = module.Ternary(self.mGrowsUpwards, v9, 0)
		local ternary4 = module.Ternary(self.mGrowsUpwards, 0, #self.mStats * (v9 + 1))
		local flag = false
		local v10 = {}
		local flag2 = false
		local flag3 = false
		local flag4 = false

		for _, mStat in ipairs(self.mStats) do
			if flag then
				table.insert(v10, {
					Label = "",
					Previous = nil,
					Filler = true,
					Order = module.Ternary(self.mGrowsUpwards, ternary4, ternary3 - ternary4)
				})
			end

			if not fn5(mStat.mName) and (#self.mStats > 1 or mStat.mForceHeader) then
				table.insert(v10, {
					Label = "<p><font face=\"" .. "SpectralSC" .. "\" color=\"" .. self.GroupTitleColor .. "\">" .. mStat.mName .. "</font></p>",
					Previous = nil,
					Title = true,
					Order = ternary2 + ternary4
				})
			end

			for k, mStat2 in pairs(mStat.mStats) do
				if self.mSort then
					if k == "Total" then
						mStat2.Order = v8 + ternary4
						table.insert(v10, {
							Label = "",
							Previous = nil,
							Filler = true,
							Order = v8 + ternary4
						})
					elseif k == "CONCLAVE" then
						mStat2.Order = ternary + ternary4
						flag2 = true
					elseif string.find(k, "_RESIST$") == nil then
						if string.find(k, "Embed") == nil then
							if string.find(k, "EmbedDT_") == nil then
								if string.find(k, "DT_") == nil and string.find(k, "Power_") == nil then
									mStat2.Order = v3 + ternary4
								else
									mStat2.Order = v5 + ternary4
									flag4 = true
								end
							else
								mStat2.Order = v7 + ternary4
							end
						else
							mStat2.Order = v6 + ternary4
						end
					else
						mStat2.Order = v4 + ternary4
						flag3 = true
					end

					if mStat2.ForceOrder ~= nil then
						mStat2.Order = mStat2.ForceOrder + ternary4

						if mStat2.ForceOrder == ternary then
							flag2 = true
						elseif mStat2.ForceOrder == v4 then
							flag3 = true
						elseif mStat2.ForceOrder == v5 then
							flag4 = true
						end
					end
				end

				table.insert(v10, mStat2)
			end

			if self.mSort then
				if flag2 then
					table.insert(v10, {
						Label = "",
						Previous = nil,
						Filler = true,
						Order = v3 + ternary4
					})
				end

				if flag3 then
					table.insert(v10, {
						Label = "",
						Previous = nil,
						Filler = true,
						Order = v4 + ternary4
					})
				end

				if flag4 then
					table.insert(v10, {
						Label = "",
						Previous = nil,
						Filler = true,
						Order = v5 + ternary4
					})
				end
			end

			ternary4 = module.Ternary(self.mGrowsUpwards, v9 + 1 + ternary4, v9 + 1 - ternary4)
			flag = true
		end

		if self.mSort then
			table.sort(v10, function(a, b)
				if a.Order == b.Order then
					return a.Label < b.Label
				end

				return a.Order < b.Order
			end)
		end

		local count = 0

		for _, v11 in pairs(v10) do
			__wf_atom_83c14687(0)
			count += 1
			v11.Id = count
			self:AddElement(v11, true)
		end
	end

	return list
end

local function fn6(displayValue, statValue, textOnly, textIfOneNil, toolTip, toolTipValue)
	if toolTipValue ~= nil then
		toolTipValue = module.FormatNumber(toolTipValue, 1, false)
	end

	return {
		DisplayValue = displayValue,
		StatValue = statValue,
		TextOnly = textOnly,
		TextIfOneNil = textIfOneNil,
		ToolTip = toolTip,
		ToolTipValue = toolTipValue
	}
end

local function fn7(instance)
	return instance:IsA(__wf_atom_2c8a4b8d) or instance:IsA(__wf_atom_77e05d3b)
end

local function fn8(instance)
	return instance:IsA(__wf_atom_d98e64fe)
end

local function fn9(object, object2, object3)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object3) then
		return
	end

	local v3 = {
		mName = object:__wf_atom_8e9ac384("/Lotus/Language/Labels/RAILJACKUpper", false),
		mStats = {},
		mIsMelee = false
	}
	local mStats = v3.mStats
	local __wf_atom_7470861b = object2:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local motionControl = object2:MotionControl()
	local maxHealth = object2:GetMaxHealth()
	local __wf_atom_2bf72530 = __wf_atom_7470861b:__wf_atom_2bf72530()
	local v4 = __wf_atom_7470861b:__wf_atom_cac9b02d() / __wf_atom_2bf72530 * 100
	local __wf_atom_3bfe22bd = __wf_atom_7470861b:__wf_atom_3bfe22bd()
	local __wf_atom_58367d88 = __wf_atom_7470861b:__wf_atom_58367d88()
	local v5 = motionControl:__wf_atom_3932eed7(0) / object2:__wf_atom_2b41bcf9()
	local v6 = (v5.x + v5.y + v5.z) / 3
	local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(
		motionControl:__wf_atom_38639bff().x,
		167,
		object3:__wf_atom_1bb5b1ff(),
		object3
	)
	local v7 = { 3, 5, 6, 4 }

	for i = 1, #v7 do
		local v8 = v7[i]
		local __wf_atom_2a745663_2 = __wf_atom_d2b2176d:__wf_atom_2a745663(100, 46, nil, nil, v8)

		if __wf_atom_2a745663_2 == 100 then
			continue
		end

		local v9 = module.FormatNumber(100 - __wf_atom_2a745663_2, 1) .. "%"
		mStats[module2.GetDamageTypeTag(v8)] = fn6(v9, __wf_atom_2a745663_2, nil, true)
	end

	local __wf_atom_2a745663_2 = __wf_atom_d2b2176d:__wf_atom_2a745663(0, 158, nil, nil, 23)

	if __wf_atom_2a745663_2 ~= 0 then
		mStats.ElementRedirection = fn6(
			module.FormatNumber(__wf_atom_2a745663_2 * 100, 1) .. "%",
			__wf_atom_2a745663_2,
			nil,
			true
		)
	end

	local __wf_atom_a8c50352 = __wf_atom_d2b2176d:__wf_atom_a8c50352()
	mStats.RailjackHealth = fn6(nil, maxHealth, nil, true)
	mStats.Shield = fn6(nil, __wf_atom_2bf72530, nil, true)
	mStats.Armor = fn6(nil, __wf_atom_58367d88, nil, true, nil, 100 * __wf_atom_7470861b:__wf_atom_7b86cbfc())
	mStats.Engines = fn6(
		object:__wf_atom_8e9ac384("/Lotus/Language/Game/UNIT_METER_PER_SECOND", false, {
			COUNT = module.FormatNumber(v6)
		}),
		v6,
		nil,
		true
	)
	mStats.EngineBoost = fn6("x" .. module.FormatNumber(__wf_atom_2a745663, 1), __wf_atom_2a745663, nil, true)
	mStats.ShieldRechargeRate = fn6(
		object:__wf_atom_8e9ac384("/Lotus/Language/Game/UNIT_PERCENT_PER_SECOND", false, {
			COUNT = module.FormatNumber(v4, 1)
		}),
		module.Round(v4, 1),
		nil,
		true
	)
	mStats.ShieldRechargeDelay = fn6(
		object:__wf_atom_8e9ac384("/Lotus/Language/Menu/ProgressSeconds", false, {
			CURRENT = module.FormatNumber(__wf_atom_3bfe22bd, 1)
		}),
		-__wf_atom_3bfe22bd,
		nil,
		true
	)
	mStats.CargoCapacity = fn6(nil, __wf_atom_a8c50352, nil, true)
	local __wf_atom_2a745663_3 = __wf_atom_d2b2176d:__wf_atom_2a745663(1, 10, object3:__wf_atom_1bb5b1ff(), object3)
	mStats.Railjack_Power_Strength = fn6(
		module.FormatNumber(__wf_atom_2a745663_3 * 100) .. "%",
		__wf_atom_2a745663_3,
		nil,
		true
	)
	local __wf_atom_2a745663_4 = __wf_atom_d2b2176d:__wf_atom_2a745663(1, 9, object3:__wf_atom_1bb5b1ff(), object3)
	mStats.Railjack_Power_Range = fn6(
		module.FormatNumber(__wf_atom_2a745663_4 * 100) .. "%",
		__wf_atom_2a745663_4,
		nil,
		true
	)
	local __wf_atom_2a745663_5 = __wf_atom_d2b2176d:__wf_atom_2a745663(1, 3, object3:__wf_atom_1bb5b1ff(), object3)
	mStats.Railjack_Power_Duration = fn6(
		module.FormatNumber(__wf_atom_2a745663_5 * 100) .. "%",
		__wf_atom_2a745663_5,
		nil,
		true
	)
	return v3
end

local function fn10(object, instance, instance2, p, p2)
	if __wf_atom_7e8ad928(instance2) then
		return
	end

	local maxHealth = 0
	local v3

	if instance2:IsA(__wf_atom_3ad9dd38) and instance2:__wf_atom_f3505c97() and __wf_atom_7e8ad928(instance) then
		instance = instance2:__wf_atom_95e72410()
		v3 = true
	else
		v3 = false
	end

	local v4 = nil
	local v5, v6

	if __wf_atom_7e8ad928(instance) then
		if not __wf_atom_7e8ad928(_T.MenuSuitAvatar) then
			v4 = _T.MenuSuitAvatar:__wf_atom_7470861b()
		end

		local v7 = Resource("/Lotus/Types/Player/TennoMainMenuDamageController")

		if not __wf_atom_7e8ad928(_T.CachedTennoAvatar) then
			maxHealth = _T.CachedTennoAvatar:GetMaxHealth()
		end

		v5 = module.Ternary(
			instance2:__wf_atom_db2661f9() >= 0,
			instance2:__wf_atom_db2661f9(),
			v7:__wf_atom_2bf72530()
		)
		v6 = module.Ternary(instance2:__wf_atom_25e79273() > 0, instance2:__wf_atom_25e79273(), v7:__wf_atom_58367d88())

		if p then
			maxHealth = v:__wf_atom_17f0be56(maxHealth)
			v5 = v:__wf_atom_d0ae0c31(v5)
			v6 = v:__wf_atom_e9dfeb66(v6)
		end
	else
		v4 = instance:__wf_atom_7470861b()

		if p then
			instance2:__wf_atom_31ea6b4f(instance)
			maxHealth = v:__wf_atom_17f0be56(instance:GetMaxHealth())
			v5 = v:__wf_atom_d0ae0c31(v4:__wf_atom_2bf72530())
			v6 = v:__wf_atom_e9dfeb66(v4:__wf_atom_58367d88())
		else
			maxHealth = math.floor((instance:GetMaxHealth()))
			v5 = math.floor((v4:__wf_atom_2bf72530()))
			v6 = math.floor((v4:__wf_atom_58367d88()))
		end
	end

	local v7 = __wf_atom_7e8ad928(p2) and { mName = "", mStats = {}, mIsMelee = false } or p2
	local mStats = v7.mStats
	mStats.Health = fn6(nil, maxHealth, nil, true)
	mStats.Shield = fn6(nil, v5, nil, true)

	if not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(instance2)) then
		local attribute = instance:GetAttribute(0, false)
		local attribute2 = instance:GetAttribute(2, false)
		local attribute3 = instance:GetAttribute(1, false)
		local __wf_atom_f44808ea = instance2:__wf_atom_f44808ea(instance, attribute, 21)
		local __wf_atom_f44808ea2 = instance2:__wf_atom_f44808ea(instance, attribute2, 23)
		local __wf_atom_f44808ea3 = instance2:__wf_atom_f44808ea(instance, attribute3, 22)
		local v8 = math.min(
			__wf_atom_c67f9605:__wf_atom_7da755e9(instance2:__wf_atom_1bb5b1ff(), 0),
			__wf_atom_c67f9605:__wf_atom_b4a75eaa(instance2:__wf_atom_9765cbd5(), instance2:__wf_atom_1bb5b1ff())
		)
		mStats.Level = fn6(nil, v8, nil, true)
		local __wf_atom_24c6fb4f = instance2:__wf_atom_24c6fb4f()

		for i = 1, math.min(v8 + 1, #__wf_atom_24c6fb4f) do
			local __wf_atom_b810064e = __wf_atom_24c6fb4f[i]:__wf_atom_b810064e()
			local __wf_atom_505b3c0e = __wf_atom_24c6fb4f[i]:__wf_atom_505b3c0e()

			if __wf_atom_b810064e == 21 then
				__wf_atom_f44808ea += __wf_atom_505b3c0e
			elseif __wf_atom_b810064e == 23 then
				__wf_atom_f44808ea2 += __wf_atom_505b3c0e
			elseif __wf_atom_b810064e == 22 then
				__wf_atom_f44808ea3 += __wf_atom_505b3c0e
			end
		end

		mStats.Courage = fn6(nil, __wf_atom_f44808ea, nil, true)
		mStats.Grace = fn6(nil, __wf_atom_f44808ea2, nil, true)
		mStats.Spirit = fn6(nil, __wf_atom_f44808ea3, nil, true)
		local v9 = 0

		for i = 0, instance2:__wf_atom_ca3e110b() - 1 do
			local __wf_atom_010c2f81 = instance2:__wf_atom_010c2f81(i)

			if __wf_atom_010c2f81:IsA(WeakResource("/SF/Types/Game/UnarmedMeleeImpactBehavior")) then
				v9 = __wf_atom_010c2f81:__wf_atom_ae4f866b(true, true, false)
			end
		end

		mStats.UnarmedMelee = fn6(nil, v9, nil, true)
	end

	local v8

	if not __wf_atom_7e8ad928(v4) then
		v8 = 100 * v4:__wf_atom_7b86cbfc()
	end

	mStats.Armor = fn6(nil, v6, nil, true, nil, v8)
	local flag = false
	local v9

	if not __wf_atom_7e8ad928(instance) then
		v9 = instance:__wf_atom_d2b2176d()

		if not p then
			instance2 = module.Ternary(v9:__wf_atom_84479917() or v3, v9:__wf_atom_f7583f71(), v9:__wf_atom_e55d02aa())
			flag = true
		end
	end

	if __wf_atom_7e8ad928(instance2) or instance2:IsA(__wf_atom_1bef9e62) then
		return v7
	end

	local v10

	if __wf_atom_7e8ad928(instance) then
		v10 = instance2:__wf_atom_6a5c92a7()
	elseif p then
		local __wf_atom_e00502d8 = instance2:__wf_atom_e00502d8()
		instance2:__wf_atom_205595ee(100)
		v10 = instance2:__wf_atom_6a5c92a7()
		instance2:__wf_atom_205595ee(__wf_atom_e00502d8)
	else
		v10 = instance2:__wf_atom_6a5c92a7()
	end

	mStats.Power = fn6(nil, v10, nil, true)

	for i = 1, 4 do
		local v11

		if flag then
			v11 = instance2:__wf_atom_c497b0ae(i - 1)
		else
			v11 = instance2:__wf_atom_e68785c4(i - 1)
		end

		if __wf_atom_7e8ad928(v11) then
			mStats["Ability" .. i] = nil
			mStats["AbilityIcon" .. i] = nil
		else
			mStats["Ability" .. i] = object:__wf_atom_8e9ac384(v11:__wf_atom_014a76a2():c_str(), false)
			mStats["AbilityDescription" .. i] = object:__wf_atom_8e9ac384(v11:__wf_atom_3a3d2e39():c_str(), true)
			mStats["AbilityIcon" .. i] = v11:GetIconTexture()
			mStats["AbilityType" .. i] = v11
		end
	end

	local __wf_atom_3a1f3f95 = instance2:__wf_atom_3a1f3f95()

	if __wf_atom_7e8ad928(v9) then
		mStats.Mult_SprintSpeed = fn6(module.FormatNumber(__wf_atom_3a1f3f95, 2), __wf_atom_3a1f3f95, nil, true)
	else
		local v11 = { 3, 4, 5, 6, 7, 8, 14 }

		for i = 1, #v11 do
			local v12 = v11[i]
			local __wf_atom_2a745663 = v9:__wf_atom_2a745663(100, 46, instance2:__wf_atom_1bb5b1ff(), instance2, v12)

			if __wf_atom_2a745663 == 100 then
				continue
			end

			local statValue = 100 - __wf_atom_2a745663
			local displayValue = module.FormatNumber(statValue, 1) .. "%"
			mStats[module2.GetDamageTypeTag(v12) .. "_RESIST"] = fn6(displayValue, statValue, nil, true, nil, statValue)
		end

		if p then
			local __wf_atom_2a745663 = v9:__wf_atom_2a745663(1, 187)
			mStats.ParkourBoost = fn6(module.FormatNumber(__wf_atom_2a745663, 2), __wf_atom_2a745663, nil, true)
		end

		v9:AddUpgrade(167, 2, __wf_atom_3a1f3f95)
		local v12

		if v9:__wf_atom_84479917() then
			v12 = v9:__wf_atom_2a745663(
				1,
				167,
				instance2:__wf_atom_1bb5b1ff(),
				instance2,
				26,
				Symbol("ARCHWING_SPRINT_SPEED")
			)
		else
			v12 = v9:__wf_atom_2a745663(1, 167)
		end

		v9:RemoveUpgrade(167, 2, __wf_atom_3a1f3f95)
		mStats.Mult_SprintSpeed = fn6(module.FormatNumber(v12, 2), v12, nil, true)

		if not v3 then
			local __wf_atom_2a745663 = v9:__wf_atom_2a745663(1, 10, instance2:__wf_atom_1bb5b1ff(), instance2)
			mStats.Power_Strength = fn6(
				module.FormatNumber(__wf_atom_2a745663 * 100) .. "%",
				__wf_atom_2a745663,
				nil,
				true
			)
			local __wf_atom_2a745663_2 = v9:__wf_atom_2a745663(1, 4, instance2:__wf_atom_1bb5b1ff(), instance2)
			local v13 = __wf_atom_421b01aa(__wf_atom_2a745663_2, 0.25, 1.75)
			mStats.Power_Efficiency = fn6(module.FormatNumber(v13 * 100) .. "%", v13, nil, true)
			local __wf_atom_2a745663_3 = v9:__wf_atom_2a745663(1, 9, instance2:__wf_atom_1bb5b1ff(), instance2)
			mStats.Power_Range = fn6(
				module.FormatNumber(__wf_atom_2a745663_3 * 100) .. "%",
				__wf_atom_2a745663_3,
				nil,
				true
			)
			local __wf_atom_2a745663_4 = v9:__wf_atom_2a745663(1, 3, instance2:__wf_atom_1bb5b1ff(), instance2)
			mStats.Power_Duration = fn6(
				module.FormatNumber(__wf_atom_2a745663_4 * 100) .. "%",
				__wf_atom_2a745663_4,
				nil,
				true
			)
			local __wf_atom_2a745663_5 = v9:__wf_atom_2a745663(1, 413, instance2:__wf_atom_1bb5b1ff(), instance2)
			mStats.Status_Duration_Lavos = fn6(
				module.FormatNumber(__wf_atom_2a745663_5 * 100) .. "%",
				__wf_atom_2a745663_5,
				nil,
				true
			)
			mStats.Power_Efficiency_Lavos = fn6(module.FormatNumber(v13 * 100) .. "%", v13, nil, true)
			return v7
		end
	end

	return v7
end

local function fn11(value, value2)
	if
		type(value) ~= "number"
		or type(value2) ~= "number"
		or value ~= math.floor(value)
		or value2 ~= math.floor(value2)
	then
		error("Invalid argument to gcd (" .. tostring(value) .. "," .. tostring(value2) .. ")", 2)
		return
	end

	if value2 == 0 then
		return value
	end

	return fn11(value2, value % value2)
end

local function fn12(p)
	local v3 = math.floor(p + 0.5)
	local v4 = fn11(v3, 100)
	local numerator = v3 / v4
	local denominator = 100 / v4
	return Localize("/SF/Language/SystemMessages/Odds", {
		NUMERATOR = numerator,
		DENOMINATOR = denominator
	})
end

local function fn13(p, p2)
	local formatNumber = module.FormatNumber(p, 0)
	local formatNumber2 = module.FormatNumber(p2, 0)

	if p2 > 0 then
		local attune = "+" .. formatNumber2
		return Localize("/SF/Language/Menu/DamageAttune", { DAMAGE = formatNumber, ATTUNE = attune })
	else
		return formatNumber
	end
end

local function fn14(p)
	return fn6(module.FormatNumber(p, 0), p, nil)
end

local function fn15(object, data, object2, p)
	local projectileType = data.projectileType

	if __wf_atom_7e8ad928(projectileType) then
		if data.turboGlaive then
			projectileType = object2:__wf_atom_47ef92e7(p)
		else
			projectileType = object:__wf_atom_a07433fe():__wf_atom_1cda18ff()
		end
	end

	if __wf_atom_7e8ad928(projectileType) then
		return projectileType, (object:__wf_atom_dca3cbea())
	end

	return projectileType, (object:__wf_atom_0590ad17(projectileType, 0, data.behaviorIndex))
end

local function fn16(p, object, _, value, list, value2)
	local getDamageTypeTag = module2.GetDamageTypeTag
	local __wf_atom_37799654 = object:__wf_atom_6386920d():__wf_atom_37799654()
	local v3 = value2 or ""
	local v4 = value or 1

	for i = 0, 19 do
		local v5

		if list == nil or list[i] == nil then
			v5 = object:__wf_atom_bf612a92(i) * __wf_atom_37799654
		else
			v5 = list[i]
		end

		if v5 > 0 then
			p[v3 .. getDamageTypeTag(i)] = fn14(v5 * v4)
		end
	end
end

local function fn17(items, p, p2, value)
	local v3 = 0

	if not next(items) then
		return v3
	end

	local v4 = value or ""

	if #v4 > 0 then
		v3 = fn17(items, p, p2)
	end

	local getDamageTypeTag = module2.GetDamageTypeTag
	local count = 0

	for i = 0, 19 do
		local v5 = v4 .. getDamageTypeTag(i)

		if not items[v5] then
			continue
		end

		v3 += items[v5].StatValue
		count += 1
		items[v5] = nil
	end

	if v3 > 0 then
		local total = fn14(v3 * p2)
		total.Hidden = count <= 1 and p2 == 1
		items.Total = total
	end

	return v3
end

local function fn18(p, object, _, value, value2, list, _)
	local _getDamageTypeTag = module2.GetDamageTypeTag
	local __wf_atom_37799654 = object:__wf_atom_6386920d():__wf_atom_37799654()
	local v3 = value or 1
	local total = 0
	local count = 0
	local v4 = value2 or 1

	for i = 0, 19 do
		if not (object:__wf_atom_bf612a92(i) > 0) then
			continue
		end

		object:__wf_atom_bf612a92(i)
		local v5

		if list == nil or list[i] == nil then
			v5 = object:__wf_atom_bf612a92(i) * __wf_atom_37799654
		else
			v5 = list[i]
		end

		if not (v5 > 0) then
			continue
		end

		total += v5 * v3
		count += 1
	end

	if total > 0 then
		local total2 = fn14(total * v4)
		total2.Hidden = count <= 1 and v4 == 1
		p.Total = total2
	end
end

local function fn19(instance, p, instance2, p2, p3, p4, p5, p6, list, p7, mName)
	local v3 = {}
	local v4, v5 = fn15(instance, p, instance2, p2)

	if instance2:IsA(__wf_atom_ed85f483) and instance2.advanceProjectileSequenceOnFire then
		local v6 = instance2:__wf_atom_da8b6164() - 1

		if v6 > 0 then
			for i = 1, v6 do
				instance2:__wf_atom_18fa30ab(i)
				local _, v7 = fn15(instance, p, instance2, p2)
				table.insert(v3, v7)
			end

			instance2:__wf_atom_18fa30ab(0)
		end
	end

	local count = #v3
	local mStats = {}

	if not p7 then
		fn16(mStats, v5, p3, p5, p6)

		if next(mStats) then
			if count > 0 then
				mName = Localize("/Lotus/Language/Stats/Attack1", {})
			end

			table.insert(list, {
				mName = mName,
				mIsMelee = false,
				mBehaviorIndex = p.behaviorIndex,
				mStats = mStats,
				mExtra = true
			})
		end
	end

	for i = 1, count do
		local v6 = v3[i]

		if not (v6:__wf_atom_6386920d():__wf_atom_37799654() > 0) then
			continue
		end

		local mStats2 = {}
		fn18(mStats2, v6, p3, p5, p4, p6)
		table.insert(list, {
			mName = Localize("/Lotus/Language/Stats/Attack" .. i + 1, {}),
			mIsMelee = false,
			mBehaviorIndex = p.behaviorIndex,
			mStats = mStats2,
			mExtra = true
		})
	end

	return v4, v5, mStats
end

local function fn20(_, _) end

local function fn21(object, upgrades)
	for _, v3 in ipairs(upgrades) do
		object:AddUpgrade(v3:__wf_atom_b810064e(), v3:__wf_atom_62831604(), v3:__wf_atom_505b3c0e())
	end
end

local function fn22(object, upgrades)
	for _, v3 in ipairs(upgrades) do
		object:RemoveUpgrade(v3:__wf_atom_b810064e(), v3:__wf_atom_62831604(), v3:__wf_atom_505b3c0e())
	end
end

local function fn23(p, unusedStats)
	for i = 1, #unusedStats do
		p[unusedStats[i]] = nil
	end
end

local function fn24(object)
	local total = 0
	local __wf_atom_37799654 = object:__wf_atom_6386920d():__wf_atom_37799654()

	if __wf_atom_37799654 > 0 then
		for i = 0, 19 do
			if object:__wf_atom_bf612a92(i) > 0 then
				total += object:__wf_atom_bf612a92(i) * __wf_atom_37799654
			end
		end
	end

	return total
end

local function fn25(__wf_atom_b810064e, p, __wf_atom_505b3c0e, object)
	local v3 = ""

	for _ = 1, __wf_atom_505b3c0e / 5 do
		if __wf_atom_b810064e == 258 then
			v3 ..= fn4(0, "<ATTUNEMENT_" .. module3.GetAttributeTypeTag(0) .. ">", true)
		elseif __wf_atom_b810064e == 260 then
			v3 ..= fn4(2, "<ATTUNEMENT_" .. module3.GetAttributeTypeTag(2) .. ">", true)
		elseif __wf_atom_b810064e == 259 then
			v3 ..= fn4(1, "<ATTUNEMENT_" .. module3.GetAttributeTypeTag(1) .. ">", true)
		end
	end

	if v3 ~= "" then
		p.AttuneTypeIncrease = fn6(object:__wf_atom_8e9ac384(v3, true))
		p.AttuneTypeIncrease.SingleLine = true
	end
end

local function fn26(p)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	local v3

	if not __wf_atom_7e8ad928(gGameRules) then
		v3 = gGameRules:__wf_atom_964056fd()
	end

	if __wf_atom_7e8ad928(v3) then
		return nil
	end

	return v3:__wf_atom_232fd31d(p)
end

local function fn27(object, p, object2)
	local __wf_atom_70b880cb = object:__wf_atom_70b880cb(object:__wf_atom_f298d802())

	for _, affixPair in ipairs(__wf_atom_70b880cb.affixPairs) do
		local rounded = tostring(module.Round(affixPair.statValue))

		if affixPair.displayAsPercent then
			rounded ..= "%"
		end

		if affixPair.statValue > 0 then
			rounded = "+" .. rounded
		end

		local v3 = fn6(rounded, affixPair.statValue)
		v3.LocalizedName = affixPair.localizedName
		v3.SmallerIsBetter = affixPair.smallerIsBetter

		if v3.LocalizedName == "/SF/Language/Upgrades/AVATAR_ARMOUR" then
			continue
		end

		p["Stat_" .. v3.LocalizedName] = v3
		AddLabelToStat("Stat_" .. v3.LocalizedName, v3.LocalizedName, v3)
	end

	for i = 1, object:__wf_atom_06f3cb74() do
		local __wf_atom_b9a1f18c = object:__wf_atom_b9a1f18c(i - 1)

		if __wf_atom_7e8ad928(__wf_atom_b9a1f18c) then
			continue
		end

		local __wf_atom_b810064e = __wf_atom_b9a1f18c:__wf_atom_b810064e()
		local __wf_atom_505b3c0e = __wf_atom_b9a1f18c:__wf_atom_505b3c0e()

		if __wf_atom_b810064e == 20 then
			local __wf_atom_7f9e6a1c = __wf_atom_b9a1f18c:__wf_atom_7f9e6a1c()
			local v3 = fn6(nil, __wf_atom_505b3c0e, nil, true)

			if __wf_atom_7f9e6a1c == 21 then
				v3.LocalizedName = "/SF/Language/Upgrades/AVATAR_ARMOUR_PHYSICAL"
			elseif __wf_atom_7f9e6a1c == 25 then
				v3.LocalizedName = "/SF/Language/Upgrades/AVATAR_ARMOUR_MAGICAL"
			end

			p["Stat_" .. v3.LocalizedName] = v3
			AddLabelToStat("Stat_" .. v3.LocalizedName, v3.LocalizedName, v3)
		else
			fn25(__wf_atom_b810064e, p, __wf_atom_505b3c0e, object2)
		end
	end

	local __wf_atom_1def9903 = object:__wf_atom_1def9903()

	for _, v3 in ipairs(__wf_atom_1def9903) do
		if not __wf_atom_7e8ad928(v3) then
			fn25(v3:__wf_atom_b810064e(), p, v3:__wf_atom_505b3c0e(), object2)
		end
	end
end

local function fn28(p, object, p2, data, p3, instance, object2, object3, p4, p5, object4)
	local criticalChance, criticalMultiplier

	if p4 then
		local criticalHitChance = object3.criticalHitChance
		local criticalHitDamageMultiplier = object3.criticalHitDamageMultiplier
		criticalChance = object4:__wf_atom_2a745663(criticalHitChance, 283, object:__wf_atom_1bb5b1ff(), object)
		criticalMultiplier = object4:__wf_atom_2a745663(
			criticalHitDamageMultiplier,
			287,
			object:__wf_atom_1bb5b1ff(),
			object
		)
	elseif p3 then
		local __wf_atom_47ef92e7 = object2:__wf_atom_47ef92e7(p5)
		local __wf_atom_b5729d65 = object:__wf_atom_b5729d65(__wf_atom_47ef92e7)
		local __wf_atom_eb5caed5 = object:__wf_atom_eb5caed5(__wf_atom_47ef92e7)
		criticalChance = object4:__wf_atom_2a745663(__wf_atom_b5729d65, 283, object:__wf_atom_1bb5b1ff(), object)
		criticalMultiplier = object4:__wf_atom_2a745663(__wf_atom_eb5caed5, 287, object:__wf_atom_1bb5b1ff(), object)
	elseif __wf_atom_7e8ad928(p2) then
		criticalChance = object3:__wf_atom_ae118ae6()
		criticalMultiplier = object3:__wf_atom_406dedab()
	else
		criticalChance = data.criticalChance
		criticalMultiplier = data.criticalMultiplier
	end

	local v3 = criticalChance * 100
	p.CriticalChance = fn6(fn12(v3), v3, nil)
	Localize("/Lotus/Language/Menu/WeaponStats_MultipilerStat", {
		STAT = module.FormatNumber(criticalMultiplier, 1)
	})

	if not p5 then
		local ternary = module.Ternary(object2.fireIterations > 1, "ProcChancePerShot", "ProcChance")
		local v4 = math.max(data.baseProcChance * 100, 0)

		if instance:__wf_atom_9ff2a58d() and not instance:IsA(__wf_atom_ef6aee1c) then
			v4 *= object:__wf_atom_bef8f035()
		end

		if v4 > 0 then
			p[ternary] = fn6(fn12(v4), v4, nil)
		end
	end
end

local function fn29(instance, instance2, object, p, __wf_atom_414f70dd, instance3, instance4, isA, p2, p3, p4, p5, p6, p7, __wf_atom_d2b2176d, p8, p9)
	local v3 = nil
	local mStats = {}
	local v4

	if not (isA and p2 or not (object:__wf_atom_6386920d():__wf_atom_37799654() > 0)) then
		fn16(mStats, object, p3, 1, p4)
		fn28(
			mStats,
			instance,
			instance2,
			object,
			p.turboGlaive == true,
			__wf_atom_414f70dd,
			instance3,
			instance4,
			isA,
			p7,
			__wf_atom_d2b2176d
		)
		v4 = {
			mName = Localize(
				module.Ternary(instance3.fireIterations > 1, "/Lotus/Language/Game/DamagePerProjectile", p8),
				{}
			),
			mIsMelee = false,
			mBehaviorIndex = p.behaviorIndex,
			mStats = mStats,
			mExtra = true
		}
	end

	local mStats2 = {}
	local v5, v6

	if instance4:IsA(__wf_atom_e65b2d71) then
		v5 = instance4:__wf_atom_cb093cde(p7)
		v6 = v5:__wf_atom_6386920d():__wf_atom_37799654()
	else
		v6 = 0
	end

	if v6 == 0 then
		if instance3:IsA(__wf_atom_b734e29f) then
			v5 = instance3:__wf_atom_cb093cde(p7)
		else
			v5 = instance:__wf_atom_c34c33a3(false, instance2)
		end

		v6 = v5:__wf_atom_6386920d():__wf_atom_37799654()
	end

	if v6 > 0 then
		local ternary = module.Ternary(
			object.hitType == 2 and instance3:__wf_atom_9a97ee4c() or object.hitType == 4,
			instance4:__wf_atom_8eeba570(true, true),
			1
		)
		fn16(mStats2, v5, p3, p5 * module.Ternary(p7, ternary, 1))
		local v7 = math.max(v5.fallOff * 100, 0)
		mStats2.DamageFallOff = fn6(fn12(v7), v7, nil)
	end

	local v7 = false

	if instance:__wf_atom_1741efdd(instance2) then
		local v8 = {
			WeakResource("/Lotus/Weapons/Corpus/Bow/Longbow/CrpBowArrow"),
			WeakResource("/Lotus/Weapons/Corpus/Bow/Longbow/CrpBowArrowPvP")
		}
		local v9 = false

		for _, className in pairs(v8) do
			if not instance2:IsA(className) then
				continue
			end

			v9 = true
			break
		end

		local __wf_atom_5419c63d = instance:__wf_atom_5419c63d(instance2)
		local __wf_atom_37799654 = __wf_atom_5419c63d:__wf_atom_6386920d():__wf_atom_37799654()

		if __wf_atom_37799654 > 0 then
			local getDamageTypeTag = module2.GetDamageTypeTag

			for i = 0, 19 do
				if not (__wf_atom_5419c63d:__wf_atom_bf612a92(i) > 0) then
					continue
				end

				local damageTypeTag = getDamageTypeTag(i)

				if mStats[i] == nil then
					mStats[damageTypeTag] = fn6(nil, 0, nil)
				end

				mStats[damageTypeTag] = fn14(mStats[damageTypeTag].StatValue + __wf_atom_5419c63d:__wf_atom_bf612a92(i) * __wf_atom_37799654)
			end
		end

		if v6 == 0 or __wf_atom_37799654 > 0 or v9 then
			v5 = instance:__wf_atom_c34c33a3(true, instance2)

			if v5:__wf_atom_6386920d():__wf_atom_37799654() > 0 then
				v7 = true
				fn16(mStats2, v5, p3, 1, nil, "Embed")
				local __wf_atom_ff676b5f = instance:__wf_atom_ff676b5f(instance2)
				local v10

				if __wf_atom_ff676b5f.minValue == __wf_atom_ff676b5f.maxValue then
					v10 = module.FormatNumber(__wf_atom_ff676b5f.minValue, 1)
				else
					v10 = module.FormatNumber(__wf_atom_ff676b5f.minValue, 1) .. " - " .. module.FormatNumber(__wf_atom_ff676b5f.maxValue, 1)
				end

				if v10 ~= nil then
					local __wf_atom_48a8e71b = __wf_atom_ff676b5f:__wf_atom_48a8e71b(0.5)

					if __wf_atom_48a8e71b > 0 then
						mStats2.EmbedDelay = fn6(v10, __wf_atom_48a8e71b, nil)
					end
				end

				local v11 = math.max(v5.fallOff * 100, 0)
				mStats2.EmbedFallOff = fn6(fn12(v11), v11, nil)
			end
		end
	end

	if next(mStats2) then
		mStats2.Range = fn6(
			module.FormatNumber(v5.radius, 2),
			v5.radius,
			nil,
			nil,
			module.Ternary(isA, "MeleeRange", "AoERange")
		)
		fn17(mStats2, p3, p6, module.Ternary(v7, "Embed", nil))
		fn28(
			mStats2,
			instance,
			instance2,
			v5,
			p.turboGlaive == true,
			__wf_atom_414f70dd,
			instance3,
			instance4,
			isA,
			p7,
			__wf_atom_d2b2176d
		)
		v3 = {
			mName = Localize(p9, {}),
			mIsMelee = isA,
			mBehaviorIndex = p.behaviorIndex,
			mStats = mStats2,
			mExtra = true
		}
	end

	local v8 = 1

	if isA then
		if not p2 then
			v8 = p6
		end
	else
		v8 = p6
	end

	fn17(mStats, p3, v8)
	return v4, v3
end

local function fn30(object, object2, _, data)
	if
		__wf_atom_7e8ad928(data.PhysicalArmor)
		and __wf_atom_7e8ad928(data.MagicalArmor)
		and __wf_atom_7e8ad928(data.StabilityArmor)
	then
		return
	end

	for k, v3 in pairs({
		PhysicalArmor = "STAT_ARMOR_PHYSICAL",
		MagicalArmor = "STAT_ARMOR_MAGICAL",
		StabilityArmor = "STAT_ARMOR_STABILITY"
	}) do
		if not __wf_atom_7e8ad928(data[k]) then
			continue
		end

		local v4 = fn6(nil, 0, nil, true)

		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384("/SF/Language/Armour/" .. v3, true, {
				AMOUNT = v4.StatValue
			})
			object2:__wf_atom_a2652e26()
			v4.DisplayValue = __wf_atom_8e9ac384
		end

		data[k] = v4
	end
end

local function fn31(mMovie, instance, _)
	local mStats = {
		Rarity = fn6(mMovie:__wf_atom_8e9ac384(
			"/SF/Language/Menu/Rarity_" .. module3.GetRarityTag(instance:__wf_atom_a8dac107()),
			false
		))
	}
	fn27(instance, mStats, mMovie)
	return {
		{ mStats = mStats, mName = "" }
	}
end

local v3 = {
	[0] = {
		DisplayName = "/SF/Language/Armour/STAT_ARMOR_PHYSICAL",
		StatName = "PhysicalArmor",
		StatLoc = "/Lotus/Language/Labels/AVATAR_ARMOUR_PHYSICAL"
	},
	[1] = {
		DisplayName = "/SF/Language/Armour/STAT_ARMOR_MAGICAL",
		StatName = "MagicalArmor",
		StatLoc = "/Lotus/Language/Labels/AVATAR_ARMOUR_MAGICAL"
	},
	[2] = {
		DisplayName = "/SF/Language/Armour/STAT_ARMOR_STABILITY",
		StatName = "StabilityArmor",
		StatLoc = "/Lotus/Language/Labels/AVATAR_ARMOUR_STABILITY"
	}
}

local function fn32(mMovie, instance, instance2)
	local mStats = {}
	local mStats2 = {}
	local v4 = {}
	local flag = false

	for i = 1, instance:__wf_atom_06f3cb74() do
		local __wf_atom_b9a1f18c = instance:__wf_atom_b9a1f18c(i - 1)

		if __wf_atom_7e8ad928(__wf_atom_b9a1f18c) then
			continue
		end

		local __wf_atom_b810064e = __wf_atom_b9a1f18c:__wf_atom_b810064e()
		local __wf_atom_505b3c0e = __wf_atom_b9a1f18c:__wf_atom_505b3c0e()

		if __wf_atom_b810064e == 21 then
			mStats.CourageIncrease = fn6("+" .. __wf_atom_505b3c0e, __wf_atom_505b3c0e, nil, true)
			flag = true
		elseif __wf_atom_b810064e == 23 then
			mStats.GraceIncrease = fn6("+" .. __wf_atom_505b3c0e, __wf_atom_505b3c0e, nil, true)
			flag = true
		elseif __wf_atom_b810064e == 22 then
			mStats.SpiritIncrease = fn6("+" .. __wf_atom_505b3c0e, __wf_atom_505b3c0e, nil, true)
			flag = true
		elseif __wf_atom_b810064e == 456 then
			mStats.StabilityDamage = fn6("+" .. __wf_atom_505b3c0e, __wf_atom_505b3c0e, nil, true)
			flag = true
		elseif __wf_atom_b810064e == 366 then
			mStats.Total = fn6("+" .. __wf_atom_505b3c0e, __wf_atom_505b3c0e, nil, true)
			flag = true
		end
	end

	local v5 = 0

	if instance:__wf_atom_5b84e5ae() then
		for i = 0, 2 do
			local __wf_atom_4dbc3979 = instance:__wf_atom_4dbc3979(i)

			if not (__wf_atom_4dbc3979 > 0) then
				continue
			end

			local attributeTypeTag = module3.GetAttributeTypeTag(i)
			local formatNumber = module.FormatNumber(__wf_atom_4dbc3979, 0)

			if not __wf_atom_7e8ad928(instance2) then
				local formatNumber2 = module.FormatNumber(instance2:GetAttribute(i, true), 0)

				if not instance:__wf_atom_a2652e26() then
					formatNumber2 = fn(formatNumber2)
				end

				formatNumber = formatNumber2 .. "/" .. formatNumber
			end

			local v6 = mMovie:__wf_atom_8e9ac384(fn4(i, "<ATTUNEMENT_" .. attributeTypeTag .. ">", true), true) .. formatNumber
			mStats2["Requirement_" .. attributeTypeTag] = fn6(v6)
			AddLabelToStat(
				"Requirement_" .. attributeTypeTag,
				mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/VirtueRequirement", false),
				mStats2["Requirement_" .. attributeTypeTag]
			)
			mStats2["Requirement_" .. attributeTypeTag].SingleLine = true
			mStats2["Requirement_" .. attributeTypeTag].Order = 4
			v5 = i
		end
	end

	for i = 0, 2 do
		local v6 = v3[i]
		local __wf_atom_aa820a9e = instance:__wf_atom_aa820a9e(instance2, i, true)
		local __wf_atom_aa820a9e2 = instance:__wf_atom_aa820a9e(instance2, i, false)

		if __wf_atom_aa820a9e <= 0 then
			continue
		end

		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v6.DisplayName, true, {
			AMOUNT = fn13(__wf_atom_aa820a9e, __wf_atom_aa820a9e - __wf_atom_aa820a9e2)
		})
		instance:__wf_atom_a2652e26()
		local v7 = fn6(__wf_atom_8e9ac384, __wf_atom_aa820a9e, nil, true)
		mStats2[v6.StatName] = v7
	end

	fn30(mMovie, instance, instance2, mStats2)

	if instance:__wf_atom_bbd8a30c() then
		local v6 = {}

		for i = 0, 2 do
			if i == v5 then
				table.insert(v6, 1, i)
			else
				table.insert(v6, i)
			end
		end

		for i = 0, 2 do
			local v7 = v3[i]
			local v8 = ""

			for _, v9 in ipairs(v6) do
				local __wf_atom_4900a295 = instance:__wf_atom_4900a295(i, v9)
				local v10 = fn4(
					v9,
					"<ATTUNEMENT_" .. module3.GetAttributeTypeTag(v9) .. ">",
					instance:__wf_atom_a2652e26()
				)

				for _ = 1, __wf_atom_4900a295 do
					v8 ..= v10
				end
			end

			local v9 = mMovie:__wf_atom_8e9ac384(v7.StatLoc, false) .. " " .. mMovie:__wf_atom_8e9ac384(v8, true)
			AddLabelToStat(v7.StatName, v9, mStats2[v7.StatName])
			mStats2[v7.StatName].SingleLine = true
		end
	end

	if not __wf_atom_7e8ad928(mStats2.PhysicalArmor) then
		mStats2.PhysicalArmor.Order = 5
	end

	if not __wf_atom_7e8ad928(mStats2.MagicalArmor) then
		mStats2.MagicalArmor.Order = 6
	end

	if not __wf_atom_7e8ad928(mStats2.StabilityArmor) then
		mStats2.StabilityArmor.Order = 7
	end

	v4[1] = { mStats = mStats2, mForceHeader = false }
	__wf_atom_7e8ad928(mMovie)

	if flag then
		v4[2] = { mStats = mStats, mForceHeader = false }
	end

	return v4
end

local function fn33(mMovie, instance, instance2, p, p2, p3, p4, p5)
	if __wf_atom_7e8ad928(instance2) then
		instance2 = module2.GetMainMenuSuitAvatar()
	end

	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(instance2) then
		return nil
	end

	local result = {}
	local v4 = p == nil and 1 or p

	if instance:IsA(__wf_atom_d560b05c) then
		local __wf_atom_42fd8000 = instance:__wf_atom_42fd8000(instance2)

		if not __wf_atom_7e8ad928(__wf_atom_42fd8000) then
			if __wf_atom_1ef90898(__wf_atom_42fd8000) then
				__wf_atom_42fd8000 = Resource(__wf_atom_42fd8000)
			end

			instance = __wf_atom_42fd8000
		end
	end

	if p5 then
		instance:__wf_atom_88686970(true)

		if _T.mMechaSuitMode then
			instance:__wf_atom_ecdda74a(true)
			instance:__wf_atom_ea0d0533(1)
		else
			instance:__wf_atom_ea0d0533(instance:__wf_atom_9d460cf1())
		end
	end

	local getDamageTypeTag = module2.GetDamageTypeTag
	local __wf_atom_d2b2176d = instance2:__wf_atom_d2b2176d()
	local __wf_atom_8c704207 = instance:__wf_atom_8c704207()
	local __wf_atom_ca3e110b = instance:__wf_atom_ca3e110b()
	local v5 = false
	local v6

	if __wf_atom_7e8ad928(__wf_atom_8c704207) or #__wf_atom_8c704207 == 0 then
		v6 = {
			{ localizedTag = "", behaviorIndex = 0 }
		}
	else
		v6 = {}

		for _, v7 in ipairs(__wf_atom_8c704207) do
			table.insert(v6, { localizedTag = v7.localizedTag, behaviorIndex = v7.behaviorIndex })
		end
	end

	if not instance2:IsA(__wf_atom_ee1ed4db) then
		for _, scriptedFireMode in ipairs(_T.ScriptedFireModes) do
			if instance:__wf_atom_0395f752() == scriptedFireMode.weaponSlot then
				table.insert(v6, scriptedFireMode)
			end
		end

		if instance:__wf_atom_4105e180() then
			local v7 = WeakResource("/SF/Types/Weapon/GlaiveProjectileFireBehavior")

			for i = 0, __wf_atom_ca3e110b - 1 do
				if not instance:__wf_atom_3d08948b(i):IsA(v7) then
					continue
				end

				v5 = true

				for j = 1, #v6 do
					if v6[j].behaviorIndex ~= i then
						continue
					end

					v6[j].turboGlaive = false
					table.insert(v6, {
						localizedTag = "/Lotus/Language/Menu/Loadout_FireModeTurboThrow",
						behaviorIndex = i,
						turboGlaive = true
					})
					break
				end

				break
			end
		end
	end

	for i, v7 in ipairs(v6) do
		if __wf_atom_ca3e110b <= v7.behaviorIndex then
			print("Error: Invalid fire mode behavior index for weapon " .. instance:GetName() .. " fireMode index = " .. tostring(i))
			break
		end

		fn21(__wf_atom_d2b2176d, v7.upgrades)
		local __wf_atom_414f70dd = instance:__wf_atom_414f70dd(v7.behaviorIndex)
		local __wf_atom_3d08948b = instance:__wf_atom_3d08948b(v7.behaviorIndex)
		local __wf_atom_010c2f81 = instance:__wf_atom_010c2f81(v7.behaviorIndex)
		instance:SetBehavior(v7.behaviorIndex)
		local v8 = instance:__wf_atom_e5141e5b() and __wf_atom_010c2f81:IsA(__wf_atom_6256a119)
		local isA = __wf_atom_414f70dd:IsA(WeakResource("/EE/Types/Game/WeaponMeleeStateBehavior"))
		local mStats = {}
		table.insert(result, {
			mName = mMovie:__wf_atom_8e9ac384(v7.localizedTag, false),
			mIsMelee = isA,
			mBehaviorIndex = v7.behaviorIndex,
			mStats = mStats
		})
		__wf_atom_3d08948b:__wf_atom_0dffbe49(1)

		if not v8 then
			local c_str = __wf_atom_414f70dd:__wf_atom_4f3855f9():c_str()
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(c_str, false)

			if __wf_atom_8e9ac384 ~= "" then
				local v9 = StringSplit("/", c_str)
				mStats.Trigger = fn6(__wf_atom_8e9ac384, nil, true, nil, (string.gsub(v9[#v9], "Loadout_", "")))
			end

			if __wf_atom_3d08948b:IsA(WeakResource("/SF/Types/Game/SFWeaponProjectileFireBehavior")) then
				local __wf_atom_d7c428fd = __wf_atom_3d08948b:__wf_atom_d7c428fd()
				local __wf_atom_9741f03e = __wf_atom_3d08948b:__wf_atom_9741f03e()

				if __wf_atom_d7c428fd ~= 0 or __wf_atom_9741f03e ~= 0 then
					mStats.DT_StackDamage = fn6(
						module.FormatNumber(__wf_atom_d7c428fd) .. " - " .. module.FormatNumber(__wf_atom_9741f03e),
						__wf_atom_d7c428fd,
						nil
					)
				end
			end

			local v9 = __wf_atom_d2b2176d:__wf_atom_2a745663(1, 383, instance:__wf_atom_1bb5b1ff(), instance) == 0
			local __wf_atom_37823495 = instance:__wf_atom_37823495()
			local __wf_atom_1cda18ff = __wf_atom_3d08948b:__wf_atom_1cda18ff()
			local v10 = false

			if not __wf_atom_7e8ad928(__wf_atom_1cda18ff) then
				local v11 = Resource(__wf_atom_1cda18ff)

				if not __wf_atom_7e8ad928(v11) then
					v10 = v11:__wf_atom_c604a6ce()
				end
			end

			mStats.Noise = fn6(
				mMovie:__wf_atom_8e9ac384(
					module.Ternary(
						__wf_atom_37823495 or v10 or v9,
						"/Lotus/Language/Labels/WEAPON_NOISEQUIET",
						"/Lotus/Language/Labels/WEAPON_NOISELOUD"
					),
					false
				),
				nil,
				true
			)
		end

		local v9 = v7.ignoreMultishot and 1 or __wf_atom_3d08948b:__wf_atom_9c30c762()
		local v10 = nil
		local v11 = nil
		local v12 = false
		local v13 = nil
		local v14 = nil
		local v15 = false
		local v16 = 1
		local __wf_atom_9ed189b9 = instance:__wf_atom_9ed189b9()

		if __wf_atom_414f70dd:IsA(WeakResource("/EE/Types/Game/WeaponChargedStateBehavior")) then
			instance:__wf_atom_6f32f2cb(instance:__wf_atom_2c6db744(p3))
			__wf_atom_414f70dd:__wf_atom_26a4fa9a(0)

			if instance:__wf_atom_ed08f97f() then
				v16 = __wf_atom_414f70dd:__wf_atom_5fec577f()
			end

			if __wf_atom_414f70dd:__wf_atom_e50a94ab() ~= 1 then
				__wf_atom_414f70dd:__wf_atom_c2d9fb01(1)
				local v17, v18 = fn15(instance, v7, __wf_atom_3d08948b, p3)
				v10, v11 = fn29(
					instance,
					v17,
					v18,
					v7,
					__wf_atom_414f70dd,
					__wf_atom_3d08948b,
					__wf_atom_010c2f81,
					isA,
					v8,
					false,
					p2,
					v4,
					v9,
					p3,
					__wf_atom_d2b2176d,
					"/Lotus/Language/Stats/QuickShot",
					"/Lotus/Language/Stats/QuickShotRadialAttack"
				)
				v12 = v10 ~= nil or v11 ~= nil

				if __wf_atom_3d08948b:IsA(__wf_atom_c38f5238) then
					local __wf_atom_16441e0e = __wf_atom_3d08948b:__wf_atom_16441e0e()

					if not __wf_atom_7e8ad928(__wf_atom_16441e0e) then
						local v19 = Resource(__wf_atom_16441e0e)

						if not __wf_atom_7e8ad928(v19) then
							v13, v14 = fn29(
								instance,
								v19,
								instance:__wf_atom_0590ad17(v19, 0, v7.behaviorIndex),
								v7,
								__wf_atom_414f70dd,
								__wf_atom_3d08948b,
								__wf_atom_010c2f81,
								isA,
								v8,
								false,
								p2,
								v4,
								v9,
								p3,
								__wf_atom_d2b2176d,
								"/Lotus/Language/Stats/PerfectShot",
								"/Lotus/Language/Stats/PerfectShotRadialAttack"
							)
							v15 = v13 ~= nil or v14 ~= nil
						end
					end
				end
			end

			instance:__wf_atom_a8d5451f()
			local __wf_atom_7eff92f0 = instance:__wf_atom_7eff92f0()

			if __wf_atom_9ed189b9 <= 0 and not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
				__wf_atom_9ed189b9 = __wf_atom_d2b2176d:__wf_atom_2a745663(
					1,
					315,
					instance:__wf_atom_1bb5b1ff(),
					instance
				)
			end

			mStats.ChargeRate = fn6(module.FormatNumber(__wf_atom_7eff92f0, 2), -__wf_atom_7eff92f0, nil)
		elseif __wf_atom_414f70dd:IsA(WeakResource("/EE/Types/Game/WeaponBurstStateBehavior")) then
			instance:__wf_atom_6f32f2cb(instance:__wf_atom_2c6db744(p3))
			__wf_atom_9ed189b9 = instance:__wf_atom_083a9e64():__wf_atom_326098b8()
		end

		if v12 then
			table.insert(result, v10)
		end

		if v11 ~= nil then
			table.insert(result, v11)
		end

		local v17 = __wf_atom_3d08948b.fireIterations > 1 and "/Lotus/Language/Game/DamagePerProjectile"
			or v12 and "/Lotus/Language/Stats/ChargedShot"
			or "/Lotus/Language/Labels/WEAPON_DAMAGE_AMOUNT"
		local v18, v19, mStats2 = fn19(
			instance,
			v7,
			__wf_atom_3d08948b,
			p3,
			false,
			v9,
			v16,
			p2,
			result,
			isA and v8,
			Localize(v17, {})
		)
		local v20 = Resource(v18)
		local ternary = module.Ternary(
			v19.hitType == 2 and __wf_atom_3d08948b:__wf_atom_9a97ee4c() or v19.hitType == 4,
			__wf_atom_010c2f81:__wf_atom_8eeba570(true, true),
			1
		)

		if p3 and not v8 then
			local v21 = 1 + 1 * instance:__wf_atom_4d0c6b2c()
			mStats.HeadShotMult = fn6(
				Localize("/Lotus/Language/Menu/WeaponStats_MultipilerStat", {
					STAT = module.FormatNumber(v21, 1)
				}),
				v21,
				nil
			)
		end

		if v9 ~= 1 then
			mStats.Multishot = fn6(module.FormatNumber(v9, 1), v9)
		end

		local __wf_atom_5419c63d = instance:__wf_atom_5419c63d(v20)
		local __wf_atom_37799654 = __wf_atom_5419c63d:__wf_atom_6386920d():__wf_atom_37799654()

		if __wf_atom_37799654 > 0 then
			for j = 0, 19 do
				if not (__wf_atom_5419c63d:__wf_atom_bf612a92(j) > 0) then
					continue
				end

				local damageTypeTag = getDamageTypeTag(j)

				if mStats2[damageTypeTag] == nil then
					mStats2[damageTypeTag] = fn6(nil, 0, nil)
				end

				mStats2[damageTypeTag] = fn14(mStats2[damageTypeTag].StatValue + __wf_atom_5419c63d:__wf_atom_bf612a92(j) * __wf_atom_37799654)
			end
		end

		local mStats3 = {}
		local v21 = 0
		local v22 = nil
		local v23 = v7.turboGlaive == nil

		if not v23 then
			local v24 = __wf_atom_d2b2176d:__wf_atom_2a745663(
				v20:__wf_atom_9d5805d7(),
				434,
				instance:__wf_atom_1bb5b1ff(),
				instance
			) * 100
			v23 = v24 > 0

			if v23 and v24 < 100 then
				mStats3.BounceChance = fn6(fn12(v24), v24, nil)
			end
		end

		if v23 then
			if __wf_atom_010c2f81:IsA(__wf_atom_e65b2d71) then
				v22 = __wf_atom_010c2f81:__wf_atom_cb093cde(p3)
				v21 = v22:__wf_atom_6386920d():__wf_atom_37799654()
			end

			if v21 == 0 then
				if __wf_atom_3d08948b:IsA(__wf_atom_b734e29f) then
					v22 = __wf_atom_3d08948b:__wf_atom_cb093cde(p3)
				else
					v22 = instance:__wf_atom_c34c33a3(false, v20)
				end

				v21 = v22:__wf_atom_6386920d():__wf_atom_37799654()
			end
		end

		if v21 > 0 then
			fn16(mStats3, v22, false, v4 * module.Ternary(p3, ternary, 1))
			local v24 = math.max(v22.fallOff * 100, 0)
			mStats3.DamageFallOff = fn6(fn12(v24), v24, nil)
		end

		local v24 = false

		if instance:__wf_atom_1741efdd(v20) then
			local v25 = {
				WeakResource("/Lotus/Weapons/Corpus/Bow/Longbow/CrpBowArrow"),
				WeakResource("/Lotus/Weapons/Corpus/Bow/Longbow/CrpBowArrowPvP")
			}
			local v26 = false

			for _, className in pairs(v25) do
				if not v20:IsA(className) then
					continue
				end

				v26 = true
				break
			end

			local __wf_atom_5419c63d2 = instance:__wf_atom_5419c63d(v20)
			local __wf_atom_37799654_2 = __wf_atom_5419c63d2:__wf_atom_6386920d():__wf_atom_37799654()

			if __wf_atom_37799654_2 > 0 then
				for j = 0, 19 do
					if not (__wf_atom_5419c63d2:__wf_atom_bf612a92(j) > 0) then
						continue
					end

					local damageTypeTag = getDamageTypeTag(j)

					if mStats2[j] == nil then
						mStats2[damageTypeTag] = fn6(nil, 0, nil)
					end

					mStats2[damageTypeTag] = fn14(mStats2[damageTypeTag].StatValue + __wf_atom_5419c63d2:__wf_atom_bf612a92(j) * __wf_atom_37799654_2)
				end
			end

			if v21 == 0 or __wf_atom_37799654 > 0 or v26 then
				v22 = instance:__wf_atom_c34c33a3(true, v20)

				if v22:__wf_atom_6386920d():__wf_atom_37799654() > 0 then
					v24 = true
					fn16(mStats3, v22, false, v4 * module.Ternary(p3, ternary, 1), nil, "Embed")
					local __wf_atom_ff676b5f = instance:__wf_atom_ff676b5f(v20)
					local v27

					if __wf_atom_ff676b5f.minValue == __wf_atom_ff676b5f.maxValue then
						v27 = module.FormatNumber(__wf_atom_ff676b5f.minValue, 1)
					else
						v27 = module.FormatNumber(__wf_atom_ff676b5f.minValue, 1) .. " - " .. module.FormatNumber(__wf_atom_ff676b5f.maxValue, 1)
					end

					if v27 ~= nil then
						local __wf_atom_48a8e71b = __wf_atom_ff676b5f:__wf_atom_48a8e71b(0.5)

						if __wf_atom_48a8e71b > 0 then
							mStats3.EmbedDelay = fn6(v27, __wf_atom_48a8e71b, nil)
						end
					end

					local v28 = math.max(v22.fallOff * 100, 0)
					mStats3.EmbedFallOff = fn6(fn12(v28), v28, nil)
				end
			end
		end

		if next(mStats3) then
			mStats3.Range = fn6(
				module.FormatNumber(v22.radius, 2),
				v22.radius,
				nil,
				nil,
				module.Ternary(isA, "MeleeRange", "AoERange")
			)
			fn17(mStats3, false, v9, module.Ternary(v24, "Embed", nil))
			table.insert(result, {
				mName = mMovie:__wf_atom_8e9ac384(
					v7.turboGlaive ~= nil and "/Lotus/Language/Labels/AVATAR_BOUNCE_ATTACK" or v12 and "/Lotus/Language/Stats/ChargedRadialAttack" or "/Lotus/Language/Labels/AVATAR_RADIAL_ATTACK",
					false
				),
				mIsMelee = isA,
				mBehaviorIndex = v7.behaviorIndex,
				mStats = mStats3,
				mExtra = true
			})
		end

		local __wf_atom_693aebd2 = __wf_atom_3d08948b:__wf_atom_693aebd2()

		if
			__wf_atom_414f70dd:__wf_atom_9ff2a58d()
			and not __wf_atom_414f70dd:IsA(__wf_atom_ef6aee1c)
			and __wf_atom_693aebd2 > 0
		then
			local v25 = __wf_atom_9ed189b9 / __wf_atom_693aebd2

			for j = 0, 19 do
				if mStats2[getDamageTypeTag(j)] ~= nil then
					mStats2[getDamageTypeTag(j)] = fn14(mStats2[getDamageTypeTag(j)].StatValue * v25)
				end
			end

			fn17(mStats3, false, v9)
			__wf_atom_9ed189b9 = __wf_atom_693aebd2
			__wf_atom_693aebd2 = 1
		end

		if __wf_atom_3d08948b:__wf_atom_6515c58a() then
			mStats.EnergyPool = fn6(nil, instance2:__wf_atom_9ec4c360(), nil)
			local __wf_atom_cc34a29a = __wf_atom_3d08948b:__wf_atom_cc34a29a()

			if __wf_atom_414f70dd:__wf_atom_9ff2a58d() then
				local v25 = __wf_atom_cc34a29a * 100 * 3
				mStats.EnergyPerSecond = fn6(module.FormatNumber(v25) .. "/s", -v25, nil)
			else
				mStats.EnergyPerShot = fn6(module.FormatNumber(__wf_atom_cc34a29a), -__wf_atom_cc34a29a, nil)
			end
		else
			local rounded = module.Round(instance:__wf_atom_2c6db744(p3))

			if rounded > 0 then
				mStats.Mag = fn6(nil, rounded, nil)
				mStats.AmmoReq = fn6(module.FormatNumber(__wf_atom_693aebd2), -__wf_atom_693aebd2, nil)
			end
		end

		if not v8 and p3 then
			local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(
				instance:__wf_atom_adc1a4dd(p3),
				254,
				instance:__wf_atom_180bd4bb()
			)

			if not p3 then
				__wf_atom_2a745663 = math.floor(__wf_atom_2a745663) + instance:GetClipSize()
			end

			if __wf_atom_2a745663 > 0 then
				mStats.MaxAmmo = fn6(nil, __wf_atom_2a745663, nil)
			end
		end

		if v7.turboGlaive == nil then
			local v25 = __wf_atom_9ed189b9 < 1 and 3 or 2

			if v8 and isA then
				mStats.FireRateMelee = fn6(module.FormatNumber(__wf_atom_9ed189b9, v25), __wf_atom_9ed189b9, nil)
			else
				mStats.FireRate = fn6(module.FormatNumber(__wf_atom_9ed189b9, v25), __wf_atom_9ed189b9, nil)
			end
		end

		math.min(
			__wf_atom_c67f9605:__wf_atom_7da755e9(instance:__wf_atom_1bb5b1ff(), 0),
			__wf_atom_c67f9605:__wf_atom_b4a75eaa(instance:__wf_atom_9765cbd5(), instance:__wf_atom_1bb5b1ff())
		)

		if v8 and isA then
			local v25 = Resource(instance:__wf_atom_c45b4ac3())

			if not __wf_atom_7e8ad928(v25) and v25:IsA(__wf_atom_cdd2dd31) then
				local v26 = fn26(v25)

				if not __wf_atom_7e8ad928(v26) then
					local __wf_atom_ab9ebfce = v26:__wf_atom_ab9ebfce()

					if __wf_atom_ab9ebfce == EMPTY_SYMBOL then
						mStats.MeleeSkill = fn6(mMovie:__wf_atom_8e9ac384(v25:__wf_atom_014a76a2():c_str(), false))
					else
						mStats.MeleeSkill = fn6(mMovie:__wf_atom_8e9ac384(__wf_atom_ab9ebfce:c_str(), false))
						mStats.MeleeSkill.SingleLine = true
					end
				end
			end
		end

		for j = 0, 19 do
			local damageTypeTag = getDamageTypeTag(j)

			if mStats2[damageTypeTag] ~= nil then
				mStats2[damageTypeTag] = fn14(mStats2[damageTypeTag].StatValue * v4 * module.Ternary(p3, ternary, 1))
			end
		end

		fn28(
			mStats2,
			instance,
			v20,
			v19,
			v7.turboGlaive == true,
			__wf_atom_414f70dd,
			__wf_atom_3d08948b,
			__wf_atom_010c2f81,
			isA,
			p3,
			__wf_atom_d2b2176d
		)
		local v25 = 0

		if v8 then
			if isA then
				local __wf_atom_3c0505c6 = __wf_atom_010c2f81:__wf_atom_3c0505c6()
				local __wf_atom_37799654_2 = __wf_atom_3c0505c6:__wf_atom_6386920d():__wf_atom_37799654()
				local __wf_atom_ae4f866b = __wf_atom_010c2f81:__wf_atom_ae4f866b(false, false, false)
				v25 = __wf_atom_37799654_2 - __wf_atom_ae4f866b

				if __wf_atom_37799654_2 > 0 then
					local v26 = -1
					local v27 = nil

					for j = 0, 19 do
						if not (__wf_atom_3c0505c6:__wf_atom_bf612a92(j) > 0) then
							continue
						end

						local __wf_atom_bf612a92 = __wf_atom_3c0505c6:__wf_atom_bf612a92(j)

						if v26 <= __wf_atom_bf612a92 then
							v27 = getDamageTypeTag(j)
							v26 = __wf_atom_bf612a92
						end

						local v28 = __wf_atom_bf612a92 * __wf_atom_37799654_2 * v9
						mStats2[getDamageTypeTag(j)] = fn14(v28)
					end

					if not __wf_atom_7e8ad928(v27) then
						mStats.DamageType = fn6(mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/" .. v27, false))
					end

					local v28 = instance:__wf_atom_1bb5b1ff() == WeakResource("/SF/Weapons/Melee/TwoHand/MotherCorruptedGreatSword/MotherCorruptedGreatSwordMeleeWeapon")

					if instance:IsA(__wf_atom_9df43583) then
						local __wf_atom_d1a2145d = instance:__wf_atom_d1a2145d()

						if __wf_atom_d1a2145d > 0 then
							mStats.RequiredLevel = fn6(module.FormatNumber(__wf_atom_d1a2145d, 0), __wf_atom_d1a2145d)
						end

						local v29 = 0

						if instance:__wf_atom_5b84e5ae() then
							for j = 0, 2 do
								local __wf_atom_4dbc3979 = instance:__wf_atom_4dbc3979(j)

								if not (__wf_atom_4dbc3979 > 0) then
									continue
								end

								local attributeTypeTag = module3.GetAttributeTypeTag(j, v28)
								local formatNumber = module.FormatNumber(__wf_atom_4dbc3979, 0)
								local attribute = instance2:GetAttribute(j, true)
								local formatNumber2 = module.FormatNumber(attribute, 0)

								if attribute < __wf_atom_4dbc3979 then
									formatNumber2 = fn(formatNumber2)
								end

								local v30 = formatNumber2 .. "/" .. formatNumber
								local v31 = mMovie:__wf_atom_8e9ac384(
									fn4(j, "<ATTUNEMENT_" .. attributeTypeTag .. ">", true),
									true
								) .. v30
								mStats["Requirement_" .. attributeTypeTag] = fn6(v31)
								mStats["Requirement_" .. attributeTypeTag].SingleLine = true
								v29 = j
							end
						end

						local v30 = false
						local v31 = ""
						local v32 = nil

						for j = 1, instance:__wf_atom_06f3cb74() do
							local __wf_atom_b9a1f18c = instance:__wf_atom_b9a1f18c(j - 1)

							if
								__wf_atom_7e8ad928(__wf_atom_b9a1f18c)
								or not __wf_atom_b9a1f18c:IsA(__wf_atom_16cdad3a)
							then
								continue
							end

							for k = 1, __wf_atom_b9a1f18c:__wf_atom_06f3cb74() do
								local __wf_atom_b9a1f18c2 = __wf_atom_b9a1f18c:__wf_atom_b9a1f18c(k - 1)

								if __wf_atom_7e8ad928(__wf_atom_b9a1f18c2) then
									continue
								end

								local __wf_atom_b810064e = __wf_atom_b9a1f18c2:__wf_atom_b810064e()

								for _ = 1, __wf_atom_b9a1f18c2:__wf_atom_505b3c0e() / 5 do
									if __wf_atom_b810064e == 258 then
										v32 = 0
									elseif __wf_atom_b810064e == 260 then
										v32 = 2
									elseif __wf_atom_b810064e == 259 then
										v32 = 1
									end
								end
							end
						end

						if instance:__wf_atom_bbd8a30c() then
							local v36 = {}

							for j = 0, 2 do
								if j == v29 then
									table.insert(v36, 1, j)
								else
									table.insert(v36, j)
								end
							end

							local v37 = false

							for _, v38 in ipairs(v36) do
								local v39 = ""
								v30 = v30 or v37
								v37 = false
								local __wf_atom_4900a295 = instance:__wf_atom_4900a295(v38)

								if v2[#v2] <= __wf_atom_4900a295 then
									if v30 then
										v31 ..= "\r\n"
									end

									if instance:__wf_atom_a2652e26() then
										v39 = "<ATTUNEMENT_MAX_" .. module3.GetAttributeTypeTag(v38, nil) .. ">"
									else
										v39 = "<ATTUNEMENT_MAX_" .. module3.GetAttributeTypeTag(v38, nil) .. "_GRAY>"
									end

									instance:__wf_atom_a2652e26()
									v37 = true
								else
									local v40 = false

									for _, v41 in ipairs(v2) do
										if not (v41 <= __wf_atom_4900a295) then
											continue
										end

										if v30 and not v40 then
											v31 ..= "\r\n"
											v40 = true
										end

										if not v37 then
											instance:__wf_atom_a2652e26()
										end

										v39 ..= fn4(
											v38,
											"<ATTUNEMENT_" .. module3.GetAttributeTypeTag(v38, v28) .. ">",
											instance:__wf_atom_a2652e26(),
											v28
										)
										v37 = true
									end
								end

								if v38 == v32 then
									v39 = "<STATS_JOINERY>" .. v39
								end

								v31 ..= v39
							end

							if v31 then
								mStats.AttuneType = fn6(mMovie:__wf_atom_8e9ac384(v31, true))
								mStats.AttuneType.SingleLine = true
							end
						end
					end

					mStats.Rarity = fn6(mMovie:__wf_atom_8e9ac384(
						"/SF/Language/Menu/Rarity_" .. module3.GetRarityTag(instance:__wf_atom_a8dac107()),
						false
					))
					local __wf_atom_966277ef = instance:__wf_atom_966277ef()
					mStats.Quality = fn6(fn3(mMovie, __wf_atom_966277ef), __wf_atom_966277ef)
					local __wf_atom_9b053089 = instance:__wf_atom_9b053089()
					local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
						"/SF/Language/Menu/Origin_" .. __wf_atom_9b053089,
						false
					)
					local v29

					if __wf_atom_9b053089 == "" or __wf_atom_9b053089 == "NONE" then
						v29 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/NoFaction", false)
					else
						v29 = mMovie:__wf_atom_8e9ac384("<WEAPON_FACTION_" .. __wf_atom_9b053089 .. ">", true) .. __wf_atom_8e9ac384
					end

					mStats.Origin = fn6(v29)
					local v30 = false

					for j = 1, instance:__wf_atom_06f3cb74() do
						local __wf_atom_b9a1f18c = instance:__wf_atom_b9a1f18c(j - 1)

						if __wf_atom_7e8ad928(__wf_atom_b9a1f18c) or not __wf_atom_b9a1f18c:IsA(__wf_atom_16cdad3a) then
							continue
						end

						local __wf_atom_2ed09791 = __wf_atom_b9a1f18c:__wf_atom_2ed09791(__wf_atom_b9a1f18c:__wf_atom_f298d802())

						if #__wf_atom_2ed09791 > 0 then
							local freeformPayload = {
								Title = {},
								Desc = {},
								Faction = {},
								AmpLevel = {}
							}
							local v31 = ""

							for _, v32 in __wf_atom_2ed09791 do
								table.insert(freeformPayload.Title, v32.mTitle)
								table.insert(freeformPayload.Desc, v32.mDesc)
								table.insert(
									freeformPayload.Faction,
									v32.mFaction == EMPTY_SYMBOL and "" or v32.mFaction:c_str()
								)
								table.insert(freeformPayload.AmpLevel, v32.mAmpLevel == nil and 1 or v32.mAmpLevel)
								v31 ..= v32.mIconName .. ","
							end

							mStats.Aspects = fn6(v31)
							mStats.Aspects.IconValue = true
							mStats.Aspects.FreeformPayload = freeformPayload
						end

						v30 = true
					end

					local __wf_atom_204490cb = instance:__wf_atom_204490cb()

					if __wf_atom_204490cb:__wf_atom_b70c3343() and not v30 then
						mStats.Era = fn6(mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/NoFaction", false))
					else
						local v31 = MongoDateTime()

						if __wf_atom_204490cb:__wf_atom_b70c3343() then
							v31.sec = string.format("%u", gGameRules:__wf_atom_93691ff2())
						else
							v31.sec = instance:__wf_atom_204490cb():__wf_atom_f1a88c30()
						end

						local __wf_atom_e0c3cbeb = v31:__wf_atom_e0c3cbeb(Engine.__wf_atom_578fc9dd())
						local v32 = string.gsub(__wf_atom_e0c3cbeb, " ", "/")
						local v37 = StringSplit("/", v32)
						local _, _, month, year = module4.ConvertDateToGame(v37[4], v37[2], v37[1], v37[3])
						mStats.Era = fn6((Localize("/SF/Language/Menu/EraTimeStamp", {
							MONTH = month,
							YEAR = year
						})))
					end

					local stabilityDamage = __wf_atom_3c0505c6.stabilityDamage
					mStats2.StabilityDamage = fn6(module.FormatNumber(stabilityDamage, 0), stabilityDamage)

					if not v5 or v7.turboGlaive ~= nil then
						instance2:__wf_atom_9373d0eb(30, true)
						local rounded = fn24(__wf_atom_010c2f81:__wf_atom_305bafa7(4))
						local __wf_atom_d7a8ea46 = __wf_atom_010c2f81:__wf_atom_d7a8ea46(4)
						local v31 = __wf_atom_7e8ad928(__wf_atom_d7a8ea46) and 1
							or __wf_atom_d7a8ea46:__wf_atom_7ee4ff02()
						local formatNumber = module.FormatNumber(rounded, module.Ternary(rounded < 999.9, 0, 0))

						if v31 > 1 then
							formatNumber ..= " x" .. module.FormatNumber(v31)
						end

						local maxValue

						if __wf_atom_7e8ad928(__wf_atom_414f70dd) or not __wf_atom_414f70dd:IsA(__wf_atom_27b2ed0b) then
							maxValue = 1
						else
							maxValue = instance:__wf_atom_485e3a02().maxValue
							rounded = module.Round(rounded * maxValue)
						end

						local v32 = rounded - module.Round(__wf_atom_ae4f866b * maxValue)
						local v37

						if instance:__wf_atom_a2652e26() then
							v37 = fn13(rounded, v32)
						else
							rounded *= instance:__wf_atom_1958c031()
							v37 = fn13(rounded, v32 * instance:__wf_atom_1958c031())
						end

						mStats2.HeavyAttack = fn6(v37, rounded)
						instance2:__wf_atom_9373d0eb(30, false)
					end

					table.insert(result, 1, {
						mIsMelee = false,
						mBehaviorIndex = v7.behaviorIndex,
						mStats = mStats2,
						mExtra = true
					})
				end

				if not p3 then
					instance:__wf_atom_a07433fe():__wf_atom_3412a04d()

					if __wf_atom_d2b2176d:__wf_atom_84479917() then
						instance:__wf_atom_a07433fe():__wf_atom_d5277a5c(false)
					end

					if not __wf_atom_d2b2176d:__wf_atom_84479917() then
						local __wf_atom_75a0566d = instance:__wf_atom_75a0566d()
						local __wf_atom_dfdf4c3f = __wf_atom_010c2f81:__wf_atom_dfdf4c3f()

						if __wf_atom_dfdf4c3f > 0 then
							mStats.ComboCount = fn6(module.FormatNumber(__wf_atom_dfdf4c3f, 1), __wf_atom_dfdf4c3f, nil)
						end

						local __wf_atom_e7b6034a = __wf_atom_010c2f81:__wf_atom_e7b6034a()

						if __wf_atom_e7b6034a > 0 then
							local v26 = __wf_atom_e7b6034a * 100
							mStats.ComboEfficiency = fn6(fn12(v26), v26, nil)
						end

						local __wf_atom_609f0f8e = __wf_atom_010c2f81:__wf_atom_609f0f8e()
						local __wf_atom_8aae89a6 = __wf_atom_010c2f81:__wf_atom_8aae89a6(true)
						local formatNumber = module.FormatNumber(__wf_atom_8aae89a6, 1)

						if __wf_atom_609f0f8e and __wf_atom_8aae89a6 ~= 0 then
							formatNumber = mMovie:__wf_atom_8e9ac384("<INFINITE_SMALL>", true)
							__wf_atom_8aae89a6 = 1e999
						end

						mStats.ComboDuration = fn6(formatNumber, __wf_atom_8aae89a6, nil)
						local __wf_atom_c77ef029 = instance:__wf_atom_c77ef029()
						mStats.BlockingAngle = fn6(
							module.FormatNumber(__wf_atom_c77ef029, 1),
							__wf_atom_c77ef029,
							nil,
							nil,
							nil,
							__wf_atom_c77ef029
						)
						local __wf_atom_607ab529 = instance:__wf_atom_607ab529()
						mStats.SlamAttackRadius = fn6(
							module.FormatNumber(__wf_atom_607ab529, 1),
							__wf_atom_607ab529,
							nil
						)
						mStats.SlamAttackRadialDamage = fn14(instance:__wf_atom_0c847e11())
						local mStats4 = {}

						if not __wf_atom_7e8ad928(__wf_atom_75a0566d) then
							local v26 = __wf_atom_75a0566d:__wf_atom_21eeed05() / __wf_atom_d2b2176d:__wf_atom_2a745663(
								1,
								368,
								instance:__wf_atom_1bb5b1ff(),
								instance
							)
							mStats4.HeavyAttackWindUp = fn6(module.FormatNumber(v26, 1), -v26, nil)
						end

						local v26 = Symbol("HeavySlam")
						local __wf_atom_607ab529_2 = instance:__wf_atom_607ab529(v26)
						mStats4.HeavySlamAttackRadius = fn6(
							module.FormatNumber(__wf_atom_607ab529_2, 1),
							__wf_atom_607ab529_2,
							nil
						)
						local __wf_atom_0c847e11 = instance:__wf_atom_0c847e11(v26)

						if __wf_atom_0c847e11 > 0 then
							mStats4.HeavySlamAttackRadialDamage = fn14(__wf_atom_0c847e11)
						end

						local _ = {
							mIsMelee = true,
							mBehaviorIndex = v7.behaviorIndex,
							mStats = mStats4,
							mExtra = true
						}
					end
				end
			elseif v5 and v7.turboGlaive ~= nil then
				local __wf_atom_c34c33a3 = instance:__wf_atom_c34c33a3(false, v20)
				local v26 = math.max(v20:__wf_atom_1ea3f9f9() * 100, 0)
				local mStats4 = {
					DamageFallOff = fn6(fn12(v26), v26, nil),
					Range = fn6(
						module.FormatNumber(__wf_atom_c34c33a3.radius, 2),
						__wf_atom_c34c33a3.radius,
						nil,
						nil,
						module.Ternary(isA, "MeleeRange", "AoERange")
					)
				}
				local v27 = v4 * module.Ternary(p3, ternary, 1) * v20:__wf_atom_32ef0df9()

				if next(mStats2) then
					fn18(mStats4, __wf_atom_c34c33a3, false, v27, 1)
				end

				table.insert(result, {
					mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Labels/AVATAR_HEAVY_ATTACK", false),
					mBehaviorIndex = v7.behaviorIndex,
					mStats = mStats4,
					mExtra = true
				})
			end
		else
			mStats.Accuracy = fn6(nil, 100, nil)
			local __wf_atom_4bd22419 = __wf_atom_3d08948b:__wf_atom_4bd22419(true)

			if __wf_atom_3d08948b:__wf_atom_4bd22419(true, 0.5, false) == 0 then
				__wf_atom_4bd22419 += 1
			end

			if __wf_atom_4bd22419 > 0 then
				local v26 = 1 / __wf_atom_4bd22419 * 100
				mStats.Accuracy = fn6(module.FormatNumber(v26, 1), v26, nil)
			end

			if __wf_atom_3d08948b:__wf_atom_6515c58a() then
				local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(instance2:__wf_atom_916d1145(), 118)
				mStats.RechargeRate = fn6(module.FormatNumber(__wf_atom_2a745663) .. "/s", __wf_atom_2a745663, nil)
				local __wf_atom_618d3b84 = instance2:__wf_atom_618d3b84()
				mStats.RechargeDelay = fn6(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ProgressSeconds", false, {
						CURRENT = module.FormatNumber(__wf_atom_618d3b84, 1)
					}),
					-__wf_atom_618d3b84,
					nil
				)
			else
				local __wf_atom_0d147834 = instance:__wf_atom_0d147834()
				mStats.Reload = fn6(module.FormatNumber(__wf_atom_0d147834, 1), -__wf_atom_0d147834, nil)
			end

			if
				__wf_atom_3d08948b:IsA(WeakResource("/Lotus/Types/Game/LotusWeaponProjectileFireBehavior"))
				and __wf_atom_3d08948b:__wf_atom_9741f03e() ~= 0
			then
				fn28(
					mStats,
					instance,
					v20,
					v19,
					v7.turboGlaive == true,
					__wf_atom_414f70dd,
					__wf_atom_3d08948b,
					__wf_atom_010c2f81,
					isA,
					p3,
					__wf_atom_d2b2176d
				)
			end
		end

		local v26 = 1

		if isA then
			if not v8 then
				v26 = v9
			end
		else
			v26 = v9
		end

		local v27 = fn17(mStats2, false, v26) * v26
		local v28

		if instance:__wf_atom_a2652e26() then
			v28 = fn13(v27, v25)
		else
			v27 *= instance:__wf_atom_1958c031()
			v28 = fn13(v27, v25 * instance:__wf_atom_1958c031())
		end

		mStats2.Total = fn6(v28, v27)

		if v15 then
			table.insert(result, v13)
		end

		if v14 ~= nil then
			table.insert(result, v14)
		end

		if instance:IsA(__wf_atom_9df43583) and mMovie:Execute("ShouldShowOmegaAttenStat", "") then
			local __wf_atom_83ee63eb = instance:__wf_atom_83ee63eb()
			local v29

			if __wf_atom_83ee63eb < 0.7 then
				v29 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/WeaponStats_OmegaAttenLowest", true)
			elseif __wf_atom_83ee63eb < 0.9 then
				v29 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/WeaponStats_OmegaAttenLow", true)
			elseif __wf_atom_83ee63eb <= 1.109 then
				v29 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/WeaponStats_OmegaAttenMedium", true)
			elseif __wf_atom_83ee63eb <= 1.309 then
				v29 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/WeaponStats_OmegaAttenHigh", true)
			else
				v29 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/WeaponStats_OmegaAttenHighest", true)
			end

			mStats.OmegaAtten = fn6(v29, __wf_atom_83ee63eb, nil)
		end

		if __wf_atom_3d08948b:IsA(__wf_atom_0cf1ac41) then
			if __wf_atom_3d08948b:__wf_atom_243e3801() then
				mStats.Punchthrough = fn6(mMovie:__wf_atom_8e9ac384("<INFINITE_SMALL>", true), 4294967295, nil)
			else
				local __wf_atom_d51d61ec = __wf_atom_3d08948b:__wf_atom_d51d61ec()

				if __wf_atom_d51d61ec > 0 then
					mStats.Punchthrough = fn6(module.FormatNumber(__wf_atom_d51d61ec, 1), __wf_atom_d51d61ec, nil)
				end
			end
		elseif __wf_atom_3d08948b:IsA(__wf_atom_ed85f483) then
			local v29 = false
			local v30

			if v7.turboGlaive == true then
				v30 = instance:__wf_atom_d2f478d5(__wf_atom_3d08948b:__wf_atom_47ef92e7(p3))
			else
				local __wf_atom_1cda18ff = __wf_atom_3d08948b:__wf_atom_1cda18ff()

				if not __wf_atom_7e8ad928(__wf_atom_1cda18ff) and __wf_atom_1cda18ff:IsA(__wf_atom_014b4ff7) then
					local v31 = Resource(__wf_atom_1cda18ff)

					if not __wf_atom_7e8ad928(v31) then
						v29 = not v31:__wf_atom_d6e8992a()
					end
				end

				v30 = instance:__wf_atom_d2f478d5(__wf_atom_3d08948b:__wf_atom_1cda18ff())
			end

			if v29 then
				mStats.Punchthrough = fn6(mMovie:__wf_atom_8e9ac384("<INFINITE_SMALL>", true), 4294967295, nil)
			elseif v30 > 0 then
				mStats.Punchthrough = fn6(module.FormatNumber(v30, 1), v30, nil)
			end
		end

		local damageFallOff

		if __wf_atom_3d08948b:IsA(__wf_atom_ed85f483) and not __wf_atom_3d08948b:__wf_atom_9a97ee4c() then
			damageFallOff = instance:__wf_atom_3e2dbe2f(__wf_atom_3d08948b:__wf_atom_1cda18ff(), false)
		else
			damageFallOff = __wf_atom_010c2f81.damageFallOff
		end

		if damageFallOff.maxValue > 0 then
			local v29 = {
				minValue = __wf_atom_d2b2176d:__wf_atom_2a745663(
					damageFallOff.minValue,
					426,
					instance:__wf_atom_1bb5b1ff(),
					instance
				),
				maxValue = __wf_atom_d2b2176d:__wf_atom_2a745663(
					damageFallOff.maxValue,
					426,
					instance:__wf_atom_1bb5b1ff(),
					instance
				)
			}

			if v29.maxValue > 0 then
				mStats.DamageFallOff = fn6(
					module.FormatNumber(v29.minValue, module.Ternary(v29.minValue < 999.9, 1, 0)) .. " - " .. module.FormatNumber(
						v29.maxValue,
						module.Ternary(v29.maxValue < 999.9, 1, 0)
					),
					v29.minValue,
					false,
					true
				)
			else
				mStats.DamageFallOff = fn6("0", 0, false, true)
			end
		end

		fn20(instance, mStats)
		fn22(__wf_atom_d2b2176d, v7.upgrades)
		fn23(mStats, v7.unusedStats)
	end

	if not __wf_atom_7e8ad928(instance) and instance:__wf_atom_5e005c29() ~= 0 then
		instance:SetBehavior(0)
	end

	if p4 then
		for i = 1, #result do
			if i == 1 then
				continue
			end

			local v7 = result[1]
			local v8 = result[i]

			for k in pairs(v8.mStats) do
				if __wf_atom_7e8ad928(k) then
					continue
				end

				local mStat = v7.mStats[k]
				local mStat2 = v8.mStats[k]

				if
					__wf_atom_7e8ad928(mStat)
					or __wf_atom_7e8ad928(mStat2)
					or mStat2.DisplayValue ~= mStat.DisplayValue
				then
					continue
				end

				v8.mStats[k] = nil
			end
		end
	end

	if p5 then
		instance:__wf_atom_be4ffd28()
		instance:__wf_atom_88686970(false)
	end

	return result
end

local function fn34()
	local v4 = 2
	local v5 = getfenv(v4)

	while not v5.mMovie do
		v4 += 1
		v5 = getfenv(v4)
	end

	return v5
end

function AddLabelToStat(p, label, p2, p3, list, list2)
	if list2 == nil then
		if list ~= nil then
			for i = 1, #list do
				if list[i] == p then
					return false
				end
			end
		end
	else
		local v4 = false

		for i = 1, #list2 do
			if list2[i] ~= p then
				continue
			end

			v4 = true
			break
		end

		if not v4 then
			return false
		end
	end

	if p2 == nil then
		return false
	end

	if not p3 then
		label = Localize(label, {})
	end

	p2.Label = label
	p2.Key = p
	return true
end

local function fn35(instance, p, p2, p3, p4, p5, p6, p7)
	local mMovie = fn34().mMovie
	local result = {}
	local mStats = nil

	if __wf_atom_7e8ad928(instance) then
		return result
	end

	local function fn36(p8, p9)
		if __wf_atom_7e8ad928(mStats) then
			return
		end

		local v4 = mStats[p8]

		if v4 == nil then
			return
		end

		if not AddLabelToStat(p8, p9, v4, p2, p5, p6) then
			mStats[p8] = nil
		end
	end

	local v4 = fn8(instance)
	local isA = instance:IsA(__wf_atom_dd81e462)
	local isA2 = instance:IsA(__wf_atom_abf506db)
	local isA3 = instance:IsA(__wf_atom_16cdad3a)
	local isA4 = instance:IsA(WeakResource("/SF/Types/Items/AttributeItem"))
	local v5 = {}
	local v6 = _T.ArsenalState == 2

	if isA2 then
		result = fn32(mMovie, instance, p)

		for i = 1, #result do
			mStats = result[i].mStats

			if __wf_atom_7e8ad928(result[i]) then
				continue
			end

			fn36("CourageIncrease", "/Lotus/Language/Labels/AVATAR_ATTRIBUTE_PRIMARY_COURAGE")
			fn36("GraceIncrease", "/Lotus/Language/Labels/AVATAR_ATTRIBUTE_PRIMARY_GRACE")
			fn36("SpiritIncrease", "/Lotus/Language/Labels/AVATAR_ATTRIBUTE_PRIMARY_SPIRIT")
			fn36("StabilityDamage", "/SF/Language/Menu/StabilityDamage")
			fn36("Total", "/SF/Language/Menu/Damage")
		end
	elseif isA3 then
		result = fn31(mMovie, instance, p)
		mStats = result[1].mStats
		fn36("AttuneTypeIncrease", "/SF/Language/Menu/AttuneType")
	elseif isA4 then
		local __wf_atom_f7423942 = __wf_atom_c67f9605:__wf_atom_f7423942(gGameData:__wf_atom_d5bed0b3())
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local v7 = SF.__wf_atom_edd3fb68 + __wf_atom_f7423942 + __wf_atom_c4f78a8f:__wf_atom_4ad84724()
		local __wf_atom_e3a1a628, v9, v10 = Resource(instance):__wf_atom_e3a1a628(v7, 1 / 3, 1 / 3)
		local v8 = {
			0,
			0,
			0,
			[1] = __wf_atom_e3a1a628,
			[2] = v9,
			[3] = v10
		}
		local v11 = {
			{ "Courage", "/Lotus/Language/Labels/AVATAR_ATTRIBUTE_PRIMARY_COURAGE" },
			{ "Grace", "/Lotus/Language/Labels/AVATAR_ATTRIBUTE_PRIMARY_GRACE" },
			{ "Spirit", "/Lotus/Language/Labels/AVATAR_ATTRIBUTE_PRIMARY_SPIRIT" }
		}
		local mStats2 = {}
		result = {}

		for i = 1, #v8 do
			local v12 = v11[i][1]
			local v13 = v11[i][2]
			mStats2[v12] = fn6(v8[i], v8[i])
			AddLabelToStat(v12, v13, mStats2[v12])
		end

		result[1] = { mStats = mStats2, mForceHeader = true }
	elseif not v4 and fn7(instance) then
		local v7

		if isA then
			v7 = instance:__wf_atom_f9b4c62f()
		else
			v7 = instance
		end

		result = fn33(mMovie, v7, p, 1, v5, v6, p3, p4)
		local v8 = instance:__wf_atom_3b0e8ae3() == 13

		if result == nil then
			result = {}
		elseif isA then
			result[1].mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/TacCallPilot", false) .. " - " .. mMovie:__wf_atom_8e9ac384(
				v7:__wf_atom_014a76a2():c_str(),
				false
			)
			v7 = instance:__wf_atom_1b81911f()
			local v9 = fn33(mMovie, v7, p, 1, v5, v6, p3, p4)

			if v9 ~= nil then
				v9[1].mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/RailjackGunnery", false) .. " - " .. mMovie:__wf_atom_8e9ac384(
					v7:__wf_atom_014a76a2():c_str(),
					false
				)

				for i = 1, #v9 do
					table.insert(result, v9[i])
				end
			end
		end

		for _, v9 in ipairs(result) do
			mStats = v9.mStats
			v9.mIsWeapon = true
			local __wf_atom_414f70dd = instance:__wf_atom_414f70dd(v9.mBehaviorIndex)
			local isA5 = __wf_atom_414f70dd:IsA(WeakResource("/SF/Types/Weapon/GlaiveAlternateGrenadeStateBehavior"))

			for i = 0, 19 do
				local damageTypeTag = module2.GetDamageTypeTag(i, isA or false)

				if mStats[damageTypeTag] ~= nil then
					fn36(damageTypeTag, "/Lotus/Language/Game/" .. damageTypeTag)
				end

				if mStats["Embed" .. damageTypeTag] ~= nil then
					fn36("Embed" .. damageTypeTag, "/Lotus/Language/Game/" .. damageTypeTag)
				end
			end

			fn36("Total", "/SF/Language/Menu/Damage")
			fn36("StabilityDamage", "/SF/Language/Menu/StabilityDamage")
			fn36("Range", "/Lotus/Language/Labels/AVATAR_RANGE")
			fn36("HeavyAttack", "/SF/Language/Menu/HeavyDamage")
			fn36("AttunementChange", "/SF/Language/Upgrades/AttunementChange")

			if not v9.mIsMelee then
				fn36("Accuracy", "/Lotus/Language/Labels/WEAPON_SPREAD")
				fn36("EmbedDelay", "/Lotus/Language/Labels/WEAPON_EMBED_DELAY")
				fn36("EmbedFallOff", "/Lotus/Language/Game/WEAPON_FALLOFF")
			end

			fn36("Level", "/SF/Language/Menu/Stat_ItemLevel")
			fn36("MeleeSkill", "/SF/Language/Menu/MeleeSkill")
			fn36("DamageType", "/SF/Language/Menu/DamageType")
			fn36("Quality", "/SF/Language/Menu/Stat_ItemQuality")
			fn36("Creator", "/SF/Language/Menu/Stat_ItemCreator")
			fn36("Origin", "/SF/Language/Menu/Stat_ItemOrigin")

			if instance:__wf_atom_966277ef() == 0 then
				fn36("Era", "/SF/Language/Menu/Stat_ItemEraForged")
			else
				fn36("Era", "/SF/Language/Menu/Stat_ItemEraFound")
			end

			fn36("Aspects", "/SF/Language/Menu/Stat_Aspects")

			if v7:IsA(__wf_atom_9df43583) then
				local v10 = v7:__wf_atom_1bb5b1ff() == WeakResource("/SF/Weapons/Melee/TwoHand/MotherCorruptedGreatSword/MotherCorruptedGreatSwordMeleeWeapon")

				if v7:__wf_atom_bbd8a30c() then
					fn36("AttuneType", mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/AttuneType", false, {
						VIRTUE = fn2(mMovie:__wf_atom_8e9ac384(
							"/SF/Language/Menu/" .. module3.GetAttributeTypeTag(v7:__wf_atom_10c2368d(), v10),
							false
						))
					}))
				end

				if v7:__wf_atom_5b84e5ae() then
					local v11 = false

					for i = 0, 2 do
						if not (v7:__wf_atom_4dbc3979(i) > 0) then
							continue
						end

						local attributeTypeTag = module3.GetAttributeTypeTag(i, v10)
						local ternary = module.Ternary(
							v11 or p7,
							" ",
							mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/VirtueRequirement", false)
						)
						fn36("Requirement_" .. attributeTypeTag, ternary)
						v11 = true
					end
				end

				fn36("RequiredLevel", "[HC] Required Level")
			end

			if not (v8 or isA5 or v9.mIsMelee) then
				fn36("FireRate", "/Lotus/Language/Labels/WEAPON_FIRE_RATE")
			end

			if v6 then
				fn36("HeadShotMult", "/Lotus/Language/Labels/WEAPON_HEADSHOT_MULTIPLIER")
			else
				fn36("CriticalChance", "/Lotus/Language/Labels/WEAPON_CRIT_CHANCE")
			end

			if __wf_atom_414f70dd:IsA(WeakResource("/EE/Types/Game/WeaponChargedStateBehavior")) then
				fn36("ChargeRate", "/Lotus/Language/Labels/WEAPON_CHARGE_RATE")
			end

			fn36("ProcChance", "/Lotus/Language/Labels/WEAPON_PROC")
			fn36("ProcChancePerShot", "/Lotus/Language/Game/StatusPerProjectile")
			fn36("EnergyPool", "/Lotus/Language/Labels/ENERGY_POOL")
			fn36("EnergyPerSecond", "/Lotus/Language/Labels/ENERGY_PER_SECOND")
			fn36("EnergyPerShot", "/Lotus/Language/Labels/ENERGY_PER_SHOT")

			if not isA5 and isA then
				fn36("Mag", "/Lotus/Language/Labels/WEAPON_HEAT_CLIP")
				fn36("AmmoReq", "/Lotus/Language/Labels/WEAPON_HEAT_GENERATION")
			end

			fn36("MaxAmmo", "/Lotus/Language/Labels/WEAPON_AMMO_MAX")

			if v9.mIsMelee then
				fn36("Stamina", "/Lotus/Language/Labels/AVATAR_STAMINA")
			else
				fn36("RechargeRate", "/Lotus/Language/Labels/RECHARGE_RATE")
				fn36("RechargeDelay", "/Lotus/Language/Labels/RECHARGE_DELAY")
				fn36("DT_StackDamage", "/Lotus/Language/Labels/WEAPON_STACKDAMAGE")
				fn36("Noise", "/Lotus/Language/Labels/WEAPON_NOISE")
				fn36("Multishot", "/Lotus/Language/Labels/WEAPON_FIRE_ITERATIONS")

				if not isA5 then
					fn36("Reload", "/Lotus/Language/Labels/WEAPON_RELOAD")
					fn36("Trigger", "/Lotus/Language/Labels/WEAPON_TRIGGER")
				end
			end

			fn36("OmegaAtten", "/Lotus/Language/Menu/WeaponStats_OmegaAttenuationTitle")
			fn36("Punchthrough", "/Lotus/Language/Labels/WEAPON_PUNCTURE_DEPTH")
			fn36("DamageFallOff", "/Lotus/Language/Game/WEAPON_FALLOFF")
			fn36("BounceChance", "/Lotus/Language/Labels/BOUNCE_CHANCE")
		end
	end

	if not __wf_atom_7e8ad928(mStats) then
		local v7 = 1

		while not __wf_atom_7e8ad928(mStats["Stat" .. v7]) do
			__wf_atom_7e8ad928(mStats["Stat" .. v7].LocalizedName)
			v7 += 1
		end
	end

	for _, v7 in ipairs(result) do
		for k, mStat in pairs(v7.mStats) do
			if not (k ~= nil and mStat ~= nil) then
				continue
			end

			if mStat.Label == nil then
				mStats[k] = nil
			else
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Stats/TIP_" .. k, true, {
					AMOUNT = mStat.ToolTipValue
				})
				local toolTip = (#__wf_atom_8e9ac384 == 0 or string.sub(__wf_atom_8e9ac384, 1, 1) == "/") and ""
					or __wf_atom_8e9ac384

				if mStat.ToolTip ~= nil then
					local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Stats/TIP_" .. mStat.ToolTip,
						true,
						{ AMOUNT = mStat.ToolTipValue }
					)

					if #__wf_atom_8e9ac384_2 > 0 and string.sub(__wf_atom_8e9ac384_2, 1, 1) ~= "/" then
						if #toolTip > 0 then
							toolTip ..= "\r" .. __wf_atom_8e9ac384_2
						else
							toolTip = __wf_atom_8e9ac384_2
						end
					end
				end

				if #toolTip > 0 then
					mStat.ToolTip = toolTip
				end
			end
		end
	end

	return result
end

local function fn36(list, list2)
	local mMovie = fn34().mMovie
	local v4 = " " .. mMovie:__wf_atom_8e9ac384("<MINI_ARROW>", true) .. " "
	local v5 = math.min(#list, #list2)
	local result = {}

	for i = 1, v5 do
		local v6 = list[i]
		local v7 = list2[i]
		local mName = ""

		if fn5(v6.mName) or fn5(v7.mName) then
			if fn5(v6.mName) then
				mName = v7.mName
			elseif fn5(v7.mName) then
				mName = v6.mName
			end
		elseif v7.mName == v6.mName then
			mName = v7.mName
		else
			mName = v6.mName .. v4 .. v7.mName
		end

		local v8 = { mName = mName, mStats = {} }
		local mStats = v8.mStats
		local flag = true

		for _, mStat in pairs(v6.mStats) do
			if not (mStat ~= nil and mStat.Key ~= nil) then
				continue
			end

			mStats[mStat.Key] = {
				Label = mStat.Label,
				SingleLine = mStat.SingleLine,
				TextOnly = mStat.TextOnly or mStat.TextIfOneNil,
				TextIfOneNil = mStat.TextIfOneNil,
				SmallerIsBetter = mStat.SmallerIsBetter,
				Previous = fn6(mStat.DisplayValue, mStat.StatValue, nil, nil, mStat.ToolTip),
				IconValue = mStat.IconValue,
				Current = {},
				Hidden = mStat.Hidden,
				ForceOrder = mStat.ForceOrder
			}
			mStats[mStat.Key].FreeformPayload = mStats[mStat.Key].FreeformPayload or {}
			table.insert(mStats[mStat.Key].FreeformPayload, mStat.FreeformPayload or {})

			if __wf_atom_7e8ad928(mStat.Order) then
				continue
			end

			mStats[mStat.Key].Previous.Order = mStat.Order
			mStats[mStat.Key].Current.Order = mStat.Order
			mStats[mStat.Key].Order = mStat.Order
		end

		for _, mStat in pairs(v7.mStats) do
			if not (mStat ~= nil and mStat.Key ~= nil) then
				continue
			end

			if mStats[mStat.Key] == nil then
				mStats[mStat.Key] = {
					Label = mStat.Label,
					SingleLine = mStat.SingleLine,
					TextOnly = mStat.TextOnly or mStat.TextIfOneNil,
					TextIfOneNil = mStat.TextIfOneNil,
					SmallerIsBetter = mStat.SmallerIsBetter,
					IconValue = mStat.IconValue,
					Current = fn6(mStat.DisplayValue, mStat.StatValue, nil, nil, mStat.ToolTip),
					Previous = {},
					ForceOrder = mStat.ForceOrder
				}
				mStats[mStat.Key].FreeformPayload = mStats[mStat.Key].FreeformPayload or {}

				if
					mStat.FreeformPayload
					and (mStats[mStat.Key].Previous == nil or #mStats[mStat.Key].Previous == 0)
				then
					table.insert(mStats[mStat.Key].FreeformPayload, {})
				end

				table.insert(mStats[mStat.Key].FreeformPayload, mStat.FreeformPayload or {})
				flag = false
			else
				mStats[mStat.Key].Current = fn6(mStat.DisplayValue, mStat.StatValue, nil, nil, mStat.ToolTip)
				mStats[mStat.Key].TextOnly = mStats[mStat.Key].TextOnly or mStat.TextOnly
				mStats[mStat.Key].TextIfOneNil = mStats[mStat.Key].TextIfOneNil or mStat.TextIfOneNil
				mStats[mStat.Key].IconValue = mStats[mStat.Key].IconValue or mStat.IconValue
				mStats[mStat.Key].SingleLine = mStats[mStat.Key].SingleLine or mStat.SingleLine
				mStats[mStat.Key].FreeformPayload = mStats[mStat.Key].FreeformPayload or {}

				if mStat.FreeformPayload and mStats[mStat.Key].Previous ~= nil then
					local _ = #mStats[mStat.Key].Previous == 0
				end

				table.insert(mStats[mStat.Key].FreeformPayload, mStat.FreeformPayload or {})

				if mStats[mStat.Key].Previous ~= nil then
					local current = mStats[mStat.Key].Current
					local previous = mStats[mStat.Key].Previous

					if current.StatValue ~= previous.StatValue or current.DisplayValue ~= previous.DisplayValue then
						flag = false
					end

					if mStats[mStat.Key].TextIfOneNil then
						mStats[mStat.Key].TextOnly = false
					end
				end
			end

			if mStats[mStat.Key].Hidden and mStat.Hidden then
				mStats[mStat.Key] = nil
			end
		end

		if flag then
			v8.mName = v7.mName
		end

		table.insert(result, v8)
	end

	local count = #list
	local count2 = #list2

	if math.abs(count - count2) == 0 then
		return result
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/NotAvailable", false)
	local ternary = module.Ternary(count < count2, list2, list)

	for i = v5 + 1, #ternary do
		local mName

		if __wf_atom_7e8ad928(ternary[i].mName) then
			mName = ""
		else
			mName = ternary[i].mName

			if list2 ~= nil and list ~= nil then
				if count < count2 then
					mName = __wf_atom_8e9ac384 .. v4 .. mName
				else
					mName ..= v4 .. __wf_atom_8e9ac384
				end
			end
		end

		local v6 = { mName = mName, mStats = {} }
		local mStats = v6.mStats

		for _, mStat in pairs(ternary[i].mStats) do
			if mStat.Key == nil then
				continue
			end

			mStats[mStat.Key] = { Label = mStat.Label, TextOnly = mStat.TextOnly }

			if ternary == list2 then
				mStats[mStat.Key].Current = {
					StatValue = mStat.StatValue,
					DisplayValue = mStat.DisplayValue
				}

				if list == nil then
					mStats[mStat.Key].Previous = mStats[mStat.Key].Current
				end
			else
				mStats[mStat.Key].Previous = {
					StatValue = mStat.StatValue,
					DisplayValue = mStat.DisplayValue
				}

				if list2 == nil then
					mStats[mStat.Key].Current = mStats[mStat.Key].Previous
				end
			end
		end

		table.insert(result, v6)
	end

	return result
end

local function fn37(state)
	local menuSuitAvatar = not __wf_atom_7e8ad928(_T.MenuSuitAvatar) and _T.MenuSuitAvatar
		or gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(_T.RailjackAvatar) or not state.IsRailjackAbility then
		if __wf_atom_7e8ad928(menuSuitAvatar) or not menuSuitAvatar:IsA(__wf_atom_47cae841) then
			if _T.mMechaSuitMode and not __wf_atom_7e8ad928(_T.MechAvatar) then
				menuSuitAvatar = _T.MechAvatar
			elseif
				(_T.mSpecialSuitMode or _T.mCachedSpecialSuitMode)
				and not __wf_atom_7e8ad928(_T.SpecialSuitAvatar)
			then
				menuSuitAvatar = _T.SpecialSuitAvatar
			end
		else
			menuSuitAvatar = menuSuitAvatar:__wf_atom_4221009f()
		end
	else
		menuSuitAvatar = _T.RailjackAvatar
	end

	if
		__wf_atom_7e8ad928(state)
		or not state.IsAbility
		or __wf_atom_7e8ad928(menuSuitAvatar)
		or __wf_atom_7e8ad928(state.Movie)
	then
		return {}, {}, {}, {}
	end

	local result = {}
	local result2 = {}
	local result3 = {}
	local result4 = {}
	local movie = state.Movie
	local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Ability_DurationInfinite", true, {})
	local v4 = Symbol("GetAbilityUpgradeLevelInfo")
	_T.AbilityLevelQueryParms = {
		ForceOverride = state.ForceOverride,
		Level = (state.Level or 0) + 1,
		Ability = state.Resource,
		Avatar = menuSuitAvatar,
		Modded = false
	}
	menuSuitAvatar:__wf_atom_51009507(state.Script, v4, true)
	local abilityUpgradeLevelInfo = _T.AbilityUpgradeLevelInfo

	if not __wf_atom_7e8ad928(abilityUpgradeLevelInfo) and abilityUpgradeLevelInfo.EnergyCost ~= nil then
		if abilityUpgradeLevelInfo.EnergyCost == false then
			state.Energy = nil
		else
			local energyCost = abilityUpgradeLevelInfo.EnergyCost

			if not __wf_atom_7e8ad928(state.Suit) and abilityUpgradeLevelInfo.EnergyIconOverride == nil then
				local suit = state.Suit

				if __wf_atom_1ef90898(suit) then
					suit = Resource(suit)
				end

				energyCost = suit:__wf_atom_6557214c(abilityUpgradeLevelInfo.EnergyCost)
			end

			state.Energy = energyCost
			state.BaseEnergy = abilityUpgradeLevelInfo.BaseEnergyCost or abilityUpgradeLevelInfo.EnergyCost
			state.EnergyLabel = abilityUpgradeLevelInfo.EnergyLabel
			state.EnergyFormatting = abilityUpgradeLevelInfo.EnergyFormatting
			state.EnergyIconOverride = abilityUpgradeLevelInfo.EnergyIconOverride
		end
	end

	if not __wf_atom_7e8ad928(state.Resource) then
		local __wf_atom_de7e7709 = state.Resource:__wf_atom_de7e7709(false, true)

		if __wf_atom_de7e7709 > 1 then
			local __wf_atom_8e9ac384_2 = movie:__wf_atom_8e9ac384("<TIMER>", true)
			table.insert(result, 1, (movie:__wf_atom_8e9ac384("/Lotus/Language/Labels/GAMEPLAY_POWER_COOLDOWN", false)))
			table.insert(result2, 1, __wf_atom_8e9ac384_2 .. " " .. __wf_atom_de7e7709)
			table.insert(result3, 1, __wf_atom_de7e7709)
			table.insert(result4, 1, 0)
		end
	end

	if state.Energy ~= nil then
		local __wf_atom_8e9ac384_2 = movie:__wf_atom_8e9ac384(
			state.EnergyLabel or "/SortingLabels/CapacityRequirement",
			false
		)
		local energy = tonumber(state.Energy)
		local baseEnergy = tonumber(state.BaseEnergy)

		if baseEnergy == nil then
			baseEnergy = energy
		end

		local v5 = baseEnergy - energy
		local __wf_atom_8e9ac384_3 = movie:__wf_atom_8e9ac384(state.EnergyIconOverride or "<ENERGY>", true)
		local ternary = module.Ternary(
			energy == 3.4028234663852886e38,
			__wf_atom_8e9ac384,
			module.FormatNumber(energy, 2, false)
		)

		if state.ModdedStats or v5 == 0 then
			ternary = __wf_atom_8e9ac384_3 .. " " .. ternary
		else
			baseEnergy = __wf_atom_8e9ac384_3 .. " " .. baseEnergy
		end

		if state.EnergyFormatting ~= nil then
			ternary = movie:__wf_atom_8e9ac384(state.EnergyFormatting, true, { COUNT = ternary })
		end

		table.insert(result, 1, __wf_atom_8e9ac384_2)
		table.insert(result2, 1, ternary)
		table.insert(result3, 1, baseEnergy)
		table.insert(result4, 1, v5)
	end

	_T.AbilityLevelQueryParms = {
		ForceOverride = state.ForceOverride,
		Level = (state.Level or 0) + 1,
		Ability = state.Resource,
		Avatar = menuSuitAvatar,
		Modded = not state.BaseOnly
	}
	menuSuitAvatar:__wf_atom_51009507(state.Script, v4, true)
	local abilityUpgradeLevelInfo2 = _T.AbilityUpgradeLevelInfo
	state.mDarken = abilityUpgradeLevelInfo2 == nil or abilityUpgradeLevelInfo2.Modded == nil

	for i = 1, #abilityUpgradeLevelInfo2 do
		local v5 = abilityUpgradeLevelInfo2[i]
		local __wf_atom_8e9ac384_2 = movie:__wf_atom_8e9ac384(v5.Label, true, {})
		local count = v5.Value or ""
		local value = abilityUpgradeLevelInfo[i].Value or ""
		local v6 = count == value and 0
			or (v5.SmallerIsBetter and count < value or not v5.SmallerIsBetter and value < count) and 1
			or -1

		if v5.Title then
			__wf_atom_8e9ac384_2 = "<b>" .. __wf_atom_8e9ac384_2 .. "</b>"
		else
			count = module.Ternary(
				count == 3.4028234663852886e38,
				__wf_atom_8e9ac384,
				module.FormatNumber(count, 2, false)
			)
			value = module.Ternary(
				value == 3.4028234663852886e38,
				__wf_atom_8e9ac384,
				module.FormatNumber(value, 2, false)
			)

			if v5.ValueMax ~= nil then
				count ..= " - " .. module.Ternary(
					v5.ValueMax == 3.4028234663852886e38,
					__wf_atom_8e9ac384,
					module.FormatNumber(v5.ValueMax, 2, false)
				)
			end

			if abilityUpgradeLevelInfo[i].ValueMax ~= nil then
				value ..= " - " .. module.Ternary(
					abilityUpgradeLevelInfo[i].ValueMax == 3.4028234663852886e38,
					__wf_atom_8e9ac384,
					module.FormatNumber(abilityUpgradeLevelInfo[i].ValueMax, 2, false)
				)
			end

			if v5.ValueUnit ~= nil then
				count = movie:__wf_atom_8e9ac384(v5.ValueUnit, true, { COUNT = count })
			end

			if v5.ValueIcon ~= nil then
				if state.ModdedStats or v6 == 0 then
					count = movie:__wf_atom_8e9ac384(v5.ValueIcon, true) .. " " .. count
				else
					value = movie:__wf_atom_8e9ac384(v5.ValueIcon, true) .. " " .. value
				end
			end
		end

		table.insert(result, __wf_atom_8e9ac384_2)
		table.insert(result2, count)
		table.insert(result3, value)
		table.insert(result4, v6)
	end

	_T.AbilityLevelQueryParms = nil
	_T.AbilityUpgradeLevelInfo = nil
	return result, result2, result3, result4
end

local function fn38(list, p, p2, p3, p4, p5, p6, p7, p8, p9)
	local v4 = p and {
		Labels = {},
		Values = {},
		CompareValues = {},
		Comparison = {},
		ToolTips = {},
		SingleLine = {},
		IconValues = {},
		GroupIndices = {},
		FreeformPayload = {}
	} or ""
	local v5 = not __wf_atom_7e8ad928(p8)

	if __wf_atom_7e8ad928(list) then
		return v4, ""
	end

	local function fn39(value, value2, p10, value3, value4, value5, p11, p12, options)
		local v6 = value2 or "-"
		local v7 = value3 or "-"
		local v8 = value4 or 0

		if p then
			if v6 == "-" and v7 == "-" then
				v6 = ""
				v7 = ""

				if #value ~= 0 then
					value = "<font face=\"" .. "SpectralSC" .. "\">" .. value .. "</font>"
				end
			end

			table.insert(v4.Labels, value)
			table.insert(v4.Values, v6)
			table.insert(v4.CompareValues, v7)
			table.insert(v4.Comparison, v8)
			table.insert(v4.ToolTips, value5 or "")
			table.insert(v4.SingleLine, p11 or false)
			table.insert(v4.IconValues, p12 or false)
			table.insert(v4.FreeformPayload, options or {})
		else
			local ternary = module.Ternary(__wf_atom_7e8ad928(p3), "#999999", p3)
			local ternary2 = module.Ternary(__wf_atom_7e8ad928(p4), "#FFFFFF", p4)
			local ternary3 = module.Ternary(p5, "<b>", "")
			local ternary4 = module.Ternary(p5, "</b>", "")
			local v9 = value:gsub("%:", "")
			v4 ..= "<font color=\"" .. ternary .. "\">" .. v9

			if p10 then
				v4 ..= ": "
			end

			v4 ..= "</font>"
			v4 ..= "<font color=\"" .. ternary2 .. "\">" .. ternary3 .. v6 .. "\r\n" .. ternary4 .. "</font>"
		end
	end

	if type(list) ~= "table" then
		list = fn35(list, p2, false, false, p7, nil, p9)
	end

	if v5 then
		if type(p8) ~= "table" then
			p8 = fn35(p8, p2, false, false, p7, nil, p9, true)
		end

		list = fn36(list, p8)
	end

	local count = 0

	local function fn40(p10, p11)
		if p10.Order ~= p11.Order then
			return p10.Order < p11.Order
		end

		if __wf_atom_7e8ad928(p10.Label) then
			return false
		end

		if __wf_atom_7e8ad928(p11.Label) then
			return true
		end

		return p10.Label < p11.Label
	end

	local flag = false
	local count2 = 0

	for i, v6 in ipairs(list) do
		if i > 1 and count > 0 then
			table.insert(v4.GroupIndices, count)
		end

		if not v6.mExtra then
			count2 += 1
		end

		if not (p6 == nil or p6 == count2) then
			continue
		end

		local order = 10
		local mStats = {}
		local order2 = 7

		for k, mStat in pairs(v6.mStats) do
			count += 1

			if type(mStat) ~= "table" then
				continue
			end

			if k == "Total" then
				mStat.Order = order2
			elseif k == "CONCLAVE" then
				mStat.Order = 0
			elseif string.find(k, "_RESIST$") == nil then
				if string.find(k, "DT_") == nil and string.find(k, "Power_") == nil then
					if k == "MeleeSkill" then
						mStat.Order = 2
					elseif k == "DamageType" then
						mStat.Order = 3
					elseif k == "AttuneType" then
						mStat.Order = 6
					elseif string.match(k, "^Requirement_") == nil and k ~= "RequiredLevel" then
						if k == "StabilityDamage" then
							mStat.Order = 9
						elseif k == "HeavyAttack" then
							mStat.Order = 8
						elseif k == "KintsugiName" then
							mStat.Order = 2
						elseif k == "Level" then
							mStat.Order = 1
						elseif k == "Rarity" then
							mStat.Order = 1
						elseif k == "Quality" or k == "Origin" or k == "Era" or k == "Creator" then
							mStat.Order = 0
						elseif k == "Aspects" then
							mStat.Order = 100
						elseif __wf_atom_7e8ad928(mStat.Order) then
							mStat.Order = order
						end
					elseif mStat.Label == " " then
						mStat.Order = 5
					else
						mStat.Order = 4
					end
				else
					mStat.Order = 3
				end
			else
				mStat.Order = 2
			end

			if mStat.Label then
				table.insert(mStats, mStat)
			end
		end

		table.sort(mStats, fn40)

		if flag then
			fn39("")
		end

		if not fn5(v6.mName) and (#list > 1 or v6.mForceHeader) then
			if p then
				fn39(v6.mName)
			else
				fn39("<font face=\"" .. "SpectralSC" .. "\" color=\"" .. UIColor_Yellow .. "\">" .. v6.mName .. "</font>")
			end
		end

		for _, v7 in ipairs(mStats) do
			local displayValue = v7.DisplayValue
			local statValue = v7.StatValue
			local v8 = nil
			local toolTip = nil

			if v7.IconValue then
				table.insert(v4.GroupIndices, count - 1)
			end

			if displayValue == nil then
				if statValue == nil then
					if v5 then
						local statValue2 = 0

						if v7.Previous ~= nil then
							displayValue = v7.Previous.DisplayValue

							if v7.Previous.StatValue ~= nil then
								statValue2 = v7.Previous.StatValue

								if displayValue == nil then
									displayValue = module.FormatNumber(statValue2)
								end
							end

							toolTip = v7.Previous.ToolTip
						end

						local statValue3 = 0

						if v7.Current ~= nil then
							statValue = v7.Current.DisplayValue

							if v7.Current.StatValue ~= nil then
								statValue3 = v7.Current.StatValue

								if statValue == nil then
									statValue = module.FormatNumber(statValue3)
								end
							end

							if toolTip == nil then
								toolTip = v7.Current.ToolTip
							end
						end

						if not v7.TextOnly then
							v8 = statValue3 < statValue2 and -1 or statValue2 < statValue3 and 1 or v8

							if v7.SmallerIsBetter and not __wf_atom_7e8ad928(v8) then
								v8 *= -1
							end
						end
					end
				else
					displayValue = module.FormatNumber(statValue)
				end
			end

			fn39(v7.Label, displayValue, true, statValue, v8, toolTip, v7.SingleLine, v7.IconValue, v7.FreeformPayload)
		end

		flag = false
	end

	return v4, ""
end

function GetCrewShipStats(p, p2, p3)
	return (fn9(p, p2, p3))
end

function GetPowerSuitStats(p, p2, p3, p4, p5)
	return (fn10(p, p2, p3, p4, p5))
end

function GetLabelledStats(p, p2, p3, _, p4, p5, p6)
	return (fn35(p, p2, p3, false, p4, p5, p6))
end

function GetStatsComparison(p, p2)
	return (fn36(p, p2))
end

function GetStatsTextForItem(p, p2, p3, p4, p5, p6, p7, p8, p9, p10)
	local v4, v5 = fn38(p, p2, p3, p4, p5, p6, p7, p8, p9, p10)
	return v4, v5
end

function GetStatsTextForAbility(p)
	local v4, v5, v6, v7 = fn37(p)
	return v4, v5, v6, v7
end