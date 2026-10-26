local module = require("EE.Interface.Utilities")
local v = nil
local v2 = nil
local v3 = __wf_atom_10cd16b2(0, 1)
local v4 = __wf_atom_10cd16b2(0, 1)
local v5 = __wf_atom_10cd16b2(0, 1)
local v6 = 5
local v7 = nil
local v8 = false

function Shake(object)
	local v9 = 1
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	v = object:__wf_atom_bb3e7833(cannonAttachment)
	local __wf_atom_dc309f8a2 = v:__wf_atom_dc309f8a()

	while not __wf_atom_7e8ad928(object) and v9 > 0 do
		local v10 = v9 * 0.1 + Noise(Time() * 0.25) * v9 * v9
		local v11 = Rotation(0, v10 * -15, 0)
		local v12 = __wf_atom_d919c2d7(v11, Rotation(-__wf_atom_dc309f8a2.heading, 0, 0))
		v12.heading = 0
		object:__wf_atom_9b788a35((__wf_atom_d919c2d7(__wf_atom_dc309f8a, v12)))
		v9 -= __wf_atom_084b3e93() * 0.5
		Sleep(0)
	end

	object:__wf_atom_9b788a35(__wf_atom_dc309f8a)
end

local function fn(object)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local shuffleTable = module.ShuffleTable(__wf_atom_ef7900cf)

	for i = 1, #shuffleTable do
		local v9 = shuffleTable[i]

		if not (object:__wf_atom_8a6b8fc3(v9) < range and v9:__wf_atom_0a6aa891(object)) then
			continue
		end

		v2 = v9
		break
	end
end

local function fn2(object)
	if __wf_atom_7e8ad928(v2) or v2:IsKilled() or v2:__wf_atom_7b82e9e1(7) then
		v6 = 5
		return false
	end

	local position = object:GetPosition()
	local position2 = v2:GetPosition()

	if Distance(position, position2) > range then
		v6 = 5
		return false
	end

	local raycastEntity = gRegion:RaycastEntity(position + Vector(0, 2, 0), position2 + Vector(0, 1, 0), object, false)

	if __wf_atom_7e8ad928(raycastEntity) or raycastEntity == v2 then
		return true
	end

	v6 = 5
	return false
end

local function fn3(object)
	local v9 = math.max(0, 1 - __wf_atom_421b01aa(v6 / 5, 0, 1) - 0.5) * 2

	if v9 > 0.1 and __wf_atom_7e8ad928(v:__wf_atom_bb3e7833(chargeFX)) and object:__wf_atom_c6f1f83d() > 0 then
		v:Attach(chargeFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		Sleep(0)
	end

	local v10 = math.pow(v9, 2) * 10
	v:SetMaterialParam(Symbol("EmissiveMapAtten"), v10)

	if __wf_atom_7e8ad928(v2) or v2:IsKilled() or v2:__wf_atom_7b82e9e1(7) then
		fn(object)
		v6 = 5

		if not __wf_atom_7e8ad928(v7) then
			v7:Stop(false)
			v7 = nil
		end
	elseif not __wf_atom_7e8ad928(v) and fn2(object) then
		local v11 = __wf_atom_084b3e93()
		local v12 = v:GetPosition() + Vector(0, 1.5, 0)
		local position = v2:GetPosition()
		local v13 = __wf_atom_9341614d(position - v12, __wf_atom_0a00e162(object:__wf_atom_dc309f8a())) + v12
		local v14 = __wf_atom_fa8d0177(v12, v13, Vector(0, 1, 0))
		v14.pitch = __wf_atom_421b01aa(v14.pitch, -10, 10)
		v13.x = v3:__wf_atom_2490589b(v13.x, __wf_atom_084b3e93())
		v13.y = v4:__wf_atom_2490589b(v13.y, __wf_atom_084b3e93())
		v13.z = v5:__wf_atom_2490589b(v13.z, __wf_atom_084b3e93())
		local v15 = __wf_atom_fa8d0177(v12, v13, Vector(0, 1, 0))
		v15.pitch = __wf_atom_421b01aa(v15.pitch, -10, 10)
		v:__wf_atom_e310f01f(__wf_atom_28d5d4aa, v15)
		local v16 = __wf_atom_d08b2f29(__wf_atom_e97f3142(v14), __wf_atom_e97f3142(v15))

		if v16 > 1 then
			if __wf_atom_7e8ad928(v7) then
				v7 = object:PlaySound(pivotSound, false)
			end
		elseif not __wf_atom_7e8ad928(v7) then
			v7:Stop(false)
			v7 = nil
		end

		if v16 < 9 then
			v6 -= v11

			if v6 >= 2.5 and v6 - v11 < 2.5 then
				object:PlaySound(warnSound, false)
			end

			v:__wf_atom_bb3e7833(chargeFX)

			if v6 <= 0.5 and __wf_atom_7e8ad928(v:__wf_atom_bb3e7833(chargeFlareFX)) then
				v:Attach(chargeFlareFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end

			if v6 <= 0 then
				local __wf_atom_bb3e7833 = v:__wf_atom_bb3e7833(chargeFX)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
					v:__wf_atom_bb3e7833(steamRingFX):FirePort("Burst")
				end

				object:PlaySound(fireSound, false)
				v6 = 5
				local __wf_atom_dc309f8a = v:__wf_atom_dc309f8a()
				local v17

				if v8 then
					v17 = v12 + __wf_atom_9341614d(Vector(-0.9, 1, 1.5), __wf_atom_dc309f8a)
				else
					v17 = v12 + __wf_atom_9341614d(Vector(0.9, 1, 1.5), __wf_atom_dc309f8a)
				end

				local v18 = Distance(v12, v13)
				local v19 = __wf_atom_421b01aa(v18 / 100, 0, 1)
				__wf_atom_dc309f8a.pitch += __wf_atom_104bfe98(0, -30, v19 * v19)
				local entity = gRegion:CreateEntity(projectileType, v17, __wf_atom_dc309f8a, object)

				if not __wf_atom_7e8ad928(entity) then
					entity:__wf_atom_8fcdea81(object)
				end

				v8 = not v8
				object:__wf_atom_8a035cd5(Symbol("Shake"), false)
			end
		end
	end
end

function SeigeEngine(object)
	Sleep(0)
	v = object:__wf_atom_bb3e7833(cannonAttachment)
	Engine.__wf_atom_878bebe4(object)

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c6f1f83d() > 0 do
		fn3(object)
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_c6f1f83d() <= 0 then
		v:SetMaterialParam(Symbol("EmissiveMapAtten"), 0)
		local __wf_atom_bb3e7833 = v:__wf_atom_bb3e7833(chargeFX)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function Charge(object)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()
	local __wf_atom_7eff92f0 = object:__wf_atom_21ed1a39():__wf_atom_7eff92f0()
	__wf_atom_f7e7be53:PlaySound(warnSound, false)

	if
		__wf_atom_7e8ad928(__wf_atom_f7e7be53:__wf_atom_bb3e7833(chargeFX))
		and __wf_atom_f7e7be53:__wf_atom_c6f1f83d() > 0
	then
		__wf_atom_f7e7be53:Attach(chargeFX, Symbol("GAME_C1_MIDDLE"), jetSteam1Position, jetSteam1Rotation)
		__wf_atom_f7e7be53:Attach(chargeFX, Symbol("GAME_C1_MIDDLE"), jetSteam2Position, jetSteam2Rotation)
	end

	local __wf_atom_f582136d = __wf_atom_f7e7be53:__wf_atom_f582136d(chargeFX)

	for i = 1, #__wf_atom_f582136d do
		__wf_atom_f582136d[i]:__wf_atom_dd9b7ab8(__wf_atom_7eff92f0)
	end

	local __wf_atom_bb3e7833 = __wf_atom_f7e7be53:__wf_atom_bb3e7833(lampsAttachment)
	local v9 = false

	while __wf_atom_7eff92f0 > 0 do
		if __wf_atom_7eff92f0 <= flareTime and not v9 then
			if __wf_atom_7e8ad928(__wf_atom_f7e7be53:__wf_atom_bb3e7833(chargeFlareFX)) then
				__wf_atom_f7e7be53:Attach(
					chargeFlareFX,
					Symbol("GAME_C1_MIDDLE"),
					chargeFlarePosition,
					chargeFlareRotation
				)
			end

			v9 = true
		end

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			local v10 = math.pow(math.max(0, 1 - __wf_atom_421b01aa(__wf_atom_7eff92f0 / 5, 0, 1) - 0.5) * 2, 2) * 10
			__wf_atom_bb3e7833:SetMaterialParam(Symbol("EmissiveMapAtten"), v10)
		end

		__wf_atom_7eff92f0 -= __wf_atom_084b3e93()
		Sleep(0)
	end
end

function Fire(object)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()
	__wf_atom_f7e7be53:PlaySound(fireSound, false)

	if not __wf_atom_7e8ad928((__wf_atom_f7e7be53:__wf_atom_bb3e7833(steamRingFX))) then
		__wf_atom_f7e7be53:__wf_atom_bb3e7833(steamRingFX):FirePort("Burst")
	end

	local __wf_atom_bb3e7833 = __wf_atom_f7e7be53:__wf_atom_bb3e7833(chargeFlareFX)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	local __wf_atom_bb3e7833_2 = __wf_atom_f7e7be53:__wf_atom_bb3e7833(lampsAttachment)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
		__wf_atom_bb3e7833_2:SetMaterialParam(Symbol("EmissiveMapAtten"), 0)
	end
end

function OnDeath(object)
	object:__wf_atom_9373d0eb(0, false)
	local __wf_atom_7d88e340 = object:__wf_atom_7d88e340()

	if __wf_atom_7d88e340 ~= Vector(0, 0, 0) then
		object:__wf_atom_6868003b(__wf_atom_7d88e340)
	end

	Sleep(1.65)

	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_83fac646(
		Symbol("GAME_C1_TOP"),
		__wf_atom_80368bb1,
		__wf_atom_28d5d4aa,
		Vector(0.001, 0.001, 0.001)
	)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(WeakResource("/SF/Types/Game/Encounters/Ode/Components/Attachments/AttachExplosivesAction"))

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end
end

function OnDamage(_) end