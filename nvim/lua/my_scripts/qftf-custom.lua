-- Custom Quickfix list text format

-- TODO: Insert beginning messages, like time, directory

-- TODO: Color highlight
-- check below, learn from these example
-- https://github.com/tzachar/local-highlight.nvim/blob/master/lua/local-highlight.lua
-- https://www.reddit.com/r/neovim/comments/13bp2hp/adding_highlighted_text_to_a_buffer/
-- https://github.com/kevinhwang91/nvim-bqf?tab=readme-ov-file#rebuild-syntax-for-quickfix
-- https://github.com/yorickpeterse/nvim-pqf
-- https://github.com/ashfinal/qfview.nvim
-- https://github.com/NvChad/nvim-colorizer.lua/blob/master/lua/colorizer/buffer.lua#L74
-- https://neovim.io/doc/user/builtin.html#matchadd()
-- https://github.com/ariel-frischer/bmessages.nvim/blob/main/lua/bmessages.lua#L62

-- Some functions
-- nvim_buf_add_highlight()
-- nvim_set_hl()


local fn = vim.fn

local function combine(fname, lnum, col, qtype, text)
    local str = fname .. '|' .. lnum

    -- concate col
    if col ~= 0 then
        str = str .. ':' .. col .. '|'
    else
        str = str .. '|'
    end
    -- concate qtype
    if qtype ~= '' then
        str = str .. qtype
    end
    -- concate text
    str = str .. text
    return str
end

function _G.qftf(info)
    local items
    local ret = {}
    -- Get items
    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end

    -- Retrieve filename, line number, column number, text
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        -- print(vim.inspect(e))
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()

            str = combine(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
