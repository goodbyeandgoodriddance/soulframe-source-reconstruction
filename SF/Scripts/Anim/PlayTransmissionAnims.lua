function PlayNpcAnimsDuringTransmission()
	while __wf_atom_7e8ad928(_T.curTransmission) do
		Sleep(0)
	end

	local __wf_atom_cefccdc5 = _T.curTransmission:__wf_atom_cefccdc5()

	if __wf_atom_7e8ad928(__wf_atom_cefccdc5) or __wf_atom_cefccdc5 == EMPTY_SYMBOL then
		print("No tag provided!")
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(__wf_atom_cefccdc5)

	if __wf_atom_7e8ad928(__wf_atom_2226b35c) or #__wf_atom_2226b35c == 0 then
		print("No npcs found to play transmission anims on!")
		return
	end

	local count = 0
	local total = 0

	while count < #animEventTags do
		if animStartTimes[count + 1] <= total then
			count += 1

			for _, v in ipairs(__wf_atom_2226b35c) do
				if __wf_atom_7e8ad928(v) or not v:IsA(__wf_atom_b39fdada) then
					print("Npc not found!")
				else
					v:PlayTriggeredAnim(animEventTags[count])

					if overrideAnimAtEnd[count] then
						v:__wf_atom_c1b602d8(animEventTags[count])
					end
				end
			end
		end

		Sleep(0)
		total += __wf_atom_03df4e1d()

		if __wf_atom_7e8ad928(_T.curTransmission) then
			break
		end
	end

	if resetAnimsAtEnd then
		for _, v in ipairs(__wf_atom_2226b35c) do
			v:__wf_atom_d927a2a4(nil)
		end
	end
end

function PlayAnimsDuringTransmission()
	while __wf_atom_7e8ad928(_T.curTransmission) do
		Sleep(0)
	end

	local __wf_atom_cefccdc5 = _T.curTransmission:__wf_atom_cefccdc5()

	if __wf_atom_7e8ad928(__wf_atom_cefccdc5) or __wf_atom_cefccdc5 == EMPTY_SYMBOL then
		print("No tag provided!")
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(__wf_atom_cefccdc5)

	if __wf_atom_7e8ad928(__wf_atom_2226b35c) or #__wf_atom_2226b35c == 0 then
		print("No entities found to play transmission anims on!")
		return
	end

	local v = {}

	if not __wf_atom_7e8ad928(prop) and prop:IsA(__wf_atom_7e616794) then
		for _, v2 in pairs(__wf_atom_2226b35c) do
			table.insert(v, (v2:Attach(prop, propBone, propOffset, propRotation)))
		end
	end

	local count = 0
	local total = 0

	while not __wf_atom_7e8ad928(_T.curTransmission) do
		if not __wf_atom_7e8ad928(animStartTimes[count + 1]) and animStartTimes[count + 1] <= total then
			count += 1

			for _, v2 in ipairs(__wf_atom_2226b35c) do
				if __wf_atom_7e8ad928(v2) then
					continue
				end

				if v2:IsA(__wf_atom_67c46eba) then
					v2:__wf_atom_921c1a5f(anims[count], false, 3, 1)
				elseif v2:IsA(__wf_atom_b39fdada) then
					v2:__wf_atom_d927a2a4(anims[count])
				else
					v2:__wf_atom_921c1a5f(anims[count], false, false)
				end
			end

			for _, v2 in ipairs(v) do
				v2:__wf_atom_921c1a5f(propAnims[count], false, false)
			end
		end

		Sleep(0)
		total += __wf_atom_03df4e1d()
	end

	while not __wf_atom_7e8ad928(_T.curTransmission) do
		Sleep(0)
	end

	for _, v2 in ipairs(__wf_atom_2226b35c) do
		if __wf_atom_7e8ad928(v2) then
			continue
		end

		if v2:IsA(__wf_atom_67c46eba) then
			v2:__wf_atom_921c1a5f(nil, false, 3, 1)
		elseif v2:IsA(__wf_atom_b39fdada) then
			v2:__wf_atom_d927a2a4(nil)
		else
			v2:__wf_atom_921c1a5f(nil, false, false)
		end
	end

	for _, v2 in ipairs(v) do
		v2:__wf_atom_8a035cd5(Symbol("DestroyPropAtEnd"), false)
	end
end

function PlayNpcAnimMatchingTransmission()
	while __wf_atom_7e8ad928(_T.curTransmission) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(_T.TransmissionSoundInstance) then
		return
	end

	local __wf_atom_00e6ce32 = _T.TransmissionSoundInstance:__wf_atom_00e6ce32()

	if __wf_atom_7e8ad928(__wf_atom_00e6ce32) then
		return
	end

	local __wf_atom_cefccdc5 = _T.curTransmission:__wf_atom_cefccdc5()

	if __wf_atom_7e8ad928(__wf_atom_cefccdc5) or __wf_atom_cefccdc5 == EMPTY_SYMBOL then
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(__wf_atom_cefccdc5)

	if __wf_atom_7e8ad928(__wf_atom_2226b35c) or #__wf_atom_2226b35c == 0 then
		return
	end

	local name = __wf_atom_00e6ce32:__wf_atom_1bb5b1ff():GetName()
	local v = string.find(name, "[_.]")

	if v then
		name = string.sub(name, 1, v - 1)
	end

	for _, v2 in ipairs(__wf_atom_2226b35c) do
		if __wf_atom_7e8ad928(v2) or not v2:IsA(__wf_atom_b39fdada) then
			continue
		end

		v2:PlayTriggeredAnim(Symbol(name))
	end
end

function DestroyPropAtEnd(instance)
	local __wf_atom_f7e7be53 = instance:__wf_atom_f7e7be53()

	if not __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		local v = false

		while not v do
			local v2 = false

			for _, v3 in ipairs(anims) do
				if __wf_atom_f7e7be53:__wf_atom_c138b19b(v3) then
					v2 = true
				end
			end

			Sleep(0)
			v = not v2 or v
		end
	end

	instance:Destroy()
end