local module = require("SF.Scripts.Libs.SparrowLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = nil

function DissolveOut(instance)
	Sleep(1)
	local total = 0

	while not __wf_atom_7e8ad928(instance) and total <= 3 do
		instance:__wf_atom_a763aa1a((math.min(total / 3, 1)))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function OpenNote(instance, object)
	local v2

	if instance:IsA(__wf_atom_0f45538d) then
		v2 = object:__wf_atom_a96eb2aa()
	else
		v2 = instance
		instance = object
	end

	if __wf_atom_7e8ad928(v2) or not v2:IsLocal() then
		return
	end

	local v3 = Localize(noteText:c_str(), nil)
	local v4 = __wf_atom_7e8ad928(customNoteBacker) and "" or customNoteBacker:__wf_atom_5b41f63b()
	local v5 = __wf_atom_7e8ad928(noteOverlayImage) and "" or noteOverlayImage:__wf_atom_5b41f63b()
	local v6 = __wf_atom_7e8ad928(noteCloseFX) and "" or noteCloseFX:__wf_atom_5b41f63b()

	if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(noteMovieRes) then
		v = __wf_atom_8e4fda44:__wf_atom_8b74c30b(noteMovieRes)
		v:__wf_atom_f62a8704("InitializeNote", {
			"",
			v3,
			"",
			tostring(hiddenText),
			tostring(hiddenTextType),
			v4,
			v5,
			v6
		})
	end

	if __wf_atom_7e8ad928(instance) then
		return
	end

	while not __wf_atom_7e8ad928(v) do
		Sleep(0)
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()
	local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(__wf_atom_0f520c3c)

	for _, v7 in ipairs(__wf_atom_f582136d) do
		v7:Destroy()
	end

	module.RemoveSparrowDestination(instance)

	if fadeOutNpc then
		__wf_atom_3d96ddcd:__wf_atom_8a035cd5(Symbol("DissolveOut"), false)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function EnableCannonLootAction(object)
	while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(WeakResource("/SF/Types/PickUps/LootContainers/Actions/LootChestBaseAction"))

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Enable()
	end

	if not __wf_atom_7e8ad928(projectorType) then
		object:Attach(projectorType, EMPTY_SYMBOL)
	end
end

function AttachBomb(object, object2)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d((WeakResource("/SF/Scripts/ModularObjectives/Components/PlacementOnlyDecos/BombPlacementOnlyDeco")))
	local nearestObject = module3.NearestObject(object2:GetPosition(), __wf_atom_f582136d, 3, true)

	if not __wf_atom_7e8ad928(nearestObject) then
		gRegion:CreateEntity(bombAttachType, nearestObject:GetPosition(), nearestObject:__wf_atom_dc309f8a()):AttachToInPlace(
			__wf_atom_3d96ddcd,
			EMPTY_SYMBOL
		)
	end

	__wf_atom_3d96ddcd:__wf_atom_8a035cd5(Symbol("EnableCannonLootAction"), false)
end

function BombAttachment(instance)
	local total = 0

	if not __wf_atom_7e8ad928(bombTimerSoundAttachment) then
		instance:Attach(bombTimerSoundAttachment, EMPTY_SYMBOL)
	end

	while not __wf_atom_7e8ad928(instance) and total < 5 do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(instance) or not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		if __wf_atom_3d96ddcd:IsA(__wf_atom_67c46eba) then
			__wf_atom_3d96ddcd:Suicide()
		else
			__wf_atom_3d96ddcd:Destroy()
		end
	end

	instance:Destroy()
end

function ApproachNpc(object)
	module2.PlayRadialTransmission(transmissionSet, transmissionTag, object:GetPosition(), dialogRadius)
end

function EnteredNpcMultiAvatarTrigger(object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_0f45538d)
	local position = __wf_atom_3d96ddcd:GetPosition()
	module2.PlayGlobalTransmission(transmissionSet, Symbol("RandomSneezeReveal"))
	__wf_atom_3d96ddcd:PlayTriggeredAnim(Symbol("PopUp"))
	__wf_atom_3d96ddcd:__wf_atom_d927a2a4(npcIdleAnim)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Enable()
	end

	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		local v2 = __wf_atom_fa8d0177(position, __wf_atom_7be51ede:GetPosition())
		v2.pitch = 0
		v2.bank = 0
		__wf_atom_3d96ddcd:Teleport(position, v2)
	end

	Sleep(1)
	local v2 = 0.5
	local flag = false

	while
		not __wf_atom_7e8ad928(object)
		and object:IsFull()
		and not __wf_atom_7e8ad928(__wf_atom_bb3e7833)
		and __wf_atom_bb3e7833:IsEnabled()
	do
		if _T.AvakotTalking then
			flag = true
		else
			if v2 <= 0 then
				if flag then
					if #npcAnimTags > 0 then
						__wf_atom_3d96ddcd:PlayTriggeredAnim(npcAnimTags[__wf_atom_5784a397(1, #npcAnimTags)])
					end
				else
					module2.PlayGlobalTransmission(transmissionSet, transmissionTag, false, true)
					flag = true
				end

				v2 = __wf_atom_5784a397(4, 6)
			end

			v2 -= 1
		end

		Sleep(1)
	end
end

function ExitedNpcMultiAvatarTrigger(object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_0f45538d)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:IsEnabled() then
		local total = 0

		while total < 3 do
			if total > 1 and object:IsFull() then
				return
			end

			total += __wf_atom_084b3e93()
			Sleep(0)
		end

		if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			return
		end

		__wf_atom_bb3e7833:Disable()
		__wf_atom_3d96ddcd:PlayTriggeredAnim(Symbol("IntoShell"))
		__wf_atom_3d96ddcd:__wf_atom_d927a2a4(npcDeactivatedIdleAnim)
	end
end

function TriggerTaleGenerator(object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_0f45538d)
	_T.currentJobBoard = __wf_atom_bb3e7833
end