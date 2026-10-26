local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Scripts.Libs.ConversationLib")
local module3 = require("SF.Scripts.Libs.QuestLib")
local module4 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local v = Symbol("FirstNightfoldInteraction")
local v2 = nil
local v3 = nil
local v4 = true

function SlidePlayer()
	local playerDialougePosition = playerDialougePosition
	module2.SlidePlayer(v3, playerDialougePosition, 0.5)
end

function EnableCameraSpot(object, object2)
	local cameraControl = object2:CameraControl()

	if __wf_atom_7e8ad928(fashionCameraSpotInstance) then
		fashionCameraSpotInstance = gRegion:__wf_atom_f738b4af(
			Symbol("FashionCamera"),
			object:__wf_atom_8992aa91(),
			0,
			5
		)
	end

	if __wf_atom_7e8ad928(ancestorIntroQuestRes) or not module3.TaggedTaskIsActive(ancestorIntroQuestRes, v) then
		module.PlayLocalTransmission(
			verminiaTransmissionSet,
			vendorGreetingTransmissionTag,
			gRegion:__wf_atom_c4f78a8f(),
			false
		)
	else
		v2 = module4.GetLocalPlayerAncestorOfType(vendorAncestorRes, true)

		if module3.TaggedTaskIsActive(ancestorIntroQuestRes, v) then
			module3.CompleteTaskWithTag(ancestorIntroQuestRes, v)
			gGameData:RankUpAncestor(v2.mType, "OnAncestorCallback")
		end
	end

	if not (__wf_atom_7e8ad928(cameraControl) or __wf_atom_7e8ad928(fashionCameraSpotInstance)) then
		_T.VendorDialougCamera = fashionCameraSpotInstance
		cameraControl:SetCameraSpot(fashionCameraSpotInstance, 1.5)
		fashionCameraSpotInstance:__wf_atom_802e6d6a(99999)
		v3 = object2
		object2:__wf_atom_8a035cd5(Symbol("SlidePlayer"), false)
		fashionCameraSpotInstance:Activate()
	end
end

function DisableCameraSpot(object, object2)
	object2:CameraControl()

	if __wf_atom_7e8ad928(fashionCameraSpotInstance) then
		fashionCameraSpotInstance = gRegion:__wf_atom_f738b4af(
			Symbol("FashionCamera"),
			object:__wf_atom_8992aa91(),
			0,
			5
		)
	end

	fashionCameraSpotInstance:Deactivate()

	if __wf_atom_7e8ad928(object2) then
		return
	end

	module.PlayLocalTransmission(verminiaTransmissionSet, vendorGreetingTransmissionTag, object2, false)
end

function Forcewalk(_, object)
	if canForcewalk then
		object:MotionControl():__wf_atom_99fc7a82(true)
	else
		object:MotionControl():__wf_atom_99fc7a82(false)
	end
end

function OnAncestorCallback()
	v4 = true
end