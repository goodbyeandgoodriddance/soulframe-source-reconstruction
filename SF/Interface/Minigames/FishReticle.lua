local module = require("SF.Scripts.Libs.FishingLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Interface.SFUtilities")
local v = {
	AIM = 1,
	THROW = 2,
	CAST = 3,
	NIBBLE = 4,
	HOOKED = 5
}
local v2 = nil
local v3 = {
	streakCount = 0,
	zoneAng = -45,
	zoneSize = 40,
	curAng = 0,
	angRate = 300,
	inHotZone = false
}
local v4 = {
	streakCount = 0,
	nibbleIntensity = 0,
	fishAng = 45,
	hitDist = 60,
	inHitDist = false,
	dotDist = 1000
}
local v5 = { "Star" }
local v6 = nil
local flag = false
local v7 = { "MaskingPlane0", "MaskingPlane1", "MaskingPlane2", "MaskingPlane3" }
local v8 = { Vector(), Vector(), Vector(), Vector() }

local function fn(p, p2, p3) -- 2 equivalent calls inferred from this helper
	local v9 = p2.x - p.x
	p3.x = -(p2.y - p.y)
	p3.y = v9
	Normalize(p3)
	p3.z = Dot(p3, p)
end

local function fn2(p) -- 4 equivalent calls inferred from this helper
	return gRegion:__wf_atom_c4f78a8f():PlaySound(p, false)
end

local function fn3(p)
	if flag then
		return
	end

	__wf_atom_7e8ad928(v6)

	if _T.FishingReticleData == nil then
		return
	end

	v3.curAng = module3.AddAngle(v3.curAng, -v3.angRate * p)

	if v3.curAng > 180 then
		v3.curAng -= 360
	end

	if v3.curAng < -180 then
		v3.curAng += 360
	end

	local aimPos = _T.FishingReticleData.AimPos
	local avatar = _T.FishingReticleData.Avatar

	if __wf_atom_7e8ad928(avatar) then
		return
	end

	local v9 = aimPos - avatar:GetPosition()
	local lureDeco = _T.FishingReticleData.LureDeco

	if __wf_atom_7e8ad928(lureDeco) then
		return
	end

	local v10 = lureDeco:GetPosition() - avatar:GetPosition()
	local __wf_atom_f582136d = lureDeco:__wf_atom_f582136d(__wf_atom_d00f34c2)

	if #__wf_atom_f582136d > 0 then
		local __wf_atom_dcecedb0 = __wf_atom_f582136d[1]:GetColor():__wf_atom_dcecedb0()
		mMovie:__wf_atom_e57658c2("Throw.CastDot", 11, __wf_atom_dcecedb0)
		v6:__wf_atom_e57658c2("CastDot.Marker", 11, __wf_atom_dcecedb0)
	end

	v10.y = 0
	Normalize(v10)
	local v11 = math.atan2(v10.z, v10.x)
	v3.curAng = -module2.ToDeg(v11)
	v9.y = 0
	Normalize(v9)
	local v12 = math.atan2(v9.z, v9.x)
	v3.zoneAng = -module2.ToDeg(v12)
	local v13 = v3.zoneAng + 90
	mMovie:__wf_atom_e57658c2("Throw.CastZone.ZoneArcStart", 16, v13 - v3.zoneSize)
	mMovie:__wf_atom_e57658c2("Throw.CastZone.ZoneArcEnd", 16, v13 + v3.zoneSize)
	fn(Vector(0, 0, 0), __wf_atom_9341614d(Vector(0, 1, 0), Rotation(0, 0, v13 + v3.zoneSize)), v8[1]) -- inferred equivalent call
	fn(__wf_atom_9341614d(Vector(0, 1, 0), Rotation(0, 0, v13 - v3.zoneSize)), Vector(0, 0, 0), v8[2]) -- inferred equivalent call
	mMovie:__wf_atom_1ca72041("Throw.CastZone.Circle", v7[1], v8[1].x, v8[1].y, v8[1].z, 0)
	mMovie:__wf_atom_1ca72041("Throw.CastZone.Circle", v7[2], v8[2].x, v8[2].y, v8[2].z, 0)
	mMovie:__wf_atom_1ca72041("Throw.CastZone.Circle", v7[3], v8[1].x, v8[1].y, v8[1].z, 0)
	mMovie:__wf_atom_1ca72041("Throw.CastZone.Circle", v7[4], v8[1].x, v8[1].y, v8[1].z, 0)
	local v14 = 100 * (v3.zoneSize / 30)
	local v15 = math.cos((module2.ToRad(v3.curAng))) * 230
	local v16 = math.sin((module2.ToRad(v3.curAng))) * 230
	gRegion:__wf_atom_c4f78a8f():CameraControl()

	if v6 then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Throw.CastDot", 2)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Throw.CastDot", 3)
		local __wf_atom_09e83ac4 = mMovie:__wf_atom_09e83ac4(__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2)
		local __wf_atom_74b9a49b = v6:__wf_atom_74b9a49b(__wf_atom_09e83ac4)
		local v17 = 50
		v6:__wf_atom_e57658c2("CastDot", 5, v17)
		v6:__wf_atom_e57658c2("CastDot", 6, v17 * 0.5)
		v6:__wf_atom_e57658c2("CastDot", 0, __wf_atom_74b9a49b.x)
		v6:__wf_atom_e57658c2("CastDot", 1, __wf_atom_74b9a49b.y)
		local zoneAng = v3.zoneAng
		local _ = math.cos((module2.ToRad(zoneAng))) * 230
		local _ = math.sin((module2.ToRad(zoneAng))) * 230
		local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("Throw.CastZone.ZoneArcStart.Inner", 2)
		local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("Throw.CastZone.ZoneArcStart.Inner", 3)
		local __wf_atom_5e6e15c8_5 = mMovie:__wf_atom_5e6e15c8("Throw.CastZone.ZoneArcEnd.Inner", 2)
		local __wf_atom_5e6e15c8_6 = mMovie:__wf_atom_5e6e15c8("Throw.CastZone.ZoneArcEnd.Inner", 3)
		local _ = v14 * 0.3
		local __wf_atom_09e83ac4_2 = mMovie:__wf_atom_09e83ac4(__wf_atom_5e6e15c8_3, __wf_atom_5e6e15c8_4)
		local __wf_atom_74b9a49b2 = v6:__wf_atom_74b9a49b(__wf_atom_09e83ac4_2)
		local __wf_atom_09e83ac4_3 = mMovie:__wf_atom_09e83ac4(__wf_atom_5e6e15c8_5, __wf_atom_5e6e15c8_6)
		local __wf_atom_74b9a49b3 = v6:__wf_atom_74b9a49b(__wf_atom_09e83ac4_3)
		local v18 = __wf_atom_f55d6358(__wf_atom_74b9a49b2, __wf_atom_74b9a49b3, 0.5)
		local v19 = __wf_atom_74b9a49b2 - __wf_atom_74b9a49b3
		local v20 = Length(v19)
		v6:__wf_atom_e57658c2("CastZone", 0, v18.x)
		v6:__wf_atom_e57658c2("CastZone", 1, v18.y)
		local v21 = math.atan2(v19.y, v19.x)
		v6:__wf_atom_e57658c2("CastZone", 16, 0 + module2.ToDeg(v21))
		v6:__wf_atom_e57658c2("CastZone.Texture", 14, v20 * 1)
		v6:__wf_atom_e57658c2("CastZone.Texture", 15, (math.max(10, v20 * 0.1)))
		v6:__wf_atom_e57658c2("CastDot", 12, 30)
		v6:__wf_atom_e57658c2("CastZone", 12, 30)
	end

	mMovie:__wf_atom_e57658c2("Throw.CastDot", 0, v15)
	mMovie:__wf_atom_e57658c2("Throw.CastDot", 1, v16)
	local inHotZone

	if math.abs((module3.SubtractAngle(v3.curAng, v3.zoneAng))) < v3.zoneSize then
		mMovie:__wf_atom_e57658c2("Throw.CastZone.Circle", 12, 100)
		mMovie:__wf_atom_e57658c2("Throw.CastZone.Circle", 11, 16777215)
		v6:__wf_atom_e57658c2("CastZone.Texture", 12, 200 / 3)
		v6:__wf_atom_e57658c2("CastZone.Texture", 11, 16777215)
		inHotZone = true
	else
		mMovie:__wf_atom_e57658c2("Throw.CastZone.Circle", 12, 75)
		mMovie:__wf_atom_e57658c2("Throw.CastZone.Circle", 11, 14524216)
		v6:__wf_atom_e57658c2("CastZone.Texture", 12, 50)
		v6:__wf_atom_e57658c2("CastZone.Texture", 11, 14524216)
		inHotZone = false
	end

	if inHotZone and not v3.inHotZone then
		fn2(hotZoneSound) -- inferred equivalent call
	end

	v3.inHotZone = inHotZone
end

local function fn4()
	__wf_atom_ec43d06e(mMovie, "Throw", 8, { 12 }, { 0 }, 0.2, 0)
	__wf_atom_ec43d06e(mMovie, "Marker", 8, { 12 }, { markerAlpha }, 0.2, 0)
	__wf_atom_ec43d06e(mMovie, "Nibble", 8, { 12 }, { 0 }, 0.2, 0)
	v6:__wf_atom_290807ee("_root")
	v6:Execute("Hide", "")
end

local function fn5()
	mMovie:__wf_atom_50d60589("Text", 36, "Casting")
	local perfectCastThreshold = module.GetPerfectCastThreshold(gRegion:__wf_atom_c4f78a8f())
	v3.zoneAng = -45
	v3.zoneSize = perfectCastThreshold
	v3.angRate = 400
	flag = false
	__wf_atom_ec43d06e(mMovie, "Throw", 8, { 12 }, { 100 }, 0.2, 0)
	__wf_atom_ec43d06e(mMovie, "Marker", 8, { 12 }, { markerAlpha }, 0.2, 0)
	__wf_atom_ec43d06e(mMovie, "Nibble", 8, { 12 }, { 0 }, 0.2, 0)
	v6:Execute("Show", "")
end

local function fn6() -- 1 equivalent call inferred from this helper
	__wf_atom_ec43d06e(mMovie, "Throw", 8, { 12 }, { 0 }, 0.2, 0)
	__wf_atom_ec43d06e(mMovie, "Marker", 8, { 12 }, { 0 }, 0.2, 0)
	__wf_atom_ec43d06e(mMovie, "Nibble", 8, { 12 }, { 0 }, 0.2, 0)
	v6:Execute("Hide", "")
end

local function fn7()
	mMovie:__wf_atom_50d60589("Text", 36, "Setting")
	v4.nibbleIntensity = 0
	v4.fishAng = math.random(-180, 180)
	__wf_atom_ec43d06e(mMovie, "Throw", 8, { 12 }, { 0 }, 0.2, 0)
	__wf_atom_ec43d06e(mMovie, "Marker", 8, { 12 }, { 0 }, 0.2, 0)
	v6:Execute("Show", "")
	v6:Execute("NibbleStart", "")
end

local function fn8()
	fn6() -- inferred equivalent call
end

function SetState(aim)
	if aim == "AIM" then
		aim = v.AIM
	elseif aim == "THROW" then
		aim = v.THROW
	elseif aim == "CAST" then
		aim = v.CAST
	elseif aim == "NIBBLE" then
		aim = v.NIBBLE
	elseif aim == "HOOKED" then
		aim = v.HOOKED
	end

	if v2 == aim then
		return
	end

	v2 = aim

	if v2 == v.AIM then
		fn4()
	elseif v2 == v.THROW then
		fn5()
	elseif v2 == v.CAST then
		fn6()
	elseif v2 == v.NIBBLE then
		fn7()
	elseif v2 == v.HOOKED then
		fn8()
	end
end

function Initialize()
	mMovie:__wf_atom_e57658c2("Throw", 12, 0)
	mMovie:__wf_atom_e57658c2("Nibble", 12, 0)
	mMovie:__wf_atom_c90af43a("Throw.Circle", castCircleTexture)
	mMovie:__wf_atom_c90af43a("Throw.CircleShadow", castCircleShadowTexture)
	mMovie:__wf_atom_c90af43a("Throw.CastZone.Circle", castCircleTexture)
	mMovie:__wf_atom_c90af43a("Throw.CastDot", castDotTexture)
	mMovie:__wf_atom_c90af43a("Marker", markerTexture)
	mMovie:__wf_atom_c90af43a("Nibble.HitZone", nibbleZoneTexture)
	mMovie:__wf_atom_e57658c2("Marker", 15, 48)
	mMovie:__wf_atom_e57658c2("Marker", 14, 48)
	mMovie:__wf_atom_e57658c2("Throw.CastZone.Circle", 11, 14524216)
	mMovie:__wf_atom_e57658c2("Throw.Circle", 11, 16777215)
	mMovie:__wf_atom_e57658c2("Throw.Circle", 12, 15)
	mMovie:__wf_atom_e57658c2("Throw.CastDot", 11, 4583423)
	mMovie:__wf_atom_e57658c2("Throw.CastDot", 5, 70)
	mMovie:__wf_atom_e57658c2("Throw.CastDot", 6, 70)
	mMovie:__wf_atom_e57658c2("Throw.CircleShadow", 12, 25)
	mMovie:__wf_atom_e57658c2("Marker", 11, 14800280)
	mMovie:__wf_atom_e57658c2("Marker", 12, markerAlpha)
	v6 = mMovie:PushChildMovie(supportMovie)
	v6:__wf_atom_50d60589("Notify.Text", 36, "")
	v6:__wf_atom_2dedec1a("Notify.Star", 13, false)
	v6:__wf_atom_e57658c2("CastDot.Marker", 11, 4583423)
	v6:__wf_atom_e57658c2("CastZone.Texture", 11, 14524216)
	v6:__wf_atom_e57658c2("CastDot", 12, 0)
	v6:__wf_atom_e57658c2("CastZone", 12, 0)
	mMovie:OverrideMaterial("Throw.CastZone.Circle", zonePlaneMaskingMaterial)
	mMovie:__wf_atom_e57658c2("Throw.CastZone.ZoneArcStart", 12, 1)
	mMovie:__wf_atom_e57658c2("Throw.CastZone.ZoneArcEnd", 12, 1)
	SetState(v.AIM)
end

function Update()
	local v9 = __wf_atom_084b3e93()
	mMovie:__wf_atom_88d9cd84(v9)

	if not __wf_atom_7e8ad928(v6) then
		v6:__wf_atom_8fcdea81(mMovie:__wf_atom_7be51ede())
	end

	if v2 == v.THROW then
		fn3(v9)
	else
		local _ = v2 == v.NIBBLE
	end
end

local function fn9(streakCount)
	if #v5 < streakCount then
		for i = #v5, streakCount do
			local v9 = "Star" .. i
			__wf_atom_86cbd68d(v6, "Notify.Star.duplicateMovieClip", v9, 1000 + i)
			table.insert(v5, v9)
		end
	end

	local v9 = streakCount
	local v10 = 1
	local v11 = 15

	while v9 > 0 do
		local v12 = v9 > 5 and 8355711 or 16777215
		local v13 = math.min(5, v9)
		v9 -= v13
		local v14 = math.max(0, v13 - 1) * 15
		local v15 = math.max(1, v13 - 1)

		for i = 1, v13 do
			local v16 = "Notify." .. v5[v10]
			local v17 = __wf_atom_104bfe98(-v14, v14, (i - 1) / v15)
			v6:__wf_atom_2dedec1a(v16, 13, true)
			v6:__wf_atom_e57658c2(v16, 0, v17)
			v6:__wf_atom_e57658c2(v16, 5, v11)
			v6:__wf_atom_e57658c2(v16, 6, v11)
			v6:__wf_atom_e57658c2(v16, 11, v12)
			v10 += 1
		end

		v11 *= 1.2
	end

	for i = streakCount + 1, #v5 do
		v6:__wf_atom_2dedec1a("Notify." .. v5[i], 13, false)
	end
end

local function fn10()
	if v2 ~= v.THROW then
		local _ = v2 == v.NIBBLE
		return
	end

	local v9 = math.abs((module3.SubtractAngle(v3.curAng, v3.zoneAng)))
	local v10

	if v9 < v3.zoneSize then
		_T.FishingCastResults = "PERFECT"
		v3.streakCount += 1

		if v3.streakCount == 5 then
			v6:__wf_atom_50d60589("Notify.Text", 36, "Perfect Streak!")
		elseif v3.streakCount == 10 then
			v6:__wf_atom_50d60589("Notify.Text", 36, "Super Streak!")
		elseif v3.streakCount == 25 then
			v6:__wf_atom_50d60589("Notify.Text", 36, "Crazy Streak!")
		else
			v6:__wf_atom_50d60589("Notify.Text", 36, "Perfect!")
		end

		fn2(perfectCastSound) -- inferred equivalent call
		v10 = 10
	elseif v9 < 90 then
		_T.FishingCastResults = "FINE"
		v6:__wf_atom_50d60589("Notify.Text", 36, "Fine...")
		fn2(fineCastSound) -- inferred equivalent call
		v3.streakCount = 0
		v10 = 20
	else
		_T.FishingCastResults = "BOTCH"
		v6:__wf_atom_50d60589("Notify.Text", 36, "Botched...")
		fn2(botchedCastSound) -- inferred equivalent call
		v3.streakCount = 0
		v10 = 50
	end

	fn9(v3.streakCount)
	v6:__wf_atom_e57658c2("Notify", 5, 50)
	v6:__wf_atom_e57658c2("Notify", 6, 50)
	v6:__wf_atom_e57658c2("Notify", 12, 0)
	__wf_atom_ec43d06e(v6, "Notify", 4, { 5, 6, 12 }, { 100, 100, 100 }, 1, 0, function()
		__wf_atom_ec43d06e(v6, "Notify", 8, { 12 }, { 0 }, 1, 2)
	end)
	__wf_atom_ec43d06e(mMovie, "Throw", 0, { function(p)
			local v11 = __wf_atom_24a82b69(1 - p)
			local v12 = 955.7 + Noise(Time() * 2.2) * v10 * v11
			local v13 = 540 + Noise(17.777 + Time() * 2.2) * v10 * v11
			mMovie:__wf_atom_e57658c2("Throw", 0, v12)
			mMovie:__wf_atom_e57658c2("Throw", 1, v13)
		end }, { 1 }, 1)
end

function GetCastingResults()
	fn10()
end

function SetHook(p)
	v6:Execute("SetHook", p)

	if _T.SetFishHook ~= 2 then
		v3.streakCount = 0
		return
	end

	v3.streakCount += 1
	fn9(v3.streakCount)
	v6:__wf_atom_e57658c2("Notify", 5, 50)
	v6:__wf_atom_e57658c2("Notify", 6, 50)
	v6:__wf_atom_e57658c2("Notify", 12, 0)
	__wf_atom_ec43d06e(v6, "Notify", 4, { 5, 6, 12 }, { 100, 100, 100 }, 1, 0, function()
		__wf_atom_ec43d06e(v6, "Notify", 8, { 12 }, { 0 }, 1, 2)
	end)
end