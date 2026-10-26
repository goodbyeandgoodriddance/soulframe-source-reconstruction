module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local v = Resource("/Lotus/PVP/PVPPowerSuitStatsModifier")

local function fn(mName)
	return mName == nil or mName == ""
end

function Create(p, p2)
	local module4 = require("EE.Interface.Components.List")
	local list = module4.CreateList(p, p2)
	list.mPrefix = "StatCompare(" .. p2 .. ")::"
	list.mStats = {}
	list.mSort = true
	list.mWrapAroundNavigation = false
	list.mElementTransitionTime = 0.15
	list.GroupTitleColor = "#4dd9e5"
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

		local v2 = p5 < p4

		if p3.SmallerIsBetter then
			v2 = p4 < p5
		end

		previousStatColor = module.Ternary(
			v2,
			string.format("%x", list.StatDecreasedColor),
			string.format("%x", list.StatIncreasedColor)
		)
		return previousStatColor
	end

	function list:mElementDrawCallback()
		local label = self.Label

		if label ~= nil and list.TitleCase and not self.Title then
			label = TitleCase(label)
		end

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
		local v2 = list.StatBgColor ~= nil
		list.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Bg", 13, v2)

		if v2 then
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
		local v3

		if ternary2 == "" then
			v3 = "<p><font color=\"#" .. previousStatColor .. "\">" .. module.Ternary(
				list.TitleCase,
				TitleCase(self.Previous.DisplayValue),
				self.Previous.DisplayValue
			) .. "</font>"
		else
			local __wf_atom_8e9ac384 = list.mMovie:__wf_atom_8e9ac384(ternary2, true, {
				COUNT = self.Previous.DisplayValue
			})

			if list.TitleCase then
				__wf_atom_8e9ac384 = TitleCase(__wf_atom_8e9ac384)
			end

			v3 = "<p><font color=\"#" .. previousStatColor .. "\">" .. __wf_atom_8e9ac384 .. "</font>"
		end

		local ternary3 = module.Ternary(self.TextOnly, self.Previous.DisplayValue, self.Previous.StatValue)
		local ternary4 = module.Ternary(self.TextOnly, self.Current.DisplayValue, self.Current.StatValue)

		if ternary3 ~= ternary4 then
			local __wf_atom_8e9ac384 = list.mMovie:__wf_atom_8e9ac384("<MINI_ARROW>", true)
			local currentStatColor = list.GetCurrentStatColor(self, ternary3, ternary4)

			if ternary2 == "" then
				v3 ..= "<font color=\"#" .. currentStatColor .. "\">" .. __wf_atom_8e9ac384 .. module.Ternary(
					list.TitleCase,
					TitleCase(self.Current.DisplayValue),
					self.Current.DisplayValue
				) .. "</font>"
			else
				local __wf_atom_8e9ac384_2 = list.mMovie:__wf_atom_8e9ac384(ternary2, true, {
					COUNT = self.Current.DisplayValue
				})

				if list.TitleCase then
					__wf_atom_8e9ac384_2 = TitleCase(__wf_atom_8e9ac384_2)
				end

				v3 ..= "<font color=\"#" .. currentStatColor .. "\">" .. __wf_atom_8e9ac384 .. __wf_atom_8e9ac384_2 .. "</font>"
			end
		end

		local v4 = v3 .. "</p>"
		list.mMovie:__wf_atom_50d60589(self.mClipName .. ".NewValue", 36, v4)
		local v5

		if self.mIndex == list:GetHowManyElements() then
			v5 = true
		else
			local elementInIndex = list:GetElementInIndex(self.mIndex + 1)
			v5 = self.Order ~= elementInIndex.Order
		end

		list.mMovie:__wf_atom_2dedec1a(self.mClipName, 13, not self.Filler)
		list.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Line", 13, not (v5 or self.Filler))
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
			local v6 = rounded * 5
			list.mMovie:__wf_atom_1ca72041(self.mClipName .. ".DotLine", "TileRepeats", rounded, 1, 1, 1)
			list.mMovie:__wf_atom_4c1c1986(self.mClipName, "DotLine", 14, v6)
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
		local v2 = 0

		for i = 1, #data.mElements do
			local mElement = data.mElements[i]

			if mElement.Filler then
				v2 += 10
			else
				local v3 = data.mMovie:__wf_atom_5e6e15c8(mElement.mClipName, 15) - data.mOriginalElementHeight
				v2 = v2 + data.mForcedVerticalSeparation + module.Ternary(v3 > 0, v3 + 3, 0)
			end
		end

		return v2
	end

	function list.CalculateY(data, p3)
		local mInitialY = data.mInitialY

		for i = 1, p3.Id - 1 do
			if data.mElements[i].Filler then
				mInitialY += module.Ternary(data.mGrowsUpwards, 10, -10)
			else
				local v2 = data.mMovie:__wf_atom_5e6e15c8(data.mElements[i].mClipName, 15) - data.mOriginalElementHeight
				local v3 = data.mForcedVerticalSeparation + module.Ternary(v2 > 0, v2 + 3, 0)
				mInitialY += module.Ternary(data.mGrowsUpwards, v3, -v3)
			end
		end

		return mInitialY
	end

	function list:Populate()
		self:RemoveElements(true, true)
		local ternary = module.Ternary(self.mGrowsUpwards, 1, 0)
		local v2 = ternary + 1
		local v3 = v2 + 1
		local v4 = v3 + 1
		local v5 = v4 + 1
		local v6 = v5 + 1
		local v7 = v6 + 1
		local v8 = v7 + 1
		local ternary2 = module.Ternary(self.mGrowsUpwards, 0, v8)
		local ternary3 = module.Ternary(self.mGrowsUpwards, v8, 0)
		local ternary4 = module.Ternary(self.mGrowsUpwards, 0, #self.mStats * (v8 + 1))
		local flag = false
		local v9 = {}
		local flag2 = false
		local flag3 = false
		local flag4 = false

		for _, mStat in ipairs(self.mStats) do
			if flag then
				table.insert(v9, {
					Label = "",
					Previous = nil,
					Filler = true,
					Order = module.Ternary(self.mGrowsUpwards, ternary4, ternary3 - ternary4)
				})
			end

			if not fn(mStat.mName) and #self.mStats > 1 then
				table.insert(v9, {
					Label = "<p><font color=\"" .. self.GroupTitleColor .. "\"><b>" .. mStat.mName .. "</b></font></p>",
					Previous = nil,
					Title = true,
					Order = ternary2 + ternary4
				})
			end

			for k, mStat2 in pairs(mStat.mStats) do
				if self.mSort then
					if k == "Total" then
						mStat2.Order = v7 + ternary4
						table.insert(v9, {
							Label = "",
							Previous = nil,
							Filler = true,
							Order = v7 + ternary4
						})
					elseif k == "CONCLAVE" then
						mStat2.Order = ternary + ternary4
						flag2 = true
					elseif string.find(k, "_RESIST$") == nil then
						if string.find(k, "Embed") == nil then
							if string.find(k, "EmbedDT_") == nil then
								if string.find(k, "DT_") == nil and string.find(k, "Power_") == nil then
									mStat2.Order = v2 + ternary4
								else
									mStat2.Order = v4 + ternary4
									flag4 = true
								end
							else
								mStat2.Order = v6 + ternary4
							end
						else
							mStat2.Order = v5 + ternary4
						end
					else
						mStat2.Order = v3 + ternary4
						flag3 = true
					end

					if mStat2.ForceOrder ~= nil then
						mStat2.Order = mStat2.ForceOrder + ternary4

						if mStat2.ForceOrder == ternary then
							flag2 = true
						elseif mStat2.ForceOrder == v3 then
							flag3 = true
						elseif mStat2.ForceOrder == v4 then
							flag4 = true
						end
					end
				end

				table.insert(v9, mStat2)
			end

			if self.mSort then
				if flag2 then
					table.insert(v9, {
						Label = "",
						Previous = nil,
						Filler = true,
						Order = v2 + ternary4
					})
				end

				if flag3 then
					table.insert(v9, {
						Label = "",
						Previous = nil,
						Filler = true,
						Order = v3 + ternary4
					})
				end

				if flag4 then
					table.insert(v9, {
						Label = "",
						Previous = nil,
						Filler = true,
						Order = v4 + ternary4
					})
				end
			end

			ternary4 = module.Ternary(self.mGrowsUpwards, v8 + 1 + ternary4, v8 + 1 - ternary4)
			flag = true
		end

		if self.mSort then
			table.sort(v9, function(a, b)
				if a.Order == b.Order then
					return a.Label < b.Label
				end

				return a.Order < b.Order
			end)
		end

		local count = 0

		for _, v10 in pairs(v9) do
			__wf_atom_83c14687(0)
			count += 1
			v10.Id = count
			self:AddElement(v10, true)
		end
	end

	return list
end

local function fn2(displayValue, statValue, textOnly, textIfOneNil, toolTip, toolTipValue)
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

local function fn3(instance)
	local v2 = WeakResource("/Lotus/Weapons/Tenno/LotusLongGun")
	local v3 = WeakResource("/Lotus/Weapons/Tenno/Archwing/Primary/ArchGun")
	local v4 = WeakResource("/Lotus/Weapons/CrewShip/RailjackWeapon")
	return instance:IsA(v2)
		or instance:IsA(__wf_atom_2c8a4b8d)
		or instance:IsA(v3)
		or instance:IsA(__wf_atom_77e05d3b)
		or instance:IsA(v4)
end

local function fn4(instance)
	return instance:IsA(__wf_atom_d98e64fe)
end

local function fn5(object, object2, object3)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object3) then
		return
	end

	local v2 = {
		mName = object:__wf_atom_8e9ac384("/Lotus/Language/Labels/RAILJACKUpper", false),
		mStats = {},
		mIsMelee = false
	}
	local mStats = v2.mStats
	local __wf_atom_7470861b = object2:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local motionControl = object2:MotionControl()
	local maxHealth = object2:GetMaxHealth()
	local __wf_atom_2bf72530 = __wf_atom_7470861b:__wf_atom_2bf72530()
	local v3 = __wf_atom_7470861b:__wf_atom_cac9b02d() / __wf_atom_2bf72530 * 100
	local __wf_atom_3bfe22bd = __wf_atom_7470861b:__wf_atom_3bfe22bd()
	local __wf_atom_58367d88 = __wf_atom_7470861b:__wf_atom_58367d88()
	local v4 = motionControl:__wf_atom_3932eed7(0) / object2:__wf_atom_2b41bcf9()
	local v5 = (v4.x + v4.y + v4.z) / 3
	local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(
		motionControl:__wf_atom_38639bff().x,
		167,
		object3:__wf_atom_1bb5b1ff(),
		object3
	)
	local v6 = { 3, 5, 6, 4 }

	for i = 1, #v6 do
		local v7 = v6[i]
		local __wf_atom_2a745663_2 = __wf_atom_d2b2176d:__wf_atom_2a745663(100, 46, nil, nil, v7)

		if __wf_atom_2a745663_2 == 100 then
			continue
		end

		local v8 = module.FormatNumber(100 - __wf_atom_2a745663_2, 1) .. "%"
		mStats[module3.GetDamageTypeTag(v7)] = fn2(v8, __wf_atom_2a745663_2, nil, true)
	end

	local __wf_atom_2a745663_2 = __wf_atom_d2b2176d:__wf_atom_2a745663(0, 158, nil, nil, 23)

	if __wf_atom_2a745663_2 ~= 0 then
		mStats.ElementRedirection = fn2(
			module.FormatNumber(__wf_atom_2a745663_2 * 100, 1) .. "%",
			__wf_atom_2a745663_2,
			nil,
			true
		)
	end

	local __wf_atom_a8c50352 = __wf_atom_d2b2176d:__wf_atom_a8c50352()
	mStats.RailjackHealth = fn2(nil, maxHealth, nil, true)
	mStats.Shield = fn2(nil, __wf_atom_2bf72530, nil, true)
	mStats.Armor = fn2(nil, __wf_atom_58367d88, nil, true, nil, 100 * __wf_atom_7470861b:__wf_atom_7b86cbfc())
	mStats.Engines = fn2(
		object:__wf_atom_8e9ac384("/Lotus/Language/Game/UNIT_METER_PER_SECOND", false, {
			COUNT = module.FormatNumber(v5)
		}),
		v5,
		nil,
		true
	)
	mStats.EngineBoost = fn2("x" .. module.FormatNumber(__wf_atom_2a745663, 1), __wf_atom_2a745663, nil, true)
	mStats.ShieldRechargeRate = fn2(
		object:__wf_atom_8e9ac384("/Lotus/Language/Game/UNIT_PERCENT_PER_SECOND", false, {
			COUNT = module.FormatNumber(v3, 1)
		}),
		module.Round(v3, 1),
		nil,
		true
	)
	mStats.ShieldRechargeDelay = fn2(
		object:__wf_atom_8e9ac384("/Lotus/Language/Menu/ProgressSeconds", false, {
			CURRENT = module.FormatNumber(__wf_atom_3bfe22bd, 1)
		}),
		-__wf_atom_3bfe22bd,
		nil,
		true
	)
	mStats.CargoCapacity = fn2(nil, __wf_atom_a8c50352, nil, true)
	local __wf_atom_2a745663_3 = __wf_atom_d2b2176d:__wf_atom_2a745663(1, 10, object3:__wf_atom_1bb5b1ff(), object3)
	mStats.Railjack_Power_Strength = fn2(
		module.FormatNumber(__wf_atom_2a745663_3 * 100) .. "%",
		__wf_atom_2a745663_3,
		nil,
		true
	)
	local __wf_atom_2a745663_4 = __wf_atom_d2b2176d:__wf_atom_2a745663(1, 9, object3:__wf_atom_1bb5b1ff(), object3)
	mStats.Railjack_Power_Range = fn2(
		module.FormatNumber(__wf_atom_2a745663_4 * 100) .. "%",
		__wf_atom_2a745663_4,
		nil,
		true
	)
	local __wf_atom_2a745663_5 = __wf_atom_d2b2176d:__wf_atom_2a745663(1, 3, object3:__wf_atom_1bb5b1ff(), object3)
	mStats.Railjack_Power_Duration = fn2(
		module.FormatNumber(__wf_atom_2a745663_5 * 100) .. "%",
		__wf_atom_2a745663_5,
		nil,
		true
	)
	return v2
end

local function fn6(object, object2, instance, p, p2)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	local maxHealth = 0
	local v2

	if instance:IsA(__wf_atom_3ad9dd38) and instance:__wf_atom_f3505c97() and __wf_atom_7e8ad928(object2) then
		object2 = instance:__wf_atom_95e72410()
		v2 = true
	else
		v2 = false
	end

	local v3 = nil
	local v4, v5

	if __wf_atom_7e8ad928(object2) then
		if not __wf_atom_7e8ad928(_T.MenuSuitAvatar) then
			v3 = _T.MenuSuitAvatar:__wf_atom_7470861b()
		end

		local v6 = Resource("/Lotus/Types/Player/TennoMainMenuDamageController")

		if instance:__wf_atom_8fa921b3() > 0 then
			maxHealth = instance:__wf_atom_8fa921b3()
		elseif not __wf_atom_7e8ad928(_T.CachedTennoAvatar) then
			maxHealth = _T.CachedTennoAvatar:GetMaxHealth()
		end

		v4 = module.Ternary(instance:__wf_atom_db2661f9() >= 0, instance:__wf_atom_db2661f9(), v6:__wf_atom_2bf72530())
		v5 = module.Ternary(instance:__wf_atom_25e79273() > 0, instance:__wf_atom_25e79273(), v6:__wf_atom_58367d88())

		if p then
			maxHealth = v:__wf_atom_17f0be56(maxHealth)
			v4 = v:__wf_atom_d0ae0c31(v4)
			v5 = v:__wf_atom_e9dfeb66(v5)
		end
	else
		v3 = object2:__wf_atom_7470861b()

		if p then
			instance:__wf_atom_31ea6b4f(object2)
			maxHealth = v:__wf_atom_17f0be56(object2:GetMaxHealth())
			v4 = v:__wf_atom_d0ae0c31(v3:__wf_atom_2bf72530())
			v5 = v:__wf_atom_e9dfeb66(v3:__wf_atom_58367d88())
		else
			maxHealth = math.floor((object2:GetMaxHealth()))
			v4 = math.floor((v3:__wf_atom_2bf72530()))
			v5 = math.floor((v3:__wf_atom_58367d88()))
		end
	end

	local v6 = __wf_atom_7e8ad928(p2) and { mName = "", mStats = {}, mIsMelee = false } or p2
	local mStats = v6.mStats
	mStats.Health = fn2(nil, maxHealth, nil, true)
	mStats.Shield = fn2(nil, v4, nil, true)
	local v7

	if not __wf_atom_7e8ad928(v3) then
		v7 = 100 * v3:__wf_atom_7b86cbfc()
	end

	mStats.Armor = fn2(nil, v5, nil, true, nil, v7)
	local flag = false
	local v8

	if not __wf_atom_7e8ad928(object2) then
		v8 = object2:__wf_atom_d2b2176d()

		if not p then
			instance = module.Ternary(v8:__wf_atom_84479917() or v2, v8:__wf_atom_f7583f71(), v8:__wf_atom_e55d02aa())
			flag = true
		end
	end

	if __wf_atom_7e8ad928(instance) or instance:IsA(__wf_atom_1bef9e62) then
		return v6
	end

	local v9

	if __wf_atom_7e8ad928(object2) then
		v9 = instance:__wf_atom_6a5c92a7()
	elseif p then
		local __wf_atom_e00502d8 = instance:__wf_atom_e00502d8()
		instance:__wf_atom_205595ee(100)
		v9 = instance:__wf_atom_6a5c92a7()
		instance:__wf_atom_205595ee(__wf_atom_e00502d8)
	else
		v9 = instance:__wf_atom_6a5c92a7()
	end

	mStats.Power = fn2(nil, v9, nil, true)

	for i = 1, 4 do
		local v10

		if flag then
			v10 = instance:__wf_atom_c497b0ae(i - 1)
		else
			v10 = instance:__wf_atom_e68785c4(i - 1)
		end

		if __wf_atom_7e8ad928(v10) then
			mStats["Ability" .. i] = nil
			mStats["AbilityIcon" .. i] = nil
		else
			mStats["Ability" .. i] = object:__wf_atom_8e9ac384(v10:__wf_atom_014a76a2():c_str(), false)
			mStats["AbilityDescription" .. i] = object:__wf_atom_8e9ac384(v10:__wf_atom_3a3d2e39():c_str(), true)
			mStats["AbilityIcon" .. i] = v10:GetIconTexture()
			mStats["AbilityType" .. i] = v10
		end
	end

	local __wf_atom_3a1f3f95 = instance:__wf_atom_3a1f3f95()

	if __wf_atom_7e8ad928(v8) then
		mStats.Mult_SprintSpeed = fn2(module.FormatNumber(__wf_atom_3a1f3f95, 2), __wf_atom_3a1f3f95, nil, true)
	else
		local v10 = { 3, 4, 5, 6, 7, 8, 14 }

		for i = 1, #v10 do
			local v11 = v10[i]
			local __wf_atom_2a745663 = v8:__wf_atom_2a745663(100, 46, instance:__wf_atom_1bb5b1ff(), instance, v11)

			if __wf_atom_2a745663 == 100 then
				continue
			end

			local statValue = 100 - __wf_atom_2a745663
			local displayValue = module.FormatNumber(statValue, 1) .. "%"
			mStats[module3.GetDamageTypeTag(v11) .. "_RESIST"] = fn2(displayValue, statValue, nil, true, nil, statValue)
		end

		if p then
			local __wf_atom_2a745663 = v8:__wf_atom_2a745663(1, 187)
			mStats.ParkourBoost = fn2(module.FormatNumber(__wf_atom_2a745663, 2), __wf_atom_2a745663, nil, true)
		end

		v8:AddUpgrade(167, 2, __wf_atom_3a1f3f95)
		local v11

		if v8:__wf_atom_84479917() then
			v11 = v8:__wf_atom_2a745663(
				1,
				167,
				instance:__wf_atom_1bb5b1ff(),
				instance,
				26,
				Symbol("ARCHWING_SPRINT_SPEED")
			)
		else
			v11 = v8:__wf_atom_2a745663(1, 167)
		end

		v8:RemoveUpgrade(167, 2, __wf_atom_3a1f3f95)
		mStats.Mult_SprintSpeed = fn2(module.FormatNumber(v11, 2), v11, nil, true)

		if not v2 then
			local __wf_atom_2a745663 = v8:__wf_atom_2a745663(1, 10, instance:__wf_atom_1bb5b1ff(), instance)
			mStats.Power_Strength = fn2(
				module.FormatNumber(__wf_atom_2a745663 * 100) .. "%",
				__wf_atom_2a745663,
				nil,
				true
			)
			local __wf_atom_2a745663_2 = v8:__wf_atom_2a745663(1, 4, instance:__wf_atom_1bb5b1ff(), instance)
			local v12 = __wf_atom_421b01aa(__wf_atom_2a745663_2, 0.25, 1.75)
			mStats.Power_Efficiency = fn2(module.FormatNumber(v12 * 100) .. "%", v12, nil, true)
			local __wf_atom_2a745663_3 = v8:__wf_atom_2a745663(1, 9, instance:__wf_atom_1bb5b1ff(), instance)
			mStats.Power_Range = fn2(
				module.FormatNumber(__wf_atom_2a745663_3 * 100) .. "%",
				__wf_atom_2a745663_3,
				nil,
				true
			)
			local __wf_atom_2a745663_4 = v8:__wf_atom_2a745663(1, 3, instance:__wf_atom_1bb5b1ff(), instance)
			mStats.Power_Duration = fn2(
				module.FormatNumber(__wf_atom_2a745663_4 * 100) .. "%",
				__wf_atom_2a745663_4,
				nil,
				true
			)
			local __wf_atom_2a745663_5 = v8:__wf_atom_2a745663(1, 413, instance:__wf_atom_1bb5b1ff(), instance)
			mStats.Status_Duration_Lavos = fn2(
				module.FormatNumber(__wf_atom_2a745663_5 * 100) .. "%",
				__wf_atom_2a745663_5,
				nil,
				true
			)
			mStats.Power_Efficiency_Lavos = fn2(module.FormatNumber(v12 * 100) .. "%", v12, nil, true)
			return v6
		end
	end

	return v6
end

local function fn7(value, value2)
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

	return fn7(value2, value % value2)
end

local function fn8(p)
	local v2 = fn7(p, 100)
	local numerator = p / v2
	local denominator = 100 / v2
	return Localize("/SF/Language/SystemMessages/Odds", {
		NUMERATOR = numerator,
		DENOMINATOR = denominator
	})
end

local function fn9(p, __wf_atom_4900a295)
	local formatNumber = module.FormatNumber(p + __wf_atom_4900a295, 0)
	return Localize("/SF/Language/Menu/DamageAttune", {
		DAMAGE = formatNumber,
		ATTUNE = __wf_atom_4900a295
	})
end

local function fn10(p)
	return fn2(module.FormatNumber(p, 0), p, nil)
end

local function fn11(object, data, object2, p)
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

local function fn12(p, object, _, value, list, value2)
	local getDamageTypeTag = module3.GetDamageTypeTag
	local __wf_atom_37799654 = object:__wf_atom_6386920d():__wf_atom_37799654()
	local v2 = value2 or ""
	local v3 = value or 1

	for i = 0, 19 do
		local v4

		if list == nil or list[i] == nil then
			v4 = object:__wf_atom_bf612a92(i) * __wf_atom_37799654
		else
			v4 = list[i]
		end

		if v4 > 0 then
			p[v2 .. getDamageTypeTag(i)] = fn10(v4 * v3)
		end
	end
end

local function fn13(items, p, p2, value)
	local v2 = 0

	if not next(items) then
		return v2
	end

	local v3 = value or ""

	if #v3 > 0 then
		v2 = fn13(items, p, p2)
	end

	local getDamageTypeTag = module3.GetDamageTypeTag
	local count = 0

	for i = 0, 19 do
		local v4 = v3 .. getDamageTypeTag(i)

		if not items[v4] then
			continue
		end

		v2 += items[v4].StatValue
		count += 1
		items[v4] = nil
	end

	if v2 > 0 then
		local total = fn10(v2 * p2)
		total.Hidden = count <= 1 and p2 == 1
		items.Total = total
	end

	return v2
end

local function fn14(p, object, _, value, value2, list, _)
	local _getDamageTypeTag = module3.GetDamageTypeTag
	local __wf_atom_37799654 = object:__wf_atom_6386920d():__wf_atom_37799654()
	local v2 = value or 1
	local total = 0
	local count = 0
	local v3 = value2 or 1

	for i = 0, 19 do
		if not (object:__wf_atom_bf612a92(i) > 0) then
			continue
		end

		object:__wf_atom_bf612a92(i)
		local v4

		if list == nil or list[i] == nil then
			v4 = object:__wf_atom_bf612a92(i) * __wf_atom_37799654
		else
			v4 = list[i]
		end

		if not (v4 > 0) then
			continue
		end

		total += v4 * v2
		count += 1
	end

	if total > 0 then
		local total2 = fn10(total * v3)
		total2.Hidden = count <= 1 and v3 == 1
		p.Total = total2
	end
end

local function fn15(instance, p, instance2, p2, isA, p3, p4, p5, list, p6, mName)
	local v2 = {}
	local v3, v4 = fn11(instance, p, instance2, p2)

	if instance2:IsA(__wf_atom_ed85f483) and instance2.advanceProjectileSequenceOnFire then
		local v5 = instance2:__wf_atom_da8b6164() - 1

		if v5 > 0 then
			for i = 1, v5 do
				instance2:__wf_atom_18fa30ab(i)
				local _, v6 = fn11(instance, p, instance2, p2)
				table.insert(v2, v6)
			end

			instance2:__wf_atom_18fa30ab(0)
		end
	end

	local count = #v2
	local mStats = {}

	if not p6 then
		fn12(mStats, v4, isA, p4, p5)

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
		local v5 = v2[i]

		if not (v5:__wf_atom_6386920d():__wf_atom_37799654() > 0) then
			continue
		end

		local mStats2 = {}
		fn14(mStats2, v5, isA, p4, p3, p5)
		table.insert(list, {
			mName = Localize("/Lotus/Language/Stats/Attack" .. i + 1, {}),
			mIsMelee = false,
			mBehaviorIndex = p.behaviorIndex,
			mStats = mStats2,
			mExtra = true
		})
	end

	return v3, v4, mStats
end

local function fn16(_, _) end

local function fn17(object, upgrades)
	for _, v2 in ipairs(upgrades) do
		object:AddUpgrade(v2:__wf_atom_b810064e(), v2:__wf_atom_62831604(), v2:__wf_atom_505b3c0e())
	end
end

local function fn18(object, upgrades)
	for _, v2 in ipairs(upgrades) do
		object:RemoveUpgrade(v2:__wf_atom_b810064e(), v2:__wf_atom_62831604(), v2:__wf_atom_505b3c0e())
	end
end

local function fn19(p, unusedStats)
	for i = 1, #unusedStats do
		p[unusedStats[i]] = nil
	end
end

local function fn20(object)
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

local function fn21(instance, list)
	for i = 1, instance:__wf_atom_06f3cb74() do
		local __wf_atom_b9a1f18c = instance:__wf_atom_b9a1f18c(i - 1)

		if __wf_atom_7e8ad928(__wf_atom_b9a1f18c) or not __wf_atom_b9a1f18c:IsA(__wf_atom_16cdad3a) then
			continue
		end

		local __wf_atom_70b880cb = __wf_atom_b9a1f18c:__wf_atom_70b880cb(__wf_atom_b9a1f18c:__wf_atom_f298d802())
		local v2 = ""

		for _, affix in ipairs(__wf_atom_70b880cb.affixes) do
			if v2 ~= "" then
				v2 ..= "\n"
			end

			v2 ..= affix
		end

		if v2 ~= "" then
			table.insert(list, {
				mName = "",
				mStats = {
					KintsugiName = fn2(Localize(__wf_atom_b9a1f18c:__wf_atom_014a76a2():c_str(), {}), nil, true),
					KintsugiEffect = fn2(v2, nil, true)
				},
				mExtra = true,
				mBehaviorIndex = 0
			})
		end
	end
end

local function fn22(p, object, p2, data, p3, instance, object2, object3, p4, p5, object4)
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

	local v2 = criticalChance * 100
	p.CriticalChance = fn2(fn8(v2), v2, nil)
	Localize("/Lotus/Language/Menu/WeaponStats_MultipilerStat", {
		STAT = module.FormatNumber(criticalMultiplier, 1)
	})

	if not p5 then
		local ternary = module.Ternary(object2.fireIterations > 1, "ProcChancePerShot", "ProcChance")
		local v3 = math.max(data.baseProcChance * 100, 0)

		if instance:__wf_atom_9ff2a58d() and not instance:IsA(__wf_atom_ef6aee1c) then
			v3 *= object:__wf_atom_bef8f035()
		end

		if v3 > 0 then
			p[ternary] = fn2(fn8(v3), v3, nil)
		end
	end
end

local function fn23(instance, instance2, object, p, __wf_atom_414f70dd, instance3, instance4, isA, p2, isA2, p3, p4, p5, p6, __wf_atom_d2b2176d, p7, p8)
	local v2 = nil
	local mStats = {}
	local v3

	if not (isA and p2 or not (object:__wf_atom_6386920d():__wf_atom_37799654() > 0)) then
		fn12(mStats, object, isA2, 1, p3)
		fn22(
			mStats,
			instance,
			instance2,
			object,
			p.turboGlaive == true,
			__wf_atom_414f70dd,
			instance3,
			instance4,
			isA,
			p6,
			__wf_atom_d2b2176d
		)
		v3 = {
			mName = Localize(
				module.Ternary(instance3.fireIterations > 1, "/Lotus/Language/Game/DamagePerProjectile", p7),
				{}
			),
			mIsMelee = false,
			mBehaviorIndex = p.behaviorIndex,
			mStats = mStats,
			mExtra = true
		}
	end

	local mStats2 = {}
	local v4, v5

	if instance4:IsA(__wf_atom_e65b2d71) then
		v4 = instance4:__wf_atom_cb093cde(p6)
		v5 = v4:__wf_atom_6386920d():__wf_atom_37799654()
	else
		v5 = 0
	end

	if v5 == 0 then
		if instance3:IsA(__wf_atom_b734e29f) then
			v4 = instance3:__wf_atom_cb093cde(p6)
		else
			v4 = instance:__wf_atom_c34c33a3(false, instance2)
		end

		v5 = v4:__wf_atom_6386920d():__wf_atom_37799654()
	end

	if v5 > 0 then
		local ternary = module.Ternary(
			object.hitType == 2 and instance3:__wf_atom_9a97ee4c() or object.hitType == 4,
			instance4:__wf_atom_8eeba570(true, true),
			1
		)
		fn12(mStats2, v4, isA2, p4 * module.Ternary(p6, ternary, 1))
		local v6 = math.max(v4.fallOff * 100, 0)
		mStats2.DamageFallOff = fn2(fn8(v6), v6, nil)
	end

	local v6 = false

	if instance:__wf_atom_1741efdd(instance2) then
		local v7 = {
			WeakResource("/Lotus/Weapons/Corpus/Bow/Longbow/CrpBowArrow"),
			WeakResource("/Lotus/Weapons/Corpus/Bow/Longbow/CrpBowArrowPvP")
		}
		local v8 = false

		for _, className in pairs(v7) do
			if not instance2:IsA(className) then
				continue
			end

			v8 = true
			break
		end

		local __wf_atom_5419c63d = instance:__wf_atom_5419c63d(instance2)
		local __wf_atom_37799654 = __wf_atom_5419c63d:__wf_atom_6386920d():__wf_atom_37799654()

		if __wf_atom_37799654 > 0 then
			local getDamageTypeTag = module3.GetDamageTypeTag

			for i = 0, 19 do
				if not (__wf_atom_5419c63d:__wf_atom_bf612a92(i) > 0) then
					continue
				end

				local damageTypeTag = getDamageTypeTag(i)

				if mStats[i] == nil then
					mStats[damageTypeTag] = fn2(nil, 0, nil)
				end

				mStats[damageTypeTag] = fn10(mStats[damageTypeTag].StatValue + __wf_atom_5419c63d:__wf_atom_bf612a92(i) * __wf_atom_37799654)
			end
		end

		if v5 == 0 or __wf_atom_37799654 > 0 or v8 then
			v4 = instance:__wf_atom_c34c33a3(true, instance2)

			if v4:__wf_atom_6386920d():__wf_atom_37799654() > 0 then
				v6 = true
				fn12(mStats2, v4, isA2, 1, nil, "Embed")
				local __wf_atom_ff676b5f = instance:__wf_atom_ff676b5f(instance2)
				local v9

				if __wf_atom_ff676b5f.minValue == __wf_atom_ff676b5f.maxValue then
					v9 = module.FormatNumber(__wf_atom_ff676b5f.minValue, 1)
				else
					v9 = module.FormatNumber(__wf_atom_ff676b5f.minValue, 1) .. " - " .. module.FormatNumber(__wf_atom_ff676b5f.maxValue, 1)
				end

				if v9 ~= nil then
					local __wf_atom_48a8e71b = __wf_atom_ff676b5f:__wf_atom_48a8e71b(0.5)

					if __wf_atom_48a8e71b > 0 then
						mStats2.EmbedDelay = fn2(v9, __wf_atom_48a8e71b, nil)
					end
				end

				local v10 = math.max(v4.fallOff * 100, 0)
				mStats2.EmbedFallOff = fn2(fn8(v10), v10, nil)
			end
		end
	end

	if next(mStats2) then
		mStats2.Range = fn2(
			module.FormatNumber(v4.radius, 2),
			v4.radius,
			nil,
			nil,
			module.Ternary(isA, "MeleeRange", "AoERange")
		)
		fn13(mStats2, isA2, p5, module.Ternary(v6, "Embed", nil))
		fn22(
			mStats2,
			instance,
			instance2,
			v4,
			p.turboGlaive == true,
			__wf_atom_414f70dd,
			instance3,
			instance4,
			isA,
			p6,
			__wf_atom_d2b2176d
		)
		v2 = {
			mName = Localize(p8, {}),
			mIsMelee = isA,
			mBehaviorIndex = p.behaviorIndex,
			mStats = mStats2,
			mExtra = true
		}
	end

	local v7 = 1

	if isA then
		if not p2 then
			v7 = p5
		end
	else
		v7 = p5
	end

	fn13(mStats, isA2, v7)
	return v3, v2
end

local function fn24(mMovie, instance, instance2, p, p2, p3, p4, p5)
	if __wf_atom_7e8ad928(instance2) then
		instance2 = module3.GetMainMenuSuitAvatar()
	end

	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(instance2) then
		return nil
	end

	local result = {}
	local v2 = p == nil and 1 or p

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

	local getDamageTypeTag = module3.GetDamageTypeTag
	local isA = instance:IsA(WeakResource("/Lotus/Weapons/CrewShip/RailjackWeapon"))
	local __wf_atom_d2b2176d = instance2:__wf_atom_d2b2176d()
	local __wf_atom_8c704207 = instance:__wf_atom_8c704207()
	local __wf_atom_ca3e110b = instance:__wf_atom_ca3e110b()
	local v3 = false
	local v4

	if __wf_atom_7e8ad928(__wf_atom_8c704207) or #__wf_atom_8c704207 == 0 then
		v4 = {
			{ localizedTag = "", behaviorIndex = 0 }
		}
	else
		v4 = {}

		for _, v5 in ipairs(__wf_atom_8c704207) do
			table.insert(v4, { localizedTag = v5.localizedTag, behaviorIndex = v5.behaviorIndex })
		end
	end

	if not instance2:IsA(__wf_atom_ee1ed4db) then
		for _, scriptedFireMode in ipairs(_T.ScriptedFireModes) do
			if instance:__wf_atom_0395f752() == scriptedFireMode.weaponSlot then
				table.insert(v4, scriptedFireMode)
			end
		end

		if instance:__wf_atom_4105e180() then
			local v5 = WeakResource("/SF/Types/Weapon/GlaiveProjectileFireBehavior")

			for i = 0, __wf_atom_ca3e110b - 1 do
				if not instance:__wf_atom_3d08948b(i):IsA(v5) then
					continue
				end

				v3 = true

				for j = 1, #v4 do
					if v4[j].behaviorIndex ~= i then
						continue
					end

					v4[j].turboGlaive = false
					table.insert(v4, {
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

	for i, v5 in ipairs(v4) do
		if __wf_atom_ca3e110b <= v5.behaviorIndex then
			print("Error: Invalid fire mode behavior index for weapon " .. instance:GetName() .. " fireMode index = " .. tostring(i))
			break
		end

		fn17(__wf_atom_d2b2176d, v5.upgrades)
		local __wf_atom_414f70dd = instance:__wf_atom_414f70dd(v5.behaviorIndex)
		local __wf_atom_3d08948b = instance:__wf_atom_3d08948b(v5.behaviorIndex)
		local __wf_atom_010c2f81 = instance:__wf_atom_010c2f81(v5.behaviorIndex)
		instance:SetBehavior(v5.behaviorIndex)
		local v6 = instance:__wf_atom_e5141e5b() and __wf_atom_010c2f81:IsA(__wf_atom_6256a119)
		local isA2 = __wf_atom_414f70dd:IsA(WeakResource("/EE/Types/Game/WeaponMeleeStateBehavior"))
		local mStats = {}
		table.insert(result, {
			mName = mMovie:__wf_atom_8e9ac384(v5.localizedTag, false),
			mIsMelee = isA2,
			mBehaviorIndex = v5.behaviorIndex,
			mStats = mStats
		})
		__wf_atom_3d08948b:__wf_atom_0dffbe49(1)

		if not v6 then
			local c_str = __wf_atom_414f70dd:__wf_atom_4f3855f9():c_str()
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(c_str, false)

			if __wf_atom_8e9ac384 ~= "" then
				local v7 = StringSplit("/", c_str)
				mStats.Trigger = fn2(__wf_atom_8e9ac384, nil, true, nil, (string.gsub(v7[#v7], "Loadout_", "")))
			end

			if __wf_atom_3d08948b:IsA(WeakResource("/SF/Types/Game/SFWeaponProjectileFireBehavior")) then
				local __wf_atom_d7c428fd = __wf_atom_3d08948b:__wf_atom_d7c428fd()
				local __wf_atom_9741f03e = __wf_atom_3d08948b:__wf_atom_9741f03e()

				if __wf_atom_d7c428fd ~= 0 or __wf_atom_9741f03e ~= 0 then
					mStats.DT_StackDamage = fn2(
						module.FormatNumber(__wf_atom_d7c428fd) .. " - " .. module.FormatNumber(__wf_atom_9741f03e),
						__wf_atom_d7c428fd,
						nil
					)
				end
			end

			local v7 = __wf_atom_d2b2176d:__wf_atom_2a745663(1, 383, instance:__wf_atom_1bb5b1ff(), instance) == 0
			local __wf_atom_37823495 = instance:__wf_atom_37823495()
			local __wf_atom_1cda18ff = __wf_atom_3d08948b:__wf_atom_1cda18ff()
			local v8 = false

			if not __wf_atom_7e8ad928(__wf_atom_1cda18ff) then
				local v9 = Resource(__wf_atom_1cda18ff)

				if not __wf_atom_7e8ad928(v9) then
					v8 = v9:__wf_atom_c604a6ce()
				end
			end

			mStats.Noise = fn2(
				mMovie:__wf_atom_8e9ac384(
					module.Ternary(
						__wf_atom_37823495 or v8 or v7,
						"/Lotus/Language/Labels/WEAPON_NOISEQUIET",
						"/Lotus/Language/Labels/WEAPON_NOISELOUD"
					),
					false
				),
				nil,
				true
			)
		end

		local v7 = v5.ignoreMultishot and 1 or __wf_atom_3d08948b:__wf_atom_9c30c762()
		local v8 = nil
		local v9 = nil
		local v10 = false
		local v11 = nil
		local v12 = nil
		local v13 = false
		local v14 = 1
		local __wf_atom_9ed189b9 = instance:__wf_atom_9ed189b9()

		if __wf_atom_414f70dd:IsA(WeakResource("/EE/Types/Game/WeaponChargedStateBehavior")) then
			instance:__wf_atom_6f32f2cb(instance:__wf_atom_2c6db744(p3))
			__wf_atom_414f70dd:__wf_atom_26a4fa9a(0)

			if instance:__wf_atom_ed08f97f() then
				v14 = __wf_atom_414f70dd:__wf_atom_5fec577f()
			end

			if __wf_atom_414f70dd:__wf_atom_e50a94ab() ~= 1 then
				__wf_atom_414f70dd:__wf_atom_c2d9fb01(1)
				local v15, v16 = fn11(instance, v5, __wf_atom_3d08948b, p3)
				v8, v9 = fn23(
					instance,
					v15,
					v16,
					v5,
					__wf_atom_414f70dd,
					__wf_atom_3d08948b,
					__wf_atom_010c2f81,
					isA2,
					v6,
					isA,
					p2,
					v2,
					v7,
					p3,
					__wf_atom_d2b2176d,
					"/Lotus/Language/Stats/QuickShot",
					"/Lotus/Language/Stats/QuickShotRadialAttack"
				)
				v10 = v8 ~= nil or v9 ~= nil

				if __wf_atom_3d08948b:IsA(__wf_atom_c38f5238) then
					local __wf_atom_16441e0e = __wf_atom_3d08948b:__wf_atom_16441e0e()

					if not __wf_atom_7e8ad928(__wf_atom_16441e0e) then
						local v17 = Resource(__wf_atom_16441e0e)

						if not __wf_atom_7e8ad928(v17) then
							v11, v12 = fn23(
								instance,
								v17,
								instance:__wf_atom_0590ad17(v17, 0, v5.behaviorIndex),
								v5,
								__wf_atom_414f70dd,
								__wf_atom_3d08948b,
								__wf_atom_010c2f81,
								isA2,
								v6,
								isA,
								p2,
								v2,
								v7,
								p3,
								__wf_atom_d2b2176d,
								"/Lotus/Language/Stats/PerfectShot",
								"/Lotus/Language/Stats/PerfectShotRadialAttack"
							)
							v13 = v11 ~= nil or v12 ~= nil
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

			mStats.ChargeRate = fn2(module.FormatNumber(__wf_atom_7eff92f0, 2), -__wf_atom_7eff92f0, nil)
		elseif __wf_atom_414f70dd:IsA(WeakResource("/EE/Types/Game/WeaponBurstStateBehavior")) then
			instance:__wf_atom_6f32f2cb(instance:__wf_atom_2c6db744(p3))
			__wf_atom_9ed189b9 = instance:__wf_atom_083a9e64():__wf_atom_326098b8()
		end

		if v10 then
			table.insert(result, v8)
		end

		if v9 ~= nil then
			table.insert(result, v9)
		end

		local v15 = __wf_atom_3d08948b.fireIterations > 1 and "/Lotus/Language/Game/DamagePerProjectile"
			or v10 and "/Lotus/Language/Stats/ChargedShot"
			or "/Lotus/Language/Labels/WEAPON_DAMAGE_AMOUNT"
		local v16, v17, mStats2 = fn15(
			instance,
			v5,
			__wf_atom_3d08948b,
			p3,
			isA,
			v7,
			v14,
			p2,
			result,
			isA2 and v6,
			Localize(v15, {})
		)
		local v18 = Resource(v16)
		local ternary = module.Ternary(
			v17.hitType == 2 and __wf_atom_3d08948b:__wf_atom_9a97ee4c() or v17.hitType == 4,
			__wf_atom_010c2f81:__wf_atom_8eeba570(true, true),
			1
		)

		if p3 and not v6 then
			local v19 = 1 + 1 * instance:__wf_atom_4d0c6b2c()
			mStats.HeadShotMult = fn2(
				Localize("/Lotus/Language/Menu/WeaponStats_MultipilerStat", {
					STAT = module.FormatNumber(v19, 1)
				}),
				v19,
				nil
			)
		end

		if v7 ~= 1 then
			mStats.Multishot = fn2(module.FormatNumber(v7, 1), v7)
		end

		local __wf_atom_5419c63d = instance:__wf_atom_5419c63d(v18)
		local __wf_atom_37799654 = __wf_atom_5419c63d:__wf_atom_6386920d():__wf_atom_37799654()

		if __wf_atom_37799654 > 0 then
			for j = 0, 19 do
				if not (__wf_atom_5419c63d:__wf_atom_bf612a92(j) > 0) then
					continue
				end

				local damageTypeTag = getDamageTypeTag(j)

				if mStats2[damageTypeTag] == nil then
					mStats2[damageTypeTag] = fn2(nil, 0, nil)
				end

				mStats2[damageTypeTag] = fn10(mStats2[damageTypeTag].StatValue + __wf_atom_5419c63d:__wf_atom_bf612a92(j) * __wf_atom_37799654)
			end
		end

		local mStats3 = {}
		local v19 = 0
		local v20 = nil
		local v21 = v5.turboGlaive == nil

		if not v21 then
			local v22 = __wf_atom_d2b2176d:__wf_atom_2a745663(
				v18:__wf_atom_9d5805d7(),
				434,
				instance:__wf_atom_1bb5b1ff(),
				instance
			) * 100
			v21 = v22 > 0

			if v21 and v22 < 100 then
				mStats3.BounceChance = fn2(fn8(v22), v22, nil)
			end
		end

		if v21 then
			if __wf_atom_010c2f81:IsA(__wf_atom_e65b2d71) then
				v20 = __wf_atom_010c2f81:__wf_atom_cb093cde(p3)
				v19 = v20:__wf_atom_6386920d():__wf_atom_37799654()
			end

			if v19 == 0 then
				if __wf_atom_3d08948b:IsA(__wf_atom_b734e29f) then
					v20 = __wf_atom_3d08948b:__wf_atom_cb093cde(p3)
				else
					v20 = instance:__wf_atom_c34c33a3(false, v18)
				end

				v19 = v20:__wf_atom_6386920d():__wf_atom_37799654()
			end
		end

		if v19 > 0 then
			fn12(mStats3, v20, isA, v2 * module.Ternary(p3, ternary, 1))
			local v22 = math.max(v20.fallOff * 100, 0)
			mStats3.DamageFallOff = fn2(fn8(v22), v22, nil)
		end

		local v22 = false

		if instance:__wf_atom_1741efdd(v18) then
			local v23 = {
				WeakResource("/Lotus/Weapons/Corpus/Bow/Longbow/CrpBowArrow"),
				WeakResource("/Lotus/Weapons/Corpus/Bow/Longbow/CrpBowArrowPvP")
			}
			local v24 = false

			for _, className in pairs(v23) do
				if not v18:IsA(className) then
					continue
				end

				v24 = true
				break
			end

			local __wf_atom_5419c63d2 = instance:__wf_atom_5419c63d(v18)
			local __wf_atom_37799654_2 = __wf_atom_5419c63d2:__wf_atom_6386920d():__wf_atom_37799654()

			if __wf_atom_37799654_2 > 0 then
				for j = 0, 19 do
					if not (__wf_atom_5419c63d2:__wf_atom_bf612a92(j) > 0) then
						continue
					end

					local damageTypeTag = getDamageTypeTag(j)

					if mStats2[j] == nil then
						mStats2[damageTypeTag] = fn2(nil, 0, nil)
					end

					mStats2[damageTypeTag] = fn10(mStats2[damageTypeTag].StatValue + __wf_atom_5419c63d2:__wf_atom_bf612a92(j) * __wf_atom_37799654_2)
				end
			end

			if v19 == 0 or __wf_atom_37799654 > 0 or v24 then
				v20 = instance:__wf_atom_c34c33a3(true, v18)

				if v20:__wf_atom_6386920d():__wf_atom_37799654() > 0 then
					v22 = true
					fn12(mStats3, v20, isA, v2 * module.Ternary(p3, ternary, 1), nil, "Embed")
					local __wf_atom_ff676b5f = instance:__wf_atom_ff676b5f(v18)
					local v25

					if __wf_atom_ff676b5f.minValue == __wf_atom_ff676b5f.maxValue then
						v25 = module.FormatNumber(__wf_atom_ff676b5f.minValue, 1)
					else
						v25 = module.FormatNumber(__wf_atom_ff676b5f.minValue, 1) .. " - " .. module.FormatNumber(__wf_atom_ff676b5f.maxValue, 1)
					end

					if v25 ~= nil then
						local __wf_atom_48a8e71b = __wf_atom_ff676b5f:__wf_atom_48a8e71b(0.5)

						if __wf_atom_48a8e71b > 0 then
							mStats3.EmbedDelay = fn2(v25, __wf_atom_48a8e71b, nil)
						end
					end

					local v26 = math.max(v20.fallOff * 100, 0)
					mStats3.EmbedFallOff = fn2(fn8(v26), v26, nil)
				end
			end
		end

		if next(mStats3) then
			mStats3.Range = fn2(
				module.FormatNumber(v20.radius, 2),
				v20.radius,
				nil,
				nil,
				module.Ternary(isA2, "MeleeRange", "AoERange")
			)
			fn13(mStats3, isA, v7, module.Ternary(v22, "Embed", nil))
			table.insert(result, {
				mName = mMovie:__wf_atom_8e9ac384(
					v5.turboGlaive ~= nil and "/Lotus/Language/Labels/AVATAR_BOUNCE_ATTACK" or v10 and "/Lotus/Language/Stats/ChargedRadialAttack" or "/Lotus/Language/Labels/AVATAR_RADIAL_ATTACK",
					false
				),
				mIsMelee = isA2,
				mBehaviorIndex = v5.behaviorIndex,
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
			local v23 = __wf_atom_9ed189b9 / __wf_atom_693aebd2

			for j = 0, 19 do
				if mStats2[getDamageTypeTag(j)] ~= nil then
					mStats2[getDamageTypeTag(j)] = fn10(mStats2[getDamageTypeTag(j)].StatValue * v23)
				end
			end

			fn13(mStats3, isA, v7)
			__wf_atom_9ed189b9 = __wf_atom_693aebd2
			__wf_atom_693aebd2 = 1
		end

		if __wf_atom_3d08948b:__wf_atom_6515c58a() then
			mStats.EnergyPool = fn2(nil, instance2:__wf_atom_9ec4c360(), nil)
			local __wf_atom_cc34a29a = __wf_atom_3d08948b:__wf_atom_cc34a29a()

			if __wf_atom_414f70dd:__wf_atom_9ff2a58d() then
				local v23 = __wf_atom_cc34a29a * 100 * 3
				mStats.EnergyPerSecond = fn2(module.FormatNumber(v23) .. "/s", -v23, nil)
			else
				mStats.EnergyPerShot = fn2(module.FormatNumber(__wf_atom_cc34a29a), -__wf_atom_cc34a29a, nil)
			end
		elseif not (isA and instance:IsA(WeakResource("/Lotus/Weapons/CrewShip/RailjackOrdnanceWeapon"))) then
			local rounded = module.Round(instance:__wf_atom_2c6db744(p3))

			if rounded > 0 then
				mStats.Mag = fn2(nil, rounded, nil)
				mStats.AmmoReq = fn2(module.FormatNumber(__wf_atom_693aebd2), -__wf_atom_693aebd2, nil)
			end
		end

		if not v6 and (p3 or isA and instance:IsA(WeakResource("/Lotus/Weapons/CrewShip/RailjackOrdnanceWeapon"))) then
			local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(
				instance:__wf_atom_adc1a4dd(p3),
				254,
				instance:__wf_atom_180bd4bb()
			)

			if not p3 then
				__wf_atom_2a745663 = math.floor(__wf_atom_2a745663) + instance:GetClipSize()
			end

			if __wf_atom_2a745663 > 0 then
				mStats.MaxAmmo = fn2(nil, __wf_atom_2a745663, nil)
			end
		end

		if v5.turboGlaive == nil then
			local v23 = __wf_atom_9ed189b9 < 1 and 3 or 2

			if v6 and isA2 then
				mStats.FireRateMelee = fn2(module.FormatNumber(__wf_atom_9ed189b9, v23), __wf_atom_9ed189b9, nil)
			else
				mStats.FireRate = fn2(module.FormatNumber(__wf_atom_9ed189b9, v23), __wf_atom_9ed189b9, nil)
			end
		end

		if v6 and isA2 then
			local __wf_atom_0e370890 = instance:__wf_atom_0e370890()

			if __wf_atom_0e370890 ~= 25 then
				mStats.MeleeSkill = fn2(mMovie:__wf_atom_8e9ac384(
					"/SF/Language/Menu/" .. module3.GetMeleeStyleTag(__wf_atom_0e370890),
					false
				))
			end
		end

		for j = 0, 19 do
			local damageTypeTag = getDamageTypeTag(j)

			if mStats2[damageTypeTag] ~= nil then
				mStats2[damageTypeTag] = fn10(mStats2[damageTypeTag].StatValue * v2 * module.Ternary(p3, ternary, 1))
			end
		end

		fn22(
			mStats2,
			instance,
			v18,
			v17,
			v5.turboGlaive == true,
			__wf_atom_414f70dd,
			__wf_atom_3d08948b,
			__wf_atom_010c2f81,
			isA2,
			p3,
			__wf_atom_d2b2176d
		)

		if v6 then
			if isA2 then
				local __wf_atom_3c0505c6 = __wf_atom_010c2f81:__wf_atom_3c0505c6()
				local __wf_atom_37799654_2 = __wf_atom_3c0505c6:__wf_atom_6386920d():__wf_atom_37799654()

				if __wf_atom_37799654_2 > 0 then
					local v23 = -1
					local v24 = nil

					for j = 0, 19 do
						if not (__wf_atom_3c0505c6:__wf_atom_bf612a92(j) > 0) then
							continue
						end

						local __wf_atom_bf612a92 = __wf_atom_3c0505c6:__wf_atom_bf612a92(j)

						if v23 <= __wf_atom_bf612a92 then
							v24 = getDamageTypeTag(j)
							v23 = __wf_atom_bf612a92
						end

						local v25 = __wf_atom_bf612a92 * __wf_atom_37799654_2 * v7
						mStats2[getDamageTypeTag(j)] = fn10(v25)
					end

					if not __wf_atom_7e8ad928(v24) then
						mStats.DamageType = fn2(mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/" .. v24, false))
					end

					if instance:IsA(__wf_atom_9df43583) and instance:__wf_atom_bbd8a30c() then
						mStats.AttuneType = fn2(mMovie:__wf_atom_8e9ac384(
							"/SF/Language/Menu/" .. module2.GetAttributeTypeTag(instance:__wf_atom_fd8bb17d()),
							false
						))
					end

					if not v3 or v5.turboGlaive ~= nil then
						instance2:__wf_atom_9373d0eb(30, true)
						local rounded = fn20(__wf_atom_010c2f81:__wf_atom_305bafa7(4))
						local __wf_atom_d7a8ea46 = __wf_atom_010c2f81:__wf_atom_d7a8ea46(4)
						local v25 = __wf_atom_7e8ad928(__wf_atom_d7a8ea46) and 1
							or __wf_atom_d7a8ea46:__wf_atom_7ee4ff02()
						local formatNumber = module.FormatNumber(rounded, module.Ternary(rounded < 999.9, 0, 0))

						if v25 > 1 then
							formatNumber ..= " x" .. module.FormatNumber(v25)
						end

						if
							not __wf_atom_7e8ad928(__wf_atom_414f70dd)
							and __wf_atom_414f70dd:IsA(__wf_atom_27b2ed0b)
						then
							rounded = module.Round(rounded * __wf_atom_414f70dd:__wf_atom_485e3a02().maxValue)
						end

						local __wf_atom_4900a295 = instance:__wf_atom_4900a295(instance:__wf_atom_fd8bb17d())
						mStats2.HeavyAttack = fn2(fn9(rounded, __wf_atom_4900a295), rounded + __wf_atom_4900a295)
						instance2:__wf_atom_9373d0eb(30, false)
					end

					table.insert(result, {
						mIsMelee = false,
						mBehaviorIndex = v5.behaviorIndex,
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
						mStats.SlideAttack = fn10(fn20(__wf_atom_010c2f81:__wf_atom_305bafa7(7)))
						local __wf_atom_75a0566d = instance:__wf_atom_75a0566d()
						local __wf_atom_dfdf4c3f = __wf_atom_010c2f81:__wf_atom_dfdf4c3f()

						if __wf_atom_dfdf4c3f > 0 then
							mStats.ComboCount = fn2(module.FormatNumber(__wf_atom_dfdf4c3f, 1), __wf_atom_dfdf4c3f, nil)
						end

						local __wf_atom_e7b6034a = __wf_atom_010c2f81:__wf_atom_e7b6034a()

						if __wf_atom_e7b6034a > 0 then
							local v23 = __wf_atom_e7b6034a * 100
							mStats.ComboEfficiency = fn2(fn8(v23), v23, nil)
						end

						local __wf_atom_609f0f8e = __wf_atom_010c2f81:__wf_atom_609f0f8e()
						local __wf_atom_8aae89a6 = __wf_atom_010c2f81:__wf_atom_8aae89a6(true)
						local formatNumber = module.FormatNumber(__wf_atom_8aae89a6, 1)

						if __wf_atom_609f0f8e and __wf_atom_8aae89a6 ~= 0 then
							formatNumber = mMovie:__wf_atom_8e9ac384("<INFINITE_SMALL>", true)
							__wf_atom_8aae89a6 = 1e999
						end

						mStats.ComboDuration = fn2(formatNumber, __wf_atom_8aae89a6, nil)
						local __wf_atom_c77ef029 = instance:__wf_atom_c77ef029()
						mStats.BlockingAngle = fn2(
							module.FormatNumber(__wf_atom_c77ef029, 1),
							__wf_atom_c77ef029,
							nil,
							nil,
							nil,
							__wf_atom_c77ef029
						)
						local __wf_atom_607ab529 = instance:__wf_atom_607ab529()
						mStats.SlamAttackRadius = fn2(
							module.FormatNumber(__wf_atom_607ab529, 1),
							__wf_atom_607ab529,
							nil
						)
						mStats.SlamAttackRadialDamage = fn10(instance:__wf_atom_0c847e11())
						local mStats4 = {}

						if not __wf_atom_7e8ad928(__wf_atom_75a0566d) then
							local v23 = __wf_atom_75a0566d:__wf_atom_21eeed05() / __wf_atom_d2b2176d:__wf_atom_2a745663(
								1,
								368,
								instance:__wf_atom_1bb5b1ff(),
								instance
							)
							mStats4.HeavyAttackWindUp = fn2(module.FormatNumber(v23, 1), -v23, nil)
						end

						local v23 = Symbol("HeavySlam")
						local __wf_atom_607ab529_2 = instance:__wf_atom_607ab529(v23)
						mStats4.HeavySlamAttackRadius = fn2(
							module.FormatNumber(__wf_atom_607ab529_2, 1),
							__wf_atom_607ab529_2,
							nil
						)
						local __wf_atom_0c847e11 = instance:__wf_atom_0c847e11(v23)

						if __wf_atom_0c847e11 > 0 then
							mStats4.HeavySlamAttackRadialDamage = fn10(__wf_atom_0c847e11)
						end

						local _ = {
							mIsMelee = true,
							mBehaviorIndex = v5.behaviorIndex,
							mStats = mStats4,
							mExtra = true
						}
					end
				end
			elseif v3 and v5.turboGlaive ~= nil then
				local __wf_atom_c34c33a3 = instance:__wf_atom_c34c33a3(false, v18)
				local v23 = math.max(v18:__wf_atom_1ea3f9f9() * 100, 0)
				local mStats4 = {
					DamageFallOff = fn2(fn8(v23), v23, nil),
					Range = fn2(
						module.FormatNumber(__wf_atom_c34c33a3.radius, 2),
						__wf_atom_c34c33a3.radius,
						nil,
						nil,
						module.Ternary(isA2, "MeleeRange", "AoERange")
					)
				}
				local v24 = v2 * module.Ternary(p3, ternary, 1) * v18:__wf_atom_32ef0df9()

				if next(mStats2) then
					fn14(mStats4, __wf_atom_c34c33a3, isA, v24, 1)
				end

				table.insert(result, {
					mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Labels/AVATAR_HEAVY_ATTACK", false),
					mBehaviorIndex = v5.behaviorIndex,
					mStats = mStats4,
					mExtra = true
				})
			end
		else
			mStats.Accuracy = fn2(nil, 100, nil)
			local __wf_atom_4bd22419 = __wf_atom_3d08948b:__wf_atom_4bd22419(true)

			if __wf_atom_3d08948b:__wf_atom_4bd22419(true, 0.5, false) == 0 then
				__wf_atom_4bd22419 += 1
			end

			if __wf_atom_4bd22419 > 0 then
				local v23 = 1 / __wf_atom_4bd22419 * 100
				mStats.Accuracy = fn2(module.FormatNumber(v23, 1), v23, nil)
			end

			if __wf_atom_3d08948b:__wf_atom_6515c58a() then
				local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(instance2:__wf_atom_916d1145(), 118)
				mStats.RechargeRate = fn2(module.FormatNumber(__wf_atom_2a745663) .. "/s", __wf_atom_2a745663, nil)
				local __wf_atom_618d3b84 = instance2:__wf_atom_618d3b84()
				mStats.RechargeDelay = fn2(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ProgressSeconds", false, {
						CURRENT = module.FormatNumber(__wf_atom_618d3b84, 1)
					}),
					-__wf_atom_618d3b84,
					nil
				)
			else
				local __wf_atom_0d147834 = instance:__wf_atom_0d147834()
				mStats.Reload = fn2(module.FormatNumber(__wf_atom_0d147834, 1), -__wf_atom_0d147834, nil)
			end

			if
				__wf_atom_3d08948b:IsA(WeakResource("/Lotus/Types/Game/LotusWeaponProjectileFireBehavior"))
				and __wf_atom_3d08948b:__wf_atom_9741f03e() ~= 0
			then
				fn22(
					mStats,
					instance,
					v18,
					v17,
					v5.turboGlaive == true,
					__wf_atom_414f70dd,
					__wf_atom_3d08948b,
					__wf_atom_010c2f81,
					isA2,
					p3,
					__wf_atom_d2b2176d
				)
			end
		end

		local v23 = 1

		if isA2 then
			if not v6 then
				v23 = v7
			end
		else
			v23 = v7
		end

		fn13(mStats2, isA, v23)
		local statValue = mStats2.Total.StatValue
		local __wf_atom_4900a295 = instance:__wf_atom_4900a295(instance:__wf_atom_fd8bb17d())
		mStats2.Total = fn2(fn9(statValue, __wf_atom_4900a295), statValue + __wf_atom_4900a295)

		if v13 then
			table.insert(result, v11)
		end

		if v12 ~= nil then
			table.insert(result, v12)
		end

		if instance:IsA(__wf_atom_9df43583) and mMovie:Execute("ShouldShowOmegaAttenStat", "") then
			local __wf_atom_83ee63eb = instance:__wf_atom_83ee63eb()
			local v24

			if __wf_atom_83ee63eb < 0.7 then
				v24 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/WeaponStats_OmegaAttenLowest", true)
			elseif __wf_atom_83ee63eb < 0.9 then
				v24 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/WeaponStats_OmegaAttenLow", true)
			elseif __wf_atom_83ee63eb <= 1.109 then
				v24 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/WeaponStats_OmegaAttenMedium", true)
			elseif __wf_atom_83ee63eb <= 1.309 then
				v24 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/WeaponStats_OmegaAttenHigh", true)
			else
				v24 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/WeaponStats_OmegaAttenHighest", true)
			end

			mStats.OmegaAtten = fn2(v24, __wf_atom_83ee63eb, nil)
		end

		if __wf_atom_3d08948b:IsA(__wf_atom_0cf1ac41) then
			if __wf_atom_3d08948b:__wf_atom_243e3801() then
				mStats.Punchthrough = fn2(mMovie:__wf_atom_8e9ac384("<INFINITE_SMALL>", true), 4294967295, nil)
			else
				local __wf_atom_d51d61ec = __wf_atom_3d08948b:__wf_atom_d51d61ec()

				if __wf_atom_d51d61ec > 0 then
					mStats.Punchthrough = fn2(module.FormatNumber(__wf_atom_d51d61ec, 1), __wf_atom_d51d61ec, nil)
				end
			end
		elseif __wf_atom_3d08948b:IsA(__wf_atom_ed85f483) then
			local v24 = false
			local v25

			if v5.turboGlaive == true then
				v25 = instance:__wf_atom_d2f478d5(__wf_atom_3d08948b:__wf_atom_47ef92e7(p3))
			else
				local __wf_atom_1cda18ff = __wf_atom_3d08948b:__wf_atom_1cda18ff()

				if not __wf_atom_7e8ad928(__wf_atom_1cda18ff) and __wf_atom_1cda18ff:IsA(__wf_atom_014b4ff7) then
					local v26 = Resource(__wf_atom_1cda18ff)

					if not __wf_atom_7e8ad928(v26) then
						v24 = not v26:__wf_atom_d6e8992a()
					end
				end

				v25 = instance:__wf_atom_d2f478d5(__wf_atom_3d08948b:__wf_atom_1cda18ff())
			end

			if v24 then
				mStats.Punchthrough = fn2(mMovie:__wf_atom_8e9ac384("<INFINITE_SMALL>", true), 4294967295, nil)
			elseif v25 > 0 then
				mStats.Punchthrough = fn2(module.FormatNumber(v25, 1), v25, nil)
			end
		end

		local damageFallOff

		if __wf_atom_3d08948b:IsA(__wf_atom_ed85f483) and not __wf_atom_3d08948b:__wf_atom_9a97ee4c() then
			damageFallOff = instance:__wf_atom_3e2dbe2f(__wf_atom_3d08948b:__wf_atom_1cda18ff(), false)
		else
			damageFallOff = __wf_atom_010c2f81.damageFallOff
		end

		if damageFallOff.maxValue > 0 then
			local v24 = {
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

			if v24.maxValue > 0 then
				mStats.DamageFallOff = fn2(
					module.FormatNumber(v24.minValue, module.Ternary(v24.minValue < 999.9, 1, 0)) .. " - " .. module.FormatNumber(
						v24.maxValue,
						module.Ternary(v24.maxValue < 999.9, 1, 0)
					),
					v24.minValue,
					false,
					true
				)
			else
				mStats.DamageFallOff = fn2("0", 0, false, true)
			end
		end

		fn16(instance, mStats)
		fn18(__wf_atom_d2b2176d, v5.upgrades)
		fn19(mStats, v5.unusedStats)
	end

	if not __wf_atom_7e8ad928(instance) and instance:__wf_atom_5e005c29() ~= 0 then
		instance:SetBehavior(0)
	end

	fn21(instance, result)

	if p4 then
		for i = 1, #result do
			if i == 1 then
				continue
			end

			local v5 = result[1]
			local v6 = result[i]

			for k in pairs(v6.mStats) do
				if __wf_atom_7e8ad928(k) then
					continue
				end

				local mStat = v5.mStats[k]
				local mStat2 = v6.mStats[k]

				if
					__wf_atom_7e8ad928(mStat)
					or __wf_atom_7e8ad928(mStat2)
					or mStat2.DisplayValue ~= mStat.DisplayValue
				then
					continue
				end

				v6.mStats[k] = nil
			end
		end
	end

	if p5 then
		instance:__wf_atom_be4ffd28()
		instance:__wf_atom_88686970(false)
	end

	return result
end

local function fn25()
	local v2 = 2
	local v3 = getfenv(v2)

	while not v3.mMovie do
		v2 += 1
		v3 = getfenv(v2)
	end

	return v3
end

local function fn26(instance, object, p, p2, p3, list, list2)
	local mMovie = fn25().mMovie
	local result = {}
	local mStats = nil

	if __wf_atom_7e8ad928(instance) then
		return result
	end

	local function fn27(p4, p5)
		if list2 == nil then
			if list ~= nil then
				for i = 1, #list do
					if list[i] == p4 then
						return
					end
				end
			end
		else
			local v2 = false

			for i = 1, #list2 do
				if list2[i] ~= p4 then
					continue
				end

				v2 = true
				break
			end

			if not v2 then
				return
			end
		end

		local v2 = mStats[p4]

		if v2 == nil then
			return
		end

		if not p then
			p5 = mMovie:__wf_atom_8e9ac384(p5, true)
		end

		v2.Label = TitleCase(p5)
		v2.Key = p4
	end

	local v2 = fn4(instance)
	local flag = false
	local isA = instance:IsA(__wf_atom_dd81e462)
	local v3 = {}
	local v4 = _T.ArsenalState == 2
	local v5 = instance:IsA(WeakResource("/Lotus/Types/Vehicles/Hoverboard/HoverboardSuit")) and true or false
	local v6

	if instance:IsA(WeakResource("/SF/Types/Game/Pets/PetPowerSuit")) and not __wf_atom_7e8ad928(object) then
		v6 = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
		local v7 = WeakResource("/Lotus/Types/NeutralCreatures/Kubrow/KubrowMeleeWeapon")
		local v8 = WeakResource("/Lotus/Types/Friendly/Pets/CatbrowPetMeleeWeapon")

		if __wf_atom_7e8ad928(v6) or not (v6:IsA(v7) or v6:IsA(v8)) then
			v6 = instance
		else
			flag = true
		end
	else
		v6 = instance
	end

	if not isA and v2 and not (flag or v5) then
		local v7 = fn6(mMovie, object, instance, v4)

		if v7 == nil then
			return {}
		end

		mStats = v7.mStats
		fn27("Health", "/Lotus/Language/Labels/AVATAR_HEALTH_MAX")
		fn27("Shield", "/Lotus/Language/Labels/AVATAR_SHIELD")
		fn27("Armor", "/Lotus/Language/Labels/AVATAR_ARMOUR")
		fn27("Power", "/Lotus/Language/Labels/AVATAR_ABILITY")
		fn27("Stamina", "/Lotus/Language/Labels/AVATAR_STAMINA")
		fn27("Mult_SprintSpeed", "/Lotus/Language/Labels/AVATAR_SPRINT_SPEED")
		fn27("ParkourBoost", "/Lotus/Language/Menu/WeaponStats_Bullet_Glide")

		for i = 0, 19 do
			local v8 = module3.GetDamageTypeTag(i) .. "_RESIST"

			if mStats[v8] ~= nil then
				fn27(v8, "/Lotus/Language/Game/" .. v8)
			end
		end

		local isA2 = instance:IsA(WeakResource("/Lotus/Powersuits/Alchemist/AlchemistBaseSuit"))
		fn27("Power_Strength", "/Lotus/Language/Labels/AVATAR_ABILITY_STRENGTH")

		if isA2 then
			fn27(
				"Status_Duration_Lavos",
				mMovie:__wf_atom_8e9ac384("<WARNING> ", true) .. mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Labels/WEAPON_PROC_TIME",
					true
				)
			)
			fn27(
				"Power_Efficiency_Lavos",
				mMovie:__wf_atom_8e9ac384("<WARNING> ", true) .. mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Labels/AVATAR_ABILITY_EFFICIENCY",
					true
				)
			)
		else
			fn27("Power_Efficiency", "/Lotus/Language/Labels/AVATAR_ABILITY_EFFICIENCY")
		end

		fn27("Power_Range", "/Lotus/Language/Labels/AVATAR_ABILITY_RANGE")
		fn27("Power_Duration", "/Lotus/Language/Labels/AVATAR_ABILITY_DURATION")
		result = { v7 }
	end

	if v5 then
		local motionControl = instance:__wf_atom_95e72410():MotionControl()

		if not __wf_atom_7e8ad928(motionControl) and motionControl:IsA(__wf_atom_71e79ef7) then
			result = {
				{ mName = "", mStats = {}, mIsMelee = false }
			}
			local mStats2 = result[1].mStats
			local __wf_atom_7e274063 = motionControl:__wf_atom_7e274063()
			local __wf_atom_d3807c01 = motionControl:__wf_atom_d3807c01(true)
			local __wf_atom_25a40c58 = motionControl:__wf_atom_25a40c58(true, true)
			local __wf_atom_9f4152b2 = motionControl:__wf_atom_9f4152b2()
			local __wf_atom_54cfb38b = motionControl:__wf_atom_54cfb38b()
			mStats2.JumpHeight = fn2(module.FormatNumber(__wf_atom_7e274063, 2), __wf_atom_7e274063, nil, true)
			mStats2.VehicleSpeed = fn2(module.FormatNumber(__wf_atom_d3807c01, 2), __wf_atom_d3807c01, nil, true)
			mStats2.BoostSpeed = fn2(module.FormatNumber(__wf_atom_25a40c58, 2), __wf_atom_25a40c58, nil, true)
			mStats2.DoubleJumpHeight = fn2(module.FormatNumber(__wf_atom_9f4152b2, 2), __wf_atom_9f4152b2, nil, true)
			mStats2.JumpChargeTime = fn2(module.FormatNumber(__wf_atom_54cfb38b, 2), -__wf_atom_54cfb38b, nil, true)
			mStats = result[1].mStats
			fn27("JumpHeight", "/Lotus/Language/Labels/VEHICLE_JUMP_HEIGHT")
			fn27("VehicleSpeed", "/Lotus/Language/Labels/VEHICLE_SPEED")
			fn27("BoostSpeed", "/Lotus/Language/Labels/VEHICLE_SPRINT_SPEED")
			fn27("JumpChargeTime", "/Lotus/Language/Labels/VEHICLE_JUMP_CHARGE_TIME")
			fn27("DoubleJumpHeight", "/Lotus/Language/Labels/VEHICLE_DOUBLE_JUMP_HEIGHT")
		end
	end

	if not v2 and fn3(instance) and not flag or isA then
		local v7

		if isA then
			v7 = instance:__wf_atom_f9b4c62f()
		else
			v7 = instance
		end

		result = fn24(mMovie, v7, object, 1, v3, v4, p2, p3)
		local v8 = instance:__wf_atom_3b0e8ae3() == 13

		if result == nil then
			result = {}
		elseif isA then
			result[1].mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/TacCallPilot", false) .. " - " .. mMovie:__wf_atom_8e9ac384(
				v7:__wf_atom_014a76a2():c_str(),
				false
			)
			local __wf_atom_1b81911f = instance:__wf_atom_1b81911f()
			local v9 = fn24(mMovie, __wf_atom_1b81911f, object, 1, v3, v4, p2, p3)

			if v9 ~= nil then
				v9[1].mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/RailjackGunnery", false) .. " - " .. mMovie:__wf_atom_8e9ac384(
					__wf_atom_1b81911f:__wf_atom_014a76a2():c_str(),
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
			local isA2 = __wf_atom_414f70dd:IsA(WeakResource("/SF/Types/Weapon/GlaiveAlternateGrenadeStateBehavior"))

			for i = 0, 19 do
				local damageTypeTag = module3.GetDamageTypeTag(i, isA or false)

				if mStats[damageTypeTag] ~= nil then
					fn27(damageTypeTag, "/Lotus/Language/Game/" .. damageTypeTag)
				end

				if mStats["Embed" .. damageTypeTag] ~= nil then
					fn27("Embed" .. damageTypeTag, "/Lotus/Language/Game/" .. damageTypeTag)
				end
			end

			fn27("Total", "/SF/Language/Menu/Damage")
			fn27("Range", "/Lotus/Language/Labels/AVATAR_RANGE")
			fn27("HeavyAttack", "/SF/Language/Menu/HeavyDamage")
			fn27("KintsugiName", "/SF/Language/Menu/Kintsugi")
			fn27("KintsugiEffect", "")

			if not v9.mIsMelee then
				fn27("Accuracy", "/Lotus/Language/Labels/WEAPON_SPREAD")
				fn27("EmbedDelay", "/Lotus/Language/Labels/WEAPON_EMBED_DELAY")
				fn27("EmbedFallOff", "/Lotus/Language/Game/WEAPON_FALLOFF")
			end

			if not (v8 or isA2) then
				if v9.mIsMelee then
					fn27("MeleeSkill", "/SF/Language/Menu/MeleeSkill")
					fn27("AttuneType", "/SF/Language/Menu/AttuneType")
					fn27("DamageType", "/SF/Language/Menu/DamageType")
				else
					fn27("FireRate", "/Lotus/Language/Labels/WEAPON_FIRE_RATE")
				end
			end

			if v4 then
				fn27("HeadShotMult", "/Lotus/Language/Labels/WEAPON_HEADSHOT_MULTIPLIER")
			else
				fn27("CriticalChance", "/Lotus/Language/Labels/WEAPON_CRIT_CHANCE")
			end

			if __wf_atom_414f70dd:IsA(WeakResource("/EE/Types/Game/WeaponChargedStateBehavior")) then
				fn27("ChargeRate", "/Lotus/Language/Labels/WEAPON_CHARGE_RATE")
			end

			fn27("ProcChance", "/Lotus/Language/Labels/WEAPON_PROC")
			fn27("ProcChancePerShot", "/Lotus/Language/Game/StatusPerProjectile")
			fn27("EnergyPool", "/Lotus/Language/Labels/ENERGY_POOL")
			fn27("EnergyPerSecond", "/Lotus/Language/Labels/ENERGY_PER_SECOND")
			fn27("EnergyPerShot", "/Lotus/Language/Labels/ENERGY_PER_SHOT")

			if not isA2 then
				if isA then
					fn27("Mag", "/Lotus/Language/Labels/WEAPON_HEAT_CLIP")
					fn27("AmmoReq", "/Lotus/Language/Labels/WEAPON_HEAT_GENERATION")
				else
					fn27("Mag", "/Lotus/Language/Labels/WEAPON_CLIP")
				end
			end

			fn27("MaxAmmo", "/Lotus/Language/Labels/WEAPON_AMMO_MAX")

			if v9.mIsMelee then
				fn27("Stamina", "/Lotus/Language/Labels/AVATAR_STAMINA")
			else
				fn27("RechargeRate", "/Lotus/Language/Labels/RECHARGE_RATE")
				fn27("RechargeDelay", "/Lotus/Language/Labels/RECHARGE_DELAY")
				fn27("DT_StackDamage", "/Lotus/Language/Labels/WEAPON_STACKDAMAGE")
				fn27("Noise", "/Lotus/Language/Labels/WEAPON_NOISE")
				fn27("Multishot", "/Lotus/Language/Labels/WEAPON_FIRE_ITERATIONS")

				if not isA2 then
					fn27("Reload", "/Lotus/Language/Labels/WEAPON_RELOAD")
					fn27("Trigger", "/Lotus/Language/Labels/WEAPON_TRIGGER")
				end
			end

			fn27("OmegaAtten", "/Lotus/Language/Menu/WeaponStats_OmegaAttenuationTitle")
			fn27("Punchthrough", "/Lotus/Language/Labels/WEAPON_PUNCTURE_DEPTH")
			fn27("DamageFallOff", "/Lotus/Language/Game/WEAPON_FALLOFF")
			fn27("BounceChance", "/Lotus/Language/Labels/BOUNCE_CHANCE")
		end
	end

	if isA then
		local v7 = fn5(mMovie, object, instance)

		if v7 == nil then
			return {}
		end

		mStats = v7.mStats
		fn27("Shield", "/Lotus/Language/Labels/AVATAR_SHIELD")
		fn27("Engines", "/Lotus/Language/Railjack/BonusEngine")
		fn27("EngineBoost", "/Lotus/Language/Railjack/BonusEngineBoost")
		fn27("RailjackHealth", "/Lotus/Language/Labels/RAILJACK_HEALTH_MAX")
		fn27("Armor", "/Lotus/Language/Labels/AVATAR_ARMOUR")
		fn27("ShieldRechargeRate", "/Lotus/Language/Labels/AVATAR_SHIELD_RECHARGE_RATE")
		fn27("ShieldRechargeDelay", "/Lotus/Language/Labels/AVATAR_SHIELD_RECHARGE_DELAY")
		fn27("ElementRedirection", "/Lotus/Language/Labels/AVATAR_SHIELD_REDIRECTION")
		fn27("DT_FIRE", "/Lotus/Language/Labels/FIRE_RESIST")
		fn27("DT_ELECTRICITY", "/Lotus/Language/Labels/ELECTRICITY_RESIST")
		fn27("DT_POISON", "/Lotus/Language/Labels/POISON_RESIST")
		fn27("DT_FREEZE", "/Lotus/Language/Labels/FREEZE_RESIST")
		fn27("CargoCapacity", "/Lotus/Language/Labels/RAILJACK_CARGO_CAPACITY")
		fn27("Railjack_Power_Strength", "/Lotus/Language/Labels/RAILJACK_POWER_STRENGTH")
		fn27("Railjack_Power_Duration", "/Lotus/Language/Labels/RAILJACK_POWER_DURATION")
		fn27("Railjack_Power_Range", "/Lotus/Language/Labels/RAILJACK_POWER_RANGE")
		table.insert(result, 1, v7)
	end

	if flag then
		result = fn24(mMovie, v6, object, 1, v3, v4, p2)
		fn6(mMovie, object, instance, v4, result[1])

		if result[1] ~= nil then
			result[1].mName = ""
		end

		for _, v7 in ipairs(result) do
			mStats = v7.mStats
			local menuSuitAvatar = _T.MenuSuitAvatar

			if __wf_atom_7e8ad928(menuSuitAvatar) then
				menuSuitAvatar = module3.GetMainMenuSuitAvatar()
			end

			if not (__wf_atom_7e8ad928(menuSuitAvatar) or __wf_atom_7e8ad928(object)) then
				local __wf_atom_28224c27 = menuSuitAvatar:__wf_atom_d2b2176d():__wf_atom_28224c27(1)

				if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
					local __wf_atom_483e7ddc = __wf_atom_28224c27:__wf_atom_483e7ddc()
					local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
						__wf_atom_483e7ddc.criticalChance,
						141,
						instance:__wf_atom_1bb5b1ff(),
						instance
					)

					if not __wf_atom_7e8ad928(mStats.CriticalChance) then
						local v8 = mStats.CriticalChance.StatValue / 100 + (__wf_atom_2a745663 - __wf_atom_483e7ddc.criticalChance)
						mStats.CriticalChance.DisplayValue = module.FormatNumber(v8 * 100, 1) .. "%"
						mStats.CriticalChance.StatValue = v8 * 100
					end

					if not __wf_atom_7e8ad928(mStats.ProcChance) then
						local v8 = v6:__wf_atom_483e7ddc().baseProcChance + __wf_atom_483e7ddc.baseProcChance * object:__wf_atom_d2b2176d():__wf_atom_2a745663(0, 150)
						mStats.ProcChance.DisplayValue = module.FormatNumber(v8 * 100, 1) .. "%"
						mStats.ProcChance.StatValue = v8 * 100
					end
				end
			end

			fn27("Health", "/Lotus/Language/Labels/AVATAR_HEALTH_MAX")
			fn27("Shield", "/Lotus/Language/Labels/AVATAR_SHIELD")
			fn27("Armor", "/Lotus/Language/Labels/AVATAR_ARMOUR")
			fn27("Power", "/Lotus/Language/Labels/AVATAR_ABILITY")
			fn27("Stamina", "/Lotus/Language/Labels/AVATAR_STAMINA")
			fn27("Mult_SprintSpeed", "/Lotus/Language/Labels/AVATAR_SPRINT_SPEED")
			fn27("ParkourBoost", "/Lotus/Language/Menu/WeaponStats_Bullet_Glide")
			fn27("Power_Strength", "/Lotus/Language/Labels/AVATAR_ABILITY_STRENGTH")
			fn27("Power_Efficiency", "/Lotus/Language/Labels/AVATAR_ABILITY_EFFICIENCY")
			fn27("Power_Range", "/Lotus/Language/Labels/AVATAR_ABILITY_RANGE")
			fn27("Power_Duration", "/Lotus/Language/Labels/AVATAR_ABILITY_DURATION")

			for i = 0, 19 do
				local damageTypeTag = module3.GetDamageTypeTag(i)

				if mStats[damageTypeTag] ~= nil then
					fn27(damageTypeTag, "/Lotus/Language/Game/" .. damageTypeTag)
				end
			end

			fn27("CriticalChance", "/Lotus/Language/Labels/WEAPON_CRIT_CHANCE")

			if v6:__wf_atom_414f70dd(v7.mBehaviorIndex):IsA(WeakResource("/EE/Types/Game/WeaponChargedStateBehavior")) then
				fn27("ChargeRate", "/Lotus/Language/Labels/WEAPON_CHARGE_RATE")
			end

			fn27("ProcChance", "/Lotus/Language/Labels/WEAPON_PROC")
			fn27("Total", "/Lotus/Language/Menu/Store_Total")
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

local function fn27(list, list2)
	local mMovie = fn25().mMovie
	local v2 = " " .. mMovie:__wf_atom_8e9ac384("<MINI_ARROW>", true) .. " "
	local v3 = math.min(#list, #list2)
	local result = {}

	for i = 1, v3 do
		local v4 = list[i]
		local v5 = list2[i]
		local mName = ""

		if fn(v4.mName) or fn(v5.mName) then
			if fn(v4.mName) then
				mName = v5.mName
			elseif fn(v5.mName) then
				mName = v4.mName
			end
		elseif v5.mName == v4.mName then
			mName = v5.mName
		else
			mName = v4.mName .. v2 .. v5.mName
		end

		local v6 = { mName = mName, mStats = {} }
		local mStats = v6.mStats
		local flag = true

		for _, mStat in pairs(v4.mStats) do
			if mStat ~= nil and mStat.Key ~= nil then
				mStats[mStat.Key] = {
					Label = mStat.Label,
					TextOnly = mStat.TextOnly or mStat.TextIfOneNil,
					TextIfOneNil = mStat.TextIfOneNil,
					SmallerIsBetter = mStat.SmallerIsBetter,
					Previous = fn2(mStat.DisplayValue, mStat.StatValue, nil, nil, mStat.ToolTip),
					Current = {},
					Hidden = mStat.Hidden,
					ForceOrder = mStat.ForceOrder
				}
			end
		end

		for _, mStat in pairs(v5.mStats) do
			if not (mStat ~= nil and mStat.Key ~= nil) then
				continue
			end

			if mStats[mStat.Key] == nil then
				mStats[mStat.Key] = {
					Label = mStat.Label,
					TextOnly = mStat.TextOnly or mStat.TextIfOneNil,
					TextIfOneNil = mStat.TextIfOneNil,
					SmallerIsBetter = mStat.SmallerIsBetter,
					Current = fn2(mStat.DisplayValue, mStat.StatValue, nil, nil, mStat.ToolTip),
					Previous = {},
					ForceOrder = mStat.ForceOrder
				}
				flag = false
			else
				mStats[mStat.Key].Current = fn2(mStat.DisplayValue, mStat.StatValue, nil, nil, mStat.ToolTip)
				mStats[mStat.Key].TextOnly = mStats[mStat.Key].TextOnly or mStat.TextOnly
				mStats[mStat.Key].TextIfOneNil = mStats[mStat.Key].TextIfOneNil or mStat.TextIfOneNil

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
			v6.mName = v5.mName
		end

		table.insert(result, v6)
	end

	local count = #list
	local count2 = #list2

	if math.abs(count - count2) == 0 then
		return result
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/NotAvailable", false)
	local ternary = module.Ternary(count < count2, list2, list)

	for i = v3 + 1, #ternary do
		local mName = ternary[i].mName

		if list2 ~= nil and list ~= nil then
			if count < count2 then
				mName = __wf_atom_8e9ac384 .. v2 .. mName
			else
				mName ..= v2 .. __wf_atom_8e9ac384
			end
		end

		local v4 = { mName = mName, mStats = {} }
		local mStats = v4.mStats

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

		table.insert(result, v4)
	end

	return result
end

local function fn28(state)
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
	local v2 = Symbol("GetAbilityUpgradeLevelInfo")
	_T.AbilityLevelQueryParms = {
		ForceOverride = state.ForceOverride,
		Level = (state.Level or 0) + 1,
		Ability = state.Resource,
		Avatar = menuSuitAvatar,
		Modded = false
	}
	menuSuitAvatar:__wf_atom_51009507(state.Script, v2, true)
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
			table.insert(
				result,
				1,
				(TitleCase(movie:__wf_atom_8e9ac384("/Lotus/Language/Labels/GAMEPLAY_POWER_COOLDOWN", false)))
			)
			table.insert(result2, 1, __wf_atom_8e9ac384_2 .. " " .. __wf_atom_de7e7709)
			table.insert(result3, 1, __wf_atom_de7e7709)
			table.insert(result4, 1, 0)
		end
	end

	if state.Energy ~= nil then
		local v3 = TitleCase(movie:__wf_atom_8e9ac384(state.EnergyLabel or "/SortingLabels/CapacityRequirement", false))
		local energy = tonumber(state.Energy)
		local baseEnergy = tonumber(state.BaseEnergy)

		if baseEnergy == nil then
			baseEnergy = energy
		end

		local v4 = baseEnergy - energy
		local __wf_atom_8e9ac384_2 = movie:__wf_atom_8e9ac384(state.EnergyIconOverride or "<ENERGY>", true)
		local ternary = module.Ternary(
			energy == 3.4028234663852886e38,
			__wf_atom_8e9ac384,
			module.FormatNumber(energy, 2, false)
		)

		if state.ModdedStats or v4 == 0 then
			ternary = __wf_atom_8e9ac384_2 .. " " .. ternary
		else
			baseEnergy = __wf_atom_8e9ac384_2 .. " " .. baseEnergy
		end

		if state.EnergyFormatting ~= nil then
			ternary = movie:__wf_atom_8e9ac384(state.EnergyFormatting, true, { COUNT = ternary })
		end

		table.insert(result, 1, v3)
		table.insert(result2, 1, ternary)
		table.insert(result3, 1, baseEnergy)
		table.insert(result4, 1, v4)
	end

	_T.AbilityLevelQueryParms = {
		ForceOverride = state.ForceOverride,
		Level = (state.Level or 0) + 1,
		Ability = state.Resource,
		Avatar = menuSuitAvatar,
		Modded = not state.BaseOnly
	}
	menuSuitAvatar:__wf_atom_51009507(state.Script, v2, true)
	local abilityUpgradeLevelInfo2 = _T.AbilityUpgradeLevelInfo
	state.mDarken = abilityUpgradeLevelInfo2 == nil or abilityUpgradeLevelInfo2.Modded == nil

	for i = 1, #abilityUpgradeLevelInfo2 do
		local v3 = abilityUpgradeLevelInfo2[i]
		local __wf_atom_8e9ac384_2 = movie:__wf_atom_8e9ac384(v3.Label, true, {})
		local count = v3.Value or ""
		local value = abilityUpgradeLevelInfo[i].Value or ""
		local v4 = count == value and 0
			or (v3.SmallerIsBetter and count < value or not v3.SmallerIsBetter and value < count) and 1
			or -1
		local v5

		if v3.Title then
			v5 = "<b>" .. __wf_atom_8e9ac384_2 .. "</b>"
		else
			v5 = TitleCase(__wf_atom_8e9ac384_2)
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

			if v3.ValueMax ~= nil then
				count ..= " - " .. module.Ternary(
					v3.ValueMax == 3.4028234663852886e38,
					__wf_atom_8e9ac384,
					module.FormatNumber(v3.ValueMax, 2, false)
				)
			end

			if abilityUpgradeLevelInfo[i].ValueMax ~= nil then
				value ..= " - " .. module.Ternary(
					abilityUpgradeLevelInfo[i].ValueMax == 3.4028234663852886e38,
					__wf_atom_8e9ac384,
					module.FormatNumber(abilityUpgradeLevelInfo[i].ValueMax, 2, false)
				)
			end

			if v3.ValueUnit ~= nil then
				count = movie:__wf_atom_8e9ac384(v3.ValueUnit, true, { COUNT = count })
			end

			if v3.ValueIcon ~= nil then
				if state.ModdedStats or v4 == 0 then
					count = movie:__wf_atom_8e9ac384(v3.ValueIcon, true) .. " " .. count
				else
					value = movie:__wf_atom_8e9ac384(v3.ValueIcon, true) .. " " .. value
				end
			end
		end

		table.insert(result, v5)
		table.insert(result2, count)
		table.insert(result3, value)
		table.insert(result4, v4)
	end

	_T.AbilityLevelQueryParms = nil
	_T.AbilityUpgradeLevelInfo = nil
	return result, result2, result3, result4
end

local function fn29(list, p, p2, p3, p4, p5, p6, p7, p8)
	local v2 = p and {
		Labels = {},
		Values = {},
		CompareValues = {},
		Comparison = {},
		ToolTips = {}
	} or ""
	local v3 = not __wf_atom_7e8ad928(p8)

	if __wf_atom_7e8ad928(list) then
		return v2, ""
	end

	local function fn30(value, value2, p9, value3, value4, value5)
		local v4 = value2 or "-"
		local v5 = value3 or "-"
		local v6 = value4 or 0

		if p then
			if v4 == "-" and v5 == "-" then
				v4 = ""
				v5 = ""

				if #value ~= 0 then
					value = "<font ><b>" .. value .. "</b></font>"
				end
			else
				value = TitleCase(value)
			end

			table.insert(v2.Labels, value)
			table.insert(v2.Values, v4)
			table.insert(v2.CompareValues, v5)
			table.insert(v2.Comparison, v6)
			table.insert(v2.ToolTips, value5 or "")
		else
			local ternary = module.Ternary(__wf_atom_7e8ad928(p3), "#999999", p3)
			local ternary2 = module.Ternary(__wf_atom_7e8ad928(p4), "#FFFFFF", p4)
			local ternary3 = module.Ternary(p5, "<b>", "")
			local ternary4 = module.Ternary(p5, "</b>", "")
			local v7 = value:gsub("%:", "")
			v2 ..= "<font color=\"" .. ternary .. "\">" .. v7

			if p9 then
				v2 ..= ": "
			end

			v2 ..= "</font>"
			v2 ..= "<font color=\"" .. ternary2 .. "\">" .. ternary3 .. v4 .. "\r\n" .. ternary4 .. "</font>"
		end
	end

	if type(list) ~= "table" then
		list = fn26(list, p2, false, false, p7)
	end

	if v3 then
		if type(p8) ~= "table" then
			p8 = fn26(p8, p2, false, false, p7)
		end

		list = fn27(list, p8)
	end

	local function fn31(p9, p10)
		if p9.Order ~= p10.Order then
			return p9.Order < p10.Order
		end

		if __wf_atom_7e8ad928(p9.Label) then
			return false
		end

		if __wf_atom_7e8ad928(p10.Label) then
			return true
		end

		return p9.Label < p10.Label
	end

	local flag = false
	local count = 0

	for _, v4 in ipairs(list) do
		if not v4.mExtra then
			count += 1
		end

		if not (p6 == nil or p6 == count) then
			continue
		end

		local order = 6
		local mStats = {}
		local order2 = 4

		for k, mStat in pairs(v4.mStats) do
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
						mStat.Order = 1
					elseif k == "DamageType" then
						mStat.Order = 2
					elseif k == "AttuneType" then
						mStat.Order = 3
					elseif k == "HeavyAttack" then
						mStat.Order = 5
					elseif k == "KintsugiName" then
						mStat.Order = 1
					else
						mStat.Order = order
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

		table.sort(mStats, fn31)

		if flag then
			fn30("")
		end

		if not fn(v4.mName) and #list > 1 then
			if p then
				fn30(v4.mName)
			else
				fn30("<font color=\"" .. "#4dd9e5" .. "\"><b>" .. v4.mName .. "</b></font>")
			end
		end

		for _, v5 in ipairs(mStats) do
			local displayValue = v5.DisplayValue
			local statValue = v5.StatValue
			local v6 = nil
			local toolTip = nil

			if displayValue == nil then
				if statValue == nil then
					if v3 then
						local statValue2 = 0

						if v5.Previous ~= nil then
							displayValue = v5.Previous.DisplayValue

							if v5.Previous.StatValue ~= nil then
								statValue2 = v5.Previous.StatValue

								if displayValue == nil then
									displayValue = module.FormatNumber(statValue2)
								end
							end

							toolTip = v5.Previous.ToolTip
						end

						local statValue3 = 0

						if v5.Current ~= nil then
							statValue = v5.Current.DisplayValue

							if v5.Current.StatValue ~= nil then
								statValue3 = v5.Current.StatValue

								if statValue == nil then
									statValue = module.FormatNumber(statValue3)
								end
							end

							if toolTip == nil then
								toolTip = v5.Current.ToolTip
							end
						end

						if not v5.TextOnly then
							if statValue3 < statValue2 then
								v6 = -1
							elseif statValue2 < statValue3 then
								v6 = 1
							end
						end
					end
				else
					displayValue = module.FormatNumber(statValue)
				end
			end

			fn30(v5.Label, displayValue, true, statValue, v6, toolTip)
		end

		flag = true
	end

	return v2, ""
end

function GetCrewShipStats(p, p2, p3)
	return (fn5(p, p2, p3))
end

function GetPowerSuitStats(p, p2, p3, p4, p5)
	return (fn6(p, p2, p3, p4, p5))
end

function GetLabelledStats(p, p2, p3, _, p4, p5, p6)
	return (fn26(p, p2, p3, false, p4, p5, p6))
end

function GetStatsComparison(p, p2)
	return (fn27(p, p2))
end

function GetStatsTextForItem(p, p2, p3, p4, p5, p6, p7, p8, p9)
	local v2, v3 = fn29(p, p2, p3, p4, p5, p6, p7, p8, p9)
	return v2, v3
end

function GetStatsTextForAbility(p)
	local v2, v3, v4, v5 = fn28(p)
	return v2, v3, v4, v5
end