module(..., package.seeall)
local v = {
	25000,
	46000,
	73500,
	107500,
	149000,
	197000,
	252500,
	314500,
	384500
}
local v2 = {
	25.07106781,
	28,
	30.24744871,
	32.14213562,
	33.8113883,
	35.32050808,
	36.70828693,
	38,
	39.21320344,
	40.36067977
}
local v3 = {
	WeakResource("/SF/Types/Gameplay/Fishing/Hotspots/LakeFishingHotspot"),
	WeakResource("/SF/Types/Gameplay/Fishing/Hotspots/OceanFishingHotspot"),
	WeakResource("/SF/Types/Gameplay/Fishing/Hotspots/ShorelineFishingHotspot"),
	WeakResource("/SF/Types/Gameplay/Fishing/Hotspots/SwampFishingHotspot")
}
local v4 = { SWAMP = 256, LAKE = 324, SHORELINE = 484, OCEAN = 784 }
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("EE.Interface.Utilities")

function HasElement(list, p)
	for _, v5 in ipairs(list) do
		if v5 == p then
			return true
		end
	end

	return false
end

function HasAnyElement(p, list)
	for _, v5 in ipairs(list) do
		if HasElement(p, v5) then
			return true
		end
	end

	return false
end

function GetMatchCount(list, list2)
	local count = 0

	for _, v5 in ipairs(list2) do
		for _, v6 in ipairs(list) do
			if v6 == v5 then
				count += 1
			end
		end
	end

	return count
end

function LineCircleIntersect2D(p, p2, p3, p4)
	local v5 = p - p3
	local v6 = p2 - p
	local v7 = v6.x * v6.x + v6.z * v6.z
	local v8 = 2 * (v5.x * v6.x + v5.z * v6.z)
	local v9 = v5.x * v5.x + v5.z * v5.z - p4 * p4
	local v10 = v8 * v8 - 4 * v7 * v9

	if v7 <= 0.00001 or v10 < 0 then
		return nil
	end

	local v11 = math.sqrt(v10)
	local v12 = (-v8 - v11) / (2 * v7)
	local v13 = (-v8 + v11) / (2 * v7)
	local v14 = nil

	if v12 >= 0 and v12 <= 1 then
		v14 = v12
	elseif v13 >= 0 and v13 <= 1 then
		v14 = v13
	end

	if v14 == nil then
		return nil
	end

	return p + (p2 - p) * v14
end

function GetFishingLevel(object)
	if __wf_atom_7e8ad928(object) then
		return 1
	end

	local __wf_atom_36659409 = object:__wf_atom_d2b2176d():__wf_atom_36659409()

	for i, v5 in ipairs(v) do
		if __wf_atom_36659409 < v5 then
			return i
		end
	end

	return #v
end

function GetStatForPlayerLevel(p, list)
	local fishingDebugCustomPlayerLevel = GetFishingLevel(p)

	if _T.fishingDebugUseCustomPlayerLevel and not __wf_atom_7e8ad928(_T.fishingDebugCustomPlayerLevel) then
		fishingDebugCustomPlayerLevel = _T.fishingDebugCustomPlayerLevel
	end

	if fishingDebugCustomPlayerLevel < 1 then
		return list[1]
	end

	if #list < fishingDebugCustomPlayerLevel then
		return list[#list]
	end

	return list[fishingDebugCustomPlayerLevel]
end

function GetNextThreshold(p)
	return v[math.min(GetFishingLevel(p), #v)]
end

function GetPerfectCastThreshold(p)
	return GetStatForPlayerLevel(p, v2)
end

function GetBiomeSymbolFromId(p)
	if p == 1 then
		return Symbol("Swamp")
	elseif p == 2 then
		return Symbol("Lake")
	elseif p == 7 then
		return Symbol("Shoreline")
	elseif p == 11 then
		return Symbol("Ocean")
	end

	return Symbol("")
end

function ConvertToWaterVolumeLocalPosition(object, p)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local v5 = __wf_atom_0a00e162(object:__wf_atom_dc309f8a())
	return __wf_atom_9341614d(p - object:GetPosition(), v5)
end

function ConvertToWorldSpace(object, p)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	return object:GetPosition() + __wf_atom_9341614d(p, object:__wf_atom_dc309f8a())
end

function IsPointInWaterVolume2D(object, p)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) then
		return nil
	end

	local v5 = ConvertToWaterVolumeLocalPosition(object, p)
	local v6 = object:__wf_atom_80cf57aa() * 0.5
	return -v6.x <= v5.x and v5.x <= v6.x and -v6.z <= v5.z and v5.z <= v6.z
end

function WaterVolumeDistanceToPosition(object, p)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) then
		return nil
	end

	local v5 = ConvertToWaterVolumeLocalPosition(object, p)
	local v6 = object:__wf_atom_80cf57aa() * 0.5
	local v7 = Vector(
		v5.x - __wf_atom_421b01aa(v5.x, -v6.x, v6.x),
		v5.y - __wf_atom_421b01aa(v5.y, -v6.y, v6.y),
		v5.z - __wf_atom_421b01aa(v5.z, -v6.z, v6.z)
	)
	return (math.sqrt(v7.x * v7.x + v7.y * v7.y + v7.z * v7.z))
end

function HotspotDistanceToPosition(object, p)
	if __wf_atom_7e8ad928(object) then
		return 3.4028234663852886e38
	end

	return Distance(p, object:GetPosition()) - object:__wf_atom_4e28532a()
end

function FindNearestWaterVolume(list, p, p2)
	local v5 = 3.4028234663852886e38
	local v6 = 3.4028234663852886e38
	local v7 = nil

	for _, v8 in ipairs(list) do
		if __wf_atom_7e8ad928(v8) or v8:__wf_atom_505c4d76() then
			continue
		end

		if not __wf_atom_7e8ad928(p2) then
			local v9 = v8:__wf_atom_ee03557f().y - p.y

			if v9 < p2.minValue or p2.maxValue < v9 then
				continue
			end
		end

		local v9 = WaterVolumeDistanceToPosition(v8, p)
		local v10 = Distance(v8:GetPosition(), p)

		if v9 < v5 then
			v7 = v8
			v6 = v10
			v5 = v9
		elseif v9 == v5 and v10 < v6 then
			v7 = v8
			v6 = v10
		end
	end

	return v7
end

function FindNearestWaterVolumeInfo(_, p, p2)
	local v5 = 3.4028234663852886e38
	local v6 = 3.4028234663852886e38
	local v7 = nil

	for _, fishingWaterVolumeInfo in ipairs(_T.FishingWaterVolumeInfos) do
		if
			__wf_atom_7e8ad928(fishingWaterVolumeInfo)
			or __wf_atom_7e8ad928(fishingWaterVolumeInfo.mWaterVolume)
			or fishingWaterVolumeInfo.mWaterVolume:__wf_atom_505c4d76()
		then
			continue
		end

		local mWaterVolume = fishingWaterVolumeInfo.mWaterVolume

		if not __wf_atom_7e8ad928(p2) then
			local v8 = mWaterVolume:__wf_atom_ee03557f().y - p.y

			if v8 < p2.minValue or p2.maxValue < v8 then
				continue
			end
		end

		local v8 = WaterVolumeDistanceToPosition(mWaterVolume, p)
		local v9 = Distance(mWaterVolume:GetPosition(), p)

		if v8 < v5 then
			v7 = fishingWaterVolumeInfo
			v6 = v9
			v5 = v8
		elseif v8 == v5 and v9 < v6 then
			v7 = fishingWaterVolumeInfo
			v6 = v9
		end
	end

	return v7
end

function FindNearestHotspotInfo(p, p2)
	local v5 = 3.4028234663852886e38
	local v6 = 3.4028234663852886e38
	local v7 = nil

	for _, fishingHotspot in ipairs(_T.fishingHotspots) do
		if __wf_atom_7e8ad928(fishingHotspot) or __wf_atom_7e8ad928(fishingHotspot.mHotspot) then
			continue
		end

		local mHotspot = fishingHotspot.mHotspot

		if not (__wf_atom_7e8ad928(p2) or not (p.y + p2.minValue > mHotspot:GetPosition().y or mHotspot:GetPosition().y > p.y + p2.maxValue)) then
			continue
		end

		local v8 = HotspotDistanceToPosition(mHotspot, p)
		local v9 = Distance(mHotspot:GetPosition(), p)

		if v8 < v5 then
			v7 = fishingHotspot
			v6 = v9
			v5 = v8
		elseif v8 == v5 and v9 < v6 then
			v7 = fishingHotspot
			v6 = v9
		end
	end

	return v7
end

function GetWaterPosition(p, p2, p3)
	local v5 = FindNearestWaterVolume(p, p2, p3)

	if __wf_atom_7e8ad928(v5) then
		return nil
	end

	local y = v5:__wf_atom_ee03557f().y
	local __wf_atom_d155f756 = v5:__wf_atom_d155f756()

	if not __wf_atom_7e8ad928(__wf_atom_d155f756) then
		y = math.min(y, __wf_atom_d155f756:GetPosition().y)
	end

	return Vector(p2.x, y, p2.z)
end

function FindOverlappingWaterVolumes(object, p)
	local v5 = object:__wf_atom_4e28532a() * object:__wf_atom_4e28532a()
	local result = {}

	for _, v6 in ipairs(gRegion:__wf_atom_3bc831e3()) do
		if __wf_atom_7e8ad928(v6) or v6:__wf_atom_505c4d76() then
			continue
		end

		if not (__wf_atom_7e8ad928(p) or not (object:GetPosition().y + p.minValue > v6:__wf_atom_ee03557f().y or v6:__wf_atom_ee03557f().y > object:GetPosition().y + p.maxValue)) then
			continue
		end

		local v7 = ConvertToWaterVolumeLocalPosition(v6, object:GetPosition())
		local v8 = v6:__wf_atom_80cf57aa() * 0.5
		local v9 = __wf_atom_421b01aa(v7.x, -v8.x, v8.x)
		local v10 = __wf_atom_421b01aa(v7.z, -v8.z, v8.z)
		local v11 = v7.x - v9
		local v12 = v7.z - v10

		if v11 * v11 + v12 * v12 <= v5 then
			table.insert(result, v6)
		end
	end

	return result
end

function AddFishingHotspot(mHotspot)
	if __wf_atom_7e8ad928(_T.fishingHotspots) then
		_T.fishingHotspots = {}
	end

	local mOverlappingWaterVolumes = FindOverlappingWaterVolumes(mHotspot)

	if #mOverlappingWaterVolumes == 0 then
		return false
	end

	local v5 = GetWaterPosition(mOverlappingWaterVolumes, mHotspot:GetPosition())

	if __wf_atom_7e8ad928(v5) then
		return false
	end

	mHotspot:SetPosition(v5)

	for i = #mOverlappingWaterVolumes, 1, -1 do
		if not (math.abs(mOverlappingWaterVolumes[i]:__wf_atom_ee03557f().y - v5.y) > 0.5) then
			continue
		end

		table.remove(mOverlappingWaterVolumes, i)
	end

	table.insert(_T.fishingHotspots, {
		mHotspot = mHotspot,
		mFishInfos = {},
		mDistanceToPlayer = 3.4028234663852886e38,
		mWaterHeight = v5.y,
		mOverlappingWaterVolumes = mOverlappingWaterVolumes,
		mRemainingFishCount = mHotspot:__wf_atom_8923739d(),
		mPurifiedFishCount = 0,
		mTotalSpawnAttempts = 0,
		mSuccessfulSpawnAttempts = 0,
		mConsecutiveFailedSpawnAttempts = 0
	})
	print("New fishing hotspot added, count: " .. #_T.fishingHotspots)

	if not _T.fishingDebugDrawHotspotSpawning then
		return true
	end

	local v6 = FindNearestWaterVolume(gRegion:__wf_atom_3bc831e3(), mHotspot:GetPosition(), Range(-20, 0.1))
	gRegion:__wf_atom_c189a462(
		v6:GetPosition() + Vector(0, 100, 0),
		v6:GetPosition() + Vector(0, -100, 0),
		Color(0, 0, 255),
		120
	)
	gRegion:__wf_atom_628723a6(v6:GetPosition() + Vector(0, 100, 0), mHotspot:GetPosition(), Color(0, 255, 0), 120)
	gRegion:__wf_atom_49f801a3(v6:__wf_atom_0aa77159(), v6:__wf_atom_ee03557f(), Color(0, 0, 255), 120)
	local position = v6:GetPosition()
	position.y = v6:__wf_atom_ee03557f().y
	gRegion:__wf_atom_8d991675(position, 0.5, Color(0, 0, 255), 120)
	return true
end

function GetHotspotTypes()
	return v3
end

function AddFishingWaterVolumeInfo(mWaterVolume)
	if __wf_atom_7e8ad928(mWaterVolume) then
		return
	end

	if __wf_atom_7e8ad928(_T.FishingWaterVolumeInfos) then
		_T.FishingWaterVolumeInfos = {}
	end

	local mSurfaceArea = mWaterVolume:__wf_atom_80cf57aa().x * mWaterVolume:__wf_atom_80cf57aa().z
	local biomeId = module.GetBiomeIdFromDensityVolume(mWaterVolume:GetPosition())
	local mFishDensity = 0

	if biomeId == 1 then
		mFishDensity = 1 / v4.SWAMP
	elseif biomeId == 2 then
		mFishDensity = 1 / v4.LAKE
	elseif biomeId == 7 then
		mFishDensity = 1 / v4.SHORELINE
	elseif biomeId == 11 then
		mFishDensity = 1 / v4.OCEAN
	end

	local rounded = module2.Round(mSurfaceArea * mFishDensity)
	table.insert(_T.FishingWaterVolumeInfos, {
		mWaterVolume = mWaterVolume,
		mFishInfos = {},
		mMaxFishCount = rounded,
		mRemainingFishCount = rounded,
		mPurifiedFishCount = 0,
		mFishDensity = mFishDensity,
		mLastSpawnAttemptTime = 0,
		mSpawnDisableUntilTime = 0,
		mConsecutiveFailedSpawnAttempts = 0,
		mWaterHeight = mWaterVolume:__wf_atom_ee03557f().y,
		mSurfaceArea = mSurfaceArea,
		mDistanceToPlayer = 3.4028234663852886e38,
		mSurfaceAreaInSpawnRange = 0,
		mLocalSpawnBoundsMin = nil,
		mLocalSpawnBoundsMax = nil
	})
	return true
end

function GetFishInfoForDeco(p)
	if __wf_atom_7e8ad928(p) then
		return nil, 0
	end

	for i = 1, #_T.allFishInfos do
		if
			not __wf_atom_7e8ad928(_T.allFishInfos[i])
			and not __wf_atom_7e8ad928(_T.allFishInfos[i].mFishDeco)
			and p == _T.allFishInfos[i].mFishDeco
		then
			return _T.allFishInfos[i], i
		end
	end

	return nil, 0
end

function RemoveFishFromTables(p)
	local v5, v6 = GetFishInfoForDeco(p)

	if __wf_atom_7e8ad928(v5) or v6 == 0 then
		return
	end

	table.remove(_T.allFishInfos, v6)

	for i, _ in ipairs(v5.mOwnerInfo.mFishInfos) do
		if v5 ~= v5.mOwnerInfo.mFishInfos[i] then
			continue
		end

		table.remove(v5.mOwnerInfo.mFishInfos, i)
		break
	end

	if v5.mIsPurified then
		for i, _ in ipairs(_T.purifiedFishInfos) do
			if v5 ~= _T.purifiedFishInfos[i] then
				continue
			end

			table.remove(_T.purifiedFishInfos, i)
			return
		end
	end
end

function SpawnCinFish(p, p2, p3, p4, p5)
	local entity = gRegion:CreateEntity(p, p2, p3, p4)

	if __wf_atom_7e8ad928(entity) then
		return nil
	end

	local __wf_atom_c082fc3d = entity:__wf_atom_c082fc3d()

	if not __wf_atom_7e8ad928(p5) then
		__wf_atom_c082fc3d *= p5
	end

	entity:SetMeshScale(__wf_atom_c082fc3d)
	entity:__wf_atom_8a035cd5(Symbol("DissolveIn"), false)
	return entity
end

function SpawnFish(p, mSpawnPosition, p2, mOwnerInfo, instance, data)
	local entity = gRegion:CreateEntity(p, mSpawnPosition, p2, instance)

	if __wf_atom_7e8ad928(entity) then
		return nil
	end

	entity:__wf_atom_032e99b2(1)
	entity:__wf_atom_913ef5ca()
	local __wf_atom_c082fc3d = entity:__wf_atom_c082fc3d()
	local mSize = entity.mSize

	if not __wf_atom_7e8ad928(mSize) then
		__wf_atom_c082fc3d *= mSize
	end

	entity:SetMeshScale(__wf_atom_c082fc3d)
	entity:__wf_atom_8a035cd5(Symbol("DissolveIn"), false)

	if __wf_atom_7e8ad928(data) then
		data = entity
	end

	local v5 = {
		mFishDeco = entity,
		mDepthLayer = data.mDepthLayer,
		mLifetime = 0,
		mMaxLifetime = 120 + math.random() * 60,
		mCorruptionLevel = entity.mCorruptionLevel,
		mOwnerInfo = mOwnerInfo,
		mHotspot = module2.Ternary(instance:IsA(__wf_atom_dab54c5c), instance, nil),
		mHotspotInfo = module2.Ternary(instance:IsA(__wf_atom_dab54c5c), mOwnerInfo, nil),
		mBiomeId = module.GetBiomeIdFromDensityVolume(mSpawnPosition),
		mWaterHeight = mOwnerInfo.mWaterHeight,
		mSmoothedAnimRate = __wf_atom_10cd16b2(0, 0.15),
		mMovementSweepRadius = data.mMovementSweepRadius,
		mInvestigationSweepRadius = data.mInvestigationSweepRadius,
		mNextTargetSweepTime = 0,
		mNextTrajectorySweepTime = 0,
		mVelocity = 0,
		mTargetVelocity = 0,
		mMaxVelocity = data.mMaxVelocity,
		mBoostedMaxVelocity = data.mBoostedMaxVelocity,
		mAcceleration = data.mAcceleration,
		mBoostedAcceleration = data.mBoostedAcceleration,
		mHeadingTurnRate = 0,
		mTargetHeadingTurnRate = 0,
		mPitchTurnRate = 0,
		mTargetPitchTurnRate = 0,
		mMaxTurnRate = data.mMaxTurnRate,
		mBoostedMaxTurnRate = data.mBoostedMaxTurnRate,
		mTurnAcceleration = data.mTurnAcceleration,
		mBoostedTurnAcceleration = data.mBoostedTurnAcceleration,
		mMinTurnVelocityMultiplier = data.mMinTurnVelocityMultiplier,
		mBoostedMinTurnVelocityMultiplier = data.mBoostedMinTurnVelocityMultiplier,
		mPreferredDepth = data.mPreferredDepth,
		mAllowedDepthRange = data.mAllowedDepthRange,
		mTargetPosition = nil,
		mMoveTimer = 0,
		mMoveDurationRange = data.mMoveDurationRange,
		mTargetLure = nil,
		mTargetLureOriginalPosition = nil,
		mLureUntargetDistance = 3.4028234663852886e38,
		mLureTargetCooldownTimer = 0,
		mLureTargetCooldownDuration = 10,
		mCachedTargetPosition = nil,
		mLureUnreachableTimer = 0,
		mLureUnreachableDuration = 1,
		mBiteDesiredDistance = 1,
		mBiteWindowStartTime = 3.4028234663852886e38,
		mBiteWindowDuration = data.mBiteWindowDuration,
		mBiteLineLength = 0,
		mBiteStruggleTargetHeading = 0,
		mBiteStruggleTargetPitch = 0,
		mBiteStruggleRotateTimer = 0,
		mBiteStruggleRotateTimeRange = data.mBiteStruggleRotateTimeRange,
		mBiteStruggleMaxVelocity = data.mBiteStruggleMaxVelocity,
		mFleeTimer = 0,
		mFleeDurationRange = data.mFleeDurationRange,
		mFleeSourcePosition = nil,
		mSpawnPosition = mSpawnPosition,
		mFailedSweepAttempts = 0,
		mStuckStartTime = 0,
		mBaseAnimRate = 2.5,
		mFleeAnimRate = 2.5,
		mBiteStruggleAnimRate = 0.3,
		mJumpCooldown = 0,
		mJumpCooldownRange = data.mWanderingJumpInterval,
		mJumpVelocity = __wf_atom_28d5d4aa,
		mJumpTargetVelocity = __wf_atom_28d5d4aa,
		mJumpAccel = __wf_atom_28d5d4aa,
		mHasLeftWater = false,
		mJumpingPower = data.mJumpingPower,
		mJumpAccelerationMultiplier = data.mJumpAccelerationMultiplier,
		mJumpDuration = 0,
		mIsPurified = false,
		mOriginalMeshScale = __wf_atom_c082fc3d
	}
	v5.mJumpCooldown = __wf_atom_104bfe98(v5.mJumpCooldownRange.minValue, v5.mJumpCooldownRange.maxValue, math.random())
	return v5
end