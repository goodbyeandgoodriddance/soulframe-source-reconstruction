module(..., package.seeall)
IDLE_ORDER = Symbol("IdleBehavior")
FOLLOW_ORDER = Symbol("FollowPlayer")
DEFEND_ORDER = Symbol("DefendArea")
PILOT_ORDER = Symbol("PilotBehavior")
USETURRET_ORDER = Symbol("UseTurretBehavior")
HAZARDS_ORDER = Symbol("ClearHazardsBehavior")
CRAFT_ORDER = Symbol("CraftBehavior")
DEFAULT_ROLES = { DEFEND_ORDER, PILOT_ORDER, USETURRET_ORDER, HAZARDS_ORDER, CRAFT_ORDER }
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Scripts.Libs.TransmissionSet")
local module3 = require("Lotus.Scripts.Libs.RailjackUtilities")

local function fn()
	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	local __wf_atom_257dee98 = gGameRules:__wf_atom_257dee98()

	if __wf_atom_7e8ad928(__wf_atom_257dee98) then
		return nil
	end

	return __wf_atom_257dee98:__wf_atom_247a5d2e()
end

local function fn2(list, object, ternary)
	local __wf_atom_eb82ab1f = object:__wf_atom_eb82ab1f(0, ternary)

	if __wf_atom_7e8ad928(__wf_atom_eb82ab1f) then
		return list
	end

	for i = 0, 8 - 1 do
		local __wf_atom_035fdfa8 = __wf_atom_eb82ab1f:__wf_atom_035fdfa8(i)

		if not __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
			table.insert(list, (tostring(__wf_atom_035fdfa8:__wf_atom_5b41f63b())))
		end
	end

	return list
end

function GetCrewMemberResourcesToLoad(data, p)
	local result = {}
	local ternary = module.Ternary(p, gGameData:GetInventory():__wf_atom_71d5cc00(), nil)

	if not __wf_atom_7e8ad928(data.mItemType) then
		table.insert(result, data.mItemType:__wf_atom_5b41f63b())
	end

	if not __wf_atom_7e8ad928(data.mPowersuitInfo.mItemType) then
		table.insert(result, data.mPowersuitInfo.mItemType:__wf_atom_5b41f63b())
		result = fn2(result, data.mPowersuitInfo, ternary)
	end

	local mCrewMemberGeneratedDetails = data.mCrewMemberGeneratedDetails

	if not __wf_atom_7e8ad928(mCrewMemberGeneratedDetails.mAvatarTypeOverride) then
		table.insert(result, mCrewMemberGeneratedDetails.mAvatarTypeOverride:__wf_atom_5b41f63b())
	end

	if not __wf_atom_7e8ad928(mCrewMemberGeneratedDetails.mAgentType) then
		table.insert(result, mCrewMemberGeneratedDetails.mAgentType:__wf_atom_5b41f63b())
	end

	for _, mAttachment in ipairs(mCrewMemberGeneratedDetails.mAttachments) do
		if __wf_atom_7e8ad928(mAttachment) or __wf_atom_7e8ad928(mAttachment:__wf_atom_0eaf058c()) then
			continue
		end

		table.insert(result, mAttachment:__wf_atom_0eaf058c():__wf_atom_5b41f63b())
	end

	if not __wf_atom_7e8ad928(mCrewMemberGeneratedDetails.mSuitCustomization) then
		table.insert(result, mCrewMemberGeneratedDetails.mSuitCustomization:__wf_atom_5b41f63b())
	end

	if __wf_atom_7e8ad928(data.mStoredWeapon.mItem) or __wf_atom_7e8ad928(data.mStoredWeapon.mItem.mItemType) then
		local ternary2 = module.Ternary(
			not __wf_atom_7e8ad928(mCrewMemberGeneratedDetails.mWeaponType),
			mCrewMemberGeneratedDetails.mWeaponType,
			mCrewMemberGeneratedDetails.mDefaultWeaponType
		)

		if not __wf_atom_7e8ad928(ternary2) then
			table.insert(result, ternary2:__wf_atom_5b41f63b())
		end
	else
		table.insert(result, data.mStoredWeapon.mItem.mItemType:__wf_atom_5b41f63b())
		result = fn2(result, data.mStoredWeapon.mItem, ternary)

		for _, mModularPart in ipairs(data.mStoredWeapon.mItem.mModularParts) do
			if not __wf_atom_7e8ad928(mModularPart) then
				table.insert(result, mModularPart:__wf_atom_5b41f63b())
			end
		end
	end

	if not __wf_atom_7e8ad928(mCrewMemberGeneratedDetails.mSkelMesh) then
		table.insert(result, mCrewMemberGeneratedDetails.mSkelMesh:__wf_atom_5b41f63b())
	end

	for _, mMaterialOverride in ipairs(mCrewMemberGeneratedDetails.mMaterialOverrides) do
		if not __wf_atom_7e8ad928(mMaterialOverride) then
			table.insert(result, mMaterialOverride:__wf_atom_5b41f63b())
		end
	end

	if not __wf_atom_7e8ad928(mCrewMemberGeneratedDetails.mVoiceBoxRes) then
		table.insert(result, mCrewMemberGeneratedDetails.mVoiceBoxRes:__wf_atom_5b41f63b())
		table.insert(result, mCrewMemberGeneratedDetails.mVoiceBoxDspEffectRes:__wf_atom_5b41f63b())
	end

	if not __wf_atom_7e8ad928(mCrewMemberGeneratedDetails.mTransmissionSet) then
		table.insert(result, mCrewMemberGeneratedDetails.mTransmissionSet:__wf_atom_5b41f63b())
	end

	if not __wf_atom_7e8ad928(mCrewMemberGeneratedDetails.mSkillUpgrade) then
		table.insert(result, mCrewMemberGeneratedDetails.mSkillUpgrade:__wf_atom_5b41f63b())
	end

	if not __wf_atom_7e8ad928(mCrewMemberGeneratedDetails.mSuitCustomization) then
		table.insert(result, mCrewMemberGeneratedDetails.mSuitCustomization:__wf_atom_5b41f63b())
	end

	return result
end

function GetIdleAnimsTypeForGenerator(p)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	return WeakResource("/SF/Types/Game/CrewFactionIdleAnims")
end

function RefreshCrewMember(object, p, value)
	if not __wf_atom_7e8ad928(object) then
		if gRegion:IsMaster() and p then
			if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_dd9a0bb8) then
				_T.TacticsOverlayCommand = IDLE_ORDER
			else
				_T.TacticsOverlayCommand = DEFAULT_ROLES[value or 1]
				object:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
			end

			_T.IsCrewBehaviorRefresh = true
			object:__wf_atom_51009507(
				Resource("/Lotus/Scripts/CrewShip/RJCrewCommands.lua"),
				Symbol("SetBehavior"),
				false
			)
			local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_de53c96e()
			end
		end

		object:__wf_atom_bfe1a804()
		_T.PlayerPanelUpdateRequired = true
		_T.CrewHudUpdateRequired = true
	end
end

local function fn3(object, p) -- 2 equivalent calls inferred from this helper
	local v = object:GiveItem(p, false)

	if not __wf_atom_7e8ad928(v) then
		object:__wf_atom_d2b2176d():Equip(v:__wf_atom_0395f752(), 0, 2)
	end

	return v
end

local function fn4(object, data)
	fn3(object, Resource(data.mPowersuitInfo.mItemType)) -- inferred equivalent call
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		__wf_atom_e55d02aa:__wf_atom_67dd6811(data.mPowersuitInfo.mXP)
		__wf_atom_e55d02aa:__wf_atom_82ddecd2(data.mItemId)
		local __wf_atom_eb82ab1f = data.mPowersuitInfo:__wf_atom_eb82ab1f(0)

		if not __wf_atom_7e8ad928(__wf_atom_eb82ab1f) then
			local inventory = gGameData:GetInventory()

			for i = 0, 2 do
				local __wf_atom_d78fd481 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(i)

				if __wf_atom_7e8ad928(__wf_atom_d78fd481) or __wf_atom_d78fd481.mItemId.mId == "" then
					continue
				end

				local __wf_atom_4177a1ad = inventory:__wf_atom_4177a1ad(__wf_atom_d78fd481.mItemId.mId)

				if not __wf_atom_7e8ad928(__wf_atom_4177a1ad) then
					__wf_atom_eb82ab1f:__wf_atom_b6072b05(__wf_atom_4177a1ad, i)
				end
			end

			__wf_atom_e55d02aa:SetCustomization(__wf_atom_eb82ab1f)
		end

		local object2 = object:__wf_atom_a5040fdf():CreateObject(
			Type(data.mCrewMemberGeneratedDetails.mSuitCustomization),
			__wf_atom_e55d02aa
		)

		if not (__wf_atom_7e8ad928(__wf_atom_e55d02aa) or __wf_atom_7e8ad928(object2)) then
			__wf_atom_e55d02aa:AddUpgrade(object2)
		end
	end
end

function InitPowersuit(p, p2)
	fn4(p, p2)
end

local function fn5(object, p)
	if p.mStoredWeapon.mItem and p.mStoredWeapon.mItem.mItemType then
		object:__wf_atom_d2b2176d():__wf_atom_6c521e6c(p.mStoredWeapon, 0, 2, true)
		local __wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(1)

		if __wf_atom_7e8ad928(__wf_atom_28224c27) then
			__wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(0)
		end

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			object:__wf_atom_d2b2176d():Equip(__wf_atom_28224c27:__wf_atom_0395f752(), 0, 2)
		end
	else
		local mCrewMemberGeneratedDetails = p.mCrewMemberGeneratedDetails
		local ternary = module.Ternary(
			not __wf_atom_7e8ad928(mCrewMemberGeneratedDetails.mWeaponType),
			mCrewMemberGeneratedDetails.mWeaponType,
			mCrewMemberGeneratedDetails.mDefaultWeaponType
		)
		fn3(object, Resource(ternary)) -- inferred equivalent call
	end
end

function InitWeapon(p, p2)
	fn5(p, p2)
end

local function fn6(scriptSpawnCrewMemberInfo)
	if not __wf_atom_7e8ad928(scriptSpawnCrewMemberInfo.mCrewMemberGeneratedDetails.mAvatarTypeOverride) then
		return (Type(scriptSpawnCrewMemberInfo.mCrewMemberGeneratedDetails.mAvatarTypeOverride:__wf_atom_5b41f63b()))
	end

	local v = Resource(scriptSpawnCrewMemberInfo.mCrewMemberGeneratedDetails.mAgentType)

	if not __wf_atom_7e8ad928(v) then
		return (v:__wf_atom_c6772fb4())
	end

	local v2 = "Error, failed to resolve avatar for crewmember; "
	local v3

	if __wf_atom_7e8ad928(scriptSpawnCrewMemberInfo.mItemType) then
		v3 = v2 .. " unknown type!"
	else
		v3 = v2 .. scriptSpawnCrewMemberInfo.mItemType:__wf_atom_5b41f63b()
	end

	print(v3)
	return nil
end

local function fn7(scriptSpawnCrewMemberInfo, p, p2, object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	if scriptSpawnCrewMemberInfo:__wf_atom_894dc31a() then
		print("Warning. Using wrong path to spawn nemesis crew member")
	end

	_T.ScriptSpawnCrewMemberInfo = scriptSpawnCrewMemberInfo
	return object:CreateEntity(fn6(scriptSpawnCrewMemberInfo), p, p2)
end

function SpawnCrewMemberAvatar(scriptSpawnCrewMemberInfo, p, p2, p3)
	return fn7(scriptSpawnCrewMemberInfo, p, p2, p3)
end

local function fn8(p, p2, p3)
	for _, v in ipairs(gRegion:__wf_atom_3c8e1a7a()) do
		if v ~= p then
			continue
		end

		local v2

		if v == gRegion:__wf_atom_eab484a7() then
			v2 = gGameData:__wf_atom_a4299765()
		else
			while not (__wf_atom_7e8ad928(v) or v:__wf_atom_d25abf5f()) do
				Sleep(0)
			end

			if __wf_atom_7e8ad928(v) then
				return nil
			else
				v2 = v:__wf_atom_a4299765()
			end
		end

		local secondInCommandInfo

		if p2 then
			secondInCommandInfo = v2.mCrewShipLoadOut:GetSecondInCommandInfo()
		else
			secondInCommandInfo = v2.mCrewShipLoadOut:__wf_atom_8f2a93d8(p3)
		end

		if secondInCommandInfo:__wf_atom_8598f3a9() then
			return secondInCommandInfo
		end

		return nil
	end

	return nil
end

local function fn9(p)
	local v = fn()

	while __wf_atom_7e8ad928(v) do
		v = fn()
		Sleep(0)
	end

	if gRegion:IsMaster() then
		local __wf_atom_8f2a93d8 = v:__wf_atom_8f2a93d8(p)

		if __wf_atom_8f2a93d8:__wf_atom_8598f3a9() then
			return __wf_atom_8f2a93d8
		end

		return nil
	else
		local __wf_atom_d85f9b53 = v:__wf_atom_d85f9b53(p)
		local __wf_atom_95e72410 = __wf_atom_d85f9b53:__wf_atom_95e72410()
		local __wf_atom_b7af9b55 = __wf_atom_d85f9b53:__wf_atom_b7af9b55()

		while __wf_atom_7e8ad928(__wf_atom_95e72410) or __wf_atom_b7af9b55 == 3 do
			Sleep(0)

			if __wf_atom_7e8ad928(v) then
				return nil
			end

			local __wf_atom_d85f9b53_2 = v:__wf_atom_d85f9b53(p)
			__wf_atom_95e72410 = __wf_atom_d85f9b53_2:__wf_atom_95e72410()
			__wf_atom_b7af9b55 = __wf_atom_d85f9b53_2:__wf_atom_b7af9b55()
		end

		return (fn8(__wf_atom_95e72410, false, __wf_atom_b7af9b55))
	end
end

function GetCrewMemberInfoFromCrewShip(p)
	return (fn9(p))
end

function GetCrewMemberInfoFromPlayerLoadout(p, p2)
	return (fn8(p, false, p2))
end

function GetCrewMemberInfoFromSecondInCommand(p)
	return (fn8(p, true))
end

local function fn10(object, p, p2, p3)
	if __wf_atom_7e8ad928(object) or not object:__wf_atom_8598f3a9() then
		return false
	end

	local mCrewMemberGeneratedDetails = object.mCrewMemberGeneratedDetails

	if __wf_atom_7e8ad928(mCrewMemberGeneratedDetails) then
		return false
	end

	local v = Resource(mCrewMemberGeneratedDetails.mTransmissionSet)
	local transmissionSpeakerData = SF.TransmissionSpeakerData()
	transmissionSpeakerData.mStringData = object.mItemId.mId
	local v2

	if p3 then
		v2 = module2.PlayLocalTransmission(v, p, gRegion:__wf_atom_c4f78a8f(), transmissionSpeakerData)
	else
		v2 = module2.PlayGlobalTransmission(v, p, nil, nil, transmissionSpeakerData)
	end

	if v2 and not __wf_atom_7e8ad928(p2) then
		if __wf_atom_7e8ad928(_T.CrewMemberSharedTransmissionTimeStamp) then
			_T.CrewMemberSharedTransmissionTimeStamp = {}
		end

		_T.CrewMemberSharedTransmissionTimeStamp = Time()
	end

	return v2
end

local function fn11(instance, p) -- 1 equivalent call inferred from this helper
	if instance:__wf_atom_bedb4e3f() or instance:IsKilled() then
		return false
	end

	if __wf_atom_7e8ad928(_T.CrewMemberSharedTransmissionTimeStamp) or p then
		return true
	end

	return false
end

local function fn12(instance, p, p2, p3, p4)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_43e0c427) then
		instance = instance:__wf_atom_6009c8ed()
	end

	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(gGameRules) then
		return false
	end

	if not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_c3b255b8 = gRegion:__wf_atom_c3b255b8()

		if not __wf_atom_7e8ad928(__wf_atom_c3b255b8) and __wf_atom_c3b255b8:__wf_atom_7d4910e4() then
			return false
		end
	end

	if not p3 and not fn11(instance, p2) then -- inferred equivalent call
		return false
	end

	local v

	if
		gGameRules:__wf_atom_95862cc1()
		or not gGameRules:IsA(__wf_atom_dd9a0bb8)
		or gGameRules:__wf_atom_e22d6f15() == 32
	then
		v = fn9(instance)
		return (fn10(v, p, instance, p4))
	end

	local __wf_atom_6115a2e2 = instance:__wf_atom_6115a2e2()

	if __wf_atom_7e8ad928(__wf_atom_6115a2e2) then
		return false
	end

	v = fn8(__wf_atom_6115a2e2:__wf_atom_0d9c1a58(), true)
	return (fn10(v, p, instance, p4))
end

local function fn13(p, p2)
	local crewMembers = module3.GetCrewMembers()

	if not __wf_atom_7e8ad928(crewMembers) and #crewMembers > 0 then
		local crewMember = crewMembers[__wf_atom_c08f5a0e(1, #crewMembers)]

		if not __wf_atom_7e8ad928(crewMember) then
			return (fn12(crewMember:__wf_atom_50a7d83e(), p, false, false, p2))
		end
	end

	return false
end

local function fn14(p, p2, callback)
	local crewMembers = module3.GetCrewMembers()

	if not (not __wf_atom_7e8ad928(crewMembers) and #crewMembers > 0 and not __wf_atom_7e8ad928(callback)) then
		return false
	end

	for _, crewMember in ipairs(crewMembers) do
		if __wf_atom_7e8ad928(crewMember) then
			continue
		end

		local __wf_atom_50a7d83e = crewMember:__wf_atom_50a7d83e()

		if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			continue
		end

		local __wf_atom_30e3d82b = __wf_atom_50a7d83e:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and callback(__wf_atom_30e3d82b) then
			return (fn12(__wf_atom_50a7d83e, p, false, false, p2))
		end
	end

	return false
end

function PlayTransmission(p, p2, p3, p4, p5)
	return (fn12(p, p2, p3, p4, p5))
end

function PlayTransmissionWithInfo(p, p2, p3)
	return (fn10(p, p2, p3, true))
end

function PlayTransmissionOnRandomCrew(p, p2)
	return (fn13(p, p2))
end

function PlayTransmissionWithCondition(p, p2, p3)
	return (fn14(p, p2, p3))
end

function GetCrewMemberTrait(p)
	local mItemType = Resource(p)

	if __wf_atom_7e8ad928(mItemType) then
		return ""
	end

	local upgradeInfo = SF.UpgradeInfo()
	upgradeInfo.mItemType = mItemType
	local __wf_atom_70b880cb = Resource(upgradeInfo.mInstance):__wf_atom_70b880cb("")
	local v = ""

	for _, affix in ipairs(__wf_atom_70b880cb.affixes) do
		if #v > 0 then
			v ..= "\r\n"
		end

		v ..= affix
	end

	return v, __wf_atom_70b880cb
end