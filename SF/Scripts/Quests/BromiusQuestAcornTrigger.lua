local module = require("SF.Scripts.Effects.EnvoyEffects")
local module2 = require("SF.Scripts.Libs.AncestorsFunctionLib")
require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")

function PlantAcornAnimation(_, object)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("AcornPickup"), object:GetPosition(), 0, 20)
	object:__wf_atom_921c1a5f(acornDropAnim, true)
	object:__wf_atom_8914dfde("Placed", 2)
	gRegion:__wf_atom_dd1e4d10(__wf_atom_f738b4af)
end

function ArmTranstiton(p)
	module.ArmTransition(p, true, armTransitionTime, armSpeedMult, true, transtionBackDelay)
end

function EchoSwapCouncilOfTrees()
	for i = 0, 4 do
		local v = Symbol(echoTreeDeadTag .. i)
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v)

		for _, v2 in ipairs(__wf_atom_2226b35c) do
			v2:SetVisibility(not toEcho, true)
		end

		local v2 = Symbol(echoTreeAliveTag .. i)
		local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(v2)

		for _, v3 in ipairs(__wf_atom_2226b35c2) do
			v3:SetVisibility(toEcho, true)
		end
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("CompletedTreeDeco"))

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		for _, v in ipairs(__wf_atom_2226b35c) do
			v:SetVisibility(false, true)
		end
	end
end

local function fn(p, p2)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p2)
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(p)

	for _, v in ipairs(__wf_atom_2226b35c) do
		v:SetVisibility(true, true)
		v:__wf_atom_68f2c268(1)

		if v:IsA(TrunkType) then
			v:Attach(TrunkFX, EMPTY_SYMBOL)
		end
	end

	Sleep(5)
	local v = 1

	while v > 0 do
		local v2 = __wf_atom_24a82b69(v)

		for _, v3 in ipairs(__wf_atom_2226b35c2) do
			v3:__wf_atom_68f2c268(1 - v2)
		end

		for _, v3 in ipairs(__wf_atom_2226b35c) do
			v3:__wf_atom_68f2c268(v2)
		end

		Sleep(0)
		v -= __wf_atom_084b3e93() * 0.5
	end

	for _, v2 in ipairs(__wf_atom_2226b35c2) do
		v2:SetVisibility(false, true)
	end
end

function DisableChildren(object)
	object:SetVisibility(false)
end

function AltAcornPlacement(object, object2)
	local v = nil
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	object:Disable()

	if object2:__wf_atom_4417a5d4() then
		__wf_atom_d2b2176d:Unequip(0, 1)
	end

	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	object2:__wf_atom_3c986cd9(module3.GetGroundPos(position), __wf_atom_dc309f8a, true)
	object2:__wf_atom_921c1a5f(acornDropAnim, false, 4, 1, false)
	object2:__wf_atom_8a035cd5(Symbol("ArmTranstiton"), false)

	if not __wf_atom_7e8ad928(acornDeco) then
		v = object2:Attach(acornDeco, Symbol("GAME_R1_WEAPON1"), Vector(-0.03, -0.04, 0), __wf_atom_80368bb1)
		v:SetMeshScale(0.5, true)
		v:__wf_atom_0ed81088(false)
	end

	object2:__wf_atom_8914dfde("Placed", 6)

	if __wf_atom_7e8ad928(object2) then
		object2 = gRegion:__wf_atom_c4f78a8f()
	end

	if not __wf_atom_7e8ad928(v) then
		v:__wf_atom_e6ed03c8()
		v:__wf_atom_0ed81088(true)

		if not __wf_atom_7e8ad928(acornPlacementPoint) then
			v:SetPosition(acornPlacementPoint:GetPosition())
			v:__wf_atom_9b788a35(acornPlacementPoint:__wf_atom_dc309f8a())
		end
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:MotionControl():__wf_atom_99fc7a82(true)
	end

	local v2

	if object:__wf_atom_db682341() == Symbol("FinalAcornPlantingTrigger") then
		v2 = Symbol("FinalBromiusDirtMound")
	else
		v2 = mudFXTag
	end

	local nearestTagged = gRegion:FindNearestTagged(v2, gRegion:__wf_atom_c4f78a8f():GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		local __wf_atom_be0bea4a = nearestTagged:__wf_atom_be0bea4a()

		for _, v3 in ipairs(__wf_atom_be0bea4a) do
			v3:SetVisibility(false, true)
		end
	end

	if __wf_atom_7e8ad928(_T.acornsPlanted) then
		_T.acornsPlanted = gGameRules:__wf_atom_d163c8e5(Symbol("BromiusAcornsPlanted"))
	end

	_T.acornsPlanted += 1
	gGameRules:SetNetPersistentVar(Symbol("BromiusAcornsPlanted"), _T.acornsPlanted)
	fn(treeDeadTag, treeAliveTag)

	for k, v3 in pairs(_T.deadTreesToBeHealed) do
		if v3 ~= treeDeadTag then
			continue
		end

		table.remove(_T.deadTreesToBeHealed, k)
		break
	end

	if _T.acornsPlanted == _T.acornsToPlant then
		for _, v3 in ipairs(_T.deadTreesToBeHealed) do
			local v4 = tostring(v3)
			local v5 = "CoTDEAD" .. tostring((string.sub(tostring(v3), -1)))
			fn(Symbol(v4), Symbol(v5))
		end
	end
end

function VerminiaAcornDance(p, object)
	if __wf_atom_7e8ad928(_T.acornsPlanted) then
		_T.acornsPlanted = gGameRules:__wf_atom_d163c8e5(Symbol("BromiusAcornsPlanted"))
	end

	if not __wf_atom_7e8ad928(_T.acornsPlanted) and _T.acornsPlanted ~= 1 then
		return
	end

	if not __wf_atom_7e8ad928(object) then
		object:Disable()
	end

	if
		not __wf_atom_7e8ad928(_T.acornsPlanted)
		and not __wf_atom_7e8ad928(_T.acornsToPlant)
		and _T.acornsPlanted == _T.acornsToPlant - 1
	then
		local v = module2.TryAppearRelativeToPlayer(p, ancestorDecoType, nil, {
			distance = 3,
			minSpawnDist = 1,
			maxSpawnVerticalDist = 2,
			tryBehind = false,
			validateFunc = function()
				local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

				if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
					return false
				end

				local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)
				return not (__wf_atom_7e8ad928(playerAvatar) or playerAvatar:IsKilled() or playerAvatar:__wf_atom_799d95f5() or _T.LocalPlayerInNightFold)
			end
		}, true)
		module2.DissolveIn(v)

		if not (__wf_atom_7e8ad928(ancestorTransmissionTag) or __wf_atom_7e8ad928(ancestorTransmissionSet)) then
			module2.PlayAncestorTransmission(
				ancestorTransmissionSet,
				ancestorTransmissionTag,
				v,
				triggeredAnimTag,
				nil,
				true
			)
		end

		module2.DissolveOut(v)
	end
end