// == Updated intent system ==
// - Use mob.get_intent() to retrieve the entire decl structure.
// - Use mob.check_intent(I_FOO) for 1:1 intent type checking.
// - Use mob.check_intent(I_FLAG_FOO) for 'close enough for government work' flag checking.
// - Use mob.set_intent(I_FOO) to set intent to a type - does not accept flags.
// - Use mob.cycle_intent(INTENT_HOTKEY_LEFT) or mob.cycle_intent(INTENT_HOTKEY_RIGHT) to step up or down the mob intent list.
// - Override mob.get_available_intents() if you want to change the intents from the default four.

// TODO:
// - dynamic intent options based on equipped weapons, species, bodytype of active hand

/proc/resolve_intent(intent)
	RETURN_TYPE(/decl/intent)
	// Legacy, should not proc.
	if(istext(intent))
		intent = decls_repository.get_decl_by_id_or_var(intent, /decl/intent, "name")
	// Saves constantly calling GET_DECL(I_FOO)
	if(ispath(intent, /decl/intent))
		intent = GET_DECL(intent)
	if(istype(intent, /decl/intent))
		return intent
	return null

/decl/intent
	abstract_type    = /decl/intent
	decl_flags       = DECL_FLAG_MANDATORY_UID
	/// Replacing the old usage of I_HURT etc. in attackby() and such. Refer to /mob/proc/check_intent().
	var/intent_flags = 0
	/// Descriptive string used in status panel.
	var/name
	/// State used to update intent selector.
	var/icon_state

/decl/intent/validate()
	. = ..()
	if(!istext(name))
		. += "null or invalid name"
	if(!istext(icon_state))
		. += "null or invalid icon_state"

// Basic subtypes.
/decl/intent/help
	name             = "help"
	uid              = "intent_help"
	intent_flags     = I_FLAG_HELP
	icon_state       = "intent_help"

/decl/intent/harm
	name             = "harm"
	uid              = "intent_harm"
	intent_flags     = I_FLAG_HARM
	icon_state       = "intent_harm"

/decl/intent/grab
	name             = "grab"
	uid              = "intent_grab"
	intent_flags     = I_FLAG_GRAB
	icon_state       = "intent_grab"

/decl/intent/disarm
	name             = "disarm"
	uid              = "intent_disarm"
	intent_flags     = I_FLAG_DISARM
	icon_state       = "intent_disarm"

/mob
	/// Decl for current 'intent' of mob; hurt, harm, etc. Initialized by get_intent().
	var/decl/intent/_a_intent

/mob/proc/check_intent(checking_intent)
	var/decl/intent/intent = get_intent() // Ensures intent has been initalised.
	. = (intent == checking_intent)
	if(!.)
		if(isnum(checking_intent))
			return (intent.intent_flags & checking_intent)
		else if(istext(checking_intent) || ispath(checking_intent, /decl/intent))
			return (intent == resolve_intent(checking_intent))

/mob/proc/set_intent(decl/intent/new_intent)
	new_intent = resolve_intent(new_intent)
	if(istype(new_intent) && get_intent() != new_intent)
		_a_intent = new_intent
		if(istype(hud_used) && hud_used.action_intent)
			hud_used.action_intent.update_icon()
		return TRUE
	return FALSE

/mob/proc/get_intent()
	RETURN_TYPE(/decl/intent)
	if(!_a_intent)
		_a_intent = get_available_intents()[1]
	return _a_intent

/mob/proc/get_available_intents()
	var/static/list/available_intents = list(
		GET_DECL(I_HELP),
		GET_DECL(I_DISARM),
		GET_DECL(I_GRAB),
		GET_DECL(I_HARM)
	)
	return available_intents

/mob/proc/cycle_intent(input)
	set name = "a-intent"
	set hidden = TRUE
	switch(input)
		if(INTENT_HOTKEY_RIGHT)
			return set_intent(next_in_list(get_intent(), get_available_intents()))
		if(INTENT_HOTKEY_LEFT)
			return set_intent(previous_in_list(get_intent(), get_available_intents()))
		else // Fallback, should just use set_intent() directly
			return set_intent(input)
