#
# Keydownイベントを生成してテストしようとしているがどうしてもうまくいかない...2016/02/16 06:52:13
#

AtomDynamicMacro = require '../lib/atom-dynamic-macro'

helpers = require './spec-helper'

describe "AtomDynamicMacro", ->
  [editor, editorElement] = []

  beforeEach ->
    #helpers.getEditorElement (element) ->
    #  # alert "getEditorElement = element is #{JSON.stringify element}"
    #  editorElement = element
    #  # alert JSON.stringify(element)
    #  editor = editorElement.getModel()

    waitsForPromise ->
      atom.workspace.open('sample.txt').then (e) ->
        #atom.workspace.open().then (e) ->
        editor = e
        
    runs ->
      #alert "textEditor = #{textEditor}"
      editorElement = atom.views.getView(editor)
      #alert "element = #{element}"
      
      editorElement.setUpdatedSynchronously(true) # ???

      #editorElement.addEventListener "keydown", (e) ->
      #atom.keymaps.handleKeyboardEvent(e)
      # # mock parent element for the text editor
      # document.createElement("html").appendChild(editorElement)

  # https://github.com/atom/atom-keymap/blob/master/src/helpers.coffee
  characterForKeyboardEvent = (event, dvorakQwertyWorkaroundEnabled) ->
    "a"
    # "U+0061"
    #unless event.ctrlKey or event.altKey or event.metaKey
    #  if key = keyForKeyboardEvent(event, dvorakQwertyWorkaroundEnabled)
    #    key if key.length is 1

  simulateTextInput = (keydownEvent) ->
    if character = characterForKeyboardEvent(keydownEvent, @dvorakQwertyWorkaroundEnabled)
      alert character
      textInputEvent = document.createEvent("TextEvent")
      textInputEvent.initTextEvent("textInput", true, true, window, character)
      keydownEvent.path[0].dispatchEvent(textInputEvent)


  keydown = (key, options={}) ->
    #k = atom.keymaps.constructor.buildKeydownEvent("a", {target: editorElement, ctrl: true})
    #atom.keymaps.handleKeyboardEvent(k); # コントロールキーとかしか効かない

    k = atom.keymaps.constructor.buildKeydownEvent("a", {target: editorElement})
    simulateTextInput(k)
    # atom.keymaps.simulateTextInput(k);

  it "try Dynamic Macro", ->
    editor.insertText("abc")
    expect(editor.getText().length).toEqual(3)                 # これは動く
    expect(editor.getCursorBufferPosition()).toEqual([0, 3])   # これもOK

    #alert editor.getCursorBufferPosition()
    # keydown "a", {element:editorElement}                       # これがダメ
    #alert editor.getCursorBufferPosition()
    
    key = "a"
    e = document.createEvent('KeyboardEvent')
    e.initKeyboardEvent("keydown", false, true, window, key, 0)
    editorElement.dispatchEvent e
    
    e = document.createEvent('KeyboardEvent')
    e.initKeyboardEvent("keypress", false, true, window, key, 0)
    editorElement.dispatchEvent e
    
    e = document.createEvent('TextEvent')
    e.initTextEvent("textInput", false, true, window, key, 0)
    editorElement.dispatchEvent e
    
    e = document.createEvent('KeyboardEvent')
    e.initKeyboardEvent("keyup", false, true, window, key, 0)
    editorElement.dispatchEvent e

    
    expect(editor.getText()).toBe 'abca'
    
    # editor.insertText("c")                                   # これは動くがkeydownイベントが出ないだろう
    # expect(editor.getText().length).toEqual(4)


