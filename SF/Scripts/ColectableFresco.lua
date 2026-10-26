local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("Lotus.Scripts.Libs.AudioLib")
local flag = false
local v = nil
local v2 = nil
local heading = 0
local v3 = 0
local position = nil
local v4 = nil
local v5 = 0
local position2 = nil
local total = 0
local flag2 = false

local function fn(p)
	total += p

	if v5 == 1 then
		flag2 = true
		return
	end

	v5 = __wf_atom_421b01aa(v5 + p * 0.05, 0, 1)
	local v6 = __wf_atom_24a82b69(v5)

	if not (__wf_atom_7e8ad928(cameraInitWp) or __wf_atom_7e8ad928(cameraEndtWp)) then
		local v7 = __wf_atom_f55d6358(cameraInitWp:GetPosition(), cameraEndtWp:GetPosition(), v6)
		camSpot:Teleport(v7, __wf_atom_fa8d0177(v7, position2))
	end
end

local function fn2()
	local cameraControl = gRegion:__wf_atom_c4f78a8f():CameraControl()

	if __wf_atom_7e8ad928(camSpot) then
		camSpot = gRegion:__wf_atom_f738b4af(Symbol("frescoCam"), v:GetPosition(), 0, 5)
	end

	if not (__wf_atom_7e8ad928(cameraControl) or __wf_atom_7e8ad928(camSpot)) then
		position = camSpot:GetPosition()
		v4 = camSpot:__wf_atom_dc309f8a()
		heading = v4.heading
		v3 = heading
		cameraControl:SetCameraSpot(camSpot, 1.5)
		cameraControl:__wf_atom_fd14c463(transitionTime)
		camSpot:__wf_atom_802e6d6a(99999)
		camSpot:Activate()
	end
end

local function fn3()
	local cameraControl = gRegion:__wf_atom_c4f78a8f():CameraControl()

	if __wf_atom_7e8ad928(camSpot) then
		camSpot = gRegion:__wf_atom_f738b4af(Symbol("frescoCam"), v:GetPosition(), 0, 5)
	end

	if not __wf_atom_7e8ad928(camSpot) then
		local __wf_atom_2f2bada0 = camSpot:__wf_atom_2f2bada0()

		if not __wf_atom_7e8ad928(v) then
			v:__wf_atom_51075230(__wf_atom_2f2bada0)
		end
	end

	if not cameraControl:__wf_atom_c8c5ba0a() then
		cameraControl:__wf_atom_fd14c463(transitionTime)
	end

	cameraControl:SetCameraSpot(nil, transitionTime)

	if __wf_atom_7e8ad928(v) then
		return
	end

	module4.PlaySound(muralCameraSpotEndSound)
end

function Initialize(object, p)
	v = p
	v2 = object

	if not __wf_atom_7e8ad928(fresco) then
		position2 = fresco:GetPosition()
		camSpot:Teleport(camSpot:GetPosition(), __wf_atom_fa8d0177(camSpot:GetPosition(), position2))
	end

	v2:Disable()
	_T.PreviousInt = 0
	local v6 = {}
	table.insert(v6, {
		Label = "/Lotus/Language/Menu/Global_Back",
		CallBack = Close,
		CallOut = "MENU_CANCEL"
	})

	if not (__wf_atom_7e8ad928(_T.SetButtons) or __wf_atom_7e8ad928(_T.BackgroundMovie)) then
		_T.SetButtons(_T.BackgroundMovie, v6, getfenv(1))
	end

	fn2()

	if instigatorOnly then
		if not (__wf_atom_7e8ad928(frescoTransmissionSet) or __wf_atom_7e8ad928(transmissionSymbol)) then
			module.PlayLocalTransmission(frescoTransmissionSet, transmissionSymbol, p)
		end
	elseif not (__wf_atom_7e8ad928(frescoTransmissionSet) or __wf_atom_7e8ad928(transmissionSymbol)) then
		module.PlayGlobalTransmission(frescoTransmissionSet, transmissionSymbol)
	end

	module2.RegisterHideHud(true)

	if gRegion:IsMaster() and not (__wf_atom_7e8ad928(completedDecal) or __wf_atom_7e8ad928(fresco)) then
		gRegion:CreateEntity(
			transformFX,
			fresco:GetPosition() + Vector(0, -2, 0),
			fresco:__wf_atom_dc309f8a(),
			nil,
			nil,
			1
		)
		Sleep(1)

		if not __wf_atom_7e8ad928((gRegion:CreateEntity(
			completedDecal,
			fresco:GetPosition(),
			fresco:__wf_atom_dc309f8a(),
			nil,
			nil,
			1
		))) then
			fresco:Destroy()
			local nearestTagged = gRegion:FindNearestTagged(Symbol("MuralInteractFX"), object:GetPosition())

			if not __wf_atom_7e8ad928(nearestTagged) then
				nearestTagged:SetVisibility(false, true)
			end
		end
	end

	while flag == false do
		if __wf_atom_7e8ad928(v) then
			break
		end

		if flag2 then
			Close()
		end

		fn(__wf_atom_fa1258d0())
		Sleep(0)
	end
end

function Close()
	if flag then
		return
	end

	if not (__wf_atom_7e8ad928(frescoLoreFragementRes) or __wf_atom_7e8ad928(loreMemeorySymbol)) then
		if instigatorOnly then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			module3.GiveLoreFragmentMemory(__wf_atom_c4f78a8f, frescoLoreFragementRes, loreMemeorySymbol)
		else
			local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

			for _, v6 in ipairs(__wf_atom_a8553251) do
				if v6:__wf_atom_a5304c35(v2:GetPosition()) < 30 then
					module3.GiveLoreFragmentMemory(v6, frescoLoreFragementRes, loreMemeorySymbol)
				end
			end
		end
	end

	module2.RegisterHideHud(false)
	flag = true
	_T.SetButtons(_T.BackgroundMovie, nil)
	Sleep(0)
	fn3()
end