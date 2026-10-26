module(..., package.seeall)
local v = WeakResource("/EE/Types/Physics/PartialRagdoll")
local v2 = WeakResource("/Lotus/Fx/Avatar/PvpAvatarStillLoading")
local v3 = WeakResource("/Lotus/Characters/Tenno/Excalibur/Excalibur_skel.fbx")
local v4 = WeakResource("/Lotus/Fx/Sigils/BasicSigil")
local v5 = WeakResource("/Lotus/Types/Game/LotusWeaponAttachments/ArrowWeaponAttachment")
local v6 = WeakResource()
local v7 = Symbol("PinchAtten")
local v8 = {
	Symbol("TintColor0"),
	Symbol("TintColor1"),
	Symbol("TintColor2"),
	Symbol("TintColor3"),
	Symbol("EmissiveTintColorHi"),
	Symbol("EmissiveTintColorLo"),
	Symbol("TintColor")
}
local v9 = {
	"/Lotus/Levels/Episodes/PvP.level",
	"/Lotus/Levels/Episodes/Capture4v4.level",
	"/Lotus/Levels/Episodes/Annihilation.level",
	"/Lotus/Levels/Episodes/AnnihilationTeam.level",
	"/Lotus/Levels/Episodes/TennoBall4v4.level",
	"/Lotus/Levels/Episodes/AnnihilationTeamSolstice.level"
}
local module = require("Lotus.Interface.LotusUtilities")

local function fn(object)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)

	for i = 1, #v8 do
		object:__wf_atom_6d11d81e(v8[i])
	end

	for _, v10 in ipairs(__wf_atom_f582136d) do
		if v10 == object then
			continue
		end

		for i = 1, #v8 do
			v10:__wf_atom_6d11d81e(v8[i])
		end
	end
end

local function fn2(object, object2)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)
	local __wf_atom_f582136d2 = object2:__wf_atom_f582136d(__wf_atom_7e616794)
	fn(object)
	object:__wf_atom_40353888(object2)
	object:__wf_atom_c66b5d44(object2)
	local __wf_atom_5c48905f = object2:__wf_atom_5c48905f()

	for i = 0, __wf_atom_5c48905f - 1 do
		object:__wf_atom_a887a262(i, object2:__wf_atom_807f6a09(i), false)
	end

	local __wf_atom_575542c8 = object2:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		local v10 = Color(0, 0, 0, 255)
		v10.red = object2:__wf_atom_06adb5a9(v8[7], 1) * 255

		if v10.red < 256 then
			v10.green = object:__wf_atom_06adb5a9(v8[7], 2) * 255
			v10.blue = object:__wf_atom_06adb5a9(v8[7], 3) * 255
			Effects.__wf_atom_d147188c(object, __wf_atom_8939e086, v10, v10)
		end
	else
		local __wf_atom_e55d02aa = __wf_atom_575542c8:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			local creator = object2:GetCreator()

			if not __wf_atom_7e8ad928(creator) and creator:IsA(__wf_atom_abf506db) then
				__wf_atom_e55d02aa:__wf_atom_198d4ff9(
					object,
					__wf_atom_e55d02aa:__wf_atom_eb82ab1f(),
					creator:__wf_atom_cf751e23(),
					true
				)
			end
		end
	end

	if #__wf_atom_f582136d == #__wf_atom_f582136d2 then
		for i, v10 in ipairs(__wf_atom_f582136d) do
			local v11 = __wf_atom_f582136d2[i]
			v10:__wf_atom_40353888(v11)

			for j = 0, v11:__wf_atom_5c48905f() - 1 do
				v10:__wf_atom_a887a262(j, v11:__wf_atom_807f6a09(j), false)
			end
		end
	else
		for _, v10 in ipairs(__wf_atom_f582136d) do
			__wf_atom_83c14687()
			local v11 = false

			for _, v12 in ipairs(__wf_atom_f582136d2) do
				if v10:__wf_atom_e14d8a8c() ~= v12:__wf_atom_e14d8a8c() then
					continue
				end

				v10:__wf_atom_40353888(v12)
				v11 = true

				for i = 0, v12:__wf_atom_5c48905f() - 1 do
					v10:__wf_atom_a887a262(i, v12:__wf_atom_807f6a09(i), false)
				end

				break
			end

			if v11 then
				continue
			end

			v10:__wf_atom_40353888(object2)

			if not v10:IsA(__wf_atom_b5e70cef) then
				continue
			end

			for i = 0, __wf_atom_5c48905f - 1 do
				v10:__wf_atom_a887a262(i, object2:__wf_atom_807f6a09(i), false)
			end
		end
	end
end

local function fn3(instance)
	while not __wf_atom_7e8ad928(instance) do
		if instance:IsA(__wf_atom_67c46eba) then
			return nil
		end

		if instance:IsA(__wf_atom_56348098) then
			return instance:__wf_atom_21ed1a39()
		else
			instance = instance:__wf_atom_3d96ddcd()
		end
	end

	return nil
end

local function fn4(instance, object, list, list2, p, p2)
	local __wf_atom_be0bea4a = instance:__wf_atom_be0bea4a()
	local v10 = Symbol("EffectsDeco")

	for i = 1, #__wf_atom_be0bea4a do
		local v11 = __wf_atom_be0bea4a[i]
		local v12 = false

		for j = 1, #list do
			if not v11:IsA(list[j]) then
				continue
			end

			v12 = true
			break
		end

		if v12 and v11:IsA(__wf_atom_56348098) then
			local __wf_atom_21ed1a39 = v11:__wf_atom_21ed1a39()

			if not __wf_atom_7e8ad928(__wf_atom_21ed1a39) and __wf_atom_21ed1a39:__wf_atom_ed08f97f() then
				v12 = false
			end
		end

		if not v12 and instance:IsA(__wf_atom_67c46eba) then
			local v13 = fn3(v11)
			v12 = not __wf_atom_7e8ad928(v13)
				and v13:__wf_atom_e2e81ab2()
				and v13 ~= instance:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
				and true
				or v12
		end

		local v13 = not v12
			and v11:IsA(v5)
			and not __wf_atom_7e8ad928(v11:__wf_atom_21ed1a39())
			and instance:IsA(__wf_atom_4ebf67cb)
			and v11:__wf_atom_21ed1a39() ~= instance:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
			and true
			or v12
		local v14 = p2 and not v11:__wf_atom_572fc369() and true or v13

		if not (v14 or not v11:HasTag(v10)) or v14 then
			continue
		end

		local __wf_atom_a5040fdf = object:__wf_atom_a5040fdf()
		local v15 = not __wf_atom_7e8ad928(__wf_atom_392793db) and __wf_atom_a5040fdf == __wf_atom_392793db and 0
			or gRegion:IsMaster() and 3
			or 4
		local flag = false
		local __wf_atom_e14d8a8c = v11:__wf_atom_e14d8a8c()

		if v11:IsA(__wf_atom_56348098) then
			__wf_atom_e14d8a8c = Type(__wf_atom_7e616794)
			flag = true
		elseif v11:IsA(__wf_atom_8d0b7f88) then
			local __wf_atom_3d96ddcd = v11:__wf_atom_3d96ddcd()

			if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_56348098) then
				__wf_atom_e14d8a8c = Type(__wf_atom_7e616794)
				flag = true
			end
		end

		local v16 = object:Attach(
			__wf_atom_e14d8a8c,
			v11:__wf_atom_f5bac0e4(),
			v11:__wf_atom_fa6a8faf(),
			v11:__wf_atom_45c0553e(true),
			object,
			v15
		)

		if __wf_atom_7e8ad928(v16) then
			break
		end

		v16:__wf_atom_0fc0efb5(0)
		fn2(v16, v11)

		if v11:IsA(v) and instance:IsA(__wf_atom_4ebf67cb) then
			v16:__wf_atom_0f723f06(object, instance)
		end

		if v11:__wf_atom_b6b760b5() ~= v16:__wf_atom_b6b760b5() then
			v16:__wf_atom_45cf0e1a(v11:__wf_atom_b6b760b5(), false, false)
		end

		if flag and not p2 then
			v16:__wf_atom_a763aa1a(0)
			v16:__wf_atom_6d11d81e(v7)
			local __wf_atom_be0bea4a2 = v16:__wf_atom_be0bea4a()

			for j = 1, #__wf_atom_be0bea4a2 do
				__wf_atom_be0bea4a2[j]:__wf_atom_6d11d81e(v7)
			end
		elseif v11:__wf_atom_f83a55c6() ~= v16:__wf_atom_f83a55c6() then
			v16:__wf_atom_a763aa1a(v11:__wf_atom_f83a55c6())
		end

		v16:SetMeshScale(v11:__wf_atom_c082fc3d())

		if flag then
			v16:__wf_atom_70f78a63(v11)
			v16:__wf_atom_a452a39b()
		end

		if not p then
			continue
		end

		local __wf_atom_be0bea4a2 = v16:__wf_atom_be0bea4a()

		for j = 1, #__wf_atom_be0bea4a2 do
			local flag2 = true
			local v17 = __wf_atom_be0bea4a2[j]

			if __wf_atom_7e8ad928(v17) then
				continue
			end

			if v17:IsA(__wf_atom_ca04301b) then
				flag2 = false

				for k = 1, #list2 do
					if not v17:IsA(list2[k]) then
						continue
					end

					flag2 = true
					break
				end
			end

			if not flag2 then
				continue
			end

			if v17:IsA(__wf_atom_465d956f) then
				v17:Enable()
				v17:Disable()
				local __wf_atom_cf51ee01 = v17:__wf_atom_cf51ee01()

				if not __wf_atom_7e8ad928(__wf_atom_cf51ee01) then
					__wf_atom_cf51ee01:Stop(true)
				end
			end

			gRegion:__wf_atom_dd1e4d10(v17)
		end

		fn4(v11, v16, list, list2, true, p2)
	end
end

local function fn5(object, object2, p, p2, p3, p4, list)
	if __wf_atom_7e8ad928(object2) and not p2 then
		object:SetVisibility(p, true)

		if p then
			local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)

			for i = 1, #__wf_atom_f582136d do
				if __wf_atom_f582136d[i] ~= object then
					__wf_atom_f582136d[i]:SetVisibility(false, true)
				end
			end

			object:__wf_atom_45cf0e1a(Resource(v3), false, false)
			object:__wf_atom_bde21df6(Resource(v2))
		end
	elseif p2 then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_a4299765 = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_a4299765()

			if not __wf_atom_7e8ad928(__wf_atom_a4299765) then
				local mOperatorCustomization = __wf_atom_a4299765.mOperatorCustomization
				local __wf_atom_1d3fceab = mOperatorCustomization:__wf_atom_1d3fceab()

				if not __wf_atom_7e8ad928(__wf_atom_1d3fceab) then
					local v10 = Resource(__wf_atom_1d3fceab)

					if not __wf_atom_7e8ad928(object) then
						local object3 = gRegion:CreateObject(v10, object)
						object3:SetCustomization(mOperatorCustomization.mCustomization)
						object:__wf_atom_d2b2176d():GiveItem(object3, true)
					end
				end
			end
		end
	else
		local __wf_atom_e55d02aa = object2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		local __wf_atom_3d96ddcd = object2:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_323ad80a) then
			return
		end

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_c256a45f(object)
		end

		if object:__wf_atom_b6b760b5() ~= object2:__wf_atom_b6b760b5() then
			object:__wf_atom_45cf0e1a(object2:__wf_atom_b6b760b5(), true, false)

			for i = 0, object:__wf_atom_5c48905f() - 1 do
				object:__wf_atom_a887a262(i, nil, false)
			end
		end

		fn2(object, object2)
		local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)

		for i = 1, #__wf_atom_f582136d do
			if __wf_atom_f582136d[i] ~= object then
				__wf_atom_f582136d[i]:SetVisibility(false, true)
			end
		end

		local v10 = {}

		for i = 1, #list do
			table.insert(v10, list[i])
		end

		table.insert(v10, __wf_atom_4ebf67cb)
		table.insert(v10, __wf_atom_ca04301b)
		table.insert(v10, __wf_atom_8b8e8b22)

		if not p3 then
			v10[#v10] = __wf_atom_56348098
		end

		if object2:IsKilled() then
			local __wf_atom_f51f1faa = object2:__wf_atom_f51f1faa()

			if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
				object2 = __wf_atom_f51f1faa
			end
		end

		fn4(object2, object, v10, list, p4, object2:__wf_atom_572fc369())
		local __wf_atom_f582136d2 = object2:__wf_atom_f582136d(v4)

		for i = 1, #__wf_atom_f582136d2 do
			local v11 = __wf_atom_f582136d2[i]
			local creator = v11:GetCreator()

			if not (__wf_atom_7e8ad928(creator) or creator:IsA(__wf_atom_87580f1c)) then
				continue
			end

			local v12 = object:Attach(
				v11:__wf_atom_e14d8a8c(),
				v11:__wf_atom_f5bac0e4(),
				v11:__wf_atom_fa6a8faf(),
				v11:__wf_atom_45c0553e()
			)
			v12:__wf_atom_0fc0efb5(0)
			fn2(v12, v11)
			v12:__wf_atom_05bf7c23(v11)
		end
	end
end

function CreateDioramaLoader(mMovie, p)
	return {
		mMovie = mMovie,
		mLevelLoader = nil,
		mLevel = nil,
		mPortrait = nil,
		mLoadingLevel = false,
		mSyncAvatars = true,
		mTraining = false,
		mLoadingComplete = false,
		mUseOperatorForLocal = false,
		mIsPvp = false,
		mFadeParams = nil,
		LoadDioramaEx = function(p2, list, mSyncAvatars)
			if mSyncAvatars ~= nil then
				p2.mSyncAvatars = mSyncAvatars
			end

			if __wf_atom_7e8ad928(list[1]) then
				__wf_atom_8e4fda44:__wf_atom_62a19abc()
				return false
			end

			local flag = false
			local v10 = false
			local v11 = false

			for _, v12 in ipairs(list) do
				if v12 == v2:__wf_atom_5b41f63b() then
					v10 = true
				elseif v12 == v3:__wf_atom_5b41f63b() then
					v11 = true
				elseif not flag then
					for _, v13 in ipairs(v9) do
						if v12 ~= v13 then
							continue
						end

						flag = true
						break
					end
				end
			end

			if flag then
				if not v10 then
					table.insert(list, v2:__wf_atom_5b41f63b())
				end

				if not v11 then
					table.insert(list, v3:__wf_atom_5b41f63b())
				end
			end

			p2.mLevelLoader = UISys.__wf_atom_c0dbe47c(list, p == true)
			p2.mLevel = list[1]
			p2.mLoadingLevel = true
			return true
		end,
		LoadDiorama = function(p2, instance)
			if __wf_atom_7e8ad928(instance) then
				if p2.mPortrait then
					__wf_atom_8e4fda44:__wf_atom_12ff8d19(false)
				else
					__wf_atom_8e4fda44:__wf_atom_62a19abc()
				end

				return false
			else
				local __wf_atom_5b41f63b = instance:__wf_atom_5b41f63b()
				local flag = false

				for _, v10 in ipairs(v9) do
					if v10 ~= __wf_atom_5b41f63b then
						continue
					end

					flag = true
					break
				end

				p2.mLevel = WeakResource(instance)
				local v10 = instance:IsA(v6) and module.HasCompletedNewWar()

				if __wf_atom_1ef90898(instance) or flag or v10 then
					local v11 = { __wf_atom_5b41f63b }

					if flag then
						table.insert(v11, v2:__wf_atom_5b41f63b())
						table.insert(v11, v3:__wf_atom_5b41f63b())
					elseif v10 and not __wf_atom_7e8ad928(gGameData) then
						local inventory = gGameData:GetInventory()

						if not __wf_atom_7e8ad928(inventory) then
							local __wf_atom_ff35dae7 = inventory:__wf_atom_ff35dae7()

							if not __wf_atom_7e8ad928(__wf_atom_ff35dae7) then
								local __wf_atom_035fdfa8 = __wf_atom_ff35dae7:__wf_atom_035fdfa8(2)

								if not __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
									table.insert(v11, __wf_atom_035fdfa8:__wf_atom_5b41f63b())
								end
							end
						end
					end

					p2.mLevelLoader = UISys.__wf_atom_c0dbe47c(v11, p == true)
					p2.mLoadingLevel = true
					p2.mLoadingComplete = false
				else
					p2.mLoadingLevel = true
					p2.mLoadingComplete = true
				end

				return true
			end
		end,
		AbortLoad = function(p2)
			if not __wf_atom_7e8ad928(p2.mLevelLoader) then
				p2.mLevelLoader:Abort()
				p2.mLevelLoader = nil
			end

			p2.mLoadingLevel = false
			p2.mLevel = nil
		end,
		IsLoading = function(self)
			return self.mLoadingLevel
		end,
		LoadingComplete = function(self, _)
			if self.mLoadingComplete or not self:IsLoading() then
				return true
			end

			return __wf_atom_7e8ad928(self.mLevelLoader) or self.mLevelLoader:__wf_atom_86399a47()
		end,
		SetFadeParams = function(p2, p3, p4, p5)
			p2.mFadeParams = { p3, p4, p5 }
		end,
		FinishLoad = function(state, p2)
			local v10 = Resource(state.mLevel)

			if __wf_atom_7e8ad928(v10) then
				return
			end

			local __wf_atom_5b41f63b = v10:__wf_atom_5b41f63b()

			for i = 1, #v9 do
				if string.find(__wf_atom_5b41f63b, v9[i]) == nil then
					continue
				end

				state.mIsPvp = true
				break
			end

			if not p2 then
				if state.mPortrait then
					__wf_atom_8e4fda44:__wf_atom_5eae3823(v10)
				else
					__wf_atom_8e4fda44:__wf_atom_ebf17acc(v10)
				end
			end

			state.mLevelLoader = nil
			state.mLoadingLevel = false
			state.mLevel = nil

			if __wf_atom_7e8ad928(__wf_atom_392793db) then
				return
			end

			if state.mFadeParams then
				__wf_atom_392793db:__wf_atom_8ad59546():__wf_atom_47f0b80b(state.mFadeParams[1])
				__wf_atom_392793db:__wf_atom_8ad59546():__wf_atom_f92e3acc(state.mFadeParams[2], state.mFadeParams[3])
			end

			if not state.mSyncAvatars then
				return
			end

			local menuSuitAvatar = module.GetMainMenuSuitAvatar()

			if state.mUseOperatorForLocal and not __wf_atom_7e8ad928(gGameRules) then
				local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

				if not (__wf_atom_7e8ad928(__wf_atom_eab484a7) or __wf_atom_7e8ad928((__wf_atom_eab484a7:__wf_atom_04b7536b()))) then
					menuSuitAvatar = __wf_atom_eab484a7:__wf_atom_50a7d83e()
				end
			elseif state.mUseArsenalAvatarForLocal and _T.MenuSuitAvatar ~= nil then
				menuSuitAvatar = _T.MenuSuitAvatar
			end

			local v11 = { menuSuitAvatar }

			for i = 1, 3 do
				if
					not _T.remoteSuitEntities
					or (__wf_atom_7e8ad928(_T.remoteSuitEntities[i]) or __wf_atom_7e8ad928(_T.remoteSuitEntities[i].avatar))
				then
					continue
				end

				if not _T.remoteSuitEntities[i].avatar:IsVisible() then
					continue
				end

				table.insert(v11, _T.remoteSuitEntities[i].avatar)
			end

			if __wf_atom_7e8ad928(v11[1]) then
				return
			end

			local __wf_atom_2226b35c = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Player"))

			if not state.mTraining and #__wf_atom_2226b35c == 0 then
				__wf_atom_2226b35c = {}
				local __wf_atom_2226b35c2 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Player1"))

				if #__wf_atom_2226b35c2 > 0 then
					table.insert(__wf_atom_2226b35c, __wf_atom_2226b35c2[1])
				end

				local __wf_atom_2226b35c3 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Player2"))

				if #__wf_atom_2226b35c3 > 0 then
					table.insert(__wf_atom_2226b35c, __wf_atom_2226b35c3[1])
				end

				local __wf_atom_2226b35c4 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Player3"))

				if #__wf_atom_2226b35c4 > 0 then
					table.insert(__wf_atom_2226b35c, __wf_atom_2226b35c4[1])
				end

				local __wf_atom_2226b35c5 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Player4"))

				if #__wf_atom_2226b35c5 > 0 then
					table.insert(__wf_atom_2226b35c, __wf_atom_2226b35c5[1])
				end
			end

			if state.mTraining then
				for _ = 1, #__wf_atom_2226b35c do
					table.insert(v11, module.GetMainMenuSuitAvatar())
				end
			end

			for i = 1, #__wf_atom_2226b35c do
				fn5(__wf_atom_2226b35c[i], v11[i], state.mIsPvp, false, false)
			end

			local __wf_atom_2226b35c2 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("PlayerCopy"))

			for i = 1, #__wf_atom_2226b35c2 do
				fn5(__wf_atom_2226b35c2[i], v11[1], state.mIsPvp, false, false)
			end

			local __wf_atom_2226b35c3 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Operator"))

			if not state.mTraining and #__wf_atom_2226b35c3 == 0 then
				local v12 = {}
				local __wf_atom_2226b35c4 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Operator1"))

				if #__wf_atom_2226b35c4 > 0 then
					table.insert(v12, __wf_atom_2226b35c4[1])
				end

				local __wf_atom_2226b35c5 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Operator2"))

				if #__wf_atom_2226b35c5 > 0 then
					table.insert(v12, __wf_atom_2226b35c5[1])
				end

				local __wf_atom_2226b35c6 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Operator3"))

				if #__wf_atom_2226b35c6 > 0 then
					table.insert(v12, __wf_atom_2226b35c6[1])
				end

				local __wf_atom_2226b35c7 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Operator4"))

				if #__wf_atom_2226b35c7 > 0 then
					table.insert(v12, __wf_atom_2226b35c7[1])
				end
			end

			local __wf_atom_2226b35c4 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Archwing"))

			if not state.mTraining and #__wf_atom_2226b35c4 == 0 then
				__wf_atom_2226b35c4 = {}
				local __wf_atom_2226b35c5 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Archwing1"))

				if #__wf_atom_2226b35c5 > 0 then
					table.insert(__wf_atom_2226b35c4, __wf_atom_2226b35c5[1])
				end

				local __wf_atom_2226b35c6 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Archwing2"))

				if #__wf_atom_2226b35c6 > 0 then
					table.insert(__wf_atom_2226b35c4, __wf_atom_2226b35c6[1])
				end

				local __wf_atom_2226b35c7 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Archwing3"))

				if #__wf_atom_2226b35c7 > 0 then
					table.insert(__wf_atom_2226b35c4, __wf_atom_2226b35c7[1])
				end

				local __wf_atom_2226b35c8 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Archwing4"))

				if #__wf_atom_2226b35c8 > 0 then
					table.insert(__wf_atom_2226b35c4, __wf_atom_2226b35c8[1])
				end
			end

			for i = 1, #__wf_atom_2226b35c4 do
				local v12 = __wf_atom_2226b35c4[i]
				local v13 = v11[i]

				if __wf_atom_7e8ad928(v13) then
					v12:SetVisibility(false, true)
				else
					local __wf_atom_f7583f71 = v13:__wf_atom_d2b2176d():__wf_atom_f7583f71()

					if not __wf_atom_7e8ad928(__wf_atom_f7583f71) then
						__wf_atom_f7583f71:__wf_atom_c256a45f(v12)
						fn2(v12, v13)
					end
				end
			end
		end,
		UpdateAvatar = function(p2, p3, p4, p5)
			if not __wf_atom_7e8ad928(__wf_atom_392793db) then
				local __wf_atom_0a6a5887 = __wf_atom_392793db:__wf_atom_0a6a5887(p3)

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					if p5 then
						fn(__wf_atom_0a6a5887)
					end

					fn5(__wf_atom_0a6a5887, p4, p2.mIsPvp, false, false)
				end
			end
		end
	}
end

function SetupDecoAsAvatar(p, p2, p3)
	fn5(p, p2, p3, false, false)
end

function SetupDecoAsAvatarWithWeapons(p, p2, p3, p4)
	fn5(p, p2, p3, false, true, true, p4)
end

function SetupOperatorAvatar(p)
	fn5(p, nil, false, true, false)
end

function SetupOperatorDeco(p, p2)
	fn5(p, p2, false, false, false)
end