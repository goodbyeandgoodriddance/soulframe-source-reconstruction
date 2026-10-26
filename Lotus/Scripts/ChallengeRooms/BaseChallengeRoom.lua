module(..., package.seeall)
local v = Localize("/Lotus/Language/Ranks/Rank1", nil)
local v2 = Localize("/Lotus/Language/Ranks/Rank2", nil)
local v3 = Localize("/Lotus/Language/Ranks/Rank3", nil)
local v4 = Localize("/Lotus/Language/Ranks/Rank4", nil)
local v5 = Localize("/Lotus/Language/Ranks/Rank5", nil)
local v6 = Localize("/Lotus/Language/Ranks/Rank6", nil)
local v7 = Localize("/Lotus/Language/Ranks/Rank7", nil)
local v8 = Localize("/Lotus/Language/Ranks/Rank8", nil)
local v9 = Localize("/Lotus/Language/Ranks/Rank9", nil)
local v10 = Localize("/Lotus/Language/Ranks/Rank10", nil)
local v11 = Localize("/Lotus/Language/Ranks/Rank11", nil)
local v12 = Localize("/Lotus/Language/Ranks/Rank12", nil)
local v13 = Localize("/Lotus/Language/Ranks/Rank13", nil)
local v14 = {
	"1_Initiate",
	"2_SilverInitiate",
	"3_GoldInitiate",
	"4_Novice",
	"5_SilverNovice",
	"6_GoldNovice",
	"7_Disciple",
	"8_SilverDisciple",
	"9_GoldDisciple",
	"10_Seeker",
	"11_SilverSeeker",
	"12_GoldSeeker",
	"13_Hunter",
	"14_SilverHunter",
	"15_GoldHunter",
	"16_Eagle",
	"17_SilverEagle",
	"18_GoldEagle",
	"19_Tiger",
	"20_SilverTiger",
	"21_GoldTiger",
	"22_Dragon",
	"23_SilverDragon",
	"24_GoldDragon",
	"25_Sage",
	"26_SilverSage",
	"27_GoldSage",
	"28_Master",
	"29_SilverMaster",
	"30_GoldMaster"
}
local v15 = nil
local BaseChallengeRoom = {}

function BaseChallengeRoom.SetMaxAttempts(p)
	v15 = p
end

function BaseChallengeRoom.ChallengeFailed()
	gGameRules:EndGame(0, 0)
end

function BaseChallengeRoom.ChallengePassed(p, object, p2)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not (__wf_atom_7e8ad928(__wf_atom_eab484a7) or p2) then
		__wf_atom_539492fe:NotifyValue(
			__wf_atom_eab484a7,
			Symbol("PLAYER_RANK_CHALLENGE_COMPLETE"),
			_G.TrainingMissionRank
		)
	end

	if gGameRules:__wf_atom_2bea3172() then
		gGameRules:__wf_atom_3e19b058()
	end

	object:FirePort("Open")
	Sleep(3)

	if p2 then
		local movie = __wf_atom_8e4fda44:FindMovie(p)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("AutoClose", "")
		end
	else
		if _T.ShowNotification ~= nil and _G.TrainingMissionRank % 2 == 0 then
			_T.ShowNotification(Localize("/Lotus/Language/Menu/Loadout_NewSlotUnlocked", {}), "LoadoutSlot")
		end

		if not __wf_atom_7e8ad928(_G.TrainingMissionRank) and _G.TrainingMissionRank > 0 then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
			local v16 = {
				v,
				v2,
				v3,
				v4,
				v5,
				v6,
				v7,
				v8,
				v9,
				v10,
				v11,
				v12,
				v13
			}

			for i = 1, #v16 do
				if _G.TrainingMissionRank ~= i then
					continue
				end

				local v17 = {
					PLAYER_NAME = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646()
				}
				__wf_atom_18a5d83b:__wf_atom_5ca96111(
					Localize("/Lotus/Language/ActivityFeed/ActivityFeedRankPromoted", v17) .. " " .. v16[i],
					v14[i]
				)
			end
		end
	end
end

function BaseChallengeRoom.SetupEnemy(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	gRegion:CreateEntity(p, object:GetPosition(), object:__wf_atom_dc309f8a())
	object:Attach(p2, EMPTY_SYMBOL)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)

	for _, v16 in ipairs(__wf_atom_f582136d) do
		v16:Attach(p2, EMPTY_SYMBOL)
	end

	object:__wf_atom_c6a78fe5(nil)
end

function BaseChallengeRoom.PlayerRetry()
	if not (v15 - 1 > 0) then
		return false
	end

	v15 -= 1

	if v15 == 1 then
		_T.ShowImpactMessage(v15 .. " " .. Localize("/Lotus/Language/Game/AttemptLeft", {}), 2, true, nil, false)
	else
		_T.ShowImpactMessage(v15 .. " " .. Localize("/Lotus/Language/Game/AttemptsLeft", {}), 2, true, nil, false)
	end

	return true
end

function BaseChallengeRoom.AddAiTypes(object)
	local __wf_atom_a3a9bb4e = gGameRules:__wf_atom_a3a9bb4e()

	if __wf_atom_7e8ad928(__wf_atom_a3a9bb4e) then
		__wf_atom_a3a9bb4e = object:__wf_atom_0958db03()
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	for _, v16 in ipairs(__wf_atom_a3a9bb4e) do
		__wf_atom_7d789620:__wf_atom_2b33739c(v16.agent, v16.probability, v16.maxSimultaneous, v16.tier)
	end
end

return BaseChallengeRoom