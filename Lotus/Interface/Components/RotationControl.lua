module(..., package.seeall)

function Create(mMovie)
	return {
		mMovie = mMovie,
		mMouseDown = false,
		mForceUseControllerDelta = false,
		mUseControllerDeltaIfSet = false,
		mRightStickTension = { x = 0, y = 0 },
		mRightStickDeadZone = 0.2,
		mLastMousePos = { x = 0, y = 0 },
		mMousePos = { x = 0, y = 0 },
		Update = function(self)
			local mLastMousePos = self.mLastMousePos
			local mLastMousePos2 = self.mLastMousePos
			local x = self.mMousePos.x
			local y = self.mMousePos.y
			mLastMousePos.x = x
			mLastMousePos2.y = y
			local mMousePos = self.mMousePos
			local mMousePos2 = self.mMousePos
			local movieMousePos, v = self:GetMovieMousePos()
			mMousePos.x = movieMousePos
			mMousePos2.y = v
		end,
		SetMouseDown = function(p, mMouseDown)
			p.mMouseDown = mMouseDown
		end,
		SetRightStickTensionX = function(p, p2)
			p.mMovie:__wf_atom_976dcedd("_root", "suitRotationX", p2)
			p.mRightStickTension.x = p2
		end,
		SetRightStickTensionY = function(p, p2)
			p.mRightStickTension.y = p2
		end,
		SetRightStickDeadZone = function(p, mRightStickDeadZone)
			p.mRightStickDeadZone = mRightStickDeadZone
		end,
		GetMouseDelta = function(self)
			if self:IsMouseDown() then
				return (self.mMousePos.x - self.mLastMousePos.x) * 0.3, (self.mMousePos.y - self.mLastMousePos.y) * 0.3
			end

			return 0, 0
		end,
		GetControllerDelta = function(self)
			return self.mRightStickTension.x * 6, self.mRightStickTension.y * 6
		end,
		IsStickTensionSet = function(self)
			local controllerDelta, v = self:GetControllerDelta()
			return controllerDelta ~= 0 or v ~= 0
		end,
		GetDelta = function(self)
			if
				Engine.IsPlayingWithController()
				or self.mForceUseControllerDelta
				or self.mUseControllerDeltaIfSet and self:IsStickTensionSet()
			then
				return self:GetControllerDelta()
			end

			return self:GetMouseDelta()
		end,
		GetMovieMousePos = function(self)
			return self.mMovie:__wf_atom_5e6e15c8("_root", 30), self.mMovie:__wf_atom_5e6e15c8("_root", 31)
		end,
		IsMouseDown = function(self)
			if
				Engine.IsPlayingWithController()
				or self.mForceUseControllerDelta
				or self.mUseControllerDeltaIfSet and self:IsStickTensionSet()
			then
				return math.abs(self.mRightStickTension.x) > self.mRightStickDeadZone
					or math.abs(self.mRightStickTension.y) > self.mRightStickDeadZone
			end

			return self.mMouseDown
		end
	}
end