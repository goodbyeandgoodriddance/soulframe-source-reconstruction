function AvatarPlayInstrument(object, p, p2, p3, p4, p5, object2, data, p6)
	local v

	if p ~= nil then
		v = gRegion:__wf_atom_f738b4af(Symbol(p), object:GetPosition(), 0, 20) or nil
	end

	if __wf_atom_7e8ad928(v) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(p2)
		gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
		object:__wf_atom_d2b2176d():Unequip(0, 2)
		local v2 = Rotation(0, 90, 0)

		if data ~= nil then
			v2.heading += data.heading
			v2.pitch += data.pitch
			v2.bank += data.bank
		end

		local v3 = Vector(0, 0, 0)

		if p6 ~= nil then
			v3 += p6
		end

		local v4 = object:Attach(p2, Symbol("GAME_L1_WEAPON1"), v3, v2, object, 1)

		if not __wf_atom_7e8ad928(object2) then
			object:__wf_atom_3c986cd9(object2:GetPosition(), object2:__wf_atom_dc309f8a(), true)
		end

		if not __wf_atom_7e8ad928(p3) then
			object:__wf_atom_1659a669(p3, false, 4, 3, true)
			Sleep(0.2)

			if not __wf_atom_7e8ad928(v4) then
				v4:__wf_atom_8a035cd5(Symbol("OverrideMusicStartAnim"), true)
			end

			while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(p3) do
				Sleep(0)
			end
		end

		if __wf_atom_7e8ad928(p3) then
			object:__wf_atom_1659a669(p4, false, 3, 2, true)
		else
			object:__wf_atom_1659a669(p4, false, 4, 2, true)
		end

		while not __wf_atom_7e8ad928(object) and object:__wf_atom_0473b7a9() do
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(object) then
			if __wf_atom_7e8ad928(p3) then
				object:__wf_atom_1659a669(p5, false, 3, 1, true)
			else
				object:__wf_atom_1659a669(p5, false, 4, 1, true)
			end

			if not __wf_atom_7e8ad928(v4) then
				v4:__wf_atom_8a035cd5(Symbol("OverrideMusicEndAnim"), true)
			end

			if not __wf_atom_7e8ad928(v4) then
				v4:__wf_atom_8a035cd5(Symbol("DestroyInstrumentAfter"), false)
			end
		end
	else
		v:__wf_atom_01142e3f(-1)
		v:SetInstigatorAvatar(object)
		v:FirePort("StartPlaying")

		while not __wf_atom_7e8ad928(object) and object:__wf_atom_0473b7a9() do
			Sleep(0)
		end
	end
end

function ShowMusicHint(musicHintNote, musicHintMidi, musicHintDelay)
	local v = WeakResource("/SF/Interface/Minigames/MusicHintPopup.swf")

	if __wf_atom_8e4fda44:__wf_atom_6b69b901(v) then
		return
	end

	_T.MusicHintDelay = musicHintDelay
	_T.MusicHintNote = musicHintNote

	if not _T.MusicHintMidi or _T.MusicHintMidi ~= musicHintMidi then
		_T.MusicHintNotesDiscovered = {}
	end

	if not _T.MusicHintNotesDiscovered then
		_T.MusicHintNotesDiscovered = {}
	end

	if musicHintNote then
		_T.MusicHintNotesDiscovered[musicHintNote] = true
	end

	_T.MusicHintMidi = musicHintMidi
	__wf_atom_8e4fda44:__wf_atom_3e5e23c0(v, "")
end

function MidiNoteToInstrumentSoundIndex(p)
	if p == 49 then
		return 1
	elseif p == 51 then
		return 2
	elseif p == 52 then
		return 3
	elseif p == 54 then
		return 4
	elseif p == 56 then
		return 5
	end

	return 1
end