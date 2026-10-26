local module = require("EE.Interface.Utilities")
local flag = false

local function fn(_g)
	if not __wf_atom_7e8ad928(_g.CommonResourcesType) then
		return
	end

	_g.CommonResourcesType = Type(mMovie:__wf_atom_6d61d595())
	_g.UIFx_ConsolePress = consolePressFx
	_g.UIFx_PCPress = pcPressFx
	_g.UIFx_LeftBumperPress = leftBumperPressFx
	_g.UIFx_LeftBumperPress3d = leftBumperPress3dFx
	_g.UIFx_RightBumperPress = rightBumperPressFx
	_g.UIFx_RightBumperPress3d = rightBumperPress3dFx
	_g.UIMovie_ConfirmMovie = confirmMovie
	_g.UIMovie_TransmissionMovie = transmissionMovie
	_g.UIMovie_ItemBrowsingMovie = itemBrowsingMovie
	_g.UIMovie_PlatBrowsingMovie = platBrowsingMovie
	_g.UIMovie_ChatReduxMovie = chatReduxMovie
	_g.UIMovie_InputCountMovie = inputCountMovie
	_g.UIMovie_ColorPicker = colorPickerMovie
	_g.UIMovie_InputDialogMovie = inputDialogMovie
	_g.UIMovie_MeleeCombosMovie = meleeCombosMovie
	_g.UIMovie_ArcWingHudMovie = arcWingHudMovie
	_g.UIMovie_EndOfQuestMovie = endOfQuestMovie
	_g.UIMovie_ShipDecoHUD = shipDecoHudMovie
	_g.UIMovie_DetailedPurchaseDialog = newDetailedPurchaseDialogMovie
	_g.UIMovie_SolarMap = radialSolarMapMovie
	_g.UIMovie_GenericMenu = genericMenuMovie
	_g.UIMovie_GenericSettings = genericSettingsMovie
	_g.UIMovie_LoadoutSelectMovie = loadoutSelectMovie
	_g.UIMovie_NemesisInfoMovie = nemesisMovie
	_g.UIMaterial_Plain = plainMaterial
	_g.UIMaterial_PlainText = plainTextMaterial
	_g.UIMaterial_DepthTestText = depthTestTextMaterial
	_g.UIMaterial_VisibilityRange = visibilityRangeMaterial
	_g.UIMaterial_VerticalVisibilityRange = verticalVisibilityRangeMaterial
	_g.UIMaterial_VerticalVisibilityRangeText = verticalVisibilityRangeTextMaterial
	_g.UIMaterial_Plasma = plasmaMaterial
	_g.UIMaterial_Icon = iconMaterial
	_g.UIMaterial_MiniMap = miniMapMaterial
	_g.UIMaterial_Diegetic = diegeticMaterial
	_g.UIMaterial_SmoothEdge = smoothEdgeMaterial
	_g.UIMaterial_SmoothEdgeNoDepthTest = smoothEdgeMaterialNoDepthTest
	_g.UIMaterial_Rectangle = rectMaterial
	_g.UIMaterial_RectangleNoDepth = rectNoDepthMaterial
	_g.UIMaterial_Pigment = pigmentMaterial
	_g.UIMaterial_PigmentVisibilityRange = pigmentVisRangeMaterial
	_g.UIMaterial_Bluer = bluerMaterial
	_g.UIMaterial_Button = buttonMaterial
	_g.UIMaterial_VitruvianLines = vitruvianLinesMaterial
	_g.UIMaterial_ScrollbarSlider = scrollbarSliderMaterial
	_g.UIMaterial_ScrollbarBacker = scrollbarBackerMaterial
	_g.UIMaterial_UnfocusedBorder = unfocusedBorderMaterial
	_g.UIMaterial_FocusedBorder = focusedBorderMaterial
	_g.UIMaterial_SelectedBorder = selectedBorderMaterial
	_g.UIMaterial_UnfocusedTabBorder = unfocusedTabBorderMaterial
	_g.UIMaterial_FocusedTabBorder = focusedTabBorderMaterial
	_g.UIMaterial_SelectedTabBorder = selectedTabBorderMaterial
	_g.UIMaterial_BackerBorder = backerBorderMaterial
	_g.UIMaterial_DarkPaperBacker = darkPaperBackerMaterial
	local v = {
		"Icon",
		"Background",
		"Energy",
		"BottomFrame",
		"TopFrame",
		"Content",
		"EmptySlot",
		"OmegaIcon",
		"Text",
		"PeculiarEnergy",
		"PeculiarBottomFrame",
		"PeculiarTopFrame",
		"GalvanizedBottomFrame",
		"GalvanizedTopFrame",
		"ImmortalIcon",
		"ImmortalBackground",
		"ImmortalBottomFrame",
		"ImmortalTopFrame",
		"SmoothEdge",
		"AvionicBottomFrame",
		"AvionicTopFrame",
		"ImmortalWildcardIcon",
		"KahlTopFrame",
		"KahlBottomFrame"
	}
	local modMaterials = modMaterials
	local v2 = {}
	local uiMaterial_Mods = { nil, nil, nil, nil }

	for i, v3 in ipairs(v) do
		v2[v3] = modMaterials[i]
	end

	local modMaterialsNoDepthTest = modMaterialsNoDepthTest
	local v3 = {}

	for i, v4 in ipairs(v) do
		v3[v4] = modMaterialsNoDepthTest[i]
	end

	local modMaterialsHorizontal = modMaterialsHorizontal
	local v4 = {}

	for i, v5 in ipairs(v) do
		v4[v5] = modMaterialsHorizontal[i]
	end

	local modMaterialsNoDepthTestHorizontal = modMaterialsNoDepthTestHorizontal
	local v5 = {}

	for i, v6 in ipairs(v) do
		v5[v6] = modMaterialsNoDepthTestHorizontal[i]
	end

	uiMaterial_Mods[1], uiMaterial_Mods[2], uiMaterial_Mods[3], uiMaterial_Mods[4] = v2, v3, v4, v5
	_g.UIMaterial_Mods = uiMaterial_Mods
	local v6 = {
		"ArbitersSyndicate",
		"SteelMeridianSyndicate",
		"PerrinSyndicate",
		"RedVeilSyndicate",
		"CephalonSudaSyndicate",
		"NewLokaSyndicate"
	}
	local modSyndicateMaterials = modSyndicateMaterials
	local v7 = {}
	local uiMaterial_ModsSyndicateIcons = { nil, nil, nil, nil }

	for i, v8 in ipairs(v6) do
		v7[v8] = modSyndicateMaterials[i]
	end

	local modSyndicateMaterialsNoDepthTest = modSyndicateMaterialsNoDepthTest
	local v8 = {}

	for i, v9 in ipairs(v6) do
		v8[v9] = modSyndicateMaterialsNoDepthTest[i]
	end

	local modSyndicateMaterialsHorizontal = modSyndicateMaterialsHorizontal
	local v9 = {}

	for i, v10 in ipairs(v6) do
		v9[v10] = modSyndicateMaterialsHorizontal[i]
	end

	local modSyndicateMaterialsNoDepthTestHorizontal = modSyndicateMaterialsNoDepthTestHorizontal
	local v10 = {}

	for i, v11 in ipairs(v6) do
		v10[v11] = modSyndicateMaterialsNoDepthTestHorizontal[i]
	end

	uiMaterial_ModsSyndicateIcons[1], uiMaterial_ModsSyndicateIcons[2], uiMaterial_ModsSyndicateIcons[3], uiMaterial_ModsSyndicateIcons[4] = v7, v8, v9, v10
	_g.UIMaterial_ModsSyndicateIcons = uiMaterial_ModsSyndicateIcons
	local v11 = { 1, 2, 3, 4, 7 }
	local focusLensMaterials = focusLensMaterials
	local uiMaterial_FocusLens = {}

	for i, v12 in ipairs(v11) do
		uiMaterial_FocusLens[v12] = focusLensMaterials[i]
	end

	_g.UIMaterial_FocusLens = uiMaterial_FocusLens
	local focusLensStoreMaterials = focusLensStoreMaterials
	local uiMaterial_FocusLensStore = {}

	for i, v12 in ipairs(v11) do
		uiMaterial_FocusLensStore[v12] = focusLensStoreMaterials[i]
	end

	_g.UIMaterial_FocusLensStore = uiMaterial_FocusLensStore
	local focusLensStoreMaterialsWithDepth = focusLensStoreMaterialsWithDepth
	local uiMaterial_FocusLensStoreDepth = {}

	for i, v12 in ipairs(v11) do
		uiMaterial_FocusLensStoreDepth[v12] = focusLensStoreMaterialsWithDepth[i]
	end

	_g.UIMaterial_FocusLensStoreDepth = uiMaterial_FocusLensStoreDepth
	_g.UIMaterial_ArchonShards = archonShardMaterials
	_g.UIMaterial_ArchonShardsStore = archonShardStoreMaterials
	_g.UIMaterial_ArchonShardsStoreDepth = archonShardStoreMaterialsWithDepth
	_g.UIMaterial_CosmeticEnhancers = cosmeticEnhancersMaterials
	_g.UIMaterial_CosmeticEnhancersStore = cosmeticEnhancersStoreMaterials
	_g.UIMaterial_CosmeticEnhancersStoreDepth = cosmeticEnhancersStoreMaterialsWithDepth
	_g.UIMaterial_CosmeticEnhancersStoreHorizontal = cosmeticEnhancersStoreMaterialsHorizontal
	_g.UIMaterial_CosmeticEnhancersStoreDepthHorizontal = cosmeticEnhancersStoreMaterialsWithDepthHorizontal
	_g.UIMaterial_RailjackMod = railjackModMaterials
	_g.UIMaterial_RailjackModStore = railjackModStoreMaterials
	_g.UIMaterial_RailjackModStoreDepth = railjackModStoreMaterialsWithDepth
	_g.UIMaterial_SpaceMarker = spaceEnemyMarkerMaterials
	_g.UIMaterial_SpaceMarkerCrewShip = spaceEnemyCrewshipMarkerMaterials
	_g.UIMaterial_SpaceMarkerCircle = spaceEnemyCircleMarkerMaterials
	_g.UIMaterial_RailjackModStoreHorizontal = railjackModStoreMaterialsHorizontal
	_g.UIMaterial_RailjackModStoreDepthHorizontal = railjackModStoreMaterialsWithDepthHorizontal
	_g.UIMaterial_EmojiColors = emojiColorMaterials
	_g.UIMaterial_SalvageMaterials = salvageMaterials
	_g.UIMaterial_Mastery = masteryMaterials
	_g.UITexture_CreditsIcon = creditsIconTexture
	_g.UITexture_PlatinumIcon = platinumIconTexture
	_g.UITexture_ProfilePlaceHolder = profilePlaceHolderTexture
	_g.UITexture_Blueprint = blueprintTexture
	_g.UITexture_ReusableBlueprint = reusableBlueprintTexture
	_g.UITexture_Search = searchIcon
	_g.UITexture_ClearSearch = clearSearchIcon
	_g.UITexture_Polarity = polarityTextures
	_g.UITexture_Wishlist = wishlistIconTexture
	_g.UITexture_Bundle = bundleIconTexture
	_g.UITexture_Mastery = masteryTextures
	_g.UITexture_ClanClass = clanClassTextures
	_g.UITexture_EmptySlot = emptySlotTexture
	_g.UITexture_LabelIcons = labelIconTextures
	_g.UITexture_EvolutionLabelIcon = evoSkillsLabelTexture
	_g.UITexture_CircleGradientBacker = circleGradientBackerTexture
	_g.UITexture_CompanionIcons = companionIconTextures
	_g.UITexture_GenderIcons = genderIconTextures
	_g.UITexture_SettingsIcons = settingsTextures
	_g.UITexture_Salvage = salvageTexture
	_g.UITexture_FavoriteIcons = favoriteTextures
	_g.UITexture_ItemList = itemListTextures
	_g.UIColor_Black = 0
	_g.UIColor_Grey = 2565927
	_g.UIColor_DarkBrown = 2825751
	_g.UIColor_Brown = 4664607
	_g.UIColor_BrightOrange = 12141075
	_g.UIColor_Orange = 9131824
	_g.UIColor_Red = 4916485
	_g.UIColor_Yellow = 14524216
	_g.UIColor_Gold = 8152122
	_g.UIColor_Beige = 10984574
	_g.UIColor_Tan = 12363651
	_g.UIColor_LightYellow = 14800280
	_g.UIColor_DarkGreen = 3880473
	_g.UIColor_Green = 5662766
	_g.UIColor_BlueGreen = 6124631
	_g.UIColor_Blue = 4482163
	_g.UIColor_White = 16777215
	_g.UIColor_FadedTint = 11578788
	_g.UIColor_LightBlue = 12769497
	_g.UIColor_MediumBlue = 8100006
	_g.UIColor_DarkBlue = 4546669
	_g.UIColor_MediumGrey = 8421504
	_g.UIColor_DarkGrey = 2368548
	_g.UIColor_Health = 13379881
	_g.UIColor_Shield = 54783
	_g.UIColor_Overshield = 11731199
	_g.UIColor_Stamina = 4502359
	_g.UIColor_Armor = 14591541
	_g.UIColor_LightGreen = 12118144
	_g.UIColor_PositiveReputation = 5030911
	_g.UIColor_NegativeReputation = 16731212
	_g.UIColor_OpposedReputation = 15647744
	_g.UIColor_PvpTeamOne = 15044409
	_g.UIColor_PvpTeamTwo = 3000544
	_g.UIColor_PvpKill = 15945236
	_g.UIColor_Hyperlink = 3394815
	_g.UIColor_UnlimitedUseBP = 15714870
	_g.UIColor_RGB_White = module.ConvertHEX2RGB255(_g.UIColor_White)
	_g.UIColorObject_White = module.ConvertColorNumberToProceduralRGB(_g.UIColor_White)
	_g.UIColorObject_Black = module.ConvertColorNumberToProceduralRGB(_g.UIColor_Black)
	_g.UIColorObject_Yellow = module.ConvertColorNumberToProceduralRGB(_g.UIColor_Yellow)
	_g.UIColorObject_DarkBlue = module.ConvertColorNumberToProceduralRGB(_g.UIColor_DarkBlue)

	for i, v12 in ipairs({
		"All",
		"Installed",
		"Warframe",
		"Rifle",
		"HandGun",
		"Melee",
		"Stance",
		"Sentinel",
		"Kubrow",
		"Aura",
		"Misc",
		"Cores",
		"Build",
		"Materials",
		"Skins",
		"Corpus",
		"Grineer",
		"Infested",
		"Wild",
		"Orokin",
		"Sentient",
		"Stalker",
		"Duplicates",
		"Archwing",
		"ArchwingPrimary",
		"ArchwingSecondary",
		"Mods",
		"Sigils",
		"Augment",
		"Utility",
		"Omega",
		"Companions",
		"Amps",
		"Cephalon",
		"Cetus",
		"Glass",
		"Ghouls",
		"Solaris",
		"FusionTreasures",
		"Displays",
		"Noggles",
		"Vehicles",
		"Recipes",
		"Imprints",
		"Immortal",
		"DataKnife",
		"Incomplete",
		"Railjack",
		"RailjackDefensive",
		"RailjackOffensive",
		"RailjackSuper",
		"RailjackTactical",
		"Narmer",
		"Duviri",
		"EvoWeapons"
	}) do
		_g["UICategoryIcon_" .. v12 .. "On"] = categoryIconsOnTexture[i]
	end

	_g.UITexture_Portrait = portraitMaterial
	_g.UITexture_Alert = alertTexture
	_g.UITexture_Story = storyTexture
	_g.UITexture_Skull = skullTexture
	_g.UITexture_SkullLarge = skullTextureLarge
	_g.UITexture_VoidTear = voidTearTexture
	_g.UITexture_Locked = lockedTexture
	_g.UITexture_Event = eventTexture
	_g.UITexture_Pvp = pvpTexture
	_g.UITexture_PvpChallenges = pvpChallengesTexture
	_g.UITexture_PvpWeeklyChallenges = pvpWeeklyChallengesTexture
	_g.UITexture_Hub = hubTexture
	_g.UITexture_BossNode = bossNodeTexture
	_g.UITexture_Invasion = invasionTexture
	_g.UITexture_Syndicate = syndicateTexture
	_g.UITexture_Darvo = darvoTexture
	_g.UITexture_DefaultClan = defaultClanIcon
	_g.UITexture_DefaultAlliance = defaultAllianceIcon
	_g.UITexture_BadlandConflict = badlandConflictIcon
	_g.UITexture_Archwing = archwingIcon
	_g.UITexture_SortieEasy = sortieEasyIcon
	_g.UITexture_SortieHard = sortieHardIcon
	_g.UITexture_SortieFinal = sortieFinalIcon
	_g.UITexture_SortieGeneric = sortieGenericIcon
	_g.UITexture_Acolyte = acolyteTexture
	_g.UITexture_Arena = arenaIcon
	_g.UITexture_EliteAlert = eliteAlertIcon
	_g.UITextures_FactionInvasion = factionTexturesInvasion
	_g.UITextures_CorpusShip = corpusShipTextures
	_g.UITextures_GrineerAsteroid = grineerAsteroidTextures
	_g.UITextures_GrineerShip = grineerShipTextures
	_g.UITextures_Outpost = outpostTextures
	_g.UITextures_Settlement = settlementTextures
	_g.UITextures_NarmerSettlement = narmerSettlementTextures
	_g.UITextures_GasCity = gasCityTextures
	_g.UITextures_NarmerGasCity = narmerGasCityTextures
	_g.UITextures_GrineerForest = grineerForestTextures
	_g.UITextures_NarmerGrineerForest = narmerForestTextures
	_g.UITextures_GrineerShipyard = grineerShipyardTextures
	_g.UITextures_InfestedCorpusShip = infestedCorpusTextures
	_g.UITextures_GameModeTextures = gameModeTextures
	_g.UITextures_IcePlanet = icePlanetTextures
	_g.UITextures_ArchwingFreeFlight = archwingFreeFlightTexture
	_g.UITextures_ArchwingTrench = archwingTrenchTexture
	_g.UITextures_GrineerOcean = grineerOceanTextures
	_g.UITextures_OrokinMoon = orokinMoonTextures
	_g.UITextures_OrokinTower = orokinTowerTextures
	_g.UITextures_pvpGameModesTextures = pvpGameModesTextures
	_g.UITextures_ArenaLocation = arenaLocationTexture
	_g.UITextures_GhostTower = ghostTowerTexture
	_g.UITextures_GhostTowerVariant = ghostTowerVariantTexture
	_g.UITextures_GrineerFortress = grineerFortressTextures
	_g.UITextures_JunctionLocation = junctionLocationTexture
	_g.UITextures_EidolonPlains = eidolonPlainsTextures
	_g.UITypes_DojoKeyBlueprint = dojoKeyBlueprintType
	_g.UITypes_UGCKeys = UGCKeys
	_g.UITypes_OwnershipRequiredCapturaTile = ownershipRequiredCapturaTileType
	_g.UITypes_QuestRequiredCapturaTile = questRequiredCapturaTileType
	_g.UIMaterial_InputFieldMiddlePart = inputFieldMiddlePartMaterial
	_g.UIMaterial_InputFieldMiddlePartHighlight = inputFieldMiddlePartHighlightMaterial
	_g.UITexture_InputFieldBorderEndCap = inputFieldBorderEndCapTexture
	_g.UITexture_InputFieldBorderEndCapHighlight = inputFieldBorderEndCapHighlightTexture
	_g.UISliceMaterials = {
		scrollbarSliderMaterial,
		scrollbarBackerMaterial,
		unfocusedBorderMaterial,
		focusedBorderMaterial,
		selectedBorderMaterial,
		unfocusedTabBorderMaterial,
		focusedTabBorderMaterial,
		selectedTabBorderMaterial,
		backerBorderMaterial,
		darkPaperBackerMaterial
	}
	module.ScaleSlicedMaterials(mMovie, _g.UISliceMaterials)
	__wf_atom_8e4fda44:__wf_atom_90c0d5d2(2825751)
end

function Initialize()
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	fn(_G)
	flag = true
end

function Update()
	if flag then
		__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("CommonResourcesReady", "")
		mMovie:Close()
	end
end