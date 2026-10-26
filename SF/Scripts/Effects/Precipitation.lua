local v = {}
local v2 = {}
local v3 = {}
local module = require("Lotus.Scripts.Libs.GameplayUtilities")
local v4 = Symbol("RainPower")
local v5 = Symbol("WetBias")
local v6 = Symbol("AlphaFadeMult")

local function fn()
	local count = 0

	for i = 1, 5 do
		v[i] = {}
		v2[i] = {}
		v3[i] = {}

		for j = 1, 5 do
			v[i][j] = Vector(i - 3, 0, j - 3) * 10

			if i == 3 and j == 3 then
				v2[3][3] = __wf_atom_10cd16b2(1, 1)
			else
				v2[i][j] = __wf_atom_10cd16b2(1, 0.6)
			end

			v3[i][j] = Symbol("Vis" .. count)
			count += 1
		end
	end
end

function SkyVisibility(object)
	fn()

	if forceRainEnabled then
		_T.gWeatherRain = true
	end

	if not testing then
		if isRainLevel then
			while _T.gWeatherRain == nil do
				Sleep(0)
			end

			local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(Symbol("WeatherRain"))

			if (forceRainEnabled and 1 or __wf_atom_d163c8e5) == 0 then
				return
			end
		end

		if openworld then
			while not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) do
				Sleep(0)
			end
		elseif not isCinematicDeco then
			module.WaitForOpeningCin()
		end
	end

	if not __wf_atom_7e8ad928(object) then
		object:SetVisibility(true, false)
	end

	local v7 = nil
	local v8 = nil
	local v9 = __wf_atom_10cd16b2(1, soundConvergeTime)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v10 = nil
	local v11

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		v11 = __wf_atom_c4f78a8f:PlaySound(sound, false)

		if not __wf_atom_7e8ad928(soundTwo) then
			v7 = __wf_atom_c4f78a8f:PlaySound(soundTwo, false)
		end

		if not __wf_atom_7e8ad928(soundThree) then
			v8 = __wf_atom_c4f78a8f:PlaySound(soundThree, false)
		end

		if not __wf_atom_7e8ad928(object) then
			v10 = gRegion:CreateEntity(playerAttachedDecoType, __wf_atom_28d5d4aa, __wf_atom_80368bb1, nil, object)

			if not __wf_atom_7e8ad928(v10) then
				__wf_atom_c4f78a8f:AttachEntity(v10, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end
		end
	end

	local v12 = Vector()
	local v13 = Vector(0, 100, 0)
	local v14 = Vector()
	local v15 = Vector()
	local v16 = Vector()
	local v17 = Vector()
	local v18 = Vector()
	local v19 = Vector(0, 1, 0)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	gRegion:__wf_atom_c4f78a8f()
	local all = gRegion:FindAll(__wf_atom_4d4372ee)
	local v20 = Vector()
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local v21 = 1
	local v22 = 1
	local v23 = -1
	local v24 = 1
	local v25 = false
	local v26 = true
	local v27 = true
	local v28 = -1
	local v29 = 0

	while not __wf_atom_7e8ad928(object) do
		local v30

		if isCinematicDeco then
			v30 = object
		else
			v30 = gRegion:__wf_atom_c4f78a8f()
		end

		if __wf_atom_7e8ad928(v30) then
			object:__wf_atom_c5f1c61a(v12)
		else
			v30:__wf_atom_c5f1c61a(v12)
		end

		VectorAdd(v12, v12, v19)
		local v31 = __wf_atom_084b3e93()
		local v32 = 1
		local v33 = v21 + 1
		local v34

		if v33 > 5 then
			v33 = 1
			v34 = v22 + 1

			if v34 > 5 then
				v34 = 1
			end
		else
			v34 = v22
		end

		local v35 = v33 == 3 and v34 == 3 and 4 or v33
		v15.x = __wf_atom_104bfe98(-5, 5, math.random())
		v15.y = 0
		v15.z = __wf_atom_104bfe98(-5, 5, math.random())

		if v21 ~= 3 and v22 ~= 3 then
			v15.y = 5
		end

		VectorAdd(v16, v[v21][v22], v15)
		v20.x = v12.x
		v20.y = v12.y
		v20.z = v12.z

		if __wf_atom_2202ffb6:__wf_atom_3c37bceb(v20, 10) and v20.y - v12.y < 5 then
			v12.x = v20.x
			v12.y = v20.y + 1.5
			v12.z = v20.z
		end

		VectorAdd(v17, v12, v16)
		VectorAdd(v18, v17, v13)

		if openworld then
			if v23 < 0 then
				local v36 = false

				if not __wf_atom_7e8ad928(all) then
					for i = 1, #all do
						if __wf_atom_7e8ad928(all[i]) or not all[i]:__wf_atom_1d13ef4d() then
							continue
						end

						v24 = forceRainEnabled and 1 or v24
						v36 = true

						if v24 > 0 then
							local v37 = not v25 or v27
							v25 = true
							v27 = v37
							break
						else
							local v37 = v25 and true or v27
							v25 = false
							v27 = v37
							break
						end
					end
				end

				if not v36 then
					all = gRegion:FindAll(__wf_atom_4d4372ee)
				end

				v23 = 1
			end

			v23 -= v31
		else
			v25 = true
		end

		if v25 or v27 then
			local __wf_atom_c699ad69 = gRegion:__wf_atom_c699ad69(v17)
			local v36 = not openworld
				and (__wf_atom_7e8ad928(__wf_atom_c699ad69) or not __wf_atom_c699ad69:__wf_atom_a529f083())
				and not testing
				and 0
				or gRegion:Raycast(v18, v17, object, nil, v14, true, false, true) and 0
				or v32
			v2[v21][v22]:__wf_atom_09294a87(v36)
			v15.x = __wf_atom_104bfe98(-0.5, 0.5, math.random())
			v15.y = 0
			v15.z = __wf_atom_104bfe98(-0.5, 0.5, math.random())
			VectorAdd(v16, v[3][3], v15)
			VectorAdd(v17, v12, v16)
			VectorAdd(v18, v17, v13)
			v15.x = __wf_atom_104bfe98(-1, 1, math.random())
			v15.z = __wf_atom_104bfe98(-1, 1, math.random())
			VectorAdd(v18, v18, v15)
			local __wf_atom_c699ad69_2 = gRegion:__wf_atom_c699ad69(v17)
			local v37 = not openworld
				and (__wf_atom_7e8ad928(__wf_atom_c699ad69_2) or not __wf_atom_c699ad69_2:__wf_atom_a529f083())
				and 0
				or gRegion:Raycast(v17, v18, object, nil, v14, true, false) and 0
				or 1
			v2[3][3]:__wf_atom_09294a87(v37)
			local total = 0

			for i = 1, 5 do
				for j = 1, 5 do
					local v38 = v[i][j]
					v2[i][j]:Update(v31)
					local v39 = v2[i][j]:__wf_atom_9e368823() * v24
					total += v39
					object:__wf_atom_fd3ec680(v3[i][j], -1, v38.x, v38.y, v38.z, v39)
				end
			end

			local lightning = not (v25 and total <= 0.01)
			local v39 = v2[3][3]:__wf_atom_9e368823() * v24

			if useLightningPost then
				if lightning ~= v26 or v27 then
					object:SetVisibility(lightning, false)

					if isRainLevel and not __wf_atom_7e8ad928(__wf_atom_8ad59546) then
						__wf_atom_8ad59546.postProcess.lightning = lightning
					end

					v26 = lightning
				end

				if not __wf_atom_7e8ad928(__wf_atom_8ad59546) then
					local lightning2 = v39 > 0.01
					__wf_atom_8ad59546.postProcess.lightning = lightning2
				end
			end

			if not __wf_atom_7e8ad928(v11) then
				v9:__wf_atom_09294a87((math.min(v39 + 1 * (total - v39) / 24, 1)))
				v9:Update(v31)
				v11:__wf_atom_ff2a5387(__wf_atom_104bfe98(soundGainMin, soundGainMax, v9:__wf_atom_9e368823()))

				if not v25 and v27 then
					v11:Pause()
				end

				if v25 and v27 then
					v11:Resume()
				end
			end

			if not __wf_atom_7e8ad928(v7) then
				if openworld and total > 0.01 then
					v7:__wf_atom_ff2a5387(__wf_atom_104bfe98(
						__wf_atom_104bfe98(soundGainMin, -5, (math.min(1, v24 * 3))),
						soundGainMax,
						v9:__wf_atom_9e368823()
					))
				else
					v7:__wf_atom_ff2a5387(__wf_atom_104bfe98(soundGainMin, soundGainMax, v9:__wf_atom_9e368823()))
				end

				if not v25 and v27 then
					v7:Pause()
				end

				if v25 and v27 then
					v7:Resume()
				end
			end

			if not __wf_atom_7e8ad928(v8) then
				if openworld and total > 0.01 then
					v8:__wf_atom_ff2a5387(__wf_atom_104bfe98(
						__wf_atom_104bfe98(soundGainMin, -5, (math.min(1, v24 * 3))),
						soundGainMax,
						(math.min(1, v9:__wf_atom_9e368823() * 1.5))
					))
				else
					v8:__wf_atom_ff2a5387(__wf_atom_104bfe98(soundGainMin, soundGainMax, v9:__wf_atom_9e368823()))
				end

				if not v25 and v27 then
					v8:Pause()
				end

				if v25 and v27 then
					v8:Resume()
				end
			end

			if not __wf_atom_7e8ad928(v10) then
				Effects.__wf_atom_91e2dccb(v10, (math.max(0, 1.5 * v39 - 0.5)))

				if not v25 and v27 then
					v10:SetVisibility(false, true)
				end

				if v25 and v27 then
					v10:SetVisibility(true, true)
				end
			end

			object:SetMaterialParam(v4, 1.25 - v24 * 0.25)
			v27 = false
			local v40

			if v39 > 0.01 then
				v40 = v28 + v39 * v31 / 5
			else
				v40 = v28 - v31 / 20
			end

			v28 = __wf_atom_421b01aa(v40, -1, 0)

			if math.abs(v29 - v28) > 0.05 and not __wf_atom_7e8ad928(v30) then
				v30:SetMaterialParam(v5, v28, 0, 0, 0, true)
				v29 = v28
			end

			local v41 = 0 + v2[2][2]:__wf_atom_9e368823() + v2[2][3]:__wf_atom_9e368823() + v2[2][4]:__wf_atom_9e368823() + v2[3][2]:__wf_atom_9e368823() + v2[3][4]:__wf_atom_9e368823() + v2[4][2]:__wf_atom_9e368823() + v2[4][3]:__wf_atom_9e368823() + v2[4][4]:__wf_atom_9e368823()
			local rainNearPlayer = __wf_atom_421b01aa(v2[3][3]:__wf_atom_9e368823() - (1 - v41 / 8), 0, 1)
			_T.RainNearPlayer = rainNearPlayer
			Effects.__wf_atom_e20e9e6f(object, v6, rainNearPlayer)
		end

		Sleep(0)
		v22 = v34
		v21 = v35
	end

	_T.RainNearPlayer = 0
end

function SetSkyDirection(object)
	Sleep(1)
	local all = gRegion:FindAll(__wf_atom_4d4372ee)
	local v7 = Vector()
	local __wf_atom_e800787c = object:__wf_atom_e800787c()
	local position = __wf_atom_e800787c:__wf_atom_cdbee85f():GetPosition()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while true do
		local __wf_atom_e800787c2 = __wf_atom_c4f78a8f:__wf_atom_e800787c()

		if
			not __wf_atom_7e8ad928(__wf_atom_e800787c2)
			and __wf_atom_e800787c2:__wf_atom_b600e356() == __wf_atom_e800787c
		then
			if useDirectionToZoneAtt then
				__wf_atom_c37ab6c1(v7, object:GetPosition(), position)
				Normalize(v7)
			else
				__wf_atom_c37ab6c1(v7, Vector(), object:__wf_atom_a06d543c())
			end

			for i = 1, #all do
				if __wf_atom_7e8ad928(all[i]) or not all[i]:__wf_atom_1d13ef4d() then
					continue
				end

				all[i]:__wf_atom_2ee34f0b(v7)
			end
		end

		Sleep(0)
	end
end

function AttachRain(_)
	gRegion:GetPlayerAvatar():cameraControl():SpawnWeatherEffect(weatherFxType)
end