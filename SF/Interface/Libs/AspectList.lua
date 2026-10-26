module(..., package.seeall)
local module = require("SF.Interface.Libs.ItemUtil")
local module2 = require("SF.Interface.Libs.UIUtilities")

function Create(p, p2)
	local mMovie = p.mMovie
	local module3 = require("EE.Interface.Components.Grid")
	local newGrid = module3.CreateNewGrid(p, p2)
	newGrid.mRows = 2
	newGrid.mColumns = 4
	newGrid.mRowSeparation = 130
	newGrid.mColumnSeparation = 130
	newGrid.mCanSelectItem = true

	function newGrid.mClipCreatedCallback(p3)
		mMovie:__wf_atom_7f57ab2f(p3, "Sparkle", 13, false)
	end

	function newGrid.ResetElements(_)
		newGrid:RunForAllElements(function(p3)
			mMovie:__wf_atom_4c1c1986(p3.mClipName, "IconComponent", 12, 100)
		end)
	end

	function newGrid.mElementDrawCallback(p3)
		module.Initialize(mMovie, p3.mClipName .. ".IconComponent", p3)
	end

	function newGrid:mOnFocusedCallback()
		if __wf_atom_7e8ad928(newGrid.mItemInfoPopupRect) then
			module2.SetItemInfoPopupRect(
				mMovie,
				self,
				mMovie:__wf_atom_cfc41e35(self.mClipName, "Btn", 2) + newGrid.mColumnSeparation,
				mMovie:__wf_atom_cfc41e35(self.mClipName, "Btn", 3),
				mMovie:__wf_atom_cfc41e35(self.mClipName, "Btn", 14),
				mMovie:__wf_atom_cfc41e35(self.mClipName, "Btn", 15)
			)
		else
			module2.SetItemInfoPopupRect(
				mMovie,
				self,
				newGrid.mItemInfoPopupRect.X,
				newGrid.mItemInfoPopupRect.Y,
				newGrid.mItemInfoPopupRect.W,
				newGrid.mItemInfoPopupRect.H
			)
		end

		_T.InfoPopup_Data = self
		mMovie:__wf_atom_4c1c1986(self.mClipName, "IconComponent", 12, 100)
		local v = self == newGrid.mSelectedElement
		self.Selected = newGrid.mCanSelectItem and v
		self.Focused = true
		module.UpdateFocus(mMovie, self.mClipName .. ".IconComponent", self, newGrid)
	end

	function newGrid:mOnUnfocusedCallback()
		if not __wf_atom_7e8ad928(self.UnfocusedAlpha) then
			mMovie:__wf_atom_4c1c1986(self.mClipName, "IconComponent", 12, self.UnfocusedAlpha)
		end

		_T.InfoPopup_Data = nil
		local v = self == newGrid.mSelectedElement
		self.Selected = newGrid.mCanSelectItem and v
		self.Focused = self.Selected
		module.UpdateFocus(mMovie, self.mClipName .. ".IconComponent", self, newGrid)
	end

	newGrid.Base_OnSelected = newGrid.OnSelected

	function newGrid.OnSelected(p3, p4, p5)
		newGrid.Base_OnSelected(p3, p4, p5)
		newGrid:RunForAllElements(function(p6)
			mMovie:__wf_atom_7f57ab2f(p6.mClipName, "Sparkle", 13, false)
			mMovie:__wf_atom_4c1c1986(p6.mClipName, "Title", 12, 30)
			mMovie:__wf_atom_4c1c1986(p6.mClipName, "IconComponent", 12, 30)
			p6.UnfocusedAlpha = 30
			module.UpdateFocus(mMovie, p6.mClipName .. ".IconComponent", p6, newGrid)
		end)
		mMovie:__wf_atom_4c1c1986(p4.mClipName, "IconComponent", 12, 100)
		p4.UnfocusedAlpha = 100
	end

	return newGrid
end