local v = nil
local v2 = nil
local v3 = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module5 = require("SF.Scripts.Libs.TransmissionSet")
local module6 = require("SF.Scripts.Libs.RaycastLib")

local function fn(mOwner, p, p2)
	_T.ProgressionScreenDisabled = true
	module.WaitForLevel()
	module.WaitForLoginSequence()

	if not module.IsInOverworld() then
		return false
	end

	if (p2 == nil or p2) and __wf_atom_7e8ad928(v) then
		v = module.WaitForAiDir()
	end

	while module.IsStreamingLevel() do
		Sleep(0)
	end

	v2 = false
	v3 = tostring(module2.GetReadableTaskTag(mOwner, p))
	print("Starting" .. v3)
	return true
end

function GrabFishRod(object, object2)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) then
		return
	end

	module.UnequipWeapon(object2, true)
	Sleep(0)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("FishingRodDeco"), object:GetPosition(), 0, 10)

	if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		print("Fishing Quest Error: rod item not found")
		return
	end

	local position = __wf_atom_f738b4af:GetPosition()
	local __wf_atom_dc309f8a = __wf_atom_f738b4af:__wf_atom_dc309f8a()
	local entity = gRegion:CreateEntity(RodDecoType, position, __wf_atom_dc309f8a, nil, nil, 1)
	local groundPos = module6.GetGroundPos(entity:GetPosition())

	if __wf_atom_7e8ad928(groundPos) then
		return
	end

	local entity2 = gRegion:CreateEntity(grabFishRodCinType, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object2, object2)

	if __wf_atom_7e8ad928(entity2) then
		return
	end

	entity:SetVisibility(true, true)
	local __wf_atom_99c400ff, _ = entity2:__wf_atom_99c400ff(Symbol("Envoy"), 0)
	local __wf_atom_99c400ff2, _ = entity2:__wf_atom_99c400ff(Symbol("FishingRod"), 0)

	if __wf_atom_7e8ad928(__wf_atom_99c400ff) or __wf_atom_7e8ad928(__wf_atom_99c400ff2) then
		return
	end

	local distance2d = module.Distance2d(__wf_atom_99c400ff, groundPos)
	module6.GetGroundPos(entity:GetPosition() + __wf_atom_9341614d(
		Vector(0, 0, distance2d),
		Rotation(__wf_atom_fa8d0177(groundPos, object2:GetPosition()).heading, 0, 0)
	))
	local v4 = __wf_atom_fa8d0177(
		object2:GetPosition(),
		Vector(entity:GetPosition().x, object2:GetPosition().y, entity:GetPosition().z)
	)
	local _ = entity:GetPosition() - __wf_atom_9341614d(__wf_atom_99c400ff2, v4)
	entity2:Teleport(object2:GetPosition(), v4)
	entity2:SetInstigatorAvatar(object2)
	entity2:__wf_atom_a3d2b66b(entity, Symbol("FishingRod"))
	entity2:FirePort("StartPlaying")
	module.WaitForCinematicToFinish(entity2)
	__wf_atom_7e8ad928(__wf_atom_f738b4af)
end

function DissolveOutQuestEntitiesWhenTriggerDone()
	if __wf_atom_7e8ad928(_T.QuestInteractCondition) or not _T.QuestInteractCondition[interactTaskTagID:c_str()] then
		local v4 = 0

		while v4 < 1 do
			v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93(), 0, 1)

			for _, v5 in pairs(actorInstances) do
				if v5:IsVisible() then
					v5:__wf_atom_68f2c268(v4)
				end
			end

			Sleep(0)
		end
	else
		for _, v4 in pairs(actorInstances) do
			v4:__wf_atom_68f2c268(0)
			v4:__wf_atom_a7ee9662(true, true)
		end
	end
end

function IntroToFishing(p)
	if not (fn(mOwner, p, true) and module.IsInOverworld()) then
		return
	end

	gGameData:__wf_atom_62924f25(true, false)
	module4.UpdateOrAddHudTask(mOwner, p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FishingIntroQuestSpot"))
	local v4

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		module3.AddQuestDestination(__wf_atom_0a6a5887, mOwner, p, Range(5, 3.4028234663852886e38))
		v4 = module2.CreateAreaMarkerAtPos(__wf_atom_0a6a5887:GetPosition(), 20, __wf_atom_28d5d4aa, mOwner, p)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_22020464 = loreFragment:__wf_atom_22020464()

	for i, v5 in ipairs(__wf_atom_22020464) do
		module.GiveLoreFragmentMemory(__wf_atom_c4f78a8f, loreFragment, v5, i == #__wf_atom_22020464)
	end

	__wf_atom_c4f78a8f:Attach(
		Type(tutorialTrigger),
		EMPTY_SYMBOL,
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		__wf_atom_c4f78a8f,
		1
	)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("FishingIntroQuest-HintToStart"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:Enable()
	end

	_T.WarsongFishing = true
	_T.WarsongFishingStarted = false
	_T.WarsongFishingLureEnteredWater = false
	_T.WarsongFishingHooked = false
	_T.WarsongFishingMinnowCaught = false
	_T.WarsongFishCaught = false
	_T.WarsongFishingCompleted = false
	local v5 = false
	local v6 = false
	local v7 = false

	while _T.WarsongFishingStarted ~= true do
		Sleep(0)
	end

	module5.PlayGlobalTransmission(transmissionSet, Symbol("SpinUp"), true)

	while _T.WarsongFishingCompleted ~= true do
		v5 = _T.WarsongFishingLureEnteredWater and not v5 and true or v5
		v6 = _T.WarsongFishingHooked and not v6 and true or v6
		v7 = _T.WarsongFishingMinnowCaught and not v7 and true or v7

		if _T.WarsongFishingEnded then
			break
		else
			Sleep(0)
		end
	end

	Sleep(2)
	_T.WarsongFishing = false
	module4.CompleteHudTask(mOwner, nil, p, module4.COMPLETETIME)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		module3.RemoveSparrowDestination(__wf_atom_0a6a5887, p)
	end

	if not __wf_atom_7e8ad928(v4) then
		module2.DestroyAreaMarker(v4)
	end

	module2.CompleteTaskWithID(mOwner, p)
end

function LightStatues(_)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("FishingStatueDeco"))

	for _, v4 in pairs(__wf_atom_2226b35c) do
		v4:Attach(statueLightFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v4, 1)
	end
end