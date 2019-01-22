#define NANO_ARMOR "armor"
#define NANO_CLOAK "cloak"
#define NANO_SPEED "speed"
#define NANO_STRENGTH "strength"
#define NANO_NONE "none"
#define NANO_JUMP_USE 30
#define NANO_CHARGE_DELAY 15
#define NANO_EMP_CHARGE_DELAY 40

#define POWER_PUNCH "QQQ"
#define HEAD_EXPLOSION "SSSS"
#define MARTIALART_NANOSUIT "nanosuit strength"

//Crytek Nanosuit made by YoYoBatty
/obj/item/clothing/under/syndicate/combat/nano
	name = "nanosuit lining"
	desc = "Foreign body resistant lining built below the nanosuit. Provides internal protection. Property of CryNet Systems."
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | FREEZE_PROOF
	item_flags = DROPDEL

/obj/item/clothing/under/syndicate/combat/nano/equipped(mob/user, slot)
	..()
	if(slot == SLOT_W_UNIFORM)
		add_trait(TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/clothing/mask/gas/nano_mask
	name = "nanosuit gas mask"
	desc = "Operator mask. Property of CryNet Systems." //More accurate
	icon_state = "syndicate"
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | FREEZE_PROOF
	item_flags = DROPDEL

/obj/item/clothing/mask/gas/nano_mask/equipped(mob/user, slot)
	..()
	if(slot == SLOT_WEAR_MASK)
		add_trait(TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/datum/action/item_action/nanojump
	name = "Activate Strength Jump"
	desc = "Activates the Nanosuit's super jumping ability to allows the user to cross 2 wide gaps."
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "jetboot"

/obj/item/clothing/shoes/combat/coldres/nanojump
	name = "nanosuit boots"
	desc = "Boots part of a nanosuit. Slip resistant. Property of CryNet Systems."
	clothing_flags = NOSLIP
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | FREEZE_PROOF
	var/jumpdistance = 2 //-1 from to see the actual distance, e.g 3 goes over 2 tiles
	var/jumpspeed = 1
	actions_types = list(/datum/action/item_action/nanojump)
	item_flags = DROPDEL

/obj/item/clothing/shoes/combat/coldres/nanojump/ui_action_click(mob/user, action)
	if(!isliving(user))
		return

	var/turf/open/floor/T = get_turf(src)
	var/obj/structure/S = locate() in get_turf(user.loc)
	var/mob/living/carbon/human/H = user
	if(istype(H.wear_suit, /obj/item/clothing/suit/space/hardsuit/nano))
		var/obj/item/clothing/suit/space/hardsuit/nano/NS = H.wear_suit
		if(NS.mode == NANO_STRENGTH)
			if(istype(T) || istype(S))
				if(NS.cell.charge >= NANO_JUMP_USE)
					NS.set_nano_energy(NANO_JUMP_USE,NANO_CHARGE_DELAY)
				else
					to_chat(user, "<span class='warning'>Not enough charge.</span>")
					return
			else
				to_chat(user, "<span class='warning'>You must be on a proper floor or stable structure.</span>")
				return
		else
			to_chat(user, "<span class='warning'>Only available in strength mode.</span>")
			return
	else
		to_chat(user, "<span class='warning'>You must be wearing a nanosuit.</span>")
		return

	var/atom/target = get_edge_target_turf(user, user.dir) //gets the user's direction
	if(user.throw_at(target, jumpdistance, jumpspeed, spin = FALSE, diagonals_first = TRUE))
		playsound(src, 'sound/effects/stealthoff.ogg', 50, 0.75, TRUE)
		user.visible_message("<span class='warning'>[user] jumps forward into the air!</span>")
	else
		to_chat(user, "<span class='warning'>Something prevents you from dashing forward!</span>")


/obj/item/clothing/shoes/combat/coldres/nanojump/equipped(mob/user, slot)
	..()
	if(slot == SLOT_SHOES)
		add_trait(TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/clothing/gloves/combat/nano
	name = "nano gloves"
	desc = "These tactical gloves are built into a nanosuit and are fireproof and shock resistant. Property of CryNet Systems."
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | FREEZE_PROOF
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	item_flags = DROPDEL

/obj/item/clothing/gloves/combat/nano/equipped(mob/user, slot)
	..()
	if(slot == SLOT_GLOVES)
		add_trait(TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/radio/headset/syndicate/alt/nano
	name = "\proper the nanosuit's bowman headset"
	desc = "Operator communication headset. Property of CryNet Systems."
	icon_state = "syndie_headset"
	item_state = "syndie_headset"
	subspace_transmission = FALSE
	keyslot = new /obj/item/encryptionkey/binary
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | FREEZE_PROOF
	item_flags = DROPDEL

/obj/item/radio/headset/syndicate/alt/nano/equipped(mob/user, slot)
	..()
	if(slot == SLOT_EARS)
		add_trait(TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/radio/headset/syndicate/alt/nano/emp_act()
	return

/obj/item/clothing/glasses/nano_goggles
	name = "nanosuit goggles"
	desc = "Goggles built for a nanosuit. Property of CryNet Systems."
	alternate_worn_icon = 'hippiestation/icons/mob/nanosuit.dmi'
	icon = 'hippiestation/icons/obj/nanosuit.dmi'
	icon_state = "nvgmesonnano"
	item_state = "nvgmesonnano"
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | FREEZE_PROOF
	glass_colour_type = /datum/client_colour/glass_colour/nightvision
	actions_types = list(/datum/action/item_action/nanosuit/goggletoggle)
	vision_correction = TRUE //We must let our wearer have good eyesight
	var/on = FALSE
	item_flags = DROPDEL

/datum/client_colour/glass_colour/nightvision
	colour = "#45723f"

/obj/item/clothing/glasses/nano_goggles/equipped(mob/user, slot)
	..()
	if(slot == SLOT_GLASSES)
		add_trait(TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/clothing/glasses/nano_goggles/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/nanosuit/goggletoggle))
		nvgmode(user)
		return TRUE
	return FALSE


/obj/item/clothing/glasses/nano_goggles/proc/nvgmode(mob/user, var/forced = FALSE)
	var/mob/living/carbon/human/H = user
	if(H.glasses != src)
		return
	if(!ishuman(user))
		return
	on = !on
	to_chat(user, "<span class='[forced ? "warning":"notice"]'>[forced ? "The goggles turn":"You turn the goggles"] [on ? "on":"off"][forced ? "!":"."]</span>")
	if(on)
		darkness_view = 8
		lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	else
		darkness_view = 2
		lighting_alpha = null
	H.update_sight()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/glasses/nano_goggles/emp_act(severity)
	..()
	if(prob(33/severity))
		nvgmode(loc,TRUE)

/obj/item/clothing/suit/space/hardsuit/nano
	alternate_worn_icon = 'hippiestation/icons/mob/nanosuit.dmi'
	icon = 'hippiestation/icons/obj/nanosuit.dmi'
	icon_state = "nanosuit"
	item_state = "nanosuit"
	name = "nanosuit"
	desc = "Some sort of alien future suit. It looks very robust. Property of CryNet Systems."
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 45, "bomb" = 70, "bio" = 100, "rad" = 70, "fire" = 100, "acid" = 100)
	allowed = list(/obj/item/tank/internals)
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS					//Uncomment to enable firesuit protection
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/nano
	slowdown = 0.5
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | FREEZE_PROOF
	actions_types = list(/datum/action/item_action/nanosuit/armor, /datum/action/item_action/nanosuit/cloak, /datum/action/item_action/nanosuit/speed, /datum/action/item_action/nanosuit/strength)
	permeability_coefficient = 0.01
	var/mob/living/carbon/human/Wearer = null
	var/criticalpower = FALSE
	var/mode = NANO_NONE
	var/datum/martial_art/nanosuit/style = new
	var/shutdown = TRUE
	var/current_charges = 3
	var/max_charges = 3 //How many charges total the shielding has
	var/medical_delay = 200 //How long after we've been shot before we can start recharging. 20 seconds here
	var/temp_cooldown = 0
	var/restore_delay = 80
	var/defrosted = FALSE
	var/detecting = FALSE
	var/help_verb = /mob/living/carbon/human/proc/Nanosuit_help
	jetpack = /obj/item/tank/jetpack/suit
	var/recharge_cooldown = 0 //if this number is greater than 0, we can't recharge
	var/cloak_use_rate = 1.2 //cloaked energy consume rate
	var/speed_use_rate = 1.6 //speed energy consume rate
	var/crit_energy = 20 //critical energy level
	var/regen_rate = 3 //rate at which we regen
	var/msg_time_react = 0
	var/trauma_threshold = 30
	var/obj/item/stock_parts/cell/nano/cell //What type of power cell this uses
	block_chance = 0
	var/menu_open = FALSE
	//variables for cloak pausing when shooting a suppressed gun
	var/stealth_cloak_out = 1 //transition time out of cloak
	var/stealth_cloak_in = 2 //transition time back into cloak
	rad_flags = RAD_PROTECT_CONTENTS|RAD_NO_CONTAMINATE
	rad_insulation = RAD_NO_INSULATION
	var/healthon = FALSE
	var/atmoson = FALSE
	var/radon = FALSE
	var/cellon = FALSE

/obj/item/clothing/suit/space/hardsuit/nano/Initialize()
	. = ..()
	cell = new(src)
	START_PROCESSING(SSfastprocess, src)

/obj/item/clothing/suit/space/hardsuit/nano/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	if(Wearer)
		if(help_verb)
			Wearer.verbs -= help_verb
	Wearer = null
	QDEL_NULL(style)
	QDEL_NULL(cell)
	return ..()

/obj/item/clothing/suit/space/hardsuit/nano/examine(mob/user)
	..()
	if(mode != NANO_NONE)
		to_chat(user, "The suit appears to be in [mode] mode.")
	else
		to_chat(user, "The suit appears to be offline.")

/obj/item/clothing/suit/space/hardsuit/nano/process()
	if(!Wearer)
		return
	if(shutdown)
		return
	if(Wearer.bodytemperature < BODYTEMP_COLD_DAMAGE_LIMIT)
		if(!detecting)
			temp_cooldown = world.time + restore_delay
			detecting = TRUE
		if(world.time > temp_cooldown)
			if(!defrosted)
				helmet.display_visor_message("Activating suit defrosting protocols.")
				Wearer.reagents.add_reagent("leporazine", 2)
				defrosted = TRUE
				temp_cooldown += 100
	else
		if(defrosted || detecting)
			defrosted = FALSE
			detecting = FALSE
	var/energy = cell.charge //store current energy here
	if(mode == NANO_CLOAK) //are we in cloak, not moving?
		energy -= cloak_use_rate //take away the cloak discharge rate at 1/10th since we're not moving
	if((energy < cell.maxcharge) && mode != NANO_CLOAK && !recharge_cooldown) //if our energy is less than 100, we're not in cloak and don't have a recharge delay timer
		var/energy2 = regen_rate //store our regen rate here
		energy2+=energy //add our current energy to it
		energy=min(cell.maxcharge,energy2) //our energy now equals the energy we had + 0.75 for everytime it iterates through, so it increases by 0.75 every tick until it goes to 100
	if(recharge_cooldown > 0) //do we have a recharge delay set?
		recharge_cooldown -= 1 //reduce it
	if(msg_time_react)
		msg_time_react -= 1
	if(cell.charge != energy)
		set_nano_energy(cell.charge - energy) //now set our current energy to the variable we modified

/obj/item/clothing/suit/space/hardsuit/nano/proc/set_nano_energy(var/amount, var/delay = 0)
	if(delay > recharge_cooldown)
		recharge_cooldown = delay
	if(cell.charge < crit_energy && !criticalpower) //energy is less than critical energy level(20) and not in crit power
		helmet.display_visor_message("Energy Critical!") //now we are
		criticalpower = TRUE
	else if(cell.charge > crit_energy) //did our energy go higher than the crit level
		criticalpower = FALSE //turn it off
	if(!cell.charge) //did we lose energy?
		if(mode == NANO_CLOAK) //are we in cloak?
			recharge_cooldown = 15 //then wait 3 seconds(1 value per 2 ticks = 15*2=30/10 = 3 seconds) to recharge again
		if(mode != NANO_ARMOR && mode != NANO_NONE) //we're not in cloak
			toggle_mode(NANO_ARMOR, TRUE) //go into it, forced
	cell.use(round(amount))
	return TRUE

/obj/item/clothing/suit/space/hardsuit/nano/proc/addmedicalcharge()
	if(current_charges < max_charges)
		current_charges = min(max_charges, current_charges + 1)

/obj/item/clothing/suit/space/hardsuit/nano/proc/onmove()
	if(mode == NANO_CLOAK)
		set_nano_energy(cloak_use_rate,NANO_CHARGE_DELAY)
	else if(mode == NANO_SPEED)
		set_nano_energy(speed_use_rate,NANO_CHARGE_DELAY)

/obj/item/clothing/suit/space/hardsuit/nano/hit_reaction(mob/living/carbon/human/user, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/obj/item/projectile/P = hitby
	if(mode == NANO_ARMOR && cell.charge)
		if(prob(final_block_chance))
			user.visible_message("<span class='danger'>[user]'s shields deflect [attack_text] draining their energy!</span>")
			if(damage)
				if(attack_type != STAMINA)
					set_nano_energy(5 + damage,NANO_CHARGE_DELAY)//laser guns, anything lethal drains 5 + the damage dealth
				else if(P.damage_type == STAMINA && attack_type == PROJECTILE_ATTACK)
					set_nano_energy(15,NANO_CHARGE_DELAY)//stamina damage, aka disabler beams
			if(istype(P, /obj/item/projectile/energy/electrode))//if electrode aka taser
				set_nano_energy(25,NANO_CHARGE_DELAY)
			return TRUE
		else
			user.visible_message("<span class='warning'>[user]'s shields fail to deflect [attack_text].</span>")
			return FALSE
		if(damage && attack_type == PROJECTILE_ATTACK && P.damage_type != STAMINA && prob(50))
			var/datum/effect_system/spark_spread/s = new
			s.set_up(1, 1, src)
			s.start()
	kill_cloak()
	if(prob(damage*2) && user.health < 60 && current_charges > 0)
		addtimer(CALLBACK(src, .proc/addmedicalcharge), medical_delay,TIMER_UNIQUE|TIMER_OVERRIDE)
		current_charges--
		heal_nano(user)
	for(var/X in Wearer.bodyparts)
		var/obj/item/bodypart/BP = X
		if(!msg_time_react)
			if(BP.body_zone == BODY_ZONE_L_LEG || BP.body_zone == BODY_ZONE_R_LEG || BP.body_zone == BODY_ZONE_L_ARM || BP.body_zone == BODY_ZONE_R_ARM)
				if(BP.brute_dam > trauma_threshold)
					helmet.display_visor_message("Extensive blunt force detected in [BP.name]!")
					msg_time_react = 200
				if(BP.burn_dam > trauma_threshold)
					helmet.display_visor_message("Heat shield failure detected in [BP.name]!")
					msg_time_react = 200
			if(BP.body_zone == BODY_ZONE_HEAD)
				if(BP.brute_dam > trauma_threshold)
					helmet.display_visor_message("Cranial trauma detected!")
					msg_time_react = 300
				if(BP.burn_dam > trauma_threshold)
					helmet.display_visor_message("Facial burns detected!")
					msg_time_react = 300
			if(BP.body_zone == BODY_ZONE_CHEST)
				if(BP.brute_dam > trauma_threshold)
					helmet.display_visor_message("Thoracic trauma detected!")
					msg_time_react = 300
				if(BP.burn_dam > trauma_threshold)
					helmet.display_visor_message("Thoracic burns detected!")
					msg_time_react = 300

	if(attack_type == THROWN_PROJECTILE_ATTACK)
		final_block_chance += 15
	if(attack_type == LEAP_ATTACK)
		final_block_chance = 75
	SEND_SIGNAL(src, COMSIG_ITEM_HIT_REACT, args)
	return FALSE

/obj/item/clothing/suit/space/hardsuit/nano/proc/heal_nano(mob/living/carbon/human/user)
	helmet.display_visor_message("Engaging emergency medical protocols")
	user.reagents.add_reagent("syndicate_nanites", 1)

/obj/item/clothing/suit/space/hardsuit/nano/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/nanosuit/armor))
		toggle_mode(NANO_ARMOR)
		return TRUE
	if(istype(action, /datum/action/item_action/nanosuit/cloak))
		toggle_mode(NANO_CLOAK)
		return TRUE
	if(istype(action, /datum/action/item_action/nanosuit/speed))
		toggle_mode(NANO_SPEED)
		return TRUE
	if(istype(action, /datum/action/item_action/nanosuit/strength))
		toggle_mode(NANO_STRENGTH)
		return TRUE
	return FALSE

/obj/item/clothing/suit/space/hardsuit/nano/proc/toggle_mode(var/suitmode, var/forced = FALSE)
	if(!shutdown && (forced || (cell.charge && mode != suitmode)))
		mode = suitmode
		switch(suitmode)
			if(NANO_ARMOR)
				helmet.display_visor_message("Maximum Armor!")
				block_chance = 50
				slowdown = initial(slowdown)
				armor = armor.setRating(melee = 60, bullet = 60, laser = 60, energy = 65, bomb = 100, rad =100)
				helmet.armor = helmet.armor.setRating(melee = 60, bullet = 60, laser = 60, energy = 65, bomb = 100, rad =100)
				Wearer.filters = null
				animate(Wearer, alpha = 255, time = 5)
				Wearer.remove_movespeed_modifier(NANO_SPEED)
				Wearer.remove_trait(TRAIT_IGNORESLOWDOWN, NANO_SPEED)
				Wearer.remove_trait(TRAIT_PUSHIMMUNE, NANO_STRENGTH)
				style.remove(Wearer)
				jetpack.full_speed = FALSE

			if(NANO_CLOAK)
				helmet.display_visor_message("Cloak Engaged!")
				block_chance = 0
				slowdown = 0.4 //cloaking makes us go sliightly faster
				armor = armor.setRating(melee = 40, bullet = 40, laser = 40, energy = 45, bomb = 70, rad = 70)
				helmet.armor = helmet.armor.setRating(melee = 40, bullet = 40, laser = 40, energy = 45, bomb = 70, rad = 70)
				Wearer.filters = filter(type="blur",size=1)
				animate(Wearer, alpha = 40, time = 2)
				Wearer.remove_movespeed_modifier(NANO_SPEED)
				Wearer.remove_trait(TRAIT_IGNORESLOWDOWN, NANO_SPEED)
				Wearer.remove_trait(TRAIT_PUSHIMMUNE, NANO_STRENGTH)
				style.remove(Wearer)
				jetpack.full_speed = FALSE

			if(NANO_SPEED)
				helmet.display_visor_message("Maximum Speed!")
				block_chance = 0
				slowdown = initial(slowdown)
				armor = armor.setRating(melee = 40, bullet = 40, laser = 40, energy = 45, bomb = 70, rad = 70)
				helmet.armor = helmet.armor.setRating(melee = 40, bullet = 40, laser = 40, energy = 45, bomb = 70, rad = 70)
				Wearer.adjustOxyLoss(-5, 0)
				Wearer.adjustStaminaLoss(-20)
				Wearer.filters = filter(type="outline", size=0.1, color=rgb(255,255,224))
				animate(Wearer, alpha = 255, time = 5)
				Wearer.remove_trait(TRAIT_PUSHIMMUNE, NANO_STRENGTH)
				Wearer.add_movespeed_modifier(NANO_SPEED, update=TRUE, priority=100, multiplicative_slowdown=-1, blacklisted_movetypes=(FLYING|FLOATING))
				Wearer.add_trait(TRAIT_IGNORESLOWDOWN, NANO_SPEED)
				style.remove(Wearer)
				jetpack.full_speed = TRUE

			if(NANO_STRENGTH)
				helmet.display_visor_message("Maximum Strength!")
				block_chance = 0
				style.teach(Wearer,1)
				slowdown = initial(slowdown)
				armor = armor.setRating(melee = 40, bullet = 40, laser = 40, energy = 45, bomb = 70, rad = 70)
				helmet.armor = helmet.armor.setRating(melee = 40, bullet = 40, laser = 40, energy = 45, bomb = 70, rad = 70)
				Wearer.filters = filter(type="outline", size=0.1, color=rgb(255,0,0))
				animate(Wearer, alpha = 255, time = 5)
				Wearer.add_trait(TRAIT_PUSHIMMUNE, NANO_STRENGTH)
				Wearer.remove_movespeed_modifier(NANO_SPEED)
				Wearer.remove_trait(TRAIT_IGNORESLOWDOWN, NANO_SPEED)
				jetpack.full_speed = FALSE

			if(NANO_NONE)
				block_chance = 0
				style.remove(Wearer)
				slowdown = initial(slowdown)
				armor = armor.setRating(melee = 40, bullet = 40, laser = 40, energy = 45, bomb = 70, rad = 70)
				helmet.armor = helmet.armor.setRating(melee = 40, bullet = 40, laser = 40, energy = 45, bomb = 70, rad = 70)
				Wearer.filters = null
				animate(Wearer, alpha = 255, time = 5)
				Wearer.remove_trait(TRAIT_PUSHIMMUNE, NANO_STRENGTH)
				Wearer.remove_movespeed_modifier(NANO_SPEED)
				Wearer.remove_trait(TRAIT_IGNORESLOWDOWN, NANO_SPEED)
				jetpack.full_speed = FALSE

	Wearer.update_inv_wear_suit()
	update_icon()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()


/obj/item/clothing/suit/space/hardsuit/nano/emp_act(severity)
	..()
	if(!severity || shutdown)
		return
	set_nano_energy(cell.charge/severity,NANO_EMP_CHARGE_DELAY)
	if((mode == NANO_ARMOR && !cell.charge) || (mode != NANO_ARMOR))
		if(prob(5/severity))
			emp_assault()
		else if(prob(10/severity))
			Wearer.confused += 10
	update_icon()

/obj/item/clothing/suit/space/hardsuit/nano/proc/emp_assault()
	if(!Wearer)
		return //Not sure how this could happen.
	Wearer.confused += 50
	helmet.display_visor_message("EMP Assault! Systems impaired.")
	sleep(40)
	Wearer.Paralyze(300)
	Wearer.AdjustStun(300)
	Wearer.Jitter(120)
	toggle_mode(NANO_NONE, TRUE)
	shutdown = TRUE
	addtimer(CALLBACK(src, .proc/emp_assaulttwo), 25)


/obj/item/clothing/suit/space/hardsuit/nano/proc/emp_assaulttwo()
	sleep(35)
	helmet.display_visor_message("Warning. EMP shutdown, all systems impaired.")
	sleep(25)
	helmet.display_visor_message("Switching to: core function mode.")
	sleep(25)
	helmet.display_visor_message("Life support priority. Warning!")
	addtimer(CALLBACK(src, .proc/emp_assaultthree), 35)


/obj/item/clothing/suit/space/hardsuit/nano/proc/emp_assaultthree()
	helmet.display_visor_message("CMOS reset sequence begin, standby...")
	sleep(20)
	playsound(src, 'sound/machines/beep.ogg', 50, FALSE)
	helmet.display_visor_message("4672482//-82544111.0//WRXT _YWD")
	sleep(5)
	helmet.display_visor_message("KPO- -86801780.768//1228.")
	sleep(5)
	helmet.display_visor_message("LMU/894411.-//0113122")
	sleep(5)
	helmet.display_visor_message("QRE 8667152...")
	sleep(5)
	helmet.display_visor_message("XAS -123455")
	sleep(5)
	helmet.display_visor_message("WF // .897")
	sleep(20)
	helmet.display_visor_message("DIAG//123")
	sleep(10)
	helmet.display_visor_message("MED//8189")
	sleep(10)
	helmet.display_visor_message("LOADING//...")
	sleep(30)
	helmet.display_visor_message("Cardiac dysrhythmias treatment in progress, standby...")
	playsound(src, 'sound/machines/defib_charge.ogg', 75, FALSE)
	sleep(25)
	playsound(src, 'sound/machines/defib_zap.ogg', 50, FALSE)
	Wearer.AdjustStun(-100)
	Wearer.AdjustParalyzed(-100)
	Wearer.adjustStaminaLoss(-55)
	Wearer.adjustOxyLoss(-55)
	helmet.display_visor_message("Cleared to proceed.")
	sleep(3)
	playsound(src, 'sound/machines/defib_success.ogg', 75, FALSE)
	shutdown = FALSE
	toggle_mode(NANO_ARMOR)

/datum/action/item_action/nanosuit
	check_flags = AB_CHECK_STUN|AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions.dmi'
	background_icon_state = "bg_tech_blue"

/datum/action/item_action/nanosuit/goggletoggle
	name = "Night Vision"
	icon_icon = 'hippiestation/icons/mob/actions/actions_nanosuit.dmi'
	button_icon_state = "toggle_goggle"

/datum/action/item_action/nanosuit/armor
	name = "Armor Mode"
	icon_icon = 'hippiestation/icons/mob/actions/actions_nanosuit.dmi'
	button_icon_state = "armor_mode"

/datum/action/item_action/nanosuit/cloak
	name = "Cloak Mode"
	icon_icon = 'hippiestation/icons/mob/actions/actions_nanosuit.dmi'
	button_icon_state = "cloak_mode"

/datum/action/item_action/nanosuit/speed
	name = "Speed Mode"
	icon_icon = 'hippiestation/icons/mob/actions/actions_nanosuit.dmi'
	button_icon_state = "speed_mode"

/datum/action/item_action/nanosuit/strength
	name = "Strength Mode"
	icon_icon = 'hippiestation/icons/mob/actions/actions_nanosuit.dmi'
	button_icon_state = "strength_mode"


/obj/item/clothing/head/helmet/space/hardsuit/nano
	name = "nanosuit helmet"
	desc = "The cherry on top. Property of CryNet Systems."
	alternate_worn_icon = 'hippiestation/icons/mob/nanosuit.dmi'
	icon = 'hippiestation/icons/obj/nanosuit.dmi'
	icon_state = "nanohelmet"
	item_state = "nanohelmet"
	item_color = "nano"
	siemens_coefficient = 0
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | FREEZE_PROOF //No longer shall our kind be foiled by lone chemists with spray bottles!
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 45, "bomb" = 70, "bio" = 100, "rad" = 70, "fire" = 100, "acid" = 100)
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	var/list/datahuds = list(DATA_HUD_SECURITY_ADVANCED, DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC_BASIC)
	var/zoom_range = 12
	var/zoom = FALSE
	var/obj/machinery/doppler_array/integrated/bomb_radar
	scan_reagents = TRUE
	actions_types = list(/datum/action/item_action/nanosuit/zoom)
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	rad_insulation = RAD_NO_INSULATION

/obj/item/clothing/head/helmet/space/hardsuit/nano/Initialize()
	. = ..()
	bomb_radar = new /obj/machinery/doppler_array/integrated(src)

/obj/item/clothing/head/helmet/space/hardsuit/nano/ui_action_click()
	return FALSE

/obj/item/clothing/head/helmet/space/hardsuit/nano/equipped(mob/living/carbon/human/wearer, slot)
	..()
	if(slot == SLOT_HEAD)
		item_flags |= NODROP
	for(var/hudtype in datahuds)
		var/datum/atom_hud/H = GLOB.huds[hudtype]
		H.add_hud_to(wearer)

/obj/item/clothing/head/helmet/space/hardsuit/nano/dropped(mob/living/carbon/human/wearer)
	..()
	if(wearer)
		for(var/hudtype in datahuds)
			var/datum/atom_hud/H = GLOB.huds[hudtype]
			H.remove_hud_from(wearer)
		if(zoom)
			toggle_zoom(wearer, TRUE)

/obj/item/clothing/head/helmet/space/hardsuit/nano/proc/toggle_zoom(mob/living/user, force_off = FALSE)
	if(!user)
		return
	if(zoom || force_off)
		user.client.change_view(CONFIG_GET(string/default_view))
		to_chat(user, "<span class='boldnotice'>Disabled helmet zoom...</span>")
		zoom = FALSE
		return FALSE
	else
		user.client.change_view(zoom_range)
		to_chat(user, "<span class='boldnotice'>Enabled helmet zoom!</span>")
		zoom = TRUE
		return TRUE

/datum/action/item_action/nanosuit/zoom
	name = "Helmet Zoom"
	icon_icon = 'icons/mob/actions.dmi'
	background_icon_state = "bg_tech_blue"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"

/datum/action/item_action/nanosuit/zoom/Trigger()
	var/obj/item/clothing/head/helmet/space/hardsuit/nano/NS = target
	if(istype(NS))
		NS.toggle_zoom(owner)
	return ..()

/obj/item/clothing/head/helmet/space/hardsuit/nano/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/rad_insulation, RAD_NO_INSULATION, TRUE, TRUE)

/obj/item/clothing/suit/space/hardsuit/nano/equipped(mob/user, slot)
	if(ishuman(user))
		Wearer = user
	if(slot == SLOT_WEAR_SUIT)
		var/turf/T = get_turf(src)
		var/area/A = get_area(src)
		RegisterSignal(Wearer, list(COMSIG_MOB_ITEM_ATTACK,COMSIG_MOB_ITEM_AFTERATTACK,COMSIG_MOB_THROW,COMSIG_MOB_ATTACK_HAND,COMSIG_MOB_ATTACK_RANGED), CALLBACK(src, .proc/kill_cloak), TRUE)
		if(is_station_level(T.z))
			priority_announce("[user] has engaged [src] at [A.map_name]!","Message from The Syndicate!", 'sound/misc/notice1.ogg')
		log_game("[user] has engaged [src]")
		item_flags |= NODROP
		Wearer.unequip_everything()
		Wearer.equipOutfit(/datum/outfit/nanosuit)
		Wearer.add_trait(TRAIT_NODISMEMBER, "Nanosuit")
		if(help_verb)
			Wearer.verbs += help_verb
		bootSequence()
	..()

/obj/item/clothing/suit/space/hardsuit/nano/dropped(mob/living/carbon/human/wearer)
	if(!wearer)
		return
	if(help_verb)
		wearer.verbs -= help_verb

/obj/item/clothing/suit/space/hardsuit/nano/proc/bootSequence()
	helmet.display_visor_message("Crynet - UEFI v1.32 Syndicate Systems")
	sleep(10)
	helmet.display_visor_message("P.O.S.T. Commencing...")
	sleep(30)
	playsound(src, 'sound/machines/beep.ogg', 50, FALSE)
	helmet.display_visor_message("Memory test: 6144MB OK(Installed Memory: 6144MB)")
	sleep(10)
	helmet.display_visor_message("Onboard equipment test: OK")
	sleep(10)
	helmet.display_visor_message("Telecommunications systems: OK")
	sleep(10)
	helmet.display_visor_message("Checking environment sensors, standby...")
	sleep(20)
	healthon = TRUE
	helmet.display_visor_message("Life signs systems: OK")
	sleep(5)
	atmoson = TRUE
	helmet.display_visor_message("Atmospheric sensors: OK")
	sleep(5)
	cellon = TRUE
	helmet.display_visor_message("Power sensor: OK")
	sleep(5)
	radon = TRUE
	helmet.display_visor_message("Geiger counter: OK")
	sleep(5)
	helmet.display_visor_message("Loading default configuration, standby...")
	sleep(25)
	helmet.display_visor_message("Successful. Have a safe and secure day.")
	shutdown = FALSE
	toggle_mode(NANO_ARMOR)


/datum/outfit/nanosuit
	name = "Nanosuit"
	uniform = /obj/item/clothing/under/syndicate/combat/nano
	glasses = /obj/item/clothing/glasses/nano_goggles
	mask = /obj/item/clothing/mask/gas/nano_mask
	ears = /obj/item/radio/headset/syndicate/alt/nano
	shoes = /obj/item/clothing/shoes/combat/coldres/nanojump
	gloves = /obj/item/clothing/gloves/combat/nano
	implants = list(/obj/item/implant/explosive/disintegrate)
	suit_store = /obj/item/tank/internals/emergency_oxygen/recharge
	internals_slot = SLOT_S_STORE

/mob/living/carbon/human/Stat()
	..()
	if(istype(wear_suit, /obj/item/clothing/suit/space/hardsuit/nano)) //Only display if actually wearing the suit.
		var/obj/item/clothing/suit/space/hardsuit/nano/NS = wear_suit
		var/datum/gas_mixture/environment = loc?.return_air()
		var/pressure = environment.return_pressure()
		if(statpanel("Crynet Nanosuit"))
			stat("Crynet Protocols : [!NS.shutdown?"Engaged":"Disengaged"]")
			stat("Energy Charge:", "[NS.cellon?"[round(NS.cell.percent())]%":"offline"]")
			stat("Mode:", "[NS.mode]")
			stat("Overall Status:", "[NS.healthon?"[health]% healthy":"offline"]")
			stat("Nutrition Status:", "[NS.healthon?"[nutrition]":"offline"]")
			stat("Oxygen Loss:", "[NS.healthon?"[getOxyLoss()]":"offline"]")
			stat("Toxin Levels:", "[NS.healthon?"[getToxLoss()]":"offline"]")
			stat("Burn Severity:", "[NS.healthon?"[getFireLoss()]":"offline"]")
			stat("Brute Trauma:", "[NS.healthon?"[getBruteLoss()]":"offline"]")
			stat("Radiation Levels:","[NS.radon?"[radiation] rads":"offline"]")
			stat("Body Temperature:","[NS.healthon?"["[bodytemperature-T0C] degrees C ([bodytemperature*1.8-459.67] degrees F)"]":"offline"]")
			stat("Atmospheric Pressure:","[NS.atmoson?"[pressure] kPa":"offline"]")
			stat("Atmoshperic Temperature:","[NS.atmoson?"<span class='[environment.temperature > FIRE_IMMUNITY_MAX_TEMP_PROTECT?"alert":"info"]'>[round(environment.temperature-T0C, 0.01)] &deg;C ([round(environment.temperature, 0.01)] K)</span>":"offline"]")
			stat("Atmospheric Thermal Energy:","[NS.atmoson?"[THERMAL_ENERGY(environment)/1000] kJ":"offline"]")

/mob/living/carbon/human/Move(NewLoc, direct)
	. = ..()
	if(.)
		if(istype(wear_suit, /obj/item/clothing/suit/space/hardsuit/nano))
			var/obj/item/clothing/suit/space/hardsuit/nano/NS = wear_suit
			if(mob_has_gravity() && !stat)
				return NS.onmove()

/datum/martial_art/nanosuit
	name = "Nanosuit strength mode"
	block_chance = 75
	deflection_chance = 25
	id = MARTIALART_NANOSUIT

/datum/martial_art/nanosuit/proc/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	A.hud_used.combo_object.update_icon(streak, 60)
	if(findtext(streak,POWER_PUNCH))
		streak = ""
		A.hud_used.combo_object.update_icon(streak)
		PowerPunch(A,D)
		return TRUE
	if(findtext(streak,HEAD_EXPLOSION))
		streak = ""
		A.hud_used.combo_object.update_icon(streak)
		HeadStomp(A,D)
		return TRUE
	return FALSE

/datum/martial_art/nanosuit/proc/PowerPunch(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!D.stat || !D.IsParalyzed())
		D.visible_message("<span class='warning'>[A] power punches [D]!</span>", \
						  	"<span class='userdanger'>[A] hits you with the force of a bus!</span>")
		playsound(get_turf(A), 'sound/effects/hit_punch.ogg', 75, TRUE, -1)
		D.apply_damage(20, BRUTE)
		var/atom/throw_target = get_edge_target_turf(D, A.dir)
		if(!D.anchored)
			D.throw_at(throw_target, rand(1,2), 7, A)
		log_combat(A, D, "nanosuit slammed")
	return TRUE

/datum/martial_art/nanosuit/proc/HeadStomp(mob/living/carbon/human/A, mob/living/carbon/human/D)
	D.visible_message("<span class='warning'>[A] smashes [D] in the head, splattering their brains!</span>", \
						"<span class='userdanger'>OH SHI-</span>")
	playsound(get_turf(A), 'hippiestation/sound/misc/squishy.ogg', 75, TRUE, -1)
	playsound(get_turf(A), 'sound/magic/disintegrate.ogg', 50, TRUE, -1)
	step_to(A,D)
	var/obj/item/bodypart/head/head = D.get_bodypart(BODY_ZONE_HEAD)
	if(head)
		head.drop_limb()
		head.drop_organs()
	D.bleed_rate = 10
	D.adjustBruteLoss(40)
	D.death(FALSE)
	log_combat(A, D, "head stomped")
	return TRUE

/datum/martial_art/nanosuit/grab_act(mob/living/carbon/human/A, mob/living/carbon/D)
	if(A.grab_state >= GRAB_AGGRESSIVE)
		D.grabbedby(A, TRUE)
	else
		A.start_pulling(D, TRUE)
		if(A.pulling)
			D.stop_pulling()
			D.visible_message("<span class='danger'>[A] grapples [D]!</span>", \
								"<span class='userdanger'>[A] grapples you!</span>")
			A.grab_state = GRAB_AGGRESSIVE //Instant aggressive grab
			log_combat(A, D, "grabbed", addition="aggressively")
	return TRUE

/datum/martial_art/nanosuit/harm_act(var/mob/living/carbon/human/A, var/mob/living/carbon/D)
	var/picked_hit_type = pick("punches", "kicks")
	var/bonus_damage = 10
	var/quick = FALSE
	var/obj/item/bodypart/affecting
	if(D.IsParalyzed() || D.resting || D.lying)//we can hit ourselves
		bonus_damage += 5
		picked_hit_type = "stomps on"
		affecting = D.get_bodypart(ran_zone(A.zone_selected))
		if(affecting.body_zone == BODY_ZONE_HEAD && !A.resting || !A.lying)
			D.add_splatter_floor(D.loc)
			D.adjustBrainLoss(15)
			bonus_damage += 5
			if(D.health <= 40)
				add_to_streak("S",D)
				if(check_streak(A,D))
					return TRUE
	if(D != A && !D.stat || !D.IsParalyzed() || !D.IsStun()) //and we can't knock ourselves the fuck out/down!
		if(A.grab_state == GRAB_AGGRESSIVE)
			A.stop_pulling() //So we don't spam the combo
			bonus_damage += 5
			D.Paralyze(15)
			D.visible_message("<span class='warning'>[A] knocks [D] the fuck down!", \
							"<span class='userdanger'>[A] knocks you the fuck down!</span>")
			if(prob(80))
				step_away(D,A,15)
		else if(A.grab_state > GRAB_AGGRESSIVE)
			var/atom/throw_target = get_edge_target_turf(D, A.dir)
			if(!D.anchored)
				D.throw_at(throw_target, rand(1,2), 7, A)
			bonus_damage += 10
			D.Paralyze(60)
			D.visible_message("<span class='warning'>[A] knocks [D] the fuck out!!", \
							"<span class='userdanger'>[A] knocks you the fuck out!!</span>")
		else if(A.resting && !D.lying) //but we can't legsweep ourselves!
			D.visible_message("<span class='warning'>[A] leg sweeps [D]!", \
								"<span class='userdanger'>[A] leg sweeps you!</span>")
			playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
			bonus_damage += 5
			D.Paralyze(60)
			log_combat(A, D, "nanosuit leg swept")
	if(!A.resting || !A.lying)
		if(prob(30))
			quick = TRUE
			A.changeNext_move(CLICK_CD_RAPID)
			.= FALSE
			add_to_streak("Q",D)
			if(check_streak(A,D))
				return TRUE
	D.visible_message("<span class='danger'>[A] [quick?"quick":""] [picked_hit_type] [D]!</span>", \
					  "<span class='userdanger'>[A] [quick?"quick":""] [picked_hit_type] you!</span>")

	if(picked_hit_type == "kicks" || picked_hit_type == "stomps on")
		A.do_attack_animation(D, ATTACK_EFFECT_KICK)
		playsound(get_turf(D), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	else
		A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
		playsound(get_turf(D), 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
	log_combat(A, D, "attacked ([name])")
	D.apply_damage(bonus_damage, BRUTE)
	return TRUE

/datum/martial_art/nanosuit/disarm_act(var/mob/living/carbon/human/A, var/mob/living/carbon/D)
	var/obj/item/I = null
	A.do_attack_animation(D, ATTACK_EFFECT_DISARM)
	if(prob(70) && D != A)
		I = D.get_active_held_item()
		if(I)
			if(D.temporarilyRemoveItemFromInventory(I))
				A.put_in_hands(I)
		D.visible_message("<span class='danger'>[A] has disarmed [D]!</span>", \
							"<span class='userdanger'>[A] has disarmed [D]!</span>")
		playsound(D, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
		D.Paralyze(40)
	else
		D.visible_message("<span class='danger'>[A] attempted to disarm [D]!</span>", \
							"<span class='userdanger'>[A] attempted to disarm [D]!</span>")
		playsound(D, 'sound/weapons/punchmiss.ogg', 25, TRUE, -1)
	log_combat(A, D, "disarmed with nanosuit", "[I ? " removing \the [I]" : ""]")
	return TRUE

/obj/proc/nanosuit_damage() //the damage nanosuits do on punches to this object, is affected by melee armor
	return 25 //just enough to damage an airlock

/atom/proc/attack_nanosuit(mob/living/carbon/human/user, does_attack_animation = FALSE)
	SEND_SIGNAL(src, COMSIG_ATOM_HULK_ATTACK, user)
	if(does_attack_animation)
		user.changeNext_move(CLICK_CD_MELEE)
		log_combat(user, src, "punched", "nanosuit strength mode")
		user.do_attack_animation(src, ATTACK_EFFECT_SMASH)

/mob/living/carbon/monkey/attack_nanosuit(mob/living/carbon/human/user, does_attack_animation = FALSE)
	if(user.a_intent == INTENT_HARM)
		..(user, TRUE)
		adjustBruteLoss(20)
		var/hitverb = "punched"
		if(mob_size < MOB_SIZE_LARGE)
			step_away(src,user,15)
			hitverb = "slammed"
		playsound(loc, "punch", 25, TRUE, -1)
		visible_message("<span class='danger'>[user] has [hitverb] [src]!</span>", \
		"<span class='userdanger'>[user] has [hitverb] [src]!</span>", null, COMBAT_MESSAGE_RANGE)
		return TRUE

/mob/living/simple_animal/attack_nanosuit(mob/living/carbon/human/user, does_attack_animation = FALSE)
	if(user.a_intent == INTENT_HARM)
		..(user, TRUE)
		adjustBruteLoss(20)
		var/hitverb = "punched"
		if(mob_size < MOB_SIZE_LARGE)
			step_away(src,user,15)
			hitverb = "slammed"
		playsound(loc, "punch", 25, TRUE, -1)
		visible_message("<span class='danger'>[user] has [hitverb] [src]!</span>", \
		"<span class='userdanger'>[user] has [hitverb] [src]!</span>", null, COMBAT_MESSAGE_RANGE)
		return TRUE

/mob/living/carbon/alien/humanoid/attack_nanosuit(mob/living/carbon/human/user, does_attack_animation = FALSE)
	if(user.a_intent == INTENT_HARM)
		..(user, TRUE)
		adjustBruteLoss(25)
		adjustStaminaLoss(35)
		var/hitverb = "punched"
		playsound(loc, "punch", 25, TRUE, -1)
		visible_message("<span class='danger'>[user] has [hitverb] [src]!</span>", \
		"<span class='userdanger'>[user] has [hitverb] [src]!</span>", null, COMBAT_MESSAGE_RANGE)
		return TRUE

/obj/item/attack_nanosuit(mob/living/carbon/human/user)
	return FALSE

/obj/effect/attack_nanosuit(mob/living/carbon/human/user, does_attack_animation = FALSE)
	return FALSE

/obj/structure/window/attack_nanosuit(mob/living/carbon/human/user, does_attack_animation = FALSE)
	if(!can_be_reached(user))
		return TRUE
	. = ..()

/obj/structure/grille/attack_nanosuit(mob/living/carbon/human/user, does_attack_animation = FALSE)
	if(user.a_intent == INTENT_HARM)
		if(!shock(user, 70))
			..(user, TRUE)
		return TRUE

/obj/structure/destructible/clockwork/attack_nanosuit(mob/living/carbon/human/user, does_attack_animation = FALSE)
	if(is_servant_of_ratvar(user) && immune_to_servant_attacks)
		return FALSE
	return ..()

/obj/attack_nanosuit(mob/living/carbon/human/user, does_attack_animation = FALSE)//attacking objects barehand
	if(user.a_intent == INTENT_HARM)
		..(user, TRUE)
		visible_message("<span class='danger'>[user] smashes [src]!</span>", null, null, COMBAT_MESSAGE_RANGE)
		if(density)
			playsound(src, 'sound/effects/bang.ogg', 100, TRUE)//less ear rape
		else
			playsound(src, 'sound/effects/bang.ogg', 50, TRUE)//less ear rape
		take_damage(nanosuit_damage(), BRUTE, "melee", FALSE, get_dir(src, user))
		return TRUE
	return FALSE

/mob/living/carbon/human/check_weakness(obj/item/weapon, mob/living/carbon/attacker)
	if(attacker && ishuman(attacker))
		if(attacker.mind.has_martialart(MARTIALART_NANOSUIT) && weapon && weapon.damtype == BRUTE)
			return 1.25 //deal 25% more damage in strength
	. = ..()

/obj/attacked_by(obj/item/I, mob/living/user)
	if(I.force && I.damtype == BRUTE && user.mind.has_martialart(MARTIALART_NANOSUIT))
		visible_message("<span class='danger'>[user] has hit [src] with a strengthened blow from [I]!</span>", null, null, COMBAT_MESSAGE_RANGE)
		//only witnesses close by and the victim see a hit message.
		take_damage(I.force*1.75, I.damtype, "melee", TRUE)//take 75% more damage with strength on
	else
		return ..()

/obj/item/throw_at(atom/target, range, speed, mob/thrower, spin = TRUE, diagonals_first = FALSE, datum/callback/callback)
	if(thrower && ishuman(thrower))
		var/mob/living/carbon/human/H = thrower
		if(istype(H.wear_suit, /obj/item/clothing/suit/space/hardsuit/nano))
			var/obj/item/clothing/suit/space/hardsuit/nano/NS = H.wear_suit
			if(NS.mode == NANO_STRENGTH)
				.=..(target, range*1.5, speed*2, thrower, spin, diagonals_first, callback)
				return
	.=..()

/datum/martial_art/nanosuit/proc/on_attack_hand(mob/living/carbon/human/owner, atom/target, proximity)
	if(proximity)
		return target.attack_nanosuit(owner)

/mob/living/carbon/human/UnarmedAttack(atom/A, proximity)
	var/datum/martial_art/nanosuit/style = mind.has_martialart(MARTIALART_NANOSUIT)
	if(style && style.on_attack_hand(src, A, proximity))
		return
	..()

/mob/living/simple_animal/attack_hand(mob/living/carbon/human/M)
	if(istype(M.wear_suit, /obj/item/clothing/suit/space/hardsuit/nano))
		var/obj/item/clothing/suit/space/hardsuit/nano/NS = M.wear_suit
		NS.kill_cloak()
	..()

/obj/item/clothing/suit/space/hardsuit/nano/proc/kill_cloak()
	if(mode == NANO_CLOAK)
		var/obj/item/W = Wearer.get_active_held_item()
		if(istype(W, /obj/item/gun))
			var/obj/item/gun/G = W
			if(G.suppressed && G.can_shoot())
				set_nano_energy(15)
				Wearer.filters = null
				animate(Wearer, alpha = 255, time = stealth_cloak_out)
				addtimer(CALLBACK(src, .proc/resume_cloak),CLICK_CD_RANGE,TIMER_UNIQUE|TIMER_OVERRIDE)
				return
		set_nano_energy(0,NANO_CHARGE_DELAY)
		return

/obj/item/clothing/suit/space/hardsuit/nano/proc/resume_cloak()
	if(cell.charge && mode == NANO_CLOAK)
		Wearer.filters = filter(type="blur",size=1)
		animate(Wearer, alpha = 40, time = stealth_cloak_in)

/obj/item/storage/box/syndie_kit/nanosuit
	name = "\improper Crynet Systems kit"
	desc = "Maximum Death."

/obj/item/storage/box/syndie_kit/nanosuit/PopulateContents()
	new /obj/item/clothing/suit/space/hardsuit/nano(src)

/obj/item/implant/explosive/disintegrate
	name = "disintegration implant"
	desc = "Ashes to ashes."
	icon_state = "explosive"
	actions_types = list(/datum/action/item_action/dusting_implant)

/obj/item/implant/explosive/disintegrate/activate(cause)
	if(!cause || !imp_in || cause == "emp" || active)
		return FALSE
	if(cause == "action_button" && !popup)
		popup = TRUE
		var/response = alert(imp_in, "Are you sure you want to activate your [name]? This will cause you to disintergrate!", "[name] Confirmation", "Yes", "No")
		popup = FALSE
		if(response == "No")
			return FALSE
	active = TRUE //to avoid it triggering multiple times due to dying
	to_chat(imp_in, "<span class='notice'>Your dusting implant activates!</span>")
	imp_in.visible_message("<span class='warning'>[imp_in] burns up in a flash!</span>")
	var/turf/T = get_turf(imp_in)
	message_admins("[ADMIN_LOOKUPFLW(imp_in)] has activated their [name] at [ADMIN_VERBOSEJMP(T)], with cause of [cause].")
	playsound(loc, 'sound/effects/fuse.ogg', 30, FALSE)
	imp_in.dust(TRUE,TRUE)
	qdel(src)

/obj/item/tank/internals/emergency_oxygen/recharge
	name = "self-filling miniature oxygen tank"
	desc = "A magical tank that uses bluespace technology to replenish it's oxygen supply."
	volume = 2
	icon_state = "emergency_tst"
	item_flags = DROPDEL

/obj/item/tank/internals/emergency_oxygen/recharge/New()
	..()
	air_contents.assert_gas(/datum/gas/oxygen)
	air_contents.gases[/datum/gas/oxygen][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

/obj/item/tank/internals/emergency_oxygen/recharge/process()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		var/moles_val = (ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)
		var/In_Use = H.Move()
		if(In_Use)
			return
		else
			sleep(10)
			if(air_contents.gases[/datum/gas/oxygen][MOLES] < (10*moles_val))
				air_contents.assert_gas(/datum/gas/oxygen)
				air_contents.gases[/datum/gas/oxygen][MOLES] = CLAMP(air_contents.total_moles()+moles_val,0,(10*moles_val))
		if(air_contents.return_pressure() >= 16 && distribute_pressure < 16)
			distribute_pressure = 16

/obj/item/tank/internals/emergency_oxygen/recharge/equipped(mob/living/carbon/human/wearer, slot)
	..()
	if(slot == SLOT_S_STORE)
		add_trait(TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)
		START_PROCESSING(SSobj, src)

/obj/item/tank/internals/emergency_oxygen/recharge/dropped(mob/living/carbon/human/wearer)
	..()
	STOP_PROCESSING(SSobj, src)

/mob/living/carbon/human/proc/Nanosuit_help()
	set name = "Crytek Product Manual"
	set desc = "You read through the manual..."
	set category = "Nanosuit help"

	to_chat(src, "<b><i>Welcome to CryNet Systems user manual 1.22 rev. 6618. Today we will learn about what your new piece of hardware has to offer.</i></b>")
	to_chat(src, "<b><i>If you are reading this, you've probably alerted the entire sector about the purchase of an illegal syndicate item banned in a radius of 50 megaparsecs!</i></b>")
	to_chat(src, "<b><i>Fortunately the syndicate equipped this bad boy with high tech sensing equipment,the downside is the whole crew knows you're here.</i></b>")
	to_chat(src, "<b>Sensors</b>: Reagent scanner, bomb radar, medical, security and diagnostic huds, user life signs monitor and bluespace communication relay.")
	to_chat(src, "<b>Passive equipment</b>: Binoculars, night vision, anti-slips, shock and heat proof gloves, self refilling mini o2 tank, emergency medical systems and body temperature defroster.")
	to_chat(src, "<b>Press C to toggle quick mode selection.</b>")
	to_chat(src, "<b>Active modes</b>: Armor, strength, speed and cloak.")
	to_chat(src, "<span class='notice'>Armor</span>: Resist damage that would normally kill or seriously injure you. Blocks 50% of attacks at a cost of suit energy drain.")
	to_chat(src, "<span class='notice'>Cloak</span>: Become a ninja. Cloaking technology alters the outer layers to refract light through and around the suit, making the user appear almost completely invisible. Simple tasks such as attacking in any way, being hit or throwing objects cancels cloak.")
	to_chat(src, "<span class='notice'>Speed</span>: Run like a madman. Use conservatively as suit energy drains fairly quickly.")
	to_chat(src, "<span class='notice'>Strength</span>: Beat the shit out of objects  or people with your fists. Jump across small gabs and structures. You hit and throw harder with brute objects. You can't be grabbed aggressively or pushed. Deflect attacks and ranged hits occasionally. ")
	to_chat(src, "<span class='notice'>Aggressive grab</span>: Your grabs start aggressive.")
	to_chat(src, "<span class='notice'>Robust push</span>: Your disarms have a 70% chance of knocking an opponent down for 4 seconds.")
	to_chat(src, "<span class='notice'>MMA master</span>: Harm intents deals more damage, occasionally trigger series of fast hits and you can leg sweep while lying down.")
	to_chat(src, "<span class='notice'>Highschool bully</span>: Grab someone and harm intent them to deliver a deadly knock down punch.")
	to_chat(src, "<span class='notice'>Knockout master</span>: Tighten your grip and harm intent to deliver a very deadly knock out punch.")
	to_chat(src, "<span class='notice'>Mike Tyson</span>: 2 quick punches to build confidence then land a hard right hook, sending your victim flying back.")
	to_chat(src, "<span class='notice'>Head stomp special</span>: Target victims head while they're knocked down, stomp until their brain explodes.")
	to_chat(src, "<b><i>User warning: The suit is equipped with an implant which vaporizes the suit and user upon request or death.</i></b>")

/obj/item/stock_parts/cell/nano
	name = "nanosuit self charging battery"
	maxcharge = 100

mob/living/carbon/human/key_down(_key, client/user)
	switch(_key)
		if("C")
			if(istype(wear_suit, /obj/item/clothing/suit/space/hardsuit/nano))
				var/obj/item/clothing/suit/space/hardsuit/nano/NS = wear_suit
				NS.open_mode_menu(src)
				return
	..()

/obj/item/clothing/suit/space/hardsuit/nano/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/clothing/suit/space/hardsuit/nano/proc/open_mode_menu(mob/living/user)
	var/list/choices = list(
	"armor" = image(icon = 'hippiestation/icons/mob/actions/actions_nanosuit.dmi', icon_state = "armor_menu"),
	"speed" = image(icon = 'hippiestation/icons/mob/actions/actions_nanosuit.dmi', icon_state = "speed_menu"),
	"cloak" = image(icon = 'hippiestation/icons/mob/actions/actions_nanosuit.dmi', icon_state = "cloak_menu"),
	"strength" = image(icon = 'hippiestation/icons/mob/actions/actions_nanosuit.dmi', icon_state = "strength_menu")
	)
	var/choice = show_radial_menu(user,user, choices, custom_check = CALLBACK(src, .proc/check_menu, user), require_near = TRUE)
	if(!check_menu(user))
		return
	switch(choice)
		if("armor")
			toggle_mode(NANO_ARMOR)
			return
		if("speed")
			toggle_mode(NANO_SPEED)
			return
		if("cloak")
			toggle_mode(NANO_CLOAK)
			return
		if("strength")
			toggle_mode(NANO_STRENGTH)
			return

/datum/radial_menu/extract_image(E)
	var/mutable_appearance/MA = new /mutable_appearance(E)
	if(MA)
		MA.layer = ABOVE_HUD_LAYER
		MA.appearance_flags |= RESET_TRANSFORM | RESET_ALPHA
	return MA
