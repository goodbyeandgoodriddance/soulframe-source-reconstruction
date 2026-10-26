local module = require("Lotus.Scripts.Libs.ObjectiveText")

function ShowTutorialHint()
	local tutorialHint = tostring(tutorialHint)

	if Engine.IsPlayingWithController() then
		local v = tutorialHint .. "_Controller"
		local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

		if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) and v ~= __wf_atom_b56d2aa8:__wf_atom_8e9ac384(v, true) then
			tutorialHint = v
		end
	end

	module.ShowTutorialHint(tutorialHint, nil, inputFilter)
	local total = 0

	while _T.HintActive do
		if hintTime > 0 and hintTime <= total then
			module.HideTutorialHint()
			break
		else
			Sleep(0)
			total += __wf_atom_084b3e93()
		end
	end
end

function HideTutorialHint()
	module.HideTutorialHint()
end