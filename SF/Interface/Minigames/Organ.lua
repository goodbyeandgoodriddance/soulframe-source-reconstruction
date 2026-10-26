local module = require("SF.Interface.SFUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("SF.Scripts.Libs.ModifySkyLib")
local v = nil
local v2 = nil
local v3 = Rotation()
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = __wf_atom_10cd16b2(960, 0.1)
local v8 = __wf_atom_10cd16b2(540, 0.1)
local v9 = Vector()
local v10 = false
local v11 = __wf_atom_10cd16b2(60, 0.5)
local v12 = { nil, nil, nil, nil }
v12[1], v12[2], v12[3], v12[4] = 1, 2, 3, 4
local v13 = nil
local v14 = 1
local v15 = nil
local v16 = 0
local flag = false
local v17 = Symbol("OrganMinigameEnded")

local function fn(p, _, p2, value)
	local v18 = value or 70
	local v19 = 9

	local function fn2(p3)
		local v20 = v18 * 2
		mMovie:__wf_atom_e57658c2(p, 5, (math.max(1, __wf_atom_104bfe98(v20, v18, p3))))
		mMovie:__wf_atom_e57658c2(p, 6, (math.max(1, __wf_atom_104bfe98(v20, v18, p3))))
		mMovie:__wf_atom_e57658c2(p, 12, (math.max(1, __wf_atom_104bfe98(v19, 100, p3))))
	end

	if p2 then
		mMovie:__wf_atom_e57658c2(p, 11, 8355711)
	else
		mMovie:__wf_atom_e57658c2(p, 11, 16777215)
	end

	__wf_atom_ec43d06e(mMovie, p, 4, { fn2 }, { 1 }, 0.3, 0, function()
		mMovie:__wf_atom_e57658c2(p, 5, v18)
		mMovie:__wf_atom_e57658c2(p, 6, v18)

		if p2 then
			__wf_atom_ec43d06e(mMovie, p, 8, { 12 }, { 0 }, 0.1)
		else
			__wf_atom_ec43d06e(mMovie, p, 8, { 12 }, { 100 }, 0.025)
		end
	end)
end

local function fn2(p, p2, p3)
	if not p3 then
		fn(p)
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<SHAWZIN_NOTE_" .. tostring(p2) .. ">", true, {}, true)
	mMovie:__wf_atom_48bd5a59(p, "Callout.Tf", 36, __wf_atom_8e9ac384)
end

function OnGamepadTransition(_)
	fn2("NoteContainer.Note" .. 1, 1, true)
	fn2("NoteContainer.Note" .. 2, 2, true)
	fn2("NoteContainer.Note" .. 3, 3, true)
	fn2("NoteContainer.Note" .. 4, 4, true)
	fn2("NoteContainer.Note" .. 5, 5, true)
end

local function fn3()
	local v18 = { 1, 2, 3, 4 }
	module2.ShuffleTable(v18)
	v12 = {}
	v12[1] = v18[1]
	v12[2] = v18[2]
	v12[3] = v18[3]
	v13 = nil
end

local function fn4(p)
	if v14 > 0 then
		v14 -= p

		if v14 <= 0 then
			fn3()
		end
	else
		if #v12 == 0 then
			return
		end

		if v12[1] ~= v13 then
			fn("NoteContainer.Note" .. v12[1], nil, false, 70)
			v:PlaySound(showNoteSound, false, 0, false)
			v13 = v12[1]
		end
	end
end

function Initialize()
	for i = 1, 5 do
		local v18 = "NoteContainer.Note" .. i
		mMovie:OverrideMaterial(v18 .. ".Lightning", lightningMaterial)
		mMovie:__wf_atom_4c1c1986(v18, "Perfect", 12, 0)
		mMovie:__wf_atom_4c1c1986(v18, "Correct", 12, 0)
		mMovie:__wf_atom_e57658c2(v18, 12, 0)
		fn2(v18, i, true)
	end

	mMovie:__wf_atom_e57658c2("NoteContainer.Note5", 1, -100)
	mMovie:OverrideMaterial("Aim.Lightning1", lightningMaterial)
	mMovie:OverrideMaterial("Aim.Lightning2", lightningMaterial)
	mMovie:__wf_atom_e57658c2("NoteContainer", 12, 90)
	mMovie:__wf_atom_e57658c2("Aim", 12, 50)
	v = gRegion:__wf_atom_c4f78a8f()
	mMovie:__wf_atom_8fcdea81(v:__wf_atom_a96eb2aa())
	v2 = gRegion:FindNearestTagged(Symbol("OrganCamera"), v:GetPosition())
	v3 = v2:__wf_atom_dc309f8a()
	v4 = gRegion:FindNearestTagged(Symbol("OrganTower"), v:GetPosition())
	v5 = gRegion:FindNearestTagged(Symbol("OrganTowerCenter"), v:GetPosition())
	v6 = gRegion:FindNearestTagged(Symbol("OrganMinigameReplicator"), v:GetPosition())
	local cameraControl = v:CameraControl()
	v:CameraControl():__wf_atom_fd14c463(1)
	v:CameraControl():SetCameraSpot(v2, 0.5)
	cameraControl:__wf_atom_dc7b15db(colorGrading, 0.0001, -1, 0.0001)
	cameraControl:__wf_atom_344d785e(colorGrading, 1)
	gRegion:__wf_atom_8ad59546().postProcess:__wf_atom_351eef0b(postProcessMaterial)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	__wf_atom_8ad59546.postProcess.radialBlurStrength = 0.1
	v:PlaySound(openSound, false, 0, false)
	module.RegisterHideHud(true)
	module4.ClearWeatherAndDisableCycle()
	v:__wf_atom_51cd6126(Symbol("OrganTookDamage"), "OnDamaged")
	_T.OrganMinigameStarted = true
	local __wf_atom_e919fb8e = v:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.DamagedOnOrgan = false
	fn3()
	local module5 = require("Lotus.Interface.Libs.TimerMgr")
	v15 = module5.CreateTimerMgr()
end

local function fn5(state, p)
	state.x = (state.x - 0.5) * 2
	state.y = (state.y - 0.5) * 2
	state.y *= 0.75
	state.x /= 1 + (state.x * state.x + state.y + state.y) * -p + 1.6 * p
	state.y *= 4 / 3
	state.x = state.x * 0.5 + 0.5
	state.y = state.y * 0.5 + 0.5
end

local function fn6(__wf_atom_2490589b, __wf_atom_2490589b2)
	mMovie:__wf_atom_65213f02()
	local __wf_atom_a35a5fbb, v18 = mMovie:__wf_atom_a35a5fbb(__wf_atom_2490589b, __wf_atom_2490589b2)
	local __wf_atom_d5a50cb5 = mMovie:__wf_atom_d5a50cb5()
	local __wf_atom_c4f6543f = mMovie:__wf_atom_c4f6543f()
	local v19 = Vector(__wf_atom_a35a5fbb / __wf_atom_d5a50cb5, v18 / __wf_atom_c4f6543f, 0)
	fn5(v19, 0.1)
	v19.x *= __wf_atom_d5a50cb5
	v19.y *= __wf_atom_c4f6543f
	return (mMovie:__wf_atom_df2c03b3(v19.x, v19.y))
end

local function fn7(p)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)
	local v18 = __wf_atom_421b01aa(__wf_atom_5e6e15c8, 80, 1840)
	local v19 = __wf_atom_421b01aa(__wf_atom_5e6e15c8_2, 80, 1000)
	local __wf_atom_2490589b = v7:__wf_atom_2490589b(v18, p)
	local __wf_atom_2490589b2 = v8:__wf_atom_2490589b(v19, p)
	mMovie:__wf_atom_e57658c2("Aim", 0, __wf_atom_2490589b)
	mMovie:__wf_atom_e57658c2("Aim", 1, __wf_atom_2490589b2)
	mMovie:__wf_atom_e57658c2("NoteContainer", 0, __wf_atom_2490589b)
	mMovie:__wf_atom_e57658c2("NoteContainer", 1, __wf_atom_2490589b2)
	local v20 = __wf_atom_2490589b / 1920
	local v21 = __wf_atom_2490589b2 / 1080
	local v22 = v20 * 2 - 1
	local v23 = v21 * 2 - 1
	v11:Update(p)
	local __wf_atom_9e368823 = v11:__wf_atom_9e368823()
	v2:__wf_atom_888efbe9(__wf_atom_9e368823)
	local v24 = math.pow(60 / __wf_atom_9e368823, 1) * 20
	local v25 = math.pow(60 / __wf_atom_9e368823, 1) * 20
	local v26 = v3
	local v27 = __wf_atom_d919c2d7(v26, Rotation(0, v23 * v25, 0))
	local v28 = __wf_atom_d919c2d7(v27, Rotation(v22 * v24, 0, 0))
	v2:__wf_atom_9b788a35(v28)
	local v29 = Vector()
	local v30 = v2:GetPosition() + fn6(__wf_atom_2490589b, __wf_atom_2490589b2) * 200

	if gRegion:Raycast(v2:GetPosition(), v30, nil, nil, v29) then
		v9 = v29
	end
end

local function fn8()
	if flag then
		return
	end

	_T.KickedOutOfMinigame = nil
	flag = true
	module.DissolveOutAndClose(mMovie)
	v2:__wf_atom_9b788a35(v3)

	if not __wf_atom_7e8ad928(v) then
		local cameraControl = v:CameraControl()
		cameraControl:__wf_atom_fd14c463(0.5)
		cameraControl:SetCameraSpot(nil, 0.5)
		cameraControl:__wf_atom_928a45c5(colorGrading)
		v:__wf_atom_3ede53b4(Symbol("OrganTookDamage"))
	end

	module.RegisterHideHud(false)
	gRegion:__wf_atom_8ad59546().postProcess:__wf_atom_351eef0b(defaultProcessMaterial)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	__wf_atom_8ad59546.postProcess.radialBlurStrength = 0
	_T.OrganMinigameStarted = false
	module4.SetWeatherCycleEnabled(true)
end

function OnDamaged(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.DamagedOnOrgan = true
	module3.PlayGlobalTransmission(
		Resource("/SF/Sounds/Dialog/Encounters/MedisGyon/PolluterTowerTransmissionSet"),
		Symbol("MedisLaugh"),
		false
	)
end

function Update()
	local damagedOnOrgan

	if __wf_atom_7e8ad928(v) then
		damagedOnOrgan = true
	else
		local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v17, 0)
		damagedOnOrgan = v:__wf_atom_e919fb8e().DamagedOnOrgan or __wf_atom_d163c8e5 == 1
	end

	local v18 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v18)

	if damagedOnOrgan then
		fn8()
	end

	if flag then
		return
	end

	fn7(v18)
	fn4(v18)
	v15:Update(v18)
	v16 = math.max(0, v16 - v18)
	v2:__wf_atom_74d17eae(1, v16 * 2)
end

function TowerExplosion(object)
	Sleep(1)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.checkForCover = false
	radialDamageData.hostAuthoritative = true
	radialDamageData.radius = 8
	radialDamageData.baseAmount = 50
	radialDamageData.instantKill = true
	radialDamageData:__wf_atom_7498285f(0, 1)
	radialDamageData:__wf_atom_d6f4d914(19, true)
	radialDamageData:__wf_atom_d6f4d914(31, true)
	radialDamageData:__wf_atom_98d98d81(object:__wf_atom_d0069154())
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_34a8a27a(object)
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	v16 = 1.5
	local nearestTagged = gRegion:FindNearestTagged(Symbol("OdeTowerElectricRod"), object:__wf_atom_d0069154())
	local v18 = __wf_atom_fa8d0177(nearestTagged:__wf_atom_a2a18137(), object:__wf_atom_d0069154())
	gRegion:CreateEntity(burstFxType, object:__wf_atom_d0069154(), v18, nil, nil, 1)
	object:Attach(deathFXSpawner, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object, 1)
end

function PlayBurstSound(object)
	Sleep(1)
	local movie = __wf_atom_8e4fda44:FindMovie(WeakResource("/SF/Interface/Minigames/Organ.swf"))
	local v18 = not __wf_atom_7e8ad928(movie) and movie:__wf_atom_7d4910e4() and true or false
	object:PlaySound(burstSound, false, 1, false, nil, v18 and 1 or 0)
end

local function fn9(p) -- 2 equivalent calls inferred from this helper
	gRegion:CreateEntity(targetFxType, p, __wf_atom_80368bb1, nil, nil, 1):__wf_atom_8a035cd5(
		Symbol("TowerExplosion"),
		false
	)
end

local function fn10(p, p2)
	if __wf_atom_7e8ad928(v) or not p2 or v14 > 0 or #v12 == 0 then
		return
	end

	if v12[1] == p then
		v:PlaySound(noteSounds[p], false, 0, false)
		local nearestTagged = gRegion:FindNearestTagged(Symbol("OdeTowerElectricRod"), v9)
		local position = nearestTagged:GetPosition()
		local __wf_atom_dc309f8a = nearestTagged:__wf_atom_dc309f8a()
		gRegion:CreateEntity(chargeFxType, position, __wf_atom_dc309f8a, nil, nil, 1)
		fn("NoteContainer.Note" .. p, nil, true, 70)
		mMovie:__wf_atom_2dedec1a("NoteContainer.Note" .. p, 13, true)
		mMovie:__wf_atom_e57658c2("NoteContainer.Note" .. p .. ".Perfect", 12, 0)
		mMovie:__wf_atom_e57658c2("NoteContainer.Note" .. p .. ".Correct", 12, 0)
		mMovie:__wf_atom_e57658c2("NoteContainer.Note" .. p .. ".Glow", 11, 16728128)
		table.remove(v12, 1)

		if #v12 == 0 then
			fn3()
			v14 = 1
			v:PlaySound(firingSound, false, 0, false)

			if gRegion:IsMaster() then
				fn9(v9) -- inferred equivalent call
			elseif not __wf_atom_7e8ad928(v6) then
				v6:__wf_atom_ba1c1bc8(v9, p)
			end
		end
	else
		v:PlaySound(wrongNoteSound, false, 0, false)

		for i = 1, 5 do
			mMovie:__wf_atom_e57658c2("NoteContainer.Note" .. i, 12, 0)
		end

		v12 = {}
		v14 = 1
		v16 = 1
	end
end

function PlayNoteRMI(p, _)
	fn9(p) -- inferred equivalent call
end

function onKeyDown_SHAWZIN_EXIT()
	fn8()
	return true
end

function onKeyDown_SHAWZIN_NOTE_1()
	fn10(1, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_1()
	fn10(1, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_2()
	fn10(2, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_2()
	fn10(2, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_3()
	fn10(3, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_3()
	fn10(3, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_4()
	fn10(4, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_4()
	fn10(4, false)
	return true
end

function onKeyDown_SHAWZIN_NOTE_5()
	fn10(5, true)
	return true
end

function onKeyUp_SHAWZIN_NOTE_5()
	fn10(5, false)
	return true
end

function onKeyDown_MENU_RIGHT_CLICK()
	v10 = true
	v11:__wf_atom_09294a87(30)
end

function onKeyUp_MENU_RIGHT_CLICK()
	v10 = false
	v11:__wf_atom_09294a87(60)
end

function onKeyDown_MENU_RTRIGGER1()
	v10 = true
	v11:__wf_atom_09294a87(30)
end

function onKeyUp_MENU_RTRIGGER1()
	v10 = false
	v11:__wf_atom_09294a87(60)
end