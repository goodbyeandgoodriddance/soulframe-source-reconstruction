local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")

local function fn(object, p, p2)
	local __wf_atom_549749d8 = gRegion:__wf_atom_549749d8(sOdeFaction)

	for i = #__wf_atom_549749d8, 1, -1 do
		if __wf_atom_549749d8[i]:IsKilled() or p2 < __wf_atom_549749d8[i]:__wf_atom_1c8f7b2d(object) then
			table.remove(__wf_atom_549749d8, i)
		else
			local __wf_atom_30e3d82b = __wf_atom_549749d8[i]:__wf_atom_30e3d82b()

			if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_160c488b() then
				table.remove(__wf_atom_549749d8, i)
			elseif
				__wf_atom_30e3d82b:__wf_atom_8077d924() == 2
				and p < __wf_atom_549749d8[i]:__wf_atom_1c8f7b2d(object)
			then
				table.remove(__wf_atom_549749d8, i)
			elseif not __wf_atom_30e3d82b:__wf_atom_04ea4887() then
				__wf_atom_30e3d82b:__wf_atom_30b587a4()
			end
		end
	end

	return __wf_atom_549749d8
end

function FenceTrapTriggered(instance)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()
	local position = instance:GetPosition()
	gRegion:CreateEntity(fenceCollisionType, position, __wf_atom_80368bb1)
	Sleep(0.1)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local __wf_atom_4e28532a = instance:__wf_atom_4e28532a()
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = 10
	radialDamageData.stabilityDamage = 100
	radialDamageData.radius = __wf_atom_4e28532a
	radialDamageData:__wf_atom_98d98d81(position)
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	__wf_atom_3d96ddcd:Attach(threatSoundAttachment, EMPTY_SYMBOL)

	if isTrapChest then
		if not __wf_atom_7e8ad928(lockedChestFx) then
			__wf_atom_3d96ddcd:Attach(lockedChestFx, EMPTY_SYMBOL, Vector(0, 0.5, 0)):SetMeshScale(0.75)
		end
	else
		__wf_atom_3d96ddcd:__wf_atom_a887a262(fenceTrapMatSlot, fenceTrapActiveMaterial)
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(trapTag, position, 0, 30)

	for _, v in ipairs(__wf_atom_439c0d29) do
		if v ~= __wf_atom_3d96ddcd then
			gRegion:__wf_atom_dd1e4d10(v)
		end
	end

	local entity = gRegion:CreateEntity(fenceType, position, __wf_atom_80368bb1)
	Sleep(0.5)

	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		if not __wf_atom_7e8ad928(entity) then
			entity:Destroy()
		end
	else
		local all = gRegion:FindAll(__wf_atom_f806fd7a, instance:GetPosition(), 0, 200)
		local hint = module.GetHintWithRegisteredObject(all, __wf_atom_3d96ddcd)
		gRegion:__wf_atom_2202ffb6():__wf_atom_192b9cb0(2, 13, position, instance, 5, 30)
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		__wf_atom_7d789620:AddEncounter(encounterType)
		local __wf_atom_c4c644af = __wf_atom_7d789620:__wf_atom_c4c644af(position, encounterType, hint)

		if __wf_atom_7e8ad928(__wf_atom_c4c644af) then
			entity:PlayTriggeredFade()
		else
			__wf_atom_c4c644af:__wf_atom_b811702e(Symbol("FenceTrapEncounterHint"))
		end

		if isTrapChest then
			if not __wf_atom_7e8ad928(instance) then
				instance:Destroy()
			end
		else
			if not __wf_atom_7e8ad928(instance) then
				instance:Destroy()
			end

			if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				__wf_atom_3d96ddcd:Destroy()
			end
		end
	end
end

function OdeFence(object)
	Sleep(5)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local position = object:GetPosition()
	local count = 0

	while count < 300 and not __wf_atom_7e8ad928(object) do
		Sleep(1)
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local v = false

		for _, v2 in ipairs(__wf_atom_ef7900cf) do
			if v2:IsKilled() or not (v2:__wf_atom_1c8f7b2d(object) <= 10.5) then
				continue
			end

			v = true
		end

		if not v then
			Sleep(3)
			break
		end

		local v2

		if count > 20 then
			v2 = fn(object, 10.5, 10.5)
		else
			v2 = fn(object, 10.5, 40)
		end

		if #v2 == 0 then
			break
		else
			count += 1
		end
	end

	Sleep(2)

	if not __wf_atom_7e8ad928(object) then
		object:PlayTriggeredFade()
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("TrappedLootChest"), position, 0, 10)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		local taggedChild = module2.FindTaggedChild(__wf_atom_f738b4af:__wf_atom_be0bea4a(), Symbol("LootChestAction"))

		if not __wf_atom_7e8ad928(lockedChestFx) then
			local __wf_atom_bb3e7833 = __wf_atom_f738b4af:__wf_atom_bb3e7833(lockedChestFx)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end

		if not __wf_atom_7e8ad928(taggedChild) then
			taggedChild:Enable()
		end
	end

	local __wf_atom_f738b4af2 = gRegion:__wf_atom_f738b4af(Symbol("FenceTrapCollision"), position, 0, 2)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af2) then
		gRegion:__wf_atom_dd1e4d10(__wf_atom_f738b4af2)
	end
end