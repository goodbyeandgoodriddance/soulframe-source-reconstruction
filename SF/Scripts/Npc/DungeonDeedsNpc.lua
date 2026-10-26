local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("SF.Scripts.Libs.SparrowLib")
local module5 = require("SF.Scripts.Libs.ConversationLib")
local module6 = require("SF.Interface.SFUtilities")
local v = nil
local v2 = nil
local v3 = Resource("/Lotus/Types/Input/DialogInputFilter")
local v4 = Symbol("Invulnerable")
local v5 = WeakResource("/SF/Interface/Vendor.swf")
local v6 = Symbol("DungeonDeedId")
local v7 = Symbol("DungeonDeedStatus")
local v8 = { WAITING = 0, ACCEPTED = 1, CLOSED = 2 }

local function fn(p)
	local v9 = WeakResource("/EE/Types/Npc/Encounters/DynamicRandomEncounterHint")
	local all = gRegion:FindAll(v9)

	for _, v10 in ipairs(all) do
		local __wf_atom_cc31ec3f = v10:__wf_atom_cc31ec3f()

		for _, v11 in ipairs(__wf_atom_cc31ec3f) do
			if p == v11 then
				return v10
			end
		end
	end

	return nil
end

local function fn2(p, tag)
	return {
		Text = Localize(p, false),
		Tag = tag,
		Callback = function()
			v2 = tag
		end
	}
end

local function fn3(p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local v9 = fn(p)

	while __wf_atom_7e8ad928(v9) do
		v9 = fn(p)
		Sleep(0.1)
	end

	v9:__wf_atom_7dd025d4("OnDeedStatusChanged", p)
	gGameRules:SetNetPersistentVar(v7, v9:__wf_atom_4026dfb5())
end

local function fn4(p, __wf_atom_3d96ddcd)
	if __wf_atom_7e8ad928(_T.AvailableDeedEncounters) or #_T.AvailableDeedEncounters == 0 then
		print("No available deeds!")
		return
	end

	local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v6, 0)

	if __wf_atom_7e8ad928(_T.AvailableDeedEncounters[__wf_atom_d163c8e5]) then
		print("Encounter with deed id " .. tostring(__wf_atom_d163c8e5) .. " not found!")
		return
	end

	module2.AddDungeonObjective(_T.AvailableDeedEncounters[__wf_atom_d163c8e5].encounterType, { p })
	module4.RemoveSparrowDestination(__wf_atom_3d96ddcd)
	print("Deed started")
	fn3(p)
end

function SetupDungeonDeeds()
	if gRegion:IsMaster() then
		local v9 = 0

		if gPromotedToHost then
			gGameRules:__wf_atom_d163c8e5(v6, 0)
			gGameRules:__wf_atom_d163c8e5(v7, 0)
			fn3(_T.DeedNpcEncounterTag)
		end

		if v9 == 0 then
			local v10 = __wf_atom_5784a397(1, #dungeonEncounters)
			gGameRules:SetNetPersistentVar(v6, v10)
			print("SetupDungeonDeeds: New DeedId = " .. tostring(v10))
		else
			print("SetupDungeonDeeds: Existing DeedId = " .. tostring(v9))
		end
	end

	_T.AvailableDeedEncounters = {}

	for i = 1, #dungeonEncounters do
		local v9 = {
			encounterType = dungeonEncounters[i],
			introTrTag = transmissionTagsIntro[i] or EMPTY_SYMBOL,
			acceptedTrTag = transmissionTagsAccepted[i] or EMPTY_SYMBOL,
			completedTrTag = transmissionTagsCompleted[i] or EMPTY_SYMBOL,
			deedAcceptMenuText = tostring(conversationTextIntro[i]) or "[HC] No menu text"
		}
		table.insert(_T.AvailableDeedEncounters, v9)
	end
end

function DungeonQuestGiverInteract(object, object2)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		object:Disable()
		return
	end

	local deedNpcEncounterTag = Symbol(__wf_atom_3d96ddcd:GetName())
	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_589cefdb)
	_T.AvakotTalking = true
	_T.DeedNpcEncounterTag = deedNpcEncounterTag

	if gRegion:IsMaster() then
		__wf_atom_bb3e7833:SetState(v8.WAITING)
		object:Disable()
	end

	if object2:__wf_atom_4417a5d4() then
		local __wf_atom_bb3e7833_2 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_7369b1a2)
		local __wf_atom_7470861b = object2:__wf_atom_7470861b()
		local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
		__wf_atom_7470861b:__wf_atom_9fba31e6(v4, 26, 6, 0)
		object2:__wf_atom_dd875cd8(true)
		object2:__wf_atom_aeb02c14(v3)
		__wf_atom_d2b2176d:Unequip(0, 0)
		__wf_atom_3d96ddcd:__wf_atom_d927a2a4(npcTalkIdleAnim)
		module3.CloseTransmissions()
		v = module5.CreateConversation(Localize(tostring(npcName), false), __wf_atom_bb3e7833_2)
		v:Start()
		local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(v6, 1)
		local flag = false
		local __wf_atom_d163c8e5_2 = gGameRules:__wf_atom_d163c8e5(v7, 0)
		local v9 = fn2(_T.AvailableDeedEncounters[__wf_atom_d163c8e5].deedAcceptMenuText, "AcceptedDeed")
		local v10 = fn2("/SF/Language/Vendor/Trade", "Trade")
		local v11 = fn2("/SF/Language/DungeonDeeds/DeedNotRightNow", "Close")
		local v12 = fn2("/SF/Language/DungeonDeeds/DeedGoodbye", "Close")
		v:SetChoices(nil)
		v:SetBackChoice("Close")

		if __wf_atom_d163c8e5_2 == 0 then
			module3.PlayDialogMenuTransmission(
				npcTransmissionSet,
				_T.AvailableDeedEncounters[__wf_atom_d163c8e5].introTrTag,
				object2,
				true,
				30
			)
		elseif __wf_atom_d163c8e5_2 == 4 then
			module3.PlayDialogMenuTransmission(
				npcTransmissionSet,
				_T.AvailableDeedEncounters[__wf_atom_d163c8e5].completedTrTag,
				object2,
				true,
				30
			)
		else
			module3.PlayDialogMenuTransmission(npcTransmissionSet, greetingTransmissionTag, object2, true, 30)
		end

		if __wf_atom_d163c8e5_2 == 0 then
			v:SetChoices({ v9, v10, v11 })
		else
			v:SetChoices({ v10, v12 })
		end

		while v:Update() do
			if not __wf_atom_7e8ad928(v2) then
				if v2 == "Close" then
					break
				end

				if v2 == "Trade" then
					module6.RegisterHideSubtitles(false)
					module6.DissolveOut(v.mConvoMovie)
					v:SetChoices(nil)
					v:SetSubConversation(v5, true, nil, function()
						module6.RegisterHideSubtitles(true)
						module6.DissolveIn(v.mConvoMovie)

						if __wf_atom_d163c8e5_2 == 0 and not flag then
							v:SetChoices({ v9, v10, v11 })
						else
							v:SetChoices({ v10, v12 })
						end
					end)
				elseif v2 == "AcceptedDeed" then
					v:SetChoices(nil)
					module3.PlayDialogMenuTransmission(
						npcTransmissionSet,
						_T.AvailableDeedEncounters[__wf_atom_d163c8e5].acceptedTrTag,
						object2,
						true,
						30
					)
					v:SetChoices({ v10, v12 })
					flag = true
				end

				v2 = nil
			end

			Sleep(0)
		end

		v:Close()
		__wf_atom_7470861b:__wf_atom_63396172(v4)
		__wf_atom_3d96ddcd:__wf_atom_d927a2a4(npcIdleAnim)
		object2:__wf_atom_cf966a74(v3)
		object2:__wf_atom_dd875cd8(false)
		_T.ForceDialogClose = nil
		_T.AvakotTalking = nil

		if flag then
			__wf_atom_bb3e7833:__wf_atom_c063982d(v8.ACCEPTED)
		else
			__wf_atom_bb3e7833:__wf_atom_c063982d(v8.CLOSED)
		end
	end

	if gRegion:IsMaster() then
		Sleep(1)

		while not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_bb3e7833) or __wf_atom_7e8ad928(object)) do
			if __wf_atom_bb3e7833:GetState() == v8.ACCEPTED then
				if gGameRules:__wf_atom_d163c8e5(v7, 0) ~= 0 then
					break
				end

				fn4(deedNpcEncounterTag, __wf_atom_3d96ddcd)
				break
			elseif __wf_atom_bb3e7833:GetState() == v8.CLOSED then
				break
			else
				Sleep(0.5)
			end
		end

		if not __wf_atom_7e8ad928(object) then
			object:Enable()
		end

		_T.AvakotTalking = nil
	end
end

function EnteredNpcMultiAvatarTrigger(object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_0f45538d)
	local v9 = fn(Symbol(__wf_atom_3d96ddcd:GetName()))

	if not __wf_atom_bb3e7833:IsEnabled() then
		module3.PlayGlobalTransmission(npcTransmissionSet, Symbol("RandomSneezeReveal"))
		__wf_atom_3d96ddcd:__wf_atom_d927a2a4(npcIdleAnim)
		__wf_atom_bb3e7833:Enable()

		if __wf_atom_7e8ad928(v9) then
			module4.AddSparrowDestination(__wf_atom_3d96ddcd, nil, nil, module4.PRIORITY.HIGH, Range(0, 20))
		end
	end

	Sleep(1)
	local v10 = 0.5
	local v11 = 5

	while
		not __wf_atom_7e8ad928(object)
		and object:IsFull()
		and not __wf_atom_7e8ad928(__wf_atom_bb3e7833)
		and __wf_atom_bb3e7833:IsEnabled()
	do
		if not _T.AvakotTalking then
			if v10 <= 0 then
				if __wf_atom_7e8ad928(v9) then
					module3.PlayGlobalTransmission(npcTransmissionSet, transmissionTag, false, true)
					v11 = math.min(v11 + 5, 90)
				elseif #npcAnimTags > 0 then
					__wf_atom_3d96ddcd:PlayTriggeredAnim(npcAnimTags[__wf_atom_5784a397(1, #npcAnimTags)])
				end

				v10 = v11
			end

			v10 -= 1
		end

		Sleep(1)
	end
end

function ExitedNpcMultiAvatarTrigger(object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_0f45538d)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:IsEnabled() then
		local total = 0

		while total < 5 do
			if total > 1 and object:IsFull() then
				return
			end

			total += __wf_atom_084b3e93()
			Sleep(0)
		end

		if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			return
		end

		__wf_atom_bb3e7833:Disable()
		__wf_atom_3d96ddcd:__wf_atom_d927a2a4(npcDeactivatedIdleAnim)
	end
end

function DungeonDeedNpcEntityScript(_) end

function RunScriptTrigger(object)
	module.WaitForLevel()
	object:FirePort("Execute")
end