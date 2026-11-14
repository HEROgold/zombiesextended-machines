local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")


for x, assembler in pairs(cfg.assemblers) do
    
    local entity, item = ze.copy_tier({ type = "assembling-machine", base = "assembling-machine-3", mod = "zombiesextended-machines", tier = assembler, subgroup = "ds-assembly-machines-2" })
    entity.crafting_speed = assembler.crafting_speed
    entity.energy_usage = assembler.energy_con_kw .. "kW"
    entity.energy_source.drain = assembler.energy_drain_kw .. "kW"
    entity.energy_source.emissions_per_minute = { pollution = assembler.pollution_per_min }
    entity.module_slots = assembler.module_slots    
    -- 2.1 redrew the assembling machine, so the mod's sheets (cut from the 1.1
    -- hr art) use the 1.1 hr layout. The 2.1 shadow and lights don't fit them.
    local gfx = "__zombiesextended-machines__/graphics/entity/" .. assembler.name .. "/"
    for _, box in pairs(entity.fluid_boxes) do
        box.pipe_picture = {
            north = ze.sprite(gfx .. "hr-assembling-machine-pipe-N.png", { width = 71, height = 38, shift = util.by_pixel(2.25, 13.5) }),
            east = ze.sprite(gfx .. "hr-assembling-machine-pipe-E.png", { width = 42, height = 76, shift = util.by_pixel(-24.5, 1) }),
            south = ze.sprite(gfx .. "hr-assembling-machine-pipe-S.png", { width = 88, height = 61, shift = util.by_pixel(0, -31.25) }),
            west = ze.sprite(gfx .. "hr-assembling-machine-pipe-W.png", { width = 39, height = 73, shift = util.by_pixel(25.75, 1.25) }),
        }
    end
    entity.graphics_set = {
        animation = ze.sprite(gfx .. "hr-assembling-machine.png", { width = 214, height = 237, frame_count = 32, line_length = 8, shift = util.by_pixel(0, -0.75) })
    }
    ze.unlock(assembler.technology, assembler.name)
    data:extend({ entity, item,
        ze.recipe(assembler)
    })
end