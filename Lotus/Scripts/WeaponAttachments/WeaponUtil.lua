module(..., package.seeall)

function CreateUserData(object, p)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return nil
	end

	local name = object:GetName()
	local __wf_atom_18aa6e58 = __wf_atom_6009c8ed:__wf_atom_18aa6e58()

	if _T.Weapons == nil then
		_T.Weapons = {}
	end

	if _T.Weapons[name] == nil then
		_T.Weapons[name] = {}
	end

	local weapon = _T.Weapons[name]
	weapon[__wf_atom_18aa6e58] = p
	return weapon[__wf_atom_18aa6e58]
end

function DestroyUserData(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return nil
	end

	local name = object:GetName()

	if _T.Weapons == nil or _T.Weapons[name] == nil then
		return
	end

	_T.Weapons[name][__wf_atom_6009c8ed:__wf_atom_18aa6e58()] = nil
end

function GetUserData(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return nil
	end

	local name = object:GetName()

	if _T.Weapons == nil or _T.Weapons[name] == nil then
		return nil
	end

	return _T.Weapons[name][__wf_atom_6009c8ed:__wf_atom_18aa6e58()]
end

local function fn(_) end

local function fn2(object, mEnabled)
	if object.mEnabled ~= mEnabled then
		object.mEnabled = mEnabled

		if mEnabled then
			object:CreateSaleWeapon()
		else
			object:DestroySaleWeapon()
		end
	end
end

function GetWeaponSale(p)
	if p == nil then
		return nil
	end

	if _T.WeaponSale == nil then
		_T.WeaponSale = {}
	end

	local v = _T.WeaponSale[p]

	if v == nil then
		v = {
			mEntity = nil,
			mAvatar = nil,
			mWeapon = nil,
			mEnabled = true,
			mSaleData = nil,
			SetEnabled = fn2,
			CreateSaleWeapon = fn,
			DestroySaleWeapon = fn
		}
		_T.WeaponSale[p] = v
	end

	return v
end