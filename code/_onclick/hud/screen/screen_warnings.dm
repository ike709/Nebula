/obj/screen/fire_warning
	name = "fire"
	icon_state = "fire0"
	screen_loc = ui_fire

/obj/screen/health_warning
	name = "health"
	icon_state = "health0"
	screen_loc = ui_health

/obj/screen/health_warning/handle_click(mob/user, params)
	if(ishuman(user))
		var/mob/living/human/human_user = user
		human_user.check_self_injuries()
	return TRUE

/obj/screen/warning_cells
	name = "cell"
	icon_state = "charge-empty"
	screen_loc = ui_nutrition
