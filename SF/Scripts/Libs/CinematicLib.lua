local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")

function SetNonLocalAvatarVisibility()
	local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

	for _, v in pairs(__wf_atom_a8553251) do
		if not v:__wf_atom_4417a5d4() then
			v:__wf_atom_a7ee9662(setVisible, true)
		end
	end
end

function UseLocalAvatarOnlyForCinematic(object)
	local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

	for _, v in pairs(__wf_atom_a8553251) do
		if v:__wf_atom_4417a5d4() then
			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_a3d2b66b(v, Symbol("Envoy"))
			end
		else
			v:__wf_atom_a7ee9662(false, true)
		end
	end
end

function PreparePactBondCinematic(object)
	local v

	if __wf_atom_7e8ad928(__wf_atom_392793db) then
		v = gRegion:CreateEntity(envoyAvatarType, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	else
		v = __wf_atom_392793db:CreateEntity(envoyAvatarType, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	if __wf_atom_7e8ad928(v) then
		return
	end

	local __wf_atom_d2b2176d = v:__wf_atom_d2b2176d()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	v:__wf_atom_72cd7949((__wf_atom_c4f78a8f:__wf_atom_f115b657()))
	local v2

	if __wf_atom_7e8ad928(__wf_atom_392793db) then
		v2 = gRegion:CreateObject(suitType, v)
	else
		v2 = __wf_atom_392793db:CreateObject(suitType, v)
	end

	local __wf_atom_eb82ab1f = v2:__wf_atom_eb82ab1f()
	__wf_atom_eb82ab1f:SetSkin(helmType, 0)

	if not __wf_atom_7e8ad928(sleeveType) then
		__wf_atom_eb82ab1f:SetSkin(sleeveType, 1)
	end

	__wf_atom_eb82ab1f:SetSkin(chestType, 2)
	__wf_atom_eb82ab1f:SetSkin(legsType, 3)

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local __wf_atom_eb82ab1f2 = __wf_atom_e55d02aa:__wf_atom_eb82ab1f()
		__wf_atom_eb82ab1f:SetSkin(__wf_atom_eb82ab1f2:__wf_atom_035fdfa8(4), 4)
		__wf_atom_eb82ab1f:SetSkin(__wf_atom_eb82ab1f2:__wf_atom_035fdfa8(6), 6)
		__wf_atom_eb82ab1f:__wf_atom_2754430f(0, __wf_atom_eb82ab1f2:GetColors(0))
	end

	v2:SetCustomization(__wf_atom_eb82ab1f)
	__wf_atom_d2b2176d:GiveItem(v2, true)
	__wf_atom_d2b2176d:Update(0)
	__wf_atom_d2b2176d:__wf_atom_da1b89a8()
	v:__wf_atom_e5d015a7(Symbol("Envoy"))
	object:ReinitializeGreenRoom()
	object:PlaceGreenRoomEntities()
end

function UnequipWeapon(object)
	local __wf_atom_02a7a2f4 = object:__wf_atom_02a7a2f4()

	if not __wf_atom_7e8ad928(__wf_atom_02a7a2f4) then
		module.UnequipWeapon(__wf_atom_02a7a2f4, true)
		Sleep(0)
	end
end

function CreateCameraSpotAtLastCinePostion(_)
	local gameCamera = gRegion:GetGameCamera()
	gRegion:CreateEntity(cameraSpotType, gameCamera:GetPosition(), gameCamera:__wf_atom_dc309f8a()):__wf_atom_888efbe9(gameCamera:__wf_atom_c277aed8())
end

function CreateEntity(object, p, p2, p3)
	local v

	if __wf_atom_7e8ad928(p.Actors) then
		p.Actors = {}
		v = 1
	else
		v = #p.Actors
	end

	local entity = gRegion:CreateEntity(p2, object:GetPosition(), __wf_atom_80368bb1, nil, object, 1)

	if p3 and not __wf_atom_7e8ad928(entity) then
		entity:SetVisibility(false, true)
	end

	table.insert(p.Actors, v, entity)
end

function CreateActorsForCin(object, p, p2, p3)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local v = {}
	local v2 = {}
	local v3 = {}

	if type(p) == "table" or p == nil then
		v = p
	else
		table.insert(v, p)

		if p2 ~= nil and p2 ~= EMPTY_SYMBOL then
			table.insert(v2, p2)
		end

		if p3 ~= nil then
			table.insert(v3, p3)
		end
	end

	for k, v4 in pairs(v) do
		CreateEntity(object, __wf_atom_e919fb8e, v4)
		local typeInTable = module.FindTypeInTable(__wf_atom_e919fb8e.Actors, v4)

		if __wf_atom_7e8ad928(typeInTable) then
			continue
		end

		typeInTable:SetVisibility(true)
		object:__wf_atom_a3d2b66b(typeInTable, v2[k])

		if k <= #v3 and v3[k] > 0 then
			typeInTable:SetMeshScale(v3[k], true)
		end
	end
end

function CreateAttachedDeco(_, object, p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:Attach(object, object:__wf_atom_f5bac0e4())
end

function DestroyAttachedDeco(_, p, p2)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p2)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_0a6a5887:__wf_atom_bb3e7833(p)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
end

function DestroyEntityFromCinBlackboard(_, p, className)
	if p.Actors ~= nil and #p.Actors > 0 then
		for i, actor in ipairs(p.Actors) do
			if not actor:IsA(className) then
				continue
			end

			table.remove(p.Actors, i)
			actor:Destroy()
		end
	end
end

function SetEntitysAttachmentVisibility(p, p2, p3)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p2)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_0a6a5887:__wf_atom_bb3e7833(p3)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	__wf_atom_bb3e7833:SetVisibility(p, true)
end

function PlayCinTransmission()
	if not isLocal then
		module2.PlayGlobalTransmission(transmissionSet, transmission, true)
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module2.PlayLocalTransmission(transmissionSet, transmission, __wf_atom_c4f78a8f)
end