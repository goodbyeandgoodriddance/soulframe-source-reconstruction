function OverrideImpulse(object)
	local __wf_atom_614ee7db = object:__wf_atom_614ee7db()
	local __wf_atom_d0fbb753 = object:__wf_atom_d0fbb753()
	object:__wf_atom_6b8780e8(horizontalImpulseForExplodingSword)
	object:__wf_atom_d042ee2b(verticalImpulseForExplodingSword)
	local v

	if object:__wf_atom_8107dcc6() == 2 then
		v = true
	else
		v = false
	end

	while not v do
		Sleep(0)
		v = object:__wf_atom_8107dcc6() == 2
	end

	object:__wf_atom_6b8780e8(__wf_atom_614ee7db)
	object:__wf_atom_d042ee2b(__wf_atom_d0fbb753)
end

function OnSwordThrow(object)
	Sleep(0)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()
	local __wf_atom_9f2332e5 = object:__wf_atom_9f2332e5()

	if
		__wf_atom_7e8ad928(__wf_atom_7be51ede)
		or not __wf_atom_7be51ede:IsA(__wf_atom_4ebf67cb)
		or __wf_atom_7e8ad928(__wf_atom_9f2332e5)
	then
		return
	end

	local __wf_atom_cfe217b8 = object:__wf_atom_cfe217b8()

	if __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_2a745663(
		__wf_atom_cfe217b8,
		312,
		__wf_atom_9f2332e5:__wf_atom_1bb5b1ff(),
		__wf_atom_9f2332e5
	) > 0 then
		object:__wf_atom_8a035cd5(Symbol("OverrideImpulse"), false)
	end
end

function Scale(object)
	Sleep(0)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()
	local __wf_atom_9f2332e5 = object:__wf_atom_9f2332e5()

	if
		__wf_atom_7e8ad928(__wf_atom_7be51ede)
		or not __wf_atom_7be51ede:IsA(__wf_atom_4ebf67cb)
		or __wf_atom_7e8ad928(__wf_atom_9f2332e5)
	then
		return
	end

	local __wf_atom_c082fc3d = object:__wf_atom_c082fc3d()
	local v = __wf_atom_c082fc3d

	while not __wf_atom_7e8ad928(object) and __wf_atom_c082fc3d < 5 do
		__wf_atom_c082fc3d += 0.1
		Sleep(0)
	end

	while not __wf_atom_7e8ad928(object) and v < __wf_atom_c082fc3d do
		__wf_atom_c082fc3d -= 0.1
		Sleep(0)
	end
end