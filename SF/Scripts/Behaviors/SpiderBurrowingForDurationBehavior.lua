local v = Symbol("LastBurrowed")

local function fn(object)
	if
		object:__wf_atom_7b82e9e1(20)
		or object:__wf_atom_7b82e9e1(12)
		or object:__wf_atom_7b82e9e1(13)
		or object:__wf_atom_7b82e9e1(6)
	then
		return true
	end

	return false
end

function Evaluate(object, _)
	if fn(object) then
		return false
	end

	local v2 = not object:__wf_atom_7bcdbf55(burrowAnimActionCheck)

	if v2 then
		object:__wf_atom_cecb2d55(v, Time() + stayBurrowedTime:__wf_atom_ff1686f2())
	end

	return v2
end

function Activate(object, _)
	while not __wf_atom_7e8ad928(object) and fn(object) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:Burrow()
	end
end

function Deactivate(_, _) end