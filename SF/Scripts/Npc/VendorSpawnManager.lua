local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local module3 = require("SF.Scripts.Libs.TaleLib")
local module4 = require("SF.Scripts.Libs.EncounterLib")
local module5 = require("Lotus.Scripts.Libs.Query")
local v = Symbol("MT_VENDOR")
local v2 = nil

local function fn(hint)
	local position = hint:GetPosition()
	local __wf_atom_103377cc = hint:__wf_atom_103377cc()
	local __wf_atom_28ce676a = v2:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, Range(0, __wf_atom_103377cc), 5)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(20)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("VendorSpawnManager.lua"), Color("0xFF00FF"))
	local positions = module5.GetPositions(1, __wf_atom_28ce676a)

	if __wf_atom_7e8ad928(positions) or #positions == 0 then
		print("Fallback to spawning vendor at hint!")
	else
		position = positions[1]
	end

	local v3 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
	return (gRegion:CreateEntity(vendorType, position, v3))
end

function VendorSpawnManager()
	module.WaitForLevel()
	module.WaitForLoginSequence()
	v2 = module.WaitForAiDir()
	Sleep(2)

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local v3 = WeakResource("/SF/Types/Quests/TCDemoQuest")

	if not module2.HasCompletedQuest(v3) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local allJobBoards = module3.GetAllJobBoards()
	local v4 = {}

	for _, allJobBoard in ipairs(allJobBoards) do
		local blue = __wf_atom_0a6a5887:GetColor(allJobBoard:GetPosition(), true).blue

		if __wf_atom_7e8ad928(v4[blue]) then
			v4[blue] = { jobBoards = {}, hints = {} }
		end

		table.insert(v4[blue].jobBoards, allJobBoard)
	end

	local all = gRegion:FindAll(__wf_atom_f806fd7a)

	for _, v5 in ipairs(all) do
		local __wf_atom_db682341 = v5:__wf_atom_db682341()

		if
			__wf_atom_db682341 == nil
			or string.find(tostring(__wf_atom_db682341), "MapTree")
			or v5:__wf_atom_5b6b447d() ~= EMPTY_SYMBOL
		then
			continue
		end

		if module4.GetSubbossEncounterTemplateName(v5) ~= nil then
			continue
		end

		local __wf_atom_e370bfde = v5:__wf_atom_e370bfde()

		for _, v6 in ipairs(__wf_atom_e370bfde) do
			if v6 ~= v then
				continue
			end

			local blue = __wf_atom_0a6a5887:GetColor(v5:GetPosition(), true).blue

			if not __wf_atom_7e8ad928(v4[blue]) then
				table.insert(v4[blue].hints, v5)
			end

			break
		end
	end

	local v5 = {}

	while #v5 < 3 and #v4 > 0 do
		local __wf_atom_774cdec4 = Engine.__wf_atom_774cdec4(7201)
		__wf_atom_01bfe5c4(__wf_atom_774cdec4)
		local v6 = __wf_atom_c08f5a0e(1, #v4)

		if #v4[v6].hints > 0 then
			table.insert(v5, v4[v6])
		end

		table.remove(v4, v6)
	end

	for _, v6 in pairs(v5) do
		local hint = v6.hints[__wf_atom_5784a397(1, #v6.hints)]
		module4.SetMissionEncounterAllowed(hint, false)

		local function fn2(object)
			if __wf_atom_7e8ad928(object.marker) then
				local v7 = fn(hint)
				object:SetMarker((gRegion:CreateEntity(vendorMarkerType, v7:GetPosition(), __wf_atom_80368bb1)))
			end
		end

		local jobBoard = v6.jobBoards[1]

		local function fn3() end

		for _, jobBoard2 in ipairs(v6.jobBoards) do
			if jobBoard2:__wf_atom_1c8f7b2d(hint) <= jobBoard:__wf_atom_1c8f7b2d(hint) then
				jobBoard = jobBoard2
			end
		end

		module3.AddToJobBoards(
			"Vendor",
			{ jobBoard },
			"/SF/Language/Objectives/VendorTitle",
			"/SF/Language/Objectives/VendorLongDesc",
			vendorMarkerType,
			fn2,
			fn3
		)
	end
end