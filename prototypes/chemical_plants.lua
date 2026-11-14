local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")


for x, chemical_plant in pairs(cfg.chemical_plants) do
    
    local entity, item = ze.copy_tier({ type = "assembling-machine", base = "chemical-plant", mod = "zombiesextended-machines", tier = chemical_plant, subgroup = "ds-assembly-machines-2" })
    entity.crafting_speed = chemical_plant.crafting_speed
    entity.energy_usage = chemical_plant.energy_con_kw .. "kW"
    entity.energy_source.drain = chemical_plant.energy_drain_kw .. "kW"
    entity.energy_source.emissions_per_minute = { pollution = chemical_plant.pollution_per_min }
    entity.module_slots = chemical_plant.module_slots
    local vanilla_animation = entity.graphics_set.animation
    entity.graphics_set.animation = ze.add_vanilla_shadows(make_4way_animation_from_spritesheet(ze.flatten_hr({
        layers =
            {
                {
                    filename = "__zombiesextended-machines__/graphics/entity/" .. chemical_plant.name .. "/chemical-plant.png",
                    width = 108,
                    height = 148,
                    frame_count = 24,
                    line_length = 12,
                    shift = util.by_pixel(1, -9),
                    hr_version =
                    {
                        filename = "__zombiesextended-machines__/graphics/entity/" .. chemical_plant.name .. "/hr-chemical-plant.png",
                        width = 220,
                        height = 292,
                        frame_count = 24,
                        line_length = 12,
                        shift = util.by_pixel(0.5, -9),
                        scale = 0.5
                    }
                }
            }
        })), vanilla_animation, 24)
    ze.unlock(chemical_plant.technology, chemical_plant.name)

    data:extend({ entity, item,
        ze.recipe(chemical_plant)
    })
end