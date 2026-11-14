local ze = require("__zombiesextended-core__.lib")
local cfg = require("configuration")


for x, electric_mining_drill in pairs(cfg.electric_mining_drills) do
    
    local entity, item = ze.copy_tier({ type = "mining-drill", base = "electric-mining-drill", mod = "zombiesextended-machines", tier = electric_mining_drill, subgroup = "ds-extraction" })
    entity.mining_speed = electric_mining_drill.mining_speed
    entity.energy_usage = electric_mining_drill.energy_con_kw .. "kW"
    entity.resource_searching_radius = electric_mining_drill.mining_area
    entity.energy_source.emissions_per_minute = { pollution = electric_mining_drill.pollution_per_min }
    entity.module_slots = electric_mining_drill.module_slots
    ze.retarget(entity.graphics_set.animation.north.layers[1], "__zombiesextended-machines__/graphics/entity/" .. electric_mining_drill.art .. "/hr-electric-mining-drill-N.png")
    entity.graphics_set.animation.north.layers[1].width = 190
    entity.graphics_set.animation.north.layers[1].height = 198


    ze.retarget(entity.graphics_set.animation.north.layers[2], "__zombiesextended-machines__/graphics/entity/" .. electric_mining_drill.art .. "/hr-electric-mining-drill-N-output.png")
    entity.graphics_set.animation.north.layers[2].width = 60
    entity.graphics_set.animation.north.layers[2].height = 66


    ze.retarget(entity.graphics_set.animation.east.layers[1], "__zombiesextended-machines__/graphics/entity/" .. electric_mining_drill.art .. "/hr-electric-mining-drill-E.png")
    entity.graphics_set.animation.east.layers[1].width = 186
    entity.graphics_set.animation.east.layers[1].height = 188


    ze.retarget(entity.graphics_set.animation.south.layers[1], "__zombiesextended-machines__/graphics/entity/" .. electric_mining_drill.art .. "/hr-electric-mining-drill-S.png")
    entity.graphics_set.animation.south.layers[1].width = 184
    entity.graphics_set.animation.south.layers[1].height = 176


    ze.retarget(entity.graphics_set.animation.west.layers[1], "__zombiesextended-machines__/graphics/entity/" .. electric_mining_drill.art .. "/hr-electric-mining-drill-W.png")
    entity.graphics_set.animation.west.layers[1].width = 180
    entity.graphics_set.animation.west.layers[1].height = 188
    

    ze.retarget(entity.graphics_set.working_visualisations[7].east_animation, "__zombiesextended-machines__/graphics/entity/" .. electric_mining_drill.art .. "/hr-electric-mining-drill-E-front.png")
    entity.graphics_set.working_visualisations[7].east_animation.width = 136
    entity.graphics_set.working_visualisations[7].east_animation.height = 148

    
    ze.retarget(entity.graphics_set.working_visualisations[7].south_animation.layers[1], "__zombiesextended-machines__/graphics/entity/" .. electric_mining_drill.art .. "/hr-electric-mining-drill-S-output.png")
    entity.graphics_set.working_visualisations[7].south_animation.layers[1].width = 84
    entity.graphics_set.working_visualisations[7].south_animation.layers[1].height = 56


    ze.retarget(entity.graphics_set.working_visualisations[7].south_animation.layers[2], "__zombiesextended-machines__/graphics/entity/" .. electric_mining_drill.art .. "/hr-electric-mining-drill-S-front.png")
    entity.graphics_set.working_visualisations[7].south_animation.layers[2].width = 190
    entity.graphics_set.working_visualisations[7].south_animation.layers[2].height = 104


    ze.retarget(entity.graphics_set.working_visualisations[7].west_animation, "__zombiesextended-machines__/graphics/entity/" .. electric_mining_drill.art .. "/hr-electric-mining-drill-W-front.png")
    entity.graphics_set.working_visualisations[7].west_animation.width = 134
    entity.graphics_set.working_visualisations[7].west_animation.height = 140
    ze.unlock(electric_mining_drill.technology, electric_mining_drill.name)

    data:extend({ entity, item,
        ze.recipe(electric_mining_drill)
    })
end