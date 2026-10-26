local v = Symbol("ShrineStags")
local module = require("SF.Scripts.Libs.StatsLib")

function RotateStatue(object)
	if _T.StagShrinePuzzleSolved then
		return
	end

	local flag = true

	for i = 1, 4 do
		if _T.shrineSolve and _T.shrineSolve[i] then
			continue
		end

		flag = false
		break
	end

	if flag then
		return
	end

	local nearestTagged = gRegion:FindNearestTagged(v, object:GetPosition())

	if __wf_atom_7e8ad928(nearestTagged) then
		return
	end

	if not _T.shrineSolve then
		_T.shrineSolve = {}
	end

	_T.shrineSolve[id] = false
	object:Disable()
	nearestTagged:PlaySound(turnSound, false)
	local __wf_atom_dc309f8a = nearestTagged:__wf_atom_dc309f8a()
	local heading = __wf_atom_dc309f8a.heading
	local v2 = 0

	while v2 < 1 do
		v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93(), 0, 1)
		__wf_atom_dc309f8a.heading = heading + 90 * __wf_atom_24a82b69(v2)
		nearestTagged:__wf_atom_9b788a35(__wf_atom_dc309f8a)
		Sleep(0)
	end

	object:Enable()
	local v3 = math.abs((gRegion:__wf_atom_0a6a5887(Symbol("TileRotationRef")):__wf_atom_dc309f8a() + nearestTagged:__wf_atom_dc309f8a()).heading - goalHeading)

	if v3 >= 315 then
		v3 -= 360
	end

	if v3 > 45 then
		return
	end

	_T.shrineSolve[id] = true

	if not (_T.shrineSolve[1] and _T.shrineSolve[2] and _T.shrineSolve[3] and _T.shrineSolve[4]) then
		return
	end

	object:Disable()
	_T.StagShrinePuzzleSolved = true
	module.ReplicateLogEvent("STAG_QUEST", "SolveStagPuzzle")
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v, object:GetPosition(), 0, 20)

	for i = 1, #__wf_atom_439c0d29 do
		local v4 = __wf_atom_439c0d29[i]
		v4:SetMaterialParam(Symbol("EmissiveMapAtten"), 4, 4, 4, 4)
		v4:PlaySound(correctSound, false)
		Sleep(math.random(0.3, 0.3))
	end

	Sleep(1)

	if gRegion:IsMaster() then
		gRegion:FindNearestTagged(Symbol("VineOpenScriptPuzzle"), object:GetPosition()):FirePort("Execute")
	end
end