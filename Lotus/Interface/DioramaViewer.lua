local module = require("Lotus.Interface.Libs.DioramaLoader")
local v = nil
local v2 = 0
local v3 = 0
local total = 0
local flag = false
local v4 = true
local flag2 = false
local v5 = false
local v6 = nil

local function fn(p, p2)
	v2 = p
	v3 = p2
	total = 0
	mMovie:__wf_atom_0cf0fdbe(v2)
end

local function fn2()
	v5 = true

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, nil)
	end

	flag = true
	fn(0, 1)
end

local function fn3()
	local v7

	if flag2 then
		v7 = {}
		table.insert(v7, {
			Label = "/Lotus/Language/Menu/Exit",
			CallBack = fn2,
			CallOut = "MENU_CANCEL"
		})
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v7, getfenv(1))
	end
end

function Initialize()
	mMovie:__wf_atom_7df746cd(0)
	gGameRules:__wf_atom_411c9025(true)
	fn3()
end

function SetLoadedCallback(p)
	v6 = p
end

function LoadDiorama(p)
	fn(0, 1)
	local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

	if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
		__wf_atom_b56d2aa8:SetVisible(false)
	end

	v = module.CreateDioramaLoader(mMovie)
	local v7 = WeakResource(p)
	v:LoadDiorama(v7)
	v.mSyncAvatars = false
	return true
end

function CloseDiorama()
	fn2()
end

function Shutdown()
	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(false)
	end
end

function Update()
	if v2 == v3 then
		if v and v:IsLoading() then
			if v:LoadingComplete() then
				v:FinishLoad()
				fn(1, 0)
				v4 = false

				if not __wf_atom_7e8ad928(v6) then
					_T[v6]()
					_T[v6] = nil
					v6 = nil
				end
			end
		elseif flag then
			if v2 == 1 then
				fn(1, 0)

				if not __wf_atom_7e8ad928(__wf_atom_392793db) then
					__wf_atom_8e4fda44:__wf_atom_62a19abc()
					gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(0, 1)
				end
			else
				local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

				if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
					__wf_atom_b56d2aa8:SetVisible(true)
				end

				mMovie:Close()
			end
		end
	else
		total += __wf_atom_084b3e93()
		v2 = __wf_atom_421b01aa(__wf_atom_104bfe98(v2, v3, total / 1), 0, 1)
		mMovie:__wf_atom_0cf0fdbe(v2)
	end
end

function EnableManualClose()
	flag2 = true
	mMovie:__wf_atom_dac78d3d(true)
	fn3()
end

function onKeyDown_MENU_SELECT()
	if flag2 and not (flag or v4) then
		fn2()
	end

	return true
end

function onKeyDown_MENU_CANCEL()
	if flag2 and not (flag or v4) then
		fn2()
	end

	return true
end

function onRawInputEvent(_, p, _)
	if p ~= "EN_SPACE" then
		return nil
	end

	if flag2 and not (flag or v4) then
		fn2()
	end

	return 1
end

function IsInputBlocked()
	return v5
end