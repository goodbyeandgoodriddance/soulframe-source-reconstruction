local module = require("SF.Scripts.Libs.StatsLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Interface.Libs.MusicCommon")
local module5 = require("SF.Scripts.NightFoldLib")
local module6 = require("SF.Scripts.Libs.EncounterLib")
local module7 = require("SF.Scripts.Libs.TransmissionSet")
local module8 = require("SF.Interface.SFUtilities")
local module9 = require("SF.Scripts.Libs.DungeonLocationInfo")
local module10 = require("SF.Scripts.Libs.PlayerPetLib")
local v = {
	Resource("/SF/Types/Game/GraceBooster"),
	Resource("/SF/Types/Game/CourageBooster"),
	Resource("/SF/Types/Game/SpiritBooster")
}
local v2 = false
local perfectPerformanceFX2 = nil
local flag = false
local v3 = nil
local v4 = nil

local function fn()
	local cameraControl = v3:CameraControl()

	if __wf_atom_7e8ad928(camSpot) then
		camSpot = gRegion:__wf_atom_f738b4af(Symbol("ChestCamera"), v3:__wf_atom_8992aa91(), 0, 5)
	end

	if v3:__wf_atom_4417a5d4() and not (__wf_atom_7e8ad928(cameraControl) or __wf_atom_7e8ad928(camSpot)) then
		cameraControl:SetCameraSpot(camSpot, 1.5)
		cameraControl:__wf_atom_fd14c463(0.7)
		camSpot:__wf_atom_802e6d6a(99999)
		camSpot:Activate()
	end
end

local function fn2()
	local cameraControl = v3:CameraControl()

	if __wf_atom_7e8ad928(camSpot) then
		camSpot = gRegion:__wf_atom_f738b4af(Symbol("ChestCamera"), v3:__wf_atom_8992aa91(), 0, 5)
	end

	local __wf_atom_2f2bada0 = camSpot:__wf_atom_2f2bada0()
	v3:__wf_atom_51075230(__wf_atom_2f2bada0)

	if not cameraControl:__wf_atom_c8c5ba0a() then
		cameraControl:__wf_atom_fd14c463(0.7)
	end

	cameraControl:SetCameraSpot(nil, 0.7)

	if __wf_atom_7e8ad928(v3) then
	end
end

function Initialize()
	_T.PreviousInt = 0
	local v5 = {}
	table.insert(v5, {
		Label = "/Lotus/Language/Menu/Global_Back",
		CallBack = Close,
		CallOut = "MENU_CANCEL"
	})

	if not (__wf_atom_7e8ad928(_T.SetButtons) or __wf_atom_7e8ad928(_T.BackgroundMovie)) then
		_T.SetButtons(_T.BackgroundMovie, v5, getfenv(1))
	end

	module7.GetCurTransmission()

	while flag == false do
		if __wf_atom_7e8ad928(v3) then
			break
		end

		if module7.TransmissionPlaying() then
			Sleep(0)
		else
			Close()
			break
		end
	end
end

function Close()
	if flag then
		return
	end

	module8.RegisterHideHud(false)
	flag = true

	if not (__wf_atom_7e8ad928(_T.SetButtons) or __wf_atom_7e8ad928(_T.BackgroundMovie)) then
		_T.SetButtons(_T.BackgroundMovie, nil)
	end

	v3:__wf_atom_cf966a74(blockMovementInput)
	Sleep(0)
	fn2()
end

local function fn3(list, tag)
	for _, v5 in ipairs(list) do
		if v5:HasTag(tag) then
			return v5
		end
	end
end

function Wiggle(object)
	local v5 = Vector()
	local v6 = Rotation()
	local v7 = 0

	while v7 < 1 do
		v7 = __wf_atom_421b01aa(v7 + __wf_atom_084b3e93(), 0, 1)
		local v8 = 1 - v7
		local v9 = Noise(Time() * 1)
		local v10 = Noise(3 + Time() * 1)
		local v11 = Noise(7 + Time() * 1)
		local v12 = math.pow(v8, 4)
		local position = object:GetPosition()
		local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
		local v13 = Vector(v9 * 0, math.abs(v10) * v12 * 0.4, v11 * 0)
		local v14 = Rotation(v9 * 10 * v12, v10 * 20 * v12, v11 * 10 * v12)
		object:SetPosition(position - v5 + v13)
		object:__wf_atom_9b788a35(__wf_atom_dc309f8a - v6 + v14)
		Sleep(0)
		v6 = v14
		v5 = v13
	end
end

function EvaluateAction(_, instance)
	if not (loreDisqualifies and instance:IsA(__wf_atom_4ebf67cb)) then
		return true
	end

	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()

	for i = 1, #loreRewards do
		local loreReward = loreRewards[i]
		local __wf_atom_22020464 = loreReward:__wf_atom_22020464()
		local v5 = loreMemoryIdx[i]
		local unlockedMemories = __wf_atom_d2b2176d:GetUnlockedMemories(loreReward) or {}

		if v5 and v5 > 0 and v5 <= #__wf_atom_22020464 then
			if unlockedMemories[v5] == __wf_atom_22020464[v5] then
				return false
			end
		elseif #unlockedMemories > 0 then
			return false
		end
	end

	return true
end

function EvaluateShrineStatus(object)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()

	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		Sleep(0)
	end

	if not EvaluateAction(object, __wf_atom_c4f78a8f) then
		object:Disable()
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			print("No parent deco for music chest action")
			return
		end

		local v5 = fn3(__wf_atom_3d96ddcd:__wf_atom_be0bea4a(), Symbol("Statue"))

		if __wf_atom_7e8ad928(v5) then
			print("Statue deco cannot be found as attached child")
			return
		end

		for _, v6 in ipairs(removeAttachmentTypes) do
			local __wf_atom_f582136d = v5:__wf_atom_f582136d(v6)

			for _, v7 in ipairs(__wf_atom_f582136d) do
				v7:Destroy()
			end
		end

		v5:__wf_atom_b811702e(EMPTY_SYMBOL)
		v5:SetMaterialParam(Symbol("EmissiveMapAtten"), 5)
		v5:__wf_atom_9e6bceb0(0, 0.4)
	end
end

local function fn4(instance, p, __wf_atom_28d5d4aa2)
	local v5 = p or dropTable

	if __wf_atom_7e8ad928(v5) then
		local v6 = __wf_atom_7e8ad928(v4) and "" or v4:__wf_atom_5b41f63b()
		print("Drop or loot (" .. v6 .. ") that doesn't have a dropTable! (So the players will collect nothing from it)")
	elseif gRegion:IsMaster() then
		local __wf_atom_e93896ba = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e93896ba(0)
		local enemyLevel = module6.GetEnemyLevel(instance)
		local v6 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)

		if dropLootScattered and not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_4ebf67cb) then
			v5:__wf_atom_6ba3aebe(instance, __wf_atom_e93896ba, v6, __wf_atom_28d5d4aa2)
		end

		if dropLootForInstigatorOnly and not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_4ebf67cb) then
			v5:__wf_atom_0ad20b11(instance, instance, __wf_atom_e93896ba, v6)
		elseif giveDirectlyToPlayers then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

			for i = 1, #__wf_atom_ef7900cf do
				local v7 = __wf_atom_ef7900cf[i]

				if
					not (__wf_atom_ef7900cf[i]:__wf_atom_a5304c35(v4:GetPosition()) < maxRewardDistance)
					or HasPlayerAquiredLootAllready(v7)
				then
					continue
				end

				v5:__wf_atom_0ad20b11(v7, __wf_atom_c4f78a8f, __wf_atom_e93896ba, v6)
			end
		elseif not __wf_atom_7e8ad928(instance) then
			if __wf_atom_7e8ad928(__wf_atom_28d5d4aa2) then
				__wf_atom_28d5d4aa2 = __wf_atom_28d5d4aa
			end

			v5:__wf_atom_6ba3aebe(instance, __wf_atom_e93896ba, v6, __wf_atom_28d5d4aa2)
		end

		_T.idleTimoutReset = true
	end
end

local function fn5(object, instance)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if openChestForInstigatorOnly then
		if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_4ebf67cb) then
			object:__wf_atom_3cbeb789(instance:__wf_atom_a96eb2aa())
		end
	else
		object:Enable()
	end
end

local function fn6(object, instance)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if openChestForInstigatorOnly then
		if instance:IsA(__wf_atom_4ebf67cb) then
			object:__wf_atom_e95c24e1(instance:__wf_atom_a96eb2aa())
		end
	else
		object:Disable()
	end
end

local function fn7(instance)
	if __wf_atom_7e8ad928(instance) or not openChestForInstigatorOnly then
		return true
	end

	return instance:__wf_atom_631bafa1()
end

function BlockInputFilter(object)
	object:__wf_atom_aeb02c14(blockMovementInput)
	Sleep(0)

	if object:__wf_atom_08998754() == 4 then
		if not __wf_atom_7e8ad928(playerCrouchedLootingAnim) then
			while object:__wf_atom_c138b19b(playerCrouchedLootingAnim) do
				Sleep(0)
			end
		end
	elseif not __wf_atom_7e8ad928(playerLootingAnim) then
		while object:__wf_atom_c138b19b(playerLootingAnim) do
			Sleep(0)
		end
	end

	if not (__wf_atom_7e8ad928(lootTransmissionSet) or __wf_atom_7e8ad928(transmissionSymbol)) then
		Sleep(transmissionDelay)
		local __wf_atom_b4a422ed = lootTransmissionSet:__wf_atom_b4a422ed(transmissionSymbol)

		if not __wf_atom_7e8ad928(__wf_atom_b4a422ed) then
			local name = __wf_atom_b4a422ed:GetName()

			while
				not __wf_atom_7e8ad928(_T.curTransmission)
				and _T.curTransmission:GetName() == name
				and flag == false
			do
				Sleep(0)
			end
		end
	end

	object:__wf_atom_cf966a74(blockMovementInput)
end

function ShouldDestroyLootContainer(p, object)
	if not removeLootContainer or not gRegion:IsMaster() or _G.resetChestDebug then
		return false
	end

	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(object) then
		return false
	end

	if not openChestForInstigatorOnly then
		return true
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v5 in pairs(__wf_atom_3c8e1a7a) do
		if not object:__wf_atom_c5ea85f0(v5) then
			return false
		end
	end

	return true
end

function DestroyLootContainer(instance, object)
	object:Disable()
	instance:SetVisibility(false)
	Sleep(10)
	instance:Destroy()
end

function PreventLootingWhileCrouched(_, object)
	return object:__wf_atom_08998754() ~= 4
end

function HasPlayerAquiredLootAllready(object)
	if checkForLoreEntry == false then
		return false
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if
		__wf_atom_7e8ad928(__wf_atom_d2b2176d)
		or not __wf_atom_d2b2176d:__wf_atom_705a2744(chestLoreFragementRes, loreMemeorySymbol)
	then
		return false
	end

	return true
end

function NotifyChallenge(p)
	print("NotifyChallenge", challengeTag)

	if challengeTag == Symbol() then
		return
	end

	for _, v5 in not __wf_atom_7e8ad928(p) and { p } or gRegion:__wf_atom_a8553251() do
		__wf_atom_539492fe:__wf_atom_c2038c7a(v5, challengeTag)
	end
end

function LootChest(object, instance)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	fn6(object, instance)
	v3 = instance
	v4 = object

	if unequipWeapon and gRegion:IsMaster() then
		module2.UnequipWeapon(instance, unequipInstant)
	end

	local v5 = instance:__wf_atom_08998754() == 4

	if useCameraSpot and fn7(instance) then
		fn()
	end

	if not __wf_atom_7e8ad928(playerLootingAnim) then
		instance:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")
		instance:__wf_atom_8a035cd5(Symbol("BlockInputFilter"), false)
		local playerCrouchedLootingAnim2

		if v5 and not __wf_atom_7e8ad928(playerCrouchedLootingAnim) then
			playerCrouchedLootingAnim2 = playerCrouchedLootingAnim
		else
			playerCrouchedLootingAnim2 = playerLootingAnim
		end

		local v6

		if showClientLootingAnim then
			v6 = instance:__wf_atom_921c1a5f(playerCrouchedLootingAnim2, false, 4, 1, false)
		else
			v6 = instance:__wf_atom_9b5dcd3b(playerCrouchedLootingAnim2, false, 4, 1, false)
		end

		local v7 = playerLootingAnim:__wf_atom_091354f5(Symbol("Unlocked")) * v6
		local v8 = playerLootingAnim:__wf_atom_091354f5(Symbol("StartMover")) * v6
		local total = 0

		if not __wf_atom_7e8ad928(moverOpen) then
			while total < v8 do
				Sleep(0)
				total += __wf_atom_084b3e93()
			end

			if openChestForInstigatorOnly then
				if fn7(instance) and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
					moverOpen:__wf_atom_0eb78444()

					if not (__wf_atom_7e8ad928(lootTransmissionSet) or __wf_atom_7e8ad928(transmissionSymbol)) then
						Sleep(transmissionDelay)
						module7.PlayLocalTransmission(lootTransmissionSet, transmissionSymbol, instance)
					end
				end
			elseif not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				moverOpen:__wf_atom_0eb78444()

				if not (__wf_atom_7e8ad928(lootTransmissionSet) or __wf_atom_7e8ad928(transmissionSymbol)) then
					Sleep(transmissionDelay)
					module7.PlayGlobalTransmission(lootTransmissionSet, transmissionSymbol)
				end
			end
		end

		while total < v7 do
			if v2 or gClient:__wf_atom_a1d07c1c() then
				if not __wf_atom_7e8ad928(moverOpen) then
					moverOpen:__wf_atom_a0bb91f8()
					moverOpen:__wf_atom_d815cb96()
				end

				fn5(object, instance)
				return
			else
				if total >= 3 then
					break
				end

				Sleep(0)
				total += __wf_atom_084b3e93()
			end
		end

		if not v5 and gRegion:IsMaster() and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			gRegion:__wf_atom_2202ffb6():__wf_atom_192b9cb0(
				2,
				31,
				__wf_atom_3d96ddcd:GetPosition(),
				__wf_atom_3d96ddcd,
				0,
				15,
				true
			)
		end
	end

	if fn7(instance) and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		if not __wf_atom_7e8ad928(openMesh) then
			__wf_atom_3d96ddcd:__wf_atom_45cf0e1a(openMesh, false, false)
		end

		if not __wf_atom_7e8ad928(moverOpen) then
			if moverOpen:__wf_atom_97217c99() == false and __wf_atom_7e8ad928(playerLootingAnim) then
				moverOpen:__wf_atom_0eb78444()
			end

			while moverOpen:__wf_atom_97217c99() == true do
				Sleep(0)
			end
		end

		if not __wf_atom_7e8ad928(openSpawnerFX) then
			local __wf_atom_be0bea4a = __wf_atom_3d96ddcd:__wf_atom_be0bea4a()

			for i = 1, #__wf_atom_be0bea4a do
				if __wf_atom_be0bea4a[i]:IsA(__wf_atom_ca04301b) then
					__wf_atom_be0bea4a[i]:Destroy()
				end
			end

			__wf_atom_3d96ddcd:Attach(openSpawnerFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end

		if wiggleLootChest then
			__wf_atom_3d96ddcd:__wf_atom_8a035cd5(Symbol("Wiggle"), false)
		end

		for _, v6 in ipairs(removeAttachmentTypes) do
			local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(v6)

			for _, v7 in ipairs(__wf_atom_f582136d) do
				v7:Destroy()
			end
		end

		if removeLootContainer then
			__wf_atom_3d96ddcd:__wf_atom_a7ee9662(false, true)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(__wf_atom_3a0953be)

		for _, v6 in ipairs(__wf_atom_f582136d) do
			v6:Destroy()
		end

		module3.RemoveSparrowDestination(__wf_atom_3d96ddcd)
	end

	if useCameraSpot and module7.TransmissionPlaying() then
		Sleep(1)

		if not __wf_atom_7e8ad928(instance) then
			instance:__wf_atom_8a035cd5(Symbol("Initialize"), false)
		end
	end

	if lootDelay > 0 then
		Sleep(lootDelay)
	end

	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_4ebf67cb) then
		fn5(object, instance)
		return
	end

	if shouldDropInWorld then
		fn4(__wf_atom_3d96ddcd, nil, itemDropSpawnOffset)
		NotifyChallenge()
	elseif openChestForInstigatorOnly then
		fn4(instance)
		module10.TrainPet(instance:__wf_atom_a96eb2aa(), 4, 60)
		NotifyChallenge(instance:__wf_atom_a96eb2aa())

		if not __wf_atom_7e8ad928(moteDropTable) then
			fn4(__wf_atom_3d96ddcd, moteDropTable, moteDropOffset)
		end
	else
		local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

		for _, _ in ipairs(__wf_atom_a8553251) do
			fn4(instance)
		end

		NotifyChallenge()
	end

	if not (__wf_atom_7e8ad928(chestLoreFragementRes) or __wf_atom_7e8ad928(loreMemeorySymbol)) then
		if openChestForInstigatorOnly then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			module2.GiveLoreFragmentMemory(__wf_atom_c4f78a8f, chestLoreFragementRes, loreMemeorySymbol)
		else
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

			for _, v6 in ipairs(__wf_atom_ef7900cf) do
				if v6:__wf_atom_a5304c35(object:GetPosition()) < maxRewardDistance then
					module2.GiveLoreFragmentMemory(v6, chestLoreFragementRes, loreMemeorySymbol)
				end
			end
		end
	end

	module.LogLootChestLootedStats(__wf_atom_3d96ddcd)
	local _resetChestDebug = _G.resetChestDebug

	if ShouldDestroyLootContainer(__wf_atom_3d96ddcd, object) then
		DestroyLootContainer(__wf_atom_3d96ddcd, object)
	end
end

function MushroomChest(object, _, _, object2)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
	module2.SetImmunity(__wf_atom_50a7d83e, true)

	if __wf_atom_50a7d83e:__wf_atom_bb81a9df() < 0.3 then
		__wf_atom_50a7d83e:SetHealth(__wf_atom_50a7d83e:GetMaxHealth(true) * 0.4)
	end

	if module6.IsHardModeActive() then
		if not __wf_atom_7e8ad928(hardmodeDroptable) then
			fn4(__wf_atom_50a7d83e, hardmodeDroptable)
		end
	else
		if
			not __wf_atom_7e8ad928(lootTransmissionSet)
			and not __wf_atom_7e8ad928(transmissionSymbol)
			and Random(0, 1) < dialougeChance
		then
			module7.PlayLocalTransmission(lootTransmissionSet, transmissionSymbol, __wf_atom_50a7d83e)

			while module7.TransmissionPlaying() do
				Sleep(0)
			end
		end

		fn4(__wf_atom_50a7d83e, dropTable)
	end

	local __wf_atom_be0bea4a = object2:__wf_atom_be0bea4a()

	for i = 1, #__wf_atom_be0bea4a do
		if not __wf_atom_be0bea4a[i]:IsA(WeakResource("/SF/Types/PickUps/ResourceManualPickupAction")) then
			__wf_atom_be0bea4a[i]:Destroy()
		end
	end

	module2.SetImmunity(__wf_atom_50a7d83e, false)
	Sleep(25)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("MushroomRingDeco"), object2:GetPosition(), 0, 3)

	for i = 1, #__wf_atom_439c0d29 do
		__wf_atom_439c0d29[i]:Destroy()
	end
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	v2 = true
	object:__wf_atom_3ede53b4(Symbol("InteruptDamage"))
end

function DecorationLootDrop(object, _, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
	Color(0, 0, 0)

	if object:__wf_atom_c6f1f83d() <= 0 then
		if math.random() <= spawnChance then
			if useRegionDropTables and not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				local blue = __wf_atom_0a6a5887:GetColor(object:GetPosition(), false).blue
				fn4(object, regionDropTables[blue], itemDropSpawnOffset)
			else
				fn4(object, nil, itemDropSpawnOffset)
			end
		end

		if not __wf_atom_7e8ad928(moteDropTable) then
			fn4(object, moteDropTable, moteDropOffset)
		end

		if not __wf_atom_7e8ad928(customDropAttachment) then
			object:Attach(customDropAttachment, EMPTY_SYMBOL, customDropAttachmentOffset, __wf_atom_80368bb1):SetMeshScale(customDropAttachmentScale)
			module.LogLootChestLootedStats(object)
		end
	end
end

function WeaponRackEntitySetup(object)
	module2.WaitForLevel()
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(spawnTag, object:GetPosition(), 0, 0.5)

	if math.random() <= spawnChance then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_46b5a019)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end

		if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			object:SetVisibility(false, false)
			local taggedChild = module2.FindTaggedChild(__wf_atom_f738b4af:__wf_atom_be0bea4a(), Symbol("LootAction"))

			if not __wf_atom_7e8ad928(taggedChild) then
				taggedChild:Disable()
			end
		end
	end
end

function SetupLootableCrypt(object)
	_T.CryptSetupDone = nil
	Sleep(2)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(spawnTag)
	local _maximumActiveCypts = maximumActiveCypts
	local _, _, _ = module9.GetActiveDungeonTaleInfo()
	local v5 = {}
	local v6 = 3

	for i = #__wf_atom_2226b35c, 2, -1 do
		local __wf_atom_c08f5a0e = object:__wf_atom_c08f5a0e(1, i)
		local v7 = __wf_atom_2226b35c[__wf_atom_c08f5a0e]
		local v8 = __wf_atom_2226b35c[i]
		__wf_atom_2226b35c[i] = v7
		__wf_atom_2226b35c[__wf_atom_c08f5a0e] = v8
	end

	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("RandomCryptGate"))

	for _, v7 in pairs(__wf_atom_2226b35c) do
		v7:Enable()

		if object:__wf_atom_8d119bab(0, 1) <= spawnChance and #v5 ~= v6 then
			for k, v8 in pairs(__wf_atom_2226b35c2) do
				if not (Distance(v8:GetPosition(), v7:GetPosition()) > 5) then
					continue
				end

				v8:SetVisibility(false)
				v8:__wf_atom_0ed81088(false)
				table.remove(__wf_atom_2226b35c2, k)
			end

			table.insert(v5, v7)
		elseif not __wf_atom_7e8ad928(v7) then
			local __wf_atom_3d96ddcd = v7:__wf_atom_3d96ddcd()

			if not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(closedMesh)) then
				__wf_atom_3d96ddcd:__wf_atom_45cf0e1a(closedMesh, false, false)
				local __wf_atom_be0bea4a = __wf_atom_3d96ddcd:__wf_atom_be0bea4a()

				for _, v8 in pairs(__wf_atom_be0bea4a) do
					v8:Destroy()
				end
			end

			v7:Disable()
		end
	end

	_T.CryptSetupDone = true
end

local function fn8(object)
	if __wf_atom_7e8ad928(perfectPerformanceFX) or __wf_atom_7e8ad928(goodPerformanceFX) then
		return
	end

	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

	for i = 1, #__wf_atom_be0bea4a do
		if __wf_atom_be0bea4a[i]:IsA(__wf_atom_ca04301b) then
			__wf_atom_be0bea4a[i]:Destroy()
		end
	end

	if _T.PerfectPerformace then
		perfectPerformanceFX2 = perfectPerformanceFX
	else
		perfectPerformanceFX2 = goodPerformanceFX
	end

	object:Attach(perfectPerformanceFX2, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	object:PlaySound(musicCompleteSound, false)
end

function DestroyInstrumentAfter(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:__wf_atom_7b82e9e1(5) do
		Sleep(0)
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

function AvatarPlayInstrument(p)
	module4.AvatarPlayInstrument(p, nil, instrumentDecoType, musicStartAnim, musicLoopAnim, musicEndAnim)
end

function ToWhite(_)
	gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(-1, 1)
	Sleep(1)
end

function DoLootDrop(object, object2)
	if not gRegion:IsMaster() or module2.EnemyLootDropsDisabled() or math.random() >= spawnChance then
		return
	end

	local __wf_atom_679ed446 = object2:__wf_atom_679ed446()
	local __wf_atom_e93896ba = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e93896ba(0)
	local enemyLevel = module6.GetEnemyLevel(__wf_atom_679ed446)
	local v5 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)

	if dropLootForInstigatorOnly then
		if
			not __wf_atom_7e8ad928(__wf_atom_679ed446)
			and __wf_atom_679ed446:IsA(__wf_atom_4ebf67cb)
			and not HasPlayerAquiredLootAllready(__wf_atom_679ed446)
		then
			dropTable:__wf_atom_0ad20b11(__wf_atom_679ed446, object, __wf_atom_e93896ba, v5)
		end
	elseif giveDirectlyToPlayers then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local position = object:GetPosition()

		for _, v6 in ipairs(__wf_atom_ef7900cf) do
			if not (v6:__wf_atom_a5304c35(position) < maxRewardDistance) or HasPlayerAquiredLootAllready(v6) then
				continue
			end

			dropTable:__wf_atom_0ad20b11(v6, object, __wf_atom_e93896ba, v5)
		end
	else
		dropTable:__wf_atom_6ba3aebe(__wf_atom_679ed446, __wf_atom_e93896ba, v5, __wf_atom_28d5d4aa)
	end
end

local function fn9(instance, object, object2, _)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_8161e6ba = instance:__wf_atom_8161e6ba()

	if __wf_atom_8161e6ba.mSuccess then
		if not __wf_atom_7e8ad928(object) then
			for _, v5 in ipairs(removeAttachmentTypes) do
				local __wf_atom_f582136d = object:__wf_atom_f582136d(v5)

				for _, v6 in ipairs(__wf_atom_f582136d) do
					v6:Destroy()
				end
			end
		end

		if gRegion:IsMaster() then
			fn8(object2:__wf_atom_3d96ddcd())

			if disableActionAfterReward then
				object:__wf_atom_b811702e(EMPTY_SYMBOL)
				object2:Disable()
			end
		end

		local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
		local v5 = {}

		if instance:__wf_atom_631bafa1() then
			local flag2 = false

			for i = 1, #loreRewards do
				local loreReward = loreRewards[i]
				local __wf_atom_22020464 = loreReward:__wf_atom_22020464()
				local v6 = loreMemoryIdx[i]

				if v6 and v6 > 0 and v6 <= #__wf_atom_22020464 then
					if not v5[loreReward] then
						v5[loreReward] = {}
					end

					table.insert(v5[loreReward], __wf_atom_22020464[v6])
				else
					if not v5[loreReward] then
						v5[loreReward] = 0
					end

					v5[loreReward] += 1
					v6 = #__wf_atom_d2b2176d:GetUnlockedMemories(loreReward) + v5[loreReward]
				end

				local __wf_atom_34817f31 = loreReward:__wf_atom_34817f31()

				if not (v6 <= #__wf_atom_34817f31) or __wf_atom_7e8ad928(__wf_atom_34817f31[v6]) then
					continue
				end

				instance:__wf_atom_8a035cd5(Symbol("ToWhite"), true)
				instance:__wf_atom_1a73b1c2(__wf_atom_34817f31[v6])
				flag2 = true
			end

			if flag2 then
				module7.WaitForTransmissions()
			end
		end

		if gRegion:IsMaster() then
			local rareDropTable2 = nil
			local __wf_atom_e93896ba = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e93896ba(0)
			local enemyLevel = module6.GetEnemyLevel(instance)
			local v6 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)

			if __wf_atom_8161e6ba.mPerfect and not __wf_atom_7e8ad928(rareDropTable) then
				rareDropTable2 = rareDropTable
			elseif not __wf_atom_7e8ad928(dropTable) then
				rareDropTable2 = dropTable
			end

			if not __wf_atom_7e8ad928(rareDropTable2) then
				if dropLootForInstigatorOnly and instance:IsA(__wf_atom_4ebf67cb) then
					rareDropTable2:__wf_atom_0ad20b11(instance, instance, __wf_atom_e93896ba, v6)
				else
					rareDropTable2:__wf_atom_6ba3aebe(instance, __wf_atom_e93896ba, v6, itemDropSpawnOffset)
				end
			end

			local v7 = v[__wf_atom_5784a397(1, #v)]
			local __wf_atom_e184ab04 = v7:__wf_atom_e184ab04()
			local v8 = __wf_atom_e184ab04 == 0 and 60 or __wf_atom_e184ab04
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

			for _, v9 in pairs(__wf_atom_ef7900cf) do
				if not __wf_atom_7e8ad928(v9) then
					v9:__wf_atom_d2b2176d():AddBoosterItem(v7, v8)
				end
			end
		end

		if not __wf_atom_7e8ad928(instance) and instance:__wf_atom_631bafa1() then
			local v6 = {}

			for _, v7 in ipairs(localRewards) do
				if __wf_atom_7e8ad928(v7) then
					continue
				end

				v6[v7] = __wf_atom_d2b2176d:__wf_atom_ee725e9c(v7, true)

				if v7:IsA(__wf_atom_a75640c1) then
					__wf_atom_d2b2176d:__wf_atom_e7ac08e7(v7, "")
				elseif v7:IsA(__wf_atom_3cecff09) then
					__wf_atom_d2b2176d:__wf_atom_fc19219a(v7)
				end
			end

			while not __wf_atom_7e8ad928(instance) do
				for k, v7 in pairs(v6) do
					if v7 < __wf_atom_d2b2176d:__wf_atom_ee725e9c(k) then
						v6[k] = nil
					end
				end

				if not next(v6) then
					break
				end

				Sleep(0)
			end

			for k, v7 in pairs(v5) do
				if type(v7) == "table" then
					for _, v8 in ipairs(v7) do
						module2.GiveLoreFragmentMemory(instance, k, v8)
					end
				else
					for _ = 1, v7 do
						module2.GiveLoreFragment(instance, k)
					end
				end
			end
		end
	elseif gRegion:IsMaster() then
		object2:Enable()
	end
end

function MoveBoulder(object)
	local position = object:GetPosition()
	object:__wf_atom_6e950389()
	object:PlaySound(boulderRumbleSound, false)
	object:PlaySound(boulderMoveSound, false)
	gRegion:CreateEntity(boulderFX, position, __wf_atom_80368bb1, nil, nil, 1)
	local v5 = 0

	while v5 < 1 do
		local v6 = __wf_atom_084b3e93()
		v5 = __wf_atom_421b01aa(v5 + v6 / 4, 0, 1)
		local v7 = Vector(Noise(Time() * 2), 0, Noise(3 + Time() * 2)) * 0.1
		object:SetPosition(position + __wf_atom_f55d6358(Vector(0, 0, 0), Vector(0, -6, 0), v5) + v7)
		Sleep(0)
	end
end

local function fn10(object, object2, instance)
	if not gRegion:IsMaster() or __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance) then
		return
	end

	if not object:__wf_atom_8161e6ba().mSuccess then
		instance:Enable()
		return
	end

	module2.TaggedFirePorts(Symbol("VerminiaBoulderSuccessSeq"), "Enable")
	module2.TaggedFirePorts(Symbol("VerminiaCapRock"), "Hide")
	local nearestTagged = gRegion:FindNearestTagged(Symbol("VerminiaCaveBoulder"), object2:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:__wf_atom_8a035cd5(Symbol("MoveBoulder"), false)
		module2.TaggedFirePorts(Symbol("VerminiaBoulderSeq"), "Enable")
		module2.TaggedFirePorts(Symbol("VerminiaRockCeil"), "Hide")
	end

	module3.RemoveSparrowDestination(nil, "RatGuide")
	object2:__wf_atom_b811702e(EMPTY_SYMBOL)
	instance:Disable()

	for _, v5 in ipairs(removeAttachmentTypes) do
		local __wf_atom_f582136d = object2:__wf_atom_f582136d(v5)

		for _, v6 in ipairs(__wf_atom_f582136d) do
			v6:Destroy()
		end
	end
end

function StartMusicChestContextAction(instance, object)
	_T.SpiritChestMusicGame = true
	_T.MusicGameMidiOverride = songMidiData
	_T.MusicGameSuccessSoundOverride = successSoundOverride
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		print("No parent deco for music chest action")
		return
	end

	local v5 = fn3(__wf_atom_3d96ddcd:__wf_atom_be0bea4a(), Symbol("Statue"))

	if __wf_atom_7e8ad928(v5) then
		print("Statue deco cannot be found as attached child")
		return
	end

	local v6 = Symbol("Invulnerable")

	if object:__wf_atom_8efce136() then
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(musicMovie)
		module5.RegisterPreventNighfoldUsage(true)

		if instance:IsA(__wf_atom_8b8e8b22) then
			if unequipWeapon and gRegion:IsMaster() then
				module2.UnequipWeapon(object, unequipInstant)
			end

			if gRegion:IsMaster() then
				local __wf_atom_7470861b = object:__wf_atom_7470861b()
				__wf_atom_7470861b:__wf_atom_9fba31e6(v6, 26, 6, 0)

				if disableActionAfterReward then
					instance:Disable()
				end

				object:__wf_atom_8a035cd5(Symbol("AvatarPlayInstrument"), true)
				fn9(object, v5, instance)

				if not __wf_atom_7e8ad928(object) then
					object:__wf_atom_d2b2176d():__wf_atom_c8700ab5(true)
					__wf_atom_7470861b:__wf_atom_63396172(v6)
				end
			else
				while not __wf_atom_7e8ad928(object) and object:__wf_atom_0473b7a9() do
					Sleep(0)
				end

				fn9(object, v5, instance)
			end

			_T.SpiritChestMusicGame = false
			_T.MusicGameMidiOverride = nil
			_T.MusicGameSuccessSoundOverride = nil
			module5.RegisterPreventNighfoldUsage(false)
		end
	elseif gRegion:IsMaster() then
		if disableActionAfterReward then
			instance:Disable()
		end

		local __wf_atom_7470861b = object:__wf_atom_7470861b()
		__wf_atom_7470861b:__wf_atom_9fba31e6(v6, 26, 6, 0)
		object:__wf_atom_8a035cd5(Symbol("AvatarPlayInstrument"), true)
		fn9(object, v5, instance)

		if not __wf_atom_7e8ad928(object) then
			object:__wf_atom_d2b2176d():__wf_atom_c8700ab5(true)
			__wf_atom_7470861b:__wf_atom_63396172(v6)
		end
	end
end

function StartMusicChestContextActionBoulderHacks(instance, object)
	_T.SpiritChestMusicGame = true
	_T.MusicGameMidiOverride = songMidiData
	_T.MusicGameSuccessSoundOverride = successSoundOverride
	local v5 = fn3(instance:__wf_atom_3d96ddcd():__wf_atom_be0bea4a(), Symbol("Statue"))

	if __wf_atom_7e8ad928(v5) then
		print("Statue deco can be found as attached child")
	elseif object:__wf_atom_8efce136() then
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(musicMovie)
		module5.RegisterPreventNighfoldUsage(true)

		if instance:IsA(__wf_atom_8b8e8b22) then
			local v6 = Symbol("Invulnerable")

			if unequipWeapon and gRegion:IsMaster() then
				module2.UnequipWeapon(object, unequipInstant)
			end

			local __wf_atom_7470861b = object:__wf_atom_7470861b()
			__wf_atom_7470861b:__wf_atom_9fba31e6(v6, 26, 6, 0)

			if gRegion:IsMaster() then
				instance:Disable()
				object:__wf_atom_8a035cd5(Symbol("AvatarPlayInstrument"), true)
				fn10(object, v5, instance)
			else
				while object:__wf_atom_0473b7a9() do
					Sleep(0)
				end
			end

			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_d2b2176d():__wf_atom_c8700ab5(true)
				__wf_atom_7470861b:__wf_atom_63396172(v6)
			end

			_T.SpiritChestMusicGame = false
			_T.MusicGameMidiOverride = nil
			_T.MusicGameSuccessSoundOverride = nil
			module5.RegisterPreventNighfoldUsage(false)
		end
	elseif gRegion:IsMaster() then
		instance:Disable()
		object:__wf_atom_8a035cd5(Symbol("AvatarPlayInstrument"), true)
		fn10(object, v5, instance)
	end
end

function StartMusicChestDynamic(object, object2)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) or not EvaluateAction(object, object2) then
		return
	end

	local __wf_atom_8efce136 = object2:__wf_atom_8efce136()
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local v5

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		v5 = fn3(__wf_atom_3d96ddcd:__wf_atom_be0bea4a(), Symbol("Statue"))
	end

	if __wf_atom_7e8ad928(v5) then
		print("Statue deco can be found as attached child")
	elseif __wf_atom_8efce136 then
		_T.SpiritChestMusicGame = true
		_T.MusicGameMidiOverride = songMidiData
		_T.MusicGameSuccessSoundOverride = successSoundOverride
		local v6 = Symbol("Invulnerable")
		local __wf_atom_7470861b = object2:__wf_atom_7470861b()
		__wf_atom_7470861b:__wf_atom_9fba31e6(v6, 26, 6, 0)

		while not (__wf_atom_7e8ad928(object2) or object2:__wf_atom_0473b7a9()) do
			Sleep(0)
		end

		if gRegion:IsMaster() then
			object:Disable()
		end

		while not __wf_atom_7e8ad928(object2) and object2:__wf_atom_0473b7a9() do
			Sleep(0)
		end

		fn9(object2, v5, object)

		if not __wf_atom_7e8ad928(object2) then
			__wf_atom_7470861b:__wf_atom_63396172(v6)
		end

		_T.SpiritChestMusicGame = false
		_T.MusicGameMidiOverride = nil
		_T.MusicGameSuccessSoundOverride = nil
	elseif gRegion:IsMaster() then
		while not (__wf_atom_7e8ad928(object2) or object2:__wf_atom_0473b7a9()) do
			Sleep(0)
		end

		object:Disable()

		while not __wf_atom_7e8ad928(object2) and object2:__wf_atom_0473b7a9() do
			Sleep(0)
		end

		fn9(object2, v5, object)
	end
end

function StopSoulSongChest()
	_T.SpiritChestMusicGame = false
	_T.MusicGameMidiOverride = nil
	_T.MusicGameSuccessSoundOverride = nil
end

function RemoveSingleAquisitionChest(object, _)
	if __wf_atom_7e8ad928(targetChest) then
		return
	end

	if not (__wf_atom_7e8ad928(object) or object:IsKilled()) then
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			if __wf_atom_d2b2176d:__wf_atom_705a2744(loreEntryToCheck, memorySym) then
				print("Player has unlocked codex entry, disabling chest")
				local taggedChild = module2.FindTaggedChild(targetChest:__wf_atom_be0bea4a(), Symbol("LootAction"))
				targetChest:__wf_atom_45cf0e1a(openMesh, false, false)

				if not __wf_atom_7e8ad928(taggedChild) then
					taggedChild:Disable()
				end
			else
				print("Player has not unlocked codex entry, leaving chest active")
			end
		end
	end
end