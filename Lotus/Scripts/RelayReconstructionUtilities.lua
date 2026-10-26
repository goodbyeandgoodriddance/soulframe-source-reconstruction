return {
	GetConstructionProjects = function()
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		local result = {}

		if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			return result
		end

		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			return result
		end

		local personalGoalProgress = __wf_atom_9be88b01:GetPersonalGoalProgress()
		local __wf_atom_92662866 = __wf_atom_9be88b01:__wf_atom_92662866()
		local mGoals = __wf_atom_92662866.mGoals
		local mConstructionProjects = __wf_atom_92662866.mConstructionProjects

		for _, mGoal in ipairs(mGoals) do
			if not (mGoal.mRelayReconstruction and Engine.__wf_atom_db2b0cee(mGoal.mActivation) <= 0) then
				continue
			end

			for i = 1, #mConstructionProjects do
				local mConstructionProject = mConstructionProjects[i]

				if mGoal.mTag ~= mConstructionProject.mTag then
					continue
				end

				local v = { info = mConstructionProject:Copy(), progress = 0, goalId = MongoId() }
				v.goalId:Parse(mGoal.mId:__wf_atom_854e0028())
				v.rebuildNode = Symbol(v.info.mNode:c_str() .. "Rebuild")
				local v2 = MongoId()

				for _, v3 in pairs(personalGoalProgress) do
					v2:Parse(v3.mId:__wf_atom_854e0028())

					if v.goalId ~= v2 then
						continue
					end

					v.progress = v3.mCount
					break
				end

				table.insert(result, v)
			end
		end

		return result
	end
}