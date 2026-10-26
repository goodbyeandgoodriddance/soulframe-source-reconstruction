local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
WeakResource("/EE/Types/Engine/SoundSysVolume")
local v8 = Symbol("")
local total = 0
local flag = false
local v9 = {
	mIdleAnimAction = Symbol("IDLE"),
	mFishingEquipAnimAction = Symbol("FISHING_EQUIP"),
	mFishingIdleAnimAction = Symbol("FISHING_IDLE"),
	mFishingSpinStartAnimAction = Symbol("FISHING_SPIN_START"),
	mFishingSpinAnimAction = Symbol("FISHING_SPIN"),
	mFishingCastAnimAction = Symbol("FISHING_CAST"),
	mFishingReelIdleAnimAction = Symbol("FISHING_REEL_IDLE"),
	mFishingReelHardAnimAction = Symbol("FISHING_REEL_HARD"),
	mFishingBiteReactAnimAction = Symbol("FISHING_BITE_REACT"),
	mFishingLeftTugAnimAction = Symbol("FISHING_LEFT_TUG"),
	mFishingRightTugAnimAction = Symbol("FISHING_RIGHT_TUG"),
	mFishingReelHookedAnimAction = Symbol("FISHING_REEL_HOOKED"),
	mFishingResetAnimAction = Symbol("FISHING_RESET"),
	mFishingLoseFishAnimAction = Symbol("FISHING_LOSE_FISH"),
	mFishingCastLobAnimEvent = "FishingCastLob",
	mFishingTugAnimEvent = "FishingTug",
	mFishingTugLureBobAnimEvent = "FishingTugLureBob"
}
local v10 = {
	MINIGAME_ALLOWED_HEIGHT_RANGE = Range(-5, 2),
	MOUSE_AIM_SPEED_MULTIPLIER = 1,
	JOYSTICK_AIM_SPEED_MULTIPLIER = 10,
	KEY_AIM_SPEED_MULTIPLIER = 10,
	REEL_HEADING_CHANGE_MULTIPLIER = 4,
	MAX_CAST_HEADING = 60,
	MAX_FISH_HEADING = 75,
	MIN_CAST_DISTANCE = 2,
	MAX_CAST_DISTANCE = 20,
	FISH_CATCH_DISTANCE = 2.15,
	FISH_ESCAPE_DISTANCE = 25,
	PARAMETRIC_TORSO_MOVEMENT = 300,
	TUG_COOLDOWN = 1,
	SIDE_TUG_COOLDOWN = 1,
	TUG_LINE_TIGHTEN_DURATION = 0.5,
	TUG_LINE_LERP_FRACTION = 0.4,
	TUG_HORIZONTAL_VELOCITY = 5,
	TUG_VERTICAL_VELOCITY = 1,
	SIDEWAYS_TUG_VELOCITY = 1.6,
	MAX_SIDEWAYS_TUG_STRAIGHT_BIAS = 0.4,
	SIDEWAYS_NO_REEL_MULTIPLIER = 0.3,
	REEL_ACCELERATION_TIME = 1.75,
	REEL_HOOKED_ACCELERATION = 5,
	SIDEWAYS_ACCELERATION = 0.5,
	LURE_VELOCITY_DAMPING = 5,
	GRAVITY = 9.8,
	REEL_SLACK_MIN = 0.2,
	REEL_SLACK_MAX = 1,
	BITE_TARGET_MOVEMENT_RANGE = Range(0.4, 0.7),
	BITE_TARGET_MOVEMENT_DURATION = 2,
	BITE_TARGET_MOVEMENT_NOISE_STRENGTH = 1,
	SPIN_MIN_ANIM_RATE = 0.5,
	SPIN_MAX_ANIM_RATE = 0.6,
	BASE_LOB_VELOCITY = 6,
	LOB_VELOCITY_PER_DISTANCE = 0.45,
	MAX_SWEET_SPOT_DEVIATION = 3,
	SETTLE_FRACTION = 0,
	LURE_LANDING_SPOOK_DURATION = 1,
	LURE_RESET_INTERPOLATION_TIME = 0.3,
	FISH_PERFECT_HOOK_STUN_DAMAGE = {
		40,
		40,
		40,
		40,
		60,
		60,
		60,
		80,
		80,
		100
	},
	FISH_JUMP_STUN_DAMAGE = {
		20,
		20,
		40,
		40,
		60,
		60,
		80,
		80,
		100,
		150
	},
	FISH_STUN_VFX_LEVEL = {
		1,
		1,
		1,
		1,
		2,
		2,
		2,
		2,
		3,
		3
	},
	FISHING_LINE_SPLINE_SPACING = 0.2,
	FISH_ROTATION_ACCELERATION = 1,
	FISH_STRUGGLE_ROTATION_ACCELERATION = 6,
	FISH_ROTATION_SMOOTHING_SPEED = 10,
	LURE_WEIGHT = 0.2,
	FISH_COLLISION_MARGIN = 0.05,
	FISH_JUMP_CHECK_MARGIN = 1.5,
	FISH_SWIM_CHECK_MARGIN = 0.7,
	LURE_DEPTH_MARGIN = 0.3,
	STUN_WINDOW_INDICATOR_BUFFER_TIME = 0.8,
	STUN_INDICATOR_AT_APEX = false,
	MAX_PERFECT_STREAK = 15
}
v10.MIN_CAST_DISTANCE = math.max(v10.MIN_CAST_DISTANCE, v10.FISH_CATCH_DISTANCE)
local v11 = v10.MAX_CAST_DISTANCE * 0.75
local v12 = {
	CAMERA_HEADING_OVERRIDE = nil,
	CAMERA_PITCH = 21,
	CAMERA_SPOT_OFFSET = Vector(0, 2.8, -3.2),
	OTS_CAMERA_SPOT_FAR_OFFSET = Vector(0, 2.8, -3.2),
	OTS_CAMERA_SPOT_CLOSE_OFFSET = Vector(0, 2.8, -2.4),
	mCameraSweepSphereRadius = 0.25,
	mSmoothCameraSpotPos = { __wf_atom_10cd16b2(0, 1.2), __wf_atom_10cd16b2(0, 1.2), __wf_atom_10cd16b2(0, 1.2) },
	mCameraTransitionPercentage = 1,
	mCameraDistanceForMaxTracking = 0.2,
	mCameraMinTrackingPercentage = 0.45,
	mCameraHorizontalDeadZone = 10,
	FIXED_CAMERA_SPOT_OFFSET = Vector(1.2, 2.2, -1.2),
	mCameraFixedTransitionPercentage = 1,
	mCameraXSign = 1
}
local v13 = 0
local flag2 = false
local v14 = {
	DOUBLE_TAP_DELAY = 0.3,
	mActionKeyHeld = false,
	mLeftKeyHeld = false,
	mRightKeyHeld = false,
	mUpKeyHeld = false,
	mDownKeyHeld = false,
	mReelHorizontalInput = 0,
	mPrevReelHorizontalInput = 0,
	mReelAimHeading = 0,
	mSimulatedCursorPosition = Vector(),
	mMouseDelta = Vector(0, 0, 0),
	mJoystickDelta = Vector(0, 0, 0),
	mCursorDelta = Vector(0, 0, 0),
	mTimeSinceActionKeyUp = 0,
	mPrevPlayingWithController = false
}
local v15 = {
	SPIN = 1,
	CAST = 2,
	REEL = 3,
	AIM = 4,
	PULL = 5,
	STUN_PULL = 6,
	BITE = 7,
	RELEASE = 8,
	SELECT_LURE = 9,
	CATCH = 10,
	LEFT = 11,
	RIGHT = 12,
	MAX = 13
}
local avatar = nil
local v16 = nil
local v17 = nil
local mLureDeco = nil
local v18 = nil
local v19 = nil
local v20 = nil
local fishReticle = nil
local v21 = nil
local v22 = nil
local v23 = nil
local v24 = nil
local v25 = nil
local v26 = nil
local v27 = nil
local caughtHealthyFishInfo = nil
local v28 = nil
local v29 = nil
local v30 = nil
local v31 = nil
local __wf_atom_28d5d4aa2 = __wf_atom_28d5d4aa
local heading = 0
local v32 = __wf_atom_10cd16b2(0, 0.09)
local v35 = __wf_atom_10cd16b2(0, 0.09)
local v36 = false
local __wf_atom_28d5d4aa3 = __wf_atom_28d5d4aa
local __wf_atom_28d5d4aa4 = __wf_atom_28d5d4aa
local __wf_atom_28d5d4aa5 = __wf_atom_28d5d4aa
local TUG_HORIZONTAL_VELOCITY = 0
local v37 = 0
local v38 = 0
local v39 = {
	mLineHandPosition = __wf_atom_28d5d4aa,
	mFishingLineHandSwitchTime = 0,
	mReelSlackMultiplier = __wf_atom_10cd16b2(1, 0.4),
	mBiteFightSlackMultiplier = __wf_atom_10cd16b2(1, 0.3),
	mTugSlackMultiplier = __wf_atom_10cd16b2(1, 0.8),
	mTugTime = 3.4028234663852886e38,
	mLineSnapped = false,
	mLineSnapDistance = 1
}
local v40 = {
	mLureOriginalMeshScale = 1,
	mLureVelocity = 0,
	mSmoothedLureReelX = __wf_atom_10cd16b2(0, 0.4),
	mSmoothedLureReelZ = __wf_atom_10cd16b2(0, 0.4),
	mLureNoiseHeading = 0,
	mLureNoiseHeadingVelocity = 0,
	mTargetDepth = 0.2,
	mBuoyancyAcceleration = 15,
	mMaxBuoyancyDepth = 0.3,
	mMaxReelVelocity = 1.3,
	mReelAcceleration = 1.5,
	mReelHookedAcceleration = 5,
	mReelDeceleration = 2
}
local v41 = __wf_atom_10cd16b2(0, 0.2)
local v42 = __wf_atom_10cd16b2(0, 0.1)
local v43 = {
	mInitialLobPosition = __wf_atom_28d5d4aa,
	mInitialLobRotation = __wf_atom_80368bb1,
	mInitialLobVelocity = 0,
	mLureImpactVerticalVelocity = 0,
	mLureImpactPosition = __wf_atom_28d5d4aa,
	mLureImpactRotation = __wf_atom_80368bb1,
	mInitialLobTime = 3.4028234663852886e38,
	mLureEnterWaterTime = 3.4028234663852886e38,
	mLureSettledTime = 3.4028234663852886e38,
	mSettleMovementDistance = 0,
	mLureEnteredWater = false,
	mLureSettled = false
}
local v44 = {
	mBiteAnimStartTime = 3.4028234663852886e38,
	mChompAnimEventDelta = 1,
	mChompAnimEventTime = 3.4028234663852886e38,
	mBiteStartPosition = __wf_atom_28d5d4aa,
	mBiteStartRotation = __wf_atom_80368bb1,
	mChompTimePosition = __wf_atom_28d5d4aa,
	mLureAttachOffset = __wf_atom_28d5d4aa,
	mRotationInterpolationDuration = 0.3,
	mBiteTimer = 0,
	mLastTugTime = 0,
	mLastSideTugTime = 0,
	mBiteWindowStartTime = 3.4028234663852886e38,
	mWasPlayingBiteAnim = false,
	mBiteStartVelocity = 0,
	BITE_VELOCITY_BLEND_DURATION = 0.5,
	mBiteVelocityBlendTimer = 1,
	mBiteStruggleRotateTimer = 0,
	mBiteStruggleTargetHeading = 0,
	mHeadingTurnRate = 0,
	mBiteStruggleTargetPitch = 0,
	mPitchTurnRate = 0,
	mTargetVelocity = 0,
	mVelocity = 0,
	mBiteLineLength = 3.4028234663852886e38,
	mBiteStruggleAnimRate = 0.3,
	mOriginalFishMeshScale = 1
}
local v45 = 3.4028234663852886e38
local __wf_atom_28d5d4aa6 = __wf_atom_28d5d4aa
local __wf_atom_80368bb1_2 = __wf_atom_80368bb1
STAMINA_STATE = { OKAY = 0, IN_USE = 1, DELAY = 2, BREAKING = 3 }
local okay = STAMINA_STATE.OKAY
local v46 = {
	mStaminaRegenAccel = 2.25,
	mStaminaBreakDelay = 1.25,
	mStaminaRegenDelay = 0.2,
	mLineDurability = 35,
	mFishForceBias = 0.7,
	mCounterStaminaDrain = 0.5,
	mColorChangeThreshold = 0.3,
	mBlinkingThreshold = 0.05,
	mBlinkSpeed = Range(0.07, 0.3),
	mBlinkEmissiveIntensity = 12,
	mRemainingStamina = 1,
	mStaminaStateTime = 0,
	mConstraintPullStrength = 0,
	mStaminaRegenSpeed = 0,
	mTimeUntilNextBlink = 0,
	mIsBlinking = false
}
local v47 = {
	mLineDefaultColor = Color(255, 255, 255),
	mLineBreakingColor = Color(255, 0, 0),
	mLineBlinkSecondColor = Color(255, 40, 40),
	mLinePulseColor = Color(0, 247, 255),
	mLineColor = Color(255, 255, 255),
	mEmissiveColor = Color(0, 0, 0),
	mEmissiveIntensity = 0,
	mEmissivePulseIntensity = 5,
	mEmissiveDefaultColor = Color(0, 0, 0),
	mEmissivePulseColor = Color(20, 160, 160),
	mEmissiveBreakingColor = Color(255, 0, 0),
	mLinePulseDuration = 1,
	mLinePulseAccelPercent = 0.2,
	mLinePulseRemainingTime = 0,
	mCurrLinePulseDuration = 0,
	mCurrEmissivePulseIntensity = 0,
	mStunLineFx = nil,
	mStunLineFxDelay = 0.3,
	mStunLineFxRemainingDelay = 0
}
local v48 = __wf_atom_10cd16b2(0, 0.2)
local v49 = 0
local v50 = 0
local __wf_atom_80368bb1_3 = __wf_atom_80368bb1
local v51 = { 0, 0, 0 }
local flag3 = false
Vector(0, 0, 0)
local v52 = Color(0, 0, 0)
local v53 = 0
local v54 = {
	mUnpredictability = 1,
	mWeight = 1,
	mStruggleAccelerationMultiplier = 15,
	mJumpingPower = Range(4, 6),
	mAcceleration = 0.4,
	mJumpAccelerationMultiplier = 1.1,
	mFishStamina = 100,
	mPreferredDepth = 1,
	mCorruptionLevel = 1,
	mSize = 1,
	mRestAccelerationMultiplier = 3,
	mFishRestDuration = Range(2, 3),
	mStunAttemptStaminaDrain = 0.5,
	mJumpStunTimingWindowPercentage = 0.5,
	mCorruptionModifierRanges = { Range(-0.15, 0), Range(0, 0.1), Range(0.1, 0.2) }
}
local v55 = {
	mStruggleDuration = Range(1.5, 2.5),
	mBackStruggleRandomGain = 3,
	mSideStruggleRandomGain = 1.5,
	mJumpCooldown = Range(2.6, 3.4),
	mInitialResistanceMultiplier = 1,
	mInitialResistanceDuration = 0
}
local v56 = {
	mTargetDepth = 1,
	mWaterDragCoeff = 2.5,
	mSurfaceDragCoeff = 3.5,
	mFishWeight = 1,
	mCorruptionLevel = 1,
	mCurrBackStruggleAccel = 0,
	mCurrSideStruggleAccel = 0,
	mSideStruggleSeed = 0,
	mBackStruggleSeed = 0,
	mSideStruggleRandomGain = 1.5,
	mSideStruggleRandomFrequency = 0.15,
	mBackStruggleRandomGain = 3,
	mBackStruggleRandomFrequency = 0.08,
	mBackStruggleRange = Range(0.5, 1),
	mSideStruggleRange = Range(0.75, 1.25),
	mStruggleStrength = 6,
	mStruggleRandomGainPassiveMultiplier = 0.6,
	mStruggleRandomFrequencyPassiveMultiplier = 0.5,
	mStruggleStrengthPassiveMultiplier = 0.1,
	mStruggleDurationPassiveMultiplier = 1.8,
	mFishStaminaDrain = 35,
	mFishStamina = 100,
	mStruggleDuration = Range(0.8, 2),
	mStruggleCooldown = Range(1.5, 2.2),
	mTimeUntilNextStruggle = 3.4028234663852886e38,
	mRemainingStruggleTime = 0,
	mCurrStruggleDuration = 0,
	mRemainingFishStamina = 0,
	mFishMaxStruggleDist = 3.4028234663852886e38,
	mFishStruggleDirectionVector = __wf_atom_28d5d4aa,
	mFishStrugglePerpendicularVector = __wf_atom_28d5d4aa,
	mSmoothFishEmissiveValue = __wf_atom_10cd16b2(0, 0.2),
	mNumRests = 0,
	mRestDurationIncreasePerRest = 0.5,
	mIsShowingDirection = false,
	mInitialResistanceMultiplier = 1,
	mInitialResistanceDuration = 0,
	mIsInFirstFight = false,
	mRemainingInitialResistanceTime = 0,
	mFishInitialColorFadeThreshold = 0.15,
	mCounterMovementMultiplier = 0.1,
	mIsFishStuck = false,
	mFishStuckSwitchTime = 0.5,
	mTimeUntilSwitch = 0,
	mPrevValidNormal = Vector(),
	mFailedAttemptPlayerDamage = 0,
	mFailedAttemptPlayerStunDuration = 1.5,
	mPlayerStunRemainingTime = 0
}
local __wf_atom_80368bb1_4 = __wf_atom_80368bb1
local flag4 = false
local v57 = __wf_atom_10cd16b2(1, 0.05)
local v58 = {
	mJumpSpeedMultiplier = 1.1,
	mMinJumpDistance = 6,
	mTimeUntilNextJump = 3.4028234663852886e38,
	mRemainingJumpTime = 0,
	mJumpAccel = __wf_atom_28d5d4aa,
	mJumpTargetVelocity = __wf_atom_28d5d4aa,
	mCurrJumpPower = 0,
	mJumpVertPower = Range(4, 6),
	mJumpDistance = Range(2, 4.2),
	mMinTimeBeforeJump = 0.5,
	mJumpCooldown = Range(2.6, 3.4),
	mJumpApexTime = 0,
	mInputtedJumpStun = false,
	mJumpStunWindowStartTime = 0,
	mShowedWindowIndicator = false,
	mStunAttemptStaminaDrain = 0.5,
	mJumpStunTimingWindowPercentage = 0.5,
	mCanStunFish = false
}
local flag5 = false
local flag6 = false
local v59 = false
local v60 = {
	mSweetSpotDelta = 0,
	mSweetSpotValue = 0,
	mSweetSpotSpeed = 0.25,
	mSweetSpotBiteValue = 0,
	mPrevShouldShowBiteIndicator = false,
	mSweetSpotSoundValue = 0,
	mIsPerfectCast = false
}
local v61 = 0
local v62 = Vector()
local v63 = Rotation()
local flag7 = false
local flag8 = false
local v64 = false
local flag9 = false
local v65 = nil
local v66 = __wf_atom_10cd16b2(0, 0.15)
local module = require("Lotus.Scripts.Libs.AudioLib")
local module2 = require("SF.Interface.Libs.ItemUtil")
require("Lotus.Scripts.Effects.EffectsColorUtilities")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("SF.Scripts.Libs.FishingLib")
local module5 = require("SF.Scripts.NightFoldLib")
local module6 = require("SF.Interface.SFUtilities")
local module7 = require("Lotus.Interface.UIUtilities")
local module8 = require("EE.Interface.Utilities")
local module9 = require("EE.Interface.AnchorMgr")
local module10 = require("SF.Scripts.Libs.PlayerPetLib")
require("SF.Scripts.Libs.RaycastLib")
mSpinRateUI = 0
mFishingUIStats = {}
keyMapping = {}
inputMapping = {}
mAnchorMgr = nil
mCalloutClips = {}
mCallouts = {}
mPrevState = nil
mFishReticleMovie = nil
MaxStarCount = 5
mStats = {}
biteFishFx = nil
revealFishFx = nil

function GetAimPosition()
	local y = __wf_atom_28d5d4aa2.y
	return Vector(v32:__wf_atom_9e368823(), y, v35:__wf_atom_9e368823())
end

function GetTargetHeading()
	return __wf_atom_fa8d0177(__wf_atom_28d5d4aa2, __wf_atom_28d5d4aa3).heading
end

function GetTargetDirection()
	return Rotation(GetTargetHeading(), 0, 0)
end

function GetTargetDistance()
	return Distance(__wf_atom_28d5d4aa2, __wf_atom_28d5d4aa3)
end

function GetTargetDistance2D()
	return module3.Distance2d(__wf_atom_28d5d4aa2, __wf_atom_28d5d4aa3)
end

function GetPositionFromHeadingDistance(p, p2)
	return __wf_atom_28d5d4aa2 + __wf_atom_9341614d(Vector(0, 0, p2), Rotation(p, 0, 0))
end

function ClampPositionHeadingDistance(p, p2, p3, p4, p5)
	local heading2 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa2, p).heading
	local angle = module8.WrapAngle(heading2 - heading)
	local angle2 = module8.WrapAngle(heading + __wf_atom_421b01aa(angle, p2, p3))
	local distance2d = module3.Distance2d(p, __wf_atom_28d5d4aa2)
	local v67 = p - __wf_atom_28d5d4aa2
	Normalize(v67)
	local v68 = __wf_atom_421b01aa(distance2d, p4, p5)
	return GetPositionFromHeadingDistance(angle2, v68)
end

function ClampToPlayableArea(p, p2)
	local v67 = __wf_atom_7e8ad928(p2) and 0 or p2
	return ClampPositionHeadingDistance(
		p,
		-v10.MAX_CAST_HEADING,
		v10.MAX_CAST_HEADING,
		v10.MIN_CAST_DISTANCE + v67,
		v10.MAX_CAST_DISTANCE
	)
end

local function fn()
	v23 = gRegion:CreateEntity(fishingLineSplineType, __wf_atom_28d5d4aa2, __wf_atom_80368bb1)
	v24 = gRegion:CreateEntity(fishingLineSplineUnderType, __wf_atom_28d5d4aa2, __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(v23) then
		v23:SetMaterialParam(Symbol("ClipHeight_ClipDirection"), __wf_atom_28d5d4aa2.y, 1)
	end

	if not __wf_atom_7e8ad928(v24) then
		v24:SetMaterialParam(Symbol("ClipHeight_ClipDirection"), __wf_atom_28d5d4aa2.y, -1)
	end
end

local function fn2(p, p2, p3)
	_T.IsFishStuckInCollision = "FALSE"
	v56.mIsFishStuck = false
	local mFishOnHook = mLureDeco

	if v13 == 7 then
		local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

		if not (__wf_atom_7e8ad928(__wf_atom_296472bc) or __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook)) then
			mFishOnHook = __wf_atom_296472bc.mFishOnHook
		end
	end

	if __wf_atom_7e8ad928(mFishOnHook) then
		return p2
	end

	local v67 = p2 - p

	if Length(v67) == 0 then
		return p
	end

	local v68 = (mFishOnHook:__wf_atom_ee03557f().y - mFishOnHook:__wf_atom_0aa77159().y) / 2
	local v69 = (mFishOnHook:__wf_atom_ee03557f().x - mFishOnHook:__wf_atom_0aa77159().x) / 2
	local v70 = (mFishOnHook:__wf_atom_ee03557f().z - mFishOnHook:__wf_atom_0aa77159().z) / 2
	local FISH_COLLISION_MARGIN = v10.FISH_COLLISION_MARGIN

	if not p3 then
		FISH_COLLISION_MARGIN = v10.FISH_JUMP_CHECK_MARGIN
	end

	local v71 = math.max(math.max(v69, v68), v70) + FISH_COLLISION_MARGIN
	local v72 = Vector()
	local mPrevValidNormal2 = Vector()
	local __wf_atom_76b74a76 = gRegion:__wf_atom_76b74a76(p, p2, v71, nil, nil, v72, mPrevValidNormal2, true, true)
	local v74 = p + v67 * __wf_atom_76b74a76

	if not p3 or __wf_atom_76b74a76 == 1 then
		return v74
	end

	local mPrevValidNormal

	if __wf_atom_76b74a76 < 0.001 then
		mPrevValidNormal = v56.mPrevValidNormal
	else
		v56.mPrevValidNormal = mPrevValidNormal2
		mPrevValidNormal = mPrevValidNormal2
	end

	local v75 = v74 + mPrevValidNormal * 0.01
	_T.IsFishStuckInCollision = "TRUE"
	v56.mIsFishStuck = true

	if
		v13 == 5
		and not (avatar:__wf_atom_7bcdbf55(v9.mFishingBiteReactAnimAction) or avatar:__wf_atom_7bcdbf55(v9.mFishingLeftTugAnimAction) or avatar:__wf_atom_7bcdbf55(v9.mFishingRightTugAnimAction))
	then
		Reset()
	end

	local v76 = v67 * (1 - __wf_atom_76b74a76)
	local v77 = v76 - math.min(0, Dot(v76, mPrevValidNormal)) * mPrevValidNormal
	Normalize(v77)
	local v78 = v77 * Length(v76)
	local v79 = v75 + v78
	return v75 + v78 * gRegion:__wf_atom_76b74a76(v75, v79, v71, nil, nil, v72, mPrevValidNormal2, true, true)
end

function DissolveOut(object)
	local v67 = 0

	while v67 < 2 do
		v67 = __wf_atom_421b01aa(v67 + __wf_atom_084b3e93(), 0, 2)
		object:__wf_atom_68f2c268(v67 / 2)
		Sleep(0)
	end
end

function DissolveIn(object)
	local v67 = 0

	while v67 < 0.5 do
		v67 = __wf_atom_421b01aa(v67 + __wf_atom_084b3e93(), 0, 0.5)
		object:__wf_atom_68f2c268(1 - v67 / 0.5)
		Sleep(0)
	end
end

local function fn3(data, data2, p)
	local v67 = tonumber("0x" .. module8.ConvertRGB2HEX(data.red, data.green, data.blue))
	local v68 = tonumber("0x" .. module8.ConvertRGB2HEX(data2.red, data2.green, data2.blue))
	local interpolateColors = module8.InterpolateColors(v67, v68, p)
	return (module8.ConvertHEX2RGB255(interpolateColors))
end

local function fn4()
	if __wf_atom_7e8ad928(avatar) then
		return
	end

	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if __wf_atom_7e8ad928(__wf_atom_296472bc.mLureDeco) or __wf_atom_7e8ad928(__wf_atom_296472bc.mLureItem) then
		return
	end

	mLureDeco = __wf_atom_296472bc.mLureDeco
	v40.mLureOriginalMeshScale = mLureDeco:__wf_atom_c082fc3d()
	mLureDeco:SetVisibility(true, true)
	local __wf_atom_be0bea4a = mLureDeco:__wf_atom_be0bea4a()

	for _, v67 in ipairs(__wf_atom_be0bea4a) do
		if not v67:IsA(Type(lureFlareWeakResource)) then
			continue
		end

		v18 = v67
		v18:__wf_atom_a763aa1a(1)
		break
	end

	v40.mTargetDepth = 0.05
	v40.mMaxBuoyancyDepth = v40.mTargetDepth * 1.2
	v40.mBuoyancyAcceleration = v10.GRAVITY * v40.mMaxBuoyancyDepth / (v40.mTargetDepth + 0.00001)
	local v67 = Type(__wf_atom_296472bc.mLureItem)
	v40.mReelAcceleration = v67:__wf_atom_c14ada5b()
	v40.mReelHookedAcceleration = v40.mReelAcceleration * v67:__wf_atom_beb8dcb4()
end

local function fn5(object, p, p2, p3)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local cameraControl = object:CameraControl()

	if __wf_atom_7e8ad928(cameraControl) then
		return
	end

	local __wf_atom_4cd347da = cameraControl:__wf_atom_4cd347da()

	if __wf_atom_7e8ad928(__wf_atom_4cd347da) then
		return
	end

	local total2 = 0

	while total2 < p3 do
		if __wf_atom_7e8ad928(__wf_atom_4cd347da) then
			return
		end

		total2 += __wf_atom_084b3e93()
		local v67 = __wf_atom_24a82b69(__wf_atom_421b01aa(total2 / p3, 0, 1))
		__wf_atom_4cd347da:__wf_atom_74d17eae(__wf_atom_104bfe98(p, 0.1, v67), __wf_atom_104bfe98(p2, 0.5, v67))
		Sleep(0)
	end

	__wf_atom_4cd347da:__wf_atom_74d17eae(0.1, 0.5)
end

function ShakeCameraSpotSmall(p)
	fn5(p, 1, 1, 0.3)
end

function ShakeCameraSpotMedium(p)
	fn5(p, 1, 2, 0.5)
end

function ShakeCameraSpotLarge(p)
	fn5(p, 1, 4, 0.8)
end

local function fn6(mFishOnHook)
	if __wf_atom_7e8ad928(mFishOnHook) then
		return
	end

	v52.red = mFishOnHook:__wf_atom_06adb5a9(Symbol("EmissiveTintColorHi"), 1) * 255
	v52.green = mFishOnHook:__wf_atom_06adb5a9(Symbol("EmissiveTintColorHi"), 2) * 255
	v52.blue = mFishOnHook:__wf_atom_06adb5a9(Symbol("EmissiveTintColorHi"), 3) * 255

	if mFishOnHook:__wf_atom_99150eda(Symbol("EmissiveMapAtten")) then
		v53 = mFishOnHook:__wf_atom_06adb5a9(Symbol("EmissiveMapAtten"), 1)
	else
		v53 = -1
	end

	v49 = mFishOnHook:__wf_atom_c082fc3d()
	v48:__wf_atom_4453e49c(v49)
	v54.mWeight = module8.Ternary(__wf_atom_7e8ad928(mFishOnHook.mWeight), v54.mWeight, mFishOnHook.mWeight)
	v54.mAcceleration = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mAcceleration),
		v54.mAcceleration,
		mFishOnHook.mAcceleration
	)
	v54.mUnpredictability = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mUnpredictability),
		v54.mUnpredictability,
		mFishOnHook.mUnpredictability
	)
	v54.mStruggleAccelerationMultiplier = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mStruggleAccelerationMultiplier),
		v54.mStruggleAccelerationMultiplier,
		mFishOnHook.mStruggleAccelerationMultiplier
	)
	v54.mJumpingPower = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mJumpingPower),
		v54.mJumpingPower,
		mFishOnHook.mJumpingPower
	)
	v54.mJumpAccelerationMultiplier = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mJumpAccelerationMultiplier),
		v54.mJumpAccelerationMultiplier,
		mFishOnHook.mJumpAccelerationMultiplier
	)
	v54.mFishStamina = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mFishStamina),
		v54.mFishStamina,
		mFishOnHook.mFishStamina
	)
	v54.mPreferredDepth = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mPreferredDepth),
		v54.mPreferredDepth,
		mFishOnHook.mPreferredDepth
	)
	v54.mCorruptionLevel = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mCorruptionLevel),
		v54.mCorruptionLevel,
		mFishOnHook.mCorruptionLevel
	)
	v54.mSize = module8.Ternary(__wf_atom_7e8ad928(mFishOnHook.mSize), v54.mSize, mFishOnHook.mSize)
	v54.mFishRestDuration = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mFishRestDuration),
		v54.mFishRestDuration,
		mFishOnHook.mFishRestDuration
	)
	v54.mRestAccelerationMultiplier = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mRestAccelerationMultiplier),
		v54.mRestAccelerationMultiplier,
		mFishOnHook.mRestAccelerationMultiplier
	)
	v54.mStunAttemptStaminaDrain = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mStunAttemptStaminaDrain),
		v54.mStunAttemptStaminaDrain,
		mFishOnHook.mStunAttemptStaminaDrain
	)
	v54.mJumpStunTimingWindowPercentage = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mJumpStunTimingWindowPercentage),
		v54.mJumpStunTimingWindowPercentage,
		mFishOnHook.mJumpStunTimingWindowPercentage
	)
	v54.mInitialResistanceMultiplier = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mInitialResistanceMultiplier),
		v54.mInitialResistanceMultiplier,
		mFishOnHook.mInitialResistanceMultiplier
	)
	v54.mInitialResistanceDuration = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mInitialResistanceDuration),
		v54.mInitialResistanceDuration,
		mFishOnHook.mInitialResistanceDuration
	)

	if _T.fishingDebugUseCustomStats then
		v54.mWeight = _T.fishingDebugCustomWeight
		v54.mAcceleration = _T.fishingDebugCustomAccel
		v54.mUnpredictability = _T.fishingDebugCustomUnpredictability
		v54.mStruggleAccelerationMultiplier = _T.fishingDebugCustomStruggleAccelerationMultiplier
		v54.mJumpingPower = Range(_T.fishingDebugCustomMinJump, _T.fishingDebugCustomMaxJump)
		v54.mJumpAccelerationMultiplier = _T.fishingDebugCustomJumpAccelMultiplier
		v54.mFishStamina = tonumber(_T.fishingDebugCustomMaxFishStamina)
		v54.mCorruptionLevel = _T.fishingDebugCustomCorruption
		v54.mFishRestDuration = Range(_T.fishingDebugCustomMinRestDur, _T.fishingDebugCustomMaxRestDur)
		v54.mRestAccelerationMultiplier = _T.fishingDebugCustomRestAccelerationMultiplier
		v54.mSize = _T.fishingDebugCustomSize
		v49 *= v54.mSize
		mFishOnHook:SetMeshScale(v49)
		v48:__wf_atom_4453e49c(v49)
	end

	local total2 = 1
	local mCorruptionLevel = math.round(v54.mCorruptionLevel)
	local v67 = mCorruptionLevel < 1 and 1 or mCorruptionLevel
	local mCorruptionModifierRange = v54.mCorruptionModifierRanges[v67]

	if not __wf_atom_7e8ad928(mCorruptionModifierRange) then
		total2 += __wf_atom_104bfe98(
			mCorruptionModifierRange.minValue,
			mCorruptionModifierRange.maxValue,
			math.random()
		)
	end

	local v68 = v54.mUnpredictability * total2
	local v69 = 0.19999999999999996 * v68 + 0.8
	v56.mStruggleDuration.minValue = v55.mStruggleDuration.minValue / v69
	v56.mStruggleDuration.maxValue = v55.mStruggleDuration.maxValue / v69
	v56.mBackStruggleRandomGain = v55.mBackStruggleRandomGain * v68
	v56.mSideStruggleRandomGain = v55.mSideStruggleRandomGain * v69
	local v70 = v55.mJumpCooldown.maxValue - v55.mJumpCooldown.minValue

	if v69 > 0 then
		local v71 = v70 * v69 / 2
		v58.mJumpCooldown.minValue = v58.mJumpCooldown.minValue - v71
		v58.mJumpCooldown.maxValue = v58.mJumpCooldown.maxValue + v71
	else
		local v71 = v70 * (1 - v69) / 2
		v58.mJumpCooldown.minValue = v58.mJumpCooldown.minValue + v71
		v58.mJumpCooldown.maxValue = v58.mJumpCooldown.maxValue - v71
	end

	v58.mJumpCooldown.minValue = math.max(v58.mJumpCooldown.minValue, v58.mMinTimeBeforeJump)
	v58.mJumpCooldown.maxValue = math.max(v58.mJumpCooldown.minValue, v58.mJumpCooldown.maxValue)
	v56.mStruggleStrength = v54.mStruggleAccelerationMultiplier * v54.mAcceleration * total2
	v58.mJumpVertPower = v54.mJumpingPower
	v56.mFishWeight = v54.mWeight * v54.mSize
	v58.mJumpSpeedMultiplier = v54.mJumpAccelerationMultiplier
	v56.mFishStamina = v54.mFishStamina
	v58.mJumpStunTimingWindowPercentage = v54.mJumpStunTimingWindowPercentage
	v58.mStunAttemptStaminaDrain = v54.mStunAttemptStaminaDrain
	v56.mStruggleCooldown = v54.mFishRestDuration
	v56.mStruggleStrengthPassiveMultiplier = v54.mRestAccelerationMultiplier / v54.mStruggleAccelerationMultiplier
	v56.mInitialResistanceMultiplier = v54.mInitialResistanceMultiplier
	v56.mInitialResistanceDuration = v54.mInitialResistanceDuration
	v56.mFailedAttemptPlayerDamage = module8.Ternary(
		__wf_atom_7e8ad928(mFishOnHook.mFailedAttemptPlayerDamage),
		v56.mFailedAttemptPlayerDamage,
		mFishOnHook.mFailedAttemptPlayerDamage
	)
end

function Shutdown() end

function CleanupAndShutdown()
	_T.FishingMode = false

	if _T.HUDResetLogContainerPosition ~= nil then
		_T.HUDResetLogContainerPosition()
	end

	if flag7 then
		return
	end

	flag7 = true

	if not __wf_atom_7e8ad928(avatar) and avatar == gRegion:__wf_atom_c4f78a8f() then
		local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

		if flag2 then
			if not __wf_atom_7e8ad928(__wf_atom_296472bc) then
				gRegion:__wf_atom_dd1e4d10(__wf_atom_296472bc.mFishOnHook)
			end

			flag2 = false
		end

		if not __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) then
			__wf_atom_296472bc.mFishOnHook:SetMaterialParam(
				Symbol("EmissiveTintColorHi"),
				v52.red / 255,
				v52.green / 255,
				v52.blue / 255,
				1,
				false
			)

			if v53 == -1 then
				__wf_atom_296472bc.mFishOnHook:__wf_atom_6d11d81e(Symbol("EmissiveMapAtten"))
			else
				__wf_atom_296472bc.mFishOnHook:SetMaterialParam(Symbol("EmissiveMapAtten"), v53, 0, 0, 0, true)
			end
		end

		avatar:__wf_atom_aabc9a96(SF.FishingData())
		__wf_atom_28d5d4aa2 = Vector()
		__wf_atom_28d5d4aa3 = Vector()
		v36 = false
		avatar:__wf_atom_e06358f3(v9.mIdleAnimAction, true)
		avatar:__wf_atom_921c1a5f(nil, false)
		avatar:__wf_atom_701bf429(v8)
		avatar:__wf_atom_7470861b():__wf_atom_63396172(Symbol("Invulnerable"))
		local cameraControl = avatar:CameraControl()
		cameraControl:__wf_atom_fd14c463(0.5)
		cameraControl:SetCameraSpot(nil, 0.5)
		avatar:__wf_atom_ae3321f6()
		local __wf_atom_d2b2176d = avatar:__wf_atom_d2b2176d()
		local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

		if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
			local __wf_atom_66088189 = __wf_atom_35a10d3c:__wf_atom_66088189(1, 0)

			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				__wf_atom_66088189:__wf_atom_017e8c6b(false)
				__wf_atom_66088189:__wf_atom_8a035cd5(Symbol("DissolveInSpoolAfter"), false)
			end
		end

		if flag9 then
			__wf_atom_d2b2176d:Unequip(0, 2)
		end

		local __wf_atom_e919fb8e = avatar:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.fishingDamaged = false
		__wf_atom_e919fb8e.FishingState = nil
		__wf_atom_e919fb8e.FishingElapsedTime = nil
	end

	gRegion:__wf_atom_dd1e4d10(v16)
	gRegion:__wf_atom_dd1e4d10(v20)
	gRegion:__wf_atom_dd1e4d10(fishReticle)
	gRegion:__wf_atom_dd1e4d10(v21)
	gRegion:__wf_atom_dd1e4d10(nil)
	gRegion:__wf_atom_dd1e4d10(mLureDeco)
	gRegion:__wf_atom_dd1e4d10(v18)
	gRegion:__wf_atom_dd1e4d10(v19)
	gRegion:__wf_atom_dd1e4d10(mLureDeco)
	gRegion:__wf_atom_dd1e4d10(v25)
	gRegion:__wf_atom_dd1e4d10(v26)
	gRegion:__wf_atom_dd1e4d10(v27)
	gRegion:__wf_atom_dd1e4d10(v29)
	gRegion:__wf_atom_dd1e4d10(v47.mStunLineFx)
	gRegion:__wf_atom_dd1e4d10(v23)
	gRegion:__wf_atom_dd1e4d10(v24)
	gRegion:__wf_atom_dd1e4d10(nil)
	gRegion:__wf_atom_dd1e4d10(v17)

	if gRegion:IsMaster() then
		gRegion:__wf_atom_dd1e4d10(v30)
		gRegion:__wf_atom_dd1e4d10(nil)
		gRegion:__wf_atom_dd1e4d10(v31)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WaterSimTrigger"))

	if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(v65)) then
		__wf_atom_0a6a5887:__wf_atom_f947c7cc(v65)
	end

	module5.RegisterPreventNighfoldUsage(false)
	OnShutdown()

	if not __wf_atom_7e8ad928(avatar) and avatar:__wf_atom_8efce136() then
		module.StopLocalCustomMusicSequencer(musicGameplayMixEffect)
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:Stop(false)
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:Stop(false)
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Stop(false)
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Stop(false)
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Stop(false)
	end

	if not __wf_atom_7e8ad928(carryOverStingerEndSound) then
		module8.PlaySound(carryOverStingerEndSound)
	end

	if not __wf_atom_7e8ad928(mFishReticleMovie) then
		mFishReticleMovie:Close()
	end

	module6.RegisterHideHudSelective(false)

	if _T.HideImpactMessage ~= nil then
		_T.HideImpactMessage()
	end

	if _T.WarsongFishCaught then
		_T.WarsongFishingCompleted = true
	end

	mMovie:Close()
end

function RequestShutdown()
	if flag8 or v13 == 8 then
		return
	end

	flag8 = true
	module7.SetChatVisible(true)
end

function DissolveInSpoolAfter(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v67 = 0

	while v67 < 1 do
		v67 = __wf_atom_421b01aa(v67 + __wf_atom_084b3e93(), 0, 1)
		object:__wf_atom_a763aa1a(1 - v67 / 1)
		Sleep(0)
	end
end

local function fn7(p, p2, p3, p4, p5, p6)
	local v67 = 1 - p6
	return p * v67 * v67 * v67 * v67 + p2 * 4 * v67 * v67 * v67 * p6 + p3 * 6 * v67 * v67 * p6 * p6 + p4 * 4 * v67 * p6 * p6 * p6 + p5 * p6 * p6 * p6 * p6
end

local function fn8(p, p2, p3)
	local v67 = p2 - p
	local v68 = p3 - p
	local v69 = v67.x * v67.x + v67.z * v67.z

	if v69 <= 0.0001 then
		return p
	end

	local v70 = __wf_atom_421b01aa((v68.x * v67.x + v68.z * v67.z) / v69, 0, 1)
	return p + (p2 - p) * v70, v70
end

local function fn9(mInitialLobPosition, mInitialLobVelocity, p)
	local v67 = p - mInitialLobPosition
	local v68 = math.max(Length(v67 * Vector(1, 0, 1)), 0.0001)
	local y = v67.y
	local v69 = math.max(mInitialLobVelocity, (math.sqrt(v10.GRAVITY * (y + math.sqrt(v68 * v68 + y * y)))))
	local v70 = v69 * v69
	local v71 = math.max(0.0001, v70 * v70 - v10.GRAVITY * (v10.GRAVITY * v68 * v68 + 2 * y * v70))
	local v72 = v10.GRAVITY * v68
	local v73 = math.sqrt(v71)
	local v74 = (v70 - v73) / v72
	local v75 = (v70 + v73) / v72
	return -math.min(module8.ToDeg((math.atan(v74))), (module8.ToDeg((math.atan(v75))))), v69
end

local function fn10(p, mInitialLobRotation, mInitialLobVelocity, p2)
	local v67 = math.rad(-mInitialLobRotation.pitch)
	local v68 = mInitialLobVelocity * math.cos(v67)
	local v69 = mInitialLobVelocity * math.sin(v67)
	local v70 = __wf_atom_9341614d(Vector(0, 0, 1), Rotation(mInitialLobRotation.heading, 0, 0))
	local v71 = p + v70 * (v68 * p2)
	v71.y = p.y + v69 * p2 - 0.5 * v10.GRAVITY * p2 * p2
	local v72 = v70 * v68
	v72.y = v69 - v10.GRAVITY * p2
	return v71, (__wf_atom_fa8d0177(v71, v71 + v72))
end

local function fn11(__wf_atom_28d5d4aa, p, p2)
	local v67 = v39.mLineHandPosition - __wf_atom_28d5d4aa3
	Normalize(v67)
	return (math.max(
		0,
		(Dot(__wf_atom_28d5d4aa, v67) * (1 - v46.mFishForceBias) * 2 - Dot(p, v67) * v46.mFishForceBias * 2) * p2
	))
end

local function fn12(p, p2)
	local v67 = __wf_atom_7e8ad928(p) and true or p

	if v67 then
		flag4 = true
	end

	local mFishStrugglePerpendicularVector = __wf_atom_28d5d4aa3 - __wf_atom_28d5d4aa2
	mFishStrugglePerpendicularVector.y = 0
	v56.mFishStrugglePerpendicularVector = mFishStrugglePerpendicularVector
	Normalize(v56.mFishStrugglePerpendicularVector)
	local z = v56.mFishStrugglePerpendicularVector.z
	local v69 = -v56.mFishStrugglePerpendicularVector.x
	v56.mFishStruggleDirectionVector = Vector(z, 0, v69)
	v56.mCurrStruggleDuration = __wf_atom_104bfe98(
		v56.mStruggleDuration.minValue,
		v56.mStruggleDuration.maxValue,
		math.random()
	)
	v56.mCurrBackStruggleAccel = __wf_atom_104bfe98(
		v56.mBackStruggleRange.minValue,
		v56.mBackStruggleRange.maxValue,
		math.random()
	)
	v56.mCurrSideStruggleAccel = __wf_atom_104bfe98(
		v56.mSideStruggleRange.minValue,
		v56.mSideStruggleRange.maxValue,
		math.random()
	)
	v56.mCurrBackStruggleAccel *= v56.mStruggleStrength
	v56.mCurrSideStruggleAccel *= v56.mStruggleStrength

	if __wf_atom_7e8ad928(p2) then
		if math.random() > 0.5 then
			v56.mCurrSideStruggleAccel *= -1
		end
	else
		v56.mCurrSideStruggleAccel *= p2
	end

	if not flag4 then
		v56.mCurrStruggleDuration *= v56.mStruggleDurationPassiveMultiplier
		v56.mCurrSideStruggleAccel *= v56.mStruggleStrengthPassiveMultiplier
		v56.mCurrBackStruggleAccel *= v56.mStruggleStrengthPassiveMultiplier
	end

	v56.mRemainingStruggleTime = v56.mCurrStruggleDuration
	v56.mSideStruggleSeed = math.random() * 1000
	v56.mBackStruggleSeed = math.random() * 1000

	if v67 then
		v56.mRemainingFishStamina = v56.mFishStamina

		if _T.fishingDebugInfiniteStamina then
			v56.mRemainingFishStamina = 99999
		end

		v58.mTimeUntilNextJump = math.max(v58.mMinTimeBeforeJump, v58.mTimeUntilNextJump)
		v56.mFishMaxStruggleDist = Distance(v39.mLineHandPosition, __wf_atom_28d5d4aa3)
		local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

		if __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) then
			return
		end

		if __wf_atom_7e8ad928(v26) then
			v26 = __wf_atom_296472bc.mFishOnHook:Attach(
				fishStruggleSplashType,
				Symbol(""),
				__wf_atom_28d5d4aa,
				Rotation(0, 180, 0)
			)
		end

		v26:FirePort("Enable")
		__wf_atom_296472bc.mFishOnHook:StopAnimation()
		__wf_atom_296472bc.mFishOnHook:__wf_atom_921c1a5f(fishStruggleAnim, false, true, 1)
	end
end

local function fn13(p)
	flag4 = false
	v56.mIsInFirstFight = false
	v56.mRemainingFishStamina = 0

	if p then
		v56.mTimeUntilNextStruggle = v56.mStruggleCooldown.maxValue
	else
		v56.mTimeUntilNextStruggle = __wf_atom_104bfe98(
			v56.mStruggleCooldown.minValue,
			v56.mStruggleCooldown.maxValue,
			math.random()
		)
	end

	v56.mTimeUntilNextStruggle += v56.mNumRests * v56.mRestDurationIncreasePerRest
	v56.mNumRests += 1

	if not __wf_atom_7e8ad928(v26) then
		v26:FirePort("Disable")
	end

	v46.mIsShowingDirection = false
	__wf_atom_7e8ad928(v27)
	fn12(false, math.sign(v56.mCurrSideStruggleAccel))
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if not __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) then
		__wf_atom_296472bc.mFishOnHook:StopAnimation()
		__wf_atom_296472bc.mFishOnHook:__wf_atom_f173c8ad(true)
	end
end

local function fn14()
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) then
		return
	end

	if flag5 then
		local statForPlayerLevel = module4.GetStatForPlayerLevel(avatar, v10.FISH_JUMP_STUN_DAMAGE)
		v56.mRemainingFishStamina = math.max(0, v56.mRemainingFishStamina - statForPlayerLevel)

		if v56.mRemainingFishStamina == 0 then
			flag3 = true
			__wf_atom_28d5d4aa5 = Vector(0, __wf_atom_28d5d4aa5.y, 0)
		end

		__wf_atom_296472bc.mFishOnHook:__wf_atom_921c1a5f(fishJumpStunAnim, false, false, 1, EMPTY_SYMBOL, 1)
	else
		local statForPlayerLevel = module4.GetStatForPlayerLevel(avatar, v10.FISH_PERFECT_HOOK_STUN_DAMAGE)
		v56.mRemainingFishStamina = math.max(0, v56.mRemainingFishStamina - statForPlayerLevel)

		if v56.mRemainingFishStamina == 0 then
			fn13(true)
		end
	end

	OnFishStunStart()

	if __wf_atom_7e8ad928(avatar) then
		return
	end

	local statForPlayerLevel = module4.GetStatForPlayerLevel(avatar, v10.FISH_STUN_VFX_LEVEL)

	if not __wf_atom_7e8ad928(_T.fishingDebugSelectedStunVfx) and _T.fishingDebugSelectedStunVfx > 1 then
		statForPlayerLevel = _T.fishingDebugSelectedStunVfx - 1
	end

	local fishStunFXType = fishStunFXTypes[statForPlayerLevel]

	if not __wf_atom_7e8ad928(fishStunFXType) then
		__wf_atom_296472bc.mFishOnHook:Attach(fishStunFXType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

local function fn15(object, p, p2) -- 11 equivalent calls inferred from this helper
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	__wf_atom_a96eb2aa:__wf_atom_a6c0f1b8(4, p, p, p2)
end

local function fn16()
	if not flag5 or v58.mInputtedJumpStun or v56.mPlayerStunRemainingTime > 0 then
		return
	end

	v58.mInputtedJumpStun = true

	if (v58.mCanStunFish or _T.fishingDebugAlwaysStun) and not _T.fishingDebugAlwaysFailStun then
		fn14()
		avatar:__wf_atom_8a035cd5(Symbol("ShakeCameraSpotMedium"), false)
		fn15(avatar, 0.6, 0.3) -- inferred equivalent call
	else
		v46.mRemainingStamina = math.max(0, v46.mRemainingStamina - v58.mStunAttemptStaminaDrain)
		okay = STAMINA_STATE.IN_USE

		if v56.mFailedAttemptPlayerDamage > 0 or _T.fishingDebugAlwaysFailStun then
			v47.mLinePulseRemainingTime = v47.mLinePulseDuration
			local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

			if not (__wf_atom_7e8ad928(fishStunLineFXType) or __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook)) then
				v47.mStunLineFx = gRegion:CreateEntity(
					fishStunLineFXType,
					__wf_atom_296472bc.mFishOnHook:GetPosition(),
					__wf_atom_80368bb1
				)
			end
		end

		OnFishStunFail()
		avatar:__wf_atom_8a035cd5(Symbol("ShakeCameraSpotSmall"), false)
		fn15(avatar, 0.2, 0.15) -- inferred equivalent call
	end

	if not __wf_atom_7e8ad928(avatar) then
		avatar:__wf_atom_e06358f3(v9.mFishingBiteReactAnimAction, true)
	end
end

local function fn17()
	if
		v13 == 7 and not (__wf_atom_28d5d4aa3.y < __wf_atom_28d5d4aa2.y)
		or GetTargetDistance() < v58.mMinJumpDistance
	then
		return false
	end

	local v67 = __wf_atom_104bfe98(v58.mJumpDistance.minValue, v58.mJumpDistance.maxValue, math.random())
	local v68 = GetTargetDistance()
	local v69 = math.asin((__wf_atom_421b01aa(v67 / (2 * v68), 0, 1))) * 360 / 3.141592653589793

	if math.sign(v56.mCurrSideStruggleAccel) < 0 then
		v69 *= -1
	end

	local heading2 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa2, __wf_atom_28d5d4aa3).heading
	local angle = module8.WrapAngle(heading2 - heading)
	local angle2 = module8.WrapAngle(angle + v69)
	local v70 = GetPositionFromHeadingDistance(angle2 + heading, v68)
	local v71 = __wf_atom_28d5d4aa3
	local v72 = fn2(v71, v70, false)
	local v73 = Distance(v71, v72)
	local v74

	if v73 < v67 then
		local angle3 = module8.WrapAngle(angle - v69)
		v74 = fn2(v71, GetPositionFromHeadingDistance(angle3 + heading, v68), false)
		local v76 = Distance(v71, v74)

		if v73 < v76 then
			v73 = v76
		else
			v74 = v72
		end
	else
		v74 = v72
	end

	if v73 < v10.FISH_JUMP_CHECK_MARGIN then
		return false
	end

	local v75 = Vector()
	local v76 = Vector(__wf_atom_28d5d4aa3.x, __wf_atom_28d5d4aa2.y - 0.5, __wf_atom_28d5d4aa3.z)

	if not __wf_atom_7e8ad928((gRegion:Raycast(__wf_atom_28d5d4aa3, v76, nil, nil, v75, true, true))) then
		return false
	end

	local v77 = ClampPositionHeadingDistance(v71, -v10.MAX_CAST_HEADING, v10.MAX_CAST_HEADING, 0, 1000)
	local v78 = ClampPositionHeadingDistance(v74, -v10.MAX_CAST_HEADING, v10.MAX_CAST_HEADING, 0, 1000)
	local v79 = v78 - v77
	Normalize(v79)
	v58.mCurrJumpPower = __wf_atom_104bfe98(v58.mJumpVertPower.minValue, v58.mJumpVertPower.maxValue, math.random()) * math.sqrt(v58.mJumpSpeedMultiplier)
	v58.mRemainingJumpTime = 2 * v58.mCurrJumpPower / (v10.GRAVITY * v58.mJumpSpeedMultiplier)
	v58.mJumpApexTime = v58.mRemainingJumpTime / 2
	v58.mInputtedJumpStun = false
	v58.mShowedWindowIndicator = false
	local _ = v58.mJumpStunTimingWindowPercentage * v58.mJumpApexTime
	v58.mJumpStunWindowStartTime = v58.mJumpApexTime + v10.STUN_WINDOW_INDICATOR_BUFFER_TIME
	local v80 = v79 * (Distance(v78, v77) / v58.mRemainingJumpTime)
	local v81 = (__wf_atom_28d5d4aa2.y - __wf_atom_28d5d4aa3.y + 0.01) / v58.mCurrJumpPower
	v58.mJumpAccel = (v80 - __wf_atom_28d5d4aa5) / v81
	v58.mJumpTargetVelocity = v80 + Vector(0, v58.mCurrJumpPower, 0)
	v56.mCurrSideStruggleAccel = 0
	v56.mCurrBackStruggleAccel = 0
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if not __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) and __wf_atom_7e8ad928(v28) then
		v28 = __wf_atom_296472bc.mFishOnHook:Attach(
			fishStunWindowTelegraphProjectorType,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)
		module8.PlaySound(fishStunWindowTelegraphSound)
	end

	if not __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) then
		local v82 = fishJumpStartAnim:__wf_atom_8bb4ded3() / v81
		__wf_atom_296472bc.mFishOnHook:StopAnimation()
		__wf_atom_296472bc.mFishOnHook:__wf_atom_921c1a5f(fishJumpStartAnim, false, false, 1, EMPTY_SYMBOL, v82)
	end

	v46.mIsShowingDirection = false
	__wf_atom_7e8ad928(v27)
	flag5 = true
	flag6 = false
	return true
end

local function fn18()
	if not flag3 then
		fn15(avatar, 0.2, 0.15) -- inferred equivalent call
	end

	mLureDeco:Attach(baitLandSplashType, Symbol(""), __wf_atom_28d5d4aa, Rotation(0, 90, 0))
	OnHitWaterFromJump()
end

local function fn19()
	flag6 = true
	__wf_atom_28d5d4aa5 = v58.mJumpTargetVelocity
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()
	local fishJumpAnim = fishJumpAnims[__wf_atom_5784a397(1, #fishJumpAnims)]

	if not __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) then
		local v67 = fishJumpAnim:__wf_atom_8bb4ded3() / v58.mRemainingJumpTime
		__wf_atom_296472bc.mFishOnHook:StopAnimation()
		__wf_atom_296472bc.mFishOnHook:__wf_atom_921c1a5f(fishJumpAnim, false, false, 1, EMPTY_SYMBOL, v67)
	end

	fn15(avatar, 0.2, 0.15) -- inferred equivalent call

	if not __wf_atom_7e8ad928(v26) then
		v26:FirePort("Disable")
	end

	mLureDeco:Attach(baitLandSplashType, Symbol(""), __wf_atom_28d5d4aa, Rotation(0, 90, 0))
	OnLeaveWaterFromJump()
end

local function fn20()
	flag5 = false
	v58.mTimeUntilNextJump = __wf_atom_104bfe98(v58.mJumpCooldown.minValue, v58.mJumpCooldown.maxValue, math.random())

	if flag3 then
		fn13(true)
		flag3 = false
	else
		fn12(false)
	end

	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) then
		return
	end

	if flag4 then
		__wf_atom_296472bc.mFishOnHook:__wf_atom_921c1a5f(fishStruggleAnim, false, true, 1)

		if __wf_atom_7e8ad928(v26) then
			v26 = __wf_atom_296472bc.mFishOnHook:Attach(
				fishStruggleSplashType,
				Symbol(""),
				__wf_atom_28d5d4aa,
				Rotation(0, 180, 0)
			)
		end

		v26:FirePort("Enable")
	end
end

function CalculateFishResistance(p)
	if __wf_atom_7e8ad928(avatar) then
		return __wf_atom_28d5d4aa
	end

	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) then
		return __wf_atom_28d5d4aa
	end

	local __wf_atom_28d5d4aa7 = __wf_atom_28d5d4aa
	local v67 = 0
	local v68 = 0

	if flag5 then
		if flag6 then
			v58.mRemainingJumpTime -= p

			if v58.mRemainingJumpTime <= 0 then
				v58.mCanStunFish = false
				fn18()
				fn20()
			else
				local v70 = v58.mJumpStunTimingWindowPercentage * v58.mJumpApexTime
				local v71 = math.abs(v58.mRemainingJumpTime - v58.mJumpApexTime)
				v58.mCanStunFish = v71 < v70

				if v58.mCanStunFish then
					local v72 = 1 - v71 / v70

					if not __wf_atom_7e8ad928(v28) then
						v28:SetMaterialParam(Symbol("AlphaAtten"), 2 * v72)
						v28:SetMaterialParam(Symbol("SineProgress"), v72)
					end

					if not v58.mShowedWindowIndicator and v58.mRemainingJumpTime <= v58.mJumpStunWindowStartTime then
						v58.mShowedWindowIndicator = true

						if not __wf_atom_7e8ad928(fishStunWindowTelegraphFlareType) then
							__wf_atom_296472bc.mFishOnHook:Attach(
								fishStunWindowTelegraphFlareType,
								EMPTY_SYMBOL,
								__wf_atom_28d5d4aa,
								__wf_atom_80368bb1
							)
						end
					end
				end
			end
		else
			__wf_atom_28d5d4aa7 = v58.mJumpAccel
			__wf_atom_28d5d4aa5 = Vector(__wf_atom_28d5d4aa5.x, v58.mJumpTargetVelocity.y, __wf_atom_28d5d4aa5.z)

			if __wf_atom_28d5d4aa3.y + __wf_atom_28d5d4aa5.y * p >= __wf_atom_28d5d4aa2.y then
				fn19()
				__wf_atom_28d5d4aa7 = __wf_atom_28d5d4aa
			end
		end
	else
		v56.mRemainingStruggleTime -= p

		if v56.mRemainingStruggleTime <= 0 then
			fn12(false)
		end

		if v56.mRemainingFishStamina > 0 then
			if v56.mIsInFirstFight then
				v56.mRemainingInitialResistanceTime -= p

				if v56.mRemainingInitialResistanceTime <= 0 then
					v56.mIsInFirstFight = false
				end
			else
				local v70 = v14.mReelHorizontalInput < 0 and -1 or 0
				local v71 = v14.mReelHorizontalInput > 0 and 1 or v70

				if v71 ~= 0 and v71 ~= math.sign(v56.mCurrSideStruggleAccel) then
					v56.mRemainingFishStamina -= p * v56.mFishStaminaDrain
				end
			end

			v67 = __wf_atom_a3cc989c(v56.mRemainingStruggleTime * v56.mSideStruggleRandomFrequency + v56.mSideStruggleSeed) * v56.mSideStruggleRandomGain * v56.mCurrSideStruggleAccel
			v68 = Noise(v56.mRemainingStruggleTime * v56.mBackStruggleRandomFrequency + v56.mBackStruggleSeed) * v56.mBackStruggleRandomGain * v56.mCurrBackStruggleAccel

			if v56.mRemainingFishStamina <= 0 then
				fn13()
			elseif not v56.mIsInFirstFight then
				v58.mTimeUntilNextJump -= p

				if v58.mTimeUntilNextJump <= 0 and not fn17() then
					v58.mTimeUntilNextJump = __wf_atom_104bfe98(
						v58.mJumpCooldown.minValue,
						v58.mJumpCooldown.maxValue,
						math.random()
					)
				end
			end
		else
			v56.mTimeUntilNextStruggle -= p
			local v71 = v56.mSideStruggleRandomFrequency * v56.mStruggleRandomFrequencyPassiveMultiplier
			local v72 = v56.mBackStruggleRandomFrequency * v56.mStruggleRandomFrequencyPassiveMultiplier
			local v73 = __wf_atom_a3cc989c(v56.mRemainingStruggleTime * v71 + v56.mSideStruggleSeed) * v56.mSideStruggleRandomGain * v56.mCurrSideStruggleAccel
			local v74 = Noise(v56.mRemainingStruggleTime * v72 + v56.mBackStruggleSeed) * v56.mBackStruggleRandomGain * v56.mCurrBackStruggleAccel
			v67 = v73 * v56.mStruggleRandomGainPassiveMultiplier
			v68 = v74 * v56.mStruggleRandomGainPassiveMultiplier

			if v56.mTimeUntilNextStruggle <= 0 then
				fn12(true)
			end
		end
	end

	local v69 = v56.mCurrSideStruggleAccel + v67
	local v70 = math.max(0, v56.mCurrBackStruggleAccel + v68)
	local v71 = __wf_atom_28d5d4aa7 + (v56.mFishStruggleDirectionVector * v69 + v56.mFishStrugglePerpendicularVector * v70)

	if v56.mIsInFirstFight then
		local v72 = v56.mRemainingInitialResistanceTime / v56.mInitialResistanceDuration
		v71 *= __wf_atom_104bfe98(1, v56.mInitialResistanceMultiplier, v72)
	end

	if not flag5 then
		local v72 = Vector(v71.x, 0, v71.z)
		Normalize(v72)
		local v73 = __wf_atom_28d5d4aa3 + v72 * v10.FISH_SWIM_CHECK_MARGIN
		local v74 = Vector()

		if not __wf_atom_7e8ad928((gRegion:Raycast(__wf_atom_28d5d4aa3, v73, nil, nil, v74, true, true))) then
			fn12(false)
		end

		if v56.mIsFishStuck then
			v56.mTimeUntilSwitch -= p

			if v56.mTimeUntilSwitch <= 0 then
				v56.mTimeUntilSwitch = v56.mFishStuckSwitchTime
				fn12(false)
			end
		end
	end

	_T.FishRestDuration = v56.mTimeUntilNextStruggle
	_T.FishRemainingStamina = v56.mRemainingFishStamina
	_T.FishCanStun = tostring(v58.mCanStunFish)
	local v72 = Vector(v71.x, 0, v71.z)

	if v13 ~= 7 or __wf_atom_28d5d4aa3.y < __wf_atom_28d5d4aa2.y then
		if flag3 then
			v72 = Vector(__wf_atom_28d5d4aa5.x, 0, __wf_atom_28d5d4aa5.z)
		end
	else
		v72 = Vector(v58.mJumpTargetVelocity.x, 0, v58.mJumpTargetVelocity.z)
	end

	local v73 = __wf_atom_28d5d4aa3 + v72 * p
	__wf_atom_80368bb1_4 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa3, v73)

	if flag5 then
		return v71
	end

	return __wf_atom_9341614d(Vector(0, 0, 1), Rotation(__wf_atom_80368bb1_3.heading, 0, 0)) * math.sqrt(v71.x * v71.x + v71.z * v71.z)
end

function GetLureLinePosition()
	return mLureDeco:GetPosition() + __wf_atom_9341614d(Vector(0, -0.02, 0), mLureDeco:__wf_atom_dc309f8a())
end

local function fn21(p) -- 4 equivalent calls inferred from this helper
	local v67 = __wf_atom_421b01aa(p, 0, 1)
	return 1 - (1 - v67) * (1 - v67) * (1 - v67)
end

function GetSweetSpotLerp(p)
	if not __wf_atom_7e8ad928(mFishReticleMovie) then
		return 1
	end

	local v67 = p % 1
	local ternary = module8.Ternary(v67 < 0.5, v67 * 2, 2 - v67 * 2)
	local __wf_atom_104bfe98 = __wf_atom_104bfe98
	return __wf_atom_104bfe98(0, 1, fn21(ternary)) -- inferred equivalent call
end

local function fn22(p) -- 3 equivalent calls inferred from this helper
	local v67 = __wf_atom_421b01aa(p, 0, 1)
	return 1 - (1 - v67) * (1 - v67)
end

function GetSweetSpotLerpQuadratic(p)
	local v67 = p % 1
	local ternary = module8.Ternary(v67 < 0.5, v67 * 2, 2 - v67 * 2)
	local __wf_atom_104bfe98 = __wf_atom_104bfe98
	return __wf_atom_104bfe98(0, 1, fn22(ternary)) -- inferred equivalent call
end

function GetSweetSpotDelta()
	local __wf_atom_1c374cc9 = avatar:__wf_atom_1c374cc9(Symbol("GAME_R1_FINGER3"))
	local v67 = GetLureLinePosition()
	local v68 = __wf_atom_f55d6358(__wf_atom_1c374cc9, GetLureLinePosition(), 0.5)
	local angle = module8.WrapAngle(heading + 90)
	local heading2 = __wf_atom_fa8d0177(v68, v67).heading
	local v69 = math.abs((module8.WrapAngle(angle - heading2)))
	return (__wf_atom_421b01aa(v69 / 180, 0, 1))
end

local function fn23()
	if __wf_atom_7e8ad928(avatar) then
		return
	end

	local v67 = avatar:GetPosition() + __wf_atom_9341614d(v12.OTS_CAMERA_SPOT_FAR_OFFSET, Rotation(heading, 0, 0))
	local v68 = __wf_atom_fa8d0177(v67, __wf_atom_28d5d4aa3)
	v12.mSmoothCameraSpotPos[1]:__wf_atom_4453e49c(v12.OTS_CAMERA_SPOT_FAR_OFFSET.x)
	v12.mSmoothCameraSpotPos[2]:__wf_atom_4453e49c(v12.OTS_CAMERA_SPOT_FAR_OFFSET.y)
	v12.mSmoothCameraSpotPos[3]:__wf_atom_4453e49c(v12.OTS_CAMERA_SPOT_FAR_OFFSET.z)

	if __wf_atom_7e8ad928(v16) then
		local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(cameraSpotType, v67, 5)

		if __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
			v16 = gRegion:CreateEntity(cameraSpotType, v67, v68)
		else
			v16 = __wf_atom_e2db08ce
		end
	end

	avatar:CameraControl():__wf_atom_fd14c463(1)
	avatar:CameraControl():SetCameraSpot(v16, 0.4)
end

local function fn24()
	local v67 = 2
	v13 = v67
	avatar:__wf_atom_037ae4a8(v67)
	__wf_atom_7e8ad928(mLureDeco)

	if not __wf_atom_7e8ad928(v5) then
		v5:Stop(false)
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:Stop(false)
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Stop(false)
	end
end

local function fn25()
	local v67 = GetTargetDistance()
	v43.mSettleMovementDistance = v67 * v10.SETTLE_FRACTION
	v43.mInitialLobVelocity = v10.BASE_LOB_VELOCITY + v67 * v10.LOB_VELOCITY_PER_DISTANCE
	v43.mAirControlOffset = Vector()
	local heading2 = __wf_atom_fa8d0177(v43.mInitialLobPosition, __wf_atom_28d5d4aa3).heading
	local v68 = __wf_atom_28d5d4aa3 + __wf_atom_9341614d(
		Vector(0, 0, v43.mSettleMovementDistance),
		Rotation(__wf_atom_fa8d0177(__wf_atom_28d5d4aa3, v43.mInitialLobPosition).heading, 0, 0)
	)
	local v69, mInitialLobVelocity = fn9(v43.mInitialLobPosition, v43.mInitialLobVelocity, v68)
	v43.mInitialLobVelocity = mInitialLobVelocity
	v43.mInitialLobRotation = Rotation(heading2, v69, 0)
	v43.mInitialLobTime = Time()
	local v71 = math.rad(-v69)
	local v72 = v43.mInitialLobVelocity * math.cos(v71)
	v43.mLureEnterWaterTime = v43.mInitialLobTime + module3.Distance2d(v43.mInitialLobPosition, v68) / v72
	v43.mLureImpactVerticalVelocity = v43.mInitialLobVelocity * math.sin(v71) - v10.GRAVITY * (v43.mLureEnterWaterTime - v43.mInitialLobTime)
	local v74 = 0.4 * -v43.mLureImpactVerticalVelocity
	v43.mLureSettledTime = v43.mLureEnterWaterTime + v74
	v42:__wf_atom_4453e49c(0)
	avatar:__wf_atom_78ad8b9f(139, 0)

	if not __wf_atom_7e8ad928(mLureDeco) then
		v19 = mLureDeco:Attach(lureTrailType, Symbol(""), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	avatar:__wf_atom_8a035cd5(Symbol("ShakeCameraSpotSmall"), false)
	fn15(avatar, 0.2, 0.15) -- inferred equivalent call
	_T.fishingLureImpactTime = v43.mLureEnterWaterTime
	OnLureLob(v60.mIsPerfectCast)
end

function WaitForLob()
	if not __wf_atom_7e8ad928(v22) then
		v22:Destroy()
	end

	avatar:__wf_atom_8914dfde(v9.mFishingCastLobAnimEvent, 3)

	if __wf_atom_7e8ad928(avatar) or flag8 or flag7 then
		return
	end

	avatar:__wf_atom_e06358f3(v9.mFishingReelIdleAnimAction, true)
	fn25()
end

local function fn26()
	local v67 = Vector()

	if
		not __wf_atom_7e8ad928((gRegion:__wf_atom_3ec9f18c(
			__wf_atom_28d5d4aa3 + Vector(0, 5, 0),
			__wf_atom_28d5d4aa3 + Vector(0, -5, 0),
			0.5,
			nil,
			v67,
			true,
			true
		)))
		and v67.y > __wf_atom_28d5d4aa2.y
	then
		fn24()
		return
	end

	if not __wf_atom_7e8ad928(mLureDeco) then
		mLureDeco:__wf_atom_dc5956fc(nil, Symbol("GAME_R1_WEAPON1"))
	end

	local v68 = 4
	v13 = v68
	avatar:__wf_atom_037ae4a8(v68)
	mFishReticleMovie:Execute("GetCastingResults", "")
	v60.mIsPerfectCast = false

	if _T.FishingCastResults == "PERFECT" or _T.FishingCastResults == "SNEAKY" then
		v60.mIsPerfectCast = true
		v60.mSweetSpotDelta = 0
	elseif _T.FishingCastResults == "FINE" then
		v60.mSweetSpotDelta = 0.25
	elseif _T.FishingCastResults == "BOTCH" then
		v60.mSweetSpotDelta = 1
	end

	_T.fishingIsPerfectCast = v60.mIsPerfectCast
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()
	__wf_atom_296472bc.mPerfectStreak = module8.Ternary(v60.mIsPerfectCast, __wf_atom_296472bc.mPerfectStreak + 1, 0)
	__wf_atom_296472bc.mPerfectStreak = math.min(__wf_atom_296472bc.mPerfectStreak, v10.MAX_PERFECT_STREAK)
	avatar:__wf_atom_aabc9a96(__wf_atom_296472bc)
	local v69 = v60.mSweetSpotDelta * v10.MAX_SWEET_SPOT_DEVIATION
	local v70 = Rotation(math.random() * 360, 0, 0)
	local v72 = fn21(math.sqrt((math.random()))) * v69 -- inferred equivalent call
	local v73 = __wf_atom_28d5d4aa3 + __wf_atom_9341614d(Vector(0, 0, v72), v70)

	if __wf_atom_a93b9922(__wf_atom_28d5d4aa3, v73) > 0.010000000000000002 then
		local v74 = Vector()

		if not __wf_atom_7e8ad928((gRegion:__wf_atom_3ec9f18c(__wf_atom_28d5d4aa3, v73, 0.5, nil, v74, true, true))) then
			v73 = v74 + __wf_atom_9341614d(Vector(0, 0, 0.5), __wf_atom_fa8d0177(v73, __wf_atom_28d5d4aa3))
		end
	end

	__wf_atom_28d5d4aa3 = ClampToPlayableArea(v73, 0.5)
	v21:Teleport(__wf_atom_28d5d4aa3, GetTargetDirection())
	v61 = 0
	v39.mFishingLineHandSwitchTime = 0
	v39.mLineSnapped = false
	v39.mLineSnapDistance = 1
	avatar:__wf_atom_e06358f3(v9.mFishingCastAnimAction, true)
	avatar:__wf_atom_8a035cd5(Symbol("WaitForLob"), false)
	OnCast(v60.mIsPerfectCast)
end

local function fn27(mFishOnHook)
	if __wf_atom_7e8ad928(mFishOnHook) then
		return
	end

	mFishOnHook:StopAnimation()
	mFishOnHook:__wf_atom_7b7015c9(fishSwimAnim)
	mFishOnHook:__wf_atom_f173c8ad()
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()
	__wf_atom_296472bc.mPerfectStreak = module8.Ternary(
		not __wf_atom_7e8ad928(_T.SetFishHook) and _T.SetFishHook == 2,
		__wf_atom_296472bc.mPerfectStreak + 1,
		0
	)
	__wf_atom_296472bc.mPerfectStreak = math.min(__wf_atom_296472bc.mPerfectStreak, v10.MAX_PERFECT_STREAK)
	avatar:__wf_atom_aabc9a96(__wf_atom_296472bc)
	avatar:__wf_atom_8a035cd5(Symbol("ShakeCameraSpotMedium"), false)
	fn15(avatar, 0.3, 0.3) -- inferred equivalent call
	local __wf_atom_296472bc2 = avatar:__wf_atom_296472bc()
	__wf_atom_296472bc2.mFishOnHook = mFishOnHook
	avatar:__wf_atom_aabc9a96(__wf_atom_296472bc2)
	fn6(mFishOnHook)
	local v67 = 7
	v13 = v67
	avatar:__wf_atom_037ae4a8(v67)
	avatar:__wf_atom_e06358f3(v9.mFishingBiteReactAnimAction, true)
	v58.mTimeUntilNextJump = __wf_atom_104bfe98(v58.mJumpCooldown.minValue, v58.mJumpCooldown.maxValue, math.random())
	v56.mFishMaxStruggleDist = Distance(v39.mLineHandPosition, __wf_atom_28d5d4aa3)
	v46.mRemainingStamina = 1
	flag5 = false
	__wf_atom_80368bb1_3 = mFishOnHook:__wf_atom_dc309f8a()
	v56.mIsInFirstFight = true
	v56.mRemainingInitialResistanceTime = v56.mInitialResistanceDuration
	fn12(true)

	if _T.fishingDebugAlwaysStun or _T.SetFishHook == 2 then
		fn14()
	end

	__wf_atom_28d5d4aa3 = mFishOnHook:GetPosition()
	v50 = GetTargetDistance()
	mFishOnHook:__wf_atom_032e99b2(5)

	if not __wf_atom_7e8ad928(fishBiteFXType) then
		biteFishFx = mFishOnHook:Attach(fishBiteFXType, Symbol("GAME_C1_JAW1"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	fn23()
	_T.WarsongFishingHooked = true
	OnFishHooked()
	module.SetLocalCustomMusicSequencerState(2)
end

function WaitUntilTugAnimEvent()
	Sleep(0)

	if
		flag8
		or flag7
		or __wf_atom_7e8ad928(avatar)
		or not avatar:__wf_atom_7bcdbf55(v9.mFishingBiteReactAnimAction)
	then
		return
	end

	avatar:__wf_atom_8914dfde(v9.mFishingTugAnimEvent, 2)

	if flag8 or flag7 or __wf_atom_7e8ad928(avatar) then
		return
	end

	v39.mTugTime = Time()
	avatar:__wf_atom_8914dfde(v9.mFishingTugLureBobAnimEvent, 2)

	if flag8 or flag7 or __wf_atom_7e8ad928(avatar) then
		return
	end

	if __wf_atom_7e8ad928(avatar:__wf_atom_296472bc().mFishOnHook) then
		v40.mLureVelocity += v10.TUG_VERTICAL_VELOCITY
		TUG_HORIZONTAL_VELOCITY = v10.TUG_HORIZONTAL_VELOCITY
	end

	avatar:__wf_atom_8a035cd5(Symbol("ShakeCameraSpotSmall"), false)
	fn15(avatar, 0.2, 0.15) -- inferred equivalent call
	OnTugLureHopStart()
end

local function fn28()
	if
		__wf_atom_7e8ad928(avatar)
		or avatar:__wf_atom_7bcdbf55(v9.mFishingBiteReactAnimAction)
		or avatar:__wf_atom_7bcdbf55(v9.mFishingLeftTugAnimAction)
		or avatar:__wf_atom_7bcdbf55(v9.mFishingRightTugAnimAction)
	then
		return
	end

	if not __wf_atom_7e8ad928(v44.mLastTugTime) and Time() < v44.mLastTugTime + v10.TUG_COOLDOWN then
		return
	end

	v44.mLastTugTime = Time()
	avatar:__wf_atom_e06358f3(v9.mFishingBiteReactAnimAction, true)
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()
	__wf_atom_296472bc.mLureTugTime = Time()
	avatar:__wf_atom_aabc9a96(__wf_atom_296472bc)
	OnTugStart()
	avatar:__wf_atom_8a035cd5(Symbol("WaitUntilTugAnimEvent"), false)
end

function WaitUntilSideTugAnimEvent()
	Sleep(0)

	if
		flag8
		or flag7
		or __wf_atom_7e8ad928(avatar)
		or not (avatar:__wf_atom_7bcdbf55(v9.mFishingLeftTugAnimAction) or avatar:__wf_atom_7bcdbf55(v9.mFishingRightTugAnimAction))
	then
		return
	end

	avatar:__wf_atom_8914dfde(v9.mFishingTugAnimEvent, 2)

	if flag8 or flag7 or __wf_atom_7e8ad928(avatar) then
		return
	end

	v39.mTugTime = Time()
	avatar:__wf_atom_8914dfde(v9.mFishingTugLureBobAnimEvent, 2)

	if flag8 or flag7 or __wf_atom_7e8ad928(avatar) then
		return
	end

	v37 = v38
	avatar:__wf_atom_8a035cd5(Symbol("ShakeCameraSpotSmall"), false)
	fn15(avatar, 0.2, 0.15) -- inferred equivalent call
	OnTugLureHopStart()
end

local function fn29(mReelHorizontalInput)
	if
		__wf_atom_7e8ad928(avatar)
		or avatar:__wf_atom_7bcdbf55(v9.mFishingBiteReactAnimAction)
		or avatar:__wf_atom_7bcdbf55(v9.mFishingLeftTugAnimAction)
		or avatar:__wf_atom_7bcdbf55(v9.mFishingRightTugAnimAction)
	then
		return
	end

	if
		v14.mActionKeyHeld
		or not __wf_atom_7e8ad928(v44.mLastSideTugTime) and Time() < v44.mLastSideTugTime + v10.SIDE_TUG_COOLDOWN
	then
		return
	end

	v44.mLastSideTugTime = Time()
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()
	__wf_atom_296472bc.mLureTugTime = Time()
	avatar:__wf_atom_aabc9a96(__wf_atom_296472bc)
	v38 = v10.SIDEWAYS_TUG_VELOCITY * mReelHorizontalInput

	if mReelHorizontalInput < 0 then
		avatar:__wf_atom_e06358f3(v9.mFishingLeftTugAnimAction, true)
	elseif mReelHorizontalInput > 0 then
		avatar:__wf_atom_e06358f3(v9.mFishingRightTugAnimAction, true)
	end

	avatar:__wf_atom_8a035cd5(Symbol("WaitUntilSideTugAnimEvent"), false)
	OnTugStart()
end

local function fn30()
	if __wf_atom_7e8ad928(avatar) then
		return
	end

	local mFishTargetingLure = avatar:__wf_atom_296472bc().mFishTargetingLure

	if
		not __wf_atom_7e8ad928(mFishTargetingLure)
		and mFishTargetingLure:__wf_atom_43e681f1() == 4
		and v44.mBiteWindowStartTime <= Time()
		and Time() <= v44.mBiteWindowStartTime + mFishTargetingLure.mBiteWindowDuration
	then
		_T.SetFishHook = nil
		mFishReticleMovie:Execute("SetHook", "")

		if mFishTargetingLure.mRequirePerfectHook and _T.SetFishHook ~= 2 then
			return
		end

		if _T.SetFishHook then
			fn27(mFishTargetingLure)
		end
	end
end

local function fn31(object)
	if not __wf_atom_7e8ad928(avatar) then
		local __wf_atom_296472bc = avatar:__wf_atom_296472bc()
		__wf_atom_296472bc.mFishTargetingLure = nil

		if Time() > v44.mBiteWindowStartTime then
			__wf_atom_296472bc.mPerfectStreak = 0
		end

		avatar:__wf_atom_aabc9a96(__wf_atom_296472bc)
	end

	object:StopAnimation()
	object:__wf_atom_7b7015c9(fishSwimAnim)
	object:__wf_atom_f173c8ad()
end

local function fn32(mFishTargetingLure)
	if __wf_atom_7e8ad928(mFishTargetingLure) or __wf_atom_7e8ad928(avatar) or __wf_atom_7e8ad928(mLureDeco) then
		fn31(mFishTargetingLure)
		return
	end

	local v67 = __wf_atom_fa8d0177(v44.mBiteStartPosition, mLureDeco:GetPosition())
	v67.bank = 0
	mFishTargetingLure:Teleport(mLureDeco:GetPosition() - __wf_atom_9341614d(v44.mLureAttachOffset, v67), v67)
	v44.mBiteTime = Time()
	mFishTargetingLure:__wf_atom_032e99b2(4)
	v44.mBiteWindowStartTime = Time()
	v44.mBiteStruggleTargetHeading = mFishTargetingLure:__wf_atom_dc309f8a().heading
	v44.mBiteStruggleTargetPitch = math.random(50, 80)
	v44.mBiteStruggleRotateTimer = mFishTargetingLure.mBiteStruggleRotateTimeRange:__wf_atom_ff1686f2()
	v44.mTargetVelocity = _T.FishBiteStartVelocity or 0
	v44.mVelocity = _T.FishBiteStartVelocity or 0
	v44.mBiteStartVelocity = _T.FishBiteStartVelocity
	v44.mBiteVelocityBlendTimer = v44.BITE_VELOCITY_BLEND_DURATION
	avatar:__wf_atom_8a035cd5(Symbol("ShakeCameraSpotMedium"), false)
	fn15(avatar, 0.6, 0.3) -- inferred equivalent call
	mFishTargetingLure:AttachEntity(
		mLureDeco,
		Symbol("GAME_C1_JAW1"),
		mFishTargetingLure.mLureAttachOffset,
		Rotation(0, 0, 30)
	)
	local __wf_atom_c082fc3d = mFishTargetingLure:__wf_atom_c082fc3d()
	mLureDeco:SetMeshScale(1 / __wf_atom_c082fc3d)
	v44.mBiteLineLength = Distance(mLureDeco:GetPosition(), avatar:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1")))
	local v68 = 6
	v13 = v68
	avatar:__wf_atom_037ae4a8(v68)
	OnFishBite()
end

local function fn33()
	local v67 = __wf_atom_28d5d4aa2 + __wf_atom_9341614d(Vector(0, 0, 5), Rotation(heading, 0, 0))
	local __wf_atom_74b9a49b = mMovie:__wf_atom_74b9a49b(v67)
	local transformPixelToViewportCoordinates = module8.TransformPixelToViewportCoordinates(mMovie, {
		x = __wf_atom_74b9a49b.x,
		y = __wf_atom_74b9a49b.y
	})
	v14.mSimulatedCursorPosition = Vector(
		mMovie:__wf_atom_d5a50cb5() * transformPixelToViewportCoordinates.x,
		mMovie:__wf_atom_c4f6543f() * transformPixelToViewportCoordinates.y,
		0
	)
	v32:__wf_atom_4453e49c(v67.x)
	v35:__wf_atom_4453e49c(v67.z)
end

function Reset()
	local v67 = 1
	v13 = v67
	avatar:__wf_atom_037ae4a8(v67)

	if not flag8 then
		avatar:__wf_atom_e06358f3(v9.mFishingResetAnimAction, true)
	end

	v42:__wf_atom_4453e49c(0)
	avatar:__wf_atom_78ad8b9f(139, 0)
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if mLureDeco:__wf_atom_f43b1463() > 0 then
		v45 = 3.4028234663852886e38
		mLureDeco:__wf_atom_8a035cd5(Symbol("DissolveIn"), false)
	else
		v45 = Time()
		__wf_atom_28d5d4aa6 = mLureDeco:GetPosition()
		__wf_atom_80368bb1_2 = mLureDeco:__wf_atom_dc309f8a()
	end

	_T.fishingLureInWater = false
	_T.fishingLureImpactTime = 3.4028234663852886e38

	if flag2 then
		gRegion:__wf_atom_dd1e4d10(__wf_atom_296472bc.mFishOnHook)
		flag2 = false
	end

	if not __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) then
		__wf_atom_296472bc.mFishOnHook:SetMaterialParam(
			Symbol("EmissiveTintColorHi"),
			v52.red / 255,
			v52.green / 255,
			v52.blue / 255,
			1,
			false
		)

		if v53 == -1 then
			__wf_atom_296472bc.mFishOnHook:__wf_atom_6d11d81e(Symbol("EmissiveMapAtten"))
		else
			__wf_atom_296472bc.mFishOnHook:SetMaterialParam(Symbol("EmissiveMapAtten"), v53, 0, 0, 0, true)
		end
	end

	__wf_atom_296472bc.mFishTargetingLure = nil
	__wf_atom_296472bc.mFishOnHook = nil
	avatar:__wf_atom_aabc9a96(__wf_atom_296472bc)
	fn33()
	gRegion:__wf_atom_dd1e4d10(v25)
	gRegion:__wf_atom_dd1e4d10(v26)
	gRegion:__wf_atom_dd1e4d10(v27)
	gRegion:__wf_atom_dd1e4d10(v29)
	gRegion:__wf_atom_dd1e4d10(v47.mStunLineFx)

	if not __wf_atom_7e8ad928(nil) then
		(nil):PlayTriggeredFade()
	end

	v43.mInitialLobRotation = __wf_atom_80368bb1
	v43.mInitialLobVelocity = 0
	v43.mLureImpactVerticalVelocity = 0
	v43.mInitialLobTime = 3.4028234663852886e38
	v43.mLureEnterWaterTime = 3.4028234663852886e38
	v43.mLureSettledTime = 3.4028234663852886e38
	v43.mSettleMovementDistance = 0
	v61 = 0
	v20:Teleport(GetAimPosition(), Rotation())
	fishReticle:Teleport(GetAimPosition(), Rotation())
	v40.mSmoothedLureReelX:__wf_atom_4453e49c(0)
	v40.mSmoothedLureReelZ:__wf_atom_4453e49c(0)
	v43.mLureEnteredWater = false
	v59 = false
	flag5 = false
	caughtHealthyFishInfo = nil
	mSpinRateUI = 0
	v39.mReelSlackMultiplier:__wf_atom_4453e49c(1)
	v39.mBiteFightSlackMultiplier:__wf_atom_4453e49c(1)
	v39.mTugSlackMultiplier:__wf_atom_4453e49c(1)
	__wf_atom_28d5d4aa5 = __wf_atom_28d5d4aa
	__wf_atom_28d5d4aa4 = __wf_atom_28d5d4aa
	v58.mJumpAccel = __wf_atom_28d5d4aa
	v58.mCanStunFish = false
	v56.mNumRests = 0
	okay = STAMINA_STATE.OKAY
	v56.mPlayerStunRemainingTime = 0
	v47.mLinePulseRemainingTime = 0
	_T.fishingDebugTempNoFishResistance = false
	OnReset()
end

local function fn34(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local caughtFishDeco = __wf_atom_e919fb8e.caughtFishDeco

	if __wf_atom_7e8ad928(caughtFishDeco) then
		return
	end

	local nearestWaterVolumeInfo = module4.FindNearestWaterVolumeInfo(_T.FishingWaterVolumes, object:GetPosition())

	if __wf_atom_7e8ad928(nearestWaterVolumeInfo) or __wf_atom_7e8ad928(nearestWaterVolumeInfo.mWaterVolume) then
		return
	end

	caughtHealthyFishInfo = module4.SpawnFish(
		caughtFishDeco:__wf_atom_2b75b04d(),
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		nearestWaterVolumeInfo,
		nearestWaterVolumeInfo.mWaterVolume,
		caughtFishDeco
	)

	if __wf_atom_7e8ad928(caughtHealthyFishInfo) or __wf_atom_7e8ad928(caughtHealthyFishInfo.mFishDeco) then
		return
	end

	local __wf_atom_fa6a475e = object:__wf_atom_296472bc():__wf_atom_fa6a475e()
	caughtHealthyFishInfo.mFishDeco:__wf_atom_032e99b2(0)
	caughtHealthyFishInfo.mFishDeco:__wf_atom_c6a2b27c(true)
	caughtHealthyFishInfo.mFishDeco:SetMeshScale(1)
	caughtHealthyFishInfo.mFishDeco:__wf_atom_a763aa1a(1)
	caughtHealthyFishInfo.mOriginalMeshScale = __wf_atom_fa6a475e
	caughtHealthyFishInfo.mIsPurified = true
	__wf_atom_e919fb8e.CaughtHealthyFishInfo = caughtHealthyFishInfo
	__wf_atom_e919fb8e.CaughtHealthyFishDeco = caughtHealthyFishInfo.mFishDeco
end

local function fn35(object, object2)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	caughtHealthyFishInfo = object2:__wf_atom_e919fb8e().CaughtHealthyFishInfo

	if __wf_atom_7e8ad928(caughtHealthyFishInfo) or __wf_atom_7e8ad928(caughtHealthyFishInfo.mFishDeco) then
		return
	end

	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local mSpawnPosition = position + __wf_atom_9341614d(v62, __wf_atom_dc309f8a)
	local v68 = __wf_atom_d919c2d7(v63, __wf_atom_dc309f8a)
	local mFishDeco = caughtHealthyFishInfo.mFishDeco
	mFishDeco:__wf_atom_c6a2b27c(false)
	mFishDeco:__wf_atom_e6ed03c8()
	mFishDeco:Teleport(mSpawnPosition, v68)
	mFishDeco:SetMeshScale(caughtHealthyFishInfo.mOriginalMeshScale)
	mFishDeco:__wf_atom_032e99b2(7)
	caughtHealthyFishInfo.mSpawnPosition = mSpawnPosition
	table.insert(caughtHealthyFishInfo.mOwnerInfo.mFishInfos, caughtHealthyFishInfo)
	table.insert(_T.allFishInfos, caughtHealthyFishInfo)
	table.insert(_T.purifiedFishInfos, caughtHealthyFishInfo)
	caughtHealthyFishInfo.mOwnerInfo.mPurifiedFishCount += 1
	_T.purifiedFishCount += 1
end

function WaitForFishCaughtEnd()
	Sleep(0)

	while not __wf_atom_7e8ad928(v31) and v31:__wf_atom_7d4910e4() and not __wf_atom_7e8ad928(avatar) do
		Sleep(0)
	end

	avatar:__wf_atom_b44eb804(not _T.ReleaseFish)
	local mFishOnHook = avatar:__wf_atom_296472bc().mFishOnHook

	if _T.ReleaseFish then
		if not __wf_atom_7e8ad928(mFishOnHook) then
			local mDustReward = mFishOnHook.mDustReward
			avatar:__wf_atom_d2b2176d():__wf_atom_a3fda1f3(mDustReward)
		end
	elseif not __wf_atom_7e8ad928(caughtHealthyFishInfo) then
		gRegion:__wf_atom_dd1e4d10(caughtHealthyFishInfo.mFishDeco)
		caughtHealthyFishInfo = nil
	end

	gRegion:__wf_atom_dd1e4d10(mFishOnHook)

	if not __wf_atom_7e8ad928(v17) then
		v17:SetVisibility(true, true)
	end

	v64 = false
	OnFishCaughtEnd()

	if flag8 then
		CleanupAndShutdown()
	else
		Reset()
	end
end

function PrepareEndCaughCin(object)
	local __wf_atom_02a7a2f4 = object:__wf_atom_02a7a2f4()

	if __wf_atom_7e8ad928(__wf_atom_02a7a2f4) then
		return
	end

	local caughtFishDeco = __wf_atom_02a7a2f4:__wf_atom_e919fb8e().caughtFishDeco
	object:__wf_atom_a3d2b66b(caughtFishDeco, Symbol("FishA"))

	if not __wf_atom_7e8ad928(caughtFishDeco) then
		local __wf_atom_bb3e7833 = caughtFishDeco:__wf_atom_bb3e7833(fishRevealFXType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end

	object:__wf_atom_a3d2b66b(module10.GetPetAvatar(__wf_atom_02a7a2f4:__wf_atom_a96eb2aa()), Symbol("WolfCub"))
end

function OnEndReleaseCinEnding(object)
	local __wf_atom_02a7a2f4 = object:__wf_atom_02a7a2f4()
	v62, v63 = object:__wf_atom_99c400ff(Symbol("FishA"), 1)
	fn35(object, __wf_atom_02a7a2f4)
end

function OnEndKeepCinEnding(object)
	local __wf_atom_02a7a2f4 = object:__wf_atom_02a7a2f4()

	if __wf_atom_7e8ad928(__wf_atom_02a7a2f4) or __wf_atom_7e8ad928(__wf_atom_02a7a2f4) then
		return
	end

	caughtHealthyFishInfo = __wf_atom_02a7a2f4:__wf_atom_e919fb8e().CaughtHealthyFishInfo

	if __wf_atom_7e8ad928(caughtHealthyFishInfo) or __wf_atom_7e8ad928(caughtHealthyFishInfo.mFishDeco) then
		return
	end

	gRegion:__wf_atom_dd1e4d10(caughtHealthyFishInfo.mFishDeco)
	caughtHealthyFishInfo = nil
end

function EndCaughtScreen()
	if __wf_atom_7e8ad928(avatar) then
		return
	end

	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()
	local _mFishOnHook = __wf_atom_296472bc.mFishOnHook

	if not __wf_atom_7e8ad928(v31) and v31:__wf_atom_7d4910e4() then
		return
	end

	if not (__wf_atom_7e8ad928(__wf_atom_296472bc) or __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook)) then
		local __wf_atom_1bb5b1ff = __wf_atom_296472bc.mFishOnHook:__wf_atom_1bb5b1ff()
		local __wf_atom_2b75b04d = __wf_atom_296472bc.mFishOnHook:__wf_atom_2b75b04d()
		local mCorruptionLevel = __wf_atom_296472bc.mFishOnHook.mCorruptionLevel
		local v67 = __wf_atom_296472bc.mFishOnHook.mSize * 1000

		if _T.ReleaseFish then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("FISH_RELEASED"), __wf_atom_1bb5b1ff:__wf_atom_5b41f63b())
		else
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("FISH_CAUGHT"), __wf_atom_1bb5b1ff:__wf_atom_5b41f63b())
		end

		local __wf_atom_b4c3edde = __wf_atom_21342f4a:__wf_atom_b4c3edde(
			Symbol("FISH_MAX_RARITY"),
			__wf_atom_1bb5b1ff:__wf_atom_5b41f63b()
		)
		local __wf_atom_b4c3edde2 = __wf_atom_21342f4a:__wf_atom_b4c3edde(
			Symbol("FISH_MAX_SIZE"),
			__wf_atom_1bb5b1ff:__wf_atom_5b41f63b()
		)
		local v68 = 0
		local v69 = 0

		for _, v70 in ipairs(mStats.mFish) do
			if not (v70.type == __wf_atom_1bb5b1ff and v70.rarity and v70.maxSize) then
				continue
			end

			local rarity = v70.rarity
			local maxSize = v70.maxSize

			if not (v68 < rarity or rarity == v68 and v69 < maxSize) then
				continue
			end

			v68 = rarity
			v69 = maxSize
		end

		local v70

		if v68 < __wf_atom_b4c3edde or __wf_atom_b4c3edde == v68 and v69 < __wf_atom_b4c3edde2 then
			v68 = __wf_atom_b4c3edde
			v69 = __wf_atom_b4c3edde2
			v70 = true
		else
			v70 = false
		end

		local v71

		if v68 < mCorruptionLevel or mCorruptionLevel == v68 and v69 < v67 then
			v68 = mCorruptionLevel
			v69 = v67
			v71 = true
		else
			v71 = false
		end

		if v71 or v70 then
			v69 = math.round(v69)
			__wf_atom_21342f4a:__wf_atom_6f4d2dc0(
				Symbol("FISH_MAX_RARITY"),
				__wf_atom_2b75b04d:__wf_atom_5b41f63b(),
				"",
				v68
			)
			__wf_atom_21342f4a:SetEvent(Symbol("FISH_MAX_SIZE"), __wf_atom_2b75b04d:__wf_atom_5b41f63b(), "", v69)
		end

		local __wf_atom_d2b2176d = avatar:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			__wf_atom_d2b2176d:__wf_atom_6379d01f(__wf_atom_296472bc.mFishOnHook)
			__wf_atom_d2b2176d:__wf_atom_6379d01f(__wf_atom_2b75b04d, true)
		end

		print("Adding scans for:" .. __wf_atom_2b75b04d:__wf_atom_5b41f63b())
	end

	local v67 = not __wf_atom_7e8ad928(avatar) and avatar:IsA(WeakResource("/SF/Types/Player/EnvoyChildAvatar"))

	if gRegion:IsMaster() or v67 then
		local v68

		if _T.ReleaseFish then
			v68 = module8.Ternary(v67, fishCaughtChildEndCinType, fishCaughtAdultEndCinType)
		else
			v68 = module8.Ternary(v67, fishCaughtChildEndKeepCinType, fishCaughtAdultEndKeepCinType)
		end

		v31 = gRegion:CreateEntity(v68, avatar:__wf_atom_a2a18137(), avatar:__wf_atom_2f2bada0(), avatar, avatar, 1)
	else
		local ternary = module8.Ternary(_T.ReleaseFish, fishCaughtAdultEndTag, fishCaughtAdultEndKeepTag)
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(ternary, avatar:__wf_atom_a2a18137(), 0, 3)

		for _, v68 in ipairs(__wf_atom_439c0d29) do
			if v68:__wf_atom_02a7a2f4() == avatar then
				v31 = v68
			end
		end
	end

	if not __wf_atom_7e8ad928(v31) then
		if gRegion:IsMaster() then
			v31:SetInstigatorAvatar(avatar)
			v31:__wf_atom_8f4c0eeb(Symbol("Envoy"), avatar:__wf_atom_a2a18137(), avatar:__wf_atom_2f2bada0(), 0.5)
			v31:FirePort("StartPlayingRelative")
		else
			v31:__wf_atom_7a6c2c2f()
		end
	end

	OnFishCaughtLoopEnd()
	CloseResultPopup()
	avatar:__wf_atom_8a035cd5(Symbol("WaitForFishCaughtEnd"), false)
end

function PlayFishCaughtLoopCin(_)
	Sleep(0)

	if not gRegion:IsMaster() then
		while not (__wf_atom_7e8ad928(v30) or v30:__wf_atom_7d4910e4()) do
			Sleep(0)
		end
	end

	while
		not __wf_atom_7e8ad928(v30)
		and v30:__wf_atom_7d4910e4()
		and v30:__wf_atom_f0329e19() == 0
		and not __wf_atom_7e8ad928(avatar)
	do
		Sleep(0)
	end

	OnFishCaughtLoopStart()

	if flag8 then
		EndCaughtScreen()
	else
		ShowResultPopup()
	end
end

local function fn36()
	if _T.fishingDebugNeverLose then
		return
	end

	OnFishEscaped()
	Reset()
	mLureDeco:__wf_atom_e6ed03c8()
	mLureDeco:SetMeshScale(v40.mLureOriginalMeshScale)
	avatar:__wf_atom_e06358f3(v9.mFishingLoseFishAnimAction, true)
	v39.mLineSnapped = true
	local __wf_atom_1c374cc9 = avatar:__wf_atom_1c374cc9(Symbol("GAME_R1_FINGER3"))
	v39.mLineSnapDistance = Distance(__wf_atom_1c374cc9, mLureDeco:GetPosition())
	avatar:__wf_atom_8a035cd5(Symbol("ShakeCameraSpotLarge"), false)
	fn15(avatar, 0.8, 0.4) -- inferred equivalent call
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if __wf_atom_7e8ad928(__wf_atom_296472bc.mLureItem) then
		return
	end

	local __wf_atom_e14d8a8c = __wf_atom_296472bc.mLureItem:__wf_atom_e14d8a8c()

	if __wf_atom_e14d8a8c:__wf_atom_7cfec59c() < math.random() then
		avatar:__wf_atom_d2b2176d():__wf_atom_5106368a(__wf_atom_e14d8a8c)
		_T.ShowImpactMessage(lureLost, 5)
	end
end

function PrepareCinFish(object)
	local __wf_atom_02a7a2f4 = object:__wf_atom_02a7a2f4()

	if __wf_atom_7e8ad928(__wf_atom_02a7a2f4) then
		return
	end

	object:__wf_atom_a3d2b66b(__wf_atom_02a7a2f4, Symbol("Envoy"))
	local __wf_atom_296472bc = __wf_atom_02a7a2f4:__wf_atom_296472bc()
	local mFishType = __wf_atom_296472bc.mFishType
	local __wf_atom_fa6a475e = __wf_atom_296472bc:__wf_atom_fa6a475e()
	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local _, v67 = object:__wf_atom_99c400ff(Symbol("FishA"), 0)
	local v68 = position + __wf_atom_9341614d(position, __wf_atom_dc309f8a)
	local v69 = __wf_atom_d919c2d7(v67, __wf_atom_dc309f8a)
	local cinFish = module4.SpawnCinFish(Type(mFishType), v68, v69, __wf_atom_02a7a2f4, __wf_atom_fa6a475e)

	if __wf_atom_7e8ad928(cinFish) then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_02a7a2f4:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.caughtFishDeco = cinFish
	cinFish:SetMeshScale(cinFish:__wf_atom_c082fc3d() / 0.15)
	object:__wf_atom_a3d2b66b(cinFish, Symbol("FishA"))
	local __wf_atom_f582136d = cinFish:__wf_atom_f582136d(__wf_atom_9578cbaa)

	if not __wf_atom_7e8ad928(__wf_atom_f582136d) then
		for i = 1, #__wf_atom_f582136d do
			__wf_atom_f582136d[i]:PlayTriggeredFade()
		end
	end

	if not __wf_atom_7e8ad928(fishRevealSplashFXType) then
		gRegion:CreateEntity(fishRevealSplashFXType, cinFish:GetPosition(), __wf_atom_80368bb1)
	end

	if not __wf_atom_7e8ad928(fishRevealAttachedSplashFXType) then
		cinFish:Attach(fishRevealAttachedSplashFXType, EMPTY_SYMBOL)
	end

	local petAvatar = module10.GetPetAvatar(__wf_atom_02a7a2f4:__wf_atom_a96eb2aa())
	object:__wf_atom_a3d2b66b(petAvatar, Symbol("WolfCub"))

	if gRegion:IsMaster() then
		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.FishWithPuppyAmmount) then
			__wf_atom_e919fb8e.FishWithPuppyAmmount = 0
		end

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.FishWithPuppyRewardAmmount) then
			__wf_atom_e919fb8e.FishWithPuppyRewardAmmount = __wf_atom_5784a397(3, 5)
		end

		if not __wf_atom_7e8ad928(petAvatar) then
			__wf_atom_e919fb8e.FishWithPuppyAmmount += 1

			if __wf_atom_e919fb8e.FishWithPuppyAmmount >= __wf_atom_e919fb8e.FishWithPuppyRewardAmmount then
				module10.TrainPet(__wf_atom_02a7a2f4:__wf_atom_a96eb2aa(), 5, 60)
				__wf_atom_e919fb8e.FishWithPuppyAmmount = 0
				__wf_atom_e919fb8e.FishWithPuppyRewardAmmount = __wf_atom_5784a397(3, 5)
			end
		end
	end

	object:ReinitializeGreenRoom()
	fn34(__wf_atom_02a7a2f4)

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_f0329e19() == 0 do
		Sleep(0)
	end

	cinFish:__wf_atom_8a035cd5(Symbol("DissolveOut"), false)
	local mFishDeco = caughtHealthyFishInfo.mFishDeco

	if not __wf_atom_7e8ad928(mFishDeco) then
		cinFish:AttachEntity(mFishDeco, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		mFishDeco:__wf_atom_c6a2b27c(true)
		mFishDeco:SetMeshScale(1)
		mFishDeco:__wf_atom_a763aa1a(0)

		if not __wf_atom_7e8ad928(fishRevealFXType) then
			Sleep(0)
			revealFishFx = cinFish:Attach(
				fishRevealFXType,
				Symbol("GAME_C1_SPINE1"),
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1
			)
			mFishDeco:Attach(healthyFishRevealProjType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end
end

local function fn37()
	if __wf_atom_7e8ad928(avatar) then
		return
	end

	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()
	local mFishOnHook = __wf_atom_296472bc.mFishOnHook
	fn13()
	local v67 = 8
	v13 = v67
	avatar:__wf_atom_037ae4a8(v67)
	_T.WarsongFishCaught = true

	if gRegion:IsMaster() then
		gRegion:__wf_atom_dd1e4d10(v30)
		gRegion:__wf_atom_dd1e4d10(v31)
	end

	local v68 = not __wf_atom_7e8ad928(avatar) and avatar:IsA(WeakResource("/SF/Types/Player/EnvoyChildAvatar"))

	if gRegion:IsMaster() or v68 then
		local ternary = module8.Ternary(v68, fishCaughtChildStartCinType, fishCaughtAdultStartCinType)
		v30 = gRegion:CreateEntity(ternary, avatar:__wf_atom_a2a18137(), avatar:__wf_atom_2f2bada0(), avatar, avatar, 1)
	else
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
			fishCaughtAdultStartTag,
			avatar:__wf_atom_a2a18137(),
			0,
			3
		)

		for _, v70 in ipairs(__wf_atom_439c0d29) do
			if v70:__wf_atom_02a7a2f4() ~= avatar then
				continue
			end

			v30 = v70
			break
		end
	end

	if not __wf_atom_7e8ad928(v30) then
		if not __wf_atom_7e8ad928(mFishOnHook) then
			v44.mOriginalFishMeshScale = mFishOnHook:__wf_atom_c082fc3d()
			mFishOnHook:__wf_atom_032e99b2(6)
			mFishOnHook:__wf_atom_68f2c268(1)
		end

		if gRegion:IsMaster() then
			v30:SetInstigatorAvatar(avatar)
			v30:__wf_atom_8f4c0eeb(Symbol("Envoy"), avatar:__wf_atom_a2a18137(), avatar:__wf_atom_2f2bada0(), 0.5)
			v30:FirePort("StartPlayingRelative")
		else
			v30:__wf_atom_7a6c2c2f()
		end
	end

	local fishInfoForDeco = module4.GetFishInfoForDeco(__wf_atom_296472bc.mFishOnHook)

	if not __wf_atom_7e8ad928(fishInfoForDeco) then
		fishInfoForDeco.mOwnerInfo.mRemainingFishCount -= 1
	end

	module4.RemoveFishFromTables(__wf_atom_296472bc.mFishOnHook)
	OnFishCaughtStart()
	avatar:__wf_atom_8a035cd5(Symbol("PlayFishCaughtLoopCin"), false)
	gRegion:__wf_atom_dd1e4d10(v23)
	gRegion:__wf_atom_dd1e4d10(v24)
	gRegion:__wf_atom_dd1e4d10(v19)

	if not __wf_atom_7e8ad928(nil) then
		(nil):PlayTriggeredFade()
	end

	mLureDeco:__wf_atom_e6ed03c8()
	mLureDeco:SetMeshScale(v40.mLureOriginalMeshScale)
	mLureDeco:__wf_atom_68f2c268(1)
	gRegion:__wf_atom_dd1e4d10(v25)
	fn15(avatar, 0.6, 0.3) -- inferred equivalent call
	_T.WarsongFishingMinnowCaught = true
end

local function fn38(p)
	if __wf_atom_8e4fda44:__wf_atom_6b69b901(ConsumablesOverlay) then
		return
	end

	v14.mCursorDelta = Vector(0, 0, 0)

	if Engine.IsPlayingWithController() then
		v14.mCursorDelta = v14.mJoystickDelta
		v14.mCursorDelta *= v10.JOYSTICK_AIM_SPEED_MULTIPLIER
	else
		v14.mCursorDelta = v14.mMouseDelta
		v14.mMouseDelta = Vector(0, 0, 0)
		v14.mCursorDelta *= v10.MOUSE_AIM_SPEED_MULTIPLIER

		if v14.mCursorDelta == Vector(0, 0, 0) then
			v14.mCursorDelta.x -= module8.Ternary(v14.mLeftKeyHeld, 1, 0)
			v14.mCursorDelta.x += module8.Ternary(v14.mRightKeyHeld, 1, 0)
			v14.mCursorDelta.y -= module8.Ternary(v14.mUpKeyHeld, 1, 0)
			v14.mCursorDelta.y += module8.Ternary(v14.mDownKeyHeld, 1, 0)
			v14.mCursorDelta *= v10.KEY_AIM_SPEED_MULTIPLIER
		end
	end

	if not __wf_atom_8e4fda44:__wf_atom_0dfd953f() then
		local v67 = Vector(mMovie:__wf_atom_d5a50cb5() / 2, mMovie:__wf_atom_c4f6543f() / 2, 0)
		gRegion:__wf_atom_eab484a7():__wf_atom_a16f9b3c(v67.x, v67.y)
		__wf_atom_8e4fda44:__wf_atom_b005c93e(v67.x, v67.y)
		mMovie:__wf_atom_fbca497c(false)
	end

	v14.mPrevReelHorizontalInput = v14.mReelHorizontalInput
	v14.mReelHorizontalInput = 0
	v14.mReelHorizontalInput -= module8.Ternary(v14.mLeftKeyHeld, 1, 0)
	v14.mReelHorizontalInput += module8.Ternary(v14.mRightKeyHeld, 1, 0)

	if v14.mReelHorizontalInput == 0 and Engine.IsPlayingWithController() and v14.mCursorDelta.x ~= 0 then
		v14.mReelHorizontalInput = v14.mCursorDelta.x / math.abs(v14.mCursorDelta.x)
	end

	if v56.mPlayerStunRemainingTime > 0 then
		v14.mReelHorizontalInput = 0
		_T.fishingPlayerStunned = "TRUE"
	else
		_T.fishingPlayerStunned = "FALSE"
	end

	if v13 == 2 or v13 == 3 then
		local position = avatar:CameraControl():__wf_atom_dd7246c7():GetPosition()
		local __wf_atom_4cd347da = avatar:CameraControl():__wf_atom_4cd347da()

		if
			not __wf_atom_7e8ad928(__wf_atom_4cd347da)
			and __wf_atom_a93b9922(position, __wf_atom_4cd347da:GetPosition()) > 0.010000000000000002
		then
			fn33()
			return
		end

		v14.mSimulatedCursorPosition += v14.mCursorDelta
		local v70 = Vector(v32.mTargetVal, 0, v35.mTargetVal)
		local v71

		if v14.mCursorDelta.x == 0 and v14.mCursorDelta.y == 0 then
			v71 = v14.mCursorDelta.z == 0
		else
			v71 = false
		end

		if not v71 then
			local v72 = Vector(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), 0)
			v14.mSimulatedCursorPosition = Vector(
				__wf_atom_421b01aa(v14.mSimulatedCursorPosition.x, 0, v72.x),
				__wf_atom_421b01aa(v14.mSimulatedCursorPosition.y, 0, v72.y),
				0
			)
			local v73 = v14.mSimulatedCursorPosition.x / v72.x
			local v74 = v14.mSimulatedCursorPosition.y / v72.y
			local __wf_atom_c35fbccd = avatar:CameraControl():__wf_atom_dd7246c7():__wf_atom_c35fbccd()
			local __wf_atom_a6e4d761 = v16:__wf_atom_a6e4d761(v73, v74, __wf_atom_c35fbccd)
			__wf_atom_a6e4d761.y = math.min(__wf_atom_a6e4d761.y, -0.001)
			local intersectLineToPlane = module8.IntersectLineToPlane(
				position,
				__wf_atom_a6e4d761,
				Vector(0, 1, 0),
				__wf_atom_28d5d4aa2.y
			)
			v70 = ClampToPlayableArea(intersectLineToPlane)
			local __wf_atom_596fc4eb = v16:__wf_atom_596fc4eb(v70, __wf_atom_c35fbccd)
			v14.mSimulatedCursorPosition = Vector(
				mMovie:__wf_atom_d5a50cb5() * __wf_atom_596fc4eb.x,
				mMovie:__wf_atom_c4f6543f() * __wf_atom_596fc4eb.y,
				0
			)
		end

		v32:__wf_atom_2490589b(v70.x, p)
		v35:__wf_atom_2490589b(v70.z, p)
	elseif v13 == 5 or v13 == 7 then
		if v13 == 5 and not v14.mActionKeyHeld and v14.mReelHorizontalInput ~= 0 then
			local mReelHorizontalInput = math.sign(v14.mReelHorizontalInput)

			if mReelHorizontalInput ~= math.sign(v14.mPrevReelHorizontalInput) then
				fn29(mReelHorizontalInput)
			end
		end

		local v69 = GetTargetDistance()

		if v69 > 0 then
			v14.mReelHorizontalInput *= v10.MAX_CAST_DISTANCE / v69
		end

		if not flag4 then
			v14.mReelAimHeading += v14.mReelHorizontalInput * v10.REEL_HEADING_CHANGE_MULTIPLIER * p
		end

		v14.mReelAimHeading = __wf_atom_421b01aa(v14.mReelAimHeading, -v10.MAX_CAST_HEADING, v10.MAX_CAST_HEADING)
	elseif v13 == 4 or v13 == 6 then
		v14.mReelAimHeading = GetTargetHeading() - heading
	else
		v14.mReelAimHeading = 0
	end
end

function UpdateReticleSize()
	local v67 = GetSweetSpotLerp(v60.mSweetSpotValue) * 1.6
	v20:SetMeshScale(2 * v67)
	local __wf_atom_be0bea4a = v20:__wf_atom_be0bea4a()

	for _, v68 in ipairs(__wf_atom_be0bea4a) do
		v68:SetMeshScale(0.7 * v67)
	end

	local __wf_atom_be0bea4a2 = fishReticle:__wf_atom_be0bea4a()

	for _, v68 in ipairs(__wf_atom_be0bea4a2) do
		v68:SetMeshScale(0.21)
	end

	local v68 = __wf_atom_421b01aa((GetTargetDistance() - v10.MIN_CAST_DISTANCE) / (v11 - v10.MIN_CAST_DISTANCE), 0, 1)
	local v69 = __wf_atom_104bfe98(0.08, 0.32, v68)
	v21:SetMeshScale(v69)
end

local function fn39(_, p)
	local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa

	if flag5 then
		return __wf_atom_28d5d4aa
	end

	local mReelAcceleration = v40.mReelAcceleration

	if v13 == 7 then
		mReelAcceleration = v40.mReelHookedAcceleration
	end

	local v67 = not v14.mActionKeyHeld and 0 or mReelAcceleration
	local heading2 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa3, __wf_atom_28d5d4aa2).heading
	local v68 = __wf_atom_9341614d(Vector(0, 0, v67), Rotation(heading2, 0, 0))

	if v13 == 7 then
		local v69 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa3, v39.mLineHandPosition)
		local v70 = __wf_atom_9341614d(Vector(0, 0, v67), v69)
		v68 = Vector(v68.x, v70.y, v68.z)
	end

	local v69 = __wf_atom_28d5d4aa + v68
	local v70 = __wf_atom_421b01aa(
		v39.mReelSlackMultiplier:__wf_atom_9e368823(),
		v10.REEL_SLACK_MIN,
		v10.REEL_SLACK_MAX
	)
	local v71 = v10.REEL_SLACK_MAX - v10.REEL_SLACK_MIN
	local v72 = 1 - (v70 - v10.REEL_SLACK_MIN) / v71
	local v73 = v69 * (v72 * v72)

	if v13 == 7 or v14.mActionKeyHeld then
		local SIDEWAYS_ACCELERATION = 0

		if v14.mReelHorizontalInput < 0 then
			SIDEWAYS_ACCELERATION = -v10.SIDEWAYS_ACCELERATION
		elseif v14.mReelHorizontalInput > 0 then
			SIDEWAYS_ACCELERATION = v10.SIDEWAYS_ACCELERATION
		end

		local v74 = SIDEWAYS_ACCELERATION * mReelAcceleration
		local v75 = GetTargetHeading() + 90
		local v76 = __wf_atom_9341614d(Vector(0, 0, v74), Rotation(v75, 0, 0))
		v37 = 0
		v73 += v76
	elseif v37 ~= 0 then
		local v74 = 1 - math.min(GetTargetDistance() / v10.MAX_CAST_DISTANCE, 1)
		local v75 = v37 * __wf_atom_104bfe98(v10.SIDEWAYS_NO_REEL_MULTIPLIER, 1, v74) * math.sqrt(mReelAcceleration)
		local v76 = __wf_atom_104bfe98(0, v10.MAX_SIDEWAYS_TUG_STRAIGHT_BIAS, v74)
		local v77 = 1 - v76
		local v78 = heading2 - 90
		local v79 = __wf_atom_9341614d(Vector(0, 0, v75 * v77), Rotation(v78, 0, 0)) + __wf_atom_9341614d(
			Vector(0, 0, math.abs(v75) * v76),
			Rotation(heading2, 0, 0)
		)
		v37 = 0
		__wf_atom_28d5d4aa5 += v79 / p
	end

	if TUG_HORIZONTAL_VELOCITY ~= 0 then
		local v74 = __wf_atom_9341614d(
			Vector(0, 0, TUG_HORIZONTAL_VELOCITY * math.sqrt(mReelAcceleration)),
			Rotation(heading2, 0, 0)
		)
		TUG_HORIZONTAL_VELOCITY = 0
		__wf_atom_28d5d4aa5 += v74 / p
	end

	return v73 / p
end

local function fn40(p)
	local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa
	local mWaterDragCoeff = v56.mWaterDragCoeff

	if v13 == 7 and not (__wf_atom_28d5d4aa3.y < __wf_atom_28d5d4aa2.y) then
		mWaterDragCoeff = v56.mSurfaceDragCoeff
	end

	if not flag5 then
		local v67 = math.sqrt(__wf_atom_28d5d4aa5.x * __wf_atom_28d5d4aa5.x + __wf_atom_28d5d4aa5.y * __wf_atom_28d5d4aa5.y + __wf_atom_28d5d4aa5.z * __wf_atom_28d5d4aa5.z)
		__wf_atom_28d5d4aa = __wf_atom_28d5d4aa5 * -v67 * mWaterDragCoeff / (1 + mWaterDragCoeff * v67 * p)
	end

	return __wf_atom_28d5d4aa
end

local function fn41(_)
	local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa

	if v13 == 7 and not (__wf_atom_28d5d4aa3.y < __wf_atom_28d5d4aa2.y) or flag5 then
		return __wf_atom_28d5d4aa
	end

	local mTargetDepth = v56.mTargetDepth
	local v67 = __wf_atom_28d5d4aa2.y - __wf_atom_28d5d4aa3.y
	local v68 = Vector(__wf_atom_28d5d4aa3.x, __wf_atom_28d5d4aa2.y - mTargetDepth, __wf_atom_28d5d4aa3.z)
	local v69 = Vector()
	local raycastResult = gRegion:Raycast(__wf_atom_28d5d4aa3, v68, nil, nil, v69, true, true)
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()
	local v70 = (__wf_atom_7e8ad928(__wf_atom_296472bc) or __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook)) and 0
		or (__wf_atom_296472bc.mFishOnHook:__wf_atom_ee03557f().y - __wf_atom_296472bc.mFishOnHook:__wf_atom_0aa77159().y) / 2

	if not __wf_atom_7e8ad928(raycastResult) then
		mTargetDepth = math.max(0.01, __wf_atom_28d5d4aa2.y - v69.y - v10.FISH_COLLISION_MARGIN - v70)
	end

	local v71 = math.max(0, v67 / mTargetDepth)
	__wf_atom_28d5d4aa = Vector(0, v10.GRAVITY * v71, 0)
	return __wf_atom_28d5d4aa
end

local function fn42(p)
	if v13 == 2 or v13 == 3 then
		__wf_atom_28d5d4aa3 = GetAimPosition()
		return
	end

	if v13 == 4 then
		return
	end

	if v13 == 5 then
		__wf_atom_28d5d4aa4 = __wf_atom_28d5d4aa
		__wf_atom_28d5d4aa4 = fn39(p, v10.LURE_WEIGHT) + fn40(p)
		__wf_atom_28d5d4aa5 += __wf_atom_28d5d4aa4 * p
		local v67 = __wf_atom_28d5d4aa3 + __wf_atom_28d5d4aa5 * p
		local v68 = GetTargetDistance()
		local v69 = ClampPositionHeadingDistance(v67, -v10.MAX_CAST_HEADING, v10.MAX_CAST_HEADING, 0, v68)
		__wf_atom_28d5d4aa3 = fn2(__wf_atom_28d5d4aa3, v69, true)
	elseif v13 == 6 then
		__wf_atom_28d5d4aa3 = mLureDeco:GetPosition()
		__wf_atom_28d5d4aa3.y = __wf_atom_28d5d4aa2.y
	elseif v13 == 7 then
		__wf_atom_28d5d4aa4 = __wf_atom_28d5d4aa
		local __wf_atom_28d5d4aa7 = fn39(p, v10.LURE_WEIGHT + v56.mFishWeight)
		local v68 = CalculateFishResistance(p)
		local v69 = __wf_atom_28d5d4aa5 * p + v68 * p * p / 2
		local _ = __wf_atom_28d5d4aa3 + v69
		local v70 = v14.mReelHorizontalInput < 0 and -1 or 0
		local v71 = v14.mReelHorizontalInput > 0 and 1 or v70

		if v71 ~= 0 and v71 ~= math.sign(v56.mCurrSideStruggleAccel) and not flag5 then
			v68 *= v56.mCounterMovementMultiplier
		end

		local v72 = fn40(p)
		local v73 = fn41(p)
		local __wf_atom_28d5d4aa8 = Vector(0, -v10.GRAVITY, 0)

		if v13 ~= 7 or __wf_atom_28d5d4aa3.y < __wf_atom_28d5d4aa2.y then
			if flag5 then
				__wf_atom_28d5d4aa8 = __wf_atom_28d5d4aa
			end
		else
			__wf_atom_28d5d4aa8 *= v58.mJumpSpeedMultiplier
		end

		v46.mConstraintPullStrength = fn11(__wf_atom_28d5d4aa7, v68 + v72 + v73 + __wf_atom_28d5d4aa8, p)

		if flag4 then
			local v75 = v14.mReelHorizontalInput < 0 and -1 or 0
			local v76 = v14.mReelHorizontalInput > 0 and 1 or v75

			if v76 == 0 or v76 == math.sign(v56.mCurrSideStruggleAccel) then
				__wf_atom_28d5d4aa7 = __wf_atom_28d5d4aa
			end
		end

		__wf_atom_28d5d4aa4 = __wf_atom_28d5d4aa7 + v68 + v72 + v73 + __wf_atom_28d5d4aa8
		__wf_atom_28d5d4aa5 += __wf_atom_28d5d4aa4 * p
		local v75 = __wf_atom_28d5d4aa3 + __wf_atom_28d5d4aa5 * p

		if not flag5 then
			local v76, v77

			if v14.mActionKeyHeld then
				v76 = Distance(v39.mLineHandPosition, __wf_atom_28d5d4aa3)
				v56.mFishMaxStruggleDist = math.min(v56.mFishMaxStruggleDist, v76)
				v77 = v75 - v39.mLineHandPosition

				if Length(v77) > v56.mFishMaxStruggleDist then
					Normalize(v77)
					v75 = v39.mLineHandPosition + v77 * v56.mFishMaxStruggleDist
				end
			else
				local v78 = v14.mReelHorizontalInput < 0 and -1 or 0
				local v79 = v14.mReelHorizontalInput > 0 and 1 or v78

				if v79 ~= 0 and v79 ~= math.sign(v56.mCurrSideStruggleAccel) then
					v76 = Distance(v39.mLineHandPosition, __wf_atom_28d5d4aa3)
					v56.mFishMaxStruggleDist = math.min(v56.mFishMaxStruggleDist, v76)
					v77 = v75 - v39.mLineHandPosition

					if Length(v77) > v56.mFishMaxStruggleDist then
						Normalize(v77)
						v75 = v39.mLineHandPosition + v77 * v56.mFishMaxStruggleDist
					end
				else
					v56.mFishMaxStruggleDist = 3.4028234663852886e38
				end
			end
		end

		if _T.fishingDebugNeverLose then
			local mFishMaxStruggleDist = v56.mFishMaxStruggleDist
			v56.mFishMaxStruggleDist = v10.FISH_ESCAPE_DISTANCE
			local v76 = v75 - v39.mLineHandPosition

			if Length(v76) > v56.mFishMaxStruggleDist then
				Normalize(v76)
				v75 = v39.mLineHandPosition + v76 * v56.mFishMaxStruggleDist
			end

			v56.mFishMaxStruggleDist = mFishMaxStruggleDist
		end

		local v76 = fn2(__wf_atom_28d5d4aa3, v75, true)

		if not _T.fishingDebugNeverLose then
			local v77 = GetTargetHeading()

			if
				(math.abs((module8.WrapAngle(v77 - heading))) > v10.MAX_FISH_HEADING or GetTargetDistance() > v10.FISH_ESCAPE_DISTANCE)
				and GetTargetDistance() > v58.mMinJumpDistance
			then
				fn36()
				return
			end
		end

		__wf_atom_28d5d4aa3 = v76
	end
end

local function fn43(p)
	if v13 == 2 or v13 == 3 then
		local v67 = GetAimPosition()
		local v68 = Rotation(__wf_atom_fa8d0177(__wf_atom_28d5d4aa2, v67).heading, 0, 0)
		v60.mSweetSpotSpeed = GetTargetDistance() / v10.MAX_CAST_DISTANCE / 2 + 0.5

		if v13 == 2 then
			v60.mSweetSpotValue = 0.97
		else
			v60.mSweetSpotValue += p * v60.mSweetSpotSpeed
		end

		UpdateReticleSize()
		local v69 = __wf_atom_7e8ad928(mFishReticleMovie)
		local v70 = v69 and v13 == 3
		v61 = __wf_atom_421b01aa(v61 + p * 2, 0, 1)
		v20:__wf_atom_68f2c268(1 - v61)
		v20:Teleport(v67, v68)

		if _T.FishingReticleData == nil then
			_T.FishingReticleData = {}
		end

		_T.FishingReticleData.Avatar = avatar
		_T.FishingReticleData.LureDeco = mLureDeco
		_T.FishingReticleData.AimPos = __wf_atom_28d5d4aa3
		v20:SetVisibility(v70, v70)
		fishReticle:Teleport(v67, Rotation())
		fishReticle:SetVisibility(v70, v70)
		v21:__wf_atom_68f2c268(1 - GetTargetDistance() / v10.MIN_CAST_DISTANCE)
		v21:Teleport(v67, GetTargetDirection())
		v21:SetVisibility(v69, v69)
	else
		if v13 == 6 or v13 ~= 4 and v13 ~= 5 and v13 ~= 6 and v13 ~= 7 then
			return
		end

		local v67 = Time() - v43.mInitialLobTime
		local v68 = __wf_atom_421b01aa(v67 / 1, 0, 1)
		v61 = __wf_atom_421b01aa(v61 + p * 4, 0, 1)
		local v69 = __wf_atom_421b01aa(v61 / 1, 0, 1)
		v21:SetMeshScale(0.08)
		v21:Teleport(__wf_atom_28d5d4aa3, GetTargetDirection())
		v21:SetVisibility(false, false)

		if v13 == 4 then
			v20:__wf_atom_68f2c268(v69)
			fishReticle:__wf_atom_68f2c268(v69)
		else
			v20:__wf_atom_68f2c268(1)
			fishReticle:__wf_atom_68f2c268(1)
		end

		local __wf_atom_be0bea4a = v21:__wf_atom_be0bea4a()

		for _, v70 in ipairs(__wf_atom_be0bea4a) do
			v70:__wf_atom_a763aa1a(v68)
		end
	end
end

local function fn44(p)
	if __wf_atom_7e8ad928(mLureDeco) or __wf_atom_7e8ad928(avatar) then
		return
	end

	local v67 = Time()

	if v13 == 3 then
		local __wf_atom_1c374cc9 = avatar:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
		local __wf_atom_8e4cf043 = avatar:__wf_atom_8e4cf043(Symbol("GAME_R1_WEAPON1"))
		mLureDeco:__wf_atom_192a2f34(__wf_atom_1c374cc9, __wf_atom_8e4cf043)
	elseif v13 == 2 or v13 == 4 and v67 < v43.mInitialLobTime then
		local v68 = Time() - v45

		if v68 < v10.LURE_RESET_INTERPOLATION_TIME and v45 ~= 3.4028234663852886e38 then
			local v69 = __wf_atom_421b01aa(v68 / v10.LURE_RESET_INTERPOLATION_TIME, 0, 1)
			local v70 = __wf_atom_24a82b69(v69)
			local __wf_atom_1c374cc9 = avatar:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
			local __wf_atom_8e4cf043 = avatar:__wf_atom_8e4cf043(Symbol("GAME_R1_WEAPON1"))
			local v71 = __wf_atom_f55d6358(__wf_atom_28d5d4aa6, __wf_atom_1c374cc9, v70)
			local v72 = __wf_atom_9d2f097a(__wf_atom_80368bb1_2, __wf_atom_8e4cf043, v70)
			mLureDeco:__wf_atom_192a2f34(v71, v72)
		else
			local __wf_atom_1c374cc9 = avatar:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
			local __wf_atom_8e4cf043 = avatar:__wf_atom_8e4cf043(Symbol("GAME_R1_WEAPON1"))
			mLureDeco:__wf_atom_192a2f34(__wf_atom_1c374cc9, __wf_atom_8e4cf043)
		end

		if not __wf_atom_7e8ad928(v18) then
			v18:__wf_atom_a763aa1a(1)
		end
	elseif v13 == 4 or v13 == 5 then
		if v43.mInitialLobTime <= v67 and v67 < v43.mLureEnterWaterTime then
			local v68 = v67 - v43.mInitialLobTime

			if not __wf_atom_7e8ad928(v16) and v14.mReelHorizontalInput then
				local __wf_atom_9d937e7e = avatar:CameraControl():__wf_atom_9d937e7e()
				local __wf_atom_2490589b = v66:__wf_atom_2490589b(v14.mReelHorizontalInput * 2, p)
				local v69 = __wf_atom_9341614d(Vector(__wf_atom_2490589b * p, 0, 0), __wf_atom_9d937e7e)
				v43.mAirControlOffset += v69
				__wf_atom_28d5d4aa3 += v69
			end

			local v69, v70 = fn10(
				v43.mInitialLobPosition + v43.mAirControlOffset,
				v43.mInitialLobRotation,
				v43.mInitialLobVelocity,
				v68
			)
			v70.pitch -= 90

			if v68 < 0.3 then
				local __wf_atom_1c374cc9 = avatar:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
				local __wf_atom_8e4cf043 = avatar:__wf_atom_8e4cf043(Symbol("GAME_R1_WEAPON1"))
				local v71 = __wf_atom_bdb9797f(v43.mInitialLobPosition, v69, __wf_atom_1c374cc9)
				local v72 = __wf_atom_421b01aa(v68 / 0.3, 0, 1)
				v69 = __wf_atom_f55d6358(v71, v69, v72)
				v70 = __wf_atom_9d2f097a(__wf_atom_8e4cf043, v70, v72)
			end

			mLureDeco:__wf_atom_192a2f34(v69, v70)
			v21:__wf_atom_68f2c268((v67 - v43.mInitialLobTime) / (v43.mLureEnterWaterTime - v43.mInitialLobTime))
		elseif v43.mLureEnterWaterTime <= v67 then
			if not v43.mLureEnteredWater then
				OnLureEnteredWater(v60.mIsPerfectCast)
				v43.mLureEnteredWater = true
				v25 = mLureDeco:Attach(lureRipplesType, Symbol(""), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				v40.mLureVelocity = v43.mLureImpactVerticalVelocity * 0.5
				_T.fishingLureInWater = true
				v43.mLureImpactPosition = mLureDeco:GetPosition()
				v43.mLureImpactRotation = mLureDeco:__wf_atom_dc309f8a()
				v40.mSmoothedLureReelX:__wf_atom_4453e49c(0)
				v40.mSmoothedLureReelZ:__wf_atom_4453e49c(0)
				v40.mLureNoiseHeading = v43.mLureImpactRotation.heading
				v40.mLureNoiseHeadingVelocity = 0
			end

			if v43.mLureSettledTime < v67 and not v43.mLureSettled then
				v43.mLureSettled = true
			end

			local v68 = Vector(__wf_atom_28d5d4aa3.x, __wf_atom_28d5d4aa3.y, __wf_atom_28d5d4aa3.z)

			if v67 < v43.mLureSettledTime then
				local v69 = v67 - v43.mLureEnterWaterTime
				local v70 = v43.mLureSettledTime - v43.mLureEnterWaterTime
				local v71 = __wf_atom_421b01aa(v69 / v70, 0, 1)
				local __wf_atom_f55d6358 = __wf_atom_f55d6358
				v68 = __wf_atom_f55d6358(v43.mLureImpactPosition, __wf_atom_28d5d4aa3, fn21(v71)) -- inferred equivalent call
			end

			local v69 = __wf_atom_28d5d4aa2.y - mLureDeco:GetPosition().y
			local v70 = __wf_atom_421b01aa(v69 / v40.mMaxBuoyancyDepth, 0, 1)
			v40.mLureVelocity -= v10.GRAVITY * p
			local v72 = v70 * v40.mBuoyancyAcceleration * p
			v40.mLureVelocity += v72
			local v74 = __wf_atom_28d5d4aa2.y - mLureDeco:GetPosition().y
			local v75 = __wf_atom_421b01aa(v74 / v40.mMaxBuoyancyDepth, 0, 1)

			if v75 > 0 then
				v40.mLureVelocity *= math.exp(-v10.LURE_VELOCITY_DAMPING * v75 * p)
			end

			v68.y = mLureDeco:GetPosition().y + v40.mLureVelocity * p
			local v76 = Vector(0, -1, 0)
			local v77 = Noise(Time() * 0.1) * 720
			v40.mLureNoiseHeadingVelocity += v77 * p
			v40.mLureNoiseHeadingVelocity *= math.exp(-2 * p)
			v40.mLureNoiseHeading = module8.WrapAngle(v40.mLureNoiseHeading + v40.mLureNoiseHeadingVelocity * p)
			local v80 = Rotation(0, 0, 0)
			v80.heading = v40.mLureNoiseHeading
			v80.pitch = Noise(Time() * 0.08 + 10) * 0.1
			v80.pitch = __wf_atom_104bfe98(0, v80.pitch, __wf_atom_24a82b69(2))
			local v81 = v76 + __wf_atom_9341614d(Vector(0, 0, 1), v80) * 0.3
			Normalize(v81)
			local __wf_atom_2490589b = v40.mSmoothedLureReelX:__wf_atom_2490589b(__wf_atom_28d5d4aa5.x, p)
			local __wf_atom_2490589b2 = v40.mSmoothedLureReelZ:__wf_atom_2490589b(__wf_atom_28d5d4aa5.z, p)
			local v82 = v81 - Vector(__wf_atom_2490589b, 0, __wf_atom_2490589b2) * 2
			Normalize(v82)
			local v83 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v82)
			v83.pitch = module8.WrapAngle(v83.pitch - 90)
			v83.bank = 0
			local v84 = __wf_atom_421b01aa((v67 - v43.mLureEnterWaterTime) / 1, 0, 1)
			local v85 = __wf_atom_9d2f097a(v43.mLureImpactRotation, v83, __wf_atom_24a82b69(v84))
			v85.bank = 0
			mLureDeco:__wf_atom_192a2f34(v68, v85)
		end

		if not __wf_atom_7e8ad928(v18) then
			local v68 = 1 - __wf_atom_421b01aa((v67 - v43.mInitialLobTime) / 0.5, 0, 1)
			v18:__wf_atom_a763aa1a(v68)
		end
	elseif v13 == 6 and not __wf_atom_7e8ad928(v18) then
		v18:__wf_atom_a763aa1a(1)
	end

	local __wf_atom_e919fb8e = avatar:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.fishingLureDepth = __wf_atom_28d5d4aa2.y - mLureDeco:GetPosition().y
end

local function fn45(p)
	if v13 == 7 then
		local v67

		if v14.mActionKeyHeld then
			v67 = flag4 and not flag3
		else
			local v68 = v14.mReelHorizontalInput < 0 and -1 or 0
			local v69 = v14.mReelHorizontalInput > 0 and 1 or v68
			v67 = v69 ~= 0 and v69 ~= math.sign(v56.mCurrSideStruggleAccel)

			if v67 then
				v67 = flag4 and not flag3
			end
		end

		if okay == STAMINA_STATE.OKAY then
			if v67 then
				okay = STAMINA_STATE.IN_USE
			end
		elseif okay == STAMINA_STATE.IN_USE then
			if v46.mRemainingStamina <= 0 then
				okay = STAMINA_STATE.BREAKING
				v46.mStaminaStateTime = v46.mStaminaBreakDelay
			elseif not v67 then
				okay = STAMINA_STATE.DELAY
				v46.mStaminaStateTime = v46.mStaminaRegenDelay
			end
		elseif okay == STAMINA_STATE.DELAY then
			if v67 then
				okay = STAMINA_STATE.IN_USE
			elseif v46.mStaminaStateTime <= 0 then
				okay = STAMINA_STATE.OKAY
				v46.mStaminaStateTime = 0
				v46.mStaminaRegenSpeed = 0
			end
		elseif okay == STAMINA_STATE.BREAKING then
			if v67 then
				if v46.mStaminaStateTime <= 0 then
					fn36()
				end
			else
				okay = STAMINA_STATE.DELAY
			end
		end

		if okay == STAMINA_STATE.OKAY then
			if v46.mRemainingStamina < 1 then
				v46.mStaminaRegenSpeed += v46.mStaminaRegenAccel * p
				v46.mRemainingStamina += v46.mStaminaRegenSpeed * p
			end
		elseif okay == STAMINA_STATE.IN_USE then
			local v68 = 0

			if v14.mActionKeyHeld then
				v68 = 1 / v46.mLineDurability
			else
				local v69 = v14.mReelHorizontalInput < 0 and -1 or 0
				local v70 = v14.mReelHorizontalInput > 0 and 1 or v69

				if v70 ~= 0 and v70 ~= math.sign(v56.mCurrSideStruggleAccel) then
					v68 = v46.mCounterStaminaDrain / (v56.mCounterMovementMultiplier * v46.mLineDurability)
				end
			end

			v46.mRemainingStamina -= v46.mConstraintPullStrength * v68
		elseif okay == STAMINA_STATE.DELAY then
			v46.mStaminaStateTime -= p
		elseif okay == STAMINA_STATE.BREAKING then
			v46.mStaminaStateTime -= p
		end

		v46.mRemainingStamina = __wf_atom_421b01aa(v46.mRemainingStamina, 0, 1)
		OnLineStaminaUpdate(v46.mRemainingStamina)
		_T.FishingLineStamina = v46.mRemainingStamina
	end

	if v47.mLinePulseRemainingTime > 0 then
		if not (__wf_atom_7e8ad928(v47.mStunLineFx) or __wf_atom_7e8ad928(v23)) then
			local v67 = fn21(v47.mLinePulseRemainingTime / v47.mLinePulseDuration) -- inferred equivalent call
			local v68 = v23:GetPosition() + v23:__wf_atom_bfb052a2(v67)
			v47.mStunLineFx:Teleport(v68, __wf_atom_80368bb1)
		end

		v47.mLinePulseRemainingTime -= p

		if v47.mLinePulseRemainingTime <= 0 then
			v47.mStunLineFxRemainingDelay = v47.mStunLineFxDelay
			v56.mPlayerStunRemainingTime = v56.mFailedAttemptPlayerStunDuration

			if not __wf_atom_7e8ad928(avatar) then
				if not __wf_atom_7e8ad928(playerStunFXType) then
					if not __wf_atom_7e8ad928(v29) then
						gRegion:__wf_atom_dd1e4d10(v29)
					end

					v29 = avatar:Attach(playerStunFXType, EMPTY_SYMBOL)
				end

				local mFailedAttemptPlayerDamage = v56.mFailedAttemptPlayerDamage

				if _T.fishingDebugAlwaysFailStun then
					mFailedAttemptPlayerDamage = math.max(1, mFailedAttemptPlayerDamage)
				end

				local damageData = Engine.DamageData()
				damageData.baseAmount = mFailedAttemptPlayerDamage
				damageData:__wf_atom_7498285f(5, 1)
				local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

				if not __wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) then
					damageData:__wf_atom_6b472125(__wf_atom_296472bc.mFishOnHook)
				end

				avatar:__wf_atom_7470861b():__wf_atom_63396172(Symbol("Invulnerable"))
				avatar:__wf_atom_649bf33e(damageData)
			end
		end
	elseif v47.mStunLineFxRemainingDelay > 0 then
		v47.mStunLineFxRemainingDelay -= p

		if v47.mStunLineFxRemainingDelay <= 0 then
			gRegion:__wf_atom_dd1e4d10(v47.mStunLineFx)
		end
	end

	if v56.mPlayerStunRemainingTime > 0 then
		v56.mPlayerStunRemainingTime -= p

		if v56.mPlayerStunRemainingTime <= 0 then
			gRegion:__wf_atom_dd1e4d10(v29)
		end
	end

	Color(0, 0, 0)
	Color(0, 0, 0)
	local mEmissiveIntensity = 0
	local mLineColor, mEmissiveColor

	if v13 == 7 then
		if v46.mRemainingStamina < v46.mBlinkingThreshold then
			v46.mTimeUntilNextBlink -= p
			local v68 = v46.mRemainingStamina / v46.mBlinkingThreshold

			if v46.mTimeUntilNextBlink <= 0 then
				v46.mTimeUntilNextBlink = __wf_atom_104bfe98(v46.mBlinkSpeed.minValue, v46.mBlinkSpeed.maxValue, v68)
				v46.mIsBlinking = not v46.mIsBlinking
			end

			v47.mEmissiveIntensity = v46.mBlinkEmissiveIntensity / 255

			if v46.mIsBlinking then
				v47.mLineColor = v47.mLineBlinkSecondColor
				v47.mEmissiveIntensity = 1 / 510
			else
				v47.mLineColor = v47.mLineBreakingColor
			end

			v47.mEmissiveColor = v47.mEmissiveBreakingColor
		elseif v46.mRemainingStamina < v46.mColorChangeThreshold then
			local v67 = (v46.mRemainingStamina - v46.mBlinkingThreshold) / (v46.mColorChangeThreshold - v46.mBlinkingThreshold)
			local v68 = 1 - __wf_atom_421b01aa(v67, 0, 1)
			v47.mLineColor = fn3(v47.mLineDefaultColor, v47.mLineBreakingColor, v68)
			v47.mEmissiveIntensity = __wf_atom_104bfe98(0, v46.mBlinkEmissiveIntensity / 255, v68)
			v47.mEmissiveColor = v47.mEmissiveBreakingColor
		else
			v46.mIsBlinking = false
			v47.mEmissiveColor = v47.mEmissiveDefaultColor
		end

		mLineColor = v47.mLineColor
		mEmissiveColor = v47.mEmissiveColor
		mEmissiveIntensity = v47.mEmissiveIntensity
	else
		v47.mLineColor = v47.mLineDefaultColor
		mEmissiveColor = v47.mEmissiveColor
		mLineColor = v47.mLineColor
	end

	if not __wf_atom_7e8ad928(v23) then
		local v67 = Symbol("EmissiveTintColor")
		local v68 = mEmissiveColor.red * mEmissiveIntensity
		local v69 = mEmissiveColor.green * mEmissiveIntensity
		local v70 = mEmissiveColor.blue * mEmissiveIntensity
		v23:SetMaterialParam(v67, v68, v69, v70, 1)
		v24:SetMaterialParam(v67, v68, v69, v70, 1)
		v23:__wf_atom_7fff6c98(mLineColor)
		v24:__wf_atom_7fff6c98(mLineColor)
	end
end

local function fn46(mFishTargetingLure)
	if __wf_atom_7e8ad928(mFishTargetingLure) then
		return
	end

	v44.mBiteAnimStartTime = Time()
	v44.mLastTugTime = 0
	local __wf_atom_8bb4ded3 = fishBiteAnim:__wf_atom_8bb4ded3()
	local __wf_atom_0dcd7684 = fishBiteAnim:__wf_atom_0dcd7684()
	local __wf_atom_43e3d184 = fishBiteAnim:__wf_atom_43e3d184()
	v44.mChompAnimEventDelta = 1

	for i, v67 in ipairs(__wf_atom_0dcd7684) do
		if v67 ~= Symbol("Chomp") then
			continue
		end

		v44.mChompAnimEventDelta = __wf_atom_43e3d184[i]
		break
	end

	v44.mChompAnimEventTime = Time() + v44.mChompAnimEventDelta * __wf_atom_8bb4ded3
	v44.mBiteStartPosition = mFishTargetingLure:GetPosition()
	v44.mBiteStartRotation = mFishTargetingLure:__wf_atom_dc309f8a()
	local __wf_atom_c082fc3d = mFishTargetingLure:__wf_atom_c082fc3d()
	v44.mChompTimePosition = fishBiteAnim:__wf_atom_df9e931d(Symbol("GAME_C1_ROOT"), v44.mChompAnimEventDelta)
	v44.mChompTimePosition *= __wf_atom_c082fc3d
	local __wf_atom_df9e931d, v68 = fishBiteAnim:__wf_atom_df9e931d(Symbol("GAME_C1_JAW1"), v44.mChompAnimEventDelta)
	v44.mLureAttachOffset = __wf_atom_df9e931d * __wf_atom_c082fc3d + __wf_atom_9341614d(
		mFishTargetingLure.mLureAttachOffset * __wf_atom_c082fc3d,
		v68
	)
	mFishTargetingLure:__wf_atom_7b7015c9(nil)
	mFishTargetingLure:__wf_atom_921c1a5f(fishBiteAnim, false, false, 0, Symbol())
	mFishTargetingLure:__wf_atom_3322b766(0, 1)
	v44.mBiteTimer = 0
	mFishTargetingLure:__wf_atom_032e99b2(3)
	v44.mWasPlayingBiteAnim = true
end

local function fn47(p)
	if __wf_atom_7e8ad928(avatar) or __wf_atom_7e8ad928(mLureDeco) then
		return
	end

	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if __wf_atom_7e8ad928(__wf_atom_296472bc) or __wf_atom_7e8ad928(__wf_atom_296472bc.mFishTargetingLure) then
		return
	end

	local mFishTargetingLure = __wf_atom_296472bc.mFishTargetingLure
	local position = mFishTargetingLure:GetPosition()

	if mFishTargetingLure:__wf_atom_43e681f1() == 0 then
		fn46(mFishTargetingLure)
	elseif mFishTargetingLure:__wf_atom_43e681f1() == 3 then
		v44.mBiteTimer += p
		local __wf_atom_1ee2a2df = mFishTargetingLure:__wf_atom_1ee2a2df(0)

		if v44.mChompAnimEventDelta < __wf_atom_1ee2a2df or v44.mBiteTimer > 2 then
			fn32(mFishTargetingLure)
			return
		end

		if not __wf_atom_7e8ad928(v44.mLastTugTime) and v44.mLastTugTime > v44.mBiteAnimStartTime then
			fn31(mFishTargetingLure)
			return
		end

		local v68 = __wf_atom_fa8d0177(v44.mBiteStartPosition, mLureDeco:GetPosition())
		v68.bank = 0
		local v69 = mLureDeco:GetPosition() - __wf_atom_9341614d(v44.mLureAttachOffset, v68)
		local v70 = __wf_atom_421b01aa(__wf_atom_1ee2a2df / v44.mChompAnimEventDelta, 0, 1)
		local v71 = __wf_atom_f55d6358(v44.mBiteStartPosition, v69, v70)
		local v72 = __wf_atom_421b01aa(v44.mBiteTimer / v44.mRotationInterpolationDuration, 0, 1)
		mFishTargetingLure:Teleport(v71, (__wf_atom_9d2f097a(v44.mBiteStartRotation, v68, v72)))
	elseif mFishTargetingLure:__wf_atom_43e681f1() == 4 then
		if Time() > v44.mBiteWindowStartTime + mFishTargetingLure.mBiteWindowDuration then
			fn31(mFishTargetingLure)
			return
		end

		if v44.mBiteVelocityBlendTimer > 0 then
			v44.mBiteVelocityBlendTimer -= p
		end

		if not mFishTargetingLure:__wf_atom_c138b19b(fishBiteAnim) and v44.mWasPlayingBiteAnim then
			mFishTargetingLure:__wf_atom_7b7015c9(nil)
			mFishTargetingLure:__wf_atom_921c1a5f(fishStruggleAnim, false, true, 0, Symbol())
			mFishTargetingLure:__wf_atom_3322b766(0, v44.mBiteStruggleAnimRate)
			v44.mWasPlayingBiteAnim = false
		end

		v44.mBiteStruggleRotateTimer -= p

		if v44.mBiteStruggleRotateTimer <= 0 then
			local heading2 = __wf_atom_fa8d0177(avatar:GetPosition(), position).heading
			v44.mBiteStruggleTargetHeading = module8.WrapAngle(heading2 - 90 + math.random() * 180)
			local mBiteStruggleTargetPitch

			if __wf_atom_28d5d4aa2.y - position.y < 0.5 then
				mBiteStruggleTargetPitch = math.random(50, 80)
			else
				mBiteStruggleTargetPitch = math.random(10, 60)
			end

			v44.mBiteStruggleTargetPitch = mBiteStruggleTargetPitch
			v44.mBiteStruggleRotateTimer = mFishTargetingLure.mBiteStruggleRotateTimeRange:__wf_atom_ff1686f2()
		end

		local __wf_atom_dc309f8a = mFishTargetingLure:__wf_atom_dc309f8a()
		local mBoostedMaxTurnRate = mFishTargetingLure.mBoostedMaxTurnRate
		local mBoostedTurnAcceleration = mFishTargetingLure.mBoostedTurnAcceleration
		local angle = module8.WrapAngle(v44.mBiteStruggleTargetHeading - mFishTargetingLure:__wf_atom_dc309f8a().heading)

		if angle == 0 then
			v44.mHeadingTurnRate = 0
		else
			if v44.mHeadingTurnRate * v44.mHeadingTurnRate / (mBoostedTurnAcceleration * 2) >= math.abs(angle) then
				v44.mHeadingTurnRate -= mBoostedTurnAcceleration * p
			else
				v44.mHeadingTurnRate += mBoostedTurnAcceleration * p
			end

			v44.mHeadingTurnRate = __wf_atom_421b01aa(v44.mHeadingTurnRate, 0, mBoostedMaxTurnRate)
			__wf_atom_dc309f8a.heading = mFishTargetingLure:__wf_atom_dc309f8a().heading + v44.mHeadingTurnRate * (angle / math.abs(angle)) * p
		end

		local mBoostedMaxTurnRate2 = mFishTargetingLure.mBoostedMaxTurnRate
		local mBoostedTurnAcceleration2 = mFishTargetingLure.mBoostedTurnAcceleration
		local angle2 = module8.WrapAngle(v44.mBiteStruggleTargetPitch - mFishTargetingLure:__wf_atom_dc309f8a().pitch)

		if angle2 == 0 then
			v44.mPitchTurnRate = 0
		else
			if v44.mPitchTurnRate * v44.mPitchTurnRate / (mBoostedTurnAcceleration2 * 2) >= math.abs(angle2) then
				v44.mPitchTurnRate -= mBoostedTurnAcceleration2 * p
			else
				v44.mPitchTurnRate += mBoostedTurnAcceleration2 * p
			end

			v44.mPitchTurnRate = __wf_atom_421b01aa(v44.mPitchTurnRate, 0, mBoostedMaxTurnRate2)
			__wf_atom_dc309f8a.pitch = mFishTargetingLure:__wf_atom_dc309f8a().pitch + v44.mPitchTurnRate * (angle2 / math.abs(angle2)) * p
		end

		v44.mTargetVelocity = mFishTargetingLure.mBiteStruggleMaxVelocity
		local mBoostedAcceleration = mFishTargetingLure.mBoostedAcceleration
		local mBoostedMinTurnVelocityMultiplier = mFishTargetingLure.mBoostedMinTurnVelocityMultiplier
		local v68 = __wf_atom_104bfe98(
			1,
			mBoostedMinTurnVelocityMultiplier,
			__wf_atom_421b01aa(math.abs(angle / 180), 0, 1)
		)
		local v69 = __wf_atom_104bfe98(
			1,
			mBoostedMinTurnVelocityMultiplier,
			__wf_atom_421b01aa(math.abs(angle2 / 180), 0, 1)
		)
		local v70 = 1 * v68 * v69
		v44.mTargetVelocity *= v70

		if v44.mBiteVelocityBlendTimer > 0 then
			local v72 = __wf_atom_421b01aa(v44.mBiteVelocityBlendTimer / v44.BITE_VELOCITY_BLEND_DURATION, 0, 1)
			v44.mVelocity = __wf_atom_104bfe98(mFishTargetingLure.mBiteStruggleMaxVelocity, v44.mBiteStartVelocity, v72)
		elseif v44.mBiteVelocityBlendTimer <= 0 and not __wf_atom_7e8ad928(v44.mTargetVelocity) then
			local v72 = v44.mTargetVelocity - v44.mVelocity

			if v72 ~= 0 then
				local v73 = v72 < 0
				v44.mVelocity = math.max(0, v44.mVelocity + mBoostedAcceleration * p * module8.Ternary(v72 > 0, 1, -1))

				if v73 and v44.mVelocity < v44.mTargetVelocity or not v73 and v44.mVelocity > v44.mTargetVelocity then
					v44.mVelocity = v44.mTargetVelocity
				end
			end
		end

		local v72 = v44.mVelocity * p
		local v73 = position + __wf_atom_9341614d(Vector(0, 0, v72), __wf_atom_dc309f8a)

		if v73 ~= position then
			local v74 = position + __wf_atom_9341614d(
				Vector(0, 0, mFishTargetingLure.mMovementSweepRadius + v72),
				__wf_atom_dc309f8a
			)
			local v75 = Vector()

			if not __wf_atom_7e8ad928((gRegion:Raycast(position, v74, nil, nil, v75, true, true))) then
				local v76 = Distance(position, v75) - mFishTargetingLure.mMovementSweepRadius
				v73 = position + __wf_atom_9341614d(Vector(0, 0, v76 - 0.00001), __wf_atom_dc309f8a)
				v44.mVelocity = 0
			end
		end

		local __wf_atom_1c374cc9 = avatar:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
		local v74 = Distance(v73, __wf_atom_1c374cc9)

		if v44.mBiteLineLength < v74 then
			local v75 = v73 - __wf_atom_1c374cc9
			Normalize(v75)
			local v76 = math.min(v74, v44.mBiteLineLength)
			local v77 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, v73)
			v73 = __wf_atom_1c374cc9 + __wf_atom_9341614d(Vector(0, 0, v76), v77)
		end

		mFishTargetingLure:Teleport(v73, __wf_atom_dc309f8a)
	elseif mFishTargetingLure:__wf_atom_43e681f1() == 5 then
		local v67 = __wf_atom_421b01aa(GetTargetDistance() / v50, 0, 1)
		mFishTargetingLure:SetMeshScale((v48:__wf_atom_2490589b(__wf_atom_104bfe98(0.75, 1, v67) * v49, p)))
		mFishTargetingLure:__wf_atom_3564c669((v57:__wf_atom_2490589b(5, p)))
		mFishTargetingLure:__wf_atom_e3c998ce(Symbol("GAME_C1_JAW1"), Rotation(0, 0, 20), __wf_atom_28d5d4aa)
		local _mRemainingFishStamina = v56.mRemainingFishStamina
		local v69 = __wf_atom_421b01aa(v56.mRemainingFishStamina / v56.mFishStamina, 0, 1)
		local v70 = Color(255, 0, 0)
		local v71 = v52
		local v72

		if v56.mIsInFirstFight then
			local v73 = v56.mRemainingInitialResistanceTime / v56.mInitialResistanceDuration

			if v56.mRemainingInitialResistanceTime < v56.mFishInitialColorFadeThreshold then
				v71 = fn3(v52, v70, v56.mRemainingInitialResistanceTime / v56.mFishInitialColorFadeThreshold)
			else
				v71 = v70
			end

			v72 = __wf_atom_104bfe98(20, 60, v73)
		else
			v72 = __wf_atom_104bfe98(0, 20, v69)
		end

		local __wf_atom_2490589b = v56.mSmoothFishEmissiveValue:__wf_atom_2490589b(v72, p)

		if not __wf_atom_7e8ad928(mFishTargetingLure) then
			mFishTargetingLure:SetMaterialParam(
				Symbol("EmissiveTintColorHi"),
				v71.red / 255,
				v71.green / 255,
				v71.blue / 255,
				1,
				false
			)
			mFishTargetingLure:SetMaterialParam(Symbol("EmissiveMapAtten"), __wf_atom_2490589b, 0, 0, 0, true)
		end

		local v73 = __wf_atom_80368bb1_3
		local FISH_STRUGGLE_ROTATION_ACCELERATION = v10.FISH_STRUGGLE_ROTATION_ACCELERATION

		if not flag4 then
			if v14.mActionKeyHeld then
				local v74 = __wf_atom_28d5d4aa3 + Vector(__wf_atom_28d5d4aa5.x, 0, __wf_atom_28d5d4aa5.z)
				__wf_atom_80368bb1_4 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa3, v74)
			end

			FISH_STRUGGLE_ROTATION_ACCELERATION = v10.FISH_ROTATION_ACCELERATION
		end

		__wf_atom_80368bb1_4.pitch = -10
		local v74 = math.mod(__wf_atom_80368bb1_4.heading - __wf_atom_80368bb1_3.heading + 360, 360)

		if v74 > 180 then
			v74 -= 360
		end

		local v75 = v74 * FISH_STRUGGLE_ROTATION_ACCELERATION
		v51[1] += (v75 - v51[1]) * v10.FISH_ROTATION_SMOOTHING_SPEED * p
		local v77 = math.mod(__wf_atom_80368bb1_4.pitch - __wf_atom_80368bb1_3.pitch + 360, 360)

		if v77 > 180 then
			v77 -= 360
		end

		local v78 = v77 * FISH_STRUGGLE_ROTATION_ACCELERATION
		v51[2] += (v78 - v51[2]) * v10.FISH_ROTATION_SMOOTHING_SPEED * p
		local v80 = math.mod(__wf_atom_80368bb1_4.bank - __wf_atom_80368bb1_3.bank + 360, 360)

		if v80 > 180 then
			v80 -= 360
		end

		local v81 = v80 * FISH_STRUGGLE_ROTATION_ACCELERATION
		v51[3] += (v81 - v51[3]) * v10.FISH_ROTATION_SMOOTHING_SPEED * p
		v73.heading = math.mod(__wf_atom_80368bb1_3.heading + v51[1] * p, 360)
		v73.pitch = math.mod(__wf_atom_80368bb1_3.pitch + v51[2] * p, 360)
		v73.bank = math.mod(__wf_atom_80368bb1_3.bank + v51[3] * p, 360)

		if v13 == 7 and not (__wf_atom_28d5d4aa3.y < __wf_atom_28d5d4aa2.y) then
			v73.pitch = 0
			v73.bank = 0
		end

		__wf_atom_80368bb1_3 = v73
		mFishTargetingLure:Teleport(__wf_atom_28d5d4aa3, __wf_atom_80368bb1_3)
	end
end

local function fn48(p) -- 1 equivalent call inferred from this helper
	local v67 = __wf_atom_421b01aa(p, 0, 1)
	return v67 * v67
end

local function fn49(p) -- 2 equivalent calls inferred from this helper
	local v67 = __wf_atom_421b01aa(math.abs(p), 0, 1)
	return 1 - v67 * v67 * (3 - 2 * v67)
end

local function fn50(p)
	if __wf_atom_7e8ad928(mLureDeco) or __wf_atom_7e8ad928(v17) then
		return
	end

	local v67 = Time()

	if v13 == 2 or v13 == 3 or v13 == 4 and v67 < v43.mInitialLobTime then
		local __wf_atom_1c374cc9 = avatar:__wf_atom_1c374cc9(Symbol("GAME_R1_FINGER3"))
		local v68 = {
			v17:__wf_atom_1c374cc9(Symbol("GAME_C1_ROPE01")),
			__wf_atom_1c374cc9,
			__wf_atom_f55d6358(__wf_atom_1c374cc9, GetLureLinePosition(), 0.5),
			GetLureLinePosition()
		}
		local v69 = Time() - v45

		if v39.mLineSnapped and v69 < v10.LURE_RESET_INTERPOLATION_TIME and v45 ~= 3.4028234663852886e38 then
			local v70 = __wf_atom_421b01aa(v69 / v10.LURE_RESET_INTERPOLATION_TIME, 0, 1)
			__wf_atom_24a82b69(v70)
			local v71 = v39.mLineSnapDistance * 1 / v10.MAX_CAST_DISTANCE
			local v72 = 0.4 + 0.4 * v39.mLineSnapDistance / v10.MAX_CAST_DISTANCE
			local v73 = math.sin(__wf_atom_421b01aa(v69 / v72, 0, 1) * 3.141592653589793)
			local v74 = v69 * -0.8
			local v75 = math.max(
				1,
				Distance(__wf_atom_1c374cc9, mLureDeco:GetPosition()) / v10.FISHING_LINE_SPLINE_SPACING
			)
			v68 = { v17:__wf_atom_1c374cc9(Symbol("GAME_C1_ROPE01")), __wf_atom_1c374cc9 }

			for i = 1, v75 do
				local v76 = i / v75
				local v77 = __wf_atom_f55d6358(__wf_atom_1c374cc9, mLureDeco:GetPosition(), v76)
				local v78 = fn49(math.abs(v76 - 0.3) / 0.3) -- inferred equivalent call
				local v79 = math.sin((v76 - v74) * 3.141592653589793 * 2 * 5) * v71 * v78 * v73
				v77.y += v79
				table.insert(v68, v77)
			end

			table.insert(v68, mLureDeco:GetPosition())
		end

		if __wf_atom_7e8ad928(v23) then
			fn()
		end

		if __wf_atom_084b3e93() > 0 then
			v23:__wf_atom_ff43aa5a(v68, true)
			v24:__wf_atom_ff43aa5a(v68, true)
		end
	elseif v13 == 4 or v13 == 5 or v13 == 6 or v13 == 7 then
		local v68 = math.max(1, GetTargetDistance() / v10.FISHING_LINE_SPLINE_SPACING)
		local v69 = v67 - v43.mInitialLobTime
		local v70 = v43.mLureEnterWaterTime - v43.mInitialLobTime
		local mLineHandPosition

		if avatar:__wf_atom_7bcdbf55(v9.mFishingCastAnimAction) or avatar:__wf_atom_c138b19b(castAnim) then
			mLineHandPosition = v17:__wf_atom_1c374cc9(Symbol("GAME_C1_ROPE01"))
			v39.mFishingLineHandSwitchTime = 0
		else
			local __wf_atom_1c374cc9 = avatar:__wf_atom_1c374cc9(Symbol("GAME_R1_FINGER3"))
			v39.mFishingLineHandSwitchTime += p
			local v73 = __wf_atom_421b01aa(v39.mFishingLineHandSwitchTime / 0.5, 0, 1)
			mLineHandPosition = v17:__wf_atom_1c374cc9(Symbol("GAME_C1_ROPE01")) * (1 - v73) + __wf_atom_1c374cc9 * v73
		end

		v39.mLineHandPosition = mLineHandPosition
		local v72 = GetLureLinePosition()
		local v73 = Distance(mLineHandPosition, v72)
		local v74 = v43.mInitialLobTime + v70 * 0.25
		local v75 = v43.mLureEnterWaterTime - v74
		local v76 = v67 - v74
		local v77 = fn48(__wf_atom_421b01aa(v76 / v75, 0, 1)) -- inferred equivalent call
		local lineCircleIntersect2D = module4.LineCircleIntersect2D(mLineHandPosition, v72, mLineHandPosition, 1)
		local v78

		if __wf_atom_7e8ad928(lineCircleIntersect2D) then
			v78 = mLineHandPosition
		else
			local v79 = lineCircleIntersect2D - v77 * Vector(0, 0.1 + GetTargetDistance() / 10, 0)
			local v80 = __wf_atom_421b01aa(v76 / v75, 0, 1)
			v78 = __wf_atom_f55d6358(lineCircleIntersect2D, v79, v80)
		end

		local _, v79 = fn10(v43.mInitialLobPosition, v43.mInitialLobRotation, v43.mInitialLobVelocity, v69)
		local v80 = v73 * (0.2 + 0.5 * __wf_atom_421b01aa(v69 / v70, 0, 1))
		local v81 = v43.mLureEnterWaterTime - v70 * 0.2
		local v82 = v72 + __wf_atom_9341614d(Vector(0, 0, -v80), v79)

		if not (v67 < v81) then
			local v83 = v72 + __wf_atom_9341614d(
				Vector(0, 0, v80),
				Rotation(__wf_atom_fa8d0177(v72, mLineHandPosition).heading, 0, 0)
			)
			local v84 = v67 - v81
			local v85 = __wf_atom_421b01aa(v84 / 1, 0, 1)
			local __wf_atom_f55d6358 = __wf_atom_f55d6358
			v82 = __wf_atom_f55d6358(v82, v83, fn22(v85)) -- inferred equivalent call
		end

		local v83

		if v43.mLureEnterWaterTime < v67 then
			local v84 = math.max(__wf_atom_28d5d4aa2.y - v72.y, 0)
			local v85 = v72 + __wf_atom_9341614d(
				Vector(0, 0, v84 / 4),
				Rotation(__wf_atom_fa8d0177(v72, mLineHandPosition).heading, 0, 0)
			)
			v85.y = __wf_atom_28d5d4aa2.y
			local v86 = v67 - v43.mLureEnterWaterTime
			local v87 = __wf_atom_421b01aa(v86 / 1, 0, 1)
			local __wf_atom_f55d6358 = __wf_atom_f55d6358
			v83 = __wf_atom_f55d6358(v72, v85, fn22(v87)) -- inferred equivalent call
		else
			v83 = v72
		end

		local distance2d = module3.Distance2d(v78, mLineHandPosition)
		local distance2d2 = module3.Distance2d(v82, mLineHandPosition)
		local v84 = __wf_atom_421b01aa((distance2d2 - distance2d) / 0.2, 0, 1)
		local v85 = __wf_atom_f55d6358(v78, v82, v84)
		local mActionKeyHeld = v14.mActionKeyHeld or v14.mReelHorizontalInput ~= 0
		local ternary = module8.Ternary(mActionKeyHeld, 0, 1)
		local ternary2 = module8.Ternary(mActionKeyHeld, p, p / 2)
		local __wf_atom_2490589b = v39.mReelSlackMultiplier:__wf_atom_2490589b(ternary, ternary2)
		local v86 = __wf_atom_421b01aa(v73 / 2, 0, 1)
		local ternary3 = module8.Ternary(v13 == 6 or v13 == 7, 0, 1)
		local __wf_atom_2490589b2 = v39.mBiteFightSlackMultiplier:__wf_atom_2490589b(ternary3, p)
		local v87

		if v67 < v39.mTugTime + v10.TUG_LINE_TIGHTEN_DURATION and v39.mTugTime ~= 3.4028234663852886e38 then
			local v88 = __wf_atom_421b01aa(
				(v67 - v39.mTugTime) / (v10.TUG_LINE_TIGHTEN_DURATION * v10.TUG_LINE_LERP_FRACTION),
				0,
				1
			)
			v87 = 1 - __wf_atom_24a82b69(v88)
			v39.mTugSlackMultiplier:__wf_atom_4453e49c(v87)
		else
			v87 = v39.mTugSlackMultiplier:__wf_atom_2490589b(1, p)
		end

		local v88 = { v78, v85, v83 }

		for i = 1, #v88 do
			local v89 = 1 * __wf_atom_2490589b * v86 * __wf_atom_2490589b2 * v87
			local v90 = __wf_atom_421b01aa(v89, 0.1, 1)
			local v91, v92 = fn8(mLineHandPosition, v72, v88[i])
			v88[i] = __wf_atom_f55d6358(v91, v88[i], v90)

			if not _T.fishingDebugDrawBezierPoints then
				continue
			end

			gRegion:__wf_atom_12f21926(v88[i], v88[i], 0.02, Vector(1, 0, 0), Vector(0, 1, 0), Color(255, 0, 0), 0.05)
			gRegion:__wf_atom_12f21926(v91, v91, 0.01, Vector(1, 0, 0), Vector(0, 1, 0), Color(255, 0, 0), 0.05)
			gRegion:__wf_atom_628723a6(v88[i], v91, Color(255, 0, 0), 0.05)
			gRegion:__wf_atom_5b35a0c8(
				v91 + Vector(0, 0.2, 0),
				Color(0, 255, 255),
				"t: " .. string.format("%.3f", v92),
				1.5,
				0.05
			)
			gRegion:__wf_atom_5b35a0c8(
				v91 + Vector(0, 0.4, 0),
				Color(0, 255, 255),
				"slack: " .. string.format("%.3f", v90),
				1.5,
				0.05
			)
		end

		local v89 = v88[1]
		local v90 = v88[2]
		local v91 = v88[3]

		if _T.fishingDebugDrawBezierPoints then
			gRegion:__wf_atom_12f21926(
				mLineHandPosition,
				mLineHandPosition,
				0.02,
				Vector(1, 0, 0),
				Vector(0, 1, 0),
				Color(0, 0, 255),
				0.05
			)
			gRegion:__wf_atom_12f21926(v72, v72, 0.02, Vector(1, 0, 0), Vector(0, 1, 0), Color(0, 0, 255), 0.05)
		end

		local v92 = GetTargetDistance() * 0.5 / v10.MAX_CAST_DISTANCE
		local v93 = 0.4 + 0.4 * GetTargetDistance() / v10.MAX_CAST_DISTANCE
		local v94 = math.sin(__wf_atom_421b01aa(v69 / v93, 0, 1) * 3.141592653589793)
		local v95 = v69 * 0.8
		local v96 = { v17:__wf_atom_1c374cc9(Symbol("GAME_C1_ROPE01")), mLineHandPosition }

		for i = 1, v68 do
			local v97 = i / v68
			local v98 = fn7(mLineHandPosition, v89, v90, v91, v72, v97)
			local v99 = fn49(math.abs(v97 - 0.3) / 0.3) -- inferred equivalent call
			local v100 = math.sin((v97 - v95) * 3.141592653589793 * 2 * 5) * v92 * v99 * v94
			v98.y += v100
			table.insert(v96, v98)
		end

		table.insert(v96, mLureDeco:GetPosition())

		if __wf_atom_7e8ad928(v23) then
			fn()
			v23:__wf_atom_ff43aa5a(v96, true)
			v24:__wf_atom_ff43aa5a(v96, true)
		elseif __wf_atom_084b3e93() > 0 then
			v23:__wf_atom_ff43aa5a(v96, true)
			v24:__wf_atom_ff43aa5a(v96, true)
		end
	end
end

local function fn51(p, p2)
	if v36 or not __wf_atom_7e8ad928(avatar:__wf_atom_92aa9d91():__wf_atom_f036f03b()) then
		return
	end

	local __wf_atom_2490589b = v41:__wf_atom_2490589b(module8.WrapAngle(p), p2)
	local heading2 = avatar:MotionControl():__wf_atom_d9cb4b97().heading
	local v67 = __wf_atom_2490589b + heading - heading2
	avatar:__wf_atom_187571ae(0, 0, -v67)
end

local function fn52(p)
	if not (avatar:__wf_atom_7bcdbf55(v9.mFishingBiteReactAnimAction) or avatar:__wf_atom_7bcdbf55(v9.mFishingLeftTugAnimAction) or avatar:__wf_atom_7bcdbf55(v9.mFishingRightTugAnimAction) or avatar:__wf_atom_c138b19b(castAnim)) then
		if v13 == 5 then
			if v14.mActionKeyHeld then
				avatar:__wf_atom_e06358f3(v9.mFishingReelHardAnimAction, true)
			else
				avatar:__wf_atom_e06358f3(v9.mFishingReelIdleAnimAction, true)
			end
		elseif v13 == 7 then
			if flag4 then
				avatar:__wf_atom_e06358f3(v9.mFishingReelHookedAnimAction, true)
			else
				avatar:__wf_atom_e06358f3(v9.mFishingReelHardAnimAction, true)
			end
		end
	end

	local v67 = v14.mReelHorizontalInput == 0 and 0
		or 60 * v14.mReelHorizontalInput / math.abs(v14.mReelHorizontalInput)

	if v14.mActionKeyHeld and v14.mReelHorizontalInput == 0 then
		local __wf_atom_d9cb4b97 = avatar:MotionControl():__wf_atom_d9cb4b97()
		v67 = -__wf_atom_a6515464(avatar:__wf_atom_a2a18137(), __wf_atom_d9cb4b97, mLureDeco:GetPosition())
	end

	local __wf_atom_2490589b = v42:__wf_atom_2490589b(v67, p * 0.5)
	avatar:__wf_atom_78ad8b9f(139, __wf_atom_2490589b)
	fn51(module8.WrapAngle(GetTargetHeading() - heading) / 2, p)
end

function UpdatePlayer(p)
	if __wf_atom_7e8ad928(avatar) then
		return
	end

	local __wf_atom_e919fb8e = avatar:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.fishingSpinAnimRate = nil
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if v13 == 1 then
		if not flag8 then
			local v67 = 2
			v13 = v67
			avatar:__wf_atom_037ae4a8(v67)
		end
	elseif v13 == 2 then
		if not (avatar:__wf_atom_7bcdbf55(v9.mFishingEquipAnimAction) or avatar:__wf_atom_7bcdbf55(v9.mFishingIdleAnimAction)) then
			avatar:__wf_atom_e06358f3(v9.mFishingIdleAnimAction, true)
		end

		fn51(module8.WrapAngle(__wf_atom_fa8d0177(__wf_atom_28d5d4aa2, GetAimPosition()).heading - heading), p)
	elseif v13 == 3 then
		if not avatar:__wf_atom_7bcdbf55(v9.mFishingSpinAnimAction) then
			avatar:__wf_atom_e06358f3(v9.mFishingSpinAnimAction, true)
		end

		local v67 = __wf_atom_421b01aa(
			(GetTargetDistance() - v10.MIN_CAST_DISTANCE) / (v11 - v10.MIN_CAST_DISTANCE),
			0,
			1
		)
		local fishingSpinAnimRate = __wf_atom_104bfe98(v10.SPIN_MIN_ANIM_RATE, v10.SPIN_MAX_ANIM_RATE, v67)
		avatar:__wf_atom_78ad8b9f(139, fishingSpinAnimRate)
		mSpinRateUI = fishingSpinAnimRate
		local v69 = Resource("/SF/Animations/Player/Contextual/Fishing/HorizontalCastChargeUpA")
		local v70 = Resource("/SF/Animations/Player/Contextual/Fishing/HorizontalCastChargeUpB")

		if avatar:__wf_atom_c138b19b(v69) or avatar:__wf_atom_c138b19b(v70) then
			if not v59 then
				OnSpinStateEnter()
				v59 = true
			end

			OnSpinUpdate(fishingSpinAnimRate)
		end

		fn51(module8.WrapAngle(GetTargetHeading() - heading) / 2, p)
		__wf_atom_e919fb8e.fishingSpinAnimRate = fishingSpinAnimRate
	elseif v13 == 4 then
		if Time() >= v43.mLureEnterWaterTime then
			local v67 = 5
			v13 = v67
			avatar:__wf_atom_037ae4a8(v67)
			v56.mFishMaxStruggleDist = 3.4028234663852886e38
			__wf_atom_28d5d4aa5 = __wf_atom_28d5d4aa
			__wf_atom_28d5d4aa4 = __wf_atom_28d5d4aa
		end
	elseif v13 == 5 then
		fn52(p)
		OnLureReelUpdate(false)

		if
			GetTargetDistance2D() < v10.FISH_CATCH_DISTANCE
			and not (avatar:__wf_atom_7bcdbf55(v9.mFishingBiteReactAnimAction) or avatar:__wf_atom_7bcdbf55(v9.mFishingLeftTugAnimAction) or avatar:__wf_atom_7bcdbf55(v9.mFishingRightTugAnimAction))
		then
			Reset()
		end
	elseif v13 == 6 then
		if __wf_atom_7e8ad928(__wf_atom_296472bc.mFishTargetingLure) then
			local v67 = 5
			v13 = v67
			avatar:__wf_atom_037ae4a8(v67)
			__wf_atom_28d5d4aa3 = mLureDeco:GetPosition()
			__wf_atom_28d5d4aa3.y = __wf_atom_28d5d4aa2.y
			mLureDeco:__wf_atom_e6ed03c8()
			mLureDeco:SetMeshScale(v40.mLureOriginalMeshScale)
			__wf_atom_28d5d4aa5 = __wf_atom_28d5d4aa
			OnFishBiteEscape()
		end
	elseif v13 == 7 then
		fn52(p)
		OnLureReelUpdate(true)

		if GetTargetDistance2D() < v10.FISH_CATCH_DISTANCE or _T.fishingDebugInstantCatch then
			if _T.fishingDebugNoCatching then
				__wf_atom_28d5d4aa3 = __wf_atom_28d5d4aa2 + __wf_atom_9341614d(
					Vector(0, 0, 15),
					Rotation(heading, 0, 0)
				)
			else
				fn37()
			end
		end
	elseif
		v13 == 8
		and (not __wf_atom_7e8ad928(v30) and v30:__wf_atom_7d4910e4() or not __wf_atom_7e8ad928(nil) and (nil):__wf_atom_7d4910e4() or not __wf_atom_7e8ad928(v31) and v31:__wf_atom_7d4910e4())
	then
		OnFishCaughtUpdate()
	end
end

smoothFloatLureX = __wf_atom_10cd16b2(0, 0.1)
smoothFloatLureY = __wf_atom_10cd16b2(0, 0.1)
smoothFloatLureZ = __wf_atom_10cd16b2(0, 0.1)
smoothedLurePosition = nil

local function fn53(p)
	if __wf_atom_7e8ad928(avatar) then
		return
	end

	if __wf_atom_7e8ad928(_T.fishingDebugSelectedCameraMode) then
		_T.fishingDebugSelectedCameraMode = 1
	end

	local fishingDebugSelectedCameraMode = _T.fishingDebugSelectedCameraMode
	local position = mLureDeco:GetPosition()

	if not smoothedLurePosition then
		smoothedLurePosition = position
		smoothFloatLureX:__wf_atom_4453e49c(position.x)
		smoothFloatLureY:__wf_atom_4453e49c(position.y)
		smoothFloatLureZ:__wf_atom_4453e49c(position.z)
	end

	smoothedLurePosition.x = smoothFloatLureX:__wf_atom_2490589b(position.x, p)
	smoothedLurePosition.y = smoothFloatLureY:__wf_atom_2490589b(position.y, p)
	smoothedLurePosition.z = smoothFloatLureZ:__wf_atom_2490589b(position.z, p)
	local v67 = nil
	local v68 = nil

	if v13 == 7 and fishingDebugSelectedCameraMode ~= 2 then
		if __wf_atom_7e8ad928(v16) then
			fn23()
		end

		local v69 = math.min(GetTargetDistance() / v10.MAX_CAST_DISTANCE, 1)
		local smoothedLurePosition = smoothedLurePosition

		if fishingDebugSelectedCameraMode == 1 then
			local v70 = (v12.mCameraTransitionPercentage < v69 and 1 or v69 < v12.mCameraDistanceForMaxTracking and 0 or (v69 - v12.mCameraDistanceForMaxTracking) / (v12.mCameraTransitionPercentage - v12.mCameraDistanceForMaxTracking)) * (1 - v12.mCameraMinTrackingPercentage)
			local OTS_CAMERA_SPOT_FAR_OFFSET = v12.OTS_CAMERA_SPOT_FAR_OFFSET

			if _T.fishingDebugUseCustomCameraPos then
				OTS_CAMERA_SPOT_FAR_OFFSET.x = module8.Ternary(
					tonumber(_T.fishingDebugCustomCameraX),
					_T.fishingDebugCustomCameraX,
					OTS_CAMERA_SPOT_FAR_OFFSET.x
				)
				OTS_CAMERA_SPOT_FAR_OFFSET.y = module8.Ternary(
					tonumber(_T.fishingDebugCustomCameraY),
					_T.fishingDebugCustomCameraY,
					OTS_CAMERA_SPOT_FAR_OFFSET.y
				)
				OTS_CAMERA_SPOT_FAR_OFFSET.z = module8.Ternary(
					tonumber(_T.fishingDebugCustomCameraZ),
					_T.fishingDebugCustomCameraZ,
					OTS_CAMERA_SPOT_FAR_OFFSET.z
				)
			end

			local v71 = __wf_atom_f55d6358(v12.OTS_CAMERA_SPOT_CLOSE_OFFSET, OTS_CAMERA_SPOT_FAR_OFFSET, v70)
			local _ = avatar:GetPosition() - __wf_atom_28d5d4aa2
			local v72 = GetTargetHeading()
			local angle = module8.WrapAngle(v72 - heading)

			if math.abs(angle) > v12.mCameraHorizontalDeadZone and math.sign(angle) ~= math.sign(v12.mCameraXSign) then
				v12.mCameraXSign *= -1
			end

			v71.x *= v12.mCameraXSign
			local v73 = {
				v12.mSmoothCameraSpotPos[1]:__wf_atom_9e368823(),
				v12.mSmoothCameraSpotPos[2]:__wf_atom_9e368823(),
				v12.mSmoothCameraSpotPos[3]:__wf_atom_9e368823()
			}
			v71.x = v12.mSmoothCameraSpotPos[1]:__wf_atom_2490589b(v71.x, p)
			v71.y = v12.mSmoothCameraSpotPos[2]:__wf_atom_2490589b(v71.y, p)
			v71.z = v12.mSmoothCameraSpotPos[3]:__wf_atom_2490589b(v71.z, p)
			v67 = avatar:GetPosition() + __wf_atom_9341614d(v71, Rotation(heading, 0, 0))
			local v74 = __wf_atom_fa8d0177(v67, smoothedLurePosition)
			local v75 = Rotation(heading, v12.CAMERA_PITCH, 0)

			if not __wf_atom_7e8ad928(v12.CAMERA_HEADING_OVERRIDE) then
				v75.heading = heading + v12.CAMERA_HEADING_OVERRIDE
			end

			v68 = __wf_atom_9d2f097a(v74, v75, v70)
			local position2 = v16:GetPosition()

			if __wf_atom_a93b9922(position2, v67) > 0.00001 then
				Vector()
				local v76 = Vector()

				if not __wf_atom_7e8ad928((gRegion:__wf_atom_3ec9f18c(
					position2,
					v67,
					v12.mCameraSweepSphereRadius,
					nil,
					v76,
					true,
					true
				))) then
					v12.mSmoothCameraSpotPos[1]:__wf_atom_4453e49c(v73[1])
					v12.mSmoothCameraSpotPos[2]:__wf_atom_4453e49c(v73[2])
					v12.mSmoothCameraSpotPos[3]:__wf_atom_4453e49c(v73[3])
					v67 = position2
				end
			end
		elseif fishingDebugSelectedCameraMode == 3 then
			if v12.mCameraFixedTransitionPercentage < v69 then
				v67 = avatar:GetPosition() + __wf_atom_9341614d(v12.CAMERA_SPOT_OFFSET, Rotation(heading, 0, 0))
				v68 = Rotation(heading, v12.CAMERA_PITCH, 0)

				if not __wf_atom_7e8ad928(v12.CAMERA_HEADING_OVERRIDE) then
					v68.heading = heading + v12.CAMERA_HEADING_OVERRIDE
				end
			else
				local v70 = GetTargetHeading()
				local angle = module8.WrapAngle(v70 - heading)

				if
					math.abs(angle) > v12.mCameraHorizontalDeadZone
					and math.sign(angle) ~= math.sign(v12.mCameraXSign)
				then
					v12.mCameraXSign *= -1
				end

				local FIXED_CAMERA_SPOT_OFFSET = v12.FIXED_CAMERA_SPOT_OFFSET

				if _T.fishingDebugUseCustomCameraPos then
					FIXED_CAMERA_SPOT_OFFSET.x = module8.Ternary(
						tonumber(_T.fishingDebugCustomCameraX),
						_T.fishingDebugCustomCameraX,
						FIXED_CAMERA_SPOT_OFFSET.x
					)
					FIXED_CAMERA_SPOT_OFFSET.y = module8.Ternary(
						tonumber(_T.fishingDebugCustomCameraY),
						_T.fishingDebugCustomCameraY,
						FIXED_CAMERA_SPOT_OFFSET.y
					)
					FIXED_CAMERA_SPOT_OFFSET.z = module8.Ternary(
						tonumber(_T.fishingDebugCustomCameraZ),
						_T.fishingDebugCustomCameraZ,
						FIXED_CAMERA_SPOT_OFFSET.z
					)
				end

				FIXED_CAMERA_SPOT_OFFSET.x *= v12.mCameraXSign
				FIXED_CAMERA_SPOT_OFFSET.x = v12.mSmoothCameraSpotPos[1]:__wf_atom_2490589b(
					FIXED_CAMERA_SPOT_OFFSET.x,
					p
				)
				v67 = avatar:GetPosition() + __wf_atom_9341614d(FIXED_CAMERA_SPOT_OFFSET, Rotation(heading, 0, 0))
				local v71 = Rotation(heading, v12.CAMERA_PITCH, 0)

				if not __wf_atom_7e8ad928(v12.CAMERA_HEADING_OVERRIDE) then
					v71.heading = heading + v12.CAMERA_HEADING_OVERRIDE
				end

				v68 = __wf_atom_fa8d0177(v67, smoothedLurePosition)
			end
		end
	else
		v67 = avatar:GetPosition() + __wf_atom_9341614d(v12.CAMERA_SPOT_OFFSET, Rotation(heading, 0, 0))
		v68 = Rotation(heading, v12.CAMERA_PITCH, 0)

		if not __wf_atom_7e8ad928(v12.CAMERA_HEADING_OVERRIDE) then
			v68.heading = heading + v12.CAMERA_HEADING_OVERRIDE
		end
	end

	if not (__wf_atom_7e8ad928(v16) or __wf_atom_7e8ad928(v67) or __wf_atom_7e8ad928(v68)) then
		v16:Teleport(v67, v68)
	end
end

function Update()
	local v67 = __wf_atom_084b3e93()
	avatar = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(avatar) then
		CleanupAndShutdown()
	elseif avatar:IsKilled() or avatar:__wf_atom_bedb4e3f() then
		fn36()
		CleanupAndShutdown()
	else
		local __wf_atom_e919fb8e = avatar:__wf_atom_e919fb8e()

		if __wf_atom_e919fb8e.fishingDamaged then
			RequestShutdown()
		end

		if flag8 and not (v64 or flag5 and flag6) then
			CleanupAndShutdown()
			return
		end

		if v56.mPlayerStunRemainingTime > 0 then
			v14.mActionKeyHeld = false
		end

		total += v67
		__wf_atom_e919fb8e.FishingElapsedTime = total

		if v14.mActionKeyHeld then
			v14.mTimeSinceActionKeyUp = 0
		else
			v14.mTimeSinceActionKeyUp += v67
		end

		local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

		if mLureDeco ~= __wf_atom_296472bc.mLureDeco and avatar:__wf_atom_3d840c93(80) ~= 16 then
			fn4()
			avatar:__wf_atom_e06358f3(v9.mFishingEquipAnimAction, true)
		end

		if
			v14.mPrevPlayingWithController
			and not (Engine.IsPlayingWithController() or __wf_atom_7e8ad928(mouseKeyboardInputFilter))
		then
			mMovie:__wf_atom_0c1c47f2(mouseKeyboardInputFilter)
			v14.mPrevPlayingWithController = false
		elseif
			not v14.mPrevPlayingWithController
			and Engine.IsPlayingWithController()
			and not __wf_atom_7e8ad928(gamepadInputFilter)
		then
			mMovie:__wf_atom_0c1c47f2(gamepadInputFilter)
			v14.mPrevPlayingWithController = true
		end

		if __wf_atom_7e8ad928(mLureDeco) then
			return
		end

		fn38(v67)
		fn42(v67)
		fn43(v67)
		fn44(v67)
		fn45(v67)
		fn47(v67)
		fn50(v67)
		UpdatePlayer(v67)
		fn53(v67)
		UpdateUI(v67, flag)

		if flag then
			flag = false
		end

		if _T.fishingDebugSpawnFishOnHook then
			if v13 == 5 then
				local __wf_atom_296472bc2 = avatar:__wf_atom_296472bc()
				local entity = gRegion:CreateEntity(
					debugFishType,
					__wf_atom_28d5d4aa3 - Vector(0, 1, 0),
					__wf_atom_80368bb1,
					avatar
				)

				if not (__wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(__wf_atom_296472bc2)) then
					entity:__wf_atom_913ef5ca()
					local __wf_atom_c082fc3d = entity:__wf_atom_c082fc3d()
					local mSize = entity.mSize

					if not __wf_atom_7e8ad928(mSize) then
						__wf_atom_c082fc3d *= mSize
					end

					entity:SetMeshScale(__wf_atom_c082fc3d)
					_T.fishingDebugUseCustomStats = true
					__wf_atom_296472bc2.mFishTargetingLure = entity
					entity:AttachEntity(mLureDeco, Symbol("GAME_C1_JAW1"), entity.mLureAttachOffset, Rotation(0, 0, 30))
					mLureDeco:SetMeshScale(1 / __wf_atom_c082fc3d)
					v44.mBiteLineLength = Distance(
						mLureDeco:GetPosition(),
						avatar:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
					)

					if not __wf_atom_7e8ad928(v18) then
						v18:__wf_atom_a763aa1a(1)
					end

					flag2 = true
					fn27(entity)
				end
			end

			_T.fishingDebugSpawnFishOnHook = false
		end

		if _T.fishingDebugNoFishResistance or _T.fishingDebugTempNoFishResistance then
			v56.mTimeUntilNextStruggle = 9999
			flag4 = false
			v56.mRemainingFishStamina = 0
		end

		local __wf_atom_296472bc2 = avatar:__wf_atom_296472bc()

		if _T.fishingDebugShowFishJumpInfo and not __wf_atom_7e8ad928(__wf_atom_296472bc2.mFishOnHook) and flag5 then
			local position = __wf_atom_296472bc2.mFishOnHook:GetPosition()

			if v58.mCanStunFish then
				gRegion:__wf_atom_5b35a0c8(position + Vector(0, 0.6, 0), Color(0, 255, 0), "CAN STUN", 1.5, 0.05)
			else
				gRegion:__wf_atom_5b35a0c8(position + Vector(0, 0.6, 0), Color(255, 0, 0), "CAN'T STUN", 1.5, 0.05)
			end
		end

		if _T.fishingDebugDrawBoundaries then
			gRegion:__wf_atom_b5c21154(
				__wf_atom_28d5d4aa2,
				v10.FISH_CATCH_DISTANCE,
				Color(255, 0, 0),
				Rotation(0, 90, 0),
				0.05
			)
			gRegion:__wf_atom_b5c21154(
				__wf_atom_28d5d4aa2,
				v10.MIN_CAST_DISTANCE,
				Color(0, 255, 0),
				Rotation(0, 90, 0),
				0.05
			)
			gRegion:__wf_atom_b5c21154(
				__wf_atom_28d5d4aa2,
				v10.MAX_CAST_DISTANCE,
				Color(0, 255, 0),
				Rotation(0, 90, 0),
				0.05
			)
			gRegion:__wf_atom_b5c21154(
				__wf_atom_28d5d4aa2,
				v10.FISH_ESCAPE_DISTANCE,
				Color(255, 0, 0),
				Rotation(0, 90, 0),
				0.05
			)
			gRegion:__wf_atom_628723a6(
				__wf_atom_28d5d4aa2,
				__wf_atom_28d5d4aa2 + __wf_atom_9341614d(
					Vector(0, 0, v10.MAX_CAST_DISTANCE),
					Rotation(heading + v10.MAX_CAST_HEADING, 0, 0)
				),
				Color(0, 255, 0),
				0.05
			)
			gRegion:__wf_atom_628723a6(
				__wf_atom_28d5d4aa2,
				__wf_atom_28d5d4aa2 + __wf_atom_9341614d(
					Vector(0, 0, v10.MAX_CAST_DISTANCE),
					Rotation(heading - v10.MAX_CAST_HEADING, 0, 0)
				),
				Color(0, 255, 0),
				0.05
			)
			gRegion:__wf_atom_628723a6(
				__wf_atom_28d5d4aa2,
				__wf_atom_28d5d4aa2 + __wf_atom_9341614d(
					Vector(0, 0, v10.MAX_CAST_DISTANCE),
					Rotation(heading + v10.MAX_FISH_HEADING, 0, 0)
				),
				Color(255, 0, 0),
				0.05
			)
			gRegion:__wf_atom_628723a6(
				__wf_atom_28d5d4aa2,
				__wf_atom_28d5d4aa2 + __wf_atom_9341614d(
					Vector(0, 0, v10.MAX_CAST_DISTANCE),
					Rotation(heading - v10.MAX_FISH_HEADING, 0, 0)
				),
				Color(255, 0, 0),
				0.05
			)
		end
	end
end

function WaitAndStopConvergence()
	Sleep(1)
	v36 = false

	if not __wf_atom_7e8ad928(avatar) then
		avatar:MotionControl():__wf_atom_3959d938(false)
	end
end

local function fn54(heading2)
	local v67 = Vector(0, 0, 1)
	local __wf_atom_d9cb4b97 = avatar:MotionControl():__wf_atom_d9cb4b97()
	__wf_atom_d9cb4b97.heading = heading2
	__wf_atom_d9cb4b97.pitch += 10
	avatar:__wf_atom_51075230(__wf_atom_d9cb4b97)
	v36 = true
	local v68 = avatar:GetPosition() + __wf_atom_9341614d(v67, __wf_atom_d9cb4b97)
	avatar:MotionControl():__wf_atom_fb8cb580(true, v68, 1)
	avatar:__wf_atom_8a035cd5(Symbol("WaitAndStopConvergence"), false)
end

local function fn55()
	mStats = {}

	if not (__wf_atom_7e8ad928(__wf_atom_a0f6588f) and __wf_atom_7e8ad928(__wf_atom_21342f4a)) then
		mStats = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_af5caba7()
	end
end

function Initialize()
	avatar = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(avatar) then
		mMovie:Close()
		return
	end

	mMovie:__wf_atom_8fcdea81(avatar)
	v8 = avatar:__wf_atom_12695c30()

	if avatar:__wf_atom_296472bc().mIsFishing then
		mMovie:Close()
		return
	end

	_T.fishingLureInWater = false
	_T.fishingLureImpactTime = 3.4028234663852886e38
	_T.fishingIsPerfectCast = false
	mMovie:__wf_atom_dac78d3d(true)
	heading = avatar:__wf_atom_4e50d390().heading
	__wf_atom_28d5d4aa2 = module4.GetWaterPosition(
		gRegion:__wf_atom_3bc831e3(),
		avatar:GetPosition(),
		v10.MINIGAME_ALLOWED_HEIGHT_RANGE
	)

	if __wf_atom_7e8ad928(__wf_atom_28d5d4aa2) then
		mMovie:Close()
		return
	end

	local v67 = avatar:GetPosition() + __wf_atom_9341614d(v12.CAMERA_SPOT_OFFSET, Rotation(heading, 0, 0))
	local v68 = __wf_atom_f55d6358(avatar:GetPosition(), v67, 0.1)
	local v69 = Vector()

	if not __wf_atom_7e8ad928((gRegion:__wf_atom_3ec9f18c(v68, v67, v12.mCameraSweepSphereRadius, nil, v69, true, true))) then
		mMovie:Close()
		return
	end

	local v70 = not __wf_atom_7e8ad928(avatar) and avatar:IsA(WeakResource("/SF/Types/Player/EnvoyChildAvatar"))
	local ternary = module8.Ternary(v70, fishCaughtChildEndCinType, fishCaughtAdultEndCinType)
	local entity = gRegion:CreateEntity(ternary, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if __wf_atom_7e8ad928(entity) then
		mMovie:Close()
		return
	end

	v62, v63 = entity:__wf_atom_99c400ff(Symbol("FishA"), 1)
	gRegion:__wf_atom_dd1e4d10(entity)
	local v71 = Rotation(heading, v12.CAMERA_PITCH, 0)

	if not __wf_atom_7e8ad928(v12.CAMERA_HEADING_OVERRIDE) then
		v71.heading = heading + v12.CAMERA_HEADING_OVERRIDE
	end

	v16 = gRegion:CreateEntity(cameraSpotType, v67, v71)
	avatar:CameraControl():__wf_atom_fd14c463(1)
	avatar:CameraControl():SetCameraSpot(v16, 0.4)
	local mLureItem = avatar:__wf_atom_296472bc().mLureItem

	if __wf_atom_7e8ad928(mLureItem) then
		mLureItem = defaultLureItem
		local __wf_atom_a96eb2aa = avatar:__wf_atom_a96eb2aa()

		if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			local __wf_atom_a4299765 = __wf_atom_a96eb2aa:__wf_atom_a4299765()

			if not __wf_atom_7e8ad928(__wf_atom_a4299765.mEquippedLureType) then
				mLureItem = Type(__wf_atom_a4299765.mEquippedLureType)
			end
		end
	end

	local fishingData = SF.FishingData()
	fishingData.mIsFishing = true
	fishingData.mFishingState = 1
	fishingData.mLureItem = mLureItem
	avatar:__wf_atom_aabc9a96(fishingData)
	local __wf_atom_e919fb8e = avatar:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.fishingDamaged = false
	avatar:__wf_atom_7470861b():__wf_atom_9fba31e6(Symbol("Invulnerable"), 26, 6, 0)
	avatar:__wf_atom_51cd6126(Symbol("FishingInterruptDamage"), "OnDamaged")
	local v72 = 1
	v13 = v72
	avatar:__wf_atom_037ae4a8(v72)
	total = 0
	__wf_atom_e919fb8e.FishingElapsedTime = total
	local __wf_atom_0dcd7684 = castAnim:__wf_atom_0dcd7684()
	local __wf_atom_43e3d184 = castAnim:__wf_atom_43e3d184()
	local v73 = 1

	for i, v75 in ipairs(__wf_atom_0dcd7684) do
		if v75 ~= Symbol(v9.mFishingCastLobAnimEvent) then
			continue
		end

		v73 = __wf_atom_43e3d184[i]
		break
	end

	v43.mInitialLobPosition = avatar:GetPosition() + __wf_atom_9341614d(
		castAnim:__wf_atom_df9e931d(Symbol("GAME_R1_WEAPON1"), v73),
		avatar:__wf_atom_2f2bada0()
	)
	local __wf_atom_35a10d3c = avatar:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		local __wf_atom_66088189 = __wf_atom_35a10d3c:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:__wf_atom_017e8c6b(true)
		end
	end

	v17 = avatar:Attach(spoolDecoType, Symbol("GAME_L1_WEAPON1"), __wf_atom_28d5d4aa, __wf_atom_80368bb1, avatar, 1)

	if __wf_atom_7e8ad928(v17) then
		CleanupAndShutdown()
		return
	end

	module5.RegisterPreventNighfoldUsage(true)
	fn54(heading)
	v20 = gRegion:CreateEntity(aimingIndicatorDecoType, __wf_atom_28d5d4aa2, __wf_atom_80368bb1)
	v20:SetVisibility(false, false)
	fishReticle = gRegion:CreateEntity(aimingIndicatorDecoType, __wf_atom_28d5d4aa2, __wf_atom_80368bb1)
	fishReticle:SetVisibility(false, false)

	if not __wf_atom_7e8ad928(fishReticleMovie) then
		mFishReticleMovie = __wf_atom_8e4fda44:__wf_atom_8b74c30b(fishReticleMovie)

		if not __wf_atom_7e8ad928(mFishReticleMovie) then
			mFishReticleMovie:__wf_atom_8fcdea81(avatar)
			local __wf_atom_e919fb8e_2 = avatar:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e_2.fishReticle = fishReticle
			mFishReticleMovie:__wf_atom_8a679cf7(fishReticle, Vector(0, 0, 0), Rotation(0, 90, 0), Vector(2, 2, 2))
		end
	end

	v21 = gRegion:CreateEntity(targetIndicatorDecoType, __wf_atom_28d5d4aa2, __wf_atom_80368bb1)
	v21:SetMeshScale(0.08)
	v21:SetVisibility(false, false)
	v22 = gRegion:CreateEntity(mouseIndicatorDecoType, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WaterSimTrigger"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		v65 = __wf_atom_0a6a5887:__wf_atom_80cf57aa()
		__wf_atom_0a6a5887:__wf_atom_f947c7cc(Vector(50, 10, 50))
	end

	_T.WarsongFishingStarted = true
	fn55()
	InitializeUI()
	OnStart()
end

function StartCast(_, _) end

function InitializeCameraSpot(_, _) end

local function fn56(p, p2, _)
	local mCalloutClip = mCalloutClips[p]

	if mCalloutClip ~= nil then
		if p2 == nil then
			mMovie:__wf_atom_2dedec1a(mCalloutClip, 13, false)
		else
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(p2.KEY, true)

			if p2.LOC ~= nil and p2.LOC ~= "" then
				__wf_atom_8e9ac384 ..= " " .. p2.LOC
			end

			mMovie:__wf_atom_50d60589(mCalloutClip .. ".Value", 36, __wf_atom_8e9ac384)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mCalloutClip .. ".Value", 40)
			mMovie:__wf_atom_e57658c2(mCalloutClip .. ".Value", 11, _G.UIColor_Gold)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(mCalloutClip .. ".Value", 0)
			mMovie:__wf_atom_e57658c2(mCalloutClip .. ".Backer", 0, -5 + __wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8 / 2)
			mMovie:__wf_atom_e57658c2(mCalloutClip .. ".Value", 14, __wf_atom_5e6e15c8)
			mMovie:__wf_atom_e57658c2(mCalloutClip .. ".Backer", 14, __wf_atom_5e6e15c8 + 100)
			mMovie:OverrideMaterial(mCalloutClip .. ".Backer", fishCalloutBackerMaterial)
			mMovie:__wf_atom_2dedec1a(mCalloutClip, 13, true)
		end
	end

	for i = 2, #mCalloutClips do
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mCalloutClips[i - 1], 0)
		local v67 = mMovie:__wf_atom_5e6e15c8(mCalloutClips[i - 1] .. ".Value", 14) + 80
		mMovie:__wf_atom_e57658c2(mCalloutClips[i], 0, __wf_atom_5e6e15c8 + v67)
	end

	local v67 = mCalloutClip .. ".RewardItem"
	mMovie:__wf_atom_2dedec1a(v67, 13, false)
end

local function fn57(_)
	mMovie:__wf_atom_2dedec1a("Reticle", 13, false)
	mMovie:__wf_atom_2dedec1a("RingIndicator", 13, false)
	mMovie:__wf_atom_2dedec1a("RingCallout", 13, false)
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if __wf_atom_7e8ad928(__wf_atom_296472bc) then
		return
	end

	local mFishTargetingLure = __wf_atom_296472bc.mFishTargetingLure
	_T.FishingReticleData = {}
	_T.FishingReticleData.TargetFish = mFishTargetingLure
	_T.FishingReticleData.LureDeco = mLureDeco
	_T.FishingReticleData.Avatar = avatar

	if __wf_atom_7e8ad928(mFishTargetingLure) or mFishTargetingLure:__wf_atom_43e681f1() ~= 4 then
		if v60.mPrevShouldShowBiteIndicator then
			__wf_atom_ec43d06e(mMovie, "RingIndicator", 8, { 12 }, { 0 }, 0.3, 0)
			__wf_atom_ec43d06e(mMovie, "RingCallout", 8, { 12 }, { 0 }, 0.3, 0)
			mFishReticleMovie:Execute("SetState", "CAST")
		end

		v60.mPrevShouldShowBiteIndicator = false
	else
		mFishReticleMovie:Execute("SetState", "NIBBLE")
		local position = mLureDeco:GetPosition()
		position.y = fishReticle:GetPosition().y
		fishReticle:Teleport(position, Rotation())
		v60.mPrevShouldShowBiteIndicator = true
		local v67 = mFishTargetingLure.mBiteWindowDuration / mFishTargetingLure.mBitePulseCount
		local v68 = (Time() - v44.mBiteWindowStartTime) % v67
		v60.mSweetSpotBiteValue = __wf_atom_421b01aa(v68 / v67, 0, 1)

		if mMovie:__wf_atom_5e6e15c8("RingIndicator", 12) == 0 then
			__wf_atom_ec43d06e(mMovie, "RingIndicator", 8, { 12 }, { 100 }, 0.3, 0)
			__wf_atom_ec43d06e(mMovie, "RingCallout", 8, { 12 }, { 100 }, 0.3, 0)
		end

		mMovie:__wf_atom_e57658c2("RingIndicator", 14, 175)
		mMovie:__wf_atom_e57658c2("RingIndicator", 15, 175)
		local position2 = mFishTargetingLure:GetPosition()
		local __wf_atom_74b9a49b = mMovie:__wf_atom_74b9a49b(position2)
		local v69 = GetSweetSpotLerpQuadratic(v60.mSweetSpotBiteValue) * v10.MAX_SWEET_SPOT_DEVIATION

		if v60.mSweetSpotBiteValue < v60.mSweetSpotSoundValue and not __wf_atom_7e8ad928(lineBitePulseSound) then
			module8.PlaySound(lineBitePulseSound)
		end

		v60.mSweetSpotSoundValue = v60.mSweetSpotBiteValue
		mMovie:__wf_atom_e57658c2("RingIndicator", 0, __wf_atom_74b9a49b.x)
		mMovie:__wf_atom_e57658c2("RingIndicator", 1, __wf_atom_74b9a49b.y)
		mMovie:__wf_atom_5e6e15c8("RingCallout", 14)
		mMovie:__wf_atom_e57658c2("RingCallout", 0, __wf_atom_74b9a49b.x - 111)
		mMovie:__wf_atom_e57658c2("RingCallout", 1, __wf_atom_74b9a49b.y + 100)
		mMovie:__wf_atom_50d60589("RingCallout", 36, mMovie:__wf_atom_8e9ac384(mCallouts[v15.BITE].KEY, true))
		mMovie:__wf_atom_e57658c2("RingIndicator.InnerRing", 14, 175 * v69 + 225)
		mMovie:__wf_atom_e57658c2("RingIndicator.InnerRing", 15, 175 * v69 + 225)
		mMovie:__wf_atom_e57658c2("RingIndicator.InnerRingSmall", 14, 225)
		mMovie:__wf_atom_e57658c2("RingIndicator.InnerRingSmall", 15, 225)
	end
end

function UpdateUI(p, p2)
	mMovie:__wf_atom_88d9cd84(p)

	if v13 == 5 or v13 == 6 then
		fn57(p)
	end

	if v13 == mPrevState and v13 ~= 3 and not p2 then
		return
	end

	mPrevState = v13

	for _, v67 in mCalloutClips do
		mMovie:__wf_atom_2dedec1a(v67, 13, false)
	end

	mMovie:__wf_atom_2dedec1a("RingIndicator", 13, false)
	mMovie:__wf_atom_2dedec1a("RingCallout", 13, false)

	if v13 == 1 then
		return
	end

	if v13 == 2 then
		fn56(2, mCallouts[v15.SPIN])
		fn56(1, mCallouts[v15.SELECT_LURE])
		mFishReticleMovie:Execute("SetState", "AIM")
	elseif v13 == 3 then
		fn56(1, mCallouts[v15.CAST])
		local v67 = __wf_atom_104bfe98(0, 80, mSpinRateUI - 0.5)
		mMovie:__wf_atom_e57658c2("Reel.StrengthIndicator", 5, v67)
		mMovie:__wf_atom_e57658c2("Reel.StrengthIndicator", 6, v67)
		mFishReticleMovie:Execute("SetState", "THROW")
	elseif v13 == 4 then
		__wf_atom_ec43d06e(mMovie, "RingIndicator", 8, { 12 }, { 0 }, 0.3, 0)
		__wf_atom_ec43d06e(mMovie, "RingCallout", 8, { 12 }, { 0 }, 0.3, 0)
		mFishReticleMovie:Execute("SetState", "CAST")
	elseif v13 == 5 then
		fn56(1, mCallouts[v15.REEL])
		fn56(2, mCallouts[v15.PULL])
	else
		if not (v13 ~= 6 and v13 == 7) then
			return
		end

		fn56(1, mCallouts[v15.REEL])
		fn56(2, mCallouts[v15.PULL])
		mFishReticleMovie:Execute("SetState", "HOOKED")
	end
end

local function fn58()
	mAnchorMgr = module9.Create(mMovie, true)
	mAnchorMgr:Register(mMovie, "Callout1", { mAnchorMgr.ANCHOR_V_BOTTOM, mAnchorMgr.ANCHOR_H_LEFT })
	mAnchorMgr:Register(mMovie, "Callout2", { mAnchorMgr.ANCHOR_V_BOTTOM, mAnchorMgr.ANCHOR_H_LEFT })
	mAnchorMgr:Register(mMovie, "Reel", { mAnchorMgr.ANCHOR_V_BOTTOM, mAnchorMgr.ANCHOR_H_CENTRE })
	mAnchorMgr:Register(mMovie, "Popup.StarAnim", { mAnchorMgr.ANCHOR_V_TOP, mAnchorMgr.ANCHOR_H_CENTRE })
	mAnchorMgr:Register(mMovie, "Popup.StarAnim.FishName", { mAnchorMgr.ANCHOR_V_TOP, mAnchorMgr.ANCHOR_H_CENTRE })
	mAnchorMgr:Register(mMovie, "Popup.FishStat", { mAnchorMgr.ANCHOR_V_BOTTOM, mAnchorMgr.ANCHOR_H_CENTRE })
	mAnchorMgr:Register(mMovie, "Popup.FishType", { mAnchorMgr.ANCHOR_V_BOTTOM, mAnchorMgr.ANCHOR_H_CENTRE })
	mAnchorMgr:Register(mMovie, "Popup.Progress", { mAnchorMgr.ANCHOR_V_BOTTOM, mAnchorMgr.ANCHOR_H_CENTRE })
	mAnchorMgr:Register(mMovie, "Popup.Fadedbacker", { mAnchorMgr.ANCHOR_V_BOTTOM, mAnchorMgr.ANCHOR_H_CENTRE })
	mAnchorMgr:Register(mMovie, "Popup.CatchBtn", { mAnchorMgr.ANCHOR_V_BOTTOM, mAnchorMgr.ANCHOR_H_CENTRE })
	mAnchorMgr:Register(mMovie, "Popup.ReleaseBtn", { mAnchorMgr.ANCHOR_V_BOTTOM, mAnchorMgr.ANCHOR_H_CENTRE })
	mAnchorMgr:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true)
end

local function fn59()
	inputMapping = {}
	keyMapping = {}
	mCallouts = {}
	keyMapping[v15.SPIN] = {
		KEY = "MENU_CLICK",
		GAMEPAD_KEY = "MENU_RTRIGGER1",
		OnKeyUp = OnSpinUp,
		OnKeyDown = OnSpinDown
	}
	keyMapping[v15.CAST] = {
		KEY = "MENU_CLICK",
		GAMEPAD_KEY = "MENU_RTRIGGER1",
		OnKeyUp = OnCastUp,
		OnKeyDown = OnCastDown
	}
	keyMapping[v15.REEL] = {
		KEY = "MENU_CLICK",
		GAMEPAD_KEY = "MENU_RTRIGGER1",
		OnKeyUp = ReelKeyUp,
		OnKeyDown = ReelKeyDown
	}
	keyMapping[v15.AIM] = {
		KEY = "MENU_CLICK",
		GAMEPAD_KEY = "MENU_RTRIGGER1",
		OnKeyUp = nil,
		OnKeyDown = nil
	}
	keyMapping[v15.STUN_PULL] = {
		KEY = "MENU_CLICK",
		GAMEPAD_KEY = "MENU_RTRIGGER1",
		OnKeyUp = nil,
		OnKeyDown = OnStunPull
	}
	keyMapping[v15.PULL] = {
		KEY = "MENU_CLICK",
		GAMEPAD_KEY = "MENU_RTRIGGER1",
		OnKeyUp = nil,
		OnKeyDown = OnTugDown
	}
	keyMapping[v15.BITE] = {
		KEY = "MENU_CLICK",
		GAMEPAD_KEY = "MENU_RTRIGGER1",
		OnKeyUp = nil,
		OnKeyDown = OnSetHookDown
	}
	keyMapping[v15.RELEASE] = {
		KEY = "MENU_CLICK",
		GAMEPAD_KEY = "MENU_GENERIC2",
		OnKeyUp = nil,
		OnKeyDown = OnReleaseFishPressed
	}
	keyMapping[v15.SELECT_LURE] = {
		KEY = "CONSUMABLES_HOLD",
		GAMEPAD_KEY = "CONSUMABLES_HOLD",
		OnKeyUp = nil,
		OnKeyDown = nil
	}
	keyMapping[v15.CATCH] = {
		KEY = "MENU_RIGHT_CLICK",
		GAMEPAD_KEY = "MENU_GENERIC1",
		OnKeyUp = nil,
		OnKeyDown = CatchFish
	}
	keyMapping[v15.LEFT] = {
		KEY = "MENU_LEFT",
		GAMEPAD_KEY = "MENU_X",
		OnKeyUp = nil,
		OnKeyDown = nil
	}
	keyMapping[v15.RIGHT] = {
		KEY = "MENU_RIGHT",
		GAMEPAD_KEY = "MENU_X",
		OnKeyUp = nil,
		OnKeyDown = nil
	}
	local v67 = {
		[v15.SPIN] = "FishingSpinAction",
		[v15.CAST] = "FishingCastAction",
		[v15.REEL] = "FishingReelAction",
		[v15.AIM] = "FishingAim",
		[v15.STUN_PULL] = nil,
		[v15.PULL] = "FishingPullAction",
		[v15.BITE] = nil,
		[v15.RELEASE] = "ReleaseFishing",
		[v15.SELECT_LURE] = "SelectLure",
		[v15.CATCH] = "CatchFish",
		[v15.LEFT] = "FishingReelAction",
		[v15.RIGHT] = "FishingReelAction"
	}

	for i = 1, v15.MAX - 1 do
		local ternary = module8.Ternary(Engine.IsPlayingWithController(), keyMapping[i].GAMEPAD_KEY, keyMapping[i].KEY)

		if ternary == nil then
			continue
		end

		if inputMapping[ternary] == nil then
			inputMapping[ternary] = { OnKeyUp = {}, OnKeyDown = {} }
		end

		local v68 = inputMapping[ternary]
		v68.OnKeyUp[#v68.OnKeyUp + 1] = keyMapping[i].OnKeyUp
		v68.OnKeyDown[#v68.OnKeyDown + 1] = keyMapping[i].OnKeyDown
		mCallouts[i] = {}
		mCallouts[i].KEY = "<" .. ternary .. ">"

		if i == v15.PULL then
			if Engine.IsPlayingWithController() then
				mCallouts[i].KEY = "<" .. keyMapping[v15.LEFT].GAMEPAD_KEY .. ">"
			else
				mCallouts[i].KEY = "<" .. keyMapping[v15.LEFT].KEY .. "> / <" .. keyMapping[v15.RIGHT].KEY .. ">"
			end
		end

		if v67[i] ~= "" and v67[i] ~= nil then
			mCallouts[i].LOC = Localize("/SF/Language/Fish/" .. v67[i], nil)
		end
	end
end

function OnGamepadTransition()
	fn59()
	local v67 = Localize("/SF/Language/Fish/CatchFish", nil)
	local catch = v15.CATCH
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(mCallouts[catch].KEY, true)
	mMovie:__wf_atom_50d60589("Popup.CatchBtn.Text", 36, __wf_atom_8e9ac384 .. " " .. Localize(v67, true))
	local v68 = Localize("/SF/Language/Fish/ReleaseFishing", nil)
	local release = v15.RELEASE
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(mCallouts[release].KEY, true)
	mMovie:__wf_atom_50d60589("Popup.ReleaseBtn.Text", 36, __wf_atom_8e9ac384_2 .. " " .. Localize(v68, true))
	flag = true
end

function ShowResultPopup()
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()
	local mFishOnHook = __wf_atom_296472bc.mFishOnHook
	local mSize = mFishOnHook.mSize
	local minValue = mFishOnHook.mSizeRange.minValue
	local v67 = mFishOnHook.mSizeRange.maxValue - minValue
	local v68 = math.floor((not (v67 > 0) and 1 or math.lerp(1, 5, (mSize - minValue) / v67)) * 4 + 0.5) / 4
	local mWeight = mFishOnHook.mWeight
	local __wf_atom_36659409 = avatar:__wf_atom_d2b2176d():__wf_atom_36659409()
	local __wf_atom_47887c9c = mFishOnHook:__wf_atom_47887c9c(__wf_atom_296472bc.mPerfectStreak)
	local mCorruptionLevel = mFishOnHook.mCorruptionLevel
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(mFishOnHook:__wf_atom_4f3855f9():c_str(), true)
	mMovie:__wf_atom_2dedec1a("Popup", 13, true)
	mMovie:__wf_atom_50d60589("Popup.StarAnim.FishName", 36, __wf_atom_8e9ac384)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Popup.StarAnim.Splash", 1)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Popup.StarAnim.FishName", 40)
	mMovie:__wf_atom_e57658c2("Popup.StarAnim.FishName", 1, __wf_atom_5e6e15c8 - 38)
	mMovie:__wf_atom_e57658c2("Popup.StarAnim.Splash", 14, __wf_atom_5e6e15c8_2 + 400)
	mMovie:__wf_atom_e57658c2("Popup.StarAnim.FishName", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("Popup.StarAnim.FishName", 12, 0)
	__wf_atom_ec43d06e(mMovie, "Popup.StarAnim.FishName", 8, { 12 }, { 100 }, 0.3, 0)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("Popup.StarAnim.FishName", 40)
	mMovie:__wf_atom_e57658c2("Popup.Deco.NameBacker", 14, __wf_atom_5e6e15c8_3 + 270)
	mMovie:__wf_atom_e57658c2("Popup", 12, 0)
	__wf_atom_ec43d06e(mMovie, "Popup", 8, { 12 }, { 100 }, 0.3, 0)
	local nextThreshold = module4.GetNextThreshold(avatar)
	local v69 = __wf_atom_36659409 / nextThreshold
	local fishingLevel = module4.GetFishingLevel(avatar)
	local v70 = (__wf_atom_36659409 + __wf_atom_47887c9c) / nextThreshold
	local v71 = v70 > 1 and 1 or v70
	local v72 = mMovie:__wf_atom_cfc41e35("Popup.Progress.Bar", "Fill", 14) * v71
	Localize("/SF/Language/Fish/FishSize", { NUMBER = string.format("%.2f", mSize) })
	Localize("/SF/Language/Fish/FishWeight", { NUMBER = string.format("%.2f", mWeight) })
	local v73 = Localize("/SF/Language/Fish/FishingRank", { NUMBER = "" })
	UpdateFishStat("Popup.Progress", nil, v73)
	mMovie:__wf_atom_4c1c1986("Popup.Progress.LevelIndicator", "LevelText", 36, fishingLevel)
	mMovie:__wf_atom_4c1c1986("Popup.Progress.LevelIndicator", "LevelText", 11, _G.UIColor_Tan)
	mMovie:__wf_atom_4c1c1986("Popup.Progress.LevelIndicator", "LevelText", 36, fishingLevel)
	mMovie:__wf_atom_e57658c2("Popup.Progress.LevelIndicatorRankFill.Mask", 6, v69 * 100)
	mMovie:__wf_atom_4c1c1986("Popup.Progress.Bar", "Mask", 14, (math.max(1, v69 * v72)))
	mMovie:__wf_atom_4c1c1986("Popup.Progress.Bar", "Fill", 11, _G.UIColor_Yellow)
	mMovie:OverrideMaterial("Popup.Progress.Bar.Fill", progressBarFillMaterial)
	mMovie:__wf_atom_50d60589("Popup.Progress.Exp", 36, "+" .. __wf_atom_47887c9c)
	__wf_atom_ec43d06e(mMovie, "Popup.Progress.Bar.Mask", 8, { 14 }, { (math.max(1, v72)) }, 2, 0)
	mMovie:__wf_atom_50d60589("Popup.Progress.Exp", 36, "+" .. __wf_atom_47887c9c)
	local v74 = math.ceil(v68)

	for i = 1, MaxStarCount do
		local v75 = "Popup.StarAnim.Backer.Star" .. i
		local v76 = 70
		local v77 = (v74 - 1) * v76 / 2

		if v74 == 1 then
			v77 = 0
			v76 = 0
		end

		if v68 > 0 then
			mMovie:__wf_atom_2dedec1a(v75, 13, true)
			local v78 = -v77 + v76 * (i - 1)
			mMovie:__wf_atom_e57658c2(v75, 0, v78)
			mMovie:__wf_atom_c90af43a(v75 .. ".Shadow", fishFullStarShadowTexture)
			mMovie:__wf_atom_e57658c2(v75, 5, 1)
			mMovie:__wf_atom_e57658c2(v75, 6, 1)
			mMovie:__wf_atom_e57658c2(v75, 12, 0)
			local v79 = v75 .. ".Icon"
			local fishFullGoldStarTexture = fishFullGoldStarTexture

			if mCorruptionLevel == 1 then
				fishFullGoldStarTexture = fishFullBronzeStarTexture
			elseif mCorruptionLevel == 2 then
				fishFullGoldStarTexture = fishFullSilverStarTexture
			end

			if v68 < 1 then
				mMovie:__wf_atom_933bbce0(v79, fishFullGoldStarTexture, fishStarMaterial)
				mMovie:__wf_atom_1ca72041(v79, "AlphaTestThreshold", v68, 0, 0, 0)
				local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8(v79, 5)
				mMovie:__wf_atom_e57658c2(v79, 5, -__wf_atom_5e6e15c8_4)
			else
				mMovie:__wf_atom_933bbce0(v79, fishFullGoldStarTexture, nil)
			end

			__wf_atom_ec43d06e(mMovie, v75, 4, { 5, 6, 12 }, { 120, 120, 100 }, 1.5, 0.5 + i * 0.15)
		else
			mMovie:__wf_atom_2dedec1a(v75, 13, false)
		end

		v68 -= 1
	end

	print("Fish caught: " .. mFishOnHook:__wf_atom_5b41f63b() .. ", XP awarded: " .. __wf_atom_47887c9c .. ", base XP rate: " .. 400 .. ", size: " .. mFishOnHook.mSize .. ", corruption level: " .. mFishOnHook.mCorruptionLevel .. ", perfect streak: " .. __wf_atom_296472bc.mPerfectStreak)
end

function CloseResultPopup()
	mMovie:__wf_atom_2dedec1a("Popup", 13, false)
	mMovie:__wf_atom_2dedec1a("Callout1", 13, false)
	mMovie:__wf_atom_2dedec1a("Callout2", 13, false)
end

function UpdateFishStat(p, p2, p3)
	mMovie:__wf_atom_c90af43a(p, p2)
	mMovie:__wf_atom_c90af43a(p .. ".Icon", p2)
	mMovie:OverrideMaterial(p .. ".Backer", fishStatBackerMaterial)
	mMovie:__wf_atom_e57658c2(p .. ".Backer", 11, 0)
	mMovie:__wf_atom_e57658c2(p .. ".Backer", 12, 60)
	mMovie:__wf_atom_50d60589(p .. ".Text", 36, p3)
	mMovie:__wf_atom_e57658c2(p .. ".Text", 11, _G.UIColor_Gold)
	mMovie:__wf_atom_e57658c2(p .. ".Text", 12, 100)
end

function InitializePopup()
	mMovie:__wf_atom_2dedec1a("Popup", 13, false)
	mMovie:__wf_atom_2dedec1a("Popup.Backer", 13, true)
	mMovie:__wf_atom_2dedec1a("Popup.FishType", 13, true)
	mMovie:__wf_atom_2dedec1a("Popup.FishSize", 13, true)
	mMovie:OverrideMaterial("Popup.StarAnim.Deco.Glow", fishGlowMaterial)
	mMovie:__wf_atom_e57658c2("Popup.StarAnim.Deco.Glow", 12, 50)
	mMovie:OverrideMaterial("Popup.Deco.NameBacker", fishNameBackerMaterial)
	mMovie:__wf_atom_50d60589("Popup.Progress.Exp", 36, "+2000")
	mMovie:__wf_atom_e57658c2("Popup.Progress.Exp", 11, _G.UIColor_Gold)
	mMovie:__wf_atom_e57658c2("Popup.Fadedbacker", 12, 30)
	mMovie:__wf_atom_e57658c2("Popup.Fadedbacker", 11, 0)
	mMovie:__wf_atom_c90af43a("Popup.StarAnim.Backer.Star1.Icon", fishFullBronzeStarTexture)

	for i = 2, MaxStarCount do
		local v67 = "Star" .. i
		local v68 = "Popup.StarAnim.Backer." .. v67

		if not mMovie:__wf_atom_253d7085(v68) then
			__wf_atom_86cbd68d(mMovie, "Popup.StarAnim.Backer.Star1.duplicateMovieClip", v67, i)
		end
	end
end

local function fn60()
	mFishingUIStats = {}
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Popup.FishStat1", 14)
	local v67 = mMovie:__wf_atom_5e6e15c8("Popup.FishStat1", 15) + 10
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Popup.FishStat1", 0)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("Popup.FishStat1", 1)
	mMovie:__wf_atom_e57658c2("Popup.FishStat1", 12, 0)

	for i = 1, #mFishingUIStats do
		local v68 = __wf_atom_5e6e15c8_2 + (i - 1) % 2 * __wf_atom_5e6e15c8
		local v69 = __wf_atom_5e6e15c8_3 - math.floor((i - 1) / 2) * v67
		local v70 = "FishStat" .. i
		local clipname = "Popup." .. v70

		if not mMovie:__wf_atom_253d7085(clipname) then
			__wf_atom_86cbd68d(mMovie, "Popup.FishStat1.duplicateMovieClip", v70, i)
		end

		local mFishingUIStat = mFishingUIStats[i]
		mFishingUIStats[i].CLIPNAME = clipname
		UpdateFishStat(clipname, mFishingUIStat.ICON, mFishingUIStat.STAT_TYPE)
		mMovie:__wf_atom_e57658c2(clipname, 0, v68)
		mMovie:__wf_atom_e57658c2(clipname, 1, v69)
	end
end

local function fn61(p, p2, p3) -- 1 equivalent call inferred from this helper
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(mCallouts[p3].KEY, true)
	mMovie:__wf_atom_50d60589(p .. ".Text", 36, __wf_atom_8e9ac384 .. " " .. Localize(p2, true))
end

local function fn62(p, p2, p3, p4)
	mMovie:__wf_atom_c90af43a(p .. ".Icon", p2)
	mMovie:__wf_atom_e57658c2(p .. ".Glow", 12, 50)
	mMovie:__wf_atom_e57658c2(p .. ".TextBacker", 11, _G.UIColor_Yellow)
	fn61(p, p3, p4) -- inferred equivalent call
	mMovie:__wf_atom_e57658c2(p .. ".Text", 11, _G.UIColor_Tan)
	mMovie:__wf_atom_e57658c2(p .. ".TextBacker", 11, 854536)
	mMovie:__wf_atom_e57658c2(p .. ".TextBacker", 12, 100)
end

local function fn63()
	require("SF.Interface.Components.Button")
	local _ = Localize("/SF/Language/Fish/ReleaseFishing", false) .. Localize(mCallouts[v15.RELEASE].KEY, true)
	local _ = Localize("/SF/Language/Fish/CatchFish", false) .. Localize(mCallouts[v15.CATCH].KEY, true)
	fn62("Popup.CatchBtn", fishCatchRewardIcon, Localize("/SF/Language/Fish/CatchFish", nil), v15.CATCH)
	fn62("Popup.ReleaseBtn", fishReleaseRewardIcon, Localize("/SF/Language/Fish/ReleaseFishing", nil), v15.RELEASE)
end

function InitializeUI()
	_T.FishingMode = true
	local v67 = mMovie:__wf_atom_5e6e15c8("Callout1", 1) - 100
	local v68 = mMovie:__wf_atom_5e6e15c8("Callout1", 0) + 20
	_T.HUDSetLogContainerPosition(v68, v67)
	module6.RegisterHideHudSelective(true)
	module7.SetChatVisible(false)
	mMovie:__wf_atom_2dedec1a("Reel", 13, true)
	mMovie:__wf_atom_2dedec1a("Reel.StrengthIndicator", 13, true)
	mMovie:__wf_atom_e57658c2("Reel.StrengthIndicator", 5, 0)
	mMovie:__wf_atom_e57658c2("Reel.StrengthIndicator", 6, 0)
	mMovie:__wf_atom_2dedec1a("RingIndicator", 13, false)
	mMovie:__wf_atom_2dedec1a("RingCallout", 13, false)
	mMovie:__wf_atom_2dedec1a("Popup", 13, false)
	table.insert(mCalloutClips, "Callout1")
	table.insert(mCalloutClips, "Callout2")
	fn59()
	module2.Update(mMovie, "Lure", {}, nil)
	InitializePopup()
	fn60()
	fn63()
	fn58()
end

function OnStart()
	if not __wf_atom_7e8ad928(carryOverStingerStartSound) then
		module8.PlaySound(carryOverStingerStartSound)
		module.StartLocalCustomMusicSequencer(musicGameplay, 2, 2, 1, musicGameplayMixEffect)
	end
end

function OnSpinStateEnter()
	module.SetLocalCustomMusicSequencerState(1)
end

function OnSpinUpdate(p)
	local v67 = Symbol("sRtpcAnimSpinRate")
	avatar:__wf_atom_cecb2d55(v67, p)

	if not __wf_atom_7e8ad928(avatar) and not __wf_atom_7e8ad928(chargeLoopSound) and __wf_atom_7e8ad928(v4) then
		v4 = avatar:PlaySound(chargeLoopSound, false)
	end

	if not __wf_atom_7e8ad928(avatar) and not __wf_atom_7e8ad928(chargeWhooshLoopSound) and __wf_atom_7e8ad928(v5) then
		v5 = avatar:PlaySound(chargeWhooshLoopSound, false)
	end

	if
		not __wf_atom_7e8ad928(avatar)
		and not __wf_atom_7e8ad928(chargeWhooshLoopSoundFaster)
		and __wf_atom_7e8ad928(v6)
	then
		v6 = avatar:PlaySound(chargeWhooshLoopSoundFaster, false)
	end
end

function OnCast(_) end

function OnLureLob(p)
	if not __wf_atom_7e8ad928(mLureDeco) then
		if p and not __wf_atom_7e8ad928(lurePerfectCastFX) then
			mLureDeco:Attach(lurePerfectCastFX, Symbol(""), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		elseif not (p or __wf_atom_7e8ad928(lureImperfectCastFX)) then
			mLureDeco:Attach(lureImperfectCastFX, Symbol(""), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:Stop(false)
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:Stop(false)
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Stop(false)
	end
end

function OnLureEnteredWater(p)
	if p and not (__wf_atom_7e8ad928(mLureDeco) or __wf_atom_7e8ad928(lurePerfectCastWaterImpactFX)) then
		gRegion:CreateEntity(lurePerfectCastWaterImpactFX, mLureDeco:GetPosition(), v43.mLureImpactRotation)
	end

	if not __wf_atom_7e8ad928(lureWaterImpactSound) then
		mLureDeco:PlaySound(lureWaterImpactSound, false, 1, true, nil)
	end

	if p and not (__wf_atom_7e8ad928(mLureDeco) or __wf_atom_7e8ad928(lureWaterImpactSoundPerfect)) then
		mLureDeco:PlaySound(lureWaterImpactSoundPerfect, false, 1, true, nil)
	end

	mLureDeco:Attach(baitLandSplashType, Symbol(""), __wf_atom_28d5d4aa, Rotation(0, 90, 0))
	_T.WarsongFishingLureEnteredWater = true
end

function OnLureReelUpdate(_)
	if not __wf_atom_7e8ad928(mLureDeco) then
		if
			(v14.mActionKeyHeld or v14.mReelHorizontalInput ~= 0)
			and not __wf_atom_7e8ad928(lureWaterLoopSound)
			and __wf_atom_7e8ad928(v3)
		then
			v3 = mLureDeco:PlaySound(lureWaterLoopSound, false)
		end

		if not v14.mActionKeyHeld and v14.mReelHorizontalInput == 0 and not __wf_atom_7e8ad928(v3) then
			v3:Stop(false)
		end
	end

	if not __wf_atom_7e8ad928(avatar) then
		if v14.mActionKeyHeld and not __wf_atom_7e8ad928(reelingLoopSound) and __wf_atom_7e8ad928(v2) then
			v2 = avatar:PlaySound(reelingLoopSound, false)
		end

		if not (v14.mActionKeyHeld or __wf_atom_7e8ad928(v2)) then
			v2:Stop(false)
		end
	end
end

function OnTugStart() end

function OnTugLureHopStart()
	if not __wf_atom_7e8ad928(lureMovementSound) then
		mLureDeco:PlaySound(lureMovementSound, false, 1, true, nil, 1)
	end
end

function OnFishBite()
	if not __wf_atom_7e8ad928(lureBiteSound) then
		mLureDeco:PlaySound(lureBiteSound, false, 1, true, nil)
	end
end

function OnFishBiteEscape()
	__wf_atom_7e8ad928(lureBiteFailSound)

	if not __wf_atom_7e8ad928(v7) then
		v7:Stop(false)
	end
end

function OnFishHooked()
	if not (__wf_atom_7e8ad928(avatar) or __wf_atom_7e8ad928(hookedStartSound)) then
		avatar:PlaySound(hookedStartSound, false, 1, true, nil)
	end

	if not __wf_atom_7e8ad928(avatar) and not __wf_atom_7e8ad928(lineTensionSound) and __wf_atom_7e8ad928(v7) then
		v7 = avatar:PlaySound(lineTensionSound, false)
	end
end

function OnHitWaterFromJump()
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if not (__wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) or __wf_atom_7e8ad928(fishEnterWaterSplashFXType)) then
		gRegion:CreateEntity(
			fishEnterWaterSplashFXType,
			__wf_atom_296472bc.mFishOnHook:GetPosition(),
			__wf_atom_80368bb1
		)
	end

	if not (__wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) or __wf_atom_7e8ad928(fishBubblesFXType)) then
		local __wf_atom_bb3e7833 = __wf_atom_296472bc.mFishOnHook:__wf_atom_bb3e7833(fishBubblesFXType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			Effects.__wf_atom_91e2dccb(__wf_atom_bb3e7833, 1)
		end
	end

	if not __wf_atom_7e8ad928(v28) then
		v28:Destroy()
	end
end

function OnLeaveWaterFromJump()
	local __wf_atom_296472bc = avatar:__wf_atom_296472bc()

	if not (__wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) or __wf_atom_7e8ad928(fishJumpSplashFXType)) then
		gRegion:CreateEntity(fishJumpSplashFXType, __wf_atom_296472bc.mFishOnHook:GetPosition(), __wf_atom_80368bb1)
	end

	if not (__wf_atom_7e8ad928(__wf_atom_296472bc.mFishOnHook) or __wf_atom_7e8ad928(fishBubblesFXType)) then
		local __wf_atom_bb3e7833 = __wf_atom_296472bc.mFishOnHook:__wf_atom_bb3e7833(fishBubblesFXType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			Effects.__wf_atom_91e2dccb(__wf_atom_bb3e7833, 0)
		end
	end
end

function OnReset()
	if not __wf_atom_7e8ad928(v3) then
		v3:Stop(false)
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Stop(false)
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Stop(false)
	end
end

function OnFishStunStart()
	module8.PlaySound(fishStunSound)
end

function OnFishStunEnd() end

function OnFishStunFail()
	module8.PlaySound(fishStunFailSound)
end

function OnFishCaughtStart()
	if not __wf_atom_7e8ad928(v7) then
		v7:Stop(false)
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Stop(false)
	end
end

function OnFishCaughtLoopStart()
	module.SetLocalCustomMusicSequencerState(3)

	if not (__wf_atom_7e8ad928(avatar) or __wf_atom_7e8ad928(FishCaughtMusicLoop)) then
		v = avatar:PlaySound(FishCaughtMusicLoop, false)
	end
end

function OnFishCaughtLoopEnd(_)
	module.SetLocalCustomMusicSequencerState(3)

	if not __wf_atom_7e8ad928(v) then
		v:Stop(false)
	end
end

function OnFishCaughtEnd()
	module.SetLocalCustomMusicSequencerState(1)
end

function OnFishCaughtUpdate()
	if not __wf_atom_7e8ad928(v30) and v30:__wf_atom_7d4910e4() then
		return
	end

	if (__wf_atom_7e8ad928(nil) or not (nil):__wf_atom_7d4910e4()) and not __wf_atom_7e8ad928(v31) then
		v31:__wf_atom_7d4910e4()
	end
end

function OnLineStaminaUpdate(p)
	if not __wf_atom_7e8ad928(avatar) then
		local v67 = Symbol("sRtpcLineStamina")
		avatar:__wf_atom_cecb2d55(v67, p)
	end
end

function OnFishEscaped()
	module.SetLocalCustomMusicSequencerState(1)

	if not (__wf_atom_7e8ad928(avatar) or __wf_atom_7e8ad928(failLineSnapSound)) then
		avatar:PlaySound(failLineSnapSound, false, 1, true, nil)
	end
end

function OnShutdown() end

function KeepCinHealthyFishFXEvent()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local caughtHealthyFishDeco = __wf_atom_c4f78a8f:__wf_atom_e919fb8e().CaughtHealthyFishDeco

	if __wf_atom_7e8ad928(caughtHealthyFishDeco) then
		return
	end

	caughtHealthyFishDeco:Attach(nightfoldAttachFxType, EMPTY_SYMBOL)
end

function onRawInputEvent(_, p, p2)
	local v67

	if p == "EN_MOUSE_B0" then
		v67 = "MENU_CLICK"
	elseif p == "EN_MOUSE_B1" then
		v67 = "MENU_RIGHT_CLICK"
	elseif p == "EN_GAMEPAD_L1" then
		v67 = "MENU_LTRIGGER1"
	elseif p == "EN_GAMEPAD_R1" then
		v67 = "MENU_RTRIGGER1"
	elseif p == "EN_GAMEPAD_L2" then
		v67 = "MENU_LTRIGGER2"
	elseif p == "EN_GAMEPAD_R2" then
		v67 = "MENU_RTRIGGER2"
	elseif p == "EN_GAMEPAD_BUTTON_TOP" then
		v67 = "MENU_GENERIC2"
	elseif p == "EN_GAMEPAD_BUTTON_LEFT" then
		v67 = "MENU_GENERIC1"
	elseif p == "EN_GAMEPAD_BUTTON_BOTTOM" then
		v67 = "MENU_SELECT"
	elseif p == "EN_GAMEPAD_BUTTON_RIGHT" then
		v67 = "MENU_CANCEL"
	else
		v67 = ""
	end

	local v68 = p2 == "1"

	if inputMapping[v67] == nil then
		return 1
	end

	local v69 = inputMapping[v67]

	if v68 then
		for i = 1, #v69.OnKeyDown do
			if v69.OnKeyDown[i] ~= nil then
				v69.OnKeyDown[i]()
			end
		end
	else
		for i = 1, #v69.OnKeyUp do
			if v69.OnKeyUp[i] ~= nil then
				v69.OnKeyUp[i]()
			end
		end
	end

	return 1
end

function IsReelState()
	return v13 == 5 or v13 == 6 or v13 == 7
end

function OnSpinDown()
	if
		v13 == 2
		and not flag8
		and not __wf_atom_7e8ad928(avatar)
		and avatar:__wf_atom_7bcdbf55(v9.mFishingIdleAnimAction)
	then
		local v67 = 3
		v13 = v67
		avatar:__wf_atom_037ae4a8(v67)
		__wf_atom_28d5d4aa3 = GetAimPosition()
		avatar:__wf_atom_e06358f3(v9.mFishingSpinStartAnimAction, true)
		__wf_atom_7e8ad928(mLureDeco)
	end
end

function OnSpinUp() end

function ReelKeyDown()
	v14.mActionKeyHeld = true
end

function ReelKeyUp()
	v14.mActionKeyHeld = false

	if v13 == 5 or v13 == 7 then
		if not __wf_atom_7e8ad928(v3) then
			v3:Stop(false)
		end

		if not __wf_atom_7e8ad928(v2) then
			v2:Stop(false)
		end
	end
end

function OnCastDown() end

function OnCastUp()
	if v13 == 3 and not flag8 and GetTargetDistance() >= v10.MIN_CAST_DISTANCE then
		fn26()
	end
end

function OnTugDown()
	if v13 == 5 then
		if v14.mUpKeyHeld or v14.mDownKeyHeld or v14.mLeftKeyHeld or v14.mRightKeyHeld then
			fn28()
		elseif v14.mTimeSinceActionKeyUp < v14.DOUBLE_TAP_DELAY then
			fn28()
		elseif Engine.IsPlayingWithController() and Length(v14.mCursorDelta) > 0 then
			fn28()
		end
	end
end

function OnSetHookDown()
	if v13 == 6 then
		fn30()
	end
end

function OnStunPull()
	if v13 == 7 then
		fn16()
	end
end

function ReleaseFish()
	local __wf_atom_a91463a8 = mMovie:__wf_atom_a91463a8("Popup", 13)

	if v13 == 8 and __wf_atom_a91463a8 then
		_T.ReleaseFish = true
		EndCaughtScreen()
	end
end

function OnReleaseFishPressed()
	ReleaseFish()
end

function CatchFish()
	local __wf_atom_a91463a8 = mMovie:__wf_atom_a91463a8("Popup", 13)

	if v13 == 8 and __wf_atom_a91463a8 then
		_T.ReleaseFish = false
		EndCaughtScreen()
	end
end

function onKeyDown_MENU_MOUSE_X(_, p)
	v14.mMouseDelta.x = tonumber(p)
end

function onKeyDown_MENU_MOUSE_Y(_, p)
	v14.mMouseDelta.y = tonumber(p)
end

function onKeyDown_MENU_X(_, p)
	v14.mJoystickDelta.x = tonumber(p)
end

function onKeyUp_MENU_X()
	v14.mJoystickDelta.x = 0
end

function onKeyDown_MENU_Y(_, p)
	v14.mJoystickDelta.y = -tonumber(p)
end

function onKeyUp_MENU_Y()
	v14.mJoystickDelta.y = 0
end

function onKeyDown_MENU_LEFT()
	v14.mLeftKeyHeld = true
end

function onKeyUp_MENU_LEFT()
	v14.mLeftKeyHeld = false
end

function onKeyDown_MENU_RIGHT()
	v14.mRightKeyHeld = true
end

function onKeyUp_MENU_RIGHT()
	v14.mRightKeyHeld = false
end

function onKeyDown_MENU_UP()
	v14.mUpKeyHeld = true
end

function onKeyUp_MENU_UP()
	v14.mUpKeyHeld = false
end

function onKeyDown_MENU_DOWN()
	v14.mDownKeyHeld = true
end

function onKeyUp_MENU_DOWN()
	v14.mDownKeyHeld = false
end

function onKeyDown_CONSUMABLES_HOLD()
	return v13 ~= 2 or not not flag8
end

function onKeyDown_MENU_CANCEL()
	local __wf_atom_a91463a8 = mMovie:__wf_atom_a91463a8("Popup", 13)

	if v13 ~= 8 or not __wf_atom_a91463a8 then
		flag9 = false
		RequestShutdown()
	end
end

function onKeyDown_HIDE_PAUSE_MENU()
	onKeyDown_MENU_CANCEL()
	return false
end

function onKeyDown_NEXT_INV()
	flag9 = true
	RequestShutdown()
end

function onKeyUp_TOOLMENU_INPUT(...)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_eab484a7:__wf_atom_ce4e872c() then
		if not __wf_atom_eab484a7:__wf_atom_648b1408() then
			avatar:CameraControl():__wf_atom_fd14c463(0.1)
			avatar:CameraControl():SetCameraSpot(nil, 0.1)
		end

		mMovie:__wf_atom_0c1c47f2(Resource("/EE/Types/Input/FreeCamInputFilter"))
	else
		if not __wf_atom_eab484a7:__wf_atom_648b1408() then
			avatar:CameraControl():__wf_atom_fd14c463(0.1)
			avatar:CameraControl():SetCameraSpot(v16, 0.1)
		end

		mMovie:__wf_atom_0c1c47f2(Resource("/SF/Interface/Minigames/FishingInputFilter"))
	end
end

function onKeyDown_MENU_LTRIGGER2() end

function OnDamaged(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if not __wf_atom_7e8ad928(__wf_atom_9d766292) then
		local __wf_atom_679ed446 = __wf_atom_9d766292:__wf_atom_679ed446()

		if not __wf_atom_7e8ad928(__wf_atom_679ed446) and __wf_atom_679ed446:IsA(__wf_atom_14e9bed7) then
			return
		end
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.fishingDamaged = true
end