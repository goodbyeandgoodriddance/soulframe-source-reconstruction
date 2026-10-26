function CreateReactantPickups()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for i = 1, #__wf_atom_3c8e1a7a do
		for _ = 1, 10 do
			gRegion:CreateEntity(
				Type("/Lotus/Types/PickUps/VoidTearSealerPickup"),
				__wf_atom_3c8e1a7a[i]:__wf_atom_50a7d83e():GetPosition(),
				Rotation()
			)
		end
	end
end