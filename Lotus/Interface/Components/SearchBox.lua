module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.UIStyleUtilities")

function Create(mMovie2, mClipName2, p)
	local v = {
		mMovie = mMovie2,
		mClipName = mClipName2,
		mSearchTerm = nil,
		mVisible = true,
		mCallout = "<MENU_LTHUMB>",
		OnSearchChanged = nil,
		mTimeToClear = 0.5,
		mClearHoldTime = 0,
		mUnfocusedRectInnerAlpha = 0.45,
		mFocusCallbackName = "OnSearchFocused",
		mUnfocusCallbackName = "OnSearchUnfocused",
		mClearRollOverCallbackName = "OnSearchClearRollOver",
		mClearRollOutCallbackName = "OnSearchClearRollOut",
		mClearCallbackName = "OnSearchClear",
		mSearchCallbackName = "OnSearchCallback",
		mOnSearchFocusedCallbackName = "OnSearchFocusedCallback",
		mSearchBigPicCallbackName = "OnSearchBigPicCallback",
		mBgMaterial = _G.UIMaterial_RectangleNoDepth,
		mPrefix = "SearchBox(" .. mClipName2 .. ")::",
		mInitWidth = mMovie2:__wf_atom_5e6e15c8(mClipName2 .. ".Bg", 14),
		mApplyThemes = true,
		mShiftClips = {},
		Print = function(_, _) end,
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
		SetVisible = function(state, mVisible)
			if state.mVisible ~= mVisible then
				state.mVisible = mVisible
				state.mMovie:__wf_atom_2dedec1a(state.mClipName, 13, state.mVisible)
				state.mMovie:__wf_atom_2dedec1a(state.mClipName, 67, state.mVisible)
				state.mAutoFocus = mVisible and not p and module2.AutofocusTextfield(mMovie2)
			end
		end,
		HookUpCallbacks = function(self)
			local v = "onKeyUp_" .. string.sub(self.mCallout, 2, -2)
			local v2 = "onKeyDown_" .. string.sub(self.mCallout, 2, -2)
			local parentEnv = self:GetParentEnv()

			if parentEnv[v] == nil and self.mCallout ~= "" then
				parentEnv[v] = function()
					self:CalloutTriggered()
				end
			end

			if parentEnv[v2] == nil and self.mCallout ~= "" then
				parentEnv[v2] = function()
					if not parentEnv.IsInputBlocked() then
						self.mClearHoldTime = self.mTimeToClear
					end
				end
			end

			if parentEnv[self.mSearchCallbackName] == nil then
				parentEnv[self.mSearchCallbackName] = function(p2, p3)
					if not p2 then
						self.mMovie:__wf_atom_50d60589(self.mClipName .. ".FilterText", 36, p3)
					end
				end
			end

			if parentEnv[self.mOnSearchFocusedCallbackName] == nil then
				parentEnv[self.mOnSearchFocusedCallbackName] = function()
					if not (Engine.IsPlayingWithController() or Engine.__wf_atom_2a979d69()) or self.mCallout == "" then
						self.mMovie:__wf_atom_46a6af3b(self.mClipName .. ".FilterText")
						return
					end

					self.mClearHoldTime = self.mTimeToClear
					self.mMovie:__wf_atom_2004c47f()
					self:CalloutTriggered()
				end
			end

			if parentEnv[self.mSearchBigPicCallbackName] == nil then
				parentEnv[self.mSearchBigPicCallbackName] = function(p2, _, p3)
					if tonumber(p3) == 5 or p2 == "" then
						return
					end

					self.mMovie:__wf_atom_50d60589(self.mClipName .. ".FilterText", 36, p2)
				end
			end

			self.mMovie:__wf_atom_976dcedd(self.mClipName, "BgRollOverCallback", self.mFocusCallbackName)

			if parentEnv[self.mFocusCallbackName] == nil then
				parentEnv[self.mFocusCallbackName] = function()
					if not (parentEnv.IsInputBlocked() or self.mHasFocus) then
						local mApplyThemes = self.mApplyThemes
						local color = module3.GetColor(1, true, mApplyThemes)
						local color2 = module3.GetColor(7, true, mApplyThemes)
						local color3 = module3.GetColor(0, true, mApplyThemes)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "FilterText", 44, color2)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "FilterText", 81, color2)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "ClearSearchLabel", 44, color2)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Prompt", 44, color2)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 11, color2)
						local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(color)
						local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(color3)
						self.mMovie:__wf_atom_1ca72041(
							self.mClipName .. ".Bg",
							"RectEdgeColor",
							convertColorNumberToProceduralRGB2.r,
							convertColorNumberToProceduralRGB2.g,
							convertColorNumberToProceduralRGB2.b,
							1
						)
						self.mMovie:__wf_atom_1ca72041(
							self.mClipName .. ".Bg",
							"RectInnerColor",
							convertColorNumberToProceduralRGB.r,
							convertColorNumberToProceduralRGB.g,
							convertColorNumberToProceduralRGB.b,
							1
						)
					end
				end
			end

			self.mMovie:__wf_atom_976dcedd(self.mClipName, "BgRollOutCallback", self.mUnfocusCallbackName)

			if parentEnv[self.mUnfocusCallbackName] == nil then
				parentEnv[self.mUnfocusCallbackName] = function()
					if not parentEnv.IsInputBlocked() then
						local mApplyThemes = self.mApplyThemes
						local color = module3.GetColor(2, true, mApplyThemes)
						local color2 = module3.GetColor(9, true, mApplyThemes)
						local color3 = module3.GetColor(0, true, mApplyThemes)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "FilterText", 44, color2)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "FilterText", 81, color2)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "ClearSearchLabel", 44, color2)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Prompt", 44, color2)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 11, color2)
						local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(color)
						local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(color3)
						self.mMovie:__wf_atom_1ca72041(
							self.mClipName .. ".Bg",
							"RectEdgeColor",
							convertColorNumberToProceduralRGB2.r,
							convertColorNumberToProceduralRGB2.g,
							convertColorNumberToProceduralRGB2.b,
							0.035
						)
						self.mMovie:__wf_atom_1ca72041(
							self.mClipName .. ".Bg",
							"RectInnerColor",
							convertColorNumberToProceduralRGB.r,
							convertColorNumberToProceduralRGB.g,
							convertColorNumberToProceduralRGB.b,
							self.mUnfocusedRectInnerAlpha
						)
					end
				end
			end

			self.mMovie:__wf_atom_976dcedd(self.mClipName, "RollOverCallback", self.mClearRollOverCallbackName)

			if parentEnv[self.mClearRollOverCallbackName] == nil then
				parentEnv[self.mClearRollOverCallbackName] = function()
					if not parentEnv.IsInputBlocked() and self.mSearchTerm ~= "" then
						local mApplyThemes = self.mApplyThemes
						local color = module3.GetColor(7, true, mApplyThemes)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 11, color)
						self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "IconBg", 13, true)
						module.PlaySound(_G.UISound_Focus)
					end
				end
			end

			self.mMovie:__wf_atom_976dcedd(self.mClipName, "RollOutCallback", self.mClearRollOutCallbackName)

			if parentEnv[self.mClearRollOutCallbackName] == nil then
				parentEnv[self.mClearRollOutCallbackName] = function()
					if not parentEnv.IsInputBlocked() and self.mSearchTerm ~= "" then
						local mApplyThemes = self.mApplyThemes
						local color = module3.GetColor(6, true, mApplyThemes)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 11, color)
						self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "IconBg", 13, false)
					end
				end
			end

			self.mMovie:__wf_atom_976dcedd(self.mClipName, "SelectCallback", self.mClearCallbackName)

			if parentEnv[self.mClearCallbackName] == nil then
				parentEnv[self.mClearCallbackName] = function()
					if not parentEnv.IsInputBlocked() and self.mSearchTerm ~= "" then
						local mApplyThemes = self.mApplyThemes
						local color = module3.GetColor(6, true, mApplyThemes)
						self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 11, color)
						self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "IconBg", 13, false)
						self.mMovie:__wf_atom_50d60589(self.mClipName .. ".FilterText", 36, "")
						module.PlaySound(_G.UISound_Select)
					end
				end
			end

			self.mMovie:SetCallbacks(
				self.mClipName .. ".FocusBtn",
				self.mFocusCallbackName,
				self.mUnfocusCallbackName,
				self.mOnSearchFocusedCallbackName,
				nil
			)
			self.mMovie:SetCallbacks(
				self.mClipName .. ".Btn",
				self.mClearRollOverCallbackName,
				self.mClearRollOutCallbackName,
				self.mClearCallbackName,
				nil
			)
			local v3 = "OnGamepadTransition"

			while parentEnv["Prev_" .. v3] ~= nil do
				v3 = "Prev_" .. v3
			end

			parentEnv["Prev_" .. v3] = parentEnv.OnGamepadTransition
			local v4 = parentEnv["Prev_" .. v3] ~= nil

			function parentEnv.OnGamepadTransition(p2)
				if v4 then
					parentEnv["Prev_" .. v3](p2)
				end

				self:OnGamepadTransition(p2 == "true")
			end
		end,
		CalloutTriggered = function(self)
			if not self:GetParentEnv().IsInputBlocked() and self.mClearHoldTime > 0 then
				self.mClearHoldTime = 0

				if Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302() or Engine.__wf_atom_2a979d69() then
					self:SearchSelected(false)
					module2.ShowInputDialog(
						self.mMovie,
						"/Lotus/Language/Menu/SearchPrompt",
						self.mSearchTerm,
						40,
						self.mSearchBigPicCallbackName,
						self.mSearchCallbackName
					)
				end
			end
		end,
		SearchSelected = function(self, _)
			if not self.mAutoFocus then
				module.PlaySound(_G.UISound_Select)
				module.PlaySound(_G.UISound_ItemTip)
			end
		end,
		UpdateWidth = function(self)
			local v = self.mWidth - self.mInitWidth

			for i = 1, #self.mShiftClips do
				local v2 = self.mShiftClips[i].InitX + v
				self.mMovie:__wf_atom_e57658c2(self.mClipName .. self.mShiftClips[i].Clip, 0, v2)
			end

			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Bg", 14, self.mWidth)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Blurer", 14, self.mWidth)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "FocusBtn", 14, self.mWidth)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "FilterText", 14, self.mWidth - 32)

			if self.mAltClearSearchPosition then
				self.mMovie:__wf_atom_4c1c1986(
					self.mClipName,
					"ClearSearchLabel",
					0,
					self.mMovie:__wf_atom_cfc41e35(self.mClipName, "Bg", 0) + self.mWidth + 5
				)
			end
		end,
		UpdateColors = function(self)
			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local mApplyThemes = self.mApplyThemes
			local color = module3.GetColor(2, true, mApplyThemes)
			local color2 = module3.GetColor(0, true, mApplyThemes)
			local color3 = module3.GetColor(1, true, mApplyThemes)
			local color4 = module3.GetColor(9, true, mApplyThemes)
			mMovie:__wf_atom_4c1c1986(mClipName, "FilterText", 44, color4)
			mMovie:__wf_atom_4c1c1986(mClipName, "FilterText", 81, color4)
			mMovie:__wf_atom_4c1c1986(mClipName, "ClearSearchLabel", 44, color4)
			mMovie:__wf_atom_4c1c1986(mClipName, "Prompt", 44, color4)
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 11, color4)
			mMovie:__wf_atom_4c1c1986(mClipName, "Callout.Tf", 11, color4)
			local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(color)
			local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(color2)
			mMovie:__wf_atom_1ca72041(
				mClipName .. ".Bg",
				"RectEdgeColor",
				convertColorNumberToProceduralRGB2.r,
				convertColorNumberToProceduralRGB2.g,
				convertColorNumberToProceduralRGB2.b,
				0.035
			)
			mMovie:__wf_atom_1ca72041(
				mClipName .. ".Bg",
				"RectInnerColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				self.mUnfocusedRectInnerAlpha
			)
			local convertColorNumberToProceduralRGB3 = module.ConvertColorNumberToProceduralRGB(color3)
			mMovie:__wf_atom_1ca72041(
				mClipName .. ".IconBg",
				"RectEdgeColor",
				convertColorNumberToProceduralRGB2.r,
				convertColorNumberToProceduralRGB2.g,
				convertColorNumberToProceduralRGB2.b,
				1
			)
			mMovie:__wf_atom_1ca72041(
				mClipName .. ".IconBg",
				"RectInnerColor",
				convertColorNumberToProceduralRGB3.r,
				convertColorNumberToProceduralRGB3.g,
				convertColorNumberToProceduralRGB3.b,
				1
			)
		end,
		Initialize = function(self)
			self:HookUpCallbacks()

			if Engine.__wf_atom_578fc9dd() then
				self.mMovie:__wf_atom_48bd5a59(self.mClipName, "FilterText", 49, "Arial Unicode MS")
				self.mMovie:__wf_atom_48bd5a59(self.mClipName, "Prompt", 49, "Arial Unicode MS")
			end

			if Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302() then
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Icon", 13, false)
				self.mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Callout.Tf.text", self.mCallout)
				self.mMovie:__wf_atom_7d7314f1(
					self.mClipName .. ".ClearSearchLabel.text",
					"/Lotus/Language/Menu/HoldToClear"
				)
			else
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Callout", 13, false)
			end

			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "ClearSearchLabel", 13, false)
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "IconBg", 13, false)
			self.mMovie:__wf_atom_50d60589(self.mClipName .. ".FilterText", 36, "")
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Btn", 13, false)
			self.mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Prompt.text", "/Lotus/Language/Menu/SearchPrompt")
			local __wf_atom_5e6e15c8 = self.mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Prompt", 0)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Prompt", 0, __wf_atom_5e6e15c8 + 3)
			self.mShiftClips = {
				{ Clip = ".Btn", InitX = 0 },
				{ Clip = ".Icon", InitX = 0 },
				{ Clip = ".IconBg", InitX = 0 },
				{ Clip = ".Callout", InitX = 0 }
			}

			if self.mAltClearSearchPosition then
				self.mMovie:__wf_atom_48bd5a59(self.mClipName, "ClearSearchLabel", 45, "left")
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "ClearSearchLabel", 1, -10)
			else
				table.insert(self.mShiftClips, { Clip = ".ClearSearchLabel", InitX = 0 })
			end

			for i = 1, #self.mShiftClips do
				self.mShiftClips[i].InitX = self.mMovie:__wf_atom_5e6e15c8(
					self.mClipName .. self.mShiftClips[i].Clip,
					0
				)

				if self.mShiftClips[i].InitX == nil then
					self.mShiftClips[i].InitX = 0
				end
			end

			self:UpdateWidth()
			self:UpdateColors()
		end,
		UpdateSearchTerm = function(self, p2)
			local mHasFocus = self.mMovie:__wf_atom_94bf489f() == "FilterText"

			if self.mHasFocus ~= mHasFocus then
				self.mHasFocus = mHasFocus
				self:UpdateColors()

				if mHasFocus then
					self:SearchSelected(true)
				end
			end

			if mHasFocus then
				local __wf_atom_76657dba = self.mMovie:__wf_atom_76657dba(
					self.mClipName .. ".FilterText",
					"cursorBlink"
				)

				if self.mCursorBlink ~= __wf_atom_76657dba then
					self.mCursorBlink = __wf_atom_76657dba

					if __wf_atom_76657dba == "true" then
						module.PlaySound(_G.UISound_CursorBlink)
					end
				end
			end

			local __wf_atom_387f260e = self.mMovie:__wf_atom_387f260e(self.mClipName .. ".FilterText", 36)

			if self.mSearchTerm ~= __wf_atom_387f260e then
				local mSearchTerm = self.mSearchTerm
				self.mSearchTerm = __wf_atom_387f260e
				local mSearching = __wf_atom_387f260e ~= ""

				if self.mSearching ~= mSearching then
					self.mSearching = mSearching
					self:UpdateColors()
				end

				self.mLowerSearchTerm = __wf_atom_d99ae0ec(__wf_atom_387f260e)
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Prompt", 13, not mSearching)

				if Engine.IsPlayingWithController() or self.ShowModeChangeCallout == true then
					self.ShowModeChangeCallout = nil
					self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "ClearSearchLabel", 13, mSearching)
				else
					local ternary = module.Ternary(mSearching, _G.UITexture_ClearSearch, _G.UITexture_Search)
					self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".Icon", ternary)
					self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Btn", 13, mSearching)
				end

				if mSearchTerm ~= nil and self.OnSearchChanged ~= nil and not p2 then
					self:OnSearchChanged(__wf_atom_387f260e)
					module.PlaySound(_G.UISound_SearchType)
				end
			end
		end,
		Update = function(self, p2)
			local parentEnv = self:GetParentEnv()
			local __wf_atom_387f260e = self.mMovie:__wf_atom_387f260e(self.mClipName .. ".FilterText", 57)
			local ternary = module.Ternary(parentEnv.IsInputBlocked(), "dynamic", "input")

			if __wf_atom_387f260e ~= ternary then
				self.mMovie:__wf_atom_48bd5a59(self.mClipName, "FilterText", 57, ternary)

				if ternary == "dynamic" then
					local __wf_atom_94bf489f = self.mMovie:__wf_atom_94bf489f()

					if not __wf_atom_7e8ad928(__wf_atom_94bf489f) and __wf_atom_94bf489f == "FilterText" then
						self.mMovie:__wf_atom_2004c47f()
					end
				end
			end

			if self.mClearHoldTime > 0 then
				self.mClearHoldTime -= p2

				if self.mClearHoldTime <= 0 then
					self.mMovie:__wf_atom_50d60589(self.mClipName .. ".FilterText", 36, "")
				end
			end

			if ternary == "dynamic" then
				return
			end

			local mAutoFocus = self.mAutoFocus

			if mAutoFocus and ternary == "input" then
				mAutoFocus = false
				mMovie2:__wf_atom_46a6af3b(mClipName2 .. ".FilterText")
				local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())

				if not __wf_atom_7e8ad928(movie) then
					movie:__wf_atom_2004c47f()
				end
			end

			self:UpdateSearchTerm(false)
			self.mAutoFocus = mAutoFocus
		end,
		OnGamepadTransition = function(self, p2)
			self.mMovie:__wf_atom_2004c47f()
			local showModeChangeCallout = Engine.IsPlayingWithController() or not p2

			if showModeChangeCallout then
				self.mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Callout.Tf.text", self.mCallout)
				self.mMovie:__wf_atom_7d7314f1(
					self.mClipName .. ".ClearSearchLabel.text",
					"/Lotus/Language/Menu/HoldToClear"
				)
			end

			local v = self.mMovie:__wf_atom_387f260e(self.mClipName .. ".FilterText", 36) ~= ""
			self.ShowModeChangeCallout = showModeChangeCallout

			if showModeChangeCallout then
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "ClearSearchLabel", 13, v)
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Btn", 13, false)
			else
				local ternary = module.Ternary(v, _G.UITexture_ClearSearch, _G.UITexture_Search)
				self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".Icon", ternary)
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "ClearSearchLabel", 13, false)
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Btn", 13, v)
			end

			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Callout", 13, showModeChangeCallout)
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Icon", 13, not showModeChangeCallout)
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "IconBg", 13, false)

			if self.mAltClearSearchPosition then
				self.mMovie:__wf_atom_48bd5a59(self.mClipName, "ClearSearchLabel", 45, "left")
			end
		end
	}
	mMovie2:__wf_atom_c90af43a(mClipName2 .. ".Icon", _G.UITexture_Search)
	mMovie2:OverrideMaterial(mClipName2 .. ".Bg", _G.UIMaterial_Button)
	mMovie2:OverrideMaterial(mClipName2 .. ".IconBg", _G.UIMaterial_Button)
	v.mWidth = v.mInitWidth
	v.mAutoFocus = not p and module2.AutofocusTextfield(mMovie2)
	return v
end