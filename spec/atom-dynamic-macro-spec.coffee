helpers = require './spec-helper'

# {AtomDynamicMacro} = require '../lib/atom-dynamic-macro' こんなもの要らない?

describe "Spec for Dynamic Macro", ->
  [editor, editorElement] = []

  beforeEach ->
    # dm = atom.packages.loadPackage('atom-dynamic-macro')
    #dm.activateResources()

    helpers.getEditorElement (element) ->
      editorElement = element
      editor = editorElement.getModel()

  keydown = (key, options={}) ->
    options.element ?= editorElement
    helpers.keydown(key, options)

  describe "Dynamic Macro Test", ->
    beforeEach ->
      editor.setText("")
      # editor.setCursorBufferPosition([0, 3])

    describe "Test dynamic macro", ->
      it "try Dynamic Macro", ->
        keydown "a"
        keydown "b"
        keydown "a"
        keydown "b"
        expect(editor.getText()).toBe "abab"
        keydown "a", ctrl: true
        keydown "t", ctrl: true
        #alert editor.getCursorBufferPosition()
        # expect(editor.getText()).toBe "ababab" # fail
        #alert editor.getText()
        # alert editor.getText()
        #expect(editor.getText().length).toEqual(3)                 # これは動く
        #expect(editor.getCursorBufferPosition()).toEqual([0, 3])   # これもOK
