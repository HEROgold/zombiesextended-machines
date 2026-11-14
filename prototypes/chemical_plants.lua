local ze = require("__zombiesextended-core__.lib")

local entity_base = util.table.deepcopy(data.raw["assembling-machine"]["chemical-plant"])
local item_base = util.table.deepcopy(data.raw["item"]["chemical-plant"])

for x, chemical_plant in pairs(chemical_plants) do
    
    entity = util.table.deepcopy(entity_base)
    item = util.table.deepcopy(item_base)

    entity.name = chemical_plant.name    
    entity.icon = "__zombiesextended-machines__/graphics/icons/" .. chemical_plant.name .. ".png"
    entity.minable.result = chemical_plant.name
    entity.max_health = chemical_plant.health
    entity.crafting_speed = chemical_plant.crafting_speed
    entity.energy_usage = chemical_plant.energy_con_kw .. "kW"
    entity.energy_source.drain = chemical_plant.energy_drain_kw .. "kW"
    entity.energy_source.emissions_per_minute = { pollution = chemical_plant.pollution_per_min }
    entity.module_slots = chemical_plant.module_slots
    entity.next_upgrade = chemical_plant.next_upgrade
    
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

    item.name = chemical_plant.name
    item.icon = "__zombiesextended-machines__/graphics/icons/" .. chemical_plant.name .. ".png"
    item.place_result = chemical_plant.name
    item.order = item.order .. chemical_plant.order

    if settings.startup["zombies-use-seperate-tab"].value == true then
        item.subgroup = "ds-assembly-machines-2"
    end

    table.insert(data.raw["technology"][chemical_plant.technology].effects, { type = "unlock-recipe", recipe = chemical_plant.name })

    data:extend({ entity, item,
        {
            type = "recipe",
            name = chemical_plant.name,
            enabled = false,            
            energy_required = chemical_plant.craft_time,
            ingredients = ze.ingredients(chemical_plant.ingredients),
            results = ze.result(chemical_plant.name)
        }
    })
end