//all about the summons, nature, and a bit o' healin.

/obj/item/book/spell/druid
	spellbook_type = /datum/spellbook/druid

/datum/spellbook/druid
	name = "\improper Druid's Leaflet"
	feedback = "DL"
	desc = "It smells like an air freshener."
	book_desc = "Summons, nature, and a bit o' healin."
	title = "Druidic Guide on how to be smug about nature"
	title_desc = "Buy spells using your available spell slots. Artefacts may also be bought however their cost is permanent."
	book_flags = CAN_MAKE_CONTRACTS|INVESTABLE
	max_uses = 6

	spells = list(
		/spell/targeted/heal_target =             1,
		/spell/targeted/heal_target/sacrifice =   1,
		/spell/aoe_turf/conjure/mirage =          1,
		/spell/aoe_turf/conjure/summon/bats =     1,
		/spell/aoe_turf/conjure/summon/bear =     1,
		/spell/targeted/equip_item/party_hardy =  1,
		/spell/targeted/equip_item/seed =         1,
		/spell/targeted/shapeshift/avian =        1,
		/spell/aoe_turf/disable_tech =            1,
		/spell/hand/charges/entangle =            1,
		/spell/aoe_turf/conjure/grove/sanctuary = 1,
		/spell/aoe_turf/knock =                   1,
		/spell/area_teleport =                    2,
		/spell/portal_teleport =                  2,
		/spell/noclothes =                        1,
		/obj/item/magic_rock =                    1,
		/obj/item/summoning_stone =               2,
		/obj/item/contract/wizard/telepathy =     1,
		/obj/item/contract/apprentice =           1
	)
	sacrifice_objects = list(
		/obj/item/seeds,
		/obj/item/wirecutters/clippers,
		/obj/item/scanner/plant,
		/obj/item/tool/axe/hatchet,
		/obj/item/tool/hoe/mini
	)
