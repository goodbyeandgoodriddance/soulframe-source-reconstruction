local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")
local module3 = require("SF.Scripts.Libs.QuestLib")
local module4 = require("SF.Scripts.Libs.TaleLib")
local module5 = require("EE.Interface.Utilities")
local module6 = require("SF.Scripts.Libs.SparrowLib")
local v = Symbol("MapTreeJobBoard")
local v2 = Symbol("WorldTreeAction")
local v3 = Symbol("WorldTreeSocial")

function Dissolve(object)
	local total = 0

	while not __wf_atom_7e8ad928(object) and total < 1 do
		total += __wf_atom_084b3e93()
		object:__wf_atom_68f2c268(total)
		Sleep(0)
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

function SocalMovieCompleted()
	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(false)
	end
end

local function fn(position)
	local nearestTagged = gRegion:FindNearestTagged(v, position)

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:Enable()
		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v2, nearestTagged:GetPosition(), 0, 10)

		if __wf_atom_7e8ad928((__wf_atom_f738b4af:__wf_atom_bb3e7833(__wf_atom_fac7b40a))) then
			__wf_atom_f738b4af:Attach(interactionFX, EMPTY_SYMBOL, Vector(-0.33, 2.885, 0.58))
		end

		if not __wf_atom_7e8ad928(gGameData) then
			local __wf_atom_0cbd9965 = gGameData:__wf_atom_0cbd9965()

			if __wf_atom_0cbd9965 ~= EMPTY_SYMBOL then
				local __wf_atom_51dd1b95 = gGameData:__wf_atom_51dd1b95(__wf_atom_0cbd9965)

				if not __wf_atom_7e8ad928(__wf_atom_51dd1b95) and __wf_atom_51dd1b95.mInitiated then
					module6.AddSparrowDestination(
						nearestTagged,
						nearestTagged,
						nil,
						module6.PRIORITY.LOW,
						Range(1, 300)
					)
				end
			end
		end
	end
end

function TreeJobBoard(object, object2)
	if not object2:__wf_atom_4417a5d4() then
		return
	end

	if gRegion:IsMaster() then
		if not isTaleNote then
			_T.currentJobBoard = object
		end

		if __wf_atom_7e8ad928(object2) then
			return
		end

		if isTaleNote then
			local __wf_atom_575542c8 = object:__wf_atom_575542c8()
			local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

			if
				not __wf_atom_7e8ad928(__wf_atom_575542c8)
				and __wf_atom_575542c8:IsA(__wf_atom_9e85eea2)
				and __wf_atom_3d96ddcd ~= __wf_atom_575542c8
			then
				__wf_atom_3d96ddcd:__wf_atom_e6ed03c8()
				__wf_atom_3d96ddcd:__wf_atom_0ed81088(true)
				return
			end
		end

		if getEventsFromNearestTree then
			local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
			local position = object:GetPosition()
			local regionId = module.GetRegionIdFromDensityVolume(position)
			local jobBoardsInRegion = module4.GetJobBoardsInRegion(regionId)
			local nearestObject = module.NearestObject(position, jobBoardsInRegion, nil, true)

			if not __wf_atom_7e8ad928(nearestObject) then
				local __wf_atom_e919fb8e2 = nearestObject:__wf_atom_e919fb8e()

				if not __wf_atom_7e8ad928(__wf_atom_e919fb8e2.eventInfo) then
					__wf_atom_e919fb8e.eventInfo = __wf_atom_e919fb8e2.eventInfo
				end
			end
		end

		local v4 = nil
		local v5

		if __wf_atom_7e8ad928(mapProxyAvatarType) then
			v5 = nil
		else
			local v6 = gRegion:IsMaster() and 3 or 4
			v5 = gRegion:CreateEntity(
				mapProxyAvatarType,
				object2:GetPosition() + Vector(0, 50, 0),
				object2:__wf_atom_dc309f8a(),
				nil,
				nil,
				v6
			)

			if not __wf_atom_7e8ad928(v5) then
				v4 = object2:__wf_atom_a96eb2aa():__wf_atom_cca6e0bc()
				v4:__wf_atom_865e86de(v5)
			end
		end

		local __wf_atom_7470861b = object2:__wf_atom_7470861b()
		local v6 = Symbol("Invulnerable")
		__wf_atom_7470861b:__wf_atom_9fba31e6(v6, 26, 6, 0)
		object2:__wf_atom_dd875cd8(true)
		_T.JobBoardEntity = object
		__wf_atom_8e4fda44:__wf_atom_8b74c30b(Resource("/SF/Interface/JobBoard.swf"))

		function _T.OnJobBoardClosed()
			if not __wf_atom_7e8ad928(object2) then
				__wf_atom_7470861b:__wf_atom_63396172(v6)
				object2:__wf_atom_dd875cd8(false)

				if not __wf_atom_7e8ad928(v4) then
					v4:__wf_atom_865e86de(object2)
				end
			end

			if not __wf_atom_7e8ad928(v5) then
				v5:Destroy()
			end

			if not __wf_atom_7e8ad928(_T.JobBoardEntity) then
				local __wf_atom_3d96ddcd = _T.JobBoardEntity:__wf_atom_3d96ddcd()

				if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and isTaleNote then
					local v7 = false

					for _, activeTale in ipairs(_T.ActiveTales) do
						if not (activeTale.jobBoardAction == _T.JobBoardEntity and activeTale.state < module4.STATE.ACCEPTED) then
							continue
						end

						v7 = true
						break
					end

					if not v7 then
						module.GiveXpToPlayer(100, object2)
						__wf_atom_3d96ddcd:Destroy()
					end
				end
			end

			_T.JobBoardEntity = nil
		end
	else
		if __wf_atom_7e8ad928(gMatchingService) then
			return
		end

		local v4 = Localize("/SF/Language/Quests/JobBoardHostOnly", false)
		local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

		if __wf_atom_7e8ad928(__wf_atom_15811761) then
			return
		end

		local __wf_atom_6c164199 = __wf_atom_15811761:__wf_atom_6c164199()
		local locString = string.gsub(v4, "|NAME|", __wf_atom_6c164199)
		local titleString = Localize("/SF/Language/Quests/JobBoardQuestsHeading", false)
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 0
		dialogSettings.locString = locString
		dialogSettings.titleString = titleString
		module5.ShowCustomMessage(dialogSettings)
	end
end

function PlayTransmission(p)
	if __wf_atom_7e8ad928(empressTransmissionSet) then
		return
	end

	Sleep(empressTransmissionDelay)
	module2.PlayLocalTransmission(empressTransmissionSet, empressTransmissionTag, p)
end

local function fn2(p, count) -- 1 equivalent call inferred from this helper
	local total = 0

	for i = 0, count - 1 do
		total += bit32.extract(p, i)
	end

	return total
end

function ActivateMapTree(object, object2)
	if not gGameData or not __wf_atom_a0f6588f:__wf_atom_f89aa44a() or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()

	if __wf_atom_d2b2176d:__wf_atom_705a2744(loreReward, loreMemory) then
		return
	end

	__wf_atom_d2b2176d:Unequip(0, 2)

	if object2:__wf_atom_631bafa1() and not __wf_atom_d2b2176d:__wf_atom_705a2744(loreReward, loreMemory) then
		local count = #loreReward:__wf_atom_22020464()
		local total = fn2(__wf_atom_d2b2176d:__wf_atom_afc2f523(loreReward), count) -- inferred equivalent call

		if not (numLoreForRewards <= 0) then
			count = math.min(numLoreForRewards, count)
		end

		if total < count and count <= total + 1 then
			for _, v4 in ipairs(localRewards) do
				if __wf_atom_7e8ad928(v4) then
					continue
				end

				if v4:IsA(__wf_atom_a75640c1) then
					__wf_atom_d2b2176d:__wf_atom_e7ac08e7(v4, "")
				elseif v4:IsA(__wf_atom_3cecff09) then
					__wf_atom_d2b2176d:__wf_atom_fc19219a(v4)
				end
			end
		end

		module.GiveLoreFragmentMemory(object2, loreReward, loreMemory)
	end

	local position = object2:GetPosition()
	local nearestTagged = gRegion:FindNearestTagged(Symbol("MapTreeSpear"), position)

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:__wf_atom_e5d015a7(Symbol("StagSpearAlt"))
	end

	object2:PlaySound(treeHealSound, false)
	local nearestTagged2 = gRegion:FindNearestTagged(Symbol("MapTreeCin"), position)

	if not __wf_atom_7e8ad928(nearestTagged2) then
		nearestTagged2:ReinitializeGreenRoom()
		module.PlayCinematicAndWait(nearestTagged2, false, object2)
	end

	local nearestTagged3 = gRegion:FindNearestTagged(Symbol("MapTree"), position)

	if not __wf_atom_7e8ad928(nearestTagged3) then
		nearestTagged3:__wf_atom_bde21df6(Resource(), false)
		nearestTagged3:__wf_atom_2f6e34f6()
		local __wf_atom_f582136d = nearestTagged3:__wf_atom_f582136d(__wf_atom_0f520c3c)

		if #__wf_atom_f582136d > 0 then
			__wf_atom_f582136d[1]:__wf_atom_ff716ec1(true)
		end
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
		Symbol("MapTreeCorruption"),
		nearestTagged3:GetPosition(),
		0,
		15
	)

	if #__wf_atom_439c0d29 > 0 then
		for _, v4 in ipairs(__wf_atom_439c0d29) do
			v4:__wf_atom_8a035cd5(Symbol("Dissolve"), false)
		end
	end

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:__wf_atom_8a035cd5(Symbol("Dissolve"), false)
		nearestTagged:__wf_atom_e5d015a7(EMPTY_SYMBOL)
	end

	_T.RevealMapMask = { WeakResource(loreReward), loreMemory }
	__wf_atom_8e4fda44:__wf_atom_8b74c30b(worldMapMovie)

	while __wf_atom_8e4fda44:FindMovie(worldMapMovie) do
		Sleep(1)
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_8a035cd5(Symbol("PlayTransmission"), false)
		local __wf_atom_d2b2176d2 = object2:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d2) then
			local __wf_atom_e55d02aa = __wf_atom_d2b2176d2:__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				__wf_atom_d2b2176d2:__wf_atom_1c510625(2000, __wf_atom_e55d02aa)
			end
		end
	end

	fn(position)
	local nearestTagged4 = gRegion:FindNearestTagged(v3, position)

	if not __wf_atom_7e8ad928(nearestTagged4) then
		nearestTagged4:Enable()
	end

	object:Disable()
end

function OpenSocialMenu(object, p)
	if not gGameData or not __wf_atom_a0f6588f:__wf_atom_f89aa44a() or __wf_atom_7e8ad928(p) then
		return
	end

	if __wf_atom_7e8ad928(gGameRules) or gGameRules:__wf_atom_3aa103d3() then
		return
	end

	local loreMemory = object:__wf_atom_e919fb8e().loreMemory
	gGameRules:__wf_atom_411c9025(true)
	_T.SocialLocation = loreMemory:c_str()
	__wf_atom_8e4fda44:__wf_atom_3e5e23c0(socialMovie, "SocalMovieCompleted")
end

function EvaluateAction(_, instance)
	if not instance:IsA(__wf_atom_4ebf67cb) then
		return false
	end

	if evaluateCheckForMemory then
		local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()

		if not (__wf_atom_7e8ad928(loreReward) or __wf_atom_7e8ad928(loreMemory) or __wf_atom_d2b2176d:__wf_atom_705a2744(
			loreReward,
			loreMemory
		)) then
			return false
		end
	end

	return true
end

function Init(object)
	Sleep(0)

	while __wf_atom_7e8ad928(gGameData) do
		Sleep(1)
	end

	local playerAvatar = nil

	while __wf_atom_7e8ad928(playerAvatar) do
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

			if not __wf_atom_7e8ad928(playerAvatar) then
				break
			end
		end

		Sleep(1)
	end

	local __wf_atom_705a2744 = playerAvatar:__wf_atom_d2b2176d():__wf_atom_705a2744(loreReward, loreMemory)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v, object:GetPosition(), 0, 30)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		local loreMemory = tostring(loreMemory)
		local v4 = 1

		for i = #loreMemory, 1, -1 do
			if string.sub(loreMemory, i, i) ~= "/" then
				continue
			end

			v4 = i + 1
			break
		end

		local name = string.sub(loreMemory, v4, (string.len(loreMemory)))
		local __wf_atom_e919fb8e = __wf_atom_f738b4af:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.name = name
		__wf_atom_e919fb8e.region = module.GetRegionIdFromDensityVolume(__wf_atom_f738b4af:GetPosition())
	end

	local __wf_atom_f738b4af2 = gRegion:__wf_atom_f738b4af(v3, object:GetPosition(), 0, 30)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af2) then
		local __wf_atom_e919fb8e = __wf_atom_f738b4af2:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.loreMemory = loreMemory
	end

	local position = object:GetPosition()
	local nearestTagged = gRegion:FindNearestTagged(Symbol("MapTree"), position)

	if __wf_atom_7e8ad928(nearestTagged) then
		return
	end

	local __wf_atom_f582136d = nearestTagged:__wf_atom_f582136d(__wf_atom_0f520c3c)

	if #__wf_atom_f582136d > 0 then
		__wf_atom_f582136d[1]:__wf_atom_ff716ec1(__wf_atom_705a2744)
	end

	if __wf_atom_705a2744 then
		nearestTagged:__wf_atom_bde21df6(Resource(), false)
		nearestTagged:__wf_atom_2f6e34f6()
		local nearestTagged2 = gRegion:FindNearestTagged(Symbol("MapTreeSpear"), position)

		if not __wf_atom_7e8ad928(nearestTagged2) then
			gRegion:__wf_atom_dd1e4d10(nearestTagged2)
		end

		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
			Symbol("MapTreeCorruption"),
			nearestTagged:GetPosition(),
			0,
			15
		)

		if #__wf_atom_439c0d29 > 0 then
			for _, v4 in ipairs(__wf_atom_439c0d29) do
				v4:__wf_atom_8a035cd5(Symbol("Dissolve"), false)
			end
		end

		local nearestTagged3 = gRegion:FindNearestTagged(v3, position)

		if not __wf_atom_7e8ad928(nearestTagged3) then
			nearestTagged3:Enable()
		end

		fn(position)
		object:Disable()
	end
end

function NightfoldInit(object)
	Sleep(0)

	while __wf_atom_7e8ad928(gGameData) do
		Sleep(1)
	end

	local firstQuestRes = firstQuestRes

	if not module3.QuestIsActive(firstQuestRes) then
		object:Attach(interactionFX, EMPTY_SYMBOL, Vector(0, 2, 3))
	end
end

function ActivateMapTreeNightfold(_, p)
	if gGameData and __wf_atom_a0f6588f:__wf_atom_f89aa44a() and not __wf_atom_7e8ad928(p) then
		_T.SocialLocation = "Nightfold"
		__wf_atom_8e4fda44:__wf_atom_3e5e23c0(socialMovie, "SocalMovieCompleted")
	end
end

function ActivateMapTreeDungeon(_, p)
	if gGameData and __wf_atom_a0f6588f:__wf_atom_f89aa44a() and not __wf_atom_7e8ad928(p) then
		_T.SocialLocation = socialLocation
		__wf_atom_8e4fda44:__wf_atom_3e5e23c0(socialMovie, "SocalMovieCompleted")
	end
end

function InitJobBoard(_) end