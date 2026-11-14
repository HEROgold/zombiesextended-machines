local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")


for x, pumpjack in pairs(cfg.pumpjacks) do
    
    local entity, item = ze.copy_tier({ type = "mining-drill", base = "pumpjack", mod = "zombiesextended-machines", tier = pumpjack, subgroup = "ds-extraction" })
    entity.mining_speed = pumpjack.mining_speed
    entity.energy_usage = pumpjack.energy_con_kw .. "kW"
    entity.energy_source.emissions_per_minute = { pollution = pumpjack.pollution_per_min }
    entity.module_slots = pumpjack.module_slots
    -- 2.1 moved the pumpjack base into working_visualisations, one entry per direction.
    for _, direction in pairs({ "north", "east", "south", "west" }) do
        ze.retarget(entity.graphics_set.working_visualisations[1][direction .. "_animation"].layers[1], "__zombiesextended-machines__/graphics/entity/" .. pumpjack.name .. "/hr-pumpjack-base.png")
    end
    -- 2.1 added flipping with its own vanilla art; the mod has no flipped sheets.
    entity.graphics_set_flipped = nil

    ze.retarget(entity.graphics_set.animation.north.layers[1], "__zombiesextended-machines__/graphics/entity/" .. pumpjack.name .. "/hr-pumpjack-horsehead.png")
    ze.unlock(pumpjack.technology, pumpjack.name)

    data:extend({ entity, item,
        ze.recipe(pumpjack)
    })
end