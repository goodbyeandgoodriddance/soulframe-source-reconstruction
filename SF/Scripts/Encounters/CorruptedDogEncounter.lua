local module = require("SF.Scripts.Libs.QuestLib")

function Evaluate()
	if module.QuestIsActive(questWres) then
		return 0
	end

	return 1
end