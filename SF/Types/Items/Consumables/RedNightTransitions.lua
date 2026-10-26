local module = require("SF.Scripts.Libs.CommonFunctionsLib")

function PrepDrinkCine(object)
	if __wf_atom_7e8ad928((gRegion:__wf_atom_2226b35c(Symbol("RedNightElixerDeco")))) then
		gRegion:CreateEntity(
			potionPickupType,
			Vector(object:GetPosition().x, object:GetPosition().y, object:GetPosition().z),
			object:__wf_atom_dc309f8a(),
			object
		)
	end

	object:ReinitializeGreenRoom()
	object:PlaceGreenRoomEntities()
end

function TeardownDrinkCine(_)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("RedNightElixerDeco"))

	for i = 1, #__wf_atom_2226b35c do
		__wf_atom_2226b35c[i]:Destroy()
	end
end

function DrunkTransition()
	_T.DrunkBias = drunkBaisAmount
end

function TransformSky()
	module.ModifySky(timeOfDay, true, lerpTimeOfDay, false, skyTransitionTime, false, Symbol("RednightSky"))
end

function UndoRednightTransformSky()
	module.ModifySky(timeOfDay, false, lerpTimeOfDay, false, 0, false)
end