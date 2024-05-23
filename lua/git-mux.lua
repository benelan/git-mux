---To setup the Wezterm integration for `git-mux`, first clone this repo to `~/.git-mux`. Then, add the following to your Wezterm config:
---```lua
---package.path = wezterm.home_dir .. "/.git-mux/lua/?.lua;" ..  package.path
---require("git-mux").setup()
---```
---The Wezterm type definitions used in this module are from <https://github.com/benelan/wezterm-types>.
---@author Ben Elan
---@license MIT
---@module 'git-mux'
local M = {}

---@type Wezterm
local wezterm = require("wezterm")

---Equivalent to POSIX basename(3)
---Given "/foo/bar" returns "bar"
---Given "c:\\foo\\bar" returns "bar"
---@param path string
---@return string name the basename of the path
local function basename(path)
  local name = string.gsub(path, "(.*[/\\])(.*)", "%2")
  return name
end

---Switch to a project (Wezterm workspace) directly or select one interactively if a path is omitted.
---
---This function can be called from a Wezterm keybinding, for example navigating to a path saved in an environment variable:
---```lua
---{
---  key = "n",
---  mods = "LEADER|CTRL",
---  action = wezterm.action_callback(
---    function(window, pane)
---      require("git-mux").project(window, pane, { path = os.getenv("NOTES") })
---    end
---  ),
---}
---```
---@param window Window the current Wezterm window
---@param pane Pane the current Wezterm pane
---@param opts { path?: string, args?: table<string> } | nil The path to the project and a command to run when spawning a Wezterm workspace.
M.project = function(window, pane, opts)
  if not opts or not opts.path then
    M.select_project(window, pane)
    return
  end

  local name = basename(opts.path)
  wezterm.GLOBAL.git_mux_previous_project = wezterm.mux.get_active_workspace()

  window:perform_action(
    wezterm.action.SwitchToWorkspace({
      name = name,
      spawn = {
        label = "Project: " .. name,
        cwd = opts.path,
        args = opts.args,
      },
    }),
    pane
  )

  -- kill the temporary pane created by git-mux, if it exists
  if wezterm.GLOBAL.git_mux_pane_id then
    wezterm.background_child_process({
      "wezterm",
      "cli",
      "kill-pane",
      "--pane-id",
      wezterm.GLOBAL.git_mux_pane_id,
    })

    wezterm.GLOBAL.git_mux_pane_id = nil
  end

  wezterm.log_info(string.format('git-mux > switched to project "%s"', opts.path))
end

---Interactively select a project. See the ENVIRONMENT section of `man git-mux` for info about defining the projects list.
---
---This function can be called from a Wezterm keybinding, for example:
---```lua
---{
---  key = "p",
---  mods = "LEADER|CTRL",
---  action = wezterm.action_callback(require("git-mux").select_project),
---}
---```
---@param window Window The current Wezterm window
---@param pane Pane the current Wezterm pane
---@param args? table<string> A command and its arguments to run when spawning a Wezterm workspace. If omitted, the default program for the target domain will be spawned.
M.select_project = function(window, pane, args)
  local project_parents = wezterm.shell_split(os.getenv("GIT_MUX_PROJECT_PARENTS") or "")
  local projects = wezterm.shell_split(os.getenv("GIT_MUX_PROJECTS") or "")
  local workspaces = {}

  if #projects > 0 then
    for _, project in ipairs(projects) do
      table.insert(workspaces, { id = project, label = project })
    end
  end

  if #project_parents > 0 then
    for _, parent in ipairs(project_parents) do
      for _, project in ipairs(wezterm.read_dir(parent)) do
        table.insert(workspaces, { id = project, label = project })
      end
    end
  end

  if #workspaces == 0 then
    wezterm.log_error("git-mux > no projects found")
    return
  end

  window:perform_action(
    wezterm.action.InputSelector({
      action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
        if not id and not label then
          wezterm.log_info("git-mux > project selection cancelled")
        else
          local name = basename(label)

          local spawn = { label = "Project: " .. name, cwd = id }
          if args then
            spawn.args = args
          end

          inner_window:perform_action(wezterm.action.SwitchToWorkspace({ name = name, spawn = spawn }), inner_pane)

          wezterm.log_info(string.format('git-mux > interactively selected and switched to project "%s"', label))
        end
      end),
      title = "Choose Project",
      choices = workspaces,
      fuzzy = true,
      fuzzy_description = "Find and select a project...  ",
    }),
    pane
  )
end

---Setup a `user-var-changed` listener so the project (Wezterm workspace) can be switched from the `git-mux` shell script.
---For info about why this is necessary, see <https://github.com/wez/wezterm/issues/3542>.
M.setup = function()
  wezterm.on("user-var-changed", function(window, pane, name, value)
    if name ~= "git-mux" then
      return
    end

    local args = wezterm.shell_split(value)
    local cmd = table.remove(args, 1)

    if cmd == "project" then
      if #args > 0 then
        local dir = table.remove(args, 1)
        M.project(window, pane, { path = dir, args = args })
      else
        M.project(window, pane)
      end
    end
  end)
end

return M
