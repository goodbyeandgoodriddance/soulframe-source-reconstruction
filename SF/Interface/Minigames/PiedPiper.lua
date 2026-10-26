local module = require("SF.Interface.SFUtilities")
local module2 = require("SF.Interface.Libs.MusicCommon")
require("SF.Scripts.NightFoldLib")
local module3 = require("EE.Interface.Utilities")
local module4 = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = Symbol("Invulnerable")
local v2 = {}
local moteAnimal = nil
local position = nil
local v3 = __wf_atom_10cd16b2(0, 0.2)
local v4 = __wf_atom_10cd16b2(0, 0.2)
local v5 = __wf_atom_10cd16b2(0, 0.2)
local v6 = nil
local v7 = nil
local v8 = nil
local clips = { "Note1", "Note2", "Note3", "Note4", "Note5" }
local v9 = nil
local v10 = {}
local v11 = 0
local v12 = 120
local v13 = 0
local flag = false
local v14 = 1
local v15 = {}
local v16 = {}
local tx = 0
local v17 = 5
local v18 = 1
local v19 = 5
local v20 = 0
local song = nil
local count = 0
local total = 0
local flag2 = false
local v21 = 100
local v22 = -1
local v23 = false
local flag3 = false

local function fn(p, _, p2, value)
	local v24 = value or 90
	local v25 = 9
	__wf_atom_ec43d06e(mMovie, p, 4, { function(p3)
			local v26 = v24 * 2
			mMovie:__wf_atom_e57658c2(p, 5, (math.max(1, __wf_atom_104bfe98(v26, v24, p3))))
			mMovie:__wf_atom_e57658c2(p, 6, (math.max(1, __wf_atom_104bfe98(v26, v24, p3))))
			mMovie:__wf_atom_e57658c2(p, 12, (math.max(1, __wf_atom_104bfe98(v25, 100, p3))))
		end }, { 1 }, 0.75, 0, function()
		mMovie:__wf_atom_e57658c2(p, 5, v24)
		mMovie:__wf_atom_e57658c2(p, 6, v24)

		if p2 then
			__wf_atom_ec43d06e(mMovie, p, 8, { 12 }, { 0 }, 0.3)
		else
			__wf_atom_ec43d06e(mMovie, p, 8, { 12 }, { 100 }, 0.025)
		end
	end)
end

local function fn2()
	local v24 = v21 * total

	if flag2 then
		if v24 > 0 then
			v24 -= 10
		end

		flag2 = false
	end

	local v25 = math.floor(v24 + 0.5)

	if v22 ~= v25 then
		mMovie:__wf_atom_50d60589("Dust.Label", 36, module3.FormatNumber(v25, 0))
		v22 = v25
		fn("Dust", 100, false, 80)
	end
end

local function fn3(response, perfect)
	if __wf_atom_7e8ad928(v8) or v19 < response then
		return
	end

	v8:PlaySound(heartSound, false, 0, false)
	v8:PlaySound(heartSoundAux, false, 0, false)
	local v24 = "Heart" .. response .. ".Flower.Inner"
	mMovie:__wf_atom_2dedec1a(v24, 13, true)
	fn(v24, 0, false, 100)

	if perfect then
		v20 += 1
		local v25 = "Heart" .. response .. ".Flower.Heart"
		mMovie:__wf_atom_2dedec1a(v25, 13, true)
		fn(v25, 0, false, 100)
	end
end

local function fn4(data)
	mMovie:__wf_atom_e57658c2(data.clip, 0, data.x)
	mMovie:__wf_atom_e57658c2(data.clip, 1, data.y)

	if not __wf_atom_7e8ad928(data.particles) then
		local screenParticlesCoord, v24 = module3.GetScreenParticlesCoord(
			mMovie,
			data.x,
			data.y,
			gRegion:GetGameCamera()
		)
		local v25 = Vector(screenParticlesCoord, v24, 1)
		Normalize(v25)
		local v26 = v25 * 4
		data.particles:__wf_atom_e310f01f(v26, __wf_atom_80368bb1)
	end
end

local function fn5(clip, noteIndex, p)
	if not p then
		fn(clip)
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<SHAWZIN_NOTE_" .. tostring(noteIndex) .. ">", true, {}, true)
	mMovie:__wf_atom_48bd5a59(clip, "Callout.Tf", 36, __wf_atom_8e9ac384)
end

function OnGamepadTransition(_)
	for i = 1, #v2 do
		local v24 = v2[i]
		fn5(v24.clip, v24.noteIndex, true)
	end
end

local function fn6(noteIndex, p, p2)
	if __wf_atom_7e8ad928(v8) then
		return
	end

	local v24 = {}

	if noteIndex then
		v24.noteIndex = noteIndex
	else
		v24.noteIndex = math.random(1, #animalNoteSounds)
	end

	local dust = p2 or false
	local v25

	if not p then
		v25 = v8:PlaySound(animalNoteSounds[v24.noteIndex], false, 0, false)
	end

	v24.speed = 1 / (v11 + v11 / 8)
	local clip

	if #clips > 0 then
		clip = clips[#clips]
		table.remove(clips, #clips)
	else
		v17 += 1
		clip = "Note" .. v17
		__wf_atom_86cbd68d(mMovie, "Note1.duplicateMovieClip", clip, v17 + 1001)
	end

	local v26 = { x = v15[noteIndex], y = v16[noteIndex] }
	v24.tx = tx
	v24.ty = v26.y
	v24.s = 65
	v24.x = v26.x
	v24.y = v26.y
	v24.sx = v26.x
	v24.sy = v26.y
	v24.expire = nil
	v24.dust = dust
	v24.clip = clip
	mMovie:__wf_atom_2dedec1a(v24.clip, 13, true)
	mMovie:__wf_atom_2dedec1a(v24.clip .. ".Flame", 13, false)
	mMovie:__wf_atom_2dedec1a(v24.clip .. ".Callout", 13, true)
	mMovie:__wf_atom_2dedec1a(v24.clip .. ".Dust", 13, dust)
	mMovie:__wf_atom_2dedec1a(v24.clip .. ".Perfect", 13, false)
	mMovie:__wf_atom_2dedec1a(v24.clip .. ".Wrong", 13, false)
	v24.t = 0
	v24.seed = math.random()
	v24.perfect = false
	fn4(v24)
	fn5(v24.clip, v24.noteIndex)
	v24.particles = module3.CreateParticles(mMovie, v24.clip, noteParticleSys, 0, 0)
	module3.CreateParticles(mMovie, v24.clip, launchParticleSys, 0, 0)
	v24.response = nil

	if not __wf_atom_7e8ad928(v24.particles) then
		v24.particles:__wf_atom_dd9b7ab8(1 / v24.speed)
	end

	table.insert(v2, v24)
	return v25
end

local function fn7()
	if flag3 then
		return
	end

	flag3 = true
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_7470861b():__wf_atom_63396172(v)
		local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

		if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
			__wf_atom_b3845a20:__wf_atom_64d1f332(__wf_atom_c4f78a8f, mixEffect, mixingGroupIgnored)
		end

		local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
		musicResultsRMIArgs.mSuccess = flag
		musicResultsRMIArgs.mPerfect = v19 <= v20 or debugAlwaysPerfect and flag
		musicResultsRMIArgs.mIsPlaying = false
		__wf_atom_c4f78a8f:__wf_atom_0a2fdbe5(musicResultsRMIArgs)
		module4.EnableWeaponSlot(__wf_atom_c4f78a8f, "PiedPiper", true, 0)
		local cameraControl = __wf_atom_c4f78a8f:CameraControl()
		cameraControl:__wf_atom_fd14c463(0.5)
		cameraControl:SetCameraSpot(nil, 0.5)
		cameraControl:__wf_atom_928a45c5(colorGrading)
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:Stop(false)
	end

	gRegion:__wf_atom_dd1e4d10(v6)
	module.DissolveOutAndClose(mMovie)
end

function SkipGame()
	flag = true
	v20 = v19
	v8:__wf_atom_d2b2176d():__wf_atom_a3fda1f3(v21 * 15)
	fn7()
end

function InterruptGame()
	fn7()
end

local function fn8(p) -- 1 equivalent call inferred from this helper
	p.expire = 1
	mMovie:__wf_atom_2dedec1a(p.clip .. ".Wrong", 13, true)
	mMovie:__wf_atom_2dedec1a(p.clip .. ".Callout", 13, false)
end

local function fn9(p, p2)
	if __wf_atom_7e8ad928(v8) or not p2 then
		return
	end

	v8:PlaySound(noteSounds[p], false, 0, false)
	fn("PlayerNote" .. p, nil, true, 100)
	mMovie:__wf_atom_2dedec1a("PlayerNote" .. p, 13, true)
	mMovie:__wf_atom_e57658c2("PlayerNote" .. p .. ".Perfect", 12, 0)
	mMovie:__wf_atom_e57658c2("PlayerNote" .. p .. ".Correct", 12, 0)
	mMovie:__wf_atom_e57658c2("PlayerNote" .. p .. ".Glow", 11, 16728128)
	local v24 = false

	for i = #v2, 1, -1 do
		local v25 = v2[i]
		local v26 = v25.x - v25.tx
		local v27 = v25.y - v25.ty
		local v28 = math.sqrt(v26 * v26 + v27 * v27)

		if v25.expire or v25.response or not (v28 <= 20) or v25.noteIndex ~= p then
			continue
		end

		v24 = true
		v25.tx = v25.sx
		v25.ty = v25.sy

		if v19 < v18 and not v25.dust then
			mMovie:__wf_atom_2dedec1a(v25.clip, 13, false)
		else
			local v29 = (v18 - 1) % v19 + 1
			v25.tx = mMovie:__wf_atom_5e6e15c8("Heart" .. v29, 0)
			v25.ty = mMovie:__wf_atom_5e6e15c8("Heart" .. v29, 1)
		end

		if v28 <= 6 then
			v8:PlaySound(perfectHitSound, false, 0, false)
			v25.perfect = true
			total += 1
			mMovie:__wf_atom_e57658c2("PlayerNote" .. p .. ".Perfect", 12, 100)
			mMovie:__wf_atom_e57658c2("PlayerNote" .. p .. ".Correct", 12, 0)
			mMovie:__wf_atom_e57658c2("PlayerNote" .. p .. ".Glow", 11, 16564557)
		else
			mMovie:__wf_atom_e57658c2("PlayerNote" .. p .. ".Perfect", 12, 0)
			mMovie:__wf_atom_e57658c2("PlayerNote" .. p .. ".Correct", 12, 100)
			mMovie:__wf_atom_e57658c2("PlayerNote" .. p .. ".Glow", 11, 45308)
		end

		if v25.dust then
			v25.tx = mMovie:__wf_atom_5e6e15c8("Dust.Boost", 2)
			v25.ty = mMovie:__wf_atom_5e6e15c8("Dust.Boost", 3)

			if v25.perfect then
				total += 10
			else
				total += 5
			end
		end

		mMovie:__wf_atom_2dedec1a(v25.clip .. ".Callout", 13, false)
		mMovie:__wf_atom_2dedec1a(v25.clip .. ".Flame", 13, true)
		v25.sx = v25.x
		v25.sy = v25.y
		v25.t = 0
		v25.speed *= 3.5
		v25.response = v18

		if not v25.dust then
			v18 += 1
		end

		v25.seed = math.random()
		v25.particles = module3.CreateParticles(mMovie, v25.clip, noteParticleSys, 0, 0)

		if not __wf_atom_7e8ad928(v25.particles) then
			v25.particles:__wf_atom_dd9b7ab8(1 / v25.speed)
		end

		v25.reponseParticles = module3.CreateParticles(mMovie, v25.clip, responseParticleSys, 0, 0)
		fn(v25.clip, mMovie:__wf_atom_5e6e15c8(v25.clip, 12))

		if flag or not (v19 < v18) then
			continue
		end

		flag = true
		__wf_atom_ec43d06e(mMovie, "WinGlow", 8, { 12 }, { 50 }, 0.3, 1 / v25.speed)
		v7:AddTimer(1 / v25.speed, function()
			if not __wf_atom_7e8ad928(v8) then
				v8:PlaySound(winSound, false, 0, false)
			end

			v7:AddTimer(1, function()
				if not __wf_atom_7e8ad928(v8) then
					local __wf_atom_e919fb8e = v8:__wf_atom_e919fb8e()
					__wf_atom_e919fb8e.HeartIndex = v18
					__wf_atom_e919fb8e.Loops = count
					__wf_atom_e919fb8e.Perfect = total
					v8:__wf_atom_d2b2176d():__wf_atom_a3fda1f3(v22)
				end

				fn7()
			end)
		end)
	end

	if not v24 then
		for i = 1, #v2 do
			if v2[i].expire then
				continue
			end

			fn8(v2[i]) -- inferred equivalent call
			flag2 = true
			fn2()
			return
		end
	end
end

local function fn10(p)
	if __wf_atom_7e8ad928(v8) then
		return
	end

	for i = #v2, 1, -1 do
		local v24 = v2[i]
		local v25 = v24.response and 1 or 1.1
		v24.t = __wf_atom_421b01aa(v24.t + p * v24.speed, 0, v25)
		local t = v24.t
		v24.x = __wf_atom_104bfe98(v24.sx, v24.tx, t)
		v24.y = __wf_atom_104bfe98(v24.sy, v24.ty, t)
		local v26 = 1 - math.abs(v24.t * 2 - 1)
		local v27 = __wf_atom_24a82b69(v26)
		local v28 = 6

		if v24.response then
			v28 = 30
		elseif v24.t > 1 or v24.expire then
			if not v24.failSoundPlayed then
				v24.failSoundPlayed = true
				v8:PlaySound(noteFallSound, false, 0, false)
			end

			local v29 = (v24.t - 1) / (v25 - 1)

			if v24.expire then
				v29 = math.max(v29, 1 - v24.expire)
				v24.expire -= p
			end

			mMovie:__wf_atom_e57658c2(v24.clip, 12, __wf_atom_104bfe98(100, 0, __wf_atom_24a82b69(v29)))
			v24.y += math.pow(v29, 3) * 200
		end

		v24.y += math.sin(v24.seed + 12.566370614359172 * v24.t) * v28 * v27

		if v24.response then
			v24.x += math.sin(v24.seed + 6.283185307179586 * v24.t) * v28 * v27
		end

		if v24.response then
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v24.clip, 0)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v24.clip, 1)
			local v29 = v24.x - __wf_atom_5e6e15c8
			local v30 = math.atan2(v24.y - __wf_atom_5e6e15c8_2, v29)
			local deg = module3.ToDeg(v30)
			mMovie:__wf_atom_e57658c2(v24.clip .. ".Flame", 16, 270 + deg)
		end

		fn4(v24)

		if not (v25 <= v24.t or v24.expire and v24.expire <= 0) then
			continue
		end

		table.insert(clips, v24.clip)
		table.remove(v2, i)
		mMovie:__wf_atom_2dedec1a(v24.clip, 13, false)

		if not v24.response then
			continue
		end

		module3.CreateParticles(mMovie, v24.clip, absorbParticleSys, 0, 0)

		if not v24.dust then
			fn3(v24.response, v24.perfect)
		end

		if v24.perfect then
			fn2()
		end
	end
end

function OverrideMusicStartAnim(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_3d96ddcd:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.musicSkipStartAnim = false

	while
		not __wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		and __wf_atom_3d96ddcd:__wf_atom_c138b19b(musicStartAnim)
		and __wf_atom_3d96ddcd:__wf_atom_0473b7a9()
	do
		Sleep(0)
	end

	if not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_3d96ddcd:__wf_atom_0473b7a9()) then
		__wf_atom_3d96ddcd:__wf_atom_1659a669(nil, false)
		__wf_atom_3d96ddcd:__wf_atom_33b8b73f(nil, false, 0, 1, false, true)
		__wf_atom_e919fb8e.musicSkipStartAnim = true
	end
end

function OverrideMusicEndAnim(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_8161e6ba = __wf_atom_3d96ddcd:__wf_atom_8161e6ba()
	local __wf_atom_e919fb8e = __wf_atom_3d96ddcd:__wf_atom_e919fb8e()

	if
		(__wf_atom_7e8ad928(__wf_atom_8161e6ba) or not __wf_atom_8161e6ba.mPerfect)
		and (__wf_atom_7e8ad928(__wf_atom_e919fb8e) or not __wf_atom_e919fb8e.musicSkipStartAnim)
	then
		__wf_atom_3d96ddcd:__wf_atom_1659a669(nil, false, 0, 1, true)

		if not __wf_atom_7e8ad928(musicEndAnim) then
			__wf_atom_3d96ddcd:__wf_atom_33b8b73f(musicEndAnim, false, 3, 1, true, true)
		end

		Sleep(0)

		while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:__wf_atom_c138b19b(musicEndAnim) do
			if
				(__wf_atom_3d96ddcd:__wf_atom_08998754() == 0 or __wf_atom_3d96ddcd:__wf_atom_08998754() == 1)
				and (__wf_atom_3d96ddcd:__wf_atom_0559c091() == 0 or __wf_atom_3d96ddcd:__wf_atom_0559c091() == 32)
			then
				Sleep(0)
			else
				__wf_atom_3d96ddcd:__wf_atom_33b8b73f(nil, false, 0, 1, false, true)
				return
			end
		end
	else
		__wf_atom_3d96ddcd:__wf_atom_1659a669(nil, false, 0, 1, true)
		__wf_atom_3d96ddcd:__wf_atom_33b8b73f(nil, false, 0, 1, false, true)
	end
end

function DestroyInstrumentAfter(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	while
		not __wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		and (__wf_atom_3d96ddcd:__wf_atom_c138b19b(musicEndAnim) or __wf_atom_3d96ddcd:__wf_atom_c138b19b(musicLoopAnim))
	do
		Sleep(0)
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

function AvatarPlayInstrument(p)
	module2.AvatarPlayInstrument(p, "SaveDeoraSoulCin", instrumentDecoType, musicStartAnim, musicLoopAnim, musicEndAnim)
end

function InitPlayer(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_d2b2176d():Unequip(0, 2)
	module4.EnableWeaponSlot(object, "PiedPiper", false, 0)
	object:__wf_atom_7470861b():__wf_atom_9fba31e6(v, 26, 6, 0)
	local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
	musicResultsRMIArgs.mIsPlaying = true
	object:__wf_atom_0a2fdbe5(musicResultsRMIArgs)
	object:__wf_atom_8a035cd5(Symbol("AvatarPlayInstrument"), false)
	v9 = object:PlaySound(openSound, false, 0, false)
	object:PlaySound(startSound, false, 0, false)
	local cameraControl = object:CameraControl()
	cameraControl:__wf_atom_dc7b15db(colorGrading, 0.0001, -1, 0.0001)
	cameraControl:__wf_atom_344d785e(colorGrading, 1)
end

function FloatAnimal(object)
	local position2 = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local v24 = 0

	while not __wf_atom_7e8ad928(object) do
		v24 = __wf_atom_421b01aa(v24 + __wf_atom_084b3e93() * 0.5, 0, 1)
		local v25 = __wf_atom_24a82b69(v24)
		local v26 = position2 + Vector(0, -0.5, 0)
		v26.y += Noise(Time() * 0.1) * 0.3
		object:SetPosition(__wf_atom_f55d6358(position2, v26, v25))
		local v27 = Noise(3 + Time() * 0.1) * 50
		local v28 = Noise(7 + Time() * 0.1) * 20
		object:__wf_atom_9b788a35((Rotation(
			__wf_atom_dc309f8a.heading + v27 * v25,
			__wf_atom_dc309f8a.pitch + v28 * v25,
			__wf_atom_dc309f8a.bank
		)))
		Sleep(0)
	end
end

function InitTempAnimal(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.MoteAnimal) then
		local __wf_atom_74d951b0 = object:__wf_atom_d2b2176d():__wf_atom_74d951b0()
		local v24 = __wf_atom_fa8d0177(__wf_atom_74d951b0, object:EyePosition())
		moteAnimal = gRegion:CreateEntity(protoAnimalDecoType, __wf_atom_74d951b0, v24)
		moteAnimal:__wf_atom_8a035cd5(Symbol("FloatAnimal"), false)
		position = __wf_atom_74d951b0
	else
		moteAnimal = __wf_atom_e919fb8e.MoteAnimal
		moteAnimal:__wf_atom_7601b116(object:__wf_atom_a2a18137())
		moteAnimal:MotionControl():__wf_atom_3a1d0c16(moteAnimal:__wf_atom_4e50d390())
		position = moteAnimal:GetPosition()
	end

	if not __wf_atom_7e8ad928(moteAnimal) then
		local __wf_atom_e919fb8e2 = moteAnimal:__wf_atom_e919fb8e()
		song = __wf_atom_e919fb8e2.Song
		local v24 = Random(0, 1)

		if __wf_atom_e919fb8e2.Rarity == 0 then
			v19 = 3
			v14 = 1
			v21 = 25

			if __wf_atom_7e8ad928(__wf_atom_e919fb8e2.hasDust) then
				__wf_atom_e919fb8e2.hasDust = v24 > 0.75
			end
		elseif __wf_atom_e919fb8e2.Rarity == 1 then
			v19 = 4
			v14 = 1.1
			v21 = 50

			if __wf_atom_7e8ad928(__wf_atom_e919fb8e2.hasDust) then
				__wf_atom_e919fb8e2.hasDust = v24 > 0.5
			end
		elseif __wf_atom_e919fb8e2.Rarity == 2 then
			v19 = 5
			v14 = 1.25
			v21 = 100

			if __wf_atom_7e8ad928(__wf_atom_e919fb8e2.hasDust) then
				__wf_atom_e919fb8e2.hasDust = v24 > 0.25
			end
		end
	end

	v3:__wf_atom_4453e49c(position.x)
	v4:__wf_atom_4453e49c(position.y)
	v5:__wf_atom_4453e49c(position.z)
end

function InitializeSong()
	local midiSong = midiSongs[__wf_atom_5784a397(1, #midiSongs)]

	if not __wf_atom_7e8ad928(song) then
		midiSong = song
	end

	v10 = {}
	Resource(midiSong:__wf_atom_1bb5b1ff())
	v11 = midiSong:__wf_atom_1e34340d()
	v12 = midiSong:__wf_atom_176234ad()
	local __wf_atom_b17a4143 = midiSong:__wf_atom_b17a4143()

	for i = 1, #__wf_atom_b17a4143 do
		local v24 = __wf_atom_b17a4143[i]
		local note = v24.note
		local start = v24.start
		local v25 = { module2.MidiNoteToInstrumentSoundIndex(note), start / v11 }
		table.insert(v10, v25)
	end

	v13 = -1.5 / v11
end

function Update()
	if __wf_atom_7e8ad928(v8) then
		return
	end

	local v24 = __wf_atom_084b3e93()
	local v25 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v25)

	if not __wf_atom_7e8ad928(v7) then
		v7:Update(v25)
	end

	fn10(v24)
	local v26 = v11

	if #v10 > 0 then
		v26 = v10[#v10][2] + v11 / 2
	end

	if v26 <= v13 then
		v13 = v26 - v13
		count += 1
		fn2()
	end

	if not __wf_atom_7e8ad928(moteAnimal) and moteAnimal:__wf_atom_e919fb8e().hasDust and not v23 then
		v23 = true
		local v27 = __wf_atom_104bfe98(1, v26, math.random())
		v7:AddTimer(v27, function()
			local v28 = fn6(__wf_atom_5784a397(1, 5), false, true)

			if not __wf_atom_7e8ad928(v28) then
				v28:__wf_atom_ff2a5387(-8)
				v28:__wf_atom_c7e39dd1(48)
			end
		end)
	end

	local v27 = v13

	if not flag then
		v13 += v25 * 1 * v14 / v11
	end

	if not flag then
		for i = 1, #v10 do
			if not (v27 <= v10[i][2] and v13 > v10[i][2]) then
				continue
			end

			local v28 = fn6(v10[i][1], false)

			if __wf_atom_7e8ad928(v28) then
				continue
			end

			v28:__wf_atom_ff2a5387(-8)
			v28:__wf_atom_c7e39dd1(48)
		end
	end

	if not __wf_atom_7e8ad928(moteAnimal) then
		local __wf_atom_d0069154 = moteAnimal:__wf_atom_d0069154()
		local __wf_atom_ee03557f = moteAnimal:__wf_atom_ee03557f()
		local v28 = __wf_atom_d0069154 + Vector(0, __wf_atom_ee03557f.y * 0.75, 0)

		if moteAnimal:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD1")) then
			v28 = moteAnimal:__wf_atom_1c374cc9(Symbol("GAME_C1_HEAD1"))
		elseif moteAnimal:__wf_atom_71a94e55(Symbol("GAME_C1_HEAD")) then
			v28 = moteAnimal:__wf_atom_1c374cc9(Symbol("GAME_C1_HEAD"))
		end

		position.x = v3:__wf_atom_2490589b(v28.x, v24)
		position.y = v4:__wf_atom_2490589b(v28.y, v24)
		position.z = v5:__wf_atom_2490589b(v28.z, v24)
	end

	local __wf_atom_74b9a49b = mMovie:__wf_atom_74b9a49b(position)
	local v28 = v19

	for i = 1, v28 do
		local v29 = (i - 1) / v28
		local v30 = __wf_atom_104bfe98(150, -210, v29) * 0.017453292519943295
		local v31 = math.sin(v30)
		local v32 = math.cos(v30)
		local v34 = __wf_atom_74b9a49b.x + v31 * 100
		local v35 = __wf_atom_74b9a49b.y + v32 * 100
		local v36 = v34 + Noise(i * 17 + Time() * 0.2) * 20
		local v37 = v35 + Noise(i * 3 + Time() * 0.2) * 20
		local v38 = "Heart" .. i
		mMovie:__wf_atom_e57658c2(v38, 0, v36)
		mMovie:__wf_atom_e57658c2(v38, 1, v37)
	end

	for i = v28 + 1, 5 do
		local v29 = "Heart" .. i
		mMovie:__wf_atom_2dedec1a(v29, 13, false)
	end

	if flag then
		local __wf_atom_74b9a49b2 = mMovie:__wf_atom_74b9a49b(position)
		mMovie:__wf_atom_e57658c2("WinGlow", 0, __wf_atom_74b9a49b2.x)
		mMovie:__wf_atom_e57658c2("WinGlow", 1, __wf_atom_74b9a49b2.y)
		local v29 = __wf_atom_104bfe98(
			100,
			150,
			(math.abs((math.sin(__wf_atom_4658d645(Time() * 0.2) * 3.141592653589793 * 2))))
		)
		mMovie:__wf_atom_e57658c2("WinGlow", 5, v29)
		mMovie:__wf_atom_e57658c2("WinGlow", 6, v29)
		mMovie:__wf_atom_e57658c2("WinGlow.Inner1", 16, __wf_atom_4658d645(Time() * 0.1) * 360)
		mMovie:__wf_atom_e57658c2("WinGlow.Inner2", 16, __wf_atom_4658d645(Time() * 0.1) * -360)
	end
end

function Initialize()
	mMovie:__wf_atom_433c28ce(false)
	v8 = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(v8) then
		return
	end

	InitPlayer(v8)
	InitTempAnimal(v8)
	fn2()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(v8, mixEffect, mixingGroupIgnored)
	end

	local gameCamera = gRegion:GetGameCamera()
	local v24 = v8:EyePosition() - Vector(0, 0.25, 0)
	local v25 = v24 + __wf_atom_9341614d(Vector(1.5, 0, -1), gameCamera:__wf_atom_dc309f8a())
	local v26 = Vector()
	local v27 = Vector()
	gameCamera:__wf_atom_592ddaac(v24, v26)
	gameCamera:__wf_atom_592ddaac(position + Vector(0, 1, 0), v27)
	local __wf_atom_92e88294 = gameCamera:__wf_atom_92e88294((__wf_atom_f55d6358(v26, v27, 0.5)))
	local v28 = __wf_atom_fa8d0177(v25, __wf_atom_92e88294)
	v6 = gRegion:CreateEntity(cameraSpotType, v25, v28)
	v8:CameraControl():__wf_atom_fd14c463(1)
	v8:CameraControl():SetCameraSpot(v6, 0.5)
	mMovie:__wf_atom_8fcdea81(v8:__wf_atom_a96eb2aa())
	v8:__wf_atom_51cd6126(Symbol("PiedPiperInterruptDamage"), "OnDamaged")
	local module5 = require("Lotus.Interface.Libs.TimerMgr")
	v7 = module5.CreateTimerMgr()
	mMovie:__wf_atom_2dedec1a("Cross", 13, false)

	for i = 1, 5 do
		local v29 = "PlayerNote" .. i
		mMovie:__wf_atom_e57658c2(v29, 12, 0)
		mMovie:__wf_atom_e57658c2(v29 .. ".Perfect", 12, 0)
		mMovie:__wf_atom_e57658c2(v29 .. ".Correct", 12, 0)
		local v30 = "Note" .. i
		v15[i] = mMovie:__wf_atom_5e6e15c8(v30, 0)
		v16[i] = mMovie:__wf_atom_5e6e15c8(v30, 1)
		mMovie:__wf_atom_2dedec1a(v30, 13, false)
		mMovie:__wf_atom_2dedec1a("Heart" .. i .. ".Flower.Inner", 13, false)
		mMovie:__wf_atom_2dedec1a("Heart" .. i .. ".Flower.Heart", 13, false)
		mMovie:__wf_atom_e57658c2("Heart" .. i, 12, 90)
	end

	for i = v19 + 1, 5 do
		local v29 = "PlayerNote" .. i
		mMovie:__wf_atom_2dedec1a(v29, 13, false)
		local v30 = "Note" .. i
		mMovie:__wf_atom_2dedec1a(v30, 13, false)
	end

	tx = mMovie:__wf_atom_5e6e15c8("Scrubber", 0)
	mMovie:__wf_atom_e57658c2("WinGlow", 12, 0)
	InitializeSong()
	module.DissolveIn(mMovie)
	fn2()
end

function OnDamaged(object)
	if not (__wf_atom_7e8ad928(object) or flag3) then
		object:__wf_atom_1659a669(nil, false)
		object:__wf_atom_33b8b73f(nil, false, 0, 1, false, true)
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.musicSkipStartAnim = true
		fn7()
	end
end

function onKeyDown_MENU_CANCEL()
	fn7()
	return true
end

function onKeyDown_SHAWZIN_EXIT()
	fn7()
	return true
end

function onKeyDown_ACTIVATE_ABILITY_0()
	return true
end

function onKeyDown_ACTIVATE_ABILITY_1()
	return true
end

function onKeyDown_ACTIVATE_ABILITY_2()
	return true
end

function onKeyDown_ACTIVATE_ABILITY_3()
	return true
end

function onKeyDown_SHAWZIN_NOTE_1()
	fn9(1, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_1()
	fn9(1, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_2()
	fn9(2, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_2()
	fn9(2, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_3()
	fn9(3, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_3()
	fn9(3, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_4()
	fn9(4, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_4()
	fn9(4, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_5()
	fn9(5, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_5()
	fn9(5, false)
	return true
end