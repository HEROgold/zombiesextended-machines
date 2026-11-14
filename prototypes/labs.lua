local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")


for x, lab in pairs(cfg.labs) do
    
    local entity, item = ze.copy_tier({ type = "lab", base = "lab", mod = "zombiesextended-machines", tier = lab, subgroup = "ds-assembly-machines-1" })
    entity.researching_speed = lab.research_speed
    entity.energy_usage = lab.energy_con_kw .. "kW"
    entity.module_slots = lab.module_slots
    ze.retarget(entity.on_animation.layers[1], "__zombiesextended-machines__/graphics/entity/" .. lab.name .. "/hr-lab.png")
    ze.retarget(entity.off_animation.layers[1], "__zombiesextended-machines__/graphics/entity/" .. lab.name .. "/hr-lab.png")
    if mods["improved-spacex-ftl"] then
        table.insert(entity.inputs, "ftl-science-pack")
    end    

    ze.unlock(lab.technology, lab.name)

    data:extend({ entity, item,
        ze.recipe(lab)
    })
end