{CompositeDisposable} = require 'atom'

module.exports = AtomDynamicMacro =
  subscriptions: null
  repeatedCommands: []

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-dynamic-macro:execute': => @execute()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  #
  # 配列の最後に繰り返しがあればその配列を返す
  #
  # findRep [1,2,3]                     # => []
  # findRep [1,2,3,3]                   # => [3]
  # findRep [1,2,3,1,2,3]               # => [1,2,3]
  # findRep [1,2,3,3,1,2,3,3]           # => [1,2,3,3]
  # findRep [1,2,3], (x,y) -> x+1 == y  # => [3]
  #
  findRep: (a,compare) ->
    compare = compare ? (x,y) -> x == y
    len = a.length
    res = []
    for i in [0...len/2]
      for j in [0..i]
        break unless compare(a[len-2-i-j], a[len-1-j])
      res = a[len-j..len-1] if i == j-1
    res

  controlKey: (e) ->
    e.keyIdentifier.match(/Enter|Up|Down|Left|Right|PageUp|PageDown|Escape|Backspace|Delete|Tab|Home|End/) ||
    e.keyCode < 32

  execute: ->
    seq = window.keySequence

    console.log seq

    if seq[seq.length-2].keyIdentifier == "U+0054" &&
      seq[seq.length-2].ctrlKey
    else
      @repeatedCommands = @findRep seq[0...seq.length-2], (x,y) ->
        x.keyIdentifier == y.keyIdentifier
    for cmd in @repeatedCommands
      if @controlKey(cmd)
        atom.keymaps.handleKeyboardEvent(cmd)
      else
        atom.keymaps.simulateTextInput(cmd)

    #editor = atom.workspace.getActiveTextEditor()
    #view = atom.views.getView(editor)

    # 名前からコマンドを呼ぶ場合
    #command_name = "editor:move-to-end-of-line"
    #atom.commands.dispatch(view, command_name)

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
