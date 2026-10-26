local function fn(object, p, p2, p3)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if p2 == EMPTY_SYMBOL then
		object:__wf_atom_f3f3bb0e(p, 1)
		return
	end

	local total = 0

	while total < p3 and not __wf_atom_7e8ad928(object) do
		local v = total / p3
		object:__wf_atom_f3f3bb0e(p, v)
		object:__wf_atom_f3f3bb0e(p2, 1 - v)
		total += __wf_atom_084b3e93(0)
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_f3f3bb0e(p, 1)
		object:__wf_atom_f3f3bb0e(p2, 0)
	end
end

local function fn2(object, object2, __wf_atom_8ea34e5e, p, p2)
	local v = Random(p, 1)
	local v2 = 1 - v
	local v3 = p2 / 2
	local total = 0

	while total < v3 and not object:__wf_atom_7b82e9e1(13) do
		if __wf_atom_7e8ad928(object2) then
			return
		end

		object2:__wf_atom_f3f3bb0e(__wf_atom_8ea34e5e, 1 - total / v3 * v2)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	local total2 = 0

	while total2 < v3 and not object:__wf_atom_7b82e9e1(13) do
		if __wf_atom_7e8ad928(object2) then
			return
		end

		object2:__wf_atom_f3f3bb0e(__wf_atom_8ea34e5e, v + total2 / v3 * v2)
		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end

	object:__wf_atom_f3f3bb0e(__wf_atom_8ea34e5e, 1)
end

local function fn3(object, p, __wf_atom_8ea34e5e, __wf_atom_8ea34e5e2)
	fn(p, __wf_atom_8ea34e5e, __wf_atom_8ea34e5e2, 0.1)
	local total = 0

	while object:__wf_atom_7b82e9e1(13) and total < 10 do
		total += __wf_atom_084b3e93()
		Sleep(0.1)
	end

	if autoRemovePainMorph then
		fn(p, __wf_atom_8ea34e5e2, __wf_atom_8ea34e5e, 0.2)
	end
end

function OnMorphChangeRequested(object, p, p2, p3)
	if p3 == 4 then
		return 4
	end

	local selected = p3 == 0 and 1 or p3

	if __wf_atom_7e8ad928(object) then
		return selected
	end

	local __wf_atom_8ea34e5e = object:__wf_atom_8ea34e5e(p2)
	local __wf_atom_8ea34e5e2 = object:__wf_atom_8ea34e5e(selected)

	if __wf_atom_7e8ad928(p) then
		p = object
	end

	if p2 == 6 then
		fn3(object, p, __wf_atom_8ea34e5e, __wf_atom_8ea34e5e2)
		return selected
	end

	if p2 == 4 then
		local __wf_atom_f51f1faa = object:__wf_atom_f51f1faa()

		if __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
			if __wf_atom_8ea34e5e == __wf_atom_8ea34e5e2 then
				fn2(object, p, __wf_atom_8ea34e5e, 0.25, 0.5)
				return 4
			end

			fn(p, __wf_atom_8ea34e5e, __wf_atom_8ea34e5e2, 0.05)
		elseif __wf_atom_8ea34e5e == __wf_atom_8ea34e5e2 then
			fn2(__wf_atom_f51f1faa, p, __wf_atom_8ea34e5e, 0.25, 0.5)
		else
			fn(p, __wf_atom_8ea34e5e, __wf_atom_8ea34e5e2, 0.05)
		end

		return p2
	else
		if __wf_atom_8ea34e5e == __wf_atom_8ea34e5e2 then
			fn2(object, p, __wf_atom_8ea34e5e, 0.25, 0.5)
		else
			fn(p, __wf_atom_8ea34e5e, __wf_atom_8ea34e5e2, 0.25)
		end

		return p2
	end
end