# set PATH
{execSync} = require 'child_process'
try
  process.env.PATH = execSync "#{process.env.SHELL} -c 'echo $PATH'"
catch e
  console.error e

# visual modeで選択しているラインの最初にマルチカーソルをつくる
atom.workspaceView.command 'custom:beginning-multi-cursor', ->
  dispachCommand(
    'editor:split-selections-into-lines'
    'vim-mode:activate-command-mode'
    'vim-mode:move-to-beginning-of-line'
  )

# visual modeのときcmd-cのcopyでvisual mode抜けるようにする
atom.workspaceView.command 'custom:copy-and-exit-visual-mode', ->
  dispachCommand 'core:copy', 'vim-mode:activate-command-mode'

# toolbar
atom.packages.activatePackage('toolbar').then (pkg) =>
  @toolbar = pkg.mainModule
  @toolbar.appendButton 'octoface', (-> dispachCommand 'open-on-github:repository'), 'Open On GitHub'
  @toolbar.appendButton 'link-external', 'open-in-browser:open', 'Open In Browser'
  @toolbar.appendButton 'terminal', 'term2:open', 'Term2 Open'
  @toolbar.appendButton 'gear', 'settings-view:open', 'Open Settings View'

dispachCommand = (commands...) ->
  editor = atom.workspace.getActiveTextEditor()
  editorView = atom.views.getView(editor)
  commands.forEach (command) -> atom.commands.dispatch(editorView, command)
