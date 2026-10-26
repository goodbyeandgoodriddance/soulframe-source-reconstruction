local v = nil

function EMO_START(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_0650fed7(instrumentDecoType)
	local v2 = object:Attach(
		instrumentDecoType,
		Symbol("GAME_L1_WEAPON1"),
		__wf_atom_28d5d4aa,
		Rotation(0, 90, 0),
		object
	)

	if not __wf_atom_7e8ad928(v2) then
		v2:__wf_atom_8a035cd5(Symbol("WaitForEnd"), false)
	end

	if object:__wf_atom_8efce136() and __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(musicMovie) then
		v = __wf_atom_8e4fda44:__wf_atom_8b74c30b(musicMovie)
	end

	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(object, mixEffect, mixingGroupIgnored)
	end
end

function EMO_LOOP(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if object:__wf_atom_8efce136() then
		while not __wf_atom_7e8ad928(v) and object:__wf_atom_0473b7a9() do
			Sleep(0)
		end

		object:__wf_atom_7ab15c94(nil)
	end
end

function EMO_END(p, _, p2)
	if not __wf_atom_7e8ad928(v) then
		v:Execute("EndMusicGame", (tostring(p2)))
	end

	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(p, mixEffect, mixingGroupIgnored)
	end
end

function WaitForEnd(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_1cfa7bd2 = __wf_atom_3d96ddcd:__wf_atom_1cfa7bd2()

	while
		not __wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		and __wf_atom_3d96ddcd:__wf_atom_1cfa7bd2() == __wf_atom_1cfa7bd2
	do
		Sleep(0)
	end

	gRegion:__wf_atom_dd1e4d10(object)
end