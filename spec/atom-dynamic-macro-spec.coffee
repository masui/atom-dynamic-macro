helpers = require './spec-helper'

describe "Insert mode commands", ->
  [editor, editorElement] = []

  beforeEach ->
    helpers.getEditorElement (element) ->
      editorElement = element
      editor = editorElement.getModel()

  keydown = (key, options={}) ->
    options.element ?= editorElement
    helpers.keydown(key, options)
    
  describe "Dynamic Macro Test", ->
    beforeEach ->
      editor.setText("abc")
      editor.setCursorBufferPosition([0, 3])

    describe "Test dynamic macro", ->
      it "try Dynamic Macro", ->
        # editor.insertText("abc")
        expect(editor.getText().length).toEqual(3)                 # これは動く
        expect(editor.getCursorBufferPosition()).toEqual([0, 3])   # これもOK
    
        keydown "a"
        expect(editor.getText().length).toEqual(4)
