reaper = reaper or {}
local reasy = {}

-- Function to run a REAPER action by its command ID
function reasy.run_action(command_id)
    reaper.Main_OnCommand(reaper.NamedCommandLookup(command_id), 0)
end

-- Function to print a message to the REAPER console and command line stdout
function reasy.print_message(message)
    reaper.ShowConsoleMsg(message)
end

-- Function to print a message to the REAPER console and command line stdout
function reasy.quit_reaper()
    reasy.run_action(40004)
end
function reasy.save()
    reasy.run_action(40026)
end


reasy.run = {}

function reasy.run.select_all_media_items()
    reaper.SelectAllMediaItems(0)
end
function reasy.run.select_all_tracks()
    reasy.run_action(40296)
end

function reasy.run.insert_files_matching_track_names()
    reasy.run_action("_SWS_INSERTFROMTN")
end


reasy.render = {}
reasy.render.settings = {}
--- Sets the sample rate for rendering.
-- @param sample_rate (number) - Sample rate of the rendered file (or 0 for project sample rate).
function reasy.render.settings.set_sample_rate(sample_rate)
    reaper.GetSetProjectInfo(0, "RENDER_SRATE", sample_rate, true)
end

--- Sets the render channels to mono.
function reasy.render.settings.set_mono()
    reaper.GetSetProjectInfo(0, "RENDER_CHANNELS", 1, true)
end

--- Sets the render channels to stereo.
function reasy.render.settings.set_stereo()
    reaper.GetSetProjectInfo(0, "RENDER_CHANNELS", 2, true)
end

--- Sets the render tail length.
-- @param ms (number) - Tail length in milliseconds to render (only used if RENDER_TAILFLAG is set).
function reasy.render.settings.set_render_tail(ms)
    reaper.GetSetProjectInfo(0, "RENDER_TAILMS", ms, true)
end

--- Sets the naming pattern for the rendered files.
-- @param pattern (string) - The naming pattern for the rendered files.
function reasy.render.settings.set_naming_pattern(pattern)
    reaper.GetSetProjectInfo_String(0, "RENDER_PATTERN", pattern, true)
end

--- Sets the format for the rendered files.
-- @param format (string) - The output format.
-- Valid formats:
-- "WAV": WAV format
-- "MP3": MP3 format 
function reasy.render.settings.set_format(format)
    reaper.GetSetProjectInfo_String(0, "RENDER_FORMAT", format, true)
end

--- Sets the render selection in REAPER.
-- @param flag (number) - The render selection flag.
-- flag values:
-- 0 = custom time bounds
-- 1 = entire project
-- 2 = time selection
-- 3 = all project regions
-- 4 = selected media items
-- 5 = selected project regions
-- 6 = all project markers
-- 7 = selected project markers
function reasy.render.settings.set_render_selection(flag)
    reaper.GetSetProjectInfo(0, "RENDER_BOUNDSFLAG", flag, true)
end

--- Sets the render settings in REAPER.
-- @param settings (number) - The render settings flag.
-- RENDER_SETTINGS values:
-- &(1|2)=0: master mix
-- &1 = stems + master mix
-- &2 = stems only
-- &4 = multichannel tracks to multichannel files
-- &8 = use render matrix
-- &16 = tracks with only mono media to mono files
-- &32 = selected media items
-- &64 = selected media items via master
-- &128 = selected tracks via master
-- &256 = embed transients if format supports
-- &512 = embed metadata if format supports
-- &1024 = embed take markers if format supports
-- &2048 = 2nd pass render
function reasy.render.settings.set_render_settings(flag)
    reaper.GetSetProjectInfo(0, "RENDER_SETTINGS", flag, true)
end


function reasy.render.mostRecentSettings()
    reasy.run_action("41823")
end

function reasy.render.start_render()
    reasy.run_action("42230")
end


return reasy