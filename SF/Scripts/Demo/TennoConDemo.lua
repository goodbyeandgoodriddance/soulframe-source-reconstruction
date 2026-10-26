local function fn(p)
	if not __wf_atom_7e8ad928(p) then
		levelToLoad = p
	end

	if not __wf_atom_7e8ad928(levelToLoad) then
		local levelArgs = Engine.OpenLevelArgs()
		levelArgs.level = levelToLoad
		levelArgs.menuMovie = __wf_atom_c67f9605:__wf_atom_cf8a801d()
		levelArgs.gameRules = gClient:__wf_atom_2aee259b()
		levelArgs.restartLevel = false
		Engine.OpenLevel(levelArgs)
	end
end

function LoadLevel()
	fn()
end

function DemoMenuLevel()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DemoMenuPlayerSpawn"))

	if gRegion:__wf_atom_c4f78a8f():__wf_atom_8a6b8fc3(__wf_atom_0a6a5887) > 1 then
		return
	end

	gRegion:__wf_atom_0a6a5887(Symbol("PostLoginCin")):FirePort("StartPlaying")
end

function RunScriptTrigger(object)
	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	while not gClient:__wf_atom_2ad290b4() do
		Sleep(0)
	end

	while __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f()) do
		Sleep(0)
	end

	object:FirePort("Execute")
end