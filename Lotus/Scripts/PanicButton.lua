local module = require("Lotus.Scripts.Libs.PanicLib")
local module2 = require("Lotus.Scripts.Libs.CommonGamemodeFunctions")
local v = Symbol("SecurityLevel")
local v2 = Symbol("EmissiveTintColor")
local v3 = Symbol("EmissiveTintColorHi")
local v4 = Symbol("EmissiveTintColorLo")

local function fn()
	print("Activate shutters")

	for _, v5 in ipairs(shutters) do
		if not __wf_atom_7e8ad928(v5) then
			v5:FirePort("PlayTriggeredAnim")
		end
	end

	Sleep(4)
end

local function fn2(object, list)
	if not __wf_atom_7e8ad928(list) then
		for i = 1, #list do
			local v5 = list[i]
			local v6 = object:GetPosition() - v5:GetPosition()
			Normalize(v6)
			local damageData = Engine.DamageData()
			damageData.baseAmount = 1
			damageData:__wf_atom_d6f4d914(16, true)
			damageData:__wf_atom_6b472125(object)
			damageData:__wf_atom_34a8a27a(object)
			damageData:__wf_atom_812165c6(0)
			damageData:__wf_atom_12cf5317(v6 * 500)
			v5:__wf_atom_649bf33e(damageData)
		end
	end
end

local function fn3(object)
	local position = object:GetPosition()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("LightFixtureTemplate"), position, 0, 50)

	if not __wf_atom_7e8ad928(__wf_atom_439c0d29) then
		local v5 = __wf_atom_439c0d29[__wf_atom_5784a397(1, #__wf_atom_439c0d29)]

		if not __wf_atom_7e8ad928(v5) then
			v5:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, 0)
			v5:__wf_atom_b811702e(Symbol())
			v5:Destroy()
		end
	end
end

function ShutterShake()
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	if __wf_atom_7e8ad928(__wf_atom_ef7900cf) then
		return
	end

	local v5 = __wf_atom_ef7900cf[1]
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local v6 = nil

	while __wf_atom_7d789620:__wf_atom_7be145fc() == true do
		local position = v5:GetPosition()
		v6 = gRegion:PlaySound(shakeSound, position, false)

		while not __wf_atom_7e8ad928(v6) and __wf_atom_7d789620:__wf_atom_7be145fc() == true do
			postProcess:__wf_atom_54a04966(v6:__wf_atom_31aab74c() * 10)
			Sleep(0)
		end

		Sleep(0)
	end

	Sleep(4)
	postProcess:__wf_atom_54a04966(0)

	if not __wf_atom_7e8ad928(v6) then
		v6:Stop(false)
	end
end

function CinShutterShake()
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	if __wf_atom_7e8ad928(__wf_atom_ef7900cf) then
		return
	end

	local v5 = __wf_atom_ef7900cf[1]
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local position = v5:GetPosition()
	local v6 = gRegion:PlaySound(shakeSound, position, false)

	while not __wf_atom_7e8ad928(v6) do
		postProcess:__wf_atom_54a04966(v6:__wf_atom_31aab74c() * 10)
		Sleep(0)
	end
end

function RandomizeGlass()
	if gPromotedToHost then
		return
	end

	local v5

	if _T.FxLayer == Symbol("Ice") then
		v5 = 0.35
	elseif _T.FxLayer == Symbol("Fire") then
		v5 = 0.35
	elseif _T.FxLayer == Symbol("Infested") then
		v5 = 0.4
	else
		v5 = 0.25
	end

	local v6 = _T.faction == Symbol("RedVeil") and 0 or v5

	for i = 1, #glassPanes do
		local __wf_atom_db682341 = glassPanes[i]:__wf_atom_e800787c():__wf_atom_db682341()

		if Random(0, 1) <= v6 and __wf_atom_db682341 ~= Symbol("Spawn") then
			glassPanes[i]:FirePort("MaterialSwitch")
		else
			glassPanes[i]:FirePort("MakeInvulnerable")
		end
	end
end

local function fn4(object)
	local position = object:GetPosition()
	local all = gRegion:FindAll(avatarType, position, 0, 100)
	local nearestTaggeds = {}

	for i = 1, #triggerZoneObjectTags do
		local nearestTagged = gRegion:FindNearestTagged(triggerZoneObjectTags[i], position)

		if __wf_atom_7e8ad928(nearestTagged) then
			print("Could not find objects with tag " .. tostring(triggerZoneObjectTags[i]))
		else
			table.insert(nearestTaggeds, nearestTagged)
		end
	end

	local result = {}

	if #triggerZoneObjectTags > 0 then
		local triggerZoneObjectTag = triggerZoneObjectTags[1]

		if _T.DeactivatedBreachZone == triggerZoneObjectTag then
			return result
		else
			_T.CurrentBreachZone = triggerZoneObjectTag
		end
	end

	for i = 1, #all do
		local v5 = all[i]
		local __wf_atom_e800787c = v5:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) then
			continue
		end

		for j = 1, #nearestTaggeds do
			if __wf_atom_e800787c == nearestTaggeds[j]:__wf_atom_e800787c() then
				table.insert(result, v5)
			end
		end
	end

	return result
end

function RaiseLevelAlertState() end

local function fn5(object, p)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(coneType)

	if not __wf_atom_7e8ad928(__wf_atom_f582136d) then
		for i = 1, #__wf_atom_f582136d do
			if p then
				__wf_atom_f582136d[i]:FirePort("Show")
				__wf_atom_f582136d[i]:FirePort("ClearMaterialSwitch")
			else
				__wf_atom_f582136d[i]:FirePort("Hide")
			end
		end
	end

	local __wf_atom_f582136d2 = object:__wf_atom_f582136d(GreenFlareType)

	if not __wf_atom_7e8ad928(__wf_atom_f582136d2) then
		for i = 1, #__wf_atom_f582136d2 do
			__wf_atom_f582136d2[i]:SetVisibility(p, true)
		end
	end

	local __wf_atom_f582136d3 = object:__wf_atom_f582136d(RedFlareType)

	if not __wf_atom_7e8ad928(__wf_atom_f582136d3) then
		for i = 1, #__wf_atom_f582136d3 do
			__wf_atom_f582136d3[i]:SetVisibility(not p, true)
		end
	end

	local __wf_atom_f582136d4 = object:__wf_atom_f582136d(laserScanType)

	if not __wf_atom_7e8ad928(__wf_atom_f582136d4) then
		for i = 1, #__wf_atom_f582136d4 do
			if p then
				__wf_atom_f582136d4[i]:FirePort("Enable")
			else
				__wf_atom_f582136d4[i]:FirePort("Disable")
			end

			__wf_atom_f582136d4[i]:__wf_atom_4bbf5530(false)
		end
	end

	local __wf_atom_f582136d5 = object:__wf_atom_f582136d(grineerBeamLargeType)

	for i = 1, #__wf_atom_f582136d5 do
		local __wf_atom_f582136d6 = __wf_atom_f582136d5[i]:__wf_atom_f582136d(laserSound)

		if __wf_atom_7e8ad928(__wf_atom_f582136d6) then
			continue
		end

		for j = 1, #__wf_atom_f582136d6 do
			if p then
				__wf_atom_f582136d6[j]:FirePort("Enable")
			else
				__wf_atom_f582136d6[j]:FirePort("Disable")
			end
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_f582136d5) then
		for i = 1, #__wf_atom_f582136d5 do
			if p then
				__wf_atom_f582136d5[i]:FirePort("Enable")
			else
				__wf_atom_f582136d5[i]:FirePort("Disable")
			end

			__wf_atom_f582136d5[i]:__wf_atom_4bbf5530(false)
		end
	end
end

local function fn6(p)
	local all = gRegion:FindAll(__wf_atom_e1d1671b)
	local v5 = 0

	for _, v6 in ipairs(all) do
		local __wf_atom_e800787c = v6:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) then
			continue
		end

		local __wf_atom_db682341 = __wf_atom_e800787c:__wf_atom_db682341()

		if
			not (__wf_atom_7e8ad928(p) or __wf_atom_db682341 == p)
			or v6:__wf_atom_6c640264()
			or v6:__wf_atom_b1dbf338():c_str() == "FlyIn"
		then
			continue
		end

		local layerIndex = __wf_atom_e800787c:GetLayerIndex()

		if v5 < layerIndex then
			v5 = layerIndex
		end
	end

	return v5
end

local function fn7(object, object2)
	Sleep(1)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local layerIndex = object:__wf_atom_e800787c():GetLayerIndex()
	local v5 = fn6()

	if object2 == playerAvatar then
		for i = 1, v5 do
			if __wf_atom_7e8ad928(_T.SecurityOff) then
				continue
			end

			for j = #_T.SecurityOff[i], 1, -1 do
				if __wf_atom_7e8ad928(_T.SecurityOff[i][j]) or not (_T.SecurityOff[i][j]:__wf_atom_0e4bbbbd() > 0) then
					continue
				end

				_T.SecurityOff[i][j]:__wf_atom_9ee30c77(0.5)
			end
		end
	elseif __wf_atom_7d789620:__wf_atom_49db0c0b() == true then
		for i = #_T.SecurityOff[layerIndex], 1, -1 do
			if _T.SecurityOff[layerIndex][i]:__wf_atom_0e4bbbbd() > 0 then
				return
			end
		end

		__wf_atom_7d789620:__wf_atom_eb6c68dc(v, layerIndex, 1, -1, 1, 2)

		for i = 1, v5 do
			local __wf_atom_a499cdc0 = __wf_atom_7d789620:__wf_atom_a499cdc0(i, v)

			if
				__wf_atom_a499cdc0 > 0
				and not (__wf_atom_7e8ad928(_T.SecurityOn) or __wf_atom_7e8ad928(_T.SecurityOn[i]))
			then
				for j = #_T.SecurityOn[i], 1, -1 do
					if not __wf_atom_7e8ad928(_T.SecurityOn[i][j]) then
						_T.SecurityOn[i][j]:FirePort("TriggerPort")
					end
				end
			end

			if
				not (__wf_atom_a499cdc0 > 0)
				or (__wf_atom_7e8ad928(_T.FortressCameras) or __wf_atom_7e8ad928(_T.FortressCameras[i]))
			then
				continue
			end

			for j = #_T.FortressCameras[i], 1, -1 do
				if __wf_atom_7e8ad928(_T.FortressCameras[i][j]) then
					continue
				end

				local __wf_atom_08228110 = _T.FortressCameras[i][j]:__wf_atom_08228110()

				if __wf_atom_7e8ad928(__wf_atom_08228110) then
					continue
				end

				local __wf_atom_30e3d82b = __wf_atom_08228110:__wf_atom_30e3d82b()

				if __wf_atom_08228110:__wf_atom_e800787c():GetLayerIndex() ~= i then
					continue
				end

				__wf_atom_30e3d82b:SetPaused(true, Symbol("SleepState"))
				fn5(__wf_atom_08228110, false)
			end
		end

		__wf_atom_7d789620:__wf_atom_4198d250(v, layerIndex)
	end
end

function PanicButton(object, p, p2)
	if not gRegion:IsMaster() then
		return
	end

	if not __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()) or p == nil or p == 1 then
		module.PanicButtonActivated(object, p2, alarmBank)
	end
end

function PanicButtonFortress(object, p, p2)
	if not gRegion:IsMaster() then
		return
	end

	local v5 = not __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()) and 1 or p

	if (v5 == nil and 1 or v5) == 1 then
		module.PanicButtonActivated(object, p2, alarmBank)

		if not __wf_atom_7e8ad928(gRegion:__wf_atom_2226b35c(Symbol("SecurityOn"))) then
			fn7(p2, object)
		end
	end
end

function OnAvatarEnterBreach(object)
	local cameraControl = object:CameraControl()

	if not __wf_atom_7e8ad928(cameraControl) then
		cameraControl:__wf_atom_dc7b15db(HBColorCorrection, 3, -1, 0)
	end
end

function OnAvatarLeaveBreach(object)
	local cameraControl = object:CameraControl()

	if not __wf_atom_7e8ad928(cameraControl) then
		cameraControl:__wf_atom_928a45c5(HBColorCorrection)
	end
end

function HullBreach(object)
	print("HullBreach()")
	_T.canClearHullBreach = false
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	__wf_atom_7d789620:__wf_atom_189228e1(object)
	local v5 = fn4(object)
	local v6 = nil
	__wf_atom_7d789620:__wf_atom_4f39f8a7(true)
	fn2(object, v5)
	wait = false
	module.SetPanicLevel(module.LOCKDOWN)
	local v7 = false

	if not __wf_atom_7e8ad928(v5) then
		for i = 1, #v5 do
			v7 = v5[i]:__wf_atom_8efce136()

			if not v7 then
				continue
			end

			v6 = v5[i]
			break
		end
	end

	if v7 then
		if not __wf_atom_7e8ad928(shakeScript) then
			shakeScript:FirePort("Execute")
		end

		if not __wf_atom_7e8ad928(v6) then
			v6:PlaySound(enterBreachSound, false, 0, false)
		end
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("Fire"), object:GetPosition(), 0, 50)
	local v8 = {}

	for _, v9 in ipairs(__wf_atom_439c0d29) do
		v9:FirePort("Destroy")
	end

	while __wf_atom_7d789620:__wf_atom_7be145fc() == true do
		if gRegion:IsMaster() then
			v5 = __wf_atom_7d789620:__wf_atom_545ac746()

			for i = 1, #v8 do
				local v9 = false

				for j = 1, #v5 do
					if v5[j] ~= v8[i] then
						continue
					end

					v9 = true
					break
				end

				if not (v9 or __wf_atom_7e8ad928(v8[i])) then
					v8[i]:__wf_atom_6a7da8c8(false)
				end
			end

			v8 = v5
		end

		if not __wf_atom_7e8ad928(v5) and gRegion:IsMaster() then
			for i = 1, #v5 do
				if __wf_atom_7e8ad928(v5[i]) then
					continue
				end

				local v9 = v5[i]
				v9:__wf_atom_6a7da8c8(true)
				v9:__wf_atom_30d17f39(1, 15, 0, 500, object, object)
			end
		end

		if Random(0, 1) > 0.8 then
			fn3(object)
		end

		Sleep(0.25)
	end

	print("Hull breach done")

	if not __wf_atom_7e8ad928(v6) then
		v6:PlaySound(leaveBreachSound, false, 0, false)
	end

	fn()
	__wf_atom_7d789620:__wf_atom_0530ae3c(object)
	__wf_atom_7d789620:__wf_atom_4f39f8a7(false)

	if not __wf_atom_7e8ad928(v8) then
		for i = 1, #v8 do
			if not __wf_atom_7e8ad928(v5[i]) then
				v5[i]:__wf_atom_6a7da8c8(false)
			end
		end
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("HullBreach"))

	for _, v9 in ipairs(__wf_atom_2226b35c) do
		if not __wf_atom_7e8ad928(v9) then
			v9:FirePort("Disable")
		end
	end

	module.SetPanicLevel(module.UNALERT)
end

function GenericHackPanel(object, p, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v5 = not __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()) and 1 or p

	if (v5 == nil and 1 or v5) == 1 then
		if not __wf_atom_7e8ad928(buttonPortForwarder) then
			buttonPortForwarder:FirePort("TriggerPort")
		end

		if disableOnUse then
			if not __wf_atom_7e8ad928(buttonLight) then
				buttonLight:TurnOff()
			end

			if not __wf_atom_7e8ad928(buttonScreen) then
				buttonScreen:__wf_atom_a887a262(materialSlot, buttonScreenOff)
			end

			object2:FirePort("Disable")
		end

		if not __wf_atom_7e8ad928(hackSuccessSound) then
			object:PlaySound(hackSuccessSound, false)
		end
	elseif not __wf_atom_7e8ad928(failedPortFowarder) and gGameRules:__wf_atom_72fc675e().sortieId == "" then
		failedPortFowarder:FirePort("TriggerPort")
	end
end

function GenericHackPanelMultiDecos(object, p, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v5 = not __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()) and 1 or p

	if (v5 == nil and 1 or v5) == 1 then
		if not __wf_atom_7e8ad928(buttonPortForwarder) then
			buttonPortForwarder:FirePort("TriggerPort")
		end

		if disableOnUse then
			if not __wf_atom_7e8ad928(buttonLight) then
				buttonLight:TurnOff()
			end

			for i = 1, #decorationsToMaterialSwap do
				decorationsToMaterialSwap[i]:__wf_atom_a887a262(materialSlots[i], materialsToSwap[i])
			end

			object2:FirePort("Disable")
		end
	elseif not __wf_atom_7e8ad928(failedPortFowarder) and gGameRules:__wf_atom_72fc675e().sortieId == "" then
		failedPortFowarder:FirePort("TriggerPort")
	end
end

function DoorControl(object, p, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v5 = not __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()) and 1 or p
	local v6 = v5 == nil and 1 or v5
	local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(screenType)

	if v6 == 1 then
		__wf_atom_bb3e7833:__wf_atom_a887a262(materialSlot, buttonScreenOff)
		object2:FirePort("Disable")
	end

	if v6 == 1 and not __wf_atom_7e8ad928(successForwarder) then
		successForwarder:FirePort("TriggerPort")
	end
end

function CinHullBreach(object)
	Sleep(25)
	print("HullBreach()")
	_T.canClearHullBreach = false
	local position = object:GetPosition()
	local all = gRegion:FindAll(avatarType, position, 0, 100)
	local v5 = nil
	local v6 = false

	if not __wf_atom_7e8ad928(all) then
		for i = 1, #all do
			v6 = all[i]:__wf_atom_8efce136()

			if not v6 then
				continue
			end

			v5 = all[i]
			break
		end
	end

	if v6 then
		if not __wf_atom_7e8ad928(shakeScript) then
			shakeScript:FirePort("Execute")
		end

		if not __wf_atom_7e8ad928(v5) then
			v5:PlaySound(enterBreachSound, false, 0, false)
		end
	end

	v5:__wf_atom_6a7da8c8(true)
	print("Hull breach done")
end

function Purge()
	module2.TaggedFirePorts(firePortTag, (tostring(firePortName)))
	local all = gRegion:FindAll(__wf_atom_1e218e76)

	for _, v5 in ipairs(all) do
		v5:__wf_atom_c1e9afc3(2, 0, 5)
		v5:SetMaterialParam(v2, PurgeFlashTint.red / 255, PurgeFlashTint.green / 255, PurgeFlashTint.blue / 255, 1)
		v5:SetMaterialParam(v3, PurgeFlashTint.red / 255, PurgeFlashTint.green / 255, PurgeFlashTint.blue / 255, 1)
		v5:SetMaterialParam(v4, PurgeFlashTint.red / 255, PurgeFlashTint.green / 255, PurgeFlashTint.blue / 255, 1)
	end

	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	postProcess.lightMapTint = PurgeTint
	local lightMapBoost = 1

	while true do
		if lightMapBoost <= 8 then
			lightMapBoost += 0.1
			postProcess.lightMapBoost = lightMapBoost
			Sleep(0.01)
		else
			while lightMapBoost >= 0.1 do
				lightMapBoost -= 0.1
				postProcess.lightMapBoost = lightMapBoost
				Sleep(0.01)
			end

			Sleep(0)
		end
	end
end

function GetPanicButtonActionText(_, _)
	if gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_49db0c0b() then
		return "/Lotus/Language/Actions/HackSystem"
	end

	return "/Lotus/Language/Actions/HackAlarms"
end

function PanicButtonMasterScript()
	while __wf_atom_7e8ad928(gGameRules) do
		assert(not gRegion:IsMaster())
		Sleep(0)
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("PanicButton"))

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) and #__wf_atom_2226b35c > 0 then
		local v5 = {
			{
				tag = Symbol("CorpusPanicDeco"),
				lockdownMats = onMaterialsCorpus,
				alertMats = alertMaterialsCorpus,
				offMats = offMaterialsCorpus
			},
			{
				tag = Symbol("GrineerPanicDeco"),
				lockdownMats = onMaterialsGrineer,
				alertMats = alertMaterialsGrineer,
				offMats = offMaterialsGrineer
			}
		}
		local currentPanicStatus = module.GetCurrentPanicStatus()

		for _, v6 in ipairs(__wf_atom_2226b35c) do
			local __wf_atom_bb3e7833 = v6:__wf_atom_bb3e7833(__wf_atom_8d0b7f88)

			if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				continue
			end

			local v7 = nil

			for _, v8 in ipairs(v5) do
				if __wf_atom_bb3e7833:__wf_atom_db682341() ~= v8.tag then
					continue
				end

				v7 = v8
				break
			end

			if __wf_atom_7e8ad928(v7) then
				continue
			end

			local offMats = v7.offMats

			if currentPanicStatus == module.LOCKDOWN then
				offMats = v7.lockdownMats
			elseif currentPanicStatus == module.ALERT then
				offMats = v7.alertMats
			end

			for i = 1, #offMats do
				if not __wf_atom_7e8ad928(offMats[i]) then
					__wf_atom_bb3e7833:__wf_atom_a887a262(i - 1, offMats[i])
				end
			end
		end
	end
end