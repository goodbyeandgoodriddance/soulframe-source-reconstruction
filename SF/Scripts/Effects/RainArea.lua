function Update(object)
	while not __wf_atom_7e8ad928(object) do
		local v = not _T.RainNearPlayer and 0 or _T.RainNearPlayer
		object:SetMaterialParam(Symbol("RainAtten"), v)

		if v < 0.01 then
			object:SetVisibility(false)
		else
			object:SetVisibility(true)
		end

		Sleep(0)
	end
end