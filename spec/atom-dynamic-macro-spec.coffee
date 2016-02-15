AtomDynamicMacro = require '../lib/atom-dynamic-macro'

helpers = require './spec-helper'

describe "AtomDynamicMacro", ->
  [editor, editorElement] = []

  beforeEach ->
    helpers.getEditorElement (element) ->
      editorElement = element
      editor = editorElement.getModel()

  keydown = (key, options={}) ->
    options.element ?= editorElement
    helpers.keydown(key, options)

  it "try Dynamic Macro", ->
    editor.insertText("abc")
    expect(editor.getText().length).toEqual(3)
    # editor.setCursorBufferPosition([0, 3])

    expect(editor.getCursorBufferPosition()).toEqual([0, 3])

    keydown "a", {element:editorElement}
    expect(editor.getText()).toBe 'abca'
    
    # editor.insertText("c")
    # expect(editor.getText().length).toEqual(4)

    #workspaceElement = atom.views.getView(atom.workspace)
    #editorElement = atom.views.getView(editor)

