local module = require("Lotus.Interface.TextSuggest")
local module2 = require("EE.Interface.Utilities")
local v = nil

function IMESetOptions(p)
	module.IMESetOptions(p, mMovie, true)
end

function IMESetFocusedOption(p)
	module.IMESetFocusedOption(p, mMovie)
end

function IMESetTip(p)
	module.IMESetTip(p, mMovie)
end

function IMESetTipCursor(p)
	module.IMESetTipCursor(p, mMovie)
end

function OpenIME()
	module.OpenIME(mMovie)
end

function CloseIME()
	module.CloseIME(mMovie)
end

function Initialize()
	module.Initialize(mMovie)
	__wf_atom_8e4fda44:__wf_atom_69d8bc02("IMESetOptions")
	__wf_atom_8e4fda44:__wf_atom_a36cfa04("IMESetFocusedOption")
	__wf_atom_8e4fda44:__wf_atom_db71286e("IMESetTip")
	__wf_atom_8e4fda44:__wf_atom_c4955da2("IMESetTipCursor")
	__wf_atom_8e4fda44:__wf_atom_a5bb70e4("OpenIME")
	__wf_atom_8e4fda44:__wf_atom_45cfe667("CloseIME")
	mMovie:__wf_atom_0b73c540(true)
end

function Shutdown()
	__wf_atom_8e4fda44:__wf_atom_70f29c09()
end

function Update()
	if __wf_atom_7e8ad928(v) then
		v = __wf_atom_8e4fda44:FindMovie(module2.GetChatMovie())
	end

	if __wf_atom_7e8ad928(v) then
		mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	else
		mMovie:__wf_atom_f0448d34(v:__wf_atom_65909d99() or _T.RadialSolarMapOpen == true)
	end

	if module then
		module.Update()
	end
end

function TipOptionFocused(p)
	module.IMEMouseOver(p)
	module.IMESetFocusedOption(p, mMovie)
end

function TipOptionUnfocused(p)
	module.IMEMouseOff(p)
end

function TipOptionClicked(p)
	module.IMESetFocusedOption(p, mMovie)
	module.IMEClickedOption(p, mMovie)
end