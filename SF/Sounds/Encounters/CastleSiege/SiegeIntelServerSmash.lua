local module = require("Lotus.Scripts.Libs.AudioLib")

function enableSequencer()
	module.EnableTaggedSequencers(Symbol("ServerAlarm"), true)
end