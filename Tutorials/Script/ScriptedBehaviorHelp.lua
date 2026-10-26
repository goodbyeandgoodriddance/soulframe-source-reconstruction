local count = 0

function Evaluate(_, object)
	if needsTarget and __wf_atom_7e8ad928(object) then
		count += 1
		return false
	end

	if __wf_atom_7e8ad928((gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620())) or not object:__wf_atom_4ec961d6() then
		return false
	end

	return true
end

function Activate(object, p)
	print(count)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if needsTarget and __wf_atom_7e8ad928(p) then
		return false
	end

	if not __wf_atom_7e8ad928((gRegion:__wf_atom_c4f78a8f())) then
		__wf_atom_30e3d82b:StartMoving(gRegion:__wf_atom_c4f78a8f():GetPosition(), 1, true, 1, 2, false)

		while not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_46292900() do
			Sleep(0.1)
		end
	end

	__wf_atom_30e3d82b:__wf_atom_9356c1bd(26)
	Sleep(2)

	if not runForever then
		return
	end

	while true do
		Sleep(1)
	end
end

function Update(object, _, _)
	print(count)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return false
	end

	__wf_atom_30e3d82b:StartMoving(gRegion:__wf_atom_c4f78a8f():GetPosition(), 1, true, 1, 3, false)

	if object:__wf_atom_c215662d(__wf_atom_c4f78a8f:GetPosition()) > 100 then
		__wf_atom_30e3d82b:__wf_atom_9356c1bd(43)
		return true
	end
end

function Deactivate(object, _)
	print(count)

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
		end
	end
end