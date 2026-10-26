Symbol("PuzzleVineSpline")
local v = WeakResource("/SF/Types/Gameplay/Puzzles/Attachments/PuzzleGalvanicKnobArrowAttachmentDeco")
local v2 = WeakResource("/SF/Types/Gameplay/Puzzles/Attachments/PuzzleGalvanicZapperAttachmentDeco")
local v3 = WeakResource("/SF/Types/Gameplay/Puzzles/Attachments/PuzzleGalvanicAlarmAttachmentDeco")
local v4 = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("Lotus.Scripts.Libs.AudioLib")
local v5 = { SWITCH = 0, KNOB = 1 }
local v6 = { OFF = 0, ON = 1 }

local function fn(object, object2, p)
	local damageData = Engine.DamageData()
	damageData.baseAmount = math.floor(p)
	damageData:__wf_atom_7498285f(0, 1)
	damageData:__wf_atom_d6f4d914(5, true)
	damageData:__wf_atom_d6f4d914(16, true)
	damageData:__wf_atom_8e0ba0ec(-4)
	damageData:__wf_atom_34a8a27a(object2)
	damageData:__wf_atom_12cf5317(object:__wf_atom_a06d543c() * 3 * 1)

	if object:__wf_atom_c6f1f83d() - damageData.baseAmount > 1 then
		object:__wf_atom_649bf33e(damageData)
	end
end

function ActionOnActivated(object, _)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:Activate()
	end

	Sleep(1)

	if disableOnUse then
		object:Disable()
	else
		object:Enable()
	end
end

local function fn2(p, object, p2)
	local endpoints = {}
	local startpoints = {}
	local entities = {}
	local v7 = {}

	for i = 1, object:__wf_atom_20d94d26() do
		local position = object:GetPosition()
		local __wf_atom_ac281087 = object:__wf_atom_ac281087(i, true, true)
		table.insert(endpoints, __wf_atom_ac281087[#__wf_atom_ac281087] + position)
		table.insert(startpoints, __wf_atom_ac281087[1] + position)

		if not p then
			continue
		end

		local entity = gRegion:CreateEntity(p2, position, object:__wf_atom_dc309f8a())
		entity:__wf_atom_ff43aa5a(__wf_atom_ac281087)
		table.insert(entities, entity)
	end

	v7.splines = entities
	v7.startpoints = startpoints
	v7.endpoints = endpoints
	return v7
end

function DrawSplineGalvanic(_, object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if #__wf_atom_e919fb8e.splines > 0 then
		for i = 1, #__wf_atom_e919fb8e.splines do
			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.splines[i]) then
				__wf_atom_e919fb8e.splines[i]:Destroy()
			end
		end
	end

	local v7

	if __wf_atom_e919fb8e.on then
		v7 = splineDrawActivatedType
	else
		v7 = splineDrawType
	end

	__wf_atom_e919fb8e.splines = fn2(true, object, v7).splines
end

function KnobOnEnabled(object)
	local outputSpline2 = nil
	local v7 = nil
	local v8 = nil
	local v9 = nil
	local v10 = nil
	local v11 = nil
	local v12 = false
	local outputKnob2 = nil
	local outputKnobs2 = nil
	local outputSplines2 = nil
	local v13 = nil

	while __wf_atom_7e8ad928(gGameRules) or not gGameRules:__wf_atom_adfb052a() do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		print("Light knob script exited, most likely due to streaming out of the level or host migration.")
		return
	end

	v4 = object:__wf_atom_bb3e7833(__wf_atom_589cefdb)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		v11 = __wf_atom_bb3e7833:__wf_atom_45c0553e()
		v10 = __wf_atom_bb3e7833:__wf_atom_fa6a8faf()
	end

	if toggleKindId == v5.SWITCH then
		outputKnob2 = outputKnob

		if #outputKnobs > 0 then
			outputKnobs2 = outputKnobs
		end

		if #outputSplines > 0 then
			outputSplines2 = outputSplines
		end

		if not __wf_atom_7e8ad928(outputSpline) then
			outputSpline2 = outputSpline
		end

		if __wf_atom_7e8ad928(outputSpline2) then
			return
		end
	elseif toggleKindId == v5.KNOB then
		outputSplines2 = outputSplines
		outputKnobs2 = outputKnobs
	end

	local function fn3(startState)
		local v14 = nil

		if not (math.random(0, 1) < knobRandomStateChance) then
			return startState
		end

		if toggleKindId == v5.SWITCH then
			if startState == 0 then
				return 1
			end

			return 0
		else
			if toggleKindId ~= v5.KNOB then
				return v14
			end

			while __wf_atom_7e8ad928(v14) do
				local v15 = __wf_atom_5784a397(0, #outputKnobs - 1)

				if v15 ~= startState then
					v14 = v15
				end
			end

			return v14
		end
	end

	if not __wf_atom_7e8ad928(object) then
		if randomizeStartState then
			startState = fn3(startState)
		end

		object:__wf_atom_0e990c03(startState)
		v7 = object:__wf_atom_bb3e7833(__wf_atom_0f45538d)
		v8 = object:__wf_atom_bb3e7833(__wf_atom_7b01f9ce)
		v9 = object:__wf_atom_bb3e7833(__wf_atom_465d956f)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			local v14 = v11.heading + arrowAngles[object:__wf_atom_f2317dfd() + 1]
			__wf_atom_bb3e7833:__wf_atom_e310f01f(v10, Rotation(v14, v11.pitch, v11.bank))
		end

		if toggleKindId == v5.KNOB then
			for _, v14 in pairs(outputSplines) do
				if __wf_atom_7e8ad928(v14) then
					continue
				end

				local __wf_atom_e919fb8e = v14:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.on = false
				v4:__wf_atom_84da4715(v14)
			end
		elseif toggleKindId == v5.SWITCH then
			local outputSpline = outputSpline

			if not __wf_atom_7e8ad928(outputSpline) then
				local __wf_atom_e919fb8e = outputSpline:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.on = false
				v4:__wf_atom_84da4715(outputSpline)
			end
		end

		if not __wf_atom_7e8ad928(v7) then
			v7:Enable()
		end

		if not __wf_atom_7e8ad928(v8) then
			v8:Enable()
		end

		if not __wf_atom_7e8ad928(v9) then
			v9:Enable()
		end
	end

	local v14 = nil

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_f2317dfd = object:__wf_atom_f2317dfd()
		local flag = false

		if not object:IsEnabled() then
			break
		end

		if v14 ~= __wf_atom_f2317dfd then
			v14 = __wf_atom_f2317dfd
			flag = true
		end

		if flag then
			if toggleKindId == v5.SWITCH then
				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:__wf_atom_e310f01f(
						v10,
						Rotation(v11.heading, arrowAngles[__wf_atom_f2317dfd + 1], v11.bank)
					)
				end
			elseif toggleKindId == v5.KNOB and not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:__wf_atom_e310f01f(
					v10,
					Rotation(v11.heading + arrowAngles[__wf_atom_f2317dfd + 1], v11.pitch, v11.bank)
				)
			end
		end

		if object:__wf_atom_b81a6e66() then
			if not v12 then
				flag = true

				if not __wf_atom_7e8ad928(knobPoweredFx) then
					v13 = object:Attach(knobPoweredFx, EMPTY_SYMBOL)
				end

				if not __wf_atom_7e8ad928(knobPoweredSound) then
					object:PlaySound(knobPoweredSound, false)
				end

				v12 = true
			end

			if flag then
				if toggleKindId == v5.SWITCH then
					if __wf_atom_f2317dfd == v6.OFF then
						if not __wf_atom_7e8ad928(outputKnob2) then
							outputKnob2:Deactivate()
						end

						if not __wf_atom_7e8ad928(outputSpline2) then
							local __wf_atom_e919fb8e = outputSpline2:__wf_atom_e919fb8e()
							__wf_atom_e919fb8e.on = false
							v4:__wf_atom_84da4715(outputSpline2)
						end

						if #outputKnobs2 > 0 then
							for _, outputKnob in pairs(outputKnobs2) do
								outputKnob:Deactivate()
							end
						end

						if #outputSplines2 > 0 then
							for _, outputSpline in pairs(outputSplines2) do
								if __wf_atom_7e8ad928(outputSpline) then
									continue
								end

								local __wf_atom_e919fb8e = outputSpline:__wf_atom_e919fb8e()
								__wf_atom_e919fb8e.on = false
								v4:__wf_atom_84da4715(outputSpline)
							end
						end
					else
						if not __wf_atom_7e8ad928(outputKnob2) then
							outputKnob2:Activate()
						end

						if not __wf_atom_7e8ad928(outputSpline2) then
							local __wf_atom_e919fb8e = outputSpline2:__wf_atom_e919fb8e()
							__wf_atom_e919fb8e.on = true
							v4:__wf_atom_84da4715(outputSpline2)
						end

						if #outputKnobs2 > 0 then
							for _, outputKnob in pairs(outputKnobs2) do
								outputKnob:Activate()
							end
						end

						if #outputSplines2 > 0 then
							for _, outputSpline in pairs(outputSplines2) do
								if __wf_atom_7e8ad928(outputSpline) then
									continue
								end

								local __wf_atom_e919fb8e = outputSpline:__wf_atom_e919fb8e()
								__wf_atom_e919fb8e.on = true
								v4:__wf_atom_84da4715(outputSpline)
							end
						end
					end
				elseif toggleKindId == v5.KNOB then
					if __wf_atom_f2317dfd == 0 then
						outputKnobs2[1]:Activate()
						outputKnobs2[2]:Deactivate()
						local outputSpline = outputSplines2[1]

						if not __wf_atom_7e8ad928(outputSpline) then
							local __wf_atom_e919fb8e = outputSpline:__wf_atom_e919fb8e()
							__wf_atom_e919fb8e.on = true
							v4:__wf_atom_84da4715(outputSpline)
						end

						local outputSpline3 = outputSplines2[2]

						if not __wf_atom_7e8ad928(outputSpline3) then
							local __wf_atom_e919fb8e = outputSpline3:__wf_atom_e919fb8e()
							__wf_atom_e919fb8e.on = false
							v4:__wf_atom_84da4715(outputSpline3)
						end
					elseif __wf_atom_f2317dfd == 1 then
						outputKnobs2[2]:Activate()
						outputKnobs2[1]:Deactivate()
						local outputSpline = outputSplines2[1]

						if not __wf_atom_7e8ad928(outputSpline) then
							local __wf_atom_e919fb8e = outputSpline:__wf_atom_e919fb8e()
							__wf_atom_e919fb8e.on = false
							v4:__wf_atom_84da4715(outputSpline)
						end

						local outputSpline3 = outputSplines2[2]

						if not __wf_atom_7e8ad928(outputSpline3) then
							local __wf_atom_e919fb8e = outputSpline3:__wf_atom_e919fb8e()
							__wf_atom_e919fb8e.on = true
							v4:__wf_atom_84da4715(outputSpline3)
						end
					end
				end
			end
		elseif not object:__wf_atom_b81a6e66() and v12 then
			if toggleKindId == v5.SWITCH then
				outputKnob2:Deactivate()

				if not __wf_atom_7e8ad928(outputSpline2) then
					local __wf_atom_e919fb8e = outputSpline2:__wf_atom_e919fb8e()
					__wf_atom_e919fb8e.on = false
					v4:__wf_atom_84da4715(outputSpline2)
				end
			elseif toggleKindId == v5.KNOB then
				for _, v15 in pairs(outputKnobs) do
					v15:Deactivate()
				end

				for _, v15 in pairs(outputSplines) do
					if __wf_atom_7e8ad928(v15) then
						continue
					end

					local __wf_atom_e919fb8e = v15:__wf_atom_e919fb8e()
					__wf_atom_e919fb8e.on = false
					v4:__wf_atom_84da4715(v15)
				end
			end

			if not __wf_atom_7e8ad928(knobDispoweredSound) then
				object:PlaySound(knobDispoweredSound, false)
			end

			if not __wf_atom_7e8ad928(v13) then
				v13:Destroy()
			end

			v12 = false
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		if not __wf_atom_7e8ad928(v7) then
			v7:Disable()
		end

		if not __wf_atom_7e8ad928(v8) then
			v8:Disable()
		end

		if not __wf_atom_7e8ad928(v9) then
			v9:Disable()
		end
	end
end

function KnobOnTouched(object, object2)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	object2:__wf_atom_921c1a5f(playerTouchAnim, true, 3, 1, true)

	if __wf_atom_3d96ddcd:__wf_atom_f2317dfd() == 1 then
		__wf_atom_3d96ddcd:__wf_atom_0e990c03(0)
	else
		__wf_atom_3d96ddcd:__wf_atom_0e990c03(1)
	end

	__wf_atom_3d96ddcd:PlaySound(knobTurnSound, false)
	Sleep(1)

	if disableOnUse then
		object:Disable()
	else
		object:Enable()
	end
end

function KnobOnHitUpdate(object)
	Sleep(0)
	module.Deflect(object)
	Sleep(1)
	object:MakeVulnerable()
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript) then
		__wf_atom_e919fb8e.runningHitUpdateScript = false
	end
end

function KnobOnHit(object, _)
	if object:__wf_atom_f2317dfd() == 1 then
		object:__wf_atom_0e990c03(0)
	else
		object:__wf_atom_0e990c03(1)
	end

	object:PlaySound(knobHitSound, false)
	object:SetHealth(object:__wf_atom_95174740())
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript)
		or __wf_atom_e919fb8e.runningHitUpdateScript == false
	then
		object:MakeInvulnerable()
		__wf_atom_e919fb8e.runningHitUpdateScript = true
		object:__wf_atom_8a035cd5(Symbol("KnobOnHitUpdate"), false)
	end
end

function ZapperOnEnabled(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_8b8e8b22)
	local v7 = object:GetPosition() + object:__wf_atom_acb19668() * 2
	local v8 = false
	local v9 = nil
	local v10 = nil

	while not __wf_atom_7e8ad928(object) do
		if not object:IsEnabled() then
			break
		end

		local __wf_atom_b81a6e66 = object:__wf_atom_b81a6e66()

		if __wf_atom_b81a6e66 then
			if v8 ~= __wf_atom_b81a6e66 then
				if not __wf_atom_7e8ad928(zapperFxType) then
					local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(v2)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
						v10 = __wf_atom_bb3e7833_2:Attach(zapperFxType, EMPTY_SYMBOL)
					end
				end

				object:PlaySound(zapperWarmupSound, false)
				module2.EnableTaggedSequencers(Symbol("GalvanicZapperActive"), true)
				Sleep(1.5)
				object:PlaySound(zapperEnabledSound, false)
			end

			if __wf_atom_bb3e7833:__wf_atom_acccc08b() then
				local __wf_atom_6f4fd712 = __wf_atom_bb3e7833:__wf_atom_6f4fd712()
				local v11 = __wf_atom_6f4fd712[__wf_atom_5784a397(1, #__wf_atom_6f4fd712)]

				if not __wf_atom_7e8ad928(v11) then
					v9 = gRegion:CreateEntity(zapperBeamType, v7, __wf_atom_80368bb1)

					if not __wf_atom_7e8ad928(v9) then
						v9:__wf_atom_b2394158(v11, Symbol("GAME_C1_HEAD1"))
						v9:Enable()
					end
				end

				if not __wf_atom_7e8ad928(v11) then
					fn(v11, object, v11:__wf_atom_c6f1f83d() * 0.65)
				end

				Sleep(3)

				if not __wf_atom_7e8ad928(v9) then
					v9:Destroy()
				end
			end
		else
			if v8 ~= __wf_atom_b81a6e66 then
				if not __wf_atom_7e8ad928(v10) then
					v10:Destroy()
				end

				module2.EnableTaggedSequencers(Symbol("GalvanicZapperActive"), false)
				object:PlaySound(zapperCooldownSound, false)
				Sleep(1.5)
			end

			if not __wf_atom_7e8ad928(v9) then
				v9:Destroy()
			end
		end

		Sleep(0.1)
		v8 = __wf_atom_b81a6e66
	end
end

function OutletOnEnabled(object)
	local v7 = false
	local v8 = false
	local v9 = nil

	while not __wf_atom_7e8ad928(object) do
		if not object:IsEnabled() then
			break
		end

		local __wf_atom_b81a6e66 = object:__wf_atom_b81a6e66()

		if __wf_atom_b81a6e66 then
			if not v7 then
				object:PlaySound(successSound, false)
				v7 = true
			end

			if v8 ~= __wf_atom_b81a6e66 then
				object:PlaySound(knobPoweredSound, false)

				if not __wf_atom_7e8ad928(knobPoweredFx) then
					v9 = object:Attach(knobPoweredFx, EMPTY_SYMBOL)
				end

				Sleep(2)

				if not __wf_atom_7e8ad928(v9) then
					v9:Destroy()
				end
			end
		elseif v8 ~= __wf_atom_b81a6e66 then
			object:PlaySound(knobDispoweredSound, false)

			if not __wf_atom_7e8ad928(v9) then
				v9:Destroy()
			end
		end

		Sleep(0.1)
		v8 = __wf_atom_b81a6e66
	end
end

function AlarmOnEnabled(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v3)
	local v7 = false
	local v8 = false
	local v9 = nil

	while not __wf_atom_7e8ad928(object) do
		if not object:IsEnabled() then
			break
		end

		local __wf_atom_b81a6e66 = object:__wf_atom_b81a6e66()

		if __wf_atom_b81a6e66 then
			if not v7 then
				local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
					Symbol("VoltaicPuzzleAlarmSpawn"),
					object:GetPosition(),
					0,
					100
				)

				for _, v10 in pairs(__wf_atom_439c0d29) do
					v10:Enable()
					local agent = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():CreateAgent(dogAgentType, v10)

					if not __wf_atom_7e8ad928(agent) then
						agent:__wf_atom_30b587a4()
					end

					v10:Disable()
					Sleep(0)
				end

				v7 = true
			end

			if v8 ~= __wf_atom_b81a6e66 then
				gRegion:CreateEntity(alarmPerceptionHintType, object:GetPosition(), __wf_atom_80368bb1)
				__wf_atom_bb3e7833:FirePort("EnableReplicaMoveNoise")
				module2.EnableTaggedSequencers(Symbol("GalvanicAlarmActive"), true)

				if not __wf_atom_7e8ad928(knobPoweredSound) then
					__wf_atom_bb3e7833:PlaySound(knobPoweredSound, false)
				end

				if not __wf_atom_7e8ad928(knobPoweredFx) then
					v9 = __wf_atom_bb3e7833:Attach(knobPoweredFx, EMPTY_SYMBOL)
				end
			end
		elseif v8 ~= __wf_atom_b81a6e66 then
			__wf_atom_bb3e7833:FirePort("DisableReplicaMoveNoise")
			module2.EnableTaggedSequencers(Symbol("GalvanicAlarmActive"), false)

			if not __wf_atom_7e8ad928(knobDispoweredSound) then
				__wf_atom_bb3e7833:PlaySound(knobDispoweredSound, false)
			end

			if not __wf_atom_7e8ad928(v9) then
				v9:Destroy()
			end
		end

		Sleep(0.1)
		v8 = __wf_atom_b81a6e66
	end
end