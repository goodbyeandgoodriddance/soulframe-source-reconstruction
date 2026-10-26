local module = require("SF.Scripts.Libs.CommonFunctionsLib")

function RunScriptTrigger(object)
	if isInTestLevel then
		module.WaitForLevel()
		module.WaitForAiDir()
		Sleep(2)
	else
		module.WaitForLevel()
		module.WaitForLoginSequence()
		module.WaitForAiDir()
	end

	object:FirePort("Execute")
end

function RunScriptTriggerTestLevels(object)
	if shouldWaitForLevel then
		module.WaitForLevel()
	end

	if shouldWaitForAiDir then
		module.WaitForAiDir()
	end

	Sleep(2)
	object:FirePort("Execute")
end