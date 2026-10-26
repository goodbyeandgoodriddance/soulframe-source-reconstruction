local module = require("SF.Interface.SFUtilities")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = Symbol("CircadeCodeDoor")
local v2 = Symbol("CircadeCode")
local v3 = Type("/SF/Types/Quests/LocationLoreQuests/CryptCircadeTombProgression/QuestAssets/CryptCircadeTombPuzzleCompletionKey")

local function fn(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v4 in ipairs(__wf_atom_ef7900cf) do
		if not v4:HasItem(object:__wf_atom_e14d8a8c()) then
			v4:GiveItem(object, false)
		end
	end
end

local function fn2(object) -- 3 equivalent calls inferred from this helper
	if not __wf_atom_7e8ad928(object) then
		object:FirePort("Open")
	end
end

function OnGoalUnlock()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v)
	module2.TaggedFirePorts(Symbol("CommunityPuzzleUnlocked"), "Enable")
	fn2(__wf_atom_0a6a5887) -- inferred equivalent call
	fn(v3)
end

function CheckCode()
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local v4 = ""

	for i = 1, 10 do
		v4 ..= tostring(_T.mCircadeCode[i])
	end

	if __wf_atom_ef9aeb11(v4) == 3712507904 then
		OnGoalUnlock()
	end
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_7b01f9ce)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	if __wf_atom_7e8ad928(_T.cryptPuzzleHit) or __wf_atom_7e8ad928(_T.mCircadeCode) then
		_T.mCircadeCode = {}
		_T.cryptPuzzleHit = {}

		for i = 0, 9 do
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CryptPuzzle" .. i))

			if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				continue
			end

			_T.cryptPuzzleHit[__wf_atom_0a6a5887:GetName()] = i
			_T.mCircadeCode[i + 1] = 0
		end

		if __wf_atom_7e8ad928(_T.cryptPuzzleHit) or #_T.cryptPuzzleHit ~= 10 then
			return
		end
	end

	local hitTimer = Time()
	local __wf_atom_e919fb8e = __wf_atom_bb3e7833:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.hitTimer) and hitTimer < __wf_atom_e919fb8e.hitTimer + 2 then
		return
	end

	__wf_atom_e919fb8e.hitTimer = hitTimer

	if not __wf_atom_7e8ad928(runeHitSound) then
		__wf_atom_bb3e7833:PlaySound(runeHitSound, false)
	end

	if not __wf_atom_7e8ad928(runeHitEffect) then
		gRegion:CreateEntity(runeHitEffect, __wf_atom_bb3e7833:GetPosition(), __wf_atom_80368bb1, nil, nil, 1)
	end

	if not __wf_atom_7e8ad928(runeHitRoomShakeSound) then
		__wf_atom_bb3e7833:PlaySound(runeHitRoomShakeSound, false)
	end

	local v4 = _T.cryptPuzzleHit[__wf_atom_bb3e7833:GetName()]
	table.remove(_T.mCircadeCode, 1)
	table.insert(_T.mCircadeCode, v4)
	CheckCode()
	Sleep(1)
	object:SetHealth(object:__wf_atom_95174740())
end

function Main()
	_T.mCircadeCode = {}
	_T.cryptPuzzleHit = {}

	if __wf_atom_7e8ad928((__wf_atom_a0f6588f:__wf_atom_18a5d83b(0))) or not gGameData then
		return
	end

	local playerAvatar = gRegion:GetPlayerAvatar(0)

	while __wf_atom_7e8ad928(playerAvatar) do
		Sleep(0)
		playerAvatar = gRegion:GetPlayerAvatar(0)
	end

	if gRegion:IsMaster() then
		local personalGoalProgress = gGameData:GetPersonalGoalProgress()

		if playerAvatar:HasItem(v3:__wf_atom_e14d8a8c()) then
			fn2(gRegion:__wf_atom_0a6a5887(v)) -- inferred equivalent call
			return
		elseif not __wf_atom_7e8ad928(personalGoalProgress) then
			for i = 1, #personalGoalProgress do
				local v4 = personalGoalProgress[i]

				if not (v4.mTag == v2 and v4.mCount > 0) then
					continue
				end

				fn2(gRegion:__wf_atom_0a6a5887(v)) -- inferred equivalent call
				playerAvatar:GiveItem(v3, false)
				return
			end
		end
	end

	for i = 0, 9 do
		_T.mCircadeCode[i + 1] = 0
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("CryptPuzzle" .. i))
		_T.cryptPuzzleHit[__wf_atom_0a6a5887:GetName()] = i
	end

	local playerEventId = module.GetPlayerEventId(playerAvatar)
	local __wf_atom_3d96ddcd = gRegion:__wf_atom_0a6a5887(Symbol("CryptPuzzle" .. tostring(playerEventId))):__wf_atom_3d96ddcd()

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		if module2.IsSoulModeActive(playerAvatar) then
			__wf_atom_3d96ddcd:SetVisibility(true)
		else
			__wf_atom_3d96ddcd:SetVisibility(false)
		end

		Sleep(0)

		while __wf_atom_7e8ad928(playerAvatar) do
			Sleep(0)
			playerAvatar = gRegion:GetPlayerAvatar(0)
		end
	end
end