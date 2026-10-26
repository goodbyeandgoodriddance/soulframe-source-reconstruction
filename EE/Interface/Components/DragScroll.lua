module(..., package.seeall)
local module = require("EE.Interface.Utilities")

function Create(mMovie, mClipName, p, p2, p3, p4)
	return {
		mMovie = mMovie,
		mClipName = mClipName,
		mDragging = false,
		mDragMultiplier = 1,
		mStarting = { x = nil, y = nil },
		mFirst = { x = nil, y = nil },
		mCurrentScroll = { x = 0, y = 0 },
		mOriginalCoords = {
			x = mMovie:__wf_atom_5e6e15c8(mClipName, 0),
			y = mMovie:__wf_atom_5e6e15c8(mClipName, 1)
		},
		mCurrentCoords = { x = 0, y = 0 },
		mDragSpeed = { x = 0, y = 0 },
		mLeeway = { x = 0.15, y = 0.15 },
		mMin = { x = p, y = p2 },
		mMax = { x = p3, y = p4 },
		mScrollRange = {
			x = p - p3,
			y = p2 - p4
		},
		mDeselectRange = 10,
		mActive = true,
		SetActive = function(p5, mActive)
			p5.mActive = mActive
		end,
		SetScroll = function(self, p5, p6, p7, p8)
			local v = self.mLeeway[p5]
			local v2 = __wf_atom_421b01aa(p6, -v, 1 + v)

			if self.mCurrentScroll[p5] ~= v2 or p8 then
				self.mCurrentScroll[p5] = v2
				self.mCurrentCoords[p5] = module.Round(self.mMax[p5] + self.mScrollRange[p5] * v2)
				self.mMovie:__wf_atom_976dcedd(self.mClipName, "_" .. p5, self.mCurrentCoords[p5])

				if self.OnScroll ~= nil then
					self:OnScroll(p5, v2, p7)
				end
			end
		end,
		StartDrag = function(state)
			state.mDragging = true
			state.mChanged = nil

			for _, v in ipairs({ "x", "y" }) do
				local v2 = tonumber(state.mMovie:__wf_atom_76657dba("_root", "_" .. v .. "mouse"))

				if v2 <= -1000 then
					state.mDragging = false
					return
				else
					state.mStarting[v] = v2
					state.mFirst[v] = v2
				end
			end

			if state.mOnStartDrag ~= nil then
				state.mOnStartDrag()
			end
		end,
		StopDrag = function(state)
			state.mDragging = false

			for _, v in ipairs({ "x", "y" }) do
				state.mStarting[v] = nil
				state.mFirst[v] = nil
			end

			if state.mOnStopDrag ~= nil then
				state.mOnStopDrag()
			end
		end,
		Update = function(self, p5)
			local v = false

			if not self.mActive then
				return
			end

			for _, v2 in ipairs({ "x", "y" }) do
				if self.mScrollRange[v2] == 0 then
					continue
				end

				if self.mStarting[v2] == nil then
					if self.mDragSpeed[v2] == 0 and self.mCurrentScroll[v2] < 0 then
						self.mDragSpeed[v2] = -self.mCurrentScroll[v2] / 20
					elseif self.mDragSpeed[v2] == 0 and self.mCurrentScroll[v2] > 1 then
						self.mDragSpeed[v2] = -(self.mCurrentScroll[v2] - 1) / 20
					end
				else
					local v3 = tonumber(self.mMovie:__wf_atom_76657dba("_root", "_" .. v2 .. "mouse"))

					if v3 == -1000 then
						v3 = self.mStarting[v2]
					end

					self.mDragSpeed[v2] = (v3 - self.mStarting[v2]) * self.mDragMultiplier / self.mScrollRange[v2]
					v = v or math.abs(self.mFirst[v2] - v3) > self.mDeselectRange
					self.mStarting[v2] = v3

					if not self.mChanged then
						self.mChanged = self.mFirst[v2] ~= self.mStarting[v2]
					end
				end

				if self.mDragSpeed[v2] == 0 then
					continue
				end

				self:SetScroll(v2, self.mCurrentScroll[v2] + self.mDragSpeed[v2], p5)

				if self.mStarting[v2] ~= nil then
					continue
				end

				self.mDragSpeed[v2] = self.mDragSpeed[v2] * 0.85

				if self.mDragSpeed[v2] > -0.001 and self.mDragSpeed[v2] < 0.001 then
					self.mDragSpeed[v2] = 0
				end
			end

			if v and self.mOnDeselectCallback ~= nil then
				self.mOnDeselectCallback()
			end
		end
	}
end