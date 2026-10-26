local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.CardUtilitiesRedux")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("SF.Interface.Libs.UIUtilities")
local module5 = require("Lotus.Interface.LotusUtilities")
local v = ""
local skillTreeSelected = nil
local v2 = {}
local rank = 0
local v3 = 0
local v4 = {}
local asyncLoader = module4.CreateAsyncLoader()
local flag = false
local flag2 = false
local v5 = 0
local v6 = 0
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = {}
local flag3 = false
local v11 = false
local flag4 = false
local flag5 = false
local v12 = false
local v13 = false

local function fn(index, id, mItemType, mX, mY, mActive, mAvailable, __wf_atom_576f6429, mCurrentLevel)
	local upgradeInfo = SF.UpgradeInfo()
	upgradeInfo.mItemType = mItemType
	local cardFromArtifact = module2.CardFromArtifact(upgradeInfo, index)
	v2[id] = {
		mId = index,
		mSkillId = id,
		mNodeRes = mItemType,
		mX = mX,
		mY = mY,
		mClipName = v .. ".Node" .. index,
		mChildren = {},
		mParentId = nil,
		mActive = mActive,
		mAvailable = mAvailable,
		mNumLevels = __wf_atom_576f6429,
		mCurrentLevel = mCurrentLevel,
		mCard = cardFromArtifact
	}
end

local function fn2()
	local v14 = v3

	for i = 1, #v10 do
		local v15 = v10[i]
		v14 -= v15.mNodeRes:__wf_atom_c61f7de4(v15.mCurrentLevel)
	end

	return v14
end

local function fn3(p)
	local mCurrentLevel = p.mCurrentLevel

	for i = 1, #v10 do
		if v10[i].mNodeRes == p.mNodeRes then
			mCurrentLevel += 1
		end
	end

	return p.mNodeRes:__wf_atom_c61f7de4(mCurrentLevel)
end

local function fn4(p)
	for _, v14 in pairs(v2) do
		if v14.mId == p then
			return v14
		end
	end

	return nil
end

local function fn5(mParentId)
	for _, v14 in pairs(v2) do
		if v14.mSkillId == mParentId then
			return v14
		end
	end

	return nil
end

local function fn6(skillNode)
	local v14 = skillNode.mNumLevels == skillNode.mCurrentLevel
	local ternary = module.Ternary(v14, "", "<SKILL_PIP>" .. fn3(skillNode))
	local infoPopup_Data = {
		CustomEntry = true,
		Name = mMovie:__wf_atom_8e9ac384(skillNode.mCard.mName, true),
		Description = mMovie:__wf_atom_8e9ac384(skillNode.mNodeRes:__wf_atom_3a3d2e39():c_str(), true),
		TitleRight = ternary,
		SkillNode = skillNode
	}
	module4.SetItemInfoPopupRect(
		mMovie,
		infoPopup_Data,
		mMovie:__wf_atom_5e6e15c8(skillNode.mClipName .. ".Full", 2),
		mMovie:__wf_atom_5e6e15c8(skillNode.mClipName .. ".Full", 3),
		mMovie:__wf_atom_5e6e15c8(skillNode.mClipName .. ".Full", 14),
		mMovie:__wf_atom_5e6e15c8(skillNode.mClipName .. ".Full", 15)
	)
	_T.InfoPopup_Data = infoPopup_Data
end

local function fn7()
	v3 = module3.GetEnvoyInventoryControl():__wf_atom_dfb755f8(skillTreeSelected)
	local v14 = fn2()
	local convertColorNumberToHex = module.ConvertColorNumberToHex(_G.UIColor_Beige)
	local skillTreeLocOverride = skillTreeSelected:__wf_atom_014a76a2():c_str()

	if _T.SkillTreeLocOverride ~= nil then
		skillTreeLocOverride = _T.SkillTreeLocOverride
	end

	mMovie:__wf_atom_50d60589(
		"Container.Title",
		36,
		"<p><font size=\"30\">" .. mMovie:__wf_atom_8e9ac384(skillTreeLocOverride, false) .. "</font><font size=\"30\">" .. mMovie:__wf_atom_8e9ac384(" <SKILL_PIP>", true) .. "</font>" .. "<font size=\"30\" color=\"" .. convertColorNumberToHex .. "\">" .. "<b>" .. v14 .. "</b></font></p>"
	)
	local v15 = mMovie:__wf_atom_5e6e15c8("Container.Title", 40) * 1.5
	mMovie:__wf_atom_e57658c2("Container.BgAmount", 14, v15)
end

local function fn8()
	local envoyInventoryControl = module3.GetEnvoyInventoryControl()
	rank = envoyInventoryControl:__wf_atom_9114aa52(skillTreeSelected)
	v4 = envoyInventoryControl:__wf_atom_72055871(skillTreeSelected)

	if __wf_atom_7e8ad928(v4) then
		v4 = {}
	end

	local v14 = fn2()
	fn7()

	for _, v15 in pairs(v2) do
		local mNodeRes = v15.mNodeRes
		local mActive = false
		local mCurrentLevel = 0

		for _, v16 in v4 do
			if not v16.mItemType:IsA(mNodeRes) then
				continue
			end

			mCurrentLevel = v16.mLevel + 1
			mActive = true
			break
		end

		v15.mActive = mActive
		v15.mCurrentLevel = mCurrentLevel
	end

	for _, v15 in ipairs(v10) do
		local fn4_2 = fn4(v15.mId)
		fn4_2.mActive = true
	end

	for _, v15 in pairs(v2) do
		local mActive = v15.mNodeRes:__wf_atom_2ecb3e75() <= rank

		if v14 < fn3(v15) then
			mActive = false
		end

		local v16 = fn5(v15.mParentId)

		if v16 ~= nil then
			mActive = mActive and v16.mActive
		end

		v15.mAvailable = mActive
	end

	if not (__wf_atom_7e8ad928(_T.InfoPopup_Data) or __wf_atom_7e8ad928(_T.InfoPopup_Data.SkillNode)) then
		fn6(_T.InfoPopup_Data.SkillNode)
	end
end

local function fn9(p)
	if flag3 or flag or flag2 then
		return
	end

	local v14 = fn4(p)

	if v14 == nil then
		return
	end

	if not v14.mAvailable then
		module.PlaySound(upgradeLockedSound)
		return
	end

	if v14.mNumLevels == v14.mCurrentLevel then
		module.PlaySound(upgradeLockedSound)
		return
	end

	if fn2() < fn3(v14) then
		module.PlaySound(upgradeLockedSound)
		return
	end

	flag2 = true
	v6 = p
	v5 += 0.2
	local v15 = math.max(0, 1.2 - v5)
	local v16 = v5 / 1.2
	local ternary = module.Ternary(
		v14.mCurrentLevel > 0,
		v14.mClipName .. ".PipContainer.Pip" .. v14.mCurrentLevel,
		v14.mClipName
	)
	v7 = module.CreateUIParticles(mMovie, v14.mClipName .. ".Full", purchaseHoldFx, 0, 0)
	mMovie:__wf_atom_4c1c1986(ternary, "Empty", 12, 100)
	mMovie:__wf_atom_4c1c1986(ternary, "Full", 12, v16 * 100)
	__wf_atom_ec43d06e(mMovie, ternary .. ".Full", 8, { 12 }, { 100 }, v15 * 1.2)
	mMovie:__wf_atom_4c1c1986(ternary, "Full", 5, v16 * 60 + 100)
	mMovie:__wf_atom_4c1c1986(ternary, "Full", 6, v16 * 60 + 100)
	__wf_atom_ec43d06e(mMovie, ternary .. ".Full", 8, { 12, 5, 6 }, { 100, 160, 160 }, v15 * 1.2)
	mMovie:__wf_atom_4c1c1986(ternary, "FullMask", 5, v16 * 400)
	mMovie:__wf_atom_4c1c1986(ternary, "FullMask", 6, v16 * 400)
	__wf_atom_ec43d06e(mMovie, ternary .. ".FullMask", 8, { 5, 6 }, { 400, 400 }, v15)
	v9 = module.PlaySound(purchaseHoldSound)
end

local function fn10()
	if not flag2 then
		return
	end

	local v14 = fn4(v6)
	local _ = v5 / 1.2
	local ternary = module.Ternary(
		v14.mCurrentLevel > 0,
		v14.mClipName .. ".PipContainer.Pip" .. v14.mCurrentLevel,
		v14.mClipName
	)
	__wf_atom_ec43d06e(mMovie, ternary .. ".Full", 8, { 12 }, { 0 }, v5, 0.4)

	if not __wf_atom_7e8ad928(v9) then
		v9:Stop(false)
	end

	flag2 = false
	v6 = 0

	if not __wf_atom_7e8ad928(v7) then
		v7:Destroy()
	end
end

function OnNodeFocus(p)
	if flag3 then
		return
	end

	local skillNode = fn4(p)

	if skillNode == nil then
		return
	end

	if not (skillNode.mAvailable or skillNode.mActive) then
		__wf_atom_ec43d06e(mMovie, skillNode.mClipName .. ".Label", 8, { 12 }, { 60 }, 0.2)
	end

	local v14 = skillNode.mClipName .. ".Glow"

	if skillNode.mCurrentLevel > 0 then
		if mMovie:__wf_atom_5e6e15c8(skillNode.mClipName .. ".PipContainer.Pip" .. skillNode.mCurrentLevel, 12) > 0 then
			v14 = skillNode.mClipName .. ".PipContainer.Pip" .. skillNode.mCurrentLevel .. ".Glow"
		elseif skillNode.mCurrentLevel > 1 then
			v14 = skillNode.mClipName .. ".PipContainer.Pip" .. skillNode.mCurrentLevel - 1 .. ".Glow"
		end
	end

	__wf_atom_ec43d06e(mMovie, v14, 8, { 12 }, { 30 }, 0.2)
	module.PlaySound(hoverSound)
	fn6(skillNode)
end

function OnNodeUnfocus(p)
	_T.InfoPopup_Data = nil

	if flag3 then
		return
	end

	local v14 = fn4(p)

	if v14 == nil then
		return
	end

	if not (v14.mAvailable or v14.mActive) then
		__wf_atom_ec43d06e(mMovie, v14.mClipName .. ".Label", 8, { 12 }, { 0 }, 0.2)
	end

	fn10()
	__wf_atom_ec43d06e(mMovie, v14.mClipName .. ".Glow", 8, { 12 }, { 0 }, 0.2)
	local v15 = 1

	while
		mMovie:__wf_atom_253d7085(v14.mClipName .. ".PipContainer.Pip" .. v15)
		and mMovie:__wf_atom_5e6e15c8(v14.mClipName .. ".PipContainer.Pip" .. v15, 12) > 0
	do
		__wf_atom_ec43d06e(mMovie, v14.mClipName .. ".PipContainer.Pip" .. v15 .. ".Glow", 8, { 12 }, { 0 }, 0.2)
		v15 += 1
	end
end

function OnNodePressed(p)
	if flag3 then
		return
	end

	fn9(p)
end

function OnNodeReleased(_)
	if flag3 then
		return
	end

	fn10()
end

local function fn11()
	for _, v14 in pairs(v2) do
		local mId = v14.mId
		local v15 = v .. ".Node" .. mId

		if mMovie:__wf_atom_253d7085(v15) then
			mMovie:OverrideMaterial(v15 .. ".Full", skillPointFillMaterial)

			for i = 1, math.max(v14.mNumLevels - 1, 1) do
				local v16 = v15 .. ".PipContainer.Pip" .. i

				if not mMovie:__wf_atom_253d7085(v16) then
					__wf_atom_86cbd68d(mMovie, v15 .. ".PipContainer.Pip1.duplicateMovieClip", "Pip" .. i, i)
				end

				mMovie:__wf_atom_4c1c1986(v16, "Full", 11, _G.UIColor_BlueGreen)
				mMovie:__wf_atom_4c1c1986(v16, "Empty", 11, _G.UIColor_Yellow)
				mMovie:__wf_atom_e57658c2(v16, 16, -50 * (i - 1) + 25 * (v14.mNumLevels - 2))
				local mCurrentLevel = v14.mCurrentLevel

				for _, v17 in ipairs(v10) do
					if v17.mNodeRes == v14.mNodeRes then
						mCurrentLevel += 1
					end
				end

				local v17 = i <= mCurrentLevel - 1
				local v18

				if v14.mNumLevels > 1 then
					v18 = mCurrentLevel > 0
				else
					v18 = false
				end

				local ternary = module.Ternary(v14.mAvailable or v17, 100, 30)
				mMovie:OverrideMaterial(v16 .. ".Full", skillPointFillMaterial)
				mMovie:OverrideMaterial(v16 .. ".Empty", module.Ternary(v17, skillPointFillMaterial, nil))
				mMovie:__wf_atom_4c1c1986(v16, "Glow", 12, 0)

				if not v13 then
					mMovie:__wf_atom_e57658c2(v16, 12, module.Ternary(v18, 100, 0))
					mMovie:__wf_atom_4c1c1986(v16, "Full", 12, module.Ternary(v17, 100, 0))
					mMovie:__wf_atom_4c1c1986(v16, "Empty", 12, ternary)
				end

				__wf_atom_ec43d06e(mMovie, v16, 8, { 12 }, { module.Ternary(v18, 100, 0) }, 0.5)
				__wf_atom_ec43d06e(
					mMovie,
					v16 .. ".Full",
					8,
					{ 12, 5, 6 },
					{ module.Ternary(v17, 100, 0), 100, 100 },
					0.5
				)
				__wf_atom_ec43d06e(mMovie, v16 .. ".Empty", 8, { 12 }, { ternary }, 0.5)
			end

			local mName = v14.mCard.mName
			mMovie:__wf_atom_4c1c1986(v15, "Label", 44, _G.UIColor_Beige)
			local ternary = module.Ternary(v14.mActive, 100, 60)
			local mAvailable = v14.mAvailable or v14.mActive
			local ternary2 = module.Ternary(mAvailable, ternary, 0)
			mMovie:__wf_atom_4c1c1986(v15, "Label", 12, ternary2)
			mMovie:__wf_atom_48bd5a59(v15, "Label", 36, mName)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v15, 2)
			local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v15, "Label", 40)
			local __wf_atom_97cd8326 = mMovie:__wf_atom_97cd8326()

			if mMovie:__wf_atom_cfc41e35(v15, "Label", 43) > 1 then
				__wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v15, "Label", 14)
			end

			local v16 = __wf_atom_5e6e15c8 + __wf_atom_cfc41e35

			if __wf_atom_97cd8326 - 100 < v16 then
				mMovie:__wf_atom_4c1c1986(v15, "Label", 0, -30 - __wf_atom_cfc41e35)
			end

			if math.abs(mMovie:__wf_atom_5e6e15c8("Container.BgAmount", 3) - mMovie:__wf_atom_5e6e15c8(v15, 3)) < 20 then
				mMovie:__wf_atom_4c1c1986(v15, "Label", 0, -30 - __wf_atom_cfc41e35)
			end

			local ternary3 = module.Ternary(mAvailable, 100, 60)
			local ternary4 = module.Ternary(mAvailable, 100, 0)

			if not v13 then
				mMovie:__wf_atom_4c1c1986(v15, "Full", 12, module.Ternary(v14.mActive, 100, 0))
				mMovie:__wf_atom_4c1c1986(v15, "Empty", 12, module.Ternary(v14.mActive, 0, ternary3))
				mMovie:__wf_atom_4c1c1986(v15, "Unlocked", 12, module.Ternary(v14.mActive, 0, ternary4))
				mMovie:__wf_atom_e57658c2(v15, 12, 0)
				__wf_atom_ec43d06e(mMovie, v15, 8, { 12 }, { 100 }, 0.5)
			end

			__wf_atom_ec43d06e(
				mMovie,
				v15 .. ".Full",
				8,
				{ 12, 5, 6 },
				{ module.Ternary(v14.mActive, 100, 0), 100, 100 },
				0.2
			)
			mMovie:__wf_atom_4c1c1986(v15, "FullMask", 5, 500)
			mMovie:__wf_atom_4c1c1986(v15, "FullMask", 6, 500)
			__wf_atom_ec43d06e(mMovie, v15 .. ".Empty", 8, { 12 }, { module.Ternary(v14.mActive, 0, ternary3) }, 0.5)
			__wf_atom_ec43d06e(mMovie, v15 .. ".Unlocked", 8, { 12 }, { module.Ternary(v14.mActive, 0, ternary4) }, 0.5)
		else
			print("ERROR: wrong skill index")
		end
	end

	v13 = true
end

function OnSaveLoadOutComplete()
	module5.OnSaveLoadOutCompleteCommon("")
	module5.RequestLoadOutBuild(gRegion:__wf_atom_eab484a7())
	flag4 = false
end

local function fn12()
	flag4 = true
	local inventory = gGameData:GetInventory()
	local __wf_atom_c132f79b = inventory:__wf_atom_c132f79b(0, inventory:__wf_atom_d25917b6(0))
	gGameData:__wf_atom_efd6bfce(0, __wf_atom_c132f79b)
	gGameData:__wf_atom_993aebc4("OnSaveLoadOutComplete")
end

function OnSkillCommitResult(p, _)
	v10 = {}
	v8 = nil
	flag = false

	if not p then
		print("ERROR: committing skills to db failed!")
	end

	v3 = module3.GetEnvoyInventoryControl():__wf_atom_dfb755f8(skillTreeSelected)
	fn8()
	fn11()
	fn12()
	module.PlaySound(purchaseDoneSound)
end

local function fn13(p)
	return v2[p]
end

local function fn14()
	local __wf_atom_bf6d2e64 = skillTreeSelected:__wf_atom_bf6d2e64()
	local v14 = __wf_atom_bf6d2e64 < 1 and 1 or __wf_atom_bf6d2e64
	v = "Container.Nodes" .. v14
	local v15 = 1

	while mMovie:__wf_atom_253d7085("Container.Nodes" .. v15) do
		if v15 == v14 and not asyncLoader:IsLoadingTag("SkillTreeLines") then
			mMovie:__wf_atom_2dedec1a(v, 13, false)
			asyncLoader:LoadResource("SkillTreeLines", linesTextures[v14], function(p)
				mMovie:__wf_atom_2dedec1a(v, 13, true)
				mMovie:__wf_atom_c90af43a(v .. ".Lines", Resource(p))
			end)
		else
			mMovie:__wf_atom_2dedec1a("Container.Nodes" .. v15, 13, false)
		end

		v15 += 1
	end

	fn7()
	local v16 = 1

	while mMovie:__wf_atom_253d7085(v .. ".Node" .. v16) do
		mMovie:__wf_atom_50d60589(v .. ".Node" .. v16 .. ".Label", 36, (tostring(v16)))
		mMovie:__wf_atom_e57658c2(v .. ".Node" .. v16 .. ".Label", 12, 100)
		mMovie:__wf_atom_2dedec1a(v .. ".Node" .. v16, 13, false)
		v16 += 1
	end

	mMovie:OverrideMaterial(v .. ".Lines", linesMaterial)
	local envoyInventoryControl = module3.GetEnvoyInventoryControl()
	rank = envoyInventoryControl:__wf_atom_9114aa52(skillTreeSelected)
	v3 = envoyInventoryControl:__wf_atom_dfb755f8(skillTreeSelected)
	v4 = envoyInventoryControl:__wf_atom_72055871(skillTreeSelected)

	if __wf_atom_7e8ad928(v4) then
		v4 = {}
	end

	mMovie:__wf_atom_50d60589(
		"Container.Rank",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/SkillTree_Rank_Title", false, {
			RANK = rank
		})
	)

	for i = 1, 12 do
		local v17 = v .. ".Node" .. i
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v17, 0)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v17, 1)
		mMovie:__wf_atom_4c1c1986(v17, "Glow", 12, 0)
		mMovie:__wf_atom_4c1c1986(v17, "Empty", 100, i)
		mMovie:SetCallbacks(v17 .. ".Empty", "OnNodeFocus", "OnNodeUnfocus", "OnNodeReleased", "OnNodePressed")
		local total = 0

		for j = 1, 12 do
			if j == i then
				continue
			end

			local v18 = v .. ".Node" .. j
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(v18, 0)
			local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8(v18, 1)

			if not (__wf_atom_5e6e15c8 < __wf_atom_5e6e15c8_3 and __wf_atom_5e6e15c8_3 - __wf_atom_5e6e15c8 < 400 and math.abs(__wf_atom_5e6e15c8_2 - __wf_atom_5e6e15c8_4 + total) < 20) then
				continue
			end

			total += math.sign(__wf_atom_5e6e15c8_2 - __wf_atom_5e6e15c8_4) * (20 - math.abs(__wf_atom_5e6e15c8_2 - __wf_atom_5e6e15c8_4)) * 0.5
		end

		mMovie:__wf_atom_4c1c1986(v17, "Label", 1, total - 20)
	end

	local __wf_atom_5047b73c = skillTreeSelected:__wf_atom_5047b73c()
	local nodeTypes = {}
	local v17 = {}

	for i, node in ipairs(__wf_atom_5047b73c.nodes) do
		__wf_atom_5047b73c:__wf_atom_0e1ca7ba(i)
		local nodeType = __wf_atom_5047b73c.nodeTypes[i]
		local v18 = __wf_atom_5047b73c.indices[i]

		if
			not (v18 > 0)
			or not (v18 < 100)
			or not nodeType:IsA(__wf_atom_58a409f1)
			or nodeType:IsA(Type("/SF/Types/Game/SFSkillTree"))
		then
			continue
		end

		table.insert(nodeTypes, nodeType)
		table.insert(v17, { Index = __wf_atom_5047b73c.indices[i], Id = node, Type = nodeType })
	end

	table.sort(v17, function(a, b)
		return a.Index < b.Index
	end)
	asyncLoader:LoadMultipleResources("Nodes", nodeTypes, function()
		v2 = {}

		for _, v18 in ipairs(v17) do
			local v19 = Resource(v18.Type)
			local mAvailable = v19:__wf_atom_2ecb3e75() <= v3
			local __wf_atom_576f6429 = v19:__wf_atom_576f6429()
			local v20 = false
			local v21 = 0

			for _, v22 in v4 do
				if not v22.mItemType:IsA(v19) then
					continue
				end

				v20 = true
				v21 = 1
				break
			end

			fn(v18.Index, v18.Id, v19, 0, 0, v20, mAvailable, __wf_atom_576f6429, v21)
			mMovie:__wf_atom_2dedec1a(v .. ".Node" .. v18.Index, 13, true)
		end

		for i = 1, #__wf_atom_5047b73c.edgePairs, 2 do
			local v18 = fn13(__wf_atom_5047b73c.edgePairs[i])

			if v18 == nil then
				continue
			end

			local v19 = fn13(__wf_atom_5047b73c.edgePairs[i + 1])

			if v19 == nil then
				continue
			end

			table.insert(v18.mChildren, v19.mSkillId)
			v19.mParentId = v18.mSkillId
		end

		fn8()
		fn11()
	end)
end

local function fn15(_) end

function onKeyDown_MENU_MOUSE_Z(_, p)
	fn15(p)
end

local function fn16()
	mMovie:__wf_atom_2dedec1a("EditModeLabel", 13, false)
end

local function fn17() end

function ShowResetSkillsPrompt()
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = "/SF/Language/Progression/SkillTree_Reset_Skills_Prompt"
	dialogSettings:SetCallback("ResetSkills")
	module.ShowCustomMessage(dialogSettings)
end

function ResetSkills(p)
	if tonumber(p) ~= 4 then
		return
	end

	flag5 = true
	local v14 = module3.GetEnvoyInventoryControl():__wf_atom_72055871(skillTreeSelected) or {}
	local skillUpgradeInfos = {}

	for _, v15 in ipairs(v14) do
		local skillUpgradeInfo = SF.SkillUpgradeInfo()
		skillUpgradeInfo.mItemType = v15.mItemType
		skillUpgradeInfo.mLevel = 255
		table.insert(skillUpgradeInfos, skillUpgradeInfo)
	end

	local skillTreeInfo = SF.SkillTreeInfo()
	skillTreeInfo.mItemType = skillTreeSelected
	skillTreeInfo.mSkills = skillUpgradeInfos
	gGameData:__wf_atom_1a95290c({ skillTreeInfo }, "OnSkillCommitResult")
end

function AdvanceAndShutdown()
	if flag3 then
		return
	end

	v12 = false
	fn10()

	if flag5 then
		fn12()
	end

	flag3 = true
	module.PlaySound(closeSound)
	mMovie:__wf_atom_0c1c47f2(nil)
	_T.InfoPopup_Data = nil
	_T.OnReturnToArsenal()
	module3.DissolveOut(mMovie, function()
		if flag4 then
			v12 = true
		else
			mMovie:Close()
		end
	end)
end

function Initialize()
	mMovie:__wf_atom_dac78d3d(true)

	if __wf_atom_7e8ad928(_T.SkillTreeSelected) then
		mMovie:Close()
		return
	end

	module3.ShowBackground({ mFade = module.RIGHT_ALIGNED })
	mMovie:__wf_atom_e57658c2("Container.Title", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_2dedec1a("Container.Rank", 13, false)
	mMovie:__wf_atom_e57658c2("Container.Backer", 12, 80)
	mMovie:__wf_atom_e57658c2("Container.Backer", 11, 2103571)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Container.LineLeft.Inner", 14)
	mMovie:__wf_atom_e57658c2("Container.LineLeft", 12, 60)
	mMovie:__wf_atom_e57658c2("Container.LineRight", 12, 60)
	mMovie:OverrideMaterial("Container.LineLeft.Inner", backerLineMat)
	mMovie:OverrideMaterial("Container.LineRight.Inner", backerLineMat)

	if not __wf_atom_7e8ad928(backerLineMat) then
		backerLineMat:__wf_atom_a042ff6c(Symbol("TileRepeats"), __wf_atom_5e6e15c8 / 32, 1)
	end

	skillTreeSelected = _T.SkillTreeSelected
	fn14()
	fn16()
	module3.DissolveIn(mMovie)
	module.PlaySound(openSound)
	local v14 = {}
	table.insert(v14, {
		Label = "/SF/Language/Progression/SkillTree_Reset_Skills",
		CallBack = function()
			if not flag3 then
				mMovie:Execute("ShowResetSkillsPrompt", nil)
			end
		end,
		CallOut = "MENU_GENERIC1"
	})
	table.insert(v14, {
		Label = "/Lotus/Language/Menu/Global_Back",
		CallBack = function()
			if not flag3 then
				mMovie:Execute("AdvanceAndShutdown", nil)
			end
		end,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v14, getfenv(1))
	end
end

local function fn18(p)
	if flag then
		return
	end

	local v14 = fn4(p)

	if not (v14 ~= nil and v14.mAvailable and v14.mNumLevels ~= v14.mCurrentLevel) then
		return
	end

	local skillUpgradeInfo = SF.SkillUpgradeInfo()
	skillUpgradeInfo.mItemType = v14.mNodeRes
	skillUpgradeInfo.mLevel = v14.mCurrentLevel
	local skillTreeInfo = SF.SkillTreeInfo()
	skillTreeInfo.mItemType = skillTreeSelected
	skillTreeInfo.mSkills = { skillUpgradeInfo }
	flag5 = true
	flag = true
	v5 = 0
	v8 = v14
	table.insert(v10, v14)
	local ternary = module.Ternary(
		v14.mCurrentLevel > 0,
		v14.mClipName .. ".PipContainer.Pip" .. v14.mCurrentLevel,
		v14.mClipName
	)

	if not __wf_atom_7e8ad928(v7) then
		v7:Destroy()
	end

	module.CreateUIParticles(mMovie, ternary .. ".Full", unlockedFx, 0, 0)
	fn8()
	fn11()
	gGameData:__wf_atom_1a95290c({ skillTreeInfo }, "OnSkillCommitResult")
end

function Update()
	local v14 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v14)
	asyncLoader:Update()

	if flag2 then
		v5 += v14

		if v5 >= 1.2 then
			fn18(v6)
			flag2 = false
			v6 = 0
		end
	else
		v5 -= v14
	end

	v5 = __wf_atom_421b01aa(v5, 0, 1.2)

	if v12 and not flag4 then
		v12 = false
		mMovie:Close()
	end
end

function Shutdown()
	_T.SkillTreeSelected = nil
	_T.SkillTreeLocOverride = nil
	_T.InfoPopup_Data = nil
end

function onRawInputEvent(_, p, p2, _)
	if p == "EN_LSHIFT" or p == "EN_RSHIFT" then
		v11 = p2 == "1"
	end

	if not v11 then
		return
	end

	if p == "EN_E" and p2 == "1" then
		fn17()
	end
end

function onKeyDown_MENU_CANCEL(_, _)
	AdvanceAndShutdown()
	return true
end