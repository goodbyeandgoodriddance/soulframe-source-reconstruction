require("SF.Scripts.Libs.StatsLib")
local module = require("EE.Interface.Utilities")
local v = Symbol()
local v2 = nil
local v3 = nil
local grainBias = 0
Symbol("WishingWellChestSpawn")
Symbol("WishingWellChestCamera")

local function fn()
	if v2 == v3 then
		local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
		local postProcess = __wf_atom_8ad59546.postProcess
		local v4 = 0.5

		while v4 > 0 do
			v4 -= __wf_atom_084b3e93()
			local v5 = 1 - v4 / 0.5
			postProcess.grainBias = __wf_atom_104bfe98(0.05, 0, v5)
			__wf_atom_8ad59546:__wf_atom_47f0b80b((1 - v5) * (1 / 3))
			Sleep(0)

			if not __wf_atom_7e8ad928(transitionOutSound) then
				module.PlaySound(transitionOutSound)
			end
		end

		postProcess.grainBias = grainBias
		__wf_atom_8ad59546:__wf_atom_47f0b80b(0)
	end
end

local function fn2()
	if v2 == v3 then
		local v4 = 0.5
		local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
		local postProcess = __wf_atom_8ad59546.postProcess
		grainBias = postProcess.grainBias

		while v4 > 0 do
			local _ = 1 - (v4 / 0.5) ^ 2

			if v4 < 0.3 then
				local v5 = 1 - v4 / 0.3
				postProcess.grainBias = __wf_atom_104bfe98(0, 0.05, v5)

				if not __wf_atom_7e8ad928(transitionInSound) then
					module.PlaySound(transitionInSound)
				end
			end

			Sleep(0)
			v4 -= __wf_atom_084b3e93()
		end

		__wf_atom_8ad59546:__wf_atom_47f0b80b(0)
	end
end

function StartCameraMagicWell(object, object2)
	local v4 = nil
	local v5 = nil
	local v6 = nil
	local flag = false
	local flag2 = false
	v2 = gRegion:__wf_atom_c4f78a8f()
	v = Symbol("NV_" .. tostring(object:__wf_atom_db682341()))
	v3 = object2

	if #_T.WishingWells == 0 then
		_T.WishingWells = {}
		_T.WishingWellChests = {}
		_T.WishingWellCameras = {}
		flag = true
	else
		for i = 1, #_T.WishingWells do
			if _T.WishingWells[i] == object then
				if __wf_atom_7e8ad928(_T.WishingWellChests[i]) then
					flag2 = true
				else
					local __wf_atom_bb3e7833 = _T.WishingWellChests[i]:__wf_atom_bb3e7833(__wf_atom_0f45538d)

					if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						flag2 = true
					elseif not __wf_atom_bb3e7833:IsEnabled() then
						flag2 = true
					end
				end
			else
				flag = true
			end

			if not flag2 then
				continue
			end

			if not __wf_atom_7e8ad928(_T.WishingWells[i]) then
				table.remove(_T.WishingWells, i)
			end

			if not __wf_atom_7e8ad928(_T.WishingWellChests[i]) then
				table.remove(_T.WishingWellChests, i)
			end

			if not __wf_atom_7e8ad928(_T.WishingWellCameras[i]) then
				table.remove(_T.WishingWellCameras, i)
			end

			flag = true
		end
	end

	if flag then
		table.insert(_T.WishingWells, object)
		local position = object:GetPosition()

		if gRegion:IsMaster() then
			local all = gRegion:FindAll(chestWaypointType, position, rangeMin, rangeMax)

			if #all > 0 then
				local v7 = __wf_atom_5784a397(1, #all)

				if v7 > 0 then
					v4 = all[v7]
				end
			end
		end

		if gRegion:IsMaster() then
			v5 = gRegion:CreateEntity(chestType, v4:GetPosition(), v4:__wf_atom_dc309f8a(), object)
		else
			local total = 0

			repeat
				local all = gRegion:FindAll(chestType, position, rangeMin, rangeMax)

				if #all == 1 then
					v5 = all[1]
				else
					for i = 1, #all do
						if all[i]:GetCreator() == object then
							v5 = all[i]
						end
					end

					Sleep(0.1)
					total += 0.1
				end
			until not __wf_atom_7e8ad928(v5) or total >= 10
		end

		if __wf_atom_7e8ad928(v5) then
			for i = 1, #_T.WishingWells do
				if _T.WishingWells[i] ~= object then
					continue
				end

				table.remove(_T.WishingWells, i)
				break
			end

			print("Wishing Well: No chest was selected")
			fn()

			if v2 == v3 then
				local cameraControl = v3:CameraControl()
				cameraControl:__wf_atom_fd14c463(0)
				cameraControl:SetCameraSpot(nil, 0)
			end

			v3:__wf_atom_cf966a74(noMovementInputFilter)

			if not __wf_atom_7e8ad928(object) then
				object:FirePort("Enable")
			end

			return
		else
			table.insert(_T.WishingWellChests, v5)
			v6 = gRegion:__wf_atom_e2db08ce(chestCameraType, v5:GetPosition())
			table.insert(_T.WishingWellCameras, v6)
		end
	else
		local v7 = nil

		if #_T.WishingWells > 0 then
			for i = 1, #_T.WishingWells do
				if _T.WishingWells[i] ~= object then
					continue
				end

				v7 = i
				break
			end

			v5 = _T.WishingWellChests[v7]
			v6 = _T.WishingWellCameras[v7]
		else
			print("Can't start Wishing Well script: not finding any whishing well!")
		end
	end

	if flag then
		if not __wf_atom_7e8ad928(splashFx) then
			splashFx:FirePort("Burst")
		end

		if not __wf_atom_7e8ad928(introAnim) then
			object2:__wf_atom_921c1a5f(introAnim, true, 3, 1, false)
		end
	end

	if v3 ~= v2 then
		return
	end

	if _T.WishingWellCameraActive then
		print("Can't start Wishing Well dcamera script: script already running on a different ScriptTrigger!")
		return
	end

	_T.WishingWellCameraActive = true
	v3:__wf_atom_aeb02c14(noMovementInputFilter)
	local cameraControl = v3:CameraControl()
	local __wf_atom_1b3db7e0 = cameraControl:__wf_atom_1b3db7e0()
	fn2()
	cameraControl:__wf_atom_fd14c463(0)
	cameraControl:SetCameraSpot(v6)

	if not __wf_atom_7e8ad928(v5) then
		v5:Attach(chestHighlightEffectType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	Sleep(cameraTime)

	if not __wf_atom_7e8ad928(cameraControl) then
		cameraControl:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
	end

	if v2 == v3 then
		local cameraControl2 = v3:CameraControl()
		cameraControl2:__wf_atom_fd14c463(0)
		cameraControl2:SetCameraSpot(nil, 0)
	end

	fn()
	v3:__wf_atom_cf966a74(noMovementInputFilter)
	Sleep(0)
	_T.WishingWellCameraActive = false

	if not __wf_atom_7e8ad928(object) then
		object:FirePort("Enable")
	end
end