local module = require("EE.Interface.Utilities")
local v = 0
local v2 = {
	streakCount = 0,
	nibbleIntensity = 1,
	fishAng = 45,
	hitDist = 32,
	nibbleDuration = 3,
	nibbleCount = 3,
	nibbleTime = 0
}
local v3 = nil

local function fn(p) -- 7 equivalent calls inferred from this helper
	return gRegion:__wf_atom_c4f78a8f():PlaySound(p, false)
end

local function fn2(p) -- 1 equivalent call inferred from this helper
	local v4 = __wf_atom_4658d645(p)
	local v5

	if v4 < 0.5 then
		v5 = 1 - v4 * 2
	else
		v5 = v4 * 2 - 1
	end

	local v6 = __wf_atom_24a82b69(v5)
	return (__wf_atom_24a82b69(v6))
end

local function fn3(p)
	if _T.FishingReticleData == nil then
		_T.FishingReticleData = {}
	end

	local _targetFish = _T.FishingReticleData.TargetFish
	local lureDeco = _T.FishingReticleData.LureDeco

	if not __wf_atom_7e8ad928(lureDeco) then
		local position = lureDeco:GetPosition()
		local __wf_atom_74b9a49b = mMovie:__wf_atom_74b9a49b(position)
		mMovie:__wf_atom_e57658c2("Nibble", 0, __wf_atom_74b9a49b.x)
		mMovie:__wf_atom_e57658c2("Nibble", 1, __wf_atom_74b9a49b.y)
	end

	v2.nibbleTime += p

	if v2.nibbleTime >= v2.nibbleDuration then
		fn(nibbleFailedSound) -- inferred equivalent call
		__wf_atom_ec43d06e(mMovie, "Nibble", 8, { 12 }, { 0 }, 0.15)

		if v3 and v3:__wf_atom_7d4910e4() then
			v3:Stop(false)
		end

		v = 0
	else
		math.abs((Noise(Time() * 0.1)))
		local v4 = fn2(v2.nibbleCount * (math.max(0, v2.nibbleTime) / v2.nibbleDuration)) -- inferred equivalent call
		local v5 = Noise(7 + __wf_atom_4658d645(Time() * 0.2)) * math.abs((Noise(3 + __wf_atom_4658d645(Time() * 0.1))))
		mMovie:__wf_atom_e57658c2("Nibble.Lure", 16, v5 * 90)
		v2.nibbleIntensity = 1
		v2.fishAng += Noise(17472.7 + Time() * 0.1)
		mMovie:__wf_atom_5e6e15c8("Nibble", 0)
		mMovie:__wf_atom_5e6e15c8("Nibble", 1)
		local v6 = math.pow(__wf_atom_104bfe98(1, v4, __wf_atom_24a82b69(v2.nibbleIntensity)), 0.75) * 175
		local v7 = math.cos((module.ToRad(v2.fishAng))) * v6
		local v8 = math.abs(math.sin((module.ToRad(v2.fishAng))) * v6)
		local dotDist = math.sqrt(v7 * v7 + v8 * v8)
		local v9 = __wf_atom_104bfe98(90, 25, v4)
		mMovie:__wf_atom_e57658c2("Nibble.FishDot", 5, v9)
		mMovie:__wf_atom_e57658c2("Nibble.FishDot", 6, v9)
		mMovie:__wf_atom_e57658c2("Nibble.FishDot", 0, v7)
		mMovie:__wf_atom_e57658c2("Nibble.FishDot", 1, v8)
		mMovie:__wf_atom_e57658c2(
			"Nibble.Target",
			12,
			__wf_atom_104bfe98(100, 50, __wf_atom_421b01aa(dotDist / 100, 0, 1))
		)
		mMovie:__wf_atom_e57658c2("Nibble.FishDot", 12, __wf_atom_104bfe98(90, 25, v4))
		mMovie:__wf_atom_e57658c2("CastZone", 12, 0)

		if __wf_atom_7e8ad928(v3) then
			v3 = fn(nibbleSound) -- inferred equivalent call
		end

		if v3 and v3:__wf_atom_7d4910e4() then
			local v10 = __wf_atom_104bfe98(1.1, 0.5, (math.sqrt((__wf_atom_421b01aa(dotDist / 100, 0, 1)))))
			v3:__wf_atom_53043d81(v10)
		end

		local inHitDist = dotDist < v2.hitDist

		if inHitDist and inHitDist ~= v2.inHitDist then
			fn(hitHookSound) -- inferred equivalent call
		end

		v2.inHitDist = inHitDist
		v2.dotDist = dotDist
	end
end

local function fn4()
	fn(setHookSound) -- inferred equivalent call
	__wf_atom_ec43d06e(mMovie, "Nibble.Lure", 0, { function(p)
			local v4 = __wf_atom_24a82b69(1 - p)
			local v5 = Noise(Time() * 1.2) * 20 * v4
			local v6 = -88 + math.abs((Noise(17.777 + Time() * 0.5))) * 20 * -10 * v4
			mMovie:__wf_atom_e57658c2("Nibble.Lure", 0, v5 * 0.2)
			mMovie:__wf_atom_e57658c2("Nibble.Lure", 1, v6)
		end }, { 1 }, 0.5)

	if v2.dotDist < v2.hitDist / 4 then
		fn(setHookSuccessSound) -- inferred equivalent call
		mMovie:__wf_atom_50d60589("Notify.Text", 36, "Perfect Set!")
		v2.streakCount += 1
		_T.SetFishHook = 2
	elseif v2.inHitDist then
		fn(setHookSuccessSound) -- inferred equivalent call
		mMovie:__wf_atom_50d60589("Notify.Text", 36, "Fish On!")
		v2.streakCount += 1
		_T.SetFishHook = 1
	else
		fn(setHookFailSound) -- inferred equivalent call
		mMovie:__wf_atom_50d60589("Notify.Text", 36, "Missed!")
		v2.streakCount = 0
		_T.SetFishHook = nil
	end

	if _T.SetFishHook then
		__wf_atom_ec43d06e(mMovie, "Nibble", 8, { 12 }, { 0 }, 0.15)

		if v3 and v3:__wf_atom_7d4910e4() then
			v3:Stop(false)
		end

		v = 0
	end
end

function SetHook(_)
	fn4()
end

function onKeyDown_MENU_CLICK()
	SetHook()
end

local function fn5(p)
	v = p

	if v == 1 then
		v2.nibbleTime = 0
		local targetFish = _T.FishingReticleData.TargetFish
		v2.nibbleDuration = targetFish.mBiteWindowDuration
		v2.nibbleCount = targetFish.mBitePulseCount
		v2.fishAng = math.random(-180, 180)
		mMovie:__wf_atom_e57658c2("Nibble", 5, 1)
		mMovie:__wf_atom_e57658c2("Nibble", 6, 1)
		mMovie:__wf_atom_e57658c2("Nibble", 12, 0)
		__wf_atom_ec43d06e(mMovie, "Nibble", 4, { 5, 6, 12 }, { 100, 100, 100 }, 1.5)
	end
end

function Initialize()
	mMovie:__wf_atom_2dedec1a("Notify.Text", 13, false)
	mMovie:__wf_atom_2dedec1a("Notify.Star", 13, false)
	mMovie:__wf_atom_c90af43a("CastDot.Marker", markerTexture)
	mMovie:__wf_atom_c90af43a("CastZone.Texture", castZoneTexture)
	mMovie:OverrideMaterial("Nibble.Lure", underWaterMaterial)
	mMovie:OverrideMaterial("Nibble.Target", underWaterMaterial)
	mMovie:OverrideMaterial("Nibble.FishDot", underWaterMaterial)
	mMovie:__wf_atom_2dedec1a("Nibble.Lure", 13, false)
	mMovie:__wf_atom_c90af43a("Nibble.Lure", lureTexture)
	mMovie:__wf_atom_c90af43a("Nibble.Target", nibbleDotTexture)
	mMovie:__wf_atom_c90af43a("Nibble.FishDot", fishDotTexture)
	mMovie:__wf_atom_e57658c2("Nibble", 12, 0)
end

function Update()
	local v4 = __wf_atom_084b3e93()
	mMovie:__wf_atom_88d9cd84(v4)

	if __wf_atom_7e8ad928(mMovie:__wf_atom_2ad5cd23()) then
		mMovie:Close()
	end

	if v == 1 then
		fn3(v4)
	end
end

function Hide()
	__wf_atom_ec43d06e(mMovie, "CastDot", 8, { 12 }, { 0 }, 0.2, 0)
	__wf_atom_ec43d06e(mMovie, "CastZone", 8, { 12 }, { 0 }, 0.2, 0)
end

function Show()
	__wf_atom_ec43d06e(mMovie, "CastDot", 8, { 12 }, { 10 }, 0.2, 0)
	__wf_atom_ec43d06e(mMovie, "CastZone", 8, { 12 }, { 10 }, 0.2, 0)
end

function NibbleStart()
	__wf_atom_ec43d06e(mMovie, "CastDot", 8, { 12 }, { 0 }, 0.2, 0)
	__wf_atom_ec43d06e(mMovie, "CastZone", 8, { 12 }, { 0 }, 0.2, 0)
	fn5(1)
end