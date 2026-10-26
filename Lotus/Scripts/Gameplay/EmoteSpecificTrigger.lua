function WaitForSpecificEmote(object, object2)
	while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_1cfa7bd2 = object:__wf_atom_1cfa7bd2()

			if
				not __wf_atom_7e8ad928(__wf_atom_1cfa7bd2)
				and (__wf_atom_1cfa7bd2:__wf_atom_1bb5b1ff() == requiredEmote:__wf_atom_1bb5b1ff() or not __wf_atom_7e8ad928(requiredEmoteAlt) and __wf_atom_1cfa7bd2:__wf_atom_1bb5b1ff() == requiredEmoteAlt:__wf_atom_1bb5b1ff())
			then
				Sleep(delayBeforePortFire)
				targetEntityToFirePortOn:FirePort(portNameToFire)
				break
			end
		end

		Sleep(emoteCheckInterval)

		if not (__wf_atom_7e8ad928(object2) or object2:__wf_atom_1eaf335c(object:GetPosition())) then
			break
		end
	end
end

function WaitForSpecificEmoteForDuration(object)
	local total = 0

	while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
		if not __wf_atom_7e8ad928(object) then
			if
				__wf_atom_7e8ad928(object:__wf_atom_1cfa7bd2())
				or object:__wf_atom_1cfa7bd2():__wf_atom_1bb5b1ff() ~= requiredEmote:__wf_atom_1bb5b1ff()
			then
				total = 0
			else
				total += emoteCheckInterval

				if requiredDuration <= total then
					Sleep(delayBeforePortFire)
					targetEntityToFirePortOn:FirePort(portNameToFire)
					break
				end
			end
		end

		Sleep(emoteCheckInterval)
	end
end