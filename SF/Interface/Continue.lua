local v = nil
local flag = false
Vector()

function Initialize()
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 3)
	__wf_atom_8e4fda44:__wf_atom_ebf17acc(level)
	__wf_atom_392793db:__wf_atom_8ad59546():__wf_atom_47f0b80b(1)
	__wf_atom_392793db:__wf_atom_8ad59546():__wf_atom_f92e3acc(0, 1 / 3)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(empressWaitScreenSound) then
		v = __wf_atom_c4f78a8f:PlaySound(empressWaitScreenSound, false)
	end
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
	local v2 = Noise(7 + __wf_atom_4658d645(Time() * 1)) * math.abs((Noise(3 + __wf_atom_4658d645(Time() * 0.2))))
	mMovie:__wf_atom_e57658c2("Weird", 16, v2 * 15)
end

function AdvanceAndShutdown()
	if flag then
		return
	end

	flag = true

	if not __wf_atom_7e8ad928(v) then
		v:Stop(false)
	end

	__wf_atom_392793db:__wf_atom_8ad59546():__wf_atom_f92e3acc(1, 0.5)
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 2, 0, function()
		mMovie:Close()
		__wf_atom_8e4fda44:__wf_atom_62a19abc()
	end)
end

function onKeyDown_MENU_SELECT(_, _)
	AdvanceAndShutdown()
	return true
end

function onKeyDown_MENU_CANCEL(_, _)
	AdvanceAndShutdown()
	return true
end

function onKeyDown_MENU_GENERIC1()
	AdvanceAndShutdown()
	return true
end

function onKeyDown_MENU_GENERIC2()
	AdvanceAndShutdown()
	return true
end