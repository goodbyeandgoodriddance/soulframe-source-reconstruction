module(..., package.seeall)
local v = WeakResource("/Lotus/Types/Enemies/CaptureTargets/CaptureTargetBaseAvatar")
local v2 = nil
local v3 = Symbol("PanicSystemStatus")
UNALERT = 0
ALERT = 1
LOCKDOWN = 2

local function fn(p, p2, p3)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) and #__wf_atom_2226b35c > 0 then
		for _, v4 in ipairs(__wf_atom_2226b35c) do
			v4:FirePort(p2)

			if p3 then
				return
			end
		end
	end
end

local function fn2()
	if __wf_atom_7e8ad928(v2) then
		v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	if v2:__wf_atom_7be145fc() == true then
		v2:__wf_atom_4f39f8a7(false)

		if not __wf_atom_7e8ad928(_T.CurrentBreachZone) then
			_T.DeactivatedBreachZone = _T.CurrentBreachZone
			_T.CurrentBreachZone = nil
		end

		print("Alarm System: Cleared hull breach")
	end
end

local function fn3(object)
	local __wf_atom_e800787c = object:__wf_atom_e800787c()

	if not __wf_atom_7e8ad928(__wf_atom_e800787c) then
		local layerIndex = __wf_atom_e800787c:GetLayerIndex()
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("PanicButtonTileEvents"))

		for _, v4 in ipairs(__wf_atom_2226b35c) do
			local __wf_atom_e800787c2 = v4:__wf_atom_e800787c()

			if __wf_atom_7e8ad928(__wf_atom_e800787c2) or layerIndex ~= __wf_atom_e800787c2:GetLayerIndex() then
				continue
			end

			v4:FirePort("TriggerPort")
		end
	end
end

local function fn4()
	local unalert = UNALERT

	if not gRegion:IsMaster() then
		unalert = gGameRules:__wf_atom_d163c8e5(v3)
		return unalert
	end

	if __wf_atom_7e8ad928(v2) then
		v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	if v2:__wf_atom_49db0c0b() then
		return LOCKDOWN
	end

	if v2:__wf_atom_efacaf12() then
		return ALERT
	end

	return unalert
end

function GetCurrentPanicStatus()
	return (fn4())
end

local function fn5()
	local __wf_atom_e22d6f15 = gGameRules:__wf_atom_e22d6f15()

	if __wf_atom_e22d6f15 == 8 or __wf_atom_e22d6f15 == 2 or __wf_atom_e22d6f15 == 34 then
		return true
	end

	return __wf_atom_e22d6f15 == 9 and gGameRules:__wf_atom_d163c8e5(Symbol("WaveTimer")) > 0
end

local function fn6(p, p2)
	local v4 = fn4()
	print("Alarm System: Triggering panic events, current status = " .. v4 .. ", new status = " .. p)
	local v5 = fn5() or p2

	if p == LOCKDOWN then
		v2:SetLockDown(true, 180)
		fn(Symbol("DoorHint"), "Lock")
		fn(Symbol("PanicLight"), "TurnOn")
	else
		v2:SetLockDown(false, 180)

		if v4 == LOCKDOWN then
			fn(Symbol("DoorHint"), "Unlock")
			fn(Symbol("PanicLight"), "TurnOff")
		end

		fn(Symbol("Alarm"), "Disable")
		fn(Symbol("AlarmFlare"), "Disable")
		fn(Symbol("AlarmLight"), "Disable")
	end

	if ALERT <= p then
		v2:__wf_atom_ac65571b(true)
		gGameRules:__wf_atom_27e65463(true)
	elseif p == UNALERT then
		if not v5 then
			v2:__wf_atom_ac65571b(false)
		end

		gGameRules:__wf_atom_27e65463(false)
	end

	fn(Symbol("PanicButtonMasterScript"), "Execute", true)
end

local function fn7(p)
	if not gRegion:IsMaster() then
		return
	end

	if __wf_atom_7e8ad928(v2) then
		v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	if p == UNALERT then
		fn6(UNALERT)
	elseif p == ALERT then
		fn6(ALERT)
	elseif p == LOCKDOWN then
		fn6(LOCKDOWN)
	end

	gGameRules:SetNetPersistentVar(v3, p)
end

local function fn8(object, instance)
	if not (__wf_atom_7e8ad928(_T.harlequinObjectChange) or __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance:__wf_atom_30e3d82b())) then
		local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_8d0b7f88)

		if not __wf_atom_7e8ad928(__wf_atom_f582136d) then
			local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

			for i = 1, #__wf_atom_3c8e1a7a do
				local __wf_atom_ef151cfd = __wf_atom_3c8e1a7a[i]:__wf_atom_ef151cfd()

				if __wf_atom_7e8ad928(_T.harlequinObjectChange[__wf_atom_ef151cfd]) then
					continue
				end

				for j = 1, #__wf_atom_f582136d do
					local v4 = _T.harlequinObjectChange[__wf_atom_ef151cfd]

					for k = 1, #v4 do
						if __wf_atom_f582136d[j] ~= v4[k].object then
							continue
						end

						gRegion:CreateEntity(v4[k].params.consoleExplosion, object:GetPosition(), __wf_atom_80368bb1)
						local v5 = __wf_atom_f582136d[j]

						if not __wf_atom_7e8ad928(__wf_atom_3c8e1a7a[i]:__wf_atom_50a7d83e()) then
							v5 = __wf_atom_3c8e1a7a[i]:__wf_atom_50a7d83e():__wf_atom_d2b2176d():__wf_atom_e55d02aa()
						end

						if not __wf_atom_7e8ad928(_T.harlequinObjectChange[__wf_atom_ef151cfd][k].params.consoleAgent) then
							_T.harlequinObjectChange[__wf_atom_ef151cfd][k].params.consoleAgent:__wf_atom_920a5a62()
						end

						gRegion:__wf_atom_f6ec80de(
							__wf_atom_3c8e1a7a[i]:__wf_atom_50a7d83e(),
							__wf_atom_f582136d[j]:GetPosition(),
							v4[k].params.consoleDamage,
							v4[k].params.consoleRange,
							500,
							7,
							__wf_atom_f582136d[j],
							v5,
							19,
							true,
							true,
							false,
							1,
							true
						)
						print("Alarm System: Mirage trap triggered")
						return true
					end
				end
			end
		end
	end
end

function SetPanicLevel(p)
	fn7(p)
end

function ClearHullBreach()
	fn2()
end

function PanicButtonActivated(instance, object, p)
	if __wf_atom_7e8ad928(v2) then
		v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	print("Alarm System: Panic button activated")
	local v4 = fn4()
	local v5

	if not __wf_atom_7e8ad928(instance) then
		local __wf_atom_e93896ba = instance:__wf_atom_e93896ba()
		local __wf_atom_a97361bb = instance:__wf_atom_a97361bb()
		v5 = __wf_atom_e93896ba == Symbol("TENNO") or __wf_atom_a97361bb == Symbol("TENNO")
		print("Alarm System: faction = " .. tostring(__wf_atom_e93896ba) .. " original faction = " .. tostring(__wf_atom_a97361bb))
	end

	fn2()
	local gGameRules = gGameRules

	if not __wf_atom_7e8ad928(gGameRules) then
		local __wf_atom_e22d6f15 = gGameRules:__wf_atom_e22d6f15()

		if __wf_atom_e22d6f15 == 5 then
			if __wf_atom_7e8ad928(instance) or not instance:IsA(v) then
				if __wf_atom_7e8ad928(instance) or not v5 then
					print("Alarm System: Capture: Panic button activate cancelled")
					return
				else
					_T.TimeSinceLastLockdown = 0
				end
			else
				print("Alarm System: Capture: Panic button pressed by capture target")
			end
		elseif __wf_atom_e22d6f15 == 9 and not v5 then
			if gGameRules:__wf_atom_d163c8e5(Symbol("WaveTimer")) > 0 then
				print("Alarm System: Mobile Defense: Panic button activate cancelled")
				return
			end
		elseif __wf_atom_e22d6f15 == 8 then
			print("Alarm System: Defense: Panic button activate cancelled")
			return
		end
	end

	if not (__wf_atom_7e8ad928(instance) or v5) then
		fn8(object, instance)
	end

	local unalert

	if __wf_atom_7e8ad928(instance) then
		unalert = UNALERT
	elseif v5 then
		unalert = UNALERT
		instance:__wf_atom_d2b2176d():__wf_atom_355b9a20(50, instance, Symbol("/Lotus/Language/Actions/HackXP"))
		__wf_atom_539492fe:__wf_atom_c2038c7a(instance:__wf_atom_a96eb2aa(), Symbol("CONSOLE_HACKED"))
		_T.idleTimoutReset = true
	else
		if _T.InstantLockdown then
			unalert = LOCKDOWN
		else
			unalert = math.min(v4 + 1, LOCKDOWN)
		end

		if v4 < unalert and not __wf_atom_7e8ad928(object) then
			if not __wf_atom_7e8ad928(p) then
				object:PlaySound(p, false, 0, true)
			end

			fn3(object)
		end
	end

	fn7(unalert)
end