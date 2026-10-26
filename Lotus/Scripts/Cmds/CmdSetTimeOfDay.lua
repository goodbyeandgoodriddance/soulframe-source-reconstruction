function SetTimeOfDay(value, _)
	if type(value) ~= "number" then
		return
	end

	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	for i = 1, #all do
		all[i]:SetTimeOfDay(value % 24)
	end
end

function SetTimeOfDayPaused(value)
	if type(value) ~= "number" then
		return
	end

	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	for i = 1, #all do
		all[i]:SetTimeOfDayPaused(value > 0)
	end
end