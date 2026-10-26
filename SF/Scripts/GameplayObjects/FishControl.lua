local v = Type("/SF/Types/Items/Consumables/Tackle/BugLureStarterCommon")
local v2 = {
	1,
	1,
	1,
	2,
	2,
	3,
	3,
	3,
	3,
	3
}
local v3 = Range(20, 30)
local v4 = Symbol("Lake")
local v5 = {
	mSwimAnim = Resource("/SF/Animations/Wildlife/Fish/FishACycle_anim.fbx"),
	mLeft90Anim = Resource("/SF/Animations/Wildlife/Fish/Turn90Left_anim.fbx"),
	mRight90Anim = Resource("/SF/Animations/Wildlife/Fish/Turn90Right_anim.fbx"),
	mLeft180Anim = Resource("/SF/Animations/Wildlife/Fish/Turn180Left_anim.fbx"),
	mRight180Anim = Resource("/SF/Animations/Wildlife/Fish/Turn180Right_anim.fbx"),
	mBiteAnim = Resource("/SF/Animations/Wildlife/Fish/Bite_anim.fbx"),
	mStruggleAnim = Resource("/SF/Animations/Wildlife/Fish/StruggleCaught_anim.fbx"),
	mJumpStartAnim = Resource("/SF/Animations/Wildlife/Fish/JumpStart_anim.fbx")
}
local v6 = {
	Resource("/SF/Animations/Wildlife/Fish/JumpOutofWater01_anim.fbx"),
	Resource("/SF/Animations/Wildlife/Fish/JumpOutofWater02_anim.fbx"),
	Resource("/SF/Animations/Wildlife/Fish/JumpOutofWater03_anim.fbx"),
	Resource("/SF/Animations/Wildlife/Fish/JumpOutofWater04_anim.fbx")
}
local v7 = 1
local v8 = 0
local v9 = nil
local v10 = nil
local mFishTypes = {}
local v11 = {
	"IDLE",
	"ROAM",
	"INVESTIGATE",
	"PREBITE",
	"BITE",
	"HOOKED",
	"CAUGHT",
	"RELEASED",
	"FLEE",
	"STUCK",
	"JUMP"
}
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.FishingLib")
local module3 = require("SF.Scripts.Libs.ModifySkyLib")
local module4 = require("EE.Interface.Utilities")

local function fn(p, position, p2)
	local v12 = p2 - position
	local v13 = v12.x * v12.x + v12.y * v12.y + v12.z * v12.z

	if v13 == 0 then
		return position
	end

	local v14 = p - position
	local v15 = (v14.x * v12.x + v14.y * v12.y + v14.z * v12.z) / v13
	local v16 = __wf_atom_421b01aa(v15, 0, 1)
	return __wf_atom_f55d6358(position, p2, v16)
end

local function fn2(position, p, position2, p2)
	local v12 = Vector(position.x, 0, position.z)
	local v13 = Vector(p.x, 0, p.z)
	local v14 = Vector(position2.x, 0, position2.z)
	local v15 = v13 - v12
	local v16 = v14 - v12
	local lengthSqr = module.LengthSqr(v15)

	if lengthSqr <= 0 then
		return module.LengthSqr(v14 - v12) <= p2 * p2
	end

	local v17 = v14 - (position + v15 * __wf_atom_421b01aa(Dot(v16, v15) / lengthSqr, 0, 1))
	return module.LengthSqr(v17) <= p2 * p2
end

function DissolveIn(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v12 = 0

	while v12 < 1.5 do
		v12 = __wf_atom_421b01aa(v12 + __wf_atom_084b3e93(), 0, 1.5)
		object:__wf_atom_68f2c268(1 - v12 / 1.5)
		Sleep(0)
	end
end

function DissolveOut(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v12 = 0

	while v12 < 2 do
		v12 = __wf_atom_421b01aa(v12 + __wf_atom_084b3e93(), 0, 2)
		object:__wf_atom_68f2c268(v12 / 2)
		Sleep(0)
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

local function fn3(state, p)
	if __wf_atom_7e8ad928(state) then
		return
	end

	if not (__wf_atom_7e8ad928(state.mTargetLure) or __wf_atom_7e8ad928(v9)) then
		local __wf_atom_296472bc = v9:__wf_atom_296472bc()

		if not __wf_atom_7e8ad928(__wf_atom_296472bc) and __wf_atom_296472bc.mFishTargetingLure == state.mFishDeco then
			__wf_atom_296472bc.mFishTargetingLure = nil
		end

		v9:__wf_atom_aabc9a96(__wf_atom_296472bc)
		local __wf_atom_e919fb8e = v9:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.fishingLureCooldownStartTime = Time()
	end

	state.mTargetLure = nil
	state.mTargetPosition = nil
	state.mTargetLureOriginalPosition = nil
	state.mLureTargetCooldownTimer = state.mLureTargetCooldownDuration
	state.mLureUnreachableTimer = 0
	state.mLureUntargetDistance = 3.4028234663852886e38

	if p == 8 then
		state.mFleeTimer = state.mFleeDurationRange:__wf_atom_ff1686f2()

		if state.mFishDeco:__wf_atom_43e681f1() == 4 then
			state.mTargetPosition = state.mFishDeco:GetPosition() + __wf_atom_9341614d(
				Vector(0, 0, 5),
				state.mFishDeco:__wf_atom_dc309f8a()
			)
			state.mTargetPosition.y = state.mWaterHeight - state.mAllowedDepthRange:__wf_atom_421b01aa(state.mWaterHeight - state.mTargetPosition.y)
			state.mMoveTimer = 3
			state.mNextTargetSweepTime = 0
			state.mNextTrajectorySweepTime = 0
		end
	elseif p == 1 then
		state.mJumpCooldown = __wf_atom_104bfe98(
			state.mJumpCooldownRange.minValue,
			state.mJumpCooldownRange.maxValue,
			math.random()
		)
	end

	state.mFishDeco:__wf_atom_032e99b2(p)
	state.mFishDeco:StopAnimation()
	state.mFishDeco:__wf_atom_7b7015c9(v5.mSwimAnim)
	state.mFishDeco:__wf_atom_f173c8ad()
end

local function fn4(position, p, position2) -- 1 equivalent call inferred from this helper
	Normalize(p)
	local v12 = position2 - position
	local v13 = position + p * Dot(v12, p)
	return Length(position2 - v13)
end

local function fn5(allFishInfo, p)
	if __wf_atom_7e8ad928(allFishInfo) or __wf_atom_7e8ad928(allFishInfo.mFishDeco) or __wf_atom_7e8ad928(v9) then
		return false
	end

	local mFishDeco = allFishInfo.mFishDeco
	local mLureDeco = v9:__wf_atom_296472bc().mLureDeco
	local position = v9:CameraControl():__wf_atom_dd7246c7():GetPosition()
	local v12 = fn4(position, mLureDeco:GetPosition() - position, mFishDeco:GetPosition()) -- inferred equivalent call

	if _T.fishingDebugInfiniteInterestDistance or not (p < v12) then
		return true
	end

	return false
end

local function fn6(_)
	if _T.fishingDebugNoFishBiting or __wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v10) then
		return
	end

	local __wf_atom_296472bc = v9:__wf_atom_296472bc()
	local mLureDeco = __wf_atom_296472bc.mLureDeco

	if not __wf_atom_7e8ad928(mLureDeco) then
		local position = mLureDeco:GetPosition()

		for _, allFishInfo in ipairs(_T.allFishInfos) do
			if
				__wf_atom_7e8ad928(allFishInfo)
				or __wf_atom_7e8ad928(allFishInfo.mFishDeco)
				or allFishInfo.mIsPurified
			then
				continue
			end

			local mFishDeco = allFishInfo.mFishDeco
			local position2 = mFishDeco:GetPosition()

			if mFishDeco:__wf_atom_43e681f1() ~= 1 then
				continue
			end

			local __wf_atom_e919fb8e = v9:__wf_atom_e919fb8e()

			if
				not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.fishingLureCooldownStartTime) or not (Time() < __wf_atom_e919fb8e.fishingLureCooldownStartTime + 2))
				or allFishInfo.mLureTargetCooldownTimer > 0
				or not _T.fishingLureInWater
			then
				continue
			end

			if not (not mFishDeco.mRequirePerfectCast or _T.fishingIsPerfectCast) then
				continue
			end

			if not __wf_atom_7e8ad928(__wf_atom_296472bc.mFishTargetingLure) then
				if __wf_atom_296472bc.mFishTargetingLure:__wf_atom_43e681f1() ~= 2 then
					continue
				end

				local distance2DSqr = module.Distance2DSqr(position2, position)
				local distance2DSqr2 = module.Distance2DSqr(
					__wf_atom_296472bc.mFishTargetingLure:GetPosition(),
					position
				)

				if distance2DSqr2 < distance2DSqr or distance2DSqr2 < 4 then
					continue
				end
			end

			local __wf_atom_e40295b1 = v10:__wf_atom_e40295b1()
			local matchCount = module2.GetMatchCount(v10:__wf_atom_e5aab704(), {
				module2.GetBiomeSymbolFromId(allFishInfo.mBiomeId)
			})
			local __wf_atom_de0ebb40 = mFishDeco:__wf_atom_de0ebb40(v10:__wf_atom_9c97587b())

			if matchCount > 0 then
				__wf_atom_e40295b1 *= 1.2
			end

			if __wf_atom_de0ebb40 > 0 then
				__wf_atom_e40295b1 *= 1.2
			end

			if
				_T.fishingLureInWater
				and _T.fishingIsPerfectCast
				and Time() >= _T.fishingLureImpactTime
				and Time() <= _T.fishingLureImpactTime + 2
			then
				__wf_atom_e40295b1 *= 1.35
			end

			if Time() >= __wf_atom_296472bc.mLureTugTime and Time() <= __wf_atom_296472bc.mLureTugTime + 2 then
				__wf_atom_e40295b1 *= 1.1
			end

			local v12 = matchCount + __wf_atom_de0ebb40 < mFishDeco.mRequiredLurePreferencesMatchCount and 0
				or __wf_atom_e40295b1

			if not fn5(allFishInfo, v12) then
				continue
			end

			if __wf_atom_a93b9922(position2, position) > 0.010000000000000002 then
				local v13 = Vector()

				if
					not __wf_atom_7e8ad928((gRegion:__wf_atom_3ec9f18c(
						position2,
						position,
						allFishInfo.mInvestigationSweepRadius,
						nil,
						v13,
						true,
						true
					)))
					and module.Distance2DSqr(v13, position) > allFishInfo.mBiteDesiredDistance * allFishInfo.mBiteDesiredDistance
				then
					continue
				end
			end

			__wf_atom_296472bc.mFishTargetingLure = allFishInfo.mFishDeco
			allFishInfo.mTargetLure = mLureDeco
			allFishInfo.mTargetLureOriginalPosition = position
			allFishInfo.mLureUnreachableTimer = 0
			allFishInfo.mLureUntargetDistance = v12 + 1
			mFishDeco:__wf_atom_032e99b2(2)
			allFishInfo.mCachedTargetPosition = allFishInfo.mTargetPosition
		end
	end
end

local function fn7(state, p)
	if __wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(state) or __wf_atom_7e8ad928(state.mFishDeco) then
		return false
	end

	if module.Distance2DSqr(p, v9:GetPosition()) < 100 then
		return false
	end

	local mFishDeco = state.mFishDeco

	if
		module.Distance2DSqr(mFishDeco:GetPosition(), v9:GetPosition()) > 100
		and fn2(mFishDeco:GetPosition(), p, v9:GetPosition(), 10)
	then
		return false
	end

	return true
end

local function fn8(allFishInfo, p, p2)
	if __wf_atom_7e8ad928(allFishInfo) or __wf_atom_7e8ad928(allFishInfo.mFishDeco) then
		return
	end

	local mFishDeco = allFishInfo.mFishDeco
	local position = mFishDeco:GetPosition()
	local __wf_atom_dc309f8a = mFishDeco:__wf_atom_dc309f8a()
	local v12 = allFishInfo.mWaterHeight - position.y

	local function fn9(p3) -- 2 equivalent calls inferred from this helper
		return math.random() ^ p3
	end

	if allFishInfo.mMoveTimer <= 0 or __wf_atom_7e8ad928(allFishInfo.mTargetPosition) then
		if
			module.Distance2DSqr(position, allFishInfo.mSpawnPosition) > 25
			and not allFishInfo.mIsPurified
			and mFishDeco:__wf_atom_43e681f1() ~= 8
		then
			local mSpawnPosition = allFishInfo.mSpawnPosition
			mSpawnPosition.y = allFishInfo.mWaterHeight - allFishInfo.mPreferredDepth
			allFishInfo.mTargetPosition = mSpawnPosition
			allFishInfo.mNextTargetSweepTime = 0
			allFishInfo.mNextTrajectorySweepTime = 0
		else
			for _ = 1, 20 do
				local v13 = p + math.random() * (p2 - p)

				if
					v12 < allFishInfo.mAllowedDepthRange.minValue
					and module.Distance2DSqr(position, v9:GetPosition()) > 100
				then
					v13 = p
				end

				local v14 = Rotation(-180 + math.random() * 360, 0, 0)
				v14.heading -= math.deg((math.sin((math.rad(v14.heading))))) * 0.4
				v14.heading = module4.WrapAngle(__wf_atom_dc309f8a.heading + v14.heading)
				local mTargetPosition = position + __wf_atom_9341614d(Vector(0, 0, v13), v14)

				if
					module.Distance2DSqr(mTargetPosition, allFishInfo.mSpawnPosition) > 25
					and not allFishInfo.mIsPurified
					and mFishDeco:__wf_atom_43e681f1() ~= 8
				then
					mTargetPosition = module2.LineCircleIntersect2D(
						position,
						mTargetPosition,
						allFishInfo.mSpawnPosition,
						5
					)

					if module.Distance2DSqr(mTargetPosition, position) < 0.5 then
						continue
					end
				end

				if not (__wf_atom_7e8ad928(v9) or fn7(allFishInfo, mTargetPosition)) then
					continue
				end

				local v15 = math.random() > 0.5
				local mPreferredDepth = allFishInfo.mPreferredDepth

				if not allFishInfo.mAllowedDepthRange:Contains(allFishInfo.mPreferredDepth) then
					v15 = allFishInfo.mPreferredDepth > allFishInfo.mAllowedDepthRange.maxValue
					mPreferredDepth = module4.Ternary(
						v15,
						allFishInfo.mAllowedDepthRange.maxValue,
						allFishInfo.mAllowedDepthRange.minValue
					)
				end

				local v16

				if v15 then
					local v17 = math.abs(allFishInfo.mAllowedDepthRange.minValue - mPreferredDepth)
					v16 = mPreferredDepth - fn9(2) * v17 -- inferred equivalent call
				else
					local v17 = math.abs(mPreferredDepth - allFishInfo.mAllowedDepthRange.maxValue)
					v16 = mPreferredDepth + fn9(2) * v17 -- inferred equivalent call
				end

				local __wf_atom_421b01aa = allFishInfo.mAllowedDepthRange:__wf_atom_421b01aa(v16)
				mTargetPosition.y = allFishInfo.mWaterHeight - __wf_atom_421b01aa
				allFishInfo.mTargetPosition = mTargetPosition
				allFishInfo.mNextTargetSweepTime = 0
				allFishInfo.mNextTrajectorySweepTime = 0
				break
			end
		end

		if not __wf_atom_7e8ad928(allFishInfo.mTargetPosition) then
			allFishInfo.mMoveTimer = allFishInfo.mMoveDurationRange:__wf_atom_ff1686f2()

			if _T.fishingDebugDrawPathing then
				gRegion:__wf_atom_12f21926(
					allFishInfo.mTargetPosition,
					allFishInfo.mTargetPosition,
					0.2,
					Vector(1, 0, 0),
					Vector(0, 1, 0),
					Color(0, 0, 255),
					5
				)
				gRegion:__wf_atom_628723a6(position, allFishInfo.mTargetPosition, Color(0, 0, 255), 5)
			end
		end
	end
end

local function fn9(allFishInfo)
	if __wf_atom_7e8ad928(allFishInfo) or __wf_atom_7e8ad928(allFishInfo.mFishDeco) then
		return false
	end

	if Time() < allFishInfo.mNextTargetSweepTime then
		return true
	end

	if __wf_atom_7e8ad928(allFishInfo.mTargetPosition) then
		return false
	end

	local mFishDeco = allFishInfo.mFishDeco
	local position = mFishDeco:GetPosition()
	local flag = true

	if __wf_atom_a93b9922(position, allFishInfo.mTargetPosition) > 0.010000000000000002 then
		local ternary = module4.Ternary(
			mFishDeco:__wf_atom_43e681f1() == 2,
			allFishInfo.mInvestigationSweepRadius,
			allFishInfo.mMovementSweepRadius
		)
		local v12 = Vector()

		if not __wf_atom_7e8ad928((gRegion:__wf_atom_3ec9f18c(
			position,
			allFishInfo.mTargetPosition,
			ternary,
			nil,
			v12,
			true,
			true
		))) then
			if _T.fishingDebugDrawPathing then
				gRegion:__wf_atom_8d991675(v12, 0.1, Color(255, 0, 0), 1)
			end

			flag = false
			local v13 = fn(v12, position, allFishInfo.mTargetPosition)
			local v14 = Distance(position, v13)

			if v14 > 3 then
				allFishInfo.mTargetPosition = position + __wf_atom_9341614d(
					Vector(0, 0, v14 - (ternary + 1)),
					__wf_atom_fa8d0177(position, allFishInfo.mTargetPosition)
				)

				if _T.fishingDebugDrawPathing then
					gRegion:__wf_atom_12f21926(
						allFishInfo.mTargetPosition,
						allFishInfo.mTargetPosition,
						0.2,
						Vector(1, 0, 0),
						Vector(0, 1, 0),
						Color(255, 0, 0),
						5
					)
					gRegion:__wf_atom_628723a6(position, allFishInfo.mTargetPosition, Color(255, 0, 0), 5)
				end
			else
				allFishInfo.mTargetPosition = nil
			end

			allFishInfo.mFailedSweepAttempts += 1

			if allFishInfo.mFailedSweepAttempts >= 5 then
				allFishInfo.mStuckStartTime = Time()
				mFishDeco:__wf_atom_032e99b2(9)
			end
		end
	end

	if flag then
		allFishInfo.mFailedSweepAttempts = 0

		if mFishDeco:__wf_atom_43e681f1() ~= 2 then
			allFishInfo.mNextTargetSweepTime = Time() + 0.5
		end
	end

	return flag
end

local function fn10(state)
	if __wf_atom_7e8ad928(state) or __wf_atom_7e8ad928(state.mFishDeco) then
		return false
	end

	if Time() < state.mNextTrajectorySweepTime then
		return true
	end

	local mFishDeco = state.mFishDeco
	local position = state.mFishDeco:GetPosition()
	local __wf_atom_dc309f8a = state.mFishDeco:__wf_atom_dc309f8a()
	local v12 = state.mTargetVelocity * 1
	local v13 = position + __wf_atom_9341614d(Vector(0, 0, v12), __wf_atom_dc309f8a)

	if __wf_atom_a93b9922(position, v13) < 0.00001 then
		return true
	end

	local ternary = module4.Ternary(
		mFishDeco:__wf_atom_43e681f1() == 2,
		state.mInvestigationSweepRadius,
		state.mMovementSweepRadius
	)
	local v14 = Vector()
	local flag

	if __wf_atom_7e8ad928((gRegion:__wf_atom_3ec9f18c(position, v13, ternary, nil, v14, true, true))) then
		flag = true
	else
		flag = false
		local v15 = fn(v14, position, v13)
		state.mVelocity = Distance(position, v15)

		if _T.fishingDebugDrawPathing then
			gRegion:__wf_atom_8d991675(v15, 0.05, Color(255, 0, 0), 1)
		end
	end

	if flag then
		state.mNextTrajectorySweepTime = Time() + 0.2
	end

	return flag
end

local function fn11(state, p, p2, p3)
	if
		__wf_atom_7e8ad928(state)
		or __wf_atom_7e8ad928(state.mFishDeco)
		or __wf_atom_7e8ad928(state.mTargetPosition)
	then
		return
	end

	if _T.fishingDebugForceFishBoost then
		p2 = true
		p = true
	end

	local mFishDeco = state.mFishDeco
	local position = state.mFishDeco:GetPosition()
	local __wf_atom_dc309f8a = state.mFishDeco:__wf_atom_dc309f8a()
	local heading = __wf_atom_dc309f8a.heading
	local pitch = __wf_atom_dc309f8a.pitch

	if Distance(position, state.mTargetPosition) < 0.5 then
		state.mTargetPosition = nil
		return
	end

	local mBoostedMaxTurnRate = p2 and state.mBoostedMaxTurnRate or state.mMaxTurnRate
	local mBoostedTurnAcceleration = p2 and state.mBoostedTurnAcceleration or state.mTurnAcceleration
	local heading2 = __wf_atom_fa8d0177(position, state.mTargetPosition).heading
	local angle = module4.WrapAngle(heading2 - heading)

	if angle == 0 then
		state.mHeadingTurnRate = 0
	else
		if state.mHeadingTurnRate * state.mHeadingTurnRate / (mBoostedTurnAcceleration * 2) >= math.abs(angle) then
			state.mHeadingTurnRate -= mBoostedTurnAcceleration * p3
		else
			state.mHeadingTurnRate += mBoostedTurnAcceleration * p3
		end

		state.mHeadingTurnRate = __wf_atom_421b01aa(state.mHeadingTurnRate, 0, mBoostedMaxTurnRate)
		__wf_atom_dc309f8a.heading = heading + state.mHeadingTurnRate * (angle / math.abs(angle)) * p3
	end

	local mBoostedMaxTurnRate2 = p2 and state.mBoostedMaxTurnRate or state.mMaxTurnRate
	local mBoostedTurnAcceleration2 = p2 and state.mBoostedTurnAcceleration or state.mTurnAcceleration
	local pitch2 = __wf_atom_fa8d0177(position, state.mTargetPosition).pitch
	local angle2 = module4.WrapAngle(pitch2 - pitch)

	if angle2 == 0 then
		state.mPitchTurnRate = 0
	else
		if state.mPitchTurnRate * state.mPitchTurnRate / (mBoostedTurnAcceleration2 * 2) >= math.abs(angle2) then
			state.mPitchTurnRate -= mBoostedTurnAcceleration2 * p3
		else
			state.mPitchTurnRate += mBoostedTurnAcceleration2 * p3
		end

		state.mPitchTurnRate = __wf_atom_421b01aa(state.mPitchTurnRate, 0, mBoostedMaxTurnRate2)
		__wf_atom_dc309f8a.pitch = pitch + state.mPitchTurnRate * (angle2 / math.abs(angle2)) * p3
	end

	local mBoostedMaxVelocity = p and state.mBoostedMaxVelocity or state.mMaxVelocity
	local mBoostedAcceleration = p and state.mBoostedAcceleration or state.mAcceleration
	local v12 = Distance(position, state.mTargetPosition)
	local v13

	if __wf_atom_7e8ad928(state.mTargetLure) then
		v13 = mBoostedMaxVelocity
	else
		v13 = math.sqrt(2 * mBoostedAcceleration * v12)
	end

	state.mTargetVelocity = math.min(mBoostedMaxVelocity, v13)
	local mBoostedMinTurnVelocityMultiplier = p2 and state.mBoostedMinTurnVelocityMultiplier
		or state.mMinTurnVelocityMultiplier
	local v14 = __wf_atom_104bfe98(
		1,
		mBoostedMinTurnVelocityMultiplier,
		__wf_atom_421b01aa(math.abs(angle / 180), 0, 1)
	)
	local v15 = __wf_atom_104bfe98(
		1,
		mBoostedMinTurnVelocityMultiplier,
		__wf_atom_421b01aa(math.abs(angle2 / 180), 0, 1)
	)
	local v16 = 1 * v14 * v15
	state.mTargetVelocity *= v16

	if state.mTargetVelocity then
		local v17 = state.mTargetVelocity - state.mVelocity

		if v17 ~= 0 then
			local v18 = v17 < 0
			state.mVelocity = math.max(0, state.mVelocity + mBoostedAcceleration * p3 * module4.Ternary(v17 > 0, 1, -1))

			if
				v18 and state.mVelocity < state.mTargetVelocity
				or not v18 and state.mVelocity > state.mTargetVelocity
			then
				state.mVelocity = state.mTargetVelocity
			end
		end
	end

	if mFishDeco:__wf_atom_43e681f1() ~= 9 then
		fn10(state)
	end

	local v17 = state.mVelocity * p3

	if v12 <= v17 then
		position = state.mTargetPosition
		state.mVelocity = 0
		state.mTargetVelocity = 0
		state.mTargetPosition = nil
	else
		VectorAdd(position, position, __wf_atom_9341614d(Vector(0, 0, v17), __wf_atom_dc309f8a))
	end

	mFishDeco:Teleport(position, __wf_atom_dc309f8a)
	local v18 = (1 - math.exp(-module4.Ternary(
		mFishDeco:__wf_atom_43e681f1() == 8,
		state.mFleeAnimRate,
		state.mBaseAnimRate
	) * state.mVelocity / 4)) * 4
	local v19 = not (v16 > 0) and 0 or v18 / v16
	mFishDeco:__wf_atom_3564c669((state.mSmoothedAnimRate:__wf_atom_2490589b(v19, p3)))
end

local function fn12(state, _)
	local mFishDeco = state.mFishDeco
	local position = state.mFishDeco:GetPosition()
	local __wf_atom_dc309f8a = state.mFishDeco:__wf_atom_dc309f8a()
	local v12 = __wf_atom_104bfe98(state.mJumpingPower.minValue, state.mJumpingPower.maxValue, math.random()) * math.sqrt(state.mJumpAccelerationMultiplier)
	state.mJumpDuration = 2 * v12 / (9.8 * state.mJumpAccelerationMultiplier)
	local v13 = position + __wf_atom_9341614d(Vector(0, 0, 1), Rotation(__wf_atom_dc309f8a.heading, 0, 0)) * state.mBoostedMaxVelocity * state.mJumpDuration
	local v14 = (state.mWaterHeight - position.y + 0.01) / v12
	local _ = v14 * state.mBoostedMaxVelocity
	state.mJumpVelocity = (v13 - position) / state.mJumpDuration
	state.mJumpTargetVelocity = state.mJumpVelocity + Vector(0, v12, 0)
	state.mJumpAccel = (state.mJumpTargetVelocity - state.mJumpVelocity) / v14
	local v15 = v5.mJumpStartAnim:__wf_atom_8bb4ded3() / v14
	mFishDeco:StopAnimation()
	mFishDeco:__wf_atom_921c1a5f(v5.mJumpStartAnim, false, false, 1, EMPTY_SYMBOL, v15)
end

local function fn13(state, _)
	state.mJumpVelocity = state.mJumpTargetVelocity
	local v12 = v6[__wf_atom_5784a397(1, #v6)]
	local v13 = v12:__wf_atom_8bb4ded3() / state.mJumpDuration
	state.mFishDeco:StopAnimation()
	state.mFishDeco:__wf_atom_921c1a5f(v12, false, false, 1, EMPTY_SYMBOL, v13)
end

local function fn14(state, p)
	local mFishDeco = state.mFishDeco
	local position = state.mFishDeco:GetPosition()
	local __wf_atom_dc309f8a = state.mFishDeco:__wf_atom_dc309f8a()
	state.mJumpVelocity -= Vector(0, 9.8 * state.mJumpAccelerationMultiplier, 0) * p
	mFishDeco:Teleport(position + state.mJumpVelocity * p, __wf_atom_dc309f8a)
end

local function fn15(state, p)
	local mFishDeco = state.mFishDeco
	local position = state.mFishDeco:GetPosition()
	local __wf_atom_dc309f8a = state.mFishDeco:__wf_atom_dc309f8a()
	local mVelocity = Length(state.mJumpVelocity)
	local v12 = state.mJumpVelocity * -mVelocity * 2.5 / (1 + 2.5 * mVelocity * p)

	if mVelocity < 0.5 then
		state.mHasLeftWater = false
		fn3(state, 1)
		state.mVelocity = mVelocity
	else
		state.mJumpVelocity += v12 * p
		mFishDeco:Teleport(position + state.mJumpVelocity * p, __wf_atom_dc309f8a)
	end
end

local function fn16(state) -- 3 equivalent calls inferred from this helper
	if __wf_atom_7e8ad928(state) or __wf_atom_7e8ad928(state.mFishDeco) then
		return false
	end

	return state.mFishDeco:GetPosition().y < state.mWaterHeight
end

local function fn17(state, p) -- 1 equivalent call inferred from this helper
	local mFishDeco = state.mFishDeco
	local position = state.mFishDeco:GetPosition()
	local __wf_atom_dc309f8a = state.mFishDeco:__wf_atom_dc309f8a()
	state.mJumpVelocity += state.mJumpAccel * p
	mFishDeco:Teleport(position + state.mJumpVelocity * p, __wf_atom_dc309f8a)
end

local function fn18(allFishInfo, p)
	if __wf_atom_7e8ad928(allFishInfo) or __wf_atom_7e8ad928(allFishInfo.mFishDeco) then
		return
	end

	if allFishInfo.mHasLeftWater then
		if fn16(allFishInfo) then -- inferred equivalent call
			fn15(allFishInfo, p)
			return
		end

		fn14(allFishInfo, p)

		if fn16(allFishInfo) then -- inferred equivalent call
			OnHitWaterFromJump(allFishInfo)
		end
	elseif __wf_atom_7e8ad928(allFishInfo.mTargetPosition) then
		if fn16(allFishInfo) then -- inferred equivalent call
			fn17(allFishInfo, p) -- inferred equivalent call
		else
			allFishInfo.mHasLeftWater = true
			fn13(allFishInfo, p)
			OnLeaveWaterFromJump(allFishInfo)
		end
	else
		fn11(allFishInfo, true, true, p)

		if __wf_atom_7e8ad928(allFishInfo.mTargetPosition) then
			fn12(allFishInfo, p)
		end
	end
end

local function fn19(p)
	local v12

	if not __wf_atom_7e8ad928(v9) then
		v12 = v9:__wf_atom_296472bc()
	end

	for i, allFishInfo in ipairs(_T.allFishInfos) do
		if __wf_atom_7e8ad928(allFishInfo) or __wf_atom_7e8ad928(allFishInfo.mFishDeco) then
			table.remove(_T.allFishInfos, i)
		else
			local mFishDeco = allFishInfo.mFishDeco
			local position = allFishInfo.mFishDeco:GetPosition()
			local v13 = Vector(position.x, allFishInfo.mWaterHeight, position.z)

			if _T.fishingDebugDrawFishSurfacePosition then
				gRegion:__wf_atom_628723a6(position, v13, Color(0, 255, 255), 0.05)
				gRegion:__wf_atom_b5c21154(v13, 0.5, Color(0, 255, 255), Rotation(0, 90, 0), 0.05)
			end

			if _T.fishingDebugDrawDepth then
				local v14 = Vector(
					position.x,
					allFishInfo.mWaterHeight - allFishInfo.mAllowedDepthRange.minValue,
					position.z
				)
				local v15 = Vector(
					position.x,
					allFishInfo.mWaterHeight - allFishInfo.mAllowedDepthRange.maxValue,
					position.z
				)
				local v16 = Vector(position.x, allFishInfo.mWaterHeight - allFishInfo.mPreferredDepth, position.z)
				gRegion:__wf_atom_b5c21154(v14, 0.3, Color(0, 255, 255), Rotation(0, 90, 0), 0.05)
				gRegion:__wf_atom_b5c21154(v15, 0.3, Color(0, 255, 255), Rotation(0, 90, 0), 0.05)
				gRegion:__wf_atom_8d991675(v16, 0.05, Color(0, 255, 0), 0.05)
				gRegion:__wf_atom_628723a6(v14, v15, Color(0, 255, 255), 0.05)
			end

			if _T.fishingDebugDrawWanderRadius then
				local v14 = Vector(allFishInfo.mSpawnPosition.x, allFishInfo.mWaterHeight, allFishInfo.mSpawnPosition.z)
				gRegion:__wf_atom_b5c21154(v14, 5, Color(0, 255, 255), Rotation(0, 90, 0), 0.05)
			end

			if _T.fishingDebugDrawSpawnPosition then
				gRegion:__wf_atom_12f21926(
					allFishInfo.mSpawnPosition,
					allFishInfo.mSpawnPosition,
					0.08,
					Vector(1, 0, 0),
					Vector(0, 1, 0),
					Color(255, 255, 0),
					0.05
				)
				gRegion:__wf_atom_628723a6(position, allFishInfo.mSpawnPosition, Color(255, 255, 0), 0.05)
			end

			allFishInfo.mLifetime += p
			allFishInfo.mMoveTimer -= p
			allFishInfo.mLureTargetCooldownTimer -= p
			allFishInfo.mFleeTimer -= p
			allFishInfo.mBiteStruggleRotateTimer -= p

			if
				module2.GetStatForPlayerLevel(v9, v2) < allFishInfo.mDepthLayer
				and not _T.fishingDebugShowFishInAllDepthLayers
			then
				mFishDeco:SetVisibility(false, true)
			else
				mFishDeco:SetVisibility(true, true)

				if
					_T.fishingDebugDrawLureInterestDistance
					and not (__wf_atom_7e8ad928(v9) or allFishInfo.mIsPurified)
				then
					local v14 = v10

					if __wf_atom_7e8ad928(v14) then
						v14 = v
						local __wf_atom_a96eb2aa = v9:__wf_atom_a96eb2aa()

						if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
							local __wf_atom_a4299765 = __wf_atom_a96eb2aa:__wf_atom_a4299765()

							if not __wf_atom_7e8ad928(__wf_atom_a4299765.mEquippedLureType) then
								v14 = Type(__wf_atom_a4299765.mEquippedLureType)
							end
						end
					end

					local __wf_atom_e40295b1 = v14:__wf_atom_e40295b1()
					local matchCount = module2.GetMatchCount(v14:__wf_atom_e5aab704(), {
						module2.GetBiomeSymbolFromId(allFishInfo.mBiomeId)
					})
					local __wf_atom_de0ebb40 = mFishDeco:__wf_atom_de0ebb40(v14:__wf_atom_9c97587b())

					if matchCount > 0 then
						__wf_atom_e40295b1 *= 1.2
					end

					if __wf_atom_de0ebb40 > 0 then
						__wf_atom_e40295b1 *= 1.2
					end

					if
						_T.fishingLureInWater
						and _T.fishingIsPerfectCast
						and Time() >= _T.fishingLureImpactTime
						and Time() <= _T.fishingLureImpactTime + 2
					then
						__wf_atom_e40295b1 *= 1.35
					end

					if Time() >= v12.mLureTugTime and Time() <= v12.mLureTugTime + 2 then
						__wf_atom_e40295b1 *= 1.1
					end

					local v15 = matchCount + __wf_atom_de0ebb40 < mFishDeco.mRequiredLurePreferencesMatchCount and 0
						or __wf_atom_e40295b1
					local position2 = v9:CameraControl():__wf_atom_dd7246c7():GetPosition()
					gRegion:__wf_atom_b5c21154(
						position,
						v15,
						Color(0, 255, 0),
						__wf_atom_fa8d0177(position2, position),
						0.05
					)
					gRegion:__wf_atom_5b35a0c8(
						position,
						Color(0, 255, 255),
						"lureInterestDistance: " .. string.format("%.2f", v15),
						1.2,
						0.05
					)
				end

				if mFishDeco:__wf_atom_43e681f1() ~= 0 then
					if mFishDeco:__wf_atom_43e681f1() == 1 then
						fn8(allFishInfo, 3, 8)

						if not __wf_atom_7e8ad928(allFishInfo.mTargetPosition) then
							fn9(allFishInfo)
							fn11(allFishInfo, false, false, p)

							if
								not __wf_atom_7e8ad928(v9)
								and module.Distance2DSqr(mFishDeco:GetPosition(), v9:GetPosition()) < 25
							then
								fn3(allFishInfo, 8)
							end

							allFishInfo.mJumpCooldown -= p

							if allFishInfo.mJumpCooldown <= 0 then
								local flag

								if
									__wf_atom_7e8ad928(allFishInfo)
									or __wf_atom_7e8ad928(allFishInfo.mFishDeco)
									or _T.fishJumpGlobalCooldown > 0
								then
									flag = false
								else
									fn8(allFishInfo, 1, 3)

									if __wf_atom_7e8ad928(allFishInfo.mTargetPosition) then
										flag = false
									else
										allFishInfo.mTargetPosition.y = allFishInfo.mWaterHeight - 0.5
										flag = true
									end
								end

								if flag then
									mFishDeco:__wf_atom_032e99b2(10)
									_T.numFishJumps += 1

									if _T.numFishJumps > 5 then
										_T.fishJumpGlobalCooldown = __wf_atom_104bfe98(v3.minValue, v3.minValue, math.random())
										_T.numFishJumps = 0
									end
								else
									allFishInfo.mJumpCooldown = __wf_atom_104bfe98(
										allFishInfo.mJumpCooldownRange.minValue,
										allFishInfo.mJumpCooldownRange.maxValue,
										math.random()
									)
								end
							end
						end
					elseif mFishDeco:__wf_atom_43e681f1() == 2 then
						if __wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(allFishInfo.mTargetLure) then
							fn3(allFishInfo, 1)
						else
							local position2 = allFishInfo.mTargetLure:GetPosition()

							if _T.fishingLureInWater then
								if fn5(allFishInfo, allFishInfo.mLureUntargetDistance) then
									if module.Distance2DSqr(position2, allFishInfo.mTargetLureOriginalPosition) > 25 then
										fn3(allFishInfo, 1)
									elseif
										__wf_atom_7e8ad928(v12.mFishTargetingLure)
										or v12.mFishTargetingLure == mFishDeco
									then
										if Distance(position, allFishInfo.mTargetLure:GetPosition()) <= allFishInfo.mBiteDesiredDistance then
											mFishDeco:__wf_atom_032e99b2(0)
											_T.FishBiteStartVelocity = allFishInfo.mVelocity
										else
											local distance2DSqr = module.Distance2DSqr(position, position2)
											local v14

											if allFishInfo.mBiteDesiredDistance == 4 then
												v14 = 0.5
											else
												local v15 = __wf_atom_421b01aa(
													(distance2DSqr - allFishInfo.mBiteDesiredDistance) / (4 - allFishInfo.mBiteDesiredDistance),
													0,
													1
												)
												v14 = __wf_atom_104bfe98(0, 0.5, __wf_atom_24a82b69(v15))
											end

											allFishInfo.mTargetPosition = position2 - Vector(0, v14, 0)

											if fn9(allFishInfo) then
												allFishInfo.mLureUnreachableTimer = 0
											elseif
												__wf_atom_7e8ad928(allFishInfo.mTargetPosition)
												or not (__wf_atom_a93b9922(allFishInfo.mTargetPosition, position2) <= allFishInfo.mBiteDesiredDistance * allFishInfo.mBiteDesiredDistance)
											then
												allFishInfo.mLureUnreachableTimer += p

												if allFishInfo.mLureUnreachableTimer >= allFishInfo.mLureUnreachableDuration then
													fn3(allFishInfo, 1)
													continue
												end
											else
												allFishInfo.mLureUnreachableTimer = 0
											end

											fn11(allFishInfo, true, true, p)
											allFishInfo.mBiteDesiredDistance = allFishInfo.mVelocity * v8
										end
									else
										fn3(allFishInfo, 1)

										if not __wf_atom_7e8ad928(allFishInfo.mCachedTargetPosition) then
											allFishInfo.mTargetPosition = allFishInfo.mCachedTargetPosition
											allFishInfo.mCachedTargetPosition = nil
										end
									end
								else
									fn3(allFishInfo, 1)
								end
							else
								fn3(allFishInfo, 8)
							end
						end
					elseif mFishDeco:__wf_atom_43e681f1() == 3 or mFishDeco:__wf_atom_43e681f1() == 4 then
						if
							__wf_atom_7e8ad928(allFishInfo.mTargetLure)
							or __wf_atom_7e8ad928(v9)
							or v12.mFishTargetingLure ~= mFishDeco
						then
							fn3(allFishInfo, 8)
						end
					elseif mFishDeco:__wf_atom_43e681f1() == 5 then
						if __wf_atom_7e8ad928(allFishInfo.mTargetLure) or __wf_atom_7e8ad928(v9) then
							fn3(allFishInfo, 8)
						elseif __wf_atom_7e8ad928(v12.mFishOnHook) then
							fn3(allFishInfo, 8)
						end
					elseif mFishDeco:__wf_atom_43e681f1() == 7 then
						allFishInfo.mFleeTimer = allFishInfo.mFleeDurationRange:__wf_atom_ff1686f2()
						allFishInfo.mTargetPosition = mFishDeco:GetPosition() + __wf_atom_9341614d(
							Vector(0, 0, 5),
							mFishDeco:__wf_atom_dc309f8a()
						)
						allFishInfo.mTargetPosition.y = math.min(
							allFishInfo.mTargetPosition.y,
							allFishInfo.mWaterHeight - 0.5
						)
						allFishInfo.mMoveTimer = 3
						allFishInfo.mBoostedMaxVelocity = 2
						allFishInfo.mVelocity = allFishInfo.mBoostedMaxVelocity
						mFishDeco:__wf_atom_032e99b2(8)
					elseif mFishDeco:__wf_atom_43e681f1() == 8 then
						if allFishInfo.mFleeTimer <= 0 then
							mFishDeco:__wf_atom_032e99b2(1)
						end

						fn8(allFishInfo, 3, 8)

						if not __wf_atom_7e8ad928(allFishInfo.mTargetPosition) then
							fn9(allFishInfo)
							fn11(allFishInfo, true, true, p)
						end
					elseif mFishDeco:__wf_atom_43e681f1() == 9 then
						if
							not __wf_atom_7e8ad928(allFishInfo.mStuckStartTime)
							and Time() > allFishInfo.mStuckStartTime + 5
						then
							mFishDeco:__wf_atom_032e99b2(1)
						end

						allFishInfo.mTargetPosition = allFishInfo.mSpawnPosition

						if __wf_atom_a93b9922(position, allFishInfo.mTargetPosition) < 0.25 then
							mFishDeco:__wf_atom_032e99b2(1)
						end

						fn11(allFishInfo, false, true, p)
					elseif mFishDeco:__wf_atom_43e681f1() == 10 then
						fn18(allFishInfo, p)
					end
				end
			end
		end
	end
end

local function fn20(fishingPlayer)
	if __wf_atom_7e8ad928(fishingPlayer.avatar) then
		return
	end

	for _, v12 in ipairs(fishingCins) do
		local entity = gRegion:CreateEntity(
			v12,
			fishingPlayer.avatar:__wf_atom_a2a18137(),
			fishingPlayer.avatar:__wf_atom_2f2bada0(),
			v9,
			v9,
			1
		)
		entity:SetInstigatorAvatar(fishingPlayer.avatar)
		entity:__wf_atom_a3d2b66b(fishingPlayer.avatar, Symbol("Envoy"))
		table.insert(fishingPlayer.cins, entity)
	end
end

local function fn21(fishingPlayer)
	for i = #fishingPlayer.cins, 1, -1 do
		gRegion:__wf_atom_dd1e4d10(fishingPlayer.cins[i])
		table.remove(fishingPlayer.cins, i)
	end
end

function UpdateClientFishingStatus(_)
	if not gRegion:IsMaster() then
		return
	end

	while __wf_atom_7e8ad928(_T.fishControlInstance) do
		Sleep(0)
	end

	local __wf_atom_e919fb8e = _T.fishControlInstance:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.fishingPlayers) then
		__wf_atom_e919fb8e.fishingPlayers = {}
	end

	fishingCins = _T.fishControlInstance:__wf_atom_e919fb8e().cins

	while not __wf_atom_7e8ad928(_T.fishControlInstance) do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, avatar in ipairs(__wf_atom_ef7900cf) do
			if avatar == v9 then
				continue
			end

			local v12 = false

			for i = #__wf_atom_e919fb8e.fishingPlayers, 1, -1 do
				local fishingPlayer = __wf_atom_e919fb8e.fishingPlayers[i]

				if __wf_atom_7e8ad928(fishingPlayer.avatar) then
					fn21(fishingPlayer)
					table.remove(__wf_atom_e919fb8e.fishingPlayers, i)
				elseif fishingPlayer.avatar == avatar then
					if fishingPlayer.fishing ~= avatar:__wf_atom_2b992e2b() then
						if avatar:__wf_atom_2b992e2b() then
							fn20(fishingPlayer)
						else
							fn21(fishingPlayer)
						end
					end

					fishingPlayer.fishing = avatar:__wf_atom_2b992e2b()
					v12 = true
				end
			end

			if not v12 then
				table.insert(__wf_atom_e919fb8e.fishingPlayers, {
					avatar = avatar,
					fishing = false,
					cins = {}
				})
			end
		end

		Sleep(0)
	end
end

function UpdateFishControl(fishControlInstance)
	while __wf_atom_7e8ad928(gClient) or not gClient:__wf_atom_328bcb8f() do
		Sleep(0.2)
	end

	if __wf_atom_7e8ad928(fishControlInstance) or not __wf_atom_7e8ad928(_T.fishControlInstance) then
		return
	end

	_T.fishControlInstance = fishControlInstance

	if __wf_atom_7e8ad928(_T.allFishInfos) then
		_T.allFishInfos = {}
	end

	_T.numFishJumps = 0
	_T.fishJumpGlobalCooldown = 0
	local __wf_atom_8bb4ded3 = v5.mBiteAnim:__wf_atom_8bb4ded3()
	local __wf_atom_0dcd7684 = v5.mBiteAnim:__wf_atom_0dcd7684()
	local __wf_atom_43e3d184 = v5.mBiteAnim:__wf_atom_43e3d184()
	v7 = 1

	for i, v12 in ipairs(__wf_atom_0dcd7684) do
		if v12 ~= Symbol("Chomp") then
			continue
		end

		v7 = __wf_atom_43e3d184[i]
		break
	end

	v8 = v7 * __wf_atom_8bb4ded3
	local __wf_atom_e919fb8e = _T.fishControlInstance:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.cins = fishingCins
	fishControlInstance:__wf_atom_8a035cd5(Symbol("UpdateClientFishingStatus"), false)
	print("Fish control initialized")

	while not __wf_atom_7e8ad928(fishControlInstance) do
		if __wf_atom_7e8ad928(_T.fishControlInstance) then
			fishControlInstance:__wf_atom_8a035cd5(Symbol("UpdateFishControl"), false)
			local __wf_atom_e919fb8e_2 = fishControlInstance:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e_2.cins = fishingCins
			fishControlInstance:__wf_atom_8a035cd5(Symbol("UpdateClientFishingStatus"), false)
			break
		else
			local v12 = __wf_atom_084b3e93()
			v9 = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(v9) then
				local __wf_atom_296472bc = v9:__wf_atom_296472bc()
				v10 = Type(__wf_atom_296472bc.mLureItem)
			end

			if _T.FishingDebugDespawnHotspotFish then
				DespawnAllFishFromOwner(_T.FishingDebugDespawnHotspotFish)
				_T.FishingDebugDespawnHotspotFish = nil
			end

			if _T.fishJumpGlobalCooldown > 0 then
				_T.fishJumpGlobalCooldown -= v12
			end

			fn6(v12)
			fn19(v12)
			UpdateDebugDraw()
			Sleep(0)
		end
	end
end

local function fn22(object, list)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v12 = 0

	for _, v13 in ipairs(list) do
		if __wf_atom_7e8ad928(v13) then
			continue
		end

		local __wf_atom_0eef876f = object:__wf_atom_0eef876f(v13)

		if v12 < __wf_atom_0eef876f then
			v12 = __wf_atom_0eef876f
		end
	end

	return v12
end

local function fn23(object, p)
	if __wf_atom_7e8ad928(object) then
		return 0
	end

	return p * object:__wf_atom_d4d62afe(gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()) * object:__wf_atom_3cfa1122(
		module3.IsOvercast(),
		module3.IsWindy(),
		module3.IsRaining(),
		module3.IsLightning()
	)
end

local function fn24(p)
	local v12 = {}
	local total = 0

	for _, fishType in ipairs(mFishTypes) do
		if __wf_atom_7e8ad928(fishType) then
			continue
		end

		local v13 = fn22(fishType, p)

		if v13 == 0 then
			continue
		end

		local spawnWeight = fn23(fishType, v13)

		if _T.fishingDebugSpawnCommons or _T.fishingDebugSpawnUncommons or _T.fishingDebugSpawnRares then
			local isA = fishType:IsA(rareFishType)
			local isA2 = fishType:IsA(uncommonFishType)
			local v14 = _T.fishingDebugSpawnCommons and not (isA or isA2) and true or false
			local v15 = _T.fishingDebugSpawnUncommons and isA2 and true or v14

			if not (_T.fishingDebugSpawnRares and isA or v15) then
				continue
			end
		end

		table.insert(v12, { fishType = fishType, spawnWeight = spawnWeight })
		total += spawnWeight
	end

	local v13 = math.random() * total

	for _, v14 in ipairs(v12) do
		if __wf_atom_7e8ad928(v14) then
			continue
		end

		if v13 <= v14.spawnWeight then
			return v14.fishType
		else
			v13 -= v14.spawnWeight
		end
	end

	return nil
end

local function fn25(p, p2)
	if __wf_atom_7e8ad928(p) or p == __wf_atom_28d5d4aa then
		return nil
	end

	local v12 = p + Vector(0, 5, 0)
	local v13 = p + Vector(0, -20, 0)
	local v14 = Vector()

	if __wf_atom_7e8ad928((gRegion:__wf_atom_3ec9f18c(v12, v13, 0.5, nil, v14, true, true))) then
		if _T.fishingDebugDrawSpawning then
			gRegion:__wf_atom_c189a462(v12, v13, Color(10, 0, 0), 5)
		end

		return nil
	elseif v14.y > p.y then
		if _T.fishingDebugDrawSpawning then
			gRegion:__wf_atom_c189a462(v12, v13, Color(100, 0, 0), 5)
		end

		return nil
	else
		local v15 = p.y - v14.y
		local v16 = math.max(p2.minValue, 0.5)
		local v17 = math.min(p2.maxValue, v15 - 1)

		if v17 <= v16 then
			if _T.fishingDebugDrawSpawning then
				gRegion:__wf_atom_c189a462(v12, v13, Color(255, 0, 0), 5)
			end

			return nil
		else
			if _T.fishingDebugDrawSpawning then
				gRegion:__wf_atom_c189a462(v12, v13, Color(0, 255, 0), 5)
			end

			local v18 = v16 + math.random() * (v17 - v16)
			return p - Vector(0, v18, 0)
		end
	end
end

local function fn26(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local v12 = Vector(0, 0, math.sqrt((math.random())) * object:__wf_atom_4e28532a())
	local v13 = Rotation(math.random() * 360, 0, 0)
	return object:GetPosition() + __wf_atom_9341614d(v12, v13)
end

function DespawnFishInfo(p, p2)
	if __wf_atom_7e8ad928(p) then
		return
	end

	if not __wf_atom_7e8ad928(p.mOwnerInfo) then
		for i, _ in ipairs(p.mOwnerInfo.mFishInfos) do
			if p ~= p.mOwnerInfo.mFishInfos[i] then
				continue
			end

			table.remove(p.mOwnerInfo.mFishInfos, i)
			break
		end
	end

	if __wf_atom_7e8ad928(p2) then
		for i, _ in ipairs(_T.allFishInfos) do
			if p ~= _T.allFishInfos[i] then
				continue
			end

			p2 = i
			break
		end
	end

	if not __wf_atom_7e8ad928(p2) then
		table.remove(_T.allFishInfos, p2)
	end

	for i, _ in ipairs(_T.purifiedFishInfos) do
		if p ~= _T.purifiedFishInfos[i] then
			continue
		end

		table.remove(_T.purifiedFishInfos, i)
		break
	end

	p.mFishDeco:__wf_atom_8a035cd5(Symbol("DissolveOut"), false)
end

function DespawnFishDeco(p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local fishInfoForDeco = module2.GetFishInfoForDeco(p)
	DespawnFishInfo(fishInfoForDeco)
end

function DespawnAllFishFromOwner(p)
	if __wf_atom_7e8ad928(p) or #p.mFishInfos == 0 then
		return
	end

	for _, mFishInfo in ipairs(p.mFishInfos) do
		if __wf_atom_7e8ad928(mFishInfo) or __wf_atom_7e8ad928(mFishInfo.mFishDeco) then
			continue
		end

		for i, _ in ipairs(_T.allFishInfos) do
			if mFishInfo ~= _T.allFishInfos[i] then
				continue
			end

			table.remove(_T.allFishInfos, i)
			break
		end

		mFishInfo.mFishDeco:__wf_atom_8a035cd5(Symbol("DissolveOut"), false)
	end

	p.mFishInfos = {}
	p.mPurifiedFishCount = 0
end

local function fn27(allFishInfo)
	if __wf_atom_7e8ad928(allFishInfo) or __wf_atom_7e8ad928(allFishInfo.mFishDeco) then
		return false
	end

	local mFishDeco = allFishInfo.mFishDeco

	if mFishDeco:__wf_atom_43e681f1() ~= 1 or __wf_atom_7e8ad928(v9) then
		return false
	end

	if module.Distance2DSqr(mFishDeco:GetPosition(), v9:GetPosition()) > 625 then
		return true
	end

	local v12 = __wf_atom_fa8d0177(v9:GetPosition(), mFishDeco:GetPosition())
	return math.abs((module4.WrapAngle(v9:__wf_atom_4e50d390().heading - v12.heading))) > 90
end

local function fn28()
	local v12 = nil
	local v13 = 0

	if __wf_atom_7e8ad928(v9) then
		if #_T.purifiedFishInfos > 0 then
			v12 = _T.purifiedFishInfos[1]
		end
	else
		for _, purifiedFishInfo in ipairs(_T.purifiedFishInfos) do
			if __wf_atom_7e8ad928(purifiedFishInfo) or __wf_atom_7e8ad928(purifiedFishInfo.mFishDeco) then
				continue
			end

			local distance2DSqr = module.Distance2DSqr(purifiedFishInfo.mFishDeco:GetPosition(), v9:GetPosition())

			if v13 < distance2DSqr then
				v13 = distance2DSqr
			end
		end
	end

	if not __wf_atom_7e8ad928(v12) then
		DespawnFishInfo(v12)
	end
end

local function fn29()
	for i = #_T.allFishInfos, 1, -1 do
		local allFishInfo = _T.allFishInfos[i]

		if __wf_atom_7e8ad928(allFishInfo) or __wf_atom_7e8ad928(allFishInfo.mFishDeco) then
			table.remove(_T.allFishInfos, i)
		else
			local mFishDeco = allFishInfo.mFishDeco

			if
				mFishDeco:__wf_atom_43e681f1() == 1
				and not allFishInfo.mIsPurified
				and allFishInfo.mLifetime > allFishInfo.mMaxLifetime
				and fn27(allFishInfo)
			then
				DespawnFishInfo(allFishInfo, i)
			elseif
				not __wf_atom_7e8ad928(v9)
				and module.Distance2DSqr(mFishDeco:GetPosition(), v9:GetPosition()) > 2500
			then
				DespawnFishInfo(allFishInfo, i)
			end
		end
	end
end

local function fn30(mWaterVolume)
	local convertToWaterVolumeLocalPosition = module2.ConvertToWaterVolumeLocalPosition(mWaterVolume, v9:GetPosition())
	local v12 = Vector(-mWaterVolume:__wf_atom_80cf57aa().x / 2, 0, -mWaterVolume:__wf_atom_80cf57aa().z / 2)
	local v13 = Vector(mWaterVolume:__wf_atom_80cf57aa().x / 2, 0, mWaterVolume:__wf_atom_80cf57aa().z / 2)
	local v14 = Vector(convertToWaterVolumeLocalPosition.x - 30, 0, convertToWaterVolumeLocalPosition.z - 30)
	local v15 = Vector(convertToWaterVolumeLocalPosition.x + 30, 0, convertToWaterVolumeLocalPosition.z + 30)
	local v16 = Vector(math.max(v12.x, v14.x), 0, (math.max(v12.z, v14.z)))
	local v17 = Vector(math.min(v13.x, v15.x), 0, (math.min(v13.z, v15.z)))

	if v16.x > v17.x or v16.z > v17.z then
		return nil, nil
	end

	return v16, v17
end

local function fn31()
	if __wf_atom_7e8ad928(fishManifest) or __wf_atom_7e8ad928(v9) then
		return nil
	end

	local position = v9:GetPosition()
	local count = 0

	for _, allFishInfo in ipairs(_T.allFishInfos) do
		if __wf_atom_7e8ad928(allFishInfo) or __wf_atom_7e8ad928(allFishInfo.mFishDeco) then
			continue
		end

		local mFishDeco = allFishInfo.mFishDeco

		if module.Distance2DSqr(mFishDeco:GetPosition(), position) <= 900 then
			count += 1
		end
	end

	if count >= 10 then
		return true
	end

	local mLastSpawnAttemptTime = Time()
	local v12 = 1
	local v13 = nil
	local v14 = 0

	local function fn32(p) -- 1 equivalent call inferred from this helper
		return p * (2 - p)
	end

	for _, fishingWaterVolumeInfo in ipairs(_T.FishingWaterVolumeInfos) do
		if __wf_atom_7e8ad928(fishingWaterVolumeInfo) or __wf_atom_7e8ad928(fishingWaterVolumeInfo.mWaterVolume) then
			continue
		end

		local mWaterVolume = fishingWaterVolumeInfo.mWaterVolume

		if mWaterVolume:__wf_atom_505c4d76() or module2.WaterVolumeDistanceToPosition(mWaterVolume, position) > 30 then
			continue
		end

		local mLocalSpawnBoundsMin, mLocalSpawnBoundsMax = fn30(mWaterVolume)
		fishingWaterVolumeInfo.mLocalSpawnBoundsMin = mLocalSpawnBoundsMin
		fishingWaterVolumeInfo.mLocalSpawnBoundsMax = mLocalSpawnBoundsMax

		if
			__wf_atom_7e8ad928(fishingWaterVolumeInfo.mLocalSpawnBoundsMin)
			or #fishingWaterVolumeInfo.mFishInfos - fishingWaterVolumeInfo.mPurifiedFishCount >= fishingWaterVolumeInfo.mRemainingFishCount
			or mLastSpawnAttemptTime < fishingWaterVolumeInfo.mSpawnDisableUntilTime
		then
			continue
		end

		local v15 = (fishingWaterVolumeInfo.mLocalSpawnBoundsMax.x - fishingWaterVolumeInfo.mLocalSpawnBoundsMin.x) * (fishingWaterVolumeInfo.mLocalSpawnBoundsMax.z - fishingWaterVolumeInfo.mLocalSpawnBoundsMin.z) * 3.141592653589793 / 4
		local v16 = fishingWaterVolumeInfo.mRemainingFishCount / fishingWaterVolumeInfo.mMaxFishCount
		local v17 = v15 * (fishingWaterVolumeInfo.mFishDensity * fn32(v16)) -- inferred equivalent call
		local v18 = __wf_atom_421b01aa(v17, 1, (math.min(10, fishingWaterVolumeInfo.mRemainingFishCount)))
		local count2 = 0

		for _, mFishInfo in ipairs(fishingWaterVolumeInfo.mFishInfos) do
			if __wf_atom_7e8ad928(mFishInfo) or __wf_atom_7e8ad928(mFishInfo.mFishDeco) then
				continue
			end

			if not (module.Distance2DSqr(mFishInfo.mFishDeco:GetPosition(), position) <= 900) then
				continue
			end

			count2 += 1
		end

		local v19 = count2 / v18

		if v19 < v12 then
			v14 = v18 - count2
			v13 = fishingWaterVolumeInfo
			v12 = v19
		elseif v19 == v12 and v19 < 1 and fishingWaterVolumeInfo.mLastSpawnAttemptTime < v13.mLastSpawnAttemptTime then
			v14 = v18 - count2
			v13 = fishingWaterVolumeInfo
		end
	end

	if __wf_atom_7e8ad928(v13) then
		return true
	end

	v13.mLastSpawnAttemptTime = mLastSpawnAttemptTime
	local v15 = math.min(math.random(1, 5), v14)
	local count2 = 0
	local v16 = nil

	while v15 > 0 or count2 > 20 do
		if __wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v13) or __wf_atom_7e8ad928(v13.mWaterVolume) then
			return false
		end

		count2 += 1

		local function fn33()
			local v17 = v13.mLocalSpawnBoundsMax.x - v13.mLocalSpawnBoundsMin.x
			local v18 = v13.mLocalSpawnBoundsMax.z - v13.mLocalSpawnBoundsMin.z
			local v19 = v13.mLocalSpawnBoundsMin + Vector(math.random() * v17, 0, math.random() * v18)
			local convertToWorldSpace = module2.ConvertToWorldSpace(v13.mWaterVolume, v19)
			convertToWorldSpace.y = v13.mWaterHeight
			return convertToWorldSpace
		end

		local function fn34(p, p2)
			local v17 = Vector(0, 0, math.sqrt((math.random())) * p2)
			local v18 = Rotation(math.random() * 360, 0, 0)
			return p + __wf_atom_9341614d(v17, v18)
		end

		local function fn35(p)
			if __wf_atom_7e8ad928(p) then
				return nil
			end

			local distance2DSqr = module.Distance2DSqr(p, position)

			if
				distance2DSqr < 100
				or distance2DSqr > 900
				or not module2.IsPointInWaterVolume2D(v13.mWaterVolume, p)
			then
				return nil
			end

			local v17 = __wf_atom_7e8ad928(v16) and 64 or 0.25
			local v18 = true

			for _, mFishInfo in ipairs(v13.mFishInfos) do
				if __wf_atom_7e8ad928(mFishInfo) or __wf_atom_7e8ad928(mFishInfo.mFishDeco) then
					continue
				end

				if not (module.Distance2DSqr(p, mFishInfo.mFishDeco:GetPosition()) < v17) then
					continue
				end

				v18 = false
				break
			end

			if not v18 then
				return nil
			end

			local v19 = p + Vector(0, 5, 0)
			local v20 = p + Vector(0, -20, 0)
			local v21 = Vector()

			if __wf_atom_7e8ad928((gRegion:__wf_atom_3ec9f18c(v19, v20, 0.5, nil, v21, true, true))) or v21.y > p.y then
				return nil
			end

			local biomeId = module.GetBiomeIdFromDensityVolume(p)
			local v22 = fn24({ (module2.GetBiomeSymbolFromId(biomeId)) })

			if __wf_atom_7e8ad928(v22) then
				return nil
			end

			local v23 = p.y - v21.y
			local v24 = math.max(v22.mAllowedDepthRange.minValue, 0.5)
			local v25 = math.min(v22.mAllowedDepthRange.maxValue, v23 - 1)

			if v25 <= v24 then
				return nil
			end

			local v26 = v24 + math.random() * (v25 - v24)
			return v22, p - Vector(0, v26, 0)
		end

		local v17

		if __wf_atom_7e8ad928(v16) then
			v17 = fn33()
		else
			v17 = fn34(v16, 8)
		end

		local v18, v19 = fn35(v17)

		if __wf_atom_7e8ad928(v18) then
			v13.mConsecutiveFailedSpawnAttempts += 1

			if v13.mConsecutiveFailedSpawnAttempts >= 20 then
				v13.mConsecutiveFailedSpawnAttempts = 0
				v13.mSpawnDisableUntilTime = Time() + 4
			end

			if _T.fishingDebugDrawSpawning and not __wf_atom_7e8ad928(v19) then
				gRegion:__wf_atom_c189a462(v19 + Vector(0, 5, 0), v19 + Vector(0, -20, 0), Color(255, 0, 0), 5)
			end

			return false
		else
			if _T.fishingDebugDrawSpawning then
				gRegion:__wf_atom_c189a462(v19 + Vector(0, 5, 0), v19 + Vector(0, -20, 0), Color(0, 255, 0), 5)
			end

			if __wf_atom_7e8ad928(v16) then
				v16 = Vector(v19.x, v13.mWaterHeight, v19.z)
			end

			local v20 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			local fish = module2.SpawnFish(Type(v18), v19, v20, v13, v13.mWaterVolume)

			if not (__wf_atom_7e8ad928(fish) or __wf_atom_7e8ad928(fish.mFishDeco)) then
				if _T.fishingDebugDrawSpawning then
					gRegion:__wf_atom_8d991675(v19, 0.2, Color(0, 255, 255), 5)
				end

				table.insert(v13.mFishInfos, fish)
				table.insert(_T.allFishInfos, fish)
				v13.mConsecutiveFailedSpawnAttempts = 0
				v15 -= 1
			end

			Sleep(0.1)
		end
	end

	return false
end

local function fn32()
	mFishTypes = {}

	if __wf_atom_7e8ad928(fishManifest) then
		return
	end

	for _, mFishType in ipairs(fishManifest.mFishTypes) do
		if not module4.IsValueInTable(mFishTypes, mFishType) then
			table.insert(mFishTypes, mFishType)
		end
	end
end

local function fn33()
	_T.FishingWaterVolumeInfos = {}

	for _, v12 in gRegion:__wf_atom_3bc831e3() do
		module2.AddFishingWaterVolumeInfo(v12)
	end
end

function UpdateFishSpawner(fishSpawnerInstance)
	while __wf_atom_7e8ad928(gClient) or not gClient:__wf_atom_328bcb8f() do
		Sleep(0.2)
	end

	if __wf_atom_7e8ad928(fishSpawnerInstance) or not __wf_atom_7e8ad928(_T.fishSpawnerInstance) then
		return
	end

	_T.fishSpawnerInstance = fishSpawnerInstance
	_T.allFishInfos = {}
	_T.purifiedFishInfos = {}
	_T.purifiedFishCount = 0
	_T.FishClusters = {}
	fn32()
	fn33()
	print("Fish spawner initialized, water volume count: " .. #_T.FishingWaterVolumeInfos)

	while not __wf_atom_7e8ad928(fishSpawnerInstance) do
		if __wf_atom_7e8ad928(_T.fishSpawnerInstance) then
			fishSpawnerInstance:__wf_atom_8a035cd5(Symbol("UpdateFishSpawner"), false)
			break
		end

		v9 = gRegion:__wf_atom_c4f78a8f()

		if _T.purifiedFishCount > 4 then
			fn28()
		end

		fn29()
		local v12 = fn31()

		if __wf_atom_7e8ad928(v12) then
			Sleep(2)
		elseif v12 then
			Sleep(2)
		else
			Sleep(0)
		end
	end
end

function SampleFishGeneration()
	local v12 = {}
	local v13 = {}

	for i = 1, 100 do
		for _ = 1, 100 do
			local v14 = fn24({ v4 })

			if __wf_atom_7e8ad928(v14) then
				continue
			end

			local v15 = 0

			for j = 1, #v12 do
				if v14 == v12[j] then
					v15 = j
				end
			end

			if v15 == 0 then
				table.insert(v12, v14)
				table.insert(v13, 0)
				v15 = #v12
			end

			v13[v15] += 1
		end

		print("Fish spawn sampling: " .. i .. "%")
		Sleep(0)
	end

	local v14 = "Fish spawn samples: "

	for i = 1, #v12 do
		v14 ..= "(" .. v12[i]:GetName() .. " " .. v13[i] .. ") "
	end

	print(v14)
	local total = 0
	local total2 = 0
	local total3 = 0

	for i = 1, #v12 do
		if v12[i]:IsA(Type("/SF/Types/Gameplay/Fishing/Fish/SoulFishCommonDecoration")) then
			total += v13[i]
		elseif v12[i]:IsA(Type("/SF/Types/Gameplay/Fishing/Fish/SoulFishUncommonDecoration")) then
			total2 += v13[i]
		elseif v12[i]:IsA(Type("/SF/Types/Gameplay/Fishing/Fish/SoulFishRareDecoration")) then
			total3 += v13[i]
		end
	end

	local v15 = "Fish samples by rarity: Common:" .. total .. ", Uncommon: " .. total2 .. ", Rare: " .. total3
	print(v15)
	local v16 = "Fish sample distribution: Common:" .. total / 10000 .. ", Uncommon: " .. total2 / 10000 .. ", Rare: " .. total3 / 10000
	print(v16)
end

function RunScriptTrigger(object)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	object:FirePort("Execute")
end

function InitializeFishingHotspot(p)
	while __wf_atom_7e8ad928(gClient) or not gClient:__wf_atom_328bcb8f() do
		Sleep(0.2)
	end

	if __wf_atom_7e8ad928(p) then
		return
	end

	if not module2.AddFishingHotspot(p) then
		print("Failed to add fishing hotspot, destroying hotspot")
		gRegion:__wf_atom_dd1e4d10(p)
	end
end

function UpdateDebugDraw()
	if _T.fishingDebugText then
		for _, allFishInfo in ipairs(_T.allFishInfos) do
			if __wf_atom_7e8ad928(allFishInfo) or __wf_atom_7e8ad928(allFishInfo.mFishDeco) then
				continue
			end

			local mFishDeco = allFishInfo.mFishDeco
			local v12 = ""

			if _T.fishingDebugTextTypeName then
				v12 ..= mFishDeco:__wf_atom_5b41f63b() .. "\n"
			end

			if _T.fishingDebugTextState then
				v12 ..= "State: " .. v11[mFishDeco:__wf_atom_43e681f1() + 1] .. "\n"
			end

			if _T.fishingDebugTextDepthLayer then
				v12 ..= "Depth layer: " .. allFishInfo.mDepthLayer .. "\n"
			end

			if _T.fishingDebugTextSizeAndCorruption then
				v12 ..= "Size: " .. string.format("%.3f", mFishDeco.mSize) .. ", corruption level: " .. mFishDeco.mCorruptionLevel .. "\n"
			end

			if _T.fishingDebugTextDepth then
				local v13 = allFishInfo.mWaterHeight - mFishDeco:GetPosition().y
				v12 ..= "Current depth: " .. string.format("%.2f", v13) .. "\n"
			end

			if _T.fishingDebugTextVelocity then
				v12 ..= "Target velocity: " .. string.format("%.2f", allFishInfo.mTargetVelocity) .. ", Actual velocity: " .. string.format("%.2f", allFishInfo.mVelocity) .. "\n"
			end

			if _T.fishingDebugTextAnimRate then
				local __wf_atom_bf1c8253 = mFishDeco:__wf_atom_bf1c8253()
				v12 ..= "Anim rate: " .. string.format("%.2f", __wf_atom_bf1c8253) .. "\n"
			end

			gRegion:__wf_atom_5b35a0c8(
				mFishDeco:GetPosition(),
				Color(0, 255, 255),
				v12,
				_T.fishingDebugTextSize or 1,
				0.05
			)
		end
	end

	if _T.fishingDebugDrawPathing then
		for _, allFishInfo in ipairs(_T.allFishInfos) do
			if
				__wf_atom_7e8ad928(allFishInfo)
				or __wf_atom_7e8ad928(allFishInfo.mFishDeco)
				or __wf_atom_7e8ad928(allFishInfo.mTargetPosition)
			then
				continue
			end

			gRegion:__wf_atom_12f21926(
				allFishInfo.mTargetPosition,
				allFishInfo.mTargetPosition,
				0.1,
				Vector(1, 0, 0),
				Vector(0, 1, 0),
				Color(0, 255, 0),
				0.1
			)
			gRegion:__wf_atom_628723a6(
				allFishInfo.mFishDeco:GetPosition(),
				allFishInfo.mTargetPosition,
				Color(0, 255, 0),
				0.1
			)
		end
	end

	if _T.fishingDebugDrawHotspots then
		for _, fishingHotspot in ipairs(_T.fishingHotspots) do
			if __wf_atom_7e8ad928(fishingHotspot) or __wf_atom_7e8ad928(fishingHotspot.mHotspot) then
				continue
			end

			gRegion:__wf_atom_b5c21154(
				fishingHotspot.mHotspot:GetPosition(),
				fishingHotspot.mHotspot:__wf_atom_4e28532a(),
				Color(0, 255, 255),
				Rotation(0, 90, 0),
				0.1
			)
			gRegion:__wf_atom_5b35a0c8(
				fishingHotspot.mHotspot:GetPosition(),
				Color(0, 255, 255),
				fishingHotspot.mHotspot:__wf_atom_db682341():c_str(),
				1.5,
				0.1
			)
		end
	end

	if _T.fishingDebugDrawPlayerAvoidance then
		gRegion:__wf_atom_b5c21154(v9:GetPosition(), 10, Color(255, 100, 100), Rotation(0, 90, 0), 0.05)
		gRegion:__wf_atom_b5c21154(v9:GetPosition(), 5, Color(255, 0, 0), Rotation(0, 90, 0), 0.05)
	end

	if _T.fishingDebugHighlightFish then
		for _, allFishInfo in ipairs(_T.allFishInfos) do
			if not (__wf_atom_7e8ad928(allFishInfo) or __wf_atom_7e8ad928(allFishInfo.mFishDeco)) then
				gRegion:__wf_atom_8d991675(allFishInfo.mFishDeco:GetPosition(), 0.2, Color(255, 255, 0), 0.1)
			end
		end
	end

	if _T.fishingDebugDrawWaterVolumes then
		for _, v12 in ipairs(gRegion:__wf_atom_3bc831e3()) do
			gRegion:__wf_atom_49f801a3(v12:__wf_atom_0aa77159(), v12:__wf_atom_ee03557f(), Color(0, 0, 255), 0.05)
			local position = v12:GetPosition()
			position.y = v12:__wf_atom_ee03557f().y
			local biomeId = module.GetBiomeIdFromDensityVolume(v12:GetPosition())
			local v13 = v12:__wf_atom_5b41f63b() .. "\n" .. "Biome ID: " .. biomeId
			gRegion:__wf_atom_5b35a0c8(position, Color(0, 255, 255), v13, 1.2, 0.05)
		end
	end

	if _T.fishingDebugShowSpawnSuccessRate then
		for _, fishingHotspot in ipairs(_T.fishingHotspots) do
			if __wf_atom_7e8ad928(fishingHotspot) or __wf_atom_7e8ad928(fishingHotspot.mHotspot) then
				continue
			end

			local v12 = not (fishingHotspot.mTotalSpawnAttempts > 0) and 0
				or fishingHotspot.mSuccessfulSpawnAttempts / fishingHotspot.mTotalSpawnAttempts
			local v13 = "Total spawn attempts: " .. fishingHotspot.mTotalSpawnAttempts .. "\n" .. "Spawn success rate: " .. string.format("%.2f", v12)
			gRegion:__wf_atom_5b35a0c8(fishingHotspot.mHotspot:GetPosition(), Color(0, 255, 255), v13, 1.5, 0.05)
		end
	end
end

function OnHitWaterFromJump(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.mFishDeco) then
		return
	end

	if not __wf_atom_7e8ad928(fishJumpLandSound) then
		p.mFishDeco:PlaySound(fishJumpLandSound, false, 1, true, nil)
	end

	if not __wf_atom_7e8ad928(fishEnterWaterSplashFXType) then
		gRegion:CreateEntity(fishEnterWaterSplashFXType, p.mFishDeco:GetPosition(), __wf_atom_80368bb1)
	end
end

function OnLeaveWaterFromJump(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.mFishDeco) then
		return
	end

	if not __wf_atom_7e8ad928(fishJumpLeaveSound) then
		p.mFishDeco:PlaySound(fishJumpLeaveSound, false, 1, true, nil)
	end

	if not __wf_atom_7e8ad928(fishJumpSplashFXType) then
		gRegion:CreateEntity(fishJumpSplashFXType, p.mFishDeco:GetPosition(), __wf_atom_80368bb1)
	end
end