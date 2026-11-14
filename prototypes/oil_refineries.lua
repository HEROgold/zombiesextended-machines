local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")


for x, oil_refinery in pairs(cfg.oil_refineries) do
    
    local entity, item = ze.copy_tier({ type = "assembling-machine", base = "oil-refinery", mod = "zombiesextended-machines", tier = oil_refinery, subgroup = "ds-assembly-machines-2" })
    entity.crafting_speed = oil_refinery.crafting_speed
    entity.energy_usage = oil_refinery.energy_con_kw .. "kW"
    entity.energy_source.drain = oil_refinery.energy_drain_kw .. "kW"
    entity.energy_source.emissions_per_minute = { pollution = oil_refinery.pollution_per_min }
    entity.module_slots = oil_refinery.module_slots
    local vanilla_animation = entity.graphics_set.animation
    entity.graphics_set.animation = ze.add_vanilla_shadows(make_4way_animation_from_spritesheet(ze.flatten_hr({
        layers =
            {
                {
                    filename = "__zombiesextended-machines__/graphics/entity/" .. oil_refinery.name .. "/oil-refinery.png",
                    width = 337,
                    height = 255,
                    frame_count = 1,
                    shift = {2.515625, 0.484375},
                    hr_version =
                    {
                        filename = "__zombiesextended-machines__/graphics/entity/" .. oil_refinery.name .. "/hr-oil-refinery.png",
                        width = 386,
                        height = 430,
                        frame_count = 1,
                        shift = util.by_pixel(0, -7.5),
                        scale = 0.5
                    }
                }
            }
        })), vanilla_animation, 1)
    ze.unlock(oil_refinery.technology, oil_refinery.name)

    data:extend({ entity, item,
        ze.recipe(oil_refinery)
    })
end