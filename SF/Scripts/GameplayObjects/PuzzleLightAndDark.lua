local v = WeakResource("/SF/Weapons/Melee/OneHand/Torch/TorchPickUpMeleeWeapon")
local v2 = WeakResource("/SF/Weapons/Melee/OneHand/Torch/TorchOffPickUpMeleeWeapon")
local v3 = WeakResource("/SF/Types/Gameplay/Puzzles/Attachments/PuzzleTorchLitBrazierAction")
local v4 = WeakResource("/SF/Types/Gameplay/Puzzles/Attachments/PuzzleTorchUnlitBrazierAction")

local function fn(object, p)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local v5, torchLitPickUpType2

	if p then
		v5 = v2
		torchLitPickUpType2 = torchLitPickUpType
	else
		v5 = v
		torchLitPickUpType2 = torchUnlitPickUpType
	end

	if not object:HasItem(v5) then
		return
	end

	if gRegion:IsMaster() then
		__wf_atom_d2b2176d:RemoveItem(4, true)
		local entity = gRegion:CreateEntity(torchLitPickUpType2, object:GetPosition(), __wf_atom_80368bb1, object)
		object:__wf_atom_d2b2176d():PickUpItem(entity, true, true)
	end

	if not __wf_atom_7e8ad928(swapEffect) then
		local v6 = object:Attach(swapEffect, Symbol("GAME_R1_FINGER9"))

		if not (__wf_atom_7e8ad928(v6) or v6:IsActive()) then
			v6:FirePort("Enable")
		end
	end
end

function PickUpUnlitTorch(_, object)
	object:__wf_atom_d2b2176d()

	if not object:HasItem(v2) and not object:HasItem(v) and gRegion:IsMaster() then
		local entity = gRegion:CreateEntity(torchUnlitPickUpType, object:GetPosition(), __wf_atom_80368bb1)
		object:__wf_atom_d2b2176d():PickUpItem(entity, true, true)
	end

	if not __wf_atom_7e8ad928(playerTouchAnim) then
		object:__wf_atom_921c1a5f(playerTouchAnim, true, 3, 1, true)
	end
end

function TorchTurnOn(_, object)
	if not __wf_atom_7e8ad928(playerTouchAnim) then
		object:__wf_atom_921c1a5f(playerTouchAnim, true, 3, 1, true)
	end

	fn(object, true)
end

function TorchTurnOff(_, p)
	fn(p, false)
end

function TorchTurnOffInShallowWater(_, instance)
	if instance:__wf_atom_1bb5b1ff() == torchLitPickUpType then
		local position = instance:GetPosition()
		local __wf_atom_dc309f8a = instance:__wf_atom_dc309f8a()
		instance:Destroy()
		local entity = gRegion:CreateEntity(torchUnlitPickUpType, position, __wf_atom_dc309f8a)

		if not (__wf_atom_7e8ad928(swapEffect) or __wf_atom_7e8ad928(entity)) then
			local v5 = entity:Attach(swapEffect, EMPTY_SYMBOL)

			if not (__wf_atom_7e8ad928(v5) or v5:IsActive()) then
				v5:FirePort("Enable")
			end
		end
	end
end

function TriggerPortIfTorchIsLit(_, object)
	if object:HasItem(v) and not (__wf_atom_7e8ad928(portToFire) or __wf_atom_7e8ad928(portName)) then
		portToFire:FirePort(portName)
	end
end

function ChangeLightmapTintFade()
	Sleep(Delay)
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess

	if postVolumeTag:__wf_atom_8598f3a9() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(postVolumeTag)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			postProcess = __wf_atom_0a6a5887:__wf_atom_e35eb214()
		end
	end

	local v5 = Color(255, 255, 255)
	local v6 = Color(40, 40, 40)
	local v7 = 0

	while v7 < 1 do
		v7 = __wf_atom_421b01aa(v7 + __wf_atom_084b3e93() / fadeTime, 0, 1)
		postProcess.lightMapTint = v5:__wf_atom_104bfe98(v6, v7)
		postProcess.zoneMapTint = startTint:__wf_atom_104bfe98(endTint, v7)
		Sleep(0)
	end
end

function ChangeLightmapTintFadeTargeted()
	Sleep(Delay)
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess

	if postVolumeTag:__wf_atom_8598f3a9() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(postVolumeTag)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			postProcess = __wf_atom_0a6a5887:__wf_atom_e35eb214()
		end
	end

	local v5 = 0

	while v5 < TimeLength and not __wf_atom_7e8ad928(postProcess) do
		v5 = __wf_atom_421b01aa(v5 + __wf_atom_084b3e93() / fadeTime, 0, 1)
		postProcess.lightMapTint = startTint:__wf_atom_104bfe98(endTint, v5)
		postProcess.zoneMapTint = startTint:__wf_atom_104bfe98(endTint, v5)
		Sleep(0)
	end
end

function LightBrazier(object)
	local v5 = nil
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v3)
	local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(v4)
	local __wf_atom_b81a6e66 = object:__wf_atom_b81a6e66()

	if not (__wf_atom_7e8ad928(__wf_atom_bb3e7833) or __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) or __wf_atom_7e8ad928(object)) then
		if __wf_atom_b81a6e66 or isBrazierLit then
			__wf_atom_bb3e7833:Enable()
			__wf_atom_bb3e7833_2:Disable()
			object:Activate()
		else
			__wf_atom_bb3e7833:Disable()
			__wf_atom_bb3e7833_2:Enable()
			object:Deactivate()
		end
	end

	while not __wf_atom_7e8ad928(object) do
		if not object:IsEnabled() then
			__wf_atom_bb3e7833_2:Disable()
			break
		end

		if object:__wf_atom_b81a6e66() ~= __wf_atom_b81a6e66 then
			if not __wf_atom_7e8ad928(litImmediateFx) then
				local entity = gRegion:CreateEntity(
					litImmediateFx,
					object:GetPosition() + litFxOffset,
					object:__wf_atom_dc309f8a()
				)

				if not __wf_atom_7e8ad928(entity) then
					entity:Enable()
				end
			end

			if object:__wf_atom_b81a6e66() then
				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Enable()

					if not __wf_atom_7e8ad928(litPersistantFx) then
						v5 = gRegion:CreateEntity(
							litPersistantFx,
							object:GetPosition() + litFxOffset,
							object:__wf_atom_dc309f8a()
						)
					end
				end
			else
				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Disable()
				end

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
					__wf_atom_bb3e7833_2:Enable()
				end

				if not __wf_atom_7e8ad928(v5) then
					v5:FirePort("Destroy")
				end
			end

			__wf_atom_b81a6e66 = object:__wf_atom_b81a6e66()
		end

		Sleep(0.1)
	end
end

function AddFireEffectToChild(object)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(childType)
	local v5 = {}

	for _, v6 in pairs(__wf_atom_f582136d) do
		if __wf_atom_7e8ad928(v6) then
			continue
		end

		if not v6:__wf_atom_a586ea4c(attachmentType) then
			table.insert(v5, v6)
			v6:Attach(attachmentType, attachBoneSymbol, attachPosition, attachRotation)
		end

		if not v6:__wf_atom_a586ea4c(attachmentSoundSequencer) then
			v6:Attach(attachmentSoundSequencer, attachBoneSymbol, attachPosition, attachRotation)
		end
	end
end

function BurningRopeOnEnabled(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:MakeVulnerable()
	object:FirePort("Show")
	local v5 = object:GetPosition() + object:__wf_atom_acb19668() * burningRopeOffset
	local entity = gRegion:CreateEntity(staticRopeType, v5, __wf_atom_80368bb1, object)

	if not __wf_atom_7e8ad928(burningRopeEndPointEntity) then
		entity:__wf_atom_b2394158(burningRopeEndPointEntity, EMPTY_SYMBOL)
	end

	while not (__wf_atom_7e8ad928(object) or object:__wf_atom_b81a6e66()) do
		if object:IsEnabled() then
			Sleep(0.1)
		else
			if not __wf_atom_7e8ad928(entity) then
				entity:Destroy()
			end

			object:FirePort("Hide")
			object:MakeInvulnerable()
			return
		end
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:Destroy()
		entity = gRegion:CreateEntity(burningRopeType, v5, __wf_atom_80368bb1, object)

		if not __wf_atom_7e8ad928(burningRopeEndPointEntity) then
			entity:__wf_atom_b2394158(burningRopeEndPointEntity, EMPTY_SYMBOL)
		end
	end

	_T.SiegeBurningStartSymbol = siegeSymbol
	Sleep(burningRopeIgnitionTime)
	burningRopeEndPointEntity:Destroy()
	Sleep(burningRopeDestructionTime - burningRopeIgnitionTime)
	entity:Destroy()
	_T.BurnedRopeSymbol = siegeSymbol
	object:Deactivate()
	object:Disable()
	object:FirePort("Hide")
end

function BurningRopeOnHit(object, object2)
	if gRegion:IsMaster() and not __wf_atom_7e8ad928(object) then
		object:SetHealth((object:__wf_atom_95174740()))

		if not __wf_atom_7e8ad928(object2) then
			local __wf_atom_679ed446 = object2:__wf_atom_679ed446()

			if
				__wf_atom_679ed446:IsA(__wf_atom_67c46eba)
				and __wf_atom_679ed446:HasItem(v)
				and not __wf_atom_7e8ad928(object)
				and object:IsEnabled()
			then
				object:Activate()
				object:MakeInvulnerable()
			end
		end
	end
end