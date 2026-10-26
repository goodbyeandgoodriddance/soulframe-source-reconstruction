local v = 0
local playerWolfAvatar = nil

function EMO_START(object)
	playerWolfAvatar = object:__wf_atom_e919fb8e().PlayerWolfAvatar

	if not __wf_atom_7e8ad928(playerWolfAvatar) then
		v = playerWolfAvatar:__wf_atom_ccd337ec(commandBbSymbol)

		if not __wf_atom_7e8ad928(v) and v ~= 0 then
			playerWolfAvatar:__wf_atom_cecb2d55(commandBbSymbol, 0)
		end

		playerWolfAvatar:__wf_atom_cecb2d55(commandBbSymbol, petCommand)
	end
end