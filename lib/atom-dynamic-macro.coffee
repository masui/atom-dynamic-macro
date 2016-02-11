{CompositeDisposable} = require 'atom'

module.exports = AtomDynamicMacro =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-dynamic-macro:execute': => @execute()

  deactivate: ->
    @subscriptions.dispose()
    @atomDynamicMacroView.destroy()

  serialize: ->

  controlKey: (e) ->
    e.keyIdentifier.match(/Enter|Up|Down|Left|Right|PageUp|PageDown|Escape|Backspace|Delete|Tab|Home|End/) ||
    e.keyCode < 32

  execute: ->
    seq = window.keySequence
    console.log seq.length
    cmd = seq[seq.length-3] # Ctrl-Tの直前

    editor = atom.workspace.getActiveTextEditor()
    view = atom.views.getView(editor)

    #command_name = "editor:move-to-end-of-line"
    #atom.commands.dispatch(view, command_name)

    # atom.keymaps.simulateTextInput("A\n")
    console.log cmd
    if @controlKey(cmd)
      atom.keymaps.handleKeyboardEvent(cmd)
    else
      atom.keymaps.simulateTextInput(cmd)

    # # findKeyBindingsはctrl- とかだけに効くようだ
    # bindings = atom.keymaps.findKeyBindings({keystrokes: "ctrl-e", target: view})
    # #bindings = atom.keymaps.findKeyBindings({keystrokes: "a"})

    # console.log bindings
    # command_name = bindings.command
    # if !command_name
    #   #console.log('bindings', bindings)
    #   bind = bindings[0]
    #   command_name = bind.command
    # console.log command_name
    # atom.commands.dispatch(view, command_name)

    #if editor = atom.workspace.getActiveTextEditor()
    #  # editor.insertText('Hello, World!!!!')
    #  # 本当はここでDynamicMacroみたいなことをしたい
    #  # window.keySequence[]を調べる
