local function fn()
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	for i = 1, #all do
		if all[i]:__wf_atom_1d13ef4d() and all[i]:IsEnabled() then
			return all[i]
		end
	end

	return nil
end

function EchoSwap(object)
	local position = object:GetPosition()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(corruptionTag, position, 0, range)

	for i = 1, #__wf_atom_439c0d29 do
		__wf_atom_439c0d29[i]:SetVisibility(not toEcho, true)
	end

	local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(echoTag, position, 0, range)

	for i = 1, #__wf_atom_439c0d29_2 do
		__wf_atom_439c0d29_2[i]:SetVisibility(toEcho, true)
	end

	if not __wf_atom_7e8ad928(corruptionBTag) then
		local __wf_atom_439c0d29_3 = gRegion:__wf_atom_439c0d29(corruptionBTag, position, 0, range)

		for i = 1, #__wf_atom_439c0d29_3 do
			if toEcho then
				__wf_atom_439c0d29_3[i]:FirePort("Disable")
			else
				__wf_atom_439c0d29_3[i]:FirePort("Enable")
			end
		end
	end

	if not __wf_atom_7e8ad928(echoBTag) then
		local __wf_atom_439c0d29_3 = gRegion:__wf_atom_439c0d29(echoBTag, position, 0, range)

		for i = 1, #__wf_atom_439c0d29_3 do
			if toEcho then
				__wf_atom_439c0d29_3[i]:FirePort("Enable")
			else
				__wf_atom_439c0d29_3[i]:FirePort("Disable")
			end
		end
	end

	if not __wf_atom_7e8ad928(material) then
		for i = 1, #matSwapInstances do
			matSwapInstances[i]:__wf_atom_a887a262(0, material, true)
		end
	end

	if not __wf_atom_7e8ad928(terrainMaterial) then
		for i = 1, #terrainMeshes do
			terrainMeshes[i]:__wf_atom_a887a262(0, terrainMaterial, true)
		end
	end

	if changeTimeOfDay and not __wf_atom_7e8ad928((tonumber(timeOfDay))) then
		local v = fn()

		if not __wf_atom_7e8ad928(v) then
			if toEcho then
				v:SetTimeOfDay(timeOfDay)
			else
				local __wf_atom_91a79d39 = gGameRules:__wf_atom_91a79d39()
				local v2 = 24 / math.max(v:__wf_atom_3e305fe5(), 0.00001)
				v:SetTimeOfDay(math.fmod(__wf_atom_91a79d39 + v2 / 2, v2) / v2 * 24)
			end
		end
	end

	if not __wf_atom_7e8ad928(foliageTag) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(foliageTag)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:__wf_atom_fbbbe369(0, not toEcho)
			__wf_atom_0a6a5887:__wf_atom_fbbbe369(2, not toEcho)
			__wf_atom_0a6a5887:__wf_atom_fbbbe369(1, toEcho)
		end
	end

	if not __wf_atom_7e8ad928(extraFoliageTag) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(extraFoliageTag)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:__wf_atom_fbbbe369(extraFoliageNormalLayer, not toEcho)
			__wf_atom_0a6a5887:__wf_atom_fbbbe369(extraFoliageEchoLayer, toEcho)
		end
	end
end

function HideOnLoad(object)
	object:SetVisibility(false)
end

function GarrenLairHealMoment()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("StagBossSunLight"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:TurnOff()
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("StagBossSunLightHealed"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:TurnOn()
	end

	gRegion:__wf_atom_8ad59546().postProcess:__wf_atom_112523e2(vegLutTexture)
end

function DisableVegLut()
	gRegion:__wf_atom_8ad59546().postProcess:__wf_atom_112523e2(disabledVegLutTexture)
end