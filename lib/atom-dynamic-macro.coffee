{CompositeDisposable} = require 'atom'

module.exports = AtomDynamicMacro =
  subscriptions: null
  repeatedKeys: []

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-dynamic-macro:execute': => @execute()
    #
    # package.jsonでactivationをディレイするのをやめて、パッケージロード時にこの初期化処理がすぐ実行されるようにする
    #
    @seq = []
    handler = (event) ->
      @seq.push(event)
      @seq.shift() if seq.length > 100
    document.addEventListener 'keydown', handler, true

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

  modifierKey: (key) ->
    key.keyIdentifier in [
      'Control', 'Alt', 'Shift', 'Meta'
    ]

  specialKey: (key) ->
    key.keyIdentifier in [
      'Enter', 'Delete', 'Backspace', 'Tab', 'Escape'
      'Up', 'Down', 'Left', 'Right'
      'PageUp', 'PageDown', 'Home', 'End'
    ]
  
  normalKey: (key) ->
    !@modifierKey(key) && !@specialKey(key) && key.keyCode >= 32

  execute: -> # Dynamic Macro実行
    if @seq[@seq.length-2].keyIdentifier == "U+0054" &&
      @seq[@seq.length-2].ctrlKey # Ctrl-t 連打
    else # 繰り返しを捜す
      @repeatedKeys = @findRep @seq[0...@seq.length-2], (x,y) ->
        x.keyIdentifier == y.keyIdentifier
    for key in @repeatedKeys # 繰り返されたキー操作列を再実行
      if @normalKey(key)
        if key.ctrlKey
          atom.keymaps.handleKeyboardEvent(key)
        else
          atom.keymaps.simulateTextInput(key)
      else
        atom.keymaps.handleKeyboardEvent(key)
