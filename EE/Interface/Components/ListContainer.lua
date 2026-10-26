module(..., package.seeall)
require("EE.Interface.Utilities")

function CreateListContainer(mMovie, mClipRoot, mClipName2, mInitialX, mInitialY, mWidth, mHeight2, mHorizontal)
	return {
		mMovie = mMovie,
		mClipRoot = mClipRoot,
		mClipName = mClipName2,
		mClipPath = mClipRoot .. "." .. mClipName2,
		mInitialized = false,
		mDragging = false,
		mEnabled = true,
		mInitialX = mInitialX,
		mInitialY = mInitialY,
		mWidth = mWidth,
		mHeight = mHeight2,
		mStartDragCallback = nil,
		mStopDragCallback = nil,
		mHookedUpCallbacks = false,
		mHorizontal = mHorizontal,
		mPrefix = "ListContainer(" .. mClipName2 .. ")::",
		mScale = 100,
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
		SetHeight = function(self, mHeight, _, _)
			if not self.mInitialized then
				return
			end

			self.mHeight = mHeight
			self:RedrawContainer()
		end,
		Initialize = function(self)
			self.mMovie:__wf_atom_4c1c1986(self.mClipRoot, self.mClipName, 0, self.mInitialX)
			self.mMovie:__wf_atom_4c1c1986(self.mClipRoot, self.mClipName, 1, self.mInitialY)
			self:RedrawContainer()
			self.mInitialized = true
		end,
		RedrawContainer = function(self)
			self.mMovie:__wf_atom_4c1c1986(self.mClipRoot, self.mClipName, 14, self.mWidth)
			self.mMovie:__wf_atom_4c1c1986(self.mClipRoot, self.mClipName, 15, self.mHeight)
		end,
		StartDrag = function(self)
			if not self.mDragging and self.mEnabled then
				self.mDragging = true

				if not __wf_atom_7e8ad928(self.mStartDragCallback) then
					self:mStartDragCallback()
				end
			end
		end,
		StopDrag = function(self)
			if self.mDragging then
				self.mDragging = false

				if not __wf_atom_7e8ad928(self.mStopDragCallback) then
					self:mStopDragCallback()
				end
			end
		end,
		RollOver = function(self)
			if not __wf_atom_7e8ad928(self.RollOverCallback) then
				self:__wf_atom_eccec90c()
			end
		end,
		RollOut = function(self)
			if not __wf_atom_7e8ad928(self.mRollOutCallback) then
				self:mRollOutCallback()
			end
		end,
		Click = function(p)
			local _mEnabled = p.mEnabled
		end,
		HookUpCallbacks = function(self)
			assert(not self.mHookedUpCallbacks)
			self.mHookedUpCallbacks = true
			local parentEnv = self:GetParentEnv()
			local mClipName = self.mClipName
			local mCallbackPrefix = string.gsub(mClipName, "%.", "")

			if self.mCallbackPrefix ~= nil then
				mCallbackPrefix = self.mCallbackPrefix
			end

			parentEnv[mCallbackPrefix .. "StartDrag"] = function()
				self:StartDrag()
			end

			parentEnv[mCallbackPrefix .. "StopDrag"] = function()
				self:StopDrag()
			end

			parentEnv[mCallbackPrefix .. "RollOver"] = function()
				self:RollOver()
			end

			parentEnv[mCallbackPrefix .. "RollOut"] = function()
				self:RollOut()
			end

			parentEnv[mCallbackPrefix .. "ReleaseOutside"] = function()
				self:RollOut()
				self:StopDrag()
			end

			parentEnv[mCallbackPrefix .. "RollOver"] = function()
				self:RollOver()
			end

			parentEnv[mCallbackPrefix .. "RollOut"] = function()
				self:RollOut()
			end

			self.mMovie:SetCallbacks(
				self.mClipPath,
				mCallbackPrefix .. "RollOver",
				mCallbackPrefix .. "RollOut",
				mCallbackPrefix .. "StopDrag",
				mCallbackPrefix .. "StartDrag"
			)
			self.mMovie:SetReleaseOutsideCallback(self.mClipPath, mCallbackPrefix .. "ReleaseOutside")
		end,
		SetEnabled = function(self, p)
			local mEnabled = p == true
			self.mEnabled = mEnabled

			if self.mDragging then
				self:StopDrag()
			end

			self.mMovie:__wf_atom_7f57ab2f(self.mClipPath, 67, mEnabled)
		end,
		ApplyScale = function(data)
			if data.mHorizontal then
				data.mMovie:__wf_atom_e57658c2(data.mClipPath, 6, data.mScale)
			else
				data.mMovie:__wf_atom_e57658c2(data.mClipPath, 5, data.mScale)
			end
		end
	}
end