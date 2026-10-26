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
	_g.UIMovie_ChatReduxMovie = chatReduxMovie
	_g.UIMovie_InputCountMovie = inputCountMovie
	_g.UIMovie_ColorPicker = colorPickerMovie
	_g.UIMovie_InputDialogMovie = inputDialogMovie
	_g.UIMovie_GenericMenu = genericMenuMovie
	_g.UIMovie_GenericSettings = genericSettingsMovie
	_g.UIMovie_ItemBrowsingMovie = itemBrowsingMovie
	_g.UIMovie_DetailedPurchaseDialog = detailedPurchaseMovie
	_g.UIMaterial_Plain = plainMaterial
	_g.UIMaterial_PlainText = plainTextMaterial
	_g.UIMaterial_DepthTestText = depthTestTextMaterial
	_g.UIMaterial_VisibilityRange = visibilityRangeMaterial
	_g.UIMaterial_VerticalVisibilityRange = verticalVisibilityRangeMaterial
	_g.UIMaterial_VerticalVisibilityRangeText = verticalVisibilityRangeTextMaterial
	_g.UIMaterial_PopupVerticalVisibilityRange = popUpVerticalVisibilityRangeMaterial
	_g.UIMaterial_PopupVerticalVisibilityRangeText = popUpVerticalVisibilityRangeTextMaterial
	_g.UIMaterial_FloatingListVerticalVisibilityRange = floatingListVerticalVisibilityRangeMaterial
	_g.UIMaterial_FloatingListVerticalVisibilityRangeText = floatingListVerticalVisibilityRangeTextMaterial
	_g.UIMaterial_Plasma = plasmaMaterial
	_g.UIMaterial_Icon = iconMaterial
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
	_g.UIMaterial_UnfocusedBackerBorder = unfocusedBackerBorderMaterial
	_g.UIMaterial_FocusedBackerBorder = focusedBackerBorderMaterial
	_g.UIMaterial_SelectedBackerBorder = selectedBackerBorderMaterial
	_g.UIMaterial_BackerBorderSingle = backerBorderSingleMaterial
	_g.UIMaterial_BackerBorderDouble = backerBorderDoubleMaterial
	_g.UIMaterial_BackerBorderFill = backerBorderFillMaterial
	_g.UIMaterial_DarkPaperBacker = darkPaperBackerMaterial
	_g.UIMaterial_DarkPaperBackerAlt = darkPaperBackerAltMaterial
	_g.UIMaterial_DarkPaperBackerVisRange = darkPaperBackerVisRangeMaterial
	_g.UIMaterial_PopupBackerBorderSingle = popupBackerBorderSingleMaterial
	_g.UIMaterial_TiledDivider = tiledDividerMaterial
	_g.UIMaterial_Divider = dividerMaterial
	_g.UIMaterial_GamepadButtonBacker = gamepadButtonBackerMaterial
	_g.UIMaterial_ButtonBackerRegular = buttonBackerMaterialRegular
	_g.UIMaterial_ButtonBackerHover = buttonBackerMaterialHover
	_g.UIMaterial_BorderMaterialDefault = borderMaterialDefault
	_g.UIMaterial_BorderMaterialCassid = borderMaterialCassid
	_g.UIMaterial_BorderMaterialDendrit = borderMaterialDendrit
	_g.UIMaterial_BorderMaterialFey = borderMaterialFey
	_g.UIMaterial_BorderMaterialMendicant = borderMaterialMendicant
	_g.UIMaterial_BorderMaterialOde = borderMaterialOde
	_g.UIMaterial_BorderMaterialErodedEdge = borderMaterialErodedEdge
	_g.UIMaterial_MidBgMaterial = midBgMaterial
	_g.UIMaterial_BackerRoughEdgeVisRangeMaterial = backerRoughEdgeVisRangeMaterial
	_g.UIMaterial_EmojiColors = emojiColorMaterials
	_g.UIMaterial_RuneMaterial = runeMaterial
	_g.UIMaterial_AnimalMoteMaterial = animalMoteMaterial
	_g.UITexture_Search = searchIcon
	_g.UITexture_ClearSearch = clearSearchIcon
	_g.UITexture_Locked = lockedTexture
	_g.UITexture_ProfilePlaceHolder = profilePlaceHolderTexture
	_g.UITexture_ItemList = itemListTextures
	_g.UITexture_GenderIcons = genderIconTextures
	_g.UITexture_SettingsIcons = settingsTextures
	_g.UITexture_LabelIcons = labelIconTextures
	_g.UITexture_LabelIconShadows = labelIconShadowTextures
	_g.UITexture_CategoryIcons = categoryTextures
	_g.UITexture_MoteIcons = moteTextures
	_g.UITexture_BackerTextureStock = backerTextureStock
	_g.UITexture_BackerTextureOfficer = backerTextureOfficer
	_g.UITexture_BackerTextureNoble = backerTextureNoble
	_g.UITexture_BackerTextureMilitary = backerTextureMilitary
	_g.UITexture_BackerTextureMasterwork = backerTextureMasterwork
	_g.UITexture_BackerTextureLegendary = backerTextureLegendary
	_g.UITexture_MoteCardBgTextures = moteCardBgTextures
	_g.UITexture_MoteStatsIcons = moteStatsIcons
	_g.UITexture_MoteFrameTexturesPassive = moteFrameTexturesPassive
	_g.UITexture_MoteFrameTexturesActive = moteFrameTexturesActive
	_g.UITexture_MidBgTexture = midBgTexture
	_g.UITexture_ItemInfoLeaf = itemInfoLeaf
	_g.UITexture_ItemInfoLeafShiny = itemInfoLeafShiny
	_g.UIColor_Black = 0
	_g.UIColor_Grey = 2565927
	_g.UIColor_LightGrey = 11382189
	_g.UIColor_DarkerBrown = 1774867
	_g.UIColor_DarkBrown = 2825751
	_g.UIColor_Brown = 4864024
	_g.UIColor_MediumBrown = 4664607
	_g.UIColor_Orange = 9131824
	_g.UIColor_BrightOrange = 12141075
	_g.UIColor_LightRed = 5644578
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
	_g.UIColor_DarkerPurple = 1972516
	_g.UIColor_White = 16777215
	_g.UIColor_FadedTint = 11578788
	_g.UIColor_StrongFadedTint = 6577219
	_g.UIColor_FadedBeige = _g.UIColor_Beige - 1118481
	_g.UIColor_Positive = _g.UIColor_Yellow
	_g.UIColor_Negative = _g.UIColor_BrightOrange
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
	_g.UIAlpha_FadedBacker = 50
	_g.UIMaterial_InputFieldMiddlePart = inputFieldMiddlePartMaterial
	_g.UIMaterial_InputFieldMiddlePartHighlight = inputFieldMiddlePartHighlightMaterial
	_g.UITexture_InputFieldBorderEndCap = inputFieldBorderEndCapTexture
	_g.UITexture_InputFieldBorderEndCapHighlight = inputFieldBorderEndCapHighlightTexture
	_g.UISound_ObjectiveUpdateSound = objectiveUpdatedSound
	_g.UISliceMaterials = {
		scrollbarSliderMaterial,
		scrollbarBackerMaterial,
		unfocusedBorderMaterial,
		focusedBorderMaterial,
		selectedBorderMaterial,
		unfocusedTabBorderMaterial,
		focusedTabBorderMaterial,
		selectedTabBorderMaterial,
		unfocusedBackerBorderMaterial,
		focusedBackerBorderMaterial,
		selectedBackerBorderMaterial,
		backerBorderSingleMaterial,
		backerBorderDoubleMaterial,
		backerBorderFillMaterial,
		darkPaperBackerMaterial,
		darkPaperBackerAltMaterial,
		darkPaperBackerVisRangeMaterial,
		tiledDividerMaterial
	}
	module.ScaleSlicedMaterials(mMovie, _g.UISliceMaterials)
	__wf_atom_8e4fda44:__wf_atom_90c0d5d2(_g.UIColor_DarkBrown)
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