local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.Libs.TimerMgr")
local module3 = require("EE.Interface.AnchorMgr")
local v = nil
local v2 = nil
local flag = false
local autoCloseEndCard = _T.AutoCloseEndCard
local v3 = nil

local function fn()
	if flag then
		gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(0)
	end
end

function ResourceReady()
	mMovie:__wf_atom_933bbce0("Image", v3, imageMaterial)
	__wf_atom_ec43d06e(mMovie, "Image", 2, { 12, 5, 6 }, { 100, 165, 165 }, 15, 3)
	__wf_atom_ec43d06e(mMovie, "LeftDetails", 8, { 12 }, { 100 }, 15, 3)
	__wf_atom_ec43d06e(mMovie, "RightDetails", 8, { 12 }, { 100 }, 15, 3)
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 3, 30, Close)
	v2:AddTimer(23.5, function()
		gRegion:PlaySound(revealSound, Vector(), false)
	end)
end

function Initialize()
	v3 = imageTextures[_T.EndCardId or 1]
	_T.EndCardId = nil

	if __wf_atom_7e8ad928(v3) then
		mMovie:Close()
	end

	v = module3.Create(mMovie)
	v:Register(mMovie, "LeftDetails", { v.ANCHOR_H_LEFT })
	v:Register(mMovie, "RightDetails", { v.ANCHOR_H_RIGHT })
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(mMovie, mixEffect, mixingGroup)
	end

	mMovie:__wf_atom_e57658c2("_root", 12, 100)
	mMovie:__wf_atom_e57658c2("Image", 12, 0)
	mMovie:__wf_atom_e57658c2("Backer", 12, 0)
	mMovie:__wf_atom_e57658c2("LeftDetails", 12, 0)
	mMovie:__wf_atom_e57658c2("RightDetails", 12, 0)
	mMovie:OverrideMaterial("LeftDetails", imageMaterial)
	mMovie:OverrideMaterial("RightDetails", imageMaterial)
	__wf_atom_ec43d06e(mMovie, "Backer", 8, { 12 }, { 100 }, 7.5, 3, fn)
	mMovie:__wf_atom_e57658c2("Image", 5, 300)
	mMovie:__wf_atom_e57658c2("Image", 6, 300)
	v2 = module2.CreateTimerMgr()
	gGameRules:RequestResource(v3:__wf_atom_5b41f63b(), "ResourceReady")
	_T.ProgressionScreenDisabled = true
	onViewportSizeChanged(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

function Update()
	local v4 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v4)
	v2:Update(v4)
end

function Shutdown()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(mMovie, mixEffect, mixingGroup)
	end

	_T.ProgressionScreenDisabled = false
	_T.AutoCloseEndCard = nil
end

function Close()
	if autoCloseEndCard or flag then
		mMovie:Close()
	end
end

function onViewportSizeChanged(p, p2)
	if not __wf_atom_7e8ad928(v) then
		v:Update(p, p2)
	end

	local v4 = mMovie:__wf_atom_97cd8326() / mMovie:__wf_atom_54eeda24()
	local screenDimensions, v5 = module.GetScreenDimensions(mMovie)

	if screenDimensions / v5 < v4 then
		mMovie:__wf_atom_e57658c2("Backer", 15, v5)
		local v6 = v5 * v4
		mMovie:__wf_atom_e57658c2("Backer", 14, v6)
	else
		mMovie:__wf_atom_e57658c2("Backer", 14, screenDimensions)
		mMovie:__wf_atom_e57658c2("Backer", 15, screenDimensions / v4)
	end

	local v6 = v5 * 0.984
	mMovie:__wf_atom_e57658c2("LeftDetails", 15, v6)
	mMovie:__wf_atom_e57658c2("RightDetails", 15, v6)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("LeftDetails", 6)
	mMovie:__wf_atom_e57658c2("LeftDetails", 5, __wf_atom_5e6e15c8)
	mMovie:__wf_atom_e57658c2("RightDetails", 5, __wf_atom_5e6e15c8)
end

function onKeyDown_MENU_CANCEL() end

function OpenFileFlashMovie()
	flag = true
end