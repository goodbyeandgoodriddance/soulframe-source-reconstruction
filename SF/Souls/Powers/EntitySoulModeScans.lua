local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Fx.Equipment.Motes.MoteCapture")
local module4 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local v = Resource("/SF/Sounds/UI/DefaultUI/UISoulScanReady")
local v2 = WeakResource("/SF/Types/Player/Ghost/SfSparrowGhostAvatar")
local total = 0
local total2 = 0
local v3 = 0
local v4 = WeakResource("/SF/Types/Game/SoulStealInfo/ScanBaseTypeSSE")
local v5 = Type("/SF/Types/Player/Ghost/SfSparrowGhostAvatar")
local v6 = WeakResource("/SF/Types/Game/Ancestors/Orlick/OrlickAncestor")

function AttachMite(originalOwner, _, _)
	local v7 = false

	if not gRegion:IsMaster() then
		return
	end

	if __wf_atom_7e8ad928(originalOwner) or originalOwner:IsKilled() then
		print("Avatar Died no mote making today")
		return
	end

	Sleep(0.1)
	local __wf_atom_30e3d82b = originalOwner:__wf_atom_30e3d82b()
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		while not v7 do
			for _, v8 in pairs(__wf_atom_ef7900cf) do
				v7 = module.IsSoulModeActive(v8)
			end

			Sleep(0)
		end

		if
			(__wf_atom_7e8ad928(__wf_atom_30e3d82b:__wf_atom_1793a706()) or __wf_atom_30e3d82b:__wf_atom_1793a706() == 1)
			and math.random() <= chance
		then
			originalOwner:Attach(
				miteAttach,
				Symbol("GAME_C1_HIP1"),
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1,
				originalOwner
			)
			local __wf_atom_bb3e7833 = originalOwner:__wf_atom_bb3e7833(miteAttach)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				local __wf_atom_e919fb8e = __wf_atom_bb3e7833:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.OriginalOwner = originalOwner
				local __wf_atom_e919fb8e_2 = __wf_atom_bb3e7833:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e_2.OriginalOwnerType = originalOwner:__wf_atom_1bb5b1ff()
			end
		end
	end
end

function MoteFlee(instance, _, _)
	module3.MoteMovementUpdate(instance, 1.5, {
		moveAwayDistance = 15,
		maxStages = 5,
		moveSpeed = 16,
		infiniteFleeDistance = true
	})
	instance:Destroy()
end

function CharacterMiteUpdate(instance, _, _)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_f7e7be53 = instance:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) or __wf_atom_f7e7be53:IsKilled() then
		print("Mite Destroyed, owner is dead")
		instance:Destroy()
	else
		local __wf_atom_30e3d82b = __wf_atom_f7e7be53:__wf_atom_30e3d82b()

		while not __wf_atom_7e8ad928(instance) do
			if __wf_atom_7e8ad928(__wf_atom_f7e7be53) or __wf_atom_f7e7be53:IsKilled() then
				print("Mite Destroyed, owner is dead")
				instance:Destroy()
				return
			else
				local v7 = __wf_atom_7e8ad928(__wf_atom_30e3d82b:__wf_atom_1793a706())
					or __wf_atom_30e3d82b:__wf_atom_1793a706() == 3

				if not v7 and __wf_atom_30e3d82b:__wf_atom_1793a706() == 2 then
					local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
					local __wf_atom_93531a72 = __wf_atom_30e3d82b:__wf_atom_93531a72()

					for _, v8 in __wf_atom_ef7900cf do
						if not (__wf_atom_93531a72 < __wf_atom_30e3d82b:__wf_atom_5bee0a94(v8)) then
							continue
						end

						v7 = true
						break
					end
				end

				if v7 then
					print("Mite fleeing, owner is alert")
					instance:__wf_atom_e6ed03c8()
					instance:__wf_atom_8a035cd5(Symbol("MoteFlee"), false)
					return
				else
					Sleep(0)
				end
			end
		end
	end
end

local function fn(p, object, object2, p2, p3)
	if __wf_atom_7e8ad928(p) and __wf_atom_7e8ad928(object) then
		return
	end

	local _ = object and object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(object) or not object:__wf_atom_d82da62f() then
		if not __wf_atom_7e8ad928(p) then
			object2:__wf_atom_d2b2176d():__wf_atom_6379d01f(p)
		end
	else
		object2:__wf_atom_d2b2176d():__wf_atom_f5437366(object:__wf_atom_d3d57326())
	end

	if p2 then
		local __wf_atom_0d9c1a58 = object2:__wf_atom_0d9c1a58()
		__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_0d9c1a58, p3)
	end
end

function GiveAnimalScan(p, p2, p3, p4)
	if __wf_atom_7e8ad928(p) then
		return
	end

	fn(p, nil, p2, p3, p4)
end

function GiveEnemyScan(object, p)
	if module4.GetAncestorUpgradeRankValueForTag(v6, Symbol("EnemyScanModeUpgrade"), Symbol("ENABLE")) > 0 then
		fn(object:__wf_atom_575542c8(), object, p, isChallengeScan, challengeTag)
	end
end

function GiveSoulScan(instance, object)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	local total3 = 0
	local flag = false

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local v7 = GetSoulScanTable(object)
	print("timeScanningCompleted", v7.timeScanningCompleted, 1, Time() - v7.timeScanningCompleted)

	if v7 ~= nil and v7.timeScanningCompleted ~= nil and Time() - v7.timeScanningCompleted <= 1 then
		flag = true
	end

	while not (__wf_atom_7e8ad928(__wf_atom_e919fb8e) or __wf_atom_e919fb8e.bPullComplete) do
		Sleep(0)

		if __wf_atom_7e8ad928(object) or object:IsKilled() then
			return
		end

		total3 += __wf_atom_084b3e93()

		if total3 > 2 then
			break
		end
	end

	print("Mite captured, " .. __wf_atom_3d96ddcd:GetName() .. " added to codex")

	if isChallengeScan then
		__wf_atom_539492fe:__wf_atom_c2038c7a(object, challengeTag)
	end

	object:__wf_atom_d2b2176d():__wf_atom_6379d01f(__wf_atom_3d96ddcd)

	if flag then
		print("Perfect scan!")
	end

	Sleep(0)

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

local function fn2(instance, instance2)
	if __wf_atom_7e8ad928(instance2) or instance2:IsKilled() then
		return false
	end

	if instance2:__wf_atom_129d1aba(instance) then
		if __wf_atom_7e8ad928(instance2:__wf_atom_a96eb2aa()) or not instance2:IsA(v2) then
			return false
		end
	elseif instance2:IsA(__wf_atom_6c243c5e) then
		if instance2:__wf_atom_60a880d0() or not instance2:__wf_atom_4573db05() then
			return false
		end
	else
		local __wf_atom_bb3e7833 = instance2:__wf_atom_bb3e7833(__wf_atom_faccb0cf)

		if
			__wf_atom_7e8ad928(__wf_atom_bb3e7833)
			or not (__wf_atom_bb3e7833:__wf_atom_572fc369() and __wf_atom_bb3e7833:IsA(v4))
		then
			return false
		end
	end

	return true
end

function GetSoulScanTable(object, p)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
		return nil
	end

	if __wf_atom_e919fb8e.soulScan == nil or p then
		__wf_atom_e919fb8e.soulScan = {
			isPlayerSoulScanning = false,
			potentialScanTargets = {},
			validScanningTargets = {},
			timeScanningCompleted = nil
		}
	end

	return __wf_atom_e919fb8e.soulScan
end

function SoulScanMode(instance, _, object, object2, object3)
	if __wf_atom_7e8ad928(instance) or instance:IsKilled() or instance:IsA(v5) then
		return
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object3) then
		return
	end

	local v7 = GetSoulScanTable(instance, false)
	local aimPosition = instance:GetAimPosition()
	local v8 = __wf_atom_e97f3142(instance:__wf_atom_4e50d390())
	local position = instance:GetPosition()
	v7.potentialScanTargets = instance:__wf_atom_0251b5eb(2, 10, 1.5, true, true) or {}
	local __wf_atom_f2e7f4a9 = object:__wf_atom_f2e7f4a9()

	if not __wf_atom_7e8ad928(__wf_atom_f2e7f4a9) then
		if __wf_atom_f2e7f4a9:IsA(__wf_atom_d127f143) then
			__wf_atom_f2e7f4a9 = __wf_atom_f2e7f4a9:__wf_atom_6009c8ed()
		end

		if
			not __wf_atom_7e8ad928(__wf_atom_f2e7f4a9)
			and __wf_atom_f2e7f4a9:IsA(__wf_atom_4ebf67cb)
			and __wf_atom_f2e7f4a9:__wf_atom_d5fda8be(position) <= 10
		then
			table.insert(v7.potentialScanTargets, 1, __wf_atom_f2e7f4a9)
		end
	end

	for i, validScanningTarget in ipairs(v7.validScanningTargets) do
		if not (not fn2(instance, validScanningTarget) or not (Dot(
			validScanningTarget:__wf_atom_a2a18137() - aimPosition,
			v8
		) > 0) or module.IsInTable(validScanningTarget, v7.validScanningTargets)) then
			continue
		end

		table.remove(v7.validScanningTargets, i)
	end

	for i, potentialScanTarget in ipairs(v7.potentialScanTargets) do
		if not (fn2(instance, potentialScanTarget) and Dot(potentialScanTarget:__wf_atom_a2a18137() - aimPosition, v8) > 0) then
			continue
		end

		if module.IsInTable(potentialScanTarget, v7.validScanningTargets) then
			continue
		end

		table.insert(v7.validScanningTargets, i, potentialScanTarget)
	end

	if __wf_atom_7e8ad928(v7.validScanningTargets) or #v7.validScanningTargets == 0 then
		object2:__wf_atom_25382a0d(1, false)
		v7.isPlayerSoulScanning = false
		total2 = 0
		total = 0
		v3 = 0
	elseif not v7.isPlayerSoulScanning then
		object3:__wf_atom_5b5911cb(0)

		for _, _ in pairs(v7.validScanningTargets) do
			if total < 0.7 then
				total += __wf_atom_084b3e93()
			elseif total2 < 4 then
				total2 += __wf_atom_084b3e93()
				v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93(), 0, 4)
				object2:__wf_atom_25382a0d((__wf_atom_104bfe98(1, 0.4, __wf_atom_24a82b69(v3 / 4))))
			elseif total2 > 4 then
				v7.isPlayerSoulScanning = true
				module2.PlaySound(v)
				object2:__wf_atom_25382a0d(0.4)
				total2 = 0
				v3 = 0
				v7.timeScanningCompleted = Time()
			end
		end
	end
end

function ResetFov(object, _, _)
	local cameraControl = object:CameraControl()
	module.AttunateFovOverTime(cameraControl, 10, 1)
end

function EndSoulmodeScan(instance, _, object)
	if __wf_atom_7e8ad928(instance) or instance:IsA(v5) or instance:IsKilled() then
		return
	end

	GetSoulScanTable(instance, true)
	object:__wf_atom_5b5911cb(Resource(object:__wf_atom_1bb5b1ff()):__wf_atom_ab10ec5a())
	local cameraControl = instance:CameraControl()

	if not __wf_atom_7e8ad928(cameraControl) then
		cameraControl:__wf_atom_25382a0d(1, false)
	end
end