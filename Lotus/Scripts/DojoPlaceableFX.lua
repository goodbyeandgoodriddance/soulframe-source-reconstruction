local v = nil

function SetDialogTriggerText(object)
	repeat
		Sleep(0)
	until not __wf_atom_7e8ad928(_G.UIColor_DarkGrey)

	local __wf_atom_bea1f978 = object:__wf_atom_bea1f978()
	v = object:Attach(iconDeco, EMPTY_SYMBOL, Vector(0, iconYOffset, 0))

	if not __wf_atom_7e8ad928(v) then
		v:SetMeshScale(iconScale)

		if __wf_atom_bea1f978 == 2 then
			v:__wf_atom_bde21df6(_T.DojoMgr.mDojo:__wf_atom_2a059165(0))
		elseif __wf_atom_bea1f978 == 3 then
			v:__wf_atom_bde21df6(_T.DojoMgr.mDojo:__wf_atom_2a059165(1))
		elseif __wf_atom_bea1f978 == 4 then
			v:SetVisibility(false, true)
		end
	end

	local __wf_atom_854e0028 = object:__wf_atom_854e0028()

	if __wf_atom_854e0028 == "" then
		return
	end

	local function fn(_, _, __wf_atom_bea1f978_2) -- 1 equivalent call inferred from this helper
		if __wf_atom_bea1f978_2 == 4 and not __wf_atom_7e8ad928(v) then
			v:SetVisibility(false, true)
		end
	end

	local function fn2(p)
		local __wf_atom_bea1f978_2 = object:__wf_atom_bea1f978()

		if p then
			if not __wf_atom_7e8ad928(v) then
				v:SetVisibility(true, true)
			end
		else
			fn(nil, nil, __wf_atom_bea1f978_2) -- inferred equivalent call
		end
	end

	local function fn3(p)
		if not __wf_atom_7e8ad928(v) then
			v:SetVisibility(p, true)
		end
	end

	_T.DojoMgr:AddDecoStatusChangedCallback(__wf_atom_854e0028, fn)
	_T.DojoMgr:AddDecoFocusChangedCallback(__wf_atom_854e0028, fn2)
	_T.DojoMgr:AddDecoSelectedCallback(__wf_atom_854e0028, fn3)
end

function UpdateBillboarding(object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			local cameraControl = __wf_atom_eab484a7:CameraControl()

			if not __wf_atom_7e8ad928(cameraControl) then
				while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(_T.FxNamePlateParentDeco) or __wf_atom_7e8ad928(cameraControl)) do
					local __wf_atom_ad19244e = cameraControl:__wf_atom_ad19244e()
					local __wf_atom_a2a18137 = _T.FxNamePlateParentDeco:__wf_atom_a2a18137()
					object:Teleport(__wf_atom_a2a18137, (__wf_atom_fa8d0177(__wf_atom_ad19244e, __wf_atom_a2a18137)))
					Sleep(0)
				end
			end
		end
	end
end