local v = nil
local v2 = { Type() }
local rarity = 0
local v3 = Resource("/SF/Interface/MusicInputFilter")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("Lotus.Interface.LotusUtilities")

local function fn()
	for i = 1, #moteType do
		if not __wf_atom_7e8ad928(moteType[i]) then
			table.insert(v2, moteType[i])
		end
	end
end

local function fn2(instance)
	instance:__wf_atom_9b5dcd3b(ResponseStartAnim, false, 4, 1)
	instance:__wf_atom_8914dfde("ready", 2)
	instance:__wf_atom_9b5dcd3b(ResponseWaitAnim, false, 4, 2)
	instance:PlaySound(responseSound, false, 0, false)
end

local function fn3(object)
	if __wf_atom_7e8ad928(object) or not object:__wf_atom_4417a5d4() then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local inventory = gGameData:GetInventory()
	local v4 = WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")
	local v5 = WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade")
	local flag = false

	for _, list in pairs({
		__wf_atom_d2b2176d:__wf_atom_ae45a8b6(),
		inventory:GetUpgrades(),
		inventory:__wf_atom_063f1444()
	}) do
		for _, v6 in ipairs(list) do
			if __wf_atom_7e8ad928(v6.mItemType) or not (v6.mItemType:IsA(v4) or v6.mItemType:IsA(v5)) then
				continue
			end

			flag = true
			break
		end

		if flag then
			break
		end
	end

	if not flag then
		local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(5)

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			local v6 = {}

			for _, v7 in ipairs(moteType) do
				if v7:CanUseWithItem("", __wf_atom_28224c27) then
					table.insert(v6, v7)
				end
			end

			if #v6 > 0 then
				v = v6[__wf_atom_5784a397(1, #v6)]
			end
		end
	end

	if __wf_atom_7e8ad928(v) then
		v = v2[__wf_atom_5784a397(1, #v2)]
	end

	if not __wf_atom_7e8ad928(v) then
		while not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) do
			Sleep(0)
		end

		if __wf_atom_d2b2176d:__wf_atom_e55d02aa():__wf_atom_a07f65c2() then
			v = corMoteType[1]
			return
		end

		if __wf_atom_7e8ad928(gGameData) then
			return
		end

		if __wf_atom_d2b2176d:__wf_atom_4137b376(4) then
			local __wf_atom_7eb21a17 = v:__wf_atom_7eb21a17()
			local __wf_atom_c3297392 = v:__wf_atom_c3297392()
			local v6 = cjson.encode({
				compat = __wf_atom_c3297392:__wf_atom_5b41f63b(),
				pol = module2.GetPolarityTag(__wf_atom_7eb21a17)
			}):gsub(
				"\\/",
				"/"
			)
			print("giving mote " .. v:__wf_atom_5b41f63b() .. " to " .. object:__wf_atom_5b41f63b() .. " " .. v6)
			__wf_atom_d2b2176d:__wf_atom_e7ac08e7(v, v6)
			local __wf_atom_8b74c30b = __wf_atom_8e4fda44:__wf_atom_8b74c30b(motePickupDialogMovie)

			if not __wf_atom_7e8ad928(__wf_atom_8b74c30b) then
				__wf_atom_8b74c30b:__wf_atom_f62a8704("SetMoteDisplay", { v:__wf_atom_5b41f63b(), "", v6 })
			end
		elseif not __wf_atom_7e8ad928(_T.ShowImpactMessage) then
			_T.ShowImpactMessage("/SF/Language/Motes/TotemInventoryFull", 4)
		end
	end
end

function HackPostCinSwimmingState(object)
	local v4 = 3

	while not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) do
		if __wf_atom_7e8ad928(object) then
			return
		end

		object:__wf_atom_78ad8b9f(179, 1)
		Sleep(0)
	end

	while v4 > 0 and not __wf_atom_7e8ad928(object) do
		v4 -= __wf_atom_084b3e93()
		object:__wf_atom_78ad8b9f(179, 1)
		Sleep(0)
	end
end

function RemoveWaterSplashTC()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BeaverBasketAttachment"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local __wf_atom_bb3e7833 = __wf_atom_0a6a5887:__wf_atom_bb3e7833(waterSplashFX)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function PlayerBeaver(p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BeaverArrowAttachment"))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("BeaverBasketAttachment"))
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("PlayerBeaver"))

	if
		__wf_atom_7e8ad928(p)
		or __wf_atom_7e8ad928(__wf_atom_0a6a5887)
		or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2)
		or __wf_atom_7e8ad928(__wf_atom_0a6a5887_3)
	then
		return
	end

	__wf_atom_0a6a5887_2:AttachToInPlace(__wf_atom_0a6a5887_3, Symbol("GAME_R1_HANDWEAPON"))
	__wf_atom_0a6a5887_2:__wf_atom_e310f01f(__wf_atom_28d5d4aa, __wf_atom_80368bb1)
	__wf_atom_0a6a5887:AttachToInPlace(__wf_atom_0a6a5887_3, Symbol("GAME_C1_SPINE_HIP"))
	__wf_atom_0a6a5887_3:__wf_atom_8a035cd5(Symbol("HackPostCinSwimmingState"), false)
	local __wf_atom_45c0553e = __wf_atom_0a6a5887_2:__wf_atom_45c0553e()
	local total = 0

	while not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_3) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2)) do
		local v4 = Sin(total * 1.2 * 0.5) + 0.3 * Sin(total * 1.2 * 0.7) + 0.1 * Sin(total * 1.2 * 1.2)
		local __wf_atom_fa6a8faf = __wf_atom_0a6a5887_2:__wf_atom_fa6a8faf()
		__wf_atom_45c0553e.pitch = __wf_atom_45c0553e.bank + v4 * 6
		total += __wf_atom_084b3e93()
		__wf_atom_0a6a5887_2:__wf_atom_e310f01f(__wf_atom_fa6a8faf, __wf_atom_45c0553e)

		if total < 3 then
			__wf_atom_0a6a5887_2:SetMeshScale((__wf_atom_104bfe98(1, 1.2, total / 3)))
		end

		Sleep(0)
	end

	__wf_atom_0a6a5887_2:SetMeshScale(1)
end

function calmness(instance)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	if instance:IsA(__wf_atom_6c243c5e) and not hasMote then
		instance:__wf_atom_dd3e4432(false)
	end

	rarity = Rarity

	if rarity ~= 2 then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
		local v4

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			v4 = 0.05
		else
			local v5 = __wf_atom_0a6a5887:GetColor(instance:__wf_atom_a2a18137(), true).red / 255
			v4 = __wf_atom_104bfe98(0.05, 0.15, v5)
		end

		local v5 = Random(0, 1)

		if 0.8 - v4 < v5 then
			rarity = 1
		end

		SetAnimalVariantByRegion(instance)
	end

	Sleep(0.25)
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.musicCalm = false
	__wf_atom_e919fb8e.MusicResponse = false
	__wf_atom_e919fb8e.WaitforSong = false
	__wf_atom_e919fb8e.Song = song
	__wf_atom_e919fb8e.floated = false
	__wf_atom_e919fb8e.allPerfect = false
	__wf_atom_e919fb8e.Rarity = rarity
	fn()
	local __wf_atom_cc5b486e = instance:__wf_atom_cc5b486e()

	if not __wf_atom_7e8ad928(__wf_atom_cc5b486e) and __wf_atom_cc5b486e:__wf_atom_4417a5d4() then
		fn3(__wf_atom_cc5b486e)
	end

	while not __wf_atom_7e8ad928(instance) do
		if __wf_atom_e919fb8e.MusicResponse == true and not __wf_atom_e919fb8e.floated then
			if not __wf_atom_7e8ad928(floatFxType) then
				instance:Attach(floatFxType, EMPTY_SYMBOL)
			end

			fn2(instance)
			__wf_atom_e919fb8e.floated = true
		end

		if __wf_atom_e919fb8e.musicCalm == true then
			if __wf_atom_e919fb8e.allPerfect then
				local avatar = __wf_atom_e919fb8e.Avatar

				if not (__wf_atom_7e8ad928(avatar) or __wf_atom_7e8ad928(perfectCharmAnim) or __wf_atom_7e8ad928(ResponseEndAnim)) then
					avatar:__wf_atom_921c1a5f(nil, false, 0, 1, false)
					avatar:__wf_atom_aeb02c14(v3)
					local entity = gRegion:CreateEntity(
						perfectCharmAnim,
						avatar:GetPosition(),
						avatar:__wf_atom_2f2bada0()
					)
					local __wf_atom_99c400ff = entity:__wf_atom_99c400ff(Symbol("Envoy"), 0)
					local v4 = entity:__wf_atom_99c400ff(perfectCharmAnimRoleName, 0) - __wf_atom_99c400ff
					local __wf_atom_2f2bada0 = avatar:__wf_atom_2f2bada0()
					local position = instance:GetPosition()
					local __wf_atom_2f2bada0_2 = instance:__wf_atom_2f2bada0()
					local __wf_atom_c082fc3d = instance:__wf_atom_c082fc3d()
					local v5 = avatar:GetPosition() + __wf_atom_9341614d(v4, __wf_atom_2f2bada0)
					local v6 = Rotation(
						__wf_atom_2f2bada0.heading + 180,
						__wf_atom_2f2bada0.pitch,
						__wf_atom_2f2bada0.bank
					)
					local v7 = instance:__wf_atom_d5fda8be(v5) / 15
					local __wf_atom_8bb4ded3 = ResponseEndAnim:__wf_atom_8bb4ded3()
					local __wf_atom_0dcd7684 = ResponseEndAnim:__wf_atom_0dcd7684()
					local __wf_atom_43e3d184 = ResponseEndAnim:__wf_atom_43e3d184()
					local v8 = Symbol("MoteTouchdown")

					for i, v9 in ipairs(__wf_atom_0dcd7684) do
						if v9 == v8 then
							__wf_atom_8bb4ded3 = __wf_atom_43e3d184[i] * ResponseEndAnim:__wf_atom_8bb4ded3()
						end
					end

					responsePerfectFallTimeRange.minValue = math.min(
						responsePerfectFallTimeRange.minValue,
						ResponseEndAnim:__wf_atom_8bb4ded3()
					)
					responsePerfectFallTimeRange.maxValue = math.min(
						responsePerfectFallTimeRange.maxValue,
						ResponseEndAnim:__wf_atom_8bb4ded3()
					)
					local v9 = ResponseEndAnim:__wf_atom_8bb4ded3() - __wf_atom_8bb4ded3
					responsePerfectLandingTime = math.min(responsePerfectLandingTime, v9)
					local v10 = responsePerfectFallTimeRange.maxValue - responsePerfectFallTimeRange.minValue
					local v11 = responsePerfectFallTimeRange.minValue + v7 * v10
					local v12 = __wf_atom_8bb4ded3 / v11
					local _ = __wf_atom_8bb4ded3 / v12 + (ResponseEndAnim:__wf_atom_8bb4ded3() - __wf_atom_8bb4ded3)
					instance:__wf_atom_921c1a5f(ResponseEndAnim, false, 2, 1, false)
					instance:__wf_atom_986f733d(Symbol("MoteFallDeltaAttenuation"), v12)
					local total = 0
					local v13 = false

					while total < v11 + responsePerfectLandingTime do
						total += __wf_atom_084b3e93()
						local v14 = __wf_atom_24a82b69((math.min(total / v11, 1)))

						if v11 < total and not v13 then
							instance:__wf_atom_558ce619(Symbol("MoteFallDeltaAttenuation"))
							v13 = true
						end

						local v15 = __wf_atom_f55d6358(position, v5, v14)
						local v16 = __wf_atom_9d2f097a(__wf_atom_2f2bada0_2, v6, v14)
						local v17 = __wf_atom_104bfe98(__wf_atom_c082fc3d, 1, v14)
						instance:Teleport(v15, v16)
						instance:SetMeshScale(v17)
						Sleep(0)
					end

					if not v13 then
						instance:__wf_atom_558ce619(Symbol("MoteFallDeltaAttenuation"))
					end

					if not __wf_atom_7e8ad928(avatar) then
						avatar:__wf_atom_cf966a74(v3)
					end

					if gRegion:IsMaster() then
						instance:__wf_atom_921c1a5f(nil, false, 0, 1, false)
						entity:__wf_atom_a3d2b66b(avatar, Symbol("Envoy"))
						entity:__wf_atom_a3d2b66b(instance, perfectCharmAnimRoleName)
						instance:__wf_atom_e5d015a7(perfectCharmAnimRoleName)
						entity:SetInstigatorAvatar(avatar)
						entity:FirePort("StartPlaying")

						while not __wf_atom_7e8ad928(entity) and entity:__wf_atom_7d4910e4() do
							Sleep(0)
						end

						instance:__wf_atom_e5d015a7(EMPTY_SYMBOL)
					else
						entity:Destroy()
						Sleep(0.2)

						if avatar:__wf_atom_4417a5d4() then
							while not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) do
								Sleep(0)
							end
						end
					end
				end

				__wf_atom_e919fb8e.floated = false

				if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Avatar) then
					fn3(__wf_atom_e919fb8e.Avatar)
					__wf_atom_e919fb8e.Avatar:__wf_atom_d2b2176d():__wf_atom_355b9a20(
						1000,
						__wf_atom_e919fb8e.Avatar,
						EMPTY_SYMBOL
					)
				end
			else
				instance:__wf_atom_9b5dcd3b(ResponseSuccessAnim, false, 4, 1, false)
				__wf_atom_e919fb8e.floated = false

				if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Avatar) then
					fn3(__wf_atom_e919fb8e.Avatar)
					__wf_atom_e919fb8e.Avatar:__wf_atom_d2b2176d():__wf_atom_355b9a20(
						500,
						__wf_atom_e919fb8e.Avatar,
						EMPTY_SYMBOL
					)
				end
			end

			local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(animMoteFx)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end

			if not __wf_atom_7e8ad928(nil) then
				(nil):Destroy()
			end

			instance:__wf_atom_dd3e4432(false)
			instance:__wf_atom_e67de6fc(false)
			break
		else
			if __wf_atom_e919fb8e.RUNAWAY == true then
				instance:__wf_atom_9b5dcd3b(ResponseFailEndAnim, false, 4, 1, false)
				__wf_atom_e919fb8e.RUNAWAY = false
				__wf_atom_e919fb8e.musicCalm = false
				__wf_atom_e919fb8e.MusicResponse = false
				__wf_atom_e919fb8e.floated = false
				instance:__wf_atom_e67de6fc(false)
			end

			Sleep(0)
		end
	end
end

function PrepPerfectCharmCin(object)
	local __wf_atom_02a7a2f4 = object:__wf_atom_02a7a2f4()

	if not __wf_atom_7e8ad928(__wf_atom_02a7a2f4) then
		module.UnequipWeapon(__wf_atom_02a7a2f4, unequipInstant)
	end
end

function SetAnimalVariantByRegion(object)
	if not useVariants then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local blue = __wf_atom_0a6a5887:GetColor(object:__wf_atom_a2a18137(), true).blue
		local __wf_atom_c4bec6cc = animalVariantInfo:__wf_atom_c4bec6cc(blue)
		local __wf_atom_22cbd7f6 = animalVariantInfo:__wf_atom_22cbd7f6(blue)

		if not __wf_atom_7e8ad928(__wf_atom_22cbd7f6) then
			moteType = __wf_atom_22cbd7f6
		end

		if not __wf_atom_7e8ad928(__wf_atom_c4bec6cc) and #__wf_atom_c4bec6cc > 0 then
			for i = 1, #__wf_atom_c4bec6cc do
				if not __wf_atom_7e8ad928(__wf_atom_c4bec6cc[i]) then
					object:__wf_atom_a887a262(i - 1, __wf_atom_c4bec6cc[i])
				end
			end
		end
	end
end