local flag = false
local v = 1
local v2 = ""
local module = require("EE.Interface.Utilities")

function BumperMovieLoaded()
	mMovie:__wf_atom_2dedec1a("_root", 13, true)
end

function Initialize()
	mMovie:__wf_atom_c90af43a("Image", loadingTexture)
	mMovie:__wf_atom_933bbce0("Spinner.Bird", spinnerTexture, spinnerMaterial)

	if not (__wf_atom_a0f6588f:__wf_atom_f89aa44a() or _G.gHasLoggedIn) then
		mMovie:__wf_atom_2dedec1a("_root", 13, false)
		__wf_atom_8e4fda44:__wf_atom_3e5e23c0(bumperMovie, "BumperMovieLoaded")
	end
end

function onViewportSizeChanged(_, _, _, _)
	local screenDimensions, _ = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("Image", 15, screenDimensions / (16 / 9))
	mMovie:__wf_atom_e57658c2("Image", 14, screenDimensions)
end

function Update()
	if gClient == nil then
		return
	end

	local __wf_atom_c845fddd = gClient:__wf_atom_c845fddd()

	if v2 ~= __wf_atom_c845fddd then
		v2 = __wf_atom_c845fddd
		mMovie:__wf_atom_7d7314f1("Task.text", __wf_atom_c845fddd)
	end

	local _ = 1 + gClient:__wf_atom_1c43a79b() * 100
	local v3 = __wf_atom_104bfe98(10, 50, (math.abs((math.sin(__wf_atom_4658d645(Time() * 1) * 3.141592653589793)))))
	mMovie:__wf_atom_e57658c2("Center", 12, v3)

	if
		not flag
		and not __wf_atom_4483393f:Applet()
		and (gClient:__wf_atom_328bcb8f() or gClient:__wf_atom_acb6a4f2())
	then
		v = 1
		_T.LoadingScreenTransOut = true
		flag = true
	end

	if flag then
		v -= 30 / 29 * __wf_atom_084b3e93()
		local v4 = __wf_atom_421b01aa(v, 0, 1)
		mMovie:__wf_atom_0cf0fdbe(v4)
		mMovie:__wf_atom_e57658c2("_root", 12, v4 * 100)

		if v4 <= 0 then
			mMovie:Close()
		end
	end
end