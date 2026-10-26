local v = __wf_atom_10cd16b2(0, 0.3)
local v2 = __wf_atom_10cd16b2(0, 0.3)
local v3 = __wf_atom_10cd16b2(0, 0.3)
local module = require("Lotus.Interface.BindingsUtil")
local module2 = require("SF.Scripts.Libs.RaycastLib")

function FXLoop(object)
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	postProcess.saturationBias = 0
	postProcess.radialBlurStrength = 0.35
	local cameraControl = object:CameraControl()
	local v4 = 165 / cameraControl:__wf_atom_5368c677()
	local v5 = Range(5.4, 10.8)
	local v6 = v5.maxValue - v5.minValue

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(cameraControl)) do
		local v7 = v5:__wf_atom_421b01aa(object:__wf_atom_ee4f0cba()) - v5.minValue
		cameraControl:__wf_atom_25382a0d(__wf_atom_421b01aa(1 + 0.75 * v7 / v6, 1, v4), false)
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(postProcess) then
		postProcess.radialBlurStrength = 0
	end
end

local function fn()
	local locForAction, _ = module.GetLocForAction("CROUCH", nil, false, true)
	local crouch = Localize(locForAction, {})
	local v4 = Localize("/SF/Language/Tutorial/SparrowLaunch", { CROUCH = crouch })
	_T.ReviveLaunchHint = true
	_T.ShowImpactMessage(v4, -1)
end

function SparrowUi(object)
	local v4 = nil

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_535d5cbb() and not object:__wf_atom_03270b83() do
		local isPlayingWithController = Engine.IsPlayingWithController()

		if v4 ~= isPlayingWithController then
			fn()
			v4 = isPlayingWithController
		end

		Sleep(0)
	end

	_T.ReviveLaunchHint = nil
	_T.HideImpactMessage()

	if not __wf_atom_7e8ad928(sparrowLaunchSound) then
		object:PlaySound(sparrowLaunchSound, false)
	end
end

function Setup(object)
	while not object:__wf_atom_535d5cbb() do
		Sleep(0)
	end

	if object:__wf_atom_8efce136() then
		object:__wf_atom_8a035cd5(Symbol("FXLoop"), false)
		local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

		if __wf_atom_7e8ad928(__wf_atom_b3845a20) then
			return
		end

		__wf_atom_b3845a20:__wf_atom_106c8d5f(object, object:GetPosition(), ambienceContainer, 0)

		if __wf_atom_72884638("Ghost.Sparrow") then
			object:__wf_atom_8a035cd5(Symbol("SparrowUi"), false)
		end

		local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			local __wf_atom_43cc9de1 = __wf_atom_e55d02aa:__wf_atom_43cc9de1(Symbol("AnimController"))

			if not __wf_atom_7e8ad928(__wf_atom_43cc9de1) then
				object:__wf_atom_4f204bbf(__wf_atom_43cc9de1)
			end

			local __wf_atom_43cc9de1_2 = __wf_atom_e55d02aa:__wf_atom_43cc9de1(Symbol("MotionController"))

			if not __wf_atom_7e8ad928(__wf_atom_43cc9de1_2) then
				object:__wf_atom_b70f5867(__wf_atom_43cc9de1_2)
			end
		end

		ShowGhostPath(object)
	end
end

function ShowGhostPath(object)
	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(object:__wf_atom_a96eb2aa())
		or _T.PlayerShrinePosition == nil
		or _T.PlayerShrinePosition[object:__wf_atom_a96eb2aa():__wf_atom_ef151cfd()] == nil
	then
		return
	end

	DrawPath(_T.PlayerShrinePosition[object:__wf_atom_a96eb2aa():__wf_atom_ef151cfd()], object)
end

function DrawPath(p, object)
	local v4 = GeneratePath(p, object)

	if v4 == nil then
		return
	end

	if __wf_atom_7e8ad928(_T.ReviveSplineEntity) then
		_T.ReviveSplineEntity = gRegion:CreateEntity(splineType, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

		if __wf_atom_7e8ad928(_T.ReviveSplineEntity) then
			print("DrawPath failed to create ReviveSplineEntity")
			return
		end
	end

	_T.ReviveSplineEntity:Teleport(object:GetPosition(), __wf_atom_80368bb1)
	_T.ReviveSplineEntity:__wf_atom_ff43aa5a(v4, true)
	local position = _T.ReviveSplineEntity:GetPosition()
	Vector(0, 0, 0)

	if not __wf_atom_7e8ad928(_T.ReviveSplineDeco) then
		_T.ReviveSplineDeco:Destroy()
	end

	_T.ReviveSplineDeco = gRegion:CreateEntity(splineDecoType, position, __wf_atom_80368bb1)

	if __wf_atom_7e8ad928(_T.ReviveSplineDeco) then
		print("DrawPath failed to create ReviveSplineDeco")
		_T.ReviveSplineEntity:Destroy()
		_T.ReviveSplineEntity = nil
	else
		local v5 = _T.ReviveSplineEntity:__wf_atom_616f02d9() / splineDecoSpeed
		v:__wf_atom_4453e49c(position.x)
		v2:__wf_atom_4453e49c(position.y)
		v3:__wf_atom_4453e49c(position.z)
		local v6 = 0

		while v6 < v5 and not (__wf_atom_7e8ad928(_T.ReviveSplineDeco) or __wf_atom_7e8ad928(_T.ReviveSplineEntity)) do
			v6 = __wf_atom_421b01aa(v6 + __wf_atom_084b3e93(), 0, v5)
			local v7 = position + _T.ReviveSplineEntity:__wf_atom_bfb052a2(v6 / v5)
			local groundPos = module2.GetGroundPos(
				v7 + Vector(0, 1.5, 0),
				__wf_atom_28d5d4aa,
				Vector(0, -3, 0),
				nil,
				__wf_atom_28d5d4aa
			)

			if groundPos == __wf_atom_28d5d4aa then
				local groundPos2 = module2.GetGroundPos(
					v7 + Vector(0, 4, 0),
					__wf_atom_28d5d4aa,
					Vector(0, -6, 0),
					nil,
					__wf_atom_28d5d4aa
				)

				if groundPos2 ~= __wf_atom_28d5d4aa then
					v7 = groundPos2 + Vector(0, 1.2, 0)
				end
			else
				v7 = groundPos + Vector(0, 1.2, 0)
			end

			local v8 = __wf_atom_084b3e93()
			local v9 = Vector(
				v:__wf_atom_2490589b(v7.x, v8),
				v2:__wf_atom_2490589b(v7.y, v8),
				v3:__wf_atom_2490589b(v7.z, v8)
			)
			_T.ReviveSplineDeco:SetPosition(v9)
			Sleep(0)
		end

		if not (__wf_atom_7e8ad928(_T.ReviveSplineDeco) or __wf_atom_7e8ad928(_T.ReviveSplineEntity)) then
			_T.ReviveSplineDeco:SetPosition(p)
		end
	end
end

local function fn2(position, p, object)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local v4 = Vector()
	local v5 = Vector()
	__wf_atom_2202ffb6:__wf_atom_3cc125d0(position, v4)
	__wf_atom_2202ffb6:__wf_atom_3cc125d0(p, v5)

	if v4 ~= __wf_atom_28d5d4aa then
		local _ = v5 == __wf_atom_28d5d4aa
	end

	__wf_atom_2202ffb6:__wf_atom_3c37bceb(position, 10)
	__wf_atom_2202ffb6:__wf_atom_3c37bceb(p, 10)
	local v6 = object:__wf_atom_753cbaf4(position, p) or {}
	table.insert(v6, 1, position)
	table.insert(v6, p)
	local v7 = p + Vector(0, 20, 0)

	for i = #v6, 2, -1 do
		if v6[i] == v6[i - 1] or Distance(v6[i], v6[i - 1]) < 2 then
			table.remove(v6, i)
		elseif Distance(v6[i], v7) < 5 and Distance(v6[i], v6[i - 1]) < 5 then
			table.remove(v6, i)
		else
			v7 = v6[i]
		end
	end

	return v6
end

function GeneratePath(p, object)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) then
		return
	end

	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local position = object:GetPosition()

	if __wf_atom_7e8ad928(__wf_atom_2202ffb6) or not __wf_atom_2202ffb6:__wf_atom_eb1b4526() then
		print("Not nav ready")
		return
	end

	local result = fn2(position, p, object)

	for i = 2, #result - 1 do
		result[i] += Vector(0, math.sin(i * 3.141592653589793 * 2 * 3) * 0.5 + 1, 0)
	end

	return result
end