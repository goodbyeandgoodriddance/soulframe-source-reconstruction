module(..., package.seeall)

function Create(mMovie2, mClipName, p, p2)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.UIUtilities")
	local module3 = require("Lotus.Interface.UIStyleUtilities")
	local module4 = require("Lotus.Interface.StoreItemUtilities")
	local module5 = require("Lotus.Interface.Components.StatCompare")
	local v = {
		mMovie = mMovie2,
		mClipName = mClipName,
		mHeight = 28,
		mMaxHeight = 0,
		mLineHeight = 23,
		mSpacerHeight = 16,
		mLockHeightToMax = false,
		mFadeThemedStats = nil,
		mScrollBar = nil,
		mWidth = mMovie2:__wf_atom_5e6e15c8(mClipName, 14),
		mCached = nil,
		mCurrent = nil,
		mType = nil,
		mAvatar = nil,
		mPadding = 5,
		mIsVisible = true,
		mActive = true,
		mStats = {},
		mStatsToSkip = {},
		mStatsToOnlyShow = nil,
		mBgOffset = 0,
		mYOffset = 0,
		mEdgeAlpha = 0.2,
		mGrowDownward = false,
		mCanFocusStats = false,
		mNumStats = 1,
		RectangleMaterial = _G.UIMaterial_RectangleNoDepth,
		TextMaterial = _G.UIMaterial_PlainText,
		GetParentEnv = function(self)
			if self.mParentEnv ~= nil then
				return self.mParentEnv
			end

			local v = 1
			local mParentEnv

			repeat
				mParentEnv = getfenv(v)
				v += 1
			until mParentEnv.mMovie

			self.mParentEnv = mParentEnv
			return mParentEnv
		end,
		ShowStatTips = function(self)
			self.mCanFocusStats = true
			local parentEnv = self:GetParentEnv()
			local mMovie = self.mMovie

			function parentEnv.StatFocused(p3)
				if mMovie:Execute("IsInputBlocked", "") then
					return
				end

				local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(self.mClipName, "Backer", 3)
				local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35(self.mClipName, "Backer", 15)
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 31)

				if
					__wf_atom_5e6e15c8 <= __wf_atom_cfc41e35
					or __wf_atom_cfc41e35 + __wf_atom_cfc41e35_2 <= __wf_atom_5e6e15c8
				then
					return
				end

				self:ShowToolTip((tonumber(p3)))
				self:SetActive(true)
			end

			function parentEnv.StatUnfocused(_)
				if mMovie:__wf_atom_5e6e15c8("_root", 31) < 0 then
					return
				end

				_T.InfoPopup_Data = nil
				self:SetActive(false)
			end
		end,
		AttachScrollBar = function(state, p3, mMaxHeight)
			state.mMaxHeight = mMaxHeight
			local module6 = require("EE.Interface.Components.ScrollBar")
			state.mScrollBar = module6.CreateScrollBar(state.mMovie, p3, mMaxHeight, 0.5)
			state.mScrollBar:HookUpCallbacks()

			function state.mScrollBar.mScrollValueChangedCallback(p4, _)
				local v = -((state.mHeight - state.mMaxHeight) * p4)
				local mMovie = state.mMovie
				mMovie:__wf_atom_4c1c1986(state.mClipName, "List", 1, v)

				if not (__wf_atom_7e8ad928(state.mStats) or __wf_atom_7e8ad928(state.mStats.Labels)) then
					for i = 1, #state.mStats.Labels do
						local v2 = state.mClipName .. ".List.Item" .. i

						if not mMovie:__wf_atom_253d7085(v2) then
							continue
						end

						local v3 = mMovie:__wf_atom_5e6e15c8(v2, 1) + v
						local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v2, "Backer", 15)
						mMovie:__wf_atom_2dedec1a(v2, 67, v3 < state.mMaxHeight and v3 + __wf_atom_cfc41e35 > 0)
					end
				end
			end

			state.mScrollBar:Initialize()
			state.mScrollBar:SetEnabled(false)
			state.mMovie:__wf_atom_2dedec1a(p3, 13, false)
		end,
		SetWidth = function(self, mWidth)
			self.mWidth = mWidth
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Backer", 14, self.mWidth)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Blurer", 14, self.mWidth)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Mask", 14, self.mWidth)
			self:Redraw()
		end,
		Redraw = function(self)
			if not self.mIsVisible then
				return
			end

			local mMovie = self.mMovie
			local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module3.GetColor(2, true))
			local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(module3.GetColor(1, true))
			local mLineHeight = self.mLineHeight
			local mPadding = self.mPadding
			local mStats = self.mStats
			local labels = mStats.Labels
			local values = mStats.Values
			local valueColors = mStats.ValueColors
			local compareValues = mStats.CompareValues
			local comparison = mStats.Comparison
			local forcedTitles = mStats.ForcedTitles
			local ternary = module.Ternary(self.mFadeThemedStats, 0, 0.2)
			local total = 0

			for i = 1, #labels do
				local v = self.mClipName .. ".List.Item" .. i

				if not mMovie:__wf_atom_253d7085(v) then
					__wf_atom_86cbd68d(mMovie, self.mClipName .. ".List.Item1.duplicateMovieClip", "Item" .. i, i)
				end

				mMovie:__wf_atom_4c1c1986(v, "Backer", 100, i)
				mMovie:SetCallbacks(v .. ".Backer", "StatFocused", "StatUnfocused", nil, nil)
				mMovie:__wf_atom_2dedec1a(v, 13, true)
				mMovie:__wf_atom_e57658c2(v, 1, total)
				mMovie:__wf_atom_7f57ab2f(v, "Backer", 67, self.mCanFocusStats)
				mMovie:__wf_atom_4c1c1986(v, "Backer", 14, self.mWidth)
				mMovie:__wf_atom_4c1c1986(v, "Stats", 14, self.mWidth)
				mMovie:OverrideMaterial(v .. ".Stats", self.TextMaterial)
				mMovie:OverrideMaterial(v .. ".Labels", self.TextMaterial)
				mMovie:OverrideMaterial(v .. ".Backer", self.RectangleMaterial)
				mMovie:__wf_atom_1ca72041(v .. ".Backer", "RectEdgeColor", 0, 0, 0, 0)

				if i % 2 == 1 then
					mMovie:__wf_atom_1ca72041(v .. ".Backer", "RectInnerColor", 0, 0, 0, 0)
				else
					local convertColorNumberToProceduralRGB3 = module.ConvertColorNumberToProceduralRGB(module3.GetColor(6, true))
					mMovie:__wf_atom_1ca72041(
						v .. ".Backer",
						"RectInnerColor",
						convertColorNumberToProceduralRGB3.r,
						convertColorNumberToProceduralRGB3.g,
						convertColorNumberToProceduralRGB3.b,
						0.05
					)
				end

				local convertColorNumberToHex = module.ConvertColorNumberToHex(module3.GetColor(9, true))
				local convertColorNumberToHex2 = module.ConvertColorNumberToHex(module3.GetColor(10, true))
				local label = labels[i]
				local value = values[i]
				local compareValue = compareValues[i]
				local v2

				if #forcedTitles > 0 then
					v2 = forcedTitles[i]
				else
					v2 = false
				end

				local v3

				if type(value) == "string" then
					v3 = false
				else
					v3 = not __wf_atom_7e8ad928(Resource(value))
				end

				mMovie:__wf_atom_7f57ab2f(v, "Icon", 13, v3)

				if v3 then
					mMovie:__wf_atom_c90af43a(v .. ".Icon", value)
					mMovie:__wf_atom_4c1c1986(v, "Icon", 11, valueColors[i])
					value = " "
				end

				local v4 = #label == 0
				local v5 = #value == 0
				local v6

				if v2 or v5 and not (#compareValue > 0) then
					v6 = "<p><font color=\"" .. convertColorNumberToHex2 .. "\">" .. label .. "</font></p>"
				else
					v6 = "<p><font color=\"" .. convertColorNumberToHex .. "\">" .. label .. "</font></p>"
				end

				local v7, v8

				if v2 then
					v7 = -2
					v8 = 3
				else
					v7 = 0
					v8 = 0
				end

				if compareValue ~= nil and value ~= compareValue then
					if not v5 then
						compareValue = mMovie:__wf_atom_8e9ac384("<MINI_ARROW>", true) .. compareValue
					end

					local v9 = comparison[i]

					if v9 ~= nil then
						if v9 > 0 then
							compareValue = "<font color=\"" .. module.ConvertColorNumberToHex(module3.GetColor(11, true)) .. "\">" .. compareValue .. "</font>"
						elseif v9 < 0 then
							compareValue = "<font color=\"" .. module.ConvertColorNumberToHex(module3.GetColor(12, true)) .. "\">" .. compareValue .. "</font>"
						end
					end

					value ..= compareValue
				end

				local v9 = "<p><font color=\"" .. convertColorNumberToHex2 .. "\">" .. value .. "</font></p>"
				mMovie:__wf_atom_48bd5a59(v, "Labels", 36, v6)
				mMovie:__wf_atom_48bd5a59(v, "Stats", 36, v9)
				mMovie:__wf_atom_7f57ab2f(v, "Labels", 52, false)
				local v10 = 1
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v .. ".Labels", 40)
				local total2 = 20
				local v11 = self.mWidth - mPadding * 2

				if v3 then
					v11 = v11 - mLineHeight - mPadding
					total2 = 0
				elseif not v5 then
					total2 = mMovie:__wf_atom_5e6e15c8(v .. ".Stats", 40) + total2
				end

				local v12 = v11 - total2

				if v12 < __wf_atom_5e6e15c8 and not v5 then
					local v13 = "<p><font color=\"" .. convertColorNumberToHex2 .. "\"><br>" .. value .. "</font></p>"
					mMovie:__wf_atom_7f57ab2f(v, "Stats", 52, true)
					mMovie:__wf_atom_48bd5a59(v, "Stats", 36, v13)
					__wf_atom_86cbd68d(mMovie, v .. ".Stats.updateTextFormat")
					v10 = mMovie:__wf_atom_5e6e15c8(v .. ".Stats", 43)
				end

				if v11 < __wf_atom_5e6e15c8 then
					mMovie:__wf_atom_7f57ab2f(v, "Labels", 52, true)
					mMovie:__wf_atom_4c1c1986(v, "Labels", 14, v12)
					__wf_atom_86cbd68d(mMovie, v .. ".Labels.updateTextFormat")
					v10 = math.max(v10, mMovie:__wf_atom_cfc41e35(v, "Labels", 43))
				end

				local mSpacerHeight = self.mSpacerHeight

				if not v4 then
					mSpacerHeight = mLineHeight * math.max(1, v10)
				end

				local v13 = mSpacerHeight + 4 + 0.5
				local v14 = (v13 - mSpacerHeight) / 2 + 1

				if i == 1 then
					v13 += mPadding
					total += mPadding
					v14 += mPadding
				end

				if i == #labels then
					v13 += mPadding
					total += mPadding
				end

				if v3 then
					mMovie:__wf_atom_4c1c1986(v, "Icon", 14, mLineHeight)
					mMovie:__wf_atom_4c1c1986(v, "Icon", 15, mLineHeight)
					mMovie:__wf_atom_4c1c1986(v, "Icon", 0, self.mWidth - mPadding - mLineHeight)
					mMovie:__wf_atom_4c1c1986(v, "Icon", 1, mSpacerHeight / 2 + 2)
				end

				mMovie:__wf_atom_4c1c1986(v, "Backer", 15, v13)
				mMovie:__wf_atom_4c1c1986(v, "Stats", 1, v14 + v7)
				mMovie:__wf_atom_4c1c1986(v, "Labels", 1, v14)
				mMovie:__wf_atom_4c1c1986(v, "Stats", 0, -mPadding + v8)
				mMovie:__wf_atom_4c1c1986(v, "Labels", 0, mPadding)
				local v15 = self.mFadeThemedStats and 25 or 100
				__wf_atom_ec43d06e(mMovie, v .. ".Stats", 0, { 12 }, { v15 }, 0.2, ternary)
				__wf_atom_ec43d06e(mMovie, v .. ".Labels", 0, { 12 }, { v15 }, 0.2, ternary)
				total += mSpacerHeight
			end

			for i = #labels + 1, self.mNumStats do
				mMovie:__wf_atom_2dedec1a(self.mClipName .. ".List.Item" .. i, 13, false)
			end

			self.mNumStats = #labels
			self.mHeight = total + 4
			mMovie:__wf_atom_4c1c1986(self.mClipName, "List", 1, 0)
			local mHeight

			if self.mCollapsed then
				mHeight = 37
			else
				mHeight = self.mHeight

				if self.mMaxHeight > 0 then
					if self.mLockHeightToMax then
						mHeight = self.mMaxHeight
					else
						mHeight = math.min(self.mHeight, self.mMaxHeight)
					end

					local v = self.mMaxHeight / self.mHeight
					self.mScrollBar:SetVisibleProp(v)
					self.mScrollBar:SetScrollValue(0, false, true)
					self.mScrollBar:SetEnabled(v <= 1)
					mMovie:__wf_atom_2dedec1a(self.mScrollBar.mClipName, 13, v <= 1)
				end
			end

			mMovie:__wf_atom_e57658c2(
				self.mClipName,
				1,
				module.Ternary(self.mGrowDownward, 0, -mHeight) + self.mYOffset
			)
			mMovie:__wf_atom_2dedec1a(self.mClipName, 13, #labels > 0)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Backer", 1, -self.mBgOffset)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Blurer", 1, -self.mBgOffset)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Mask", 1, 3)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Backer", 15, mHeight + self.mBgOffset)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Blurer", 15, mHeight + self.mBgOffset)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Mask", 15, mHeight - 5)
			mMovie:OverrideMaterial(self.mClipName .. ".Backer", self.RectangleMaterial)
			local mEdgeStartAlpha = self.mFadeThemedStats and 0.15 or self.mEdgeAlpha or 0.15

			if self.mEdgeStartAlpha == nil then
				self.mEdgeStartAlpha = mEdgeStartAlpha
			end

			mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Backer",
				"RectEdgeColor",
				convertColorNumberToProceduralRGB2.r,
				convertColorNumberToProceduralRGB2.g,
				convertColorNumberToProceduralRGB2.b,
				self.mEdgeStartAlpha
			)
			mMovie:__wf_atom_1ca72041(
				self.mClipName .. ".Backer",
				"RectInnerColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				0.8
			)

			if self.mFadeThemedStats ~= nil then
				__wf_atom_ec43d06e(mMovie, self.mClipName .. ".Backer", 0, { function(p3)
						local v = self.mEdgeStartAlpha + p3 * (mEdgeStartAlpha - self.mEdgeStartAlpha)
						mMovie:__wf_atom_1ca72041(
							self.mClipName .. ".Backer",
							"RectEdgeColor",
							convertColorNumberToProceduralRGB2.r,
							convertColorNumberToProceduralRGB2.g,
							convertColorNumberToProceduralRGB2.b,
							v
						)
					end }, { 1 }, 0.2, ternary, function()
					self.mEdgeStartAlpha = mEdgeStartAlpha
					mMovie:__wf_atom_1ca72041(
						self.mClipName .. ".Backer",
						"RectEdgeColor",
						convertColorNumberToProceduralRGB2.r,
						convertColorNumberToProceduralRGB2.g,
						convertColorNumberToProceduralRGB2.b,
						mEdgeStartAlpha
					)
				end)
			end

			self:SetActive(self.mActive)
		end,
		SetCollapsed = function(state, mCollapsed, value)
			state.mCollapsed = mCollapsed
			local mHeight

			if mCollapsed then
				mHeight = 37
			elseif state.mMaxHeight > 0 then
				mHeight = math.min(state.mHeight, state.mMaxHeight)
			else
				mHeight = state.mHeight
			end

			local function fn(p3)
				local v = state.mClipName .. ".List.Item2"
				state.mMovie:__wf_atom_7f57ab2f(v, "Stats", 13, p3)
				state.mMovie:__wf_atom_7f57ab2f(v, "Labels", 13, p3)
				state.mMovie:__wf_atom_7f57ab2f(v, "Backer", 13, p3)
			end

			if not mCollapsed then
				fn(true)
			end

			local v = value or 0.2
			__wf_atom_ec43d06e(
				state.mMovie,
				state.mClipName,
				2,
				{ 1 },
				{ module.Ternary(state.mGrowDownward, 0, -mHeight) + state.mYOffset },
				v
			)
			__wf_atom_ec43d06e(state.mMovie, state.mClipName .. ".Backer", 2, { 15 }, { mHeight + state.mBgOffset }, v)
			__wf_atom_ec43d06e(state.mMovie, state.mClipName .. ".Blurer", 2, { 15 }, { mHeight + state.mBgOffset }, v)
			__wf_atom_ec43d06e(state.mMovie, state.mClipName .. ".Mask", 2, { 15 }, { mHeight - 5 }, v, 0, function()
				if mCollapsed then
					fn(false)
				end
			end)
		end,
		SetActive = function(self, mActive)
			if self.mActive == mActive then
				return
			end

			self.mActive = mActive
			local mEdgeStartAlpha = self.mEdgeStartAlpha
			local mEdgeStartAlpha2 = not mActive and 0 or self.mEdgeAlpha or 0
			local ternary = module.Ternary(mActive, 0, 0.2)
			local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module3.GetColor(1, true))
			__wf_atom_ec43d06e(self.mMovie, self.mClipName .. ".Backer", 0, { function(p3)
					self.mEdgeStartAlpha = mEdgeStartAlpha + p3 * (mEdgeStartAlpha2 - mEdgeStartAlpha)
					self.mMovie:__wf_atom_1ca72041(
						self.mClipName .. ".Backer",
						"RectEdgeColor",
						convertColorNumberToProceduralRGB.r,
						convertColorNumberToProceduralRGB.g,
						convertColorNumberToProceduralRGB.b,
						self.mEdgeStartAlpha
					)
				end }, { 1 }, 0.2, ternary, function()
				self.mEdgeStartAlpha = mEdgeStartAlpha2
				self.mMovie:__wf_atom_1ca72041(
					self.mClipName .. ".Backer",
					"RectEdgeColor",
					convertColorNumberToProceduralRGB.r,
					convertColorNumberToProceduralRGB.g,
					convertColorNumberToProceduralRGB.b,
					mEdgeStartAlpha2
				)
			end)
		end,
		SetBorderPadding = function(self, mPadding)
			self.mPadding = mPadding
			self:Redraw()
		end,
		SetType = function(self, mType, mAvatar, p3, p4, p5)
			local v = self.mType ~= mType or (self.mAvatar ~= mAvatar or p3)

			if mType ~= nil then
				self.mType = mType

				if not self.mCanFocusStats then
					self:ShowStatTips()
				end
			end

			if mAvatar ~= nil then
				self.mAvatar = mAvatar
			end

			self.mCached = module5.GetLabelledStats(
				self.mType,
				self.mAvatar,
				nil,
				p5,
				p4,
				self.mStatsToSkip,
				self.mStatsToOnlyShow
			)
			self.mCurrent = self.mCached

			if v then
				self.mStats = module4.GetDisplayStats(self.mCached, true, nil, nil, self.mCurrent)
				self:Redraw()
			end
		end,
		Compare = function(self, p3, p4, p5)
			self.mCurrent = module5.GetLabelledStats(
				module.Ternary(p3 == nil, self.mType, p3),
				self.mAvatar,
				nil,
				p5,
				p4,
				self.mStatsToSkip,
				self.mStatsToOnlyShow
			)
			self.mStats = module4.GetDisplayStats(self.mCached, true, nil, nil, self.mCurrent)
			self:Redraw()
		end,
		SetVisible = function(self, mIsVisible)
			self.mIsVisible = mIsVisible

			if mIsVisible then
				self:Redraw()
			else
				self.mMovie:__wf_atom_2dedec1a(self.mClipName, 13, false)

				if self.mScrollBar ~= nil then
					self.mMovie:__wf_atom_2dedec1a(self.mScrollBar.mClipName, 13, false)
				end
			end
		end,
		SetAlpha = function(p3, p4)
			p3.mMovie:__wf_atom_e57658c2(p3.mClipName, 12, p4)
		end,
		ShowToolTip = function(self, p3, value)
			if
				__wf_atom_7e8ad928(self.mStats)
				or __wf_atom_7e8ad928(self.mStats.ToolTips[p3])
				or self.mStats.ToolTips[p3] == ""
			then
				return
			end

			local v = self.mClipName .. ".List.Item" .. tostring(p3) .. ".Backer"
			local infoPopup_Data = {
				CustomEntry = true,
				Name = self.mStats.Labels[p3],
				LocalizedDesc = self.mStats.ToolTips[p3]
			}
			module2.SetItemInfoPopupRect(
				self.mMovie,
				infoPopup_Data,
				self.mMovie:__wf_atom_5e6e15c8(v, 2),
				self.mMovie:__wf_atom_5e6e15c8(v, 3),
				self.mMovie:__wf_atom_5e6e15c8(v, 14) + (value or 0),
				self.mMovie:__wf_atom_5e6e15c8(v, 15),
				true
			)
			_T.InfoPopup_Data = infoPopup_Data
		end
	}
	v:SetType(p, p2)
	return v
end