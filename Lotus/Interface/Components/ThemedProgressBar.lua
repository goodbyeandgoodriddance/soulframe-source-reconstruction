module(..., package.seeall)

function Create(object, mClipName, value, options, p, mTotalValue3)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.UIStyleUtilities")

	if mTotalValue3 == nil or mTotalValue3 == false then
		mTotalValue3 = 100
	elseif mTotalValue3 == true then
		mTotalValue3 = nil
	end

	local v = {
		mClipName = mClipName,
		mWidth = value or 100,
		mHeight = 11,
		mValues = options or {},
		mRectMaterial = p or _G.UIMaterial_RectangleNoDepth,
		mBarColors = { 9, 6, 10 },
		mBackerColor = 3,
		mPadding = 1,
		mEdgePadding = 1,
		mBgEdgeAlpha = 1,
		mBgInnerAlpha = 1,
		mFillEdgeAlpha = 1,
		mTotalValue = mTotalValue3,
		GetParentEnv = function(p2)
			if p2.mParentEnv ~= nil then
				return p2.mParentEnv
			end

			local v = 1
			local mParentEnv

			repeat
				mParentEnv = getfenv(v)
				v += 1
			until mParentEnv.mMovie

			p2.mParentEnv = mParentEnv
			return mParentEnv
		end,
		UpdateText = function(_) end,
		InitializeBarColor = function(self, p2)
			local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module2.GetColor(self.mBarColors[p2], true))
			object:__wf_atom_1ca72041(
				mClipName .. ".Fill" .. p2,
				"RectInnerColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				1
			)
			object:__wf_atom_1ca72041(
				mClipName .. ".Fill" .. p2,
				"RectEdgeColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				self.mFillEdgeAlpha
			)
		end,
		UpdateColors = function(self)
			local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module2.GetColor(self.mBackerColor, true))
			local v

			if self.mBgEdgeColor == nil then
				v = convertColorNumberToProceduralRGB
			else
				v = module.ConvertColorNumberToProceduralRGB(module2.GetColor(self.mBgEdgeColor, true))
			end

			object:__wf_atom_1ca72041(
				mClipName .. ".Bg",
				"RectInnerColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				self.mBgInnerAlpha
			)
			object:__wf_atom_1ca72041(mClipName .. ".Bg", "RectEdgeColor", v.r, v.g, v.b, self.mBgEdgeAlpha)

			for i = 1, #self.mBarColors do
				self:InitializeBarColor(i)
			end
		end,
		SetProgress = function(self, options2, value2, mTotalValue)
			local v = value2 or 0.15

			if mTotalValue ~= nil then
				self.mTotalValue = mTotalValue
			end

			local mTotalValue2 = self.mTotalValue or 0

			for k, v2 in pairs(options2 or {}) do
				self.mValues[k] = v2
			end

			for i = 1, #self.mValues do
				if self.mTotalValue == nil then
					mTotalValue2 += self.mValues[i]
				end

				if not object:__wf_atom_253d7085(mClipName .. ".Fill" .. i) then
					__wf_atom_86cbd68d(object, mClipName .. ".Fill1.duplicateMovieClip", "Fill" .. i, i)
					object:OverrideMaterial(mClipName .. ".Fill" .. i, self.mRectMaterial)
					self:InitializeBarColor(i)
				end

				object:__wf_atom_e57658c2(mClipName .. ".Fill" .. i, 1, self.mEdgePadding)
				object:__wf_atom_e57658c2(mClipName .. ".Fill" .. i, 15, self.mHeight - self.mEdgePadding * 2)
			end

			local v2 = math.max(#self.mValues + 1, 2)

			while object:__wf_atom_253d7085(mClipName .. ".Fill" .. v2) do
				__wf_atom_86cbd68d(object, mClipName .. ".Fill" .. v2 .. ".removeMovieClip")
				v2 += 1
			end

			local ternary = module.Ternary(self.mFillEdgeAlpha == 0, 5, 1)
			local v3 = self.mWidth - self.mEdgePadding
			local v4 = self.mWidth - self.mEdgePadding * 2 + self.mPadding
			local v5 = 0
			local mEdgePadding = self.mEdgePadding
			local v6 = 0

			for i, mValue in ipairs(self.mValues) do
				if mValue == 0 then
					v5 = 0
				else
					local v7 = mValue / mTotalValue2 * v4 - self.mPadding + v6
					v5 = math.max(ternary, (math.floor(v7 + 0.5)))
					v6 = v7 - v5
				end

				if v3 < mEdgePadding + v5 then
					v5 = v3 - mEdgePadding
				end

				local v7 = i
				__wf_atom_ec43d06e(
					object,
					mClipName .. ".Fill" .. i,
					2,
					{ 14, 0 },
					{ v5, mEdgePadding },
					v,
					0,
					function()
						if v5 <= 0 then
							object:__wf_atom_2dedec1a(mClipName .. ".Fill" .. v7, 13, false)
						end
					end
				)

				if not (v5 > 0) then
					continue
				end

				object:__wf_atom_2dedec1a(mClipName .. ".Fill" .. i, 13, true)
				mEdgePadding = mEdgePadding + v5 + self.mPadding
			end
		end,
		SetWidth = function(self, mWidth)
			self.mWidth = mWidth
			object:__wf_atom_e57658c2(mClipName .. ".Bg", 14, mWidth)
			self:SetProgress(nil, 0)
		end,
		SetHeight = function(p2, mHeight)
			p2.mHeight = mHeight
			object:__wf_atom_e57658c2(mClipName .. ".Bg", 15, mHeight)
		end,
		SetVisible = function(p2, p3)
			p2.mVisible = p3 == true
			object:__wf_atom_2dedec1a(mClipName, 13, p2.mVisible)
		end,
		Redraw = function(self)
			object:__wf_atom_2dedec1a(mClipName .. ".Fill1", 13, false)
			self:SetWidth(self.mWidth)
			object:OverrideMaterial(mClipName .. ".Fill1", self.mRectMaterial)
			object:OverrideMaterial(mClipName .. ".Bg", self.mRectMaterial)
			self:UpdateColors()
		end
	}
	v:Redraw()
	return v
end