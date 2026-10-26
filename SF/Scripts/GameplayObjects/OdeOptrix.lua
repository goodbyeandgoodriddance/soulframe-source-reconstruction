local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local encHint2 = nil
local ringFX = nil
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil

function IsTargetOnCone(object, p)
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	local v5 = p - v2
	Normalize(v5)
	return Dot(__wf_atom_a06d543c, v5) > 0.5
end

function LookAtTarget(object, p)
	local __wf_atom_0e1e5bc9 = object:__wf_atom_0e1e5bc9()
	local v5 = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), p)
	v5.pitch = 0
	v5.bank = 0
	local v6 = __wf_atom_0e1e5bc9 - v5

	if Abs(v6.heading) > 15 then
		object:__wf_atom_51075230(v5)
		object:__wf_atom_84d66e8e(v5)
	end
end

function AgentAttackMonitor(object)
	local __wf_atom_95e72410 = object:__wf_atom_95e72410()

	if not __wf_atom_7e8ad928(__wf_atom_95e72410) then
		local __wf_atom_30e3d82b = __wf_atom_95e72410:__wf_atom_30e3d82b()
		local timeBetweenShots2 = 0
		local __wf_atom_28224c27 = __wf_atom_95e72410:__wf_atom_d2b2176d():__wf_atom_28224c27(1)
		local v5

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			v5 = __wf_atom_28224c27:__wf_atom_66088189(1, 1)
		end

		local v6 = nil

		while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(__wf_atom_95e72410) or __wf_atom_7e8ad928(__wf_atom_95e72410:IsKilled())) do
			local target = object:__wf_atom_e919fb8e().target
			timeBetweenShots2 = math.max(0, timeBetweenShots2 - __wf_atom_084b3e93())

			if __wf_atom_7e8ad928(target) or not IsTargetOnCone(object, target:GetPosition()) then
				local __wf_atom_1149884c = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3():__wf_atom_1149884c()
				LookAtTarget(__wf_atom_95e72410, __wf_atom_1149884c)
			else
				if not __wf_atom_30e3d82b:__wf_atom_351e924e() then
					__wf_atom_30e3d82b:__wf_atom_f54283ea()
				end

				if not __wf_atom_7e8ad928(activeFX) and __wf_atom_7e8ad928(v6) and not __wf_atom_7e8ad928(v5) then
					v6 = v5:Attach(activeFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				end

				__wf_atom_30e3d82b:__wf_atom_d9c4539a(target)

				if timeBetweenShots2 <= 0 then
					__wf_atom_30e3d82b:__wf_atom_ae219cdf(target, 1, true, false)

					while not __wf_atom_7e8ad928(__wf_atom_28224c27) and __wf_atom_28224c27:GetState() == 13 do
						Sleep(0)
					end

					if not __wf_atom_7e8ad928(v6) then
						v6:Destroy()
					end

					timeBetweenShots2 = timeBetweenShots
				else
					if not __wf_atom_7e8ad928(activeFX) and __wf_atom_7e8ad928(v6) and not __wf_atom_7e8ad928(v5) then
						v6 = v5:Attach(activeFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
					end

					LookAtTarget(__wf_atom_95e72410, target:GetPosition())
				end
			end

			Sleep(0)
		end
	end
end

local function fn(object)
	for i = 1, object:__wf_atom_ca3e110b() do
		if object:__wf_atom_3d08948b(i - 1):IsA(__wf_atom_ed85f483) then
			return object:__wf_atom_3d08948b(i - 1)
		end
	end

	return nil
end

function OptrixOnEnabled(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_872ff757)
	local position

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		position = nil
	else
		position = __wf_atom_bb3e7833:GetPosition()
		v2 = position
	end

	local v5

	if #patrolRoutes > 0 then
		v5 = patrolRoutes[__wf_atom_5784a397(1, #patrolRoutes)]
	end

	local positions = {}

	if not __wf_atom_7e8ad928(v5) then
		local __wf_atom_3c752388 = v5:__wf_atom_3c752388()

		while #positions < __wf_atom_3c752388 do
			local __wf_atom_ddfab3a7 = v5:__wf_atom_ddfab3a7((math.min(#positions, __wf_atom_3c752388)))

			if not __wf_atom_7e8ad928(__wf_atom_ddfab3a7) then
				table.insert(positions, (__wf_atom_ddfab3a7:GetPosition()))
			end
		end
	end

	local function fn2(p)
		if showDebug then
			local __wf_atom_fdf659dc = __wf_atom_bb3e7833:__wf_atom_fdf659dc()

			if not __wf_atom_7e8ad928(__wf_atom_fdf659dc) then
				gRegion:__wf_atom_b5c21154(
					__wf_atom_fdf659dc + Vector(0, 0.25, 0),
					beamRadius,
					Color(255, 0, 0),
					Rotation(0, 90, 0),
					p
				)
				local v6 = __wf_atom_bb3e7833:GetPosition() - __wf_atom_bb3e7833:__wf_atom_fdf659dc()
				Normalize(v6)
				local v7 = Vector(0, 1, 0)
				local v8 = __wf_atom_edfe0d73(v6, v7)
				gRegion:__wf_atom_12f21926(
					__wf_atom_bb3e7833:GetPosition(),
					__wf_atom_bb3e7833:__wf_atom_fdf659dc(),
					beamRadius,
					v8,
					v7,
					Color(255, 0, 0, 255),
					0.1
				)
			end
		end
	end

	local function fn3(encHint)
		local v6

		if __wf_atom_7e8ad928(encHint) then
			v6 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e0730826(object, 5, true)
		else
			v6 = encHint:__wf_atom_314c9b99(2)
		end

		if __wf_atom_7e8ad928(v6) or #v6 < 1 then
			return nil
		end

		local v7 = v6[1]

		if __wf_atom_7e8ad928(position) then
			position = object:GetPosition()
		end

		local v8 = Distance(v6[1]:__wf_atom_50a7d83e():GetPosition(), position)

		for _, v9 in pairs(v6) do
			if v9:__wf_atom_8077d924() ~= 2 then
				continue
			end

			local v10 = Distance(v9:__wf_atom_50a7d83e():GetPosition(), position)

			if not (v10 < v8) then
				continue
			end

			v7 = v9
			v8 = v10
		end

		return v7
	end

	local function fn4(object2, object3)
		if __wf_atom_7e8ad928(object3) then
			return
		end

		fn2(0)
		local __wf_atom_81548e8e = object3:__wf_atom_81548e8e()

		if not __wf_atom_7e8ad928(__wf_atom_81548e8e) then
			if __wf_atom_81548e8e:IsA(__wf_atom_8d0b7f88) then
				__wf_atom_81548e8e = __wf_atom_81548e8e:__wf_atom_f7e7be53()
			end

			if __wf_atom_81548e8e:IsA(envoyAvatarType) then
				local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.target = __wf_atom_81548e8e
				return
			end

			local v6 = object3:GetPosition() - object3:__wf_atom_fdf659dc()
			Normalize(v6)
			local __wf_atom_8f153f2d = gRegion:__wf_atom_8f153f2d(
				object3:GetPosition(),
				object3:__wf_atom_fdf659dc(),
				beamRadius,
				v6,
				v
			)

			if
				not __wf_atom_7e8ad928(__wf_atom_8f153f2d)
				and #__wf_atom_8f153f2d > 0
				and __wf_atom_8f153f2d[1]:IsA(envoyAvatarType)
			then
				local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.target = __wf_atom_8f153f2d[1]
				return
			end
		end

		local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.target = nil
	end

	local function fn5(p, p2, p3)
		local v6 = __wf_atom_fa8d0177(v2, p)
		local v7 = __wf_atom_fa8d0177(v2, p2)
		local v8 = Distance(p, p2) / optrixIdleSpeed
		local total = 0

		while total < v8 do
			local v9 = __wf_atom_9d2f097a(v6, v7, __wf_atom_24a82b69(__wf_atom_421b01aa(total / v8, 0, 1)))
			total += __wf_atom_084b3e93()

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:__wf_atom_9b788a35(v9)

				if not __wf_atom_7e8ad928(ringFX) then
					ringFX:SetPosition(__wf_atom_bb3e7833:__wf_atom_fdf659dc())
				end

				fn4(object, __wf_atom_bb3e7833)
			end

			Sleep(0)

			if
				p3
				and not __wf_atom_7e8ad928(v)
				and not __wf_atom_7e8ad928(v:__wf_atom_30e3d82b())
				and v:__wf_atom_30e3d82b():__wf_atom_351e924e()
			then
				break
			end
		end

		fn2(optrixIdlePauseTime)
	end

	local flag = true
	local encHint = object:__wf_atom_e919fb8e().encHint
	local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(enemyActionType)
	local __wf_atom_bb3e7833_3 = object:__wf_atom_bb3e7833(playerActionType)
	local v6 = 1
	local _ = positions[v6]

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
		__wf_atom_bb3e7833_2:Enable()
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_3) then
		__wf_atom_bb3e7833_3:Enable()
	end

	local position2 = nil
	local v7 = -1
	local total = 0
	local v8 = nil

	while not __wf_atom_7e8ad928(object) do
		if object:IsEnabled() then
			if object:__wf_atom_b81a6e66() then
				if flag then
					if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						break
					end

					__wf_atom_bb3e7833:Enable()
					__wf_atom_bb3e7833:__wf_atom_e6ed03c8()
					v = object:__wf_atom_95e72410()
					ringFX = gRegion:CreateEntity(ringFx, __wf_atom_bb3e7833:__wf_atom_fdf659dc(), Rotation(), v, v, 1)
					local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
					__wf_atom_e919fb8e.ringFX = ringFX
					local __wf_atom_e919fb8e_2 = object:__wf_atom_e919fb8e()
					__wf_atom_e919fb8e_2.target = nil
					flag = false
					object:__wf_atom_8a035cd5(Symbol("AgentAttackMonitor"), false)
					v3 = v:__wf_atom_d2b2176d():__wf_atom_28224c27(1)
					position2 = __wf_atom_bb3e7833:__wf_atom_fdf659dc()

					if not __wf_atom_7e8ad928(v3) then
						v4 = fn(v3)

						if not __wf_atom_7e8ad928(v4) and v4:IsA(__wf_atom_ed85f483) then
							v4:__wf_atom_18fa30ab(2)
						end
					end
				end

				if __wf_atom_7e8ad928(v) or __wf_atom_7e8ad928(v:__wf_atom_30e3d82b()) or v:IsKilled() then
					flag = true
					__wf_atom_bb3e7833:Disable()

					if not __wf_atom_7e8ad928(ringFX) then
						ringFX:Destroy()
					end

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
						__wf_atom_bb3e7833_2:Enable()
					end

					object:Deactivate()
				elseif v:__wf_atom_30e3d82b():__wf_atom_04ea4887() then
					local __wf_atom_14bb6996 = v:__wf_atom_30e3d82b():__wf_atom_14bb6996()

					if
						__wf_atom_7e8ad928(__wf_atom_14bb6996)
						or not (#__wf_atom_14bb6996 > 0 and __wf_atom_14bb6996[1].visible)
					then
						if not (__wf_atom_7e8ad928(v) or __wf_atom_7e8ad928(v:__wf_atom_30e3d82b())) then
							local __wf_atom_1340423d = v:__wf_atom_30e3d82b():__wf_atom_1340423d()

							if not __wf_atom_7e8ad928(__wf_atom_1340423d) then
								local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
								__wf_atom_e919fb8e.target = __wf_atom_1340423d

								if IsTargetOnCone(object, __wf_atom_1340423d:GetPosition()) then
									fn5(position2, __wf_atom_1340423d:GetPosition(), false)

									if not __wf_atom_7e8ad928(__wf_atom_1340423d) then
										position2 = __wf_atom_1340423d:GetPosition()
									end

									v7 = Time()
								end
							end
						end

						fn4(object, __wf_atom_bb3e7833)
					else
						local v9 = __wf_atom_14bb6996[1]
						local avatar = v9.avatar

						if not __wf_atom_7e8ad928(avatar) then
							local position3 = avatar:GetPosition()

							if IsTargetOnCone(object, position3) then
								fn5(position2, position3, false)
								v7 = Time()
								position2 = position3
							elseif v9.visible and v7 > 0 and Time() - v7 > 2.5 then
								__wf_atom_bb3e7833:Disable()
								v:__wf_atom_30e3d82b():__wf_atom_cf391375()

								if not __wf_atom_7e8ad928(v4) and v4:IsA(__wf_atom_ed85f483) then
									v4:__wf_atom_18fa30ab(0)
								end

								if not __wf_atom_7e8ad928(v3) then
									local __wf_atom_66088189 = v3:__wf_atom_66088189(1, 1)

									if not __wf_atom_7e8ad928(__wf_atom_66088189) then
										local __wf_atom_bb3e7833_4 = __wf_atom_66088189:__wf_atom_bb3e7833(activeFX)

										if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_4) then
											__wf_atom_bb3e7833_4:Destroy()
										end
									end
								end

								if not __wf_atom_7e8ad928(ringFX) then
									ringFX:Destroy()
								end

								break
							end
						end
					end
				else
					total += __wf_atom_084b3e93()

					if optrixIdlePauseTime <= total then
						if v6 + 1 <= #positions then
							fn5(positions[v6], positions[v6 + 1], true)
							v6 += 1
						else
							fn5(positions[v6], positions[1], true)
							v6 = 1
						end

						position2 = positions[v6]
						total = 0
					else
						fn4(object, __wf_atom_bb3e7833)
					end
				end
			elseif __wf_atom_7e8ad928(v8) then
				v8 = fn3(encHint)

				if not (__wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(__wf_atom_bb3e7833_2)) then
					v8:UseContextAction(__wf_atom_bb3e7833_2, false)
				end

				Sleep(1)
			end
		end

		Sleep(0)
	end
end

function SetupOdeOptrix(instance)
	encHint2 = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(encHint2) or not encHint2:IsA(__wf_atom_f806fd7a) or math.random() > chanceToSpawn then
		instance:Destroy()
		return
	end

	local position = encHint2:GetPosition()
	local __wf_atom_6199ef01 = encHint2:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(encHint2, __wf_atom_6199ef01)

	if __wf_atom_7e8ad928(__wf_atom_6199ef01) or #__wf_atom_6199ef01 < 1 then
		instance:Destroy()
		return
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
		Symbol("OdeOptrixDevice"),
		position,
		0,
		encHint2:__wf_atom_103377cc()
	)
	local pointInstances = module.FindPointInstances(encHint2, nil, Symbol("OdeOptrixDevice"))
	local mergeTables = module2.MergeTables(__wf_atom_439c0d29, pointInstances, true)

	if __wf_atom_7e8ad928(mergeTables) or #mergeTables <= 0 then
		instance:Destroy()
		return
	end

	local mergeTable = mergeTables[math.random(1, #mergeTables)]
	local __wf_atom_e919fb8e = mergeTable:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.encHint = encHint2
	mergeTable:SetVisibility(true, true)
	mergeTable:Enable()
end

function OptrixOnTouched(object, object2)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	object2:__wf_atom_921c1a5f(playerTouchAnim, false, 3, 1, true)
	Sleep(0.5)

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:Disable()
		__wf_atom_3d96ddcd:Destroy()
		local __wf_atom_95e72410 = __wf_atom_3d96ddcd:__wf_atom_95e72410()

		if not __wf_atom_7e8ad928(__wf_atom_95e72410) then
			local __wf_atom_30e3d82b = __wf_atom_95e72410:__wf_atom_30e3d82b()

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_cf391375()
			end

			local __wf_atom_28224c27 = __wf_atom_95e72410:__wf_atom_d2b2176d():__wf_atom_28224c27(1)

			if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
				local v5 = fn(__wf_atom_28224c27)

				if not __wf_atom_7e8ad928(v5) and v5:IsA(__wf_atom_ed85f483) then
					v5:__wf_atom_18fa30ab(0)
				end

				local __wf_atom_66088189 = __wf_atom_28224c27:__wf_atom_66088189(1, 1)

				if not __wf_atom_7e8ad928(__wf_atom_66088189) then
					local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(activeFX)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_bb3e7833:Destroy()
					end
				end
			end

			if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd:__wf_atom_e919fb8e().ringFX) then
				__wf_atom_3d96ddcd:__wf_atom_e919fb8e().ringFX:Destroy()
			end
		end
	end
end