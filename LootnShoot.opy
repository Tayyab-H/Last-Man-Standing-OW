#Global variables

globalvar SpawnPos 0
globalvar isSpawning 1
globalvar ItemsOnFloor 2
globalvar Drops 5
globalvar ItemsToDrop 8
globalvar DropsReady 9
globalvar numberOfDrops 10
globalvar dropsIndex 11
globalvar LightShafts 12
globalvar currentLightShaftPos 13
globalvar currentItemBeingSpawned 14
globalvar lightShaftIndex 15
globalvar lightShaftEntity 16


#Player variables

playervar ItemBeingLookedAt 0
playervar InventoryItemSelect 1
playervar InvIndex 3
playervar Inv1 8
playervar Inv2 9
playervar Inv3 10
playervar Inv4 11
playervar ID1 12
playervar ID2 13
playervar ID3 14
playervar ID4 15
playervar currentInvIndex 16
playervar InvItemUnselect 17
playervar tempArray 19
playervar isPickingUp 20
playervar invIndexCopy 21
playervar ItemToBeAdded 22
playervar isPickup2 23
playervar ItemBeingUsed 24
playervar Hero 25
playervar HeroHealth 26
playervar PlayersInAngleView 27
playervar PlayerToBeChanged 28
playervar SelectTextId 29
playervar WallHacks 30
playervar KnockDown 31
playervar RunningTextID 32
playervar InvincibillityTextID 33
playervar Burn 34
playervar BurnTextID 35
playervar InvisibleTextID 36
playervar SmokeGrenadeEntity 37
playervar ClearSmoke 38
playervar ControlsID 39
playervar ControlsID2 41
playervar ControlsID3 42
playervar ControlsID4 43
playervar ControlsID5 44
playervar KillStreak 45
playervar CurrentItemDesc 46
playervar CurrentItemTextID 47


#Subroutine names

subroutine changeItemDesc 0
subroutine getCurrentItem 1


rule "Asssemble hero time":
    @Condition isAssemblingHeroes() == true
    
    setMatchTime(10)


rule "Controls off":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == false
    
    destroyHudText(eventPlayer.ControlsID)
    destroyHudText(eventPlayer.ControlsID2)
    destroyHudText(eventPlayer.ControlsID3)
    destroyHudText(eventPlayer.ControlsID4)
    destroyHudText(eventPlayer.ControlsID5)
    hudSubtext(eventPlayer, "Hold Crouch to see controls", HudPosition.RIGHT, 1, Color.RED, HudReeval.STRING, SpecVisibility.DEFAULT)
    eventPlayer.ControlsID = getLastCreatedText()


rule "Controls On":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    
    destroyHudText(eventPlayer.ControlsID)
    hudSubtext(eventPlayer, "F TO PICK UP ITEMS ON THE FLOOR.", HudPosition.RIGHT, 1, Color.BLUE, HudReeval.STRING, SpecVisibility.DEFAULT)
    eventPlayer.ControlsID2 = getLastCreatedText()
    hudSubtext(eventPlayer, "HOLD F + PRESS SECONDARY FIRE TO CYCLE THROUGH ITEMS IN YOUR INVENTORY.", HudPosition.RIGHT, 1, Color.BLUE, HudReeval.STRING, SpecVisibility.DEFAULT)
    eventPlayer.ControlsID3 = getLastCreatedText()
    hudSubtext(eventPlayer, "HOLD F + PRESS PRIMARY FIRE TO USE SELECTED ITEM.", HudPosition.RIGHT, 2, Color.BLUE, HudReeval.STRING, SpecVisibility.DEFAULT)
    eventPlayer.ControlsID4 = getLastCreatedText()
    hudSubtext(eventPlayer, "F + RELOAD TO DROP SELECTED ITEM.", HudPosition.RIGHT, 3, Color.BLUE, HudReeval.STRING, SpecVisibility.DEFAULT)
    eventPlayer.ControlsID5 = getLastCreatedText()


rule "Initialise Global Vars":
    if getCurrentMap() == Map.BLIZZ_WORLD or getCurrentMap() == Map.BLIZZ_WORLD_WINTER:
        SpawnPos = vect(-63.255, 0.855, 92.966)
        SpawnPos = SpawnPos.concat(vect(-50.109, 0.858, 78.684))
        SpawnPos = SpawnPos.concat(vect(-22.823, 1.251, 57.938))
        SpawnPos = SpawnPos.concat(vect(-69.008, 7.832, 109.941))
        SpawnPos = SpawnPos.concat(vect(-60.186, 6.975, 83.606))
        SpawnPos = SpawnPos.concat(vect(-76.896, 6.123, 66.414))
        SpawnPos = SpawnPos.concat(vect(-91.46, 2.002, 94.545))
        SpawnPos = SpawnPos.concat(vect(-80.471, 1.498, 63.009))
        SpawnPos = SpawnPos.concat(vect(-17.627, 3.155, 89.12))
        SpawnPos = SpawnPos.concat(vect(-49.644, 1.061, 88.105))
    if getCurrentMap() == Map.EICHENWALDE or getCurrentMap() == Map.EICHENWALDE_HALLOWEEN:
        SpawnPos = vect(100.751, 14.149, -109.204)
        SpawnPos = SpawnPos.concat(vect(55.268, 12.149, -119.552))
        SpawnPos = SpawnPos.concat(vect(42.081, 12.031, -98.12))
        SpawnPos = SpawnPos.concat(vect(55.758, 19.15, -109.956))
        SpawnPos = SpawnPos.concat(vect(58.366, 6.149, -90.497))
        SpawnPos = SpawnPos.concat(vect(82.438, 14.107, -86.502))
        SpawnPos = SpawnPos.concat(vect(55.562, 22.429, -67.671))
        SpawnPos = SpawnPos.concat(vect(44.908, 6.973, -69.802))
        SpawnPos = SpawnPos.concat(vect(87.53, 14.071, -69.768))
        SpawnPos = SpawnPos.concat(vect(55.664, 19.471, -79.319))
    if getCurrentMap() == Map.BLACK_FOREST or getCurrentMap() == Map.BLACK_FOREST_WINTER:
        SpawnPos = vect(28.241, 18.545, 22.369)
        SpawnPos = SpawnPos.concat(vect(32.554, 13.551, 35.475))
        SpawnPos = SpawnPos.concat(vect(-9.202, 14.548, 27.542))
        SpawnPos = SpawnPos.concat(vect(20.793, 10.548, 4.837))
        SpawnPos = SpawnPos.concat(vect(32.959, 13.549, -24.534))
        SpawnPos = SpawnPos.concat(vect(14.918, 12.595, -17.8))
        SpawnPos = SpawnPos.concat(vect(11.745, 18.55, 4.893))
        SpawnPos = SpawnPos.concat(vect(-20.915, 13.64, 5.217))
        SpawnPos = SpawnPos.concat(vect(14.972, 18.475, 12.681))
        SpawnPos = SpawnPos.concat(vect(2.392, 13.767, -14.456))
    Drops = 1
    Drops = Drops.concat(1)
    Drops = Drops.concat(1)
    Drops = Drops.concat(1)
    Drops = Drops.concat(1)
    Drops = Drops.concat(2)
    Drops = Drops.concat(2)
    Drops = Drops.concat(2)
    Drops = Drops.concat(2)
    Drops = Drops.concat(3)
    Drops = Drops.concat(3)
    Drops = Drops.concat(3)
    Drops = Drops.concat(3)
    Drops = Drops.concat(4)
    Drops = Drops.concat(4)
    Drops = Drops.concat(4)
    Drops = Drops.concat(4)
    Drops = Drops.concat(4)
    Drops = Drops.concat(5)
    Drops = Drops.concat(5)
    Drops = Drops.concat(5)
    Drops = Drops.concat(5)
    Drops = Drops.concat(6)
    Drops = Drops.concat(6)
    Drops = Drops.concat(6)
    Drops = Drops.concat(6)
    Drops = Drops.concat(6)
    Drops = Drops.concat(7)
    Drops = Drops.concat(8)
    Drops = Drops.concat(8)
    Drops = Drops.concat(9)
    Drops = Drops.concat(10)
    Drops = Drops.concat(11)
    Drops = Drops.concat(12)
    Drops = Drops.concat(12)
    Drops = Drops.concat(12)
    Drops = Drops.concat(12)
    Drops = Drops.concat(13)
    Drops = Drops.concat(13)
    Drops = Drops.concat(13)
    Drops = Drops.concat(13)
    Drops = Drops.concat(14)
    Drops = Drops.concat(14)
    Drops = Drops.concat(15)
    Drops = Drops.concat(15)
    Drops = Drops.concat(15)
    Drops = Drops.concat(15)
    Drops = Drops.concat(15)
    Drops = Drops.concat(16)
    Drops = Drops.concat(16)
    Drops = Drops.concat(16)
    Drops = Drops.concat(16)
    Drops = Drops.concat(17)
    Drops = Drops.concat(17)
    Drops = Drops.concat(18)
    Drops = Drops.concat(18)
    Drops = Drops.concat(18)
    Drops = Drops.concat(18)
    Drops = Drops.concat(18)
    Drops = Drops.concat(19)
    Drops = Drops.concat(19)
    Drops = Drops.concat(20)
    Drops = Drops.concat(20)
    isSpawning = false
    ItemsOnFloor = []
    numberOfDrops = 10
    LightShafts = []
    ItemsToDrop = []
    dropsIndex = 0
    lightShaftEntity = []
    getAllPlayers().resetHeroAvailability()
    disableAnnouncer()
    disableMusic()
    hudSubtext(getAllPlayers(), "Made by Tayyab. Join the discord! discord.gg/vjF2v3p", HudPosition.RIGHT, -1, Color.TURQUOISE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "initialise inventory and player vars":
    @Event eachPlayer
    
    hudSubtext(eventPlayer, "INVENTORY:", HudPosition.LEFT, 0, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, ">EMPTY", HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    hudHeader(eventPlayer, "EMPTY", HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    hudHeader(eventPlayer, "EMPTY", HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    hudHeader(eventPlayer, "EMPTY", HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    eventPlayer.InvIndex = 0
    eventPlayer.currentInvIndex = 0
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickup2 = false
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.setUltEnabled(false)
    eventPlayer.PlayerToBeChanged = null
    createIcon([player for player in getAllPlayers() if player.WallHacks == true], eventPlayer, Icon.SKULL, IconReeval.VISIBILITY_AND_POSITION, Color.RED, true)


rule "Item Pickup":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == false
    
    eventPlayer.tempArray = []
    eventPlayer.ItemBeingLookedAt = [player for player in ItemsOnFloor if abs(eventPlayer.getPosition() - player) <= 5]
    eventPlayer.ItemBeingLookedAt = [player for player in eventPlayer.ItemBeingLookedAt if abs(player) != player]
    eventPlayer.ItemBeingLookedAt = sorted(eventPlayer.ItemBeingLookedAt, lambda player: abs(eventPlayer.getPosition() - player))
    eventPlayer.ItemBeingLookedAt = eventPlayer.ItemBeingLookedAt[0]
    eventPlayer.ItemBeingLookedAt = ItemsOnFloor.index(eventPlayer.ItemBeingLookedAt)
    eventPlayer.tempArray = eventPlayer.tempArray.concat(eventPlayer.Inv1)
    eventPlayer.tempArray = eventPlayer.tempArray.concat(eventPlayer.Inv2)
    eventPlayer.tempArray = eventPlayer.tempArray.concat(eventPlayer.Inv3)
    eventPlayer.tempArray = eventPlayer.tempArray.concat(eventPlayer.Inv4)
    if eventPlayer.ItemBeingLookedAt == -1:
        goto lbl_0
    if eventPlayer.tempArray.index(0) != -1:
        goto lbl_1
    smallMessage(eventPlayer, "Inventory Full")
    return
    lbl_1:
    playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 10)
    destroyEffect(ItemsOnFloor[eventPlayer.ItemBeingLookedAt + 1])
    destroyInWorldText(ItemsOnFloor[eventPlayer.ItemBeingLookedAt + 2])
    eventPlayer.ItemToBeAdded = ItemsOnFloor[eventPlayer.ItemBeingLookedAt - 1]
    ItemsOnFloor = (ItemsOnFloor.slice(0, eventPlayer.ItemBeingLookedAt - 1)).concat(ItemsOnFloor.slice(eventPlayer.ItemBeingLookedAt + 3, 9999999))
    eventPlayer.ItemBeingLookedAt = []
    eventPlayer.tempArray = eventPlayer.tempArray.index(0)
    eventPlayer.invIndexCopy = eventPlayer.InvIndex
    eventPlayer.isPickingUp = true
    if eventPlayer.tempArray != 0:
        goto lbl_2
    if eventPlayer.InvIndex != 0:
        goto lbl_3
    eventPlayer.Inv1 = eventPlayer.ItemToBeAdded
    eventPlayer.InventoryItemSelect = eventPlayer.ItemToBeAdded
    return
    lbl_3:
    if eventPlayer.InvIndex == 0:
        goto lbl_4
    eventPlayer.Inv1 = eventPlayer.ItemToBeAdded
    eventPlayer.InvIndex = 1
    eventPlayer.InvItemUnselect = eventPlayer.ItemToBeAdded
    return
    lbl_2:
    lbl_4:
    if eventPlayer.tempArray != 1:
        goto lbl_5
    if eventPlayer.InvIndex != 1:
        goto lbl_6
    eventPlayer.Inv2 = eventPlayer.ItemToBeAdded
    eventPlayer.InventoryItemSelect = eventPlayer.ItemToBeAdded
    return
    lbl_6:
    if eventPlayer.InvIndex == 1:
        goto lbl_7
    eventPlayer.Inv2 = eventPlayer.ItemToBeAdded
    eventPlayer.InvIndex = 2
    eventPlayer.InvItemUnselect = eventPlayer.ItemToBeAdded
    return
    lbl_5:
    lbl_7:
    if eventPlayer.tempArray != 2:
        goto lbl_8
    eventPlayer.isPickup2 = true
    return
    lbl_8:
    if eventPlayer.tempArray != 3:
        goto lbl_9
    eventPlayer.isPickup2 = true
    return
    lbl_0:
    lbl_9:


rule "Item Pickup 2":
    @Event eachPlayer
    @Condition eventPlayer.isPickup2 == true
    
    if eventPlayer.tempArray != 2:
        goto lbl_0
    if eventPlayer.InvIndex != 2:
        goto lbl_1
    eventPlayer.Inv3 = eventPlayer.ItemToBeAdded
    eventPlayer.InventoryItemSelect = eventPlayer.ItemToBeAdded
    eventPlayer.isPickup2 = false
    return
    lbl_1:
    if eventPlayer.InvIndex == 2:
        goto lbl_2
    eventPlayer.Inv3 = eventPlayer.ItemToBeAdded
    eventPlayer.InvIndex = 3
    eventPlayer.InvItemUnselect = eventPlayer.ItemToBeAdded
    eventPlayer.isPickup2 = false
    return
    lbl_0:
    lbl_2:
    if eventPlayer.tempArray != 3:
        goto lbl_3
    if eventPlayer.InvIndex != 3:
        goto lbl_4
    eventPlayer.Inv4 = eventPlayer.ItemToBeAdded
    eventPlayer.InventoryItemSelect = eventPlayer.ItemToBeAdded
    eventPlayer.isPickup2 = false
    return
    lbl_4:
    if eventPlayer.InvIndex == 3:
        goto lbl_5
    eventPlayer.Inv4 = eventPlayer.ItemToBeAdded
    eventPlayer.InvIndex = 0
    eventPlayer.InvItemUnselect = eventPlayer.ItemToBeAdded
    eventPlayer.isPickup2 = false
    return
    lbl_3:
    lbl_5:


rule "Using Item inv 1":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.InvIndex == 0
    @Condition eventPlayer.Inv1 != 0
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    eventPlayer.ItemBeingUsed = eventPlayer.Inv1
    eventPlayer.Inv1 = 0
    changeItemDesc()


rule "Using Item inv 2":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.InvIndex == 1
    @Condition eventPlayer.Inv2 != 0
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    eventPlayer.ItemBeingUsed = eventPlayer.Inv2
    eventPlayer.Inv2 = 0
    changeItemDesc()


rule "Using Item inv 3":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.InvIndex == 2
    @Condition eventPlayer.Inv3 != 0
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    eventPlayer.ItemBeingUsed = eventPlayer.Inv3
    eventPlayer.Inv3 = 0
    changeItemDesc()


rule "Using Item inv 4":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.InvIndex == 3
    @Condition eventPlayer.Inv4 != 0
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    eventPlayer.ItemBeingUsed = eventPlayer.Inv4
    eventPlayer.Inv4 = 0
    changeItemDesc()


rule "spawn item":
    @Condition isGameInProgress() == true
    
    DropsReady = 0.5
    setMatchTime(30)
    wait(30)
    goto RULE_START


rule "Clear all items":
    @Condition DropsReady == 0.5
    @Condition ItemsOnFloor == []
    
    DropsReady = 1


rule "Clear all items":
    @Condition DropsReady == 0.5
    @Condition ItemsOnFloor != []
    
    destroyEffect(ItemsOnFloor[2])
    destroyInWorldText(ItemsOnFloor[3])
    ItemsOnFloor = ItemsOnFloor.slice(4, 9999999)
    wait()
    if ItemsOnFloor != []:
        goto RULE_START
    DropsReady = 1


rule "Inventory Selection":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    eventPlayer.InvIndex = eventPlayer.InvIndex + 1
    if eventPlayer.InvIndex <= 3:
        goto lbl_0
    eventPlayer.InvIndex = 0
    lbl_0:


rule "1 - HP heals 75":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 1
    
    eventPlayer.startHoT(eventPlayer, 0.5, 150)
    eventPlayer.ItemBeingUsed = 0
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.GREEN, eventPlayer, 10)


rule "1 - HP heals 75 HUD Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 1
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Small)"), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Small)"), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Small)"), HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Small)"), HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "1 - HP heals 75 HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 1
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Small)"), HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Small)"), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Small)"), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Small)"), HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "2 - HP heals 125":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 2
    
    eventPlayer.startHoT(eventPlayer, 1, 125)
    eventPlayer.ItemBeingUsed = 0
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.GREEN, eventPlayer, 10)


rule "2 - HP heals 125 HUD Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 2
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Medium)"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Medium)"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Medium)"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Medium)"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "2 - HP heals 125 HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 2
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Medium)"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Medium)"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Medium)"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Medium)"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "3 - Unlock Ability 2":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 3
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.setAbility2Enabled(true)
    smallMessage(eventPlayer, "Abillity 2 Unlocked")
    playEffect(eventPlayer, DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)


rule "3 - Unlock Ability 2 Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 3
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Abillity Key 2"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Abillity Key 2"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Abillity Key 2"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Abillity Key 2"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "3 - Unlock Ability 2 HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 3
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Abillity Key 2"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Abillity Key 2"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Abillity Key 2"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Abillity Key 2"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "4 - Unlock Ability 1":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 4
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.setAbility1Enabled(true)
    smallMessage(eventPlayer, "Abillity 1 Unlocked")
    playEffect(eventPlayer, DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)


rule "4 - Unlock Ability 1 Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 4
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Ability key 1"), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Ability key 1"), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Ability key 1"), HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Ability key 1"), HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "4 - Unlock Ability 1 HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 4
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Ability key 1"), HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Ability key 1"), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Ability key 1"), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Ability key 1"), HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "5 - HP heals 200":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 5
    
    eventPlayer.startHoT(eventPlayer, 1, 200)
    eventPlayer.ItemBeingUsed = 0
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.GREEN, eventPlayer, 10)


rule "5 - HP heals 200 HUD Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 5
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Large)"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Large)"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Large)"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.PLUS), "Health Shot (Large)"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "5 - HP heals 200 HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 5
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Large)"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Large)"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Large)"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.PLUS), "Health Shot (Large)"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "6 - Super Jump":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 6
    
    eventPlayer.ItemBeingUsed = 0
    playEffect(eventPlayer, DynamicEffect.GOOD_EXPLOSION, Color.WHITE, eventPlayer, 100)
    eventPlayer.applyImpulse(vect(0, 1, 0), 20, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "6 - Super Jump HUD Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 6
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.ARROW_UP), "Exo Boots"), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.ARROW_UP), "Exo Boots"), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.ARROW_UP), "Exo Boots"), HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.ARROW_UP), "Exo Boots"), HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "6 - Super Jump HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 6
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.ARROW_UP), "Exo Boots"), HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.ARROW_UP), "Exo Boots"), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.ARROW_UP), "Exo Boots"), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.ARROW_UP), "Exo Boots"), HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "7 - Refresher":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 7
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.HeroHealth = eventPlayer.getHealth()
    eventPlayer.Hero = eventPlayer.getCurrentHero()
    eventPlayer.preloadHero(eventPlayer.Hero)
    eventPlayer.startForcingHero(Hero.ANA)
    eventPlayer.startForcingHero(eventPlayer.Hero)
    eventPlayer.stopForcingCurrentHero()


rule "7 -Refresher HUD Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 7
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.RECYCLE), "Refresher"), HudPosition.LEFT, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.RECYCLE), "Refresher"), HudPosition.LEFT, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.RECYCLE), "Refresher"), HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.RECYCLE), "Refresher"), HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "7 - Refresher HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 7
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.RECYCLE), "Refresher"), HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.RECYCLE), "Refresher"), HudPosition.LEFT, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.RECYCLE), "Refresher"), HudPosition.LEFT, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.RECYCLE), "Refresher"), HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "8 - Unlock ult":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 8
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.setUltEnabled(true)
    smallMessage(eventPlayer, "Ultimate Unlocked")
    playEffect(eventPlayer, DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)


rule "8 - Unlock ult Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 8
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Ultimate key"), HudPosition.LEFT, 1, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Ultimate key"), HudPosition.LEFT, 2, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Ultimate key"), HudPosition.LEFT, 3, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Ultimate key"), HudPosition.LEFT, 4, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "8 - Unlock ult HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 8
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Ultimate key"), HudPosition.LEFT, 4, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Ultimate key"), HudPosition.LEFT, 1, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Ultimate key"), HudPosition.LEFT, 2, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Ultimate key"), HudPosition.LEFT, 3, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "9 - Hero Changer(choice)":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 9
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.setAllowedHeroes(getDamageHeroes().exclude(eventPlayer.getCurrentHero()))
    wait(0.25)
    eventPlayer.setAllowedHeroes(getDamageHeroes())


rule "9 - Hero Changer(choice) Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 9
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Hero Change-inator"), HudPosition.LEFT, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Hero Change-inator"), HudPosition.LEFT, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Hero Change-inator"), HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Hero Change-inator"), HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "9 - Hero Changer(choice) HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 9
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Hero Change-inator"), HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Hero Change-inator"), HudPosition.LEFT, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Hero Change-inator"), HudPosition.LEFT, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Hero Change-inator"), HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "UnTargeting for enemy hero change 2":
    @Event eachPlayer
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 10) == []
    
    destroyInWorldText(eventPlayer.SelectTextId)
    eventPlayer.PlayerToBeChanged = null


rule "10 - Hero Changer(enemy)":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 10
    @Condition eventPlayer.PlayerToBeChanged != null
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.PlayerToBeChanged.startForcingHero(random.choice(getDamageHeroes()))
    eventPlayer.PlayerToBeChanged.stopForcingCurrentHero()


rule "10 - Hero Changer(enemy) Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 10
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Enemy Hero Change-inator"), HudPosition.LEFT, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Enemy Hero Change-inator"), HudPosition.LEFT, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Enemy Hero Change-inator"), HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Enemy Hero Change-inator"), HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "10 - Hero Changer(enemy) HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 10
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Enemy Hero Change-inator"), HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Enemy Hero Change-inator"), HudPosition.LEFT, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Enemy Hero Change-inator"), HudPosition.LEFT, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Enemy Hero Change-inator"), HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "11 - Wall Hacks":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 11
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.WallHacks = true
    smallMessage(eventPlayer, "Radar Activated!")
    wait(14)
    eventPlayer.WallHacks = false


rule "11 - Wall Hacks Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 11
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.EYE), "Radar"), HudPosition.LEFT, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.EYE), "Radar"), HudPosition.LEFT, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.EYE), "Radar"), HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.EYE), "Radar"), HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "11 - Wall Hacks HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 11
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.EYE), "Radar"), HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.EYE), "Radar"), HudPosition.LEFT, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.EYE), "Radar"), HudPosition.LEFT, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.EYE), "Radar"), HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "12 - Knock Down Functionality":
    @Event playerDealtDamage
    @Condition attacker.KnockDown == true
    
    victim.setStatusEffect(null, Status.KNOCKED_DOWN, 1)
    attacker.KnockDown = false


rule "12 - Knock Down Shell":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 12
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.KnockDown = true
    smallMessage(eventPlayer, "Knock Down Shell Equipped")


rule "12 - Knock Down Shell HUD Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 12
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.DIZZY), "Knock Down Shell"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.DIZZY), "Knock Down Shell"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.DIZZY), "Knock Down Shell"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.DIZZY), "Knock Down Shell"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "12 - Knock Down Shell HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 12
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.DIZZY), "Knock Down Shell"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.DIZZY), "Knock Down Shell"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.DIZZY), "Knock Down Shell"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.DIZZY), "Knock Down Shell"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "13 - Running Shoes":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 13
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.setMoveSpeed(150)
    hudHeader(eventPlayer, iconString(Icon.BOLT), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.RunningTextID = getLastCreatedText()
    smallMessage(eventPlayer, "Running Shoes Equipped! Run!")
    wait(7)
    eventPlayer.setMoveSpeed(100)
    destroyHudText(eventPlayer.RunningTextID)


rule "13 - Running Shoes HUD Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 13
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.BOLT), "Running Shoes"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.BOLT), "Running Shoes"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.BOLT), "Running Shoes"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.BOLT), "Running Shoes"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "13 - Running Shoes HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 13
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.BOLT), "Running Shoes"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.BOLT), "Running Shoes"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.BOLT), "Running Shoes"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.BOLT), "Running Shoes"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "14 - Invinci-Juice":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 14
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.setStatusEffect(null, Status.UNKILLABLE, 5)
    hudHeader(eventPlayer, iconString(Icon.NO), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.InvincibillityTextID = getLastCreatedText()
    bigMessage(getAllPlayers(), "{0}{1} Is invincible!".format(heroIcon(eventPlayer.getCurrentHero()), eventPlayer))
    wait(4.9)
    destroyHudText(eventPlayer.InvincibillityTextID)


rule "14 - Invinci-Juice Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 14
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.NO), "Invinci-Juice"), HudPosition.LEFT, 1, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.NO), "Invinci-Juice"), HudPosition.LEFT, 2, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.NO), "Invinci-Juice"), HudPosition.LEFT, 3, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.NO), "Invinci-Juice"), HudPosition.LEFT, 4, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "14 - Invinci-Juice HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 14
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.NO), "Invinci-Juice"), HudPosition.LEFT, 4, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.NO), "Invinci-Juice"), HudPosition.LEFT, 1, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.NO), "Invinci-Juice"), HudPosition.LEFT, 2, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.NO), "Invinci-Juice"), HudPosition.LEFT, 3, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "15 - Teleporter":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 15
    
    eventPlayer.ItemBeingUsed = 0
    playEffect(eventPlayer, DynamicEffect.GOOD_EXPLOSION, Color.WHITE, eventPlayer, 100)
    eventPlayer.teleport(random.choice(SpawnPos))


rule "15 - Teleporter HUD Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 15
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.SPIRAL), "Slightly Useful Teleporter"), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.SPIRAL), "Slightly Useful Teleporter"), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.SPIRAL), "Slightly Useful Teleporter"), HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.SPIRAL), "Slightly Useful Teleporter"), HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "15 - Teleporter HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 15
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.SPIRAL), "Slightly Useful Teleporter"), HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.SPIRAL), "Slightly Useful Teleporter"), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.SPIRAL), "Slightly Useful Teleporter"), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.SPIRAL), "Slightly Useful Teleporter"), HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "16 - Fire-Tipped Ammo":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 16
    
    eventPlayer.ItemBeingUsed = 0
    hudHeader(eventPlayer, iconString(Icon.FIRE), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.BurnTextID = getLastCreatedText()
    eventPlayer.Burn = true
    smallMessage(eventPlayer, "Fire-Tipped Ammo Equiped!")
    wait(7)
    destroyHudText(eventPlayer.BurnTextID)
    eventPlayer.Burn = false


rule "16 - Fire-Tipped Ammo HUD Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 16
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.FIRE), "Fire-Tipped Ammo"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.FIRE), "Fire-Tipped Ammo"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.FIRE), "Fire-Tipped Ammo"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.FIRE), "Fire-Tipped Ammo"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "16 - Fire-Tipped Ammo HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 16
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.FIRE), "Fire-Tipped Ammo"), HudPosition.LEFT, 4, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.FIRE), "Fire-Tipped Ammo"), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.FIRE), "Fire-Tipped Ammo"), HudPosition.LEFT, 2, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.FIRE), "Fire-Tipped Ammo"), HudPosition.LEFT, 3, Color.BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "Burn Damage for Fire-Tipped Ammo":
    @Event playerDealtDamage
    @Condition attacker.Burn == true
    @Condition victim.hasStatusEffect(Status.BURNING) != true
    
    victim.setStatusEffect(null, Status.BURNING, 5)
    victim.startDoT(attacker, 5, 10)


rule "17 - Hero Changer(random)":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 17
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.startForcingHero(random.choice(getDamageHeroes().exclude(eventPlayer.getCurrentHero())))
    eventPlayer.stopForcingCurrentHero()


rule "17 - Hero Changer(random) Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 17
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Broken Hero Change-inator"), HudPosition.LEFT, 1, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Broken Hero Change-inator"), HudPosition.LEFT, 2, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Broken Hero Change-inator"), HudPosition.LEFT, 3, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", heroIcon(eventPlayer.getCurrentHero()), "Broken Hero Change-inator"), HudPosition.LEFT, 4, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "17 - Hero Changer(random) HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 17
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Broken Hero Change-inator"), HudPosition.LEFT, 4, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Broken Hero Change-inator"), HudPosition.LEFT, 1, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Broken Hero Change-inator"), HudPosition.LEFT, 2, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(heroIcon(eventPlayer.getCurrentHero()), "Broken Hero Change-inator"), HudPosition.LEFT, 3, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "18 - Smoke Grenade":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 18
    
    eventPlayer.ItemBeingUsed = 0
    createEffect(getAllPlayers(), Effect.CLOUD, Color.BLUE, eventPlayer.getPosition() + vect(0, 0, 0), 5, EffectReeval.NONE)
    eventPlayer.SmokeGrenadeEntity = eventPlayer.SmokeGrenadeEntity.concat(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.CLOUD, Color.BLUE, eventPlayer.getPosition() + vect(0, 0, 0), 5, EffectReeval.NONE)
    eventPlayer.SmokeGrenadeEntity = eventPlayer.SmokeGrenadeEntity.concat(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.CLOUD, Color.BLUE, eventPlayer.getPosition() + vect(0, 0, 0), 5, EffectReeval.NONE)
    eventPlayer.SmokeGrenadeEntity = eventPlayer.SmokeGrenadeEntity.concat(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.CLOUD, Color.BLUE, eventPlayer.getPosition() + vect(0, 0, 0), 5, EffectReeval.NONE)
    eventPlayer.SmokeGrenadeEntity = eventPlayer.SmokeGrenadeEntity.concat(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.CLOUD, Color.BLUE, eventPlayer.getPosition() + vect(0, 0, 0), 5, EffectReeval.NONE)
    eventPlayer.SmokeGrenadeEntity = eventPlayer.SmokeGrenadeEntity.concat(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.CLOUD, Color.BLUE, eventPlayer.getPosition() + vect(0, 1, 0), 5, EffectReeval.NONE)
    eventPlayer.SmokeGrenadeEntity = eventPlayer.SmokeGrenadeEntity.concat(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.CLOUD, Color.BLUE, eventPlayer.getPosition() + vect(0, 1, 0), 5, EffectReeval.NONE)
    eventPlayer.SmokeGrenadeEntity = eventPlayer.SmokeGrenadeEntity.concat(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.CLOUD, Color.BLUE, eventPlayer.getPosition() + vect(0, 1, 0), 5, EffectReeval.NONE)
    eventPlayer.SmokeGrenadeEntity = eventPlayer.SmokeGrenadeEntity.concat(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.CLOUD, Color.BLUE, eventPlayer.getPosition() + vect(0, 1, 0), 5, EffectReeval.NONE)
    eventPlayer.SmokeGrenadeEntity = eventPlayer.SmokeGrenadeEntity.concat(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.CLOUD, Color.BLUE, eventPlayer.getPosition() + vect(0, 1, 0), 5, EffectReeval.NONE)
    eventPlayer.SmokeGrenadeEntity = eventPlayer.SmokeGrenadeEntity.concat(getLastCreatedEntity())
    wait(10)
    eventPlayer.ClearSmoke = true


rule "18 - Smoke Grenade Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 18
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.WARNING), "Smoke Grenade"), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.WARNING), "Smoke Grenade"), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.WARNING), "Smoke Grenade"), HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.WARNING), "Smoke Grenade"), HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "18 - Smoke Grenade HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 18
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.WARNING), "Smoke Grenade"), HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.WARNING), "Smoke Grenade"), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.WARNING), "Smoke Grenade"), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.WARNING), "Smoke Grenade"), HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "Clear Smoke Grenades Effects":
    @Event eachPlayer
    @Condition eventPlayer.ClearSmoke == true
    
    destroyEffect(eventPlayer.SmokeGrenadeEntity[0])
    eventPlayer.SmokeGrenadeEntity = eventPlayer.SmokeGrenadeEntity.slice(1, 9999)
    wait()
    if eventPlayer.SmokeGrenadeEntity != []:
        goto RULE_START
    eventPlayer.ClearSmoke = false


rule "19 - Invisible":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 19
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.setInvisibility(Invis.ALL)
    hudHeader(eventPlayer, iconString(Icon.QUESTION_MARK), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.InvisibleTextID = getLastCreatedText()
    bigMessage(getAllPlayers(), "{0}{1} Is invisble!".format(heroIcon(eventPlayer.getCurrentHero()), eventPlayer))
    wait(7)
    eventPlayer.setInvisibility(Invis.NONE)
    destroyHudText(eventPlayer.InvisibleTextID)


rule "19 - Invisible Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 19
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.QUESTION_MARK), "Invisibox"), HudPosition.LEFT, 1, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.QUESTION_MARK), "Invisibox"), HudPosition.LEFT, 2, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.QUESTION_MARK), "Invisibox"), HudPosition.LEFT, 3, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.QUESTION_MARK), "Invisibox"), HudPosition.LEFT, 4, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "19 - Invisible HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 19
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.QUESTION_MARK), "Invisibox"), HudPosition.LEFT, 4, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.QUESTION_MARK), "Invisibox"), HudPosition.LEFT, 1, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.QUESTION_MARK), "Invisibox"), HudPosition.LEFT, 2, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.QUESTION_MARK), "Invisibox"), HudPosition.LEFT, 3, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "20 - Insta-ult":
    @Event eachPlayer
    @Condition eventPlayer.ItemBeingUsed == 20
    
    eventPlayer.ItemBeingUsed = 0
    eventPlayer.setUltEnabled(true)
    eventPlayer.setUltCharge(100)
    playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.WHITE, eventPlayer, 10)


rule "20 - Insta-ult Creation Select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 20
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Insta-ult"), HudPosition.LEFT, 1, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Insta-ult"), HudPosition.LEFT, 2, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Insta-ult"), HudPosition.LEFT, 3, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1} {2}".format(">", iconString(Icon.CHECKMARK), "Insta-ult"), HudPosition.LEFT, 4, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1
    eventPlayer.isPickingUp = false
    changeItemDesc()


rule "20 - Insta-ult HUD unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 20
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Insta-ult"), HudPosition.LEFT, 4, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Insta-ult"), HudPosition.LEFT, 1, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Insta-ult"), HudPosition.LEFT, 2, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, l"{0} {1}".format(iconString(Icon.CHECKMARK), "Insta-ult"), HudPosition.LEFT, 3, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    if eventPlayer.isPickingUp != true:
        goto lbl_4
    eventPlayer.InvIndex = eventPlayer.invIndexCopy
    lbl_4:
    eventPlayer.InvItemUnselect = -1
    eventPlayer.isPickingUp = false


rule "Empty item select":
    @Event eachPlayer
    @Condition eventPlayer.InventoryItemSelect == 0
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_3:
    eventPlayer.InventoryItemSelect = -1


rule "Empty item unselect":
    @Event eachPlayer
    @Condition eventPlayer.InvItemUnselect == 0
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, "EMPTY", HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, "EMPTY", HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, "EMPTY", HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, "EMPTY", HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    lbl_3:
    eventPlayer.InvItemUnselect = -1


rule "Inventory Controller":
    @Event eachPlayer
    @Condition eventPlayer.InvIndex != eventPlayer.currentInvIndex
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    eventPlayer.InventoryItemSelect = eventPlayer.Inv1
    eventPlayer.InvItemUnselect = eventPlayer.Inv4
    eventPlayer.currentInvIndex = eventPlayer.InvIndex
    changeItemDesc()
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    eventPlayer.InventoryItemSelect = eventPlayer.Inv2
    eventPlayer.InvItemUnselect = eventPlayer.Inv1
    eventPlayer.currentInvIndex = eventPlayer.InvIndex
    changeItemDesc()
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    eventPlayer.InventoryItemSelect = eventPlayer.Inv3
    eventPlayer.InvItemUnselect = eventPlayer.Inv2
    eventPlayer.currentInvIndex = eventPlayer.InvIndex
    changeItemDesc()
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    eventPlayer.InventoryItemSelect = eventPlayer.Inv4
    eventPlayer.InvItemUnselect = eventPlayer.Inv3
    eventPlayer.currentInvIndex = eventPlayer.InvIndex
    changeItemDesc()
    lbl_3:


rule "Drop Item":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    
    if eventPlayer.InvIndex != 0:
        goto lbl_0
    ItemsToDrop = ItemsToDrop.concat(eventPlayer.Inv1)
    ItemsToDrop = ItemsToDrop.concat(nearestWalkablePosition(eventPlayer.getPosition()))
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    eventPlayer.Inv1 = 0
    lbl_0:
    if eventPlayer.InvIndex != 1:
        goto lbl_1
    ItemsToDrop = ItemsToDrop.concat(eventPlayer.Inv2)
    ItemsToDrop = ItemsToDrop.concat(nearestWalkablePosition(eventPlayer.getPosition()))
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    eventPlayer.Inv2 = 0
    lbl_1:
    if eventPlayer.InvIndex != 2:
        goto lbl_2
    ItemsToDrop = ItemsToDrop.concat(eventPlayer.Inv3)
    ItemsToDrop = ItemsToDrop.concat(nearestWalkablePosition(eventPlayer.getPosition()))
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    eventPlayer.Inv3 = 0
    lbl_2:
    if eventPlayer.InvIndex != 3:
        goto lbl_3
    ItemsToDrop = ItemsToDrop.concat(eventPlayer.Inv4)
    ItemsToDrop = ItemsToDrop.concat(nearestWalkablePosition(eventPlayer.getPosition()))
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    eventPlayer.Inv4 = 0
    lbl_3:


rule "Targeting for enemy hero change inv 1":
    @Event eachPlayer
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 10) != []
    @Condition eventPlayer.InvIndex == 0
    @Condition eventPlayer.Inv1 == 10
    
    eventPlayer.PlayersInAngleView = eventPlayer.getPlayersInViewAngle(Team.ALL, 10)
    eventPlayer.PlayersInAngleView = sorted(eventPlayer.PlayersInAngleView, lambda player: distance(player.getPosition(), eventPlayer.getPosition()))
    eventPlayer.PlayerToBeChanged = eventPlayer.PlayersInAngleView[0]
    createInWorldText(eventPlayer, iconString(Icon.ARROW_DOWN), eventPlayer.PlayerToBeChanged.getPosition() + vect(0, 1.5, 0), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.DEFAULT)
    eventPlayer.SelectTextId = getLastCreatedText()


rule "Targeting for enemy hero change inv 2":
    @Event eachPlayer
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 10) != []
    @Condition eventPlayer.InvIndex == 1
    @Condition eventPlayer.Inv2 == 10
    
    eventPlayer.PlayersInAngleView = eventPlayer.getPlayersInViewAngle(Team.ALL, 10)
    eventPlayer.PlayersInAngleView = sorted(eventPlayer.PlayersInAngleView, lambda player: distance(player.getPosition(), eventPlayer.getPosition()))
    eventPlayer.PlayerToBeChanged = eventPlayer.PlayersInAngleView[0]
    createInWorldText(eventPlayer, iconString(Icon.ARROW_DOWN), eventPlayer.PlayerToBeChanged.getPosition() + vect(0, 1.5, 0), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.DEFAULT)
    eventPlayer.SelectTextId = getLastCreatedText()


rule "Targeting for enemy hero change inv 3":
    @Event eachPlayer
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 10) != []
    @Condition eventPlayer.InvIndex == 2
    @Condition eventPlayer.Inv3 == 10
    
    eventPlayer.PlayersInAngleView = eventPlayer.getPlayersInViewAngle(Team.ALL, 10)
    eventPlayer.PlayersInAngleView = sorted(eventPlayer.PlayersInAngleView, lambda player: distance(player.getPosition(), eventPlayer.getPosition()))
    eventPlayer.PlayerToBeChanged = eventPlayer.PlayersInAngleView[0]
    createInWorldText(eventPlayer, iconString(Icon.ARROW_DOWN), eventPlayer.PlayerToBeChanged.getPosition() + vect(0, 1.5, 0), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.DEFAULT)
    eventPlayer.SelectTextId = getLastCreatedText()


rule "Targeting for enemy hero change inv 4":
    @Event eachPlayer
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 10) != []
    @Condition eventPlayer.InvIndex == 3
    @Condition eventPlayer.Inv4 == 10
    
    eventPlayer.PlayersInAngleView = eventPlayer.getPlayersInViewAngle(Team.ALL, 10)
    eventPlayer.PlayersInAngleView = sorted(eventPlayer.PlayersInAngleView, lambda player: distance(player.getPosition(), eventPlayer.getPosition()))
    eventPlayer.PlayerToBeChanged = eventPlayer.PlayersInAngleView[0]
    createInWorldText(eventPlayer, iconString(Icon.ARROW_DOWN), eventPlayer.PlayerToBeChanged.getPosition() + vect(0, 1.5, 0), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.DEFAULT)
    eventPlayer.SelectTextId = getLastCreatedText()


rule "Generate Drops":
    @Condition DropsReady == 1
    
    currentLightShaftPos = random.choice(SpawnPos)
    LightShafts = LightShafts.concat(currentLightShaftPos)
    if len([player for player in LightShafts if player == currentLightShaftPos]) == 1:
        goto lbl_0
    LightShafts = LightShafts.exclude(currentLightShaftPos)
    lbl_0:
    dropsIndex = dropsIndex + 1
    wait()
    if dropsIndex < numberOfDrops:
        goto RULE_START
    DropsReady = 1.5
    dropsIndex = 0


rule "Light Shaft Creation":
    @Condition DropsReady == 1.5
    
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.WHITE, LightShafts[lightShaftIndex], 2, EffectReeval.VISIBILITY)
    lightShaftEntity = lightShaftEntity.concat(getLastCreatedEntity())
    lightShaftIndex = lightShaftIndex + 1
    wait()
    if lightShaftIndex < len(LightShafts):
        goto RULE_START
    bigMessage(getAllPlayers(), "Drops Incoming")
    wait(5)
    lightShaftIndex = 0
    DropsReady = 1.9


rule "Light Shaft Destruction":
    @Condition DropsReady == 1.9
    
    destroyEffect(lightShaftEntity[lightShaftIndex])
    lightShaftIndex = lightShaftIndex + 1
    wait()
    if lightShaftIndex < len(LightShafts):
        goto RULE_START
    lightShaftEntity = []
    lightShaftIndex = 0
    DropsReady = 2


rule "Generate Drops 2 - Item Generation":
    @Condition DropsReady == 2
    
    ItemsToDrop = ItemsToDrop.concat(random.choice(Drops))
    ItemsToDrop = ItemsToDrop.concat(LightShafts[0] + vect(2, -1, 0))
    ItemsToDrop = ItemsToDrop.concat(random.choice(Drops))
    ItemsToDrop = ItemsToDrop.concat(LightShafts[0] + vect(0, -1, 2))
    ItemsToDrop = ItemsToDrop.concat(random.choice(Drops))
    ItemsToDrop = ItemsToDrop.concat(LightShafts[0] + vect(2, -1, 2))
    LightShafts = LightShafts.slice(1, 9999)
    wait()
    if LightShafts != []:
        goto RULE_START
    DropsReady = 3


rule "Create Items In Game 1":
    @Condition 1 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 1
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.WHITE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Health Shot (Small)", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 1
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 2":
    @Condition 2 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 2
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.BLUE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Health Shot (Medium)", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 2
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 3":
    @Condition 3 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 3
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.BLUE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Ability Key 2", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 3
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 4":
    @Condition 4 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 4
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.WHITE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Ability Key 1", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 4
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 5":
    @Condition 5 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 5
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.BLUE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Health Shot (Large)", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 5
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 6":
    @Condition 6 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 6
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.WHITE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Exo Boots", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 6
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 7":
    @Condition 7 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 7
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.YELLOW, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Refresh", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.4, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.YELLOW, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 7
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 8":
    @Condition 8 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 8
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.PURPLE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Ultimate key", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.PURPLE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 8
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 9":
    @Condition 9 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 9
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.YELLOW, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Hero Change-inator", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.4, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.YELLOW, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 9
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 10":
    @Condition 10 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 10
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.YELLOW, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Enemy Hero Change-inator", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.4, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.YELLOW, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 10
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 11":
    @Condition 11 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 11
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.YELLOW, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Radar", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.4, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.YELLOW, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 11
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 12":
    @Condition 12 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 12
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.BLUE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Knock Down Shell", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 12
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 13":
    @Condition 13 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 13
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.BLUE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Running Shoes", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 13
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 14":
    @Condition 14 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 14
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.PURPLE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Invinci-Juice", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.PURPLE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 14
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 15":
    @Condition 15 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 15
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.WHITE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Slightly Useful Teleporter", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 15
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 16":
    @Condition 16 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 16
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.BLUE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Fire-Tipped Ammo", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 16
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 17":
    @Condition 17 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 17
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.PURPLE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Broken Hero Change-inator", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.PURPLE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 17
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 18":
    @Condition 18 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 18
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.WHITE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Smoke Grenade", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 18
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 19":
    @Condition 19 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 19
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.PURPLE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Invisibox", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.PURPLE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 19
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Create Items In Game 20":
    @Condition 20 in ItemsToDrop == true
    @Condition DropsReady == 3
    
    currentItemBeingSpawned = 20
    ItemsOnFloor = ItemsOnFloor.concat(currentItemBeingSpawned)
    ItemsOnFloor = ItemsOnFloor.concat(ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1])
    createEffect(getAllPlayers(), Effect.ORB, Color.PURPLE, ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 0.05, EffectReeval.VISIBILITY)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedEntity())
    createInWorldText(getAllPlayers(), "Insta-ult", ItemsToDrop[ItemsToDrop.index(currentItemBeingSpawned) + 1], 1.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.PURPLE, SpecVisibility.DEFAULT)
    ItemsOnFloor = ItemsOnFloor.concat(getLastCreatedText())
    ItemsToDrop = ItemsToDrop.slice(0, ItemsToDrop.index(currentItemBeingSpawned)).concat(ItemsToDrop.slice(ItemsToDrop.index(currentItemBeingSpawned) + 2, 10000))
    wait()
    currentItemBeingSpawned = 10
    if currentItemBeingSpawned in ItemsToDrop == true:
        goto RULE_START


rule "Drop items on death":
    @Event playerDied
    
    if eventPlayer.Inv1 == 0:
        goto lbl_0
    ItemsToDrop = ItemsToDrop.concat(eventPlayer.Inv1)
    ItemsToDrop = ItemsToDrop.concat(nearestWalkablePosition(eventPlayer.getPosition()) + vect(0, 0, 0))
    lbl_0:
    if eventPlayer.Inv2 == 0:
        goto lbl_1
    ItemsToDrop = ItemsToDrop.concat(eventPlayer.Inv2)
    ItemsToDrop = ItemsToDrop.concat(nearestWalkablePosition(eventPlayer.getPosition()) + vect(2, 0, 0))
    lbl_1:
    if eventPlayer.Inv3 == 0:
        goto lbl_2
    ItemsToDrop = ItemsToDrop.concat(eventPlayer.Inv3)
    ItemsToDrop = ItemsToDrop.concat(nearestWalkablePosition(eventPlayer.getPosition()) + vect(0, 0, 2))
    lbl_2:
    if eventPlayer.Inv4 == 0:
        goto lbl_3
    ItemsToDrop = ItemsToDrop.concat(eventPlayer.Inv4)
    ItemsToDrop = ItemsToDrop.concat(nearestWalkablePosition(eventPlayer.getPosition()) + vect(2, 0, 2))
    lbl_3:
    eventPlayer.KillStreak = 0
    destroyHudText(eventPlayer.ID1)
    hudHeader(eventPlayer, ">Empty", HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID1 = getLastCreatedText()
    eventPlayer.Inv1 = 0
    eventPlayer.InvIndex = 0
    eventPlayer.currentInvIndex = 0
    destroyHudText(eventPlayer.ID2)
    hudHeader(eventPlayer, "Empty", HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID2 = getLastCreatedText()
    eventPlayer.Inv2 = 0
    destroyHudText(eventPlayer.ID3)
    hudHeader(eventPlayer, "Empty", HudPosition.LEFT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID3 = getLastCreatedText()
    eventPlayer.Inv3 = 0
    destroyHudText(eventPlayer.ID4)
    hudHeader(eventPlayer, "Empty", HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.ID4 = getLastCreatedText()
    eventPlayer.Inv4 = 0


rule "Kill Streak on elim":
    @Event playerEarnedElimination
    
    eventPlayer.KillStreak = eventPlayer.KillStreak + 1


rule "5 kill streak":
    @Event eachPlayer
    @Condition eventPlayer.KillStreak == 5
    
    bigMessage(getAllPlayers(), "{0}{1} is on a 5 Kill Streak!".format(heroIcon(eventPlayer.getCurrentHero()), eventPlayer))


rule "10 kill streak":
    @Event eachPlayer
    @Condition eventPlayer.KillStreak == 10
    
    bigMessage(getAllPlayers(), "{0}{1} is on a 10 Kill Streak!".format(heroIcon(eventPlayer.getCurrentHero()), eventPlayer))


rule "Disable controls while Interact is held":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.setPrimaryFireEnabled(false)


rule "Enable controls while Interact is not held":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == false
    
    wait(0.3)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setPrimaryFireEnabled(true)


def getCurrentItem():
    @Name "SubRoutine - Get Current Item"
    
    if eventPlayer.InvIndex == 0:
        eventPlayer.CurrentItemDesc = eventPlayer.Inv1
    elif eventPlayer.InvIndex == 1:
        eventPlayer.CurrentItemDesc = eventPlayer.Inv2
    elif eventPlayer.InvIndex == 2:
        eventPlayer.CurrentItemDesc = eventPlayer.Inv3
    elif eventPlayer.InvIndex == 3:
        eventPlayer.CurrentItemDesc = eventPlayer.Inv4


def changeItemDesc():
    @Name "SubRoutine - Create Item Desc"
    
    getCurrentItem()
    if eventPlayer.CurrentItemDesc == 0:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Its Empty! Go pick up an item, theyre really useful.", HudPosition.LEFT, 5, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 1:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Health is a valuable resource. Without it, well, you die. \r\nThis will give you a small health boost to keep you going.", HudPosition.LEFT, 5, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 2:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Sometimes you just need the good stuff. I'm not sure what your good stuff is, \r\nbut mine is sweet sweet health.", HudPosition.LEFT, 5, Color.BLUE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 3:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Use your abillity. Oh wait you haven't unlocked them. \r\nHere, use this to unlock your second ability.", HudPosition.LEFT, 5, Color.BLUE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 4:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Abilities are your friend. If you die or swap heroes they stay with you! \r\nUnlike my friends, who are the ones that kill me :/", HudPosition.LEFT, 5, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 5:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "This portable mega health pack is every genji mains dreams. \r\nIt'll boost you from 1 to full health so you can keep feeding!", HudPosition.LEFT, 5, Color.BLUE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 6:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Someone snuck into baptise's locker and stole his boots. \r\nUnfortunately they malfunctioned. You get 1 jump, use it well.", HudPosition.LEFT, 5, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 7:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Sometimes you just need a refresher. I do like it when I reset my health, \r\nammo and cooldowns. Maybe you will too.", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 8:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "This key will grant you accesss to the most powerful abillites ever seen, \r\nthat last for a few seconds and work half the time.", HudPosition.LEFT, 5, Color.PURPLE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 9:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Be whoever you want to be is my philosophy in life. \r\nBoth figuratively and literally.", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 10:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Sometimes its fun to mess with people. Sometimes its fun to change enemys \r\ninto random heroes they dont want to be. ", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 11:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Ever wanted to know they exact location of enemies \r\nthrough solid objects and walls? That'd be so cool right...", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 12:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "These shells are definitely gonna sweep your enemies off their feet, \r\nand not in the romantic way either.", HudPosition.LEFT, 5, Color.BLUE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 13:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "A wise blue rodent once said \"Gotta Go Fast\".I couldn't agree more.  ", HudPosition.LEFT, 5, Color.BLUE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 14:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Whats the juice? I have no idea but this juice will make you incincible, \r\nso I choose this juice.", HudPosition.LEFT, 5, Color.PURPLE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 15:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "A mad scientist was making a teleporter. He made one but its broken and is random. \r\nAh well, I guess its still somewhat useful.", HudPosition.LEFT, 5, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 16:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "I left these on my table and my ex found them. She burned the house down. \r\nI guess thats what i get for playing with fire.", HudPosition.LEFT, 5, Color.BLUE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 17:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Would you rather stay how you are now or change into a random person and/or omnic. \r\nI guess we'll find out.", HudPosition.LEFT, 5, Color.PURPLE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 18:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "Smoking is very bad for you. However using smoke to mask positions of people \r\nand items is very good for you.", HudPosition.LEFT, 5, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 19:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "What's better than playing hide and seek? Playing hide and shoot your enemy in the face, thats what. ", HudPosition.LEFT, 5, Color.PURPLE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()
    elif eventPlayer.CurrentItemDesc == 20:
        destroyHudText(eventPlayer.CurrentItemTextID)
        hudSubtext(eventPlayer, "That big round percent counter at the bottom of you screen. Lets bump that up \r\nto 100% and see what happens.", HudPosition.LEFT, 5, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
        eventPlayer.CurrentItemTextID = getLastCreatedText()