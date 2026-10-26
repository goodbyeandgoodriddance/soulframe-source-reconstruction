function ToggleMotionBlur()
	Sleep(preDelay)

	if not __wf_atom_7e8ad928(deco) then
		deco:__wf_atom_25c58c94(isEnable, true)
	end

	Sleep(delay)

	if not __wf_atom_7e8ad928(deco) and toggleBackAfterDelay then
		deco:__wf_atom_25c58c94(not isEnable, true)
	end
end

function BatchToggleMotionBlur()
	Sleep(preDelay)

	for _, v in ipairs(decos) do
		if not __wf_atom_7e8ad928(v) then
			v:__wf_atom_25c58c94(false, true)
		end
	end

	Sleep(delay)

	if toggleBackAfterDelay then
		for _, v in ipairs(decos) do
			if not __wf_atom_7e8ad928(v) then
				v:__wf_atom_25c58c94(true, true)
			end
		end
	end
end