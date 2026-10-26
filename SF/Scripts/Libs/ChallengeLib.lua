module(..., package.seeall)
local v = Symbol("BOSS_COMPLETE")
local v2 = Symbol("SUBBOSS_COMPLETE")

function NotifyTagAllPlayers(p)
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v3 in ipairs(__wf_atom_3c8e1a7a) do
		__wf_atom_539492fe:__wf_atom_8b4524e6(v3, p)
	end
end

function NotifyBossComplete()
	NotifyTagAllPlayers(v)
end

function NotifySubbossComplete(p)
	if not p then
		return
	end

	NotifyTagAllPlayers(v2)
end