function EnteredAvatar(object, object2)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_28ce676a = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(object:GetPosition(), distanceRange, distanceRange.maxValue / 5)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_ce415137(1)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_0f52bdf4(object2:GetPosition(), distanceRange, -1, 1, 1, 0, false)
	__wf_atom_28ce676a:Start()
	local v = 2

	while not __wf_atom_28ce676a:__wf_atom_2ddd6354() and v > 0 do
		Sleep(0)
		v -= __wf_atom_084b3e93()

		if v <= 0 then
			return
		end
	end

	local __wf_atom_5802ff81 = __wf_atom_28ce676a:__wf_atom_5802ff81()

	if #__wf_atom_5802ff81 == 0 or __wf_atom_7e8ad928(object2) then
		return
	end

	object2:Teleport(object2:__wf_atom_0d7d47e6(__wf_atom_5802ff81[1]), object2:__wf_atom_dc309f8a())
end

function SelfRemove(p)
	Sleep(1)

	if not __wf_atom_7e8ad928(p) then
		gRegion:__wf_atom_dd1e4d10(p)
	end
end