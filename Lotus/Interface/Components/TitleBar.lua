module(..., package.seeall)
UnderlineFillTexture = Resource("/Lotus/Interface/Graphics/Themes/TitleDividerBody.png")
UnderlineStartTexture = Resource("/Lotus/Interface/Graphics/Themes/TitleDividerStart.png")
UnderlineCapTexture = Resource("/Lotus/Interface/Graphics/Themes/TitleDividerEnd.png")
local module = require("Lotus.Interface.UIStyleUtilities")
local module2 = require("EE.Interface.Utilities")
local v = { _ko = true, _ja = true, _zh = true, _tc = true }

function Create(mMovie2, mClipName2, value, value2, p)
	local v2 = {
		mMovie = mMovie2,
		mClipName = mClipName2,
		mApplyThemes = true,
		mTitle = value or "",
		mSubTitle = value2 or "",
		mVisible = nil,
		mTitleVisible = true,
		mBookendVisible = true,
		mBookendPadding = -16,
		mBookendIcon = p or Resource("/Lotus/Interface/Graphics/Themes/TitleDecoration.png"),
		mInitTitleXPos = mMovie2:__wf_atom_5e6e15c8(mClipName2 .. ".Title", 0),
		Resize = function(self)
			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local mBookendPadding = self.mBookendPadding

			if v[__wf_atom_b953295d():c_str()] then
				mMovie:__wf_atom_4c1c1986(mClipName, "Title.Label", 77, 0)
			end

			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".Title", 0)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".Title.Label", 40)
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(mClipName .. ".Title.BookendIcon", 14)
			local v2 = not self.mBookendVisible and 0 or __wf_atom_5e6e15c8_3
			local v3 = __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 + mBookendPadding + v2
			mMovie:__wf_atom_4c1c1986(mClipName, "Title.BookendIcon", 0, __wf_atom_5e6e15c8_2 + mBookendPadding)
			mMovie:__wf_atom_4c1c1986(mClipName, "Underline.Fill", 14, v3)
			mMovie:__wf_atom_4c1c1986(mClipName, "Underline.CapRight", 0, v3 + 32)
		end,
		UpdateText = function(self)
			local mMovie = self.mMovie

			if __wf_atom_7e8ad928(mMovie) then
				return
			end

			local mClipName = self.mClipName
			local mVisible = self.mTitle ~= "" or self.mSubTitle ~= ""

			if self.mVisible ~= mVisible then
				self.mVisible = mVisible

				if mVisible then
					__wf_atom_ec43d06e(mMovie, mClipName, 2, { 12 }, { 100 }, 0.2)
				else
					__wf_atom_ec43d06e(mMovie, mClipName, 1, { 12 }, { 0 }, 0.2)
				end
			end

			if not mVisible then
				return
			end

			local mApplyThemes = self.mApplyThemes
			local color = module.GetColor(9, true, mApplyThemes)
			local color2 = module.GetColor(10, true, mApplyThemes)
			local v2 = (self.mTitle == "" or self.mSubTitle == "") and "" or "/"
			local v3 = "<font color=\"#" .. string.format("%X", color) .. "\">" .. string.upper(self.mTitle) .. v2 .. "</font>"
			local v4 = "<font color=\"#" .. string.format("%X", color2) .. "\">" .. string.upper(self.mSubTitle) .. " </font>"

			if self.mTitleChanged then
				self.mTitleChanged = false
				module2.AnimateTyping(
					mMovie,
					nil,
					mClipName .. ".Title.Label",
					"<p>" .. v3 .. v4 .. "</p>",
					nil,
					1,
					0.15
				)
			else
				mMovie:__wf_atom_50d60589(mClipName .. ".Title.Label", 36, "<p>" .. v3 .. v4 .. "</p>")
			end

			self:Resize()
		end,
		UpdateIcon = function(self)
			self.mMovie:__wf_atom_c90af43a(
				self.mClipName .. ".Title.BookendIcon",
				module.GetIconOverride(self.mBookendIcon)
			)
		end,
		UpdateColors = function(self)
			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local mApplyThemes = self.mApplyThemes
			local color = module.GetColor(2, true, mApplyThemes)
			local color2 = module.GetColor(9, true, mApplyThemes)
			mMovie:__wf_atom_4c1c1986(mClipName, "Title.Label", 90, color)
			mMovie:__wf_atom_4c1c1986(mClipName, "Title.BookendIcon", 11, color2)
			mMovie:__wf_atom_4c1c1986(mClipName, "Underline", 11, color2)
			self:UpdateText()
			self:UpdateIcon()
		end,
		Redraw = function(self)
			local mMovie = self.mMovie
			local mClipName = self.mClipName
			mMovie:__wf_atom_c90af43a(mClipName .. ".Underline.Fill", UnderlineFillTexture)
			mMovie:__wf_atom_c90af43a(mClipName .. ".Underline.CapRight", UnderlineCapTexture)
			mMovie:__wf_atom_c90af43a(mClipName .. ".Underline.CapLeft", UnderlineStartTexture)
			self:UpdateColors()
		end,
		SetLabels = function(self, value3, value4)
			local mTitle = value3 or ""
			local mSubTitle = value4 or ""
			self.mTitleChanged = self.mTitle ~= mTitle or self.mSubTitle ~= mSubTitle
			self.mTitle = mTitle
			self.mSubTitle = mSubTitle
			self:UpdateText()
		end,
		HasText = function(p2)
			return p2.mTitle ~= "" or p2.mSubTitle ~= ""
		end,
		SetBookendIcon = function(self, mBookendIcon)
			self.mBookendIcon = mBookendIcon
			self:UpdateIcon()
		end,
		SetBookendVisible = function(self, mBookendVisible, p2)
			self.mBookendVisible = mBookendVisible
			self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Title.BookendIcon", 13, mBookendVisible)

			if p2 then
				self:Resize()
			end
		end,
		SetTitleVisible = function(state, mTitleVisible)
			state.mTitleVisible = mTitleVisible
			state.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Title", 13, mTitleVisible)
		end
	}
	v2:SetBookendVisible(false)
	v2:Redraw()
	return v2
end