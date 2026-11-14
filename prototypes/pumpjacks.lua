local ze = require("__zombiesextended-core__.lib")

local entity_base = util.table.deepcopy(data.raw["mining-drill"]["pumpjack"])
local item_base = util.table.deepcopy(data.raw["item"]["pumpjack"])

for x, pumpjack in pairs(pumpjacks) do
    
    entity = util.table.deepcopy(entity_base)
    item = util.table.deepcopy(item_base)

    entity.name = pumpjack.name
    entity.icon = "__zombiesextended-machines__/graphics/icons/" .. pumpjack.name .. ".png"
    entity.minable.result = pumpjack.name
    entity.max_health = pumpjack.health
    entity.mining_speed = pumpjack.mining_speed
    entity.energy_usage = pumpjack.energy_con_kw .. "kW"
    entity.energy_source.emissions_per_minute = { pollution = pumpjack.pollution_per_min }
    entity.module_slots = pumpjack.module_slots
    entity.next_upgrade = pumpjack.next_upgrade
    
    -- 2.1 moved the pumpjack base into working_visualisations, one entry per direction.
    for _, direction in pairs({ "north", "east", "south", "west" }) do
        ze.retarget(entity.graphics_set.working_visualisations[1][direction .. "_animation"].layers[1], "__zombiesextended-machines__/graphics/entity/" .. pumpjack.name .. "/hr-pumpjack-base.png")
    end
    -- 2.1 added flipping with its own vanilla art; the mod has no flipped sheets.
    entity.graphics_set_flipped = nil

    ze.retarget(entity.graphics_set.animation.north.layers[1], "__zombiesextended-machines__/graphics/entity/" .. pumpjack.name .. "/hr-pumpjack-horsehead.png")

    item.name = pumpjack.name
    item.icon = "__zombiesextended-machines__/graphics/icons/" .. pumpjack.name .. ".png"
    item.place_result = pumpjack.name
    item.order = item.order .. pumpjack.order

    if settings.startup["zombies-use-seperate-tab"].value == true then
        item.subgroup = "ds-extraction"
    end

    table.insert(data.raw["technology"][pumpjack.technology].effects, { type = "unlock-recipe", recipe = pumpjack.name })

    data:extend({ entity, item,
        {
            type = "recipe",
            name = pumpjack.name,
            enabled = false,            
            energy_required = pumpjack.craft_time,
            ingredients = ze.ingredients(pumpjack.ingredients),
            results = ze.result(pumpjack.name)
        }
    })
end