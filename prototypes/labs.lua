local ze = require("__zombiesextended-core__.lib")

local entity_base = util.table.deepcopy(data.raw["lab"]["lab"])
local item_base = util.table.deepcopy(data.raw["item"]["lab"])

for x, lab in pairs(labs) do
    
    entity = util.table.deepcopy(entity_base)
    item = util.table.deepcopy(item_base)

    entity.name = lab.name    
    entity.icon = "__zombiesextended-machines__/graphics/icons/" .. lab.name .. ".png"
    entity.minable.result = lab.name
    entity.max_health = lab.health
    entity.researching_speed = lab.research_speed
    entity.energy_usage = lab.energy_con_kw .. "kW"
    entity.module_slots = lab.module_slots
    entity.next_upgrade = lab.next_upgrade
    
    ze.retarget(entity.on_animation.layers[1], "__zombiesextended-machines__/graphics/entity/" .. lab.name .. "/hr-lab.png")
    ze.retarget(entity.off_animation.layers[1], "__zombiesextended-machines__/graphics/entity/" .. lab.name .. "/hr-lab.png")

    item.name = lab.name
    item.icon = "__zombiesextended-machines__/graphics/icons/" .. lab.name .. ".png"
    item.place_result = lab.name
    item.order = item.order .. lab.order

    if settings.startup["zombies-use-seperate-tab"].value == true then
        item.subgroup = "ds-assembly-machines-1"
    end

    if mods["improved-spacex-ftl"] then
        table.insert(entity.inputs, "ftl-science-pack")
    end    

    table.insert(data.raw["technology"][lab.technology].effects, { type = "unlock-recipe", recipe = lab.name })

    data:extend({ entity, item,
        {
            type = "recipe",
            name = lab.name,
            enabled = false,
            energy_required = lab.craft_time,
            ingredients = ze.ingredients(lab.ingredients),
            results = ze.result(lab.name)
        }
    })
end