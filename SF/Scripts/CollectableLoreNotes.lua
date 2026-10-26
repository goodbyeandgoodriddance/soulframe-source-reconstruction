local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.StatsLib")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
local v = nil
local v2 = ""
local v3 = ""
local v4 = ""

function GiveItemReward()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v5 in ipairs(__wf_atom_3c8e1a7a) do
		if not v5:IsLocal() then
			continue
		end

		local __wf_atom_50a7d83e = v5:__wf_atom_50a7d83e()

		for _, v6 in ipairs(itemRewards) do
			local v7 = Resource(v6:__wf_atom_5b41f63b())

			if __wf_atom_50a7d83e:HasItem(v7) then
				continue
			end

			if v7 == WeakResource("/SF/Types/Quests/AncestorProgression/OrlickProgression/QuestAssets/OrlicksQuillQuestItem") then
				module3.ReplicateLogEvent("ORLICK_QUEST", "AquireQuill")
			end

			if gRegion:IsMaster() then
				__wf_atom_50a7d83e:GiveItem(v7, false)
			else
				v5:__wf_atom_36b99b9d(v7, 1)
			end
		end
	end
end

function OpenNote(object, _)
	if __wf_atom_7e8ad928(object) or not object:IsLocal() then
		return
	end

	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		return
	end

	local v5 = Resource(noteLoreFragementRes)

	if __wf_atom_7e8ad928(v5) then
		return
	end

	if not __wf_atom_7e8ad928(noteTransmissionSet) then
		module4.PlayGlobalTransmission(noteTransmissionSet, transmissionSymbol, false)
	end

	local __wf_atom_22020464 = v5:__wf_atom_22020464()
	local v6

	if #__wf_atom_22020464 == 0 then
		v6 = v5:__wf_atom_3a3d2e39()
	else
		v6 = __wf_atom_22020464[loreMemeoryIndex]
	end

	if
		canAddAsCodexEntry
		and __wf_atom_a0f6588f:__wf_atom_f89aa44a()
		and gGameData
		and not __wf_atom_7e8ad928(__wf_atom_50a7d83e)
	then
		module2.GiveLoreFragmentMemory(__wf_atom_50a7d83e, v5, __wf_atom_22020464[loreMemeoryIndex])
	end

	local v7 = Localize(v6:c_str(), nil)
	v2 = ""

	if not __wf_atom_7e8ad928(customNoteBacker) then
		v2 = customNoteBacker:__wf_atom_5b41f63b()
	end

	v3 = ""

	if not __wf_atom_7e8ad928(noteOverlayImage) then
		v3 = noteOverlayImage:__wf_atom_5b41f63b()
	end

	v4 = ""

	if not __wf_atom_7e8ad928(noteCloseFX) then
		v4 = noteCloseFX:__wf_atom_5b41f63b()
	end

	if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(noteMovieRes) then
		v = __wf_atom_8e4fda44:__wf_atom_8b74c30b(noteMovieRes)
		v:__wf_atom_f62a8704("InitializeNote", {
			"",
			v7,
			"",
			tostring(hiddenText),
			tostring(hiddenTextType),
			v2,
			v3,
			v4
		})
	end

	while not __wf_atom_7e8ad928(v) do
		Sleep(0)
	end

	if #itemRewards >= 1 then
		GiveItemReward()
	end

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(questRes) then
		module.StartQuest(questRes)
	end
end

function OpenNoteLetter(object, _)
	if __wf_atom_7e8ad928(object) or not object:IsLocal() then
		return
	end

	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		return
	end

	local v5 = Resource(noteLoreFragementRes)

	if __wf_atom_7e8ad928(v5) then
		return
	end

	if markerEntitySymbol ~= nil then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(markerEntitySymbol)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			local areaMarker = module.CreateAreaMarker(__wf_atom_0a6a5887)
			module.DestroyAreaMarker(areaMarker)
		end
	end

	local __wf_atom_22020464 = v5:__wf_atom_22020464()
	local v6 = __wf_atom_22020464[loreMemeoryIndex]

	if
		canAddAsCodexEntry
		and __wf_atom_a0f6588f:__wf_atom_f89aa44a()
		and gGameData
		and not __wf_atom_7e8ad928(__wf_atom_50a7d83e)
	then
		module2.GiveLoreFragmentMemory(__wf_atom_50a7d83e, v5, __wf_atom_22020464[loreMemeoryIndex])
	end

	local v7 = Localize(v6:c_str(), nil)
	local v8 = StringSplit("+", v7)
	local v9 = v8[1] or ""
	local v10 = v8[2] or ""
	local v11 = v8[3] or ""
	v2 = ""

	if not __wf_atom_7e8ad928(customNoteBacker) then
		v2 = customNoteBacker:__wf_atom_5b41f63b()
	end

	v3 = ""

	if not __wf_atom_7e8ad928(noteOverlayImage) then
		v3 = noteOverlayImage:__wf_atom_5b41f63b()
	end

	v4 = ""

	if not __wf_atom_7e8ad928(noteCloseFX) then
		v4 = noteCloseFX:__wf_atom_5b41f63b()
	end

	if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(noteMovieRes) then
		v = __wf_atom_8e4fda44:__wf_atom_8b74c30b(noteMovieRes)
		v:__wf_atom_f62a8704("InitializeNote", {
			v9,
			v10,
			v11,
			tostring(hiddenText),
			tostring(hiddenTextType),
			v2,
			v3,
			v4
		})
	end

	while not __wf_atom_7e8ad928(v) do
		Sleep(0)
	end

	if #itemRewards <= 1 then
		GiveItemReward()
	end

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(questRes) then
		module.StartQuest(questRes)
	end
end

function OpenNoteNoLore(instance, object)
	if instance:IsA(__wf_atom_0f45538d) then
		instance = object:__wf_atom_a96eb2aa()
	end

	if __wf_atom_7e8ad928(instance) or not instance:IsLocal() then
		return
	end

	local v5 = Localize(noteText:c_str(), nil)
	local v6 = __wf_atom_7e8ad928(customNoteBacker) and "" or customNoteBacker:__wf_atom_5b41f63b()
	local v7 = __wf_atom_7e8ad928(noteOverlayImage) and "" or noteOverlayImage:__wf_atom_5b41f63b()
	v4 = ""

	if not __wf_atom_7e8ad928(noteCloseFX) then
		v4 = noteCloseFX:__wf_atom_5b41f63b()
	end

	if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(noteMovieRes) then
		v = __wf_atom_8e4fda44:__wf_atom_8b74c30b(noteMovieRes)
		v:__wf_atom_f62a8704("InitializeNote", {
			"",
			v5,
			"",
			tostring(hiddenText),
			tostring(hiddenTextType),
			v6,
			v7,
			v4
		})
	end
end

function RevealOnPlayerProgression(object)
	module2.WaitForLoginSequence()

	if not gRegion:IsMaster() then
		return
	end

	if canCheckForQuestProgression and not __wf_atom_7e8ad928(questRes) then
		if module.HasCompletedQuest(questRes) then
			return
		end

		while __wf_atom_7e8ad928(object:__wf_atom_a3d1d403()) do
			Sleep(0)
		end

		object:Disable()
	end
end