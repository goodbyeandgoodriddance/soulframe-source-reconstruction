module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")
local v = Resource("/Lotus/Interface/Materials/SpinnerLoomMaterial")
local v2 = Resource("/SF/Interface/Graphics/LoadingAnimation/BirdFlipbook_d.png")
local v3 = Resource("/SF/Interface/Graphics/LoadingAnimation/BirdFlipbook")

function Create(mMovie2, mClipName2, mCallback)
	local v4 = {
		mMovie = mMovie2,
		mClipName = mClipName2,
		mCallback = mCallback,
		mActive = false,
		mVisible = false,
		mScale = 60,
		mApplyThemes = true,
		OnGamepadTransition = function(self, _) end,
		OnViewportSizeChanged = function(_) end,
		UpdateColors = function(self)
			local mMovie = self.mMovie
			local mClipName = self.mClipName
			local mApplyThemes = self.mApplyThemes
			local color = module2.GetColor(2, true, mApplyThemes)
			local color2 = module2.GetColor(10, true, mApplyThemes)

			if not mApplyThemes then
				mMovie:__wf_atom_4c1c1986(mClipName, "Darkener", 12, 60)
				color = 0
			end

			mMovie:__wf_atom_4c1c1986(mClipName, "Darkener", 11, color)
			mMovie:__wf_atom_4c1c1986(mClipName, "Diamonds", 11, color2)
			mMovie:__wf_atom_4c1c1986(mClipName, "LeftLoom", 11, color2)
			mMovie:__wf_atom_4c1c1986(mClipName, "RightLoom", 11, color2)
		end,
		Redraw = function(self)
			self:UpdateColors()
		end,
		SetText = function(p, p2)
			local mMovie = p.mMovie
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(p2, true)
			mMovie:__wf_atom_48bd5a59(p.mClipName, "Label", 36, __wf_atom_8e9ac384)
		end,
		SetActive = function(self, p, value, value2)
			local mActive = p ~= false

			if self.mActive == mActive then
				return
			end

			self.mActive = mActive
			local v4 = value or 0.2
			local v5 = value2 or 0
			local mMovie = self.mMovie
			local mClipName = self.mClipName

			if mActive then
				if mMovie:__wf_atom_1b848254(mClipName) then
					print("ThemedSpinner activated after just being deactivated! ClipName: " .. mClipName)
				else
					__wf_atom_86cbd68d(mMovie, mClipName .. ".Diamonds.gotoAndPlay", 1)
					__wf_atom_86cbd68d(mMovie, mClipName .. ".LeftLoom.gotoAndPlay", 1)
					__wf_atom_86cbd68d(mMovie, mClipName .. ".RightLoom.gotoAndPlay", 1)
				end

				self.mVisible = true
				self:UpdateColors()
				__wf_atom_ec43d06e(mMovie, mClipName, 1, { 12 }, { 100 }, v4, v5)
			else
				__wf_atom_ec43d06e(mMovie, mClipName, 1, { 12 }, { 0 }, v4, v5, function()
					__wf_atom_86cbd68d(mMovie, mClipName .. ".Diamonds.stop")
					__wf_atom_86cbd68d(mMovie, mClipName .. ".LeftLoom.stop")
					__wf_atom_86cbd68d(mMovie, mClipName .. ".RightLoom.stop")
					self.mVisible = false
				end)
			end

			if self.mCallback ~= nil then
				self.mCallback(mActive)
			end
		end,
		IsActive = function(p)
			return p.mActive
		end,
		IsVisible = function(p)
			return p.mVisible
		end,
		SetBackerVisible = function(p, p2)
			p.mMovie:__wf_atom_7f57ab2f(p.mClipName, "Darkener", 13, p2)
		end,
		SetScale = function(state, mScale)
			state.mScale = mScale
			state.mMovie:__wf_atom_e57658c2(mClipName2, 5, state.mScale)
			state.mMovie:__wf_atom_e57658c2(mClipName2, 6, state.mScale)
		end,
		Update = function(data, p)
			if not (data.mActive and data.mVisible) then
				return
			end

			for _, v4 in ipairs({ ".LeftLoom", ".RightLoom" }) do
				local v5 = data.mClipName .. v4
				local __wf_atom_5e6e15c8 = data.mMovie:__wf_atom_5e6e15c8(v5 .. ".Flare1", 0)
				local __wf_atom_5e6e15c8_2 = data.mMovie:__wf_atom_5e6e15c8(v5 .. ".BackCap1", 0)

				if __wf_atom_5e6e15c8 == nil or __wf_atom_5e6e15c8_2 == nil then
					print("Outdated spinner: " .. data.mClipName)
				else
					local ternary = module.Ternary(
						__wf_atom_5e6e15c8_2 < __wf_atom_5e6e15c8,
						__wf_atom_5e6e15c8_2,
						__wf_atom_5e6e15c8
					)
					local v6 = module.Ternary(
						__wf_atom_5e6e15c8_2 < __wf_atom_5e6e15c8,
						__wf_atom_5e6e15c8,
						__wf_atom_5e6e15c8_2
					) - ternary
					local v7 = (ternary + v6 * 0.5) / 512 + 0.5
					local v8 = (v6 * 0.5 + 20) / 512
					data.mMovie:__wf_atom_1ca72041(v5 .. ".Loom", "VisibilityCenter", v7, 0, 0, 0)
					data.mMovie:__wf_atom_1ca72041(v5 .. ".Loom", "VisibilitySize", v8, 0, 0, 0)
					data.mMovie:__wf_atom_1ca72041(v5 .. ".Loom", "VisibilityFadeSize", 0.01953125, 0, 0, 0)
				end
			end
		end
	}
	mMovie2:__wf_atom_e57658c2(mClipName2, 12, 0)
	mMovie2:__wf_atom_e57658c2(mClipName2, 5, v4.mScale)
	mMovie2:__wf_atom_e57658c2(mClipName2, 6, v4.mScale)
	mMovie2:__wf_atom_4c1c1986(mClipName2, "Darkener", 12, 100)
	mMovie2:__wf_atom_4c1c1986(mClipName2, "Darkener", 14, 140)
	mMovie2:__wf_atom_4c1c1986(mClipName2, "Darkener", 15, 140)
	mMovie2:__wf_atom_c90af43a(mClipName2 .. ".Darkener", _G.UITexture_CircleGradientBacker)
	mMovie2:OverrideMaterial(mClipName2 .. ".LeftLoom.Loom", v)
	mMovie2:OverrideMaterial(mClipName2 .. ".RightLoom.Loom", v)
	mMovie2:__wf_atom_933bbce0(mClipName2 .. ".Bird", v2, v3)
	__wf_atom_86cbd68d(mMovie2, mClipName2 .. ".Diamonds.stop")
	__wf_atom_86cbd68d(mMovie2, mClipName2 .. ".LeftLoom.stop")
	__wf_atom_86cbd68d(mMovie2, mClipName2 .. ".RightLoom.stop")
	v4:OnGamepadTransition(not Engine.IsPlayingWithController())
	v4:Redraw()
	return v4
end