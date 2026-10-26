module(..., package.seeall)
local v = WeakResource("/Lotus/Types/Keys/ApostasyQuest/ApostasyKeyChain")
local module = require("Lotus.Interface.UIStyleUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.LotusUtilities")

local function fn(object, p)
	if not gClient then
		return true
	end

	local v2 = p == nil or p
	_T.CheckQuestCompletionCache = _T.CheckQuestCompletionCache or {}
	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()
	local v3 = _T.CheckQuestCompletionCache[__wf_atom_5b41f63b]

	if v3 ~= nil then
		return v3
	end

	local mCompleted = false

	while __wf_atom_7e8ad928(gGameData) do
		if not v2 then
			return false
		end

		Sleep(0)
	end

	local inventory = gGameData:GetInventory()

	while __wf_atom_7e8ad928(inventory) do
		if not v2 then
			return false
		end

		Sleep(0)
		inventory = gGameData:GetInventory()
	end

	local __wf_atom_fe84572e = inventory:__wf_atom_fe84572e()

	for i = 1, #__wf_atom_fe84572e do
		local v4 = __wf_atom_fe84572e[i]

		if v4.mItemType ~= object then
			continue
		end

		mCompleted = v4.mCompleted
		break
	end

	_T.CheckQuestCompletionCache[__wf_atom_5b41f63b] = mCompleted
	return mCompleted
end

function CheckQuestCompletion(p, p2)
	return (fn(p, p2))
end

function InvalidateQuestCompletionCache(value)
	if not _T.CheckQuestCompletionCache then
		return
	end

	if value == nil then
		_T.CheckQuestCompletionCache = {}
	elseif type(value) == "string" then
		_T.CheckQuestCompletionCache[value] = nil
	else
		_T.CheckQuestCompletionCache[value:__wf_atom_5b41f63b()] = nil
	end
end

function HasCompletedApostasyMission()
	return (fn(v, false))
end

function PlayCinematic(p, p2, p3, p4, value, value2)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local v2 = value or 0
	local v3 = value2 or 0
	_T.StoryLib_PlayingCin = true
	local currentBackgroundInfo = module.GetCurrentBackgroundInfo()

	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	_T.QuestStartCinPlaying = true
	local movie = __wf_atom_8e4fda44:FindMovie(module2.GetChatMovie())
	local v4 = not __wf_atom_7e8ad928(movie) and movie:IsVisible()
	local v5 = {
		WeakResource("/Lotus/Interface/ChatRedux.swf"),
		WeakResource("/Lotus/Interface/Notifications.swf"),
		WeakResource("/Lotus/Interface/GenericNotification.swf"),
		WeakResource("/Lotus/Interface/ThemedSquadOverlay.swf")
	}

	for _, v6 in ipairs(v5) do
		local movie2 = __wf_atom_8e4fda44:FindMovie(v6)

		if not __wf_atom_7e8ad928(movie2) then
			movie2:SetVisible(false)
		end
	end

	if _T.StoryLib_MoviesToAlpha ~= nil then
		for _, v6 in ipairs(_T.StoryLib_MoviesToAlpha) do
			local movie2 = __wf_atom_8e4fda44:FindMovie(v6)

			if not __wf_atom_7e8ad928(movie2) then
				movie2:__wf_atom_e57658c2("_root", 12, 0)
			end
		end
	end

	__wf_atom_8e4fda44:__wf_atom_06b56505(0)

	if not (p4 or __wf_atom_7e8ad928(_T.DisableUIInput)) then
		_T.DisableUIInput()
	end

	if not __wf_atom_7e8ad928(p2) then
		gRegion:__wf_atom_c4f78a8f():__wf_atom_aeb02c14(p2)
	end

	_T.BlockAmbientTransmissions = true
	local module4 = require("Lotus.Interface.Libs.DioramaLoader")
	local dioramaLoader = module4.CreateDioramaLoader(_T.BackgroundMovie)
	dioramaLoader:LoadDiorama(p)

	if dioramaLoader:IsLoading() then
		if v2 ~= 0 then
			dioramaLoader:SetFadeParams(v2, 0, v3)
			gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(v2)
		end

		if p3 and not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
		end

		while not dioramaLoader:LoadingComplete() do
			Sleep(0)
		end

		if p3 and not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		end

		dioramaLoader:FinishLoad()

		if not _T.StoryLib_SkipClearFade then
			gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(0)
		end

		local __wf_atom_c3b255b8 = __wf_atom_392793db:__wf_atom_c3b255b8()

		while
			not __wf_atom_7e8ad928(__wf_atom_c3b255b8)
			and __wf_atom_c3b255b8:__wf_atom_7d4910e4()
			and _T.QuestStartCinPlaying
			or _T.StoryLib_HoldBackgroundRegion
		do
			Sleep(0)

			if not __wf_atom_7e8ad928(movie) then
				movie:SetVisible(false)
			end

			if not _T.StoryLib_BlockTransmissions or __wf_atom_7e8ad928(_T.curTransmission) then
				continue
			end

			module3.ClearTransmissionQueue()
			module3.InterruptTransmission()
		end

		__wf_atom_8e4fda44:__wf_atom_62a19abc()
	end

	if not _T.StoryLib_SkipFadeOnExit then
		gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(0)
	end

	__wf_atom_8e4fda44:__wf_atom_06b56505(1)

	for _, v6 in ipairs(v5) do
		local movie2 = __wf_atom_8e4fda44:FindMovie(v6)

		if not __wf_atom_7e8ad928(movie2) then
			movie2:SetVisible(true)
		end
	end

	if not __wf_atom_7e8ad928(movie) then
		movie:SetVisible(v4)
	end

	if _T.StoryLib_MoviesToAlpha ~= nil then
		for _, v6 in ipairs(_T.StoryLib_MoviesToAlpha) do
			local movie2 = __wf_atom_8e4fda44:FindMovie(v6)

			if not __wf_atom_7e8ad928(movie2) then
				movie2:__wf_atom_e57658c2("_root", 12, 100)
			end
		end

		_T.StoryLib_MoviesToAlpha = nil
	end

	if not __wf_atom_7e8ad928(p2) then
		gRegion:__wf_atom_c4f78a8f():__wf_atom_cf966a74(p2)
	end

	if currentBackgroundInfo.Visible and not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground(
			0,
			currentBackgroundInfo.HighlightOffset,
			currentBackgroundInfo.HighlightOn,
			currentBackgroundInfo.VisRangeInfo
		)
	end

	_T.StoryLib_BlockTransmissions = nil
	_T.StoryLib_PlayingCin = false
end