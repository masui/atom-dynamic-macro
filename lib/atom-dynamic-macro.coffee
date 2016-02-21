{CompositeDisposable} = require 'atom'

module.exports = AtomDynamicMacro =
  subscriptions: null
  repeatedKeys: []

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-dynamic-macro:execute': => @execute()

    #
    # @activate() called immediately after loading this package
    # (by removing "activationCommands" part from package.json)
    #
    # Record all key strokes in @spec
    @seq = []
    handler = (event) ->
      seq = AtomDynamicMacro.seq
      seq.push(event)
      seq.shift() if seq.length > 100
    document.addEventListener 'keydown', handler, true

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  #
  # Detect repeated elements at the end of an array
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

  execute: -> # Dynamic Macro execution
    editor = atom.workspace.getActiveTextEditor()
    if @seq[@seq.length-2].keyIdentifier == "U+0054" &&
      @seq[@seq.length-2].ctrlKey # typing Ctrl-t repeatedly
    else # Find a repeated keystrokes
      @repeatedKeys = @findRep @seq[0...@seq.length-2], (x,y) ->
        x && y && x.keyIdentifier == y.keyIdentifier
    for key in @repeatedKeys # Re-execute repeated key strokes
      if @normalKey(key)
        if key.ctrlKey
          atom.keymaps.handleKeyboardEvent(key)
        else
          if key.keyCode == 32 # Special handling for space key
            editor.insertText(" ")
          else
            atom.keymaps.simulateTextInput(key)
      else
        atom.keymaps.handleKeyboardEvent(key)
