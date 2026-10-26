local v = nil
local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.TaleLib")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")

function ReadMessage(instance, p)
	if __wf_atom_7e8ad928(p) or not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_3d96ddcd:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.message) then
		__wf_atom_3d96ddcd:Destroy()
		return
	end

	__wf_atom_3d96ddcd:SetVisibility(false, true)
	local message = __wf_atom_e919fb8e.message
	local text = message.text or ""
	local v2 = StringSplit("+", text)
	local v3 = Localize(v2[1], false) or ""
	local v4 = Localize(v2[2], false) or ""
	local v5 = Localize("/SF/Language/Notes/MarkedPlayerMap", false)
	local noteBacker = message.noteBacker or defaultNoteBacker

	if not __wf_atom_7e8ad928(noteBacker) then
		noteBacker = noteBacker:__wf_atom_5b41f63b()
	end

	local v6 = nil

	if __wf_atom_7e8ad928(v6) and not __wf_atom_7e8ad928(noteMovieRes) then
		v6 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(noteMovieRes)
		v6:__wf_atom_f62a8704("InitializeNote", {
			v3,
			v4,
			v5,
			tostring(false),
			tostring(0),
			noteBacker,
			nil,
			nil
		})
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.PickupFunction) then
		__wf_atom_e919fb8e.PickupFunction()
	end

	while not __wf_atom_7e8ad928(v6) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		instance:Destroy()
	else
		__wf_atom_3d96ddcd:Destroy()
	end
end

function OnKilled(object)
	if __wf_atom_7e8ad928(v) then
		return
	end

	v:__wf_atom_e6ed03c8()
	v:__wf_atom_0ed81088(true)
	local v2 = Vector()
	gRegion:__wf_atom_c20d246a(
		v:GetPosition(),
		v:GetPosition() - Vector(0, 5, 0),
		{
			__wf_atom_4ebf67cb,
			__wf_atom_3feeb44a,
			__wf_atom_43e0c427,
			__wf_atom_7b01f9ce,
			__wf_atom_3feeb44a
		},
		nil,
		v2
	)

	if v2 == __wf_atom_28d5d4aa then
		local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(object:GetPosition())
		v:SetPosition(__wf_atom_0e0a6fee + Vector(0, 0.25, 0))
	end

	v:__wf_atom_03d03fec(false)
	v:__wf_atom_1b57cb83(false)
end

function SetupMessengerScroll(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	Sleep(1)
	local v2 = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntMessengerAgent")
	local v3 = nil
	local count = 0

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_7e8ad928(v3) do
		local __wf_atom_6199ef01 = __wf_atom_3d96ddcd:__wf_atom_6199ef01()

		for _, v4 in ipairs(__wf_atom_6199ef01) do
			if not v4:IsA(v2) then
				continue
			end

			v3 = v4
			break
		end

		count += 1

		if count > 10 then
			return
		else
			Sleep(1)
		end
	end

	if __wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		instance:Destroy()
		return
	end

	local __wf_atom_50a7d83e = v3:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled() then
		instance:Destroy()
		return
	end

	local v4 = nil
	local v5 = nil

	if not isTaleMessenger then
		local all = gRegion:FindAll(__wf_atom_f806fd7a, instance:GetPosition(), 0, 400)

		for _, v6 in ipairs(all) do
			local __wf_atom_1c8f7b2d = v6:__wf_atom_1c8f7b2d(instance)

			if not (__wf_atom_7e8ad928(v4) or __wf_atom_1c8f7b2d < v5) then
				continue
			end

			local __wf_atom_e919fb8e = v6:__wf_atom_e919fb8e()

			if __wf_atom_7e8ad928(__wf_atom_e919fb8e.messages) or not (#__wf_atom_e919fb8e.messages > 0) then
				continue
			end

			v5 = __wf_atom_1c8f7b2d
			v4 = v6
		end

		if __wf_atom_7e8ad928(v4) then
			instance:Destroy()
			return
		end
	end

	local v6 = Symbol("GAME_C1_RIFLEATTACH")
	v = __wf_atom_50a7d83e:Attach(objectType, v6, attachmentOffset, attachmentRotation)
	v:__wf_atom_0ed81088(false)
	__wf_atom_55142dd4(__wf_atom_50a7d83e, "OnKilled")

	if isTaleMessenger then
		local __wf_atom_bb3e7833 = v:__wf_atom_bb3e7833(__wf_atom_0f45538d)
		_T.currentJobBoard = __wf_atom_bb3e7833
	else
		local __wf_atom_e919fb8e = v4:__wf_atom_e919fb8e()
		local __wf_atom_e919fb8e2 = v:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e2.message = __wf_atom_e919fb8e.messages[1]

		function __wf_atom_e919fb8e2.PickupFunction(_)
			local hint = __wf_atom_e919fb8e2.message.hint

			if __wf_atom_7e8ad928(hint) or __wf_atom_7e8ad928(__wf_atom_e919fb8e2.message.markerType) then
				return
			end

			local position = hint:GetPosition()
			local entity = gRegion:CreateEntity(__wf_atom_e919fb8e2.message.markerType, position, __wf_atom_80368bb1)
			entity:__wf_atom_b811702e(Symbol("MessengerMarker"))
			hint:__wf_atom_d494454b(entity)
			module.RemoveMessengerIntel(hint, false)
		end

		table.remove(__wf_atom_e919fb8e.messages, 1)
	end

	__wf_atom_3d96ddcd:__wf_atom_d494454b(instance)
end

function SetupStaticNote(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	Sleep(1)
	local position = __wf_atom_3d96ddcd:GetPosition()
	local regionId = module3.GetRegionIdFromDensityVolume(position)
	local all = gRegion:FindAll(__wf_atom_f806fd7a, instance:GetPosition(), 0, 250)
	local v2 = nil
	local v3 = nil

	for _, v4 in ipairs(all) do
		local __wf_atom_1c8f7b2d = v4:__wf_atom_1c8f7b2d(instance)

		if not (v4 ~= __wf_atom_3d96ddcd and __wf_atom_1c8f7b2d >= 50 and (__wf_atom_7e8ad928(v2) or __wf_atom_1c8f7b2d < v3) and module3.GetRegionIdFromDensityVolume(v4:GetPosition()) == regionId) then
			continue
		end

		if __wf_atom_7e8ad928(v4:__wf_atom_e919fb8e().taleMessage) then
			continue
		end

		v3 = __wf_atom_1c8f7b2d
		v2 = v4
	end

	if __wf_atom_7e8ad928(v2) then
		instance:Destroy()
		return
	end

	local __wf_atom_e919fb8e = v2:__wf_atom_e919fb8e()
	local v4 = math.max(__wf_atom_3d96ddcd:__wf_atom_103377cc() + 5, 10)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(__wf_atom_e919fb8e.taleMessage.spawnTag, position, 0, v4)
	local position2 = nil
	local v5 = nil

	if #__wf_atom_439c0d29 == 0 then
		local mergeTables = module3.MergeTables(
			gRegion:__wf_atom_439c0d29(Symbol("RetrieveItemSpawnWithContainer"), position, 0, v4),
			gRegion:__wf_atom_439c0d29(Symbol("AnimalCageSpawn"), position, 0, v4)
		)
		local mergeTables2 = module3.MergeTables(
			mergeTables,
			module.GetAvailableLootChestSpawnsInRange(position, 0, v4)
		)

		if #mergeTables2 == 0 then
			instance:Destroy()
			return
		end

		local mergeTable = mergeTables2[__wf_atom_5784a397(1, #mergeTables2)]
		local position3 = mergeTable:GetPosition()
		local __wf_atom_dc309f8a = mergeTable:__wf_atom_dc309f8a()
		mergeTable:FirePort("Disable")
		__wf_atom_3d96ddcd:__wf_atom_d494454b((gRegion:CreateEntity(
			noteContainerTypes[__wf_atom_5784a397(1, #noteContainerTypes)],
			position3,
			__wf_atom_dc309f8a
		)))
		__wf_atom_439c0d29 = { gRegion:__wf_atom_f738b4af(__wf_atom_e919fb8e.taleMessage.spawnTag, position3, 0, 5) }
	end

	if __wf_atom_7e8ad928(position2) then
		local v6 = __wf_atom_439c0d29[__wf_atom_5784a397(1, #__wf_atom_439c0d29)]
		position2 = v6:GetPosition()
		v5 = v6:__wf_atom_dc309f8a()
	end

	v = gRegion:CreateEntity(__wf_atom_e919fb8e.taleMessage.pickupType, position2, v5)
	__wf_atom_3d96ddcd:__wf_atom_d494454b(v)
	__wf_atom_3d96ddcd:__wf_atom_d494454b(instance)
end

function SetupTaleStarter(instance)
	if math.random() > 0.75 then
		instance:Destroy()
		return
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if
		__wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a)
		or module2.ShouldStopEncounters()
	then
		instance:Destroy()
		return
	end

	if __wf_atom_3d96ddcd:__wf_atom_5b6b447d() ~= EMPTY_SYMBOL then
		instance:Destroy()
		return
	end

	if
		not __wf_atom_7e8ad928(_T.LastTaleNoteTime)
		and math.abs(gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9() - _T.LastTaleNoteTime) < 0.5
	then
		instance:Destroy()
		return
	end

	if not __wf_atom_7e8ad928(_T.ActiveTales) and #_T.ActiveTales > 0 then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			instance:Destroy()
			return
		end

		local regionId = module3.GetRegionIdFromDensityVolume(__wf_atom_c4f78a8f:GetPosition())
		local count = 0

		for _, activeTale in ipairs(_T.ActiveTales) do
			if activeTale.regionId == regionId and activeTale.state >= module2.STATE.ACCEPTED then
				count += 1
			end
		end

		if 0.5 ^ count < math.random() then
			instance:Destroy()
			return
		end
	end

	Sleep(1)
	local v2 = Symbol("TaleLedgerPlacementDeco")
	local position = __wf_atom_3d96ddcd:GetPosition()
	local v3 = math.max(__wf_atom_3d96ddcd:__wf_atom_103377cc() + 10, 20)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v2, position, 0, v3)
	local position2 = nil
	local v4 = nil

	if #__wf_atom_439c0d29 == 0 then
		local mergeTables = module3.MergeTables(
			gRegion:__wf_atom_439c0d29(Symbol("RetrieveItemSpawnWithContainer"), position, 0, v3),
			gRegion:__wf_atom_439c0d29(Symbol("AnimalCageSpawn"), position, 0, v3)
		)
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

		for i = #mergeTables, 1, -1 do
			local position3 = mergeTables[i]:GetPosition()

			if __wf_atom_7d789620:__wf_atom_0e0a6fee(position3, 0, 2, false) == position3 then
				table.remove(mergeTables, i)
			end
		end

		local mergeTables2 = module3.MergeTables(
			mergeTables,
			module.GetAvailableLootChestSpawnsInRange(position, 0, v3)
		)

		if #mergeTables2 == 0 then
			instance:Destroy()
			return
		end

		local mergeTable = mergeTables2[__wf_atom_5784a397(1, #mergeTables2)]
		local position3 = mergeTable:GetPosition()
		local __wf_atom_dc309f8a = mergeTable:__wf_atom_dc309f8a()
		mergeTable:FirePort("Disable")
		__wf_atom_3d96ddcd:__wf_atom_d494454b((gRegion:CreateEntity(
			noteContainerTypes[__wf_atom_5784a397(1, #noteContainerTypes)],
			position3,
			__wf_atom_dc309f8a
		)))
		__wf_atom_439c0d29 = { gRegion:__wf_atom_f738b4af(v2, position3, 0, 5) }
	end

	if __wf_atom_7e8ad928(position2) then
		local v5 = __wf_atom_439c0d29[__wf_atom_5784a397(1, #__wf_atom_439c0d29)]
		position2 = v5:GetPosition()
		v4 = v5:__wf_atom_dc309f8a()
	end

	v = gRegion:CreateEntity(noteTypes[__wf_atom_5784a397(1, #noteTypes)], position2, v4)
	local __wf_atom_bb3e7833 = v:__wf_atom_bb3e7833(__wf_atom_0f45538d)
	__wf_atom_3d96ddcd:__wf_atom_d494454b(v)
	__wf_atom_3d96ddcd:__wf_atom_d494454b(instance)
	_T.currentJobBoard = __wf_atom_bb3e7833
	_T.LastTaleNoteTime = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
end