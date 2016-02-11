{CompositeDisposable} = require 'atom'

module.exports = AtomDynamicMacro =
  subscriptions: null
  repeatedKeys: []

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
    # console.log res
    res

  normalKey: (key) ->
    controlKeys = [
      'Enter', 'Delete', 'Backspace', 'Tab', 'Escape'
      'Up', 'Down', 'Left', 'Right'
      'PageUp', 'PageDown', 'Home', 'End'
    ]
    key.keyCode >= 32 && ! (key.keyIdentifier in controlKeys)

  execute: -> # Dynamic Macro実行
    editor = atom.workspace.getActiveTextEditor()
    # view = atom.views.getView(editor)

    seq = window.keySequence
    #console.log seq

    if seq[seq.length-2].keyIdentifier == "U+0054" &&
      seq[seq.length-2].ctrlKey # Ctrl-t 連打
    else # 繰り返しを捜す
      @repeatedKeys = @findRep seq[0...seq.length-2], (x,y) ->
        x.keyIdentifier == y.keyIdentifier
    for key in @repeatedKeys # 繰り返されたキー操作列を再実行
      # console.log key.keyIdentifier
      if @normalKey(key)
        if key.keyCode == 32 # 何故かスペースだけうまくいかないので
          editor.insertText(" ")
        else
          atom.keymaps.simulateTextInput(key)
      else
        atom.keymaps.handleKeyboardEvent(key)
