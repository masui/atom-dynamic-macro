helpers = require './spec-helper'

dynamicMacro = require '../lib/atom-dynamic-macro'

describe "Testing Dynamic Macro", ->
  [editor, editorElement] = []

  beforeEach ->
    helpers.getEditorElement (element) ->
      editorElement = element              # DOM要素
      editor = editorElement.getModel()    # エディタ本体

  keydown = (key, options={}) ->
    options.element ?= editorElement
    helpers.keydown(key, options)

  describe "Dynamic Macro Test", ->
    beforeEach ->
      editor.setText("")
      # editor.setCursorBufferPosition([0, 3])

    describe "Test dynamic macro", ->
      
      it "try repeat func", ->
        expect(dynamicMacro.findRep([1,2,3])).toEqual []
        expect(dynamicMacro.findRep([1,2,3,3])).toEqual [3]
        expect(dynamicMacro.findRep([1,2,3,1,2,3])).toEqual [1,2,3]
        expect(dynamicMacro.findRep([1,2,3,3,1,2,3,3])).toEqual [1,2,3,3]
      
      #it "try Dynamic Macro", ->
      #  keydown "a"
      #  keydown "b"
      #  keydown "a"
      #  keydown "b"
      #  expect(editor.getText()).toBe "abab"
      #  keydown "a", ctrl: true
      #  keydown "t", ctrl: true
      #  #alert editor.getCursorBufferPosition()
      #  # expect(editor.getText()).toBe "ababab" # fail
      #  #alert editor.getText()
      #  # alert editor.getText()
      #  #expect(editor.getText().length).toEqual(3)                 # これは動く
      #  #expect(editor.getCursorBufferPosition()).toEqual([0, 3])   # これもOK
