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

      dap_go.setup()

      dap.configurations.go = {
        {
          type = "go",
          name = "Debug App (cmd/app)",
          request = "launch",
          program = function()
            local workspace = vim.fn.getcwd()
            local cmd_path = workspace .. "/cmd"

            if vim.fn.isdirectory(cmd_path) == 1 then
              local handle = vim.loop.fs_scandir(cmd_path)
              if handle then
                while true do
                  local name, type = vim.loop.fs_scandir_next(handle)
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
        sections = { "scopes", "breakpoints", "threads", "watches", "exceptions" },
        default_section = "scopes",
        show_keymap_hints = true,
        separators = nil,
        base_sections = {
          breakpoints = { label = "Breakpoints", keymap = "B" },
          scopes = { label = "Scopes", keymap = "S" },
          exceptions = { label = "Exceptions", keymap = "E" },
          watches = { label = "Watches", keymap = "W" },
          threads = { label = "Threads", keymap = "T" },
          sessions = { label = "Sessions", keymap = "K" },
          console = { label = "Console", keymap = "C" },
        },
        custom_sections = {},
        controls = {
          enabled = true,
          buttons = { "play", "step_into", "step_over", "step_out", "term_restart", "fun" },
          custom_buttons = {
            fun = {
              render = function() return "🎉" end,
              action = function() vim.print("🎊") end,
            },
            term_restart = {
              render = function(session)
                local group = session and "ControlTerminate" or "ControlRunLast"
                local icon = session and "" or ""
                return "%#NvimDapView" .. group .. "#" .. icon .. "%*"
              end,
              action = function(clicks, button, modifiers)
                local dap_inst = require("dap")
                local alt = clicks > 1 or button ~= "l" or modifiers:gsub(" ", "") ~= ""
                if not dap_inst.session() then
                  dap_inst.run_last()
                elseif alt then
                  dap_inst.disconnect()
                else
                  dap_inst.terminate()
                end
              end,
            },
          },
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
        enabled = false,
        position = "inline",
        format = function(variable, _, _) return " " .. variable.value end,
        prefix = function(position, node, bufnr)
          if position == "eol" or position == "eol_right_align" then
            local name = vim.treesitter.get_node_text(node, bufnr)
            return name .. " ="
          end
        end,
        suffix = function(position, _, _, var_index, num_var_line)
          if position == "eol" or position == "eol_right_align" then
            return var_index == num_var_line and "" or ","
          end
        end,
      },
      switchbuf = "usetab,uselast",
      auto_toggle = false,
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
