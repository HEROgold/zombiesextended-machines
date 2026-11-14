local ze = require("__zombiesextended-core__.lib")

local entity_base = util.table.deepcopy(data.raw["assembling-machine"]["centrifuge"])
local item_base = util.table.deepcopy(data.raw["item"]["centrifuge"])

for x, centrifuge in pairs(centrifuges) do
    
    entity = util.table.deepcopy(entity_base)
    item = util.table.deepcopy(item_base)

    entity.name = centrifuge.name    
    entity.icon = "__zombiesextended-machines__/graphics/icons/" .. centrifuge.name .. ".png"
    entity.minable.result = centrifuge.name
    entity.max_health = centrifuge.health
    entity.crafting_speed = centrifuge.crafting_speed
    entity.energy_usage = centrifuge.energy_con_kw .. "kW"
    entity.energy_source.drain = centrifuge.energy_drain_kw .. "kW"
    entity.energy_source.emissions_per_minute = { pollution = centrifuge.pollution_per_min }
    entity.module_slots = centrifuge.module_slots
    entity.next_upgrade = centrifuge.next_upgrade
    -- 2.x merged the three centrifuge drums into one sheet; the mod ships the
    -- 1.1 hr drums, so build them with the 1.1 layout and keep the 2.x shadow.
    local gfx = "__zombiesextended-machines__/graphics/entity/" .. centrifuge.name .. "/"
    local vanilla_idle = entity.graphics_set.idle_animation
    entity.graphics_set.idle_animation = ze.add_vanilla_shadows({ layers = {
        ze.sprite(gfx .. "hr-centrifuge-C.png", { width = 237, height = 214, frame_count = 64, line_length = 8, shift = util.by_pixel(-0.25, -26.5) }),
        ze.sprite(gfx .. "hr-centrifuge-B.png", { width = 156, height = 234, frame_count = 64, line_length = 8, shift = util.by_pixel(23, 6.5) }),
        ze.sprite(gfx .. "hr-centrifuge-A.png", { width = 139, height = 246, frame_count = 64, line_length = 8, shift = util.by_pixel(-26.25, 3.5) }),
    } }, vanilla_idle, 64)

    item.name = centrifuge.name
    item.icon = "__zombiesextended-machines__/graphics/icons/" .. centrifuge.name .. ".png"
    item.place_result = centrifuge.name
    item.order = item.order .. centrifuge.order

    if settings.startup["zombies-use-seperate-tab"].value == true then
        item.subgroup = "ds-assembly-machines-1"
    end

    table.insert(data.raw["technology"][centrifuge.technology].effects, { type = "unlock-recipe", recipe = centrifuge.name })

    data:extend({ entity, item,
        {
            type = "recipe",
            name = centrifuge.name,
            enabled = false,
            energy_required = centrifuge.craft_time,
            ingredients = ze.ingredients(centrifuge.ingredients),
            results = ze.result(centrifuge.name)
        }
    })
end