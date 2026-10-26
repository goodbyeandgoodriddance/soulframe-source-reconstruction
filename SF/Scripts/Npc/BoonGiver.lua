local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")
local module3 = require("SF.Scripts.Libs.ConversationLib")
local module4 = require("EE.Interface.Utilities")
local v = nil
local v2 = nil
local v3 = Symbol("UPGRADEGIVEN_GODANDGHOST")
local v4 = nil
local v5 = Resource("/Lotus/Types/Input/DialogInputFilter")
local v6 = Symbol("Invulnerable")
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = false
local v13 = false
local v14 = nil
local selectedBoons = nil
local flag = false
local v15 = WeakResource("/SF/Upgrades/Boons/AncestorAndGodsBoonBoosterUpgrade")
local v16 = WeakResource("/SF/Types/Game/SFItemBundle")
local v17 = WeakResource()

local function fn()
	local result = {}

	for k, boon in pairs(npcBoonsPool) do
		local commonBoonWeight2 = 0
		local cost = 0
		local rarity, locString

		if __wf_atom_7e8ad928(boon) then
			rarity = 0
		else
			rarity = boon:__wf_atom_a8dac107()
			locString = boon:__wf_atom_014a76a2()
		end

		if rarity == 0 then
			commonBoonWeight2 = commonBoonWeight
		elseif rarity == 1 then
			commonBoonWeight2 = uncommonBoonWeight
		elseif rarity == 2 then
			commonBoonWeight2 = rareBoonWeight
			cost = 2500
		end

		table.insert(result, k, {
			Boon = boon,
			Rarity = rarity,
			Chance = commonBoonWeight2,
			LocString = locString,
			Cost = cost
		})
	end

	local _dontUseRolledSeed = _G.DontUseRolledSeed == true
	module4.SeededShuffleTable(result)
	return result
end

local function fn2(list)
	local result = {}
	local count = 0
	local flag2 = true
	local flag3 = false
	local v18

	if #list < 3 then
		v18 = #list
	else
		v18 = 3
	end

	while flag2 do
		for k, v19 in list do
			if flag3 then
				if Random(0, 1) <= v19.Chance and v19.Rarity ~= 2 then
					table.insert(result, v19)
					table.remove(list, k)
					count += 1

					if v18 <= count then
						flag2 = false
						break
					end
				end
			elseif v19.Rarity == 2 then
				table.insert(result, 3, v19)
				table.remove(list, k)
				count += 1
				flag3 = true

				if v18 <= count then
					flag2 = false
					break
				end
			end
		end

		Sleep(0)
	end

	if flag then
		flag = false
	end

	return result
end

local function fn3(selectedBoons2, stageResponces, object)
	local response = nil
	local responses = {}
	local selection = {}
	local v18 = {}

	for k, item in pairs(selectedBoons2) do
		local tag = "Choice" .. tostring(k)
		local v19 = true
		local text

		if item.Rarity == 2 then
			text = Localize(tostring(item.LocString), false) .. " (" .. Localize(tostring("/SF/Language/Phrases/Gift"), false) .. " " .. Localize("<CURRENCY_MOTE_DUST>", true) .. " " .. tostring(item.Cost) .. ")"

			if not object:__wf_atom_fcf61765(item.Cost) then
				v19 = false
			end
		else
			text = Localize(tostring(item.LocString), false)
		end

		local v20 = {
			Text = text,
			Disable = not v19
		}
		v20.Text = __wf_atom_8e4fda44:__wf_atom_03ff0530():__wf_atom_8e9ac384(v20.Text, true)
		local v21 = k

		function v20.Callback()
			v8 = tag
			v9 = v20
			v11 = v21
		end

		for k2, item2 in pairs(stageResponces) do
			if k2 == k then
				response = item2
			end
		end

		table.insert(responses, k, { Response = response, Tag = tag })
		table.insert(selection, k, v20)
	end

	local v19 = { Text = "/SF/Language/Quests/LeaveShrine" }
	v19.Text = __wf_atom_8e4fda44:__wf_atom_03ff0530():__wf_atom_8e9ac384(v19.Text, true)
	local v20 = "Exit"
	local v21 = nil

	function v19.Callback()
		v8 = v20
		v9 = v19
		v11 = v21
	end

	table.insert(selection, #selection + 1, v19)
	table.insert(v18, { Selection = selection, Responses = responses })
	return v18
end

local function fn4(object, boon)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(boon) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if boon:IsA(v15) then
		__wf_atom_d2b2176d:AddBoosterItem(boon, (boon:__wf_atom_e184ab04()))
	elseif boon:IsA(v16) then
		if gRegion:IsMaster() then
			object:GiveItem(boon, false)
		else
			object:__wf_atom_a96eb2aa():__wf_atom_36b99b9d(boon, 1)
		end
	else
		boon:IsA(v17)
	end

	object:Attach(boonAttachFxType, EMPTY_SYMBOL)
	gGameData:__wf_atom_a975522c(v3, 86400, true, "TimerSetCallback")
	__wf_atom_d2b2176d:__wf_atom_259e7653()
end

function BoonGiverIMGUI(object, _)
	if __wf_atom_7e8ad928(v) then
		v = object:__wf_atom_d2b2176d()
	end

	if __wf_atom_7e8ad928(_G.DontUseRolledSeed) then
		_G.DontUseRolledSeed = false
	end

	if not __wf_atom_7e8ad928(v2) then
		v2 = Engine.__wf_atom_774cdec4(86400)
	end

	__wf_atom_48bcafdc()
end

function TimerSetCallback()
	v13 = true
end

function DitherOutEntity(object)
	if object == v10 and not __wf_atom_7e8ad928(ancestorFadeFxType) then
		object:Attach(ancestorFadeFxType, EMPTY_SYMBOL)
		object:PlaySound(boonNpcDissolveSound, false)
	end

	local v18 = 0

	while v18 < 1 do
		v18 = __wf_atom_421b01aa(v18 + __wf_atom_084b3e93(), 0, 1)
		object:__wf_atom_68f2c268(v18)
		Sleep(0)
	end

	object:__wf_atom_a7ee9662(false)
end

function DitherInEntity(object)
	object:__wf_atom_68f2c268(1)
	object:__wf_atom_a7ee9662(true)
	local v18 = 1

	while not __wf_atom_7e8ad928(object) and v18 > 0 do
		v18 = __wf_atom_421b01aa(v18 - __wf_atom_084b3e93() / 1.5, 0, 1)
		object:__wf_atom_68f2c268(__wf_atom_24a82b69(v18))
		Sleep(0)
	end
end

function checkTimer(_, _)
	v12 = false

	if __wf_atom_7e8ad928(gGameData) then
		return false
	end

	if v12 and _G.EnableBoonTesting == true or gGameData:__wf_atom_20bf298d(v3) then
		return true
	end

	return false
end

function magicAwayBoonGiver(object)
	if playBoonAnim then
		object:PlayTriggeredAnim(Symbol("GiveBoonAnim"))
		Sleep(2)
	else
		Sleep(1)
	end

	if not __wf_atom_7e8ad928(object) then
		DitherOutEntity(object)
		Sleep(1)
	end
end

function BoonGiverConversation(object, object2)
	if not object2:__wf_atom_4417a5d4() then
		return
	end

	v12 = false
	_T.ConvoStage = 1

	if __wf_atom_7e8ad928(v4) then
		v4 = module.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("ConversationCamera"))
	end

	if __wf_atom_7e8ad928(v10) then
		v10 = object:__wf_atom_3d96ddcd()
	end

	if not gGameData then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.SelectedBoons) then
		v14 = fn()
		selectedBoons = fn2(v14)
		__wf_atom_e919fb8e.SelectedBoons = selectedBoons
	else
		selectedBoons = __wf_atom_e919fb8e.SelectedBoons
	end

	local __wf_atom_7470861b = object2:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local boon = nil
	object2:__wf_atom_dd875cd8(true)
	object2:__wf_atom_aeb02c14(v5)
	__wf_atom_d2b2176d:Unequip(0, 0)
	local __wf_atom_259e7653 = __wf_atom_d2b2176d:__wf_atom_259e7653(true)
	module2.CloseTransmissions()
	local v18 = { Loop = conversationMenuMusic }
	v7 = module3.CreateConversation(Localize(tostring(npcName), false), v4)
	local mFusionPoints = __wf_atom_259e7653.mFusionPoints
	local v19 = {}
	local __wf_atom_a96eb2aa = object2:__wf_atom_a96eb2aa()

	if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		v19.mLabel = __wf_atom_a96eb2aa:__wf_atom_6be84646()
	end

	if __wf_atom_7e8ad928(v18) then
		v7:Start()
	else
		v7:Start(v18)
	end

	if hideAvatar then
		object2:__wf_atom_8a035cd5(Symbol("DitherOutEntity"), false)
	end

	if #stageResponces == 0 then
		stageResponces = { EMPTY_SYMBOL, EMPTY_SYMBOL, EMPTY_SYMBOL }
	end

	v19.mMovie = v7.mConvoMovie
	v19.mCustomCurrencies = {
		{
			Icon = v19.mMovie:__wf_atom_8e9ac384("<CURRENCY_MOTE_DUST>", true),
			Amount = mFusionPoints
		}
	}
	v19.mOverwriteCurrencies = true

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v19)
	end

	local v20 = fn3(selectedBoons, stageResponces, __wf_atom_d2b2176d)
	module2.PlayDialogMenuTransmission(npcTransmissionSet, conversationIntroTag, object2, false)
	v7:SetChoices(v20[_T.ConvoStage].Selection)

	while v7:Update() do
		if __wf_atom_7e8ad928(v8) then
			if #v7.mConvoInfo.Choices == 0 then
				v7:SetChoices(v20[_T.ConvoStage].Selection)
			end
		else
			if v8 == "Exit" then
				break
			end

			if v8 == v20[_T.ConvoStage].Responses[v11].Tag then
				v7:SetChoices(nil)
				v8 = nil
				local response = v20[_T.ConvoStage].Responses[v11].Response
				module2.PlayDialogMenuTransmission(npcTransmissionSet, response, object2)

				if not __wf_atom_7e8ad928(selectedBoons[v11]) then
					boon = selectedBoons[v11].Boon

					if selectedBoons[v11].Rarity == 2 then
						__wf_atom_d2b2176d:__wf_atom_a1af2399(selectedBoons[v11].Cost)
					end

					v10:__wf_atom_8a035cd5(Symbol("magicAwayBoonGiver"), false)
					break
				end
			end
		end

		if v12 and enableImgui then
			BoonGiverIMGUI(object2, v7)
		end

		Sleep(0)
	end

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(v7.mConvoMovie)
	end

	v7:Close()

	if not __wf_atom_7e8ad928(object2) then
		if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
			__wf_atom_7470861b:__wf_atom_63396172(v6)
		end

		object2:__wf_atom_cf966a74(v5)
		object2:__wf_atom_dd875cd8(false)

		if hideAvatar then
			object2:__wf_atom_8a035cd5(Symbol("DitherInEntity"), false)
		end

		if boon and v8 ~= "Exit" then
			object:__wf_atom_e95c24e1(object2:__wf_atom_a96eb2aa())
			Sleep(1.9)
			fn4(object2, boon)
		end
	end

	_T.NPCConversationFinished = { conversationID = conversationID }
	_T.ConvoStage = 0
end