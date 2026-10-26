local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Effects.IdolEffects")
local v = 25
local v2 = 10

local function fn(p, p2)
	local magikForceCalc = module.magikForceCalc(p2, p, mOwner)
	module.magikEnergyCalc(p2, p, mOwner)

	if p <= 1 then
		v2 = 8
		v = 10
	elseif p == 2 then
		v2 = 10
		v = 12
	elseif p == 3 then
		v2 = 12
		v = 15
	else
		v2 = 15
		v = 20
	end

	v2 *= magikForceCalc
	v *= magikForceCalc
end

function NpcEvaluateAbility(_, _)
	return 0
end

function GetAbilityUpgradeLevelInfo()
	mOwner = _T.AbilityLevelQueryParms.Ability
	fn(_T.AbilityLevelQueryParms.Level, _T.AbilityLevelQueryParms.Avatar)
	local abilityUpgradeLevelInfo = {}
	table.insert(abilityUpgradeLevelInfo, {
		Label = "HEAL AMOUNT",
		Value = v,
		ValuePost = "HEAL PER SECOND"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/ABILITY_RADIUS",
		Value = 5,
		ValueUnit = "/Lotus/Language/Game/UNIT_METER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/POWER_DURATION",
		Value = v2,
		ValueUnit = "/Lotus/Language/Game/UNIT_SECOND"
	})
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

function ActivateAbility(object, object2, _, p)
	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	fn(p, object2)
	module.EnableWeaponSlot(object2, "Idol", true, 0)

	while object2:__wf_atom_d2b2176d():__wf_atom_d93821d0(0) do
		Sleep(0)
	end

	if object2:__wf_atom_4417a5d4() then
		object2:__wf_atom_d2b2176d():Equip(0, 0, 2)
	end

	module.SetForceAim(object2, mOwner, true)
	module.AddCastImmunity(object2)
	module.Fear(object2, 10)
	object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	Sleep(0)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v3

	if not __wf_atom_7e8ad928(pactFxType) then
		v3 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	object2:Attach(castFxType, EMPTY_SYMBOL)

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Slam", false, 4, 1, true, 1) then
		return
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_6009c8ed()) then
		return
	end

	object2:__wf_atom_8a035cd5(Symbol("VirtueSwap"), false)
	local __wf_atom_2f2bada0 = object2:__wf_atom_2f2bada0()
	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"), false)
	local v4 = Vector(-0.05, 0, 0.85)
	local v5 = __wf_atom_1c374cc9 + __wf_atom_9341614d(v4, __wf_atom_2f2bada0)
	v5.y = object2:__wf_atom_a2a18137().y
	local v6 = Vector(0, 0, 0)
	local v7 = Rotation(0, 0, 0)
	local v8 = {
		__wf_atom_4ebf67cb,
		__wf_atom_3feeb44a,
		__wf_atom_43e0c427,
		__wf_atom_7b01f9ce,
		__wf_atom_3ae8d73b
	}
	gRegion:__wf_atom_267afa54(v5 + Vector(0, 1, 0), v5 - Vector(0, 1, 0), nil, v8, nil, v6, v7, true)
	gRegion:CreateEntity(slamFxType, v6, v7, object)
	module.RemoveCastImmunity(object2)
	object:__wf_atom_6009c8ed():__wf_atom_8914dfde("Cast", 2)
	mOwner:__wf_atom_a7328d06(true)

	if gRegion:IsMaster() then
		gRegion:CreateEntity(decoType, v5, __wf_atom_2f2bada0, object)
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Destroy()
	end
end

function DeactivateAbility(_, object, _, _)
	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	module.EnableWeaponSlot(object, "Idol", false, 0)

	if object:__wf_atom_4417a5d4() then
		object:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
	end

	module.EnableWeaponFiring(object, mOwner, true)
	module.SetForceAim(object, mOwner, false)
end

function TotemLoop(instance)
	local creator = instance:GetCreator()

	while __wf_atom_7e8ad928(creator) do
		Sleep(0)
		creator = instance:GetCreator()
	end

	local __wf_atom_6009c8ed = creator:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		instance:Destroy()
		return
	end

	if creator:__wf_atom_f5ca3244() then
		mOwner = creator:__wf_atom_e21e8409(WeakResource("/SF/Souls/Default/FeyHealthTotemAbilityPrime"))
	else
		mOwner = creator:__wf_atom_e21e8409(WeakResource("/SF/Souls/Default/FeyHealthTotemAbility"))
	end

	local __wf_atom_e8008ec5 = creator:__wf_atom_e8008ec5(mOwner)
	fn(
		not (__wf_atom_e8008ec5 < creator:__wf_atom_87a16e10()) and 1 or creator:__wf_atom_cc3c265a(__wf_atom_e8008ec5) or 1,
		__wf_atom_6009c8ed
	)
	local __wf_atom_18aa6e58 = instance:__wf_atom_18aa6e58()
	Sleep(0)

	if not gRegion:IsMaster() then
		return
	end

	if __wf_atom_7e8ad928(_T.FeyHealthTotems) then
		_T.FeyHealthTotems = {}
	end

	_T.FeyHealthTotems[__wf_atom_18aa6e58] = {}
	_T.FeyHealthTotems[__wf_atom_18aa6e58].avatars = {}
	local v3 = instance:Attach(scriptTriggerType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, creator)

	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_400189c4(5)
	end

	local v4 = v2
	local v5 = 0
	local v6 = 0

	while
		not __wf_atom_7e8ad928(__wf_atom_6009c8ed)
		and not __wf_atom_6009c8ed:IsKilled()
		and not __wf_atom_7e8ad928(creator)
		and v4 > 0
		and not Game.__wf_atom_2b221245(false)
	do
		local v7 = __wf_atom_084b3e93()
		v4 -= v7

		if v5 <= 0 then
			if
				__wf_atom_7e8ad928(gGameRules)
				or not gGameRules:__wf_atom_45bdab4d(__wf_atom_6009c8ed, instance:GetPosition(), 0.75)
			then
				v5 = 0.2
			else
				break
			end
		else
			v5 -= v7
		end

		if v6 <= 0 then
			v6 = 0.5

			for _, avatar in ipairs(_T.FeyHealthTotems[__wf_atom_18aa6e58].avatars) do
				if __wf_atom_7e8ad928(avatar) then
					continue
				end

				if __wf_atom_7e8ad928((avatar:__wf_atom_bb3e7833(avatarAttachFxType))) then
					avatar:Attach(avatarAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				end

				local __wf_atom_c6f1f83d = avatar:__wf_atom_c6f1f83d()

				if not (__wf_atom_c6f1f83d < avatar:GetMaxHealth()) then
					continue
				end

				local __wf_atom_2a745663 = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_2a745663(
					v,
					473,
					nil,
					nil,
					26,
					Symbol("HEAL_FROM_CAST")
				)
				avatar:Heal(avatar, __wf_atom_2a745663, __wf_atom_6009c8ed)
				avatar:NotifyHeal(__wf_atom_6009c8ed:__wf_atom_a96eb2aa(), __wf_atom_2a745663, 0, 1)
				module.NotifyHeal(__wf_atom_6009c8ed, avatar:__wf_atom_c6f1f83d() - __wf_atom_c6f1f83d)
			end
		else
			v6 -= v7
		end

		Sleep(0)
	end

	for _, avatar in ipairs(_T.FeyHealthTotems[__wf_atom_18aa6e58].avatars) do
		if __wf_atom_7e8ad928(avatar) then
			continue
		end

		local __wf_atom_bb3e7833 = avatar:__wf_atom_bb3e7833(avatarAttachFxType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end

	table.remove(_T.FeyHealthTotems, __wf_atom_18aa6e58)
	instance:Destroy()

	if not __wf_atom_7e8ad928(creator) then
		creator:__wf_atom_e6831c5c(mOwner, Symbol("DoCooldownUnpause"), SF.SecondaryScriptArgs(false))
	end
end

function TotemTriggerEntered(object, instance)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_18aa6e58 = __wf_atom_3d96ddcd:__wf_atom_18aa6e58()

	if instance:IsA(__wf_atom_d127f143) then
		instance = instance:__wf_atom_6009c8ed()

		if __wf_atom_7e8ad928(instance) then
			return
		end
	elseif instance:IsA(__wf_atom_47cae841) then
		local __wf_atom_4221009f = instance:__wf_atom_4221009f()

		if not __wf_atom_7e8ad928(__wf_atom_4221009f) then
			instance = __wf_atom_4221009f
		end
	end

	local creator = __wf_atom_3d96ddcd:GetCreator()

	if __wf_atom_7e8ad928(creator) then
		return
	end

	local __wf_atom_6009c8ed = creator:__wf_atom_6009c8ed()

	if
		__wf_atom_7e8ad928(__wf_atom_6009c8ed)
		or not instance:__wf_atom_4402f880(__wf_atom_6009c8ed)
		or not instance:__wf_atom_42397c84(__wf_atom_6009c8ed)
		or not __wf_atom_6009c8ed:__wf_atom_f2309174(instance)
		or instance:__wf_atom_c832c6f1(Symbol("ALLY_BUFFS"))
	then
		return
	end

	local v3 = false

	for _, avatar in ipairs(_T.FeyHealthTotems[__wf_atom_18aa6e58].avatars) do
		if avatar ~= instance then
			continue
		end

		v3 = true
		break
	end

	if not v3 then
		local avatars = _T.FeyHealthTotems[__wf_atom_18aa6e58].avatars
		avatars[#avatars + 1] = instance
	end
end

function TotemTriggerExited(object, object2)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_18aa6e58 = __wf_atom_3d96ddcd:__wf_atom_18aa6e58()
	local avatars = _T.FeyHealthTotems[__wf_atom_18aa6e58].avatars
	local v3 = {}

	for i = #avatars, 1, -1 do
		if avatars[i] == object2 then
			v3[#v3 + 1] = i
		end
	end

	local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(avatarAttachFxType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	for _, v4 in ipairs(v3) do
		table.remove(avatars, v4)
	end
end

function VirtueSwap(p)
	module2.FeyVirtueSwap(p, 1, 2)
end

function DoCooldownUnpause(_, _, _, _, _, _, _)
	mOwner:__wf_atom_a7328d06(false)
end