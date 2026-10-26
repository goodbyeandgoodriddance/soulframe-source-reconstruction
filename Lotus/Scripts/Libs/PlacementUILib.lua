module(..., package.seeall)
local module = require("Lotus.Interface.LotusUtilities")
local v = Symbol("SandBoxInv")
local v2 = Color(181, 220, 80)
local desaturateColor = Color(196, 255, 196)
local v3 = WeakResource("/Lotus/Levels/ClanDojo/ClanDojoProcLevel")

local function fn()
	if _T.EnvRadiationGlowActive then
		local postProcess = gRegion:__wf_atom_8ad59546().postProcess
		postProcess.saturation = math.abs((math.sin(__wf_atom_4658d645(Time() * 0.1) * 3.141592653589793 * 2))) * 0.75 + 0.25
		postProcess.desaturateColor = desaturateColor
		postProcess.fogColor = v2
		postProcess.distanceFogDensity = 0.25
		postProcess.lightMapTint = v2
	end
end

local function fn2(object)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_1fa97530(5, v)
	__wf_atom_7470861b:__wf_atom_1fa97530(7, v)
	__wf_atom_7470861b:__wf_atom_1fa97530(3, v)
	__wf_atom_7470861b:__wf_atom_77b5f32e(v)
	__wf_atom_7470861b:__wf_atom_6cbcca8d(v, 26, 6, 0, 0)
end

function MakeAvatarInvincible(p)
	fn2(p)
end

function CameraToggleControl(p)
	if not (__wf_atom_7e8ad928(__wf_atom_8e4fda44) or __wf_atom_7e8ad928(p)) then
		local movie = __wf_atom_8e4fda44:FindMovie(p)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("ToggleControl", "")
		end
	end
end

function CreateFreeCam(mCameraInputFilter, mDefaultCamSpeed2, mMinCameraStartDistance, mIsDecoPlacement, mEnterFreeCameraSound, mExitFreeCameraSound, mCameraSequencerType)
	return {
		mCameraInputFilter = mCameraInputFilter,
		mDefaultCamSpeed = mDefaultCamSpeed2,
		mMinCameraStartDistance = mMinCameraStartDistance,
		mIsDecoPlacement = mIsDecoPlacement,
		mEnterFreeCameraSound = mEnterFreeCameraSound,
		mExitFreeCameraSound = mExitFreeCameraSound,
		mCameraSequencerType = mCameraSequencerType,
		mPlayer = nil,
		mOperatorSet = false,
		mControlsMovie = nil,
		mCameraAvatar = nil,
		mCameraSpot = nil,
		mIsApartment = false,
		mAfkTimer = 0,
		InitCamera = function(state, object, p, p2, p3, p4, p5)
			if state.mIsDecoPlacement then
				if not __wf_atom_7e8ad928(p2) then
					state.mCameraSpot = gRegion:CreateEntity(
						p2,
						object:__wf_atom_a2a18137() + Vector(0, 1.5, 0),
						__wf_atom_80368bb1
					)
					_T.PhotoBoothCameraSpot = state.mCameraSpot
				end
			elseif not __wf_atom_7e8ad928(p2) then
				state.mCameraSpot = gRegion:CreateEntity(p2, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				_T.PhotoBoothCameraSpot = state.mCameraSpot
			end

			local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

			if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
				_T.freeCamActive = __wf_atom_a96eb2aa:__wf_atom_ce4e872c()
				state.mPlayer = __wf_atom_a96eb2aa
			end

			state.mIsApartment = module.IsApartmentLevel()
			Sleep(0)

			if __wf_atom_7e8ad928(object) then
				return
			end

			local position = object:GetPosition()
			position.y += 2
			state.mCameraAvatar = gRegion:CreateEntity(p, position, object:__wf_atom_dc309f8a())

			if not __wf_atom_7e8ad928(state.mCameraAvatar) then
				state.mCameraAvatar:__wf_atom_4bf24e79()
				state.mCameraAvatar:SetVisibility(false)
				state.mCameraAvatar:SetFaction(Symbol("TENNO"))
				state.mCameraAvatar:__wf_atom_84dbc46b(0)
				state.mCameraAvatar:SetDisableGravity(true)
				state.mCameraAvatar:__wf_atom_30964595(false)
				state.mCameraAvatar:__wf_atom_e4df34a5(false)
				state.mCameraAvatar:__wf_atom_d342e870(false)
				fn2(state.mCameraAvatar)
				print("initialized photobooth camera avatar")
			end

			gRegion:__wf_atom_242f7e56(object)
			gRegion:__wf_atom_242f7e56(state.mCameraAvatar)

			if gRegion:IsMaster() then
				fn2(object)
				local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

				if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
					local __wf_atom_1915cc84 = __wf_atom_d2b2176d:__wf_atom_1915cc84()

					if not __wf_atom_7e8ad928(__wf_atom_1915cc84) then
						fn2(__wf_atom_1915cc84)
					end
				end
			end

			if not state.mIsDecoPlacement then
				if
					__wf_atom_7e8ad928(state.mControlsMovie)
					and not (__wf_atom_7e8ad928(__wf_atom_8e4fda44) or __wf_atom_7e8ad928(p3))
				then
					state.mControlsMovie = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(p3)
				end

				local all = gRegion:FindAll(__wf_atom_0f45538d)

				for i = 1, #all do
					if all[i]:__wf_atom_db682341() == Symbol("Arsenal") then
						all[i]:__wf_atom_438bf419(true)
						gGameRules:__wf_atom_b3a89a0d(all[i])
					elseif
						all[i]:__wf_atom_db682341() ~= Symbol("ConsoleActive")
						and not (all[i]:IsA(__wf_atom_585b23d8) or all[i]:IsA(__wf_atom_a4796624))
					then
						all[i]:__wf_atom_b87ba8f0(false, false)
					end
				end

				if gGameRules:IsA(__wf_atom_dd9a0bb8) then
					gGameRules:__wf_atom_f8d64ecf(true)
				end

				if not gRegion:IsMaster() then
					local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("Infested"))

					for i = 1, #__wf_atom_2226b35c do
						gRegion:__wf_atom_dd1e4d10(__wf_atom_2226b35c[i])
					end
				end

				if gRegion:IsMaster() then
					Sleep(0)
					local position2 = object:GetPosition()
					position2.y += 10
					gRegion:CreateEntity(p4, position2, __wf_atom_80368bb1, nil, nil)
					gRegion:CreateEntity(p5, position2, __wf_atom_80368bb1, nil, nil)
				end
			end
		end,
		ActivateFreeCam = function(self, object)
			_T.DisableMiniMap = true

			if self.mIsDecoPlacement then
				if not (__wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(gGameRules)) then
					local v4 = gGameRules:InDojo()
					local v5 = gGameRules:IsA(__wf_atom_311a7128) and gGameRules:IsApartmentLevel()
					local v6 = not __wf_atom_7e8ad928(gClient) and gGameRules:__wf_atom_09e81034()

					if v4 then
						local v7

						if __wf_atom_7e8ad928(_T.DojoMgr) or __wf_atom_7e8ad928(_T.DojoMgr.mJsonProcLevelHelper) then
							v7 = false
						else
							v7 = _T.DojoMgr.mJsonProcLevelHelper:__wf_atom_5175aea4():__wf_atom_1bb5b1ff() == v3
						end

						if v7 then
							__wf_atom_21342f4a:StartTimer(Symbol("DECO_TIME"), "OBSTACLE_COURSE")
						else
							__wf_atom_21342f4a:StartTimer(Symbol("DECO_TIME"), "DOJO")
						end
					elseif v5 then
						__wf_atom_21342f4a:StartTimer(Symbol("DECO_TIME"), "APARTMENT")
					elseif v6 then
						__wf_atom_21342f4a:StartTimer(Symbol("DECO_TIME"), "SHIP")
						_T.DecoratingPlayerShip = true
					end
				end
			else
				object:Attach(self.mCameraSequencerType, EMPTY_SYMBOL)
				object:__wf_atom_aeb02c14(self.mCameraInputFilter)
				object:__wf_atom_cf966a74((Resource("/EE/Types/Input/FreeCamInputFilter")))
			end

			_T.freeCamActive = true
			local __wf_atom_dd7246c7 = self.mPlayer:__wf_atom_dd7246c7()
			local mDefaultCamSpeed = self.mDefaultCamSpeed
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				local settings = __wf_atom_18a5d83b:Settings()

				if not __wf_atom_7e8ad928(settings) then
					if gGameRules:InDojo() then
						mDefaultCamSpeed = settings:__wf_atom_856527f3()
					else
						mDefaultCamSpeed = settings:__wf_atom_d5242987()
					end
				end
			end

			__wf_atom_dd7246c7:__wf_atom_7ea8df40(mDefaultCamSpeed)

			if
				not __wf_atom_7e8ad928(gGameRules)
				and gGameRules:IsA(__wf_atom_469b1d97)
				and not __wf_atom_7e8ad928(_T.TopMenuMovie)
			then
				_T.TopMenuMovie:Close()
			end

			_T.freeCamControlsVis = self.mPlayer:__wf_atom_7c72c90d()
			local cameraControl = object:CameraControl()

			if not (__wf_atom_7e8ad928(cameraControl) or __wf_atom_7e8ad928(self.mCameraSpot)) then
				cameraControl:SetCameraSpot(self.mCameraSpot, 0.01)
			end

			if object:__wf_atom_7b82e9e1(0) then
				local __wf_atom_301e8d97 = self.mPlayer:__wf_atom_301e8d97()

				if not __wf_atom_7e8ad928(__wf_atom_301e8d97) then
					local __wf_atom_398433a4 = __wf_atom_301e8d97:__wf_atom_398433a4()

					if not __wf_atom_7e8ad928(__wf_atom_398433a4) then
						__wf_atom_398433a4:SetVisible(false)
					end
				end
			end

			if not self.mIsDecoPlacement and not __wf_atom_7e8ad928(gGameRules) and gRegion:IsMaster() then
				gGameRules:__wf_atom_fb52d63c()
			end

			if not __wf_atom_7e8ad928(self.mCameraAvatar) then
				self.mCameraAvatar:__wf_atom_30964595(true)
				self.mCameraAvatar:__wf_atom_e4df34a5(true)
				self.mCameraAvatar:__wf_atom_d342e870(true)
			end

			object:PlaySound(self.mEnterFreeCameraSound, false, 1, false)

			if not __wf_atom_7e8ad928(self.mCameraAvatar) then
				local v4 = self.mCameraAvatar:__wf_atom_a2a18137() - object:__wf_atom_a2a18137()

				if Length(v4) > self.mMinCameraStartDistance then
					self.mCameraAvatar:Teleport(__wf_atom_dd7246c7:__wf_atom_a2a18137())
				end
			end

			object:__wf_atom_92aa9d91():__wf_atom_05549dae(Vector())

			if not self.mIsDecoPlacement then
				local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

				if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
					local __wf_atom_7b5ddf37 = __wf_atom_e55d02aa:__wf_atom_7b5ddf37()

					if not __wf_atom_7e8ad928(__wf_atom_7b5ddf37) then
						local movie = __wf_atom_8e4fda44:FindMovie(__wf_atom_7b5ddf37)

						if not __wf_atom_7e8ad928(movie) then
							movie:Close()
						end
					end
				end
			end
		end,
		DeactivateFreeCam = function(self, object)
			_T.DisableMiniMap = false
			local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(self.mCameraSequencerType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end

			object:__wf_atom_cf966a74(self.mCameraInputFilter)

			if self.mIsDecoPlacement then
				self.mPlayer:__wf_atom_845b1231(false)
				self.mPlayer:__wf_atom_f78d9598(false)

				if self.mPlayer:__wf_atom_ce4e872c() then
					self.mPlayer:ToggleFreeCamera()
				end
			end

			_T.freeCamActive = false
			local cameraControl = object:CameraControl()

			if not __wf_atom_7e8ad928(cameraControl) then
				cameraControl:SetCameraSpot(nil, 0)
			end

			if not (self.mIsDecoPlacement or __wf_atom_7e8ad928(gGameRules)) then
				gGameRules:__wf_atom_9141808b()
			end

			if not __wf_atom_7e8ad928(self.mCameraAvatar) then
				self.mCameraAvatar:__wf_atom_30964595(false)
				self.mCameraAvatar:__wf_atom_e4df34a5(false)
				self.mCameraAvatar:__wf_atom_d342e870(false)

				if self.mIsDecoPlacement then
					self.mCameraAvatar:Destroy()
					self.mCameraAvatar = nil
				end
			end

			if object:__wf_atom_7b82e9e1(0) then
				local __wf_atom_301e8d97 = self.mPlayer:__wf_atom_301e8d97()

				if not __wf_atom_7e8ad928(__wf_atom_301e8d97) then
					local __wf_atom_398433a4 = __wf_atom_301e8d97:__wf_atom_398433a4()

					if not __wf_atom_7e8ad928(__wf_atom_398433a4) then
						__wf_atom_398433a4:SetVisible(true)
					end
				end
			end

			object:PlaySound(self.mExitFreeCameraSound, false, 1, false)

			if not (__wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(gGameRules)) then
				local v4 = gGameRules:InDojo()
				local v5 = gGameRules:IsA(__wf_atom_311a7128) and gGameRules:IsApartmentLevel()
				local v6 = not __wf_atom_7e8ad928(gClient) and gGameRules:__wf_atom_09e81034()

				if v4 then
					local v7

					if __wf_atom_7e8ad928(_T.DojoMgr) or __wf_atom_7e8ad928(_T.DojoMgr.mJsonProcLevelHelper) then
						v7 = false
					else
						v7 = _T.DojoMgr.mJsonProcLevelHelper:__wf_atom_5175aea4():__wf_atom_1bb5b1ff() == v3
					end

					if v7 then
						__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("DECO_TIME"), "OBSTACLE_COURSE")
					else
						__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("DECO_TIME"), "DOJO")
					end
				elseif v5 then
					__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("DECO_TIME"), "APARTMENT")
				elseif v6 then
					__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("DECO_TIME"), "SHIP")
					_T.DecoratingPlayerShip = false
				end
			end
		end,
		OnUpdate = function(self)
			fn()

			if not __wf_atom_7e8ad928(self.mPlayer) then
				self.mAfkTimer += __wf_atom_fa1258d0()

				if self.mAfkTimer > 30 then
					self.mAfkTimer = 0
					self.mPlayer:__wf_atom_98782515()
				end

				local __wf_atom_50a7d83e = self.mPlayer:__wf_atom_50a7d83e()

				if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					return
				end

				if
					self.mIsApartment
					and not __wf_atom_7e8ad928(self.mCameraAvatar)
					and module.GetShipDecoRoom(self.mCameraAvatar) == module.OUTSIDE_THE_SHIP_ROOM.Name
				then
					if self.mIsDecoPlacement then
						local __wf_atom_be6b2a2f = __wf_atom_50a7d83e:__wf_atom_a1b79f95():__wf_atom_be6b2a2f()

						if
							not __wf_atom_7e8ad928(__wf_atom_be6b2a2f)
							and __wf_atom_be6b2a2f:IsA(__wf_atom_0097d4df)
						then
							__wf_atom_be6b2a2f:__wf_atom_8337f821()
							return
						end
					elseif self.mPlayer:__wf_atom_ce4e872c() then
						self.mPlayer:ToggleFreeCamera()
						self.mPlayer:__wf_atom_9efbf072(false)
					end
				end

				if
					not self.mIsInDojo
					and not self.mOperatorSet
					and __wf_atom_50a7d83e == self.mPlayer:__wf_atom_04b7536b()
				then
					__wf_atom_50a7d83e:__wf_atom_aeb02c14(self.mAvatarInputFilter)
					gRegion:__wf_atom_242f7e56(__wf_atom_50a7d83e)
					self.mOperatorSet = true
				end

				if not __wf_atom_7e8ad928(_T.freeCamActive) then
					if _T.freeCamActive then
						if self.mPlayer:__wf_atom_ce4e872c() then
							_T.freeCamControlsVis = self.mPlayer:__wf_atom_7c72c90d()
							local __wf_atom_dd7246c7 = self.mPlayer:__wf_atom_dd7246c7()

							if not (__wf_atom_7e8ad928(self.mCameraAvatar) or _T.playingCamera) then
								if __wf_atom_7e8ad928(_T.editingCameraPos) then
									local __wf_atom_fd63c7a5 = __wf_atom_dd7246c7:__wf_atom_fd63c7a5()

									if
										__wf_atom_fd63c7a5.x ~= 0
										or __wf_atom_fd63c7a5.y ~= 0
										or __wf_atom_fd63c7a5.z ~= 0
									then
										local position = self.mCameraAvatar:GetPosition()
										local v4 = Vector(
											__wf_atom_fd63c7a5.x,
											__wf_atom_fd63c7a5.y,
											__wf_atom_fd63c7a5.z
										)
										Normalize(v4)
										local v5 = position + v4 * 0.3
										local v6 = position + __wf_atom_fd63c7a5 * __wf_atom_dd7246c7:__wf_atom_08a1b45c()

										if __wf_atom_a93b9922(position, v6) > __wf_atom_a93b9922(position, v5) then
											v5 = v6
										end

										local v7 = { __wf_atom_7b01f9ce, self.mCameraAvatar:__wf_atom_1bb5b1ff() }
										local v8 = Vector()

										if not gRegion:__wf_atom_f54ffdb8(position, v5, v7, {}, true, nil, v8) then
											self.mCameraAvatar:MotionControl():Move(v6)
										end
									end

									__wf_atom_dd7246c7:SetPosition(self.mCameraAvatar:GetPosition())
								else
									self.mCameraAvatar:Teleport(__wf_atom_dd7246c7:__wf_atom_a2a18137())
									_T.editingCameraPos = _T.editingCameraPos - 1

									if _T.editingCameraPos <= 0 then
										_T.editingCameraPos = nil
									end
								end
							end
						else
							self:DeactivateFreeCam(__wf_atom_50a7d83e)

							if not __wf_atom_7e8ad928(_T.detachCamera) then
								gRegion:__wf_atom_c4f78a8f():ControlCamera(not _T.detachCamera)
							end

							if not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_469b1d97) then
								_T.editingCameraPos = nil
								_T.cancelCameraEdit = true
							end
						end
					else
						if self.mPlayer:__wf_atom_ce4e872c() then
							self:ActivateFreeCam(__wf_atom_50a7d83e)
							return
						end

						local __wf_atom_dd7246c7 = self.mPlayer:__wf_atom_dd7246c7()

						if not (__wf_atom_7e8ad928(self.mCameraAvatar) or __wf_atom_7e8ad928(__wf_atom_dd7246c7) or _T.playingCamera) then
							self.mCameraAvatar:MotionControl():Move(__wf_atom_dd7246c7:__wf_atom_a2a18137())
						end
					end
				end
			end
		end
	}
end