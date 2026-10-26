local module = require("EE.Interface.AnchorMgr")
local module2 = require("EE.Interface.Utilities")

local function fn(object)
	local __wf_atom_1cda18ff = object:__wf_atom_a07433fe():__wf_atom_1cda18ff()

	if __wf_atom_7e8ad928(__wf_atom_1cda18ff) then
		return object:__wf_atom_18007d51():__wf_atom_ae4f866b(false, false, false)
	end

	return object:__wf_atom_0590ad17(__wf_atom_1cda18ff, 0, object:__wf_atom_5e005c29()):__wf_atom_6386920d():__wf_atom_97dd20f1()
end

local function fn2()
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	local __wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()
	local __wf_atom_d2b2176d = __wf_atom_50a7d83e:__wf_atom_d2b2176d()
	local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	mMovie:__wf_atom_50d60589("Container.Stats.Name", 36, __wf_atom_eab484a7:__wf_atom_6be84646())
	mMovie:__wf_atom_50d60589("Container.Stats.Spirit", 36, __wf_atom_50a7d83e:GetAttribute(1))
	mMovie:__wf_atom_50d60589("Container.Stats.Power", 36, __wf_atom_50a7d83e:GetAttribute(0))
	mMovie:__wf_atom_50d60589("Container.Stats.Grace", 36, __wf_atom_50a7d83e:GetAttribute(2))
	mMovie:__wf_atom_50d60589("Container.Stats.Life", 36, __wf_atom_50a7d83e:GetMaxHealth())
	mMovie:__wf_atom_e57658c2("Container.Stats.Title", 12, 20)
	mMovie:__wf_atom_50d60589("Container.Stats.Title", 36, "-")
	mMovie:__wf_atom_e57658c2("Container.Stats.TitleTag", 12, 20)
	mMovie:__wf_atom_e57658c2("Container.Stats.Rank", 12, 20)
	mMovie:__wf_atom_50d60589("Container.Stats.Rank", 36, "-")
	mMovie:__wf_atom_e57658c2("Container.Stats.RankTag", 12, 20)

	if __wf_atom_e55d02aa == nil then
		mMovie:__wf_atom_e57658c2("Container.Info.Soul", 12, 20)
		mMovie:__wf_atom_e57658c2("Container.Info.SoulTag", 12, 20)
	else
		mMovie:__wf_atom_50d60589("Container.Info.Soul", 36, __wf_atom_e55d02aa:__wf_atom_5b41f63b())
	end

	if __wf_atom_9fb9a1d6 == nil then
		mMovie:__wf_atom_e57658c2("Container.Info.Weapon", 12, 20)
		mMovie:__wf_atom_e57658c2("Container.Info.WeaponTag", 12, 20)
		mMovie:__wf_atom_e57658c2("Container.Info.MeleeDamage", 12, 20)
		mMovie:__wf_atom_e57658c2("Container.Info.MeleeDamageTag", 12, 20)
	else
		mMovie:__wf_atom_50d60589("Container.Info.Weapon", 36, __wf_atom_9fb9a1d6:GetName())
		local v = fn(__wf_atom_9fb9a1d6)
		local v2 = __wf_atom_9fb9a1d6:__wf_atom_9f610be2(v) - v
		local ternary = module2.Ternary(v2 > 0, v .. " (+" .. v2 .. ")", v)
		mMovie:__wf_atom_50d60589("Container.Info.MeleeDamage", 11, _G.UIColor_White)

		if not __wf_atom_9fb9a1d6:__wf_atom_a2652e26() then
			local rounded = module2.Round((v + v2) * (1 - __wf_atom_9fb9a1d6:__wf_atom_1958c031()))

			if rounded > 0 then
				ternary ..= " (-" .. rounded .. ")"
				mMovie:__wf_atom_50d60589("Container.Info.MeleeDamage", 11, 16755361)
			end
		end

		mMovie:__wf_atom_50d60589("Container.Info.MeleeDamage", 36, ternary)
	end

	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

	if __wf_atom_28224c27 == nil then
		mMovie:__wf_atom_e57658c2("Container.Info.Ranged", 12, 20)
		mMovie:__wf_atom_e57658c2("Container.Info.RangedTag", 12, 20)
		mMovie:__wf_atom_e57658c2("Container.Info.RangedDamage", 12, 20)
		mMovie:__wf_atom_e57658c2("Container.Info.RangedDamageTag", 12, 20)
	else
		mMovie:__wf_atom_50d60589("Container.Info.Ranged", 36, __wf_atom_28224c27:GetName())
		local v = fn(__wf_atom_28224c27)
		local v2 = __wf_atom_28224c27:__wf_atom_9f610be2(v) - v
		local ternary = module2.Ternary(v2 > 0, v .. " (+" .. v2 .. ")", v)
		mMovie:__wf_atom_50d60589("Container.Info.RangedDamage", 11, _G.UIColor_White)

		if not __wf_atom_28224c27:__wf_atom_a2652e26() then
			local rounded = module2.Round((v + v2) * (1 - __wf_atom_28224c27:__wf_atom_1958c031()))

			if rounded > 0 then
				ternary ..= " (-" .. rounded .. ")"
				mMovie:__wf_atom_50d60589("Container.Info.RangedDamage", 11, 16755361)
			end
		end

		mMovie:__wf_atom_50d60589("Container.Info.RangedDamage", 36, ternary)
	end

	mMovie:__wf_atom_e57658c2("Container.Info.Attunment", 12, 20)
	mMovie:__wf_atom_50d60589("Container.Info.Attunment", 36, "-")
	mMovie:__wf_atom_e57658c2("Container.Info.AttunmentTag", 12, 20)
	mMovie:__wf_atom_e57658c2("Container.Info.Rank", 12, 20)
	mMovie:__wf_atom_50d60589("Container.Info.Rank", 36, "-")
	mMovie:__wf_atom_e57658c2("Container.Info.RankTag", 12, 20)
	mMovie:__wf_atom_e57658c2("Container.Info.Idol", 12, 20)
	mMovie:__wf_atom_50d60589("Container.Info.Idol", 36, "-")
	mMovie:__wf_atom_e57658c2("Container.Info.IdolTag", 12, 20)
	mMovie:__wf_atom_e57658c2("Container.Info.Command", 12, 20)
	mMovie:__wf_atom_50d60589("Container.Info.Command", 36, "-")
	mMovie:__wf_atom_e57658c2("Container.Info.CommandTag", 12, 20)
	mMovie:__wf_atom_e57658c2("Container.Info.Charm", 12, 20)
	mMovie:__wf_atom_50d60589("Container.Info.Charm", 36, "-")
	mMovie:__wf_atom_e57658c2("Container.Info.CharmTag", 12, 20)
end

function StoreAttributesCallback(_, _)
	fn2()
end

function Initialize()
	local v = module.Create(mMovie)
	v:Register(mMovie, "Container", { v.ANCHOR_V_CENTRE, v.ANCHOR_H_CENTRE })
	v:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	mMovie:__wf_atom_7f5b0d60(2)
	module2.PlaySound(_G.UISound_DialogOpen)
	fn2()
	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("EnableInput", "")
	mMovie:SetCallbacks("Container.Stats.SpiritIncrease.Btn", nil, nil, nil, "SpiritIncrease")
	mMovie:SetCallbacks("Container.Stats.PowerIncrease.Btn", nil, nil, nil, "PowerIncrease")
	mMovie:SetCallbacks("Container.Stats.GraceIncrease.Btn", nil, nil, nil, "GraceIncrease")
end

local function fn3(p, _) -- 3 equivalent calls inferred from this helper
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		return
	end

	__wf_atom_9be88b01:__wf_atom_615ff731(p, "StoreAttributesCallback")
end

function SpiritIncrease()
	fn3(1) -- inferred equivalent call
end

function PowerIncrease()
	fn3(0) -- inferred equivalent call
end

function GraceIncrease()
	fn3(2) -- inferred equivalent call
end

function onKeyUp_SHOW_INVENTORY()
	module2.PlaySound(_G.UISound_DialogClose)
	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("DisableInput", "")
	mMovie:Close()
	return true
end