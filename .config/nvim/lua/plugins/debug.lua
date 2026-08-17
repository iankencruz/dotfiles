return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      { "igorlfs/nvim-dap-view", version = "1.*" },
    },
    config = function()
      local dap = require("dap")
      local dap_go = require("dap-go")

      -- Visual Signs
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped",
        { text = "▶️", texthl = "DiagnosticHint", linehl = "Visual", numhl = "DiagnosticHint" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "DiagnosticError", linehl = "", numhl = "" })

      local dap = require('dap')
      local dap_go = require('dap-go')



      -- Intercept choice prompts to make Enter default to option 1
      local original_select = vim.ui.select
      vim.ui.select = function(items, opts, on_choice)
        if opts and opts.prompt and opts.prompt:match("Configuration") then
          local original_on_choice = on_choice
          on_choice = function(item, idx)
            -- If user hits Enter without typing a number, select item 1
            if not item and not idx then
              return original_on_choice(items[1], 1)
            end
            return original_on_choice(item, idx)
          end
        end
        return original_select(items, opts, on_choice)
      end

      -- 1. Initialize dap-go normally
      dap_go.setup()

      -- 2. Completely overwrite the configuration table with ONLY your choices
      dap.configurations.go = {
        {
          type = 'go',
          name = 'Connect to Hot-Reloading Air (Port 2345)',
          request = 'attach',
          mode = 'remote',
          port = 2345,
        },
        {
          type = "go",
          name = "Debug App (cmd/app)",
          request = "launch",
          program = function()
            local workspace = vim.fn.getcwd()
            local cmd_path = workspace .. "/cmd"

            if vim.fn.isdirectory(cmd_path) == 1 then
              local handle = vim.uv.fs_scandir(cmd_path)
              if handle then
                while true do
                  local name, type = vim.uv.fs_scandir_next(handle)
                  if not name then
                    break
                  end
                  if type == "directory" then
                    return cmd_path .. "/" .. name
                  end
                end
              end
              return cmd_path
            end
            return workspace
          end,
        },
        {
          type = "go",
          name = "Debug App (Prompt for Folder/File)",
          request = "launch",
          program = function()
            -- This opens a Neovim input prompt for you to specify the path
            local path = vim.fn.input("Path to main.go or folder: ", vim.fn.getcwd() .. "/", "file")

            -- Return the entered path, or fallback to workspace root if empty
            if path == "" then
              return vim.fn.getcwd()
            end
            return path
          end,
        },
        {
          type = "go",
          name = "Debug Test (Current File/Directory)",
          request = "launch",
          mode = "test",
          console = "integratedTerminal",
          program = "${fileDirname}",
        },
        {
          type = "go",
          name = "Debug All Tests (Workspace)",
          request = "launch",
          mode = "test",
          console = "integratedTerminal",
          program = "./...",
        },
        {
          type = "go",
          name = "Attach",
          request = "attach",
          mode = "local",
          processId = require('dap.utils').pick_process,
        },

      }



      -- Mappings
      vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Debug: Start / Continue" })
      vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<leader>do", function() dap.step_over() end, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Debug: Terminate Session" })
      vim.keymap.set("n", "<leader>dgt", function() dap_go.debug_test() end, { desc = "Debug: Go Nearest Test" })
      vim.keymap.set("n", "<leader>dv", "<CMD>DapViewToggle<CR>", { desc = "Debug: Toggle UI View" })
    end,
  },
  {
    "igorlfs/nvim-dap-view",
    version = "1.*",
    opts = {
      winbar = {
        show = true,
        sections = { "scopes", "breakpoints", "threads", "watches", "repl", "exceptions", "console" },
        default_section = "scopes",
        show_keymap_hints = true,
        separators = nil,
        base_sections = {
          breakpoints = { label = "Breakpoints", keymap = "B" },
          scopes = { label = "Scopes", keymap = "S" },
          exceptions = { label = "Exceptions", keymap = "E" },
          watches = { label = "Watches", keymap = "W" },
          threads = { label = "Threads", keymap = "T" },
          repl = { label = "REPL", keymap = "R" },
          sessions = { label = "Sessions", keymap = "K" },
          console = { label = "Console", keymap = "C" },
        },
        custom_sections = {},
        controls = {
          enabled = true,
          position = "right",
          buttons = {
            "play",
            "step_into",
            "step_over",
            "step_out",
            "step_back",
            "run_last",
            "terminate",
            "disconnect",
          },
          custom_buttons = {},
        },
      },
      windows = {
        size = 0.25,
        position = "below",
        terminal = {
          size = 0.5,
          position = "left",
          hide = {},
        },
      },
      keymaps = {
        scopes = { toggle = { "<CR>", "<2-LeftMouse>" }, jump_to_parent = "[[", set_value = "s" },
        watches = { toggle = { "<CR>", "<2-LeftMouse>" }, jump_to_parent = "[[", set_value = "s", copy_value = "c", delete_expression = "d", append_expression = "a", insert_expression = "i", edit_expression = "e" },
        hover = { quit = "q", toggle = { "<CR>", "<2-LeftMouse>" }, jump_to_parent = "[[", set_value = "s" },
        help = { quit = "q" },
        console = { next_session = "]s", prev_session = "[s" },
        threads = { toggle_subtle_frames = "t", filter = "f", invert_filter = "o", jump_to_frame = { "<CR>", "<2-LeftMouse>" }, force_jump = "<C-w><CR>" },
        exceptions = { toggle_filter = { "<CR>", "<2-LeftMouse>" } },
        sessions = { switch_session = { "<CR>", "<2-LeftMouse>" } },
        breakpoints = { delete_breakpoint = "d", jump_to_breakpoint = { "<CR>", "<2-LeftMouse>" }, force_jump = "<C-w><CR>" },
        base = { next_view = "]v", prev_view = "[v", jump_to_first = "[V", jump_to_last = "]V", help = "g?" },
      },
      icons = {
        collapsed = "󰅂 ",
        disabled = "",
        disconnect = "",
        enabled = "",
        expanded = "󰅀 ",
        filter = "󰈲",
        negate = " ",
        pause =
        "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = "",
      },
      help = { border = nil },
      hover = { border = nil },
      render = {
        sort_variables = nil,
        threads = {
          format = function(name, lnum, path)
            return {
              { part = name, separator = " " },
              { part = path, hl = "FileName",  separator = ":" },
              { part = lnum, hl = "LineNumber" },
            }
          end,
          align = false,
        },
        breakpoints = {
          format = function(line, lnum, path)
            return {
              { part = path, hl = "FileName" },
              { part = lnum, hl = "LineNumber" },
              { part = line, hl = true },
            }
          end,
          align = false,
        },
      },
      virtual_text = {
        -- Control with `DapViewVirtualTextToggle`
        enabled = false,
        -- Supported options include "inline", "eol", and "eol_right_align"
        position = "inline",
        format = function(variable, _, _)
          return " " .. variable.value
        end,
        -- Prepend the variable name (when using eol positioning)
        prefix = function(position, node, bufnr)
          if position == "eol" or position == "eol_right_align" then
            local name = vim.treesitter.get_node_text(node, bufnr)

            return name .. " ="
          end
        end,
        -- Add commas between variables (when using eol positioning)
        suffix = function(position, _, _, var_index, num_var_line)
          if position == "eol" or position == "eol_right_align" then
            return var_index == num_var_line and "" or ","
          end
        end,
      },
      switchbuf = "usetab,uselast",
      auto_toggle = "open_term",
      follow_tab = false,
    },
    config = function(_, opts)
      local dap_view = require("dap-view")
      local dap = require("dap")
      dap_view.setup(opts)

      -- Automation Listeners linked with target profile setup
      dap.listeners.before.attach.my_go_debug = function()
        dap_view.open()
        print("🐞 Debugger: Connected/Attached")
      end

      dap.listeners.before.launch.my_go_debug = function()
        dap_view.open()
        print("🚀 Debugger: Process Launched & Running...")
      end

      dap.listeners.before.event_terminated.my_go_debug = function()
        dap_view.close()
        print("⏹️ Debugger: Session Terminated")
      end

      dap.listeners.before.event_exited.my_go_debug = function()
        dap_view.close()
        print("🏁 Debugger: Process Exited")
      end
    end,
  },
}
