module(..., package.seeall)
local module = require("EE.Interface.Utilities")

function Create(p, value, callback, items)
	local mMovie = p.mMovie
	local _ = not mMovie:__wf_atom_253d7085(value)
	local result = {
		mStates = nil,
		mSelectedStateId = nil,
		SetStateId = function(self, p2)
			local mSelectedStateId = self.mSelectedStateId
			local v = p2 or mSelectedStateId or 1
			local mSelectedStateId2

			if v < 1 then
				mSelectedStateId2 = #self.mStates
			else
				mSelectedStateId2 = #self.mStates < v and 1 or v
			end

			if mSelectedStateId2 == mSelectedStateId then
				return
			end

			self.mSelectedStateId = mSelectedStateId2

			if mSelectedStateId ~= nil then
				local v2 = value .. ".State" .. mSelectedStateId
				mMovie:__wf_atom_7f57ab2f(v2, "Bookends", 13, false)
				mMovie:__wf_atom_4c1c1986(v2, "Label", 11, _G.UIColor_Beige)
			end

			local v2 = value .. ".State" .. mSelectedStateId2
			mMovie:__wf_atom_7f57ab2f(v2, "Bookends", 13, true)
			mMovie:__wf_atom_4c1c1986(v2, "Label", 11, _G.UIColor_Yellow)

			if callback ~= nil then
				callback(mSelectedStateId2)
			end
		end,
		SetStates = function(self, mStates, p2)
			self.mStates = mStates

			if #mStates > 1 then
				local v = string.gsub(value, "%.", "")
				local v2 = v .. "RollOver"
				local v3 = v .. "RollOut"
				local v4 = v .. "Select"
				local v5 = 0

				for k, mState in mStates do
					local v6 = value .. ".State" .. k

					if not mMovie:__wf_atom_253d7085(v6) then
						__wf_atom_86cbd68d(mMovie, value .. ".State1.duplicateMovieClip", "State" .. k, k)
					end

					mMovie:__wf_atom_4c1c1986(v6, "Btn", 100, k)
					mMovie:__wf_atom_7f57ab2f(v6, "Bookends", 13, false)
					mMovie:__wf_atom_7f57ab2f(v6, "Bookends.Right", 13, false)
					mMovie:SetCallbacks(v6 .. ".Btn", v2, v3, v4, nil)
					mMovie:__wf_atom_4c1c1986(v6, "Label", 11, _G.UIColor_Beige)
					mMovie:__wf_atom_48bd5a59(v6, "Label", 36, Localize(mState.Name, nil))
					local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v6, "Label", 40)
					mMovie:__wf_atom_4c1c1986(
						v6,
						"Bookends.Right",
						0,
						__wf_atom_cfc41e35 + -mMovie:__wf_atom_cfc41e35(v6, "Bookends.Left", 0) * 2
					)
					mMovie:__wf_atom_4c1c1986(v6, "Btn", 14, __wf_atom_cfc41e35)
					v5 = math.max(v5, __wf_atom_cfc41e35)
				end

				local total = 0

				for k, _ in mStates do
					mMovie:__wf_atom_e57658c2(value .. ".State" .. k, 0, total)
					total += v5 + 50
				end

				mMovie:__wf_atom_4c1c1986(value, "Backer", 14, total)
				self:SetStateId(p2)
			end

			mMovie:__wf_atom_2dedec1a(value, 13, #mStates > 1)
		end,
		GetActiveState = function(p2)
			if p2.mStates == nil then
				return nil
			end

			return p2.mStates[p2.mSelectedStateId]
		end,
		FocusElementById = function(p2, p3)
			if p2.mSelectedStateId == p3 then
				return
			end

			mMovie:__wf_atom_4c1c1986(value .. ".State" .. p3, "Label", 11, _G.UIColor_Yellow)
			module.PlaySound(_G.UISound_Focus)
		end,
		UnfocusElementById = function(p2, p3)
			if p2.mSelectedStateId == p3 then
				return
			end

			mMovie:__wf_atom_4c1c1986(value .. ".State" .. p3, "Label", 11, _G.UIColor_Beige)
			module.PlaySound(_G.UISound_Unfocus)
		end,
		SelectElementById = function(self, p2)
			self:SetStateId(p2)
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

	mMovie:__wf_atom_4c1c1986(value, "Backer", 12, 80)
	local v = string.gsub(value, "%.", "")
	result:AssignCallback(v, "RollOver", result.FocusElementById)
	result:AssignCallback(v, "RollOut", result.UnfocusElementById)
	result:AssignCallback(v, "Select", result.SelectElementById)
	result:SetStates()
	return result
end