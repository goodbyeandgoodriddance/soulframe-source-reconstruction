function MovePickupToNav(instance)
	if trackPickup then
		_T.TrackedGameplayPickup = instance
	end

	if instance:IsA(WeakResource("/Lotus/Types/Items/Tokens/GreedTokens/GreedTokenBasePickup")) then
		_T.CorpusGreedToken = instance
		_T.CorpusGreedTokenDropped = true
	end

	local v = nil
	local position = nil

	if removeFromExtractArea then
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ExtractionTrigger"))

		for _, v2 in ipairs(__wf_atom_2226b35c) do
			local __wf_atom_e800787c = v2:__wf_atom_e800787c()

			if
				__wf_atom_7e8ad928(__wf_atom_e800787c)
				or not (__wf_atom_e800787c:__wf_atom_db682341() == Symbol("Exit") or #__wf_atom_2226b35c == 1)
			then
				continue
			end

			v = v2
			break
		end

		if not __wf_atom_7e8ad928(v) then
			local allUntagged = gRegion:FindAllUntagged(gNpcSpawnPointType, v:GetPosition(), 30, 60)

			for i = #allUntagged, 1, -1 do
				local __wf_atom_e800787c = allUntagged[i]:__wf_atom_e800787c()

				if not (__wf_atom_7e8ad928(__wf_atom_e800787c) or __wf_atom_e800787c:__wf_atom_db682341() ~= Symbol("Exit")) then
					continue
				end

				table.remove(allUntagged, i)
			end

			if not __wf_atom_7e8ad928(allUntagged) and #allUntagged > 0 then
				position = allUntagged[1]:GetPosition()
			end
		end
	end

	if gRegion:IsMaster() then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local count = 0
		local count2 = 0

		while not __wf_atom_7e8ad928(instance) do
			if instance:__wf_atom_9efab7d3() then
				count += 1
				count2 = 0
			else
				count2 += 1
				count = 0
			end

			if
				removeFromExtractArea
				and (count > 2 or count2 > 2)
				and not __wf_atom_7e8ad928(position)
				and v:__wf_atom_8a6b8fc3(instance) <= 25
			then
				instance:Teleport(position + Vector(0, 0.5, 0), Rotation())
			elseif count >= 10 or count2 >= 10 then
				local position2 = instance:GetPosition()
				local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(position2)

				if Distance(position2, __wf_atom_0e0a6fee) >= 0.7 then
					instance:Teleport(__wf_atom_0e0a6fee + Vector(0, 0.5, 0), Rotation())
				end

				count = 0
				count2 = 0
			end

			Sleep(1)
		end
	end
end