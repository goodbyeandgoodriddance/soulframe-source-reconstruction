local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("Lotus.Scripts.Libs.AbilitiesLib")

function PlayTransmission()
	module.PlayGlobalTransmission(transmissionSet, transmissionTag, waitForTransmissionComplete)
end

local function fn() -- 2 equivalent calls inferred from this helper
	return not __wf_atom_7e8ad928(_T.PlayerGrantedFennJotarRune)
end

function PlayFennTransmission()
	if fn() then -- inferred equivalent call
		module.PlayGlobalTransmission(transmissionSet, transmissionTag, waitForTransmissionComplete)
	end
end

function SpawnSparrowFromScriptTrigger()
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v = __wf_atom_7d789620:__wf_atom_0e0a6fee(
		__wf_atom_c4f78a8f:GetPosition() + __wf_atom_9341614d(Vector(2, 0, 2), __wf_atom_c4f78a8f:__wf_atom_4e50d390()),
		3,
		6
	) + Vector(0, 2, 0)
	__wf_atom_7d789620:__wf_atom_54cf3d0a(sparrowAgentType, v, __wf_atom_c4f78a8f:__wf_atom_dc309f8a())
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DemoTotemAction"))
	_T.SparrowDest = __wf_atom_0a6a5887
end

function RemoveSparrowFromScriptTrigger()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SparrowGuide"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Destroy()
	end
end

function JotarIdleAnim(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:__wf_atom_921c1a5f(anim, false, 2, 2, false)
	end
end

function RemoveJotar()
	if gRegion:IsMaster() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FennJotar"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Destroy()
		end
	end
end

function RemoveFireSword()
	if fn() then -- inferred equivalent call
		for _, v in pairs(_T.PlayerGrantedFennJotarRune) do
			if __wf_atom_7e8ad928(v) then
				continue
			end

			local __wf_atom_50a7d83e = v:__wf_atom_50a7d83e()

			if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				continue
			end

			local __wf_atom_d2b2176d = __wf_atom_50a7d83e:__wf_atom_d2b2176d()
			local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(5)
			__wf_atom_d2b2176d:RemoveUpgrade(283, 4, 0)

			if __wf_atom_7e8ad928(__wf_atom_28224c27) then
				continue
			end

			for _, v2 in ipairs(starterRunes) do
				if not v2:__wf_atom_8e024c48("", __wf_atom_28224c27) then
					continue
				end

				local weaponMoteAbility = module3.GetWeaponMoteAbility(__wf_atom_28224c27)
				local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
				__wf_atom_e55d02aa:__wf_atom_0c58cfe4((__wf_atom_e55d02aa:__wf_atom_e21e8409(weaponMoteAbility)))
				__wf_atom_28224c27:RemoveUpgrade(__wf_atom_28224c27:__wf_atom_7a2a76fa(v2), true)

				if __wf_atom_d2b2176d:__wf_atom_ee725e9c(v2, true, false) <= 0 then
					__wf_atom_d2b2176d:__wf_atom_e7ac08e7(v2, "")
				end

				Sleep(0)
				__wf_atom_e55d02aa:FinalizeUpgrades(0)
				break
			end
		end

		_T.PlayerGrantedFennJotarRune = nil
	end
end

function PickUpTotem(object, object2)
	if not gRegion:IsMaster() then
		_T.TotemPickedUp = true
		return
	end

	object2:__wf_atom_d2b2176d():Unequip(0, 0)
	object2:__wf_atom_aeb02c14(inputFilter)
	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local total = 0

	while total <= 0.6 do
		object2:Teleport(
			__wf_atom_f55d6358(object2:GetPosition(), position, (math.min(total / 0.6, 1))),
			(__wf_atom_9d2f097a(object2:__wf_atom_2f2bada0(), __wf_atom_dc309f8a, (math.min(total / 0.6, 1))))
		)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	Sleep(0.5)
	object2:Teleport(object:GetPosition(), object:__wf_atom_dc309f8a())
	object2:__wf_atom_921c1a5f(anim, false, 2, 1, true)
	Sleep(1.3)
	totem:AttachToInPlace(object2, Symbol("GAME_R1_WEAPON1"))
	Sleep(2.3949999999999996)
	gRegion:__wf_atom_dd1e4d10(totem)
	object2:__wf_atom_cf966a74(inputFilter)

	if not __wf_atom_7e8ad928(doneForwarder) then
		doneForwarder:FirePort("TriggerPort")
	end

	_T.TotemPickedUp = true
	object:Disable()
end

function ShowHideEchoCinObjects()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ShowForEcho"))
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("HideForEcho"))

	for _, v in ipairs(__wf_atom_2226b35c) do
		if cinematicStarting then
			if v:IsA(__wf_atom_465d956f) or v:IsA(__wf_atom_ca04301b) then
				v:Enable()
			else
				v:SetVisibility(true)
			end
		elseif v:IsA(__wf_atom_465d956f) or v:IsA(__wf_atom_ca04301b) then
			v:Disable()
		else
			v:SetVisibility(false)
		end
	end

	for _, v in ipairs(__wf_atom_2226b35c2) do
		if cinematicStarting then
			if v:IsA(__wf_atom_465d956f) or v:IsA(__wf_atom_ca04301b) then
				v:Disable()
			else
				v:SetVisibility(false)
			end
		elseif v:IsA(__wf_atom_465d956f) or v:IsA(__wf_atom_ca04301b) then
			v:Enable()
		else
			v:SetVisibility(true)
		end
	end
end

function CinematicStreamOut(object)
	if module2.IsInOverworld() then
		return
	end

	gRegion:__wf_atom_ef7900cf()
	local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(__wf_atom_bc9e92c8, object:GetPosition(), 50)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("JotarDepartCinematic"), object:GetPosition(), 0, 50)

	if __wf_atom_7e8ad928(_T.PlayerGrantedFennJotarRune) then
		return
	end

	local layerIndex = __wf_atom_e2db08ce:__wf_atom_e800787c():GetLayerIndex()
	local v = false

	while not v do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v2 in ipairs(__wf_atom_ef7900cf) do
			if v2:IsKilled() or not module2.IsIntileIndex(v2, layerIndex) then
				continue
			end

			v = true
			break
		end

		Sleep(0.5)
	end

	__wf_atom_e2db08ce:Disable()
	module2.PlayCinematicAndWait(__wf_atom_f738b4af)
	RemoveFireSword()
	__wf_atom_e2db08ce:Enable()
end