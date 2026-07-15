--- STEAMODDED HEADER
--- MOD_NAME: Dandy's World Jokers
--- MOD_ID: dandys_jokers
--- MOD_AUTHOR: [Thezudik]
--- MOD_DESCRIPTION: Your favorite toons as Jokers :).
--- PREFIX: dwjokers
--- VERSION: 0.8.1
----------------------------------------------
------------MOD CODE -------------------------


------------ GLOBAL VARIABLES ------------

-- Global variable para Gigi JAJAJA take the L lol JACKPOT BIG MONEY
G.dwjokers_gigi_state_sprites = {
	{ x = 4, y = 3 },	-- Normal
	{ x = 6, y = 0}		-- L
}


------------ CUSTOM SETS, POOLS y AREAS --------------

-- Custom card areas
SMODS.current_mod.custom_card_areas = function(game)
	
	-- Prediction area para Coal
	game.dwjokers_prediction_area = CardArea(
		G.hand.T.x-1,
     	G.hand.T.y+3,
      	G.GAME.shop.joker_max*2*G.CARD_W,
      	0.8*G.CARD_H, 
        { card_limit = 1, type = 'shop', highlight_limit = 0 }
	)

	-- Basket area para Bassie
		game.dwjokers_bassie_basket = CardArea(
		game.jokers.T.x, 
		game.jokers.T.y - 2,
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

-- Pool de los jokers de toon, para lo que se ofrezca
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


------------ HOOKS --------------

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
	local ret = original_remove(self)

	SMODS.calculate_context({
		dwjokers_removed = true,
		dwjokers_removed_card = re_card
	})

	return ret
end	

-- Start_dissolve hook para prevenir que Jokers sean destruidos si tienes a Goob en un deck
-- Mas un saved by goob context por si se ocupa
local original_start_dissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)

	local is_joker = self.ability and self.ability.set == "Joker"
    local goob_exists = next(SMODS.find_card("j_dwjokers_Goob"))
    local selling = self.being_sold
	local selfdestructive = table_contains(self.config.center.key, selfdestruct_jokers)


	if is_joker and goob_exists and not selling and not selfdestructive then
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

-- Set edition con prediction activado, si es prediccion sera SILENT
local original_set_edition = Card.set_edition
function Card:set_edition(edition, immediate, silent, delay)
	if G.GAME.dwjokers_prediction_active then
		local ret = original_set_edition(self, edition, immediate, true, delay)
	else
		local ret = original_set_edition(self,edition,immediate,silent,delay)
	end

	return ret
end

-- Set seal con prediccion activado, si es prediccion sera SILENT
local original_set_seal = Card.set_seal
function Card:set_seal(_seal, silent, immediate)
	if G.GAME.dwjokers_prediction_active then
		local ret = original_set_seal(self, _seal, true, immediate)
	else
		local ret = original_set_seal(self, _seal, silent, immediate)
	end

	return ret
end


G.FUNCS.draw_from_play_to_discard = function(e)
    local play_count = #G.play.cards
    -- Verificamos si tienes el Joker "Scraps"
    local scraps_exists = next(SMODS.find_card("j_dwjokers_Scraps"))

    for i=1, play_count do
        local card = G.play.cards[i]
        
        if scraps_exists and card.ability.dwjokers_scrapped then
            -- Si puntuó y tenemos a Scraps, va al DECK (mazo)
            draw_card(G.play, G.deck, i*100/play_count, 'down', nil, nil, 0.08)
            card.ability.dwjokers_scrapped = nil -- Limpiamos la marca
        else
            -- Comportamiento normal: va al DISCARD (descarte)
            draw_card(G.play, G.discard, i*100/play_count, 'down', nil, nil, 0.08)
            card.ability.dwjokers_scrapped = nil -- Limpiamos por si acaso
        end
    end
end


------------ CUSTOM FUNCTIONS --------------

-- Para verificar si una tabla contiene un valor. Muy util :)
function table_contains(value, tbl)
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

-- Predecir contenido de booster pack. TREMENDO DOLOR DE CABEZA FUE HACER ESTO :S
function Card:simulate_open()
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
			card:set_card_area(G.dwjokers_prediction_area)
			card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 2*G.SETTINGS.GAMESPEED)
			G.dwjokers_prediction_area:emplace(card, nil)
            
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

-- Imprimir predicciones de Card:simulate_open(). Se imprimen en consola.
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


------------ UI ---------------

-- GUARDAR EN LA dwjokers_bassie_basket
G.FUNCS.dwjokers_save_button = function(e)
	local card = e.config.ref_table -- access the card this button was on
	local area = card.area
	card.original_area = area

	if card.config.center.key ~= "j_dwjokers_Bassie" then
		if #G.dwjokers_bassie_basket.cards < G.dwjokers_bassie_basket.config.card_limit then
			card:hard_set_T(nil, nil, card.T.w / 1.5, card.T.h / 1.5)
			area:remove_card(card)
			area:remove_from_highlighted(card)
			card:set_card_area(G.dwjokers_bassie_basket)
			card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 2*G.SETTINGS.GAMESPEED)
			G.dwjokers_bassie_basket:emplace(card, nil)
		else
			SMODS.calculate_effect({ message = "BASKET FULL!" }, card)
		end
	else
		SMODS.calculate_effect({ message = "I CANT SAVE MYSELF!" }, card)
	end
end

-- RECUPERAR DE LA dwjokers_bassie_basket
G.FUNCS.dwjokers_retrieve_button = function(e)
	local card = e.config.ref_table -- access the card this button was on
	local area = {}
	local set = card.ability.set

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

	if #area.cards < area.config.card_limit or area == G.hand then	
		card:hard_set_T(nil, nil, card.T.w * 1.5, card.T.h * 1.5)
		G.dwjokers_bassie_basket:remove_card(card)
		G.dwjokers_bassie_basket:remove_from_highlighted(card)
		card:set_card_area(area)
		card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 2*G.SETTINGS.GAMESPEED)
		area:emplace(card, nil)
	else
		SMODS.calculate_effect({ message = "NOT ENOUGH SPACE!" }, card)
	end
end

-- BOTON PARA GUARDAR CARTAS
local function dwjokers_create_save_button_ui(card)
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
            colour = G.C.CHIPS, -- color of the button background
            button = 'dwjokers_save_button', -- function in G.FUNCS that will run when this button is clicked
            ref_table = card,
          },
          nodes = {
            {
              n = G.UIT.R,
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = "SAVE",
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
      align = 'tm', -- position relative to the card, meaning "center left". Follow the SMODS UI guide for more alignment options
      major = card,
      parent = card,
      offset = { x = 0.2, y = 0 } -- depends on the alignment you want, without an offset the button will look as if floating next to the card, instead of behind it
    }
  })
end

-- BOTON PARA RECUPERAR CARTAS
local function dwjokers_create_retrieve_button_ui(card)
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
            colour = G.C.CHIPS, -- color of the button background
            button = 'dwjokers_retrieve_button', -- function in G.FUNCS that will run when this button is clicked
            ref_table = card,
          },
          nodes = {
            {
              n = G.UIT.R,
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = "RETRIEVE",
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

-- highlight hook para el boton de save y retrieve de Bassie
local highlight_ref = Card.highlight
function Card:highlight(is_highlighted)
	local bassie_exists = next(SMODS.find_card("j_dwjokers_Bassie"))

		if bassie_exists and is_highlighted and ((self.ability.set == "Joker" and self.area == G.jokers) or 
			((self.ability.set == "Tarot" or self.ability.set == "Planet" or self.ability.set == "Spectral") and self.area == G.consumeables) or
			((self.ability.set == "Default" or self.ability.set == "Enhanced") and self.area == G.hand)) then
			self.children.dwjokers_my_button = dwjokers_create_save_button_ui(self)
		elseif is_highlighted and self.area == G.dwjokers_bassie_basket then
			self.children.dwjokers_my_button = dwjokers_create_retrieve_button_ui(self)
		elseif self.children.dwjokers_my_button then
			self.children.dwjokers_my_button:remove()
			self.children.dwjokers_my_button = nil
		end

  return highlight_ref(self, is_highlighted)
end

-- drawstep for my_button
SMODS.DrawStep {
  key = 'my_button',
  order = 100, -- before the Card is drawn
  func = function(card, layer)
    if card.children.dwjokers_my_button then
      card.children.dwjokers_my_button:draw()
    end
  end
}

-- make sure SMODS doesn't draw the button after the card is drawn
SMODS.draw_ignore_keys.dwjokers_my_button = true

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
		for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
			if (joker.config.center.pools or {}).dwjokers_toons then
				card.ability.extra.mult_stack = card.ability.extra.mult_stack + card.ability.extra.mult_add
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
			for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
			if (joker.config.center.pools or {}).dwjokers_toons then
				card.ability.extra.mult_stack = card.ability.extra.mult_stack + card.ability.extra.mult_add
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
					for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
						if (joker.config.center.pools or {}).dwjokers_toons then
							card.ability.extra.mult_stack = card.ability.extra.mult_stack + card.ability.extra.mult_add
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
		for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
			if (joker.config.center.pools or {}).dwjokers_toons then
				card.ability.extra.chips_stack = card.ability.extra.chips_stack + card.ability.extra.chips_add
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
			for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
				if (joker.config.center.pools or {}).dwjokers_toons then
					card.ability.extra.chips_stack = card.ability.extra.chips_stack + card.ability.extra.chips_add
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
					for _, joker in ipairs(G.dwjokers_bassie_basket.cards) do
						if (joker.config.center.pools or {}).dwjokers_toons then
							card.ability.extra.chips_stack = card.ability.extra.chips_stack + card.ability.extra.chips_add
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
	blueprint_compat = false,
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

		if context.after then
			G.hand:change_size(card.ability.extra.hand_size)
			card.ability.extra.looey_uses = card.ability.extra.looey_uses + 1
			return {
				message = 'Im actually so excited!',
				colour = G.C.CHIPS,
				card = card
			}
		end
		
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
        if G.GAME.current_round.hands_left <= 0 and G.GAME.chips < G.GAME.blind.chips then
            if context.after and not context.blind_defeated and not context.blueprint then
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

-- Rudie (WIP)
SMODS.Joker {
	key = 'Rudie',
	loc_txt = {
		name = 'Rudie',
		text = {
			"WIP"
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
	end,
    calculate = function(self, card, context)
		
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

-- Connie (WIP)
SMODS.Joker {
	key = 'Connie',
	loc_txt = {
		name = 'Connie',
		text = {
			"WIP"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 5, y = 2 },
	cost = 7,
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

-- Finn (WIP)
SMODS.Joker {
	key = 'Finn',
	loc_txt = {
		name = 'Finn',
		text = {
			"WIP"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 0, y = 3 },
	cost = 7,
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
				card.ability.extra.currently1 = 1000
				card.ability.extra.currently2 = "Chips"
			else
				card.ability.extra.currently1 = 100
				card.ability.extra.currently2 = "Mult"
			end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.round % 2 == 1 then
				card.ability.extra.currently1 = 1000
				card.ability.extra.currently2 = "Chips"
				return {
					chip_mod = card.ability.extra.chips,
					message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
				}
			else
				card.ability.extra.currently1 = 100
				card.ability.extra.currently2 = "Mult"
				return {
					mult_mod = card.ability.extra.mult,
					message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
				}
			end
		end

		if context.setting_blind then
			if G.GAME.round % 2 == 1 then
				card.ability.extra.currently1 = 1000
				card.ability.extra.currently2 = "Chips"
				return {
					message = 'Oh what fun!',
					colour = G.C.CHIPS
				}
			else
				card.ability.extra.currently1 = 100
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
        return { vars = { card.ability.extra.d_size, card.ability.extra.d_total, G.GAME.round } }
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
		if context.money_altered and to_big(context.amount) > to_big(0) then
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

-- Flyte (WIP)
SMODS.Joker {
	key = 'Flyte',
	loc_txt = {
		name = 'Flyte',
		text = {
			"WIP"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 1, y = 3 },
	cost = 7,
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

-- Soulvester
SMODS.Joker {
	key = 'Soulvester',
	loc_txt = {
		name = 'Soulvester',
		text = {
			"When {C:attention}blind{} is selected,",
			"Double the {C:attention}hands{} and",
			"halve the {C:attention}hand size{}.",
			"{C:inactive}(Currently {C:attention}#4#{C:inactive})"
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
	config = { extra = { hand_mult = 2, hand_size_mult = 0.5, half_hand_size = 0, soulvester_active_string = 'inactive', soulvester_active = false } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand_mult, card.ability.extra.hand_size_mult, card.ability.extra.soulvester_active, card.ability.extra.soulvester_active_string } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.half_hand_size = math.floor(G.hand.config.card_limit * card.ability.extra.hand_size_mult)
	end,
	remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.soulvester_active then
			G.hand.config.card_limit = G.hand.config.card_limit / (1 - card.ability.extra.hand_size_mult)
			G.GAME.current_round.hands_left = G.GAME.current_round.hands_left / card.ability.extra.hand_mult
		end
	end,
    calculate = function(self, card, context)
		
		if context.setting_blind then
			card.ability.extra.soulvester_active_string = 'active'
			card.ability.extra.soulvester_active = true
			card.ability.extra.half_hand_size = math.floor(G.hand.config.card_limit * card.ability.extra.hand_size_mult)
			G.hand.config.card_limit = G.hand.config.card_limit - card.ability.extra.half_hand_size
			G.GAME.current_round.hands_left = G.GAME.current_round.hands_left * card.ability.extra.hand_mult
			return {
				message = 'There is still work to be done.',
				colour = G.C.CHIPS,
				card = card
			}
		end
		
		if context.starting_shop and not context.blueprint then
			card.ability.extra.soulvester_active_string = 'inactive'
			card.ability.extra.soulvester_active = false
			G.hand.config.card_limit = G.hand.config.card_limit + card.ability.extra.half_hand_size
			G.GAME.current_round.hands_left = G.GAME.current_round.hands_left / card.ability.extra.hand_mult
			return {
				message = 'Inactive!',
				colour = G.C.CHIPS,
				card = card
			}
		end
	end
	
}


--- RAROS

-- Blot
SMODS.Joker {
	key = 'Blot',
	loc_txt = {
		name = 'Blot',
		text = {
			"{C:blue}+#1#{} hand for each consumable",
			"in your possesion and {C:mult}+#2#{} Mult",
			"for each current hand size.",
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
		card.ability.extra.diff = #G.consumeables.cards - card.ability.extra.hand_stack
		card.ability.extra.hand_stack = #G.consumeables.cards + #G.dwjokers_bassie_basket.cards
		card.ability.extra.mult_stack = G.hand.config.card_limit * card.ability.extra.mult_add
		G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.diff
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.current_round.hands_left = G.GAME.current_round.hands_left - card.ability.extra.hand_stack
	end,
    calculate = function(self, card, context)

		if context.setting_blind and not context.blueprint then
			card.ability.extra.hand_stack = #G.consumeables.cards + #G.dwjokers_bassie_basket.cards
			card.ability.extra.mult_stack = G.hand.config.card_limit * card.ability.extra.mult_add
			G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hand_stack
		end

		if context.card_added or (context.dwjokers_removed and table_contains(context.dwjokers_removed_card.ability.set, card_types)) and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					card.ability.extra.diff = #G.consumeables.cards - card.ability.extra.hand_stack
					card.ability.extra.hand_stack = #G.consumeables.cards + #G.dwjokers_bassie_basket.cards
					G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.diff
					return true
				end,
				blocking = false
			}))
		end

		if context.joker_main and not context.blueprint then
			card.ability.extra.mult_stack = G.hand.config.card_limit * card.ability.extra.mult_add
		end	

		if context.joker_main then
			return {
					mult_mod = card.ability.extra.mult_stack,
					message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_stack } }
				}
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

-- Glisten (WIP)
SMODS.Joker {
	key = 'Glisten',
	loc_txt = {
		name = 'Glisten',
		text = {
			"WIP"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
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
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)
		
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
			"{C:red,E:2}self destructions{C:inactive})"
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
SMODS.Joker {
	key = 'Coal',
	loc_txt = {
		name = 'Coal',
		text = {
			"See the content of {C:attention}Booster Packs{}",
			"by hovering over them.",
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
	calculate = function(self, card, context)
		
		if context.dwjokers_hovered and not context.open_booster and 
		context.dwjokers_hovered_card.ability.set == "Booster" and G.shop then
			G.dwjokers_prediction_area.cards = {}

			context.dwjokers_hovered_card.prediction_active = true
			local predictions = context.dwjokers_hovered_card:simulate_open()
		end	

		if context.open_booster then
			G.dwjokers_prediction_area.cards = {}
		end	

		if context.ending_shop then
			G.dwjokers_prediction_area.cards = {}
		end	

		
	end

}

-- Cocoa (WIP)
SMODS.Joker {
	key = 'Cocoa',
	loc_txt = {
		name = 'Cocoa',
		text = {
			"WIP"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
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


-- MAINS

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
	rarity = 4,
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
			"creates {C:attention}#1#{} random {X:edition}Toon{C:attention} Joker",
			"{C:inactive}(Dandy not included)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 4,
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
                            set = 'dwjokers_toons',
							key_append = 'dwjokers_dandy' 
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
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 4,
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
	rarity = 4,
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
			"{X:edition}Toon{} Joker in your possesion.",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 4,
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
		for _, joker in ipairs(G.dwjokers_bassie_basket) do
			if (joker.config.center.pools or {}).dwjokers_toons then
				card.ability.extra.xmult_stack = card.ability.extra.xmult_stack + card.ability.extra.xmult_add
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
			for _, joker in ipairs(G.dwjokers_bassie_basket) do
				if (joker.config.center.pools or {}).dwjokers_toons then
					card.ability.extra.xmult_stack = card.ability.extra.xmult_stack + card.ability.extra.xmult_add
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
					for _, joker in ipairs(G.dwjokers_bassie_basket) do
						if (joker.config.center.pools or {}).dwjokers_toons then
							card.ability.extra.xmult_stack = card.ability.extra.xmult_stack + card.ability.extra.xmult_add
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
			"{C:attention}Cosmo {X:edition}Toon{} {C:attention}Joker."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 4,
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

		if context.selling_card then
			if context.card.config.center.key == "j_dwjokers_Cosmo" then
				card:explode()
			end
		end	
	end
}

-- Vee (WIP)
SMODS.Joker {
	key = 'Vee',
	loc_txt = {
		name = 'Vee',
		text = {
			"{C:attention}+#1#{} Joker spaces and",
			"{C:atention}+#2#{} Consumable spaces",
			"at the end of shop while you have",
			"this {X:edition}Toon{} on your deck.",
			"{C:inactive}(Currently {C:attention}+#3#{C:inactive} Joker spaces",
			"{C:inactive}and {C:attention}+#4#{C:inactive} Consumable spaces)"
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 4,
	atlas = 'Mains',
	pos = { x = 1, y = 2 },
	soul_pos = { x = 1, y = 3 },
	cost = 20,
	config = { extra = { joker_spaces = 1, consumable_spaces = 1, joker_stack = 0, consumable_stack = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.joker_spaces, card.ability.extra.consumable_spaces, card.ability.extra.joker_stack, card.ability.extra.consumable_stack } }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
	add_to_deck = function(self, card, from_debuff)
	end,
    calculate = function(self, card, context)
		
		if context.ending_shop then

		end

	end
}

-- Bobette (WIP)
SMODS.Joker {
	key = 'Bobette',
	loc_txt = {
		name = 'Bobette',
		text = {
			"{X:attention,C:white}X#1#{} to all {C:attention}listed",
			"{X:mult,C:white}Mult{} and {X:chips,C:white}Chips",
			"in {X:edition}Toon{C:attention} Jokers."
		}
	},
	unlocked = true, 
	discovered = true,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 4,
	atlas = 'Mains',
	pos = { x = 2, y = 2 },
	soul_pos = { x = 2, y = 3 },
	cost = 20,
	config = { extra = {mult_bonus = 5} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult_bonus} }
	end,
	set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge('Toon', G.C.EDITION, G.C.BLACK, 1.2 )
 	end,
    calculate = function(self, card, context)
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
	rarity = 4,
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
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.dwjokers_bassie_basket.config.card_limit = G.dwjokers_bassie_basket.config.card_limit - card.ability.extra.save_cards
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
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	rarity = 4,
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
			return {balance = true}
		end
	end
}

----------------------------------------------
------------MOD CODE END----------------------
