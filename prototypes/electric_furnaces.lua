local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")


for x, electric_furnace in pairs(cfg.electric_furnaces) do
    
    local entity, item = ze.copy_tier({ type = "furnace", base = "electric-furnace", mod = "zombiesextended-machines", tier = electric_furnace, subgroup = "ds-assembly-machines-1" })
    entity.crafting_speed = electric_furnace.crafting_speed
    entity.energy_usage = electric_furnace.energy_con_kw .. "kW"
    entity.energy_source.drain = electric_furnace.energy_drain_kw .. "kW"
    entity.energy_source.emissions_per_minute = { pollution = electric_furnace.pollution_per_min }
    entity.module_slots = electric_furnace.module_slots
    ze.retarget(entity.graphics_set.animation.layers[1], "__zombiesextended-machines__/graphics/entity/" .. electric_furnace.name .. "/hr-electric-furnace.png")
    ze.unlock(electric_furnace.technology, electric_furnace.name)

    data:extend({ entity, item,
        ze.recipe(electric_furnace)
    })
end