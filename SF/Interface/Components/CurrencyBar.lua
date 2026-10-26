module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
local module3 = require("SF.Interface.SFUtilities")

function CreateCurrencyBar(p, mClipName2, options)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.mMovie) then
		print("Invalid env")
		return
	end

	local v = string.gsub(mClipName2, "%.", "")
	local mMovie = p.mMovie
	local result = {
		mClipName = mClipName2,
		mVisible = false,
		mLabel = "",
		mSubTitle = "",
		mLevel = "",
		mRankProgress = 0,
		mMinWidth = 490,
		mPadding = 5,
		mCurrencyWidth = 0,
		mDefaultY = mMovie:__wf_atom_54eeda24() * 0.025,
		mOptions = {},
		QUEUE_STATE = { IDLE = 0, REDRAW = 1, HIDE_AND_REDRAW = 2 },
		OnFocusedCallback = function(_, infoPopup_Data)
			module.PlaySound(_G.UISound_Focus)
			module2.SetItemInfoPopupRect(
				mMovie,
				infoPopup_Data,
				mMovie:__wf_atom_cfc41e35(infoPopup_Data.mClipName, "Btn", 2) - 16,
				mMovie:__wf_atom_cfc41e35(infoPopup_Data.mClipName, "Btn", 3) - 4,
				nil,
				mMovie:__wf_atom_cfc41e35(infoPopup_Data.mClipName, "Btn", 15)
			)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Title", 12)
			local __wf_atom_a91463a8 = mMovie:__wf_atom_a91463a8("Title", 13)

			if __wf_atom_5e6e15c8 > 0 and __wf_atom_a91463a8 then
				_T.InfoPopup_Data = infoPopup_Data
			end
		end,
		OnUnfocusedCallback = function(_, _)
			_T.InfoPopup_Data = nil
		end,
		SetCallbacks = function(self)
			for _, v2 in {
				"OnFocusedCallback",
				"OnUnfocusedCallback",
				"OnSelectedCallback",
				"OnPressedCallback"
			} do
				local v3 = v2

				p[v .. v2] = function(p2)
					if not (__wf_atom_7e8ad928(self[v3]) or __wf_atom_7e8ad928(self.mCurrencies)) then
						self[v3](self, self.mCurrencies[p2])
					end
				end
			end
		end,
		UpdateCurrencyEntry = function(self, p2, p3, p4, value)
			local total = 0
			local icon = p2.Icon
			local v2 = type(icon) == "string"

			if p4 == nil then
				mMovie:__wf_atom_48bd5a59(p3, "Amount.Text", 36, "")
				mMovie:__wf_atom_48bd5a59(p3, "Prefix", 36, "")
				mMovie:__wf_atom_7f57ab2f(p3, "Icon", 13, false)
			else
				mMovie:__wf_atom_48bd5a59(p3, "Amount.Text", 36, module.FormatNumber(p4))
				mMovie:__wf_atom_4c1c1986(p3, "Amount.Text", 44, _G.UIColor_Tan)
				total += mMovie:__wf_atom_cfc41e35(p3, "Amount.Text", 40) + self.mPadding
				local v3 = value or ""
				mMovie:__wf_atom_7f57ab2f(p3, "Icon", 13, not v2)

				if v2 then
					v3 ..= icon
				else
					mMovie:__wf_atom_c90af43a(p3 .. ".Icon", icon)
					total += mMovie:__wf_atom_cfc41e35(p3, "Icon", 14)
					mMovie:__wf_atom_4c1c1986(p3, "Icon", 0, -total)
				end

				mMovie:__wf_atom_48bd5a59(p3, "Prefix", 36, v3)

				if #v3 > 0 then
					mMovie:__wf_atom_4c1c1986(p3, "Prefix", 44, _G.UIColor_Tan)
					total += mMovie:__wf_atom_cfc41e35(p3, "Prefix", 40)
					mMovie:__wf_atom_4c1c1986(p3, "Prefix", 0, -total)
				end
			end

			return total + -mMovie:__wf_atom_5e6e15c8(p3, 0) * 2
		end,
		CreateCurrencyEntry = function(self, state)
			local mId = state.mId
			local mClipName = self.mClipName .. ".Money.Currency" .. mId

			if not mMovie:__wf_atom_253d7085(mClipName) then
				__wf_atom_86cbd68d(
					mMovie,
					self.mClipName .. ".Money.Currency1.duplicateMovieClip",
					"Currency" .. mId,
					mId
				)
			end

			state.mClipName = mClipName
			state.SuppressRarity = true
			mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 100, mId)
			mMovie:SetCallbacks(
				mClipName .. ".Btn",
				v .. "OnFocusedCallback",
				v .. "OnUnfocusedCallback",
				v .. "OnSelectedCallback",
				v .. "OnPressedCallback"
			)
			local amount = tonumber(state.Amount)
			mMovie:__wf_atom_2dedec1a(mClipName, 13, amount ~= nil)

			if amount == nil then
				return
			end

			state.Amount = amount
			local amountDelta = state.AmountDelta or 0
			local v2 = self:UpdateCurrencyEntry(state, mClipName .. ".Value", amount)
			local v3 = math.max(2, v2 - mMovie:__wf_atom_cfc41e35(mClipName, "BackerLeft", 14) * 2)
			mMovie:__wf_atom_4c1c1986(mClipName, "ValueDelta", 12, 0)

			if amountDelta == 0 then
				mMovie:__wf_atom_4c1c1986(mClipName, "BackerMid", 14, v3)
				mMovie:__wf_atom_4c1c1986(mClipName, "BackerLeft", 0, -v2)
				mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 14, v2)
			else
				local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(mClipName, "Value", 1)
				mMovie:__wf_atom_4c1c1986(mClipName, "ValueDelta", 1, __wf_atom_cfc41e35 + 40)
				mMovie:__wf_atom_4c1c1986(mClipName, "ValueDelta", 6, 10)
				local v4 = amount - amountDelta
				self:UpdateCurrencyEntry(state, mClipName .. ".Value", v4)
				self:UpdateCurrencyEntry(
					state,
					mClipName .. ".ValueDelta",
					math.abs(amountDelta),
					amountDelta > 0 and "+" or "-"
				)
				__wf_atom_ec43d06e(mMovie, mClipName .. ".BackerMid", 2, { 14 }, { v3 }, 0.4, 0.45)
				__wf_atom_ec43d06e(mMovie, mClipName .. ".BackerLeft", 2, { 0 }, { -v2 }, 0.4, 0.45)
				__wf_atom_ec43d06e(mMovie, mClipName .. ".Btn", 2, { 14 }, { v2 }, 0.4, 0.45)
				__wf_atom_ec43d06e(mMovie, mClipName .. ".ValueDelta", 2, { 12, 6 }, { 100, 100 }, 0.2, 0, function()
					__wf_atom_ec43d06e(
						mMovie,
						mClipName .. ".ValueDelta",
						1,
						{ 12, 1, 6 },
						{ 0, __wf_atom_cfc41e35, 10 },
						0.4,
						0.2
					)
					__wf_atom_ec43d06e(mMovie, mClipName .. ".Value.Amount", 2, {
						6,
						function(p2)
							self:UpdateCurrencyEntry(state, mClipName .. ".Value", v4 + amountDelta * p2)
						end
					}, { 150, 1 }, 0.4, 0.25, function()
						__wf_atom_ec43d06e(mMovie, mClipName .. ".Value.Amount", 1, { 6 }, { 100 }, 0.1)
					end)
				end)
			end

			mMovie:__wf_atom_e57658c2(mClipName, 0, -self.mCurrencyWidth)
			self.mCurrencyWidth += v2
		end,
		CreateCurrencies = function(self)
			self.mCurrencyWidth = 0
			local mClipName = self.mClipName
			local mCurrencies2 = {}

			if not self:GetOption("mOverwriteCurrencies") then
				local envoyInventoryControl = module3.GetEnvoyInventoryControl()

				if not __wf_atom_7e8ad928(envoyInventoryControl) then
					local __wf_atom_259e7653 = envoyInventoryControl:__wf_atom_259e7653(true)
					table.insert(mCurrencies2, {
						IsRegular = true,
						Icon = mMovie:__wf_atom_8e9ac384("<DRACS>", true),
						Amount = __wf_atom_259e7653.mRegularCredits,
						Name = Localize("/SF/Language/Currency/CurrencyName", nil),
						LocalizedDesc = Localize("/SF/Language/Currency/CurrencyDesc", nil),
						CustomEntry = true
					})
					table.insert(mCurrencies2, {
						IsPremium = true,
						Icon = mMovie:__wf_atom_8e9ac384("<PREMIUM_CURRENCY>", true),
						Amount = __wf_atom_259e7653.mPremiumCredits,
						Name = Localize("/SF/Language/Currency/PremiumCurrencyName", nil),
						LocalizedDesc = Localize("/SF/Language/Currency/PremiumCurrencyDesc", nil),
						CustomEntry = true
					})
				end
			end

			local inventory = gGameData:GetInventory()

			for _, v2 in ipairs(self:GetOption("mCustomCurrencies")) do
				local storeItem = v2.StoreItem

				if __wf_atom_7e8ad928(storeItem) then
					v2.CustomEntry = #v2.Name > 0
				else
					v2.Icon = storeItem:GetIconTexture()
					v2.Amount = inventory:__wf_atom_52fcdd65(storeItem:GetItem())
					v2.Name = Localize(storeItem:__wf_atom_014a76a2():c_str(), nil)
					v2.LocalizedDesc = Localize(storeItem:__wf_atom_3a3d2e39():c_str(), nil)
					v2.CustomEntry = true
				end

				table.insert(mCurrencies2, v2)
			end

			mMovie:__wf_atom_7f57ab2f(mClipName, "Money", 13, #mCurrencies2 > 0)
			local mCurrencies = self.mCurrencies
			local v2 = #mCurrencies == 0 or #mCurrencies ~= #mCurrencies2

			if not v2 then
				for k, v3 in mCurrencies2 do
					if not (mCurrencies[k] and mCurrencies[k].Amount ~= v3.Amount) then
						continue
					end

					v2 = true
					break
				end

				if not v2 then
					return
				end
			end

			self.mCurrencies = mCurrencies2

			for k, v3 in mCurrencies2 do
				v3.mId = k
				self:CreateCurrencyEntry(v3)
			end

			local v3 = math.max(#mCurrencies2 + 1, 2)

			while mMovie:__wf_atom_253d7085(mClipName .. ".Money.Currency" .. v3) do
				__wf_atom_86cbd68d(mMovie, mClipName .. ".Money.Currency" .. v3 .. ".removeMovieClip")
				v3 += 1
			end

			local v4 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".Name", 0) + mMovie:__wf_atom_5e6e15c8(mClipName .. ".Name", 40) + self.mCurrencyWidth + self.mPadding
			local v5 = math.max(self:GetOption("mMinWidth"), v4)
			mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 14, v5)
			mMovie:__wf_atom_4c1c1986(mClipName, "Money", 0, v5)
			mMovie:__wf_atom_4c1c1986(mClipName, "RightCap", 0, v5)
		end,
		UpdatePosition = function(self, p2)
			local mTargetY = p2 or self:GetOption("mDefaultY")

			if self.mTargetY ~= mTargetY then
				self.mTargetY = mTargetY

				if self.mQueueRedraw == self.QUEUE_STATE.IDLE then
					self.mQueueRedraw = self.QUEUE_STATE.HIDE_AND_REDRAW
				end
			end
		end,
		UpdateVisibility = function(self)
			local mVisible

			if self.mQueueRedraw == self.QUEUE_STATE.HIDE_AND_REDRAW then
				mVisible = false
			else
				mVisible = #self.mOptions > 0
			end

			if self.mVisible ~= mVisible then
				self.mVisible = mVisible

				if mVisible then
					self.mRequiresInput = true
					__wf_atom_ec43d06e(mMovie, self.mClipName, 2, { 12 }, { 100 }, self.mFadeInTime or 0.2)
				else
					_T.InfoPopup_Data = nil
					__wf_atom_ec43d06e(mMovie, self.mClipName, 2, { 12 }, { 0 }, self.mFadeOutTime or 0.2, 0, function()
						self.mRequiresInput = false
					end)
				end
			end
		end,
		Update = function(self)
			if __wf_atom_7e8ad928(gGameData) then
				return
			end

			self:UpdateVisibility()

			if
				self.mQueueRedraw == self.QUEUE_STATE.REDRAW
				or self.mQueueRedraw == self.QUEUE_STATE.HIDE_AND_REDRAW and not self.mRequiresInput
			then
				self.mQueueRedraw = self.QUEUE_STATE.IDLE
				self:ShowCurrencyBar()
			end

			if self.mVisible and #self.mCurrencies > 0 then
				self:CreateCurrencies()
			end
		end,
		GetOption = function(self, p2)
			local mOption = self.mOptions[1]

			if mOption == nil or mOption[p2] == nil then
				return self[p2]
			end

			return mOption[p2]
		end,
		UpdateRank = function(self, p2)
			local mClipName = self.mClipName
			local v2 = tonumber(mMovie:__wf_atom_4934c8e7(mClipName, "Level", 36))
			local option = tonumber(self:GetOption("mLevel"))
			local v3 = math.max(0.01, self:GetOption("mRankProgress"))

			local function fn(_) -- 2 equivalent calls inferred from this helper
				mMovie:__wf_atom_4c1c1986(
					mClipName,
					"RankFill.FillLine",
					1,
					mMovie:__wf_atom_cfc41e35(mClipName, "RankFill.Mask", 1) - mMovie:__wf_atom_cfc41e35(mClipName, "RankFill.Mask", 15)
				)
			end

			if v2 == nil or option == nil or p2 then
				mMovie:__wf_atom_48bd5a59(mClipName, "Level", 36, option)
				mMovie:__wf_atom_4c1c1986(mClipName, "RankFill.Mask", 6, v3)
				fn() -- inferred equivalent call
			else
				local v4 = __wf_atom_421b01aa(mMovie:__wf_atom_cfc41e35(mClipName, "RankFill.Mask", 6), 0.01, 100)

				if v2 < option or v3 ~= v4 then
					mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 5, 20)
					mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 6, 20)
					mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 12, 0)
					__wf_atom_ec43d06e(mMovie, mClipName .. ".Glow", 2, { 5, 6, 12 }, { 100, 100, 100 }, 0.25, 0)
					local function fn2()
						mMovie:__wf_atom_48bd5a59(mClipName, "Level", 36, v2)
						mMovie:__wf_atom_4c1c1986(mClipName, "RankFill.Mask", 6, v4)
						fn() -- inferred equivalent call
						local v5 = v2 < option and 100 or v3
						local v6 = 0.5 * (1 - v4 / 100)
						v4 = 0.01
						__wf_atom_ec43d06e(
							mMovie,
							mClipName .. ".RankFill.Mask",
							2,
							{ 6, fn },
							{ v5, 1 },
							v6,
							0,
							function()
								if v2 < option then
									v2 += 1
									fn2()
								else
									__wf_atom_ec43d06e(
										mMovie,
										mClipName .. ".Glow",
										1,
										{ 5, 6, 12 },
										{ 20, 20, 0 },
										0.5,
										0
									)
								end
							end
						)
					end

					fn2()
				end
			end
		end,
		ShowCurrencyBar = function(self)
			local mClipName = self.mClipName
			mMovie:__wf_atom_50d60589(mClipName, 1, self:GetOption("mTargetY"))
			local v2 = mMovie:__wf_atom_4934c8e7(mClipName, "Name", 36) ~= self:GetOption("mLabel")
			mMovie:__wf_atom_48bd5a59(mClipName, "Name", 36, self:GetOption("mLabel"))
			mMovie:__wf_atom_48bd5a59(mClipName, "Clan", 36, self:GetOption("mSubTitle"))
			self:UpdateRank(self:GetOption("mFirstDraw") or v2)
			self.mCurrencies = nil
			self:CreateCurrencies()
			local option = self:GetOption("mInnerIcon")
			local v3 = not __wf_atom_7e8ad928(option)
			mMovie:__wf_atom_7f57ab2f(mClipName, "InnerIcon", 13, v3)

			if v3 then
				mMovie:__wf_atom_c90af43a(mClipName .. ".InnerIcon", option)
			end
		end,
		ApplyOptions = function(self, p2)
			if __wf_atom_7e8ad928(p2.mMovie) then
				if #self.mOptions > 0 then
					local mOption = self.mOptions[1]

					for k, v2 in p2 do
						mOption[k] = v2
					end
				else
					return
				end
			else
				local v2 = false

				for k, mOption in self.mOptions do
					if mOption.mMovie ~= p2.mMovie then
						continue
					end

					for _, mCustomCurrency in mOption.mCustomCurrencies do
						for _, mCustomCurrency2 in p2.mCustomCurrencies do
							if not (mCustomCurrency.Name == mCustomCurrency2.Name and tonumber(mCustomCurrency.Amount) and tonumber(mCustomCurrency2.Amount)) then
								continue
							end

							mCustomCurrency2.AmountDelta = mCustomCurrency2.Amount - mCustomCurrency.Amount
						end
					end

					self.mOptions[k] = p2
					v2 = true
				end

				if not v2 then
					table.insert(self.mOptions, 1, p2)
				end
			end

			if #p2.mLabel == 0 then
				local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

				if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
					local mLevel, v2

					if __wf_atom_7e8ad928(gGameData) then
						mLevel = 0
						v2 = 0
					else
						local __wf_atom_d5bed0b3 = gGameData:__wf_atom_d5bed0b3()
						mLevel = __wf_atom_c67f9605:__wf_atom_f7423942(__wf_atom_d5bed0b3)
						local __wf_atom_e372699a = __wf_atom_c67f9605:__wf_atom_e372699a(__wf_atom_d5bed0b3)
						local __wf_atom_c927661a = __wf_atom_c67f9605:__wf_atom_c927661a(__wf_atom_d5bed0b3)
						v2 = (__wf_atom_d5bed0b3 - __wf_atom_e372699a) / (__wf_atom_c927661a - __wf_atom_e372699a)
					end

					p2.mLabel = __wf_atom_eab484a7:__wf_atom_6be84646()
					p2.mLevel = mLevel
					p2.mRankProgress = v2 * 100
				end
			end

			self.mQueueRedraw = self.QUEUE_STATE.REDRAW
		end,
		RemoveOptions = function(self, p2)
			for i = #self.mOptions, 1, -1 do
				local mMovie2 = self.mOptions[i].mMovie

				if not (__wf_atom_7e8ad928(mMovie2) or mMovie2 == p2) then
					continue
				end

				table.remove(self.mOptions, i)

				if i == 1 and #self.mOptions > 0 then
					self.mQueueRedraw = self.QUEUE_STATE.REDRAW
				end
			end
		end
	}

	for k, v2 in pairs(options or {}) do
		result[k] = v2
	end

	function _T:ShowCurrencyBar()
		result:ApplyOptions(self)
	end

	function _T.HideCurrencyBar(p2)
		result:RemoveOptions(p2)
	end

	local uiColor_Yellow = _G.UIColor_Yellow
	local v2 = {
		Inner = module.ConvertColorNumberToProceduralRGB(_G.UIColor_DarkBrown)
	}
	v2.Edge = v2.Inner
	mMovie:__wf_atom_4c1c1986(mClipName2, "Name", 44, uiColor_Yellow)
	mMovie:__wf_atom_4c1c1986(mClipName2, "Clan", 44, uiColor_Yellow)
	mMovie:__wf_atom_4c1c1986(mClipName2, "Rank", 44, uiColor_Yellow)
	mMovie:__wf_atom_4c1c1986(mClipName2, "Level", 44, uiColor_Yellow)
	mMovie:__wf_atom_4c1c1986(mClipName2, "Glow", 12, 0)
	mMovie:OverrideMaterial(mClipName2 .. ".Glow", result.mRankUpRaysMaterial)
	mMovie:OverrideMaterial(mClipName2 .. ".Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(mClipName2 .. ".Bg", "RectInnerColor", v2.Inner.r, v2.Inner.g, v2.Inner.b, 0.8)
	mMovie:__wf_atom_1ca72041(mClipName2 .. ".Bg", "RectEdgeColor", v2.Edge.r, v2.Edge.g, v2.Edge.b, 0.8)
	result:UpdatePosition()
	result:SetCallbacks()
	return result
end