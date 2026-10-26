local v = WeakResource("/SF/Types/Gameplay/Puzzles/Attachments/GladesBellPuzzleGroundFissureTrailEffect")
WeakResource("/SF/Types/Gameplay/Puzzles/Attachments/GladesBellShockwaveTrigger")
WeakResource()
local v2 = { IDLE = 0, ACTIVE = 1, COMPLETED = 2, FINISHED = 3 }
local v3 = { PUZZLE = 0, SHOCKWAVE = 1, TETHER = 2 }
local v4 = nil
local v5 = nil
local v6 = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")

local function fn(object)
	local v7 = object:GetPosition() + Vector(0, -2, 0)
	local __wf_atom_946cad0d = object:__wf_atom_bb3e7833(__wf_atom_7b01f9ce):__wf_atom_946cad0d()
	local v8 = nil

	if not __wf_atom_7e8ad928(__wf_atom_946cad0d) then
		if __wf_atom_946cad0d:IsA(__wf_atom_2dc5c74e) then
			v8 = __wf_atom_946cad0d:__wf_atom_95e72410()
		elseif __wf_atom_946cad0d:IsA(__wf_atom_67c46eba) then
			v8 = __wf_atom_946cad0d
		end
	end

	gRegion:CreateEntity(shockwaveEntity, v7, __wf_atom_80368bb1, v8)
end

function StartCooldown(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.cooldown = true
	Sleep(5)
	__wf_atom_e919fb8e.cooldown = nil
end

function BellDeflectUpdate(object)
	Sleep(0)
	module.Deflect(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript) then
		__wf_atom_e919fb8e.runningHitUpdateScript = false
	end
end

function BellOnHit(object, _)
	if not __wf_atom_7e8ad928(bellHitFx) then
		gRegion:CreateEntity(bellHitFx, object:GetPosition() - Vector(0, 2.25, 0), object:__wf_atom_dc309f8a())
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_e919fb8e.cooldown then
		object:__wf_atom_8a035cd5(Symbol("StartCooldown"), false)
		object:Activate()
	end

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript)
		or __wf_atom_e919fb8e.runningHitUpdateScript == false
	then
		__wf_atom_e919fb8e.runningHitUpdateScript = true
		object:__wf_atom_8a035cd5(Symbol("BellDeflectUpdate"), false)
	end

	object:SetHealth(object:__wf_atom_95174740())
end

function Bell(object)
	v5 = object
	local v7 = false
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v)
	v5:GetPosition()
	local __wf_atom_95e72410 = object:__wf_atom_95e72410()
	local v8

	if not __wf_atom_7e8ad928(__wf_atom_95e72410) then
		v6 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		__wf_atom_bb3e7833:SetPosition((v6:__wf_atom_0e0a6fee(__wf_atom_bb3e7833:GetPosition(), 10, 20)))
		__wf_atom_bb3e7833:__wf_atom_77d50e8b(__wf_atom_95e72410)
		__wf_atom_bb3e7833:__wf_atom_c709edee(255)
		v8 = __wf_atom_bb3e7833:__wf_atom_7df70ec2()
	end

	local total = 0

	while not __wf_atom_7e8ad928(object) do
		if not object:IsEnabled() then
			break
		end

		local __wf_atom_b81a6e66 = object:__wf_atom_b81a6e66()

		if __wf_atom_b81a6e66 ~= v7 then
			if __wf_atom_b81a6e66 then
				object:PlaySound(bellRingingSound, false)
				object:__wf_atom_e792b90b(true)

				if bellVariantNumber == v3.PUZZLE then
					if #v8 > 0 then
						__wf_atom_bb3e7833:__wf_atom_7cbad21b((math.floor(__wf_atom_bb3e7833:__wf_atom_f2f158da() / 1)))
						__wf_atom_bb3e7833:__wf_atom_c709edee(0)
						__wf_atom_bb3e7833:__wf_atom_fa550593()
					else
						print("Trail FX. Failed - zero length path")
					end
				end
			else
				object:__wf_atom_e792b90b(false)

				if bellVariantNumber == v3.PUZZLE then
					__wf_atom_bb3e7833:__wf_atom_c4a58228()
				end
			end

			v7 = __wf_atom_b81a6e66
		end

		if bellVariantNumber ~= v3.PUZZLE then
			if bellRingingTime < total then
				object:Deactivate()

				if not __wf_atom_7e8ad928(shockwaveEntity) then
					fn(object)
				end

				total = 0
			elseif object:__wf_atom_b81a6e66() then
				total += 0.1
			end
		end

		Sleep(0.1)
	end
end

local function fn2(list) -- 2 equivalent calls inferred from this helper
	for _, v7 in ipairs(list) do
		v7:FirePort("Deactivate")
	end
end

local function fn3(list) -- 1 equivalent call inferred from this helper
	for _, v7 in ipairs(list) do
		v7:Disable()
	end
end

function BellResonancePuzzle(object)
	v4 = object
	object:GetPosition()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(sBellButton)
	local layerIndex = module.GetLayerIndex(object)
	local _idle = v2.IDLE

	for i = #__wf_atom_2226b35c, 1, -1 do
		local layerIndex2 = module.GetLayerIndex(__wf_atom_2226b35c[i])

		if layerIndex2 == layerIndex or layerIndex2 == 0 then
			__wf_atom_2226b35c[i]:Enable()
			__wf_atom_2226b35c[i]:SetOwner(object)
		else
			table.remove(__wf_atom_2226b35c, i)
		end
	end

	local bellRingingTime2 = bellRingingTime
	local v7 = 0

	while object:IsEnabled() do
		local count = 0

		for _, v8 in ipairs(__wf_atom_2226b35c) do
			if __wf_atom_7e8ad928(v8) then
				print("Most likely level was streamed out. Exiting bell puzzle script.")
				return
			elseif v8:__wf_atom_b81a6e66() then
				count += 1
			end
		end

		local state = object:GetState()

		if state == v2.IDLE then
			if count > 0 then
				bellRingingTime2 = bellRingingTime
				object:SetState(v2.ACTIVE)
			end
		elseif state == v2.ACTIVE then
			if v7 < count then
				if not __wf_atom_7e8ad928(portForwarderIncrements[count]) then
					portForwarderIncrements[count]:FirePort("TriggerPort")
				end

				bellRingingTime2 = bellRingingTime
				v7 = count
			elseif count == #__wf_atom_2226b35c then
				object:SetState(v2.COMPLETED)
			end

			if bellRingingTime2 <= 0 then
				if not __wf_atom_7e8ad928(portForwarderCountLost) then
					portForwarderCountLost:FirePort("TriggerPort")
				end

				fn2(__wf_atom_2226b35c) -- inferred equivalent call
				object:SetState(v2.IDLE)
				v7 = 0
			else
				bellRingingTime2 -= __wf_atom_084b3e93()
			end
		elseif state == v2.COMPLETED then
			Sleep(1)
		elseif state == v2.FINISHED then
			if not __wf_atom_7e8ad928(portForwarderSuccess) then
				portForwarderSuccess:FirePort("TriggerPort")
			end

			fn2(__wf_atom_2226b35c) -- inferred equivalent call
			Sleep(1)
			fn3(__wf_atom_2226b35c) -- inferred equivalent call
			object:Disable()
			break
		end

		Sleep(0)
	end
end

function Shockwave(object)
	local position = object:GetPosition()
	local __wf_atom_946cad0d = object:__wf_atom_3d96ddcd():__wf_atom_bb3e7833(__wf_atom_7b01f9ce):__wf_atom_946cad0d()

	if __wf_atom_946cad0d:__wf_atom_1bb5b1ff() ~= __wf_atom_67c46eba then
		__wf_atom_946cad0d = __wf_atom_946cad0d:__wf_atom_95e72410()
	end

	if not __wf_atom_7e8ad928(__wf_atom_946cad0d) and object:IsEnabled() and object:__wf_atom_acccc08b() then
		gRegion:CreateEntity(shockwaveEntity, position, __wf_atom_80368bb1, __wf_atom_946cad0d)
	end

	object:Disable()
end

function ForceBellPuzzleState(_, _)
	if not __wf_atom_7e8ad928(puzzleScriptTrigger) then
		puzzleScriptTrigger:SetState(forcedPuzzleState)
	end
end