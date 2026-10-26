function DilateTime(_, object)
	object:__wf_atom_986f733d(Symbol("TrapTimeDilate"), timeDilateRate)

	for _, v in pairs(timeDilateTraps) do
		v:__wf_atom_986f733d(Symbol("TrapTimeDilate"), timeDilateRate)
	end

	Sleep(timeDilateLength)

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_558ce619(Symbol("TrapTimeDilate"))
	end

	for _, v in pairs(timeDilateTraps) do
		if not __wf_atom_7e8ad928(v) then
			v:__wf_atom_558ce619(Symbol("TrapTimeDilate"))
		end
	end
end