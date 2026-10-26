local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.RaycastLib")
local module3 = require("SF.Scripts.Effects.EnvoyEffects")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
local module5 = require("SF.Scripts.Libs.ConversationLib")
local v = Resource("/Lotus/Types/Input/DialogInputFilter")
local v2 = nil
local v3 = nil
local selectedChoice = nil

function StartDynamicEncounter()
	local v4 = nil

	if gRegion:IsMaster() then
		if __wf_atom_7e8ad928(v4) then
			v4 = module.WaitForAiDir()
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(hintTag)

		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(encounterType)) then
			v4:AddEncounter(encounterType)
			v4:__wf_atom_c4c644af(__wf_atom_0a6a5887:GetPosition(), encounterType, __wf_atom_0a6a5887)
		end
	end
end

function ArmTranstiton(p)
	module3.ArmTransition(p, true, armTransitionTime, armSpeedMult, true, transtionBackDelay)
end

function PlantPlacement(object, object2)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	object:Disable()

	if object2:__wf_atom_4417a5d4() then
		__wf_atom_d2b2176d:Unequip(0, 1)
	end

	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	object2:__wf_atom_3c986cd9(module2.GetGroundPos(position), __wf_atom_dc309f8a, true)
	object2:__wf_atom_921c1a5f(plantingDropAnim, false, 4, 1, false)
	object2:__wf_atom_8a035cd5(Symbol("ArmTranstiton"), false)
	object2:__wf_atom_8914dfde("Unlocked", 5)

	if not __wf_atom_7e8ad928(plantPlacementDeco) then
		plantPlacementDeco:FirePort("Show")

		if not __wf_atom_7e8ad928(plantPlacementSound) then
			plantPlacementDeco:PlaySound(plantPlacementSound, false, 1, false)
		end
	end
end

function PlayContextActionAnimation(object, instance)
	if unequipWeapon then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		module.UnequipWeapon(__wf_atom_c4f78a8f, true)
	end

	if rotateToFaceContextAction then
		local position = instance:GetPosition()
		local position2 = object:GetPosition()
		local v4 = position2 + __wf_atom_9341614d(object:__wf_atom_d32e11f8(), object:__wf_atom_dc309f8a())
		position.y = position2.y
		local v5 = object:__wf_atom_3d96ddcd() or object

		if not __wf_atom_7e8ad928(v5) then
			local position3 = v5:GetPosition()
			position3.y += position2.y
			local v6 = {
				__wf_atom_4ebf67cb,
				__wf_atom_3feeb44a,
				__wf_atom_43e0c427,
				__wf_atom_7b01f9ce,
				__wf_atom_3feeb44a
			}
			local v7 = Vector()
			gRegion:__wf_atom_c20d246a(position, position2, v6, nil, v7)

			if v7 ~= __wf_atom_28d5d4aa then
				v4 = v7
			end
		end

		local v6 = v4 + __wf_atom_9341614d(Vector(0, 0, 0.5), __wf_atom_fa8d0177(v4, position))
		local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v6)
		instance:__wf_atom_3c986cd9(__wf_atom_0e0a6fee, __wf_atom_fa8d0177(__wf_atom_0e0a6fee, v4), true)
	end

	local loopTimeForPlayer = loopTimeForPlayer

	if instance:IsA(__wf_atom_9e85eea2) then
		object:__wf_atom_b87ba8f0(false, true)
		loopTimeForPlayer = loopTimeForNpc
	else
		object:__wf_atom_b87ba8f0(true, false)
	end

	instance:__wf_atom_921c1a5f(startAnim, true, 4, 1, true, 1)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	if not __wf_atom_7e8ad928(loopAnim) then
		instance:__wf_atom_921c1a5f(loopAnim, true, 4, 2, false)
		Sleep(loopTimeForPlayer)

		if __wf_atom_7e8ad928(instance) then
			return
		end
	end

	if not __wf_atom_7e8ad928(stopAnim) then
		instance:__wf_atom_921c1a5f(stopAnim, true, 4, 1, false)
	end

	Sleep(0)

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_b87ba8f0(true, true)
	end
end

function DeliverResources(object)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		local __wf_atom_d2b2176d = __wf_atom_7be51ede:__wf_atom_d2b2176d()
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.itemsDelivered) then
			__wf_atom_e919fb8e.itemsDelivered = 0
		end

		if __wf_atom_e919fb8e.amountsToDeliver == nil then
			__wf_atom_e919fb8e.amountsToDeliver = amountsToDeliver
		end

		if __wf_atom_e919fb8e.deliverResources == nil then
			__wf_atom_e919fb8e.deliverResources = deliverResources
		end

		if __wf_atom_e919fb8e.deliveriesCompleted == nil then
			__wf_atom_e919fb8e.deliveriesCompleted = 0
		end

		if __wf_atom_e919fb8e.amountsDelivered == nil then
			__wf_atom_e919fb8e.amountsDelivered = {}

			for _ = 1, #__wf_atom_e919fb8e.amountsToDeliver do
				table.insert(__wf_atom_e919fb8e.amountsDelivered, 0)
			end
		end

		if __wf_atom_e919fb8e.numberOfDeliveriesRequired == nil then
			__wf_atom_e919fb8e.numberOfDeliveriesRequired = #__wf_atom_e919fb8e.amountsToDeliver
		end

		if #__wf_atom_e919fb8e.deliverResources > 0 and #__wf_atom_e919fb8e.amountsToDeliver > 0 then
			for i, _ in ipairs(__wf_atom_e919fb8e.amountsToDeliver) do
				for _ = 1, __wf_atom_d2b2176d:__wf_atom_ee725e9c(__wf_atom_e919fb8e.deliverResources[i], true, true) do
					if
						__wf_atom_e919fb8e.amountsDelivered ~= nil
						and __wf_atom_e919fb8e.amountsDelivered[i] < __wf_atom_e919fb8e.amountsToDeliver[i]
					then
						__wf_atom_d2b2176d:__wf_atom_5106368a(__wf_atom_e919fb8e.deliverResources[i])
						__wf_atom_e919fb8e.amountsDelivered[i] = __wf_atom_e919fb8e.amountsDelivered[i] + 1

						if __wf_atom_e919fb8e.amountsDelivered[i] >= __wf_atom_e919fb8e.amountsToDeliver[i] then
							table.remove(__wf_atom_e919fb8e.amountsToDeliver, i)
							table.remove(__wf_atom_e919fb8e.deliverResources, i)
							table.remove(__wf_atom_e919fb8e.amountsDelivered, i)
							__wf_atom_e919fb8e.deliveriesCompleted += 1
						end
					end

					if __wf_atom_e919fb8e.deliveriesCompleted ~= __wf_atom_e919fb8e.numberOfDeliveriesRequired then
						continue
					end

					__wf_atom_e919fb8e.deliveryComplete = true
					object:Disable()
					break
				end
			end
		end

		if not (__wf_atom_7e8ad928(deliverResource) or __wf_atom_7e8ad928(__wf_atom_7be51ede)) then
			local __wf_atom_ee725e9c = __wf_atom_d2b2176d:__wf_atom_ee725e9c(deliverResource, true, true)

			if __wf_atom_e919fb8e.amountToDeliver == nil then
				__wf_atom_e919fb8e.amountToDeliver = amountToDeliver
			end

			while __wf_atom_ee725e9c > 0 do
				if __wf_atom_e919fb8e.itemsDelivered < __wf_atom_e919fb8e.amountToDeliver then
					__wf_atom_d2b2176d:__wf_atom_5106368a(deliverResource)
					__wf_atom_e919fb8e.itemsDelivered += 1

					if __wf_atom_e919fb8e.itemsDelivered >= __wf_atom_e919fb8e.amountToDeliver then
						__wf_atom_e919fb8e.deliveryComplete = true
						object:Disable()
						return
					end
				end

				if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
					return
				end

				__wf_atom_ee725e9c = __wf_atom_d2b2176d:__wf_atom_ee725e9c(deliverResource, true, true)
				Sleep(0)
			end
		end
	end
end

function PresentChoices(object, instance)
	if not gGameData or instance:IsA(__wf_atom_9e85eea2) then
		return
	end

	if __wf_atom_7e8ad928(v3) then
		v3 = module.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("ConversationCamera"))
	end

	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	instance:__wf_atom_dd875cd8(true)
	instance:__wf_atom_aeb02c14(v)
	module.UnequipWeapon(instance, false)
	module4.CloseTransmissions()
	v2 = module5.CreateConversation(Localize(tostring(titleText), false), v3)

	if __wf_atom_7e8ad928(v2) then
		return
	end

	v2:Start()
	local choices = {}

	for _, text in ipairs(choiceStrings) do
		local _ = "Choice" .. tostring(text)
		local v4 = { Text = text }
		v4.Text = Localize(v4.Text, false)

		function v4.Callback()
			selectedChoice = v4
		end

		table.insert(choices, v4)
	end

	v2:SetChoices(choices)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.choices = choices

	while v2:Update() and not __wf_atom_7e8ad928(instance) do
		if selectedChoice == nil then
			Sleep(0)
		else
			v2:SetChoices(nil)
			break
		end
	end

	if __wf_atom_7e8ad928(instance) then
		return
	end

	object:Disable()
	v2:Close()

	if not __wf_atom_7e8ad928(instance) then
		if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
			__wf_atom_7470861b:__wf_atom_63396172(Symbol("Invulnerable"))
		end

		instance:__wf_atom_cf966a74(v)
		instance:__wf_atom_dd875cd8(false)
	end

	__wf_atom_e919fb8e.selectedChoice = selectedChoice
end

function ActivateParentGameplayObject(object, p)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			__wf_atom_3d96ddcd:Activate()

			if setOwner and not __wf_atom_7e8ad928(p) then
				__wf_atom_3d96ddcd:SetOwner(p)
			end
		end
	end
end