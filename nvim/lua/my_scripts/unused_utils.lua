-- Set background base on time of day
local function set_background()
    local hour = os.date("*t").hour
    if hour >= 5 and hour < 19 then
        vim.opt.background = "light"
    else
        vim.opt.background = "dark"
    end
end



-- Print result to file
-- But the log.txt file is will be create in the directory
-- relative to the error's file's path
local function print_to_file()
    local flag = 0, filewrite
    if flag == 0 then
        flag = 1
        filewrite = io.open("log.txt", "a")
        filewrite:write(os.date() .. "\n")
    end
    filewrite:write(string.format("%s:\n%s\n", v, plugin))
    print(string.format("%s: %s", v, plugin))

    if flag == 1 then
        filewrite:write("\n-----\n")
        filewrite:close()
    end
end



-- Shows current time
local function show_time()
    return " " .. os.date("%H:%M")
end



-- Greeting
local function getGreeting(name) local tableTime = os.date("*t")
    local tableTime = os.date("*t")
    local hour = tableTime.hour
    local datetime = " " .. os.date("%Y-%m-%d  ") .. " " .. os.date("%H:%M:%S")
    local greetingsTable = {
        [1] = " Sleep well",
        [2] = " Good morning",
        [3] = " Good afternoon",
        [4] = " Good evening",
        [5] = "󰖔 Good night",
    }
    local greetingIndex = 0
    if hour == 23 or hour < 7 then
        greetingIndex = 1
    elseif hour < 12 then
        greetingIndex = 2
    elseif hour >= 12 and hour < 18 then
        greetingIndex = 3
    elseif hour >= 18 and hour < 21 then
        greetingIndex = 4
    elseif hour >= 21 then
        greetingIndex = 5
    end
    return " " .. datetime .. "  " .. greetingsTable[greetingIndex] .. ", " .. name
end



-- Toggleterm plugin
local function set_open_mapping()
    if vim.o.shell == "cmd.exe" then
        return [[<c-\>]]
    else return "<leader>m"
    end
end
local open_mapping = set_open_mapping()
on_create = function()
    idd = 0
    for _, chan in pairs(vim.api.nvim_list_chans()) do
        if chan["mode"] == "terminal" then
            --print(chan["id"])
            idd = chan["id"]
        end
    end
    vim.fn.chansend(idd, "pwsh\n")
end
