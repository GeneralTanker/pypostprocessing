local function test_entity_graphics()
    local graphics_locations = {
        ["accumulator"] = {"chargable_graphics"},
        ["boiler"] = {"pictures"},
        ["burner-generator"] = {"animation"},
        ["car"] = {"animation"},
        ["cargo-wagon"] = {"pictures"},
        ["fluid-wagon"] = {"pictures"},
        ["character"] = {"animations", "light"},
        ["construction-robot"] = {"idle", "in_motion", "shadow_idle", "shadow_in_motion", "working", "shadow_working", "smoke", "sparks"},
        ["logistic-robot"] = {"idle", "in_motion", "shadow_idle", "shadow_in_motion", "idle_with_cargo", "shadow_idle_with_cargo", "in_motion_with_cargo", "shadow_in_motion_with_cargo"},
        ["container"] = {"picture"},
        ["linked-container"] = {"picture"},
        ["curved-rail-a"] = {"pictures"},
        ["curved-rail-b"] = {"pictures"},
        ["elevated-curved-rail-a"] = {"pictures"},
        ["elevated-curved-rail-b"] = {"pictures"},
        ["elevated-half-diagonal-rail"] = {"pictures"},
        ["elevated-straight-rail"] = {"pictures"},
        ["half-diagonal-rail"] = {"pictures"},
        ["straight-rail"] = {"pictures"},
        ["train-stop"] = {"animations"},
        ["electric-energy-interface"] = {{"picture", "pictures", "animation", "animations"}},
        ["electric-pole"] = {"pictures"},
        ["fish"] = {"pictures"},
        ["generator"] = {"horizontal_animation", "vertical_animation"},
        ["heat-interface"] = {"picture"},
        ["heat-pipe"] = {"connection_sprites", "heat_glow_sprites"},
        ["inserter"] = {"hand_base_picture", "hand_closed_picture", "hand_open_picture", "hand_base_shadow", "hand_closed_shadow", "hand_open_shadow"},
        ["lab"] = {"on_animation", "off_animation"},
        ["lamp"] = {"picture_on", "picture_off"},
        ["land-mine"] = {"picture_safe", "picture_set"},
        ["lane-splitter"] = {"structure"},
        ["transport-belt"] = {"belt_animation_set", "connector_frame_sprites"},
        ["underground-belt"] = {"structure"},
        ["linked-belt"] = {"structure"},
        ["splitter"] = {"structure"},
        ["loader"] = {"structure"},
        ["loader-1x1"] = {"structure"},
        ["locomotive"] = {"front_light", "stand_by_light", "pictures"},
        ["logistic-container"] = {{"picture", "animation"}},
        ["pipe"] = {"pictures"},
        ["pipe-to-ground"] = {"pictures", "visualization"},
        ["projectile"] = {"animation"},
        ["pump"] = {"animations", "fluid_animation", "glass_pictures", "fluid_wagon_connector_graphics"},
        ["radar"] = {"pictures"},
        ["reactor"] = {"picture", "working_light_picture", "connection_patches_connected", "connection_patches_disconnected", "heat_connection_patches_connected", "heat_connection_patches_disconnected"},
        ["resource"] = {"stages"},
        ["roboport"] = {"base", "base_patch", "base_animation", "door_animation_up", "door_animation_down", "recharging_animation"},
        ["rocket-silo"] = {"shadow_sprite", "hole_sprite", "hole_light_sprite", "rocket_shadow_overlay_sprite", "rocket_glow_overlay_sprite", "door_back_sprite", "door_front_sprite", "base_day_sprite", "base_front_sprite", "red_lights_back_sprites", "red_lights_front_sprites", "satellite_animation", "arm_01_back_animation", "arm_02_right_animation", "arm_03_front_animation"},
        ["simple-entity"] = {{"picture", "pictures", "animations"}},
        ["simple-entity-with-force"] = {{"picture", "pictures", "animations"}},
        ["simple-entity-with-owner"] = {{"picture", "pictures", "animations"}},
        ["solar-panel"] = {"picture"},
        ["storage-tank"] = {"pictures"},
        ["tree"] = {{"pictures", "variations"}},
        ["wall"] = {"pictures"},
    }
    local excluded_types = {
        ["arithmetic-combinator"] = true,
        ["arrow"] = true,
        ["artillery-flare"] = true,
        ["artillery-projectile"] = true,
        ["artillery-turret"] = true,
        ["artillery-wagon"] = true,
        ["cargo-pod"] = true,
        ["constant-combinator"] = true,
        ["corpse"] = true,
        ["decider-combinator"] = true,
        ["deconstructible-tile-proxy"] = true,
        ["display-panel"] = true,
        ["entity-ghost"] = true,
        ["explosion"] = true,
        ["fire"] = true,
        ["highlight-box"] = true,
        ["infinity-container"] = true,
        ["infinity-pipe"] = true,
        ["item-entity"] = true,
        ["item-request-proxy"] = true,
        ["market"] = true,
        ["rail-remnants"] = true,
        ["selector-combinator"] = true,
        ["sticker"] = true,
        ["stream"] = true,
        ["temporary-container"] = true,
        ["tile-ghost"] = true,
        ["character-corpse"] = true,
        ["cliff"] = true,
        ["combat-robot"] = true,
        ["gate"] = true,
        ["leaf-particle"] = true,
        ["particle"] = true,
        ["legacy-curved-rail"] = true,
        ["legacy-straight-rail"] = true,
        ["particle-source"] = true,
        ["power-switch"] = true,
        ["programmable-speaker"] = true,
        ["rail-chain-signal"] = true,
        ["rail-ramp"] = true,
        ["rail-signal"] = true,
        ["rocket-silo-rocket"] = true,
        ["rocket-silo-rocket-shadow"] = true,
        ["smoke-with-trigger"] = true,
        ["speech-bubble"] = true,
        ["unit"] = true,
    }
    local excluded_entities = {
        ["bitumen-seep-mk01-base"] = true,
        ["bitumen-seep-mk02-base"] = true,
        ["bitumen-seep-mk03-base"] = true,
        ["bitumen-seep-mk04-base"] = true,
        ["tar-seep-mk01-base"] = true,
        ["natural-gas-seep-mk01-base"] = true,
        ["hidden-beacon"] = true,
        ["hidden-beacon-turd"] = true,
        ["atomic-bomb-wave-spawns-nuke-shockwave-explosion"] = true,
        ["atomic-bomb-wave-spawns-nuclear-smoke"] = true,
        ["atomic-bomb-wave-spawns-fire-smoke-explosion"] = true,
        ["atomic-bomb-wave-spawns-cluster-nuke-explosion"] = true,
        ["atomic-bomb-wave"] = true,
        ["atomic-bomb-ground-zero-projectile"] = true,
    }
    for i = 0, 9, 1 do
        excluded_entities["parameter-" .. i] = true
    end
    for i = 1, 4, 1 do
        excluded_entities["aerial-blimp-mk0" .. i .. "-accumulator"] = true
    end

    local success = true
    log("\ntest entity graphics:")
    for entity_type, _ in pairs(defines.prototypes.entity) do
        for name, entity in pairs((excluded_types[entity_type] and {}) or (data.raw[entity_type] or {})) do
            if not excluded_entities[name] then
                local graphics_exist = true
                for _, field in pairs(graphics_locations[entity_type] or {"graphics_set"}) do
                    if type(field) == "table" then
                        local at_least_one = false
                        for _, value in pairs(field) do
                            if entity[value] then
                                at_least_one = true
                                break
                            end
                        end
                        if not at_least_one then
                            graphics_exist = false
                        end
                    elseif not entity[field] then
                        graphics_exist = false
                    else
                    end
                end
                if not graphics_exist then
                    log("WARNING: entity type " .. entity_type .. ", name: " .. name .. " is missing required graphics")
                    success = false
                end
            end
        end
    end
    if success then log("graphics check successful") end
end

local function scan_for_cages()
    local success = true
    log("\ntest cage recipes:")
    for recipe_name, recipe in pairs(data.raw.recipe) do
        if recipe_name:find("%-pyvoid$")
            or recipe_name:find("^biomass%-")
            or recipe_name:find("^vonix")
            or recipe_name:find("^space%-dingrit") then
            goto NEXT_RECIPE_CAGECHECK
        end
        if not recipe.ingredients then
            goto NEXT_RECIPE_CAGECHECK
        end
        local cage_input = false
        local cage_output = false
        for i, ingredient in pairs(recipe.ingredients) do
            local item_name = ingredient[1] or ingredient.name
            if item_name:find("caged") then
                cage_input = true
                break
            end
        end
        if not cage_input then
            goto NEXT_RECIPE_CAGECHECK
        end
        if not recipe.results then
            -- Don't log, probably a voiding recipe
            goto NEXT_RECIPE_CAGECHECK
        end
        for i, result in pairs(recipe.results) do
            local item_name = result[1] or result.name
            if item_name:find("cage") then -- could be the same caged animal or an empty cage
                cage_output = true
                break
            end
        end
        if cage_input and not cage_output then
            log(string.format("Recipe \'%s\' takes a caged animal as input but does not return a cage", recipe_name))
            success = false
        end
        ::NEXT_RECIPE_CAGECHECK::
    end
    if success then log("cage check successful") end
end

local function factoriopedia_recipes(check_absent_recipes)
    local success = true
    log("\ntest factoriopedia:")
    local science_pack_order = {
        ["none"] = 0,
        ["automation-science-pack"] = 1,
        ["py-science-pack-1"] = 2,
        ["logistic-science-pack"] = 3,
        ["military-science-pack"] = 4,
        ["py-science-pack-2"] = 5,
        ["chemical-science-pack"] = 6,
        ["space-science-pack-2"] = 7,
        ["py-science-pack-3"] = 8,
        ["production-science-pack"] = 9,
        ["py-science-pack-4"] = 10,
        ["utility-science-pack"] = 11,
        ["space-science-pack"] = 12,
    }
    local unlocks = {}
    local barreling = {["py-barreling"] = true, ["py-unbarreling"] = true}
    for _, tech in pairs(data.raw["technology"]) do
        local unit_tech = table.deepcopy(tech)
        local science
        while not unit_tech.unit do
            if #unit_tech.prerequisites == 0 then
                science = "none"
                break
            end
            local tiers = {}
            for _, tech_name in pairs(unit_tech.prerequisites) do
                local technology = data.raw["technology"][tech_name]
                if not technology.unit then
                    table.insert(tiers, {tech_name, "none"})
                else
                    for _, pack in pairs(technology.unit.ingredients) do
                        if pack[2] == 1 then
                            table.insert(tiers, {tech_name, pack[1]})
                        end
                    end
                end
            end
            local max = -1
            for _, tier in pairs(tiers) do
                if science_pack_order[tier[2]] or 100 > max then
                    max = science_pack_order[tier[2]] or 100
                    unit_tech = table.deepcopy(data.raw["technology"][tier[1]])
                end
            end
        end
        for _, modifier in pairs(tech.effects or {}) do
            if modifier.type == "unlock-recipe" and not barreling[data.raw["recipe"][modifier.recipe].category] then
                if not science then
                    for _, pack in pairs(unit_tech.unit.ingredients) do
                        if pack[2] == 1 then
                            science = pack[1]
                        end
                    end
                end
                for _, product in pairs(data.raw["recipe"][modifier.recipe].results) do
                    unlocks[product.name] = unlocks[product.name] or {}
                    table.insert(unlocks[product.name], {science = science_pack_order[science], recipe = modifier.recipe})
                end
            end
        end
    end
    for name, recipe in pairs(data.raw["recipe"]) do
        if recipe.enabled ~= false and not recipe.category == "py-incineration" and not recipe.hidden then
            for _, product in pairs(recipe.results) do
                unlocks[product.name] = unlocks[product.name] or {}
                table.insert(unlocks[product.name], {science = 0, recipe = name})
            end
        end
    end
    for item_name, unlock_table in pairs(unlocks) do
        local min_recipe
        local min_tier = table_size(science_pack_order) + 1
        local tier = table_size(science_pack_order) + 1
        for _, unlock_data in pairs(unlock_table) do
            if unlock_data.recipe == item_name then
                tier = math.min(tier, unlock_data.science)
            end
            if unlock_data.science < min_tier then
                min_tier = unlock_data.science
                min_recipe = unlock_data.recipe
            end
        end
        if tier > table_size(science_pack_order) then
            if check_absent_recipes then
                success = false
                log(item_name .. " has no default recipe, should be " .. min_recipe)
            end
        elseif min_tier < tier then
            success = false
            log(item_name .. " has wrong default recipe, should be " .. min_recipe)
        end
    end
    if success then log("factoriopedia test successful") end
end

test_entity_graphics()
scan_for_cages()
-- factoriopedia default recipe assignment currently isn't good enough to properly define them to every item in the game
-- probably best to wait for that to change, unless someone wants to make a giga migration and still have some things wrong
factoriopedia_recipes(false)
