local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")


for x, pumpjack in pairs(cfg.pumpjacks) do
    
    local entity, item = ze.copy_tier({ type = "mining-drill", base = "pumpjack", mod = "zombiesextended-machines", tier = pumpjack, subgroup = "ds-extraction" })
    entity.mining_speed = pumpjack.mining_speed
    entity.energy_usage = pumpjack.energy_con_kw .. "kW"
    entity.energy_source.emissions_per_minute = { pollution = pumpjack.pollution_per_min }
    entity.module_slots = pumpjack.module_slots
    -- 2.1 moved the pumpjack base into working_visualisations, one entry per
    -- direction, moved the east and west outlets, and added flipping. Both
    -- sheets are the 1.1 frames rearranged for that:
    --   normal:  north, mirrored west, south, mirrored east
    --   flipped: mirrored north, east, mirrored south, west
    -- A mirrored frame needs its x shift negated to stay centred on the entity.
    local dir = "__zombiesextended-machines__/graphics/entity/" .. pumpjack.art .. "/"
    local sheets = {
        { set = entity.graphics_set, file = "hr-pumpjack-base.png", mirrored = { east = true, west = true } },
        { set = entity.graphics_set_flipped, file = "hr-pumpjack-base-flipped.png", mirrored = { north = true, south = true } },
    }
    for _, sheet in pairs(sheets) do
        for _, direction in pairs({ "north", "east", "south", "west" }) do
            local layer = sheet.set.working_visualisations[1][direction .. "_animation"].layers[1]
            local layout = nil
            if sheet.mirrored[direction] then
                layout = { shift = { -layer.shift[1], layer.shift[2] } }
            end
            ze.retarget(layer, dir .. sheet.file, layout)
        end
        ze.retarget(sheet.set.animation.north.layers[1], dir .. "hr-pumpjack-horsehead.png")
    end
    ze.unlock(pumpjack.technology, pumpjack.name)

    data:extend({ entity, item,
        ze.recipe(pumpjack)
    })
end