local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Souls.Powers.EntitySoulModeScans")
local module3 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local v = WeakResource("/SF/Types/Game/Ancestors/Orlick/OrlickAncestor")
local v2 = nil

local function fn(instance) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_6c243c5e) then
		return false
	end

	return instance:__wf_atom_4573db05()
end

function EMO_START(object)
	if not object:__wf_atom_8efce136() or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local v3 = object:__wf_atom_0251b5eb(2, 30, 1, true, true, true, true) or {}

	for i = 1, #v3 do
		if v3[i]:IsKilled() or not fn(v3[i]) then -- inferred equivalent call
			continue
		end

		local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
		secondaryScriptArgs:__wf_atom_a17e41c6(v3[i])
		__wf_atom_e55d02aa:ActivateSecondaryScript(
			WeakResource("/SF/Souls/Powers/SoulStealAbility"),
			Symbol("AnimoteMusicGame"),
			secondaryScriptArgs
		)
		return
	end

	object:PlaySound(castSound, false, 0, false)
end

function EMO_LOOP(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if object:__wf_atom_8efce136() then
		while not __wf_atom_7e8ad928(v2) and object:__wf_atom_0473b7a9() do
			Sleep(0)
		end

		object:__wf_atom_7ab15c94(nil)
	end
end

function EMO_END(p, _, p2)
	if not __wf_atom_7e8ad928(v2) then
		v2:Execute("EndMusicGame", (tostring(p2)))
	end

	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(p, mixEffect, mixingGroupIgnored)
	end
end

function WaitForEnd(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_1cfa7bd2 = __wf_atom_3d96ddcd:__wf_atom_1cfa7bd2()

	while
		not __wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		and __wf_atom_3d96ddcd:__wf_atom_1cfa7bd2() == __wf_atom_1cfa7bd2
	do
		Sleep(0)
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

function AnimoteMusicGame(object, _, moteAnimal)
	if __wf_atom_7e8ad928(moteAnimal) or not moteAnimal:IsA(__wf_atom_6c243c5e) or module.IsStreamingLevel() then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	local ancestorUpgradeRankValueForTag = module3.GetAncestorUpgradeRankValueForTag(
		v,
		Symbol("AnimalCharm"),
		Symbol("AnimalCharmChanceToSkip")
	)
	local v3 = ancestorUpgradeRankValueForTag > 0 and Random(0, 100) <= ancestorUpgradeRankValueForTag
	__wf_atom_e919fb8e.MoteAnimal = moteAnimal
	__wf_atom_6009c8ed:MotionControl():__wf_atom_3a1d0c16(__wf_atom_6009c8ed:__wf_atom_4e50d390())
	__wf_atom_6009c8ed:__wf_atom_0650fed7(instrumentDecoType)
	local v4 = __wf_atom_6009c8ed:Attach(
		instrumentDecoType,
		Symbol("GAME_L1_WEAPON1"),
		__wf_atom_28d5d4aa,
		Rotation(0, 90, 0),
		__wf_atom_6009c8ed
	)

	if not __wf_atom_7e8ad928(v4) then
		v4:__wf_atom_8a035cd5(Symbol("WaitForEnd"), false)
	end

	local __wf_atom_e919fb8e2 = moteAnimal:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e2.WaitforSong = true
	__wf_atom_e919fb8e2.MusicResponse = true
	moteAnimal:__wf_atom_e67de6fc(true)
	local __wf_atom_8efce136 = __wf_atom_6009c8ed:__wf_atom_8efce136()

	if __wf_atom_8efce136 and __wf_atom_7e8ad928(v2) and not __wf_atom_7e8ad928(musicMovie) then
		v2 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(musicMovie)
	end

	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(__wf_atom_6009c8ed, mixEffect, mixingGroupIgnored)
	end

	while not (__wf_atom_6009c8ed:__wf_atom_0473b7a9() or module.IsStreamingLevel() or v3) do
		Sleep(0)
	end

	while
		not __wf_atom_7e8ad928(__wf_atom_6009c8ed)
		and __wf_atom_6009c8ed:__wf_atom_0473b7a9()
		and not module.IsStreamingLevel()
	do
		if v3 then
			local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
			musicResultsRMIArgs.mIsPlaying = false
			musicResultsRMIArgs.mSuccess = true
			musicResultsRMIArgs.mPerfect = true
			__wf_atom_6009c8ed:__wf_atom_0a2fdbe5(musicResultsRMIArgs)

			if __wf_atom_7e8ad928(v2) then
				break
			end

			v2:Execute("SkipGame", "")
			v2:Execute("EndMusicGame", "true")
			break
		elseif __wf_atom_8efce136 and __wf_atom_7e8ad928(v2) then
			local musicResultsRMIArgs = SF.MusicResultsRMIArgs()
			musicResultsRMIArgs.mIsPlaying = false
			musicResultsRMIArgs.mSuccess = false
			__wf_atom_6009c8ed:__wf_atom_0a2fdbe5(musicResultsRMIArgs)
			break
		else
			Sleep(0)
		end
	end

	if module.IsStreamingLevel() and not __wf_atom_7e8ad928(v2) then
		v2:Execute("InterruptGame", "")
	end

	local v5

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		v5 = SF.MusicResultsRMIArgs()
	else
		v5 = __wf_atom_6009c8ed:__wf_atom_8161e6ba()
	end

	local _mSuccess = v5.mSuccess

	if v5.mSuccess or v3 then
		__wf_atom_e919fb8e2.Avatar = __wf_atom_6009c8ed
		__wf_atom_e919fb8e2.musicCalm = true
		__wf_atom_e919fb8e2.allPerfect = v5.mPerfect

		if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
			__wf_atom_539492fe:__wf_atom_8b4524e6(__wf_atom_6009c8ed:__wf_atom_a96eb2aa(), Symbol("ANIMOTE_SUCCESS"))

			if v5.mPerfect then
				__wf_atom_539492fe:__wf_atom_8b4524e6(
					__wf_atom_6009c8ed:__wf_atom_a96eb2aa(),
					Symbol("ANIMOTE_PERFECT")
				)
			end
		end

		if module3.GetAncestorUpgradeRankValueForTag(v, Symbol("AnimalScan"), Symbol("ENABLE")) > 0 then
			module2.GiveAnimalScan(moteAnimal, __wf_atom_6009c8ed, isChallengeScan, challengeTag)
		end
	elseif not v5.mSuccess then
		__wf_atom_e919fb8e2.musicCalm = false
		__wf_atom_e919fb8e2.MusicResponse = false
		__wf_atom_e919fb8e2.RUNAWAY = true
		__wf_atom_539492fe:__wf_atom_8b4524e6(__wf_atom_6009c8ed:__wf_atom_a96eb2aa(), Symbol("ANIMOTE_FAIL"))
	end

	__wf_atom_7e8ad928(v2)

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(__wf_atom_6009c8ed, mixEffect, mixingGroupIgnored)
	end

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		__wf_atom_6009c8ed:__wf_atom_92aa9d91():__wf_atom_8595f516()
	end

	__wf_atom_e919fb8e.MoteAnimal = nil
end