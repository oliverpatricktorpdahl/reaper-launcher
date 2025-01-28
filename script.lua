-- Get the current directory
local current_dir = debug.getinfo(1, "S").source:match("@?(.*/)")
-- Add the current directory to the package path
package.path = package.path .. ";" .. current_dir .. "?.lua"
local reasy = require("reasy")

reasy.print_message("Starting the script...")

-- Run the action with command ID 40296
reasy.run_action(40296)

-- Run the SWS action "Insert from template"
reasy.run_action("_SWS_INSERTFROMTN")

reasy.render.settings.set_naming_pattern("output")
reasy.render.settings.set_format("WAV")

-- Run the action with command ID 41824
reasy.run_action(41824)

-- Run the action with command ID 40026
reasy.run_action(40026)

-- Run the action with command ID 40004
reasy.run_action(40004)

reasy.print_message("Finished running the script...")
