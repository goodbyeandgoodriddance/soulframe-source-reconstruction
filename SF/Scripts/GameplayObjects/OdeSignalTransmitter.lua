local v = WeakResource("/SF/Fx/Gameplay/Puzzles/BeaconBeamStartDeco")
local v2 = WeakResource("/SF/Fx/Gameplay/Puzzles/BeaconBeamStartShortDeco")
local v3 = { ALLCLEAR = 1, BEGONE = 2, RESUPPLY = 3, ALARM = 4 }

function SignalMirrorOnEnabled(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v)
	local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(v2)

	if not __wf_atom_7e8ad928(object) then
		object:FirePort("Show")
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:FirePort("Hide")
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
		__wf_atom_bb3e7833_2:FirePort("Show")
	end

	local function fn(p)
		local total = 0

		if p == v3.ALARM then
			strobePhaseTime *= 1.5
			strobeTime /= 2
		elseif p == v3.RESUPPLY then
			strobePhaseTime *= 1.5
			strobeTime *= 1.5
		end

		while total < strobeTime do
			__wf_atom_bb3e7833:FirePort("Show")
			Sleep(strobePhaseTime / 2)
			__wf_atom_bb3e7833:FirePort("Hide")
			Sleep(strobePhaseTime / 2)
			total += strobePhaseTime
		end
	end

	local v4 = false

	while not __wf_atom_7e8ad928(object) and object:IsEnabled() do
		if v4 ~= object:__wf_atom_b81a6e66() and object:__wf_atom_b81a6e66() then
			fn(object:__wf_atom_f2317dfd())
			object:Deactivate()
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:FirePort("Hide")
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Disable()
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
		__wf_atom_bb3e7833_2:Disable()
	end
end