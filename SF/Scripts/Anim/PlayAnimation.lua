local v = 7
local v2 = 16

function PlayContextActionAnim(_, object)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_921c1a5f(activateAnim, false, 2, 1, true)
	end

	if not __wf_atom_7e8ad928(portForwarder) then
		Sleep(portForwarderDelay)
		portForwarder:FirePort("TriggerPort")
	end
end

function NpcSpawnPointAnimation(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:__wf_atom_921c1a5f(anim, false)
	end
end

function PlayStaggerReaction(p, object)
	if not __wf_atom_7e8ad928(object) then
		local damageData = Engine.DamageData()
		damageData.baseAmount = 0
		damageData:__wf_atom_7498285f(v, 1)
		damageData:__wf_atom_d6f4d914(v2, true)
		damageData:__wf_atom_6b472125(p)
		object:__wf_atom_649bf33e(damageData)
	end
end