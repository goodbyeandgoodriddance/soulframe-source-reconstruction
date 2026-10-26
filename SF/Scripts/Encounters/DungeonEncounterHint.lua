function DungeonHuntActivated(object)
	if chanceToStartEncounter < 1 and math.random() > chanceToStartEncounter then
		object:Disable()
	end
end