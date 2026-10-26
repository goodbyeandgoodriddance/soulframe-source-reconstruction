module(..., package.seeall)
local module = require("SF.Scripts.Libs.ObjectiveHudLib")
require("SF.Interface.Libs.OdeCipher")

function HasActiveJobs()
	return not __wf_atom_7e8ad928(_T.ActiveJobs) and #_T.ActiveJobs ~= 0
end

function HasActiveJob(data)
	if not HasActiveJobs() then
		return false
	end

	for _, activeJob in ipairs(_T.ActiveJobs) do
		if
			activeJob.JobInfo == data.JobInfo
			and activeJob.LocationTag == data.LocationTag
			and activeJob.MissionTag == data.MissionTag
		then
			return true
		end
	end

	return false
end

function AddJob(data)
	if HasActiveJob(data) then
		print("AddJob error: Already has job")
		return
	end

	if __wf_atom_7e8ad928(data.JobInfo) then
		print("AddJob error: Missing JobInfo")
		return
	end

	if __wf_atom_7e8ad928(data.LocationTag) then
		print("AddJob error: Missing LocationTag")
		return
	end

	if __wf_atom_7e8ad928(data.MissionTag) then
		print("AddJob error: Missing MissionTag")
		return
	end

	if __wf_atom_7e8ad928(_T.ActiveJobs) then
		_T.ActiveJobs = {}
	end

	table.insert(_T.ActiveJobs, data)
end

function RemoveJob(data)
	if not HasActiveJobs() then
		return
	end

	if __wf_atom_7e8ad928(data.JobInfo) then
		print("RemoveJob error: Missing JobInfo")
		return
	end

	for i, activeJob in ipairs(_T.ActiveJobs) do
		if not (activeJob.JobInfo == data.JobInfo and activeJob.LocationTag == data.LocationTag and activeJob.MissionTag == data.MissionTag) then
			continue
		end

		table.remove(_T.ActiveJobs, i)
		break
	end
end

function RefreshJobTrackers()
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	module.RemoveHudGroup(__wf_atom_eab484a7, "SilentRoseJobs")
	module.AddHudTitle(
		__wf_atom_eab484a7,
		"SilentRoseJobs",
		"/SF/Language/Hub/DeoraJobs_HudTitle",
		module.HUD_PRIORITY.JOBS
	)

	for _, activeJob in ipairs(_T.ActiveJobs) do
		local v = "/SF/Language/Hub/DeoraJobs_HudJob"
		local c_str = activeJob.LocationLocTag:c_str()
		local name = Localize(activeJob.Name, false)

		if c_str ~= "" then
			local location = Localize(c_str, false)
			name = Localize(v, { NAME = name, LOCATION = location })
		end

		module.AddHudTask(__wf_atom_eab484a7, "SilentRoseJobs", "SilentRoseJob_" .. activeJob.LocationTag:c_str(), name)
	end

	module.UpdateVisibility(true)
end