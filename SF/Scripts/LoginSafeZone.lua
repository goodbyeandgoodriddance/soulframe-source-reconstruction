local module = require("SF.Scripts.Libs.CommonFunctionsLib")

function PostLoginCombatChill()
	if _G.LoginSequencePlayed or _T.ShowWelcome then
		return
	end

	module.WaitForLevel()
	module.WaitForAiDir()
	module.WaitForLoginSequence()
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:IsKilled()) then
		local entity = gRegion:CreateEntity(
			blockCombatDynamicContainer,
			__wf_atom_c4f78a8f:GetPosition(),
			__wf_atom_80368bb1
		)
		__wf_atom_7d789620:__wf_atom_ccbb5582(entity)
		_T.PausePatrols = true

		while
			not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
			and not __wf_atom_c4f78a8f:IsKilled()
			and __wf_atom_c4f78a8f:__wf_atom_1c8f7b2d(entity) <= 40
			and gRegion:__wf_atom_d52d8448() == 1
		do
			Sleep(5)
		end

		if not (__wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(__wf_atom_7d789620)) then
			__wf_atom_7d789620:__wf_atom_5b2460df(entity)
			entity:Destroy()
		end

		_T.PausePatrols = nil
	end
end

function RunScriptTrigger(object)
	object:FirePort("Execute")
end