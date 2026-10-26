function SoulModeEntitySpawned(object)
	_T.NeedSoulModeVisUpdate = true

	if not soulModeAlwaysOn then
		object:__wf_atom_b811702e(Symbol("SOUL_MODE_HIDDEN_UPGRADED"))
	end
end