module(..., package.seeall)

function CreateCircularText(mMovie, mClipName2)
	local module = require("EE.Interface.Utilities")
	return {
		mMovie = mMovie,
		mText = "",
		mLetters = {},
		mClipName = mClipName2,
		UTIL = module,
		mInitialDepth = 1000,
		mInitialX = mMovie:__wf_atom_5e6e15c8(mClipName2, 0),
		mInitialY = mMovie:__wf_atom_5e6e15c8(mClipName2, 1),
		mInitialZ = mMovie:__wf_atom_5e6e15c8(mClipName2, 4),
		mRadius = 200,
		mLetterSpacing = 1,
		mInitialLetterRotation = 90,
		mInitialAngle = -90,
		mAlignment = module.CENTER_ALIGNED,
		mFlip = false,
		PI = 3.1416,
		mLayflat = false,
		mUseHeading = false,
		mZMultiplier = 20,
		mTargetAngle = nil,
		mPrefix = "CircularText(" .. mClipName2 .. ")::",
		Print = function(self, _) end,
		GetHowManyLetters = function(p)
			return (string.len(p.mText))
		end,
		ConvertPixelsInCircumferenceToAngle = function(self, p)
			local v = p / (self.PI * self.mRadius * 2)
			return (self.UTIL.ToDeg(v * 2 * self.PI))
		end,
		Redraw = function(self)
			self:Print("Redraw()")
			local count = #self.mLetters

			for i = 0, count - 1 do
				local v = count - i
				local mClipName = self.mLetters[v].mClipName
				table.remove(self.mLetters, v)

				if mClipName == self.mClipName then
					self.mMovie:__wf_atom_e57658c2(mClipName, 12, 0)
				else
					__wf_atom_86cbd68d(self.mMovie, mClipName .. ".removeMovieClip")
				end
			end

			self.mLetters = {}
			local mText = self.mText
			local count2 = 0

			while string.len(mText) > 0 and count2 < 50 do
				count2 += 1
				local letter = __wf_atom_f50c9d2d(mText, 0, 1)
				mText = __wf_atom_f50c9d2d(mText, 2)
				table.insert(self.mLetters, { Id = count2, Letter = letter })
			end

			local v = ""
			local v2 = 0
			local total = 0

			for i = 1, #self.mLetters do
				self.mMovie:__wf_atom_48bd5a59(self.mClipName, "Tf", 36, v .. " ")
				local __wf_atom_5e6e15c8 = self.mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Tf", 40)
				local v3 = __wf_atom_5e6e15c8 - v2

				if i ~= 1 then
					v3 += self.mLetterSpacing
				end

				local convertPixelsInCircumferenceToAngle = self:ConvertPixelsInCircumferenceToAngle(v3)
				total += convertPixelsInCircumferenceToAngle
				v ..= self.mLetters[i].Letter
				self:Print("Calculating width '" .. v .. "' deltaWidth=" .. tostring(__wf_atom_5e6e15c8) .. "' deltaAngle=" .. tostring(convertPixelsInCircumferenceToAngle))
				self.mLetters[i].DeltaAngle = convertPixelsInCircumferenceToAngle
				v2 = __wf_atom_5e6e15c8
			end

			local v3 = nil
			local v4 = nil
			self:Print("totalCircumference=" .. total)
			local v5

			if self.mTargetAngle == nil then
				v5 = 1
			else
				v5 = math.min(1, self.mTargetAngle / total)
				self:Print("targetAngle=" .. v5)
				self:Print("targetCircumference=" .. total * v5)
			end

			local v6 = self.mInitialAngle - self.mLetters[1].DeltaAngle / 2 * v5
			self:Print("startingAngle=" .. v6)
			local ternary = self.UTIL.Ternary(self.mFlip, -v5, v5)

			if self.mAlignment == self.UTIL.CENTER_ALIGNED then
				v6 -= total * 0.5 * ternary
			elseif self.mAlignment == self.UTIL.RIGHT_ALIGNED then
				v6 -= total * ternary
			end

			local mWidthScale = self.mWidthScale or v5 * 1.4
			self:Print("leftAngle=" .. v6)

			for i, mLetter in ipairs(self.mLetters) do
				local mClipName

				if i == 1 then
					mClipName = self.mClipName
				else
					mClipName = self.mClipName .. i
				end

				self.mLetters[i].mClipName = mClipName

				if not self.mMovie:__wf_atom_253d7085(mClipName) then
					local v7 = StringSplit(".", mClipName)
					self:Print("duplicating and creating " .. tostring(v7[#v7]) .. " from " .. tostring(mClipName))
					__wf_atom_86cbd68d(
						self.mMovie,
						self.mClipName .. ".duplicateMovieClip",
						v7[#v7],
						self.mInitialDepth + i
					)
				end

				v6 += mLetter.DeltaAngle * ternary
				local v7 = math.cos((self.UTIL.ToRad(v6))) * self.mRadius
				local mInitialX = self.mInitialX

				if self.mFlip then
					v7 = -v7
				end

				local v8 = mInitialX + v7

				if self.mUseHeading then
					v4 = (self.mInitialZ + math.sin((self.UTIL.ToRad(v6))) * self.mRadius) * self.mZMultiplier
				else
					local v9 = math.sin((self.UTIL.ToRad(v6))) * self.mRadius + self.mRadius
					local mInitialY = self.mInitialY

					if self.mFlip then
						v9 = -v9
					end

					v3 = mInitialY + v9
				end

				self:Print(tostring(i) .. " letter -> " .. tostring(mLetter.Letter) .. " currentAngle -> " .. tostring(v6) .. " X:" .. tostring(v8) .. " Y:" .. tostring(v3))
				self.mMovie:__wf_atom_e57658c2(mClipName, 0, v8)

				if self.mUseHeading then
					self.mMovie:__wf_atom_e57658c2(mClipName, 17, self.mInitialLetterRotation + (180 - v6))
					self.mMovie:__wf_atom_e57658c2(mClipName, 4, v4)

					if self.mLayflat then
						self.mMovie:__wf_atom_e57658c2(mClipName, 18, -90)
					end
				else
					self.mMovie:__wf_atom_e57658c2(mClipName, 1, v3)
					self.mMovie:__wf_atom_e57658c2(mClipName, 16, self.mInitialLetterRotation + v6)
				end

				self.mMovie:__wf_atom_e57658c2(mClipName, 5, mWidthScale * 100)
				self.mMovie:__wf_atom_e57658c2(mClipName, 12, 100)
				self.mMovie:__wf_atom_48bd5a59(mClipName, "Tf", 36, mLetter.Letter)
				self.mMovie:OverrideMaterial(mClipName .. ".Tf", self.mMaterial)

				if self.OnDrawLetter ~= nil then
					self:OnDrawLetter(self.mLetters[i])
				end
			end
		end,
		SetText = function(self, mText)
			self:Print("SetText(" .. mText .. ")")
			self.mText = mText
			self:Redraw()
		end,
		RunForEachLetter = function(p, callback)
			if not __wf_atom_7e8ad928(callback) then
				for i = 1, #p.mLetters do
					callback(p.mLetters[i])
				end
			end
		end
	}
end