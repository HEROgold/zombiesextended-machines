local ze = require("__zombiesextended-core__.lib")

local entity_base = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"])
local item_base = util.table.deepcopy(data.raw["item"]["assembling-machine-3"])

for x, assembler in pairs(assemblers) do
    
    entity = util.table.deepcopy(entity_base)
    item = util.table.deepcopy(item_base)

    entity.name = assembler.name    
    entity.icon = "__zombiesextended-machines__/graphics/icons/" .. assembler.name .. ".png"
    entity.minable.result = assembler.name
    entity.max_health = assembler.health
    entity.crafting_speed = assembler.crafting_speed
    entity.energy_usage = assembler.energy_con_kw .. "kW"
    entity.energy_source.drain = assembler.energy_drain_kw .. "kW"
    entity.energy_source.emissions_per_minute = { pollution = assembler.pollution_per_min }
    entity.module_slots = assembler.module_slots    
    entity.next_upgrade = assembler.next_upgrade
    
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

    item.name = assembler.name
    item.icon = "__zombiesextended-machines__/graphics/icons/" .. assembler.name .. ".png"
    item.place_result = assembler.name
    item.order = item.order .. assembler.order

    if settings.startup["zombies-use-seperate-tab"].value == true then
        item.subgroup = "ds-assembly-machines-2"
    end

    table.insert(data.raw["technology"][assembler.technology].effects, { type = "unlock-recipe", recipe = assembler.name })
    data:extend({ entity, item,
        {
            type = "recipe",
            name = assembler.name,
            enabled = false,            
            energy_required = assembler.craft_time,
            ingredients = ze.ingredients(assembler.ingredients),
            results = ze.result(assembler.name)
        }
    })
end