local v = WeakResource("/Lotus/Levels/CivilianHubs/ZoneAttribsTypes/VenusCaveZoneAttribs")

function AnimalStartMarker(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_e800787c = __wf_atom_3d96ddcd:__wf_atom_e800787c()

	while __wf_atom_7e8ad928(__wf_atom_e800787c) do
		Sleep(0)
		__wf_atom_e800787c = __wf_atom_3d96ddcd:__wf_atom_e800787c()
	end

	local __wf_atom_58b2e21e = __wf_atom_e800787c:__wf_atom_58b2e21e()

	if not __wf_atom_7e8ad928(__wf_atom_58b2e21e) and __wf_atom_58b2e21e:IsA(v) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
			Sleep(0)
			__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		end

		local v2 = 0

		while v2 == 0 and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
			Sleep(0)
			v2 = __wf_atom_3d96ddcd:__wf_atom_208fc028()
		end

		if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			return
		end

		local v3 = tostring(v2)

		if v2 < 10 then
			v3 = "0" .. v3
		end

		local v4 = Symbol("Cave" .. v3)
		local position = __wf_atom_3d96ddcd:GetPosition()
		local nearestTagged = gRegion:FindNearestTagged(v4, position)

		if not __wf_atom_7e8ad928(nearestTagged) then
			local position2 = nearestTagged:GetPosition()
			local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
			local v5 = nil

			while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
				if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and not __wf_atom_7e8ad928(gRegion) then
					__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
				end

				if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
					local __wf_atom_e800787c2 = __wf_atom_c4f78a8f:__wf_atom_e800787c()

					if not __wf_atom_7e8ad928(__wf_atom_e800787c2) then
						if __wf_atom_e800787c2 == __wf_atom_e800787c and not v5 then
							object:Teleport(position, __wf_atom_dc309f8a)
							v5 = true
						elseif __wf_atom_e800787c2 ~= __wf_atom_e800787c and (v5 == nil or v5) then
							object:Teleport(position2, __wf_atom_dc309f8a)
							v5 = false
						end
					end
				end

				Sleep(0.1)
			end
		end
	end
end