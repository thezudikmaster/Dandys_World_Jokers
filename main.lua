------------ GLOBAL VARIABLES ------------

-- Global variable para sprites de Gigi JAJAJA take the L lol JACKPOT BIG MONEY
G.dwjokers_gigi_state_sprites = {
	[1] = { x = 4, y = 3 },	-- Normal
	[2] = { x = 6, y = 0}	-- L
}

-- G.dwjokers_delete_run : marca si la run esta siendo borrada o no ahora mismo

-- G.GAME.dwjokers_bassie_exists : marca si Bassie existe en tu deck

-- G.GAME.dwjokers_vee_exists : marca si Vee existe en tu deck

-- G.GAME.dwjokers_coal_exists : marca si Coal existe en tu deck

-- G.GAME.dwjokers_pebble_exists : marca si Pebble existe en tu deck

-- G.GAME.dwjokers_pebble_cards_to_predict : numero de cartas del deck a predecir para pebble

-- G.GAME.dwjokers_bobette_bonus : bonus multiplicativo individual de Bobette (default: 2)

-- G.GAME.dwjokers_editing_vee : carta de Vee que esta abriendo el super menu ahora mismo

-- G.GAME.dwjokers_soulvester_h_size : guarda valor real instantaneo del hand size para soulvester

-- G.GAME.dwjokers_soulvester_hands : guarda valor real instantaneo de las hands para soulvester

-- G.GAME.dwjokers_blot_game_over : guarda si el juego esta en game over. Se actualiza solo con Blot

-- G.GAME.dwjokers_toon_spotlight_rate : tasa de aparicion de toons en tienda. Para el voucher toon spotlight

-- G.GAME.dwjokers_vee_table : guarda las opciones seleccionadas para los bonus de vee, de todas las vees existentes

-- G.GAME.dwjokers_blackout_disable_by_light_producing : true si el The Blackout boss blind fue deshabilitado por un toon con la propiedad Light-Producing

------------ CUSTOM SETS, POOLS y AREAS --------------

-- Custom card areas
SMODS.current_mod.custom_card_areas = function(game)
	
	-- Prediction area para Coal (out of bounds)
	game.dwjokers_coal_prediction_area = CardArea(
		game.jokers.T.x, 
		game.jokers.T.y -20,
        game.jokers.T.w, 
		game.jokers.T.h / 2,
        { card_limit = 0, type = 'shop', highlight_limit = 0 }
	)

	-- Prediction area para Pebble (out of bounds)
	game.dwjokers_pebble_prediction_area = CardArea(
		game.jokers.T.x + 10, 
		game.jokers.T.y -20,
        game.jokers.T.w, 
		game.jokers.T.h / 2,
        { card_limit = 0, type = 'shop', highlight_limit = 0 }
	)

	-- Basket area para Bassie (out of bounds)
	-- OJO: las cartas de la UI de la basket son una copia de las originales.
	game.dwjokers_bassie_basket = CardArea(
		game.jokers.T.x, 
		game.jokers.T.y -10,
        game.jokers.T.w, 
		game.jokers.T.h / 2,
        { card_limit = 0, type = 'shop', highlight_limit = 1 }
	)
end

-- Tipos de cartas, para Yatta
local card_types = {
	'Tarot',
	'Planet',
	'Spectral'
}

-- Jokers autodestructivos. En Balatro vanilla solo hay uno (Mr.Bones).
-- TODO: quizas pudiera crear un contexto que se active si un joker se autodestruye.
local selfdestruct_jokers = {
	'j_dwjokers_Cosmo',
	'j_mr_bones'
}

-- Rainbow colour, para badge de mains
SMODS.Gradient {
    key = 'rainbow', -- Clave para identificarlo
    
    -- Los colores entre los que va a ciclar (R, G, B, A)
    colours = {
        HEX("FF0000"),	-- rojo
        HEX("FF9900"),	-- naranja
        HEX("FFFF00"),	-- amarillo
		HEX("00FF00"),	-- verde
		HEX("0000FF"),	-- azul
		HEX("AA00FF"),	-- morado
    },
    
    cycle = 5.0, -- Cuántos segundos tarda en completar el ciclo
    interpolation = 'trig' -- 'trig' para suave (senoidal), 'linear' para lineal
}

-- Lethal colour, para badge de letales
SMODS.Gradient {
    key = 'lethal', -- Clave para identificarlo
    
    -- Los colores entre los que va a ciclar (R, G, B, A)
    colours = {
        HEX("FF0000"),	-- rojo
        HEX("000000"),	-- negro
    },
    
    cycle = 5.0, -- Cuántos segundos tarda en completar el ciclo
    interpolation = 'trig' -- 'trig' para suave (senoidal), 'linear' para lineal
}

-- Rareza de mains
SMODS.Rarity {
    key = "Main",
	loc_txt = {
		name = "Main"
	},
	pools = {
		["Joker"] = true
	},
    default_weight = 0,
    badge_colour = SMODS.Gradients.dwjokers_rainbow,
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

-- Rareza de lideres
SMODS.Rarity {
    key = "Leader",
	loc_txt = {
		name = "Leader"
	},
	pools = {
		["Joker"] = true
	},
    default_weight = 0,
    badge_colour = SMODS.Gradients.dwjokers_lethal,
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

-- Rareza de letales
SMODS.Rarity {
    key = "Lethal",
	loc_txt = {
		name = "Lethal"
	},
	pools = {
		["Joker"] = true
	},
    default_weight = 0,
    badge_colour = SMODS.Gradients.dwjokers_lethal,
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

-- Pool de todos los toons, para lo que se ofrezca
SMODS.ObjectType ({
	key = "dwjokers_toons",
	default = "j_dwjokers_Cosmo", -- Jiji SC-001
	cards = {
		-- Regular
		["j_dwjokers_Blot"] = true,
		["j_dwjokers_Boxten"] = true,
		["j_dwjokers_Brightney"] = true,
		["j_dwjokers_Brusha"] = true,
		["j_dwjokers_Connie"] = true,
		["j_dwjokers_Cosmo"] = true,
		["j_dwjokers_Finn"] = true,
		["j_dwjokers_Flutter"] = true,
		["j_dwjokers_Gigi"] = true,
		["j_dwjokers_Glisten"] = true,
		["j_dwjokers_Goob"] = true,
		["j_dwjokers_Looey"] = true,
		["j_dwjokers_Poppy"] = true,
		["j_dwjokers_RazzlenDazzle"] = true,
		["j_dwjokers_Rodger"] = true,
		["j_dwjokers_Scraps"] = true,
		["j_dwjokers_Shrimpo"] = true,
		["j_dwjokers_Squirm"] = true,
		["j_dwjokers_Teagan"] = true,
		["j_dwjokers_Tisha"] = true,
		["j_dwjokers_Toodles"] = true,
		["j_dwjokers_Yatta"] = true,

		-- Mains
		["j_dwjokers_Astro"] = true,
		["j_dwjokers_Pebble"] = true,
		["j_dwjokers_Shelly"] = true,
		["j_dwjokers_Sprout"] = true,
		["j_dwjokers_Vee"] = true,

		-- Letales
		["j_dwjokers_Dandy"] = true,
		["j_dwjokers_Dyle"] = true,

		-- Festivos
		["j_dwjokers_Bassie"] = true,
		["j_dwjokers_Bobette"] = true,
		["j_dwjokers_Coal"] = true,
		["j_dwjokers_Cocoa"] = true,
		["j_dwjokers_Eclipse"] = true,
		["j_dwjokers_Eggson"] = true,
		["j_dwjokers_Flyte"] = true,
		["j_dwjokers_Ginger"] = true,
		["j_dwjokers_Gourdy"] = true,
		["j_dwjokers_Ribecca"] = true,
		["j_dwjokers_Rudie"] = true,
		["j_dwjokers_Soulvester"] = true,
	},
})

-- Pool de los toons mains
SMODS.ObjectType ({
	key = "dwjokers_toons_mains",
	default = "j_dwjokers_Pebble", -- MC-001
	cards = {
		-- Mains
		["j_dwjokers_Astro"] = true,
		["j_dwjokers_Pebble"] = true,
		["j_dwjokers_Shelly"] = true,
		["j_dwjokers_Sprout"] = true,
		["j_dwjokers_Vee"] = true,

		-- Festivos
		["j_dwjokers_Bassie"] = true,
		["j_dwjokers_Bobette"] = true,
		["j_dwjokers_Gourdy"] = true,
	},
})

-- Pool de los toons letales
SMODS.ObjectType ({
	key = "dwjokers_toons_lethals",
	default = "j_dwjokers_Dandy", -- L-001
	cards = {
		-- Letales
		["j_dwjokers_Dandy"] = true,
		["j_dwjokers_Dyle"] = true,
	},
})

-- Pool de los toons no letales, para Dandy
SMODS.ObjectType ({
	key = "dwjokers_toons_regular",
	default = "j_dwjokers_Cosmo", -- Jiji SC-001
	cards = {
		-- Regular
		["j_dwjokers_Blot"] = true,
		["j_dwjokers_Boxten"] = true,
		["j_dwjokers_Brightney"] = true,
		["j_dwjokers_Brusha"] = true,
		["j_dwjokers_Connie"] = true,
		["j_dwjokers_Cosmo"] = true,
		["j_dwjokers_Finn"] = true,
		["j_dwjokers_Flutter"] = true,
		["j_dwjokers_Gigi"] = true,
		["j_dwjokers_Glisten"] = true,
		["j_dwjokers_Goob"] = true,
		["j_dwjokers_Looey"] = true,
		["j_dwjokers_Poppy"] = true,
		["j_dwjokers_RazzlenDazzle"] = true,
		["j_dwjokers_Rodger"] = true,
		["j_dwjokers_Scraps"] = true,
		["j_dwjokers_Shrimpo"] = true,
		["j_dwjokers_Squirm"] = true,
		["j_dwjokers_Teagan"] = true,
		["j_dwjokers_Tisha"] = true,
		["j_dwjokers_Toodles"] = true,
		["j_dwjokers_Yatta"] = true,

		-- Mains
		["j_dwjokers_Astro"] = true,
		["j_dwjokers_Pebble"] = true,
		["j_dwjokers_Shelly"] = true,
		["j_dwjokers_Sprout"] = true,
		["j_dwjokers_Vee"] = true,

		-- Festivos
		["j_dwjokers_Bassie"] = true,
		["j_dwjokers_Bobette"] = true,
		["j_dwjokers_Coal"] = true,
		["j_dwjokers_Cocoa"] = true,
		["j_dwjokers_Eclipse"] = true,
		["j_dwjokers_Eggson"] = true,
		["j_dwjokers_Flyte"] = true,
		["j_dwjokers_Ginger"] = true,
		["j_dwjokers_Gourdy"] = true,
		["j_dwjokers_Ribecca"] = true,
		["j_dwjokers_Rudie"] = true,
		["j_dwjokers_Soulvester"] = true,
	},
})

-- Pool de los toons no mains ni letales, para booster packs
SMODS.ObjectType ({
	key = "dwjokers_toons_pack",
	default = "j_dwjokers_Cosmo", -- Jiji SC-001
	cards = {
		-- Regular
		["j_dwjokers_Blot"] = true,
		["j_dwjokers_Boxten"] = true,
		["j_dwjokers_Brightney"] = true,
		["j_dwjokers_Brusha"] = true,
		["j_dwjokers_Connie"] = true,
		["j_dwjokers_Cosmo"] = true,
		["j_dwjokers_Finn"] = true,
		["j_dwjokers_Flutter"] = true,
		["j_dwjokers_Gigi"] = true,
		["j_dwjokers_Glisten"] = true,
		["j_dwjokers_Goob"] = true,
		["j_dwjokers_Looey"] = true,
		["j_dwjokers_Poppy"] = true,
		["j_dwjokers_RazzlenDazzle"] = true,
		["j_dwjokers_Rodger"] = true,
		["j_dwjokers_Scraps"] = true,
		["j_dwjokers_Shrimpo"] = true,
		["j_dwjokers_Squirm"] = true,
		["j_dwjokers_Teagan"] = true,
		["j_dwjokers_Tisha"] = true,
		["j_dwjokers_Toodles"] = true,
		["j_dwjokers_Yatta"] = true,

		-- Festivos
		["j_dwjokers_Coal"] = true,
		["j_dwjokers_Cocoa"] = true,
		["j_dwjokers_Eclipse"] = true,
		["j_dwjokers_Eggson"] = true,
		["j_dwjokers_Flyte"] = true,
		["j_dwjokers_Ginger"] = true,
		["j_dwjokers_Ribecca"] = true,
		["j_dwjokers_Rudie"] = true,
		["j_dwjokers_Soulvester"] = true,
	},
})

-- Retrigger joker optional feature para Cocoa
SMODS.current_mod.optional_features = function()
    return { retrigger_joker = true }
end

-- Attribute Toon para los toons
SMODS.Attribute ({
	key = 'toon',
	keys = {

		-- Regular
		"j_dwjokers_Blot",
		"j_dwjokers_Boxten",
		"j_dwjokers_Brightney",
		"j_dwjokers_Brusha",
		"j_dwjokers_Connie",
		"j_dwjokers_Cosmo",
		"j_dwjokers_Finn",
		"j_dwjokers_Flutter",
		"j_dwjokers_Gigi",
		"j_dwjokers_Glisten",
		"j_dwjokers_Goob",
		"j_dwjokers_Looey",
		"j_dwjokers_Poppy",
		"j_dwjokers_RazzlenDazzle",
		"j_dwjokers_Rodger",
		"j_dwjokers_Scraps",
		"j_dwjokers_Shrimpo",
		"j_dwjokers_Squirm",
		"j_dwjokers_Teagan",
		"j_dwjokers_Tisha",
		"j_dwjokers_Toodles",
		"j_dwjokers_Yatta",

		-- Mains
		"j_dwjokers_Astro",
		"j_dwjokers_Pebble",
		"j_dwjokers_Shelly",
		"j_dwjokers_Sprout",
		"j_dwjokers_Vee",

		-- Letales
		"j_dwjokers_Dandy",
		"j_dwjokers_Dyle",

		-- Festivos
		"j_dwjokers_Bassie",
		"j_dwjokers_Bobette",
		"j_dwjokers_Coal",
		"j_dwjokers_Cocoa",
		"j_dwjokers_Eclipse",
		"j_dwjokers_Eggson",
		"j_dwjokers_Flyte",
		"j_dwjokers_Ginger",
		"j_dwjokers_Gourdy",
		"j_dwjokers_Ribecca",
		"j_dwjokers_Rudie",
		"j_dwjokers_Soulvester",
	}
})

-- Attribute selfdestruct para jokers
SMODS.Attribute ({
	key = 'self_destructs',
	keys = {
		"j_dwjokers_Cosmo",
		'j_mr_bones'
	}
})

-- Attribute cant save para objetos que no pueden guardarse en la basket de Bassie
SMODS.Attribute ({
	key = 'cant_save',
	keys = {
		"j_dwjokers_Vee",
		"j_dwjokers_Coal",
		"j_dwjokers_Pebble",
		"j_dwjokers_Bassie",
		"j_dwjokers_Dandy_twisted",
		"j_dwjokers_Dyle_twisted"
	}
})

-- Attribute light producing para toons que producen luz
SMODS.Attribute ({
	key = 'light_producing',
	keys = {
		"j_dwjokers_Astro",
		"j_dwjokers_Brightney",
		"j_dwjokers_Connie",
		"j_dwjokers_Rudie",
		"j_dwjokers_Soulvester",
		"j_dwjokers_Vee"
	}
})


------------ HOOKS --------------

-- Game delete run hook para evitar crasheos con remove card (no se si es mala o PESIMA practica)
local original_delete_run = Game.delete_run
function Game:delete_run()
	G.dwjokers_delete_run = true
	dwjokers_rarity_change(nil, true)
	local ret = original_delete_run(self)
	G.dwjokers_delete_run = false
	return ret
end

-- Game start run hook para revisar si tenemos el voucher de dandys world
local original_start_run = Game.start_run
function Game:start_run(args)

	local ret = original_start_run(self, args)
	-- Vemos si tenemos el voucher de dandys world
	if next(SMODS.find_card("v_dwjokers_dandys_world")) then
		dwjokers_rarity_change(true, nil) -- Aplicamos el cambio de rarezas
	end

	return ret
end

-- Card hover hook para un hovered context
local original_card_hover = Card.hover
function Card:hover()
	local ret = original_card_hover(self)
	
	SMODS.calculate_context({ 
		dwjokers_hovered = true, 
		dwjokers_hovered_card = self,
	})

	return ret
end

-- Card stop hover para hovered context
local original_card_stop_hover = Card.stop_hover
function Card:stop_hover()
	SMODS.calculate_context({ 
		dwjokers_hovered = false, 
		dwjokers_hovered_card = self,
	})
	local ret = original_card_stop_hover(self)
	return ret
end

-- Card remove hook para un removed context DESPUES de que la carta ha sido removida
local original_remove = Card.remove
function Card:remove()

	local goob_exists = next(SMODS.find_card("j_dwjokers_Goob"))
	if goob_exists then
		local is_joker = self.ability and self.ability.set == "Joker"
		local selling = self.being_sold
		local selfdestructive = self:has_attribute('self_destructs')
		local area = self.area
		if is_joker and area == G.jokers and goob_exists and not selling and not selfdestructive then
			self.getting_sliced = nil
			self.debuff = nil
			self.saved_by_goob = true
			self.added_to_deck = true
			return
		end
	end

	local re_card = self
	local cardarea = re_card.area or false

	local ret = original_remove(self)

	if not G.dwjokers_delete_run then
		SMODS.calculate_context({
			dwjokers_removed = true,
			dwjokers_removed_card = re_card,
			dwjokers_removed_cardarea = cardarea
		})
	end

	return ret
end	

-- Start_dissolve hook para prevenir que Jokers sean destruidos si tienes a Goob en tu deck
-- Mas un saved by goob context por si se ocupa
local original_start_dissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)

	-- Revisamos si tiene a Goob
    local goob_exists = next(SMODS.find_card("j_dwjokers_Goob"))
	if goob_exists then
		local is_joker = self.ability and self.ability.set == "Joker"
		local selling = self.being_sold
		local selfdestructive = self:has_attribute('self_destructs')
		local area = self.area

		-- Evitamos la destruccion de jokers
		if is_joker and area == G.jokers and not selling and not selfdestructive then
			SMODS.calculate_context({ 
				dwjokers_saved_by_goob = true, 
				dwjokers_saved_by_goob_card = self })
			self.getting_sliced = nil
			self.debuff = nil
			self.saved_by_goob = true
			self.added_to_deck = true
			return
		end
	end

	local ret = original_start_dissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
    return ret
end

-- Shatter hook para marcar la carta como being shattered
local original_shatter = Card.shatter
function Card:shatter()
	self.being_shattered = true
	return original_shatter(self)
end

-- Explode hook para marcar la carta como being exploded
local original_explode = Card.explode
function Card:explode(dissolve_colours, explode_time_fac)
	self.being_exploded = true
	return original_explode(self, dissolve_colours, explode_time_fac)
end

-- Sell_card hook para marcar la carta como being sold
local original_sell_card = Card.sell_card
function Card:sell_card()
	self.being_sold = true
	return original_sell_card(self)
end

-- Set edition hook para predicciones silenciosas y Glisten
local original_set_edition = Card.set_edition
function Card:set_edition(edition, immediate, silent, delay)
	if not edition then return end

	-- si es Glisten, forzamos la edicion a ser holo
	if self.config and self.config.center and self.config.center.key == "j_dwjokers_Glisten" then
		edition = {}
		edition.holo = true
	end

	-- si es prediccion, entonces silent es true
	if G.GAME.dwjokers_prediction_active then
		local ret = original_set_edition(self, edition, immediate, true, delay)
	else
		local ret = original_set_edition(self,edition,immediate,silent,delay)
	end

	return ret
end

-- Set seal hook con prediccion activado, si es prediccion sera SILENT
local original_set_seal = Card.set_seal
function Card:set_seal(_seal, silent, immediate)
	if G.GAME.dwjokers_prediction_active then
		local ret = original_set_seal(self, _seal, true, immediate)
	else
		local ret = original_set_seal(self, _seal, silent, immediate)
	end

	return ret
end

-- highlight hook para las mecanicas de bassie, vee, coal y pebble
local highlight_ref = Card.highlight
function Card:highlight(is_highlighted)
	
	-- para la mecanica de la basket de bassie. No se dibuja si es Vee, Coal o Pebble
	if G.GAME.dwjokers_bassie_exists then
		if is_highlighted and ((self.ability.set == "Joker" and self.area == G.jokers) or 
			((self.ability.set == "Tarot" or self.ability.set == "Planet" or self.ability.set == "Spectral") and self.area == G.consumeables) or
			((self.ability.set == "Default" or self.ability.set == "Enhanced") and self.area == G.hand)) then
			if self.config.center.key == "j_dwjokers_Bassie" then
				self.children.dwjokers_my_button = dwjokers_create_bassie_button_ui(self, {func = 'dwjokers_basket_button', text = "BASKET"})
			elseif not self:has_attribute('cant_save') then
				self.children.dwjokers_my_button = dwjokers_create_bassie_button_ui(self, {func = 'dwjokers_save_button', text = "SAVE"})
			end
		elseif is_highlighted and self.ability.dwjokers_in_basket then
			self.children.dwjokers_my_button = dwjokers_create_bassie_button_ui(self, {func = 'dwjokers_retrieve_button', text = "RETRIEVE"})
			return self:highlight_custom(is_highlighted)
		elseif self.children.dwjokers_my_button then
			self.children.dwjokers_my_button:remove()
			self.children.dwjokers_my_button = nil
		end
	elseif self.children.dwjokers_my_button then
		self.children.dwjokers_my_button:remove()
		self.children.dwjokers_my_button = nil
	end

	-- para la mecanica del super menu de vee
	if G.GAME.dwjokers_vee_exists then
		if is_highlighted and self.config.center.key == "j_dwjokers_Vee" and self.area == G.jokers then
			self.children.dwjokers_my_button_2 = dwjokers_create_vee_button_ui(self)
		elseif self.children.dwjokers_my_button_2 then
			self.children.dwjokers_my_button_2:remove()
			self.children.dwjokers_my_button_2 = nil
		end
	end
	
	-- para la mecanica de predicciones de coal
	if G.GAME.dwjokers_coal_exists and G.STATE == G.STATES.SHOP then
		if is_highlighted and self.config.center.key == "j_dwjokers_Coal" and self.area == G.jokers then
			self.children.dwjokers_my_button_3 = dwjokers_create_coal_button_ui(self)
		elseif is_highlighted and self.coal_flag then
			return self:highlight_custom(is_highlighted)
		elseif self.children.dwjokers_my_button_3 then
			self.children.dwjokers_my_button_3:remove()
			self.children.dwjokers_my_button_3 = nil
		end
	end

	-- para la mecanica de predicciones de pebble
	if G.GAME.dwjokers_pebble_exists and ((G.GAME and G.GAME.blind and G.GAME.blind.in_blind) or (G.STATE == G.STATES.SHOP)) then
		if is_highlighted and self.config.center.key == "j_dwjokers_Pebble" and self.area == G.jokers then
			self.children.dwjokers_my_button_4 = dwjokers_create_pebble_button_ui(self)
		elseif is_highlighted and self.pebble_flag then
			return self:highlight_custom(is_highlighted)
		elseif self.children.dwjokers_my_button_4 then
			self.children.dwjokers_my_button_4:remove()
			self.children.dwjokers_my_button_4 = nil
		end
	end

	-- para evitar que twisted Dyle y twisted Dandy puedan venderse
	if is_highlighted and (self.config.center.key == "j_dwjokers_Dandy_twisted" or self.config.center.key == "j_dwjokers_Dyle_twisted") 
	and self.area == G.jokers then
		return self:highlight_custom(is_highlighted)
	end

  	return highlight_ref(self, is_highlighted)
end

-- Draw from play to discard, si tienes a Scraps las scoring cards vuelven al deck
-- CON TAL DE NO HACER UN PATCH XDDDDDD
local original_draw_from_play_to_discard = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
    local play_count = #G.play.cards
    -- Verificamos si tienes el Joker "Scraps"
    local scraps_exists = next(SMODS.find_card("j_dwjokers_Scraps"))

	if scraps_exists then
		for i=1, play_count do
			local card = G.play.cards[i]
			
			if card.ability.dwjokers_scrapped then
				-- Si puntuó y tenemos a Scraps, va al DECK (mazo)
				draw_card(G.play, G.deck, i*100/play_count, 'down', nil, nil, 0.08)
				card.ability.dwjokers_scrapped = nil -- Limpiamos la marca
			else
				-- Comportamiento normal: va al DISCARD (descarte)
				draw_card(G.play, G.discard, i*100/play_count, 'down', nil, nil, 0.08)
				card.ability.dwjokers_scrapped = nil -- Limpiamos por si acaso
			end
		end
	else
		return original_draw_from_play_to_discard(e)
	end
end

-- SMODS.create_card hook para cuando tengas el voucher de toon spotlight
local original_smods_create_card = SMODS.create_card
function SMODS.create_card(t)

	-- 1. Verificamos que no este forzada una key y que el area sea la tienda (jokers)
	if not t.key and t.area == G.shop_jokers then

		-- 2. Verificamos que ya se haya comprado el voucher de toon spotlight
		if G.GAME and G.GAME.used_vouchers and G.GAME.used_vouchers['v_dwjokers_toon_spotlight'] then

			-- 3. Probabilidad de que la carta escogida para la tienda sea un toon
			if pseudorandom('dwjokers_toon_spotlight'..G.GAME.round_resets.ante) > (1-G.GAME.dwjokers_toon_spotlight_rate) then -- 
				
				-- 4. Forzamos el toon, lo escogera de la pool de toons no mains ni lideres/letales
				if G.GAME.used_vouchers['v_dwjokers_dandys_world'] then
					t.set = "dwjokers_toons_regular"
				else
					t.set = "dwjokers_toons_pack"
				end
			end
		end
	end

	-- 5. Devolvemos la funcion original
	return original_smods_create_card(t)
end

-- Generate UIBox ability table hook para ocultar habilidades y nombres si la carta es blackout
local original_generate_UIBox_ability_table = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table()
    local res = original_generate_UIBox_ability_table(self)
    
	-- verificamos que la carta no se haya creado en pausa (como la coleccion)
	-- algo minimo, permite ver que hace el blackout edition en la coleccion
	if not self.created_on_pause then
		-- Verificamos si la carta tiene la edición Blackout
		if self.edition and self.edition.key == "e_dwjokers_blackout" then

			-- 1. Reemplazamos el Nombre
			local colour1 = {}
			local set = (self.ability and self.ability.set) and self.ability.set or 'None'
			local scale1 = 0

			-- caso especifico si la carta es jugable
			if set == 'Default' or set == 'Enhanced' then
				colour1 = copy_table(G.C.UI.TEXT_DARK)
				scale1 = 0.32
			else
				colour1 = copy_table(G.C.UI.TEXT_LIGHT)
				scale1 = 0.45
			end

			res.name = {
				{n=G.UIT.T, config={text = "????", colour = colour1, scale = scale1, shadow = true}}
			}
			
			-- 2. Reemplazamos la Descripción Principal (main desc)
			res.main = {
				{
					{n=G.UIT.T, config={text = "?????", colour = G.C.UI.TEXT_DARK, scale = 0.32}}
				}
			}
		end
	end
    
    return res
end

-- Parse Highlighted hook para cambiar el hand text si hay una carta blackout
local original_parse_highlighted = CardArea.parse_highlighted
function CardArea:parse_highlighted()
	local ret = original_parse_highlighted(self)

	for _,v in pairs(self.cards) do
		if v.edition and v.edition.key == "e_dwjokers_blackout" and v.highlighted then
			update_hand_text({immediate = true, nopulse = nil, delay = 0}, {handname='????', level='?', mult = '?', chips = '?'})
		end
	end

	return ret
end


------------ CUSTOM FUNCTIONS --------------

-- Para verificar si una tabla contiene un valor. Muy util :)
-- value: valor a buscar en la tabla
-- tbl: tabla de valores
-- return: true si lo contiene, false si no
function table_contains(value, tbl)
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

-- Predecir contenido de booster pack. TREMENDO DOLOR DE CABEZA FUE HACER ESTO :S
-- Card: booster pack a predecir
-- return: tabla de cartas predichas
function Card:simulate_open(to_area)
    if self.ability.set ~= "Booster" then return nil end

	-- ACTIVAMOS ESTADO GLOBAL DE PREDICCION
	G.GAME.dwjokers_prediction_active = true

    -- HACEMOS BACKUP DE PSEUDORANDOM
    local backup_rng = {}
    for k, v in pairs(G.GAME.pseudorandom) do backup_rng[k] = v end
    
    local backup_used_jokers = {}
    for k, v in pairs(G.GAME.used_jokers) do backup_used_jokers[k] = v end


    local predicted_results = {}
    local temp_cards = {} -- Tabla para guardar las cartas físicamente hasta el final
    local booster_obj = self.config.center
    
	-- SIMULACION DE CARD:OPEN() SIN EFECTOS VISUALES NI ANIMACIONES
	-- TOMANDO EN CUENTA LOS PATCHES HASTA SMODS 1.0.0 BETA 1016C

    local _size = math.max(1, (self.ability.extra or 0) + (G.GAME.modifiers.booster_size_mod or 0))
    if booster_obj.config and booster_obj.config.extra then
         _size = math.max(1, booster_obj.config.extra + (G.GAME.modifiers.booster_size_mod or 0))
    end

    for i = 1, _size do
        local card = {}
		card.prediction_active = true
        
        if booster_obj.create_card and type(booster_obj.create_card) == "function" then
            local _card_to_spawn = booster_obj:create_card(self, i)
            if type((_card_to_spawn or {}).is) == 'function' and _card_to_spawn:is(Card) then
                card = _card_to_spawn
            else
                card = SMODS.create_card(_card_to_spawn)
            end
        elseif self.ability.name:find('Arcana') then
            if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
                card = create_card("Spectral", G.pack_cards, nil, nil, true, true, nil, 'ar2')
            else
                card = create_card("Tarot", G.pack_cards, nil, nil, true, true, nil, 'ar1')
            end
        elseif self.ability.name:find('Celestial') then

            local _planet = nil
            if G.GAME.used_vouchers.v_telescope and i == 1 then
                local _hand, _tally = nil, 0
                for k, v in ipairs(G.handlist) do
                    if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                        _hand = v
                        _tally = G.GAME.hands[v].played
                    end
                end
                if _hand then
                    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == _hand then _planet = v.key end
                    end
                end
            end
            card = create_card("Planet", G.pack_cards, nil, nil, true, true, _planet, 'pl1')
        elseif self.ability.name:find('Spectral') then
            card = create_card("Spectral", G.pack_cards, nil, nil, true, true, nil, 'spe')
        elseif self.ability.name:find('Standard') then
            card = create_card((pseudorandom(pseudoseed('stdset'..G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base", G.pack_cards, nil, nil, nil, true, nil, 'sta')
            poll_edition('standard_edition'..G.GAME.round_resets.ante, 2, true)
            SMODS.poll_seal({mod = 10})
        elseif self.ability.name:find('Buffoon') then
            card = create_card("Joker", G.pack_cards, nil, nil, true, true, nil, 'buf')
        end

        if card then
            -- GUARDAMOS LA CARTA EN UNA TABLA
            table.insert(predicted_results, card)
			card:set_card_area(to_area)
			card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 2*G.SETTINGS.GAMESPEED)
			to_area:emplace(card, nil)
            
            -- REGISTRAMOS MANUALMENTE LA CARTA COMO USADA SI ES JOKER
            if card.config.center.set == 'Joker' then
                G.GAME.used_jokers[card.config.center.key] = true
            end

        end
    end

	-- RESTAURACION COMPLETA DE PSEUDORANDOM

	-- Este es importante por si se crearon mas espacios en pseudorandom, no se si ocurre pero mejor prevenir
    for k, _ in pairs(G.GAME.pseudorandom) do G.GAME.pseudorandom[k] = nil end 

    for k, v in pairs(backup_rng) do G.GAME.pseudorandom[k] = v end
    
    -- RESTAURAR LISTA DE USADOS ORIGINAL
    G.GAME.used_jokers = backup_used_jokers 

	-- DESACTIVAMOS ESTADO GLOBAL DE PREDICCION
	G.GAME.dwjokers_prediction_active = false

    return predicted_results
end

-- Imprimir predicciones de Card:simulate_open(). Se imprimen en consola. (DEBUG)
-- t: tabla de cartas predichas por card:simulate_open()
-- card: booster pack predicho
function print_predictions(t, card)
	print("")
	if card and card.config and card.config.center and card.config.center.name then
		print(card.config.center.name)
	end
	local str = ""
	for i = 1, #t do

		if t[i].ability and t[i].ability.set == "Default" or t[i].ability.set == "Enhanced" then
			str = "Playing card: " .. t[i].base.value .. " of " .. t[i].base.suit

			if t[i].edition then
				str = str .. ", Edition: " .. t[i].edition.key
			end

			if t[i].config and t[i].config.center and t[i].config.center.key ~= "c_base" then
				str = str .. ", Enhancement: " .. t[i].config.center.key
			end

			if t[i].seal then
				str = str .. ", Seal: " .. t[i].seal
			end

		else

			str = t[i].config.center.set .. ": " .. t[i].config.center.name

			if t[i].edition then
				str = str .. ", Edition: " .. t[i].edition.key
			end

		end


		if t[i].ability.rental or t[i].ability.perishable or t[i].ability.eternal then
			str = str .. ", Stickers:"
			if t[i].ability.rental then str = str .. " Rental" end
			if t[i].ability.perishable then str = str .. " Perishable" end
			if t[i].ability.eternal then str = str .. " Eternal" end
		end

		print(str)
	end	
end

-- Predecir siguientes cartas a tomar del deck
-- n: numero de cartas a predecir
-- return: tabla de cartas predichas
function get_pebble_predictions(n)
    local predictions = {}
    local deck_ref = G.deck.cards
    local num_cards = #deck_ref
    
    if num_cards == 0 then return predictions end

    -- 1. Backup del RNG para no desincronizar el mazo real
    local backup_rng = {}
    for k, v in pairs(G.GAME.pseudorandom) do backup_rng[k] = v end

	-- Limpiamos el cardarea de pebble
	G.GAME.dwjokers_pebble_predicted_cards = {}

    -- 2. Empezamos desde la cima (final de la tabla)
    for i = 1, math.min(n, num_cards) do
        local real_card = deck_ref[num_cards - i + 1]
        
        -- 3. CREAR LA COPIA (Instancia independiente)
        -- Argumentos de copy_card: (carta_original, area, skip_holos, card_id, no_collectible)
        -- Usamos el último argumento como 'true' para que no cuente para la colección
        local ghost_card = copy_card(real_card, nil, nil, nil, true)
        
        -- 4. Predicción de orientación (Flipped)
        local is_flipped = false
        if G.GAME.blind and G.GAME.blind:stay_flipped(G.hand, ghost_card) then
            is_flipped = true
        end

        if G.GAME.modifiers.flipped_cards then
            -- Esto consume un uso del RNG, por eso el backup es vital
            if pseudorandom(pseudoseed('flipped_card')) < 1/G.GAME.modifiers.flipped_cards then
                is_flipped = true
            end
        end

        -- Aplicamos el estado visual a la COPIA únicamente
        if is_flipped then
            ghost_card.facing = 'down'
            ghost_card.sprite_facing = 'down'
        else
            ghost_card.facing = 'up'
            ghost_card.sprite_facing = 'up'
        end

        -- 5. Guardamos la copia en la tabla
        table.insert(predictions, ghost_card)
			ghost_card:set_card_area(G.dwjokers_pebble_prediction_area)
			ghost_card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 2*G.SETTINGS.GAMESPEED)
			G.dwjokers_pebble_prediction_area:emplace(ghost_card, nil)
    end

    -- RESTAURACION COMPLETA DE PSEUDORANDOM

	-- Este es importante por si se crearon mas espacios en pseudorandom, no se si ocurre pero mejor prevenir
    for k, _ in pairs(G.GAME.pseudorandom) do G.GAME.pseudorandom[k] = nil end 

    for k, v in pairs(backup_rng) do G.GAME.pseudorandom[k] = v end

    return predictions
end

-- Revisar si una carta es de toon
-- card: carta a revisar, o tabla de valores
-- return: true si es toon, false si no.
function dwjokers_is_toon(card)

	-- caso 1: la funcion se llama para una carta dentro de un center pool
	if card.pools then
		if (card.pools or {}).dwjokers_toons then
			return true
		else
			return false
		end
	end

	-- caso 2: la funcion se llama en una carta fuera de un center pool
	if card.config and card.config.center and card.config.center.pools then
		if (card.config.center.pools or {}).dwjokers_toons then
			return true
		else
			return false
		end
	end				

	-- en cualquier otro caso, false
	return false
end	

-- Aplicar bonus multiplicativo de Bobette
-- card: carta a actualizar el bonus
-- apply: true si se aplicara el bonus, tiene prioridad
-- remove: true si se quitara el bonus
-- return: nada si no hay config o si el bonus no aplica
function dwjokers_apply_bobette_bonus(card, apply, remove)
    if not (card.ability and card.ability.extra) then return end
    
	-- Inicializamos el contador en 0 si no existe
	card.ability.dwjokers_bobette_stacks = card.ability.dwjokers_bobette_stacks or 0
	local power = 0

	if apply then
		power = 1
		card.ability.dwjokers_bobette_stacks = card.ability.dwjokers_bobette_stacks + 1
	elseif remove then
		-- Solo removemos si hay stacks para quitar
		if card.ability.dwjokers_bobette_stacks > 0 then
			power = -1
			card.ability.dwjokers_bobette_stacks = card.ability.dwjokers_bobette_stacks - 1
		else
			return -- No hacemos nada si no tiene stacks
		end
	end 

	-- Usamos el bonus base
	local base_bonus = G.GAME.dwjokers_bobette_bonus or 2 
	local multiplier = base_bonus ^ power

	-- actualizamos las variables mult y chips segun si tienen atributos de mult o chips
	if card:has_attribute('mult') or card:has_attribute('xmult') or 
	card:has_attribute('chips') or card:has_attribute('xchips') then

		-- nos movemos por todas las variables en extra
		for k,v in pairs(card.ability.extra) do

			-- buscamos que las variables tengan los terminos "mult" o "chips"
			if type(k) == "string" and type(v) == "number" and 
			(string.find(k,"mult") or string.find(k,"chips")) then
				card.ability.extra[k] = v * multiplier
			end
		end
	end

end

-- Game over automatico. Obtenido directo de vanilla remade
function dwjokers_lose_run()
	-- Credits to Winter <3
	G.STATE = G.STATES.GAME_OVER
	if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
		G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
	end
	G:save_settings()
	G.FILE_HANDLER.force = true
	G.STATE_COMPLETE = false
end

-- Conteo de consumibles en G.consumeables y en la basket de Bassie
-- return: conteo de consumibles en ambas areas
function dwjokers_consumable_count()
    local count = #G.consumeables.cards
    
    if G.GAME.dwjokers_bassie_exists and G.dwjokers_bassie_basket then
        for _, v in ipairs(G.dwjokers_bassie_basket.cards) do
            -- Asumo que 'card_types' y 'table_contains' están definidos en tu archivo
            if table_contains(v.ability.set, card_types) then
                count = count + 1
            end
        end
    end
    return count
end

-- Aplicar modificacion a hands para Blot, y aplicar game over segun sea necesario
-- card: carta que llama a la funcion
-- amount: cuanto modificaremos las hands
-- return: nada si pierdes la partida
function dwjokers_blot_hand_mod(card, amount)
    if amount == 0 then return end

	if G.GAME.dwjokers_blot_game_over then
		if G.buttons then G.buttons:remove() end
		return
	end

    -- calculamos cuantas hands quedarian
    local expected_hands = G.GAME.current_round.hands_left + amount

	-- si quedaran menos hands que las que tenemos, forzamos un game over
    if expected_hands <= 0 and amount < 0 then
		G.GAME.dwjokers_blot_game_over = true
		G.STATE = G.STATES.GAME_OVER
        
		-- efecto visual instantaneo
        ease_hands_played(-G.GAME.current_round.hands_left, true) 

		-- se establecen en 0
        G.GAME.current_round.hands_left = 0
        G.GAME.round_resets.hands = -1

		-- terminamos la ronda y forzamos que los botones de
		-- "play hand" y "discard" se remuevan
        end_round()
		if G.buttons then G.buttons:remove() end
        return 
    end

    -- Si no es muerte, procedemos normal
	if not G.GAME.dwjokers_blot_game_over then
		G.GAME.round_resets.hands = math.max(0, G.GAME.round_resets.hands + amount)
		ease_hands_played(amount)
	end

end

-- Determinar tasa de aparicion de los toons segun las rarezas y el numero de jokers en cada una
-- return: tasa de aparicion de los toons en la tienda, numero entre 0 y 1
function dwjokers_get_toon_appearance_rate()
	local toon_rate = 0
	local toon_rate_in_shop = 0
	local total_weight = 0

	-- obtenemos lista de todas las rarezas, incluidas las de mods
	-- para que se muestre, debe asignarsele el pool 'Joker' cuando se declara la rareza
	-- si no se muestra aqui, ya no es asunto mio lol
	local rarity_list = SMODS.ObjectTypes['Joker'].rarities

	-- suma de todos los pesos
	for _,rarity in ipairs(rarity_list) do
		total_weight = total_weight + rarity.weight
	end

	-- si el peso es 0 o menos, retornamos 0
	if total_weight <= 0 then return 0 end

	-- numero de jokers en cada rareza
	local total_jokers = {}
	for _,rarity in ipairs(rarity_list) do
		local key = rarity.key

		-- rarezas vanilla, que asco que no puedan llamarse con su key alv
		-- en principio los modders no deberian modificar estas rarezas vanilla
		if key == "Common" then total_jokers[key] = #G.P_JOKER_RARITY_POOLS[1]
		elseif key == "Uncommon" then total_jokers[key] = #G.P_JOKER_RARITY_POOLS[2]
		elseif key == "Rare" then total_jokers[key] = #G.P_JOKER_RARITY_POOLS[3]
		elseif key == "Legendary" then total_jokers[key] = #G.P_JOKER_RARITY_POOLS[4]
		
		-- rarezas mod
		else total_jokers[key] = #G.P_JOKER_RARITY_POOLS[key]
		end
	end

	-- numero de toons en cada rareza, sirve si agrego a mas toons al mod
	local total_toons = {}
	for _,rarity in ipairs(rarity_list) do
		local key = rarity.key

		-- inicializamos conteo
		total_toons[key] = 0

		-- rarezas vanilla
		if key == "Common" then 
			for i=1, total_jokers[key] do 
				if dwjokers_is_toon(G.P_JOKER_RARITY_POOLS[1][i]) then
					total_toons[key] = total_toons[key] + 1
				end
			end
		elseif key == "Uncommon" then
			for i=1, total_jokers[key] do 
				if dwjokers_is_toon(G.P_JOKER_RARITY_POOLS[2][i]) then
					total_toons[key] = total_toons[key] + 1
				end
			end
		elseif key == "Rare" then
			for i=1, total_jokers[key] do 
				if dwjokers_is_toon(G.P_JOKER_RARITY_POOLS[3][i]) then
					total_toons[key] = total_toons[key] + 1
				end
			end
		elseif key == "Legendary" then
			for i=1, total_jokers[key] do 
				if dwjokers_is_toon(G.P_JOKER_RARITY_POOLS[4][i]) then
					total_toons[key] = total_toons[key] + 1
				end
			end

		-- rarezas mod, digo hay un par de toons que tienen rarezas mod, pero
		-- por si alguien quiere agregar otra yo que se
		else
			for i=1, total_jokers[key] do 
				if dwjokers_is_toon(G.P_JOKER_RARITY_POOLS[key][i]) then
					total_toons[key] = total_toons[key] + 1
				end
			end
		end
	end

	-- probabilidad de que el joker escogido sea de toon
	for _,rarity in ipairs(rarity_list) do
		local key = rarity.key
		local weight = rarity.weight

		local aux1 = rarity.weight / total_weight

		local aux2 = total_toons[key] / total_jokers[key]

		toon_rate = toon_rate + (aux1 * aux2)
	end

	-- probabilidad de que el joker escogido, en la tienda, sea de toon
	local total_rate = G.GAME.joker_rate + G.GAME.playing_card_rate
	for _,v in ipairs(SMODS.ConsumableType.obj_buffer) do
		total_rate = total_rate + G.GAME[v:lower()..'_rate']
	end

	local aux = G.GAME.joker_rate / total_rate
	toon_rate_shop = aux * toon_rate

	return toon_rate_shop
end

-- Cambiar rarezas de toons
-- apply: true si se disminuiran las rarezas, tiene prioridad.
-- reset: true si se devolveran las rarezas a sus valores originales
-- return: nada si se ha aplicado o removido el cambio de rarezas
function dwjokers_rarity_change(apply, reset)

	if apply then
		-- Uncommon -> Common
		for k = #G.P_JOKER_RARITY_POOLS[2], 1, -1 do
			local v = G.P_JOKER_RARITY_POOLS[2][k]
			if dwjokers_is_toon(v) then
				v.rarity = 1
				v.dwjokers_original_rarity = 2
				table.remove(G.P_JOKER_RARITY_POOLS[2], k)
				table.insert(G.P_JOKER_RARITY_POOLS[1], v)
			end
		end

		-- Rare -> Uncommon
		for k = #G.P_JOKER_RARITY_POOLS[3], 1, -1 do
			local v = G.P_JOKER_RARITY_POOLS[3][k]
			if dwjokers_is_toon(v) then
				v.rarity = 2
				v.dwjokers_original_rarity = 3
				table.remove(G.P_JOKER_RARITY_POOLS[3], k)
				table.insert(G.P_JOKER_RARITY_POOLS[2], v)
			end
		end

		-- Main -> Rare
		for k = #G.P_JOKER_RARITY_POOLS["dwjokers_Main"], 1, -1 do
			local v = G.P_JOKER_RARITY_POOLS["dwjokers_Main"][k]
			if dwjokers_is_toon(v) then
				v.rarity = 3
				v.dwjokers_original_rarity = "dwjokers_Main"
				table.remove(G.P_JOKER_RARITY_POOLS["dwjokers_Main"], k)
				table.insert(G.P_JOKER_RARITY_POOLS[3], v)
			end
		end

		return
	end

	if reset then
		for _,v in ipairs(G.P_CENTER_POOLS.Joker) do
			if v.dwjokers_original_rarity then
				
				local pool = G.P_JOKER_RARITY_POOLS[v.rarity]

				-- buscar el joker dentro de su pool real
				for i = #pool, 1, -1 do
					if pool[i] == v then
						table.remove(pool, i)
						break
					end
				end

				-- restaurar
				table.insert(G.P_JOKER_RARITY_POOLS[v.dwjokers_original_rarity], v)
				v.rarity = v.dwjokers_original_rarity
				v.dwjokers_original_rarity = nil
			end
		end

		return
	end

end

-- Funcion highlight que no dibuja botones de USE ni SELL
-- Card: carta que llamo a la funcion
-- is_highlighted: si la carta esta seleccionada o no
function Card:highlight_custom(is_higlighted)
    self.highlighted = is_higlighted
    if self.ability.consumeable or self.ability.set == 'Joker' or (self.area and self.area == G.pack_cards) then
        if self.highlighted and self.area and self.area.config.type ~= 'shop' then
        elseif self.children.use_button then
            self.children.use_button:remove()
            self.children.use_button = nil
        end
    end
    if self.ability.consumeable or self.ability.set == 'Joker' then
        if not self.highlighted and self.area and self.area.config.type == 'joker' and
            (#G.jokers.cards >= G.jokers.config.card_limit or (self.edition and self.edition.negative)) then
                if G.shop_jokers then G.shop_jokers:unhighlight_all() end
        end
    end
end


------------ UI PARA LA BASKET DE BASSIE ---------------

-- GUARDAR EN LA BASKET DE BASSIE
G.FUNCS.dwjokers_save_button = function(e)
	local card = e.config.ref_table -- access the card this button was on
	local area = card.area
	card.original_area = area -- guardamos cardarea original, aqui se devolvera la carta
	
	-- removemos carta del area original y la asignamos a la basket de bassie
	if card.config.center.key ~= "j_dwjokers_Bassie" then
		if #G.dwjokers_bassie_basket.cards < G.dwjokers_bassie_basket.config.card_limit then
			area:remove_card(card)
			area:remove_from_highlighted(card)
			card:set_card_area(G.dwjokers_bassie_basket)
			card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 2*G.SETTINGS.GAMESPEED)
			G.dwjokers_bassie_basket:emplace(card)
			card.ability.dwjokers_in_basket = true

			SMODS.calculate_context({ 
				dwjokers_basket_modified = true, 
				dwjokers_basket_card = card,
			})

		else
			-- si no hay espacio en la basket
			SMODS.calculate_effect({ message = "BASKET FULL!" }, card)
		end
	else
		-- si de alguna forma intentas guardar a Bassie, activamos un mensajito
		SMODS.calculate_effect({ message = "I CANT SAVE MYSELF!" }, card)
	end
end

-- RECUPERAR DE LA BASKET DE BASSIE
G.FUNCS.dwjokers_retrieve_button = function(e)
	local card = e.config.ref_table -- access the card this button was on
	local area = {}
	local set = card.ability.set
	local area2 = card.area

	-- asignamos el area a la que mandaremos la carta
	if G.STATES.SMODS_BOOSTER_OPENED == G.STATE and (set == "Default" or set == "Enhanced") then
		area = G.hand
	elseif card.original_area and not (not G.GAME.blind.in_blind and card.original_area == G.hand) then
		area = card.original_area
	elseif (set == "Default" or set == "Enhanced") then
		area = G.deck
	elseif set == "Joker" then
		area = G.jokers
	elseif set == "Tarot" or set == "Planet" or set == "Spectral" then
		area = G.consumeables
	end

	-- usamos bassie_flag para identificar carta original en la basket de bassie
	-- verificamos que el area al que se enviara la carta tenga espacio
	if #area.cards < area.config.card_limit or area == G.hand then	
		for _, v in ipairs(G.dwjokers_bassie_basket.cards) do
			if v.ability.bassie_flag == card.ability.bassie_flag then
				G.dwjokers_bassie_basket:remove_card(v)
				G.dwjokers_bassie_basket:remove_from_highlighted(v)
				v:set_card_area(area)
				v:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 2*G.SETTINGS.GAMESPEED)
				area:emplace(v, nil)
				v.ability.dwjokers_in_basket = false -- quitamos que la carta este en la basket
				break
			end
		end
		
		-- si de alguna forma usaste retrieve en la carta original, no la destruye
		if area2 ~= G.dwjokers_bassie_basket then
			card:start_dissolve()
		end

		SMODS.calculate_context({ 
				dwjokers_basket_modified = true, 
				dwjokers_basket_card = card,
			})

	else
		-- si no hay espacio en el area original, mostramos un mensajito
		SMODS.calculate_effect({ message = "NOT ENOUGH SPACE!" }, card)
	end
end

-- CREAR LA BASKET CON BASSIE
G.FUNCS.dwjokers_basket_button = function(e)

  G.FUNCS.overlay_menu{
    definition = G.UIDEF.dwjokers_bassie_uibox(),
	pause = false
  }
end

-- BOTONES CREADOS POR BASSIE
-- card: carta que llamo a la funcion
-- button.func: funcion que llamara el boton creado (las 3 opciones arriba)
-- button.text: texto del boton (decorativo, "SAVE", "RETRIEVE" y "BASKET")
-- return: UIBox del boton personalizado
function dwjokers_create_bassie_button_ui(card, button)
    -- 1. Verdad si la carta es una jugable y esta en la mano, o esta en la basket de bassie
    local is_in_hand_playing_card = ((card.config.center.set == 'Default' or card.config.center.set == 'Enhanced') 
                                    and (card.area == G.hand)) or card.ability.dwjokers_in_basket

    -- 2. Definimos align dependiendo de la ubicacion de la carta
	-- si la condicion de arriba es verdad, el boton se dibuja arriba
	-- en cualquier otro caso se dibuja abajo
    local target_align = is_in_hand_playing_card and 'tm' or 'bm'


    return UIBox({
        definition = {
            n = G.UIT.ROOT,
            config = {
                colour = G.C.CLEAR
            },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        align = target_align, -- Dinámico
                        padding = 0.15,
                        r = 0.08,
                        hover = true,
                        shadow = true,
                        colour = G.C.CHIPS,
                        button = button.func,
                        ref_table = card,
                    },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm" },
                            nodes = {
                                -- espaciador
                                { n = G.UIT.R, config = { align = "cm", minh = 0.1 }, nodes = {} },
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = button.text,
                                        colour = G.C.UI.TEXT_LIGHT,
                                        scale = 0.4,
                                    }
                                }
                            }
                        }
                    }
                }
            }
        },
        config = {
            align = target_align, -- Dinámico
            major = card,
            parent = card,
            offset = { x = 0.0, y = 0 }
        }
    })
end

-- drawstep for my_button
SMODS.DrawStep {
  key = 'my_button',
  order = -30, -- before the Card is drawn
  func = function(card, layer)
    if card.children.dwjokers_my_button then
      card.children.dwjokers_my_button:draw()
    end
  end
}

-- make sure SMODS doesn't draw the button after the card is drawn
SMODS.draw_ignore_keys.dwjokers_my_button = true

-- CREAR UI BASE DE LA BASKET DE BASSIE
-- return: menu generico de opciones (da un boton de back muy util)
function G.UIDEF.dwjokers_bassie_uibox()
  return create_UIBox_generic_options({contents ={create_tabs(
    {colour = HEX("B97EDB"),
		tabs = {
          {
            label = "BASSIE BASKET",
            chosen = true,
			tab_definition_function = G.UIDEF.dwjokers_bassie_uibox_tab_definition
		  }
    },
    tab_h = 4,
    snap_to_nav = true})}})
end

-- CREAR INTERIOR DE LA BASKET DE BASSIE
-- return: nodos con un cardarea que copia la basket de bassie para renderizar
function G.UIDEF.dwjokers_bassie_uibox_tab_definition()
    local display_node = {}

    -- 1. Verificamos si hay cartas en la cesta
    if #G.dwjokers_bassie_basket.cards > 0 then
    
        local cardarea = CardArea(
            2, 2,
            math.min(2 * #G.dwjokers_bassie_basket.cards, 8 * G.CARD_W),
            0.75 * G.CARD_H, 
            {card_limit = #G.dwjokers_bassie_basket.cards, type = 'joker'}
        )

        for i = 1, #G.dwjokers_bassie_basket.cards do
            local basket_card = G.dwjokers_bassie_basket.cards[i]
            basket_card.ability.bassie_flag = i
            local new_card = copy_card(basket_card, nil, nil, basket_card.playing_card)
            new_card.ability.bassie_flag = i
            new_card.original_area = basket_card.original_area
            cardarea:emplace(new_card)
        end

        -- Guardamos el objeto CardArea en el nodo
        display_node = {n=G.UIT.O, config={object = cardarea}}
    else
        
        display_node = { n=G.UIT.R, config={align = "cm", padding = 0.5}, nodes={
                { n=G.UIT.T, config={ text = "Just doing my part!", 
				colour = G.C.UI.TEXT_LIGHT, scale = 0.4 }
                }
            }
        }
    end

    -- 2. Retornamos la UI usando el display_node que definimos arriba
    return {
        n=G.UIT.ROOT, 
        config={align = "cm", minw = 15, padding = 0.1, r = 0.1, colour = G.C.CLEAR}, nodes={
            {
                n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR, r = 0.1, minh = 2}, nodes={
                    { n=G.UIT.C, config={align = "cm"}, nodes={
                            display_node
                        }
                    }
                }
            }
        }
    }
end


------------ UI PARA EL SUPER MENU DE VEE ---------------

-- CREAR EL MENU CON VEE
G.FUNCS.dwjokers_vee_menu_button = function(e)
    -- Guardamos la referencia de la carta que estamos editando
    G.GAME.dwjokers_editing_vee = e.config.ref_table 
    
    G.FUNCS.overlay_menu{
        definition = G.UIDEF.dwjokers_vee_uibox(),
    }
end

-- CAMBIAR DE VEE
G.FUNCS.dwjokers_change_vee = function(e)

	-- Deseleccionamos la vee actual
	G.GAME.dwjokers_editing_vee:click() 

	-- Actualizamos la carta de vee que estamos editando
	local option = e.cycle_config.current_option
	local vees = SMODS.find_card('j_dwjokers_Vee')
	G.GAME.dwjokers_editing_vee = vees[option]
	G.GAME.dwjokers_editing_vee:click() 

	-- Actualizamos el menu
	local tab_button = G.OVERLAY_MENU:get_UIE_by_ID("tab_but_VEE'S SUPER MENU")
	if tab_button then
        G.FUNCS.change_tab(tab_button)
    end
end

-- APLICAR CONFIGURACION A TODAS LAS VEES
G.FUNCS.dwjokers_vee_apply_to_all = function(e)

	-- Obtenemos la vee seleccionada
	local vee_card = G.GAME.dwjokers_editing_vee
	local vee_key = vee_card.ability.dwjokers_vee_key

	-- Obtenemos sus opciones
	local options = G.GAME.dwjokers_vee_table[vee_key]

	-- Aplicamos las opciones a todas las demas vees
	for k, v in pairs(G.GAME.dwjokers_vee_table) do
		if k ~= vee_key then 
			G.GAME.dwjokers_vee_table[k] = options
		end
	end

end



-- BOTONES CREADOS POR VEE
-- card: carta que llamo a la funcion
-- return: UIBox del boton de super menu de vee
function dwjokers_create_vee_button_ui(card)
  return UIBox({
    definition = {
      n = G.UIT.ROOT,
      config = {
        colour = G.C.CLEAR
      },
      nodes = {
        {
          n = G.UIT.C,
          config = {
            align = 'cm',
            padding = 0.15,
            r = 0.08,
            hover = true,
            shadow = true,
            colour = G.C.SUITS.Clubs, -- color of the button background
            button = 'dwjokers_vee_menu_button', -- function in G.FUNCS that will run when this button is clicked
            ref_table = card,
          },
          nodes = {
            {
              n = G.UIT.R,
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = "SUPER MENU",
                    colour = G.C.UI.TEXT_LIGHT, -- color of the button text,
                    scale = 0.4,
                  }
                },
                {
                  n = G.UIT.B,
                  config = {
                    w = 0.1,
                    h = 0.4
                  }
                }
              }
            }
          }
        }
      }
    },
    config = {
      align = 'bm', -- position relative to the card, meaning "center left". Follow the SMODS UI guide for more alignment options
      major = card,
      parent = card,
      offset = { x = 0.2, y = 0 } -- depends on the alignment you want, without an offset the button will look as if floating next to the card, instead of behind it
    }
  })
end

-- drawstep for my_button_2
SMODS.DrawStep {
  key = 'my_button_2',
  order = 100, -- before the Card is drawn
  func = function(card, layer)
    if card.children.dwjokers_my_button_2 then
      card.children.dwjokers_my_button_2:draw()
    end
  end
}

-- make sure SMODS doesn't draw the button after the card is drawn
SMODS.draw_ignore_keys.dwjokers_my_button_2 = true

-- CREAR UI BASE DEL MENU DE VEE
-- return: menu generico de opciones (da un boton de back muy util)
function G.UIDEF.dwjokers_vee_uibox()
  return create_UIBox_generic_options({
    colour = HEX("041400"), 
    outline_colour = HEX("25B800"),
    contents ={create_tabs({
        colour = HEX("25B800"),
        tabs = {
            -- Super menu ajua
            {
                label = "VEE'S SUPER MENU",
                chosen = true,
                tab_definition_function = G.UIDEF.dwjokers_vee_uibox_tab_definition
            },
            -- Stats
            {
                label = "CURRENT BONUSES",
                chosen = false,
                tab_definition_function = G.UIDEF.dwjokers_vee_stats_tab_definition
            },
			-- Total stats
            {
                label = "TOTAL BONUSES",
                chosen = false,
                tab_definition_function = G.UIDEF.dwjokers_vee_total_stats_tab_definition
            }
        },
        tab_h = 4,
        scale = 1.5, -- Ajusté un poco la escala, 2 a veces es muy grande para dos pestañas
        snap_to_nav = true
    })}
  })
end

-- CREAR INTERIOR DEL SUPER MENU DE VEE
-- return: nodos con el super menu de Vee, una tortura de nodear pues JAJ muchos nodos arre
function G.UIDEF.dwjokers_vee_uibox_tab_definition()

	-- llamamos a la referencia de la vee seleccionada
	local vee_card = G.GAME.dwjokers_editing_vee
	local vee_key = vee_card.ability.dwjokers_vee_key

    -- Función auxiliar para no repetir código y envolver cada toggle en una fila
    local function wrap_toggle(args)
        return {n=G.UIT.R, config={align = "lc", padding = 0.05}, nodes={
            create_toggle(args)
        }}
    end

    -- Primer columna
    local col_1 = {
        wrap_toggle({label = "+1 Hands", ref_table = G.GAME.dwjokers_vee_table[vee_key], ref_value = "dwjokers_vee_hands", active_colour = HEX("25B800"), inactive_colour = HEX("041400")}), 
        wrap_toggle({label = "+1 Discards", ref_table = G.GAME.dwjokers_vee_table[vee_key], ref_value = "dwjokers_vee_discards", active_colour = HEX("25B800"), inactive_colour = HEX("041400")}), 
        wrap_toggle({label = "+1 Hand size", ref_table = G.GAME.dwjokers_vee_table[vee_key], ref_value = "dwjokers_vee_handsize", active_colour = HEX("25B800"), inactive_colour = HEX("041400")})
    }

    -- Segunda columna
    local col_2 = {
        wrap_toggle({label = "+1 Joker spaces", ref_table = G.GAME.dwjokers_vee_table[vee_key], ref_value = "dwjokers_vee_jokers", active_colour = HEX("25B800"), inactive_colour = HEX("041400")}), 
        wrap_toggle({label = "+1 Consumable spaces", ref_table = G.GAME.dwjokers_vee_table[vee_key], ref_value = "dwjokers_vee_consumables", active_colour = HEX("25B800"), inactive_colour = HEX("041400")})
    }

    -- Tercer columna
    local col_3 = {
        wrap_toggle({label = "+1 card slot in shop", ref_table = G.GAME.dwjokers_vee_table[vee_key], ref_value = "dwjokers_vee_cardslots", active_colour = HEX("25B800"), inactive_colour = HEX("041400")}), 
        wrap_toggle({label = "+1 voucher slots in shop", ref_table = G.GAME.dwjokers_vee_table[vee_key], ref_value = "dwjokers_vee_vouchers", active_colour = HEX("25B800"), inactive_colour = HEX("041400")}),
        wrap_toggle({label = "+1 booster pack slots in shop", ref_table = G.GAME.dwjokers_vee_table[vee_key], ref_value = "dwjokers_vee_boosters", active_colour = HEX("25B800"), inactive_colour = HEX("041400")})
    }
	
	-- Tabla de nodos
	local nodes = {
        {n=G.UIT.R, config={align = "tm", colour = G.C.CLEAR}, nodes={
            {n=G.UIT.C, config={align = "lc", minw = 5, padding = 0.2}, nodes = col_1},
            {n=G.UIT.C, config={align = "lc", minw = 5, padding = 0.2}, nodes = col_2},
            {n=G.UIT.C, config={align = "lc", minw = 5, padding = 0.2}, nodes = col_3}
        }},
    }

	-- En caso de tener varias Vees, mostrare una opcion para desplazarse entre Vees rapidamente
	-- y otra para aplicar la configuracion de la vee actual a todas las demas
	local vees = SMODS.find_card('j_dwjokers_Vee')
	local joker_options = {}
	local current_vee_index = 1
	if #vees > 1 then
		for i = 1, #vees do
			if vee_card == vees[i] then
				current_vee_index = i
			end
			table.insert(joker_options, 'Vee '..tostring(i)..'/'..#vees)
		end

		-- Insertamos una fila
		local option_cycle = {n=G.UIT.R, config={align = "cm"}, nodes={
          create_option_cycle({options = joker_options, w = 4.5, cycle_shoulders = true, opt_callback = 'dwjokers_change_vee', current_option = current_vee_index, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}}),
		  UIBox_button({
			label = {"Apply to","all Vee's"}, button = 'dwjokers_vee_apply_to_all', minw = 1.7, minh = 0.4, scale = 0.35
		  })
        }}
		table.insert(nodes, option_cycle)
	end

    return {n=G.UIT.ROOT, config={align = "tl", minw = 15, padding = 0.1, colour = G.C.CLEAR}, nodes = nodes}
end

-- CREAR TAB DE STATS DEL SUPER MENU DE VEE
-- return: nodos con stats de los bonus ya aplicados. SI EL ANTERIOR FUE TORTURA ESTE MAS JAJAJAAJ
function G.UIDEF.dwjokers_vee_stats_tab_definition()
    local card = G.GAME.dwjokers_editing_vee
    local nodes = {}
    
    -- Si por alguna razón la carta no existe, mostramos error (seguridad)
    if not card or not card.ability or not card.ability.extra then
        return {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.T, config={text = "Error: Vee not found", scale = 0.5, colour = G.C.RED}}}}
    end

    local upgrades = card.ability.extra.total_upgrades or {}
    
    -- Mapeo para nombres bonitos en la UI
    local display_names = {
        hands = "Hands",
        discards = "Discards",
        hand_size = "Hand Size",
        jokers = "Joker Slots",
        consumables = "Consumable Slots",
        cardslots = "Shop Card Slots",
        vouchers = "Shop Voucher Slots",
        boosters = "Booster Pack Slots"
    }

    local found_any = false

    -- Iteramos por los upgrades y creamos una fila para cada uno que sea > 0
    for k, v in pairs(upgrades) do
        if v > 0 then
            found_any = true
            local name = display_names[k] or k -- Usamos el nombre bonito o la llave si falla
            
            table.insert(nodes, {
                n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
                    {n=G.UIT.C, config={align = "cr", minw = 2.5}, nodes={
                        {n=G.UIT.T, config={text = name..": ", scale = 0.45, colour = G.C.UI.TEXT_LIGHT}}
                    }},
                    {n=G.UIT.C, config={align = "cl", minw = 1}, nodes={
                        {n=G.UIT.T, config={text = "+"..v, scale = 0.45, colour = G.C.GREEN}}
                    }}
                }
            })
        end
    end

    -- Si no tiene mejoras, mostramos un mensaje
    if not found_any then
        table.insert(nodes, {
            n=G.UIT.R, config={align = "cm", padding = 0.2}, nodes={
                {n=G.UIT.T, config={text = "Ahem. . . is it working?", scale = 0.4, colour = G.C.UI.TEXT_INACTIVE}}
            }
        })
    end

    -- Retornamos la estructura completa
    return {n=G.UIT.ROOT, config={align = "cm", minw = 6, padding = 0.1, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes = nodes}
    }}
end

-- CREAR TAB DE BONUS TOTALES DEL SUPER MENU DE VEE
-- return: nodos con stats de TODOS los bonus aplicados por todas las vees, en caso de tener mas de una
function G.UIDEF.dwjokers_vee_total_stats_tab_definition()

	-- tabla de Vees
	local vees = SMODS.find_card('j_dwjokers_Vee')
    local nodes = {}
    
    -- Si por alguna razón no existen vees, mostramos error (seguridad)
    if not vees then
        return {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.T, config={text = "Error: Vee's not found", scale = 0.5, colour = G.C.RED}}}}
    end

	local upgrades = {}
	-- vamos sumando los upgrades
	for k,v in ipairs(vees) do
		local v_upgrades = v.ability.extra.total_upgrades 

		for i,j in pairs(v_upgrades) do
			upgrades[i] = (upgrades[i] or 0) + j
		end

	end
    
    -- Mapeo para nombres bonitos en la UI
    local display_names = {
        hands = "Hands",
        discards = "Discards",
        hand_size = "Hand Size",
        jokers = "Joker Slots",
        consumables = "Consumable Slots",
        cardslots = "Shop Card Slots",
        vouchers = "Shop Voucher Slots",
        boosters = "Booster Pack Slots"
    }

    local found_any = false

    -- Iteramos por los upgrades y creamos una fila para cada uno que sea > 0
    for k, v in pairs(upgrades) do
        if v > 0 then
            found_any = true
            local name = display_names[k] or k -- Usamos el nombre bonito o la llave si falla
            
            table.insert(nodes, {
                n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
                    {n=G.UIT.C, config={align = "cr", minw = 2.5}, nodes={
                        {n=G.UIT.T, config={text = name..": ", scale = 0.45, colour = G.C.UI.TEXT_LIGHT}}
                    }},
                    {n=G.UIT.C, config={align = "cl", minw = 1}, nodes={
                        {n=G.UIT.T, config={text = "+"..v, scale = 0.45, colour = G.C.GREEN}}
                    }}
                }
            })
        end
    end

    -- Si no tiene mejoras, mostramos un mensaje
    if not found_any then
        table.insert(nodes, {
            n=G.UIT.R, config={align = "cm", padding = 0.2}, nodes={
                {n=G.UIT.T, config={text = "Ahem. . . is it working?", scale = 0.4, colour = G.C.UI.TEXT_INACTIVE}}
            }
        })
    end

    -- Retornamos la estructura completa
    return {n=G.UIT.ROOT, config={align = "cm", minw = 6, padding = 0.1, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes = nodes}
    }}
end

-- APLICAR BONUS DEL SUPER MENU DE VEE
-- card: carta que llamo a la funcion
-- mode: "apply" para aplicar bonus, "remove" para remover todos los bonus, 
-- 		 "re-apply" para aplicar bonus en caso de copia. (default: "apply")
-- return: nada si card no es Vee
function dwjokers_vee_bonus(card, mode)

    -- 1. Solo aplica si la carta es Vee
    if card.config.center.key ~= "j_dwjokers_Vee" then return end

    mode = mode or "apply"
    local extra = card.ability.extra
    local upgrades = extra.upgrades or 1

    -- 2. Definimos las acciones 
    local actions = {
        dwjokers_vee_hands = {
            func = function(amt) 
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + amt
                ease_hands_played(amt)
            end,
            stat = "hands", msg = "Hands"
        },
        dwjokers_vee_discards = {
            func = function(amt) 
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + amt
                ease_discard(amt)
            end,
            stat = "discards", msg = "Discards"
        },
        dwjokers_vee_handsize = {
            func = function(amt) G.hand:change_size(amt) end,
            stat = "hand_size", msg = "Hand Size"
        },
        dwjokers_vee_jokers = {
            func = function(amt) G.jokers:change_size(amt) end,
            stat = "jokers", msg = "Joker Slots"
        },
        dwjokers_vee_consumables = {
            func = function(amt) G.consumeables:change_size(amt) end,
            stat = "consumables", msg = "Consumable Slots"
        },
        dwjokers_vee_cardslots = {
            func = function(amt) change_shop_size(amt) end,
            stat = "cardslots", msg = "Shop Slots"
        },
        dwjokers_vee_boosters = {
            func = function(amt) SMODS.change_booster_limit(amt) end,
            stat = "boosters", msg = "Booster Slots"
        },
        dwjokers_vee_vouchers = {
            func = function(amt) SMODS.change_voucher_limit(amt) end,
            stat = "vouchers", msg = "Voucher Slots"
        }
    }

    if mode == "apply" then
        -- LOGICA DE APLICAR (Uno al azar)
        local vee_keys = {"dwjokers_vee_hands", "dwjokers_vee_discards", "dwjokers_vee_handsize", "dwjokers_vee_jokers", "dwjokers_vee_consumables", "dwjokers_vee_cardslots", "dwjokers_vee_vouchers", "dwjokers_vee_boosters"}
        local vee_active_settings = {}
        local vee_key_key = card.ability.dwjokers_vee_key -- no se me ocurrio un mejor nombre :sob:
		for _, key in ipairs(vee_keys) do
            if G.GAME.dwjokers_vee_table[vee_key_key][key] then table.insert(vee_active_settings, key) end
        end

        local chosen_key = pseudorandom_element(vee_active_settings, 'dwjokers_vee') 

        local action = actions[chosen_key]
        if action then
            action.func(upgrades)
            extra.total_upgrades[action.stat] = (extra.total_upgrades[action.stat] or 0) + upgrades
            SMODS.calculate_effect({ message = "+" .. upgrades .. " " .. action.msg .. "!", colour = G.C.GREEN }, card)
        end

    elseif mode == "remove" then
        -- LOGICA DE REMOVER (Todo lo acumulado)
        for _, action in pairs(actions) do
            local total = extra.total_upgrades[action.stat] or 0
            if total > 0 then
                action.func(-total)
				SMODS.calculate_effect({ message = "-" .. total .. " " .. action.msg .. "!", colour = G.C.RED }, card)
            end
        end

    elseif mode == "re-apply" then
        -- NUEVA LOGICA: RE-APLICAR (Para copias)
        local applied_any = false
        for _, action in pairs(actions) do
            local total = extra.total_upgrades[action.stat] or 0
            if total > 0 then
                action.func(total)
                applied_any = true
            end
        end
        if applied_any then
            SMODS.calculate_effect({ message = "Reapplied!", colour = G.C.BLUE }, card)
        end
    end
end


------------ UI PARA LAS PREDICCIONES DE COAL ---------------

-- CALCULAR PREDICCIONES DE BOOSTER PACKS AL PRESIONAR EL BOTON DE COAL
G.FUNCS.dwjokers_coal_predictions = function()
	if not G.shop_booster then return end
	G.dwjokers_coal_prediction_area.cards = {}
	G.GAME.dwjokers_predicted_cards = {}
	for i=1, #G.shop_booster.cards do
		G.GAME.dwjokers_predicted_cards[i] = G.shop_booster.cards[i]:simulate_open(G.dwjokers_coal_prediction_area)
	end
end	

-- CREAR EL MENU DE COAL
G.FUNCS.dwjokers_coal_button = function(e)

	-- Calculamos las predicciones al presionar el boton
	G.FUNCS.dwjokers_coal_predictions()

	G.FUNCS.overlay_menu{
		definition = G.UIDEF.dwjokers_coal_uibox(),
		pause = false,
		no_esc = true
	}
end

-- BOTON DE COAL
-- card: carta que llamo a la funcion
-- return: UIBox del menu de predicciones de coal
function dwjokers_create_coal_button_ui(card)
  return UIBox({
    definition = {
      n = G.UIT.ROOT,
      config = {
        colour = G.C.CLEAR
      },
      nodes = {
        {
          n = G.UIT.C,
          config = {
            align = 'cm',
            padding = 0.15,
            r = 0.08,
            hover = true,
            shadow = true,
            colour = G.C.BLACK, -- color of the button background
            button = 'dwjokers_coal_button', -- function in G.FUNCS that will run when this button is clicked
            ref_table = card,
          },
          nodes = {
            {
              n = G.UIT.R,
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = "PREDICTIONS",
                    colour = G.C.UI.TEXT_LIGHT, -- color of the button text,
                    scale = 0.4,
                  }
                },
                {
                  n = G.UIT.B,
                  config = {
                    w = 0.1,
                    h = 0.4
                  }
                }
              }
            }
          }
        }
      }
    },
    config = {
      align = 'bm', -- position relative to the card, meaning "center left". Follow the SMODS UI guide for more alignment options
      major = card,
      parent = card,
      offset = { x = 0.2, y = 0 } -- depends on the alignment you want, without an offset the button will look as if floating next to the card, instead of behind it
    }
  })
end

-- drawstep for my_button_3
SMODS.DrawStep {
  key = 'my_button_3',
  order = -30, -- before the Card is drawn
  func = function(card, layer)
    if card.children.dwjokers_my_button_3 then
      card.children.dwjokers_my_button_3:draw()
    end
  end
}

-- make sure SMODS doesn't draw the button after the card is drawn
SMODS.draw_ignore_keys.dwjokers_my_button_3 = true

-- CREAR UI BASE DEL MENU DE COAL
-- return: menu generico de opciones (da un boton de back muy util)
function G.UIDEF.dwjokers_coal_uibox()
  return create_UIBox_generic_options({contents ={create_tabs(
    {colour = G.C.BLACK,
		tabs = {
          {
            label = "COAL PREDICTIONS",
            chosen = true,
			tab_definition_function = G.UIDEF.dwjokers_coal_uibox_tab_definition
		  }
    },
    tab_h = 4,
    snap_to_nav = true})}})
end

-- CREAR INTERIOR DEL MENU DE COAL
-- return: nodos con un cardarea para booster packs y otra para las cartas predichas
function G.UIDEF.dwjokers_coal_uibox_tab_definition()
    local main_nodes = {}

    -- 1. Verificamos si hay paquetes en la tienda
    if #G.shop_booster.cards > 0 then
        
        local cardarea_boosters = CardArea(
            2, 2,
            math.min(2 * #G.shop_booster.cards, 8 * G.CARD_W),
            0.75 * G.CARD_H, 
            {card_limit = #G.shop_booster.cards, type = 'joker'}
        )

        local max_size = 0 
        for _, booster in ipairs(G.shop_booster.cards) do
            local booster_obj = booster.config.center
            local _size = math.max(1, (booster.ability.extra or 0) + (G.GAME.modifiers.booster_size_mod or 0))
            if booster_obj.config and booster_obj.config.extra then
                _size = math.max(1, booster_obj.config.extra + (G.GAME.modifiers.booster_size_mod or 0))
            end
            if _size > max_size then max_size = _size end 
        end

        local cardarea_predictions = CardArea(
            2, 2,
            math.min(2 * max_size, 8 * G.CARD_W),
            0.75 * G.CARD_H, 
            {card_limit = max_size, type = 'joker'}
        )

        for i = 1, #G.shop_booster.cards do
            G.shop_booster.cards[i].coal_flag = i
            local new_card = copy_card(G.shop_booster.cards[i], nil, nil, G.shop_booster.cards[i].playing_card)
            cardarea_boosters:emplace(new_card)
            new_card.dwjokers_coal_to_area = cardarea_predictions
            new_card.coal_flag = i
        end

        -- Definimos los nodos con las áreas
        main_nodes = {
            {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.O, config={object = cardarea_boosters}}}},
            {n=G.UIT.R, config={align = "cm", minh = 0.4}, nodes={}},
            {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.O, config={object = cardarea_predictions}}}}
        }
    else
        
        main_nodes = {
            {n=G.UIT.R, config={align = "cm", padding = 0.5, minh = 2}, nodes={
                {
                    n=G.UIT.T, 
                    config={
                        text = "Bworf.", 
                        colour = G.C.UI.TEXT_LIGHT, 
                        scale = 0.5, 
                        shadow = true
                    }
                }
            }}
        }
    end

    -- 2. Retornamos la estructura raíz
    return {
        n=G.UIT.ROOT, 
        config={align = "cm", minw = 15, padding = 0.1, r = 0.1, colour = G.C.CLEAR}, 
        nodes={
            {
                n=G.UIT.C, 
                config={align = "cm", padding = 0.2}, 
                nodes = main_nodes
            }
        }
    }
end


------------ UI PARA LAS PREDICCIONES DE PEBBLE ---------------

-- CALCULAR PREDICCIONES DE BOOSTER PACKS AL PRESIONAR EL BOTON DE PEBBLE
G.FUNCS.dwjokers_pebble_predictions = function()
	G.dwjokers_pebble_prediction_area.cards = {}
	G.GAME.dwjokers_pebble_predicted_cards = {}
	
	G.GAME.dwjokers_pebble_predicted_cards = get_pebble_predictions(G.GAME.dwjokers_pebble_cards_to_predict)
end	

-- CREAR EL MENU DE PEBBLE
G.FUNCS.dwjokers_pebble_button = function(e)

	-- Calculamos las predicciones al presionar el boton
	G.FUNCS.dwjokers_pebble_predictions()

	G.FUNCS.overlay_menu{
		definition = G.UIDEF.dwjokers_pebble_uibox(),
		pause = false
	}
end

-- BOTON DE PEBBLE
-- card: carta que llamo a la funcion
-- return: UIBox del menu de predicciones de coal
function dwjokers_create_pebble_button_ui(card)
  return UIBox({
    definition = {
      n = G.UIT.ROOT,
      config = {
        colour = G.C.CLEAR
      },
      nodes = {
        {
          n = G.UIT.C,
          config = {
            align = 'cm',
            padding = 0.15,
            r = 0.08,
            hover = true,
            shadow = true,
            colour = G.C.BLACK, -- color of the button background
            button = 'dwjokers_pebble_button', -- function in G.FUNCS that will run when this button is clicked
            ref_table = card,
          },
          nodes = {
            {
              n = G.UIT.R,
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = "PREDICTIONS",
                    colour = G.C.UI.TEXT_LIGHT, -- color of the button text,
                    scale = 0.4,
                  }
                },
                {
                  n = G.UIT.B,
                  config = {
                    w = 0.1,
                    h = 0.4
                  }
                }
              }
            }
          }
        }
      }
    },
    config = {
      align = 'bm', -- position relative to the card, meaning "center left". Follow the SMODS UI guide for more alignment options
      major = card,
      parent = card,
      offset = { x = 0.2, y = 0 } -- depends on the alignment you want, without an offset the button will look as if floating next to the card, instead of behind it
    }
  })
end

-- drawstep for my_button_4
SMODS.DrawStep {
  key = 'my_button_4',
  order = -30, -- before the Card is drawn
  func = function(card, layer)
    if card.children.dwjokers_my_button_4 then
      card.children.dwjokers_my_button_4:draw()
    end
  end
}

-- make sure SMODS doesn't draw the button after the card is drawn
SMODS.draw_ignore_keys.dwjokers_my_button_4 = true

-- CREAR UI BASE DEL MENU DE COAL
-- return: menu generico de opciones (da un boton de back muy util)
function G.UIDEF.dwjokers_pebble_uibox()
  return create_UIBox_generic_options({contents ={create_tabs(
    {colour = G.C.BLACK,
		tabs = {
          {
            label = "PEBBLE PREDICTIONS",
            chosen = true,
			tab_definition_function = G.UIDEF.dwjokers_pebble_uibox_tab_definition
		  }
    },
    tab_h = 4,
    snap_to_nav = true})}})
end

-- CREAR INTERIOR DEL MENU DE COAL
-- return: nodos con un cardarea para booster packs y otra para las cartas predichas
function G.UIDEF.dwjokers_pebble_uibox_tab_definition()
    local main_nodes = {}

    -- 1. Verificamos si quedan cartas en el deck
    if #G.deck.cards > 0 then
        
        local pebble_cards = CardArea(
            2, 2,
            math.min(2 * G.GAME.dwjokers_pebble_cards_to_predict, 8 * G.CARD_W),
            0.75 * G.CARD_H, 
            {card_limit = G.GAME.dwjokers_pebble_cards_to_predict, type = 'joker'}
        )

		for i = 1, #G.GAME.dwjokers_pebble_predicted_cards do
			local card_to_copy = G.GAME.dwjokers_pebble_predicted_cards[i]
			-- Creamos la copia visual para el área de predicción
			local new_card = copy_card(card_to_copy, nil, nil, card_to_copy.playing_card)
			new_card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 2*G.SETTINGS.GAMESPEED)
			pebble_cards:emplace(new_card)
			new_card.pebble_flag = true
		end

        -- Definimos los nodos con las áreas
        main_nodes = {
            {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.O, config={object = pebble_cards}}}}
        }
    else
        
        main_nodes = {
            {n=G.UIT.R, config={align = "cm", padding = 0.5, minh = 2}, nodes={
                {
                    n=G.UIT.T, 
                    config={
                        text = "Bark!", 
                        colour = G.C.UI.TEXT_LIGHT, 
                        scale = 0.5, 
                        shadow = true
                    }
                }
            }}
        }
    end

    -- 2. Retornamos la estructura raíz
    return {
        n=G.UIT.ROOT, 
        config={align = "cm", minw = 15, padding = 0.1, r = 0.1, colour = G.C.CLEAR}, 
        nodes={
            {
                n=G.UIT.C, 
                config={align = "cm", padding = 0.2}, 
                nodes = main_nodes
            }
        }
    }
end


------------ ATLAS --------------

-- Jokers no mains
SMODS.Atlas{
    key = 'Jokers', 
    path = 'Jokers.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

-- Jokers mains
SMODS.Atlas{
    key = 'Mains', 
    path = 'Mains.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

-- Otras cartas (enhancements, boosters, etc)
SMODS.Atlas{
    key = 'Other_cards', 
    path = 'Other_cards.png', 
    px = 71, --width of one card
    py = 95 -- height of one card
}

-- Blind Chips
SMODS.Atlas{
    key = 'blindchips', 
    path = 'BlindChips.png', 
	atlas_table = "ANIMATION_ATLAS",
	frames = 21,
    px = 34,
    py = 34
}


------------ SOUNDS ------------

-- Musica de la tienda
SMODS.Sound {
	key = 'shop_music',
	path = 'shop_music.ogg',
	pitch = 1,
	volume = 1,
	select_music_track = function(self)
		if G.STATE == G.STATES.SHOP then
			for _,v in ipairs(G.jokers.cards) do
				if v:has_attribute('toon') then
					return 99999999
				end
			end
		end
	end

}


------------ SHADERS ------------

-- Vintage shader (me lo robe de alguien mas XDDD luego hago el mio)
SMODS.Shader({ 
	key = 'vintage', 
	path = 'vintage.fs' 
})

-- Springfever shader
SMODS.Shader({ 
	key = 'springfever', 
	path = 'springfever.fs' 
})

-- blackout shader
SMODS.Shader({ 
	key = 'blackout', 
	path = 'blackout.fs' 
})


------------ EDITIONS ------------

-- Vintage edition
SMODS.Edition({
    key = "vintage",
    loc_txt = {
        name = "Vintage",
        label = "Vintage",
        text = {
           "{X:chips,C:white}X#1#{} Chips",
		   "even if card",
		   "stays in hand."
        }
    },
    shader = "vintage",
    discovered = true,
    unlocked = true,
    config = { x_chips = 2 },
    in_shop = true,
    weight = 8,
    extra_cost = 6,
    apply_to_float = true,
    loc_vars = function(self)
		self.edition = {x_chips = self.config.x_chips}
        return { vars = {self.edition.x_chips} }
    end,
	calculate = function(self, card, context)

		-- si es carta jugable
        if context.main_scoring and (context.cardarea == G.play or context.cardarea == G.hand) then
            return {
                x_chips = card.edition.x_chips
            }
        end

		-- si es joker
		if context.pre_joker and context.cardarea == G.jokers then
			return {
                x_chips = card.edition.x_chips
            }
		end
    end
})

-- Springfever edition (WIP)
SMODS.Edition({
    key = "springfever",
    loc_txt = {
        name = "Spring Fever",
        label = "Spring Fever",
        text = {
           "WIP"
        }
    },
    shader = "springfever",
    discovered = true,
    unlocked = true,
    config = { },
    in_shop = true,
    weight = 8,
    extra_cost = 6,
    apply_to_float = true,
    loc_vars = function(self)
	
    end,
	calculate = function(self, card, context)

    end
})

-- Blackout edition
SMODS.Edition({
    key = "blackout",
    loc_txt = {
        name = "Blackout",
        label = "Blackout",
        text = {
           "Hides the {C:attention}appearance{},",
		   "{C:attention}name{} and {C:attention}description",
		   "of the cards"
        }
    },
    shader = "blackout",
    discovered = true,
    unlocked = true,
    config = { },
    in_shop = false,
    weight = 0,
    extra_cost = 6,
    apply_to_float = true,
})


------------ ENHANCEMENTS ------------

-- Ichor enhancement
SMODS.Enhancement {
    key = "ichor",
    loc_txt = {
        name = "Ichor",
        text = {
            "{C:mult}-#1#{} Mult. Every {C:attention}card{} in hand",
			"permanently gains {X:mult,C:white}X#2#{} Mult.",
			"Scoring {C:attention}cards{} become {X:black,C:white}ichor{} cards."
        }
    },
    unlocked = true,
    discovered = true,
	atlas = "Other_cards",
    pos = { x = 0, y = 0 },
    config = { neg_mult = 20, pos_mult = 0.2, ichor_infected = true },
    loc_vars = function(self, info_queue, card)
        return { vars ={ card.ability.neg_mult, card.ability.pos_mult, card.ability.ichor_infected } }
    end,
    calculate = function(self, card, context)

		if context.main_scoring and context.cardarea == G.play then
			local is_scoring = false

			-- Revisamos si la carta ichor esta anotando puntos
			for _, v in ipairs(context.scoring_hand) do
				if v == card then
					is_scoring = true
					break;
				end
			end
			
			-- Si no anoto puntos, nos brincamos todo esto
			if is_scoring then

				-- Determinamos que cartas ichor hay en la scoring hand
				local ichor_cards = {}
				for i=1, #context.scoring_hand do
					if context.scoring_hand[i].config.center.key == 'm_dwjokers_ichor' then
						table.insert(ichor_cards, context.scoring_hand[i])
					end
				end

				-- Tomamos solo la primera carta ichor para infectar a las demas cartas
				-- y para evitar que el mensaje "infected" se repita varias veces
				if card == ichor_cards[1] then
					for _, v in ipairs(context.scoring_hand) do
						if not v.ability.ichor_infected then
							G.E_MANAGER:add_event(Event({
								func = function()
									v:set_ability('m_dwjokers_ichor', nil, true)
									v:juice_up()
									SMODS.calculate_effect({ message = "Infected", colour = G.C.BLACK }, v)
									return true
								end,
								blocking = true,
								blockable = false
							}))
						end
					end
				end

				-- Damos xmult permanente a todas las cartas en la mano
				for _, v in ipairs(G.hand.cards) do
					G.E_MANAGER:add_event(Event({
						func = function()
							v.ability.perma_x_mult = (v.ability.perma_x_mult or 1) + card.ability.pos_mult
							v:juice_up()
							SMODS.calculate_effect({ message = "Upgrade!", colour = G.C.MULT }, v)
							return true
						end,
						blocking = true,
						blockable = false
					}))
				end
			end

			return { mult = (mult - card.ability.neg_mult)>=0 and -card.ability.neg_mult or mod_mult(0) }
        end

    end
}

-- Ice enhancement
SMODS.Enhancement {
	key = "ice",
    loc_txt = {
        name = "Ice",
        text = {
            "{C:green}#1# in #2#{} chance",
			"to give {C:chips}+#3#{} hands if scored",
			"{C:green}#4# in #5#{} chance",
			"to not score"
        }
    },
	unlocked = true,
    discovered = true,
	atlas = "Other_cards",
    pos = { x = 4, y = 0 },
	config = { extra = {hands = 1, hands_odds = 5, no_score_odds = 4}},
    loc_vars = function(self, info_queue, card)
		local hand_numerator, hand_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.hands_odds,
            'dwjokers_ice_hand')
		local no_score_numerator, no_score_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.no_score_odds,
            'dwjokers_ice_no_score')
        return { vars ={ hand_numerator, hand_denominator, card.ability.extra.hands, no_score_numerator, no_score_denominator } }
    end,
    calculate = function(self, card, context)

		-- Revisamos si la carta ice debe removerse de la scoring hand
		-- seria mucho mas facil usando context.modify_scoring_hand, pero entonces
		-- el boss blind del iced over no alcanzaria a dar el ice enhancement
		if context.before and context.cardarea == G.play then

			-- Determinamos el indice de la carta en la scoring hand
			local card_index = 0
			for i=1, #context.scoring_hand do
				if card == context.scoring_hand[i] then
					card_index = i
				end
			end

			-- Probabilidad de no dar puntos
			if SMODS.pseudorandom_probability(card, 'dwjokers_ice_no_score', 1, card.ability.extra.no_score_odds) then
				-- Removemos la carta de la scoring hand
				table.remove(context.scoring_hand, card_index)
				SMODS.calculate_effect({message = "Sliped!"}, card)

				-- Evento que espera a que la carta este highlighted para quitarselo
				G.E_MANAGER:add_event(Event({
					func = function()
						if not card.highlighted then
							return false
						end
						card:highlight(false)
						return true
					end,
					blocking = false
				}))
			end
		end

		if context.main_scoring and context.cardarea == G.play then
			local ret = {}

			-- Probabilidad de dar manos extras
			if SMODS.pseudorandom_probability(card, 'dwjokers_ice_hand', 1, card.ability.extra.hands_odds) then
                ease_hands_played(card.ability.extra.hands)
            end

			
		end


	end
}

-- Light-Producing para toons
-- Utilizo un enhancement para inyectar en G.P_CENTERS y asi poder usar info_queue
local function get_lightprod_badge(Game)
    return create_badge('Light-Producing', Game.C.SECONDARY_SET.Enhanced, Game.C.WHITE, 0.8)
end
SMODS.Enhancement {
    key = "light_producing_1",
    loc_txt = {
        name = "Light-Producing",
        text = {
            "Will disable {C:attention}The",
			"{C:attention}Blackout{} Boss blind"
        }
    },
	no_collection = true, -- No aparece en la coleccion
    unlocked = true,
    discovered = true,
	atlas = "Other_cards",
    pos = { x = 0, y = 0 },
	set_ability = function(self, card, initial, delay_sprites)
		-- Quitamos el enhancement inmediatamente si la carta lo obtiene de alguna forma
		card:set_ability("c_base", nil, true)
	end
}


------------ BOOSTER PACKS ------------

-- Toon research
SMODS.Booster {
    key = "toon_research",
	loc_txt = {
        name = "Toon Research",
		group_name = "Toon Research",
        text = {
        	"Choose {C:attention}#1#{} of up to",
        	"{C:attention}#2# {X:edition}Toon{} cards.",
        }
    },
	unlocked = true, 
	discovered = true,
    weight = 1,
    kind = 'dwjokers_toon_pack',
    cost = 6,
	atlas = "Other_cards",
    pos = { x = 0, y = 1 },
    config = { extra = 4, choose = 1 },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    ease_background_colour = function(self)
    	ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.WHITE, G.C.BLACK, 0.9))
		ease_background_colour{new_colour = SMODS.Gradients.dwjokers_rainbow, special_colour = G.C.WHITE, contrast = 1.5}
   	end,
    create_card = function(self, card, i)
        return { set = "dwjokers_toons_pack", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "dwjokers_toon_research" }
    end,
}

-- Classic collection
SMODS.Booster {
    key = "classic_collection",
	loc_txt = {
        name = "Classic Collection",
		group_name = "Classic Collection",
        text = {
        	"Choose {C:attention}#1#{} of up to",
        	"{C:attention}#2# {X:edition}Toon{} cards",
			"with {C:attention}Vintage{} edition."
        }
    },
	unlocked = true, 
	discovered = true,
    weight = 0.5,
    kind = 'dwjokers_toon_pack', -- You can also use Buffoon if you want it to belong to the vanilla kind
    cost = 6,
	atlas = "Other_cards",
    pos = { x = 0, y = 2 },
    config = { extra = 4, choose = 1 },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.e_dwjokers_vintage
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.WHITE, G.C.BLACK, 0.9))
		ease_background_colour{new_colour = G.C.L_BLACK, special_colour = G.C.BLACK, contrast = 1.5}
   	end,
    create_card = function(self, card, i)
        return { set = "dwjokers_toons_pack", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "dwjokers_classic_collection", edition = "e_dwjokers_vintage" }
    end,
}

-- Ichor Capsule
SMODS.Booster {
    key = "ichor_capsule",
	loc_txt = {
        name = "Ichor Capsule",
		group_name = "Ichor Capsule",
        text = {
        	"Choose {C:attention}#1#{} of up to {C:attention}#2# ",
            "{X:black,C:white}Ichor{C:attention} Playing{C:attention} cards{}",
			"to add to your deck",
        }
    },
	unlocked = true, 
	discovered = true,
    weight = 1,
    kind = 'dwjokers_ichor_pack', -- You can also use Buffoon if you want it to belong to the vanilla kind
    cost = 6,
	atlas = "Other_cards",
    pos = { x = 0, y = 3 },
    config = { extra = 6, choose = 1 },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_dwjokers_ichor
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.WHITE, G.C.BLACK, 0.9))
		ease_background_colour{new_colour = darken(G.C.BLUE, 0.5), special_colour = darken(G.C.BLACK, 0.2), contrast = 1.5}
    end,
    create_card = function(self, card, i)
        return { set = "Enhanced", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "dwjokers_ichor_capsule", enhancement = "m_dwjokers_ichor"}
    end,
}


------------ VOUCHERS ------------

-- Toon Spotlight
SMODS.Voucher {
    key = 'toon_spotlight',
	loc_txt = {
		name = 'Toon Spotlight',
		text = {
			"{X:edition}Toon{} cards appear",
			"{C:attention}X#1#{} more frequently",
			"in the shop"
		}
	},
	unlocked = true, 
	discovered = true,
	atlas = 'Other_cards',
    pos = { x = 4, y = 2 },
	cost = 10,
    config = { extra = { extra_rate = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.extra_rate } }
    end,
    redeem = function(self, card)
        -- calculamos la tasa de aparicion de los toons
		-- valor solo con vanilla y dwjokers = 0.11242492492492... o 599/5328
		G.GAME.dwjokers_toon_spotlight_rate = dwjokers_get_toon_appearance_rate()
		G.GAME.dwjokers_toon_spotlight_rate = G.GAME.dwjokers_toon_spotlight_rate * card.ability.extra.extra_rate
    end
}

-- Dandys World
SMODS.Voucher {
    key = 'dandys_world',
	loc_txt = {
		name = "Dandy's World",
		text = {
			"Lowers the rarities of",
			"all {X:edition}Toons{} in one tier",
			"{X:dwjokers_rainbow,C:white}Main{} -> {X:rare,C:white}Rare{} ->",
			"{X:uncommon,C:white}Uncommon{} -> {X:common,C:white}Common{}"
		}
	},
	unlocked = true, 
	discovered = true,
	atlas = 'Other_cards',
    pos = { x = 4, y = 3 },
	cost = 10,
	requires = { 'v_dwjokers_toon_spotlight' },
    redeem = function(self, card)
		-- disminuimos las rarezas siguiendo el orden
        dwjokers_rarity_change(true, nil)
		
    end
}


------------ CONSUMABLES ------------

-- The Operation
SMODS.Consumable {
    key = 'ichor_operation',
	loc_txt = {
		name = "The Operation",
		text = {
			"Adds or removes the {X:black,C:white}ichor{}",
			"enhancement of up to",
			"{C:attention}#1#{} selected cards"
		}
	},
    set = 'Tarot',
    unlocked = true, 
	discovered = true,
	atlas = 'Other_cards',
    pos = { x = 4, y = 1 },
	cost = 3,
    config = { max_highlighted = 3, enhancement = 'm_dwjokers_ichor' },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_dwjokers_ichor

        return { vars = { card.ability.max_highlighted, card.ability.enhancement} }
    end,
	use = function(self, card, area, copier)
		
		-- sonamos sonidito cuando usemos la carta
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

		-- damos vuelta a las cartas, estetico nada mas
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)

		-- les asignamos a las cartas el enhancement de ichor
        for i = 1, #G.hand.highlighted do
			if G.hand.highlighted[i].config and G.hand.highlighted[i].config.center and 
			G.hand.highlighted[i].config.center.key == 'm_dwjokers_ichor' then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						G.hand.highlighted[i]:set_ability("c_base")
						return true
					end
				}))
			else
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						G.hand.highlighted[i]:set_ability(card.ability.enhancement)
						return true
					end
				}))
			end
        end

		-- les damos vuelta de nuevo a las cartas
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end

		-- deseleccionamos las cartas
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end
}

-- Stars of the show
SMODS.Consumable {
    key = 'stars_show',
	loc_txt = {
		name = "Stars of the Show",
		text = {
			"Creates a",
            "{X:dwjokers_rainbow,C:white,E:1}Main{} {X:edition}Toon{}",
            "{C:inactive}(Must have room)",
		}
	},
    set = 'Spectral',
    unlocked = true, 
	discovered = true,
	atlas = 'Other_cards',
    pos = { x = 1, y = 0 },
	cost = 4,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'dwjokers_toons_mains'})
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}

-- Leaders
SMODS.Consumable {
    key = 'leaders',
	loc_txt = {
		name = "The Leaders",
		text = {
			"Creates a",
            "{X:dwjokers_leader,C:white,E:1}Leader{} {X:edition}Toon{}",
			"destroys any other {X:edition}Toon{}",
			"{C:inactive}(Must have at least 1 Toon)"
		}
	},
    set = 'Spectral',
    unlocked = true, 
	discovered = true,
	atlas = 'Other_cards',
    pos = { x = 2, y = 0 },
	cost = 4,
	use = function(self, card, area, copier)

		-- destruye todos los toons que tengas
		local deletable_jokers = {}
        for _, joker in pairs(G.jokers.cards) do
            if not SMODS.is_eternal(joker, card) and dwjokers_is_toon(joker) then 
				deletable_jokers[#deletable_jokers + 1] = joker 
			end
        end

		G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                for _, joker in pairs(deletable_jokers) do
					joker:start_dissolve(nil, _first_dissolve)
					_first_dissolve = true
                end
                return true
            end
        }))

		-- creamos un leader al azar (50/50 dandy o dyle)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'dwjokers_toons_lethals'})
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
		local deletable_jokers = {}
        for _, joker in pairs(G.jokers.cards) do
            if not SMODS.is_eternal(joker, card) and dwjokers_is_toon(joker) then 
				deletable_jokers[#deletable_jokers + 1] = joker 
			end
        end

		local toons = #deletable_jokers

        return G.jokers and toons > 0
    end
}

-- Toon mastery
SMODS.Consumable {
    key = 'toon_mastery',
	loc_txt = {
		name = "Toon Mastery",
		text = {
			"Adds {C:dark_edition}Vintage{} to a",
			"random {X:edition}Toon{}"
		}
	},
    set = 'Spectral',
    unlocked = true, 
	discovered = true,
	atlas = 'Other_cards',
    pos = { x = 3, y = 0 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_dwjokers_vintage
        return { vars = { G.GAME.ecto_minus or 1 } }
    end,
    use = function(self, card, area, copier)

        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
		for index,joker in ipairs(editionless_jokers) do
			if not dwjokers_is_toon(joker) then
				table.remove(editionless_jokers, index)
			end
		end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_jokers, 'dwjokers_toon_mastery')
                eligible_card:set_edition({ dwjokers_vintage = true })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)

		local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
		for index,joker in ipairs(editionless_jokers) do
			if not dwjokers_is_toon(joker) then
				table.remove(editionless_jokers, index)
			end
		end

		local toons = #editionless_jokers

        return toons > 0
    end,
}


------------ CHALLENGES ------------

-- Ichor Operation challenge
G.localization.misc.v_text['ch_c_dwjokers_ichor_1'] = {'Win by adding the {X:black,C:white,T:m_dwjokers_ichor}ichor{}'}
G.localization.misc.v_text['ch_c_dwjokers_ichor_2'] = {'enhancement to {C:attention}all cards'}
G.localization.misc.v_text['ch_c_dwjokers_ichor_3'] = {'in deck before {C:attention}ante 9'}
SMODS.Challenge {
	key = 'ichor_challenge',
	loc_txt = {
		name = 'Ichor Operation',
	},
	rules = {
		custom = {
			{id = 'dwjokers_ichor_1'},
			{id = 'dwjokers_ichor_2'},
			{id = 'dwjokers_ichor_3'},
		}
	},
	consumeables = {
		{id = 'c_dwjokers_ichor_operation'},
		{id = 'c_dwjokers_ichor_operation'},
	},
	calculate = function(self, context)

		if context.end_of_round and context.main_eval and not context.game_over then
			-- si el ante es 9 o mayor, perdemos la partida
			if G.GAME.round_resets.ante > 8 then 
				dwjokers_lose_run()
				return
			end

			-- verificamos si todas las cartas en el deck son de ichor
			for i=1, #G.playing_cards do
				-- si alguna de las cartas no es ichor entonces salimos
				if not (G.playing_cards[i].config.center.key == 'm_dwjokers_ichor') then return end
			end

			-- si llegamos hasta aqui, ganamos la partida
			win_game()
			G.GAME.won = true
		end
	end
}


------------ BLINDS ------------

-- The Blackout
SMODS.Blind {
	key = "blackout",
	loc_txt = {
		name = "The Blackout",
		text = {
			"All {C:attention}cards{} get the",
			"{C:edition,T:e_dwjokers_blackout}Blackout{} Edition",
			"until the end of round"
		}
	},
	discovered = true,
	atlas = "blindchips",
	pos = { x = 0, y = 0},
	dollars = 5,
	mult = 2,
	boss = { min = 1},
	boss_colour = HEX("28295C"),
	calculate = function(self, blind, context)

        if context.setting_blind then

			-- Si algun toon es light producing, deshabilitamos el blind
			for _, v in ipairs(G.jokers.cards) do
				if v:has_attribute('light_producing') then
					G.GAME.dwjokers_blackout_disable_by_light_producing = true
					G.E_MANAGER:add_event(Event({
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									G.GAME.blind:disable()
									play_sound('timpani')
									delay(0.4)
									return true
								end
							}))
							SMODS.calculate_effect({ message = 'Blackout disable!' }, v)
							return true
						end
					}))
					return nil, true -- This is for Joker retrigger purposes
				end
			end
            
			-- Funcion para aplicar el blackout
            local function aplicar_blackout(cards_table)
                for i=1, #cards_table do
                    local card = cards_table[i]
                    -- Guardamos la edicion original. En ability por si la carta se copia
                    card.ability.dwjokers_original_edition = card.edition or "none"
                    card:set_edition("e_dwjokers_blackout", true, true)
                end
            end

			-- Aplicamos blackout a las playing cards, jokers y consumibles
            aplicar_blackout(G.playing_cards)
            aplicar_blackout(G.jokers.cards)
            aplicar_blackout(G.consumeables.cards)
			aplicar_blackout(G.dwjokers_bassie_basket)
        end

        if context.blind_disabled or context.blind_defeated then

			-- si fue deshabilitado por un toon light producing nos brincamos todo lo demas lol
			if G.GAME.dwjokers_blackout_disable_by_light_producing then
				G.GAME.dwjokers_blackout_disable_by_light_producing = nil
				return
			end

			-- Funcion para restaurar la edicion original
            local function restaurar_edicion(cards_table)
                for i=1, #cards_table do
                    local card = cards_table[i]
                    local orig_ed = card.ability.dwjokers_original_edition

                    if orig_ed then
                        if orig_ed == "none" then
							
                            card.edition = nil -- Limpiamos el valor de la edición
                            
                            -- Edition = nil para quitar la edicion
                            card:set_edition(nil, true, true) 
                        else
                            -- Si tenía una edición, la restauramos
                            card:set_edition(orig_ed, true, true)
                        end
                        -- Limpiamos nuestra variable temporal
                        card.ability.dwjokers_original_edition = nil
                    end
                end
            end

			-- Restauramos las ediciones originales de las cartas
            restaurar_edicion(G.playing_cards)
            restaurar_edicion(G.jokers.cards)
            restaurar_edicion(G.consumeables.cards)
			restaurar_edicion(G.dwjokers_bassie_basket)
        end
    end

}

-- The Iced Over
SMODS.Blind {
	key = "iced_over",
	loc_txt = {
		name = "The Iced Over",
		text = {
			"Played cards get the",
			"{C:attention}Ice{} Enhancement",
			"before each hand"
		}
	},
	discovered = true,
	atlas = "blindchips",
	pos = { x = 0, y = 1},
	dollars = 5,
	mult = 2,
	boss = { min = 1},
	boss_colour = HEX("BEE0F9"),
	calculate = function(self, blind, context)
		-- Le damos el ice enhancement a las cartas jugadas
		-- usamos context.modify_scoring_hand para darle tiempo al ice enhancement
		-- de calcular sus probabilidades correctamente
		if context.modify_scoring_hand and context.in_scoring then
			for _, carta in ipairs(G.play.cards) do
				-- En lugar de comparar toda la carta, comparo solo su posicion en G.play
				if carta.rank == context.other_card.rank then
					carta:set_ability('m_dwjokers_ice')
					carta:juice_up()
				end
			end
		end

    end

}


------------ JOKERS --------------

--- COMUNES

-- Boxten
SMODS.Joker {
	key = 'Boxten',
	loc_txt = {
		name = 'Boxten',
		text = {
			"{C:mult}+#1#{} Mult for each",
			"{X:edition}Toon{} Joker in your possesion.",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 1, y = 4 },
	cost = 5,
	attributes = {'mult', 'scaling'},
	config = { extra = {mult_add = 10, mult_stack = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult_add, card.ability.extra.mult_stack} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.mult_stack = 0
		for _, joker in ipairs(G.jokers.cards) do
			if (joker.config.center.pools or {}).dwjokers_toons then
				card.ability.extra.mult_stack = card.ability.extra.mult_stack + card.ability.extra.mult_add
			end	
		end
		if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
			for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
				if (joker.config.center.pools or {}).dwjokers_toons then
					card.ability.extra.mult_stack = card.ability.extra.mult_stack + card.ability.extra.mult_add
				end	
			end
		end
	end,
    calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			card.ability.extra.mult_stack = 0
			for _, joker in ipairs(G.jokers.cards) do
				if (joker.config.center.pools or {}).dwjokers_toons then
					card.ability.extra.mult_stack = card.ability.extra.mult_stack + card.ability.extra.mult_add
				end	
			end
			if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
				for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
					if (joker.config.center.pools or {}).dwjokers_toons then
						card.ability.extra.mult_stack = card.ability.extra.mult_stack + card.ability.extra.mult_add
					end
				end
			end	
		end

		if context.card_added or (context.dwjokers_removed and context.dwjokers_removed_card.ability.set == "Joker") and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					card.ability.extra.mult_stack = 0
					for _, joker in ipairs(G.jokers.cards) do
						if (joker.config.center.pools or {}).dwjokers_toons then
							card.ability.extra.mult_stack = card.ability.extra.mult_stack + card.ability.extra.mult_add
						end	
					end
					if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
						for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
							if (joker.config.center.pools or {}).dwjokers_toons then
								card.ability.extra.mult_stack = card.ability.extra.mult_stack + card.ability.extra.mult_add
							end	
						end	
					end
					return true
				end,
				blocking = false
			}))
		end

		if context.joker_main then
			return {
					mult_mod = card.ability.extra.mult_stack,
					message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_stack } }
			}
		end	
	end
}

-- Poppy
SMODS.Joker {
	key = 'Poppy',
	loc_txt = {
		name = 'Poppy',
		text = {
			"{C:chips}+#1#{} Chips for each",
			"{X:edition}Toon{} Joker in your possesion.",
			"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 0, y = 4 },
	cost = 5,
	attributes = {'chips', 'scaling'},
	config = { extra = {chips_add = 20, chips_stack = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.chips_add, card.ability.extra.chips_stack} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.chips_stack = 0
		for _, joker in ipairs(G.jokers.cards) do
			if (joker.config.center.pools or {}).dwjokers_toons then
				card.ability.extra.chips_stack = card.ability.extra.chips_stack + card.ability.extra.chips_add
			end	
		end
		if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
			for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
				if (joker.config.center.pools or {}).dwjokers_toons then
					card.ability.extra.chips_stack = card.ability.extra.chips_stack + card.ability.extra.chips_add
				end	
			end
		end
	end,
    calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			card.ability.extra.chips_stack = 0
			for _, joker in ipairs(G.jokers.cards) do
				if (joker.config.center.pools or {}).dwjokers_toons then
					card.ability.extra.chips_stack = card.ability.extra.chips_stack + card.ability.extra.chips_add
				end	
			end
			if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
				for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
					if (joker.config.center.pools or {}).dwjokers_toons then
						card.ability.extra.chips_stack = card.ability.extra.chips_stack + card.ability.extra.chips_add
					end	
				end
			end
		end

		if context.card_added or (context.dwjokers_removed and context.dwjokers_removed_card.ability.set == "Joker") and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					card.ability.extra.chips_stack = 0
					for _, joker in ipairs(G.jokers.cards) do
						if (joker.config.center.pools or {}).dwjokers_toons then
							card.ability.extra.chips_stack = card.ability.extra.chips_stack + card.ability.extra.chips_add
						end	
					end
					if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
						for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
							if (joker.config.center.pools or {}).dwjokers_toons then
								card.ability.extra.chips_stack = card.ability.extra.chips_stack + card.ability.extra.chips_add
							end	
						end	
					end
					return true
				end,
				blocking = false
			}))
		end

		if context.joker_main then
			return {
					chip_mod = card.ability.extra.chips_stack,
					message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips_stack } }
			}
		end	
	end
}

-- Shrimpo
SMODS.Joker {
	key = 'Shrimpo',
	loc_txt = {
		name = 'Shrimpo',
		text = {
			"{C:mult}+#1#{} Mult",
			"{C:attention}#2#{} hand size"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 0, y = 0 },
	cost = 1,
	attributes = {'mult', 'hand_size', 'food'},
	config = { extra = { mult = 100, hand_size = -10 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.hand_size } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.hand_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.hand_size)
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
	end
	
}

-- Tisha
SMODS.Joker {
	key = 'Tisha',
	loc_txt = {
		name = 'Tisha',
		text = {
			"This {X:edition}Toon{} gains {C:chips}+#2#{} Chips",
			"per played hand,",
			"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 1, y = 0 },
	cost = 5,
	attributes = {'chips', 'scaling'},
	config = { extra = { chips = 0, chips_gain = 10 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chip_mod = card.ability.extra.chips,
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
			}
		end

		if context.after then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
			return {
				message = 'Gotta sweep!',
				colour = G.C.CHIPS,
				card = card
			}
		end
	end
}

-- Yatta
SMODS.Joker {
	key = 'Yatta',
	loc_txt = {
		name = 'Yatta',
		text = {
			"Grants a random {C:purple}Tarot{},",
			"{C:blue}Planet{} or {C:spectral}Spectral{} card",
			"when {C:attention}blind{} is selected",
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 3, y = 0 },
	cost = 5,
	attributes = {'generation', 'tarot', 'planet', 'spectral'},
	config = { extra = { set_aux = 'Tarot' } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.set_aux } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			card.ability.extra.set_aux = pseudorandom_element(card_types, 'dwjokers_yatta')
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = card.ability.extra.set_aux,
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = card.ability.extra.set_aux .. 's FOR EVERYONE!!!', colour = G.C.PURPLE },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
        end
    end,
}

-- Looey
SMODS.Joker {
	key = 'Looey',
	loc_txt = {
		name = 'Looey',
		text = {
			"Gain {C:attention}+#1#{} hand size",
			"each played hand.",
			"Resets every round.",
			"{C:inactive}(Currently {C:chips}+#2#{C:inactive} hand size)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 4, y = 0 },
	cost = 5,
	attributes = {'hands', 'hand_size', 'scaling', 'reset'},
	config = { extra = { hand_size = 1, looey_uses = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand_size, card.ability.extra.looey_uses } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		-- En caso de ser añadido from debuff o ser copiado
		G.hand:change_size(card.ability.extra.hand_size * card.ability.extra.looey_uses)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.hand_size * card.ability.extra.looey_uses)
	end,
    calculate = function(self, card, context)
		
		if context.setting_blind then
			card.ability.extra.looey_uses = 0
		end

		-- toma en cuenta si fue usado por blueprint
		if context.after then
			G.hand:change_size(card.ability.extra.hand_size)
			card.ability.extra.looey_uses = card.ability.extra.looey_uses + 1
			return {
				message = 'Im actually so excited!',
				colour = G.C.CHIPS,
				card = card
			}
		end
		
		-- reinicia el hand size a su valor original al inicio del blind
		if context.end_of_round and context.main_eval and not context.blueprint then
			G.hand:change_size(-card.ability.extra.hand_size * card.ability.extra.looey_uses)
			card.ability.extra.looey_uses = 0
			return {
				message = 'Reset!',
				colour = G.C.CHIPS,
				card = card
			}
		end
	end
}

-- Cosmo
SMODS.Joker {
	key = 'Cosmo',
	loc_txt = {
		name = 'Cosmo',
		text = {
			"Prevents Death and",
            "grants {C:blue}+#1#{} extra hands",
            "{C:red,E:2}self destructs{}",
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
	rarity = 1,
	cost = 5,
	atlas = 'Jokers',
	pos = { x = 1, y = 1 },
	attributes = {'prevents_death', 'hands', 'food'},
	config = { extra = { hands = 3 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands } }
    end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	calculate = function(self, card, context)
		if context.after and not context.blind_defeated and not context.blueprint then
        	if G.GAME.current_round.hands_left <= 0 and G.GAME.chips < G.GAME.blind.chips then
                G.E_MANAGER:add_event(Event {
					blocking = false,
                    func = function()
						if not context.after or context.blind_defeated or 
						G.GAME.current_round.hands_left > 0 or G.GAME.chips >= G.GAME.blind.chips then
							return true
						end
						G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hands
						play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        card:start_dissolve()
                        return true
                    end
                })
				return {
					message = 'Enjoy, just for you!',
					colour = G.C.RED
				}
            end
        end
    end
}

-- Brusha
SMODS.Joker {
	key = 'Brusha',
	loc_txt = {
		name = 'Brusha',
		text = {
			"When {C:attention}blind{} is selected, gain",
			"{C:attention}#1#%{} extra discards.",
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 0, y = 1 },
	cost = 5,
	attributes = {'discard'},
	config = { extra = { discards_mult = 50, brusha_uses = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.discards_mult, card.ability.extra.brusha_uses } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	calculate = function(self, card, context)
		
		if context.setting_blind then
			card.ability.extra.brusha_uses = card.ability.extra.brusha_uses + 1
			ease_discard(math.ceil(G.GAME.round_resets.discards * card.ability.extra.discards_mult / 100))
			return {
				message = 'A work of art!',
				colour = G.C.CHIPS,
				card = card
			}
		end

		if context.end_of_round and context.main_eval and not context.blueprint then
			ease_discard(-math.ceil(G.GAME.round_resets.discards * card.ability.extra.discards_mult / 100) * card.ability.extra.brusha_uses)
		end
	end
}

-- Rudie
SMODS.Joker {
	key = 'Rudie',
	loc_txt = {
		name = 'Rudie',
		text = {
			"Increase your {C:attention}Play{}",
			"and {C:attention}Discard{} limit",
			"by {C:attention}+#1#{} cards if the",
			"{C:attention}ranks{} of scoring",
			"cards sum {C:attention}#2#{}.",
			"{C:inactive}(Currently {C:attention}+#3#{C:inactive} cards)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 4, y = 4 },
	cost = 5,
	attributes = {'rank', 'scaling', 'hands', 'discard'},
	config = { extra = { limit = 1, rank_sum = 25, limit_stack = 0 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_dwjokers_light_producing_1
		return { vars = { card.ability.extra.limit, card.ability.extra.rank_sum, card.ability.extra.limit_stack } }
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = get_lightprod_badge(G)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		-- En caso de que sea añadido from debuff o por ser copiado
		SMODS.change_play_limit(card.ability.extra.limit_stack)
		SMODS.change_discard_limit(card.ability.extra.limit_stack)
	end,
	remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-card.ability.extra.limit_stack)
		SMODS.change_discard_limit(-card.ability.extra.limit_stack)
	end,
	calculate = function(self, card, context)
		
		if context.after then 
			local rank_total = 0
			for _, v in ipairs(context.scoring_hand) do
				-- solo rank
				rank_total = rank_total + (SMODS.has_no_rank(v) and 0 or v.base.nominal)
			end
			
			if rank_total == card.ability.extra.rank_sum then
				SMODS.change_play_limit(card.ability.extra.limit)
				SMODS.change_discard_limit(card.ability.extra.limit)
				card.ability.extra.limit_stack = card.ability.extra.limit_stack + card.ability.extra.limit
				return { 
				message = 'MERRY CHRISTMAS!',
				colour = G.C.RED,
				card = card}
			end	
		end	
	
	end


}

-- Eggson
SMODS.Joker {
	key = 'Eggson',
	loc_txt = {
		name = 'Eggson',
		text = {
			"At the start of each round,",
			"get {C:attention}#1#%{} of the chips",
			"required in the blind."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 2, y = 4 },
	cost = 5,
	attributes = {'score', 'food'},
	config = { extra = { score_percent = 10 } },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.score_percent} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)
		
		if context.setting_blind then
			local eggs_score = math.floor( G.GAME.blind.chips * card.ability.extra.score_percent / 100 )
			return {
				score = eggs_score,
				message = 'Eggs.',
				colour = G.C.CHIPS,
				card = card
			}
		end	
	end
}

-- Ribecca
SMODS.Joker {
	key = 'Ribecca',
	loc_txt = {
		name = 'Ribecca',
		text = {
			"Prevents {C:attention}debuffs{} to",
			"{C:attention}Playing Cards."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 3, y = 4 },
	cost = 5,
	attributes = {'passive'},
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		-- Esto solo aplicaria si Ribecca es añadida en medio de un blind
		for _,v in ipairs(G.playing_cards) do
			SMODS.debuff_card(v, 'prevent_debuff', 'dwjokers_ribecca')
		end	
	end,
	remove_from_deck = function(self, card, from_debuff)
		-- Revisamos si quedan Ribeccas entre los jokers
		for _, joker in ipairs(G.jokers.cards) do
			if joker.config.center.key == "j_dwjokers_Ribecca" and joker ~= card then
				return
			end	
		end

		-- Recalculamos debuffs si no quedan Ribeccas
		for _,v in ipairs(G.playing_cards) do
			SMODS.debuff_card(v, nil, 'dwjokers_ribecca')
		end
	end,
    calculate = function(self, card, context)
		
		-- Prevenimos debuffs a cartas jugables cuando se seleccione el blind
		if context.debuff_card and context.debuff_card.area == G.deck then
			return { prevent_debuff = true}
		end

	end
}


--- POCO COMUNES

-- Brightney
SMODS.Joker {
	key = 'Brightney',
	loc_txt = {
		name = 'Brightney',
		text = {
			"Prevents {C:attention}debuffs{} and",
			"redirects all {C:attention}destructions{}",
			"of jokers in your deck to itself.",
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 2, y = 2 },
	cost = 10,
	attributes = {'passive'},
	set_badges = function(self, card, badges)
		badges[#badges+1] = get_lightprod_badge(G)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_dwjokers_light_producing_1
	end,
	calculate = function(self, card, context)
		if context.joker_type_destroyed and context.main_eval then
            card:start_dissolve()
			SMODS.calculate_effect({ message = 'Sparkle on!', instant = true}, card)
            return { no_destroy = true, remove = false}
		end
		if context.debuff_card and context.cardarea == G.jokers then
			return { prevent_debuff = true, card = context.debuff_card }
		end

    end,
}

-- Connie
SMODS.Joker {
	key = 'Connie',
	loc_txt = {
		name = 'Connie',
		text = {
			"Destroys {C:attention}#1#{} random {C:attention}playing",
			"{C:attention}card{} of each played",
			"hand and permanently adds",
			"{X:chips,C:white}X#2#{} its Chips to Mult",
			"before each hand.",
			"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 5, y = 2 },
	cost = 7,
	attributes = {'scaling', 'mult', 'destroy_card', 'rank'},
	config = { extra = {card_num = 1, mult = 1.5, mult_stack = 0} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_dwjokers_light_producing_1
		return { vars = {card.ability.extra.card_num, card.ability.extra.mult, card.ability.extra.mult_stack} }
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = get_lightprod_badge(G)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)

		if context.before then

			-- inicializamos cartas elegibles, que son las que no esten getting sliced
			-- ni que hayan sido removidas ya, para evitar que la misma carta se destruya dos veces
			local eligible_cards = {}
			for k, v in ipairs(context.full_hand) do
				if not v.getting_sliced and not v.removed then
					table.insert(eligible_cards, v)
				end
			end

			-- elegimos las cartas que Connie destruira
			for i=1, card.ability.extra.card_num do
				if #eligible_cards >0 then
					local random_card, index = pseudorandom_element(eligible_cards, "dwjokers_Connie")
					random_card.getting_sliced = true -- no se si SMODS.destroy_cards lo especifica o no lol
					table.remove(eligible_cards, index)
					-- chips de la carta (rank (si tiene), perma bonus, enhancement y edition )
					local chips_from_card = (not SMODS.has_no_rank(random_card) and random_card.base.nominal or 0) + 
											(random_card.ability.perma_bonus or 0) + 
											(random_card.edition and (random_card.edition.chips or 0) or 0) + 
											(random_card.ability.bonus or 0)

					-- stackeamos el mult
					card.ability.extra.mult_stack = card.ability.extra.mult_stack + (chips_from_card * card.ability.extra.mult)

					-- destruimos la carta y arrojamos un mensaje
					SMODS.destroy_cards(random_card)
					SMODS.calculate_effect({ message = localize { type = 'variable', key = 'a_mult', vars = { chips_from_card * card.ability.extra.mult } }}, card)
				end
			end
		end

		-- se agrega mult antes de que las cartas puntuen
		if context.initial_scoring_step then
			if card.ability.extra.mult_stack > 0 then
				return {
					mult = card.ability.extra.mult_stack,
					card = card
				}
			end
		end

	end
}

-- Finn
-- TODO: Hay que encontrar una forma de hacer que el calculo sea mas rapido
local yarepitio = false
SMODS.Joker {
	key = 'Finn',
	loc_txt = {
		name = 'Finn',
		text = {
			"Retrigger {C:attention}all{} played cards",
			"used in scoring",
			"{C:attention}+#1#{} times for each",
			"{X:edition}Toon{} in your possesion",
			"{C:inactive}(Currently {C:attention}+#2#{C:inactive} times)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 0, y = 3 },
	cost = 7,
	attributes = {'retrigger'},
	config = { extra = { rep = 1, rep_stack = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.rep, card.ability.extra.rep_stack } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.rep_stack = 0
		for _, joker in ipairs(G.jokers.cards) do
			if (joker.config.center.pools or {}).dwjokers_toons then
				card.ability.extra.rep_stack = card.ability.extra.rep_stack + card.ability.extra.rep
			end	
		end
		if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
			for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
				if (joker.config.center.pools or {}).dwjokers_toons then
					card.ability.extra.rep_stack = card.ability.extra.rep_stack + card.ability.extra.rep
				end
			end
		end
	end,
    calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			yarepitio = false
			card.ability.extra.rep_stack = 0
			for _, joker in ipairs(G.jokers.cards) do
				if (joker.config.center.pools or {}).dwjokers_toons then
					card.ability.extra.rep_stack = card.ability.extra.rep_stack + card.ability.extra.rep
				end	
			end
			if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
				for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
					if (joker.config.center.pools or {}).dwjokers_toons then
						card.ability.extra.rep_stack = card.ability.extra.rep_stack + card.ability.extra.rep
					end
				end
			end	
		end

		if context.card_added or (context.dwjokers_removed and context.dwjokers_removed_card.ability.set == "Joker") and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					card.ability.extra.rep_stack = 0
					for _, joker in ipairs(G.jokers.cards) do
						if (joker.config.center.pools or {}).dwjokers_toons then
							card.ability.extra.rep_stack = card.ability.extra.rep_stack + card.ability.extra.rep
						end	
					end
					if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
						for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
							if (joker.config.center.pools or {}).dwjokers_toons then
								card.ability.extra.rep_stack = card.ability.extra.rep_stack + card.ability.extra.rep
							end	
						end	
					end
					return true
				end,
				blocking = false
			}))
		end

		if context.repetition and context.cardarea == G.play then
			if not yarepitio then
				G.GAME.dwjokers_card_effects = context.card_effects
				-- print(G.GAME.dwjokers_card_effects)
				yarepitio = true
			end
			-- print(context.card_effects) -- Esta es una tabla que guarda cositas de la carta que se repitio
			--INFO - [G] Table:
			--	1: Table:
			--	playing_card: Table:
			--		x_mult: 142
			--		p_dollars: 3
			--		chips: 10

			--	edition: Table:
			--		card: Table:
			--		click_offset: table: 0x110ef810
			--		+72 more values.

			--		chips: 50
			-- Si quisiera resumir los calculos, podria usar la tabla y context.repetition_only
			-- Poner repetitions = 2, y en la repeticion utilizar la tabla y simplemente calcular
			-- todo multiplicado por rep_stack
			-- Asi me ahorro los 4 mil events JAJAJAJAJA
			return {
				repetitions = card.ability.extra.rep_stack
			}
		end	


	end
}

-- Razzle n Dazzle
SMODS.Joker {
	key = 'RazzlenDazzle',
	loc_txt = {
		name = 'Razzle n Dazzle',
		text = {
			"{C:chips}+#1#{} Chips on odd rounds and",
			"{C:mult}+#2#{} Mult on even rounds",
			"{C:inactive}(Currently {C:attention}+#3#{C:attention} #4#{C:inactive})"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	cost = 7,
	attributes = {'chips', 'mult'},
	config = { extra = { chips = 1000, mult = 100, currently1 = 100, currently2 = "Mult" } },
	atlas = 'Jokers',
	pos = { x = 2, y = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.currently1, card.ability.extra.currently2, G.GAME.round } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		if G.GAME.round % 2 == 1 then
				card.ability.extra.currently1 = card.ability.extra.chips
				card.ability.extra.currently2 = "Chips"
			else
				card.ability.extra.currently1 = card.ability.extra.mult
				card.ability.extra.currently2 = "Mult"
			end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.round % 2 == 1 then
				card.ability.extra.currently1 = card.ability.extra.chips
				card.ability.extra.currently2 = "Chips"
				return {
					chip_mod = card.ability.extra.chips,
					message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
				}
			else
				card.ability.extra.currently1 = card.ability.extra.mult
				card.ability.extra.currently2 = "Mult"
				return {
					mult_mod = card.ability.extra.mult,
					message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
				}
			end
		end

		if context.setting_blind then
			if G.GAME.round % 2 == 1 then
				card.ability.extra.currently1 = card.ability.extra.chips
				card.ability.extra.currently2 = "Chips"
				return {
					message = 'Oh what fun!',
					colour = G.C.CHIPS
				}
			else
				card.ability.extra.currently1 = card.ability.extra.mult
				card.ability.extra.currently2 = "Mult"
				return {
					message = 'Oh the misery...',
					colour = G.C.MULT
				}
			end
		end
	end
}

-- Rodger
SMODS.Joker {
	key = 'Rodger',
	loc_txt = {
		name = 'Rodger',
		text = {
			"Gain {C:attention}+#1#{} discards for",
			"each played round.",
			"{C:inactive}(Currently {C:attention}+#2#{C:inactive} discards)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 3, y = 1 },
	cost = 7,
	attributes = {'discards', 'scaling'},
	config = { extra = { d_size = 1, d_total = 0} },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.d_size, card.ability.extra.d_total } }
    end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.d_total = G.GAME.round
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_total
		ease_discard(card.ability.extra.d_total)
	end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_total
        ease_discard(-card.ability.extra.d_total)
    end,
	calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
			card.ability.extra.d_total = G.GAME.round
			G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
			ease_discard(card.ability.extra.d_size)
			return {
				message = 'Upgrade!',
				colour = G.C.CHIPS,
				card = card
			}
		end
    end
}

-- Toodles
SMODS.Joker {
    key = "Toodles",
	loc_txt = {
		name = 'Toodles',
		text = {
			"Gives {X:mult,C:white}X#1#{} Mult",
            "for each {C:attention}Lucky Card",
            "in your {C:attention}full deck",
            "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
		}
	},
	unlocked = true, 
	discovered = true,
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    cost = 7,
	atlas = 'Jokers',
    pos = { x = 2, y = 1 },
	attributes = {'xmult', 'scaling', 'full_deck', 'enhancements'},
    config = { extra = { xmult = 0.5 } },
	-- ni siquiera intentare entender que pasa aqui, robe codigo del stone joker
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky

        local lucky_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_lucky') then lucky_tally = lucky_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.xmult, 1 + card.ability.extra.xmult * lucky_tally } }
    end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)
        if context.joker_main then
            local lucky_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_lucky') then lucky_tally = lucky_tally + 1 end
            end
            return {
                Xmult = 1 + card.ability.extra.xmult * lucky_tally,
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_lucky') then
                return true
            end
        end
        return false
    end
}

-- Teagan
SMODS.Joker {
	key = 'Teagan',
	loc_txt = {
		name = 'Teagan',
		text = {
			"{X:money,C:white}X#1#{} to all sources",
			"of {C:money}money gain"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 4, y = 1 },
	cost = 7,
	attributes = {'economy', 'passive', 'food'},
	config = { extra = { money_mult = 2} },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money_mult} }
    end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	calculate = function(self, card, context)
		if context.money_altered and context.amount > 0 then
			G.GAME.dollars = G.GAME.dollars + context.amount * (card.ability.extra.money_mult-1)
			return {
				message = 'Lets fix that!',
				colour = G.C.MONEY,
				card = card
			}
		end
    end
}

-- Ginger
SMODS.Joker {
	key = 'Ginger',
	loc_txt = {
		name = 'Ginger',
		text = {
			"Prevents Death and",
            "restablishes the {C:blue}hands{} by",
			"paying {C:money}$#1#{}."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 2, y = 3 },
	cost = 7,
	attributes = {'prevents_death', 'hands', 'economy', 'food'},
	config = { extra = { price = 20 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.price } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)

		if context.after and not context.blind_defeated and not context.blueprint then

			-- comprobamos si hemos perdido y que podamos pagar los 20 dollars
			if G.GAME.current_round.hands_left <= 0 and G.GAME.chips < G.GAME.blind.chips and
				G.GAME.dollars >= 20 then
				
				-- añadimos un evento para que no sea instantaneo
                G.E_MANAGER:add_event(Event {
					blocking = false,
                    func = function()

						-- seguridad
						if not context.after or context.blind_defeated or 
						G.GAME.current_round.hands_left > 0 or G.GAME.chips >= G.GAME.blind.chips then
							return true
						end

						-- quitamos los dollars
						G.GAME.dollars = G.GAME.dollars - card.ability.extra.price

						-- añadimos las hands extras
						G.GAME.current_round.hands_left = G.GAME.round_resets.hands
						play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                })
				return {
					message = 'Might be a little bitter haha...',
					colour = G.C.RED
				}
            end
        end

	end
}

-- Flyte
SMODS.Joker {
	key = 'Flyte',
	loc_txt = {
		name = 'Flyte',
		text = {
			"Adds {X:chips,C:white}X#1#{} the sum of",
			"the chips of each card",
			"{C:attention}held in hand.",
			"{C:inactive}(Will give {C:chips}+#2#{C:inactive} Chips)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 1, y = 3 },
	cost = 7,
	attributes = {'chips', 'rank'},
	config = { extra = {chips_mult = 10, chips_to_give = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.chips_mult, card.ability.extra.chips_to_give} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)

		-- Actualizamos las cartas en mano segun modifiquemos la playing hand
		if context.modify_scoring_hand and not context.blueprint then
			local chips_sum = 0
			
			for _, h_card in ipairs(G.hand.cards) do
				local is_scoring = false
				
				-- Comprobamos si ESTA carta de la mano está en la jugada que va a puntuar
				for _, s_card in ipairs(context.full_hand) do
					if h_card == s_card then 
						is_scoring = true
						break 
					end
				end

				-- Si la carta NO va a puntuar (se queda en la mano)
				if not is_scoring then
					-- Sumamos (usamos nominal para el valor facial y perma_bonus para bonos de cartas)
					-- Añadimos "or 0" por seguridad para evitar errores nil
					local chips_from_card = (h_card.base.nominal or 0) + 
						(h_card.ability.perma_bonus or 0) + 
						(h_card.edition and (h_card.edition.chips or 0) or 0) + 
						(h_card.ability.bonus or 0)
					chips_sum = chips_sum + chips_from_card
				end
			end
			
			-- Guardamos el resultado final multiplicado
			card.ability.extra.chips_to_give = chips_sum * card.ability.extra.chips_mult
		end
		
		if context.joker_main then
			local chips_sum = 0
			
			for _, h_card in ipairs(G.hand.cards) do
				local is_scoring = false
				
				-- Comprobamos si ESTA carta de la mano está en la jugada que va a puntuar
				for _, s_card in ipairs(context.full_hand) do
					if h_card == s_card then 
						is_scoring = true
						break 
					end
				end

				-- Si la carta NO va a puntuar (se queda en la mano)
				if not is_scoring then
					-- Sumamos (usamos nominal para el valor facial y perma_bonus para bonos de cartas)
					-- Añadimos "or 0" por seguridad para evitar errores nil
					local chips_from_card = (h_card.base.nominal or 0) + 
						(h_card.ability.perma_bonus or 0) + 
						(h_card.edition and (h_card.edition.chips or 0) or 0) + 
						(h_card.ability.bonus or 0)
					chips_sum = chips_sum + chips_from_card
				end
			end
			
			-- Guardamos el resultado final multiplicado
			card.ability.extra.chips_to_give = chips_sum * card.ability.extra.chips_mult
			return {
				chip_mod = card.ability.extra.chips_to_give,
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips_to_give } }
			}
		end	

	end
}

-- Soulvester
SMODS.Joker {
	key = 'Soulvester',
	loc_txt = {
		name = 'Soulvester',
		text = {
			"When {C:attention}blind{} is selected,",
			"Double the {C:attention}hands{} and",
			"halve the {C:attention}hand size{}.",
			"{C:inactive}(Currently {C:blue}+#3#{C:inactive} hands",
			"{C:inactive}and {C:red}-#4#{C:inactive} hand size)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 1, y = 2 },
	cost = 5,
	attributes = {'hands', 'hand_size'},
	config = { extra = { hand_mult = 2, hand_size_mult = 0.5, hands_added = 0, h_size_removed = -0, soulvester_active = false } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_dwjokers_light_producing_1
		return { 
			vars = {
				card.ability.extra.hand_mult, 
				card.ability.extra.hand_size_mult,
				card.ability.extra.hands_added, 
				card.ability.extra.h_size_removed, 
				card.ability.extra.soulvester_active, 
			} 
		}
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = get_lightprod_badge(G)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		-- inicializamos variables globales
		G.GAME.dwjokers_soulvester_h_size = G.GAME.dwjokers_soulvester_h_size or G.hand.config.card_limit
		G.GAME.dwjokers_soulvester_hands = G.GAME.dwjokers_soulvester_hands or G.GAME.current_round.hands_left

        -- reiniciamos variables por si acaso es una copia de otro Soulvester
        card.ability.extra.soulvester_active = false
        card.ability.extra.hands_added = 0
        card.ability.extra.h_size_removed = -0

    end,
    remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.soulvester_active then
			G.GAME.dwjokers_soulvester_h_size = G.GAME.dwjokers_soulvester_h_size + card.ability.extra.h_size_removed
			G.GAME.dwjokers_soulvester_hands = G.GAME.dwjokers_soulvester_hands - card.ability.extra.hands_added
			G.hand:change_size(card.ability.extra.h_size_removed)
		end
	end,
    calculate = function(self, card, context)

        -- al inicio del blind se activa
        if context.setting_blind then
			G.GAME.dwjokers_soulvester_hands = G.GAME.dwjokers_soulvester_hands or G.GAME.round_resets.hands
			G.GAME.dwjokers_soulvester_h_size = G.GAME.dwjokers_soulvester_h_size or G.hand.config.card_limit

			if G.GAME.dwjokers_soulvester_h_size > 1 then
				card.ability.extra.soulvester_active = true
				
				-- calculamos las hands añadidas y el hand size removido
				card.ability.extra.hands_added = G.GAME.dwjokers_soulvester_hands * (card.ability.extra.hand_mult - 1)
				card.ability.extra.h_size_removed = math.floor(G.GAME.dwjokers_soulvester_h_size * (1 - card.ability.extra.hand_size_mult))

				-- actualizamos hand size y hands
				G.GAME.dwjokers_soulvester_h_size = G.GAME.dwjokers_soulvester_h_size - card.ability.extra.h_size_removed
				G.hand:change_size(-card.ability.extra.h_size_removed)
				G.GAME.dwjokers_soulvester_hands = G.GAME.dwjokers_soulvester_hands + card.ability.extra.hands_added
				ease_hands_played(card.ability.extra.hands_added)

				return {
					message = 'There is still work to be done.',
					colour = G.C.CHIPS,
					card = card
				}
			end
        end

        -- despues del fin de ronda se desactiva, para evitar colision con otros jokers (creo?)
        if context.round_eval then
			-- restablecemos buffer de hands
			G.GAME.dwjokers_soulvester_hands = nil
			G.GAME.dwjokers_soulvester_h_size = nil

			-- solo si soulvester esta activo
			if card.ability.extra.soulvester_active then
				card.ability.extra.soulvester_active = false

				-- restablecemos hand size y hands
				G.hand:change_size(card.ability.extra.h_size_removed)
				

				-- reiniciamos hands añadidas y hand size removido
				card.ability.extra.hands_added = 0
				card.ability.extra.h_size_removed = -0
				

				return {
					message = 'Inactive!',
					colour = G.C.CHIPS,
					card = card
				}
			end

        end
    end
}


--- RAROS

-- Blot
-- al usar un consumible cuando te queda una hand, 
-- los botones de "play hand" y "discard" no se remueven correctamente
SMODS.Joker {
    key = 'Blot',
    loc_txt = {
        name = 'Blot',
        text = {
            "{C:blue}+#1#{} hand for each consumable",
            "in your possesion and {C:mult}+#2#{} Mult",
            "for each current card {C:attention}held in hand.",
            "{C:inactive}(Currently {C:chips}+#3#{C:inactive} hands and {C:mult}+#4#{C:inactive} Mult)",
        }
    },
    unlocked = true, 
    discovered = true,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 3,
    atlas = 'Jokers',
    pos = { x = 3, y = 3 },
    cost = 10,
	attributes = {'hands', 'mult', 'scaling', 'hand_size'},
    config = { extra = {hand_add = 1, mult_add = 10, hand_stack = 0, mult_stack = 0, diff = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.hand_add, card.ability.extra.mult_add, card.ability.extra.hand_stack, card.ability.extra.mult_stack, card.ability.extra.diff} }
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
    end,
    add_to_deck = function(self, card, from_debuff)
        local current_consumables = dwjokers_consumable_count()
        card.ability.extra.hand_stack = current_consumables
        card.ability.extra.mult_stack = #G.hand.cards * card.ability.extra.mult_add
        
        -- Si hay consumibles, los sumamos al conteo de hands
        dwjokers_blot_hand_mod(card, current_consumables)
    end,
    remove_from_deck = function(self, card, from_debuff)
		-- Quitamos hands acumuladas y causamos game over si aplica
        dwjokers_blot_hand_mod(card, -card.ability.extra.hand_stack)
    end,
    calculate = function(self, card, context)

		-- Actualización de MULT, solo si no es blueprint
		if context.modify_scoring_hand and not context.blueprint then
			local hand_cards = 0
			
			for _, h_card in ipairs(G.hand.cards) do
				local is_scoring = false
				
				-- Verificamos que la carta no este debuffeada
				-- Comprobamos si ESTA carta de la mano está en la jugada que va a puntuar
				for _, s_card in ipairs(context.full_hand) do
					if h_card == s_card then 
						is_scoring = true
						break 
					end
				end

				-- Si la carta NO va a puntuar (se queda en la mano)
				if not is_scoring then
					hand_cards = hand_cards + 1
				end
			end
			
			-- Guardamos el resultado final multiplicado
			card.ability.extra.mult_stack = hand_cards * card.ability.extra.mult_add
		end

		-- Damos el mult en el joker scoring. Aqui no importa si es blueprint
		if context.joker_main then
			local hand_cards = 0
			
			for _, h_card in ipairs(G.hand.cards) do
				local is_scoring = false
				
				-- Verificamos que la carta no este debuffeada
				-- Comprobamos si ESTA carta de la mano está en la jugada que va a puntuar
				for _, s_card in ipairs(context.full_hand) do
					if h_card == s_card then 
						is_scoring = true
						break 
					end
				end

				-- Si la carta NO va a puntuar (se queda en la mano)
				if not is_scoring then
					hand_cards = hand_cards + 1
				end
			end
			
			-- Guardamos el resultado final multiplicado
			card.ability.extra.mult_stack = hand_cards * card.ability.extra.mult_add
			return {
                mult_mod = card.ability.extra.mult_stack,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_stack } }
            }
		end

        -- Si es Blueprint, ignoramos la lógica de modificar manos para evitar duplicados peligrosos
        if context.blueprint then return end

        -- Inicializamos estado de check update
        local check_update = false
        
        -- Como mecanismo de emergencia, actualizamos al iniciar el blind si no lo hizo antes
        if context.setting_blind then
            check_update = true
        end

        -- Cuando se añade un consumible
        if context.card_added and table_contains(context.card.ability.set, card_types) then
            check_update = true
        end

        -- Cuando el consumible es removido, destruido, vendido o usado
		-- context personalizado para ver que carta ha sido removida y su cardarea antes de ser removida
        if (context.dwjokers_removed and table_contains(context.dwjokers_removed_card.ability.set, card_types) and context.dwjokers_removed_cardarea == G.consumeables) 
        or (context.using_consumeable and table_contains(context.consumeable.ability.set, card_types)) then
            check_update = true
        end

        -- Actualizamos conteo de hands
		if check_update then
			G.E_MANAGER:add_event(Event({
				func = function()

					local new_count = dwjokers_consumable_count()	-- conteo de consumibles
					local diff = new_count - card.ability.extra.hand_stack
					
					if diff ~= 0 then
						card.ability.extra.hand_stack = new_count
						dwjokers_blot_hand_mod(card, diff)	-- aplicamos modificador de hands
					end
					return true
				end,
				blocking = false
			}))
		end

    end
}

-- Flutter
-- la mas facil de todas :b
SMODS.Joker {
	key = 'Flutter',
	loc_txt = {
		name = 'Flutter',
		text = {
			"{X:chips,C:white}X#1#{} Chips."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 5, y = 3 },
	cost = 10,
	attributes = {'xchips', 'passive'},
	config = { extra = {xchips = 5} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.xchips} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)
		
		if context.joker_main then
			-- daria igual si fuera 5 Xmult pero shhh
			return {
                xchips = card.ability.extra.xchips
            }
		end	

	end
}

-- Gigi
SMODS.Joker {
	key = 'Gigi',
	loc_txt = {
		name = 'Gigi',
		text = {
			"Gives {C:green}#1# to #2#{C:attention} playing cards",
			"with random {C:attention}Enhancement{},",
			"{C:attention}Edition{} and{C:attention} Seal",
			"when {C:attention}blind{} is selected."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 4, y = 3},
	cost = 10,
	attributes = {'enhancements', 'seals', 'editions', 'generation'},
	config = { extra = { creates = 3, in_game = false } },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.creates,
            'dwjokers_GIGI_IS_GIVING_FREE_CARDS_CMON_EVERYONE_LETS_GO!!!')
		return { vars = { numerator, denominator} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.in_game = true
	end,
    calculate = function(self, card, context)
		
		if context.setting_blind then
			-- Aprovechamos el get_probability_vars para que Gigi sea compatible con
			-- cambios globales de probabilidad
			local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.creates,
            'dwjokers_GIGI IS GIVING FREE CARDS EVERYONE CMON LETS GO!!!')
			local create_cards = math.max(numerator, math.ceil(pseudorandom("dwjokers_Gigi_LETS FLIP A COIN!", 0, denominator) ) )
			for i=1, create_cards do
				local random_edition = SMODS.poll_edition { key = "dwjokers_Gigi_MAKE IT SHINY!", guaranteed = true, no_negative = true }
				local random_seal = SMODS.poll_seal {key = "dwjokers_Gigi_UHHH A SEAL. NEAT!", guaranteed = true}
				SMODS.add_card { set = "Enhanced", edition = random_edition, seal = random_seal }
			end
			return {
				message = 'Yoink!',
				colour = G.C.CHIPS,
				card = card
			}
		end

	end,
	draw = function(self, card, layer)

		-- hace que el sprite de gigi cambie entre normal y L aleatoriamente con el tiempo
		if card.ability.extra.in_game then
			if pseudorandom("dwjokers_Gigi_Gambling_JACKPOT") > 0.99 then
				local gigi_state = {}
				if card.children.center.sprite_pos.x == G.dwjokers_gigi_state_sprites[1].x then 
					gigi_state = G.dwjokers_gigi_state_sprites[2]
				else
					gigi_state = G.dwjokers_gigi_state_sprites[1]
				end
				card:set_sprites({set = card.config.center.set, atlas = card.config.center.atlas, pos = gigi_state}, nil)
			end
		end

		-- este hace que gigi aparezca con un sprite random que no cambie con el tiempo
		--local gigi_state, gigi_index = pseudorandom_element(G.dwjokers_gigi_state_sprites, "dwjokers_Gigi_Gambling_JACKPOT")
		--card.config.center.pos = gigi_state
	end	
}

-- Glisten
SMODS.Joker {
	key = 'Glisten',
	loc_txt = {
		name = 'Glisten',
		text = {
			"Swaps current {C:chips}Chips{}",
			"and {C:mult}Mult{} values with",
			"each other."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 5, y = 1 },
	cost = 10,
	attributes = {'swap'},
	set_card_type_badge = function(self, card, badges)
		-- hace que el color de la badge corresponda a su rareza actual
		local color = G.C.RARITY[card.config.center.rarity]

		-- badge de rareza personalizada que dice "Perfect!" porque Glisten :b
		-- esto solo es decorativo y no cambia la rareza real de Glisten
		badges[#badges+1] = create_badge('Perfect!', color, G.C.WHITE, 1.2)
 	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		card:set_edition("e_holo")
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card:set_edition("e_holo")
	end,
    calculate = function(self, card, context)
		
		if context.joker_main then
			return {swap = true, no_retrigger = true,
				message = "Looking good!",
				colour = G.C.PINK,
				card = card
			}
		end

	end
}

-- Goob
SMODS.Joker {
	key = 'Goob',
	loc_txt = {
		name = 'Goob',
		text = {
			"Protects all {C:attention}jokers{} in your",
			"deck from being destroyed.",
			"{C:inactive}(Itself included, doesn't include",
			"{C:red,E:2}self destructives{C:inactive})"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = true,
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 0, y = 2 },
	cost = 10,
	attributes = {'passive'},
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	calculate = function(self, card, context)

		-- Contexto personalizado que se activa cuando una carta es destruida
		if context.dwjokers_saved_by_goob and not context.dwjokers_saved_by_goob_card.being_sold then
			SMODS.calculate_effect({ message = 'Hug time!', instant = true}, card)
			return { no_destroy = true}
		end
    end
}

-- Scraps
SMODS.Joker {
	key = 'Scraps',
	loc_txt = {
		name = 'Scraps',
		text = {
			"{C:attention}Scoring cards{} return",
			"to your deck after",
			"each played hand."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 5, y = 0 },
	cost = 10,
	attributes = {'passive', 'modify_card'},
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)

		if context.individual and context.cardarea == G.play then
			context.other_card.ability.dwjokers_scrapped = true
		end

		if context.after then
			return {
				message = 'Goob would be so impressed!',
				colour = G.C.CHIPS,
				card = card
			}
		end	

	end
}

-- Squirm
SMODS.Joker {
	key = 'Squirm',
	loc_txt = {
		name = 'Squirm',
		text = {
			"Before each hand, destroys",
			"{C:attention}#3#{} random {C:attention}consumable{}",
			"in your possesion and",
			"gains {X:mult,C:white}X#1#{} Mult",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 6, y = 2 },
	cost = 10,
	attributes = {'destroy_card', 'xmult', 'scaling'},
	config = { extra = { xmult_gain = 0.2, xmult_stack = 1, cards_to_destroy = 1} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.xmult_gain, card.ability.extra.xmult_stack, card.ability.extra.cards_to_destroy} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)

		if context.before then
			-- inicializamos cartas elegibles, que son las que no esten getting sliced
			-- ni que hayan sido removidas ya, para evitar que la misma carta se destruya dos veces
			local eligible_cards = {}
			local to_destroy = {}
			for k, v in ipairs(G.consumeables.cards) do
				if not v.getting_sliced and not v.removed then
					table.insert(eligible_cards, v)
				end
			end
			
			-- elegimos las cartas que Squirm consumira
			for i=1, card.ability.extra.cards_to_destroy do
				if #eligible_cards >0 then
					local random_card, index = pseudorandom_element(eligible_cards, "dwjokers_Squirm")
					random_card.getting_sliced = true -- no se si SMODS.destroy_cards lo establece ya la verdad
					table.insert(to_destroy, random_card)
					table.remove(eligible_cards, index)
					card.ability.extra.xmult_stack = card.ability.extra.xmult_stack + card.ability.extra.xmult_gain
				end
			end

			if #to_destroy > 0 then
				SMODS.destroy_cards(to_destroy)
				return {
					message = '...I-I feel a bit better.',
					colour = G.C.CHIPS,
					card = card
				}
			end
		end

		if context.joker_main then
			return {
					xmult = card.ability.extra.xmult_stack
			}
		end	

	end
}

-- Coal
-- quizas la toon mas compleja de todos.
SMODS.Joker {
	key = 'Coal',
	loc_txt = {
		name = 'Coal',
		text = {
			"See the content of {C:attention}Booster Packs{}",
			"in the {X:black,C:white}PREDICTIONS{} menu",
			"by clicking this {X:edition}Toon{} while",
			"in {C:attention}shop by hovering over",
			"the {C:attention}Booster Pack{}."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 4, y = 2 },
	cost = 7,
	config = { extra = { update = true } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.update } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		-- Coal existe, para poder predecir
		G.GAME.dwjokers_coal_exists = true
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.dwjokers_coal_prediction_area.cards = {}
		-- revisamos que no queden Coals entre los jokers
		for _, joker in ipairs(G.jokers.cards) do
			if joker.config.center.key == "j_dwjokers_Coal" and joker ~= card then
				return
			end	
		end
		G.GAME.dwjokers_coal_exists = false
	end,	
	calculate = function(self, card, context)
		
		-- contexto personalizado que se activa si pasas el cursor sobre un booster pack
		-- revisamos ademas que este en la tienda.
		if context.dwjokers_hovered and not context.open_booster and 
		context.dwjokers_hovered_card.ability.set == "Booster" and G.shop then
			
			local hovered_card = context.dwjokers_hovered_card
			local to_area = hovered_card.dwjokers_coal_to_area or nil
			

			-- NO RECUERDO QUE HICE AQUI OKEY, HABRA QUE HACER INGENIERIA INVERSA A ESTA MADRE
			if to_area then
				-- 1. Limpiar el área correctamente
				for i = #to_area.cards, 1, -1 do
					to_area.cards[i]:remove()
				end
				to_area.cards = {}

				-- 2. Encontrar el índice correcto comparando contra cada carta de la tienda
				local index = 1
				for i = 1, #G.shop_booster.cards do
					-- AQUÍ ESTABA EL ERROR: Accedemos a la carta [i] de la tienda
					if hovered_card.coal_flag == G.shop_booster.cards[i].coal_flag then
						index = i
						break -- Detenemos el ciclo una vez encontrado
					end 
				end 

				-- 3. Dibujar las predicciones del índice encontrado
				if G.GAME.dwjokers_predicted_cards[index] then
					hovered_card.prediction_active = true
					for i = 1, #G.GAME.dwjokers_predicted_cards[index] do
						local card_to_copy = G.GAME.dwjokers_predicted_cards[index][i]
						-- Creamos la copia visual para el área de predicción
						local new_card = copy_card(card_to_copy, nil, nil, card_to_copy.playing_card)
						new_card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 2*G.SETTINGS.GAMESPEED)
						to_area:emplace(new_card)
						new_card.coal_flag = true
					end 
				end
			end
		end

		-- removemos el boton de predictions y reiniciamos el cardarea al abrir un booster
		if context.open_booster then
			G.dwjokers_coal_prediction_area.cards = {}
			if card.children.dwjokers_my_button_3 then
				card.children.dwjokers_my_button_3:remove()
				card.children.dwjokers_my_button_3 = nil
			end
		end	

		-- ditto, al terminar la tienda
		if context.ending_shop then
			G.dwjokers_coal_prediction_area.cards = {}
			if card.children.dwjokers_my_button_3 then
				card.children.dwjokers_my_button_3:remove()
				card.children.dwjokers_my_button_3 = nil
			end
		end	

		-- ditto, al comprar una carta
		if context.buying_card then
			G.dwjokers_coal_prediction_area.cards = {}
		end	

		
	end
}

-- Cocoa
SMODS.Joker {
	key = 'Cocoa',
	loc_txt = {
		name = 'Cocoa',
		text = {
			"Retriggers all {X:edition}Toons{}",
			"during {C:attention}joker scoring{}."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 5, y = 4 },
	cost = 10,
	attributes = {'retrigger', 'passive'},
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)
		
		if context.retrigger_joker_check and context.other_context.joker_main then
			if dwjokers_is_toon(context.other_card) then
				return { repetitions = 1 }
			end	
		end


	end
}

-- Eclipse
SMODS.Joker {
	key = 'Eclipse',
	loc_txt = {
		name = 'Eclipse',
		text = {
			"{X:mult,C:white}X#1#{} Mult on",
			"{C:attention}boss blinds.",
			"{C:inactive}(Currently {C:attention}#2#{C:inactive})",
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 3, y = 2 },
	cost = 7,
	attributes = {'xmult', 'boss_blind'},
	config = { extra = { xmult = 10, eclipse_active_string = 'inactive', is_boss = false } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.eclipse_active_string, card.ability.extra.is_boss, G.GAME.blind } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.is_boss = G.GAME.blind:get_type() == "Boss"
		if card.ability.extra.is_boss then
			card.ability.extra.eclipse_active_string = 'active'
		else
			card.ability.extra.eclipse_active_string = 'inactive'
		end
	end,
	calculate = function(self, card, context)
		
		if context.setting_blind then
			card.ability.extra.is_boss = G.GAME.blind:get_type() == "Boss"
			if card.ability.extra.is_boss then
				card.ability.extra.eclipse_active_string = 'active'
			else
				card.ability.extra.eclipse_active_string = 'inactive'
			end
		end	

		if context.joker_main and card.ability.extra.is_boss then
			return {
				xmult = card.ability.extra.xmult
			}
		end

		if context.end_of_round and context.main_eval and card.ability.extra.is_boss then
			card.ability.extra.eclipse_active_string = 'inactive'
		end
	end

}


--- MAINS

-- Astro
SMODS.Joker {
	key = 'Astro',
	loc_txt = {
		name = 'Astro',
		text = {
			"Upgrades {C:attention}+#1#{} levels all",
			"the {C:attention}Poker Hands{} after",
			"each hand while you have",
			"this {X:edition}Toon{} in your possesion.",
			"{C:inactive}(Currently {C:attention}+#2#{C:inactive} levels)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Main",
	atlas = 'Mains',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
	cost = 20,
	attributes = {'scaling', 'space'},
	config = { extra = { level_up = 1, total_levels = 0 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_dwjokers_light_producing_1
		return { vars = { card.ability.extra.level_up, card.ability.extra.total_levels } }
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = get_lightprod_badge(G)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	remove_from_deck = function(self, card, from_debuff)
		update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = '-', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = '-', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '-' .. card.ability.extra.total_levels })
        delay(1.3)
        SMODS.upgrade_poker_hands({ instant = true, from = card, level_up = - card.ability.extra.total_levels })
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
	end,
    calculate = function(self, card, context)
		if context.before then
		update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+' .. card.ability.extra.level_up })
        delay(1.3)
        SMODS.upgrade_poker_hands({ instant = true, from = card, level_up = card.ability.extra.level_up })
		card.ability.extra.total_levels = card.ability.extra.total_levels + card.ability.extra.level_up
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
		end
	end
}

-- Pebble
-- un poco hecho a la carrera, intentare optimizar su codigo en un futuro
SMODS.Joker {
	key = 'Pebble',
	loc_txt = {
		name = 'Pebble',
		text = {
			"See {C:attention}+#1#{} of the next",
			"playing cards to draw ",
			"from your deck in the {X:black,C:white}PREDICTIONS{} menu",
			"by clicking this {X:edition}Toon{} while",
			"in {C:attention}Blind{} or in {C:attention}Shop{}"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Main",
	atlas = 'Mains',
	pos = { x = 3, y = 0 },
	soul_pos = { x = 3, y = 1 },
	cost = 20,
	config = { extra = {deck_cards = 5} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.deck_cards} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		-- Pebble existe, para poder predecir
		G.GAME.dwjokers_pebble_exists = true
		G.GAME.dwjokers_pebble_cards_to_predict = (G.GAME.dwjokers_pebble_cards_to_predict or 0) + card.ability.extra.deck_cards
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.dwjokers_pebble_prediction_area.cards = {}
		-- revisamos que no queden Coals entre los jokers
		for _, joker in ipairs(G.jokers.cards) do
			if joker.config.center.key == "j_dwjokers_Pebble" and joker ~= card then
				return
			end	
		end
		G.GAME.dwjokers_pebble_exists = false
		G.GAME.dwjokers_pebble_cards_to_predict = G.GAME.dwjokers_pebble_cards_to_predict - card.ability.extra.deck_cards
	end,	
    calculate = function(self, card, context)
        
		-- removemos el boton de predictions y reiniciamos el cardarea al tomar cartas
		if context.drawing_cards then
			G.dwjokers_pebble_prediction_area.cards = {}
			if card.children.dwjokers_my_button_4 then
				card.children.dwjokers_my_button_4:remove()
				card.children.dwjokers_my_button_4 = nil
			end
		end

		-- ditto, antes de cada mano
		if context.before then
			G.dwjokers_pebble_prediction_area.cards = {}
			if card.children.dwjokers_my_button_4 then
				card.children.dwjokers_my_button_4:remove()
				card.children.dwjokers_my_button_4 = nil
			end
		end

		-- ditto, al descartar cartas
		if context.pre_discard then
			G.dwjokers_pebble_prediction_area.cards = {}
			if card.children.dwjokers_my_button_4 then
				card.children.dwjokers_my_button_4:remove()
				card.children.dwjokers_my_button_4 = nil
			end
		end	

		

    end
}

-- Shelly
SMODS.Joker {
	key = 'Shelly',
	loc_txt = {
		name = 'Shelly',
		text = {
			"{X:mult,C:white}X#1#{} Mult for each",
			"{X:edition}Toon{} in your possesion.",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Main",
	atlas = 'Mains',
	pos = { x = 4, y = 0 },
	soul_pos = { x = 4, y = 1 },
	cost = 20,
	attributes = {'xmult', 'scaling'},
	config = { extra = {xmult_add = 7.5, xmult_stack = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.xmult_add, card.ability.extra.xmult_stack} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.xmult_stack = 0
		for _, joker in ipairs(G.jokers.cards) do
			if (joker.config.center.pools or {}).dwjokers_toons then
				card.ability.extra.xmult_stack = card.ability.extra.xmult_stack + card.ability.extra.xmult_add
			end	
		end
		if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
			for _, joker in ipairs(G.dwjokers_bassie_basket) do
				if (joker.config.center.pools or {}).dwjokers_toons then
					card.ability.extra.xmult_stack = card.ability.extra.xmult_stack + card.ability.extra.xmult_add
				end	
			end
		end
	end,
    calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			card.ability.extra.xmult_stack = 0
			for _, joker in ipairs(G.jokers.cards) do
				if (joker.config.center.pools or {}).dwjokers_toons then
					card.ability.extra.xmult_stack = card.ability.extra.xmult_stack + card.ability.extra.xmult_add
				end	
			end
			if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
				for _, joker in ipairs(G.dwjokers_bassie_basket) do
					if (joker.config.center.pools or {}).dwjokers_toons then
						card.ability.extra.xmult_stack = card.ability.extra.xmult_stack + card.ability.extra.xmult_add
					end	
				end
			end	
		end

		if context.card_added or (context.dwjokers_removed and context.dwjokers_removed_card.ability.set == "Joker") and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					card.ability.extra.xmult_stack = 0
					for _, joker in ipairs(G.jokers.cards) do
						if (joker.config.center.pools or {}).dwjokers_toons then
							card.ability.extra.xmult_stack = card.ability.extra.xmult_stack + card.ability.extra.xmult_add
						end	
					end
					if G.dwjokers_bassie_basket and G.dwjokers_bassie_basket.cards and G.GAME.dwjokers_bassie_exists then
						for _, joker in ipairs(G.dwjokers_bassie_basket) do
							if (joker.config.center.pools or {}).dwjokers_toons then
								card.ability.extra.xmult_stack = card.ability.extra.xmult_stack + card.ability.extra.xmult_add
							end	
						end	
					end
					return true
				end,
				blocking = false
			}))
		end

		if context.joker_main then
			return {
					xmult = card.ability.extra.xmult_stack
			}
		end	
	end
}

-- Sprout
SMODS.Joker {
	key = 'Sprout',
	loc_txt = {
		name = 'Sprout',
		text = {
			"When {C:attention}blind{} is selected",
			"creates a {C:dark_edition}negative",
			"{C:attention}Cosmo {X:edition}Toon{} card."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Main",
	atlas = 'Mains',
	pos = { x = 0, y = 2 },
	soul_pos = { x = 0, y = 3 },
	cost = 20,
	attributes = {'generation', 'prevents_death', 'food'},
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)
		if context.setting_blind then
			SMODS.add_card{ key = "j_dwjokers_Cosmo", edition = "e_negative" }
			return { 
				message = 'Fresh out of the oven!',
				colour = G.C.RED,
				card = card}
		end

		-- explota si vendes a Cosmo. No aviso de esto en la descripcion jeje
		if context.selling_card then
			if context.card.config.center.key == "j_dwjokers_Cosmo" then
				card:explode()
			end
		end	
	end
}

-- Vee
SMODS.Joker {
	key = 'Vee',
	loc_txt = {
		name = 'Vee',
		text = {
			"Unlock {C:green}VEE'S SUPER MENU",
			"to add {C:attention}+#1#{} random permanent",
			"upgrade between the",
			"selected ones while you have",
			"this {X:edition}Toon{} in your possesion."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Main",
	atlas = 'Mains',
	pos = { x = 1, y = 2 },
	soul_pos = { x = 1, y = 3 },
	cost = 20,
	attributes = {'hands', 'discard', 'hand_size', 'joker_slot', 'scaling'},
	config = { extra = { upgrades = 1, -- numero de veces que ha dado algun bonus
		total_upgrades = {
			hands = 0,			-- manos extras
			discards = 0,		-- discards extras
			hand_size = 0,		-- ditto, hand size
			jokers = 0,			-- espacios para jokers
			consumables = 0,	-- ditto, consumibles
			cardslots = 0,		-- ditto, cartas en tienda
			boosters = 0,		-- ditto, de booster packs
			vouchers = 0		-- ditto, de vouchers
		}
	}},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_dwjokers_light_producing_1
		return { vars = { card.ability.extra.upgrades, card.ability.extra.total_upgrades } }
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = get_lightprod_badge(G)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)

		-- asignamos key unica para esta vee
		local vees = #SMODS.find_card('j_dwjokers_Vee')
		local key = 'vee_version_' .. tostring(vees)

		-- tabla unica para esta vee donde se guardaran las opciones activadas
		-- esto para los super menus de vee
		if not G.GAME.dwjokers_vee_table then G.GAME.dwjokers_vee_table = {} end
		G.GAME.dwjokers_vee_table[key] = {}
		card.ability.dwjokers_vee_key = key

		-- Aplica si Vee fue copiada. Re aplica los bonus de la original.
		dwjokers_vee_bonus(card, "re-apply")	
		G.GAME.dwjokers_vee_exists = true
	end,
	remove_from_deck = function(self, card, from_debuff)

		-- limpiamos tabla de esta vee
		G.GAME.dwjokers_vee_table[card.ability.dwjokers_vee_key] = nil

		-- Se remueven los bonus de esta Vee en particular
		dwjokers_vee_bonus(card, "remove")

		-- Verificamos si quedan Vees
		for _, joker in ipairs(G.jokers.cards) do
			if joker.config.center.key == "j_dwjokers_Vee" and joker ~= card then
				return
			end	
		end
		G.GAME.dwjokers_vee_exists = false
	end,
	calculate = function(self, card, context)

		if context.ending_shop then
			dwjokers_vee_bonus(card, "apply")
		end
	end	
}

-- Bobette
SMODS.Joker {
	key = 'Bobette',
	loc_txt = {
		name = 'Bobette',
		text = {
			"{X:attention,C:white}X#1#{} to all {C:attention}listed",
			"{X:mult,C:white}Mult{} and {X:chips,C:white}Chips",
			"of {X:edition}Toon{C:attention} Jokers{} in your deck."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Main",
	atlas = 'Mains',
	pos = { x = 2, y = 2 },
	soul_pos = { x = 2, y = 3 },
	cost = 20,
	attributes = {'mult', 'chips', 'xmult', 'xchips', 'passive'},
	config = { extra = { bonus = 2} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.bonus} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)

		G.GAME.dwjokers_bobette_bonus = card.ability.extra.bonus 

		-- Buscamos a todos los Toons y les aplicamos UNA capa de bonus
		for _, v in ipairs(G.jokers.cards) do
			if dwjokers_is_toon(v) and v ~= card then
				dwjokers_apply_bobette_bonus(v, true, nil)
			end
		end
		-- Aplicamos tambien a los toons en la basket de bassie
		for _, v in ipairs(G.dwjokers_bassie_basket.cards) do
			if dwjokers_is_toon(v) and v ~= card then
				dwjokers_apply_bobette_bonus(v, true, nil)
			end
		end 
	end,
	remove_from_deck = function(self, card, from_debuff)
		-- Quitamos UNA capa de bonus a todos los Toons
		for _, v in ipairs(G.jokers.cards) do
			if dwjokers_is_toon(v) and v ~= card then
				dwjokers_apply_bobette_bonus(v, nil, true)
			end
		end
		-- Quitamos tambien a los toons en la basket de bassie
		for _, v in ipairs(G.dwjokers_bassie_basket.cards) do
			if dwjokers_is_toon(v) and v ~= card then
				dwjokers_apply_bobette_bonus(v, nil, true)
			end
		end
	end,	
    calculate = function(self, card, context)

		if context.card_added and not context.blueprint then
			local added_card = context.card

			-- Si la carta es una copia de otra ya buffeada, no aplicamos buffeos
			if not (added_card.ability.dwjokers_bobette_stacks and added_card.ability.dwjokers_bobette_stacks > 0) then


				local bobettes = SMODS.find_card('j_dwjokers_Bobette')

				if dwjokers_is_toon(added_card) and card == bobettes[1] then
					
					-- Contamos Bobettes activas
					local active_bobettes = 0
					for _, b in ipairs(bobettes) do
						if not b.debuff then active_bobettes = active_bobettes + 1 end
					end

					if added_card ~= card then
						for i=1, active_bobettes do
							dwjokers_apply_bobette_bonus(added_card, true, nil)
						end
					end
				end
			end
		end 
	end

}

-- Bassie 
SMODS.Joker {
	key = 'Bassie',
	loc_txt = {
		name = 'Bassie',
		text = {
			"{X:blue,C:white}Save{} up to {C:attention}+#1#{} cards of",
			"any type that you can",
			"{X:blue,C:white}Retrieve{} at any moment."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Main",
	atlas = 'Mains',
	pos = { x = 3, y = 2 },
	soul_pos = { x = 3, y = 3 },
	cost = 20,
	config = { extra = { save_cards = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.save_cards } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		G.dwjokers_bassie_basket.config.card_limit = G.dwjokers_bassie_basket.config.card_limit + card.ability.extra.save_cards
		G.GAME.dwjokers_bassie_exists = true
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.dwjokers_bassie_basket.config.card_limit = G.dwjokers_bassie_basket.config.card_limit - card.ability.extra.save_cards
		for _, joker in ipairs(G.jokers.cards) do
			if joker.config.center.key == "j_dwjokers_Bassie" and joker ~= card then
				return
			end	
		end

		G.GAME.dwjokers_bassie_exists = false
	end
}

-- Gourdy
SMODS.Joker {
	key = 'Gourdy',
	loc_txt = {
		name = 'Gourdy',
		text = {
			"Balance {C:chips}Chips{} and",
			"{C:mult}Mult{} when calculating",
			"score for playing hand."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Main",
	atlas = 'Mains',
	pos = { x = 4, y = 2 },
	soul_pos = { x = 4, y = 3 },
	cost = 20,
	attributes = {'balance', 'food'},
	set_badges = function(self, card, badges)
		badges[#badges+1] = get_lightprod_badge(G)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_dwjokers_light_producing_1
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			return {balance = true, no_retrigger = true}
		end
	end
}


--- LETALES

-- Dandy (TOON)
SMODS.Joker {
	key = 'Dandy',
	loc_txt = {
		name = 'Dandy',
		text = {
			"At the end of {C:attention}each shop,",
			"if you bought something,",
			"creates {C:attention}#1#{} random {X:edition}Toon{C:attention} card",
			"{C:inactive}(Dandy nor Dyle included)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Leader",
	atlas = 'Mains',
	pos = { x = 1, y = 0 },
	soul_pos = { x = 1, y = 1 },
	cost = 20,
	attributes = {'generation'},
	config = { extra = {creates = 1, toon_give = false, twisted_count = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.creates, card.ability.extra.toon_give, card.ability.extra.twisted_count } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)

		-- al comprar cualquier cosa en la tienda, reiniciamos el contador de twisted
		if context.buying_card then
			card.ability.extra.toon_give = true

			-- Si era mayor a 0, reiniciamos la fase de Dandy y hace un comentario
			if card.ability.extra.twisted_count > 0 then
				card.ability.extra.twisted_count = 0
				return {
					message = "Now that's more like it.",
					colour = G.C.BLUE,
					card = card
				}
			end
		end

		-- al finalizar la tienda, si compraste algo y tienes espacio agrega un toon random
		if context.ending_shop and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
			if card.ability.extra.toon_give then
				local jokers_to_create = math.min(1,
				G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
				G.E_MANAGER:add_event(Event({
					func = function()
						for _ = 1, jokers_to_create do
							SMODS.add_card {
								set = "dwjokers_toons_regular",
								key_append = 'dwjokers_dandy',
								soulable = true 
							}
							G.GAME.joker_buffer = 0
						end
						return true
					end
				}))
				card.ability.extra.toon_give = false
				return {
					message = "Good luck, friend!",
					colour = G.C.BLUE,
					card = card
				}
			else
				-- si no compraste nada, aumentamos la fase de dandy
				card.ability.extra.twisted_count = card.ability.extra.twisted_count + 1

				-- si la fase es 3 o mayor, hay probabilidad de que se convierta en twisted
				if card.ability.extra.twisted_count > 3 then
					if SMODS.pseudorandom_probability(card, 'dwjokers_twisted_dandy', card.ability.extra.twisted_count, 10) then
						card:set_ability("j_dwjokers_Dandy_twisted")
					end
				end

				-- si no se transforma en twisted, hace un comentario
				return {
						message = "Just buy something already.",
						colour = G.C.BLUE,
						card = card
				}
			end
        end

	end
}

-- Dyle (TOON)
SMODS.Joker {
	key = 'Dyle',
	loc_txt = {
		name = 'Dyle',
		text = {
			"Gains {X:mult,C:white}X#1#{} Mult",
			"for everything bought in shop.",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Leader",
	atlas = 'Mains',
	pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 1 },
	cost = 20,
	attributes = {'xmult', 'economy', 'scaling'},
	config = { extra = { xmult_gain = 0.5, xmult = 1, twisted_count = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult, card.ability.extra.twisted_count } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)

		-- cada que compres algo, gana xmult
		if context.buying_card then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
			return {
						message = "What a wise decision, enjoy!",
						colour = G.C.BLUE,
						card = card
			}
		end

		-- cada discard y mano jugada, aumenta en 1% la probabilidad de convertirse en twisted
		if context.pre_discard or context.before then
			card.ability.extra.twisted_count = card.ability.extra.twisted_count + 1
		end

		if context.joker_main then

			-- vemos si se convierte en twisted
			if SMODS.pseudorandom_probability(card, 'dwjokers_twisted_dyle', card.ability.extra.twisted_count, 100) then
				card:set_ability("j_dwjokers_Dyle_twisted")
			end

			return {
				xmult = card.ability.extra.xmult
			}
		end
	end
}

-- Dandy (TWISTED)
SMODS.Joker {
	key = 'Dandy_twisted',
	loc_txt = {
		name = 'Twisted Dandy',
		text = {
			"Can't be sold nor destroyed.",
			"When {C:attention}Blind{} is selected,",
			"destroys one random {X:edition}Toon{}.",
			"Returns to his {X:edition}Toon{} form after",
			"spending {C:money}$#1#{} in shop",
			"{C:inactive}(Currently {C:money}$#2#/$#1#{C:inactive} spent)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Lethal",
	atlas = 'Mains',
	pos = { x = 5, y = 0 },
	soul_pos = { x = 5, y = 1 },
	cost = 20,
	attributes = {'destroy_card', 'economy'},
	config = { extra = {money = 100, money_spent = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money, card.ability.extra.money_spent } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)

		-- al comprar cualquier cosa en la tienda, lo sumamos al dinero gastado
		if context.buying_card then
			card.ability.extra.money_spent = card.ability.extra.money_spent + context.card.cost
			
			-- si llegas a la meta de dinero, vuelve a ser Dandy normal
			if card.ability.extra.money_spent > card.ability.extra.money then
				card:set_ability("j_dwjokers_Dandy")
				return {
						message = "Let's just say you saw nothing.",
						colour = G.C.BLUE,
						card = card
				}		
			end
		end

		-- evitamos que la destruyan
		if context.joker_type_destroyed and context.card == card then
			return{
				no_destroy = true
			}
		end
		
		-- destruimos un toon random (parecido a madness pero solo con toons)
		if context.setting_blind and not context.blueprint and not context.blind.boss then
            local destructable_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced
				and (G.jokers.cards[i].config.center.pools or {}).dwjokers_toons then
                    destructable_jokers[#destructable_jokers + 1] =
                        G.jokers.cards[i]
                end
            end
            local joker_to_destroy = pseudorandom_element(destructable_jokers, 'dwjokers_twisted_Dandy')

            if joker_to_destroy then
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
        	end
        end

	end
}

-- Dyle (TWISTED)
SMODS.Joker {
	key = 'Dyle_twisted',
	loc_txt = {
		name = 'Twisted Dyle',
		text = {
			"Can't be sold nor destroyed.",
			"When {C:attention}Blind{} is selected,",
			"destroys one random {X:edition}Toon{}.",
			"Gains {X:mult,C:white}X#1#{} Mult for",
			"every {X:edition}Toon{C:attention} card destroyed",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Lethal",
	atlas = 'Mains',
	pos = { x = 5, y = 2 },
	soul_pos = { x = 5, y = 3 },
	cost = 20,
	attributes = {'destroy_card', 'xmult', 'scaling'},
	config = { extra = { xmult_gain = 2, xmult = 1, twisted_count = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult, card.ability.extra.twisted_count } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)

		-- cada que un toon se destruya, gana xmult
		if context.joker_type_destroyed and not context.blueprint then
            local toon_cards = 0
            if dwjokers_is_toon(context.card) then toon_cards = toon_cards + 1 end
            if toon_cards > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + toon_cards * card.ability.extra.xmult_gain
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
            end
        end

		-- evitamos que la destruyan
		if context.joker_type_destroyed and context.card == card then
			return{
				no_destroy = true
			}
		end

		-- cada discard y mano jugada, aumenta en 1% la probabilidad de volver a toon
		if context.pre_discard or context.before then
			card.ability.extra.twisted_count = card.ability.extra.twisted_count + 1
		end

		-- destruir un toon random
		if context.setting_blind and not context.blueprint and not context.blind.boss then
            local destructable_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced
				and (G.jokers.cards[i].config.center.pools or {}).dwjokers_toons then
                    destructable_jokers[#destructable_jokers + 1] =
                        G.jokers.cards[i]
                end
            end
            local joker_to_destroy = pseudorandom_element(destructable_jokers, 'dwjokers_twisted_Dyle')

            if joker_to_destroy then
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
        	end
        end

        if context.joker_main then

			-- vemos si se convierte en toon
			if SMODS.pseudorandom_probability(card, 'dwjokers_twisted_dyle', card.ability.extra.twisted_count, 100) then
				card:set_ability("j_dwjokers_Dyle")
			end

            return {
                xmult = card.ability.extra.xmult
            }
        end
	end
}


------------ TOON DIALOGUES ------------

-- Los dialogos entre toons tienen la siguiente estructura:

-- toons_dialogues['toon1_toon2']: es donde se guardaran los dialogos entre toon1 y toon2.
-- toon1 y toon2 deben estar en orden alfabetico

-- toons_dialogues['toon']: es donde se guardaran los dialogos solitarios de toon
-- el resto de la estructura es igual tanto para parejas como solitarios

-- Los dialogos se indexan de la forma [1], [2], etc..

-- Cada dialogo consiste de una lista de tablas de la forma: {origin, dialogue, duration}
-- origin: number, que toon dira el dialogo (1 es toon1 o toon, 2 es toon2, default es 1)
-- dialogue: string, el dialogo en si
-- duration: number, el tiempo que el dialogo durara en segundos (opcional, default es 3)

local toons_dialogues = {
	
	-- DIALOGOS SOLITARIOS

	['Astro'] = {
		[1] = {{dialogue = 'Am I dreaming?'}},
		[2] = {{dialogue = 'I wish it wasnt so noisy...'}},
		[3] = {{dialogue = 'My nap will have to wait..'}},
	},

	['Bassie'] = {
		[1] = {{dialogue = 'Doing my part, Im doing my part...'},{dialogue = 'doing my part!'}},
		[2] = {{dialogue = 'Glad thats finished...'}},
		[3] = {{dialogue = 'Is one of my flowers wilted?'}},
	},

	['Blot'] = {
		[1] = {{dialogue = '!rehtruf nwod gnioG'}},
		[2] = {{dialogue = '?tey revo ti sI'}},
	},


	['Bobette'] = {
		[1] = {{dialogue = 'Honestly Im just happy to be here!'}},
		[2] = {{dialogue = 'I feel so festive!'}},
		[3] = {{dialogue = 'This sweater is a little itchy...'}},
	},

	['Boxten'] = {
		[1] = {{dialogue = 'I think I heard something...'}},
		[2] = {{dialogue = 'Im scared to think of whats in the next Blind...'}},
		[3] = {{dialogue = 'I think I forgot something last Blind...'}},
	},

	['Brightney'] = {
		[1] = {{dialogue = 'I cant wait to get to reading after this!'}},
		[2] = {{dialogue = 'Im gonna be late for Book Club!'}},
		[3] = {{dialogue = 'Is my lightbulb flickering?'}},
	},

	['Brusha'] = {
		[1] = {{dialogue = 'Are my bristles knotted?'}},
		[2] = {{dialogue = 'Id like for this to end sooner than later.'}},
		[3] = {{dialogue = 'Tch... This shop doesnt spark much inspiration.'}},
	},

	['Coal'] = {
		[1] = {{dialogue = 'Bark... Bworf.'}},
		[2] = {{dialogue = 'Bork, bwuff.'}},
		[3] = {{dialogue = 'Bworf... bork.'}},
		[4] = {{dialogue = '. . .Grr.'}},
	},

	['Cocoa'] = {
		[1] = {{dialogue = 'Golly, this is not what I expected to do today!'}},
		[2] = {{dialogue = 'I could go for another Bonbon...'}},
		[3] = {{dialogue = 'Lets hop to it!'}},
	},

	['Connie'] = {
		[1] = {{dialogue = 'Hah... Boo.'}},
		[2] = {{dialogue = 'Thinking about what to haunt after this.'}},
		[3] = {{dialogue = 'Uuugh, another Blind.'}},
	},

	['Cosmo'] = {
		[1] = {{dialogue = 'Do I... smell a burning scent? Uh probably nothing...'}},
		[2] = {{dialogue = 'I wish I was baking right now!'}},
		[3] = {{dialogue = 'Ill admit... Im a bit nervous.'}},
	},

	['Eclipse'] = {
		[1] = {{dialogue = 'AWOOO!!'}},
		[2] = {{dialogue = 'Ive got a scent Im tracking...'}},
	},

	['Eggson'] = {
		[1] = {{dialogue = 'Eggs.'}},
		[2] = {{dialogue = 'I wonder if Dandy hid an egg in here...'}},
		[3] = {{dialogue = 'This is more intense than the last Egg Hunt!'}},
	},

	['Finn'] = {
		[1] = {{dialogue = 'I feel Im a big reason we have so many wet floor signs!'}},
		[2] = {{dialogue = 'Something fishy is going on around here.'}},
		[3] = {{dialogue = 'Where did I put my fish hooks?'}},
	},

	['Flutter'] = {
		[1] = {{dialogue = '!'}},
		[2] = {{dialogue = '!!'}},
		[3] = {{dialogue = '...'}},
		[4] = {{dialogue = '...?'}},
	},

	['Flyte'] = {
		[1] = {{dialogue = 'Phew, really have to stretch my wings!'}},
		[2] = {{dialogue = 'Seriously, I might just lay down when were done here.'}},
		[3] = {{dialogue = 'Wow Im creating tons of memories.'},{dialogue = 'Cant say theyre all great though.'}},
	},

	['Gigi'] = {
		[1] = {{dialogue = 'Hoping for a good souvenir on the next blind!'}},
		[2] = {{dialogue = 'I swear I saw something real shiny last blind.'}},
		[3] = {{dialogue = 'Mewhehe...'}},
	},

	['Ginger'] = {
		[1] = {{dialogue = 'Did I smudge my icing makeup...?'}},
		[2] = {{dialogue = 'Do I smell a scent of cinnamon? Or is it just me?'}},
		[3] = {{dialogue = 'I hope Ill have time to bake after this...'}},
	},

	['Glisten'] = {
		[1] = {{dialogue = 'Goodness! I make this whole thing look easy!'}},
		[2] = {{dialogue = 'Hahahaaa! ...Im fine.'}},
		[3] = {{dialogue = 'I still got it!'}},
		[4] = {{dialogue = 'Nobodys perfect they say... Im the proof theyre wrong!'}},
	},

	['Goob'] = {
		[1] = {{dialogue = 'Im having so much fun!'}},
		[2] = {{dialogue = 'I could use a hug right now!'}},
		[3] = {{dialogue = 'Running arounds got me all tuckered out...'}},
	},

	['Gourdy'] = {
		[1] = {{dialogue = 'That wasnt SO scary...'}},
		[2] = {{dialogue = 'Something spooky is around here...'},{dialogue = 'its me! Im the spooky!'}},
		[3] = {{dialogue = '...I wonder if the next blind has tons of candy.'}},
	},

	['Looey'] = {
		[1] = {{dialogue = 'Haha, happy to be alive!'}},
		[2] = {{dialogue = 'Im actually so excited!'}},
		[3] = {{dialogue = 'This will be remembered as my best act yet!'}},
	},

	['Pebble'] = {
		[1] = {{dialogue = 'Bark Bark!'}},
		[2] = {{dialogue = 'Bark! Arf!'}},
		[3] = {{dialogue = 'Woof! Bark!'}},
		[4] = {{dialogue = '(Sniffing)'}},
	},

	['Poppy'] = {
		[1] = {{dialogue = 'Alright, whats next?'}},
		[2] = {{dialogue = 'Lets go Poppy!'}},
		[3] = {{dialogue = 'Yippee!'}},
	},

	['Razzle n Dazzle'] = {
		[1] = {{dialogue = 'Checking in on you Dazzle.'}, {dialogue = 'You alright? (Im okay.)'}},
		[2] = {{dialogue = 'I think we did so well on that last blind!'},{dialogue = '(If you say so...)'}},
		[3] = {{dialogue = 'I wonder whats on the next Blind?'},{dialogue = '(Do you really want to know?)'}},
		[4] = {{dialogue = 'Oh boy, another Blind!'},{dialogue = '(Oh no, another Blind...)'}},
	},

	['Ribecca'] = {
		[1] = {{dialogue = 'Are all my bones still in place-?'}},
		[2] = {{dialogue = 'I can at least say this whole ordeal has left me inspired.'}},
		[3] = {{dialogue = 'I feel colder than usual...'}},
		[4] = {{dialogue = ''}},
	},
	
	['Rodger'] = {
		[1] = {{dialogue = 'I do not have the time for all of these activities.'}},
		[2] = {{dialogue = 'It would be a great pleasure if...'},{dialogue = 'this was finished sooner rather than later.'}},
		[3] = {{dialogue = 'What more is there to learn about this place?'}},
		[4] = {{dialogue = 'What secrets will the future endeavors contain?'}},
	},

	['Rudie'] = {
		[1] = {{dialogue = 'Happy Holidays!'}},
		[2] = {{dialogue = 'Im ready for more fun!'}},
		[3] = {{dialogue = 'Merry Christmas!'}}
	},

	['Scraps'] = {
		[1] = {{dialogue = 'Did I lose my plastic cup?!'}},
		[2] = {{dialogue = 'Is my tail crumpled?'}},
		[3] = {{dialogue = 'Made it in one piece!'}},
	},

	['Shelly'] = {
		[1] = {{dialogue = 'Hooray, Im not extinct!'}},
		[2] = {{dialogue = 'I could be assembling fossils right now...'}},
		[3] = {{dialogue = 'Is my shell chipped?'}},
	},

	['Shrimpo'] = {
		[1] = {{dialogue = 'I HATE CARDS.'}},
		[2] = {{dialogue = 'I HATE JOKERS A LOT!'}},
		[3] = {{dialogue = 'I HATE BLINDS SO MUCH!!!'}}
	},

	['Soulvester'] = {
		[1] = {{dialogue = 'I am confident this next blind will end in victory.'}},
		[2] = {{dialogue = 'Nothing will stop me for this venture.'}},
	},

	['Sprout'] = {
		[1] = {{dialogue = 'Did I remember to turn off the oven?'},{dialogue = 'Hope so!'}},
		[2] = {{dialogue = 'I wonder if well get a snack break!'}},
		[3] = {{dialogue = 'I could be baking right now.'}},
	},

	['Squirm'] = {
		[1] = {{dialogue = 'Snf... sniffle-'}},
		[2] = {{dialogue = 'W-what if the next blind- IS EVEN WORSE!'}},
		[3] = {{dialogue = 'I-I just wanna lie down…snf- sniffle…'}},
	},

	['Teagan'] = {
		[1] = {{dialogue = 'I wonder what kind of tea I should have after this.'}},
		[2] = {{dialogue = 'I hope my handles still intact.'}},
		[3] = {{dialogue = 'I hope this doesnt take too long.'}},
	},

	['Tisha'] = {
		[1] = {{dialogue = 'I think I missed a spot!'}},
		[2] = {{dialogue = 'This card area is so gross!'},{dialogue = 'It needs like 3 deep cleanings.'}},
		[3] = {{dialogue = 'Wheres my spare feather duster?'}},
	},

	['Toodles'] = {
		[1] = {{dialogue = 'Come on! Lets go!'}},
		[2] = {{dialogue = 'I hope the next room isnt dark'},{dialogue = 'for no reason of course!'}},
		[3] = {{dialogue = 'Stay brave!'}},
	},

	['Vee'] = {
		[1] = {{dialogue = 'Is my microphone tangled?'}},
		[2] = {{dialogue = 'Im gonna need a new motherboard after that.'}},
		[3] = {{dialogue = 'Question 1: Is this a waste of my time? Probably.'}},
		[4] = {{dialogue = 'This would be the perfect time for a commercial!'}},
	},

	['Yatta'] = {
		[1] = {{dialogue = 'PHEW! Good thing my tail hasnt been TANGLED!'}},
		[2] = {{dialogue = 'Did I drop candy ANYWHERE in the shop?'}},
		[3] = {{dialogue = 'AHAHAHAaaa... Thought of something funny!'}},
	},


	-- DIALOGOS EN PAREJA

	['Astro_Bassie'] = {
		[1] = {
			{origin = 1, dialogue = 'Bassie...You know were here to support you.'},
			{origin = 2, dialogue = 'I-if this is about my dreams... STAY OUT!'},
			{origin = 1, dialogue = 'Wha... what?'},
			{origin = 2, dialogue = 'You heard me, stay away from my sleep!... Please.'},
			{origin = 1, dialogue = '. . .'},
			{origin = 2, dialogue = 'Sorry... didnt mean to raise my voice.'},
		},
		[2] = {
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Bassie, youre a bit silent.'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'Everything will be alright, focus...'},
			{origin = 2, dialogue = 'Youre right... everything is fineee...!'},
			{origin = 1, dialogue = 'Mhm! There we are, were calm.'},
		},
	},

	['Astro_Blot'] = {
		[1] = {
			{origin = 1, dialogue = 'Blot you seem to be trailing puddles behind you.'},
			{origin = 2, dialogue = '.ti setah ahsiT'},
			{origin = 1, dialogue = 'Tisha...? Oh she must not like that.'},
			{origin = 2, dialogue = '.heaY .haH'},
		},
		[2] = {
			{origin = 2, dialogue = '!elims a no tup ortsA'},
			{origin = 1, dialogue = 'Hm? What was that you said...?'},
			{origin = 2, dialogue = '!elimS'},
			{origin = 1, dialogue = 'Oh... smile! Hah... alright, thank you...'},
			{origin = 2, dialogue = '!uoy knaht ,on, oN'},
		},
	},

	['Astro_Bobette'] = {
		[1] = {
			{origin = 2, dialogue = 'Id love a good winter-wonderland dream tonight!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'With snow... and whimsy... and cheer!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Astro? Pretty please? With a big cherry on top!'},
			{origin = 1, dialogue = 'Ill try...?'},
		},
	},

	['Astro_Boxten'] = {
		[1] = {
			{origin = 1, dialogue = 'Boxten, how have those dreams been treating you...?'},
			{origin = 2, dialogue = 'You mean the nightmares?'},
			{origin = 1, dialogue = 'No... I believe I remember giving you only good dreams.'},
			{origin = 2, dialogue = 'I-I dont know Astro, maybe what you think of as a good dream isnt one to me.'},
			{origin = 1, dialogue = '...Ill keep that in mind, thank you.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Hey Astro... been sleeping well yourself?'},
			{origin = 1, dialogue = 'I sleep most days Boxten, sleeping is not difficult for me...'},
			{origin = 2, dialogue = 'Well yeah I knew that! I mean have you had good dreams?'},
			{origin = 1, dialogue = '...Not exactly, Im too busy giving others better rest.'},
		},
	},

	['Astro_Brightney'] = {
		[1] = {
			{origin = 1, dialogue = 'Brightney, your glow is as bright as ever.'},
			{origin = 2, dialogue = 'And yours is just a feeew lumens less than mine!'},
			{origin = 1, dialogue = 'Lumens, the measurement of light!'},
			{origin = 2, dialogue = 'Haha, I may have been reading up on those books you suggested.'},
			{origin = 1, dialogue = 'Thats nice to hear... Maybe I can suggest more soon.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Hey Astro, ever try getting a good look at the stars?'},
			{origin = 1, dialogue = 'I have some that glow in one of my personally themed exhibits...'},
			{origin = 2, dialogue = 'No, no, not the plastic ones silly! The real deal!'},
			{origin = 1, dialogue = '...Not often, not as much as I used to.'},
			{origin = 2, dialogue = 'Ah, I see... well maybe you and I can look later!'},
			{origin = 1, dialogue = '...Maybe, the tree blocks most of the view now.'},
		},
	},

	['Astro_Brusha'] = {
		[1] = {
			{origin = 2, dialogue = 'Astro, youre always wearing that blanket.'},
			{origin = 1, dialogue = '... And?'},
			{origin = 2, dialogue = 'Wouldnt you want to change your style?'},
			{origin = 1, dialogue = 'No, I like my blanket....I feel comfortable in it.'},
			{origin = 2, dialogue = 'Fine, Im sure youd look better in something else though.'},
			{origin = 1, dialogue = '...Noted.'},
		},
	},

	['Astro_Coal'] = {
		[1] = {
			{origin = 2, dialogue = 'Bork, bwoof.'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'S-stop staring at me like that please...'},
			{origin = 2, dialogue = 'Bwoof.'},
		},
	},

	['Astro_Connie'] = {
		[1] = {
			{origin = 2, dialogue = 'Your chats with Dandy are boring.'},
			{origin = 1, dialogue = 'W-what...?'},
			{origin = 2, dialogue = 'Yeah, I stuck around for one while being invisible...'},
			{origin = 1, dialogue = 'Connie!'},
			{origin = 2, dialogue = 'What. All you talked about was past episodes!'},
			{origin = 1, dialogue = '...Ah uhm, alright... Sorry.'},
		},
		[2] = {
			{origin = 1, dialogue = 'You know Connie... you have a subtle glow to you.'},
			{origin = 2, dialogue = 'Oh yeaaah, makes navigating around the dark places so much easier!'},
			{origin = 1, dialogue = 'Yes, Ive found my own glow useful for such.'},
			{origin = 2, dialogue = 'Yeah- I mean it would be more useful if I couldnt already see in the dark!'},
			{origin = 1, dialogue = 'Wait, you can see in the dark?'},
			{origin = 2, dialogue = 'Heh, maybe.'},
		}
	},

	['Astro_Cosmo'] = {
		[1] = {
			{origin = 2, dialogue = 'You look a little down... Do you maybe want a cooking break later?'},
			{origin = 1, dialogue = '...No, thank you for your offer, though Cosmo. Im sure youll be busy.'},
			{origin = 2, dialogue = 'Aw but cmon, Im never too busy to spend some time with a friend!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '...Well-If you reconsider, let me know! Ill have cookies ready incase!'},
			{origin = 1, dialogue = '...Alright, sorry, thank you.'},
		},
		[2] = {
			{origin = 1, dialogue = 'Youve been having some interesting dreams Cosmo.'},
			{origin = 2, dialogue = 'Which one? The one with fire, or the one with flowers?'},
			{origin = 1, dialogue = 'Well the flowers were- wait, fire?'},
			{origin = 2, dialogue = '...Nevermind! Nevermind! Lets talk later on that! haha...'},
			{origin = 1, dialogue = '...'},
		}
	},

	['Astro_Eclipse'] = {
		[1] = {
			{origin = 2, dialogue = 'Youre a crescent moon, and I have a crescent moon on my head! We match!!'},
			{origin = 1, dialogue = 'Oh... I suppose we do match...thats lovely.'},
			{origin = 2, dialogue = 'Youre lovely!! We gotta be like BEST FRIENDS!!'},
			{origin = 1, dialogue = 'I uhm- Im not sure about that... but Id consider you a nice friend, just not my closest- or best...'},
			{origin = 2, dialogue = 'Aw... Thats okay, I understand... Do you wanna howl at the real moon together sometime?'},
			{origin = 1, dialogue = 'Uhm... No thank you.'},
		},
	},

	['Astro_Eggson'] = {
		[1] = {
			{origin = 2, dialogue = 'Astro, you are getting proper rest, arent you?'},
			{origin = 1, dialogue = 'Hm...? Why do you ask?'},
			{origin = 2, dialogue = 'You seem to be dozing off some! You should really have some proper rest!'},
			{origin = 1, dialogue = '...Im sorry, but-'},
			{origin = 2, dialogue = 'No buts! Tell me youll rest a proper amount when youre able!!'},
			{origin = 1, dialogue = '...Oh, uhm- I will rest a proper amount- ...when able.'},
		},
	},

	['Astro_Finn'] = {
		[1] = {
			{origin = 1, dialogue = 'Finn do you ever dream of anything other than fish...?'},
			{origin = 2, dialogue = 'Why would I ever want to NOT dream of fish???'},
			{origin = 1, dialogue = '...Alright, never mind.'},
			{origin = 2, dialogue = 'My mind is filled with nautical treasures!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Astro! Ever heard of a Sunfish?'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '...Astro?'},
			{origin = 1, dialogue = 'Huh? Oh yes, sorry the sun-FISH, yes...'},
			{origin = 2, dialogue = 'Why dont I just tell you all about it later!'},
			{origin = 1, dialogue = 'Mhm, later... thank you.'},
		},
	},

	['Astro_Flutter'] = {
		[1] = {
			{origin = 1, dialogue = 'Flutter, do you ever get tired from flying so often...?'},
			{origin = 2, dialogue = '...!'},
			{origin = 1, dialogue = 'I suppose you are stronger than me then.'},
			{origin = 2, dialogue = '...?'},
			{origin = 1, dialogue = 'Haha... no I can not fly, I mean your endurance.'},
			{origin = 2, dialogue = '!!!'},
		},
		[2] = {
			{origin = 2, dialogue = '...?'},
			{origin = 1, dialogue = 'So you got the dream I made for you...?'},
			{origin = 2, dialogue = '!!!'},
			{origin = 1, dialogue = 'Well thats lovely, happy to have helped.'},
			{origin = 2, dialogue = '...!'},
			{origin = 1, dialogue = 'Haha, I suppose you are right.'},
		},
	},

	['Astro_Gigi'] = {
		[1] = {
			{origin = 1, dialogue = 'Gigi... would you happen to know where some of-'},
			{origin = 2, dialogue = 'Before you continue, I did not steal anything!'},
			{origin = 1, dialogue = 'So you dont know where my spare hat went?'},
			{origin = 2, dialogue = 'Oh, wait no, yeah! -I stole that!'},
			{origin = 1, dialogue = '...Ill need that back.'},
		},
	},

	['Astro_Glisten'] = {
		[1] = {
			{origin = 1, dialogue = 'Glisten your dreams have been a concern recently...'},
			{origin = 2, dialogue = 'Huh? OH! HAHA...Lets not talk about that here Astro!'},
			{origin = 1, dialogue = 'But-'},
			{origin = 2, dialogue = 'Be so patient Astro! Later, please!'},
			{origin = 1, dialogue = '...A-alright.'},
		},
	},

	['Astro_Goob'] = {
		[1] = {
			{origin = 1, dialogue = 'Goob I noticed youve had dreams of chasing your own tail...?'},
			{origin = 2, dialogue = 'Yup!'},
			{origin = 1, dialogue = 'But, you dont have one...?'},
			{origin = 2, dialogue = 'Not in the dream I dont!'},
			{origin = 1, dialogue = 'Right...'},
		},
	},

	['Astro_Gourdy'] = {
		[1] = {
			{origin = 2, dialogue = 'Mister Novalite...'},
			{origin = 1, dialogue = 'Gourdy... if this is a discussion about your dreams again-'},
			{origin = 2, dialogue = 'No! No! No! Its not promise!! I uh... I just-'},
			{origin = 1, dialogue = '...Take your time.'},
			{origin = 2, dialogue = 'Y-yeah well, it was about the dreams but, never mind I guess.'},
			{origin = 1, dialogue = 'Well, know that I am always here if you ever need anything...'},
		},
	},

	['Astro_Looey'] = {
		[1] = {
			{origin = 2, dialogue = 'Astro, turn that frown upsidedown!'},
			{origin = 1, dialogue = 'Its okay Looey Im feeling fine honestly...'},
			{origin = 2, dialogue = 'Aw but you always look so sad!'},
			{origin = 1, dialogue = '...I do?'},
		},
		[2] = {
			{origin = 1, dialogue = 'You know... sometimes I have stage fright as well.'},
			{origin = 2, dialogue = 'Huh? Youre talking to me? I-I dont have stage fright!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Maybe Im misremembering your dream... nevermind.'},
		},
	},

	['Astro_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'Pebble, hello... What a good pet rock.'},
			{origin = 2, dialogue = 'Arf Arf!!'},
			{origin = 1, dialogue = 'Oh youre excited to see me... Hows Dandy?'},
			{origin = 2, dialogue = '(Whine whine)'},
			{origin = 1, dialogue = '...I know, Im worried about Dandy too.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Bark bark!'},
			{origin = 1, dialogue = 'I know, Im happy to see you too, Pebble...'},
			{origin = 2, dialogue = 'Bwoof!!'},
			{origin = 1, dialogue = 'Heh...'},
		}
	},

	['Astro_Poppy'] = {
		[1] = {
			{origin = 1, dialogue = 'Poppy... how many bottles of soda do you usually drink?'},
			{origin = 2, dialogue = 'Not enough to be honest!'},
			{origin = 1, dialogue = 'I dont know about that, Im certain youre losing sleep...'},
			{origin = 2, dialogue = 'Losing sleep OR, gaining hours in the day!!!'},
			{origin = 1, dialogue = '...'},
		},
	},

	['Astro_Razzle n Dazzle'] = {
		[1] = {
			{origin = 1, dialogue = 'How have you two been...?'},
			{origin = 2, dialogue = 'Hehe! Im doing just amazing! (Its been alright, its nice to have you here.)'},
			{origin = 1, dialogue = 'Dazzle, have you been enjoying that astronomy book I gave you?'},
			{origin = 2, dialogue = 'I cant get him to put it down! (...The pictures are lovely.)'},
			{origin = 1, dialogue = 'Heh, Ill have to tell you more about it sometime later...'},
		},
		[2] = {
			{origin = 2, dialogue = 'Astro! (Astro... nice to have you here.)'},
			{origin = 1, dialogue = 'Of course, nice having you twos company...'},
			{origin = 2, dialogue = 'Hehe Thanks! (We should spend time after we all finish here...)'},
			{origin = 1, dialogue = 'That would be nice, I dont have much else to do.'},
			{origin = 2, dialogue = 'Perfect! (Mhm excited...)'},
		},
	},

	['Astro_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'Rodger, maybe you should focus on... other things than your investigations.'},
			{origin = 2, dialogue = 'I dont see a point in that Astro.'},
			{origin = 1, dialogue = 'How about a new hobby...?'},
			{origin = 2, dialogue = 'Astro, I have plenty hobbies!'},
			{origin = 1, dialogue = '...Maybe mooore hobbies?'},
		},
		[2] = {
			{origin = 2, dialogue = 'Astro! Would you mind answering some of my questions?'},
			{origin = 1, dialogue = 'Yes? Yes I would mind.'},
			{origin = 2, dialogue = 'How about later? I could ask you after this!'},
			{origin = 1, dialogue = 'I rather you didnt Rodger...'},
		},
	},

	['Astro_Rudie'] = {
		[1] = {
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Looking for a good dream...?'},
			{origin = 2, dialogue = 'A little!'},
			{origin = 1, dialogue = 'Say no more...'},
			{origin = 2, dialogue = 'Thank you!!!'},
		},
	},

	['Astro_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Scraps Ive noticed you drawing less...'},
			{origin = 2, dialogue = 'You have???'},
			{origin = 1, dialogue = 'Yes, are you doing alright?'},
			{origin = 2, dialogue = 'I mean, I could be better, I have a lot on my mind!'},
			{origin = 1, dialogue = 'Im here to listen if you ever need.'},
		},
	},

	['Astro_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = '...Are you alright?'},
			{origin = 2, dialogue = 'Huh?? OH! Youre asking me?'},
			{origin = 1, dialogue = 'Uhm... yes you, Shelly.'},
			{origin = 2, dialogue = 'Yeah! Im actually doing better knowing I got you around!'},
			{origin = 1, dialogue = 'Heh, thats good I suppose.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Astro! You think I could get a good dream tonight buddy?'},
			{origin = 1, dialogue = 'Well... maybe, what were you thinking?'},
			{origin = 2, dialogue = 'Let me tame a hundred velociraptors.'},
			{origin = 1, dialogue = 'Uhm... A-are you sure...?'},
			{origin = 2, dialogue = 'Astro, Ive never been more sure.'},
		},
	},

	['Astro_Shrimpo'] = {
		[1] = {
			{origin = 2, dialogue = 'ASTRO, MORE LIKE BAD!'},
			{origin = 1, dialogue = 'Uh... what?'},
			{origin = 2, dialogue = 'BADSTRO!!!'},
		},
		[2] = {
			{origin = 1, dialogue = '...Shrimpo I-'},
			{origin = 2, dialogue = 'NO!!'},
			{origin = 1, dialogue = 'But I just-'},
			{origin = 2, dialogue = 'I DONT WANT TO HEAR YOUR VOICE!!!'},
			{origin = 1, dialogue = '...'},
		},
	},

	['Astro_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Sprout... Are you well?'},
			{origin = 2, dialogue = 'Eh... well enough? What do you want?'},
			{origin = 1, dialogue = 'Nothing...! I just wanted to check in...'},
			{origin = 2, dialogue = 'Uh huh... No desserts you were looking for?'},
			{origin = 1, dialogue = 'No not at all! Just- Nevermind...'},
		},
		[2] = {
			{origin = 2, dialogue = 'Astro?'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Ahem- Astro!'},
			{origin = 1, dialogue = '-Yes Sprout?'},
			{origin = 2, dialogue = 'Keep focused, dont doze off when were out here in danger.'},
			{origin = 1, dialogue = 'Mhm... Sorry.'},
		},
	},

	['Astro_Squirm'] = {
		[1] = {
			{origin = 2, dialogue = 'Astro... a-are you still mad at m-me...? sniffle- snf-'},
			{origin = 1, dialogue = 'What...? No, no of course not, why would I be mad at you...?'},
			{origin = 2, dialogue = '... Than why a-are we in a nightmare right now?'},
			{origin = 1, dialogue = 'Oh... Squirm, were not in a nightmare... were awake.'},
			{origin = 2, dialogue = 'Sniffle, snf-'},
			{origin = 1, dialogue = '...Dont cry Squirm, Ill be here to help.'},
		},
		[2] = {
			{origin = 1, dialogue = '...Im a bit tired.'},
			{origin = 2, dialogue = '...M-maybe if I work even harder next blind, youll have to do less-!'},
			{origin = 1, dialogue = 'Thats very kind Squirm, but, I wouldnt want you working harder for my sake.'},
			{origin = 2, dialogue = 'B-but I want to help you!'},
			{origin = 1, dialogue = 'I know... just keep your head up, and dont panic youre doing well.'},
		}
	},

	['Astro_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Astro, are you still talking with... Him?'},
			{origin = 1, dialogue = 'Yes... well, sometimes... not as often...'},
			{origin = 2, dialogue = 'Goodness Astro, you need to make up your mind!'},
			{origin = 1, dialogue = '...Sorry.'},
		},
		[2] = {
			{origin = 1, dialogue = 'Teagan, are you planning one of your gatherings anytime soon?'},
			{origin = 2, dialogue = 'Astro! Why of course, I always love a good tea party!'},
			{origin = 1, dialogue = 'Good, good... I could use a nice tea to calm down after this.'},
			{origin = 2, dialogue = 'Ill have you an iced tea ready, just the way you like!'},
		},
	},

	['Astro_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Tisha my room is a bit messy again...'},
			{origin = 2, dialogue = 'Again? Astro!'},
			{origin = 1, dialogue = '...Im sorry, I could use the help.'},
			{origin = 2, dialogue = 'I know, you get tired, I understand! Do try and be considerate of my time though!'},
			{origin = 1, dialogue = '...Sorry'},
		},
		[2] = {
			{origin = 2, dialogue = 'Ive been so busy! I almost need an extra set of arms to help me out!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Oh? Is there something wrong Astro?'},
			{origin = 1, dialogue = 'Nothing...'},
		}
	},

	['Astro_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Hmm...hmm...'},
			{origin = 2, dialogue = 'I like when you hum little songs!'},
			{origin = 1, dialogue = 'Ah... really?'},
			{origin = 2, dialogue = 'Yeah makes me sleepy! Like you!'},
			{origin = 1, dialogue = 'Hm, I see..'},
		},
	},

	['Astro_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Vee, hows your Mic cord? Need any untangling?'},
			{origin = 2, dialogue = 'You need to start worrying about yourself more.'},
			{origin = 1, dialogue = '..Well, is it tangled?'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'Ill give it a look after we finish here...'},
			{origin = 2, dialogue = 'Ok. Thanks, Astro.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Hey Astro if anyone gives you issues, come to me alright?'},
			{origin = 1, dialogue = 'Mhm...'},
			{origin = 2, dialogue = 'Or if you need to finish a Round faster!'},
			{origin = 1, dialogue = 'Alright Vee.'},
			{origin = 2, dialogue = 'OR if a Twisted tries anything!'},
			{origin = 1, dialogue = 'Vee, I get it... Thank you.'},
		}
	},

	['Astro_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Yatta nice to know you care deeply for your friends...'},
			{origin = 2, dialogue = 'Pft- HAhaha, how could I not! Theyre SO, SO, SO funny and kind!'},
			{origin = 1, dialogue = 'In your dreams you always present them so highly...'},
			{origin = 2, dialogue = 'Haha Im sure YOUR FRIENDS do the same!!'},
			{origin = 1, dialogue = '...Right, ahem, anyways...'},
		},
	},

	['Bassie_Bobette'] = {
		[1] = {
			{origin = 1, dialogue = 'So youre the Christmas Holiday Main?'},
			{origin = 2, dialogue = 'Hmm, last I checked, yup!'},
			{origin = 1, dialogue = 'Last you checked? Like, we could be replaced!?'},
			{origin = 2, dialogue = 'What? No, no! I meant it as a silly little comment!'},
			{origin = 1, dialogue = '...Oh- HAHAHAHA! Youre so FUNNY!'},
			{origin = 2, dialogue = 'Uhm thanks...?'},
		},
		[2] = {
			{origin = 2, dialogue = 'Hows the spring weather...?'},
			{origin = 1, dialogue = 'Lovely really... beautiful flowers, chirping birds!'},
			{origin = 2, dialogue = 'Wow that sounds nice!'},
			{origin = 1, dialogue = 'Hows winter weather-?'},
			{origin = 2, dialogue = 'Cozy when youre sat comfy with a blanket and hot chocolate!'},
			{origin = 1, dialogue = 'Ah, that does sound wonderful and cozy!!'},
		},
	},

	['Bassie_Brightney'] = {
		[1] = {
			{origin = 1, dialogue = 'Brightney do you have any spare lightbulbs?'},
			{origin = 2, dialogue = 'Not on me right now... but in my room I do!'},
			{origin = 1, dialogue = 'Think I could have some...? Not a fan of the dark.'},
			{origin = 2, dialogue = 'You know I might have something even better!'},
			{origin = 1, dialogue = 'O-oh...?'},
			{origin = 2, dialogue = 'Ill bring you a little night-light! Itll help I promise!'},
		},
	},

	['Bassie_Brusha'] = {
		[1] = {
			{origin = 2, dialogue = 'Bassie, your flowers.'},
			{origin = 1, dialogue = '...W-what? What about my flowers??'},
			{origin = 2, dialogue = 'Are they always like that?'},
			{origin = 1, dialogue = 'Like what-???'},
			{origin = 2, dialogue = 'Tsk. Nevermind.'},
		},
	},

	['Bassie_Cocoa'] = {
		[1] = {
			{origin = 1, dialogue = 'Cocoa.'},
			{origin = 2, dialogue = 'Oh! Bassie! How are you my friend!!'},
			{origin = 1, dialogue = 'Fine.'},
			{origin = 2, dialogue = 'Thats great to hear! Were you needing any help?'},
			{origin = 1, dialogue = 'No, not from you.'},
			{origin = 2, dialogue = 'O-oh Haha... Silly Bassie always with your jokes! ...Hah'},
		},
		[2] = {
			{origin = 2, dialogue = 'Ah! I love the spring season, I cant stop thinking about Easter!'},
			{origin = 1, dialogue = 'Of course you cant stop thinking about it.'},
			{origin = 2, dialogue = 'Huh? Arent you the same way though!'},
			{origin = 1, dialogue = 'No, Im not like you.'},
			{origin = 2, dialogue = 'Aw thats okay! Were all our own Toon at the end of the day!'},
			{origin = 1, dialogue = '...HahaHA- Ok.'},
		},
	},

	['Bassie_Connie'] = {
		[1] = {
			{origin = 1, dialogue = 'So Connie, you can go invisible? Like disappear?'},
			{origin = 2, dialogue = 'I mean yeah, I can go invisible, but that doesnt mean I just disappear.'},
			{origin = 1, dialogue = 'Ah right...'},
			{origin = 2, dialogue = 'Right...? Is that all you wanted to ask?'},
			{origin = 1, dialogue = 'I guess, yeah, sorry to waste any time-!'},
			{origin = 2, dialogue = 'Its all good, dont stress about whatever is on your mind girl.'},
		},
	},

	['Bassie_Eggson'] = {
		[1] = {
			{origin = 1, dialogue = 'Eggson I could use some advice later...'},
			{origin = 2, dialogue = 'Advice? Eh well youre coming to the right Toon, Ive got plenty wisdom...!'},
			{origin = 1, dialogue = 'Yes but its advice on something not uhm well... egg related.'},
			{origin = 2, dialogue = 'Not egg related!? Well... I suppose I can still give more so general advice.'},
			{origin = 1, dialogue = 'Thanks Eggson...'},
		},
		[2] = {
			{origin = 2, dialogue = 'Ah Bassie just the Basket I wanted to see!'},
			{origin = 1, dialogue = 'Eggson! Did you need something...?'},
			{origin = 2, dialogue = 'Of course, it was something of the utmost importance actually!'},
			{origin = 1, dialogue = 'O-oh... Sounds serious...'},
			{origin = 2, dialogue = 'Sure is serious! I was in terrible need of seeing you smile!'},
			{origin = 1, dialogue = 'Aw... yeah, Ill try and smile a bit more.'},
		},
	},

	['Bassie_Flutter'] = {
		[1] = {
			{origin = 1, dialogue = 'Flutter! Its so lovely to see you-!!'},
			{origin = 2, dialogue = '...!!!'},
			{origin = 1, dialogue = 'Of course Im alright...! Never better... yup.'},
			{origin = 2, dialogue = '...?'},
			{origin = 1, dialogue = 'W-what? Nothing is wrong! Cmon really! Lets just enjoy each others company.'},
			{origin = 2, dialogue = '...'},
		},
	},

	['Bassie_Flyte'] = {
		[1] = {
			{origin = 1, dialogue = 'Flyte could you and me spend some time later?'},
			{origin = 2, dialogue = 'Uh sure, doing what though?'},
			{origin = 1, dialogue = 'Maybe pressing flowers...?'},
			{origin = 2, dialogue = 'Oh sure! Of course!'},
			{origin = 1, dialogue = 'Thank you Flyte, youre always so nice.'},
			{origin = 2, dialogue = 'Well I know you love the company!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Bassie are my wings looking about right-?'},
			{origin = 1, dialogue = 'Huh- Why do you ask? Are you okay-?!'},
			{origin = 2, dialogue = 'Yeah Im alright! Just dont want to stretch them the wrong way or something.'},
			{origin = 1, dialogue = 'Flyte!!'},
			{origin = 2, dialogue = 'Sorry geez, didnt think youd get so worried about that.'},
		},
	},

	['Bassie_Gigi'] = {
		[1] = {
			{origin = 2, dialogue = 'Woah... How much stuff can you carry???'},
			{origin = 1, dialogue = 'Not as much as you Im sure...'},
			{origin = 2, dialogue = 'Seriously? Do you like- collect anything?'},
			{origin = 1, dialogue = '...Sometimes I like to collect pressed flowers.'},
			{origin = 2, dialogue = 'Thats it? Psh, girl, we have to get you another collection!'},
			{origin = 1, dialogue = 'O-oh...?'},
		},
	},

	['Bassie_Glisten'] = {
		[1] = {
			{origin = 2, dialogue = 'Bassie I must say those flowers are just beautiful!'},
			{origin = 1, dialogue = 'Ah, thank you! I do love spring flowers.'},
			{origin = 2, dialogue = 'Any favorites come to mind...?'},
			{origin = 1, dialogue = 'I love tulips, hyacinth, OH! And lily flowers...!'},
			{origin = 2, dialogue = 'Hmm, Ive not actually heard of "hyacinth" before, Ill have to give them a look!'},
		},
	},

	['Bassie_Goob'] = {
		[1] = {
			{origin = 2, dialogue = 'Does someone need a big hug!'},
			{origin = 1, dialogue = 'Are you asking me...? Because if so... no thank you...'},
			{origin = 2, dialogue = 'Aw, but you look like you could use a hug!'},
			{origin = 1, dialogue = 'I-I do...? How so...'},
			{origin = 2, dialogue = 'You seem a little down! Or more so... hmmm, tense?'},
			{origin = 1, dialogue = 'HAHAHAhaha... ha... nooo... Thanks for the offer, though.'},
		},
	},

	['Bassie_Looey'] = {
		[1] = {
			{origin = 2, dialogue = 'Bassie, you wouldnt happen to know where my spare juggling pins are, would you?'},
			{origin = 1, dialogue = 'No... any reason youre asking me?'},
			{origin = 2, dialogue = 'Well... Haha... funny story- I heard you may have helped Gigi hide some things!'},
			{origin = 1, dialogue = 'Oh no, no... that was not a one-time thing! -Im NOT hiding anything!!'},
			{origin = 2, dialogue = 'When you say it like that I sure do trust youuu... yup! Hahahaaa-'},
			{origin = 1, dialogue = 'HahaHAHAha... haha- anyways... ahem... we should focus back to what matter.'},
		},
	},

	['Bassie_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'Mh... why are you looking at me like that!'},
			{origin = 2, dialogue = 'Bworf...?'},
			{origin = 1, dialogue = 'S-sorry... You probably dont mean to'},
			{origin = 2, dialogue = 'Arf arf!'},
			{origin = 1, dialogue = 'Im glad I never had a pet, feels like a lot of work...'},
			{origin = 2, dialogue = 'Grrr Bark!!'},
		},
	},

	['Bassie_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'Shelly... uhm do you-'},
			{origin = 2, dialogue = 'Wait! ...You got my name right!'},
			{origin = 1, dialogue = 'I uh, try to remember all my fellow "Main" friends...!'},
			{origin = 2, dialogue = 'Were for sure friends! Of course! Just us "Mains" Hahaha!'},
			{origin = 1, dialogue = 'R-right!! Haha... HaHAha!'},
		},
	},

	['Bassie_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Sprout youre so kind to want to take care of everyone...'},
			{origin = 2, dialogue = 'Well its nothing really! Just part of my nature I guess.'},
			{origin = 1, dialogue = 'Your nature to help others? Do you know what my nature is...?'},
			{origin = 2, dialogue = 'Huh? Haha... No, thats something you gotta find out yourself!'},
			{origin = 1, dialogue = 'Right... I guess you have a point, I hope Im kind like you.'},
			{origin = 2, dialogue = 'Well, I think youre kind if thats worth anything.'},
		},
	},

	['Bassie_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = 'Squirm, I noticed you crying often...'},
			{origin = 2, dialogue = 'You did...? Oh nooo... I-IM SORRY! I DONT MEAN TO! I- I- SNF-'},
			{origin = 1, dialogue = 'Wait no, dont cry now! I only said that because maybe I could help...?'},
			{origin = 2, dialogue = 'You.. want to help me? Snf- sniffle- I-I dont know Bassie...'},
			{origin = 1, dialogue = 'Im capable.'},
			{origin = 2, dialogue = 'O-oh... I-I uhm... I wasnt questioning that... Snf-'},
		},
	},

	['Bassie_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Vee do you have any trivia on flowers?'},
			{origin = 2, dialogue = 'I have trivia on nearly every topic Bassie.'},
			{origin = 1, dialogue = 'Wow, youre... really talented! Really, really, talented!'},
			{origin = 2, dialogue = 'Thanks, thats pretty nice to hear.'},
			{origin = 1, dialogue = 'I hope I can be as talented as you Vee.'},
			{origin = 2, dialogue = '...Sure Bassie, sure.'},
		},
	},

	['Blot_Boxten'] = {
		[1] = {
			{origin = 1, dialogue = '?netxoB'},
			{origin = 2, dialogue = 'Huh? Uhm... me?'},
			{origin = 1, dialogue = '?thgirla uoy erA'},
			{origin = 2, dialogue = '...Oh! Youre checking on me? Ill be fine- I hope.'},
			{origin = 1, dialogue = '.esnopser gninrecnoc ylthgilS'},
		},
		[2] = {
			{origin = 2, dialogue = 'Blot when you mime things do you actually picture them in your mind?'},
			{origin = 1, dialogue = '.haey ereht yllaer ton stahw ees yllacitcarp nac I ekil sti netfo os emim I'},
			{origin = 2, dialogue = 'Uhm... A little shorter?'},
			{origin = 1, dialogue = '.fo dniK...'},
			{origin = 2, dialogue = 'Oooh, ok! Thats pretty neat over all if so!'},
		},
	},

	['Blot_Brightney'] = {
		[1] = {
			{origin = 1, dialogue = '.hgu thgil thgirb a hcus ...eye yM'},
			{origin = 2, dialogue = 'Its lovely to have you here Blot!'},
			{origin = 1, dialogue = '.ynapmoc doog dna dnik eruoy tsael ta lleW'},
			{origin = 2, dialogue = 'Huh, wish I could understand you better! I dont know how Yatta and Looey are able to'},
		},
		[2] = {
			{origin = 2, dialogue = 'Ive been reading this book recently, its all about the performing arts!'},
			{origin = 1, dialogue = '!gninetsil mI'},
			{origin = 2, dialogue = 'Hm? Are you interested Blot? I could get you a copy!'},
			{origin = 1, dialogue = '.daer esle enoemos ot netsil tsuj rehtar dI'},
			{origin = 2, dialogue = 'I dont think I fully understand... BUT! Youre welcome to book club later for a visit!'},
		},
	},

	['Blot_Brusha'] = {
		[1] = {
			{origin = 2, dialogue = 'Blot, is she still asking for help with her "art"?'},
			{origin = 1, dialogue = '.heaY'},
			{origin = 2, dialogue = 'Instead of helping her, you could always be my assistant for the day.'},
			{origin = 1, dialogue = '.ti tuoba kniht llI'},
		},
	},

	['Blot_Cocoa'] = {
		[1] = {
			{origin = 2, dialogue = 'Blot! Guess what! Tisha told me that you always leave a messy trail!'},
			{origin = 1, dialogue = '.did ehs erus mI'},
			{origin = 2, dialogue = 'So I thought of a way to help! What if I followed you around with a mop!'},
			{origin = 1, dialogue = '.gnitailimuh ylpeed eb dluow tahT'},
			{origin = 2, dialogue = 'Im sure you agree its a good idea! Ill have to find a mop first, though!'},
			{origin = 1, dialogue = '.nosaes gnirps eht rof spom ediH ...fles ot etoN'},
		},
	},

	['Blot_Connie'] = {
		[1] = {
			{origin = 2, dialogue = 'Blot how many pairs of gloves does one Toon need to own!'},
			{origin = 1, dialogue = '!enim fo emos nelots sah ehs erus ytterp osla mI .erom sah igiG erus mI'},
			{origin = 2, dialogue = '... What?'},
			{origin = 1, dialogue = '.pmow pmoW...'},
			{origin = 2, dialogue = 'Hey dont start with that! I hear it enough from Looey.'},
		},
	},

	['Blot_Cosmo'] = {
		[1] = {
			{origin = 1, dialogue = '.edam tuorpS seikooc esoht fo eno flesym teg og dluoc I enod si siht lla retfa ebyaM'},
			{origin = 2, dialogue = 'Did you say Sprout?'},
			{origin = 1, dialogue = '???em fo tuo dnatsrednu ot tog yllautca uoy gniht eno eht taht si woH'},
			{origin = 2, dialogue = 'Uhm... What?'},
			{origin = 1, dialogue = 'dnimreveN'},
		},
		[2] = {
			{origin = 2, dialogue = 'Blot did you still want that order of uhm... three cakes?'},
			{origin = 1, dialogue = '.seY'},
			{origin = 2, dialogue = 'Ok... why?'},
			{origin = 1, dialogue = '.attaY'},
			{origin = 2, dialogue = 'Ooooh, I think I get it now, alright!'},
		},
	},

	['Blot_Finn'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Blot! Since youre ink I thought youd love to hear an octopus pun!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Ahem... Whats an octopuses favorite shape?'},
			{origin = 1, dialogue = '.nogatco nA...'},
			{origin = 2, dialogue = 'An octagon!!!'},
		},
	},

	['Blot_Flutter'] = {
		[1] = {
			{origin = 1, dialogue = '.rettulF'},
			{origin = 2, dialogue = '...?'},
			{origin = 1, dialogue = '.uoy etaicerppa I'},
			{origin = 2, dialogue = '...!!!'},
		},
		[2] = {
			{origin = 2, dialogue = '...?'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '...!!!'},
			{origin = 1, dialogue = '.oot uoy ,sknahT'},
		},
	},

	['Blot_Gigi'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Blot, tell me your day in excruciating detail!'},
			{origin = 1, dialogue = '...gniyas mI tahw aedi on evah uoy taht wonk I ,igiG'},
			{origin = 2, dialogue = 'Uhuh... uhuh... then'},
			{origin = 1, dialogue = '.igiG yfoog eruoy ...thgirla -tfP'},
			{origin = 2, dialogue = 'Lovely chat Blot, Im sure you had the most distinguished responses Mwehehe!'},
		},
	},

	['Blot_Glisten'] = {
		[1] = {
			{origin = 1, dialogue = '...siht fo derit os ydaerla mI'},
			{origin = 2, dialogue = 'Blot for a mime you seem to make a lot of noise.'},
			{origin = 1, dialogue = '. . .'},
			{origin = 2, dialogue = 'Aw come on dont get silent now! Im going to feel bad-'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Blot noo...'},
		},
		[2] = {
			{origin = 2, dialogue = 'Whenever you make that little... oh hm, what was it you called it-?'},
			{origin = 1, dialogue = '.rJ tolB'},
			{origin = 2, dialogue = 'YES! When you make that, do you think you can make one in MY image next time?'},
			{origin = 1, dialogue = '.oN'},
			{origin = 2, dialogue = 'Oh... I understand... cant recreate perfection I know Ive given too difficult a task!'},
			{origin = 1, dialogue = '.pan ,gnol ,gnol a gnikat mI ,revo lla si siht retfA'},
		},
	},

	['Blot_Goob'] = {
		[1] = {
			{origin = 2, dialogue = 'BLOT!! I really like your gloves! Do you think they make gloves that I can wear too??'},
			{origin = 1, dialogue = '?oN...'},
			{origin = 2, dialogue = 'Aww... WAIT! Maybe I can make gloves that are super big.'},
			{origin = 1, dialogue = '.taht tuoba eil neve tnac I .sevolg gib repus fo aedi eht ekil I ,yltsenoH ...huH'},
			{origin = 2, dialogue = 'I agree with whatever you just said buddy!!'},
		},
	},

	['Blot_Looey'] = {
		[1] = {
			{origin = 1, dialogue = '.retal stca fo gnikniht pleh emos deen I yeooL'},
			{origin = 2, dialogue = 'Oh yeah I had some ideas, some pantomime stuff for you!'},
			{origin = 1, dialogue = '!taerg eb llti ,si ti revetahw erus mI ,taerG'},
			{origin = 2, dialogue = 'Yeah! Im excited about sharing all of that later!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Blot do you know where my juggling pins went?'},
			{origin = 1, dialogue = '!tegrof dna ereht meht evael syawla uoy ,deb ruoy rednU'},
			{origin = 2, dialogue = 'Ohhh, Blot you always know where me and Yatta leave stuff!'},
			{origin = 1, dialogue = '!htob uoy no eye doog a peek I'},
			{origin = 2, dialogue = 'Thank you Blot...!'},
		},
	},

	['Blot_Pebble'] = {
		[1] = {
			{origin = 2, dialogue = 'ARF! BARK!'},
			{origin = 1, dialogue = '.tsael ta "tis" naht rehto ,llew ...skcirt yna od nac uoy fi rednoW'},
			{origin = 2, dialogue = 'Bworf...?'},
			{origin = 1, dialogue = '.attaY ekil tsuj ,tluasremos a otni pilfkcab a od elbbeP no oG'},
			{origin = 2, dialogue = 'Arf???'},
			{origin = 1, dialogue = '.huh dnatsrednu tnod uoy esoppus I...'},
		},
	},

	['Blot_Poppy'] = {
		[1] = {
			{origin = 2, dialogue = 'Aw I think I might have a little stain on my dress!'},
			{origin = 1, dialogue = '...eeeem ta revo yaw siht kool ydobon ,em ta kool tnoD-'},
			{origin = 2, dialogue = 'What was that Blot?'},
			{origin = 1, dialogue = '.gnihtoN'},
		},
	},

	['Blot_Razzle n Dazzle'] = {
		[1] = {
			{origin = 1, dialogue = '.no sreyal eerht tup I raews I ?sevolg eseht hguorht gnipaes kni sI'},
			{origin = 2, dialogue = 'Hm? (...Blot did I hear that right? Do you wear three pairs of gloves at once...?)'},
			{origin = 1, dialogue = '.gnileef ddo na stahT .erom em dnatsrednu ot gnitrats eruoy ,haoW'},
			{origin = 2, dialogue = 'You really have to tell me what hes saying. (...Uhm I didnt get that one really.)'},
			{origin = 1, dialogue = '.sevolg fo sriap eerht reaw I'},
			{origin = 2, dialogue = 'How about that? (...Oh! He wears three pairs of gloves...)'},
		},
		[2] = {
			{origin = 2, dialogue = 'Blot hey friend! (I hope youre not so tired Blot, with all the miming...)'},
			{origin = 1, dialogue = '!si yllausu ortsA sa derit sa toN... !yeH'},
			{origin = 2, dialogue = 'Huh? What? (Hm... oh! Haha... I think I understood some.)'},
			{origin = 1, dialogue = '.ti steg yug sihT !yA'},
		},
	},

	['Blot_Rodger'] = {
		[1] = {
			{origin = 2, dialogue = 'Pardon me if this is a bothersome question Blot, but is it true you only have one eye?'},
			{origin = 1, dialogue = '!gniksa si ohw kool lleW'},
			{origin = 2, dialogue = '...Is that a yes or a no?'},
			{origin = 1, dialogue = '.regdoR seY'},
			{origin = 2, dialogue = 'Ah well, thank you for your answer, I do appreciate it. Couldnt help but be curious!'},
		},
	},

	['Blot_Rudie'] = {
		[1] = {
			{origin = 2, dialogue = 'Happy Holidays Blot! Are you excited TODAY is CHRISTMAS!'},
			{origin = 1, dialogue = '...eiduR samtsirhC ton stI'},
			{origin = 2, dialogue = 'Whats that? Youre as excited as me!? WOW! I didnt know you were SO festive!!!'},
			{origin = 1, dialogue = '!dias I tahw tnsi taht wonk uoY'},
		},
	},

	['Blot_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Blot, I had some very emotional based art and I was thinking, maybe youd wanna help!'},
			{origin = 1, dialogue = '.eb lliw aedi siht tahw rednow I eeG'},
			{origin = 2, dialogue = 'So I get this canvas, right? And then you just run into it really fast and-'},
			{origin = 1, dialogue = '.oN'},
		},
		[2] = {
			{origin = 2, dialogue = 'So lets say my pen ran out of ink, and I was looking for more ink...'},
			{origin = 1, dialogue = '.on esaelP'},
			{origin = 2, dialogue = '-And there was this amazing Toon I knew who may or may not have had a great abundance of ink...'},
			{origin = 1, dialogue = '!siht gniod ton, epon, on, oN'},
		},
	},

	['Blot_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = '...ehcadaeh a fo tib a gnitteg mI kniht I'},
			{origin = 2, dialogue = 'Huh? What did you say?'},
			{origin = 1, dialogue = '.ruasoniD'},
			{origin = 2, dialogue = 'OH! OH! I know that one! Yes! I knew you were a dinosaur fan! Hehehe! YES!'},
			{origin = 1, dialogue = '.sruasonid tuoba gniklat tnecrep derdnuh eno saw I ,erus haeY'},
		},
		[2] = {
			{origin = 2, dialogue = 'Blot are we really sure youre ink? What if you were oil! Oil made of fossil fuels?'},
			{origin = 1, dialogue = '?...siht htiw gniog uoy era erehW'},
			{origin = 2, dialogue = 'If you were... you would be sort of, maybe, part dinosaur in a way!'},
			{origin = 1, dialogue = '.won siht htiw gniog si ehs erehw ees I hO'},
			{origin = 2, dialogue = 'Blot if I could assign you a dinosaur, I think youd be a Baryonyx!'},
		},
	},

	['Blot_Shrimpo'] = {
		[1] = {
			{origin = 2, dialogue = 'I HATE MIMES!!!'},
			{origin = 1, dialogue = '!yug siht fo daol a teG'},
			{origin = 2, dialogue = 'WHATEVER YOU SAID, I HATE IT!'},
		},
	},

	['Blot_Sprout'] = {
		[1] = {
			{origin = 2, dialogue = 'Blot are you meant to be dripping that much ink? Youre not hurt are you?'},
			{origin = 1, dialogue = '.enif mI'},
			{origin = 2, dialogue = 'It doesnt hurt to lose ink does it? That would be awful, youd tell me right???'},
			{origin = 1, dialogue = '!tuorpS enif mI'},
			{origin = 2, dialogue = 'If you say so, but know Im here to help!'},
		},
	},

	['Blot_Squirm'] = {
		[1] = {
			{origin = 2, dialogue = 'Blot... a-are you scared too...?'},
			{origin = 1, dialogue = '.yllaer toN'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = '?uoy od ,em dnatsrednu tnod uoY'},
			{origin = 2, dialogue = '. . .Snf...sniffle-'},
		},
	},

	['Blot_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Blot are you doing well?'},
			{origin = 1, dialogue = '?uoy dna ,ma I'},
			{origin = 2, dialogue = 'Im doing lovely, though Ive so many tea parties to plan. Care to join one?'},
			{origin = 1, dialogue = '-fo derit fo tros neeb evI ereht tnera nniF ro sparcS yllufepoh ,dab dnuos tnseod yltsenoh tahT'},
			{origin = 2, dialogue = 'Oh! I know! - There is one I could invite you to that has Scraps and Finn! You can join that tea party!'},
			{origin = 1, dialogue = 'taeeerg hO...'},
		},
	},

	['Blot_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = '!peews attog I !em ta kooL'},
			{origin = 2, dialogue = 'Did you say something?'},
			{origin = 1, dialogue = '.oN'},
		},
		[2] = {
			{origin = 2, dialogue = 'Blot please, please, PLEASE stop making such a mess wherever you go!'},
			{origin = 1, dialogue = '?kni gnieb pots tsuj nac I kniht ehs seoD'},
			{origin = 2, dialogue = 'Whatd you say...? Nevermind that! Just stop making a mess please?'},
			{origin = 1, dialogue = '.elbissopmi yllacisyhP'},
			{origin = 2, dialogue = 'This is like... my worst nightmare, AND IVE SEEN GIGIS ROOM!'},
		},
	},

	['Blot_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'Blot!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Hey! Hey! Blot! Heeey!'},
			{origin = 1, dialogue = '?...seY'},
			{origin = 2, dialogue = 'Hehehe! I got you to talk!'},
			{origin = 1, dialogue = '-tfP ...revocer I lliw woh ho ,on ho ,detramstuo ,yob hO'},
		},
	},

	['Blot_Vee'] = {
		[1] = {
			{origin = 1, dialogue = '?no rotalsnart ruoy evah uoy oD ?eeV'},
			{origin = 2, dialogue = 'Yeah I do, what was it you wanted to say Blot?'},
			{origin = 1, dialogue = '-stca sucric ruo fo eno rof moor saw ereht kniht uoy did ,wohs ruoy tuobA'},
			{origin = 2, dialogue = '...And setting translator program off slooowly.'},
			{origin = 1, dialogue = 'hgu... !eeV !nomC !eeV'},
		},
		[2] = {
			{origin = 2, dialogue = 'Blot youre sure you rather keep performing with the circus crew?'},
			{origin = 1, dialogue = '.lliw syawlA'},
			{origin = 2, dialogue = 'Well... if you ever change your mind-'},
			{origin = 1, dialogue = '!em deen syawla lliw attaY dna yeooL tnow I'},
			{origin = 2, dialogue = 'Fine, fine, do what youd like of course'},
		},
	},

	['Blot_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = '?stnev eht ni derots uoy ydnac eht denaelc uoy evah attaY'},
			{origin = 2, dialogue = 'Thats my winter storage for the cold months!'},
			{origin = 1, dialogue = '!YDNAC TNEV EDIH OT DEEN TNOD UOY ,edisni lla erew ,lerriuqs a ton eruoy attaY'},
			{origin = 2, dialogue = 'YOULL NEVER TAKE MY CANDY STASH NEVEEER!!!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Blot! Blot! Blot!'},
			{origin = 1, dialogue = '. . .'},
			{origin = 2, dialogue = 'BLOT SPEAK TO ME!!!'},
			{origin = 1, dialogue = '?...ti si tahw, attaY'},
			{origin = 2, dialogue = 'Hehehe... Hi!'},
			{origin = 1, dialogue = '!attaY iH -tfP'},
		},
	},

	['Bobette_Coal'] = {
		[1] = {
			{origin = 1, dialogue = 'Coal! Whos a good girl? You are! You are!'},
			{origin = 2, dialogue = '... Bwoof.'},
			{origin = 1, dialogue = 'Aww my cute pet rock!'},
			{origin = 2, dialogue = 'Bworf.'},
			{origin = 1, dialogue = 'You could never do any wrong, ever.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Bworf!'},
			{origin = 1, dialogue = 'Awww what is it girl? Love seeing me?'},
			{origin = 2, dialogue = 'Bwoof, bwork.'},
			{origin = 1, dialogue = 'Youre the best pet I could ever ask for...'},
			{origin = 2, dialogue = '... Bwoof.'},
		},
	},

	['Bobette_Connie'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya Connie! Are you feeling the spirit of Christmas joy in the air!'},
			{origin = 2, dialogue = 'EH... not exactly? Ill be real with you Bobette- Youre very Christmas-y?'},
			{origin = 1, dialogue = 'Yeah...? That is sort of my thing!'},
			{origin = 2, dialogue = 'Yeah, yeah- but I feel like Christmas happens way too soon after Halloween.'},
			{origin = 1, dialogue = 'What! Oh come on, Im sure youre just overreacting a little!'},
			{origin = 2, dialogue = 'Naaah girl... I swear, the Christmas decorations start way too early! Halloween should last so much longer!'},
		},
	},

	['Bobette_Finn'] = {
		[1] = {
			{origin = 1, dialogue = 'Sooo... Finn, I got your note about what you were wanting as a gift.'},
			{origin = 2, dialogue = 'REEL-y??? Good! Im sure you found it FIN-tastic!'},
			{origin = 1, dialogue = 'Finn, buddy, friend, uhm... I counted around- seventeen whole fish puns written.'},
			{origin = 2, dialogue = 'Yup! and-?'},
			{origin = 1, dialogue = 'Oh uhm... uh- I didnt understand it that well...'},
			{origin = 2, dialogue = 'Haha-! Dont worry, I just wanted another tackle box!'},
		},
	},

	['Bobette_Flutter'] = {
		[1] = {
			{origin = 1, dialogue = 'Flutter! I heard from one of your friends that you wanted some new colorful pens!'},
			{origin = 2, dialogue = '...!!!'},
			{origin = 1, dialogue = 'That makes sense, Im sure your diary has pretty pages still wanting to be filled!'},
			{origin = 2, dialogue = '...!'},
			{origin = 1, dialogue = 'Wait... Gigi does the writing? ...Ill make sure there are extra pens.'},
		},
	},

	['Bobette_Ginger'] = {
		[1] = {
			{origin = 1, dialogue = 'Ginger! Its so lovely to have you around!'},
			{origin = 2, dialogue = 'Oh..! Yeah, thank you... Nice to see you as well.'},
			{origin = 1, dialogue = 'Thinking of making some of your sweet treats later?'},
			{origin = 2, dialogue = 'Youd be interested in some...?'},
			{origin = 1, dialogue = 'Of course! Thats why Im asking silly!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Bobette, is there something on my face...?'},
			{origin = 1, dialogue = 'Your makeup?'},
			{origin = 2, dialogue = 'Huh... well no, I mean... I suppose that counts.'},
			{origin = 1, dialogue = 'I think you did a great job with it!'},
			{origin = 2, dialogue = 'Ah... thank you.'},
		},
	},

	['Bobette_Gourdy'] = {
		[1] = {
			{origin = 2, dialogue = 'Christmas Lady!!! I hear, instead of candy... you give TOYS.'},
			{origin = 1, dialogue = 'Yup! Though... you could still have Candy as a gift.'},
			{origin = 2, dialogue = 'WOAH- So it is true... going door to door trick or treating for toys!!!'},
			{origin = 1, dialogue = 'Oh uhm... you dont go door to door getting a toy.'},
			{origin = 2, dialogue = 'You... dont? Where does the cool toy come from then???'},
			{origin = 1, dialogue = 'From under a tree of course! Left by friends and faaaammm- uh...Oh wow, look a blind!'},
		},
		[2] = {
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '...Huh? Why are you staring at me!'},
			{origin = 1, dialogue = 'Huh! Oh... I was? Sorry, I suppose I just didnt think Id see a halloween uhm-'},
			{origin = 2, dialogue = 'A Halloween Toon? YEAH WELL- YOU ARE! And Im like the most awesome-ist Halloween Toon!'},
			{origin = 1, dialogue = 'Well, if you say so! Then that must be true.'},
		},
	},

	['Bobette_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'Aw so cute...!'},
			{origin = 2, dialogue = 'Bark! Arf!'},
			{origin = 1, dialogue = 'You remind me of Coal when I first got her, so tiny!'},
			{origin = 2, dialogue = 'Bark.'},
			{origin = 1, dialogue = '--I mean! So very big and strong!'},
		},
	},

	['Bobette_Rudie'] = {
		[1] = {
			{origin = 2, dialogue = 'I looove Christmas!'},
			{origin = 1, dialogue = 'Haha yeah me too...!'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'We sure do love Christmas.'},
			{origin = 1, dialogue = '...Happens once a year.'},
		},
		[2] = {
			{origin = 1, dialogue = 'I love giving gifts to my friends!'},
			{origin = 2, dialogue = 'Good thing its Christmas!'},
			{origin = 1, dialogue = '...Rudie.'},
			{origin = 2, dialogue = 'What?'},
			{origin = 1, dialogue = 'Its not Christmas buddy.'},
			{origin = 2, dialogue = 'I know its Christmas, in my heart!!!'},
		},
	},

	['Bobette_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'After this I have to really focus on finishing my craft projects...'},
			{origin = 2, dialogue = 'Well I wish you luck! I myself like to sew a little.'},
			{origin = 1, dialogue = 'You sew...? I thought your thing was dinosaurs?'},
			{origin = 2, dialogue = 'I can have my little side hobbies, haha... Dont you?'},
			{origin = 1, dialogue = 'Uhm... haha... probably, I mean yeah sure, I do.'},
		},
	},

	['Bobette_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = 'You might be on the naughty list to be honest...'},
			{origin = 2, dialogue = 'I HATE THE NAUGHTY LIST!'},
			{origin = 1, dialogue = 'Uhuh...?'},
			{origin = 2, dialogue = 'AND I HATE YOU!!!'},
			{origin = 1, dialogue = 'Oh...uhm ok... sorry?'},
		},
	},

	['Bobette_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Sooo, ever make a gingerbread house?'},
			{origin = 2, dialogue = 'Uhm, Nah, I mean Ive tried but it fell apart.'},
			{origin = 1, dialogue = 'Maybe you should invite Ginger to help next time!'},
			{origin = 2, dialogue = 'Oh yeah Cosmos cousin? Shes great at decorating stuff.'},
			{origin = 1, dialogue = 'Mhm!'},
		},
	},

	['Bobette_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Tisha, are you hoping for the same gift as last year? and uhm... the year before that? Haha-'},
			{origin = 2, dialogue = 'Mhm! Cleaning supplies.'},
			{origin = 1, dialogue = 'Yeaaah, thats what I thought.'},
			{origin = 2, dialogue = 'Maybe we could get a little crazy this year and toss in a new mop!'},
			{origin = 1, dialogue = 'Ill see what I can do...'},
		},
	},

	['Bobette_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Toodles, I noticed you have a veeeery long list of toys youd want for Christmas.'},
			{origin = 2, dialogue = 'Yeah! I couldnt really decide, there is just so many cool things I could think of!'},
			{origin = 1, dialogue = '...Now dont get me wrong, Im thrilled that youre so excited! -But I think you may want too many toys.'},
			{origin = 2, dialogue = 'Bobette Carolynne, there is NEVER too many toys.'},
			{origin = 1, dialogue = 'Hahah... Did Rodger tell you my full name-???'},
			{origin = 2, dialogue = 'Uhmmmm....noooo....maybe.'},
		},
	},

	['Bobette_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Mmm, I could go for some cookies and hot cocoa...'},
			{origin = 2, dialogue = 'You could talk with Teagan about that.'},
			{origin = 1, dialogue = 'Oh yeah! Would you want to join if I asked her?'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'Oh! Right... You dont really drink or eat...'},
		},
	},

	['Boxten_Brightney'] = {
		[1] = {
			{origin = 1, dialogue = 'Brightney, you seem pretty focused, something on your mind?'},
			{origin = 2, dialogue = 'Theres always something on my mind Boxten!'},
			{origin = 1, dialogue = 'Oh?'},
			{origin = 2, dialogue = 'Yup! Always have to be three steps ahead of those Twisteds!'},
		},
	},

	['Boxten_Brusha'] = {
		[1] = {
			{origin = 1, dialogue = 'You know Brusha, your art is very nice!'},
			{origin = 2, dialogue = 'Why thank you, I am the best artist, despite what others may say.'},
			{origin = 1, dialogue = '...What do you mean by that?'},
			{origin = 2, dialogue = 'Nevermind, you wouldnt understand the challenges an artist like me faces.'},
		},
	},

	['Boxten_Cocoa'] = {
		[1] = {
			{origin = 1, dialogue = 'Cocoa, I had just a small question- if thats alright?'},
			{origin = 2, dialogue = 'Of course its alright! Im always open to a question from a friend!'},
			{origin = 1, dialogue = 'Well... What is your favorite music genre?'},
			{origin = 2, dialogue = 'Hmm- how about any genre that reminds me of Easter!'},
			{origin = 1, dialogue = 'Not sure what genre that would be in specifically- but thats nice...'},
		},
	},

	['Boxten_Connie'] = {
		[1] = {
			{origin = 1, dialogue = 'Connie, do you think you could stop scaring me around corners?'},
			{origin = 2, dialogue = 'Ill think about it.'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'And-?'},
			{origin = 2, dialogue = 'Ive decided Ill keep doing it! Youre too easy of a scare!'},
		},
	},

	['Boxten_Cosmo'] = {
		[1] = {
			{origin = 2, dialogue = 'Boxten, your key on the back of your head spins whenever you use your ability.'},
			{origin = 1, dialogue = 'Huh really? It tends to spin when I focus on something..'},
			{origin = 2, dialogue = 'Is that why it spins when I teach you recipes?'},
			{origin = 1, dialogue = 'Well I get nervous with the oven! Rather be focused...'},
			{origin = 2, dialogue = 'I think you do great, try not to stress about it..!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Pft- I just remembered the time I mistook salt for sugar.'},
			{origin = 2, dialogue = 'Haha yeah, I have to check every time Im in the kitchen with you now!'},
			{origin = 1, dialogue = 'Well were thankful to have someone as caring as you...!'},
			{origin = 2, dialogue = 'Aw, thanks Boxten! Thats kind of you to say!'},
		}
	},

	['Boxten_Eggson'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey there, Eggson!'},
			{origin = 2, dialogue = 'Hello there, young man! Have you been taking care of yourself?'},
			{origin = 1, dialogue = 'I have...but I still end up getting stressed sometimes.'},
			{origin = 2, dialogue = 'Worry not! This wise egg has a relaxing story or two to help you calm down.'},
			{origin = 1, dialogue = 'Id appreciate that a lot, thank you..!'},
		},
	},

	['Boxten_Finn'] = {
		[1] = {
			{origin = 1, dialogue = 'Ive been wondering, whats your favorite fish?'},
			{origin = 2, dialogue = 'A favorite? I could never pick a favorite!'},
			{origin = 1, dialogue = 'Oh, well, I like the Tuna..!'},
			{origin = 2, dialogue = 'Well, youre a TUNA-fun!'},
			{origin = 1, dialogue = 'I... I dont get it.'},
		},
	},

	['Boxten_Flutter'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Flutter, how are you holding up?'},
			{origin = 2, dialogue = '...!'},
			{origin = 1, dialogue = 'Oh...'},
			{origin = 2, dialogue = '!!!'},
			{origin = 1, dialogue = 'Ah, yikes, sorry to have asked...'},
		},
		[2] = {
			{origin = 2, dialogue = '!!!'},
			{origin = 1, dialogue = 'Its okay Flutter, I could understand why youre upset.'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Well, I-I mean I can understand a little!'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'Or...not a lot???'},
		},
	},

	['Boxten_Gigi'] = {
		[1] = {
			{origin = 1, dialogue = 'Huh... My pockets feel lighter for some reason?'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Gigi-?'},
			{origin = 2, dialogue = 'Dont look at me! Im an innocent bystander!'},
			{origin = 1, dialogue = 'I-Im not trying to accuse you of anything'},
			{origin = 2, dialogue = 'Yeaaah, thats right! ...Im like, so innocent.'},
		},
	},

	['Boxten_Ginger'] = {
		[1] = {
			{origin = 2, dialogue = 'Your turning key on the back of your head... its sort of--'},
			{origin = 1, dialogue = 'Moving?'},
			{origin = 2, dialogue = 'Yeah...'},
			{origin = 1, dialogue = 'It moves on its own really...! Spins when Im really thinking on things.'},
			{origin = 2, dialogue = 'Thats kind of neat in a way...!'},
			{origin = 1, dialogue = 'Heh, yeah guess it is!'},
		},
	},

	['Boxten_Glisten'] = {
		[1] = {
			{origin = 2, dialogue = 'Hm... Boxy, is my makeup smudged?!'},
			{origin = 1, dialogue = 'Huh? O-oh uh... no?'},
			{origin = 2, dialogue = 'Thats right, its always perfect.'},
			{origin = 1, dialogue = 'Then whyd you ask me to check?'},
			{origin = 2, dialogue = 'Oh, I just wanted you to look!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Glisten, busy later..? I was hoping we could spend some time.'},
			{origin = 2, dialogue = 'Depends, what time would "later" be?'},
			{origin = 1, dialogue = 'I-I dont know, just tonight?'},
			{origin = 2, dialogue = 'Sure, but I pick whats playing on television!'},
			{origin = 1, dialogue = 'Sounds good then!'},
		}
	},

	['Boxten_Goob'] = {
		[1] = {
			{origin = 2, dialogue = 'Boxten... Have you ever noticed that both our heads are squares?'},
			{origin = 1, dialogue = 'Huh? W-what..?'},
			{origin = 2, dialogue = 'Yeah! Mine doesnt have music in it like yours though.'},
			{origin = 1, dialogue = 'Right, well unless you imagine the music!'},
			{origin = 2, dialogue = 'Oh yeah! Im going to think about music right now!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Goob! How do you keep such a happy smile most of the time?'},
			{origin = 2, dialogue = 'I think of the positives in every situation and challenge we face!'},
			{origin = 1, dialogue = 'Ah, I wish that was easier for someone like me...'},
			{origin = 2, dialogue = 'Not everyone can be like me! Or like you! So just be you!'},
			{origin = 1, dialogue = '...Thanks-?'},
		}
	},

	['Boxten_Looey'] = {
		[1] = {
			{origin = 2, dialogue = 'I like your square head!'},
			{origin = 1, dialogue = 'What?'},
			{origin = 2, dialogue = 'I like that your head is a square!'},
			{origin = 1, dialogue = 'I mean, thanks?'},
			{origin = 2, dialogue = 'No problem!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Hey uh Looey? Whats it like having a tail?'},
			{origin = 2, dialogue = 'Maybe you should ask Yatta! She has four!'},
			{origin = 1, dialogue = 'Yeah but... Im asking you?'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = '. . .'},
			{origin = 2, dialogue = 'Ive had my tail stuck in a doorway for hours once.'},
		},
	},

	['Boxten_Pebble'] = {
		[1] = {
			{origin = 2, dialogue = 'Arf Arf!!'},
			{origin = 1, dialogue = 'Uhm... thats a good rock?'},
			{origin = 2, dialogue = 'Bwoof!!'},
		},
		[2] = {
			{origin = 1, dialogue = 'I wonder what itd be like to have my own pet...'},
			{origin = 2, dialogue = 'Grrr...'},
			{origin = 1, dialogue = 'On second thought, maybe its too much responsibility.'},
		},
	},

	['Boxten_Poppy'] = {
		[1] = {
			{origin = 2, dialogue = 'Hi Boxten!'},
			{origin = 1, dialogue = 'H-hi Poppy...'},
			{origin = 2, dialogue = 'I SAID HI BOXTEN!!!'},
			{origin = 1, dialogue = 'Poppy are you okay...'},
			{origin = 2, dialogue = 'Haha, Im okay enough!'},
		},
		[2] = {
			{origin = 1, dialogue = 'I feel like we could have done better last blind...'},
			{origin = 2, dialogue = 'Oooh dont worry too much about it Boxten! You worry WAAAAAAY too much!'},
			{origin = 1, dialogue = 'What? You think I worry too much?'},
			{origin = 2, dialogue = 'See thats what I mean! Youre worrying again!'},
			{origin = 1, dialogue = 'Wow...'},
		},
	},

	['Boxten_Razzle n Dazzle'] = {
		[1] = {
			{origin = 1, dialogue = 'The two of you have been helping finish the rounds on each ante, right?'},
			{origin = 2, dialogue = 'Uh- Hehe, sorta! (I do the extracting much faster than him.)'},
			{origin = 1, dialogue = 'Well as long as youre both trying your best.'},
			{origin = 2, dialogue = 'Of course! Always trying my best! (I wish my best was enough...)'},
			{origin = 1, dialogue = 'Erm... Youre doing great Dazzle.'},
		},
	},

	['Boxten_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'Rodger, any luck or progress on your investigation?'},
			{origin = 2, dialogue = 'I believe Im making steady progress each day! Though I conduct multiple investigations!'},
			{origin = 1, dialogue = 'Oh right... sorry.'},
			{origin = 2, dialogue = 'No need to apologize Boxten! Just informing you!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Boxten, keeping your mind steady and clear?'},
			{origin = 1, dialogue = 'Uhm.. N-not really?'},
			{origin = 2, dialogue = 'Well, try counting if you find yourself worried or stressed!'},
		},
	},

	['Boxten_Rudie'] = {
		[1] = {
			{origin = 2, dialogue = 'BOXTEN! Did you know... The happiest holiday on earth, TODAY!'},
			{origin = 1, dialogue = 'Rudie... I know other Toons try to play along but... it isnt-'},
			{origin = 2, dialogue = 'Dont say it.'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'MERRY CHRISTMAS TO YOUUuuUUuu!!!!'},
			{origin = 1, dialogue = '...M-merry Christmas.'},
		},
	},

	['Boxten_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Scraps... have you been taking the pencils from my room in the night?'},
			{origin = 2, dialogue = 'What?! No, that couldve been anyone on our blind!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Shrimpo?'},
			{origin = 1, dialogue = 'Shrimpo.'},
		},
	},

	['Boxten_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey ...you? How are you doing?'},
			{origin = 2, dialogue = 'Me-? Im alright...what about you?'},
			{origin = 1, dialogue = 'Could be better...'},
			{origin = 2, dialogue = 'Yeah I get that-'},
		},
	},

	['Boxten_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = 'Please dont look my way, please dont look my way...'},
			{origin = 2, dialogue = 'BOXTEN!!!!'},
			{origin = 1, dialogue = 'Ugh...'},
			{origin = 2, dialogue = 'BOXTEN YOUR MUSIC IS AWFUL!!!! GIVE UP YOUR CAREER!!!!'},
			{origin = 1, dialogue = 'I am not even a music artist Shrimpo... Im just a music box.'},
		},
	},

	['Boxten_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Sprout, this might not be the best time to tell you this...'},
			{origin = 2, dialogue = '-Huh? What? Are you okay?'},
			{origin = 1, dialogue = 'I-Im okay! But uh, I did sort of lose that apron you got me.'},
			{origin = 2, dialogue = 'Ah just that! -Dont worry about it, Ill find you a new one later!'},
			{origin = 1, dialogue = 'Thanks, I appreciate it!'},
		},
	},

	['Boxten_Squirm'] = {
		[1] = {
			{origin = 2, dialogue = 'Snf... sniffle-'},
			{origin = 1, dialogue = 'Hey Squirm... You alright...?'},
			{origin = 2, dialogue = 'Noooo.... everything is AWFUL!!!'},
			{origin = 1, dialogue = 'But wait- theres that one thing... or uhm no wait- theres uhm... Huh.'},
			{origin = 2, dialogue = 'SEE, EVERYTHING IS AWFUL!!! WAAAH!!!'},
			{origin = 1, dialogue = '...O-oh my, Ill uh...uhm- forget I said anything!'},
		},
	},

	['Boxten_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Stressed Boxten...?'},
			{origin = 1, dialogue = 'Oh! Only a little...'},
			{origin = 2, dialogue = 'Maybe a herbal tea would soothe you after we finish here.'},
			{origin = 1, dialogue = 'That would be nice... Thank you Teagan.'},
		},
	},

	['Boxten_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Tisha! Good to know youre here...!'},
			{origin = 2, dialogue = 'Of course! Ill be sure to keep this hands real clean!'},
			{origin = 1, dialogue = 'Huh... how clean?'},
			{origin = 2, dialogue = 'Shining, sparkling, so clean youll need a wet hand sign!'},
			{origin = 1, dialogue = 'Oh.'},
		},
	},

	['Boxten_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Toodles I noticed that art you drew for Poppy...!'},
			{origin = 2, dialogue = 'Uhuh! Wait- whered you see it?'},
			{origin = 1, dialogue = 'Poppy hung it up in her room to see better.'},
			{origin = 2, dialogue = 'WOAH!! That must mean she REALLY liked it!'},
			{origin = 1, dialogue = 'Mhm...!'},
		},
	},

	['Boxten_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'I cant believe Im in the same run as THE Vee...'},
			{origin = 2, dialogue = 'Youre a fan of the gameshow Boxten?'},
			{origin = 1, dialogue = 'Who isnt? Youve got such fun questions, I love trivia!'},
			{origin = 2, dialogue = 'Haha, who doesnt!?'},
			{origin = 1, dialogue = 'Was that one of your trivia questions??'},
			{origin = 2, dialogue = 'No.'},
		},
	},

	['Boxten_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'All this running around has already gotten me a bit tired...'},
			{origin = 2, dialogue = 'BOXTEN!!! PUMP. UP. THE ENERGY!!!'},
			{origin = 1, dialogue = 'I-I... what? I mean, I am awake now!'},
			{origin = 2, dialogue = 'Yeeeah! Yatta coming with the -WAKE UP CALL!!!'},
			{origin = 1, dialogue = 'Yay?'},
			{origin = 2, dialogue = 'YAY!!!'},
		},
	},

	['Brightney_Cocoa'] = {
		[1] = {
			{origin = 2, dialogue = 'Brightney! I noticed the libraries had some books out of order, so I helped categorize!'},
			{origin = 1, dialogue = 'Wow, Cocoa, thats very helpful! But... how did you organize them?'},
			{origin = 2, dialogue = 'Hm?'},
			{origin = 1, dialogue = 'I mean, you did organize them and categorize them in some sort of order... right?'},
			{origin = 2, dialogue = '...Huh? Oh! Right! I categorized based on Dazzles notes! I dont fully remember.'},
			{origin = 1, dialogue = 'Phew... Right, thank you Cocoa!'},
		},
	},

	['Brightney_Connie'] = {
		[1] = {
			{origin = 1, dialogue = 'Youve been doing a great job helping, Connie!'},
			{origin = 2, dialogue = 'I mean, I am pretty good at this.'},
			{origin = 1, dialogue = 'Keep up the good energy!'},
			{origin = 2, dialogue = 'Will do, yup, you got it!'},
		},
		[2] = {
			{origin = 2, dialogue = '...Heeey'},
			{origin = 1, dialogue = 'Hey Connie!'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = '...Yeah?'},
			{origin = 2, dialogue = 'Hey.'},
			{origin = 1, dialogue = 'Haha, Hi Connie.'},
		},
	},

	['Brightney_Cosmo'] = {
		[1] = {
			{origin = 1, dialogue = 'Cosmo! How is that cookbook I gave you?'},
			{origin = 2, dialogue = 'Its great, Brightney! Sprout and I are learning a lot of recipes from the book!'},
			{origin = 1, dialogue = 'Im glad to hear that! I didnt know Sprout enjoyed the cookbook as well.'},
			{origin = 2, dialogue = 'Yeah, we sit together and read it when we get the chance to!'},
		},
	},

	['Brightney_Eclipse'] = {
		[1] = {
			{origin = 2, dialogue = 'Woah... your light is so bright! YOURE SO BRIGHT!!!'},
			{origin = 1, dialogue = 'Ah, uhm... thank you!'},
			{origin = 2, dialogue = 'I LOVE bright lights! How do I glow as bright as you in the night?'},
			{origin = 1, dialogue = 'Hmm, I could show you what type of lightbulbs I use!'},
			{origin = 2, dialogue = 'Yes please!! YES!!'},
		},
	},

	['Brightney_Eggson'] = {
		[1] = {
			{origin = 2, dialogue = 'Brightney, do you think you could make me one of those lists you make?'},
			{origin = 1, dialogue = 'A to-do list? Of course! Can I ask what you plan to-do then! Haha.'},
			{origin = 2, dialogue = 'Yes, yes... First there is painting the eggs, second is to find more eggs, third is for eggs to-'},
			{origin = 1, dialogue = 'Eggson... are all of these notes planned to be egg-related?'},
			{origin = 2, dialogue = 'Yes.'},
			{origin = 1, dialogue = 'Why dont we write these down a bit later then... haha-'},
		},
	},

	['Brightney_Finn'] = {
		[1] = {
			{origin = 2, dialogue = 'Brightney, you remind me of a goldfish!'},
			{origin = 1, dialogue = 'Wha-? Excuse me?? Are you calling me forgetful?'},
			{origin = 2, dialogue = 'No, no, quite the opposite! Despite the stereotype, goldfish actually have amazing memory!'},
			{origin = 1, dialogue = 'Oh... I didnt know that. Thank you for the compliment, Finn!'},
		},
	},

	['Brightney_Flutter'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya Flutter! You know what a Lepidoptera is?'},
			{origin = 2, dialogue = '...???'},
			{origin = 1, dialogue = 'Its the scientific name of a butterfly!'},
			{origin = 2, dialogue = '...!'},
			{origin = 1, dialogue = 'Hehe yeah, I know its pretty cool!'},
		},
		[2] = {
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Oh? Youre interested in my light?'},
			{origin = 2, dialogue = '...!'},
			{origin = 1, dialogue = 'Ah I use an incandescent lightbulb! Thanks for asking.'},
		}
	},

	['Brightney_Gigi'] = {
		[1] = {
			{origin = 2, dialogue = 'Brightney I think one of my friends sorta wants to hang out with you...'},
			{origin = 1, dialogue = 'Uhuh...? And why cant whoever tell me personally?'},
			{origin = 2, dialogue = '...She is like so nervous, she thinks youre too cool!'},
			{origin = 1, dialogue = 'She? Who is she?'},
			{origin = 2, dialogue = '...Ive for sure said too much.'},
		},
	},

	['Brightney_Ginger'] = {
		[1] = {
			{origin = 2, dialogue = 'Brightney, I appreciate the help you offer when Christmas comes around, you know- with the lighting.'},
			{origin = 1, dialogue = 'Haha, no need to thank me! Really, I barely do anything when it comes to all those festive lights!'},
			{origin = 2, dialogue = 'But you do...! Bobette tells me so, and I just wanted to let you know... its appreciated.'},
			{origin = 1, dialogue = 'Aw well, thanks... even if I still think Its not much on my end.'},
		},
	},

	['Brightney_Glisten'] = {
		[1] = {
			{origin = 2, dialogue = 'Brightney, whats this about having a book club Ive heard...?'},
			{origin = 1, dialogue = 'Me, Astro and Dazzle all read books!'},
			{origin = 2, dialogue = '-And you didnt invite me?!'},
			{origin = 1, dialogue = 'We did. Several times. You never show up Glisten.'},
			{origin = 2, dialogue = '...Oh yeah! Hahaha, I just like to feel included!'},
		},
	},

	['Brightney_Goob'] = {
		[1] = {
			{origin = 1, dialogue = 'Hi Goob, hows Scraps doing?'},
			{origin = 2, dialogue = 'Heya! Oooh you know! Shes doing good!'},
			{origin = 1, dialogue = 'And what about you? How are things?'},
			{origin = 2, dialogue = 'Oooh you knoooow! Hehe!'},
			{origin = 1, dialogue = 'Oh come on! I dont know everything!'},
		},
	},

	['Brightney_Looey'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Brightney, got any BRIGHT ideas?'},
			{origin = 1, dialogue = 'Looey, this is the fifth time youve made this joke this week.'},
			{origin = 2, dialogue = 'Wait, is it?'},
			{origin = 1, dialogue = 'Oh most definitely, I recall it very clearly.'},
			{origin = 2, dialogue = 'Yeesh, Ive got to write some more material to work with...'},
		},
	},

	['Brightney_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'You know Im not even sure what kind of rock you are'},
			{origin = 2, dialogue = 'Bark bark!'},
			{origin = 1, dialogue = 'Igneous, Sedimentary, maybe Metamorphic?'},
			{origin = 2, dialogue = 'Arf!'},
			{origin = 1, dialogue = 'You sure are one cute little mystery.'},
		},
	},

	['Brightney_Poppy'] = {
		[1] = {
			{origin = 1, dialogue = 'Hi Poppy! How are things going?'},
			{origin = 2, dialogue = 'Things are going!'},
			{origin = 1, dialogue = 'Just going?'},
			{origin = 2, dialogue = 'Just going!'},
			{origin = 1, dialogue = 'Oooh Poppy.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Heya Brightney!! Loving your lampshade!!'},
			{origin = 1, dialogue = 'Thanks! Its the same one I have every day actually...'},
			{origin = 2, dialogue = 'Nooo really? I swear your lampshade was pink last time I saw you!'},
			{origin = 1, dialogue = 'Nope! Always been red haha!'},
		},
	},

	['Brightney_Razzle n Dazzle'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey last book club was the fastest youve ever fallen asleep.'},
			{origin = 2, dialogue = 'Going for a new record! (Razzle...Dont be proud of that.)'},
			{origin = 1, dialogue = 'Hm I dont know Dazzle, they may have taken the record from Astro!'},
			{origin = 2, dialogue = 'Fastest sleeper award! (...Im sure Astro still holds that title.)'},
			{origin = 1, dialogue = 'Ill have to bring a timer to the next book club session I suppose.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Dazzle are you a little nervous? (...Why do you ask?)'},
			{origin = 1, dialogue = 'Razzle usually can just tell when it comes to you- and so can I!'},
			{origin = 2, dialogue = 'Yeah, youve got a little shake to your wrist. (...Sorry.)'},
			{origin = 1, dialogue = 'Nothing to be sorry on, completely normal to get a bit nervous here!'},
			{origin = 2, dialogue = 'Well get through this! (...Mhm, I appreciate you both, truly.)'},
		},
	},

	['Brightney_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'Rodger! Got any new cases youre working on?'},
			{origin = 2, dialogue = 'Ah, Brightney! Why of course, a great detective is always working!'},
			{origin = 1, dialogue = 'Of course, if you ever need some help, you know where to find me.'},
			{origin = 2, dialogue = 'Brightney, as kind as you are smart! Ill keep that in mind.'},
			{origin = 1, dialogue = 'Aw, thank you!!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Brightney! Keeping clever I assume?'},
			{origin = 1, dialogue = 'Yup! Im making sure to re-read the whole collection of books I got!'},
			{origin = 2, dialogue = 'Your mind must be sharp as it is bright!'},
		},
	},

	['Brightney_Rudie'] = {
		[1] = {
			{origin = 2, dialogue = 'Wow you glow! I glow!'},
			{origin = 1, dialogue = 'Well yeah! But technically its my lightbulb that glows!'},
			{origin = 2, dialogue = 'Oooh! Could you switch the color?'},
			{origin = 1, dialogue = 'Yeah! If I really wanted, Im sure I could.'},
			{origin = 2, dialogue = 'So cool!!'},
		},
	},

	['Brightney_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Scraps, lovely to see you! Have you solved that puzzle I let you borrow?'},
			{origin = 2, dialogue = 'Oh the puzzle? Erm. Well about that...'},
			{origin = 1, dialogue = 'Did you lose a piece again?'},
			{origin = 2, dialogue = 'Maaaaybe...'},
			{origin = 1, dialogue = 'Ill help you find it later, dont worry about it.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Heeey! Brightney! Whatcha thinking about?'},
			{origin = 1, dialogue = 'You want the honest truth?'},
			{origin = 2, dialogue = 'Uh huh! Of course.'},
			{origin = 1, dialogue = 'Im thinking about Trigonometry...'},
			{origin = 2, dialogue = 'Oh.'},
		}
	},

	['Brightney_Shelly'] = {
		[1] = {
			{origin = 2, dialogue = 'Brightney! You remind me of a Troodon!'},
			{origin = 1, dialogue = 'A Troodon...? Shelly, Im not a dinosaur...'},
			{origin = 2, dialogue = 'I-I mean Im not trying to call you old or anything! Sorry! Troodons were smart!'},
			{origin = 1, dialogue = 'Oh! Youre calling me smart! Haha... I was about to say.'},
			{origin = 2, dialogue = 'Yeah! Troodons were smart theropods! Appearing later in the Cretaceous period.'},
		},
	},

	['Brightney_Shrimpo'] = {
		[1] = {
			{origin = 2, dialogue = 'YOUR LIGHT IS ANNOYING!'},
			{origin = 1, dialogue = 'Ugh, not this again...'},
			{origin = 2, dialogue = 'TURN IT OFF!!!'},
			{origin = 1, dialogue = 'No!'},
			{origin = 2, dialogue = 'YOUR FAULT IF WE LOSE THEN!'},
		},
	},

	['Brightney_Sprout'] = {
		[1] = {
			{origin = 2, dialogue = 'Brightney please, please, PLEASE stay out of trouble...'},
			{origin = 1, dialogue = 'Why do you say that...?'},
			{origin = 2, dialogue = 'Well your light- It can get you easily seen.'},
			{origin = 1, dialogue = 'Oh! Yes! Ill be careful, or Ill try to be at least, thank you Sprout.'},
		},
	},

	['Brightney_Squirm'] = {
		[1] = {
			{origin = 2, dialogue = 'Brightney I-I was wondering uhm... do you think I-I could rejoin the book club...?'},
			{origin = 1, dialogue = 'Im not sure I can allow for that! You know why you were removed from the club...'},
			{origin = 2, dialogue = 'I-I know... snf- sniffle-'},
			{origin = 1, dialogue = 'Aw... dont cry Squirm, the choice is for your own good, we all really care about you.'},
			{origin = 2, dialogue = 'I-I know....'},
		},
		[2] = {
			{origin = 1, dialogue = 'Hey Squirm, youre doing very well'},
			{origin = 2, dialogue = 'I-I am...? I thought I was being- s-so- SO AWFUL!!'},
			{origin = 1, dialogue = 'Aww... No, no, dont think that way! Remember when were stressed, we...'},
			{origin = 2, dialogue = 'We take a big breath...?'},
			{origin = 1, dialogue = 'And...?'},
			{origin = 2, dialogue = 'We take a big breath, and dont eat the nearest book.'},
		},
	},

	['Brightney_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Brightney, how is your book club going?'},
			{origin = 1, dialogue = 'Its going well! Would you like to join us sometime?'},
			{origin = 2, dialogue = 'Sorry Brightney, Im much too busy with my tea parties. Perhaps another time?'},
			{origin = 1, dialogue = 'Of course! If you ever have some free time, Ive got the perfect book for you!'},
		},
	},

	['Brightney_Tisha'] = {
		[1] = {
			{origin = 2, dialogue = 'You know, Brightney, we should start like a cleaning club!'},
			{origin = 1, dialogue = 'Thats very sweet but Im already president of a book club!'},
			{origin = 2, dialogue = 'Aww man! I just think wed make a good team!'},
			{origin = 1, dialogue = 'Hahah, maybe Ill make an exception!'},
		},
	},

	['Brightney_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'Brightney, if things get dark youll be here right?'},
			{origin = 1, dialogue = 'Yeah! Of course.'},
			{origin = 2, dialogue = 'Good, not because Im scared of the dark or anything- Because Im not!!'},
			{origin = 1, dialogue = 'Uh huh... I get what you mean.'},
		},
	},

	['Brightney_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Sooo, got any plans after this?'},
			{origin = 2, dialogue = 'Hmm, not exactly but I could put something together if youre interested!'},
			{origin = 1, dialogue = 'Would you really? For me?!'},
			{origin = 2, dialogue = 'Of course! You are my best contestant after all!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Brightney! Lovely to know I have someone truly talented with me!'},
			{origin = 1, dialogue = 'Wait, like Im truly talented as opposed to "un-truly" talented?'},
			{origin = 2, dialogue = 'Yeah. . .?'},
			{origin = 1, dialogue = 'Yeah.'},
			{origin = 2, dialogue = 'Yeah alright, good talk.'},
		},
	},

	['Brightney_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Huh, youre near constantly moving... have you noticed that?'},
			{origin = 2, dialogue = 'I cant NOT move! Its like, I cant sit still!'},
			{origin = 1, dialogue = 'Well, do you want to sit still?'},
			{origin = 2, dialogue = 'NOT REALLY!!'},
			{origin = 1, dialogue = 'Well... You just keep being you, and well be supportive.'},
		},
		[2] = {
			{origin = 2, dialogue = 'BRIGHTNEEEEY!!!'},
			{origin = 1, dialogue = 'Yes Yatta...?'},
			{origin = 2, dialogue = 'WHEN will we be DONE!!'},
			{origin = 1, dialogue = 'Done with... what?'},
			{origin = 2, dialogue = 'All of THIS!!!'},
			{origin = 1, dialogue = 'Hmmm, unsure, but Ill let you know if I have a clue of when.'},
		},
	},

	['Brusha_Coal'] = {
		[1] = {
			{origin = 2, dialogue = 'Bworf!'},
			{origin = 1, dialogue = 'Oh... Youre erm... bigger than Pebble.'},
			{origin = 2, dialogue = 'Grrr...'},
			{origin = 1, dialogue = 'Dont get any closer. I know not to mess with a growling animal.'},
		},
	},

	['Brusha_Connie'] = {
		[1] = {
			{origin = 2, dialogue = 'So, whats the meaning behind your art?'},
			{origin = 1, dialogue = 'The meaning is so in depth that you wouldnt understand it.'},
			{origin = 2, dialogue = 'This is why no one invites you to parties.'},
		},
	},

	['Brusha_Cosmo'] = {
		[1] = {
			{origin = 2, dialogue = 'Brusha, have you ever used a piping bag?'},
			{origin = 1, dialogue = 'No, why would I ever use such a thing?'},
			{origin = 2, dialogue = 'There is an art to decorating desserts! My cousin loves to decorate desserts.'},
			{origin = 1, dialogue = 'Would you consider your cousin an artist?'},
			{origin = 2, dialogue = 'Of course I do!'},
		},
	},

	['Brusha_Finn'] = {
		[1] = {
			{origin = 1, dialogue = 'You know Finn, some say jokes are a form of art.'},
			{origin = 2, dialogue = 'You REEL-Y think so?'},
			{origin = 1, dialogue = 'No, not at all, I dont think so.'},
			{origin = 2, dialogue = '...Then why did you say it in the first place?'},
			{origin = 1, dialogue = 'Because if I dont like your jokes, at least someone less impressive does.'},
			{origin = 2, dialogue = 'I cant tell if youre complimenting me or not...'},
		},
	},

	['Brusha_Flutter'] = {
		[1] = {
			{origin = 2, dialogue = '...?'},
			{origin = 1, dialogue = 'I didnt know you were into abstract art!'},
			{origin = 2, dialogue = '...!!!'},
			{origin = 1, dialogue = 'Really?! ...Your palette'},
		},
	},

	['Brusha_Flyte'] = {
		[1] = {
			{origin = 2, dialogue = 'Brusha, still painting...?'},
			{origin = 1, dialogue = 'Of course Im "still painting". What sort of question is that meant to be!'},
			{origin = 2, dialogue = '...Im just making conversation, is all.'},
			{origin = 1, dialogue = '...ah.'},
			{origin = 2, dialogue = 'If its no trouble... Would you paint something for me?'},
			{origin = 1, dialogue = 'Hmm... Ill find the time for a request.'},
		},
	},

	['Brusha_Gigi'] = {
		[1] = {
			{origin = 2, dialogue = 'Brusha, I have a whole gallery worth of your artwork.'},
			{origin = 1, dialogue = '...How? Ive never given you any art pieces.'},
			{origin = 2, dialogue = 'Mweheheh...'},
			{origin = 1, dialogue = 'Oh....Right.'},
		},
	},

	['Brusha_Glisten'] = {
		[1] = {
			{origin = 1, dialogue = 'I need a better inspiration for my next piece.'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Maybe someone, a muse for my next piece.'},
			{origin = 2, dialogue = '...AHEM!'},
			{origin = 1, dialogue = 'Not you.'},
		},
		[2] = {
			{origin = 2, dialogue = 'You know, your art isnt bad.'},
			{origin = 1, dialogue = 'I know its not, my art is near perfect.'},
			{origin = 2, dialogue = 'Unlike me, I AM perfect!'},
		},
	},

	['Brusha_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Are you still doing that childish "art"?'},
			{origin = 2, dialogue = 'My art is realer than yours!'},
			{origin = 1, dialogue = 'I doubt that given your last art piece I saw used glitter glue!'},
			{origin = 2, dialogue = 'The glitter was very tasteful!!!'},
			{origin = 1, dialogue = 'Ew, you taste the glitter?'},
			{origin = 2, dialogue = 'Tasteful, as in the art was really, really, really good! Sheesh.'},
		},
	},

	['Brusha_Shrimpo'] = {
		[1] = {
			{origin = 2, dialogue = 'I HATE ART!!'},
			{origin = 1, dialogue = 'Your hatred is so vivid, that I cannot even take offense.'},
			{origin = 2, dialogue = 'I HATE THAT YOURE NOT TAKING OFFENSE!!!'},
			{origin = 1, dialogue = 'If my art invokes such emotion, it is worthy art.'},
			{origin = 2, dialogue = 'YOULL NEVER BE WORTHY!!!!'},
		},
	},

	['Brusha_Sprout'] = {
		[1] = {
			{origin = 2, dialogue = 'Brusha, even though Im sure I know your answer, how are you doing?'},
			{origin = 1, dialogue = 'Tch! What does it matter to you...? Pretending you care?'},
			{origin = 2, dialogue = 'Come on Brusha, I do care.'},
			{origin = 1, dialogue = 'You only care because the show said you had to.'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = '...I- ...I stand on what I said.'},
		},
	},

	['Brusha_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = 'I could easily capture your terribly sad aura through my art medium.'},
			{origin = 2, dialogue = '...O-oh, Im sorry...'},
			{origin = 1, dialogue = 'Dont be, an artist such as myself can find great inspiration in your very frequent tears.'},
			{origin = 2, dialogue = '...W-what?'},
			{origin = 1, dialogue = 'Tch- Of course you struggle to understand... I want to paint you a portrait.'},
			{origin = 2, dialogue = 'OH! Thats nice...I think? ...I hope-'},
		},
	},

	['Brusha_Teagan'] = {
		[1] = {
			{origin = 1, dialogue = 'Teagan, are you looking for another art piece anytime soon?'},
			{origin = 2, dialogue = 'Of course, I love your art!'},
			{origin = 1, dialogue = 'Thank you, its lovely to know SOMEONE has good taste.'},
			{origin = 2, dialogue = 'Brusha, what did I say about small comments like that?'},
			{origin = 1, dialogue = '...Right, "Dont talk lowly of others"... even if they are deserving.'},
			{origin = 2, dialogue = 'Maybe I should schedule us a few more one on one discussions over tea...'},
		},
	},

	['Brusha_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Tisha! Ive been working on TONS of new pieces lately...! You should uhm-'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = '...RIGHT! Youre still doing the whole... ignoring me thing.'},
			{origin = 2, dialogue = '...Hm'},
			{origin = 1, dialogue = 'Well- HAHAhaa... Youre always welcome to come visit! But you probably knew that.'},
			{origin = 2, dialogue = '...'},
		},
		[2] = {
			{origin = 2, dialogue = 'That last blind wasnt so bad!'},
			{origin = 1, dialogue = 'Of course it wasnt! Not when we work so well with one another! Right?'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'OH COME ON, cant you even AKNOWLEDGE ME! -I was saying a NICE thing!'},
			{origin = 2, dialogue = 'Dont raise your voice Brusha-'},
			{origin = 1, dialogue = 'UUugh!! . . . Yes Tisha.'},
		}
	},

	['Brusha_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Your gameshow is ok.'},
			{origin = 2, dialogue = 'Your art is ok.'},
			{origin = 1, dialogue = 'Just ok?'},
			{origin = 2, dialogue = 'Ive seen better.'},
			{origin = 1, dialogue = 'Same can be said for your gameshow.'},
		},
	},

	['Coal_Cocoa'] = {
		[1] = {
			{origin = 2, dialogue = 'Long time no see, Coal! Have your expeditions with Bobette been fun?'},
			{origin = 1, dialogue = '...Bworf.'},
			{origin = 2, dialogue = 'I guess you do look a little tired. And a little hungry, too...'},
			{origin = 1, dialogue = 'Bwoof...'},
			{origin = 2, dialogue = 'You know what, Ill give you all the treats I can find after this! Will that make you happy?'},
			{origin = 1, dialogue = 'Bwoof!'},
		},
	},

	['Coal_Connie'] = {
		[1] = {
			{origin = 1, dialogue = 'Bwoof, bork.'},
			{origin = 2, dialogue = 'Yeesh... you are one big rock.'},
			{origin = 1, dialogue = 'Bworf.'},
			{origin = 2, dialogue = 'Yikes, what is Bobette feeding you???'},
		},
	},

	['Coal_Ginger'] = {
		[1] = {
			{origin = 2, dialogue = 'Coal... have you been helping well with the presents?'},
			{origin = 1, dialogue = 'Bworf.'},
			{origin = 2, dialogue = 'Mhm...'},
			{origin = 1, dialogue = 'Bork.'},
			{origin = 2, dialogue = 'Such a strong rock, so helpful!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Bworf!'},
			{origin = 2, dialogue = 'Oh! Uhm... Nice seeing you as well Coal.'},
			{origin = 1, dialogue = 'Bwoof.'},
			{origin = 2, dialogue = 'Easy girl... Ill give you a treat later...'},
		},
	},

	['Coal_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'Bworf.'},
			{origin = 2, dialogue = 'Arf!'},
			{origin = 1, dialogue = 'Bwoof.'},
			{origin = 2, dialogue = 'Woof!'},
			{origin = 1, dialogue = 'Bworf, bork... bwoof bwoof.'},
			{origin = 2, dialogue = '...Arf!'},
		},
	},

	['Coal_Poppy'] = {
		[1] = {
			{origin = 1, dialogue = 'Bwoof!'},
			{origin = 2, dialogue = 'Oooh so cute! What a good girl!'},
			{origin = 1, dialogue = 'Bworf bork.'},
			{origin = 2, dialogue = 'Sometimes I wish if I should get a pet rock!'},
			{origin = 1, dialogue = '...'},
		},
	},

	['Coal_Razzle n Dazzle'] = {
		[1] = {
			{origin = 2, dialogue = 'Grrrr...'},
			{origin = 2, dialogue = 'Awww! Big friend!!! (...Shes growling, Razzle- shes growling- RAZZLE!)'},
			{origin = 1, dialogue = 'BARK BARK!!'},
			{origin = 2, dialogue = 'Woah woah, haha...Its ok Dazzle. Im here! (...Sorry, I-Im not great with animals.)'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'See! Shes calm now, and no need to be sorry! (...O-ok)'},
		},
	},

	['Coal_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'Bworf.'},
			{origin = 2, dialogue = 'Coal, Bobette says you have a great sense of smell! I wonder how well you can track things...'},
			{origin = 1, dialogue = 'Bworf. Bworf.'},
			{origin = 2, dialogue = 'Hm... Makes me wonder if youd be any help in solving a case!'},
		},
	},

	['Coal_Rudie'] = {
		[1] = {
			{origin = 1, dialogue = 'BWORF!!'},
			{origin = 2, dialogue = 'Woah! Coal, calm down, Im as excited as you for Christmas!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Whats that look for? Dont tell me you dont care about Christmas.'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Coal, please.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Merry Christmas Coal!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '...I said, MERRY CHRISTMAS COAL!!!'},
			{origin = 1, dialogue = 'Grrr...'},
			{origin = 2, dialogue = 'Oh uh... nevermind! Haha! Nevermind!'},
		},
	},

	['Coal_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'I HATE YOUR EYEBROWS!'},
			{origin = 1, dialogue = 'Grrr...'},
			{origin = 2, dialogue = 'I CAN GROWL TOO, GRRRRR!!!'},
			{origin = 1, dialogue = 'Bwoof...?'},
			{origin = 2, dialogue = 'RAAAAAAAH!!!!'},
		},
	},

	['Coal_Teagan'] = {
		[1] = {
			{origin = 1, dialogue = 'Bork... bwoof, bwoof.'},
			{origin = 2, dialogue = 'Well, at least youre more behaved than Pebble.'},
			{origin = 1, dialogue = '...Bork.'},
		},
	},

	['Coal_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'Gawwwww, what a big doggie!'},
			{origin = 1, dialogue = 'Bwoof.'},
			{origin = 2, dialogue = 'Aww, you want a treat after this?'},
			{origin = 1, dialogue = 'Bork bork.'},
			{origin = 2, dialogue = 'Ginger was right, you really are a big cute rock!'},
		},
	},

	['Coal_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Bworf, Bworf.'},
			{origin = 2, dialogue = 'OOOoooo!!! LOOK AT YOU!! What a big cutie-pie!!!'},
			{origin = 1, dialogue = 'Bworf?'},
			{origin = 2, dialogue = 'Id LOVE a pet like you! Looey says I really SHOULDNT have a pet though!'},
		},
	},

	['Cocoa_Connie'] = {
		[1] = {
			{origin = 2, dialogue = 'Need any help, Cocoa?'},
			{origin = 1, dialogue = 'Huh? Youre asking ME if I need help?'},
			{origin = 2, dialogue = 'Well, yeah. That was the plan.'},
			{origin = 1, dialogue = 'Im so glad you asked!! I have this huge list of things I need to get done, and-'},
			{origin = 2, dialogue = 'Changed my mind. Nevermind.'},
			{origin = 1, dialogue = 'Aw shucks, thats what toons usually say...'},
		},
	},

	['Cocoa_Cosmo'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Cosmo, can you please make me some bonbons?'},
			{origin = 2, dialogue = 'Ive never made bonbons before, Cocoa. What if I mess them up?'},
			{origin = 1, dialogue = 'Im sure youll do great! Your cooking is always amazing!'},
			{origin = 2, dialogue = 'Thats really sweet of you, Cocoa! Tell you what: Ill try to make some after this.'},
			{origin = 1, dialogue = 'Really?! Thank you so much, Cosmo!!'},
			{origin = 2, dialogue = 'Anytime...!'},
		},
	},

	['Cocoa_Eggson'] = {
		[1] = {
			{origin = 2, dialogue = 'Cocoa, you always seem to be helping one person after another.'},
			{origin = 1, dialogue = 'I guess I am, yeah. I kinda lose track of time when helping others, haha...'},
			{origin = 2, dialogue = 'When was the last time you took a break, young lady?'},
			{origin = 1, dialogue = 'Uhmmmm...'},
			{origin = 2, dialogue = '...I think listening to one of my stories would help you slow down a bit.'},
		},
		[2] = {
			{origin = 1, dialogue = 'Do you need any help, Eggson?'},
			{origin = 2, dialogue = 'Ah Cocoa, this is the hundredth time youve offered me help in just this week.'},
			{origin = 1, dialogue = 'You know me! I just like to help out whenever I can!!'},
			{origin = 2, dialogue = 'Hmmm, I was going to go egg hunting soon, and-'},
			{origin = 1, dialogue = 'Sure, Ill help you if youd like!'},
			{origin = 2, dialogue = 'Hmm... A hundred and one now.'},
		},
	},

	['Cocoa_Flyte'] = {
		[1] = {
			{origin = 2, dialogue = 'Cocoa, wait up a second!'},
			{origin = 1, dialogue = 'Oh hi Flyte! Whats up?'},
			{origin = 2, dialogue = 'Youre always so quick to help everyone. Maybe you should slow down a little.'},
			{origin = 1, dialogue = 'I mean, I can try to slow down a little bit! Did something happen?'},
			{origin = 2, dialogue = 'I just...dont want you helping the wrong person, yknow? It could be dangerous for you.'},
			{origin = 1, dialogue = 'Well Flyte, I think everyone deserves a little help!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Hey Flyte! How are you doing?'},
			{origin = 2, dialogue = 'Could be better, I guess. Thanks for checking in though, Cocoa.'},
			{origin = 1, dialogue = 'Of course! Is there anything I can do to help you feel better?'},
			{origin = 2, dialogue = 'Umm, I dont think even you can help this situation be any better...'},
		},
	},

	['Cocoa_Glisten'] = {
		[1] = {
			{origin = 2, dialogue = 'Cocoa, how do I look?'},
			{origin = 1, dialogue = 'Hmm, you look nice!'},
			{origin = 2, dialogue = 'Well, I mean, do I not look perfect?'},
			{origin = 1, dialogue = 'Aw Glisten, no one is ever perfect!'},
			{origin = 2, dialogue = 'You must be mistaken! You simply cant handle perfection! Youre looking at it.'},
			{origin = 1, dialogue = 'Hehe, alright, alright. Whatever you say silly!'},
		},
	},

	['Cocoa_Goob'] = {
		[1] = {
			{origin = 2, dialogue = 'Cocoa!'},
			{origin = 1, dialogue = 'Golly Goob, youre just as energetic as ever!'},
			{origin = 2, dialogue = 'Of course! If youre here, everythings gonna be alright!'},
			{origin = 1, dialogue = 'Aww, thank you Goob! A hundred hugs for you!!'},
			{origin = 2, dialogue = 'Not if I give you a hundred hugs first!!'},
		},
	},

	['Cocoa_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'PEBBLE!! You look soooo CUTE!!!'},
			{origin = 2, dialogue = 'Bark Bark!!'},
			{origin = 1, dialogue = 'Awww, whos a happy little pet rock! You are!!'},
			{origin = 2, dialogue = 'Arf!!'},
			{origin = 1, dialogue = 'Hehehe! Soooo sweet! Just like my Bonbons!'},
			{origin = 2, dialogue = 'Bark!!'},
		},
	},

	['Cocoa_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya Shelly! I saw you and Bassie getting along!'},
			{origin = 2, dialogue = 'Really? I thought we just chatted here and there but-'},
			{origin = 1, dialogue = 'You two SHOULD hang out more! Any friend of hers is a friend of mine!!'},
			{origin = 2, dialogue = 'Aw.. thats sweet! Thanks Cocoa...!'},
			{origin = 1, dialogue = 'Hehe! No need to thank me for just being a friend!'},
		},
	},

	['Cocoa_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Hiya, Tisha! Need any help cleaning at all?'},
			{origin = 2, dialogue = 'Oh, no thank you Cocoa. Its very kind of you to offer though!'},
			{origin = 1, dialogue = 'Are you sure? Youre usually the only one cleaning, so I thought youd like some help!'},
			{origin = 2, dialogue = 'No, Im fine Cocoa. Thank you though, really!'},
			{origin = 1, dialogue = 'Well alright, I guess!'},
		},
	},

	['Cocoa_Yatta'] = {
		[1] = {
			{origin = 2, dialogue = 'You look REALLY SWEET, Cocoa!'},
			{origin = 1, dialogue = 'Aw, thanks Yatta! I try to- Wait, did you say "look?"'},
			{origin = 2, dialogue = 'YEAH! You LOOK super sweet, like CHOCOLATE!!'},
			{origin = 1, dialogue = '...Yatta, you know Im not chocolate to be eaten right-?'},
			{origin = 2, dialogue = '...Right, right, uhuh... I MEAN- I KNEW THAT!!! DUH!!!'},
			{origin = 1, dialogue = 'Yatta!! Do not even think about it!!!'},
		},
	},

	['Connie_Cosmo'] = {
		[1] = {
			{origin = 2, dialogue = 'Connie, do you think you could help me and Sprout bake later?'},
			{origin = 1, dialogue = 'Why me-?'},
			{origin = 2, dialogue = 'Well, you know...'},
			{origin = 1, dialogue = 'Ah right, I can reach the high shelves.'},
		},
	},

	['Connie_Eclipse'] = {
		[1] = {
			{origin = 2, dialogue = 'Hi Boolynski!! Hiii!!!'},
			{origin = 1, dialogue = 'Ay Eclipse- Its Connie.'},
			{origin = 2, dialogue = 'Oh, right, right! Oopsie, sorry!'},
			{origin = 1, dialogue = 'Its fine, how are you holding the crew together? My little replacement.'},
			{origin = 2, dialogue = 'I try my best to live up to your awesomeness!!!'},
			{origin = 1, dialogue = 'Heck yeah you do! Youre doing amazing Eclipse, keep up being awesome.'},
		},
	},

	['Connie_Finn'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Connie, have you ever heard of a Cuttlefish before?'},
			{origin = 1, dialogue = 'Nope. That sounds boring.'},
			{origin = 2, dialogue = 'Well, I thought youd find them interesting because theyre really good at hiding, like you are!'},
			{origin = 1, dialogue = 'Oh wow, really?? Thats actually interesting!'},
			{origin = 2, dialogue = 'Do you really think so??'},
			{origin = 1, dialogue = 'No Finn, I was kidding. That still sounds boring.'},
		},
	},

	['Connie_Flutter'] = {
		[1] = {
			{origin = 1, dialogue = 'Flutter, what are you doing after this?'},
			{origin = 2, dialogue = '...!'},
			{origin = 1, dialogue = 'Oh, wait really?'},
			{origin = 2, dialogue = '...!!!'},
			{origin = 1, dialogue = 'Wow, thats a little hardcore, even for me.'},
		},
		[2] = {
			{origin = 2, dialogue = '...?'},
			{origin = 1, dialogue = 'My favorite color is blue.'},
			{origin = 2, dialogue = '...??'},
			{origin = 1, dialogue = 'No, I mean I like pink! Its just not my favorite.'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Oh cmon dont be like that.'},
		},
	},

	['Connie_Gigi'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey girl, hey!'},
			{origin = 2, dialogue = 'Heeey wassup?'},
			{origin = 1, dialogue = 'Been haunting, and floating, you know the usual!'},
			{origin = 2, dialogue = 'Mwehehe, nice...'},
		},
		[2] = {
			{origin = 2, dialogue = 'I wish I could float...'},
			{origin = 1, dialogue = 'Its great honestly, I can reach high places.'},
			{origin = 2, dialogue = 'Like, top shelves? I could use something like that.'},
			{origin = 1, dialogue = 'Yeah, youd find nothing cool up high, so dont worry.'},
			{origin = 2, dialogue = 'But think of all the dust I could reach!'},
		},
	},

	['Connie_Glisten'] = {
		[1] = {
			{origin = 1, dialogue = 'Ugh, why dont people include me in conversations?'},
			{origin = 2, dialogue = 'Hm, are you invisible during them?'},
			{origin = 1, dialogue = '...Haha, oh yeah, I usually am.'},
			{origin = 2, dialogue = 'That will do it.'},
		},
	},

	['Connie_Goob'] = {
		[1] = {
			{origin = 1, dialogue = 'Do you even know you exist Goob?'},
			{origin = 2, dialogue = 'Uhm, Yeah! Mhm! Yeah!'},
			{origin = 1, dialogue = 'Do you REALLY know?'},
			{origin = 2, dialogue = '...Hm, hm... Yeah!'},
			{origin = 1, dialogue = 'Alright, just making sure.'},
		},
	},

	['Connie_Gourdy'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Boolyn- I MEAN, Connie...'},
			{origin = 1, dialogue = 'Yeah-huh, lil guy? There is an effort, I mean for sure I am seeing your attempt there!'},
			{origin = 2, dialogue = 'I meaaan, at least I am trying! Right?'},
			{origin = 1, dialogue = 'True, unlike a certain FAKE "knight"...'},
			{origin = 2, dialogue = 'Aw cmon Connie, Soulvester is awesome!'},
			{origin = 1, dialogue = 'Trust me Gourdy, youre way more awesome than he is, haha-'},
		},
	},

	['Connie_Looey'] = {
		[1] = {
			{origin = 1, dialogue = 'Ugh its like so cold...'},
			{origin = 2, dialogue = 'Isnt it always cold for you?'},
			{origin = 1, dialogue = 'Yeah, that doesnt mean I cant complain.'},
			{origin = 2, dialogue = 'You know what... fair.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Connie ever thought of joining a circus?'},
			{origin = 1, dialogue = 'No interest in joining your little carnival crew.'},
			{origin = 2, dialogue = 'Oh cmon! Could be fun!'},
			{origin = 1, dialogue = 'Nooope, not wasting my time.'},
			{origin = 2, dialogue = 'Womp womp...'},
		}
	},

	['Connie_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'I could be haunting right now, but instead Im stuck in this shop.'},
			{origin = 2, dialogue = 'Arf!'},
			{origin = 1, dialogue = 'Oh...and Pebbles here too, I guess...?'},
			{origin = 2, dialogue = 'Arf Arf!'},
			{origin = 1, dialogue = 'Do you even know whats going on, or do you just enjoy doing this all of the time?'},
			{origin = 2, dialogue = '...Bworf.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Grr....'},
			{origin = 1, dialogue = 'Dont give me that, I already promised I wouldnt sneak into his room again.'},
			{origin = 2, dialogue = 'GRRR... BARK! BARK!!'},
			{origin = 1, dialogue = 'OK, I get it! Sheesh, its like Dandy takes really good care of you or something...'},
		},
	},

	['Connie_Poppy'] = {
		[1] = {
			{origin = 2, dialogue = 'Connie, its super cool that you can go invisible!!'},
			{origin = 1, dialogue = 'I mean, its pretty cool sure, sometimes even entertaining!'},
			{origin = 2, dialogue = 'Oh yeah? Entertaining in like, what way???'},
			{origin = 1, dialogue = 'Psh... I mean I can spy on people without them knowing, learn their juicy secrets.'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = '. . .'},
		},
	},

	['Connie_Razzle n Dazzle'] = {
		[1] = {
			{origin = 1, dialogue = 'You two up to anything recently?'},
			{origin = 2, dialogue = 'The usual! (...I was hoping wed read later.)'},
			{origin = 1, dialogue = 'Yeah...? I dont do that whole reading thing.'},
			{origin = 2, dialogue = 'Wait, you dont read at all? (What about signs, or instructions?)'},
			{origin = 1, dialogue = 'Meh, I dont abide by the rules!'},
		},
	},

	['Connie_Ribecca'] = {
		[1] = {
			{origin = 2, dialogue = 'Boolynski!! Girl it is great seeing you!!'},
			{origin = 1, dialogue = 'Its Connie still, but Ayyy! Your outfit is great as always.'},
			{origin = 2, dialogue = 'Aw thank you! You know me, making just the best outfits and costumes.'},
			{origin = 1, dialogue = 'You planning on making me any?'},
			{origin = 2, dialogue = 'If youd want some you know Id be happy to throw a few things together while I feel creative.'},
			{origin = 1, dialogue = 'I look forward to seeing what you make! Better be suuuper cool.'},
		},
	},

	['Connie_Rodger'] = {
		[1] = {
			{origin = 2, dialogue = 'Miss Boolynski...'},
			{origin = 1, dialogue = 'WHO TOLD YOU THAT NAME!?'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'Dont call me that!! Its embarrassing!! Stick. To. The nickname!'},
			{origin = 2, dialogue = 'I thought it was a lovely name, but I understand, nothing meant by it.'},
			{origin = 1, dialogue = 'Ugh, just stop talking Rodger.'},
		},
	},

	['Connie_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'I hate to sound like Tisha, but you should so clean your room.'},
			{origin = 2, dialogue = 'Its not even THAT messy... have you seen Yattas room?'},
			{origin = 1, dialogue = 'Huh... Fair point!'},
			{origin = 2, dialogue = 'Hey wait, since when did I invite you to my room???'},
			{origin = 1, dialogue = '. . .'},
			{origin = 2, dialogue = 'Connie!! Stop snooping around the place!'},
		},
	},

	['Connie_Shelly'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey so dinosaurs are extinct... and well, youre...'},
			{origin = 1, dialogue = '...Im what Shelly?'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'Go on. Say it.'},
			{origin = 2, dialogue = '...NEVERMIND! Nevermind!'},
		},
	},

	['Connie_Shrimpo'] = {
		[1] = {
			{origin = 2, dialogue = 'I HATE TOONS WHO FLOAT!'},
			{origin = 1, dialogue = '...I feel very targeted.'},
			{origin = 2, dialogue = 'I HATE TOONS WHO THINK THEYRE THE MAIN TOPIC!!'},
			{origin = 1, dialogue = 'WHO ELSE FLOATS AS MUCH AS ME SHRIMPO!?'},
			{origin = 2, dialogue = 'I DO NOT ANSWER TO YOU!!!'},
		},
	},

	['Connie_Soulvester'] = {
		[1] = {
			{origin = 2, dialogue = 'Sister, even though we are apart most of the year, I must say- I wish it was longer.'},
			{origin = 1, dialogue = 'Yuuup, same can be said here bro. Youre way too serious all the time!'},
			{origin = 2, dialogue = '-And you are never serious enough. Though I will always be here as your protector.'},
			{origin = 1, dialogue = 'I can be serious when I want to be! And sure- yeah... keep larping as a knight.'},
			{origin = 2, dialogue = 'I AM a knight!'},
			{origin = 1, dialogue = 'Sure, sure...'},
		},
	},

	['Connie_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Berry-boy, whats going on with you?'},
			{origin = 2, dialogue = 'Ugh... Did Vee tell you to call me that???'},
			{origin = 1, dialogue = 'Pft- No, I just overheard her call you that and thought Id give it a try!'},
			{origin = 2, dialogue = 'Well cut it out, I dont need any of your pranks, or tricks, or whatever you do.'},
			{origin = 1, dialogue = 'Oh lighten up! Just a little tease!'},
		},
	},

	['Connie_Squirm'] = {
		[1] = {
			{origin = 2, dialogue = 'Connie...?'},
			{origin = 1, dialogue = 'What is it worm buddy?'},
			{origin = 2, dialogue = 'Worm buddy...? W-were friends??? Buddies...???'},
			{origin = 1, dialogue = 'Well I meant it more so as a little nickname-'},
			{origin = 2, dialogue = 'I-I dont have many Friends... snf... This... this is amazing- sniffle-'},
			{origin = 1, dialogue = 'Oh,,,erm... Yeaaa, were friends. Sure.'},
		},
	},

	['Connie_Teagan'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Teagan, could I maybe-'},
			{origin = 2, dialogue = 'No, you may not come to another tea party.'},
			{origin = 1, dialogue = 'What!? Why?!'},
			{origin = 2, dialogue = 'Connie, you haunted the kettle and spun it around in the air for an hour.'},
			{origin = 1, dialogue = 'Good times... Ah, what fond memories!'},
			{origin = 2, dialogue = 'No Connie! NOT fond memories! Poor Dazzle got tea in his eyes!'},
		},
	},

	['Connie_Tisha'] = {
		[1] = {
			{origin = 2, dialogue = 'Connie, keeping tidy?'},
			{origin = 1, dialogue = 'Yes.'},
			{origin = 2, dialogue = 'Are you..? Seems like a fast response.'},
			{origin = 1, dialogue = 'Tisha, please, my room has like... nothing.'},
			{origin = 2, dialogue = 'Oh? Maybe I could help decorate!'},
			{origin = 1, dialogue = 'Maybe.'},
		},
	},

	['Connie_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey kid, you uh... like any toys...?'},
			{origin = 2, dialogue = 'Uhuh! I have a plush, of a dog! And the dog is my favorite!'},
			{origin = 1, dialogue = '...And is there a reason the dog toy is your favorite?'},
			{origin = 2, dialogue = 'Shes got a spot on her head! Just like me!'},
			{origin = 1, dialogue = 'UGH- Thats actually too adorable to say anything further.'},
		},
	},

	['Connie_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Do you think Id be able to haunt your screen...?'},
			{origin = 2, dialogue = 'Dont try it.'},
			{origin = 1, dialogue = 'OoOoo... I just might!!'},
			{origin = 2, dialogue = 'Ill tell Brightney.'},
			{origin = 1, dialogue = '...Erm, Nevermind.'},
		},
		[2] = {
			{origin = 2, dialogue = '-Zzst- BZT-'},
			{origin = 1, dialogue = 'Someone sounds a little out of tune!'},
			{origin = 2, dialogue = 'Tch, it was just for a moment.'},
			{origin = 1, dialogue = 'Eh, pretty sure you make that noise a couple times throughout the week!'},
			{origin = 2, dialogue = 'What, are you counting the times???'},
			{origin = 1, dialogue = 'Nah, I just take notice of things! Many things! Im a good observer.'},
		},
	},

	['Connie_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Yatta, are you ready for the next blind?'},
			{origin = 2, dialogue = 'Im ALWAYS ready!! Unless Im not, IN WHICH ITS NOT ALWAYS!!'},
			{origin = 1, dialogue = '...Yeah girl?'},
			{origin = 2, dialogue = 'YUP! Watch! And leaaaarn!'},
			{origin = 1, dialogue = 'Pft, sounds like youre ready then, lets do this!'},
		},
		[2] = {
			{origin = 2, dialogue = 'CONNIE!! Are we there yet!?'},
			{origin = 1, dialogue = 'Nope, the run is still going.'},
			{origin = 2, dialogue = 'HOW ABOUT NOW???'},
			{origin = 1, dialogue = 'Still doing the whole run thing.'},
			{origin = 2, dialogue = 'Are we THERE YET???'},
			{origin = 1, dialogue = 'Hmmm, yeah, sure, watch the round start.'},
		},
	},

	['Cosmo_Eggson'] = {
		[1] = {
			{origin = 2, dialogue = 'Cosmo, could I perhaps-'},
			{origin = 1, dialogue = 'For the last time Eggson, you cannot take the eggs out of the fridge and hide them for me to find.'},
			{origin = 2, dialogue = 'Drats Cosmo! Cant you understand my vision!'},
			{origin = 1, dialogue = 'Its not happening.'},
		},
	},

	['Cosmo_Finn'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Finn did you need anything to feel better...?'},
			{origin = 2, dialogue = 'Nope! But if I do trust me I know a... sturgeon!'},
			{origin = 1, dialogue = '. . . I dont get it?'},
			{origin = 2, dialogue = 'Like the fish! And surgeon!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'STURGEON! Haha!'},
		},
	},

	['Cosmo_Flutter'] = {
		[1] = {
			{origin = 1, dialogue = 'Flutter, I just wanted to say I think youre doing great.'},
			{origin = 2, dialogue = '...!'},
			{origin = 1, dialogue = 'Yeah, I just think you dont hear it enough, that it would cheer you up.'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Keep it up, alright?'},
			{origin = 2, dialogue = '!'},
		},
		[2] = {
			{origin = 2, dialogue = '???'},
			{origin = 1, dialogue = 'What...? No, I dont think so.'},
			{origin = 2, dialogue = '...?'},
			{origin = 1, dialogue = 'No, we definitely didnt leave any card last blind.'},
			{origin = 2, dialogue = '. . . ?'},
			{origin = 1, dialogue = 'What does this have to do with the size of my head???'},
		}
	},

	['Cosmo_Flyte'] = {
		[1] = {
			{origin = 1, dialogue = 'Flyte, would you have any idea where some of the Easter-themed recipe cards went-?'},
			{origin = 2, dialogue = 'You and Sprout dont have them...? I thought you had copies of those cards.'},
			{origin = 1, dialogue = 'Well for some of them we do- but- not all of them...'},
			{origin = 2, dialogue = 'Well Ill be honest, I did use some for thematic scrapbooking... So sorry.'},
			{origin = 1, dialogue = 'Darn, well at least they were used somewhere.'},
		},
	},

	['Cosmo_Gigi'] = {
		[1] = {
			{origin = 2, dialogue = 'Pst, Cosmo! It says gullible on the ceiling!'},
			{origin = 1, dialogue = 'Wait- really? Where?!'},
			{origin = 2, dialogue = 'Mwehehe...'},
			{origin = 1, dialogue = '...Oh wait- No... I fell for it.'},
			{origin = 2, dialogue = 'Gigi wins!'},
		},
	},

	['Cosmo_Ginger'] = {
		[1] = {
			{origin = 2, dialogue = 'Cousin Cosmo! So happy to see you!'},
			{origin = 1, dialogue = 'Hey Ginger, I am happy to have you around...!'},
			{origin = 2, dialogue = 'Yeah... dont get to see you too often haha...'},
			{origin = 1, dialogue = 'Right, I understand why though, being a Holiday Toon and such.'},
			{origin = 2, dialogue = 'Mhm...! But if you need anything, let me know... truly!'},
		},
	},

	['Cosmo_Glisten'] = {
		[1] = {
			{origin = 2, dialogue = 'Cosmo those stars on your cheeks are such a lovely bit of makeup!'},
			{origin = 1, dialogue = 'Glisten, those arent makeup, Ive always had these.'},
			{origin = 2, dialogue = 'Seriously?'},
			{origin = 1, dialogue = 'Yeah, theyre on all my art around Gardenview!'},
			{origin = 2, dialogue = 'I knew that! How could I not know that! Haha...'},
		},
	},

	['Cosmo_Goob'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Goob! Were you busy later?'},
			{origin = 2, dialogue = 'Nope! Not too busy! Something on your mind buddy?'},
			{origin = 1, dialogue = 'Well I was hoping you could taste test some cookies later!'},
			{origin = 2, dialogue = 'I can taste test ALL the cookies!!!'},
			{origin = 1, dialogue = 'Oh, you seem excited..?'},
			{origin = 2, dialogue = 'You say taste, and cookie, and my name, and I get excited!!!'},
		},
	},

	['Cosmo_Looey'] = {
		[1] = {
			{origin = 1, dialogue = 'Looey, think you could lighten up the mood..?'},
			{origin = 2, dialogue = 'Sure can! Ever seen me juggle?'},
			{origin = 1, dialogue = 'Cant say I have yet!'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = '...Well are you going to?'},
			{origin = 2, dialogue = 'Oh! Look at the time! The shop is ending! Gosh, we should prepare!'},
		},
	},

	['Cosmo_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'Sprout said to stop giving you pet treats.'},
			{origin = 2, dialogue = 'Bwork?'},
			{origin = 1, dialogue = '...Yeah, sorry buddy. Apparently one everyday isnt good for you.'},
			{origin = 2, dialogue = 'Grrr-- BARK!'},
			{origin = 1, dialogue = 'Hey, hey! Be a nice rock.'},
		},
	},

	['Cosmo_Poppy'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Cosmo, could you bake some cookies with my face on them?'},
			{origin = 1, dialogue = 'Oh sure! What kind of toppings should we put on the cookies?'},
			{origin = 2, dialogue = 'Hmm...Maybe we could use gumballs for the eyes, and-'},
			{origin = 1, dialogue = 'Never again.'},
			{origin = 2, dialogue = 'Are you sure? Im sure theyd look great!'},
			{origin = 1, dialogue = 'Never. Again.'},
		},
	},

	['Cosmo_Razzle n Dazzle'] = {
		[1] = {
			{origin = 1, dialogue = 'Do you both want to help in the kitchen later?'},
			{origin = 2, dialogue = 'Depends, got a sweet treat? (...Wed help you even without the dessert.)'},
			{origin = 1, dialogue = 'Im sure I can find the time to get you both something!'},
			{origin = 2, dialogue = 'YES!!! (...Oh, thank you Cosmo.)'},
			{origin = 1, dialogue = 'Of course!'},
		},
	},

	['Cosmo_Rodger'] = {
		[1] = {
			{origin = 2, dialogue = 'Cosmo think you could answer some quick questions?'},
			{origin = 1, dialogue = 'Nope.'},
			{origin = 2, dialogue = 'Oh Cosmo, there is so much to be answered though and-'},
			{origin = 1, dialogue = 'Are the questions about Sprout?'},
			{origin = 2, dialogue = 'Well...'},
			{origin = 1, dialogue = 'In that case, nope!'},
		},
	},

	['Cosmo_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Scraps have you been the one folding the napkins into origami?'},
			{origin = 2, dialogue = '...Maybe.'},
			{origin = 1, dialogue = 'Well I think the origami is really well done!'},
			{origin = 2, dialogue = 'Really? Aw... I thought you were going to complain!'},
			{origin = 1, dialogue = 'Complain? Of course not!! I feel bad taking them apart...'},
		},
	},

	['Cosmo_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = '...The plant in my room wilted recently.'},
			{origin = 2, dialogue = 'Oh no, were you giving it enough water?'},
			{origin = 1, dialogue = 'Yeah! Maybe I gave it too much water?'},
			{origin = 2, dialogue = 'You could ask Dandy for advice on that!'},
			{origin = 1, dialogue = '...Uhm, no thanks Shelly. I think Dandy is the last person I want to ask.'},
		},
	},

	['Cosmo_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = 'So happy we made it off that blind...'},
			{origin = 2, dialogue = 'IM NOT.'},
			{origin = 1, dialogue = 'W-what?'},
			{origin = 2, dialogue = 'LETS GO BACK.'},
			{origin = 1, dialogue = 'Shrimpo- no, were not going back up???'},
			{origin = 2, dialogue = 'YOU NEVER LISTEN TO ME, I HATE YOU!!!'},
		},
	},

	['Cosmo_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Are you okay...?'},
			{origin = 2, dialogue = 'Are YOU okay-?'},
			{origin = 1, dialogue = 'Ohh... Sprout, cmon I asked first.'},
			{origin = 2, dialogue = 'Well I asked louder! Cmon! You say first!'},
			{origin = 1, dialogue = '...Im okay.'},
			{origin = 2, dialogue = 'Good! Then Im okay too!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Hm... you ever notice the sign that says Delictable?'},
			{origin = 1, dialogue = 'The one in the dining section? Isnt it meant to be Delectable?'},
			{origin = 2, dialogue = '...Yeah, yeah it is.'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Were not fixing it are we?'},
			{origin = 1, dialogue = 'Hehehe- Nope!'},
		}
	},

	['Cosmo_Squirm'] = {
		[1] = {
			{origin = 2, dialogue = 'Snf... sniffle-'},
			{origin = 1, dialogue = 'Is something on your mind...?'},
			{origin = 2, dialogue = 'I-I thought back to... a r-really SAD STORY REALLY, REALLY, SAD-'},
			{origin = 1, dialogue = 'Woah, woah... its going to be alright! Its just a story, Im sure theres other things to focus on.'},
			{origin = 2, dialogue = 'YOURE RIGHT! Snf- WORSE THINGS!!! WAAAH!!!'},
			{origin = 1, dialogue = '...There, there- Ill let you just get all out your emotions.'},
		},
	},

	['Cosmo_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Excuse me Cosmo, do you have a moment?'},
			{origin = 1, dialogue = 'Sure! Anything I can help with?'},
			{origin = 2, dialogue = 'If its not too much trouble, would you be willing to bake some cookies for me?'},
			{origin = 1, dialogue = 'Oh, of course! Hosting another tea party?'},
			{origin = 2, dialogue = 'Not this time, I simply adore your cookies with my tea! I cant get enough of them.'},
			{origin = 1, dialogue = 'Haha, Im glad you enjoy them! Ill try to make some when Im able to!'},
		},
	},

	['Cosmo_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Tisha how are you doing...?'},
			{origin = 2, dialogue = 'Well... I could be better!'},
			{origin = 1, dialogue = 'Right, I could agree there.'},
			{origin = 2, dialogue = 'That I could be better?'},
			{origin = 1, dialogue = 'Oh! No! I mean, I feel the same way!'},
			{origin = 2, dialogue = '-I was about to say! Hahaha...'},
		},
	},

	['Cosmo_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'So do you use the oven alot?'},
			{origin = 1, dialogue = 'Of course!'},
			{origin = 2, dialogue = 'I heard thats dangerous though!'},
			{origin = 1, dialogue = 'Dangerous? Well, they could be if youre not careful!'},
			{origin = 2, dialogue = 'Oh ok!... Are you careful?'},
			{origin = 1, dialogue = 'Hah uhm- careful enough usually!'},
		},
	},

	['Cosmo_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Vee, are you alright..?'},
			{origin = 2, dialogue = 'Youre checking in on me? I mean, Im fine honestly.'},
			{origin = 1, dialogue = 'Thats good to know, I was told you havent been doing the best.'},
			{origin = 2, dialogue = 'What? -Who said that.'},
			{origin = 1, dialogue = 'Well, I uh...'},
			{origin = 2, dialogue = '-Never mind, I know who. Sprout can ask me himself next time.'},
		},
	},

	['Cosmo_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Yatta, think you could drop off some candy to the kitchen later?'},
			{origin = 2, dialogue = 'COULD I!?'},
			{origin = 1, dialogue = '...Could you?'},
			{origin = 2, dialogue = 'COULD I?!'},
			{origin = 1, dialogue = '...Yatta please.'},
			{origin = 2, dialogue = 'Yeah! I COULD!'},
		},
	},

	['Eclipse_Gourdy'] = {
		[1] = {
			{origin = 1, dialogue = 'AWOOO!'},
			{origin = 2, dialogue = 'Eclipse... youre howling... why? -What for?'},
			{origin = 1, dialogue = 'To get the pack excited for another blind!'},
			{origin = 2, dialogue = 'Eclipse I dont think howling is gonna get everyone excited... but I mean, the thought counts I guess!'},
			{origin = 1, dialogue = 'It gets me super excited!! AWOOO!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Eclipse, what would you pick, a trick!!... or a yummy treat?'},
			{origin = 1, dialogue = 'Obviously a yummy, yummy treat!! Who would pick a trick??'},
			{origin = 2, dialogue = 'I would!!! No one ever gives trick a chance, they dont have people saying "treat or treat" ever!'},
			{origin = 1, dialogue = 'I guess youre right, it is "trick or treat" NOT "treat or treat"...'},
			{origin = 2, dialogue = 'What if I made it "trick or trick"???'},
			{origin = 1, dialogue = 'Very spooky and scary of you!! -dont ACTUALLY do it though.'},
		},
	},

	['Eclipse_Looey'] = {
		[1] = {
			{origin = 1, dialogue = 'Woah! Are you like a bunny balloon? Or a dog balloon???'},
			{origin = 2, dialogue = 'Huh? Oh! Im actually neither haha just kinda my own thing, just a balloon!'},
			{origin = 1, dialogue = 'Awww, I was hoping youd say dog! I need friends to howl at the moon with.'},
			{origin = 2, dialogue = 'You howl at Astro...?'},
			{origin = 1, dialogue = 'Nah, the real deal, the real moon! Just a lil AWOOO! You know.'},
			{origin = 2, dialogue = 'Cant say I know the feeling...'},
		},
	},

	['Eclipse_Ribecca'] = {
		[1] = {
			{origin = 1, dialogue = 'Ribecca if I tried to catch my tail would you watch? SAY YES!! Please say yes!!'},
			{origin = 2, dialogue = 'Ill be real Eclipse, I wouldnt wanna watch that, it took you three hours last time.'},
			{origin = 1, dialogue = 'Aw but when I caught it that one time the pay off was amazing!!'},
			{origin = 2, dialogue = 'The "pay off" was you falling asleep almost immediately after from exhaustion.'},
			{origin = 1, dialogue = 'Aw yeah... good times...'},
		},
		[2] = {
			{origin = 2, dialogue = 'Ay! Eclipse!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Girl... Eclipse, sometimes you stare at me just like Pebble... Knock that off.'},
			{origin = 1, dialogue = '-Huh? Oh! Sorry Ribecca!! Was I staring??'},
			{origin = 2, dialogue = 'Yeah, yeah you were.'},
			{origin = 1, dialogue = 'Oopsie daisy! My bad!! I just zone out sometimes!'},
		},
	},

	['Eclipse_Soulvester'] = {
		[1] = {
			{origin = 1, dialogue = 'Soulvester! How do you always wear that armor? It must be so heavy!! Cause your like sooo slow!'},
			{origin = 2, dialogue = 'This stunning suit of armor may be cumbersome at times though it provides me great protection.'},
			{origin = 1, dialogue = 'Yeah but you wear it even when you dont really need protection!! Like all the time!'},
			{origin = 2, dialogue = '...Yes well, I must admit, I simply do not find myself as knightly without such.'},
			{origin = 1, dialogue = '...So you just wear it? Like all the time?'},
			{origin = 2, dialogue = '...Thou wouldnt understand.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Eclipse, do you find yourself nervous? -I see your fur is a bit ruffled.'},
			{origin = 1, dialogue = 'Oh that might just be static in the air! You should see me when I dry off! Im so fluffy!'},
			{origin = 2, dialogue = 'Ah I suppose that would make sense, ignore my trivial comments.'},
			{origin = 1, dialogue = 'Its ok!! I know youre just super protective!'},
			{origin = 2, dialogue = 'I am protective of all Toons for that is my duty as knight, that of protector.'},
		}
	},

	['Eggson_Flutter'] = {
		[1] = {
			{origin = 2, dialogue = '...!!!'},
			{origin = 1, dialogue = 'Goodness Flutter... youre very energetic today.'},
			{origin = 2, dialogue = '...?'},
			{origin = 1, dialogue = 'Me? No Id rather not.'},
			{origin = 2, dialogue = '...!!'},
			{origin = 1, dialogue = 'Flutter, that idea has too many eggs, even for me.'},
		},
	},

	['Eggson_Flyte'] = {
		[1] = {
			{origin = 1, dialogue = 'Sigh... I miss the egg hunt!'},
			{origin = 2, dialogue = 'Eggson, we still celebrate with an egg hunt each year.'},
			{origin = 1, dialogue = 'No, no, no... They dont call it an EGG hunt anymore!'},
			{origin = 2, dialogue = 'W-what do you mean?'},
			{origin = 1, dialogue = 'They just call it "The Hunt"... or something.'},
			{origin = 2, dialogue = 'Eggson, I think youre talking about some sort of dream.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Eggson anything on your mind?'},
			{origin = 1, dialogue = 'Hmmm... Eggs.'},
			{origin = 2, dialogue = 'Anything uhm, other than eggs?'},
			{origin = 1, dialogue = 'Our place within the structure of this somewhat Toon formed community, and by that the social structure of such-'},
			{origin = 2, dialogue = 'I think Id rather you talk about the eggs...'},
			{origin = 1, dialogue = 'Can do! I could talk about eggs all day!'},
		},
	},

	['Eggson_Gigi'] = {
		[1] = {
			{origin = 1, dialogue = 'I wonder if theres any eggs hidden anywhere...'},
			{origin = 2, dialogue = 'Eggs? Like... Items, hidden, for the finding—FOR THE TAKING??'},
			{origin = 1, dialogue = '...I mean, yes, that is what an egg hunt would be, wouldnt it!'},
			{origin = 2, dialogue = 'Eggson why didnt you say so! If there is any lying around I WILL find them!'},
			{origin = 1, dialogue = 'Oh! And youll share them with me?'},
			{origin = 2, dialogue = 'Woah, woah, who said all that about uhm "shar-ing"... No.'},
		},
	},

	['Eggson_Razzle n Dazzle'] = {
		[1] = {
			{origin = 1, dialogue = 'Well hey there, Razzle and Dazzle! Have you two read any good books lately?'},
			{origin = 2, dialogue = 'Hi there, Eggson! (Weve read quite a few books recently...)'},
			{origin = 1, dialogue = 'Ohoho! Would you like to trade stories sometime? Id love to hear what youve read!'},
			{origin = 2, dialogue = 'Sure thing! (Just let us know when...)'},
		},
	},

	['Eggson_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'So Rodger, hows the little one that follows you around?'},
			{origin = 2, dialogue = 'Toodles? Shes well, Im sure to always keep my eye on her.'},
			{origin = 1, dialogue = 'Good, I trust shes well under you watch.'},
			{origin = 2, dialogue = 'Well, I try my best to look out for her.'},
			{origin = 1, dialogue = 'Thats all you can do Rodger, is your best! Ohoho!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Eggson you have a smudge on your glasses.'},
			{origin = 1, dialogue = 'Usually itd be Glisten telling me that...'},
			{origin = 1, dialogue = '...'},
			{origin = 1, dialogue = 'Rodger?'},
			{origin = 2, dialogue = 'I think Im being influenced by the company I keep.'},
		},
	},

	['Eggson_Shrimpo'] = {
		[1] = {
			{origin = 2, dialogue = 'I HATE OLD PEOPLE!!!'},
			{origin = 1, dialogue = 'Shrimpo, I must say I do feel targeted.'},
			{origin = 2, dialogue = 'YEAH, WELL, I HATE THAT YOU THINK THAT I HATE YOU IN SPECIFIC!'},
			{origin = 1, dialogue = 'Well do you hate me in specific...?'},
			{origin = 2, dialogue = 'YES, I HATE YOU IN SPECIFIC! BUT I ALSO HATE YOU THINKING WHAT I THINK!'},
		},
	},

	['Eggson_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'Eggson! Eggson! I barely ever get to see you!!'},
			{origin = 1, dialogue = 'Ohoho! Is that who I think it is!'},
			{origin = 2, dialogue = 'Hehehe! Yeah Its me! Its Toodles!'},
			{origin = 1, dialogue = 'I know! I could never forget you little one!'},
			{origin = 2, dialogue = 'Are you going to tell a story later??'},
			{origin = 1, dialogue = 'Hm... Maybe! If youre on your best behavior.'},
		},
	},

	['Finn_Flutter'] = {
		[1] = {
			{origin = 2, dialogue = '...!'},
			{origin = 1, dialogue = 'Flutter! Sure, I could tell you a fish-tastic pun!'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'What happened to the tilapia that traded its fins for a pair of legs-'},
			{origin = 2, dialogue = '-!!!'},
			{origin = 1, dialogue = 'What? Wow, howd you already know that punchline!'},
		},
	},

	['Finn_Gigi'] = {
		[1] = {
			{origin = 1, dialogue = 'Do you know what kind of fish gets fan mail?'},
			{origin = 2, dialogue = 'No. tell me Finn what fish gets fan mail.'},
			{origin = 1, dialogue = 'A star-fish!.. But do keep in mind starfish arent actually fish.'},
			{origin = 2, dialogue = 'Wait really???'},
			{origin = 1, dialogue = 'Yeah! Ill tell you more after we finish here!'},
		},
	},

	['Finn_Glisten'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Glisten, do you think I look so-FISH-ticated?'},
			{origin = 2, dialogue = 'Never say that to me again.'},
			{origin = 1, dialogue = 'Alright! Its oh-FISH-ial, no more jokes with you!'},
			{origin = 2, dialogue = 'Someone get me OUT of this shop!!!'},
			{origin = 1, dialogue = 'Oh my COD! Calm down buddy!'},
			{origin = 2, dialogue = 'SOMEONE END THIS RUN PLEASE!!!'},
		},
	},

	['Finn_Goob'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Finn! What kind of fish only comes out at night?'},
			{origin = 1, dialogue = 'A Starfish!'},
			{origin = 2, dialogue = '...What do fish take to stay healthy?'},
			{origin = 1, dialogue = 'Vitamin Sea!!'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'You cant beat me at my own game, Goob. Good effort though!'},
		},
	},

	['Finn_Looey'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Finn, think you could teach me some puns later?'},
			{origin = 1, dialogue = 'Sure! I could school you on fish puns!'},
			{origin = 2, dialogue = 'Haha, I get it school, like a group of fish'},
			{origin = 1, dialogue = 'Yup! Haha'},
		},
	},

	['Finn_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'Like spinning around and chasing that tail of yours buddy?'},
			{origin = 2, dialogue = 'Bworf???'},
			{origin = 1, dialogue = 'Yeah, I feel a little.. GILL-TY for laughing a bit, but youre just too silly!'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'Oh, not silly? Serious rock? Giving the cold SHOAL-der now?'},
		},
	},

	['Finn_Poppy'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Poppy, I like your positive attitude that you always have!'},
			{origin = 2, dialogue = 'Oh, thank you Finn! I try my best!'},
			{origin = 1, dialogue = 'Yeah, you go GILL!'},
			{origin = 2, dialogue = 'YEAH!!'},
		},
	},

	['Finn_Razzle n Dazzle'] = {
		[1] = {
			{origin = 2, dialogue = 'Finn! You have to share some of your jokes with us later! (Or maybe dont...)'},
			{origin = 1, dialogue = 'Razzle my best buddy!! Maybe I pass the written notes of jokes later?'},
			{origin = 2, dialogue = 'Oh- yes notes instead for Dazzles sake haha! (Phew...)'},
			{origin = 1, dialogue = 'Sounds great! Ill pass by your room later with notes!'},
		},
	},

	['Finn_Rodger'] = {
		[1] = {
			{origin = 2, dialogue = 'You know Finn, youre far smarter than people give you credit for.'},
			{origin = 1, dialogue = 'Huh? Well thanks Rodger! What prompted this little compliment?'},
			{origin = 2, dialogue = 'I remembered back to a fact you shared on marine life.'},
			{origin = 1, dialogue = 'Ooo! Which one was it???'},
			{origin = 2, dialogue = 'Well... Octopodes have 3 hearts.'},
			{origin = 1, dialogue = 'Yeah! Heres another fact. Octopus actually prefer to crawl rather than swim!'},
		},
	},

	['Finn_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya! Catfish got your tongue?'},
			{origin = 2, dialogue = 'Ha ha ha... its because Im cat-like isnt it?'},
			{origin = 1, dialogue = 'Haha Yeah!'},
			{origin = 2, dialogue = 'Youre lucky there is no real fish in your head, Id be snacking right now!'},
			{origin = 1, dialogue = 'GASP! Not my toy Barnaby Wilikers...'},
		},
	},

	['Finn_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'Shelly! Are you a sea shell?'},
			{origin = 2, dialogue = 'Nope, Im an ammonite!'},
			{origin = 1, dialogue = 'Thats still a kind of sea shell!'},
			{origin = 2, dialogue = 'Well, yeah technically but I like to think of myself as a fossil more-so!'},
		},
	},

	['Finn_Shrimpo'] = {
		[1] = {
			{origin = 2, dialogue = 'I HATE FISH!!'},
			{origin = 1, dialogue = 'What about shrimp?'},
			{origin = 2, dialogue = 'SHRIMP ARENT FISH. THEYRE CRUSTACEANS!!'},
			{origin = 1, dialogue = 'GASP! You do listen to my facts!'},
			{origin = 2, dialogue = 'I HATE YOUR FACTS! I WOULD FORGET THEM IF I COULD!!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Heya bud! Why so Seal-rious? Haha!'},
			{origin = 2, dialogue = 'I HATE SEALS!!! SHRIMPO WINS.'},
			{origin = 1, dialogue = 'Well I suppose one could say youre one in a krill-ion!'},
			{origin = 2, dialogue = 'WRONG CRUSTACEAN!!! YOU LOSE!!!'},
			{origin = 1, dialogue = 'No but the joke is krill and shrimp are both- Ah nevermind.'},
		},
	},

	['Finn_Sprout'] = {
		[1] = {
			{origin = 2, dialogue = 'Hm... Maybe I can cook some seafood after this...'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Sprout?'},
			{origin = 2, dialogue = 'Finn, I mean this nicely- the fish in your head is a toy plastic fish.'},
			{origin = 1, dialogue = 'He is so much more to me!!!'},
		},
	},

	['Finn_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = 'You know some fish get excited when they get to eat a worm!'},
			{origin = 2, dialogue = 'W-what...?!'},
			{origin = 1, dialogue = 'Yeah! Worms get washed into water from the rain, and its a nice change in diet for fish!'},
			{origin = 2, dialogue = 'Why would you ever tell me this!? THATS AWFUL!!!'},
			{origin = 1, dialogue = 'Heh, dont worry Squirm! Youre much bigger than an actual worm!'},
			{origin = 2, dialogue = 'Snf... I-I guess so...'},
		},
	},

	['Finn_Teagan'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya Teagan I was wondering, what type of tea do you carry?'},
			{origin = 2, dialogue = '...Carry? As in whats in my head?'},
			{origin = 1, dialogue = 'Yup!'},
			{origin = 2, dialogue = 'Sweet Tea.'},
			{origin = 1, dialogue = 'Ooo! Thats why youre so sweet!'},
			{origin = 2, dialogue = 'Haha, Youre too kind.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Finn, would you like to join my next tea party?'},
			{origin = 1, dialogue = 'Nope! No interest! I only drink water.'},
			{origin = 2, dialogue = 'Well... I could simply serve you water instead of tea?'},
			{origin = 1, dialogue = 'You can just do that at a tea party???'},
			{origin = 2, dialogue = 'Im sure no one would mind! Please do consider the invite.'},
		},
	},

	['Finn_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya Tisha have you heard of the-'},
			{origin = 2, dialogue = 'Before you continue, I do not want to play into the fish puns today Finn.'},
			{origin = 1, dialogue = '. . .'},
			{origin = 2, dialogue = 'Finn...?'},
			{origin = 1, dialogue = 'WHALE, I guess Ill just SEA myself out-!'},
			{origin = 2, dialogue = '. . .Ok Finn, ok.'},
		},
	},

	['Finn_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya Toodles, do you have a favorite sea creature?'},
			{origin = 2, dialogue = 'Uhmmm...An octopus!'},
			{origin = 1, dialogue = 'Is it because it has eight tentacles? And youre an eight-ball?'},
			{origin = 2, dialogue = 'Uhmmm, uh- Yeah!'},
			{origin = 1, dialogue = 'Ah, I SEA, whyd you like them then!'},
		},
	},

	['Finn_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya Vee!'},
			{origin = 2, dialogue = 'Five feet apart from me Finn.'},
			{origin = 1, dialogue = 'Why? Is it because I smell fishy?'},
			{origin = 2, dialogue = 'No, because I rather not short-circuit and need repairs.'},
			{origin = 1, dialogue = 'Ah, woopsie! Almost forgot!'},
		},
	},

	['Finn_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'All of this work is REEL, difficult!'},
			{origin = 2, dialogue = 'REEL!! I GET IT!! I GET THE JOKE!!!'},
			{origin = 1, dialogue = 'Haha! Yeah, like reeling in a fish!'},
			{origin = 2, dialogue = 'YES, YES, FINN- Youre a genius among Toons.'},
			{origin = 1, dialogue = 'Thank you! I am pretty smart huh!'},
		},
	},

	['Flutter_Flyte'] = {
		[1] = {
			{origin = 1, dialogue = '...???'},
			{origin = 2, dialogue = 'Of course I miss you when were apart, I hope youve been out of trouble without my eye on you.'},
			{origin = 1, dialogue = '...!'},
			{origin = 2, dialogue = 'I know, I know... Youre grown! But I cant help but worry.'},
			{origin = 1, dialogue = '!!!'},
			{origin = 2, dialogue = 'Alright, Ill TRY not to worry as much. Just for you!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Heya little sis! Ever think about giving those wings a break?'},
			{origin = 1, dialogue = '!!!'},
			{origin = 2, dialogue = 'Oh dont tell me that, I use my wings plenty!'},
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'Sure youre a faster flier but that doesnt mean I dont fly enough!'},
			{origin = 1, dialogue = '...'},
		},
	},

	['Flutter_Gigi'] = {
		[1] = {
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'Youre so right, we should get matching hats!'},
			{origin = 1, dialogue = '...!'},
			{origin = 2, dialogue = 'WITH GLITTER?!'},
			{origin = 1, dialogue = '...!!!'},
			{origin = 2, dialogue = 'AND MATCHING SHIRTS?! This is the best. plan. EVER!!!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Heeey Flutter! Whats up?'},
			{origin = 1, dialogue = '...!'},
			{origin = 2, dialogue = 'Oh whoa really? No way...'},
			{origin = 1, dialogue = '...!!!'},
			{origin = 2, dialogue = 'WOAH, ok, ok... Ill help you write that into your diary later.'},
		},
	},

	['Flutter_Glisten'] = {
		[1] = {
			{origin = 1, dialogue = '...!'},
			{origin = 2, dialogue = 'Ew, what?'},
			{origin = 1, dialogue = '!?...!'},
			{origin = 2, dialogue = 'Oh, thats awful! Why would he do that to you?'},
			{origin = 1, dialogue = '!!!'},
			{origin = 2, dialogue = 'You poor thing, tell me all about it later.'},
		},
	},

	['Flutter_Goob'] = {
		[1] = {
			{origin = 2, dialogue = 'Flutter are you able to hug with your wings...?'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Oh? you cant?'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Thats okay! Ill hug others on your behalf!'},
		},
	},

	['Flutter_Looey'] = {
		[1] = {
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'Diary? I-I dont write in a diary!'},
			{origin = 1, dialogue = '...!'},
			{origin = 2, dialogue = '...'},
			{origin = 2, dialogue = '...'},
			{origin = 2, dialogue = 'Howd you know.'},
		},
	},

	['Flutter_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Arf!'},
			{origin = 1, dialogue = '...!!!'},
			{origin = 2, dialogue = 'Bark bark!'},
		},
	},

	['Flutter_Poppy'] = {
		[1] = {
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'You want to try on my bow?'},
			{origin = 1, dialogue = '...!'},
			{origin = 2, dialogue = 'Maybe later Flutter! I have to look my best right now!'},
		},
	},

	['Flutter_Razzle n Dazzle'] = {
		[1] = {
			{origin = 1, dialogue = '!!!'},
			{origin = 2, dialogue = 'Woah! Someone is a little upset! (I dont blame her..)'},
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'We get it Flutter! (Yeah... things have been difficult.)'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'But hey well support you too! (Mhm...)'},
		},
	},

	['Flutter_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Hm? Of course I am doing well Flutter.'},
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'Haha, you have a proper sense of humour today.'},
			{origin = 1, dialogue = '...!'},
		},
	},

	['Flutter_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = '???'},
			{origin = 2, dialogue = 'No were not doing that again.'},
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'Not even if you say please!'},
			{origin = 1, dialogue = '...???'},
			{origin = 2, dialogue = 'Flutter, Im like scared of heights...'},
		},
	},

	['Flutter_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'Oh! Flutter! Youre actually interested in the Brachiosaurus skeleton replica??'},
			{origin = 1, dialogue = '. . . ???'},
			{origin = 2, dialogue = 'Yeah... Its only a replica here in Gardenview.'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Oh.... Right, not as interesting, I understand...'},
		},
	},

	['Flutter_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'HOW DARE YOU SAY THAT!!'},
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'HOW DARE YOU!!!'},
		},
		[2] = {
			{origin = 2, dialogue = 'I HATE YOUR WINGS!!!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'I HATE THE FACT THAT YOURE SO LOUD!!!'},
		},
	},

	['Flutter_Soulvester'] = {
		[1] = {
			{origin = 2, dialogue = 'Flutter, your wings are still doing well I see. How have you been, my sister speaks so highly of you.'},
			{origin = 1, dialogue = '...!!!'},
			{origin = 2, dialogue = 'What.'},
			{origin = 1, dialogue = '!!'},
			{origin = 2, dialogue = 'She said all that of me-? I see, well, do not fall for such lies.'},
		},
	},

	['Flutter_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'No, were not making cookies of your face.'},
			{origin = 1, dialogue = '...???'},
			{origin = 2, dialogue = 'You remember what happened last time! Cosmo cried for a whole week.'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Yes Flutter, the gumballs for eyes were that scary- After they melted.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Flutter, have you seen Gigi sneaking into the kitchen late at night?'},
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'Yes, its about the missing aprons, where does she store them all??'},
			{origin = 1, dialogue = '!!!'},
			{origin = 2, dialogue = 'Its fine, its fine- Ill ask someone else about it.'},
		},
	},

	['Flutter_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'I know Flutter... I thought so too...'},
			{origin = 1, dialogue = '...???'},
			{origin = 2, dialogue = 'I KNOOOW!!! b-but HE said Im a book worm and so... I MUST be a book worm!'},
			{origin = 1, dialogue = '...!'},
			{origin = 2, dialogue = '...Sorry Flutter, m-maybe we can spend some time together after this...'},
		},
	},

	['Flutter_Teagan'] = {
		[1] = {
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'You wanted some tea later?'},
			{origin = 1, dialogue = '...!'},
			{origin = 2, dialogue = 'Of course Flutter! Ill get to it once Im free.'},
		},
	},

	['Flutter_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = '...???'},
			{origin = 2, dialogue = 'No there isnt anything in your fur!'},
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'Of course Id tell you if there was haha, I do love things clean!'},
		},
	},

	['Flutter_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Flutter, Flutter! I wish I could fly like you!'},
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'Oh... Youre right that could actually be dangerous...'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Cmon Im sure Id be super careful though!'},
		},
	},

	['Flutter_Vee'] = {
		[1] = {
			{origin = 2, dialogue = 'Flutter I know you write about me in your diary.'},
			{origin = 1, dialogue = '...?'},
			{origin = 2, dialogue = 'Dont act like you dont! Gigi was laughing about it with you in your room!'},
			{origin = 1, dialogue = '...!!!'},
			{origin = 2, dialogue = 'I overheard her from the hallway! -She has such a specific laugh!'},
			{origin = 1, dialogue = '...'},
		},
		[2] = {
			{origin = 1, dialogue = '!!!'},
			{origin = 2, dialogue = 'Dont start this with me.'},
			{origin = 1, dialogue = '!?!?'},
			{origin = 2, dialogue = 'Its not my fault you never won in my game-shows!'},
			{origin = 1, dialogue = '!!!'},
			{origin = 2, dialogue = 'No I never knew Scraps would win so many! Its not rigged!'},
		}
	},

	['Flutter_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = '...!'},
			{origin = 2, dialogue = 'Flutter cmon, Im NOT doing that!'},
			{origin = 1, dialogue = '!!'},
			{origin = 2, dialogue = 'Haha nooo, thats SO embarrassing!!'},
			{origin = 1, dialogue = '...!!!'},
			{origin = 2, dialogue = 'Pft-HAHaha. Flutter! Youre a silly, SILLY, butterfly arent you!'},
		},
	},

	['Flyte_Ginger'] = {
		[1] = {
			{origin = 1, dialogue = 'So youre from the winter season...?'},
			{origin = 2, dialogue = 'Yeah... Uhm- I heard you had a sister?'},
			{origin = 1, dialogue = 'Yeah- She isnt really-'},
			{origin = 2, dialogue = 'A Holiday Toon-? I understand the feeling.'},
			{origin = 1, dialogue = 'Right, well we should uhm, focus...'},
		},
	},

	['Flyte_Looey'] = {
		[1] = {
			{origin = 1, dialogue = 'Any luck in finding another member for your circus group, Looey?'},
			{origin = 2, dialogue = 'That depends, Flyte! Would YOU like to join the-'},
			{origin = 1, dialogue = 'No. Im already part of my own group, thank you though.'},
			{origin = 2, dialogue = '...Then no, I havent had any luck finding another circus member to join us.'},
			{origin = 1, dialogue = 'Im sure youll find someone eventually!'},
			{origin = 2, dialogue = 'Im not too sure...'},
		},
	},

	['Flyte_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey there Rodger, have any luck with your investigations?'},
			{origin = 2, dialogue = 'Not too great, honestly. I havent been able to make any headway at all...'},
			{origin = 1, dialogue = 'Does that mean youre gonna call it off for now?'},
			{origin = 2, dialogue = 'Of course not! I cant give up just because of a rough patch.'},
			{origin = 1, dialogue = 'I really think you should be careful Rodger, before you find something you dont want to know.'},
			{origin = 2, dialogue = '...Thank you for this conversation, Flyte.'},
		},
	},

	['Flyte_Scraps'] = {
		[1] = {
			{origin = 2, dialogue = 'Heya Flyte! Dont get to see you often!'},
			{origin = 1, dialogue = 'Well same can be said about you Scraps.'},
			{origin = 2, dialogue = 'Right, right, but how are you?'},
			{origin = 1, dialogue = 'As good as I could be I guess!'},
			{origin = 2, dialogue = 'Well thats better than the answer Shrimpo usually gives.'},
			{origin = 1, dialogue = 'Pft- Im sure it is.'},
		},
	},

	['Flyte_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = 'My antenna has an awful itch right now...'},
			{origin = 2, dialogue = 'I HATE WHEN YOU COMPLAIN!!'},
			{origin = 1, dialogue = 'Woah, Shrimpo, I am just thinking out loud.'},
			{origin = 2, dialogue = 'WELL THINK INSIDE THE LOUD!!!'},
			{origin = 1, dialogue = 'What?'},
			{origin = 2, dialogue = 'I HATE YOU!!! I HATE YOU!'},
		},
	},

	['Flyte_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Sprout, I want to thank you on behalf of the other Easter Toons...'},
			{origin = 2, dialogue = 'Huh? For any reason in specific? Not that Im complaining at all, thank you! Haha.'},
			{origin = 1, dialogue = 'The work you put in to make sure there are desserts and treats for everyone.'},
			{origin = 2, dialogue = 'Well it sure does cheer people up to have a nice sweet treat.'},
			{origin = 1, dialogue = 'Keep up the wonderful work.'},
		},
	},

	['Flyte_Squirm'] = {
		[1] = {
			{origin = 2, dialogue = 'I-Im not sure if this is odd to say, but your wings a-are amazing!'},
			{origin = 1, dialogue = 'Why, thank you! -though my sister is far better at flying.'},
			{origin = 2, dialogue = '...B-but, you can still fly- right?'},
			{origin = 1, dialogue = 'Yes, even though Im a tad bit out of practice, I can fly!'},
			{origin = 2, dialogue = '...Snf- sniffle- youre sooo amazing... Snf-'},
			{origin = 1, dialogue = '...Thank you.'},
		},
		[2] = {
			{origin = 1, dialogue = 'Squirm, youre always so kind to me, know that I appreciate it.'},
			{origin = 2, dialogue = 'R-really...? Oh wow... I-I appreciate you!'},
			{origin = 1, dialogue = 'There you are, being so kind again!'},
			{origin = 2, dialogue = 'Haha... yeah...'},
			{origin = 1, dialogue = 'If you continue to be so kind, I might just have to invite you to scrapbooking time.'},
			{origin = 2, dialogue = 'Scrapbooking...? Oh nooo... UHM- I-I mean! Y-yea! Sure! Just us-! And books...'},
		},
	},

	['Flyte_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Cocoa told me you like candy?'},
			{origin = 2, dialogue = 'HUH? WHO? ME!?'},
			{origin = 1, dialogue = 'Yes you.'},
			{origin = 2, dialogue = 'Oh! Yeah shed be right then! I LOOOVE CANDY!!'},
			{origin = 1, dialogue = 'Seems you love it more than I thought actually... wow.'},
			{origin = 2, dialogue = 'I mean, you can NEVER love candy TOO MUCH!!!'},
		},
		[2] = {
			{origin = 2, dialogue = 'HEY!! Your wings are super big! Can you carry things with them??'},
			{origin = 1, dialogue = 'Well, sometimes my wings can also be delicate, unlike proper hands.'},
			{origin = 2, dialogue = 'Uhuh- I get it! So you GOTTA be careful! I bet wings could help me!!!'},
			{origin = 1, dialogue = 'How so...?'},
			{origin = 2, dialogue = 'MY ACROBATICS!! Imagine it! The top of a tightrope! BOOM! Wings! Flying around!'},
			{origin = 1, dialogue = 'I sure could imagine that...'},
		},
	},

	['Gigi_Ginger'] = {
		[1] = {
			{origin = 2, dialogue = '...How many things can fit in your head?'},
			{origin = 1, dialogue = 'Uh like... A ga-zillion-billion things!'},
			{origin = 2, dialogue = 'R-really???'},
			{origin = 1, dialogue = 'Heh... nah-- BUT IMAGINE IF I COULD!!'},
		},
	},

	['Gigi_Glisten'] = {
		[1] = {
			{origin = 2, dialogue = 'Gigi, has Flutter asked you to write in her diary about me?'},
			{origin = 1, dialogue = 'I WOULD NEVER GIVE OUT HER SECRETS!!!'},
			{origin = 2, dialogue = 'Oh goodness she did! Didnt she?!'},
			{origin = 1, dialogue = 'Uh... nuh-uh...'},
			{origin = 2, dialogue = 'Youre not exactly a good liar Gigi...'},
		},
	},

	['Gigi_Goob'] = {
		[1] = {
			{origin = 1, dialogue = 'Goob, youd look cool in a sweater.'},
			{origin = 2, dialogue = 'Woah! Like yours?'},
			{origin = 1, dialogue = 'For sure! We just gotta find one with SUPER long sleeves.'},
			{origin = 2, dialogue = 'Sounds like a fun idea! Lets do it!'},
		},
	},

	['Gigi_Looey'] = {
		[1] = {
			{origin = 1, dialogue = 'Whats it like having a tiny head?'},
			{origin = 2, dialogue = 'What.'},
			{origin = 1, dialogue = 'Do you like, feel it ever after youre hit or...'},
			{origin = 2, dialogue = 'Gigi, I feel pain!'},
			{origin = 1, dialogue = 'Yeaaah but likeee, do you care when your head is small?'},
			{origin = 2, dialogue = 'What are you even saying!?'},
		},
	},

	['Gigi_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'Heeey little guy!'},
			{origin = 2, dialogue = 'Bark bark!'},
			{origin = 1, dialogue = 'Youre definitely deserving of a treat after this!'},
			{origin = 2, dialogue = 'Arf!'},
			{origin = 1, dialogue = 'Yeah, thats right, keep up the good work!'},
		},
		[2] = {
			{origin = 2, dialogue = 'ARF!'},
			{origin = 1, dialogue = 'Huh? Oh, hi there Pebble. Did you need something?'},
			{origin = 2, dialogue = 'ARF ARF!!'},
			{origin = 1, dialogue = 'Whats that? You want ME to "borrow" a bone from Gardenviews dinosaur exhibit?'},
			{origin = 2, dialogue = 'Bworf...?'},
			{origin = 1, dialogue = 'Well... if YOU say so! I cant argue with what YOURE saying! I guess I will later.'},
		}
	},

	['Gigi_Poppy'] = {
		[1] = {
			{origin = 2, dialogue = 'Gigi!'},
			{origin = 1, dialogue = 'Poppy!'},
			{origin = 2, dialogue = 'You and me should watch some shows later!'},
			{origin = 1, dialogue = 'Ooo! Alright! Ive got like a whole tape collection I could bring over!'},
			{origin = 2, dialogue = 'Yay! Just stop by my room when you wanna hangout!'},
		},
	},

	['Gigi_Razzle n Dazzle'] = {
		[1] = {
			{origin = 1, dialogue = 'So... do you guys like ever fight?'},
			{origin = 2, dialogue = 'Us? (Of course she is talking to us...)'},
			{origin = 1, dialogue = 'Yeah, you two! I like never see you fight.'},
			{origin = 2, dialogue = 'Easy, because we dont! (Its better to hear each other out...)'},
			{origin = 1, dialogue = 'Yeesh, you guys must have patience!'},
			{origin = 2, dialogue = 'Hehe I try! (We both try...)'},
		},
	},

	['Gigi_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'Rodger, be honest with a gachapon..Do you have records on me?'},
			{origin = 2, dialogue = 'Records? I dont fully understand Gigi.'},
			{origin = 1, dialogue = 'Like a written record of everything Ive maybe, perhaps, borrowed!'},
			{origin = 2, dialogue = 'You mean that youve stolen?'},
			{origin = 1, dialogue = '"Stolen" is such a strong word! -But yes.'},
			{origin = 2, dialogue = 'Yes, yes I do have that.'},
		},
	},

	['Gigi_Rudie'] = {
		[1] = {
			{origin = 2, dialogue = 'Oooh GIGI!!!'},
			{origin = 1, dialogue = 'Aw man... Dont say it-'},
			{origin = 2, dialogue = 'ITS... CHRISTMAS!!!!!'},
			{origin = 1, dialogue = 'Man... come on Rudie, you cant say this EVERY day I see you.'},
			{origin = 2, dialogue = 'I dont understand what you could possibly be talking about!!'},
			{origin = 1, dialogue = 'Honestly... I guess you never will dude.'},
		},
	},

	['Gigi_Scraps'] = {
		[1] = {
			{origin = 2, dialogue = 'Gigi! Stop, taking, my paints!'},
			{origin = 1, dialogue = 'Mwehehe...'},
			{origin = 2, dialogue = 'Gigi...'},
			{origin = 1, dialogue = 'Mwehehe... Ill do it again.'},
			{origin = 2, dialogue = 'GIGI!!'},
		},
	},

	['Gigi_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'So are you like... a sea shell?'},
			{origin = 2, dialogue = 'Haha no actually, Im a ammonite!'},
			{origin = 1, dialogue = 'Oh woah! I dont have that in my collection, yet.'},
			{origin = 2, dialogue = '...What do you mean yet?'},
			{origin = 1, dialogue = 'Dont worry about it.'},
		},
	},

	['Gigi_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = 'Lil Shrimpson, whats up?'},
			{origin = 2, dialogue = 'THATS NOT MY NAME! I HATE IT! I HATE IT! I HATE IT!!!'},
			{origin = 1, dialogue = 'Uh huh... right, right, uh huh....'},
			{origin = 2, dialogue = 'I HATE YOU!'},
			{origin = 1, dialogue = 'Wow that is so interesting mhm... do you ever enjoy things?'},
			{origin = 2, dialogue = 'I HATE TO ENJOY THINGS!'},
		},
		[2] = {
			{origin = 2, dialogue = 'I HATE YOU!'},
			{origin = 1, dialogue = 'I never asked...'},
			{origin = 2, dialogue = 'RAHHH BE QUIET!'},
			{origin = 1, dialogue = 'Id rather not...'},
		},
	},

	['Gigi_Soulvester'] = {
		[1] = {
			{origin = 2, dialogue = 'Gigi I see you are also here...wonderful.'},
			{origin = 1, dialogue = 'Heh I know sarcasm when I hear it! Come on Soulvester I know you cant handle my energy!'},
			{origin = 2, dialogue = 'Your "energy" is foul.'},
			{origin = 1, dialogue = 'Just because me and Connie think you larping as a knight is dorky doesnt mean we think youre dorky.'},
			{origin = 2, dialogue = 'I am not defined as "dorky...Dorky is not an adjective that describes me.'},
			{origin = 1, dialogue = 'Pft... alright, alright! Mwehehe-'},
		},
	},

	['Gigi_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Pst, Sprout... It says gullible on the ceiling.'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Oh cmon, not even a glance?'},
			{origin = 2, dialogue = 'Nope, I dont fall for that haha.'},
			{origin = 1, dialogue = 'Psh, alright.'},
		},
		[2] = {
			{origin = 2, dialogue = 'So are you, or are you not the one taking the aprons...?'},
			{origin = 1, dialogue = 'Mwehehe... mmmaybe.'},
			{origin = 2, dialogue = 'What would you need aprons for? Please, really, I want to know!'},
			{origin = 1, dialogue = 'Apron corner.'},
			{origin = 2, dialogue = 'What.'},
			{origin = 1, dialogue = 'I have a corner somewhere in Gardenview with MY apron collection.'},
		}
	},

	['Gigi_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = 'Squirm, you could be lot of help in one of my super sweet plans.'},
			{origin = 2, dialogue = '...I-I could...?'},
			{origin = 1, dialogue = 'For sure! -How many backpacks could you wear... more than two Im sure.'},
			{origin = 2, dialogue = '...Ive never checked how m-many backpacks I could wear.'},
			{origin = 1, dialogue = 'Were gonna have to change that! Ill need the help carrying all the cool stuff well get!'},
			{origin = 2, dialogue = 'Like...borrow? ...borrowing right? Not stealing...? Gigi? . . . Gigi?'},
		},
	},

	['Gigi_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Gigi, I noticed that one of my bags of sugar is missing.'},
			{origin = 1, dialogue = 'It was Yatta, not me! Im innocent!'},
			{origin = 2, dialogue = 'And what makes you so certain it was Yatta?'},
			{origin = 1, dialogue = 'I watched her take it before I had the chance to grab it myself!'},
			{origin = 2, dialogue = '...Right.'},
		},
	},

	['Gigi_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Tisha, when are we hanging out at my place again?'},
			{origin = 2, dialogue = 'Never again Gigi...'},
			{origin = 1, dialogue = 'Huh. Why is that again?'},
			{origin = 2, dialogue = 'I told you not until you clean up that room a bit, its a mess in there!'},
			{origin = 1, dialogue = 'NEVER!!! Ill never get rid of all my cool stuff!!'},
		},
	},

	['Gigi_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'Gigi, why were you carrying a big box labeled "stuff" or something-'},
			{origin = 1, dialogue = 'What, when did you like... see that, huh?'},
			{origin = 2, dialogue = 'I couldnt sleep well one night! I peeked down the hallway!'},
			{origin = 1, dialogue = 'Oh yeah, I forgot you live on the same blind as me.'},
			{origin = 2, dialogue = 'Uhuh!'},
			{origin = 1, dialogue = 'Forget you saw anything... Mwehehe...!'},
		},
	},

	['Gigi_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Vee, do you need like... ALL your circuitry?'},
			{origin = 2, dialogue = 'I dont like where this is going...'},
			{origin = 1, dialogue = 'Did you or did you not need that all?'},
			{origin = 2, dialogue = 'I need all my circuitry, yes.'},
			{origin = 1, dialogue = '...Ok, sure, yeah.'},
			{origin = 2, dialogue = 'Gigi, stop thinking about it.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Gigi, youre not planning to keep all the items to yourself right?'},
			{origin = 1, dialogue = '...Maybe.'},
			{origin = 2, dialogue = 'Gigi... dont just take everything for yourself.'},
			{origin = 1, dialogue = 'Ooo... no promises!'},
			{origin = 2, dialogue = 'Gigi!!!'},
		},
	},

	['Gigi_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Yatta, where do you like... stash all your candy?'},
			{origin = 2, dialogue = 'In my SUPER SECRET candy stash of course!'},
			{origin = 1, dialogue = 'Riiiight, but like... where is it?'},
			{origin = 2, dialogue = 'Oh! Its just to the left of- WAIT JUst a moment.'},
			{origin = 1, dialogue = '...No really, go ahead.'},
			{origin = 2, dialogue = 'Im not falling for THAT ONE!!!!'},
		},
	},

	['Ginger_Goob'] = {
		[1] = {
			{origin = 1, dialogue = 'I heard from someone else that you love cookies...?'},
			{origin = 2, dialogue = 'YEAH! I love cookies!'},
			{origin = 1, dialogue = 'Well I baked some, maybe youd like to give them a try at some point...?'},
			{origin = 2, dialogue = 'Oh uh... I dunno! I tried your cookies last year, they dont really taste like the cookies Cosmo makes.'},
			{origin = 1, dialogue = 'Ah- I understand...'},
			{origin = 2, dialogue = 'But thank you for thinking of offering!! Thats really, really nice of you!!'},
		},
	},

	['Ginger_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'Hows your little investigations going...?'},
			{origin = 2, dialogue = 'Ah, they arent little investigations! Im uncovering a big picture.'},
			{origin = 1, dialogue = 'Oh...?'},
			{origin = 2, dialogue = 'Yes, plenty happens outside of the Christmas season when we see you lot most.'},
			{origin = 1, dialogue = '...Right, I suppose I just forget sometimes.'},
		},
	},

	['Ginger_Rudie'] = {
		[1] = {
			{origin = 1, dialogue = 'Feeling festive my friend...?'},
			{origin = 2, dialogue = 'Its all I know! Hehe!'},
			{origin = 1, dialogue = 'Oh... Well when you say it like that its a tad ominous.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Lalalah! I love Christmas!'},
			{origin = 1, dialogue = '...Of course, uhm, but its not really-'},
			{origin = 2, dialogue = 'It is the most festive time of the year!!'},
			{origin = 1, dialogue = '...Right.'},
		},
	},

	['Ginger_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Scraps, have you ever thought of taking your art skills into culinary arts...?'},
			{origin = 2, dialogue = 'Haha, I dont know, maybe I should stick with crafts!'},
			{origin = 1, dialogue = 'Its not about skills, its about spending time with others you care about- Thats part of the Holidays.'},
			{origin = 2, dialogue = 'Right, right... very festive of you! I guess I could put aside some time!'},
			{origin = 1, dialogue = 'Aw come on... Id love some company in the kitchen to make baked goods.'},
			{origin = 2, dialogue = 'Yeah but Im sure Sprout and Cosmo are far better help! Theyd be far more skilled!'},
		},
	},

	['Ginger_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = 'Im forgetting if I left icing outside of the fridge...'},
			{origin = 2, dialogue = 'SHRIMPO HATES ICING!!!'},
			{origin = 1, dialogue = '...Oh, I-im sorry...?'},
			{origin = 2, dialogue = 'YOU SHOULD BE I HATE YOU!'},
		},
	},

	['Ginger_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Sprout... How are you?'},
			{origin = 2, dialogue = 'Doing Good! Happy to have you around of course.'},
			{origin = 1, dialogue = 'Hehe... yeah, hope your baking has been well, I had some recipes to share.'},
			{origin = 2, dialogue = 'Oh yeah? Sounds like a good time! Youll have to show me the recipes soon.'},
			{origin = 1, dialogue = '...Will do!'},
		},
	},

	['Ginger_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Does a certain someone want some Christmas cookies...?'},
			{origin = 2, dialogue = 'OH, OH! ME! ME! ME!'},
			{origin = 1, dialogue = 'Youll love them, I made them myself...'},
			{origin = 2, dialogue = 'Wait... you made the cookies? Not Cosmo?'},
			{origin = 1, dialogue = 'Mhm! baked and decorated the cookies myself! Ill give you some after were finished here.'},
			{origin = 2, dialogue = '...Mmm, thaaanks.'},
		},
	},

	['Ginger_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'You know... Sometimes I binge your gameshow episodes...'},
			{origin = 2, dialogue = 'Huh? Seriously? Just the gameshow segments in the seasons?'},
			{origin = 1, dialogue = 'Mhm... so much variety, so many outcomes with contestants.'},
			{origin = 2, dialogue = 'Glad to know you Holiday Toons have things to keep you busy all year long.'},
			{origin = 1, dialogue = '...Right.'},
		},
	},

	['Glisten_Goob'] = {
		[1] = {
			{origin = 1, dialogue = 'Goob, how does it feel to be so fluffy my friend?'},
			{origin = 2, dialogue = 'Feels fluffy!'},
			{origin = 1, dialogue = 'Oh, youre too silly! Too sweet!'},
			{origin = 2, dialogue = 'Hehehe- Youre sweet too!'},
			{origin = 1, dialogue = 'Ah... I know!'},
		},
	},

	['Glisten_Looey'] = {
		[1] = {
			{origin = 2, dialogue = 'Glisten, are you not a fan of clowns?'},
			{origin = 1, dialogue = 'Oh goodness, wow! What! Me? Not, like, clowns??? ME of all Toons???'},
			{origin = 2, dialogue = '...Well, do you?'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'I understand...'},
		},
	},

	['Glisten_Pebble'] = {
		[1] = {
			{origin = 2, dialogue = 'Grrrr...'},
			{origin = 1, dialogue = 'Hm? Whats wrong? Why are you looking at me like that...?'},
			{origin = 2, dialogue = 'BARK BARK!!'},
			{origin = 1, dialogue = 'What did I even do-? Oh, youre looking at your reflection, arent you...'},
			{origin = 2, dialogue = 'GRRRRR...'},
			{origin = 1, dialogue = 'Yeah, youre looking at your reflection. Of course you are.'},
		},
		[2] = {
			{origin = 1, dialogue = 'Well look who it is! Hello Pebble!'},
			{origin = 2, dialogue = 'Bark Bark!'},
			{origin = 1, dialogue = 'Goodness, Poppy was right. You really would look adorable in a pink bow!'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'Its a compliment, trust me.'},
		},
	},

	['Glisten_Poppy'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Glisten! How are you doing?'},
			{origin = 1, dialogue = 'Im doing perfect! You seem happy Poppy.'},
			{origin = 2, dialogue = 'Who said I was happy?'},
			{origin = 1, dialogue = '...Are you not happy right now?'},
			{origin = 2, dialogue = 'Nope! Just optimistic!'},
		},
	},

	['Glisten_Razzle n Dazzle'] = {
		[1] = {
			{origin = 2, dialogue = 'Glisten! Im so happy youre here friend! (Hey...)'},
			{origin = 1, dialogue = 'Oh if it isnt my favourite duo! We have to hangout sometime!'},
			{origin = 2, dialogue = 'I found some new scripts around the center! (Youll love them...)'},
			{origin = 1, dialogue = 'Im sure I will, I trust both of your judgements.'},
			{origin = 2, dialogue = 'Ooo Im excited now! (Thank you Glisten... We can all review them later.)'},
		},
	},

	['Glisten_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Rodger.'},
			{origin = 2, dialogue = 'Dont say it.'},
			{origin = 1, dialogue = 'Its not my fault I notice the smudges on your glass!'},
			{origin = 2, dialogue = 'I am plenty well-kept!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Youre keeping safe I hope?'},
			{origin = 1, dialogue = 'Me? Rodger please, I make this look easy.'},
			{origin = 2, dialogue = '...I saw you almost walk into a wall.'},
			{origin = 1, dialogue = 'Tch.. youre seeing things.'},
			{origin = 2, dialogue = 'Ive got a keen eye, Glisten. Dont forget that.'},
			{origin = 1, dialogue = 'Mhmmm... Im alright.'},
		}
	},

	['Glisten_Rudie'] = {
		[1] = {
			{origin = 2, dialogue = 'Merry Christmas!'},
			{origin = 1, dialogue = '...Uhm Rudie Its not--'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'I mean-- MERRY CHRISTMAS! Hahaha... silly me mhm...!'},
		},
	},

	['Glisten_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Scraps I really think I should be your next artistic muse!'},
			{origin = 2, dialogue = 'Haha, not happening Glisten.'},
			{origin = 1, dialogue = 'Your loss! What is better than the best topic, ME!'},
			{origin = 2, dialogue = 'I could think of multiple things better...'},
		},
	},

	['Glisten_Shelly'] = {
		[1] = {
			{origin = 2, dialogue = 'Glisten, how do you do it?'},
			{origin = 1, dialogue = 'Hm? Do what... ?'},
			{origin = 2, dialogue = 'Get everyone to notice you?'},
			{origin = 1, dialogue = 'Aw! Im so glad you asked me Shelby!'},
			{origin = 2, dialogue = 'My name is Shelly.'},
			{origin = 1, dialogue = 'RIGHT! That was a test! Of memory! Anyways- Ill actually tell you later!'},
		},
	},

	['Glisten_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = 'You know you could stand to be nicer.'},
			{origin = 2, dialogue = 'NO, NEVER, I HATE YOU.'},
			{origin = 1, dialogue = 'Mhm, sure, Shrimpo.'},
		},
		[2] = {
			{origin = 2, dialogue = 'GLISTEN, YOURE UGLY!!!'},
			{origin = 1, dialogue = 'Shrimpo... you know I am a mirror, yes?'},
			{origin = 2, dialogue = 'AN UGLY ONE!!!'},
			{origin = 1, dialogue = 'But Shrimpo, I reflect so...'},
			{origin = 2, dialogue = 'NO MORE TALKING, YOURE DONE TALKING!!!'},
		},
	},

	['Glisten_Soulvester'] = {
		[1] = {
			{origin = 2, dialogue = 'Hm, your reflecting face is as almost as shining as my armor.'},
			{origin = 1, dialogue = 'Ooo! Armor! I love watching those old tales about the knight saving the princess!'},
			{origin = 2, dialogue = 'Of course! A classic part one of the many duties a knight bears.'},
			{origin = 1, dialogue = 'Wow, so heroic of you!'},
		},
	},

	['Glisten_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Ugh.. All this running has me-'},
			{origin = 2, dialogue = 'Exhausted?'},
			{origin = 1, dialogue = 'YES! Of course... I can push through it though!'},
			{origin = 2, dialogue = 'Let me guess... because youre perfect?'},
			{origin = 1, dialogue = 'EXACTLY!! Sprout, look at you! So clever!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Glisten, doing alright? No injuries?'},
			{origin = 1, dialogue = 'Sprout, youre sooo clingy! Im fine, perfect even!'},
			{origin = 2, dialogue = '...Is that a little crack on your mirror?'},
			{origin = 1, dialogue = 'OH MY GOODNESS -WHERE!?'},
			{origin = 2, dialogue = 'Right, so youre still doing "perfect"...'},
			{origin = 1, dialogue = 'Sprout!! Dont tease me like that!'},
		},
	},

	['Glisten_Squirm'] = {
		[1] = {
			{origin = 2, dialogue = 'I-I cant handle this all! IM A FAILURE!!'},
			{origin = 1, dialogue = 'Oh come now Squirm, youre not a failure! Youre being far too hard on yourself!'},
			{origin = 2, dialogue = 'Thats easy for you to s-say... youre perfect at everything...'},
			{origin = 1, dialogue = 'Yes Squirm, yes I am...b-BUT! That doesnt mean you cant be ALMOST as perfect as me!'},
			{origin = 2, dialogue = 'O-okay...snf- sniffle-'},
			{origin = 1, dialogue = 'See! Now try being a bit more like me this next blind, perfect!'},
		},
	},

	['Glisten_Teagan'] = {
		[1] = {
			{origin = 1, dialogue = 'Teagaaan!!!'},
			{origin = 2, dialogue = 'Oh my, what is it?'},
			{origin = 1, dialogue = 'I love the dress youre wearing.'},
			{origin = 2, dialogue = '...Was that all you wanted to say Glisten?'},
			{origin = 1, dialogue = 'Hmmm, yeah about so!'},
		},
	},

	['Glisten_Tisha'] = {
		[1] = {
			{origin = 2, dialogue = 'Glisten how do you keep your glass so clean?'},
			{origin = 1, dialogue = 'Its simple really! Ive got a morning routine.'},
			{origin = 2, dialogue = 'Whats the morning routine?'},
			{origin = 1, dialogue = '...A secret.'},
			{origin = 2, dialogue = 'You just use a towel dont you?'},
			{origin = 1, dialogue = 'Hush, hush- Lets focus now haha!'},
		},
	},

	['Glisten_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'Hmm... Can you do a makeup for me later?'},
			{origin = 1, dialogue = 'For you? Of course if thats what youd like!'},
			{origin = 2, dialogue = 'It is!! I really wanna!'},
			{origin = 1, dialogue = 'Then we will, but later! Not now.'},
			{origin = 2, dialogue = 'YES!!! Im going to have ALL the glitter!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Toodles! Hiii buddy! How are you? You better be good!'},
			{origin = 2, dialogue = 'I am good! Even better when youre here!'},
			{origin = 1, dialogue = 'I know... everything is better with me.'},
			{origin = 2, dialogue = 'Yeah! Even when youre doing that thing where you cry and complain to Rodger!'},
			{origin = 1, dialogue = '...I think thats enough chatting for now, hahaha-'},
		}
	},

	['Glisten_Vee'] = {
		[1] = {
			{origin = 2, dialogue = 'You know, you couldnt make a good game show, even if you tried.'},
			{origin = 1, dialogue = 'Goodness Vee! Ouchie, owie, ow! Fighting words are out here right now.'},
			{origin = 2, dialogue = 'Yes, if fighting was just the truth.'},
			{origin = 1, dialogue = 'Youre right I wouldnt be good... Id be better, Id be perfect actually!'},
			{origin = 2, dialogue = 'Sure, if you keep dreaming so much you should talk with Astro.'},
		},
		[2] = {
			{origin = 1, dialogue = 'Vee!! Hellooo oh bestest closest friend of mine whom I care for deeply!'},
			{origin = 2, dialogue = '...What is it now?'},
			{origin = 1, dialogue = 'Oh youre no fun.'},
			{origin = 2, dialogue = 'Well? Go on.'},
			{origin = 1, dialogue = 'Tch- Ugh... I broke my microphone. I need a spare.'},
			{origin = 2, dialogue = 'Just meet me after this.'},
		}
	},

	['Glisten_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'So, you do a bunch of clown stuff for your little clown group?'},
			{origin = 2, dialogue = 'Its NOT a clown group! Its a circus troupe!'},
			{origin = 1, dialogue = 'Right, well, arent you all clowns?'},
			{origin = 2, dialogue = 'NOPE!! Looey kinda is-! But otherwise Im an acrobat, and Blots a mime!'},
			{origin = 1, dialogue = 'Oh, I guess thats not as bad as I thought.'},
		},
	},

	['Goob_Looey'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey, looking for a hug, Looey?'},
			{origin = 2, dialogue = 'Haha... uh maybe not...?'},
			{origin = 1, dialogue = 'Oh why?'},
			{origin = 2, dialogue = 'Last time you squeezed me a bit too tight!'},
			{origin = 1, dialogue = 'Oooh, sorry!'},
		},
	},

	['Goob_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'I dont know why Scraps doesnt like you that much, Pebble.'},
			{origin = 2, dialogue = 'Bworf?'},
			{origin = 1, dialogue = 'I mean, just look at you! What isnt there to like? Youre adorable!'},
			{origin = 2, dialogue = 'Arf!'},
			{origin = 1, dialogue = 'Awwww! If you ever want a hug, you know where to find me!'},
			{origin = 2, dialogue = 'Bark Bark!'},
		},
	},

	['Goob_Poppy'] = {
		[1] = {
			{origin = 1, dialogue = 'Poppy!'},
			{origin = 2, dialogue = 'Goob!!'},
			{origin = 1, dialogue = 'Poppy!!'},
			{origin = 2, dialogue = 'GOOB!!!'},
			{origin = 1, dialogue = 'Alright, alright, I cant yell any louder. You win!'},
		},
	},

	['Goob_Razzle n Dazzle'] = {
		[1] = {
			{origin = 2, dialogue = 'Heya there Goob! (...)'},
			{origin = 1, dialogue = 'Hi Dazzle!!'},
			{origin = 2, dialogue = 'Actually Im Razzle! (...And Im Dazzle.)'},
			{origin = 1, dialogue = 'Oooh.. wait, then who am I?'},
			{origin = 2, dialogue = 'Youre Goob...? (...What)'},
			{origin = 1, dialogue = 'OOOH!!! Right, Im Goob!!'},
		},
	},

	['Goob_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'Rodger! Looking for a hug?'},
			{origin = 2, dialogue = 'What? No, not at the moment, though Ive found your hugs strategic.'},
			{origin = 1, dialogue = 'Strategic? What do you mean?'},
			{origin = 2, dialogue = 'You know! Pulling us fellow Toons from danger! Isnt that the reason you hug others?'},
			{origin = 1, dialogue = 'Not really- I just think some Toons need a hug right about now!'},
		},
	},

	['Goob_Rudie'] = {
		[1] = {
			{origin = 2, dialogue = 'Happy Holidays!'},
			{origin = 1, dialogue = 'Its the Holidays? Wait which one???'},
			{origin = 2, dialogue = '...Uhm, pretty sure its Christmas!!'},
			{origin = 1, dialogue = 'Oh! Ok! Wont argue with that!!'},
		},
	},

	['Goob_Scraps'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey little bro, nothings giving you trouble right?'},
			{origin = 1, dialogue = 'Well... Sorta? The Twisteds are.'},
			{origin = 2, dialogue = 'Well yeah! Obviously haha, but if theres anything else you let me know! Alright?'},
			{origin = 1, dialogue = 'Hehe alright! Thanks Scraps.'},
		},
		[2] = {
			{origin = 1, dialogue = 'Scraps!! You doing okay sis?'},
			{origin = 2, dialogue = 'Yup! Just trying my best, better to have you here with me though!'},
			{origin = 1, dialogue = 'I could say the same! I feel safer with you around!'},
			{origin = 2, dialogue = 'Thats what a big sister is for!'},
		},
	},

	['Goob_Shelly'] = {
		[1] = {
			{origin = 2, dialogue = 'Would you hug a dinosaur?'},
			{origin = 1, dialogue = 'I would hug a million dinosaurs!'},
			{origin = 2, dialogue = 'Even the ones with sharp teeth?'},
			{origin = 1, dialogue = 'I have sharp teeth too!'},
			{origin = 2, dialogue = 'Oh right! I forgot haha!'},
		},
	},

	['Goob_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = 'Aw Shrimpo, do you need a hug to turn that frown upside down?'},
			{origin = 2, dialogue = 'I HATE HUGS!'},
			{origin = 1, dialogue = 'What?'},
			{origin = 2, dialogue = 'I HATE HUGS AND I HATE YOU!!!'},
			{origin = 1, dialogue = 'Nevermind-..'},
		},
	},

	['Goob_Sprout'] = {
		[1] = {
			{origin = 2, dialogue = 'Goob, dont your hands hurt from saving the toons all the time?'},
			{origin = 1, dialogue = 'Not at all! Im used to it!'},
			{origin = 2, dialogue = 'Well, if you ever need a break from all the saving around, you can tell me!'},
			{origin = 1, dialogue = 'Nuh-uh! Ill be the one helping you!'},
			{origin = 2, dialogue = 'Hmm I dont think so.'},
			{origin = 1, dialogue = 'I know so!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Sprout! You seem a little tense! Need a big hug?'},
			{origin = 2, dialogue = 'Nah... Im good.'},
			{origin = 1, dialogue = '...Are you sure?'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = '-After this I can give you the biggest hug!! Cmon!!'},
			{origin = 2, dialogue = 'Hmmm, fine! After this.'},
		},
	},

	['Goob_Squirm'] = {
		[1] = {
			{origin = 2, dialogue = 'Snf... sniffle-'},
			{origin = 1, dialogue = 'Awww, someone sounds like they need a big hug!'},
			{origin = 2, dialogue = 'Y-yes please-'},
			{origin = 1, dialogue = 'Dont you worry! My big sister says I give the best hugs! So youre in luck!!'},
			{origin = 2, dialogue = 'M-me...? lucky...? ...Hehe... I feel better already.'},
		},
	},

	['Goob_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Care for some tea after this Goob?'},
			{origin = 1, dialogue = '...Are you sure? I dropped the cup last time!'},
			{origin = 2, dialogue = 'Dont worry my friend! Ive found straws recently.'},
			{origin = 1, dialogue = 'Oooo~! That sounds fun! Do the straws bend?'},
			{origin = 2, dialogue = 'Yes.'},
			{origin = 1, dialogue = 'YAYY!!!'},
		},
	},

	['Goob_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Tisha youre so busy all the time!'},
			{origin = 2, dialogue = 'Well I wouldnt be as busy without everyone causing a mess!'},
			{origin = 1, dialogue = 'Good thing I dont!'},
			{origin = 2, dialogue = 'Goob, you shed.'},
			{origin = 1, dialogue = 'I WHAT!?'},
			{origin = 2, dialogue = 'Uh, nevermind! I didnt say anything- Haha...'},
		},
	},

	['Goob_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya buddy! Are you a little scared?'},
			{origin = 2, dialogue = 'Well... a little!'},
			{origin = 1, dialogue = 'Thats ok! Ill be here to protect you!!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Hmmm... Goob?'},
			{origin = 1, dialogue = 'Yeees, Toodles?'},
			{origin = 2, dialogue = 'Why are your teeth scary?'},
			{origin = 1, dialogue = 'Scary? ...I dont think theyre scary!'},
			{origin = 2, dialogue = 'Well, theyre sharp!'},
			{origin = 1, dialogue = 'Being a little different isnt scary!'},
		},
	},

	['Goob_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Vee, whats it like knowing so much?'},
			{origin = 2, dialogue = 'Glad you asked, the knowledge and information I have recorded helps in my day to day.'},
			{origin = 1, dialogue = 'Oh! Yeah it probably would!'},
			{origin = 2, dialogue = 'Yup, I know all that I would need to know.'},
			{origin = 1, dialogue = 'Do you even know how to give the best hugs?'},
			{origin = 2, dialogue = 'I said everything I would NEED to know Goob.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Goob, why did you never sign up for my hosted trivia?'},
			{origin = 1, dialogue = 'I just wanted to cheer on my big sister!'},
			{origin = 2, dialogue = 'Yeah but, wouldnt you want to prove youre smarter than her lucky guesses?'},
			{origin = 1, dialogue = 'I dont need to prove that sort of thing to anyone!'},
			{origin = 2, dialogue = '...Hm, well, If thats what youve decided, cant say I agree.'},
			{origin = 1, dialogue = 'I hope youll be able to understand someday then!'},
		},
	},

	['Goob_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'YATTA!'},
			{origin = 2, dialogue = 'GOOB!'},
			{origin = 1, dialogue = 'How are you??'},
			{origin = 2, dialogue = 'IM GOOD!!! How are you???'},
			{origin = 1, dialogue = 'IM GOOD!!!'},
			{origin = 2, dialogue = 'Lets keep being good!!'},
		},
		[2] = {
			{origin = 2, dialogue = 'GOOB!'},
			{origin = 1, dialogue = 'YATTA!'},
			{origin = 2, dialogue = 'Hows the whole HUG BUSINESS??'},
			{origin = 1, dialogue = 'Oh! Its not a business! I hug for free!'},
			{origin = 2, dialogue = 'FOR FREE??? Sign me up for more!!'},
		},
	},

	['Gourdy_Pebble'] = {
		[1] = {
			{origin = 1, dialogue = 'Pebble! Pebble!!! Youre so cute!!'},
			{origin = 2, dialogue = 'Arf!! Arf!!'},
			{origin = 1, dialogue = 'Whos the bestest boy!! You are! Hehehe'},
			{origin = 2, dialogue = 'Bark! Bark!'},
		},
	},

	['Gourdy_Ribecca'] = {
		[1] = {
			{origin = 1, dialogue = 'Ribecca! Ribecca!!'},
			{origin = 2, dialogue = 'Yeah little boss man? Whats up-?'},
			{origin = 1, dialogue = 'Can we draw together!! ...When youre not so busy of course.'},
			{origin = 2, dialogue = 'You know Im never too busy for you. Let me guess youll draw tons of spooky stuff?'},
			{origin = 1, dialogue = 'Yup! -And youll draw cool costumes??'},
			{origin = 2, dialogue = 'Yup, you know me.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Heya kid, you doing alright?'},
			{origin = 1, dialogue = 'Mhm! What about you? Still got all your bones???'},
			{origin = 2, dialogue = 'You know if you asked any other Toon that question they would be concerned haha-'},
			{origin = 1, dialogue = 'Yeah but youre missing your hand.'},
			{origin = 2, dialogue = 'WAIT WHAT- Oh, wait, I still have both my hands... Pft are you pranking me?'},
			{origin = 1, dialogue = 'Hehe maaaaybe!!'},
		}
	},

	['Gourdy_Rodger'] = {
		[1] = {
			{origin = 2, dialogue = 'Hello Holloway, how are you doing...? Need any help?'},
			{origin = 1, dialogue = 'Uhmmm. . ..Im ok, Im doing fine really, I guess.'},
			{origin = 2, dialogue = 'Well know that you can always come to me if you need anything, and I mean it!'},
			{origin = 1, dialogue = 'Mhm! Ok! Yeah! Ill let you know Mister Rodger!'},
		},
	},

	['Gourdy_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'If you think about it- fossils are like skeletons.'},
			{origin = 2, dialogue = 'Well... not all fossils are skeletal remains actually!'},
			{origin = 1, dialogue = 'Aw, what!'},
			{origin = 2, dialogue = 'Its not a bad thing though! Variation in data is key to new discoveries!'},
			{origin = 1, dialogue = 'Alright... if you say so Miss Fossilian.'},
		},
	},

	['Gourdy_Soulvester'] = {
		[1] = {
			{origin = 2, dialogue = 'You are being very brave today, my liege.'},
			{origin = 1, dialogue = 'Why thank you! I am very brave today arent I!'},
			{origin = 2, dialogue = 'Of course, but even those who are brave have others whom they rely on.'},
			{origin = 1, dialogue = 'Yeah...I get what youre saying, uhuh...'},
			{origin = 2, dialogue = 'Heed my words Gourdy, I have your best interests at heart.'},
		},
		[2] = {
			{origin = 1, dialogue = 'Soulvester, are you doing okay??'},
			{origin = 2, dialogue = 'I should be the one to ask you, my liege.'},
			{origin = 1, dialogue = 'I keep telling you that isnt my name silly! Im Gourdy!'},
			{origin = 2, dialogue = '...Of course, my habits have bested me- Sir Gourdy.'},
			{origin = 1, dialogue = 'Uhuh, Uhuh, yeah but Gourdy is my first name, not "Sir"! Hehehe-'},
			{origin = 2, dialogue = 'Haha...Now you are acting alike to a jester. You knew what I meant.'},
		}
	},

	['Gourdy_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya there Mister Seedly!'},
			{origin = 2, dialogue = 'Gourdy please just call me Sprout...'},
			{origin = 1, dialogue = 'Oh! Right! Heya Sprout! Whatcha Doing...?'},
			{origin = 2, dialogue = 'Thinking up a new recipe, Ill probably need a taste-tester though...'},
			{origin = 1, dialogue = 'OH, OH, ME!!! Please, please!'},
			{origin = 2, dialogue = 'Haha- Of course... Pft- Mister Holloway.'},
		},
	},

	['Gourdy_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Toodles, what if we pretend youre like a super brave detective, and Im like a villain.'},
			{origin = 2, dialogue = 'I dont have to pretend Im a super brave detective! I am one! Hehehe'},
			{origin = 1, dialogue = 'Nuh-uh you got scared when I pulled out Halloween decorations last year!'},
			{origin = 2, dialogue = 'Shhh!! Im still super brave! ...Usually'},
			{origin = 1, dialogue = 'Hehehe ok! Ok!'},
		},
	},

	['Gourdy_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Vee!! Vee- I have another thing i was hoping you could sign!'},
			{origin = 2, dialogue = 'Another autographed item...? Well I cant say no to a fan.'},
			{origin = 1, dialogue = 'YES,YEAH, WOO! -I mean, ahem... Thank you.'},
			{origin = 2, dialogue = 'Right...'},
		},
	},

	['Looey_Pebble'] = {
		[1] = {
			{origin = 2, dialogue = 'Bark!'},
			{origin = 1, dialogue = 'Haha, yeah? Youre a sweet pet rock!'},
			{origin = 2, dialogue = 'Arf Arf!'},
			{origin = 1, dialogue = 'Dont worry Ill pet you later!'},
			{origin = 2, dialogue = 'Bworf.'},
		},
	},

	['Looey_Poppy'] = {
		[1] = {
			{origin = 2, dialogue = 'Pop.'},
			{origin = 1, dialogue = 'Pop, pop.'},
			{origin = 2, dialogue = 'Pop!'},
			{origin = 1, dialogue = 'Poppity, pop, pop.'},
			{origin = 2, dialogue = 'Hehehe... pop.'},
		},
		[2] = {
			{origin = 1, dialogue = 'Do you ever fear thumbtacks?'},
			{origin = 2, dialogue = 'Oh, all the time!'},
			{origin = 1, dialogue = 'Shrimpo keeps trying to put them in my room.'},
			{origin = 2, dialogue = 'Thats a waste of thumbtacks.'},
			{origin = 1, dialogue = 'Thats what Im thinking.'},
		},
	},

	['Looey_Razzle n Dazzle'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Looey think we could be part of your next act? (...If its okay.)'},
			{origin = 1, dialogue = 'Hmm, Id have to ask the rest of the circus troupe!'},
			{origin = 2, dialogue = 'Ah right, that makes sense! (...Yeah.)'},
			{origin = 1, dialogue = 'Ill get back to you both on that!'},
		},
	},

	['Looey_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Rodger, if I had something bothering me you could look into it right?'},
			{origin = 2, dialogue = 'Well thats dependent on what has you bothered!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Looey?'},
			{origin = 1, dialogue = 'Ah, never mind! HAha, Im just overthinking something!'},
			{origin = 2, dialogue = 'Well, Im here if you need me.'},
		},
	},

	['Looey_Rudie'] = {
		[1] = {
			{origin = 2, dialogue = 'Looey! Isnt it funny how I have a red nose, and... IM NOT EVEN A CLOWN! Hahaha!'},
			{origin = 1, dialogue = 'Hahaha, yeah, yeah... THATS funny!'},
			{origin = 2, dialogue = 'Yup! My red nose has that christmas festive glow to it!'},
			{origin = 1, dialogue = 'Thats good for you Rudie... Im happy for you!'},
			{origin = 2, dialogue = 'Of course youd be! Why would anyone be unhappy ON CHRISTMAS!!!'},
		},
	},

	['Looey_Scraps'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey, I think your tails wagging.'},
			{origin = 1, dialogue = 'It does that, how about you?'},
			{origin = 2, dialogue = 'Yeah, sometimes, when Im mad though.'},
			{origin = 1, dialogue = 'Right, mine does so when Im happy!'},
			{origin = 2, dialogue = 'Good talk.'},
			{origin = 1, dialogue = 'Yup! Good talk!'},
		},
	},

	['Looey_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'Hmm, I should put together an act for later!'},
			{origin = 2, dialogue = 'Ooo! Could I come watch?'},
			{origin = 1, dialogue = 'Huh? Oh er... Yeah! Sure! Didnt see you there haha!'},
			{origin = 2, dialogue = 'I get that a lot... hahaha...'},
		},
	},

	['Looey_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya Shrimpo! How are you feeling buddy?'},
			{origin = 2, dialogue = 'IF I HAD A SHARP PIN I WOULD POP YOU!!!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'I WILL PUT THUMBTACKS IN YOUR ROOM.'},
			{origin = 1, dialogue = 'Ill check up on you later, then...'},
		},
	},

	['Looey_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Sprout, are you sure you have to take care of everyones health?'},
			{origin = 2, dialogue = 'Looey, if I think you need some extra care, thats my call, were a team!'},
			{origin = 1, dialogue = '...I know but, Id hate to waste your-'},
			{origin = 2, dialogue = 'Looey, youre never a waste of anything.'},
			{origin = 1, dialogue = 'Sorry!! Never mind!! Pretend I didnt say anything!! HAHAHAha AHem-'},
		},
		[2] = {
			{origin = 2, dialogue = 'Maybe I should start keeping a list of every Toons favorite flavor of cupcake.'},
			{origin = 1, dialogue = 'Gee Sprout, thats a pretty kind thought, how many flavors are there?'},
			{origin = 2, dialogue = 'Well theres milk chocolate, vanilla, dark chocolate, lemon, white chocolate, red velvet-'},
			{origin = 1, dialogue = 'Strawberry?'},
			{origin = 2, dialogue = 'Oh! Yeah, I was going to get to that one haha!'},
		},
	},

	['Looey_Squirm'] = {
		[1] = {
			{origin = 2, dialogue = 'I-Im so nervous... what if we just lose the run!! THEN WHAT'},
			{origin = 1, dialogue = '. . .'},
			{origin = 2, dialogue = 'WHAT IF!?- Oh no, oh no, ooooh NO-!!'},
			{origin = 1, dialogue = 'Squirm... I think youre overthinking things- just a bit!'},
			{origin = 2, dialogue = 'B-But...'},
			{origin = 1, dialogue = 'Dont continue- You ever hear a clown panic? ...Its NOT as funny as youd think'},
		},
	},

	['Looey_Teagan'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Teagan, I think your tea parties could use some entertainment!'},
			{origin = 2, dialogue = 'I believe my tea parties are entertaining enough Looey, but thank you for the offer.'},
			{origin = 1, dialogue = 'But there arent any clowns! Or acrobats! Or mimes!'},
			{origin = 2, dialogue = 'My tea parties dont need a circus troupe to be entertaining.'},
			{origin = 1, dialogue = 'If you say so, but the offer is still on the table if you change your mind!'},
		},
	},

	['Looey_Tisha'] = {
		[1] = {
			{origin = 2, dialogue = 'Looey please tell Yatta to clean her room.'},
			{origin = 1, dialogue = 'Why dont you tell her...?'},
			{origin = 2, dialogue = 'Well she listens to you more than me.'},
			{origin = 1, dialogue = 'Ah, well, Im not getting involved in this one.'},
			{origin = 2, dialogue = 'Oh come on!'},
			{origin = 1, dialogue = 'Nope! This is between you both, subtract the Looey in your math!'},
		},
	},

	['Looey_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'Hehehe...hehe!'},
			{origin = 1, dialogue = 'Hahaha... I havent even told a joke yet!'},
			{origin = 2, dialogue = 'You dont need to! Hehehe-'},
			{origin = 1, dialogue = 'Ah, and why is that my little friend?'},
			{origin = 2, dialogue = 'You already look silly!!'},
			{origin = 1, dialogue = 'Oh. . . Aha... HahaHAHA-!'},
		},
	},

	['Looey_Vee'] = {
		[1] = {
			{origin = 2, dialogue = 'Still doing those circus acts?'},
			{origin = 1, dialogue = 'Yup! You wanna come see one?'},
			{origin = 2, dialogue = 'No.'},
			{origin = 1, dialogue = 'Ahaha... ah.'},
			{origin = 2, dialogue = 'Im a bit too busy... maybe another time.'},
			{origin = 1, dialogue = 'Oh, right, of course!'},
		},
	},

	['Looey_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Oooh Yatta, youre doing so much better then me!'},
			{origin = 2, dialogue = 'Looey, stop, youre doing PERFECT!!!'},
			{origin = 1, dialogue = 'Haha, Nooo, no, youre much better then me-'},
			{origin = 2, dialogue = 'TAKE, THE, COMPLIMENT!!!'},
			{origin = 1, dialogue = 'OH! Right haha, right, taking compliments! Can do!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Looey, my best buddy ever, LOOEY!!!'},
			{origin = 1, dialogue = 'Yeah Yatta?'},
			{origin = 2, dialogue = 'Youre one of my BEST FRIENDS!!! -AND I ONLY HAVE TWO BEST FRIENDS!!!'},
			{origin = 1, dialogue = 'Hahaha- Yeah? Really?'},
			{origin = 2, dialogue = 'YUP! FOREVER AND EVER!!! I just gotta remind you!'},
		},
	},

	['Pebble_Poppy'] = {
		[1] = {
			{origin = 1, dialogue = 'Bark! Arf!'},
			{origin = 2, dialogue = 'Aww!! What a cute rock!! Youd look cuter with a big pink bow!'},
			{origin = 1, dialogue = 'Bworf..?'},
		},
	},

	['Pebble_Razzle n Dazzle'] = {
		[1] = {
			{origin = 1, dialogue = 'Bark! Bark!'},
			{origin = 2, dialogue = 'Aww how cute!! A little pet rock! (More like terrifying...)'},
			{origin = 1, dialogue = 'Arf!'},
			{origin = 2, dialogue = 'Seems sweet to me! (Agree to disagree...)'},
		},
		[2] = {
			{origin = 2, dialogue = 'Aw look Dazzle!! A pet rock! (Id rather close my eyes...)'},
			{origin = 1, dialogue = 'Arf! Arf!'},
			{origin = 2, dialogue = 'So sweet!!! (Please dont let it get any closer...)'},
			{origin = 1, dialogue = 'Bark!'},
		},
	},

	['Pebble_Ribecca'] = {
		[1] = {
			{origin = 2, dialogue = 'Aw Pebble, dont stare at me man...'},
			{origin = 1, dialogue = '...Arf.'},
			{origin = 2, dialogue = 'Pebble, no, bad rock- no staring!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Eugh... Dandy needs to not leave us in the same card area.'},
		},
	},

	['Pebble_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'Woof! Bark!'},
			{origin = 2, dialogue = 'I see, a small stone... Without a leash?'},
			{origin = 1, dialogue = 'Grrr...'},
			{origin = 2, dialogue = 'Right, right, no leash necessary! Understood!'},
		},
	},

	['Pebble_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Grr...'},
			{origin = 2, dialogue = 'Really? You dont want to go there, buddy...'},
			{origin = 1, dialogue = 'BARK! BARK!'},
			{origin = 2, dialogue = 'HISSss...'},
		},
		[2] = {
			{origin = 2, dialogue = 'I dont mind Dandy, just wish he didnt let his pet rock in the run.'},
			{origin = 1, dialogue = 'Grr...'},
			{origin = 2, dialogue = 'Thats exactly why.'},
		}
	},

	['Pebble_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'Arf!'},
			{origin = 2, dialogue = 'Nope! I dont have any bones for you buddy!'},
			{origin = 1, dialogue = '...Bworf.'},
			{origin = 2, dialogue = 'No... Fossils are not for pet rocks to chew on.'},
			{origin = 1, dialogue = 'Grrr...'},
			{origin = 2, dialogue = 'Im telling Dandy.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Hey Pebble, youre good at sniffing out stuff, right?'},
			{origin = 1, dialogue = 'Bark arf!'},
			{origin = 2, dialogue = 'I might need some help finding a lost fossil to add to my collection.'},
			{origin = 1, dialogue = '...Bworf.'},
			{origin = 2, dialogue = 'You... you buried it..? Lets talk about this later..'},
		}
	},

	['Pebble_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = 'Arf!'},
			{origin = 2, dialogue = 'I HATE LOUD NOISES!!'},
			{origin = 1, dialogue = 'BARK!!!'},
			{origin = 2, dialogue = 'ONLY I CAN BE LOUD!!!'},
			{origin = 1, dialogue = '...Woof.'},
			{origin = 2, dialogue = 'I HATE QUIET NOISES, TOO!!'},
		},
	},

	['Pebble_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Bark! Bark!'},
			{origin = 2, dialogue = 'No, I dont have any treats for you.'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '... Pebble?'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '... I really gotta tell Dandy about your staring problem.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Youre a good pet rock when you want to be Pebble'},
			{origin = 2, dialogue = 'you going to be good this next blind?'},
			{origin = 1, dialogue = 'Bworf.'},
			{origin = 2, dialogue = 'Yeah?'},
			{origin = 1, dialogue = '...Bwoarf.'},
			{origin = 2, dialogue = '...Alright.'},
		}
	},

	['Pebble_Squirm'] = {
		[1] = {
			{origin = 2, dialogue = 'I thought about having a pet of my own once... I-I read on it some.'},
			{origin = 1, dialogue = 'Bark? Bark!'},
			{origin = 2, dialogue = 'I-I couldnt finish reading the book though, snf- sniffle- on account of- of-'},
			{origin = 1, dialogue = 'Bark! Arf!'},
			{origin = 2, dialogue = 'Snf... sniffle- sorry Pebble- I-I wont cry...'},
		},
	},

	['Pebble_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Goodness... whats the rock doing here?'},
			{origin = 1, dialogue = 'Grrr...'},
			{origin = 2, dialogue = 'Such terrible manners! Didnt Dandicus ever teach you good manners?'},
			{origin = 1, dialogue = 'Arf! Bark bark!'},
			{origin = 2, dialogue = '...I suppose not.'},
		},
	},

	['Pebble_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Bark ARF!'},
			{origin = 2, dialogue = 'Im honestly surprised youre not sitting with Dandy in his shop.'},
			{origin = 1, dialogue = 'ARF!! BARK!!'},
			{origin = 2, dialogue = 'Mostly with how much Ive seen him pamper you all the time-'},
			{origin = 1, dialogue = 'Grr...'},
			{origin = 2, dialogue = 'Ah! Right! Sorry! Im sure you want to help out! Right! Nice pet rock!'},
		},
	},

	['Pebble_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Arf!'},
			{origin = 2, dialogue = 'Youre such a cute rock!'},
			{origin = 1, dialogue = 'Bworf?'},
			{origin = 2, dialogue = 'Daawwww!!'},
		},
		[2] = {
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Pebble, why are you staring at me like that?'},
			{origin = 1, dialogue = '. . .'},
			{origin = 2, dialogue = 'Uhh... Okay puppy.'},
		}
	},

	['Pebble_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Arf!'},
			{origin = 2, dialogue = 'Pebble, ugh, I dont have time.'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Fine! Fine, Ill play fetch with you later! Happy?!'},
			{origin = 1, dialogue = 'Bwoof!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Pebble.'},
			{origin = 1, dialogue = 'Bwoof!'},
			{origin = 2, dialogue = 'No, really?'},
			{origin = 1, dialogue = 'Arf!'},
			{origin = 2, dialogue = 'Tell me about that later, thats actually so interesting.'},
		}
	},

	['Pebble_Yatta'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Pebble, do YOU want some CANDY?'},
			{origin = 1, dialogue = 'ARF! ARF!!'},
			{origin = 2, dialogue = 'WAIT, didnt Dandy say you cant have ANY candy?'},
			{origin = 1, dialogue = 'Grrr...'},
			{origin = 2, dialogue = 'OK, ok. Maybe just ONE piece.'},
			{origin = 1, dialogue = 'ARF!!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Grrr...'},
			{origin = 2, dialogue = 'HAHA!!! Dont.'},
			{origin = 1, dialogue = '...Woof?'},
		},
	},

	['Poppy_Razzle n Dazzle'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey there Poppy! Could I ask you something? (...)'},
			{origin = 1, dialogue = 'Hi Razzle n Dazzle! What did you wanna ask me?'},
			{origin = 2, dialogue = 'Would you like to come to our rehearsal later? (If you want...)'},
			{origin = 1, dialogue = 'Oh, what kind of play are you two rehearsing?'},
			{origin = 2, dialogue = 'Its a comedy play, with a mix of...! (Drama...)'},
			{origin = 1, dialogue = 'Ooh, sounds interesting!'},
		},
	},

	['Poppy_Rodger'] = {
		[1] = {
			{origin = 1, dialogue = 'Rodger!! Have you ever thought about changing your style?'},
			{origin = 2, dialogue = 'Excuse me?- Well, actually... I have thought of getting a monocle.'},
			{origin = 1, dialogue = 'Oh yeah! Then youd look even fancier!'},
			{origin = 2, dialogue = 'Hm... I suppose I would look spiffy!'},
		},
	},

	['Poppy_Rudie'] = {
		[1] = {
			{origin = 2, dialogue = 'Poppy! Poppy! Poppy! ITS CHRISTMAS!!!'},
			{origin = 1, dialogue = 'Huh?? NO WAY!'},
			{origin = 2, dialogue = 'Yes way.'},
			{origin = 1, dialogue = 'Woah. Thats crazy, I had no idea Rudie! Mostly since you say this every time I see you!'},
		},
	},

	['Poppy_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya Scraps!! Your claws are looking really shiny!'},
			{origin = 2, dialogue = 'Huh? really?'},
			{origin = 1, dialogue = 'We should paint them some time after this!'},
			{origin = 2, dialogue = 'Ooo I do like the sound of that! Hehe sure!'},
		},
	},

	['Poppy_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'I had one of the best dreams last night!'},
			{origin = 2, dialogue = 'Really? What was the dream about!'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Poppy..?'},
			{origin = 1, dialogue = 'Huh? OH! Sorry I didnt hear you!'},
			{origin = 2, dialogue = 'Nevermind... its okay, really...'},
		},
	},

	['Poppy_Shrimpo'] = {
		[1] = {
			{origin = 2, dialogue = 'I HATE YOUR BOW!!!'},
			{origin = 1, dialogue = 'Well, I like it!'},
			{origin = 2, dialogue = 'WHO ASKED?!'},
		},
	},

	['Poppy_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'SPROUT!!'},
			{origin = 2, dialogue = 'Poppy??? -Are you okay?'},
			{origin = 1, dialogue = 'Yep! The big question is... are you okay!'},
			{origin = 2, dialogue = 'Phew, yeah... Dont scare me like that though.'},
			{origin = 1, dialogue = 'Im sorry, it WILL happen again! Hehe!'},
		},
	},

	['Poppy_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya Squirm! I had a question! Do books have unique flavors?'},
			{origin = 2, dialogue = 'W-what...? Why are you asking...???'},
			{origin = 1, dialogue = 'I have to know! What if you have a favorite flavor of book? And I just had no idea!'},
			{origin = 2, dialogue = 'What would even be a flavor...? The genre of book...? The type of cover? The page count???'},
			{origin = 1, dialogue = 'Good point! But youre the one who would have that answer!'},
			{origin = 2, dialogue = 'I-I dont like this question! M-maybe ask Brightney, she has answers to things...'},
		},
	},

	['Poppy_Teagan'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya Teagan! Whens the next Tea party planned?'},
			{origin = 2, dialogue = 'Im not sure yet, but I can always make time for one if youd like!'},
			{origin = 1, dialogue = 'Yay!! Do you remember my favorite tea??'},
			{origin = 2, dialogue = 'Of course, Bubble Tea for you!'},
			{origin = 1, dialogue = 'OMG... you do remember.'},
		},
	},

	['Poppy_Tisha'] = {
		[1] = {
			{origin = 2, dialogue = 'Poppy, how good are you at cleaning?'},
			{origin = 1, dialogue = 'Im not the greatest, why do you ask?'},
			{origin = 2, dialogue = 'Well, bubbles are usually made out of soap!'},
			{origin = 1, dialogue = 'OOOH, and soap is clean!'},
			{origin = 2, dialogue = 'Exactly!'},
			{origin = 1, dialogue = 'Cool! Im still not good at cleaning, though!'},
		},
	},

	['Poppy_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Toodles, whats up?'},
			{origin = 2, dialogue = 'Not losing this ante, thats for sure!'},
			{origin = 1, dialogue = 'Ooh, youre right! Were going fine.'},
			{origin = 2, dialogue = 'Yeah, Im super brave though! Count on me alright?'},
			{origin = 1, dialogue = 'Hehe alright!'},
		},
	},

	['Poppy_Vee'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Poppy! You are our lucky winner today!'},
			{origin = 1, dialogue = 'Yippee! What do I win?'},
			{origin = 2, dialogue = 'A brand new car!'},
			{origin = 1, dialogue = 'Oh my goodness! Really!?!'},
			{origin = 2, dialogue = 'No, Poppy, does it look like we can have a car here?'},
			{origin = 1, dialogue = 'Oh yeah! I dont even know how to drive!'},
		},
	},

	['Poppy_Yatta'] = {
		[1] = {
			{origin = 2, dialogue = 'Ooooh! POPPY!'},
			{origin = 1, dialogue = 'Hii!! Whats up!'},
			{origin = 2, dialogue = 'DO you know how to do.. A BACKFLIP?'},
			{origin = 2, dialogue = 'Aw, no! But I wanna!!!'},
			{origin = 2, dialogue = 'Meet me, outside of my room, MIDNIGHT SHARP.'},
			{origin = 1, dialogue = 'Oh! OK!'},
		},
	},

	['Razzle n Dazzle_Rodger'] = {
		[1] = {
			{origin = 2, dialogue = 'You two could be great detectives!'},
			{origin = 1, dialogue = 'Really? (Is this a joke...?)'},
			{origin = 2, dialogue = 'No really! Youd have secondary opinions on cases!'},
			{origin = 1, dialogue = 'Ooh! (He likes acting... I cant stand it.)'},
			{origin = 2, dialogue = 'See? Already contrasting one another!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Whats up Rodger! (Hello...)'},
			{origin = 2, dialogue = 'Nothing is "up" right now, but hello you two!'},
			{origin = 1, dialogue = 'Working hard then? (Or hardly working...)'},
			{origin = 2, dialogue = 'Hah! Good one, but yes, working as always!'},
		},
	},

	['Razzle n Dazzle_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Scraps!! (Paper sibling...)'},
			{origin = 2, dialogue = 'Hey you two!! Doing good right?'},
			{origin = 1, dialogue = 'Couldnt be better!! (I dont know about that...)'},
		},
	},

	['Razzle n Dazzle_Shelly'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey do you two have favorite dinosaurs?'},
			{origin = 1, dialogue = 'I love the Stegosaurus! (...The long neck one.)'},
			{origin = 2, dialogue = 'Long neck? You mean one of the many Sauropods!'},
			{origin = 1, dialogue = 'Huh? (...Sure, whichever has the long neck.)'},
		},
	},

	['Razzle n Dazzle_Sprout'] = {
		[1] = {
			{origin = 2, dialogue = 'Razzle, Dazzle, need anything?'},
			{origin = 1, dialogue = 'Not really? (...Why do you ask?)'},
			{origin = 2, dialogue = 'Well, I just know you both get along with Astro...'},
			{origin = 1, dialogue = 'Yeah? (...Were all friends.)'},
			{origin = 2, dialogue = 'AND... I respect you guys, just want to make sure youre both fine.'},
			{origin = 1, dialogue = 'Well thats kind! (...Hm.)'},
		},
	},

	['Razzle n Dazzle_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = 'Squirm, how are you? (Hopefully, youre feeling better...)'},
			{origin = 2, dialogue = 'Dazzle! ...Razzle- uhm, Im ok... did you both want to maybe chat sometime...? Catch up?'},
			{origin = 1, dialogue = 'Im not sure- (We should make some time for that...)'},
			{origin = 2, dialogue = 'I-I dont get to see you both as often since I stopped going to book club sessions...'},
			{origin = 1, dialogue = 'If Dazzle would like Im sure we can find some time, right? (...Right)'},
			{origin = 2, dialogue = 'Thank you! ...snf- Thank you...'},
		},
		[2] = {
			{origin = 2, dialogue = 'W-what if... WHAT IF THE NEXT BLIND IS WORSE!'},
			{origin = 2, dialogue = 'W-what if its THE WORST BLIND EVER!?'},
			{origin = 1, dialogue = 'Woah woah- (Squirm... you may be overthinking things some... Breathe.)'},
			{origin = 2, dialogue = 'B-BUT... WHAT IF!?'},
			{origin = 1, dialogue = 'Or...This could be great knowing we have each other!'},
			{origin = 1, dialogue = '(Thats right... See Squirm, youre with us.)'},
			{origin = 2, dialogue = '....Youre both right... Having you around does make this a-a bit better.'},
		},
	},

	['Razzle n Dazzle_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Razzle and Dazzle, the twins! How are you two today?'},
			{origin = 1, dialogue = 'Were doing alright! (Pretty good, all things considered...)'},
			{origin = 2, dialogue = 'Will you two be attending my tea party later?'},
			{origin = 1, dialogue = 'Wish we could! (We have book club with Brightney at that time...)'},
			{origin = 2, dialogue = 'Oh, thats too bad then. You both have fun!'},
			{origin = 1, dialogue = 'Definetly will have fun! (...Razzle, you always fall asleep a couple minutes into reading-)'},
		},
	},

	['Razzle n Dazzle_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Wow Tisha, youre hard at work! (Maybe overworking even...)'},
			{origin = 2, dialogue = 'Dont you worry a thing, Dazzle! Someone has to keep things clean!'},
			{origin = 1, dialogue = 'That is true! (Please take breaks...'},
		},
	},

	['Razzle n Dazzle_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'Hi you both! What are you guys doing?'},
			{origin = 1, dialogue = 'Well were waiting in the shop right now! (...That is true.)'},
			{origin = 2, dialogue = 'Aw cmon thats a little bit of a boring answer!'},
			{origin = 1, dialogue = 'But its the truth. (...Would you rather that we lie?)'},
			{origin = 2, dialogue = 'Hmmm...Maybe?'},
		},
	},

	['Razzle n Dazzle_Vee'] = {
		[1] = {
			{origin = 2, dialogue = 'You know Razzle you dont need to keep sending me letters.'},
			{origin = 1, dialogue = 'I dont? (...Ive been telling him this.)'},
			{origin = 2, dialogue = 'Right, you could just... come talk to me?'},
			{origin = 1, dialogue = 'REALLY??? (Oh uh, Vee, are you sure about that...?)'},
			{origin = 2, dialogue = 'Yeah, just swing by my room and knock of course.'},
			{origin = 1, dialogue = 'FOR SURE!! YES MAAM!!(...Well visit a reasonable amount.)'},
		},
		[2] = {
			{origin = 1, dialogue = 'VEE!! HELLO!(...Hey Vee.)'},
			{origin = 2, dialogue = 'Hello, how are you both doing?'},
			{origin = 1, dialogue = 'AMAZING!! Right Dazzle!? (...Yeah, hes a fan.)'},
			{origin = 2, dialogue = 'I can tell.'},
		},
	},

	['Razzle n Dazzle_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'I wish we could do acrobatics like you! (Or parties...)'},
			{origin = 2, dialogue = 'Well Im sure you could AT LEAST, throw a party!!'},
			{origin = 1, dialogue = 'Oh no, Dazzle doesnt really like parties. (Too many people...)'},
			{origin = 2, dialogue = 'But WHAT about the THEATRE?! Your PLAYS!? THE ACTING!!!'},
			{origin = 1, dialogue = 'Its simple! (My mind, it focuses to the script lines... It helps...)'},
		},
	},

	['Ribecca_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'Youre smiling over really wide....'},
			{origin = 2, dialogue = 'I cant help it! Youre a skeleton! Its so FASCINATING!'},
			{origin = 1, dialogue = 'Huh, thanks...? Is that a compliment I cant really tell...'},
			{origin = 2, dialogue = 'Of course! A compliment I promise! Ive studied all sorts of extinct species bone structures.'},
			{origin = 1, dialogue = 'Well thankfully Im not like extinct... I think??'},
		},
	},

	['Ribecca_Soulvester'] = {
		[1] = {
			{origin = 2, dialogue = 'Ribecca dost thou need any knightly assistance?'},
			{origin = 1, dialogue = 'Nah, I dont have any uh "quests" for you or anything...'},
			{origin = 2, dialogue = 'I see, well even if it is something as simple as fetching supplies, know Id be here!'},
			{origin = 1, dialogue = 'Alright! Maybe some time later when we get some new fabrics.'},
		},
		[2] = {
			{origin = 1, dialogue = 'Hello Mister knight in shining armor, you know that you got some scratches on that armor?'},
			{origin = 2, dialogue = 'Well Id consider simply proof of my many expeditions in Gardenview.'},
			{origin = 1, dialogue = 'You know I could always help fix that armor up for you pal.'},
			{origin = 2, dialogue = 'Hark Ribecca, for I have no need...I am most comfortable within the suit of armor.'},
			{origin = 1, dialogue = 'Itd only be for a moment Soulvester.'},
			{origin = 2, dialogue = 'I refuse.'},
		},
	},

	['Rodger_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Scraps, do you think you could lend me some extra pens?'},
			{origin = 2, dialogue = 'What? Did you already run out of the last batch I gave you?'},
			{origin = 1, dialogue = 'Yes, I had plenty to write! I also need some red yarn.'},
			{origin = 2, dialogue = 'Red yarn? Dont tell me youre stringing the corkboard again.'},
			{origin = 1, dialogue = 'Im stringing the corkboard again!'},
		},
	},

	['Rodger_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'Miss Fossilian was it?'},
			{origin = 2, dialogue = 'Yes! How can I help you Rodger?'},
			{origin = 1, dialogue = 'Interested in answering some questions for my case?'},
			{origin = 2, dialogue = 'You want answers... from me?'},
			{origin = 1, dialogue = 'Of course! Youre part of the "main" casting... are you not?'},
			{origin = 2, dialogue = 'I AM! I AM! Ill catch up with you after this!!'},
		},
	},

	['Rodger_Shrimpo'] = {
		[1] = {
			{origin = 1, dialogue = 'Shrimpo, is there a reason you are so very spiteful?'},
			{origin = 2, dialogue = 'WHAT DID YOU CALL ME?!'},
			{origin = 1, dialogue = 'Spiteful?'},
			{origin = 2, dialogue = 'IM TAKING OFFENSE TO THAT!!!'},
			{origin = 1, dialogue = 'Right... Lets try this interview later.'},
		},
	},

	['Rodger_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Sprout, were you interested in an interview?'},
			{origin = 2, dialogue = 'Nope, and dont go asking Cosmo about me either.'},
			{origin = 1, dialogue = 'Ah... I see.'},
			{origin = 2, dialogue = 'Best you keep to yourself Rodger, thats safer.'},
			{origin = 1, dialogue = 'It may be safer, but uncovering truths is more rewarding!'},
			{origin = 2, dialogue = '...Sure Rodger, Sure.'},
		},
	},

	['Rodger_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = 'You wouldnt happen to have seen anything suspicious recently... have you?'},
			{origin = 2, dialogue = 'I-I have! IT WAS AWFUL! I... I dropped a pen I was using a-and it rolled under a table...'},
			{origin = 1, dialogue = 'Im not sure if thats something Id ever label as "suspicious" ...But continue.'},
			{origin = 2, dialogue = 'N-NO WAIT! But... but the pen when I went to grab it, WAS GONE-!!!'},
			{origin = 1, dialogue = '...Last time you mentioned something disappeared, we found it within ten minutes of searching.'},
			{origin = 2, dialogue = 'BUT RODGER W-WHAT IF THIS TIME SOMETHING REALLY DID DISAPPEAR!!'},
		},
	},

	['Rodger_Teagan'] = {
		[1] = {
			{origin = 1, dialogue = 'Teagan I must say, how do you keep your fluffy boa so clean?'},
			{origin = 2, dialogue = 'Ah! I make sure no Ichor gets on it of course!'},
			{origin = 1, dialogue = 'You must be very good at dodging then!'},
		},
	},

	['Rodger_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Tisha, think you could find the time to help me organize some files later?'},
			{origin = 2, dialogue = 'Ah record keeping some new data?'},
			{origin = 1, dialogue = 'Yes, I trust only your eyes to help and keep things silent.'},
			{origin = 2, dialogue = 'I know that one isnt true, you have a few trusted Toons in your corner.'},
			{origin = 1, dialogue = 'Yes, well, some of my trusted friends dont know how to organize well.'},
		},
	},

	['Rodger_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'If it isnt the bravest little detective!'},
			{origin = 2, dialogue = 'Hey Rodger!! Am I able to help in your next case??'},
			{origin = 1, dialogue = 'Ah, no, not exactly but maybe the next, next one!'},
			{origin = 2, dialogue = 'Youve said that like... a bajillion times now.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Rodger, tell me about your latest cases! Please, please, please!!!'},
			{origin = 1, dialogue = 'Oh well, Im unsure about doing that.'},
			{origin = 2, dialogue = 'Aww, cmon!! Pleaaaase!!!'},
			{origin = 1, dialogue = 'Hmm, maybe after we finish here, then ask me again.'},
		}
	},

	['Rodger_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Vee your knowledge could be very useful for-'},
			{origin = 2, dialogue = 'I wont become your tool Rodger.'},
			{origin = 1, dialogue = 'Thats not what Im asking of you!'},
			{origin = 2, dialogue = 'Sounds like it is, Im much more than my technology.'},
			{origin = 1, dialogue = 'Apologies if you feel I was implying otherwise!'},
			{origin = 2, dialogue = 'Sure Rodger, sure.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Rodger, do me a favor.'},
			{origin = 1, dialogue = 'Thats dependent on what you plan to ask of me!'},
			{origin = 2, dialogue = 'Stop trying to ask Astro questions.'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Will you?'},
			{origin = 1, dialogue = 'I... cant promise such.'},
		},
	},

	['Rodger_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Yatta! How are your friends doing?'},
			{origin = 2, dialogue = 'WHICH ONES???'},
			{origin = 1, dialogue = 'The circus troupe youre always seen with...?'},
			{origin = 2, dialogue = 'OH YEAH!! What about them.'},
			{origin = 1, dialogue = 'Any odd ongoings with you lot?'},
			{origin = 2, dialogue = 'HAHAHAha... Im not telling you.'},
		},
	},

	['Rudie_Scraps'] = {
		[1] = {
			{origin = 1, dialogue = 'Happy holidays!'},
			{origin = 2, dialogue = 'Yeah?'},
			{origin = 1, dialogue = 'YUP! HAPPY HOLIDAYS!!'},
		},
	},

	['Rudie_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Are you on the nice list?'},
			{origin = 2, dialogue = 'Probably!! What about you?'},
			{origin = 1, dialogue = 'Oh for sure!'},
			{origin = 2, dialogue = 'Yay!! Were both nice!'},
			{origin = 1, dialogue = 'That we are! Yay! Hooray! All is perfect! Ahaha!'},
		},
	},

	['Scraps_Shelly'] = {
		[1] = {
			{origin = 1, dialogue = 'Sooo... Sabertooths? Were they really that cool?'},
			{origin = 2, dialogue = 'They were super cool! Their canine teeth were seven inches!'},
			{origin = 1, dialogue = 'Whoah, that is kind of cool!'},
			{origin = 2, dialogue = 'Uhuh! And their mouth could open a hundred-thirty degrees!'},
			{origin = 1, dialogue = 'Also... kind of scary, then.'},
		},
	},

	['Scraps_Shrimpo'] = {
		[1] = {
			{origin = 2, dialogue = 'YOURE AWFUL, I LIKE DOGS MORE THAN CATS!! AND I HATE DOGS!!!'},
			{origin = 1, dialogue = 'Im not even really a cat technically...'},
			{origin = 2, dialogue = 'YOU HISS!! YOURE A CAT!!!'},
			{origin = 1, dialogue = 'Im not taking this from a literal shrimp.'},
		},
		[2] = {
			{origin = 1, dialogue = 'I dont like your tone Shrimpo!'},
			{origin = 2, dialogue = 'I DONT LIKE YOUR EAR, HORN, THINGYS!!'},
			{origin = 1, dialogue = 'You. Take. That. Back.'},
			{origin = 2, dialogue = 'SHRIMPO NEVER APOLOGIZES!!!'},
			{origin = 1, dialogue = 'HISsss!'},
		},
	},

	['Scraps_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Sprout! Buddy! Pal! Best friend!'},
			{origin = 2, dialogue = 'Scraps, we are not best friends-'},
			{origin = 1, dialogue = 'Yeah well... I meant to just ask if you could answer a question?'},
			{origin = 2, dialogue = 'Its fine, what is it?'},
			{origin = 1, dialogue = 'I ran out of red paint, do you think ketchup can substitute-'},
			{origin = 2, dialogue = 'Scraps no, before you even finish that sentence... do NOT use ketchup.'},
		},
	},

	['Scraps_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = 'Squirm... I know sometimes Gigi takes a few of my paints, but now my sketchbook is gone.'},
			{origin = 2, dialogue = '. . . O-oh no...'},
			{origin = 1, dialogue = 'Squirm.'},
			{origin = 2, dialogue = 'OOOOH NOOOO....!!!!'},
			{origin = 1, dialogue = 'SQUIRM- DID YOU EAT MY SKETCHBOOK?! SQUIRM!!! -WHY???'},
			{origin = 2, dialogue = 'Y-you know I cant help it! ...I-IM SORRY!!!'},
		},
	},

	['Scraps_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Scraps, how good are you at painting?'},
			{origin = 1, dialogue = 'I think Im pretty good at it! Why do you ask?'},
			{origin = 2, dialogue = 'Would you be interested in painting a couple of my teacups? They could use some variety.'},
			{origin = 1, dialogue = 'Ohh, I see! Yeah, I can help you with that, no worries!'},
			{origin = 2, dialogue = 'Splendid! Ill come find you later.'},
		},
	},

	['Scraps_Tisha'] = {
		[1] = {
			{origin = 2, dialogue = 'Scraps, did you clean up your room from all the yarn?'},
			{origin = 1, dialogue = 'Huh?? Oh... uh nooo..'},
			{origin = 2, dialogue = 'What! But its a mess, didnt you say you would?'},
			{origin = 1, dialogue = 'Well, I changed my mind! I like the yarn. Even if I trip some.'},
			{origin = 2, dialogue = 'Oh goodness. Well talk later on it.'},
		},
	},

	['Scraps_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'Your cup on your tail is neat!'},
			{origin = 1, dialogue = 'Oh! Thanks Toodles.'},
			{origin = 2, dialogue = 'Yeah!! I dunno about the dress though.'},
			{origin = 1, dialogue = 'Wha- wow, kids can be harsh.'},
		},
	},

	['Scraps_Vee'] = {
		[1] = {
			{origin = 2, dialogue = 'If it isnt Scraps! One of the luckiest Toons here!!'},
			{origin = 1, dialogue = 'I dont know if Id call myself lucky...? But thanks.'},
			{origin = 2, dialogue = 'Thats great! Now answer me this winning question!'},
			{origin = 1, dialogue = 'Go on?'},
			{origin = 2, dialogue = 'Who was the contestant who won ALL my prizes, EVERY time, FROM LUCKY GUESSES...?'},
			{origin = 1, dialogue = 'Uhm... me?'},
			{origin = 2, dialogue = 'Y e a h.'},
		},
		[2] = {
			{origin = 1, dialogue = 'Hey Vee... Youre not still mad at me for winning all your game show prizes right?'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Vee..?'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'Ill take that as a yes.'},
		}
	},

	['Scraps_Yatta'] = {
		[1] = {
			{origin = 2, dialogue = 'MEOW MEOW MEOW!!!'},
			{origin = 1, dialogue = 'Are you... making fun of me?'},
			{origin = 2, dialogue = 'Oh! Haha! NO! I love cats!'},
			{origin = 1, dialogue = 'Well, Im not really a cat, just sort of... cat-like?'},
			{origin = 2, dialogue = 'YEAH! Youre a craft! A PAPER CRAFT!!'},
		},
	},

	['Shelly_Shrimpo'] = {
		[1] = {
			{origin = 2, dialogue = 'I HATE YOU!!!'},
			{origin = 1, dialogue = 'Me?'},
			{origin = 2, dialogue = 'EVERYONE!!!'},
			{origin = 1, dialogue = '...Well, I guess thats better than just me?'},
		},
	},

	['Shelly_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'Sprout! Have I told you about some prehistoric plants?'},
			{origin = 2, dialogue = 'Yeah, a couple times actually.'},
			{origin = 1, dialogue = 'Oh, well, uhm... Did you want to hear more???'},
			{origin = 2, dialogue = '...Sure, as long as Cosmo can join us later.'},
			{origin = 1, dialogue = 'DEAL!! You two are going to looove the Cycadophyta!'},
		},
		[2] = {
			{origin = 2, dialogue = 'I think I tore my scarf a little.'},
			{origin = 1, dialogue = 'Oh I have a friend whos teaching me some about sewing!'},
			{origin = 2, dialogue = '... You sew?'},
			{origin = 1, dialogue = 'Well its a little side hobby!'},
			{origin = 2, dialogue = 'You know Cosmo is teaching Boxten how to bake.'},
			{origin = 1, dialogue = 'Ooo! maybe I should ask him for some tips so I can have more hobbies!'},
		}
	},

	['Shelly_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = 'Phew... feel like I could have done a bit better-'},
			{origin = 2, dialogue = 'Me too... I-I did awful... I-IM SO USELESS!!! WAAAAAH!!!'},
			{origin = 1, dialogue = '...Im not sure if Id go as far as to say that.'},
			{origin = 2, dialogue = 'Y-youre right... I could be doing worse... -OH NO, I COULD BE DOING WORSE!!!'},
			{origin = 1, dialogue = '...Please dont cry! Please, please, please dont cry!'},
			{origin = 2, dialogue = 'OH NOOOO, I AM MAKING THINGS WORSE! WAAAAH!!!'},
		},
	},

	['Shelly_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Shelly, how have you been?'},
			{origin = 1, dialogue = 'Ah! Doing good... well sorta-ish!'},
			{origin = 2, dialogue = 'Sorta-ish? Why dont we have tea after this.'},
			{origin = 1, dialogue = 'That would be nice yeah... where?'},
			{origin = 2, dialogue = 'My room after we finish here, I expect you on time.'},
			{origin = 1, dialogue = 'Got it! You can count on me!'},
		},
	},

	['Shelly_Tisha'] = {
		[1] = {
			{origin = 2, dialogue = 'Heya Shelly, you alright?'},
			{origin = 1, dialogue = 'Oh! Yeah, yeah, just thinking!'},
			{origin = 2, dialogue = 'Ah, just know Ive got your back alright?'},
			{origin = 1, dialogue = 'Heh, of course...! And Ive got you! Lets do this!'},
		},
		[2] = {
			{origin = 1, dialogue = 'Heya Tisha! Think you could help me again?'},
			{origin = 2, dialogue = 'Uh huh! Like cleaning up a fossil right?'},
			{origin = 1, dialogue = 'Yup! After this I got a few to put together.'},
			{origin = 2, dialogue = 'Sounds fun! Cant wait Teehee!'},
		},
	},

	['Shelly_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Toodles! Interested in learning about some powerful carnivores of the prehistoric?'},
			{origin = 2, dialogue = '...Are they like scary powerful?'},
			{origin = 1, dialogue = 'Well some of them were so powerful they could bite a tree in half!'},
			{origin = 2, dialogue = '-EEK!!'},
			{origin = 1, dialogue = 'I-I mean... uh... No need to be scared!! Everythings okay!!'},
		},
	},

	['Shelly_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Want to hear some dinosaur facts?'},
			{origin = 2, dialogue = 'I know them all.'},
			{origin = 1, dialogue = 'What...?'},
			{origin = 2, dialogue = 'Theyre programmed in already Shelly, I know them all.'},
			{origin = 1, dialogue = 'Ah... right, silly me!'},
		},
		[2] = {
			{origin = 2, dialogue = 'So, are you busy after this?'},
			{origin = 1, dialogue = 'Huh...? OH! Youre asking me!!'},
			{origin = 2, dialogue = '...Yes, Im talking to you.'},
			{origin = 1, dialogue = 'Nope! Not busy at all! What do you need?'},
			{origin = 2, dialogue = 'Just help moving around supplies.'},
			{origin = 1, dialogue = 'Oh... uhm, right... of course.'},
		},
	},

	['Shelly_Yatta'] = {
		[1] = {
			{origin = 2, dialogue = 'SHELLY!'},
			{origin = 1, dialogue = 'W-what??? Huh? -Me?'},
			{origin = 2, dialogue = 'Yes YOU! Tisha said you learned sewing?'},
			{origin = 1, dialogue = 'Yeah... YEAH! Are you interested!?'},
			{origin = 2, dialogue = 'YEAH!! YEAH!! SHOW ME LATER!!'},
			{origin = 1, dialogue = 'OH YEAH!! I mean like- of course! Perfect! Later!'},
		},
		[2] = {
			{origin = 1, dialogue = '...So you do acrobatics Yatta?'},
			{origin = 2, dialogue = 'BACKFLIPS, FRONTFLIPS, SUPER COOL FLIPS!!!'},
			{origin = 1, dialogue = 'Right.. youre like super agile then.'},
			{origin = 2, dialogue = 'SOMETIMES, EVERY SO OFTEN- I travel through Gardenviews vent systems!'},
			{origin = 1, dialogue = 'Oh.'},
		},
	},

	['Shrimpo_Sprout'] = {
		[1] = {
			{origin = 1, dialogue = 'I HATE YOUR COOKING!!!'},
			{origin = 2, dialogue = 'And yet you still eat it! Interesting isnt it.'},
			{origin = 1, dialogue = 'WELL I HATE YOUR BEST FRIENDS COoking... uh.'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = 'Dont.'},
		},
		[2] = {
			{origin = 2, dialogue = '...Really wishing this was over with sooner than later.'},
			{origin = 1, dialogue = 'SHRIMPO DISAGREES.'},
			{origin = 2, dialogue = 'Yeah well- Shrimpo disagrees with everyone and hates everything!'},
			{origin = 1, dialogue = 'I HATE THAT YOURE PUTTING JUDGMENT ON ME, SHRIMPO.'},
			{origin = 2, dialogue = 'Is it really judgment? Feels like a fact, or the truth!'},
			{origin = 1, dialogue = 'I HATE YOU!!! I HATE YOU, I HATE YOU, I HATE YOU GRAAAAH!'},
		},
	},

	['Shrimpo_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = 'I HATE WORMS WITH LEGS!'},
			{origin = 2, dialogue = 'WAHHHH! Shrimpo is right-snf'},
			{origin = 1, dialogue = 'I HATE THE WAY YOU CRY!'},
		},
		[2] = {
			{origin = 1, dialogue = 'I HATE YOU!! YOU HAVE TOO MANY LEGS!! WORMS DONT HAVE LEGS!!'},
			{origin = 2, dialogue = '...Snf- sniffle- SHRIMPOS RIGHT!!! WAAAAAH!!!'},
			{origin = 1, dialogue = 'I HATE HOW LOUD YOU CRY!!'},
		},
	},

	['Shrimpo_Teagan'] = {
		[1] = {
			{origin = 1, dialogue = 'I HATE YOUR DRESS!'},
			{origin = 2, dialogue = 'You know... Glisten said he liked it.'},
			{origin = 1, dialogue = 'I HATE GLISTEN, AND YOUR DRESS!'},
			{origin = 2, dialogue = 'What else do you hate...?'},
			{origin = 1, dialogue = 'I HATE THAT YOU ASKED WHAT I HATE.'},
		},
	},

	['Shrimpo_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'I HATE YOU, YOURE TOO CLEAN!!!'},
			{origin = 2, dialogue = 'No such thing as "too clean" Shrimpo!'},
			{origin = 1, dialogue = 'THERE IS NOW!!! AND ITS YOU!! YOURE THE TOO CLEAN.'},
			{origin = 2, dialogue = 'That sentence doesnt make sense...'},
			{origin = 1, dialogue = 'YOU DONT MAKE SENSE!!!'},
		},
	},

	['Shrimpo_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'I HATE ANTES!!!'},
			{origin = 2, dialogue = 'Actually... they are kinda scary if you think about it-'},
			{origin = 1, dialogue = 'WERE GONNA LOSE!!!'},
			{origin = 2, dialogue = 'EEK!'},
		},
	},

	['Shrimpo_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'VEE!'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'I HATE TELEVISION!'},
			{origin = 2, dialogue = 'You done?'},
			{origin = 1, dialogue = 'I HATE NOT HAVING THE LAST WORD!'},
		},
	},

	['Shrimpo_Yatta'] = {
		[1] = {
			{origin = 2, dialogue = 'HAHAHaha...I dont like you.'},
			{origin = 1, dialogue = 'I HATE YOU!!'},
			{origin = 2, dialogue = 'HATE, is such a strong word!!'},
			{origin = 1, dialogue = 'ARE YOU QUESTIONING MY STRENGTH!?'},
			{origin = 2, dialogue = 'HAHahaha. I dont NEED to question it.'},
			{origin = 1, dialogue = '...I HATE BEING CHALLENGED BY SOMEONE TALLER THAN ME!!!'},
		},
	},

	['Sprout_Squirm'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Squirm... Heard youre still having a couple small issues going on?'},
			{origin = 2, dialogue = 'W-WHO TOLD YOU!?'},
			{origin = 1, dialogue = 'It doesnt matter who told me. Did you need any help at all...?'},
			{origin = 2, dialogue = 'Snf... sniffle- M-maybe a little...'},
			{origin = 1, dialogue = 'Alright, lets get you some apple pie after this, does that sound good...?'},
			{origin = 2, dialogue = '...Mhm thats my favorite.'},
		},
	},

	['Sprout_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'Sprout, will you be joining me for tea at some point?'},
			{origin = 1, dialogue = 'No.'},
			{origin = 2, dialogue = '-Cosmo will be there.'},
			{origin = 1, dialogue = '...Ill consider.'},
		},
	},

	['Sprout_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Tisha can you clean the-'},
			{origin = 2, dialogue = 'Nope.'},
			{origin = 1, dialogue = 'Tisha... Tisha please, the-'},
			{origin = 2, dialogue = 'Sprout, this would be the fourth time I clean the kitchen this week.'},
		},
	},

	['Sprout_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Heya kiddo, holding up alright?'},
			{origin = 2, dialogue = 'Mhm...'},
			{origin = 1, dialogue = 'If anything scares you, know you can come find me.'},
			{origin = 2, dialogue = 'Okay! I know!'},
			{origin = 1, dialogue = 'Ill lift you up where no scary thing could ever get to you!'},
			{origin = 2, dialogue = 'Hehehe- I get it I get it!!!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Sprout...?'},
			{origin = 1, dialogue = 'Toodles?'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'Did you need something kiddo?'},
			{origin = 2, dialogue = 'Uh, I just wanted to make sure you were still there.'},
			{origin = 1, dialogue = 'Well, Im still here with you haha, not zoning out.'},
		}
	},

	['Sprout_Vee'] = {
		[1] = {
			{origin = 2, dialogue = 'Hey Berry-boy.'},
			{origin = 1, dialogue = 'Youre still calling me that?!'},
			{origin = 2, dialogue = 'Youre a berry, youre a boy.'},
			{origin = 1, dialogue = 'Alright Outdated-tech.'},
			{origin = 2, dialogue = '...-Sheesh.'},
			{origin = 1, dialogue = 'Sorry, that one was probably a bit far.'},
		},
		[2] = {
			{origin = 1, dialogue = 'You still arguing with Dandy?'},
			{origin = 2, dialogue = 'I try to, but he just walks away when I approach most the time.'},
			{origin = 1, dialogue = 'Yeah that sounds about right, he does the same to me.'},
			{origin = 2, dialogue = 'Yeah but hell talk with-'},
			{origin = 1, dialogue = 'Vee. I know.'},
			{origin = 2, dialogue = 'Whatever, well chat more on it later if you want.'},
		}
	},

	['Sprout_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Yatta... you really have to calm down with how much candy you eat.'},
			{origin = 2, dialogue = 'WHY!?'},
			{origin = 1, dialogue = 'Its a bit concerning honestly.'},
			{origin = 2, dialogue = 'WHAT? ME?? CONCERNING???'},
			{origin = 1, dialogue = 'Uh, yeah, you concern me like almost always.'},
			{origin = 2, dialogue = 'HAHA-! I get that A LOT MORE than youd think!'},
		},
	},

	['Squirm_Teagan'] = {
		[1] = {
			{origin = 2, dialogue = 'I was looking for a book I was reading, a mystery novel... but recently my book has gone missing.'},
			{origin = 1, dialogue = '...Oh.'},
			{origin = 2, dialogue = 'Now, Im not one to accuse others ever, especially without any prior evidence...'},
			{origin = 1, dialogue = '...Oh...no...'},
			{origin = 2, dialogue = 'Squirm, did you eat my book?'},
			{origin = 1, dialogue = '-It WAS me! Im sorry... I-I really didnt mean to... Ill try and it make it up to you!!'},
		},
	},

	['Squirm_Tisha'] = {
		[1] = {
			{origin = 2, dialogue = 'Squirm, next time you decide to have a snack, could you pick up the mess of paper?'},
			{origin = 1, dialogue = 'W-what if someone left those... Scraps draws... Brusha uhm... also draws...'},
			{origin = 2, dialogue = 'They had bite marks out of them.'},
			{origin = 1, dialogue = '...Snf- sniffle-'},
			{origin = 2, dialogue = 'Dont cry... just, pick up the paper next time.'},
		},
	},

	['Squirm_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'Do you know how to dance??'},
			{origin = 1, dialogue = 'Not really... I-it would be difficult with four legs Id guess...'},
			{origin = 2, dialogue = 'Youd guess??? SO YOU NEVER TRIED!'},
			{origin = 1, dialogue = 'Sniffle- ...Noooo.'},
			{origin = 2, dialogue = 'You should try!! Dancing is super fun!'},
			{origin = 1, dialogue = 'I-Id rather not...I could get hurt! And it could be NOT fun! And thatd be awful...'},
		},
	},

	['Squirm_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Vee... are you a-alright?'},
			{origin = 2, dialogue = 'Why do you ask?'},
			{origin = 1, dialogue = 'I was told to check in on you... S-something about your batteries? Or was it the microphone?'},
			{origin = 2, dialogue = 'Well Im doing great. Better than ever. Im actually at my most optimal right now!'},
			{origin = 1, dialogue = 'Oh... really? I-I didnt know...'},
			{origin = 2, dialogue = 'Yup, you had no idea. Im at the best point I could ever perform at, no need to question that.'},
		},
	},

	['Squirm_Yatta'] = {
		[1] = {
			{origin = 2, dialogue = 'BOOK EATER!! You should come watch my acrobat tricks!! Theyre SO entertaining!'},
			{origin = 1, dialogue = 'Snf... sniffle-'},
			{origin = 2, dialogue = 'HEY! ...Why are you going to cry? -Dont cry!! Acrobats make people smile!'},
			{origin = 1, dialogue = 'Youuuu called me book eateeer....SNIFFLE-'},
			{origin = 2, dialogue = 'You dont like that?? OOPS- Youre not "book eater" then!! Youre uh- uh- AWESOME WORM!'},
			{origin = 1, dialogue = 'snif-...I-I like that better...-I guess I can come watch some tricks...'},
		},
	},

	['Teagan_Tisha'] = {
		[1] = {
			{origin = 1, dialogue = 'Tisha, would you like some tea later?'},
			{origin = 2, dialogue = 'As always!'},
			{origin = 1, dialogue = 'Of course, youre always so punctual!'},
			{origin = 2, dialogue = 'Oh I try to be!'},
		},
		[2] = {
			{origin = 2, dialogue = 'So... how have your tea party sessions with her been?'},
			{origin = 1, dialogue = 'Whos her- OH, right, yes not much progress but shes trying.'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = 'I promise she really is.'},
			{origin = 2, dialogue = 'Right... Thanks Teagan.'},
		},
	},

	['Teagan_Toodles'] = {
		[1] = {
			{origin = 2, dialogue = 'Teagan... are we going to have a tea party later?'},
			{origin = 1, dialogue = 'For you? Of course!'},
			{origin = 2, dialogue = 'YAY!'},
			{origin = 1, dialogue = 'Haha! Settle down now, we have to focus!'},
		},
	},

	['Teagan_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Vee you could try to be a tad kinder.'},
			{origin = 2, dialogue = 'Kinder? Youre acting like Im rude or something.'},
			{origin = 1, dialogue = 'Well... sometimes you come off a bit, how do I put it-'},
			{origin = 2, dialogue = '...'},
			{origin = 1, dialogue = '-A bit harsh?'},
			{origin = 2, dialogue = '...I dont think so.'},
		},
		[2] = {
			{origin = 2, dialogue = 'Teagan.'},
			{origin = 1, dialogue = 'Vee?'},
			{origin = 2, dialogue = 'Im trying to start conversation, but honestly, I dont care about tea.'},
			{origin = 1, dialogue = 'I could assume why... Does that mean you dislike me?'},
			{origin = 2, dialogue = 'No, of course not, youre a whole toon, not some regular teacup.'},
		},
	},

	['Teagan_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Yatta maybe its time you relax with a bit of tea...?'},
			{origin = 2, dialogue = 'I am NOT going to one of your tea parties!'},
			{origin = 1, dialogue = 'But dont you love parties...?'},
			{origin = 2, dialogue = 'NOT WHEN THE PARTY IS SITTING! -Cant, keep, STILL!!!'},
			{origin = 1, dialogue = 'Ah, I understand... maybe we put together a different party?'},
			{origin = 2, dialogue = 'YES, YES, YEEEEES!! That Ill consider!'},
		},
	},

	['Tisha_Toodles'] = {
		[1] = {
			{origin = 1, dialogue = 'Toodles, hows your little adventures with Rodger?'},
			{origin = 2, dialogue = 'Theyre not little adventures first off!! Theyre BIG adventures.'},
			{origin = 1, dialogue = 'Oh! My mistake, how are your... BIG adventures with Rodger?'},
			{origin = 2, dialogue = 'He uh... doesnt take me on a lot of them.'},
			{origin = 1, dialogue = 'Well thats just because he cares for your safety.'},
			{origin = 2, dialogue = 'Yeah, yeah, I get it! Safety! And being safe! Bleh...!'},
		},
	},

	['Tisha_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Vee.'},
			{origin = 2, dialogue = 'Tisha.'},
			{origin = 1, dialogue = '...'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'Hmph!'},
		},
		[2] = {
			{origin = 2, dialogue = 'Tisha, any reason youre not talking with me?'},
			{origin = 1, dialogue = 'I have my reasons Vee.'},
			{origin = 2, dialogue = 'Wow, so descriptive.'},
			{origin = 1, dialogue = 'I just think, you dont appreciate certain things here in Gardenview!'},
			{origin = 2, dialogue = 'Still not very descriptive!'},
			{origin = 1, dialogue = 'UGH! Forget it-!'},
		},
	},

	['Tisha_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Yatta, please... pick up after yourself with the candy!'},
			{origin = 2, dialogue = 'I CANT CARRY IT ALL!! Trust me, I would if I COULD!!!'},
			{origin = 1, dialogue = 'Yatta, PLEASE.'},
			{origin = 2, dialogue = 'I DONT KNOW WHAT TO TELL YOU!!!'},
		},
		[2] = {
			{origin = 2, dialogue = 'TISHA!'},
			{origin = 1, dialogue = 'What is it now Yatta?'},
			{origin = 2, dialogue = 'What if I ATE all the candy I left around?'},
			{origin = 1, dialogue = 'Well, dont do all that!'},
			{origin = 2, dialogue = 'WHY!?'},
			{origin = 1, dialogue = 'Because I care about your well-being???'},
		},
	},

	['Toodles_Vee'] = {
		[1] = {
			{origin = 1, dialogue = 'Can you swim?'},
			{origin = 2, dialogue = '. . .'},
			{origin = 1, dialogue = 'Vee? Can you swim?'},
			{origin = 2, dialogue = 'What is Rodger even teaching you.'},
			{origin = 1, dialogue = 'Well... can you???'},
			{origin = 2, dialogue = 'No Toodles, I cannot swim.'},
		},
	},

	['Toodles_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Ive been hearing some scary noises at night recently...'},
			{origin = 2, dialogue = 'AW- from where little buddy???'},
			{origin = 1, dialogue = 'Uhm... uh... like the walls?'},
			{origin = 2, dialogue = 'OH!! THAT MAY BE ME!! I am NOT to be feared!'},
			{origin = 1, dialogue = 'Huh? Why are you in the walls? I wanna explore the walls!'},
			{origin = 2, dialogue = 'Ill take you on my NEXT, UPCOMING, VENT SYSTEM EXPEDITION!'},
		},
	},

	['Vee_Yatta'] = {
		[1] = {
			{origin = 1, dialogue = 'Hey Piñata, still creeping around the place?'},
			{origin = 2, dialogue = 'HAHA-!!! Its Yatta.'},
			{origin = 1, dialogue = 'Right, right... doesnt answer the question.'},
			{origin = 2, dialogue = 'Its NOT creeping! Youre jealous I can be so FLEXIBLE in my movement!'},
			{origin = 1, dialogue = '...So youre still sneaking in the vents in your free time?'},
			{origin = 2, dialogue = 'Thats just how I get around!! Im busy with ACROBATICS, MY TROUPE, and... PARTIES!!!'},
		},
	},

}

-- Id unico para parejas de cartas
-- card_1: primera carta
-- card_2: segunda carta
-- return: string unica para esa pareja, primera carta, segunda carta
function dwjokers_id_generator(card_1, card_2)

	-- En caso de que sea una sola carta. Para dialogos solitarios
	if not card_2 then
		local name = card_1.config.center.loc_txt.name
		return name
	end

	-- Se obtienen nombres. Esto depende de que se haya definido loc_txt dentro del joker
	-- en mi caso yo si lo hice porque no uso archivos localization
	local name_1 = card_1.config.center.loc_txt.name
	local name_2 = card_2.config.center.loc_txt.name
	
	-- generamos el id
	if name_1 < name_2 then
		return name_1 .. '_' .. name_2, card_1, card_2
	else
		return name_2 .. '_' .. name_1, card_2, card_1
	end
end

-- Sistema de dialogos para toons
-- cards_list: lista de cartas de las que se obtendran dialogos
-- return: nada si no hubo dialogos posibles
function dwjokers_dialog_system(cards_list)

	-- Acotamos lista de cartas a solo cartas toon
	local cards = {}
	for i=1, #cards_list do
		local card = cards_list[i]
		if card:has_attribute('toon') then
			cards[#cards+1] = card
		end
	end

	-- Si no hay cartas toon, terminamos
	if #cards <= 0 then return end

	-- Inicializamos dialogos posibles
	local possible_pairs = {}
	local pairs_exist = false
	local random_dialogue = {}
	local chosen_dialogue = {}

	-- triangulo de iteracion para evitar procesar doble
	for i=1, #cards do
		for j=i+1, #cards do
			local pair_id, card1, card2 = dwjokers_id_generator(cards[i], cards[j])
			
			if toons_dialogues[pair_id] then
				-- id: id del dialogo, [1]: carta 1, [2]: carta 2
				possible_pairs[pair_id] = {id = pair_id, [1] = card1, [2] = card2 }
				pairs_exist = true
			end
		end
	end

	-- Si no hubo parejas posibles, buscamos un dialogo solitario
	if not pairs_exist then 	
		for i=1, #cards do
			local id = dwjokers_id_generator(cards[i])

			if toons_dialogues[id] then
				possible_pairs[id] = {id = id, [1] = cards[i]}
				pairs_exist = true
			end
		end
	end

	-- Si tampoco hay dialogos solitarios, terminamos
	if not pairs_exist then return end

	-- Escogemos un dialogo al azar
	random_dialogue = pseudorandom_element(possible_pairs, 'dwjokers_dialogue_system_1')

	-- Si los personajes tienen varios dialogos, escogemos uno
	chosen_dialogue = pseudorandom_element(toons_dialogues[random_dialogue.id], 'dwjokers_dialogue_system_2')

	-- Inicializamos queue para los dialogos
	-- Esto evitara que los dialogos bloqueen otros eventos en la queue base
	G.E_MANAGER.queues.dwjokers_dialogues_queue = {}

	-- esperamos 2 segundos despues de que se genere la tienda, por estetica
	G.E_MANAGER:add_event(Event({
			trigger = 'after', 
			delay = 2,
			func = function()
				return true
			end
		}), "dwjokers_dialogues_queue")

	-- Ejecutamos el dialogo
	for i=1, #chosen_dialogue do
		-- calculamos la duracion del dialogo y delay entre mensajes
		local delay_1 = (chosen_dialogue[i].duration or 3) + 1
		local duration = chosen_dialogue[i].duration or 3

		-- determinamos el dialogo y carta que dira el mensaje
		local dialogue = chosen_dialogue[i].dialogue
		local card = random_dialogue[chosen_dialogue[i].origin or 1]

		-- creamos el evento
		G.E_MANAGER:add_event(Event({
			trigger = 'before', -- before para que se ejecute inmediatamente y el siguiente dialogo tenga delay
			delay = delay_1,
			func = function()
				-- instant para evitar que cree un evento en la queue base
				SMODS.calculate_effect({ message = dialogue, instant = true, delay = duration}, card)
				return true
			end
		}), "dwjokers_dialogues_queue")
	end

end

-- update shop hook para activar dialogos de toons
local original_update_shop = Game.update_shop
function Game:update_shop(dt)

	-- Esto asegura que se active una sola vez
	if not G.STATE_COMPLETE then

		for _,v in ipairs(G.jokers.cards) do
			if v:has_attribute('toon') then
				dwjokers_dialog_system(G.jokers.cards)
				break;
			end
		end

	end

	return original_update_shop(self, dt)
end
