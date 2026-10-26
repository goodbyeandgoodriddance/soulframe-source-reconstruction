module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local v = {
	[3] = 13,
	[5] = 2,
	[6] = {
		{ SubIcon = 3 },
		{ SubCategory = "accessories", SubIcon = 17 }
	},
	[2] = 4,
	[4] = {
		{
			SubType = WeakResource("/SF/Types/Items/Kintsugi/BaseKintsugiUpgrade"),
			SubIcon = 5
		},
		{
			SubType = WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade"),
			SubIcon = 11
		},
		{
			SubType = WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade"),
			SubIcon = 12
		},
		{
			SubType = WeakResource("/SF/Types/Items/Aspects/Tempers/BaseAspectTemper"),
			SubIcon = 25
		}
	},
	[13] = 7,
	[11] = 8,
	[9] = {
		{ SubIcon = 16 },
		{ SubCategory = "founders", SubIcon = 15 }
	},
	[19] = 14
}

local function fn(subType, subType2) -- 1 equivalent call inferred from this helper
	if subType2 == nil then
		return true
	end

	if __wf_atom_7e8ad928(subType) or not subType:IsA(subType2) then
		return false
	end

	return not subType:IsA(WeakResource("/SF/Souls/Common/SFIdolMod"))
end

local function fn2(mCategory)
	local ternary = module.Ternary(mCategory.IconIndex ~= nil, mCategory.IconIndex, v[mCategory.ItemType])

	if tonumber(ternary) ~= nil then
		return _G.UITexture_CategoryIcons[ternary]
	end

	if ternary == nil then
		return _G.UITexture_CategoryIcons[1]
	end

	for _, v2 in ipairs(ternary) do
		if mCategory.SubCategory == v2.SubCategory and fn(mCategory.SubType, v2.SubType) then -- inferred equivalent call
			return _G.UITexture_CategoryIcons[v2.SubIcon]
		end
	end

	return _G.UITexture_CategoryIcons[1]
end

function Create(p, value, callback, items)
	local mMovie = p.mMovie
	local _ = not mMovie:__wf_atom_253d7085(value)
	local result = {
		mCategories = nil,
		mSelectedCategoryId = nil,
		SetCategoryId = function(self, p2)
			local mSelectedCategoryId = self.mSelectedCategoryId
			local v2 = p2 or mSelectedCategoryId or 1
			local mSelectedCategoryId2

			if v2 < 1 then
				mSelectedCategoryId2 = #self.mCategories
			else
				mSelectedCategoryId2 = #self.mCategories < v2 and 1 or v2
			end

			local _ = mSelectedCategoryId2 == mSelectedCategoryId
			self.mSelectedCategoryId = mSelectedCategoryId2

			if mSelectedCategoryId ~= nil then
				local v3 = value .. ".List.Tab" .. mSelectedCategoryId
				mMovie:__wf_atom_7f57ab2f(v3, "Detail", 13, false)
				mMovie:OverrideMaterial(v3 .. ".Backer", _G.UIMaterial_UnfocusedTabBorder)
			end

			local v3 = value .. ".List.Tab" .. mSelectedCategoryId2
			mMovie:__wf_atom_7f57ab2f(v3, "Detail", 13, true)
			mMovie:OverrideMaterial(v3 .. ".Backer", _G.UIMaterial_SelectedTabBorder)

			if callback ~= nil then
				callback(mSelectedCategoryId2)
			end
		end,
		SetCategories = function(self, mCategories, p2)
			self.mCategories = mCategories

			if #mCategories > 1 then
				local v2 = string.gsub(value, "%.", "")
				local v3 = v2 .. "RollOver"
				local v4 = v2 .. "RollOut"
				local v5 = v2 .. "Select"
				local total = 0

				for k, mCategory in mCategories do
					local v6 = value .. ".List.Tab" .. k

					if not mMovie:__wf_atom_253d7085(v6) then
						__wf_atom_86cbd68d(mMovie, value .. ".List.Tab1.duplicateMovieClip", "Tab" .. k, k)
					end

					mMovie:__wf_atom_e57658c2(v6, 1, total)
					mMovie:__wf_atom_4c1c1986(v6, "Btn", 100, k)
					mMovie:__wf_atom_7f57ab2f(v6, "Detail", 13, false)
					mMovie:SetCallbacks(v6 .. ".Btn", v3, v4, v5, nil)
					mMovie:OverrideMaterial(v6 .. ".Backer", _G.UIMaterial_UnfocusedTabBorder)
					mMovie:__wf_atom_c90af43a(v6 .. ".Icon", (fn2(mCategory)))

					if __wf_atom_7e8ad928(mCategory.Enabled) or mCategory.Enabled then
						mMovie:__wf_atom_e57658c2(v6, 12, 100)
					else
						mMovie:__wf_atom_e57658c2(v6, 12, 30)
					end

					if mCategory.SpecialIcon then
						mMovie:__wf_atom_c90af43a(v6 .. ".SpecialIcon", mCategory.SpecialIcon)
						mMovie:__wf_atom_7f57ab2f(v6, "SpecialIcon", 13, true)
					else
						mMovie:__wf_atom_7f57ab2f(v6, "SpecialIcon", 13, false)
					end

					total += 60
				end

				self:SetCategoryId(p2)
				local v6 = #mCategories + 1
				local v7 = value .. ".List.Tab"

				while mMovie:__wf_atom_253d7085(v7 .. v6) do
					__wf_atom_86cbd68d(mMovie, v7 .. v6 .. ".removeMovieClip")
					v6 += 1
				end

				local mMaskEnabled = self.mMaskEnabled ~= false
				self.mMaskEnabled = nil
				self:SetMasked(mMaskEnabled)
			end

			mMovie:__wf_atom_2dedec1a(value, 13, #mCategories > 1)
		end,
		GetActiveCategory = function(p2)
			if p2.mCategories == nil then
				return nil
			end

			return p2.mCategories[p2.mSelectedCategoryId]
		end,
		SetMasked = function(self, p2)
			if self.mMaskEnabled == p2 then
				return
			end

			self.mMaskEnabled = p2 ~= false
			mMovie:__wf_atom_7f57ab2f(value, "Mask", 13, p2)

			for k, _ in self.mCategories do
				local v2 = value .. ".List.Tab" .. k
				mMovie:__wf_atom_7f57ab2f(v2, "Detail.Right", 13, not p2)

				if p2 then
					mMovie:__wf_atom_4c1c1986(v2, "Backer", 0, 0)
					mMovie:__wf_atom_4c1c1986(v2, "Backer", 14, 148)
				else
					mMovie:__wf_atom_4c1c1986(v2, "Backer", 0, mMovie:__wf_atom_cfc41e35(v2, "Icon", 0) - 31)
					mMovie:__wf_atom_4c1c1986(v2, "Backer", 14, 84)
				end
			end
		end,
		FocusElementById = function(p2, p3)
			local mCategory = p2.mCategories[p3]
			local gToolTip

			if mCategory ~= nil then
				gToolTip = Localize(mCategory.Name, nil)
			end

			if #gToolTip > 0 then
				_T.gToolTip = gToolTip
			else
				_T.gToolTip = nil
			end

			if p2.mSelectedCategoryId == p3 then
				return
			end

			mMovie:OverrideMaterial((value .. ".List.Tab" .. p3) .. ".Backer", _G.UIMaterial_FocusedTabBorder)
			module.PlaySound(_G.UISound_Focus)
		end,
		UnfocusElementById = function(p2, p3)
			_T.gToolTip = nil
			mMovie:OverrideMaterial(
				(value .. ".List.Tab" .. p3) .. ".Backer",
				p2.mSelectedCategoryId == p3 and _G.UIMaterial_SelectedTabBorder or _G.UIMaterial_UnfocusedTabBorder
			)
			module.PlaySound(_G.UISound_Unfocus)
		end,
		SelectElementById = function(self, p2)
			self:SetCategoryId(p2)
			module.PlaySound(_G.UISound_Select)
		end,
		AssignCallback = function(self, p2, p3, callback2)
			p[p2 .. p3] = function(p4)
				callback2(self, (tonumber(p4)))
			end
		end
	}

	for k, item in pairs(items) do
		result[k] = item
	end

	local v2 = string.gsub(value, "%.", "")
	result:AssignCallback(v2, "RollOver", result.FocusElementById)
	result:AssignCallback(v2, "RollOut", result.UnfocusElementById)
	result:AssignCallback(v2, "Select", result.SelectElementById)
	result:SetCategories()
	return result
end