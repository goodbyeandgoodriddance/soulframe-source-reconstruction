function SetHP(object)
	object:__wf_atom_d2b2176d():AddUpgrade(23, 0, graceToAdd)
end

function TestDummyPredeath(object)
	if object:__wf_atom_52077f7a(Symbol("IsTestDummyMode")) then
		if not __wf_atom_7e8ad928(object) and object:__wf_atom_bedb4e3f() and not object:IsKilled() then
			object:SetHealth(object:GetMaxHealth(), false)
		end
	else
		while not __wf_atom_7e8ad928(object) and object:__wf_atom_bedb4e3f() and not object:IsKilled() do
			if
				(__wf_atom_7e8ad928(_T.FactionSelectionConfirmed) or not _T.FactionSelectionConfirmed)
				and not __wf_atom_7e8ad928(_T.FactionSelectionClosed)
				and _T.FactionSelectionClosed
			then
				object:SetHealth(object:GetMaxHealth(), false)
				return
			else
				Sleep(0)
			end
		end
	end
end

function TestDummyAgent(object, _, _)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("SpawnPoint"), object:GetPosition(), 0, 100)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	object:__wf_atom_68f2c268(1)
	local v = 2
	local v2 = v

	while not __wf_atom_7e8ad928(object) and v > 0 do
		v = __wf_atom_421b01aa(v - __wf_atom_084b3e93(), 0, v2)
		object:__wf_atom_68f2c268(v / v2)
		Sleep(0)
	end

	object:__wf_atom_68f2c268(0)

	while __wf_atom_7e8ad928(__wf_atom_30e3d82b) do
		__wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
		Sleep(0)
	end

	if not (__wf_atom_7e8ad928(__wf_atom_f738b4af) or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) then
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(Symbol("DummyHome"), __wf_atom_f738b4af, 30, 1)
		local heading = __wf_atom_f738b4af:__wf_atom_2f2bada0().heading
		__wf_atom_30e3d82b:__wf_atom_b783ff91(__wf_atom_f738b4af:__wf_atom_a2a18137(), heading)
	end

	SetHP(object)
end