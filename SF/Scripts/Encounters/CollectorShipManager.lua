local v = 30
local v2 = Range(80, 420)
local v3 = Symbol("MT_COLLECTOR")
local v4 = Symbol("CollectorTimer")
local v5 = {
	WeakResource("/SF/Types/Quests/OmenBeastQuests/BromiusQuest"),
	WeakResource("/SF/Types/Quests/EnvoyQuests/Warsong")
}
local v6 = { WeakResource("/SF/Types/Quests/TCDemoQuest") }
local v7 = nil
local v8 = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local module3 = require("SF.Scripts.Libs.EncounterLib")
local module4 = require("SF.Scripts.Libs.TaleLib")
require("Lotus.Interface.LotusUtilities")

local function fn(all)
	if __wf_atom_7e8ad928(v7) then
		v7 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
	end

	if __wf_atom_7e8ad928(v7) then
		return
	end

	local v9 = {}

	for _, v10 in ipairs(all) do
		local blue = v7:GetColor(v10:GetPosition(), true).blue

		if __wf_atom_7e8ad928(v9[blue]) then
			v9[blue] = {}
		end

		table.insert(v9[blue], v10)
	end

	local v10 = {}

	for _, v11 in pairs(v9) do
		table.insert(v10, v11)
	end

	local v11 = __wf_atom_04d7eaaa()
	local __wf_atom_774cdec4 = Engine.__wf_atom_774cdec4(21600)
	__wf_atom_01bfe5c4(__wf_atom_774cdec4)
	local v12 = __wf_atom_c08f5a0e(1, #v10)
	local v13 = __wf_atom_5784a397(1, #v10[v12])
	__wf_atom_01bfe5c4(v11)
	return v10[v12][v13]
end

function CanStartCollector(object)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	if
		__wf_atom_7e8ad928(object)
		or object:IsPrimed()
		or object:IsActive()
		or not module3.GetMissionEncounterAllowed(object)
	then
		return false
	end

	local flag = false

	for _, v9 in ipairs(__wf_atom_ef7900cf) do
		local __wf_atom_1c8f7b2d = v9:__wf_atom_1c8f7b2d(object)

		if __wf_atom_1c8f7b2d < v2.minValue then
			flag = false
			break
		elseif __wf_atom_1c8f7b2d <= v2.maxValue then
			flag = true
		end
	end

	if flag then
		return true
	end

	return false
end

function CollectorManager(p)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	local v9 = module.WaitForAiDir()

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local all = gRegion:FindAll(WeakResource("/SF/Types/Game/Encounters/Tales/CollectorEncounterHint"))
	local v10 = nil

	for i = #all, 1, -1 do
		local v11 = false

		if all[i]:__wf_atom_db682341() ~= EMPTY_SYMBOL then
			local __wf_atom_e370bfde = all[i]:__wf_atom_e370bfde()

			for _, v12 in ipairs(__wf_atom_e370bfde) do
				if v12 ~= v3 then
					continue
				end

				v11 = true
				break
			end

			if module3.GetEnemyLevel(all[i], true).minValue < 20 then
				v11 = false
			end
		end

		if not v11 then
			table.remove(all, i)
		end
	end

	local v11 = __wf_atom_5784a397(30, 120)
	local v12 = nil
	local v13 = nil

	while not (__wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(gGameData) or Game.__wf_atom_2b221245() or gRegion:__wf_atom_83b2f434()) do
		if gGameData:__wf_atom_b3cdb701(v4) then
			Sleep(120)
			v12 = nil
		elseif module2.AnyQuestIsActive(v5) and module2.HasCompletedQuestsInList(v6) then
			Sleep(120)
			v12 = nil
		else
			if __wf_atom_7e8ad928(v10) then
				if v11 <= 0 then
					v12 = v12 or fn(all)

					if not __wf_atom_7e8ad928(v12) and CanStartCollector(v12) then
						v12:Enable()

						if __wf_atom_7e8ad928(v9:PrimeMissionOnHint(v3, v12)) then
							print("Failed to prime collector encounter " .. tostring(v12:__wf_atom_db682341()))
							v12:Disable()
							v11 = 10
						else
							v10 = v12
						end
					end

					if v12 ~= v13 and not __wf_atom_7e8ad928(v12) then
						local position = v12:GetPosition()

						local function fn2(object)
							if __wf_atom_7e8ad928(v8) and not __wf_atom_7e8ad928(v12) then
								v8 = gRegion:CreateEntity(markerType, position, __wf_atom_80368bb1)
								v12:__wf_atom_d494454b(v8)
								object:SetMarker(v8)
								object:SetEnemyLevel(v12)
							end
						end

						local jobBoardsInRange = module4.GetJobBoardsInRange(position, Range(0, 1000))
						module4.AddToJobBoards(
							"Collector",
							jobBoardsInRange,
							"/SF/Language/Objectives/CollectorTaleTitle",
							"/SF/Language/Objectives/CollectorTaleLongDesc",
							markerType,
							fn2
						)
						v13 = v12
					end
				else
					v11 -= v
				end
			elseif not (v10:IsPrimed() or v10:IsActive()) then
				v10 = nil
			end

			if _T.SetCollectorAccountTimer then
				module4.RemoveFromAllJobBoards("Collector")
				gGameData:__wf_atom_a975522c(v4, 21600, true, "")
				_T.SetCollectorAccountTimer = nil
			end

			Sleep(v)
		end
	end

	print("Script ended")
end