local module = require("SF.Scripts.Quests.QuestTools.QuestStateHandler")
local v = { courage = 0.5, grace = 0.1, spirit = 0.2 }
local activeFightController = nil
local v2 = nil
local v3 = Symbol("WSP13_BOSSFIGHTTRIGGER")
local v4 = Resource("/SF/Characters/Bayor/BayorHeadAge")
local v5 = Symbol("BayorPastAttachment")
local v6 = Symbol("BayorPresentAttachment")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.CinematicLib")
local module4 = require("SF.Scripts.Libs.AvatarLib")
local module5 = require("SF.Scripts.Libs.RespawnLib")
local module6 = require("SF.Interface.SFUtilities")
require("SF.Scripts.Libs.ModifySkyLib")
local module7 = require("SF.Scripts.Libs.TransmissionSet")
local module8 = require("SF.Scripts.Libs.ModifySkyLib")

local function fn(p, p2)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		for i = 1, #__wf_atom_2226b35c do
			if not __wf_atom_7e8ad928(__wf_atom_2226b35c[i]) then
				__wf_atom_2226b35c[i]:SetVisibility(p2, true)
			end
		end
	end
end

local function fn2()
	fn(v6, false)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TempestBayor"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_a887a262(0, nil, false)
		__wf_atom_0a6a5887:SetBlackboardBool(Symbol("IsPresent"), false)
	end

	fn(v5, true)
end

local function fn3()
	fn(v6, true)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TempestBayor"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_a887a262(0, v4, false)
		__wf_atom_0a6a5887:SetBlackboardBool(Symbol("IsPresent"), true)
	end

	fn(v5, false)
end

function AddDecorationsToBlackBoard(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.Attachments = {}
	Sleep(0.1)
	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

	for i = 1, #__wf_atom_be0bea4a do
		if not (__wf_atom_be0bea4a[i]:IsA(WeakResource("/EE/Types/Engine/Decoration")) or __wf_atom_be0bea4a[i]:IsA(WeakResource("/EE/Types/Effects/SkeletalClothEx"))) then
			continue
		end

		table.insert(__wf_atom_e919fb8e.Attachments, {
			Tag = __wf_atom_be0bea4a[i]:__wf_atom_db682341(),
			Attachment = __wf_atom_be0bea4a[i]
		})
	end
end

function SetUpP9EndingCine(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local nearestTagged = gRegion:FindNearestTagged(Symbol("Warsong-P9HurtedDeer"), object:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		gRegion:__wf_atom_dd1e4d10(nearestTagged)
	end

	module3.CreateEntity(object, __wf_atom_e919fb8e, actorType)
	module3.CreateEntity(object, __wf_atom_e919fb8e, deerDecoType)
	local typeInTable = module2.FindTypeInTable(__wf_atom_e919fb8e.Actors, actorType)
	local typeInTable2 = module2.FindTypeInTable(__wf_atom_e919fb8e.Actors, deerDecoType)

	if not __wf_atom_7e8ad928(typeInTable) then
		typeInTable:SetVisibility(true)
		local __wf_atom_bb3e7833 = typeInTable:__wf_atom_bb3e7833(attachmentObj)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:SetVisibility(false, true)
		end

		object:__wf_atom_a3d2b66b(typeInTable, cinematicActorTag)
	end

	if not __wf_atom_7e8ad928(typeInTable2) then
		object:__wf_atom_a3d2b66b(typeInTable2, Symbol("WhiteTailDeerDoe"))
	end
end

local function fn4(object, p, p2)
	if not customizeImmediately then
		Sleep(0.2)
	end

	if __wf_atom_7e8ad928(object) then
		object = gRegion:__wf_atom_0a6a5887(targetAvatarTag)
	end

	local v7 = p or taggedDecosToHide
	local v8 = p2 or taggedDecosToShow
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Attachments) then
		return
	end

	for _, attachment in pairs(__wf_atom_e919fb8e.Attachments) do
		for _, v9 in pairs(v8) do
			if v9 == attachment.Tag then
				attachment.Attachment:SetVisibility(true)
			end
		end

		for _, v9 in pairs(v7) do
			if v9 == attachment.Tag then
				attachment.Attachment:SetVisibility(false)
			end
		end
	end
end

function SpawnActorEntity(p, p2, p3, p4)
	module3.CreateEntity(p, p2, p3, p4)
end

function CreateMultipleActors(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	for k, v7 in pairs(multipleActorTypes) do
		module3.CreateEntity(object, __wf_atom_e919fb8e, v7)
		local typeInTable = module2.FindTypeInTable(__wf_atom_e919fb8e.Actors, v7)

		if __wf_atom_7e8ad928(typeInTable) then
			continue
		end

		typeInTable:SetVisibility(true)
		object:__wf_atom_a3d2b66b(typeInTable, multipleActorsCinematicTags[k])

		if k <= #meshScales and meshScales[k] > 0 then
			typeInTable:SetMeshScale(meshScales[k], true)
		end
	end
end

function CreateCinematicActor(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	module3.CreateEntity(object, __wf_atom_e919fb8e, actorType)
	local typeInTable = module2.FindTypeInTable(__wf_atom_e919fb8e.Actors, actorType)

	if not __wf_atom_7e8ad928(typeInTable) then
		typeInTable:SetVisibility(true)
		object:__wf_atom_a3d2b66b(typeInTable, cinematicActorTag)
	end

	if meshScale ~= 1 then
		typeInTable:SetMeshScale(meshScale, true)
	end
end

function ShowCinematicActor(object)
	local nearestTagged = gRegion:FindNearestTagged(actorTag, object:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:SetVisibility(true)
		object:__wf_atom_a3d2b66b(nearestTagged, cinematicActorTag)
	end
end

function DestroyAllCinematicActor(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	for _, v7 in pairs(multipleActorTypes) do
		module3.DestroyEntityFromCinBlackboard(object, __wf_atom_e919fb8e, v7)
	end
end

function DestroyCinematicActor(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	module3.DestroyEntityFromCinBlackboard(object, __wf_atom_e919fb8e, actorType)
end

function HideWeapon(_, object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(5)

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			local __wf_atom_66088189 = __wf_atom_28224c27:__wf_atom_66088189(1, 0)

			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				__wf_atom_66088189:__wf_atom_017e8c6b(true)
			end
		end
	end
end

function BayorAmbushPrepare(p)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v2 = activeFightController:__wf_atom_e919fb8e()
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v7 = module4.StorePlayerAttribute(__wf_atom_c4f78a8f)
	local __wf_atom_e919fb8e = __wf_atom_c4f78a8f:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.lastAssignedAvatar) then
		__wf_atom_e919fb8e.lastAssignedAvatar = nil
	end

	module3.CreateEntity(p, v2, motherAvatarType, true)
	local typeInTable = module2.FindTypeInTable(v2.Actors, motherAvatarType)
	typeInTable:__wf_atom_c274907d(gRegion:__wf_atom_eab484a7())
	fn4(typeInTable, motherDecosTohide, motherDecosToShow)
	module4.ApplyPlayerAttributeDistribution(typeInTable, v7, v)
	module4.GiveAndInitalizeCustomWeaponOrPact(typeInTable, motherWeaponType)
	typeInTable:__wf_atom_d2b2176d():Equip(5, 0, 2)
	local typeInTable2 = module2.FindTypeInTable(v2.Actors, bayorAvatarType)

	if not __wf_atom_7e8ad928(typeInTable2) then
		fn3()
		typeInTable2:SetVisibility(true)
		fn4(typeInTable2)
	end

	HideWeapon(p, __wf_atom_c4f78a8f)
end

function PrepareFightEndCine(object)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v2 = activeFightController:__wf_atom_e919fb8e()
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	object:__wf_atom_a3d2b66b(__wf_atom_c4f78a8f, Symbol("Envoy"))
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PlayerMotherAvatar"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or not module4.HasPreviouslyAssignedAvatar(__wf_atom_c4f78a8f) then
		module3.CreateEntity(object, v2, motherAvatarType, true)
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PlayerMotherAvatar"))
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:SetVisibility(true, true)
		__wf_atom_0a6a5887:__wf_atom_68f2c268(0)
		object:__wf_atom_a3d2b66b(__wf_atom_0a6a5887, Symbol("PlayerMother"))
	end

	module3.CreateEntity(object, v2, motherBayorCombatDeco, true)
	module3.CreateEntity(object, v2, envoyBayorCombatDeco, true)
	Sleep(1)
end

function CustomiseBayor(_)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v2 = activeFightController:__wf_atom_e919fb8e()
	end

	local typeInTable = module2.FindTypeInTable(v2.Actors, bayorAvatarType)

	if not __wf_atom_7e8ad928(typeInTable) then
		fn4(typeInTable)
	end
end

function CustomiseMother(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(targetAvatarTag)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		fn4(__wf_atom_0a6a5887, motherDecosTohide, motherDecosToShow)
	end
end

function ShowMotherAndCustomize(_, object)
	if not __wf_atom_7e8ad928(object) then
		object:SetVisibility(true, true)
		fn4(object, motherDecosTohide, motherDecosToShow)
	end
end

function SwitchToMother(_)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v2 = activeFightController:__wf_atom_e919fb8e()
	end

	local typeInTable = module2.FindTypeInTable(v2.Actors, motherAvatarType)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if module4.HasPreviouslyAssignedAvatar(__wf_atom_c4f78a8f) then
		module4.SwapLastAssignedControllableAvatar(false, true, true, true)
	else
		module4.SwapControllableAvatar(__wf_atom_c4f78a8f, typeInTable, false, true, true)
	end

	if shouldFillHealth then
		module5.RefillHealthPotions(5)
	end

	module6.RegisterHideHudSelective(true)

	if
		not __wf_atom_7e8ad928(motherFireAttachFxType)
		and __wf_atom_7e8ad928((typeInTable:__wf_atom_bb3e7833(motherFireAttachFxType)))
	then
		typeInTable:Attach(motherFireAttachFxType, EMPTY_SYMBOL)
	end

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_28224c27 = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_28224c27(5)

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			local __wf_atom_66088189 = __wf_atom_28224c27:__wf_atom_66088189(1, 0)

			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				__wf_atom_66088189:__wf_atom_017e8c6b(false)
			end
		end
	end
end

function SwitchToEnvoy(_)
	module4.SwapLastAssignedControllableAvatar(false, true, true, true)

	if shouldFillHealth then
		module5.RefillHealthPotions(5)
	end

	module6.RegisterHideHudSelective(false)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_d2b2176d():Equip(5, 0, 2)
	end
end

function SwitchToPast(_)
	module8.SwapSkyTo(Symbol("WarsongIntroSky"))
	module8.SetTimeOfDay(6)
	module8.ClearWeather()
	local isSkyValid = module8.IsSkyValid(Symbol("WarsongIntroSky"))

	if not __wf_atom_7e8ad928(isSkyValid) then
		isSkyValid:__wf_atom_2ee34f0b(Vector(-1, 0.3, -1))
	end

	module.LoadTaggedLevels({ Symbol("WarsongQuestBridgePreBattle") })
	module.UnloadTaggedLevels({ Symbol("WarsongQuestBridgePostBattle") })
	fn2()
end

function SwitchToPresent(_)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v2 = activeFightController:__wf_atom_e919fb8e()
	end

	module8.SwapSkyTo(Symbol("DefaultMainSky"))
	module8.ClearWeatherAndDisableCycle()
	module8.SetTimeOfDay(1)
	module8.SetOvercast(1)
	module8.SetWindy(1)
	module8.SetRaining(true)
	module8.SetLightning(true, 0, true)
	module.UnloadTaggedLevels({ Symbol("WarsongQuestBridgePreBattle") })
	module.LoadTaggedLevels({ Symbol("WarsongQuestBridgePostBattle") })
	fn3()
end

function OnWeaponHit(_, object, _)
	local __wf_atom_679ed446 = object:__wf_atom_679ed446()

	if _T.BayorFightComboSwap == true then
		if module4.HasPreviouslyAssignedAvatar(__wf_atom_679ed446) then
			module4.SwapLastAssignedControllableAvatar(false, true, true, true)
		else
			module4.CreateAndSwapControllableAvatar(avatarType, false, true, true, true)
		end
	end
end

function EnableKnockdownTrigger(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if
		__wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		or __wf_atom_3d96ddcd:__wf_atom_08998754() ~= 2
		or not (__wf_atom_3d96ddcd:__wf_atom_ee4f0cba() > 1)
	then
		return false
	end

	return true
end

function CorruptedWeaponThrownDown(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P7-SwordWp"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("CorruptedSwordDeco"))
	local entity = gRegion:CreateEntity(
		corruptedWeaponType,
		__wf_atom_0a6a5887:GetPosition(),
		__wf_atom_0a6a5887_2:__wf_atom_dc309f8a()
	)
	entity:__wf_atom_9b788a35(__wf_atom_0a6a5887_2:__wf_atom_dc309f8a())
	local total = 0

	while total <= 0.3 do
		Sleep(0)
		total += __wf_atom_03df4e1d()

		if __wf_atom_7e8ad928(entity) then
			break
		else
			entity:SetPosition(__wf_atom_f55d6358(
				__wf_atom_0a6a5887:GetPosition(),
				__wf_atom_0a6a5887_2:GetPosition(),
				(math.min(1, total / 0.3))
			))
		end
	end
end

function FadeToHideDeadFrames(_)
	module2.Fade(true, 0, 1, true)
end

function PushTheButtonPrepare(object)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BayorCollectorShip"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		if not __wf_atom_0a6a5887:IsVisible() then
			__wf_atom_0a6a5887:SetVisibility(true, true)
		end

		object:__wf_atom_a3d2b66b(__wf_atom_0a6a5887, Symbol("DendritOdeCastleShip"))
	end

	fn3()
end

function PushTheButtonTeardown(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_0650fed7(buttonType)
	end
end

function MotherBattleEndPrepair(object, _, _)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BayorCollectorShip"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		if not __wf_atom_0a6a5887:IsVisible() then
			__wf_atom_0a6a5887:SetVisibility(true, true)
		end

		object:__wf_atom_a3d2b66b(__wf_atom_0a6a5887, Symbol("DendritOdeCastleShip"))
	end
end

function ShiftSunInCitadel(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OdeSkyCastleSky"))
	local __wf_atom_032a6a06 = __wf_atom_0a6a5887:__wf_atom_032a6a06()
	local v7 = Vector(-1, 0.3, -1)
	local v8 = 0

	while v8 < 1 do
		v8 = __wf_atom_421b01aa(v8 + __wf_atom_084b3e93() * 0.5, 0, 1)
		local v9 = __wf_atom_f55d6358(__wf_atom_032a6a06, v7, v8)
		Normalize(v9)
		__wf_atom_0a6a5887:__wf_atom_2ee34f0b(v9)
		Sleep(0)
	end
end

function CastEmpressSpell(_)
	module7.PlayGlobalTransmission(transmissionSet, Symbol("EmpressRaiseIchorousWomb"), false)
end

function MotherAddPropHelmetCollision(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(targetAvatarTag)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(actorTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		return
	end

	local __wf_atom_f582136d = __wf_atom_0a6a5887:__wf_atom_f582136d(__wf_atom_b5e70cef)

	for i = 1, #__wf_atom_f582136d do
		__wf_atom_f582136d[i]:__wf_atom_2faa4bca(motherHelmetSimCollision, __wf_atom_0a6a5887_2)
	end
end

function MotherRemovePropHelmet(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(targetAvatarTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_f582136d = __wf_atom_0a6a5887:__wf_atom_f582136d(__wf_atom_b5e70cef)

	for i = 1, #__wf_atom_f582136d do
		__wf_atom_f582136d[i]:__wf_atom_2431040c()
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(actorTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		return
	end

	__wf_atom_0a6a5887_2:SetVisibility(false, true)
end

function DisableCinLight(_)
	local __wf_atom_bb3e7833 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongP4CinLoop")):__wf_atom_bb3e7833(__wf_atom_d00f34c2)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:TurnOff()
	end
end

function CreateAttachedDeco(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(targetAvatarTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:Attach(attachDecoType, attachDecoType:__wf_atom_f5bac0e4(), attachDecoOffset)
end

function DestroyAttachedDeco(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(targetAvatarTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_0a6a5887:__wf_atom_bb3e7833(attachDecoType)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
end

function ShowTargetAvatar(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(targetAvatarTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:SetVisibility(true, true)
end

function UnholsterWeapon(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(targetAvatarTag)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:__wf_atom_d2b2176d():Equip(5, 0, 2)
end

function ShiftMotherSkyToRed(_)
	module8.SetTimeOfDay(5)
	module8.SetLightning(false)
	local v7 = Vector(1, 0.35, 0.5)
	local v8 = Vector(-1, 0.3, -1)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongIntroSky"))
	local v9 = 0

	while v9 < 1 do
		v9 = 1
		__wf_atom_0a6a5887:SetTimeOfDay(__wf_atom_104bfe98(5, 6, v9))
		__wf_atom_0a6a5887:__wf_atom_2ee34f0b((__wf_atom_f55d6358(v7, v8, v9)))
		Sleep(0)
	end
end

function GooPrepare(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_eb82ab1f = __wf_atom_e55d02aa:__wf_atom_eb82ab1f()
	__wf_atom_eb82ab1f:SetSkin(sleeveType, 1)
	__wf_atom_e55d02aa:SetCustomization(__wf_atom_eb82ab1f)
	local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Update(0)
	__wf_atom_d2b2176d:__wf_atom_da1b89a8()
	local colors = __wf_atom_eb82ab1f:GetColors(7)
	colors:SetColor(0, Color(199, 194, 176, 128))
	colors:__wf_atom_59cc106e(0, true)
	colors:SetColor(1, Color(99, 61, 28, 128))
	colors:__wf_atom_59cc106e(1, true)
	colors:SetColor(2, Color(199, 158, 107, 128))
	colors:__wf_atom_59cc106e(2, true)
	colors:SetColor(3, Color(224, 140, 54, 128))
	colors:__wf_atom_59cc106e(3, true)
	__wf_atom_eb82ab1f:__wf_atom_2754430f(7, colors)
	local colors2 = __wf_atom_eb82ab1f:GetColors(8)
	colors2:SetColor(0, Color(199, 194, 176, 128))
	colors2:__wf_atom_59cc106e(0, true)
	colors2:SetColor(1, Color(99, 61, 28, 128))
	colors2:__wf_atom_59cc106e(1, true)
	colors2:SetColor(2, Color(199, 158, 107, 128))
	colors2:__wf_atom_59cc106e(2, true)
	colors2:SetColor(3, Color(224, 140, 54, 128))
	colors2:__wf_atom_59cc106e(3, true)
	__wf_atom_eb82ab1f:__wf_atom_2754430f(8, colors2)
	__wf_atom_eb82ab1f:ApplyCustomization(__wf_atom_c4f78a8f)
	__wf_atom_e55d02aa:SetCustomization(__wf_atom_eb82ab1f, false)
end

function MothersEyesBeginToTurn(_, object)
	while not (__wf_atom_7e8ad928(object) or object:__wf_atom_e919fb8e().fullyTurn) do
		local v7 = __wf_atom_104bfe98(0.3, 2, Noise(0.5 * Time()))
		object:SetMaterialParam(Symbol("EmissiveMapAtten"), v7)
		Sleep(0)
	end
end

function MothersEyesTurn(_, object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.fullyTurn = true
	local v7 = 0

	while not __wf_atom_7e8ad928(object) and v7 < 1 do
		v7 = __wf_atom_421b01aa(v7 + __wf_atom_084b3e93() * 0.25, 0, 1)
		local v8 = v7 * v7 * 5 + 0.4 + v7 * v7 * __wf_atom_104bfe98(0.3, 1, Noise(0.5 * Time())) * 2
		object:SetMaterialParam(Symbol("EmissiveMapAtten"), v8)
		Sleep(0)
	end
end

function EmergenceSong(mDeoraCinematic)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("EnvoyEmergeMusicScriptTrigger"))
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	_T.mDeoraCinematic = mDeoraCinematic
	_T.mDeoraCinematicStartDelta = 0.01
	_T.mDeoraCinematicEndDelta = 0.2
	__wf_atom_0a6a5887:Enable()
	__wf_atom_0a6a5887:__wf_atom_84da4715(__wf_atom_c4f78a8f)
	__wf_atom_0a6a5887:Disable()
end

function SoldierEyes(_, object)
	object:Attach(soldierEyesType, Symbol("GAME_L1_EYE1"))
	object:Attach(soldierEyesType, Symbol("GAME_R1_EYE1"))
	object:PlaySound(soldierEyesSound, false)
end

function ShowThralledKnights(_)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v3)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v2 = activeFightController:__wf_atom_e919fb8e()
	end

	if __wf_atom_7e8ad928(v2.MobAgents) then
		return
	end

	local mobAgents = v2.MobAgents

	for _, mobAgent in pairs(mobAgents) do
		mobAgent.Avatar:SetVisibility(true, true)
	end
end

function AnimalsBringDawn(_)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DefaultMainSky"))
	module8.ClearWeatherAndDisableCycle(5)
	local v7 = 0

	while v7 < 1 do
		v7 = __wf_atom_421b01aa(v7 + __wf_atom_084b3e93() / 24, 0, 1)
		local v8 = __wf_atom_24a82b69(v7)
		__wf_atom_0a6a5887:SetTimeOfDay((__wf_atom_104bfe98(2, 7, v8)))
		Sleep(0)
	end

	local v8 = 0

	while v8 < 1 do
		v8 = __wf_atom_421b01aa(v8 + __wf_atom_084b3e93() / 10, 0, 1)
		_T.RainNearPlayer = 1 - v8
		Sleep(0)
	end
end

function DestroyGooPool(_)
	local __wf_atom_bb3e7833 = gRegion:__wf_atom_c4f78a8f():__wf_atom_bb3e7833(gooPoolFXType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end
end