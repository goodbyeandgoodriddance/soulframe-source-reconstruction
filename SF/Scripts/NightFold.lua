Resource("/EE/Types/Input/FreeCamInputFilter")
local v = Resource("/SF/Types/Player/NightFoldInputFilter")
local module = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("EE.Interface.Utilities")
local module4 = require("SF.Scripts.NightFoldLib")
local module5 = require("SF.Scripts.Libs.StatsLib")
local module6 = require("SF.Interface.SFUtilities")
local module7 = require("SF.Scripts.Libs.PlayerPetLib")
local v2 = nil
local v3 = nil

function EmptyCallback() end

function OnSyncInventoryFromDbCallback()
	if not __wf_atom_7e8ad928(_G.NightfoldInventoryUpdateFinished) then
		_G.NightfoldInventoryUpdateFinished = true
	end
end

function OnInventoryCommitCallback()
	if not __wf_atom_7e8ad928(gGameData) then
		gGameData:SyncInventoryFromDB("OnSyncInventoryFromDbCallback")
	end

	if not _T.ProgressionScreenDisabled then
		if __wf_atom_7e8ad928(gGameRules) then
			return
		end

		local __wf_atom_9d991d71 = gGameRules:__wf_atom_9d991d71()

		if Engine.__wf_atom_db2b0cee(__wf_atom_9d991d71.mLastClearedDate) < -900 then
			module6.ShowProgressionScreen(true)
			_T.QueueClearProgressionScreen = true
		end
	end
end

function NightfoldEvaluate(object, p)
	if __wf_atom_7e8ad928(object) or object:__wf_atom_08998754() == 4 then
		return false
	end

	if
		object:__wf_atom_47fbd15c()
		or object:__wf_atom_58dabbc7() and not object:__wf_atom_737fd2c9(9)
		or object:__wf_atom_7b82e9e1(4)
	then
		return false
	end

	if object:IsKilled() or object:__wf_atom_b1bb7035() or module2.IsStreamingLevel() then
		return false
	end

	if module4.IsNightfoldBlocked(not p) then
		if not __wf_atom_7e8ad928(_T.PreventNightfoldUsageReason) and _T.PreventNightfoldUsageReason > 0 then
			local preventNightfoldUsageReason = module4.GetPreventNightfoldUsageReason()

			if not __wf_atom_7e8ad928(preventNightfoldUsageReason) then
				_T.ShowImpactMessage(preventNightfoldUsageReason, 5)
			end
		end

		return false
	else
		if _T.VendorRevealInProgress and not p then
			return false
		end

		if p and module2.PlayerIsInBattle(object) then
			_T.ShowImpactMessage("/SF/Language/SystemMessages/NightfoldDisabledCombat", 5)
			return false
		else
			return true
		end
	end
end

local function fn(position)
	if not gRegion:Raycast(position + Vector(0, 1, 0), position + Vector(0, -3, 0), nil, nil, Vector()) then
		position = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(position, 30, 50)
	end

	return position
end

function ClearNightFoldFX(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not (object:__wf_atom_799d95f5(true) or __wf_atom_e919fb8e.nightfoldTransition) then
		return
	end

	local __wf_atom_92aa9d91 = object:__wf_atom_92aa9d91()
	__wf_atom_92aa9d91:__wf_atom_17c1c30f()
	__wf_atom_92aa9d91:__wf_atom_8595f516()
	object:__wf_atom_51075230(_T.mWorldView)

	if object:__wf_atom_631bafa1() then
		module4.ToggleSky(true)
	end

	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	postProcess.horizonDOF = 0.5
	postProcess:__wf_atom_eba78d3d(1)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(startFx)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(fadeFx)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
		__wf_atom_bb3e7833_2:Destroy()
	end

	object:CameraControl():__wf_atom_25382a0d(1)
	object:CameraControl():__wf_atom_928a45c5(colorCorrection)
end

function _ToggleCombatOnAvatar(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local isA = gGameRules:IsA(__wf_atom_e714d8ac)

	if p and isA then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()

		for _, v4 in ipairs(__wf_atom_36b4a6e5) do
			v4:SetEnabled(p)
		end

		__wf_atom_e55d02aa:__wf_atom_c31a704b(p, p)
	end

	if p then
		__wf_atom_d2b2176d:EnableWeaponFiring(true)
	else
		__wf_atom_d2b2176d:EnableWeaponFiring(false)
	end
end

function NightfoldActivateRMI(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if p then
		if not __wf_atom_7e8ad928(replicatedStartFx) then
			object:Attach(replicatedStartFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end

		object:__wf_atom_9b5dcd3b(startNightFoldTransitionAnimation, false, 3, 3)
	else
		if not __wf_atom_7e8ad928(replicatedEndFx) then
			object:Attach(replicatedEndFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end

		object:__wf_atom_9b5dcd3b(endNightFoldTransitionAnimation, false, 1, 1)
	end
end

local function fn2()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and __wf_atom_c4f78a8f:__wf_atom_799d95f5()
		and not __wf_atom_7e8ad928(__wf_atom_18a5d83b)
	then
		__wf_atom_18a5d83b:GetStatsFromServer(__wf_atom_18a5d83b:__wf_atom_e75653c3(), false, "")
	end
end

function OnInNightfoldChanged(object, p)
	print("OnInNightfoldChanged", p, object:__wf_atom_5b41f63b())

	if __wf_atom_7e8ad928(object) then
		return
	end

	if p then
		if gRegion:IsMaster() and not object:__wf_atom_4417a5d4() then
			RemovePlayerPet(object, p)
			object:__wf_atom_8a035cd5(Symbol("InNightfoldLoop"), false)
		end
	elseif object:__wf_atom_4417a5d4() then
		RemovePlayerPet(object, p)
	end

	if not object:__wf_atom_4417a5d4() then
		object:SetDisableGravity(p)
	end

	if p then
		fn2()
	end
end

function RemovePlayerPet(object, p)
	print("Nightfold: Calling RemovePlayerPet for avatar:")
	print(object)

	if __wf_atom_7e8ad928((object:__wf_atom_a96eb2aa())) then
		return
	end

	local oldWolfAvatar = p and object:__wf_atom_e919fb8e().OldWolfAvatar
		or object:__wf_atom_d2b2176d():__wf_atom_b725e497()

	if not __wf_atom_7e8ad928(oldWolfAvatar) then
		gRegion:__wf_atom_dd1e4d10(oldWolfAvatar)
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.OldWolfAvatar = nil
	_T.NightFoldPupCreated = nil
end

function PlayCancellableTransition(object, p, p2, p3)
	if _T.SkipNightfoldTransition == true then
		return true
	end

	local v4 = not object:__wf_atom_92aa9d91():__wf_atom_722edb11()
	local v5 = nil
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local v6 = false
	local total = 0
	local v7

	if not __wf_atom_7e8ad928(startFxNightFold) then
		v7 = object:Attach(p2, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	if object:IsKilled() then
		print("Cancelled nightfold envoy dead")
		object:__wf_atom_54e4f4e5()
		__wf_atom_e919fb8e.nightfoldTransition = nil
		return false
	else
		local __wf_atom_722edb11 = object:__wf_atom_92aa9d91():__wf_atom_722edb11()
		local __wf_atom_86618c58 = object:__wf_atom_92aa9d91():__wf_atom_86618c58()
		local v8 = false

		while (v4 or __wf_atom_722edb11 or __wf_atom_86618c58 >= 1) and (not v6 or object:__wf_atom_737fd2c9(9)) do
			if not v6 and animationStartDelay < total and (__wf_atom_722edb11 or v4) then
				v6 = true
				object:__wf_atom_ce79ef9d(9)
				object:__wf_atom_78ad8b9f(65, 0)

				if not __wf_atom_7e8ad928(fadeFx) then
					v5 = object:Attach(p, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				end
			end

			Sleep(0)
			total += __wf_atom_084b3e93()

			if object:IsKilled() then
				print("Cancelled nightfold envoy dead")
				object:__wf_atom_54e4f4e5()
				__wf_atom_e919fb8e.nightfoldTransition = nil
				return false
			else
				__wf_atom_722edb11 = object:__wf_atom_92aa9d91():__wf_atom_722edb11()
				__wf_atom_86618c58 = object:__wf_atom_92aa9d91():__wf_atom_86618c58()

				if __wf_atom_86618c58 >= 1 and not v8 then
					if not __wf_atom_7e8ad928(actionHoldCompleteSound) then
						module3.PlaySound(actionHoldCompleteSound)
					end

					v8 = true

					if p3 then
						object:__wf_atom_63453419(p3)
						SendHubMessage(p3)
					end
				end
			end
		end

		if v4 or __wf_atom_722edb11 or not (__wf_atom_86618c58 < 1) then
			if not (v8 or __wf_atom_7e8ad928(actionHoldCompleteSound)) then
				module3.PlaySound(actionHoldCompleteSound)
				object:__wf_atom_63453419(p3)
				SendHubMessage(p3)
			end

			while object:__wf_atom_737fd2c9(9) do
				Sleep(0)
			end

			return true
		else
			print(
				"Cancelled nightfold because button let up early",
				v4,
				__wf_atom_722edb11,
				__wf_atom_86618c58,
				object:__wf_atom_737fd2c9(9)
			)

			if not (__wf_atom_7e8ad928(startFx) or __wf_atom_7e8ad928(v7)) then
				v7:Destroy()
			end

			object:__wf_atom_54e4f4e5()
			object:__wf_atom_78ad8b9f(65, 1)
			object:__wf_atom_cf966a74(nightfoldTransitionInputFilter)
			__wf_atom_e919fb8e.nightfoldTransition = nil

			if __wf_atom_7e8ad928(fadeFx) or __wf_atom_7e8ad928(v5) then
				return false
			end

			v5:Destroy()
			Sleep(0)
			object:CameraControl():__wf_atom_25382a0d(1)
			object:CameraControl():__wf_atom_928a45c5(colorCorrection)
			module2.Fade(false, 0.4, 1, true)
			return false
		end
	end
end

local function fn3() -- 1 equivalent call inferred from this helper
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PlayerPetSpawn"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("Execute")
	end
end

function NightfoldActivate(object, p)
	if __wf_atom_7e8ad928(object:CameraControl()) then
		return
	end

	local v4 = not p
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.nightfoldTransition = true
	object:__wf_atom_aeb02c14(nightfoldTransitionInputFilter)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		__wf_atom_d2b2176d:__wf_atom_d5651846()
		__wf_atom_d2b2176d:Unequip(0, 2)
	end

	local __wf_atom_92aa9d91 = object:__wf_atom_92aa9d91()
	__wf_atom_92aa9d91:__wf_atom_17c1c30f()
	__wf_atom_92aa9d91:__wf_atom_8595f516()

	if v4 then
		print("Entering the nightfold")
		module6.CloseProgressionScreen(true)

		if object:__wf_atom_631bafa1() then
			module6.BlockFastTravel(true)
		end

		_T.mWorldPosition = fn(object:GetPosition())
		_T.mWorldView = object:__wf_atom_0e1e5bc9()
		_T.mHadForcedWalk = object:MotionControl():__wf_atom_e384400a()
		_T.mCanJump = __wf_atom_92aa9d91:__wf_atom_ccce2e8d()
		_T.mWorldFOV = object:CameraControl():__wf_atom_31f8207e()
		_T.mCanDodge = object:__wf_atom_fc69677c()
		object:__wf_atom_43b67ec1(_T.mWorldPosition, object:MotionControl():__wf_atom_282af4d6())
		object:__wf_atom_915c8b10(_T.mWorldPosition)
		local v5 = gRegion:IsMaster() and 3 or 4

		if not __wf_atom_7e8ad928(enterSoundLocal) then
			v2 = module3.PlaySound(enterSoundLocal)
		end

		if PlayCancellableTransition(object, fadeFx, startFxNightFold, true) then
			if module2.IsStreamingLevel() then
				print("Cancelled entering the nightfold due to streaming")
				object:__wf_atom_9b5dcd3b(endNightFoldTransitionAnimation, true, 3, 1)
				object:__wf_atom_cf966a74(nightfoldTransitionInputFilter)
				__wf_atom_e919fb8e.nightfoldTransition = nil

				if object:__wf_atom_631bafa1() then
					module6.BlockFastTravel(false)
				end

				return false
			elseif object:IsKilled() then
				print("Cancelled entering the nightfold due to death")
				__wf_atom_e919fb8e.nightfoldTransition = nil

				if object:__wf_atom_631bafa1() then
					module6.BlockFastTravel(false)
				end

				return false
			elseif __wf_atom_7e8ad928(object:__wf_atom_a96eb2aa()) then
				print("Cancelled entering the nightfold due to null player")
				__wf_atom_e919fb8e.nightfoldTransition = nil

				if object:__wf_atom_631bafa1() then
					module6.BlockFastTravel(false)
				end

				return false
			else
				if not __wf_atom_7e8ad928(_T.NightfoldGhostAvatar) then
					gRegion:__wf_atom_dd1e4d10(_T.NightfoldGhostAvatar)
				end

				local entity = gRegion:CreateEntity(
					mapProxyAvatarType,
					object:GetPosition() + Vector(0, 0.1, 0),
					_T.mWorldView,
					nil,
					nil,
					v5
				)

				if not __wf_atom_7e8ad928(entity) then
					_T.NightfoldGhostAvatar = entity
					object:__wf_atom_a96eb2aa():__wf_atom_cca6e0bc():__wf_atom_865e86de(entity)
				end

				module7.SetPetResting(object:__wf_atom_a96eb2aa(), true)

				if object:__wf_atom_631bafa1() then
					if object:__wf_atom_4ec961d6() then
						object:__wf_atom_1c72afa0(_T.mWorldPosition)
					end

					_G.NightfoldInventoryUpdateFinished = false
					gGameRules:CommitInventoryCheckpointToDB(0, 0, 0, "OnInventoryCommitCallback")
				end

				if not __wf_atom_7e8ad928(_T.InterruptEnteringNightFoldFunction) then
					_T.InterruptEnteringNightFoldFunction()
				end

				InitalizeVendorStations()

				if not __wf_atom_7e8ad928(_T.InterruptEnteringNightFoldFunction) then
					_T.InterruptEnteringNightFoldFunction = nil
				end

				local mNightFoldPosition = _T.mNightFoldPosition
				local mNightFoldView = _T.mNightFoldView

				if mNightFoldPosition == nil or mNightFoldView == nil then
					local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TentTestWp"))

					if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
						print("Couldn't find tent waypoint")
						__wf_atom_e919fb8e.nightfoldTransition = nil

						if object:__wf_atom_631bafa1() then
							module6.BlockFastTravel(false)
						end

						return false
					else
						mNightFoldPosition = __wf_atom_0a6a5887:GetPosition()
						mNightFoldView = __wf_atom_0a6a5887:__wf_atom_dc309f8a()
					end
				elseif _T.ForceCharacterScreen then
					local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ArsenalWp"))

					if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
						print("Couldn't find arsenal waypoint")
						__wf_atom_e919fb8e.nightfoldTransition = nil

						if object:__wf_atom_631bafa1() then
							module6.BlockFastTravel(false)
						end

						return false
					else
						mNightFoldPosition = __wf_atom_0a6a5887:GetPosition()
						mNightFoldView = __wf_atom_0a6a5887:__wf_atom_dc309f8a()
					end
				else
					local v6 = mNightFoldPosition + Vector(0, 0.01, 0)
					local v7 = v6 + __wf_atom_e97f3142(mNightFoldView) * -0.01
					local v8 = Vector()
					local v9 = Vector()
					local __wf_atom_df3098a0 = gRegion:__wf_atom_df3098a0(
						object,
						v6,
						v7,
						{ entity, object },
						nil,
						v8,
						v9
					)

					if not __wf_atom_7e8ad928(__wf_atom_df3098a0) then
						mNightFoldPosition.y += 0.5
						v6.y += 0.5
						v7.y += 0.5
						__wf_atom_df3098a0 = gRegion:__wf_atom_df3098a0(object, v6, v7, { entity, object }, nil, v8, v9)
					end

					if not __wf_atom_7e8ad928(__wf_atom_df3098a0) then
						print("Teleport to NF might be stuck on: " .. __wf_atom_df3098a0:__wf_atom_5b41f63b() .. " moving to WP")
						local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TentTestWp"))

						if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
							print("Couldn't find tent waypoint when attempting to move to unstuck position")
							__wf_atom_e919fb8e.nightfoldTransition = nil

							if object:__wf_atom_631bafa1() then
								module6.BlockFastTravel(false)
							end

							return false
						else
							mNightFoldPosition = __wf_atom_0a6a5887:GetPosition()
							mNightFoldView = __wf_atom_0a6a5887:__wf_atom_dc309f8a()
						end
					end
				end

				object:Teleport(mNightFoldPosition, mNightFoldView)
				object:__wf_atom_51075230(mNightFoldView)

				if object:__wf_atom_631bafa1() then
					module4.ToggleSky(false)
				end

				local postProcess = gRegion:__wf_atom_8ad59546().postProcess
				postProcess.horizonDOF = 0
				postProcess:__wf_atom_eba78d3d(0)
				gRegion:GetGameCamera():EnableMotionBlur(false)
				Sleep(0)
				gRegion:GetGameCamera():EnableMotionBlur(true)

				if not __wf_atom_7e8ad928(endFxNightFold) then
					object:Attach(endFxNightFold, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				end

				if not _T.SkipNightfoldTransition then
					object:__wf_atom_9b5dcd3b(endNightFoldTransitionAnimation, false, 3, 1)
					Sleep(0)

					while object:__wf_atom_c138b19b(endNightFoldTransitionAnimation) do
						object:Teleport(mNightFoldPosition, mNightFoldView)
						Sleep(0)
					end
				end

				object:__wf_atom_fb9d7578(true)
				object:__wf_atom_972e5bcd()
				object:MotionControl():__wf_atom_99fc7a82(true)
				__wf_atom_92aa9d91:__wf_atom_9f4f79f7(false)
				object:__wf_atom_f747bba3(false)
				object:__wf_atom_cf966a74(nightfoldTransitionInputFilter)
				object:__wf_atom_aeb02c14(v)

				if object:__wf_atom_631bafa1() then
					module6.BlockFastTravel(false)
				end

				_ToggleCombatOnAvatar(object, false)

				if _T.ForceCharacterScreen then
					local entity2 = module3.GetEntityFromTag("NightfoldArsenal")

					if not __wf_atom_7e8ad928(entity2) then
						object:__wf_atom_3e5bf6ab(entity2)
					end
				end

				_T.ForceCharacterScreen = nil

				for k, v6 in pairs(module5.mAncestorsRevealable) do
					if v6 then
						module5.ReplicateLogEvent("ANCESTOR", "EnterNightfold", k, nil, nil, "EnterNightfold")
					end
				end

				module5.LogEnterNightfold()
				module2.SetImmunity(object, true)
				_T.LocalPlayerInNightFold = true
				fn3() -- inferred equivalent call
				object:__wf_atom_92aa9d91():__wf_atom_fb9d7578()

				if gRegion:IsMaster() then
					object:__wf_atom_8a035cd5(Symbol("InNightfoldLoop"), false)
				end

				if gGameRules:IsA(__wf_atom_e714d8ac) then
					gGameRules:__wf_atom_da2edbc4(true)
				end

				print("Enter nightfold completed")

				if object:__wf_atom_631bafa1() then
					object:__wf_atom_8a035cd5(Symbol("ListenForCinematicOutsideNightfold"), false)
				end
			end
		else
			if not __wf_atom_7e8ad928(v2) then
				v2:Stop(false)
				v2 = nil
			end

			if object:__wf_atom_631bafa1() then
				module6.BlockFastTravel(false)
			end

			__wf_atom_e919fb8e.nightfoldTransition = nil
			return false
		end
	else
		print("Exiting nightfold")
		object:__wf_atom_84dbc46b(0)
		_T.mNightFoldPosition = fn(object:GetPosition())
		_T.mNightFoldView = object:__wf_atom_0e1e5bc9()

		if not __wf_atom_7e8ad928(exitSoundLocal) then
			v3 = module3.PlaySound(exitSoundLocal)
		end

		if PlayCancellableTransition(object, fadeFx, startFxNightFold, false) then
			if gGameRules:IsA(__wf_atom_e714d8ac) then
				gGameRules:__wf_atom_da2edbc4(false)
			end

			if _T.QueueClearProgressionScreen then
				gGameRules:__wf_atom_9b1915ae()
				_T.QueueClearProgressionScreen = nil
			end

			local __wf_atom_4c2e0189 = object:__wf_atom_4c2e0189()
			object:__wf_atom_915c8b10(__wf_atom_4c2e0189)
			local mWorldView = _T.mWorldView
			object:Teleport(__wf_atom_4c2e0189, mWorldView)
			module7.SetPetResting(object:__wf_atom_a96eb2aa(), true)
			SendHubMessage(v4)

			if not __wf_atom_7e8ad928(_T.InterruptNightFoldFunction) then
				_T.InterruptNightFoldFunction()
			end

			object:__wf_atom_51075230(_T.mWorldView)

			if object:__wf_atom_631bafa1() then
				module4.ToggleSky(true)
			end

			local postProcess = gRegion:__wf_atom_8ad59546().postProcess
			postProcess.horizonDOF = 0.5
			postProcess:__wf_atom_eba78d3d(1)
			gRegion:GetGameCamera():EnableMotionBlur(false)
			Sleep(0)
			gRegion:GetGameCamera():EnableMotionBlur(true)

			if not __wf_atom_7e8ad928(endFx) then
				object:Attach(endFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end

			if not __wf_atom_7e8ad928(_T.InterruptNightFoldFunction) then
				_T.InterruptNightFoldFunction = nil
				module2.Fade(false, 0.4)
			end

			while object:__wf_atom_63087342() do
				Sleep(0)
			end

			local __wf_atom_de2916be = object:__wf_atom_de2916be()

			if not __wf_atom_7e8ad928(__wf_atom_de2916be) then
				__wf_atom_de2916be:__wf_atom_d3ebb128(object)
			end

			object:__wf_atom_43b67ec1(__wf_atom_28d5d4aa, nil)
			object:__wf_atom_63453419(false)
			object:__wf_atom_fb9d7578(false)
			object:__wf_atom_972e5bcd()
			object:__wf_atom_9b5dcd3b(endNightFoldTransitionAnimation, false, 3, 1)
			Sleep(0)

			while object:__wf_atom_c138b19b(endNightFoldTransitionAnimation) do
				object:Teleport(__wf_atom_4c2e0189, mWorldView)
				Sleep(0)
			end

			object:__wf_atom_84dbc46b(1)
			local ternary = module3.Ternary(not __wf_atom_7e8ad928(_T.mHadForcedWalk), _T.mHadForcedWalk, false)
			local ternary2 = module3.Ternary(not __wf_atom_7e8ad928(_T.mCanJump), _T.mCanJump, true)
			local ternary3 = module3.Ternary(not __wf_atom_7e8ad928(_T.mCanDodge), _T.mCanDodge, true)
			object:MotionControl():__wf_atom_99fc7a82(ternary)
			__wf_atom_92aa9d91:__wf_atom_9f4f79f7(ternary2)
			object:__wf_atom_cf966a74(nightfoldTransitionInputFilter)
			object:__wf_atom_cf966a74(v)
			object:__wf_atom_f747bba3(ternary3)
			_ToggleCombatOnAvatar(object, true)

			if not __wf_atom_7e8ad928(_T.NightfoldGhostAvatar) then
				gRegion:__wf_atom_dd1e4d10(_T.NightfoldGhostAvatar)
				object:__wf_atom_a96eb2aa():__wf_atom_cca6e0bc():__wf_atom_865e86de(object)
			end

			module5.LogLeaveNightfold()
			module2.SetImmunity(object, false)
			_T.LocalPlayerInNightFold = false
			object:__wf_atom_92aa9d91():__wf_atom_fb9d7578()
			print("Exit nightfold completed")
		else
			if not __wf_atom_7e8ad928(v3) then
				v3:Stop(false)
				v3 = nil
			end

			object:__wf_atom_84dbc46b(1)
			__wf_atom_e919fb8e.nightfoldTransition = nil
			return false
		end
	end

	_T.SkipNightfoldTransition = nil
	__wf_atom_e919fb8e.nightfoldTransition = nil
	return true
end

function SendHubMessage(enteringNightFold)
	if not __wf_atom_7e8ad928(gMatchingService:__wf_atom_9c7c90fb()) then
		local encoded = cjson.encode({ enteringNightFold = enteringNightFold })
		gMatchingService:__wf_atom_6ff767a1("zone", encoded)
	end
end

function InitalizeVendorStations()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("VendorScriptTrigger"))

	for i = 1, #__wf_atom_2226b35c do
		__wf_atom_2226b35c[i]:FirePort("Execute")
	end
end

function InNightfoldLoop(object)
	local total = 0

	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and object:__wf_atom_799d95f5() do
		local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()
		local v4 = math.max(25, object:GetMaxHealth() * 0.25) + 1

		if __wf_atom_c6f1f83d < v4 then
			total += 0.5

			if total >= 1 then
				object:SetHealth(__wf_atom_c6f1f83d + math.min(math.floor(total), v4 - __wf_atom_c6f1f83d))
			end
		else
			total = 0
		end

		Sleep(0.1)
	end
end

function DisallowNightfoldInVolume(object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()

	while object:IsEnabled() and object:__wf_atom_4b409d7b(__wf_atom_c4f78a8f) do
		if not module4.IsNightfoldBlockedById(__wf_atom_5b41f63b) then
			module4.RegisterPreventNighfoldUsage(true, __wf_atom_5b41f63b)
			module4.SetPreventNightfoldUsageReason(disallowedNightFoldReasonCode)
		end

		Sleep(0.5)
	end

	module4.RegisterPreventNighfoldUsage(false, __wf_atom_5b41f63b)
	module4.SetPreventNightfoldUsageReason(0)
end

function DoCinematicFadeTransition()
	local __wf_atom_89894bd1 = gRegion:__wf_atom_8ad59546():__wf_atom_89894bd1()

	if __wf_atom_89894bd1 < 0 or __wf_atom_89894bd1 > 0 then
		return
	end

	module2.Fade(true, 0, 1, false)
	Sleep(1.5)
	module2.Fade(true, 0.5, 0, false)
end

function ListenForCinematicOutsideNightfold()
	module2.WaitForLevel()
	local playerAvatar = gRegion:GetPlayerAvatar()
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ArsenalWp"))
	local v4 = false
	local v5 = false

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("Arsenal waypoint not found. Can't check for Nightfold zone.")
		return
	end

	local __wf_atom_e800787c = __wf_atom_0a6a5887:__wf_atom_e800787c()

	while
		not __wf_atom_7e8ad928(playerAvatar)
		and playerAvatar:__wf_atom_799d95f5()
		and not __wf_atom_7e8ad928(postProcess)
	do
		local __wf_atom_c3b255b8 = gRegion:__wf_atom_c3b255b8()

		if __wf_atom_7e8ad928(__wf_atom_c3b255b8) or v4 then
			if __wf_atom_7e8ad928(__wf_atom_c3b255b8) and v4 then
				v4 = false

				if not v5 then
					module4.ToggleSky(false)
					postProcess.horizonDOF = 0
					postProcess:__wf_atom_eba78d3d(0)
					DoCinematicFadeTransition()
				end
			end
		else
			v4 = true
			v5 = __wf_atom_c3b255b8:__wf_atom_e800787c() == __wf_atom_e800787c

			if not v5 then
				module4.ToggleSky(true)
				postProcess.horizonDOF = 0.5
				postProcess:__wf_atom_eba78d3d(1)
				DoCinematicFadeTransition()
			end
		end

		Sleep(0)
	end
end

local function fn4()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local __wf_atom_330f77f5 = __wf_atom_eab484a7:__wf_atom_330f77f5(false)
	local v4 = not __wf_atom_7e8ad928(__wf_atom_330f77f5) and __wf_atom_330f77f5:__wf_atom_aaf836a8()

	if
		__wf_atom_c4f78a8f:IsKilled()
		or __wf_atom_c4f78a8f:__wf_atom_799d95f5()
		or module2.PlayerIsInBattle(__wf_atom_c4f78a8f)
		or module4.IsNightfoldBlocked()
		or v4
	then
		return
	end

	local ancestors = module.GetAncestorsWithRank(-1, true)

	if #ancestors > 0 then
		local v5 = #ancestors > 1 and "/SF/Language/Objectives/AncestorsWaiting"
			or "/SF/Language/Objectives/AncestorWaiting"

		if _T.ShowImpactMessage then
			_T.ShowImpactMessage(v5, -1)
			local total = 0

			while true do
				Sleep(0)

				if
					__wf_atom_7e8ad928(__wf_atom_c4f78a8f)
					or __wf_atom_c4f78a8f:__wf_atom_799d95f5()
					or module2.PlayerIsInBattle(__wf_atom_c4f78a8f)
					or module4.IsNightfoldBlocked()
					or total >= 120
				then
					break
				end

				total += __wf_atom_084b3e93()
			end

			while __wf_atom_7e8ad928(_T.HideImpactMessage) do
				Sleep(0)
			end

			_T.HideImpactMessage()
		end
	end
end

function UpdateNewAncestorNotification() end