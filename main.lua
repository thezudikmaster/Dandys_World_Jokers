--- STEAMODDED HEADER
--- MOD_NAME: Dandy's World Jokers
--- MOD_ID: dandys_jokers
--- MOD_AUTHOR: [Thezudik]
--- MOD_DESCRIPTION: Your favorite toons as Jokers :).
--- PREFIX: dwjokers
--- VERSION: 0.12.0
----------------------------------------------
------------MOD CODE -------------------------


------------ GLOBAL VARIABLES ------------

-- Global variable para sprites de Gigi JAJAJA take the L lol JACKPOT BIG MONEY
G.dwjokers_gigi_state_sprites = {
	{ x = 4, y = 3 },	-- Normal
	{ x = 6, y = 0}		-- L
}

-- G.dwjokers_delete_run : marca si la run esta siendo borrada o no ahora mismo

-- G.GAME.dwjokers_bassie_exists : marca si Bassie existe en tu deck

-- G.GAME.dwjokers_vee_exists : marca si Vee existe en tu deck

-- G.GAME.dwjokers_bobette_bonus : bonus multiplicativo individual de Bobette (default: 2)

-- G.GAME.dwjokers_editing_vee : carta de Vee que esta abriendo el super menu ahora mismo

-- G.GAME.dwjokers_soulvester_h_size : guarda valor real instantaneo del hand size para soulvester

-- G.GAME.dwjokers_soulvester_hands : guarda valor real instantaneo de las hands para soulvester

-- G.GAME.dwjokers_blot_game_over : guarda si el juego esta en game over. Se actualiza solo con Blot

------------ CUSTOM SETS, POOLS y AREAS --------------

-- Custom card areas
SMODS.current_mod.custom_card_areas = function(game)
	
	-- Prediction area para Coal (out of bounds)
	game.dwjokers_prediction_area = CardArea(
		game.jokers.T.x, 
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
    default_weight = 0,
    badge_colour = SMODS.Gradients.dwjokers_rainbow,
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
	rarities = {
            { key = "Common", rate = 1 },
            { key = "Uncommon", rate = 0.5 },
            { key = "Rare", rate = 0.25 },
        },
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





------------ HOOKS --------------

-- Game delete run hook para evitar crasheos con remove card (no se si es mala o PESIMA practica)
local original_delete_run = Game.delete_run
function Game:delete_run()
	G.dwjokers_delete_run = true
	local ret = original_delete_run(self)
	G.dwjokers_delete_run = false
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

	local is_joker = self.ability and self.ability.set == "Joker"
    local goob_exists = next(SMODS.find_card("j_dwjokers_Goob"))
    local selling = self.being_sold
	local selfdestructive = table_contains(self.config.center.key, selfdestruct_jokers)
	local area = self.area


	if is_joker and area == G.jokers and goob_exists and not selling and not selfdestructive then
		SMODS.calculate_context({ 
			dwjokers_saved_by_goob = true, 
			dwjokers_saved_by_goob_card = self })
		self.getting_sliced = nil
		self.debuff = nil
		self.saved_by_goob = true
		self.added_to_deck = true
		return
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

-- Set edition hook con prediction activado, si es prediccion sera SILENT
local original_set_edition = Card.set_edition
function Card:set_edition(edition, immediate, silent, delay)
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

-- highlight hook para las mecanicas de bassie, vee y coal
local highlight_ref = Card.highlight
function Card:highlight(is_highlighted)
	
	-- para la mecanica de la basket de bassie. No se dibuja si es Vee o Coal
	if G.GAME.dwjokers_bassie_exists then
		if is_highlighted and ((self.ability.set == "Joker" and self.area == G.jokers) or 
			((self.ability.set == "Tarot" or self.ability.set == "Planet" or self.ability.set == "Spectral") and self.area == G.consumeables) or
			((self.ability.set == "Default" or self.ability.set == "Enhanced") and self.area == G.hand)) and not 
			(self.config and self.config.center and (self.config.center.key == "j_dwjokers_Vee" or self.config.center.key == "j_dwjokers_Coal")) then
			if self.config.center.key == "j_dwjokers_Bassie" then
				self.children.dwjokers_my_button = dwjokers_create_bassie_button_ui(self, {func = 'dwjokers_basket_button', text = "BASKET"})
			else
				self.children.dwjokers_my_button = dwjokers_create_bassie_button_ui(self, {func = 'dwjokers_save_button', text = "SAVE"})
			end
		elseif is_highlighted and self.ability.dwjokers_in_basket then
			self.children.dwjokers_my_button = dwjokers_create_bassie_button_ui(self, {func = 'dwjokers_retrieve_button', text = "RETRIEVE"})
			return self:highlight_custom_bassie(is_highlighted)
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
		if is_highlighted and self.config.center.key == "j_dwjokers_Vee" then
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
		elseif is_highlighted and G.GAME.dwjokers_coal_can_predict then
			return self:highlight_custom_bassie(is_highlighted)
		elseif self.children.dwjokers_my_button_3 then
			self.children.dwjokers_my_button_3:remove()
			self.children.dwjokers_my_button_3 = nil
		end
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
    
	-- SIMULACION DE CARD:OPEN() SIN EFECTOS VISUALES NI AMINACIONES
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
	print(card.config.center.name)
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

-- Revisar si una carta es de toon
-- Card: carta a revisar
-- return: true si es toon, false si no.
function Card:dwjokers_is_toon()
	if self.config and self.config.center then
		if (self.config.center.pools or {}).dwjokers_toons then
			return true
		else
			return false
		end
	else
		return false
	end				
end	

-- Aplicar bonus de Bobette. MUY MALA PRACTICA pero no se como hacerlo mejor :S
-- ACTUALIZAR CADA QUE CAMBIE ALGO EN LOS TOONS. TREMENDO.
-- card: carta a actualizar el bonus
-- apply: true si se aplicara el bonus, tiene prioridad
-- remove: true si se quitara el bonus
-- return: nada si no hay config o si el bonus no aplica
function dwjokers_apply_bobette_bonus(card, apply, remove)
    if not (card.config and card.config.center and card.config.center.key) then return end
    
	local key = card.config.center.key
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

	-- Usamos el bonus base (ej: 2)
	-- NO multipliques esta variable global por la cantidad de Bobettes.
	-- Deja que sea siempre 2 (o lo que diga la carta).
	local base_bonus = G.GAME.dwjokers_bobette_bonus or 2 
	
	-- Si power es 1, multiplicamos por 2.
	-- Si power es -1, multiplicamos por 0.5 (dividimos).
	local multiplier = base_bonus ^ power


	if key == "j_dwjokers_Boxten" then
		card.ability.extra.mult_add = card.ability.extra.mult_add * multiplier
		card.ability.extra.mult_stack = card.ability.extra.mult_stack * multiplier
		
	elseif key == "j_dwjokers_Poppy" then
		card.ability.extra.chips_add = card.ability.extra.chips_add * multiplier
		card.ability.extra.chips_stack = card.ability.extra.chips_stack * multiplier
		
	elseif key == "j_dwjokers_Shrimpo" then
		card.ability.extra.mult = card.ability.extra.mult * multiplier
		
	elseif key == "j_dwjokers_Tisha" then
		card.ability.extra.chips = card.ability.extra.chips * multiplier
		card.ability.extra.chip_gain = card.ability.extra.chip_gain * multiplier
		
	elseif key == "j_dwjokers_Connie" then
		card.ability.extra.mult = card.ability.extra.mult * multiplier
		card.ability.extra.mult_stack = card.ability.extra.mult_stack * multiplier
	
	elseif key == "j_dwjokers_RazzlenDazzle" then
		card.ability.extra.chips = card.ability.extra.chips * multiplier
		card.ability.extra.mult = card.ability.extra.mult * multiplier
		
	elseif key == "j_dwjokers_Toodles" then
		card.ability.extra.xmult = card.ability.extra.xmult * multiplier
		
	elseif key == "j_dwjokers_Flyte" then
		card.ability.extra.chips_mult = card.ability.extra.chips_mult * multiplier
		card.ability.extra.chips_to_give = card.ability.extra.chips_to_give * multiplier

	elseif key == "j_dwjokers_Blot" then
		card.ability.extra.mult_add = card.ability.extra.mult_add * multiplier
		card.ability.extra.mult_stack = card.ability.extra.mult_stack * multiplier
		
	elseif key == "j_dwjokers_Flutter" then
		card.ability.extra.xchips = card.ability.extra.xchips * multiplier
		
	elseif key == "j_dwjokers_Eclipse" then
		card.ability.extra.xmult = card.ability.extra.xmult * multiplier
		
	elseif key == "j_dwjokers_Dyle" then
		card.ability.extra.xmult_gain = card.ability.extra.xmult_gain * multiplier
		card.ability.extra.xmult = card.ability.extra.xmult * multiplier
		
	elseif key == "j_dwjokers_Shelly" then
		card.ability.extra.xmult_add = card.ability.extra.xmult_add * multiplier
		card.ability.extra.xmult_stack = card.ability.extra.xmult_stack * multiplier
		
	else 
		return
	end
end

-- Game over automatico. Para Blot en particular. Obtenido directo de vanilla remade (sin uso actualmente)
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
			SMODS.calculate_effect({ message = "BASKET FULL!" }, card)
		end
	else
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

-- Funcion highlight que no dibuja botones de USE ni SELL
-- Card: carta que llamo a la funcion
-- is_highlighted: si la carta esta seleccionada o no
function Card:highlight_custom_bassie(is_higlighted)
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


------------ UI PARA EL SUPER MENU DE Vee ---------------

-- CREAR EL MENU CON VEE
G.FUNCS.dwjokers_vee_menu_button = function(e)
    -- Guardamos la referencia de la carta que estamos editando
    G.GAME.dwjokers_editing_vee = e.config.ref_table 
    
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
        definition = G.UIDEF.dwjokers_vee_uibox(),
    }
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

    -- Función auxiliar para no repetir código y envolver cada toggle en una fila
    local function wrap_toggle(args)
        return {n=G.UIT.R, config={align = "lc", padding = 0.05}, nodes={
            create_toggle(args)
        }}
    end

    -- Primer columna
    local col_1 = {
        wrap_toggle({label = "+1 Hands", ref_table = G.SETTINGS, ref_value = "dwjokers_vee_hands", active_colour = HEX("25B800"), inactive_colour = HEX("041400")}), 
        wrap_toggle({label = "+1 Discards", ref_table = G.SETTINGS, ref_value = "dwjokers_vee_discards", active_colour = HEX("25B800"), inactive_colour = HEX("041400")}), 
        wrap_toggle({label = "+1 Hand size", ref_table = G.SETTINGS, ref_value = "dwjokers_vee_handsize", active_colour = HEX("25B800"), inactive_colour = HEX("041400")})
    }

    -- Segunda columna
    local col_2 = {
        wrap_toggle({label = "+1 Joker spaces", ref_table = G.SETTINGS, ref_value = "dwjokers_vee_jokers", active_colour = HEX("25B800"), inactive_colour = HEX("041400")}), 
        wrap_toggle({label = "+1 Consumable spaces", ref_table = G.SETTINGS, ref_value = "dwjokers_vee_consumables", active_colour = HEX("25B800"), inactive_colour = HEX("041400")})
    }

    -- Tercer columna
    local col_3 = {
        wrap_toggle({label = "+1 card slot in shop", ref_table = G.SETTINGS, ref_value = "dwjokers_vee_cardslots", active_colour = HEX("25B800"), inactive_colour = HEX("041400")}), 
        wrap_toggle({label = "+1 voucher slots in shop", ref_table = G.SETTINGS, ref_value = "dwjokers_vee_vouchers", active_colour = HEX("25B800"), inactive_colour = HEX("041400")}),
        wrap_toggle({label = "+1 booster pack slots in shop", ref_table = G.SETTINGS, ref_value = "dwjokers_vee_boosters", active_colour = HEX("25B800"), inactive_colour = HEX("041400")})
    }

    return {n=G.UIT.ROOT, config={align = "tl", minw = 15, padding = 0.1, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.R, config={align = "tm", colour = G.C.CLEAR}, nodes={
            {n=G.UIT.C, config={align = "lc", minw = 5, padding = 0.2}, nodes = col_1},
            {n=G.UIT.C, config={align = "lc", minw = 5, padding = 0.2}, nodes = col_2},
            {n=G.UIT.C, config={align = "lc", minw = 5, padding = 0.2}, nodes = col_3}
        }}
    }}
end

-- CREAR TAB DE STATS DEL SUPER MENU DE VEE
-- return: nodos con stats de los bonus ya aplicados. SI EL ANTERIOR FUE TORTURA ESTE MAS JAJAJAAJ
function G.UIDEF.dwjokers_vee_stats_tab_definition()
    local card = G.GAME.dwjokers_editing_vee
    local nodes = {}
    
    -- Si por alguna razón la carta no existe, mostramos error (seguridad)
    if not card or not card.ability or not card.ability.extra then
        return {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.T, config={text = "Error: Card not found", scale = 0.5, colour = G.C.RED}}}}
    end

    local upgrades = card.ability.extra.total_upgrades or {}
    
    -- Mapeo para nombres bonitos en la UI
    local display_names = {
        hands = "Hands Played",
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
        -- LÓGICA DE APLICAR (Uno al azar)
        local vee_keys = {"dwjokers_vee_hands", "dwjokers_vee_discards", "dwjokers_vee_handsize", "dwjokers_vee_jokers", "dwjokers_vee_consumables", "dwjokers_vee_cardslots", "dwjokers_vee_vouchers", "dwjokers_vee_boosters"}
        local vee_active_settings = {}
        for _, key in ipairs(vee_keys) do
            if G.SETTINGS[key] then table.insert(vee_active_settings, key) end
        end

        local chosen_key = pseudorandom_element(vee_active_settings, 'dwjokers_vee') 

        local action = actions[chosen_key]
        if action then
            action.func(upgrades)
            extra.total_upgrades[action.stat] = (extra.total_upgrades[action.stat] or 0) + upgrades
            SMODS.calculate_effect({ message = "+" .. upgrades .. " " .. action.msg .. "!", colour = G.C.GREEN }, card)
        end

    elseif mode == "remove" then
        -- LÓGICA DE REMOVER (Todo lo acumulado)
        for _, action in pairs(actions) do
            local total = extra.total_upgrades[action.stat] or 0
            if total > 0 then
                action.func(-total)
				SMODS.calculate_effect({ message = "-" .. total .. " " .. action.msg .. "!", colour = G.C.RED }, card)
            end
        end

    elseif mode == "re-apply" then
        -- NUEVA LÓGICA: RE-APLICAR (Para copias)
        local applied_any = false
        for _, action in pairs(actions) do
            local total = extra.total_upgrades[action.stat] or 0
            if total > 0 then
                action.func(total)
                applied_any = true
            end
        end
        if applied_any then
            SMODS.calculate_effect({ message = "Copy Bonuses Applied!", colour = G.C.BLUE }, card)
        end
    end
end


------------ UI PARA LAS PREDICCIONES DE COAL ---------------

-- CALCULAR PREDICCIONES DE BOOSTER PACKS AL PRESIONAR EL BOTON DE COAL
G.FUNCS.dwjokers_coal_predictions = function()
	if not G.shop_booster then return end
	G.dwjokers_prediction_area.cards = {}
	G.GAME.dwjokers_predicted_cards = {}
	for i=1, #G.shop_booster.cards do
		G.GAME.dwjokers_predicted_cards[i] = G.shop_booster.cards[i]:simulate_open(G.dwjokers_prediction_area)
	end
end	

-- FUNCION DE SALIDA DE COAL. ACTUALIZA G.GAME.dwjokers_coal_can_predict = false.
G.FUNCS.dwjokers_coal_exit = function()

	G.GAME.dwjokers_coal_can_predict = false

	G.FUNCS.exit_overlay_menu()
end	

-- CREAR EL MENU DE COAL
G.FUNCS.dwjokers_coal_button = function(e)

	-- Calculamos las predicciones al presionar el boton
	G.FUNCS.dwjokers_coal_predictions()

	G.FUNCS.overlay_menu{
		definition = G.UIDEF.dwjokers_coal_uibox(),
		pause = false
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

-- drawstep for my_button
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
  return create_UIBox_generic_options({back_func = "dwjokers_coal_exit", contents ={create_tabs(
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
    G.GAME.dwjokers_coal_can_predict = true
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


------------ ATLAS --------------

-- Icono
SMODS.Atlas{
	key = "modicon", 
	path = "icon.png", 
	px = 32, 
	py = 32
}

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


------------ EDITIONS Y ENHANCEMENTS ------------

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
    shader = "greyscale",
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

-- Vintage shader (me lo robe de alguien mas XDDD luego hago el mio)
SMODS.Shader({ key = 'greyscale', path = 'greyscale.fs' })

-- Ichor enhancement
SMODS.Enhancement {
    key = "ichor",
    loc_txt = {
        name = "Ichor",
        text = {
            "{C:mult}-#1#{} Mult. Every {C:attention}card{} in hand",
			"permanently gains {X:mult,C:white}X#2#{} Mult.",
			"Played {C:attention}cards{} become {X:black,C:white}ichor{} cards."
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

		if context.before then
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

		end

		if context.main_scoring and context.cardarea == G.play then
			return { mult = mod_mult(math.max(mult - card.ability.neg_mult, 0)) }
        end

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
    kind = 'dwjokers_toon_pack', -- You can also use Buffoon if you want it to belong to the vanilla kind
    cost = 6,
	atlas = "Other_cards",
    pos = { x = 1, y = 0 },
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
    pos = { x = 2, y = 0 },
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
    pos = { x = 3, y = 0 },
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
	cost = 5,
	config = { extra = { chips = 0, chip_gain = 10 } },
	atlas = 'Jokers',
	pos = { x = 1, y = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain } }
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
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
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
	cost = 5,
	config = { extra = { set_aux = 'Tarot' } },
	atlas = 'Jokers',
	pos = { x = 3, y = 0 },
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
	config = { extra = { hand_size = 1, looey_uses = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand_size, card.ability.extra.looey_uses } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
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
	config = { extra = { hands = 3 } },
	atlas = 'Jokers',
	pos = { x = 1, y = 1 },
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
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 4, y = 4 },
	cost = 5,
	config = { extra = { limit = 1, rank_sum = 25, limit_stack = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.limit, card.ability.extra.rank_sum, card.ability.extra.limit_stack } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
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
	config = { extra = { score_percent = 10 } },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.score_percent} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)
		
		if context.setting_blind then
			G.GAME.chips = G.GAME.chips + math.floor( G.GAME.blind.chips * card.ability.extra.score_percent / 100 )
			return {
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
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
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
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	calculate = function(self, card, context)
		if context.joker_type_destroyed and context.main_eval then
            card:start_dissolve()
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
	config = { extra = {card_num = 1, mult = 1.5, mult_stack = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.card_num, card.ability.extra.mult, card.ability.extra.mult_stack} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)

		if context.before and not context.blueprint then

			-- inicializamos cartas elegibles, que son las que no esten getting sliced
			-- ni que hayan sido removidas ya, para evitar que la misma carta se destruya dos veces
			local eligible_cards = {}
			for k, v in ipairs(context.full_hand) do
				if not v.getting_sliced and not v.removed then
					table.insert(eligible_cards, v)
				end
			end

			if #eligible_cards > 0 then
				local random_card, index = pseudorandom_element(eligible_cards, "dwjokers_Connie")
				random_card.getting_sliced = true 

				-- chips de la carta (rank (si tiene), perma bonus, enhancement y edition )
				local chips_from_card = (not SMODS.has_no_rank(random_card) and random_card.base.nominal or 0) + 
										(random_card.ability.perma_bonus or 0) + 
										(random_card.edition and (random_card.edition.chips or 0) or 0) + 
										(random_card.ability.bonus or 0)
				
				card.ability.extra.mult_stack = card.ability.extra.mult_stack + (chips_from_card * card.ability.extra.mult)

				random_card.removed = true
				G.play:remove_card(random_card)
				SMODS.calculate_effect({ message = localize { type = 'variable', key = 'a_mult', vars = { chips_from_card } }}, card)
				random_card:start_dissolve()
				
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
			"Gives {X:mult,C:white} X#1# {} Mult",
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
-- no compatible con Talisman
SMODS.Joker {
	key = 'Teagan',
	loc_txt = {
		name = 'Teagan',
		text = {
			"Doubles all sources",
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
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.dollars } }
    end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	calculate = function(self, card, context)
		if context.money_altered and context.amount > 0 then
			G.E_MANAGER:add_event(Event {
				func = function()
					G.GAME.dollars = G.GAME.dollars + context.amount
					return true
				end
			})
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
			if G.GAME.current_round.hands_left <= 0 and G.GAME.chips < G.GAME.blind.chips and
				G.GAME.dollars >= 20 then
                G.E_MANAGER:add_event(Event {
					blocking = false,
                    func = function()
						if not context.after or context.blind_defeated or 
						G.GAME.current_round.hands_left > 0 or G.GAME.chips >= G.GAME.blind.chips then
							return true
						end
						G.GAME.dollars = G.GAME.dollars - card.ability.extra.price
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
	config = { extra = { hand_mult = 2, hand_size_mult = 0.5, hands_added = 0, h_size_removed = -0, soulvester_active = false } },
	loc_vars = function(self, info_queue, card)
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
-- TODO: al usar un consumible cuando te queda una hand,
-- 		 los botones de "play hand" y "discard" no se remueven
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
	config = { extra = {xchips = 5} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.xchips} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)
		
		if context.joker_main then
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
			"Gives {C:green}1 to #1# {C:attention}playing cards",
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
	config = { extra = { creates = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.creates } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)
		
		if context.setting_blind then
			local create_cards = math.max(1, math.ceil(pseudorandom("dwjokers_Gigi", 0, card.ability.extra.creates) ) )
			for i=1, create_cards do
				local random_edition = SMODS.poll_edition { key = "dwjokers_Gigi", guaranteed = true, no_negative = true }
				local random_seal = SMODS.poll_seal {key = "dwjokers_Gigi", guaranteed = true}
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
		local gigi_state, gigi_index = pseudorandom_element(G.dwjokers_gigi_state_sprites, "dwjokers_Gigi_Gambling_JACKPOT")
		card.config.center.pos = gigi_state
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
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	set_card_type_badge = function(self, card, badges)
 		badges[#badges+1] = create_badge('Perfect!', G.C.RARITY.Rare, G.C.WHITE, 1.2 )
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
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	calculate = function(self, card, context)

		-- Contexto personalizado que se activa cuando una carta es destruida
		if context.dwjokers_saved_by_goob and not context.dwjokers_saved_by_goob_card.being_sold then
			return { no_destroy = true,
				message = 'Hug time!',
				colour = G.C.CHIPS,
				card = card}
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
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
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
		G.dwjokers_prediction_area.cards = {}
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
					end 
				end
			end
		end

		-- removemos el boton de predictions y reiniciamos el cardarea al abrir un booster
		if context.open_booster then
			G.dwjokers_prediction_area.cards = {}
			if card.children.dwjokers_my_button_3 then
				card.children.dwjokers_my_button_3:remove()
				card.children.dwjokers_my_button_3 = nil
			end
		end	

		-- ditto, al terminar la tienda
		if context.ending_shop then
			G.dwjokers_prediction_area.cards = {}
			if card.children.dwjokers_my_button_3 then
				card.children.dwjokers_my_button_3:remove()
				card.children.dwjokers_my_button_3 = nil
			end
		end	

		-- ditto, al comprar una carta
		if context.buying_card then
			G.dwjokers_prediction_area.cards = {}
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
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		
	end,
    calculate = function(self, card, context)
		
		if context.retrigger_joker_check and context.other_context.joker_main then
			if context.other_card:dwjokers_is_toon() then
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
	config = { extra = { level_up = 1, total_levels = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.level_up, card.ability.extra.total_levels } }
	end,
	set_badges = function(self, card, badges)
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

-- Dandy
SMODS.Joker {
	key = 'Dandy',
	loc_txt = {
		name = 'Dandy',
		text = {
			"At the end of {C:attention}each shop,",
			"creates {C:attention}#1#{} random {X:edition}Toon{C:attention} card",
			"{C:inactive}(Dandy not included)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Lethal",
	atlas = 'Mains',
	pos = { x = 1, y = 0 },
	soul_pos = { x = 1, y = 1 },
	cost = 20,
	config = { extra = {creates = 1} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.creates } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)

		if context.ending_shop and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
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
            return {
                message = "Good luck, friend!",
                colour = G.C.BLUE,
				card = card
            }
        end

	end
}

-- Dyle
SMODS.Joker {
	key = 'Dyle',
	loc_txt = {
		name = 'Dyle',
		text = {
			"This {X:edition}Toon{} gains {X:mult,C:white} X#1# {} Mult",
			"when a {X:edition}Toon{} is destroyed",
			"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Lethal",
	atlas = 'Mains',
	pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 1 },
	cost = 20,
	config = { extra = { xmult_gain = 1, xmult = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)
		if context.joker_type_destroyed and not context.blueprint then
            local toon_cards = 0
            if context.card:dwjokers_is_toon() then toon_cards = toon_cards + 1 end
            if toon_cards > 0 then
                -- See note about SMODS Scaling Manipulation on the wiki
                card.ability.extra.xmult = card.ability.extra.xmult + toon_cards * card.ability.extra.xmult_gain
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
	end
}

-- Pebble (WIP)
SMODS.Joker {
	key = 'Pebble',
	loc_txt = {
		name = 'Pebble',
		text = {
			"WIP"
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
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)
		
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
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
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
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = "dwjokers_Main",
	atlas = 'Mains',
	pos = { x = 1, y = 2 },
	soul_pos = { x = 1, y = 3 },
	cost = 20,
	config = { extra = { upgrades = 1, -- numero de veces que ha dado algun bonus
		total_upgrades = {
			hands = 0,			-- manos extras
			discards = 0,		-- discards extras
			hand_size = 0,		-- ditto, hand size
			jokers = 0,			-- espacios para jokers
			consumables = 0,	-- ditto, consumibles
			cardslots = 0,		-- espacios de cartas en tienda
			boosters = 0,		-- ditto, de booster packs
			vouchers = 0		-- ditto, de vouchers
		}
	}},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.upgrades, card.ability.extra.total_upgrades } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		-- Aplica si Vee fue copiada. Re aplica los bonus de la original.
		dwjokers_vee_bonus(card, "re-apply")	
		G.GAME.dwjokers_vee_exists = true
	end,
	remove_from_deck = function(self, card, from_debuff)
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
			if v:dwjokers_is_toon() and v ~= card then
				dwjokers_apply_bobette_bonus(v, true, nil)
			end
		end
		-- Aplicamos tambien a los toons en la basket de bassie
		for _, v in ipairs(G.dwjokers_bassie_basket.cards) do
			if v:dwjokers_is_toon() and v ~= card then
				dwjokers_apply_bobette_bonus(v, true, nil)
			end
		end 
	end,
	remove_from_deck = function(self, card, from_debuff)
		-- Quitamos UNA capa de bonus a todos los Toons
		for _, v in ipairs(G.jokers.cards) do
			if v:dwjokers_is_toon() and v ~= card then
				dwjokers_apply_bobette_bonus(v, nil, true)
			end
		end
		-- Quitamos tambien a los toons en la basket de bassie
		for _, v in ipairs(G.dwjokers_bassie_basket.cards) do
			if v:dwjokers_is_toon() and v ~= card then
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

				if added_card:dwjokers_is_toon() and card == bobettes[1] then
					
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
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			return {balance = true, no_retrigger = true}
		end
	end
}

----------------------------------------------
------------MOD CODE END----------------------
