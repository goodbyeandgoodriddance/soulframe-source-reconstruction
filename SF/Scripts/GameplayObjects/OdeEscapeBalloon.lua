require("Lotus.Scripts.Libs.AudioLib")
local position = nil
local v = 0
local __wf_atom_28d5d4aa2 = __wf_atom_28d5d4aa
local __wf_atom_28d5d4aa3 = __wf_atom_28d5d4aa
local v2 = 0
local v3 = 0
local v4 = 0
local v5 = 0
local v6 = { TOWARDS_CENTER = 0, CIRCLE = 1, FADE = 2 }

local function fn(object, object2, p, p2)
	local damageData = Engine.DamageData()
	damageData.baseAmount = math.floor(p)
	damageData:__wf_atom_7498285f(0, 1)
	damageData:__wf_atom_d6f4d914(p2, true)
	damageData:__wf_atom_34a8a27a(object2)
	damageData:__wf_atom_12cf5317(object:__wf_atom_a06d543c() * 10 * 1)
	object:__wf_atom_649bf33e(damageData)
end

local function fn2(object)
	position = object:GetPosition()
	__wf_atom_28d5d4aa3 = position
	local __wf_atom_95e72410 = object:__wf_atom_95e72410()

	if not __wf_atom_7e8ad928(__wf_atom_95e72410) then
		local __wf_atom_30e3d82b = __wf_atom_95e72410:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_28d5d4aa3 = __wf_atom_30e3d82b:__wf_atom_76724198():GetPosition()
		end
	end

	__wf_atom_28d5d4aa2 = __wf_atom_28d5d4aa3 + (position - __wf_atom_28d5d4aa3) * relativeRadiusSize
	local v7 = __wf_atom_28d5d4aa2 - __wf_atom_28d5d4aa3
	v = math.atan2(v7.z, v7.x)
	v2 = math.sqrt(v7.z * v7.z + v7.x * v7.x)
	v3 = flightTime + fadeOutDuration
	v4 = flightTime / 4
	v5 = flightHeight / 4
end

local function fn3(object, total)
	local TOWARDS_CENTER = v6.TOWARDS_CENTER

	if v3 < total then
		object:FirePort("Hide")
		object:Disable()
	else
		local v7

		if flightTime < total then
			TOWARDS_CENTER = v6.FADE
			v7 = (total - v4) / (flightTime - v4)
		elseif v4 < total then
			TOWARDS_CENTER = v6.CIRCLE
			v7 = (total - v4) / (flightTime - v4)
		else
			v7 = total / v4
		end

		local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa

		if TOWARDS_CENTER == v6.TOWARDS_CENTER then
			__wf_atom_28d5d4aa = __wf_atom_f55d6358(position, __wf_atom_28d5d4aa2, __wf_atom_24a82b69(v7))
			__wf_atom_28d5d4aa.y = __wf_atom_104bfe98(0, v5, __wf_atom_24a82b69(v7)) + position.y
		elseif TOWARDS_CENTER == v6.CIRCLE or TOWARDS_CENTER == v6.FADE then
			local v8 = v7 * v7
			local v9 = v8 + Noise(v8 * noiseFrequency) * noiseGain
			local v10 = v + 7.0685834705770345 * v9
			local v11 = __wf_atom_104bfe98(v2, v2 / 1.2, __wf_atom_24a82b69(v7))
			local v12 = __wf_atom_28d5d4aa3.x + math.cos(v10) * v11
			local v13 = __wf_atom_28d5d4aa3.z + math.sin(v10) * v11
			local v14

			if TOWARDS_CENTER == v6.FADE then
				local v15 = (total - flightTime) / fadeOutDuration
				v14 = position.y + __wf_atom_104bfe98(flightHeight, flightHeight * 2, __wf_atom_24a82b69(v15))
				object:__wf_atom_a763aa1a(__wf_atom_421b01aa(v15, 0, 1))
			else
				v14 = position.y + __wf_atom_104bfe98(v5, flightHeight, __wf_atom_24a82b69(v7))
			end

			__wf_atom_28d5d4aa = Vector(v12, v14, v13)
		end

		object:SetPosition(__wf_atom_28d5d4aa)
	end
end

function EscapeBalloonOnEnabled(object)
	object:FirePort("Show")
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_0f45538d)
	local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(armDecoType)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	__wf_atom_bb3e7833:Enable()
	local flag = true
	local v7 = nil
	local total = 0

	while not __wf_atom_7e8ad928(object) do
		if not object:IsEnabled() then
			break
		end

		if object:__wf_atom_b81a6e66() then
			if flag then
				v7 = object:Attach(inflatableLanternType, EMPTY_SYMBOL, inflatableLanternOffset, __wf_atom_80368bb1)
				flag = false

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
					__wf_atom_bb3e7833_2:__wf_atom_e6ed03c8()
					__wf_atom_bb3e7833_2:FirePort("PlayTriggeredFade")
					__wf_atom_bb3e7833_2:PlaySound(armActivateSound, false)
				end

				fn2(object)
				Sleep(0.5)
			end

			if __wf_atom_7e8ad928(v7) or v7:__wf_atom_c6f1f83d() <= 0 then
				local __wf_atom_95e72410 = object:__wf_atom_95e72410()

				if not __wf_atom_7e8ad928(__wf_atom_95e72410) then
					__wf_atom_95e72410:__wf_atom_e6ed03c8()
					__wf_atom_7e8ad928((__wf_atom_95e72410:__wf_atom_30e3d82b()))
					fn(__wf_atom_95e72410, object, 1000, 20)
					object:FirePort("Destroy")
					Sleep(1)
					break
				end
			end

			fn3(object, total)
			total += __wf_atom_084b3e93()
		end

		Sleep(0)
	end
end

function LatchActionOnActivated(instance, object)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_3d96ddcd)) then
		object:__wf_atom_921c1a5f(latchStartAnim, true, 3, 1, true)
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_921c1a5f(latchLoopAnim, false, 3, 2, true)
		object:AttachToInPlace(__wf_atom_3d96ddcd, EMPTY_SYMBOL)
		object:EnableFootIK(false)
	end

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:SetOwner(object)
		Sleep(0)
		__wf_atom_3d96ddcd:Activate()
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end