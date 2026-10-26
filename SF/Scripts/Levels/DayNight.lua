require("Lotus.Interface.LotusUtilities")
Symbol("Day")
Symbol("Night")
Symbol("Water")
Symbol("NightSwap")
Symbol("BackDrop")
Symbol("BackDropNight")
Symbol("DayNight")
WeakResource("/EE/Types/Engine/WaterVolumeTrigger")
WeakResource("/Lotus/Types/GameRules/AlternateLotusFrontEndGameRules")
WeakResource("/Lotus/Levels/Proc/Narmer/NarmerArchonGrineerForestLevelInfo")

function SyncSkiesWithWorldState()
	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	local gGameRules2 = nil

	while _T.isStreamingLevel do
		gGameRules2 = gGameRules
		Sleep(0)
	end

	while gGameRules2 == gGameRules do
		Sleep(0)
	end

	while gGameRules:__wf_atom_91a79d39() < 0 do
		Sleep(0)
	end

	local v = false
	local v2 = nil

	while not v do
		Sleep(0)
		v2 = gRegion:FindAll(__wf_atom_4d4372ee)

		for i = 1, #v2 do
			if v2[i]:__wf_atom_1d13ef4d() then
				v = true
			end
		end
	end

	if _T.ForceTimeOfDay ~= nil then
		return
	end

	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

	if not __wf_atom_7e8ad928(__wf_atom_8ad59546) then
		__wf_atom_8ad59546:__wf_atom_92132f3d(true)
	end

	for i = 1, #v2 do
		local v3 = v2[i]

		if __wf_atom_7e8ad928(v3) or not (not v or v3:__wf_atom_1d13ef4d()) then
			continue
		end

		local v4 = math.max(v3:__wf_atom_3e305fe5(), 0.00001)
		local v5 = 24 / v4
		v3:SetTimeOfDay((gGameRules:CalculateTimeOfDay(v4, v5 / 2)))
	end
end

function SetSkiesTime()
	_T.ForceTimeOfDay = forceTimeOfDay
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	while __wf_atom_7e8ad928(all) do
		Sleep(0)
		all = gRegion:FindAll(__wf_atom_4d4372ee)
	end

	for i = 1, #all do
		all[i]:SetTimeOfDay(math.mod(forceTimeOfDay, 24))
		all[i]:SetTimeOfDayRate(0)
	end
end