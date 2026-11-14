local ze = require("__zombiesextended-core__.lib")
local science_t1 = ze.science(1)
local science_t2 = ze.science(2)
local science_t3 = ze.science(3)
local science_t4 = ze.science(4)
local science_t5 = ze.science(5)
local science_t6 = ze.science(6)
local technologies = {
    { order = "a-b-c", name = "assembling-machine-mk1", count = 300, time = 60, prerequisite = {"automation-3"}, ingredients = science_t4 },
    { order = "a-b-c", name = "assembling-machine-mk2", count = 300, time = 60, prerequisite = {"assembling-machine-mk1"}, ingredients = science_t5 },
    { order = "a-b-c", name = "assembling-machine-mk3", count = 300, time = 60, prerequisite = {"assembling-machine-mk2"}, ingredients = science_t6 },

    { order = "a-b-c", name = "oil-processing-mk1", count = 200, time = 30, prerequisite = {"oil-processing"}, ingredients = science_t3 },
    { order = "a-b-c", name = "oil-processing-mk2", count = 300, time = 30, prerequisite = {"oil-processing-mk1"}, ingredients = science_t4 },
    { order = "a-b-c", name = "oil-processing-mk3", count = 400, time = 30, prerequisite = {"oil-processing-mk2"}, ingredients = science_t5 },

    { order = "a-b-c", name = "centrifuge-mk1", count = 300, time = 60, prerequisite = {"uranium-processing"}, ingredients = science_t4 },
    { order = "a-b-c", name = "centrifuge-mk2", count = 400, time = 60, prerequisite = {"centrifuge-mk1"}, ingredients = science_t5 },
    { order = "a-b-c", name = "centrifuge-mk3", count = 500, time = 60, prerequisite = {"centrifuge-mk2"}, ingredients = science_t6 },

    { order = "a-b-c", name = "electric-furnace-mk1", count = 300, time = 60, prerequisite = {"advanced-material-processing-2"}, ingredients = science_t4 },
    { order = "a-b-c", name = "electric-furnace-mk2", count = 400, time = 60, prerequisite = {"electric-furnace-mk1"}, ingredients = science_t5 },
    { order = "a-b-c", name = "electric-furnace-mk3", count = 500, time = 60, prerequisite = {"electric-furnace-mk2"}, ingredients = science_t6 },

    { order = "a-b-c", name = "lab-mk1", count = 300, time = 60, prerequisite = {"research-speed-3"}, ingredients = science_t3 },
    { order = "a-b-c", name = "lab-mk2", count = 400, time = 60, prerequisite = {"lab-mk1"}, ingredients = science_t4 },
    { order = "a-b-c", name = "lab-mk3", count = 500, time = 60, prerequisite = {"lab-mk2"}, ingredients = science_t5 },

    { order = "a-b-c", name = "ze-electric-mining-drill-mk1", art = "electric-mining-drill-mk1", count = 200, time = 60, prerequisite = {"mining-productivity-2"}, ingredients = science_t3 },
    { order = "a-b-c", name = "ze-electric-mining-drill-mk2", art = "electric-mining-drill-mk2", count = 200, time = 60, prerequisite = {"ze-electric-mining-drill-mk1"}, ingredients = science_t4 },
    { order = "a-b-c", name = "ze-electric-mining-drill-mk3", art = "electric-mining-drill-mk3", count = 200, time = 60, prerequisite = {"ze-electric-mining-drill-mk2"}, ingredients = science_t5 },
}

-- Need to mod some vanilla items in order for the upgrade planner to work
ze.set_upgrade("assembling-machine", "assembling-machine-3", "assembling-machine-mk1", "assembling-machine")
ze.set_upgrade("assembling-machine", "oil-refinery", "oil-refinery-mk1", "oil-refinery")
ze.set_upgrade("assembling-machine", "chemical-plant", "chemical-plant-mk1", "chemical-plant")
ze.set_upgrade("assembling-machine", "centrifuge", "centrifuge-mk1", "centrifuge")
ze.set_upgrade("furnace", "electric-furnace", "electric-furnace-mk1", "furnace")
ze.set_upgrade("lab", "lab", "lab-mk1", "lab")
ze.set_upgrade("mining-drill", "electric-mining-drill", "ze-electric-mining-drill-mk1", "mining-drill")
ze.set_upgrade("mining-drill", "pumpjack", "ze-pumpjack-mk1", "pumpjack")

local assemblers = {
    { order = "a", name = "assembling-machine-mk1", health = 450, crafting_speed = 2, energy_con_kw = 750, energy_drain_kw = 25, pollution_per_min = 4, module_slots = 4, next_upgrade = "assembling-machine-mk2", craft_time = ze.craft_time.mk1, ingredients = { {"assembling-machine-3",2},{"complex-processing-unit",2} }, technology = "assembling-machine-mk1" },
    { order = "b", name = "assembling-machine-mk2", health = 500, crafting_speed = 4, energy_con_kw = 1500, energy_drain_kw = 50, pollution_per_min = 8, module_slots = 6, next_upgrade = "assembling-machine-mk3", craft_time = ze.craft_time.mk2, ingredients = { {"assembling-machine-mk1",2},{"complex-processing-unit",2} }, technology = "assembling-machine-mk2" },
    { order = "c", name = "assembling-machine-mk3", health = 550, crafting_speed = 8, energy_con_kw = 3000, energy_drain_kw = 100, pollution_per_min = 16, module_slots = 6, craft_time = ze.craft_time.mk3, ingredients = { {"assembling-machine-mk2",2},{"complex-processing-unit",2} }, technology = "assembling-machine-mk3" },
}

local oil_refineries = {
    { order = "a", name = "oil-refinery-mk1", health = 400, crafting_speed = 2, energy_con_kw = 800, energy_drain_kw = 30, pollution_per_min = 10, module_slots = 3, next_upgrade = "oil-refinery-mk2", craft_time = ze.craft_time.mk1, ingredients = { {"oil-refinery",2},{"complex-processing-unit",2} }, technology = "oil-processing-mk1" },
    { order = "b", name = "oil-refinery-mk2", health = 450, crafting_speed = 4, energy_con_kw = 1200, energy_drain_kw = 50, pollution_per_min = 20, module_slots = 4, next_upgrade = "oil-refinery-mk3", craft_time = ze.craft_time.mk2, ingredients = { {"oil-refinery-mk1",2},{"complex-processing-unit",2} }, technology = "oil-processing-mk2" },
    { order = "c", name = "oil-refinery-mk3", health = 500, crafting_speed = 8, energy_con_kw = 1600, energy_drain_kw = 80, pollution_per_min = 30, module_slots = 6, craft_time = ze.craft_time.mk3, ingredients = { {"oil-refinery-mk2",2},{"complex-processing-unit",2} }, technology = "oil-processing-mk3" },
}

local chemical_plants = {
    { order = "a", name = "chemical-plant-mk1", health = 350, crafting_speed = 2, energy_con_kw = 280, energy_drain_kw = 15, pollution_per_min = 9, module_slots = 3, next_upgrade = "chemical-plant-mk2", craft_time = ze.craft_time.mk1, ingredients = { {"chemical-plant",2},{"complex-processing-unit",2} }, technology = "oil-processing-mk1" },
    { order = "b", name = "chemical-plant-mk2", health = 400, crafting_speed = 4, energy_con_kw = 340, energy_drain_kw = 28, pollution_per_min = 16, module_slots = 4, next_upgrade = "chemical-plant-mk3", craft_time = ze.craft_time.mk2, ingredients = { {"chemical-plant-mk1",2},{"complex-processing-unit",2} }, technology = "oil-processing-mk2" },
    { order = "c", name = "chemical-plant-mk3", health = 450, crafting_speed = 8, energy_con_kw = 420, energy_drain_kw = 39, pollution_per_min = 22, module_slots = 6, craft_time = ze.craft_time.mk3, ingredients = { {"chemical-plant-mk2",2},{"complex-processing-unit",2} }, technology = "oil-processing-mk3" },
}

local centrifuges = {
    { order = "a", name = "centrifuge-mk1", health = 400, crafting_speed = 2, energy_con_kw = 400, energy_drain_kw = 15, pollution_per_min = 10, module_slots = 3, next_upgrade = "centrifuge-mk2", craft_time = ze.craft_time.mk1, ingredients = { {"centrifuge",2},{"complex-processing-unit",2} }, technology = "centrifuge-mk1" },
    { order = "b", name = "centrifuge-mk2", health = 450, crafting_speed = 4, energy_con_kw = 500, energy_drain_kw = 25, pollution_per_min = 18, module_slots = 4, next_upgrade = "centrifuge-mk3", craft_time = ze.craft_time.mk2, ingredients = { {"centrifuge-mk1",2},{"complex-processing-unit",2} }, technology = "centrifuge-mk2" },
    { order = "c", name = "centrifuge-mk3", health = 500, crafting_speed = 8, energy_con_kw = 600, energy_drain_kw = 40, pollution_per_min = 30, module_slots = 6, craft_time = ze.craft_time.mk3, ingredients = { {"centrifuge-mk2",2},{"complex-processing-unit",2} }, technology = "centrifuge-mk3" },
}

local electric_furnaces = {
    { order = "a", name = "electric-furnace-mk1", health = 400, crafting_speed = 3, energy_con_kw = 200, energy_drain_kw = 8, pollution_per_min = 2, module_slots = 3, next_upgrade = "electric-furnace-mk2", craft_time = ze.craft_time.mk1, ingredients = { {"electric-furnace",2},{"complex-processing-unit",2} }, technology = "electric-furnace-mk1" },
    { order = "b", name = "electric-furnace-mk2", health = 450, crafting_speed = 4, energy_con_kw = 240, energy_drain_kw = 12, pollution_per_min = 4, module_slots = 4, next_upgrade = "electric-furnace-mk3", craft_time = ze.craft_time.mk2, ingredients = { {"electric-furnace-mk1",2},{"complex-processing-unit",2} }, technology = "electric-furnace-mk2" },
    { order = "c", name = "electric-furnace-mk3", health = 500, crafting_speed = 8, energy_con_kw = 300, energy_drain_kw = 16, pollution_per_min = 8, module_slots = 6, craft_time = ze.craft_time.mk3, ingredients = { {"electric-furnace-mk2",2},{"complex-processing-unit",2} }, technology = "electric-furnace-mk3" },
}

local labs = {
    { order = "a", name = "lab-mk1", health = 200, research_speed = 2, energy_con_kw = 90, module_slots = 3, next_upgrade = "lab-mk2", craft_time = ze.craft_time.mk1, ingredients = { {"lab",2},{"complex-processing-unit",2} }, technology = "lab-mk1" },
    { order = "b", name = "lab-mk2", health = 250, research_speed = 4, energy_con_kw = 120, module_slots = 4, next_upgrade = "lab-mk3", craft_time = ze.craft_time.mk2, ingredients = { {"lab-mk1",2},{"complex-processing-unit",2} }, technology = "lab-mk2" },
    { order = "c", name = "lab-mk3", health = 300, research_speed = 8, energy_con_kw = 200, module_slots = 6, craft_time = ze.craft_time.mk3, ingredients = { {"lab-mk2",2},{"complex-processing-unit",2} }, technology = "lab-mk3" },    
}

local electric_mining_drills = {
    { order = "a", name = "ze-electric-mining-drill-mk1", art = "electric-mining-drill-mk1", health = 350, mining_speed = 1, energy_con_kw = 120, mining_area = 3.49, pollution_per_min = 20, module_slots = 3, next_upgrade = "ze-electric-mining-drill-mk2", craft_time = ze.craft_time.mk1, ingredients = { {"electric-mining-drill",2},{"complex-processing-unit",2} }, technology = "ze-electric-mining-drill-mk1" },
    { order = "b", name = "ze-electric-mining-drill-mk2", art = "electric-mining-drill-mk2", health = 400, mining_speed = 2, energy_con_kw = 150, mining_area = 4.49, pollution_per_min = 40, module_slots = 4, next_upgrade = "ze-electric-mining-drill-mk3", craft_time = ze.craft_time.mk2, ingredients = { {"ze-electric-mining-drill-mk1",2},{"complex-processing-unit",2} }, technology = "ze-electric-mining-drill-mk2" },
    { order = "c", name = "ze-electric-mining-drill-mk3", art = "electric-mining-drill-mk3", health = 450, mining_speed = 4, energy_con_kw = 180, mining_area = 5.49, pollution_per_min = 60, module_slots = 6, craft_time = ze.craft_time.mk3, ingredients = { {"ze-electric-mining-drill-mk2",2},{"complex-processing-unit",2} }, technology = "ze-electric-mining-drill-mk3" },
}

local pumpjacks = {
    { order = "a", name = "ze-pumpjack-mk1", art = "pumpjack-mk1", health = 250, mining_speed = 2, energy_con_kw = 120, mining_area = 1, pollution_per_min = 20, module_slots = 3, next_upgrade = "ze-pumpjack-mk2", craft_time = ze.craft_time.mk1, ingredients = { {"pumpjack",2},{"complex-processing-unit",2} }, technology = "oil-processing-mk1" },
    { order = "b", name = "ze-pumpjack-mk2", art = "pumpjack-mk2", health = 300, mining_speed = 4, energy_con_kw = 160, mining_area = 1, pollution_per_min = 40, module_slots = 4, next_upgrade = "ze-pumpjack-mk3", craft_time = ze.craft_time.mk2, ingredients = { {"ze-pumpjack-mk1",2},{"complex-processing-unit",2} }, technology = "oil-processing-mk2" },
    { order = "c", name = "ze-pumpjack-mk3", art = "pumpjack-mk3", health = 350, mining_speed = 8, energy_con_kw = 200, mining_area = 1, pollution_per_min = 60, module_slots = 6, craft_time = ze.craft_time.mk3, ingredients = { {"ze-pumpjack-mk2",2},{"complex-processing-unit",2} }, technology = "oil-processing-mk3" },
}

return {
    technologies = technologies,
    assemblers = assemblers,
    oil_refineries = oil_refineries,
    chemical_plants = chemical_plants,
    centrifuges = centrifuges,
    electric_furnaces = electric_furnaces,
    labs = labs,
    electric_mining_drills = electric_mining_drills,
    pumpjacks = pumpjacks,
}
