module(..., package.seeall)

function CreateList(mMovie, mClipName2, mVisibleElements)
	mMovie:__wf_atom_e57658c2(mClipName2, 12, 0)
	return {
		mMovie = mMovie,
		mElements = {},
		mClips = {},
		mEnabled = true,
		mClipName = mClipName2,
		mCurrentElementIndex = nil,
		mElementDrawCallback = nil,
		mOnFocusedCallback = nil,
		mOnUnfocusedCallback = nil,
		mOnSelectedCallback = nil,
		mOnRemovedCallback = nil,
		mOnPressedCallback = nil,
		mForcedVerticalSeparation = nil,
		mForcedHorizontalSeparation = nil,
		mPressElementCallback = nil,
		mSelectElementCallback = nil,
		mRollOverElementCallback = nil,
		mRollOutElementCallback = nil,
		mClipCreatedCallback = nil,
		mOnDraggedCallback = nil,
		mOnDragFocusedCallback = nil,
		mOnDragUnfocusedCallback = nil,
		UTIL = require("EE.Interface.Utilities"),
		mHasDrawn = false,
		mTopId = 0,
		mTopClipIndexUsed = 0,
		mLastPressTime = 0,
		mInitialDepth = 1000,
		mDepthDirection = -1,
		mElementTransitionTime = 0.2,
		mElementDelayTime = 0,
		mWrapAroundNavigation = true,
		mInitialX = mMovie:__wf_atom_5e6e15c8(mClipName2, 0),
		mInitialY = mMovie:__wf_atom_5e6e15c8(mClipName2, 1),
		mVisibleElements = mVisibleElements,
		mScroll = nil,
		mScrollBarClipName = nil,
		mRedrawFromScrollBar = nil,
		mListContainer = nil,
		mSmoothScroll = false,
		mScrollAlwaysVisible = false,
		mOriginalButtonY = mMovie:__wf_atom_cfc41e35(mClipName2, "Btn", 1),
		mOriginalButtonHeight = mMovie:__wf_atom_cfc41e35(mClipName2, "Btn", 15),
		mOriginalButtonWidth = mMovie:__wf_atom_5e6e15c8(mClipName2 .. ".Btn", 14),
		mPrefix = "List(" .. mClipName2 .. ")::",
		mEasing = 2,
		mLowerBoundBuffer = 0,
		mUpperBoundBuffer = 0,
		mIgnoreFiller = false,
		mClickDrag = {},
		mScrollDrag = {},
		UP = 1,
		RIGHT = 2,
		DOWN = 3,
		LEFT = 4,
		mMovie:__wf_atom_2dedec1a(mClipName2, 67, false),
		mInterpolationProps = { 12, 1 },
		mInterpolationValues = { 100, 0 },
		mStopDragScrollingOnSelection = true,
		mAllowElementSelectionOnScrollDragEnd = false,
		Print = function(p, p2)
			print(p.mPrefix .. p2)
		end,
		GetHowManyElements = function(self)
			return #self.mElements
		end,
		GetHowManyVisibleElements = function(self)
			return (self.UTIL.Ternary(self.mVisibleElements == nil, #self.mElements, self.mVisibleElements))
		end,
		GetFocusedElement = function(p)
			if __wf_atom_7e8ad928(p.mCurrentElementIndex) then
				return nil
			end

			return p.mElements[p.mCurrentElementIndex]
		end,
		GetFocusedElementIndex = function(p)
			return p.mCurrentElementIndex
		end,
		GetElementInIndex = function(self, p)
			return self.mElements[p]
		end,
		GetElementIndexById = function(self, p)
			for i = 1, #self.mElements do
				if self.mElements[i].Id == p then
					return i
				end
			end

			return nil
		end,
		UpdateElementInIndex = function(self, p, p2, p3)
			p2.Id = self.mElements[p].Id
			self.mElements[p] = p2

			if not p3 then
				self:Redraw(nil, true)
			end
		end,
		UpdateElementById = function(self, p, p2, p3)
			self:UpdateElementInIndex(self:GetElementIndexById(p), p2, p3)
		end,
		GetElementById = function(self, p)
			return (self:GetElementInIndex(self:GetElementIndexById(p)))
		end,
		SetBaseClipName = function(self, mClipName)
			self.mClipName = mClipName
			self:SetClipCallbacks(mClipName)
		end,
		GetClipName = function(p, p2)
			return p.mElements[p2].mClipName
		end,
		GetScroll = function(p)
			return p.mScroll
		end,
		CalculateX = function(self, p)
			local mIndex = p.mIndex

			if mIndex == nil then
				mIndex = self:GetElementIndexById(p.Id)
			end

			if __wf_atom_7e8ad928(mIndex) then
				return self.mInitialX
			end

			if not __wf_atom_7e8ad928(self.mScroll) then
				mIndex = mIndex - self.mScroll + 1
			end

			local mForcedHorizontalSeparation = self.mForcedHorizontalSeparation or 0
			return (self.UTIL.Round(self.mInitialX + mForcedHorizontalSeparation * (mIndex - 1)))
		end,
		CalculateY = function(self, data)
			local mIndex = data.mIndex

			if mIndex == nil then
				mIndex = self:GetElementIndexById(data.Id)
			end

			if __wf_atom_7e8ad928(mIndex) then
				return self.mInitialY
			end

			if not __wf_atom_7e8ad928(self.mScroll) then
				mIndex = mIndex - self.mScroll + 1
			end

			local mForcedVerticalSeparation = self.mForcedVerticalSeparation
				or self.mMovie:__wf_atom_5e6e15c8(self.mClipName, 15)
			local listExtraY = data.listExtraY or 0
			return self.UTIL.Round(self.mInitialY + mForcedVerticalSeparation * (mIndex - 1)) + listExtraY
		end,
		SetCallbacks = function(self, mSelectElementCallback, mRollOverElementCallback, mRollOutElementCallback, mPressElementCallback, mDragOverElementCallback, mDragOutElementCallback, mReleaseOutsideElementCallback)
			self.mSelectElementCallback = mSelectElementCallback
			self.mRollOverElementCallback = mRollOverElementCallback
			self.mRollOutElementCallback = mRollOutElementCallback
			self.mPressElementCallback = mPressElementCallback
			self.mDragOverElementCallback = mDragOverElementCallback
			self.mDragOutElementCallback = mDragOutElementCallback
			self.mReleaseOutsideElementCallback = mReleaseOutsideElementCallback
			self:SetClipCallbacks(self.mClipName)
			self:RunForAllVisibleElements(function(p)
				self:SetClipCallbacks(p.mClipName)
			end)
		end,
		SetClipCallbacks = function(self, p)
			if
				(self.mRollOverElementCallback ~= nil or self.mRollOutElementCallback ~= nil or self.mSelectElementCallback ~= nil or self.mPressElementCallback ~= nil)
				and not self.mMovie:SetCallbacks(
					p .. ".Btn",
					self.mRollOverElementCallback,
					self.mRollOutElementCallback,
					self.mSelectElementCallback,
					self.mPressElementCallback
				)
			then
				if not __wf_atom_7e8ad928(self.mPressElementCallback) then
					self.mMovie:__wf_atom_976dcedd(p, "PressedCallback", self.mPressElementCallback)
				end

				if not __wf_atom_7e8ad928(self.mSelectElementCallback) then
					self.mMovie:__wf_atom_976dcedd(p, "SelectCallback", self.mSelectElementCallback)
				end

				if not __wf_atom_7e8ad928(self.mRollOverElementCallback) then
					self.mMovie:__wf_atom_976dcedd(p, "RollOverCallback", self.mRollOverElementCallback)
				end

				if not __wf_atom_7e8ad928(self.mRollOutElementCallback) then
					self.mMovie:__wf_atom_976dcedd(p, "RollOutCallback", self.mRollOutElementCallback)
				end
			end

			if
				self.mReleaseOutsideElementCallback ~= nil
				and not self.mMovie:SetReleaseOutsideCallback(p .. ".Btn", self.mReleaseOutsideElementCallback)
			then
				self.mMovie:__wf_atom_976dcedd(p, "ReleaseOutsideCallback", self.mReleaseOutsideElementCallback)
			end

			if
				(self.mDragOverElementCallback ~= nil or self.mDragOutElementCallback ~= nil)
				and not self.mMovie:SetDragCallbacks(
					p .. ".Btn",
					self.mDragOverElementCallback,
					self.mDragOutElementCallback
				)
			then
				if not __wf_atom_7e8ad928(self.mDragOverElementCallback) then
					self.mMovie:__wf_atom_976dcedd(p, "DragOverCallback", self.mDragOverElementCallback)
				end

				if not __wf_atom_7e8ad928(self.mDragOutElementCallback) then
					self.mMovie:__wf_atom_976dcedd(p, "DragOutCallback", self.mDragOutElementCallback)
				end
			end
		end,
		InsertElement = function(self, p, state, p2, p3)
			local mIndex = p == nil and 0 or p
			local howManyElements = self:GetHowManyElements()

			if howManyElements > 0 then
				while mIndex < 0 do
					mIndex = howManyElements + mIndex
				end

				while howManyElements + 1 < mIndex do
					mIndex -= howManyElements
				end
			end

			local flag = false

			if mIndex == 0 or howManyElements == 0 then
				mIndex = howManyElements + 1
			elseif mIndex <= howManyElements then
				flag = true
			end

			if __wf_atom_7e8ad928(state.Id) then
				state.Id = self.mTopId + 1
			end

			self.mTopId = math.max(state.Id, self.mTopId)
			state.mInitialized = false
			state.mClipName = nil
			state.mClipEnabled = false
			state.mIndex = mIndex
			table.insert(self.mElements, mIndex, state)

			if flag then
				local howManyElements2 = self:GetHowManyElements()
				__wf_atom_83c14687(0)

				for i = 1, howManyElements2 do
					self.mElements[i].mIndex = i
				end
			end

			if state.mOverrideClipName ~= nil then
				self:SetClipCallbacks(state.mOverrideClipName)
			end

			if not p2 then
				self:Redraw(nil, flag, p3)
			end

			return state
		end,
		AddElement = function(self, p, p2, p3)
			return (self:InsertElement(self:GetHowManyElements() + 1, p, p2, p3))
		end,
		RemoveElement = function(self, p, p2, flag, p3, p4, p5)
			if flag == nil then
				flag = false
			end

			if not __wf_atom_7e8ad928(self.mElements[p]) then
				__wf_atom_83c14687(0)
				local howManyElements = self:GetHowManyElements()
				local mClipName = self.mElements[p].mClipName
				local v = self.mElements[p].mOverrideClipName ~= nil
				local howManyVisibleElements = self:GetHowManyVisibleElements()

				if not __wf_atom_7e8ad928(mClipName) then
					local function fn()
						if
							not p4
							and (self.mVisibleElements == nil or howManyElements <= howManyVisibleElements or p3)
						then
							if v or mClipName == self.mClipName then
								self.mMovie:__wf_atom_e57658c2(mClipName, 12, 0)
								self.mMovie:__wf_atom_2dedec1a(mClipName, 67, false)
							else
								__wf_atom_86cbd68d(self.mMovie, mClipName .. ".removeMovieClip")
							end
						end

						if not p2 then
							self:Redraw(nil, true, flag)
						end
					end

					if flag then
						self.mMovie:__wf_atom_290807ee(mClipName)
						fn()
					else
						__wf_atom_ec43d06e(
							self.mMovie,
							mClipName,
							self.mEasing,
							{ 12, 1 },
							{ 0, self:CalculateY(self.mElements[p]) - 40 },
							self.mElementTransitionTime,
							0,
							fn
						)
					end

					if self.mVisibleElements == nil or howManyElements <= howManyVisibleElements or p3 then
						if not __wf_atom_7e8ad928(self.mOnRemovedCallback) then
							self:mOnRemovedCallback(self.mElements[p])
						end

						if not p4 then
							self.mClips[mClipName] = nil
						end
					else
						self.mClips[mClipName] = false
						self.mMovie:__wf_atom_e57658c2(mClipName, 12, 0)

						if mClipName ~= self.mClipName then
							self.mMovie:__wf_atom_2dedec1a(mClipName, 67, false)
						end
					end

					__wf_atom_83c14687(0)
				end

				if
					not __wf_atom_7e8ad928(self.mSelectedElement)
					and self.mElements[p].Id == self.mSelectedElement.Id
				then
					self.mSelectedElement = nil
				end

				local id = self.mElements[p].Id
				table.remove(self.mElements, p)

				if not __wf_atom_7e8ad928(id) and id == self.mTopId then
					local howManyElements2 = self:GetHowManyElements()
					__wf_atom_83c14687(0)
					local id2 = 0

					for i = 1, howManyElements2 do
						if id2 < self.mElements[i].Id then
							id2 = self.mElements[i].Id
						end
					end

					self.mTopId = id2
				end

				if not p5 then
					for i = 1, self:GetHowManyElements() do
						self.mElements[i].mIndex = i
					end
				end
			end
		end,
		RemoveElementById = function(self, p, p2, p3)
			self:RemoveElement(self:GetElementIndexById(p), p2, p3)
		end,
		RemoveElements = function(self, p, p2)
			if not __wf_atom_7e8ad928(self.mCurrentElementIndex) then
				self:UnfocusElement(self.mCurrentElementIndex)
			end

			local count = #self.mElements
			self.mTopId = 0

			for i = 0, count - 1 do
				self:RemoveElement(count - i, p, p2, true, self.mPreserveClips, true)
			end

			if not __wf_atom_7e8ad928(self.mScroll) then
				self:SetScroll(1, true)
			end

			self.mTopClipIndexUsed = 0

			if not self.mPreserveClips then
				for k, _ in pairs(self.mClips) do
					if k == self.mClipName then
						self.mMovie:__wf_atom_e57658c2(k, 12, 0)
					else
						__wf_atom_86cbd68d(self.mMovie, k .. ".removeMovieClip")
					end

					self.mClips[k] = nil
				end
			end

			self.mSelectedElement = nil
			self.mMovie:__wf_atom_2dedec1a(self.mClipName, 67, false)
		end,
		Remove = function(self)
			self:RemoveElements()
		end,
		OnUnfocused = function(self, p)
			if not __wf_atom_7e8ad928(self.mOnUnfocusedCallback) then
				self.mOnUnfocusedCallback(p)
			end
		end,
		UnfocusElement = function(self, p)
			if
				self.mCurrentElementIndex == p
				and not __wf_atom_7e8ad928(self.mElements[p])
				and self.mElements[p].mInitialized
			then
				self:OnUnfocused(self.mElements[p])
				self.mCurrentElementIndex = nil
			end
		end,
		UnfocusElementById = function(self, p)
			local elementIndexById = self:GetElementIndexById(p)

			if not __wf_atom_7e8ad928(elementIndexById) then
				self:UnfocusElement(elementIndexById)
			end
		end,
		OnFocused = function(self, p)
			if not __wf_atom_7e8ad928(self.mOnFocusedCallback) then
				self.mOnFocusedCallback(p)
			end
		end,
		FocusElement = function(self, mCurrentElementIndex, p)
			if
				self.mCurrentElementIndex == mCurrentElementIndex
				or __wf_atom_7e8ad928(self.mElements[mCurrentElementIndex])
				or not self.mElements[mCurrentElementIndex].mInitialized
			then
				return
			end

			if not __wf_atom_7e8ad928(self.mCurrentElementIndex) then
				self:UnfocusElement(self.mCurrentElementIndex)
			end

			if not (__wf_atom_7e8ad928(self.mScroll) or p) then
				local v = nil
				local v2 = self.mScroll + self:GetHowManyVisibleElements() - 1

				if mCurrentElementIndex < self.mScroll then
					v = mCurrentElementIndex
				elseif v2 < mCurrentElementIndex then
					v = mCurrentElementIndex - self:GetHowManyVisibleElements() + 1
				end

				if not __wf_atom_7e8ad928(v) then
					self:SetScroll(v, true)
					self:Redraw(nil, false, true)
					self:RunForAllVisibleElements(function(p2)
						self:RepositionButton(p2)
					end)
				end
			end

			self.mCurrentElementIndex = mCurrentElementIndex
			self:OnFocused(self.mElements[mCurrentElementIndex])
		end,
		FocusElementById = function(self, p, p2)
			local elementIndexById = self:GetElementIndexById(p)

			if not __wf_atom_7e8ad928(elementIndexById) then
				self:FocusElement(elementIndexById, p2)
			end
		end,
		GetIndexInDirection = function(self, p, p2)
			local mCurrentElementIndex = __wf_atom_7e8ad928(self.mScroll) and 0 or self.mScroll - p

			if not __wf_atom_7e8ad928(self.mCurrentElementIndex) then
				mCurrentElementIndex = self.mCurrentElementIndex
			end

			if p2 and not __wf_atom_7e8ad928(self.mSelectedElement) then
				mCurrentElementIndex = self.mSelectedElement.mIndex
			end

			if self.mScrollBar ~= nil then
				if
					p == self.DOWN
					and mCurrentElementIndex == self.mScroll + self:GetHowManyVisibleElements() - 1
					and self.mScrollBar:GetScrollValue() < 1
				then
					self.mScrollBar:ScrollDown()
				elseif
					p == self.UP
					and mCurrentElementIndex == self.mScroll
					and self.mScrollBar:GetScrollValue() > 0
				then
					self.mScrollBar:ScrollUp()
				end
			end

			if self.mWrapAroundNavigation then
				return (self.UTIL.ToggleValue(mCurrentElementIndex, p, 1, self:GetHowManyElements()))
			end

			return (__wf_atom_421b01aa(mCurrentElementIndex + p, 1, self:GetHowManyElements()))
		end,
		ToggleFocusedElement = function(self, p)
			local indexInDirection = self:GetIndexInDirection(p)
			local elementById = self:GetElementById(indexInDirection)

			if __wf_atom_7e8ad928(elementById) or not (self.mIgnoreFiller and elementById.Filler) then
				self:FocusElement(indexInDirection)
			end
		end,
		FocusNextElement = function(self)
			self:ToggleFocusedElement(self.UTIL.INCREMENT)
		end,
		FocusPreviousElement = function(self)
			self:ToggleFocusedElement(self.UTIL.DECREMENT)
		end,
		PressedElement = function(self, dragIndex)
			if not __wf_atom_7e8ad928(self.mElements[dragIndex]) and self.mElements[dragIndex].mInitialized then
				local mElement = self.mElements[dragIndex]

				if __wf_atom_7e8ad928(self.mOnPressedCallback) then
					if self.mClickDrag.Enabled then
						self.mClickDrag.DragId = mElement.Id
						self.mClickDrag.DragIndex = dragIndex
						self.mClickDrag.InitDownPos = Vector(
							self.mMovie:__wf_atom_5e6e15c8("_root", 30),
							self.mMovie:__wf_atom_5e6e15c8("_root", 31),
							0
						)
					end
				else
					self.mOnPressedCallback(mElement)
				end

				self:StartScrollDrag(dragIndex)
			end
		end,
		PressedElementById = function(self, p)
			self:PressedElement(self:GetElementIndexById(p))
		end,
		PressCurrentElement = function(self)
			if not __wf_atom_7e8ad928(self.mCurrentElementIndex) then
				self:PressedElement(self.mCurrentElementIndex)
			end
		end,
		OnSelected = function(self, mSelectedElement, p)
			if
				self.mScrollDrag.Enabled
				and (self.mScrollDrag.isPressed or self.mScrollDrag.isDragging or self.mScrollDrag.isStopping)
			then
				local isDragging = self.mScrollDrag.isDragging or self.mScrollDrag.isStopping

				if self.mStopDragScrollingOnSelection then
					self:StopScrollDrag()
				end

				if isDragging and not self.mAllowElementSelectionOnScrollDragEnd then
					return
				end
			elseif self.mClickDrag.Enabled and self.mClickDrag.DragId ~= nil then
				self.mClickDrag.DragId = nil
				local v

				if self.mClickDrag.Dragging then
					self.UTIL.PlaySound(_G.UISound_EndDrag)

					if
						self.mClickDrag.FocusedIndex ~= nil
						and self.mClickDrag.FocusedIndex ~= self.mClickDrag.DragIndex
						and not __wf_atom_7e8ad928(self.mOnDraggedCallback)
					then
						self.mOnDraggedCallback()
					end

					v = false
				else
					v = true
				end

				self:StopDragging()

				if not v then
					return
				end
			end

			if mSelectedElement.mClipName == nil then
				self:SetScroll(mSelectedElement.mIndex)
			end

			local mSelectedElement2 = self.mSelectedElement
			local v

			if mSelectedElement2 == mSelectedElement then
				v = not __wf_atom_7e8ad928(self.mOnDoubleClickCallback)
					and (Engine.IsPlayingWithController() or Time() - self.mLastPressTime < 0.5)
			else
				v = false
			end

			self.mLastPressTime = Time()
			self.mSelectedElement = mSelectedElement

			if v then
				self.mOnDoubleClickCallback(mSelectedElement, p, mSelectedElement2)
			elseif not __wf_atom_7e8ad928(self.mOnSelectedCallback) then
				self.mOnSelectedCallback(mSelectedElement, p, mSelectedElement2)
			end
		end,
		SelectElement = function(self, p, p2)
			if not __wf_atom_7e8ad928(self.mElements[p]) and self.mElements[p].mInitialized then
				self:OnSelected(self.mElements[p], p2)
			end
		end,
		SelectElementById = function(self, p, p2)
			local elementIndexById = self:GetElementIndexById(p)

			if not __wf_atom_7e8ad928(elementIndexById) then
				self:SelectElement(elementIndexById, p2)
			end
		end,
		SelectCurrentElement = function(self, p)
			if not __wf_atom_7e8ad928(self.mCurrentElementIndex) then
				self:SelectElement(self.mCurrentElementIndex, p)
			end
		end,
		SelectElementInDirection = function(self, p, p2)
			local indexInDirection = self:GetIndexInDirection(p, true)
			local elementById = self:GetElementById(indexInDirection)

			if __wf_atom_7e8ad928(elementById) or not (self.mIgnoreFiller and elementById.Filler) then
				self:SelectElement(indexInDirection, p2)
			end
		end,
		RepositionButton = function(self, p)
			if self.mScroll ~= nil and self.mOriginalButtonHeight ~= nil then
				local mOriginalButtonY = self.mOriginalButtonY
				local v = self.mScroll + self:GetHowManyVisibleElements() - 1
				local mOriginalButtonHeight

				if v < p.mIndex then
					mOriginalButtonHeight = (1 - (p.mIndex - v)) * self.mForcedVerticalSeparation
					mOriginalButtonY += (-self.mForcedVerticalSeparation + mOriginalButtonHeight) / 2
				elseif p.mIndex < self.mScroll then
					mOriginalButtonHeight = (1 - (self.mScroll - p.mIndex)) * self.mForcedVerticalSeparation
					mOriginalButtonY += (self.mForcedVerticalSeparation - mOriginalButtonHeight) / 2
				else
					mOriginalButtonHeight = self.mOriginalButtonHeight
				end

				if mOriginalButtonHeight ~= nil then
					self.mMovie:__wf_atom_4c1c1986(p.mClipName, "Btn", 15, (math.max(mOriginalButtonHeight, 0.01)))
					self.mMovie:__wf_atom_4c1c1986(p.mClipName, "Btn", 1, mOriginalButtonY)
				end
			end
		end,
		OnDraw = function(self, p, p2)
			if self.mSmoothScroll then
				self:RepositionButton(p)
			end

			if p2 == nil then
				print("ERROR: pNeedsElementDrawCallback is nil!")
				__wf_atom_6bd2126c()
				p2 = true
			end

			if not __wf_atom_7e8ad928(self.mElementDrawCallback) and p2 then
				self.mElementDrawCallback(p)
			end
		end,
		OnElementTransitionStarted = function(self, _) end,
		OnElementTransitionEnded = function(self, _) end,
		SetupPreInterpolationValues = function(self, p)
			local y = self:CalculateY(p)
			self.mMovie:__wf_atom_e57658c2(p.mClipName, 1, y - 20)
			self.mMovie:__wf_atom_e57658c2(p.mClipName, 12, 0.001)
		end,
		GetInterpolationProperties = function(self, p)
			self.mInterpolationValues[2] = self:CalculateY(p)
			return self.mInterpolationProps, self.mInterpolationValues
		end,
		_DefaultAlphaInterpolationVars = { 12 },
		_DefaultAlphaInterpolationValues = { 100 },
		DefaultAlphaInterpolation = function(self, _)
			return self._DefaultAlphaInterpolationVars, self._DefaultAlphaInterpolationValues
		end,
		GetBounds = function(self)
			local howManyElements = self:GetHowManyElements()
			local howManyVisibleElements = self:GetHowManyVisibleElements()
			local mScroll = self.mScroll

			if mScroll == nil then
				mScroll = 1
				return mScroll, howManyElements
			end

			if self.mSmoothScroll then
				local v = math.max(1, math.floor(mScroll) - self.mLowerBoundBuffer)
				return v, math.floor(v + howManyVisibleElements) + self.mLowerBoundBuffer + self.mUpperBoundBuffer
			end

			howManyElements = mScroll + howManyVisibleElements - 1
			return mScroll, howManyElements
		end,
		OnClipCreated = function(self, p, p2)
			if self.mClipCreatedCallback ~= nil then
				self.mClipCreatedCallback(p, p2)
			end
		end,
		OnFirstRedraw = function(self)
			self:OnClipCreated(self.mClipName, self.mElements[1])
		end,
		Redraw = function(self, callback, p, p2)
			if __wf_atom_7e8ad928(self.mMovie) or self.mDisableRedraw then
				return
			end

			if not self.mHasDrawn or p and self.mElements[1] ~= nil and not self.mElements[1].mInitialized then
				self:OnFirstRedraw()
				self.mHasDrawn = true
			end

			local howManyElements = self:GetHowManyElements()
			local v = true
			local mElementTransitionTime = self.mElementTransitionTime
			local total

			if p2 then
				total = 0
				mElementTransitionTime = 0
			else
				total = 0
			end

			if howManyElements == 0 and not __wf_atom_7e8ad928(callback) then
				callback()
			end

			local bounds, v2 = self:GetBounds()
			local mScroll = self.mScroll

			for i = 1, howManyElements do
				__wf_atom_83c14687(0)
				local mElement = self.mElements[i]
				local mClipName = nil
				local v3

				if bounds <= i then
					v3 = i <= v2
				else
					v3 = false
				end

				if v3 then
					if mElement.mClipName and self.mClips[mElement.mClipName] == true then
						mClipName = mElement.mClipName
					elseif mElement.mOverrideClipName == nil then
						for k, mClip in pairs(self.mClips) do
							if mClip then
								continue
							end

							mClipName = k
							break
						end

						if __wf_atom_7e8ad928(mClipName) then
							self.mTopClipIndexUsed += 1

							if self.mTopClipIndexUsed == 1 then
								mClipName = self.mClipName
							else
								mClipName = self.mClipName .. tostring(self.mTopClipIndexUsed)
							end
						end

						self.mClips[mClipName] = true
					else
						mClipName = mElement.mOverrideClipName
					end

					if self.mHideExtraClips then
						self.mMovie:__wf_atom_2dedec1a(mClipName, 13, true)
					end

					self.mMovie:__wf_atom_7f57ab2f(mClipName, "Status", 13, false)
					self.mMovie:__wf_atom_7f57ab2f(mClipName, "Glow", 13, false)
				elseif mElement.mClipName and self.mClips[mElement.mClipName] == true and self.mHideExtraClips then
					self.mMovie:__wf_atom_2dedec1a(mElement.mClipName, 13, false)
				end

				if
					mElement.mForceRedraw
					or mElement.mClipName ~= mClipName
					or p
					or mElement.mOverrideClipName ~= nil
				then
					local v4 = mElement.mClipName ~= mClipName or (mElement.mForceRedraw or p or mScroll == nil)

					if mElement.mClipName and mClipName ~= mElement.mClipName then
						self.mClips[mElement.mClipName] = false

						if mClipName == nil then
							self.mMovie:__wf_atom_290807ee(mElement.mClipName)
							self.mMovie:__wf_atom_e57658c2(mElement.mClipName, 12, 0)
							self.mMovie:__wf_atom_2dedec1a(mElement.mClipName, 67, false)
							mElement.mClipEnabled = false
						end
					end

					mElement.mClipName = mClipName
					mElement.mForceRedraw = false

					if not __wf_atom_7e8ad928(mClipName) then
						if not self.mMovie:__wf_atom_253d7085(mClipName) then
							local v5 = StringSplit(".", mClipName)
							__wf_atom_86cbd68d(
								self.mMovie,
								self.mClipName .. ".duplicateMovieClip",
								v5[#v5],
								self.mInitialDepth + self.mTopClipIndexUsed * self.mDepthDirection
							)
							self:OnClipCreated(mClipName, mElement)

							if not p then
								self:SetClipCallbacks(mClipName)
							end
						end

						if p then
							self:SetClipCallbacks(mClipName)
						end

						if not mElement.mClipEnabled then
							self.mMovie:__wf_atom_2dedec1a(mElement.mClipName, 67, true)
							mElement.mClipEnabled = true
						end

						self.mMovie:__wf_atom_976dcedd(mClipName, "Id", mElement.Id)
						self.mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 100, mElement.Id)
						self.mMovie:__wf_atom_e57658c2(mClipName, 0, self:CalculateX(mElement))
						self.mMovie:__wf_atom_e57658c2(mClipName, 1, self:CalculateY(mElement))

						if not mElement.mInitialized then
							self:SetupPreInterpolationValues(mElement)
						end

						total += self.mElementDelayTime
						local ternary = self.UTIL.Ternary(v, callback, nil)
						local interpolationProperties, v5 = self:GetInterpolationProperties(mElement)
						self:OnElementTransitionStarted(mElement)

						if _T.DebugButtons then
							self.mMovie:__wf_atom_e57658c2(mClipName, 12, 50)
							self.mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 12, 100 + mElement.mIndex % 2 * 30)
							interpolationProperties = {}
							v5 = {}
						end

						if p2 then
							for j = 1, #interpolationProperties do
								self.mMovie:__wf_atom_e57658c2(mClipName, interpolationProperties[j], v5[j])
							end

							self:OnElementTransitionEnded(mElement)

							if not __wf_atom_7e8ad928(ternary) then
								ternary()
							end
						else
							__wf_atom_ec43d06e(
								self.mMovie,
								mClipName,
								self.mEasing,
								interpolationProperties,
								v5,
								mElementTransitionTime,
								total,
								function()
									self:OnElementTransitionEnded(mElement)

									if not __wf_atom_7e8ad928(ternary) then
										ternary()
									end
								end
							)
						end

						self:OnDraw(mElement, v4)
						v = false
					end
				elseif mClipName ~= nil then
					self.mMovie:__wf_atom_e57658c2(mClipName, 0, self:CalculateX(mElement))
					self.mMovie:__wf_atom_e57658c2(mClipName, 1, self:CalculateY(mElement))
				end

				mElement.mInitialized = true
			end

			if self.mRedrawFromScrollBar then
				self.mRedrawFromScrollBar = false
			else
				self:RedrawScrollBar(p2)
			end
		end,
		SetScroll = function(self, p, p2)
			local mScroll = __wf_atom_421b01aa(p, 1, (math.max(#self.mElements, 1)))

			if self.mScroll ~= mScroll then
				self.mScroll = mScroll

				if not p2 then
					self:Redraw(nil, true)
				end
			end
		end,
		RunForAllElements = function(self, callback)
			if not __wf_atom_7e8ad928(callback) then
				for i = 1, #self.mElements do
					__wf_atom_83c14687(0)
					callback(self.mElements[i])
				end
			end
		end,
		_RunForAllVisibleElements = function(self, callback, p)
			local bounds = 1
			local v

			if p then
				local v2
				bounds, v2 = self:GetBounds()
				v = math.min(v2, #self.mElements)
			else
				v = #self.mElements
			end

			for i = bounds, v do
				local mElement = self.mElements[i]

				if mElement.mClipName == nil then
					continue
				end

				__wf_atom_83c14687(0)
				callback(mElement)
			end
		end,
		RunForAllVisibleElements = function(self, p, p2)
			if __wf_atom_7e8ad928(self.mScroll) then
				self:RunForAllElements(p)
			elseif not __wf_atom_7e8ad928(p) then
				self:_RunForAllVisibleElements(p, p2)
			end
		end,
		CalculateScrollBarHeight = function(self, value)
			if self.Height == nil then
				return self.mVisibleElements * self.mForcedVerticalSeparation + (value or 0)
			end

			return self.Height
		end,
		ScrollValueChangedCallback = function(self, p, _)
			local v = self:GetHowManyElements() - self.mVisibleElements

			if self.mSmoothScroll then
				local v2 = __wf_atom_421b01aa(v * p, 0, v) + 1

				if v2 ~= self.mScroll then
					local v3 = math.floor(v2) - math.floor(self.mScroll)
					self:SetScroll(v2, true)

					if v3 >= 1 or v3 <= -1 then
						self.mRedrawFromScrollBar = true
						self:Redraw(nil, false, true)
					end

					self:RunForAllVisibleElements(function(p2)
						self.mMovie:__wf_atom_e57658c2(p2.mClipName, 1, self:CalculateY(p2))
						self:RepositionButton(p2)
					end)
				end
			else
				local v2 = __wf_atom_421b01aa(self.UTIL.Round(v * p), 0, v) + 1

				if v2 ~= self.mScroll then
					self:SetScroll(v2, true)
					self.mRedrawFromScrollBar = true
					self:Redraw(nil, false, true)
					self:RunForAllVisibleElements(function(p2)
						self.mMovie:__wf_atom_e57658c2(p2.mClipName, 1, self:CalculateY(p2))
						self:RepositionButton(p2)
					end)
				end
			end
		end,
		CanUseScrollBar = function(self)
			return true
		end,
		AttachScrollBar = function(self, mScrollBarClipName, value, p)
			self.mScrollBarClipName = mScrollBarClipName

			if self.mScrollBarClipName ~= nil then
				self:SetScroll(1, true)
				self.mDeltaScrollBarSize = value or 0
				local module = require("EE.Interface.Components.ScrollBar")
				self.mScrollBar = module.CreateScrollBar(
					self.mMovie,
					self.mScrollBarClipName,
					self:CalculateScrollBarHeight(self.mDeltaScrollBarSize),
					0.5,
					p
				)
				self.mMovie:__wf_atom_2dedec1a(self.mScrollBarClipName, 13, false)

				function self.mScrollBar.mScrollValueChangedCallback(p2, p3)
					self:ScrollValueChangedCallback(p2, p3)
				end

				self.mScrollBar:HookUpCallbacks()
				self.mScrollBar:Initialize()
				self:EnableDragScrolling(p)
			end
		end,
		RedrawScrollBar = function(self)
			if self.mScrollBarClipName ~= nil and self.mScrollBar ~= nil and not self.mScrollBar.mDragging then
				local howManyElements = self:GetHowManyElements()
				local v

				if self:GetHowManyVisibleElements() < howManyElements then
					v = self:CanUseScrollBar()
				else
					v = false
				end

				self.mMovie:__wf_atom_2dedec1a(self.mScrollBarClipName, 13, self.mScrollAlwaysVisible or v)
				self.mMovie:__wf_atom_7f57ab2f(self.mScrollBarClipName, "Scrub", 13, v)
				self.mScrollBar:SetEnabled(v)

				if v then
					local v2 = self:GetHowManyElements() - self.mVisibleElements
					self.mScrollBar.mVisibleProp = self.mVisibleElements / howManyElements
					self.mScrollBar.mCurrentScroll = (self.mScroll - 1) / v2
					self.mScrollBar:SetHeight(self:CalculateScrollBarHeight(self.mDeltaScrollBarSize), true)
					self.mScrollBar.mScrollStep = 1 / (howManyElements - self.mVisibleElements)
				end
			end
		end,
		AttachListContainer = function(self, p, p2, p3, p4, p5, p6, p7)
			if p ~= nil and p2 ~= nil then
				local module = require("EE.Interface.Components.ListContainer")
				self.mListContainer = module.CreateListContainer(self.mMovie, p, p2, p3, p4, p5, p6, p7)
				self.mMovie:__wf_atom_2dedec1a(p .. "." .. p2, 13, true)
				self.mListContainer:HookUpCallbacks()
				self.mListContainer:Initialize()

				function self.mListContainer.mStartDragCallback()
					self:StartScrollDrag(nil)
				end

				function self.mListContainer.mStopDragCallback()
					self:StopScrollDrag()
				end
			end
		end,
		EnableSmoothScroll = function(self)
			if self.mScroll == nil or self.mForcedVerticalSeparation == nil then
				print("Error: Smooth scroll dependencies failed!")
				assert(false)
			else
				self.mSmoothScroll = true
				self.mScrollBar.mEnableSmoothScroll = true
			end
		end,
		StopDragging = function(self)
			self.mClickDrag.DragId = nil
			self.mMovie:__wf_atom_2dedec1a(self.mClickDrag.DragClipName, 13, false)
			self.mClickDrag.Dragging = false
			self.mClickDrag.FocusedIndex = nil
			self.mClickDrag.DragIndex = nil

			if not __wf_atom_7e8ad928(self.mOnDragEndCallback) then
				self:mOnDragEndCallback()
			end
		end,
		EnableDrag = function(self)
			self.mClickDrag = { Enabled = true, Dragging = false, DistThresh = 20 }

			if Engine.__wf_atom_b6edc589() then
				self.mClickDrag.DistThresh = 5
			end

			local v = StringSplit(".", self.mClipName)
			self.mClickDrag.RootClip = ""

			if #v > 1 then
				local v2 = #v - 1

				for i = 1, v2 do
					self.mClickDrag.RootClip = self.mClickDrag.RootClip .. v[i]

					if i ~= v2 then
						self.mClickDrag.RootClip = self.mClickDrag.RootClip .. "."
					end
				end
			end

			self.mClickDrag.DragClipName = self.mClipName .. "Drag"
		end,
		CreateDragClip = function(self)
			if not self.mMovie:__wf_atom_253d7085(self.mClickDrag.DragClipName) then
				local v = StringSplit(".", self.mClipName)
				self.mTopClipIndexUsed += 1
				__wf_atom_86cbd68d(
					self.mMovie,
					self.mClipName .. ".duplicateMovieClip",
					v[#v] .. "Drag",
					self.mInitialDepth + self.mTopClipIndexUsed * self.mDepthDirection
				)
			end

			local elementById = self:GetElementById(self.mClickDrag.DragId)
			local mClipName = elementById.mClipName
			elementById.mClipName = self.mClickDrag.DragClipName

			if not __wf_atom_7e8ad928(self.mElementDrawCallback) then
				self.mElementDrawCallback(elementById)
			end

			elementById.mClipName = mClipName
			self.mMovie:__wf_atom_2dedec1a(self.mClickDrag.DragClipName, 13, true)
			self.mMovie:__wf_atom_e57658c2(self.mClickDrag.DragClipName, 12, 60)
			self.mMovie:__wf_atom_2dedec1a(self.mClickDrag.DragClipName .. "Btn", 67, false)
			self.mClickDrag.Dragging = true
			self.UTIL.PlaySound(_G.UISound_StartDrag)
		end,
		EnableDragScrolling = function(self, isHorizontal)
			if not Engine.__wf_atom_b6edc589() then
				return
			end

			self.mScrollDrag = {
				Enabled = true,
				isPressed = false,
				isDragging = false,
				isStopping = false,
				ignoreDrag = false,
				isHorizontal = isHorizontal,
				DistThresh = 20,
				Sensitivity = 1
			}

			if Engine.__wf_atom_b6edc589() then
				self.mScrollDrag.DistThresh = 5
			end

			function self:GetDragScrollIncrement()
				return 1
			end

			function self:GetMouseDragScrollStep()
				if __wf_atom_7e8ad928(self.mForcedVerticalSeparation) then
					return (self.mMovie:__wf_atom_5e6e15c8(self.mClipName, 15))
				end

				return self.mForcedVerticalSeparation
			end
		end,
		Update = function(self, _, p)
			local v = false

			if self.mScrollDrag.Enabled then
				return (self:UpdateScrollDrag(p))
			end

			if not self.mClickDrag.Enabled or self.mClickDrag.DragId == nil then
				return v
			end

			local v2 = Vector(
				self.mMovie:__wf_atom_5e6e15c8("_root", 30),
				self.mMovie:__wf_atom_5e6e15c8("_root", 31),
				0
			)

			if
				not self.mClickDrag.Dragging
				and Distance(v2, self.mClickDrag.InitDownPos) > self.mClickDrag.DistThresh
			then
				local elementById = self:GetElementById(self.mClickDrag.DragId)

				if elementById.DisableDrag == nil or not elementById.DisableDrag then
					self:CreateDragClip()
				else
					self.mClickDrag.DragId = nil
					self.mClickDrag.DragIndex = nil
				end

				self:UnfocusElementById(elementById.Id)
			end

			if not self.mClickDrag.Dragging then
				return v
			end

			local x = v2.x
			local y = v2.y

			if self.mClickDrag.RootClip ~= "" then
				local rootBasedPosition, v3 = self.UTIL.GetRootBasedPosition(self.mMovie, self.mClickDrag.RootClip)
				x -= rootBasedPosition
				y -= v3
			end

			self.mMovie:__wf_atom_e57658c2(self.mClickDrag.DragClipName, 0, x)
			self.mMovie:__wf_atom_e57658c2(self.mClickDrag.DragClipName, 1, y)
			local v3 = Vector(x, y, 0)
			local mIndex = nil
			local v4 = 0
			self:RunForAllVisibleElements(function(p2)
				local v5, v6

				if self.mGetElementCenter == nil then
					v5 = self.mMovie:__wf_atom_5e6e15c8(p2.mClipName, 0)
					v6 = self.mMovie:__wf_atom_5e6e15c8(p2.mClipName, 1)
				else
					v5, v6 = self.mGetElementCenter(p2)
				end

				local v7 = Distance(Vector(v5, v6, 0), v3)

				if mIndex == nil or v7 < v4 then
					mIndex = p2.mIndex
					v4 = v7
				end
			end)

			if self.mClickDrag.FocusedIndex == nil or mIndex ~= self.mClickDrag.FocusedIndex then
				if self.mClickDrag.FocusedIndex ~= nil and self.mOnDragUnfocusedCallback ~= nil then
					local elementInIndex = self:GetElementInIndex(self.mClickDrag.FocusedIndex)
					self.mOnDragUnfocusedCallback(elementInIndex)
				end

				if mIndex == self.mClickDrag.DragIndex then
					self.mClickDrag.FocusedIndex = nil
				else
					self.mClickDrag.FocusedIndex = mIndex

					if self.mOnDragFocusedCallback ~= nil then
						local elementInIndex = self:GetElementInIndex(self.mClickDrag.FocusedIndex)
						self.mOnDragFocusedCallback(elementInIndex)
					end
				end
			end

			return v
		end,
		StartScrollDrag = function(self, p)
			if self.mScrollDrag.Enabled then
				local elementIndexById = self:GetElementIndexById(p)
				local v = nil

				if not __wf_atom_7e8ad928(elementIndexById) then
					local mElement = self.mElements[elementIndexById]

					if mElement ~= nil then
						v = self.mMovie:__wf_atom_387f260e(mElement.mClipName, 23)
					end
				end

				if v ~= nil and self.mMovie:__wf_atom_4ad8cd1c() ~= v then
					self.mScrollDrag.ignoreDrag = true
				end

				self.mScrollDrag.isPressed = true
				self.mScrollDrag.isStopping = false
				self.mScrollDrag.InitDownPos = Vector(
					self.mMovie:__wf_atom_5e6e15c8("_root", 30),
					self.mMovie:__wf_atom_5e6e15c8("_root", 31),
					0
				)
			end
		end,
		StopScrollDrag = function(self)
			self.mScrollDrag.isPressed = false

			if self.mScrollDrag.Enabled and self.mScrollDrag.isDragging then
				self.mScrollDrag.isDragging = false
				self.mScrollDrag.isStopping = true
				self.mScrollDrag.ignoreDrag = false
			end
		end,
		UpdateScrollDrag = function(self, p)
			if self.mScrollDrag.Enabled and self.mScrollDrag.isPressed then
				local v = Vector(
					self.mMovie:__wf_atom_5e6e15c8("_root", 30),
					self.mMovie:__wf_atom_5e6e15c8("_root", 31),
					0
				)

				if self.mScrollDrag.isDragging and not self.mScrollDrag.ignoreDrag then
					local ternary = self.UTIL.Ternary(not __wf_atom_7e8ad928(self.mScrollBar), self.mScrollBar, p)

					if ternary then
						local v2 = Vector(
							self.mMovie:__wf_atom_5e6e15c8("_root", 30),
							self.mMovie:__wf_atom_5e6e15c8("_root", 31),
							0
						)
						local y = v2.y
						local y2 = self.mScrollDrag.InitDownPos.y

						if self.mScrollDrag.isHorizontal then
							y = v2.x
							y2 = self.mScrollDrag.InitDownPos.x
						end

						if y > 0 then
							local v3 = -(y - y2) * self.mScrollDrag.Sensitivity

							if self.mScrollDrag.isHorizontal then
								self.mScrollDrag.InitDownPos.x = y
							else
								self.mScrollDrag.InitDownPos.y = y
							end

							ternary:ScrollBy(v3 / self:GetMouseDragScrollStep() * ternary.mScrollStep * self.mScrollDrag.Sensitivity)
						end
					else
						local y = v.y
						local y2 = self.mScrollDrag.InitDownPos.y

						if self.mScrollDrag.isHorizontal then
							y = v.x
							y2 = self.mScrollDrag.InitDownPos.x
						end

						if y > 0 then
							local v2 = (y - y2) * self.mScrollDrag.Sensitivity
							local mouseDragScrollStep = self:GetMouseDragScrollStep()
							local v3 = math.modf(v2 / mouseDragScrollStep)

							if v3 ~= 0 then
								local v4 = y2 + v3 * mouseDragScrollStep / self.mScrollDrag.Sensitivity

								if self.mScrollDrag.isHorizontal then
									self.mScrollDrag.InitDownPos.x = v4
								else
									self.mScrollDrag.InitDownPos.y = v4
								end

								local v5 = v3 * self:GetDragScrollIncrement()
								local v6 = self.mScroll - v5
								local v7

								if self.GetClampedScroll == nil then
									v7 = __wf_atom_421b01aa(
										v6,
										1,
										self:GetHowManyElements() - self:GetHowManyVisibleElements() + 1
									)
								else
									v7 = self:GetClampedScroll(v6)
								end

								self:SetScroll(v7, true)
								return true
							end
						end
					end
				elseif Distance(v, self.mScrollDrag.InitDownPos) > self.mScrollDrag.DistThresh then
					self.mScrollDrag.isDragging = true
				end
			end
		end
	}
end

function CreateNewList(p, value, items)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.mMovie) then
		print("List created without valid env")
		return
	end

	local v = string.gsub(value, "%.", "")
	local result = CreateList(p.mMovie, value)
	result.OldRedraw = result.Redraw

	function result:Redraw(p2, p3, p4)
		self:UpdateVisibleProp()
		result:OldRedraw(p2, p3, p4)
	end

	result.OldCalculateScrollBarHeight = result.CalculateScrollBarHeight

	function result:CalculateScrollBarHeight(p2)
		if self.mScrollBar == nil then
			return self:OldCalculateScrollBarHeight(p2)
		end

		return self.mScrollBar.mContentOffset * 2 + self:OldCalculateScrollBarHeight(p2)
	end

	function result:UpdateVisibleProp(mHeight, mScrollBar)
		local mVisibleElements = 0

		if mScrollBar == nil then
			mScrollBar = self.mScrollBar

			if mScrollBar == nil then
				return
			end
		end

		if mHeight == nil then
			mHeight = mScrollBar.mHeight
		end

		local v2 = mHeight - mScrollBar.mContentOffset * 2
		local total = 0

		if #self.mElements > 0 then
			local mScroll = self.mScroll or 1
			local v3 = math.floor(mScroll)
			local v4 = mScroll - v3
			local v5 = 0

			for i, mElement in ipairs(self.mElements) do
				if mElement == nil then
					continue
				end

				local mHeight2 = mElement.mHeight
					or self.mForcedVerticalSeparation
					or self.mMovie:__wf_atom_5e6e15c8(mElement.mClipName, 15)
				total += mHeight2

				if i == v3 then
					v5 = mHeight2 * (1 - v4)
					mVisibleElements = 1
				elseif v3 < i and v5 < v2 then
					mVisibleElements += 1
					v5 += mHeight2
				end
			end
		end

		if total == 0 then
			mScrollBar.mVisibleProp = 1
		else
			mScrollBar.mVisibleProp = __wf_atom_421b01aa(v2 / total, 0, 1)
		end

		self.mVisibleElements = mVisibleElements
	end

	function result:AttachScrollBar(mScrollBarClipName, options)
		if #mScrollBarClipName > 0 then
			local v2 = options or {}
			v2.mContentOffset = v2.mContentOffset or 0
			v2.mHeight = v2.mHeight or self:CalculateScrollBarHeight()
			v2.mAlwaysVisible = v2.mAlwaysVisible or self.mScrollAlwaysVisible
			self:UpdateVisibleProp(nil, v2)
			local mVisRangeFadeSize = v2.mVisRangeFadeSize

			if mVisRangeFadeSize == nil then
				for _, mVisRangeMaterial in pairs(v2.mVisRangeMaterials) do
					if __wf_atom_7e8ad928(mVisRangeMaterial) then
						continue
					end

					mVisRangeFadeSize = mVisRangeMaterial:__wf_atom_b90af225(SF.__wf_atom_7a5b8f59, 1)
					break
				end
			end

			self.mLowerBoundBuffer = math.ceil((mVisRangeFadeSize or 0) / (self.mRowSeparation or self.mForcedVerticalSeparation))

			if self.mColumns ~= nil then
				self.mLowerBoundBuffer *= self.mColumns
			end

			self.mUpperBoundBuffer = self.mLowerBoundBuffer
			self.mScrollBarClipName = mScrollBarClipName
			self:SetScroll(1, true)
			local module = require("SF.Interface.Components.Scrollbar")
			local scrollBar = module.CreateScrollBar(p, mScrollBarClipName, v2)

			function scrollBar.mScrollValueChangedCallback(p2, p3)
				self:ScrollValueChangedCallback(p2, p3)
			end

			self.mScrollBar = scrollBar
			self:EnableDragScrolling(v2 ~= nil and v2.mHorizontal)
			self:EnableSmoothScroll()
		end
	end

	function result:GetScrollRange()
		local scrollRange = 0

		if not (#self.mElements > 0) then
			return scrollRange
		end

		local mScrollBar = self.mScrollBar

		if mScrollBar == nil then
			return scrollRange
		end

		scrollRange = mScrollBar:GetScrollRange()

		for i, mElement in ipairs(self.mElements) do
			local mHeight = mElement.mHeight or self.mForcedVerticalSeparation

			if scrollRange < mHeight then
				return scrollRange / mHeight + (i - 1)
			else
				scrollRange -= mHeight
			end
		end

		return scrollRange
	end

	function result:ScrollValueChangedCallback(p2, _)
		if self.mScrollBar ~= nil then
			local scrollRange = self:GetScrollRange()
			local v2 = __wf_atom_421b01aa(scrollRange * p2, 0, scrollRange) + 1

			if v2 ~= self.mScroll then
				local v3 = math.floor(v2) - math.floor(self.mScroll)
				self:SetScroll(v2, true)
				self:UpdateVisibleProp()

				if v3 >= 1 or v3 <= -1 then
					self.mRedrawFromScrollBar = true
					self:Redraw(nil, false, true)
				end

				self:RunForAllVisibleElements(function(p3)
					self.mMovie:__wf_atom_e57658c2(p3.mClipName, 1, self:CalculateY(p3))
					self:RepositionButton(p3)
				end)
			end
		end
	end

	function result:UpdateScrollBarHeight(p2)
		local mScrollBar = self.mScrollBar

		if mScrollBar ~= nil then
			local v2 = p2 or self:CalculateScrollBarHeight()
			self:UpdateVisibleProp(v2)
			mScrollBar:SetHeight(v2, true, true)
		end
	end

	function result:ResetScrollBar()
		if self.mScrollBar ~= nil then
			self.mScrollBar.mCurrentScroll = 0
			self:UpdateScrollBarHeight()
		end
	end

	function result:RedrawScrollBar(p2)
		local mScrollBar = self.mScrollBar

		if mScrollBar ~= nil and self.mScrollBarClipName ~= nil and not mScrollBar.mDragging then
			self:UpdateVisibleProp()
			local v2

			if mScrollBar.mVisibleProp < 1 then
				v2 = self:CanUseScrollBar()
			else
				v2 = false
			end

			if v2 then
				local scrollRange = self:GetScrollRange()

				if scrollRange ~= 0 then
					scrollRange = (self.mScroll - 1) / scrollRange
				end

				mScrollBar:SetScrollValue(scrollRange, true, p2)
				mScrollBar:RedrawScrollBar()
			else
				mScrollBar:SetScrollValue(0, true, true)
			end

			mScrollBar:SetVisible(v2, self.mScrollAlwaysVisible)
			mScrollBar:SetEnabled(v2)
		end
	end

	function result:CalculateY(state)
		local mScroll = self.mScroll or 1
		local v2 = math.min(state.mIndex, (math.floor(mScroll)))
		local mElements = self.mElements
		local mElement = mElements[v2]
		local mOffsetY = mElement == nil and 0
			or (v2 - mScroll) * (mElement.mHeight or self.mForcedVerticalSeparation or self.mMovie:__wf_atom_5e6e15c8(mElement.mClipName, 15))

		for i = v2, state.mIndex - 1 do
			local mElement2 = mElements[i]

			if mElement2 ~= nil then
				mOffsetY += mElement2.mHeight or self.mForcedVerticalSeparation or self.mMovie:__wf_atom_5e6e15c8(mElement2.mClipName, 15)
			end
		end

		state.mOffsetY = mOffsetY
		return self.UTIL.Round(self.mInitialY + mOffsetY) + (state.listExtraY or 0)
	end

	function result:AssignCallback(p2, p3)
		if p2 == nil then
			return
		end

		local v2 = v .. p2
		result["m" .. p2 .. "ElementCallback"] = v2

		if p3 == nil then
			p[v2] = nil
		else
			p[v2] = function(p4)
				if result[p3] ~= nil then
					result[p3](result, (tonumber(p4)))
				end
			end
		end
	end

	function result:SetCallbacks(items2)
		for k, item in items2 do
			result:AssignCallback(k, item)
		end

		self:SetClipCallbacks(self.mClipName)
		self:RunForAllVisibleElements(function(p2)
			self:SetClipCallbacks(p2.mClipName)
		end)
	end

	function result:SetClipCallbacks(p2)
		if
			self.mRollOverElementCallback ~= nil
			or self.mRollOutElementCallback ~= nil
			or self.mSelectElementCallback ~= nil
			or self.mPressElementCallback ~= nil
		then
			self.mMovie:SetCallbacks(
				p2 .. ".Btn",
				self.mRollOverElementCallback,
				self.mRollOutElementCallback,
				self.mSelectElementCallback,
				self.mPressElementCallback
			)
		end

		if self.mReleaseOutsideElementCallback ~= nil then
			self.mMovie:SetReleaseOutsideCallback(p2 .. ".Btn", self.mReleaseOutsideElementCallback)
		end

		if self.mDragOverElementCallback ~= nil or self.mDragOutElementCallback ~= nil then
			self.mMovie:SetDragCallbacks(p2 .. ".Btn", self.mDragOverElementCallback, self.mDragOutElementCallback)
		end

		if self.mRightSelectElementCallback ~= nil or self.mRightPressElementCallback ~= nil then
			self.mMovie:SetRightMouseCallbacks(
				p2 .. ".Btn",
				self.mRightPressElementCallback,
				self.mRightSelectElementCallback
			)
		end
	end

	for k, item in pairs(items) do
		result[k] = item
	end

	result:SetCallbacks({
		Select = "SelectElementById",
		RollOver = "FocusElementById",
		RollOut = "UnfocusElementById"
	})
	return result
end