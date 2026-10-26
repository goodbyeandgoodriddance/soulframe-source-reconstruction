local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")
local module3 = require("Lotus.Scripts.Libs.AudioLib")
local module4 = require("SF.Scripts.Libs.QuestLib")
local module5 = require("SF.Scripts.Libs.ModifySkyLib")
local v = 1
local v2 = WeakResource("/SF/Types/Game/SFInstigatorCinematic")
local v3 = Symbol("WSP13_BOSSFIGHTTRIGGER")
local activeFightController = nil
local v4 = nil
Symbol("WaitToFight")

function OnMobsDamaged(object, _, _)
	object:__wf_atom_9d766292()

	if object:IsKilled() then
		_T.MobsKilled -= 1
	end
end

function MonitorMobs(object)
	while _T.MobsKilled > 0 do
		Sleep(0)
	end

	object:SetBlackboardBool(Symbol("LightningHang"), false)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	object:__wf_atom_30e3d82b():StormTarget(__wf_atom_c4f78a8f)
end

local function fn()
	for _, mobAgent in pairs(v4.MobAgents) do
		if not __wf_atom_7e8ad928(mobAgent.Avatar) then
			gRegion:__wf_atom_dd1e4d10(mobAgent.Avatar)
		end
	end

	_T.MobsKilled = 0
end

local function fn2(p, object)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v5 in ipairs(__wf_atom_ef7900cf) do
		if v5:__wf_atom_4417a5d4() then
			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_a3d2b66b(v5, Symbol("Envoy"))
			end
		else
			v5:__wf_atom_a7ee9662(p, true)
		end
	end
end

function CameraFoVIn(object)
	local cameraControl = object:CameraControl()

	if __wf_atom_7e8ad928(cameraControl) then
		return
	end

	local total = 0

	while total <= 1 and not __wf_atom_7e8ad928(cameraControl) do
		cameraControl:__wf_atom_25382a0d((__wf_atom_104bfe98(1, cameraFOV, __wf_atom_24a82b69(total))))
		total += __wf_atom_084b3e93() * speedIn
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(cameraControl) then
		cameraControl:__wf_atom_25382a0d(cameraFOV)
	end
end

function CameraFoVOut(object)
	local cameraControl = object:CameraControl()

	if __wf_atom_7e8ad928(cameraControl) then
		return
	end

	local total = 0

	while total <= 1 and not __wf_atom_7e8ad928(cameraControl) do
		cameraControl:__wf_atom_25382a0d((__wf_atom_104bfe98(cameraFOV, 1, __wf_atom_24a82b69(total))))
		total += __wf_atom_084b3e93() * speedOut
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(cameraControl) then
		cameraControl:__wf_atom_25382a0d(1)
	end
end

function FightSetUpScript(_)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v4 = activeFightController:__wf_atom_e919fb8e()
	end

	v4.UpdatePlayerAvatars()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("PostBattle"))
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("PreBattle"))
	local mergeTables = module.MergeTables(__wf_atom_2226b35c2, __wf_atom_2226b35c)
	v4.CastleDecorations = mergeTables
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol(cinematicTag))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:PrefetchStreaming()
	end

	v4.SongEnded = false
	v4.MusicSequencer = gRegion:__wf_atom_0a6a5887(Symbol("WarsongMotherBayorMusic"))
end

function FightIntro(object)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v4 = activeFightController:__wf_atom_e919fb8e()
	end

	v4.UpdatePlayerAvatars()

	for _, playerAvatar in v4.PlayerAvatars do
		if useForceWalk then
			playerAvatar:MotionControl():__wf_atom_99fc7a82(true)
		end

		if attenuateFov then
			playerAvatar:__wf_atom_8a035cd5(Symbol("CameraFoVIn"), false)
		end
	end

	module3.EnableTaggedSequencers(Symbol("WarsongMotherBayorMusic"), true)
	module3.EnableTaggedSoundSysVolumes(Symbol("WarsongMndHorseRideMusic"), false)
	module2.PlayGlobalTransmission(questTransmissionSet, transmissionTag, false)

	while __wf_atom_7e8ad928(_T.curTransmission) do
		Sleep(0)
	end

	local v5 = _T.curTransmission:__wf_atom_1e34340d() - _T.curTransmission:__wf_atom_7456d5f7() + _T.curTransmission:__wf_atom_90737e8c()
	Sleep(v5)

	if useForceWalk then
		for _, playerAvatar in v4.PlayerAvatars do
			playerAvatar:MotionControl():__wf_atom_99fc7a82(false)
		end
	end

	for _, v6 in fightCinematicTags do
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v6)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:__wf_atom_7d4910e4() then
			module.WaitForCinematicToFinish(__wf_atom_0a6a5887)
		else
			if __wf_atom_0a6a5887:IsA(v2) then
				__wf_atom_0a6a5887:SetInstigatorAvatar(v4.PlayerAvatars[1])
			end

			__wf_atom_0a6a5887:FirePort("StartPlaying")

			while
				not __wf_atom_7e8ad928(__wf_atom_0a6a5887)
				and __wf_atom_0a6a5887:__wf_atom_7d4910e4()
				and not __wf_atom_0a6a5887:__wf_atom_e9546dc6()
			do
				Sleep(0)

				if __wf_atom_7e8ad928(object) or object:GetState() ~= 1 then
					continue
				end

				__wf_atom_0a6a5887:Skip()
			end

			if __wf_atom_0a6a5887:__wf_atom_e9546dc6() and not __wf_atom_7e8ad928(object) then
				if gRegion:IsMaster() then
					object:SetState(1)
				else
					object:__wf_atom_c063982d(1)
				end
			end

			fn2(true, __wf_atom_0a6a5887)
		end
	end

	for _, playerAvatar in v4.PlayerAvatars do
		if useForceWalk then
			playerAvatar:MotionControl():__wf_atom_99fc7a82(false)
		end

		if attenuateFov then
			playerAvatar:CameraControl():__wf_atom_25382a0d(1, true)
		end
	end

	v4.UpdatePlayerAvatars()
	v4.IntroFinished = true
end

function FightLoop(_)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v4 = activeFightController:__wf_atom_e919fb8e()
	end

	local bossAvatar = v4.BossAvatar
	local _ = v4.PlayerAvatars[1]
	bossAvatar:GetMaxHealth()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(phase2CineTag)
	bossAvatar:SetBlackboardBool(Symbol("MeleeOnly"), false)
	bossAvatar:SetBlackboardBool(Symbol("OrderThrall"), true)
	v4.MusicInstance = v4.MusicSequencer:__wf_atom_cf51ee01()
	v4.SetCustomLockOnSettings(true)
	v = 1
	local v5 = 0

	while not __wf_atom_7e8ad928(bossAvatar) and v4.FightRestarting == false do
		if gRegion:IsMaster() then
			if not __wf_atom_7e8ad928(v4.MusicInstance) then
				v5 = v4.MusicInstance:__wf_atom_bed2c66d()
			end

			if v == 1 then
				if phase1meleeOnlyTimeStamp <= v5 and not bossAvatar:__wf_atom_52077f7a(Symbol("MeleeOnly")) then
					bossAvatar:SetBlackboardBool(Symbol("MeleeOnly"), true)
				elseif phase1EndTimeStamp <= v5 then
					fn()

					if startRelative then
						__wf_atom_0a6a5887:StartRelative(
							animNameToStarRelativeToo,
							bossAvatar:GetPosition(),
							__wf_atom_80368bb1
						)
					else
						__wf_atom_0a6a5887:FirePort("StartPlaying")
					end

					while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
						Sleep(0)
					end

					v4.UpdatePlayerAvatars()
					v4.SetCustomLockOnSettings(true)
					bossAvatar:SetBlackboardBool(Symbol("MeleeOnly"), false)
					v += 1
				end
			elseif v == 2 then
				if phase2EndTimeStamp <= v5 then
					bossAvatar:SetBlackboardBool(Symbol("SongEnd"), true)
					v += 1
				end
			elseif v == 3 and v4.FinisherCompleted == true then
				bossAvatar:SetBlackboardBool(Symbol("SongEnd"), false)
				v4.FightloopCompleted = true
				break
			end
		end

		Sleep(0)
	end
end

function MakeSunRiseAsMusicPlays() end

function OnBayorBattleEndCineStopped()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WSP13-BayorFightAnimalRush"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("StartPlaying")
	end
end

function PostFightSequence(_)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v4 = activeFightController:__wf_atom_e919fb8e()
	end

	v4.UpdatePlayerAvatars()

	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(cinematicTag)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		if not __wf_atom_0a6a5887:__wf_atom_7d4910e4() then
			__wf_atom_0a6a5887:FirePort("StartPlaying")
		end

		while __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	v4.PostFightSequence = true
end

function StreamInCastle()
	if not module.HasStreamedLevel("/SF/Levels/Procs/OdeSkyCastle/OSCxTC2026xOdeSkyCastle.level") then
		if not __wf_atom_7e8ad928(skyCastleLevel) then
			module.StreamInLevelRegion(skyCastleLevel, nil, Vector(0, -2000, 0), 400, false, nil)
		end

		while not module.HasStreamedLevel("/SF/Levels/Procs/OdeSkyCastle/OSCxTC2026xOdeSkyCastle.level") do
			Sleep(0.5)
		end
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P13-Scene19"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:PrefetchStreaming()
	end
end

function OnMusicCinStopped(_)
	gRegion:__wf_atom_0a6a5887(Symbol("WSP13-PushTheButton")):FirePort("StartPlaying")
end

function FightEnd(object)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v4 = activeFightController:__wf_atom_e919fb8e()
	end

	module.Fade(false)

	if not gRegion:IsMaster() then
		return
	end

	v4.UpdatePlayerAvatars()
	v4.SetCustomLockOnSettings(false)
	object:__wf_atom_8a035cd5(Symbol("StreamInCastle"), false)
	module.DespawnPlayerSummons()
	local __wf_atom_c3b255b8 = gRegion:__wf_atom_c3b255b8()
	__wf_atom_55142dd4(__wf_atom_c3b255b8, "OnStopped", "OnMusicCinStopped")

	while not __wf_atom_7e8ad928(__wf_atom_c3b255b8) and __wf_atom_c3b255b8:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	local __wf_atom_c3b255b8_2 = gRegion:__wf_atom_c3b255b8()

	while not __wf_atom_7e8ad928(__wf_atom_c3b255b8_2) and __wf_atom_c3b255b8_2:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v5 in ipairs(__wf_atom_ef7900cf) do
		if not __wf_atom_7e8ad928(v5) then
			v5:__wf_atom_e25a34ac(true)
		end
	end

	module.Fade(true, 0)
	Sleep(2)
	module5.SwapSkyTo(Symbol("OdeSkyCastleSky"))
	module5.SetTimeOfDay(12)
	module5.ClearWeather()
	module4.TeleportPlayers(Symbol("WSP14-SkyCastleTP"), false)
	_T.Tennocon2026EndcardPart = 1
	__wf_atom_8e4fda44:__wf_atom_5d67a2c5(teaserEndcardMovie)

	while __wf_atom_8e4fda44:__wf_atom_6b69b901(teaserEndcardMovie) do
		Sleep(0)
	end

	_T.Tennocon2026EndcardPart = nil
	module.Fade(false, 1)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P13-Scene19"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("StartPlaying")

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end

		module5.SwapSkyTo(Symbol("DefaultMainSky"))
		module5.SetTimeOfDay(10)
		module5.ClearWeather()
		module4.TeleportPlayers(Symbol("WSP14-BackToEarth"), false)
		module.StreamOutLevelRegion(400)
	end

	module.Fade(true, 0)
	_T.Tennocon2026EndcardPart = 2
	__wf_atom_8e4fda44:__wf_atom_5d67a2c5(teaserEndcardMovie)

	while __wf_atom_8e4fda44:__wf_atom_6b69b901(teaserEndcardMovie) do
		Sleep(0)
	end

	_T.Tennocon2026EndcardPart = nil
	module.Fade(false, 1)
	_T.BayorFightCompleted = true
	v4.BossFightCompleted = true
end

function StartFinisherOnPickup(object, _)
	local bossAvatar = nil
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or not __wf_atom_50a7d83e:IsA(envoyAvatarType) then
		return
	end

	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v4 = activeFightController:__wf_atom_e919fb8e()
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		bossAvatar = v4.BossAvatar
	end

	if __wf_atom_7e8ad928(bossAvatar) then
		bossAvatar = gRegion:__wf_atom_0a6a5887(Symbol("TempestBayor"))
	end

	local __wf_atom_d2b2176d = bossAvatar:__wf_atom_d2b2176d()

	if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()

		if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
			SF.__wf_atom_4659f336(__wf_atom_9fb9a1d6, false, true)
		end
	end

	if gRegion:IsMaster() and not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_7e8ad928(fightEndFinisher)) then
		__wf_atom_50a7d83e:Heal(__wf_atom_50a7d83e, __wf_atom_50a7d83e:GetMaxHealth())
		__wf_atom_50a7d83e:__wf_atom_70ca09b9(fightEndFinisher, bossAvatar)
		module3.EnableTaggedSequencers(Symbol("WarsongMotherBayorMusic"), false)
	end
end

function Evaluate(object, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928((object:__wf_atom_30e3d82b())) then
		return false
	end

	if object:__wf_atom_7470861b():__wf_atom_bedb4e3f() or object2.visible and object2:__wf_atom_a3309443() then
		return true
	end

	return false
end

function Activate(object, p)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v4 = activeFightController:__wf_atom_e919fb8e()
	end

	object:__wf_atom_30e3d82b()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(postFinisherCineTag)

	if object:__wf_atom_7470861b():__wf_atom_bedb4e3f() then
		object:SetHealth(9)
	end

	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v5 in ipairs(__wf_atom_ef7900cf) do
		if __wf_atom_7e8ad928(v5) then
			continue
		end

		local __wf_atom_bb3e7833 = v5:__wf_atom_bb3e7833(__wf_atom_faccb0cf)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end

	local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(BayorBossChargeUp, false, 4, 1, true)
	local v5 = BayorBossChargeUp:__wf_atom_091354f5(endAnimEventSym) * __wf_atom_921c1a5f
	Sleep(0.1)
	local total = 0

	while object:__wf_atom_c138b19b(BayorBossChargeUp) and not (v5 <= total) do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		if not __wf_atom_7e8ad928(p) then
			__wf_atom_0a6a5887:__wf_atom_a3d2b66b(p, Symbol("Envoy"))
		end

		__wf_atom_55142dd4(__wf_atom_0a6a5887, "OnStopped", "OnBayorBattleEndCineStopped")
		__wf_atom_0a6a5887:__wf_atom_a3d2b66b(object, Symbol("TempestBayor"))
		Sleep(0)
		__wf_atom_0a6a5887:FirePort("StartPlaying")
		Sleep(5)

		if not __wf_atom_7e8ad928(__wf_atom_8e4fda44) then
			__wf_atom_8e4fda44:__wf_atom_5d67a2c5(timingActionMovie)
		end

		print("FinalFinisher Completed, Fight ending now")
		module.WaitForCinematicToFinish(__wf_atom_0a6a5887)
		v4.FinisherCompleted = true

		if not __wf_atom_7e8ad928(__wf_atom_8e4fda44) then
			local movie = __wf_atom_8e4fda44:FindMovie(timingActionMovie)

			if not __wf_atom_7e8ad928(movie) then
				movie:Execute("TransitionOut", "")
			end
		end
	end

	if gRegion:IsMaster() then
	end
end