local multi_cursor = {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    -- event = "VeryLazy",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Line
        set({"n", "x"}, "<leader><C-k>", function() mc.lineAddCursor(-1) end)
        set({"n", "x"}, "<leader><C-j>", function() mc.lineAddCursor(1) end)

        -- Matched word/selection
        set({"n", "x"}, "<leader><A-n>", function() mc.matchAddCursor(1) end)
        set({"n", "x"}, "<leader><A-N>", function() mc.matchSkipCursor(1) end)

        -- Visual / visual line / visual block modes to multicursor
        set({"x"}, "<C-q>", function()
            local TERM_CODES = require("multicursor-nvim.term-codes")
            local mode = vim.fn.mode()
            mc.action(function(ctx)
                ctx:forEachCursor(function(cursor)
                    cursor:splitVisualLines()
                end)
                ctx:forEachCursor(function(cursor)
                    cursor:feedkeys(
                        (cursor:atVisualStart() and "" or "o")
                        .. "<esc>"
                        .. (mode == TERM_CODES.CTRL_V and "" or "^"),
                        { keycodes = true }
                    )
                end)
            end)
        end)

        -- -- Add or skip cursor above/below the main cursor.
        -- set({"n", "x"}, "<up>", function() mc.lineAddCursor(-1) end)
        -- set({"n", "x"}, "<down>", function() mc.lineAddCursor(1) end)
        -- set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end)
        -- set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end)
        --
        -- -- Add or skip adding a new cursor by matching word/selection
        -- set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end)
        -- set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end)
        -- set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)
        -- set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end)

        -- Add and remove cursors with control + left click.
        set("n", "<c-leftmouse>", mc.handleMouse)
        set("n", "<c-leftdrag>", mc.handleMouseDrag)
        set("n", "<c-leftrelease>", mc.handleMouseRelease)

        -- Disable and enable cursors.
        set({"n", "x"}, "<A-q>", mc.toggleCursor)

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            layerSet({"n", "x"}, "<C-k>", function() mc.lineAddCursor(-1) end)
            layerSet({"n", "x"}, "<C-j>", function() mc.lineAddCursor(1) end)
            layerSet({"n", "x"}, "<A-n>", function() mc.matchAddCursor(1) end)
            layerSet({"n", "x"}, "<A-N>", function() mc.matchSkipCursor(1) end)

            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "<left>", mc.prevCursor)
            layerSet({"n", "x"}, "<right>", mc.nextCursor)

            -- Delete the main cursor.
            layerSet({"n", "x"}, "<C-x>", mc.deleteCursor)

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
}

return multi_cursor
