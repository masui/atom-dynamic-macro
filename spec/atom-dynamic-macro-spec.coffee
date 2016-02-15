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

  it "should be opened in an editor", ->
    #expect(editor.getPath()).toContain 'sample'

    editor.insertText("abc")
    expect(editor.getText().length).toEqual(3)
    # editor.setCursorBufferPosition([0, 3])

    expect(editor.getCursorBufferPosition()).toEqual([0, 3])

    keydown "a", {element:editorElement}
    alert editor.getText()
    
    # editor.insertText("c")
    expect(editor.getText().length).toEqual(4)
    
    # キーイベントを発生させる方法が不明
    
    #workspaceElement = atom.views.getView(atom.workspace)
    #editorElement = atom.views.getView(editor)

