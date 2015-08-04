# set PATH
{execSync} = require 'child_process'
try
  process.env.PATH = execSync "#{process.env.SHELL} -c 'echo $PATH'"
catch e
  console.error e

# visual modeのときcmd-cのcopyでvisual mode抜けるようにする
atom.commands.add 'atom-workspace', 'custom:copy-and-exit-visual-mode', ->
  dispachCommand 'core:copy', 'vim-mode-plus:activate-normal-mode'

dispachCommand = (commands...) ->
  editor = atom.workspace.getActiveTextEditor()
  editorView = atom.views.getView(editor)
  commands.forEach (command) -> atom.commands.dispatch(editorView, command)
