local module = require("EE.Interface.Utilities")
require("SF.Interface.SFUtilities")
local module2 = require("SF.Scripts.Libs.JobsLib")
local availableJobs = {}
local flag = false
local uiParticles = {}

local function fn(i)
	local v = "Pin" .. i
	mMovie:__wf_atom_c90af43a(v .. ".Backer", backerTexture)
	mMovie:OverrideMaterial(v .. ".Backer", backerMaterial)
	mMovie:OverrideMaterial(v .. ".Glow", glowMaterial)
	mMovie:__wf_atom_c90af43a(v .. ".Icon", pinTexture)
	mMovie:__wf_atom_c90af43a(v .. ".Glow", glowTexture)
	mMovie:__wf_atom_4c1c1986(v, "Text", 11, _G.UIColor_Beige)
	mMovie:__wf_atom_4c1c1986(v, "Icon", 14, 40)
	mMovie:__wf_atom_4c1c1986(v, "Icon", 15, 40)
	mMovie:__wf_atom_7f57ab2f(v, "Backer", 13, false)
	mMovie:__wf_atom_7f57ab2f(v, "Text", 13, false)
	mMovie:__wf_atom_e57658c2(v, 100, i)
	mMovie:__wf_atom_2dedec1a(v, 13, true)
	mMovie:__wf_atom_7f57ab2f(v, "Glow", 67, false)
	mMovie:SetCallbacks(v, "OnNodeFocus", "OnNodeUnfocus", "OnNodeReleased", "OnNodePressed")
	mMovie:__wf_atom_e57658c2(v, 12, 0)
	__wf_atom_ec43d06e(mMovie, v, 8, { 12 }, { 100 }, 0.5)
end

local function fn2(p)
	local v = "Pin" .. p
	local v2 = availableJobs[p]

	if module2.HasActiveJob(v2) then
		mMovie:__wf_atom_4c1c1986(v, "Text", 11, _G.UIColor_Yellow)
		__wf_atom_ec43d06e(mMovie, v .. ".Glow", 8, { 12 }, { 60 }, 0.2)
	else
		mMovie:__wf_atom_4c1c1986(v, "Text", 11, _G.UIColor_Beige)
		__wf_atom_ec43d06e(mMovie, v .. ".Glow", 8, { 12 }, { 0 }, 0.2)
	end
end

local function fn3()
	local v = {}
	table.insert(v, {
		Label = "/Lotus/Language/Menu/Back",
		CallBack = onKeyDown_MENU_CANCEL,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v, getfenv(1))
	end
end

local function fn4()
	availableJobs = _T.AvailableJobs

	for i, availableJob in ipairs(availableJobs) do
		local c_str = availableJob.LocationTag:c_str()
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("JobBoard" .. c_str))

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			print("UpdateJobs error: no waypoint found for location: " .. c_str)
		else
			local position = __wf_atom_0a6a5887:GetPosition()
			local __wf_atom_74b9a49b = mMovie:__wf_atom_74b9a49b(position)

			if not mMovie:__wf_atom_253d7085("Pin" .. i) then
				__wf_atom_86cbd68d(mMovie, "Pin1.duplicateMovieClip", "Pin" .. i, i)
			end

			fn(i)
			fn2(i)
			mMovie:__wf_atom_e57658c2("Pin" .. i, 0, __wf_atom_74b9a49b.x)
			mMovie:__wf_atom_e57658c2("Pin" .. i, 1, __wf_atom_74b9a49b.y)
			mMovie:__wf_atom_48bd5a59("Pin" .. i, "Text", 36, mMovie:__wf_atom_8e9ac384(availableJob.Name, false))
			mMovie:__wf_atom_4c1c1986("Pin" .. i, "Backer", 14, mMovie:__wf_atom_cfc41e35("Pin" .. i, "Text", 40) + 90)
		end
	end

	flag = false
	fn3()
end

function onViewportSizeChanged(_, _, _, _)
	fn4()
end

function Initialize()
	flag = true

	if not __wf_atom_7e8ad928(openSound) then
		module.PlaySound(openSound)
	end

	mMovie:__wf_atom_2dedec1a("Pin1", 13, false)
	mMovie:__wf_atom_50d60589(
		"ClientWarning.Text",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Hub/DeoraJobs_ClientWarning", false)
	)
	mMovie:__wf_atom_e57658c2("ClientWarning.Text", 11, _G.UIColor_Beige)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("ClientWarning.Text", 40)
	mMovie:OverrideMaterial("ClientWarning.Backer", backerMaterial)
	mMovie:__wf_atom_e57658c2("ClientWarning.Backer", 14, __wf_atom_5e6e15c8 + 50)
	mMovie:__wf_atom_50d60589("Info.Text", 36, mMovie:__wf_atom_8e9ac384("/SF/Language/Hub/DeoraJobs_InfoText", false))
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Info.Text", 40)
	mMovie:OverrideMaterial("Info.Backer", infoBackerMaterial)
	mMovie:__wf_atom_e57658c2("Info.Backer", 14, __wf_atom_5e6e15c8_2 + 100)
	mMovie:__wf_atom_e57658c2("Info.Backer", 12, 75)
	mMovie:__wf_atom_e57658c2("Info", 12, 0)
	__wf_atom_ec43d06e(mMovie, "Info", 8, { 12 }, { 100 }, 0.5, 1)
	__wf_atom_ec43d06e(mMovie, "UpdateJobs", 8, {}, {}, 0, 1, fn4)

	if gMatchingService:__wf_atom_1b24a1bb() then
		mMovie:__wf_atom_2dedec1a("ClientWarning", 13, false)
	else
		mMovie:__wf_atom_2dedec1a("ClientWarning", 13, true)
	end
end

function Update()
	local v = gGameRules:__wf_atom_2cec6d56() * 3
	local v2 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v2)
	local v3 = 1

	while mMovie:__wf_atom_253d7085("Pin" .. v3) do
		local v4 = "Pin" .. v3
		mMovie:__wf_atom_4c1c1986(v4, "Glow", 14, math.sin(v) * 10 + 128)
		mMovie:__wf_atom_4c1c1986(v4, "Glow", 15, math.sin(v) * 10 + 128)
		v3 += 1
	end

	for i = #uiParticles, 1, -1 do
		if __wf_atom_7e8ad928(uiParticles[i].mInstance) then
			table.remove(uiParticles, i)
		end
	end
end

function OnNodeFocus(p)
	local v = "Pin" .. p
	__wf_atom_ec43d06e(mMovie, v .. ".Backer", 8, { 12 }, { 100 }, 0.25)
	__wf_atom_ec43d06e(mMovie, v .. ".Text", 8, { 12 }, { 100 }, 0.25, 0.1)
	__wf_atom_ec43d06e(mMovie, v .. ".Icon", 8, { 14, 15 }, { 48, 48 }, 0.25)
	mMovie:__wf_atom_7f57ab2f(v, "Backer", 13, true)
	mMovie:__wf_atom_7f57ab2f(v, "Text", 13, true)
end

function OnNodeUnfocus(p)
	local v = "Pin" .. p
	__wf_atom_ec43d06e(mMovie, v .. ".Backer", 8, { 12 }, { 0 }, 0.25)
	__wf_atom_ec43d06e(mMovie, v .. ".Text", 8, { 12 }, { 0 }, 0.25, 0, function()
		mMovie:__wf_atom_7f57ab2f(v, "Backer", 13, false)
		mMovie:__wf_atom_7f57ab2f(v, "Text", 13, false)
	end)
	__wf_atom_ec43d06e(mMovie, v .. ".Icon", 8, { 14, 15 }, { 40, 40 }, 0.25)
end

function OnNodePressed(p)
	if flag then
		return
	end

	local availableJob = availableJobs[p]

	if module2.HasActiveJob(availableJob) then
		module2.RemoveJob(availableJob)

		if not __wf_atom_7e8ad928(deselectedSound) then
			module.PlaySound(deselectedSound)
		end
	else
		module2.AddJob(availableJob)
		local v = "Pin" .. p
		local uiParticles2 = module.CreateUIParticles(mMovie, v, glowParticleSys, 0, 0)
		table.insert(uiParticles, uiParticles2)

		if not __wf_atom_7e8ad928(selectedSound) then
			module.PlaySound(selectedSound)
		end
	end

	fn2(p)
end

function OnNodeReleased(_) end

function TransitionOut()
	if flag then
		return
	end

	flag = true

	for _, v in uiParticles do
		v:Destroy()
	end

	if not __wf_atom_7e8ad928(closeSound) then
		module.PlaySound(closeSound)
	end

	if _T.BackFromJobs ~= nil then
		_T.BackFromJobs()
	end

	mMovie:Close()
end

function onKeyDown_MENU_CANCEL()
	TransitionOut()
	return true
end