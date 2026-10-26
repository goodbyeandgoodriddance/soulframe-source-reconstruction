local module = require("SF.Scripts.Libs.CommonFunctionsLib")
require("EE.Interface.Utilities")
local module2 = require("SF.Scripts.Libs.QuestLib")

local function fn()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ShipwreckHighlight"))

	for _, v in pairs(__wf_atom_2226b35c) do
		local __wf_atom_bb3e7833 = v:__wf_atom_3d96ddcd():__wf_atom_bb3e7833(__wf_atom_0f45538d)

		if __wf_atom_7e8ad928(__wf_atom_bb3e7833) or not __wf_atom_bb3e7833:IsEnabled() then
			continue
		end

		v:SetVisibility(highlightShipwreck, true)
	end
end

function EquipDuelHat(_)
	fn()
end

function EnableRibbons()
	module.WaitForLevel()
	module.WaitForLoginSequence()

	if gRegion:IsMaster() and module.IsInOverworld() then
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("FencerRibbonTrigger"))

		if #__wf_atom_2226b35c < 1 then
			return
		end

		for _, v in pairs(__wf_atom_2226b35c) do
			local __wf_atom_3d96ddcd = v:__wf_atom_3d96ddcd()

			if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_3d96ddcd:__wf_atom_db682341() == EMPTY_SYMBOL then
				continue
			end

			__wf_atom_3d96ddcd:SetVisibility(true, false)
			v:Enable()
		end
	end
end

function ActivateFencerShipwrecks()
	module.WaitForLevel()

	while Game.__wf_atom_2b221245(false) do
		Sleep(0)
	end

	if module2.HasCompletedQuest(questResource) then
		Sleep(5)
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("FencerFightTrigger"))

		if #__wf_atom_2226b35c < 1 or __wf_atom_7e8ad928(gGameData) then
			return
		end

		for i = 1, #__wf_atom_2226b35c do
			local v = __wf_atom_2226b35c[i]
			local __wf_atom_3d96ddcd = v:__wf_atom_3d96ddcd()

			if gGameData:__wf_atom_b3cdb701(__wf_atom_3d96ddcd:__wf_atom_db682341()) then
				continue
			end

			__wf_atom_3d96ddcd:SetVisibility(true, false)
			v:Enable()
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				continue
			end

			local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

			if
				__wf_atom_7e8ad928(__wf_atom_e55d02aa)
				or __wf_atom_e55d02aa:__wf_atom_eb82ab1f():__wf_atom_035fdfa8(0) ~= fencerHeadSkin
			then
				continue
			end

			gRegion:FindNearestTagged(Symbol("ShipwreckHighlight"), __wf_atom_3d96ddcd:GetPosition()):SetVisibility(
				true,
				true
			)
		end
	elseif module2.CanQuestBeStarted(questResource) then
		EnableRibbons()
		_T.FencerRibbonFound = false

		while not _T.FencerRibbonFound do
			Sleep(4)
		end

		module2.StartQuest(questResource)
		_T.QuestToTrack = questResource
	end
end

function GhostShipBells(object)
	local v = {
		{ 0.5, 1 },
		{ 4.5, 1 },
		{ 8.5, 1 },
		{ 1, 2 },
		{ 5, 2 },
		{ 9, 2 },
		{ 1.5, 3 },
		{ 5.5, 3 },
		{ 9.5, 3 },
		{ 2, 4 },
		{ 6, 4 },
		{ 10, 4 },
		{ 2.5, 5 },
		{ 6.5, 5 },
		{ 10.5, 5 },
		{ 3, 6 },
		{ 7, 6 },
		{ 11, 6 },
		{ 3.5, 7 },
		{ 7.5, 7 },
		{ 11.5, 7 },
		{ 4, 8 },
		{ 8, 8 },
		{ 0, 8 }
	}
	table.sort(v, function(a, b)
		return a[1] < b[1]
	end)
	local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()

	if __wf_atom_cb3427c9 > 12 then
		__wf_atom_cb3427c9 -= 12
	end

	local v2 = 1

	for i = 1, #v do
		if not (__wf_atom_cb3427c9 < v[i][1]) then
			continue
		end

		v2 = i
		break
	end

	while not __wf_atom_7e8ad928(object) do
		if
			__wf_atom_7e8ad928(gGameRules)
			or __wf_atom_7e8ad928(gRegion)
			or __wf_atom_7e8ad928(gRegion:__wf_atom_8ad59546())
		then
			break
		end

		local __wf_atom_cb3427c9_2 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()

		if __wf_atom_cb3427c9_2 > 12 then
			__wf_atom_cb3427c9_2 -= 12
		end

		if (v2 == 1 and v[#v][1] < __wf_atom_cb3427c9_2 and 0 or __wf_atom_cb3427c9_2) > v[v2][1] then
			local v3 = v[v2][2]
			local v4 = v2 + 1
			v2 = #v < v4 and 1 or v4

			for _ = 1, math.floor(v3 / 2) do
				if __wf_atom_7e8ad928(object) then
					continue
				end

				object:PlaySound(bellSoundDouble, false)
				Sleep(2)
			end

			if not __wf_atom_7e8ad928(object) and v3 % 2 > 0 then
				object:PlaySound(bellSoundSingle, false)
			end
		end

		Sleep(1)
	end
end