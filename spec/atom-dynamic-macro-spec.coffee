AtomDynamicMacro = require '../lib/atom-dynamic-macro'
{Emitter} = require 'atom'

describe "AtomDynamicMacro", ->
  [editor, emitter] = []
  
  beforeEach ->
    waitsForPromise ->
      atom.workspace.open 'sample.txt' # どこかに新規作成するのだろうか?
      
    runs ->
      emitter = new Emitter
      editor = atom.workspace.getActiveTextEditor()
      editor.insertText "abc"

  it "should be opened in an editor", ->
    editor = atom.workspace.getActiveTextEditor()
    alert editor
    expect(editor.getPath()).toContain 'sample'
    expect(editor.getText().length).toEqual(3)
    # キーイベントを発生させる方法が不明
    # emitter.emit "keydown", "a"
    editor.insertText "a"
    expect(editor.getText().length).toEqual(4)


#  it "has some expectations that should pass", ->
#    expect("apples").toEqual("apple")
#    expect("oranges").not.toEqual("apples")
#    alert 100
    
#
# # Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
# #
# # To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# # or `fdescribe`). Remove the `f` to unfocus the block.
#
# describe "AtomDynamicMacro", ->
#   [workspaceElement, activationPromise] = []
#
#   beforeEach ->
#     workspaceElement = atom.views.getView(atom.workspace)
#     activationPromise = atom.packages.activatePackage('dynamic-macro')
#
#   describe "when the dynamic-macro:toggle event is triggered", ->
#     it "hides and shows the modal panel", ->
#       # Before the activation event the view is not on the DOM, and no panel
#       # has been created
#       expect(workspaceElement.querySelector('.dynamic-macro')).not.toExist()
#
#       # This is an activation event, triggering it will cause the package to be
#       # activated.
#       atom.commands.dispatch workspaceElement, 'dynamic-macro:toggle'
#
#       waitsForPromise ->
#         activationPromise
#
#       runs ->
#         expect(workspaceElement.querySelector('.dynamic-macro')).toExist()
#
#         atomDynamicMacroElement = workspaceElement.querySelector('.dynamic-macro')
#         expect(atomDynamicMacroElement).toExist()
#
#         atomDynamicMacroPanel = atom.workspace.panelForItem(atomDynamicMacroElement)
#         expect(atomDynamicMacroPanel.isVisible()).toBe true
#         atom.commands.dispatch workspaceElement, 'dynamic-macro:toggle'
#         expect(atomDynamicMacroPanel.isVisible()).toBe false
#
#     it "hides and shows the view", ->
#       # This test shows you an integration test testing at the view level.
#
#       # Attaching the workspaceElement to the DOM is required to allow the
#       # `toBeVisible()` matchers to work. Anything testing visibility or focus
#       # requires that the workspaceElement is on the DOM. Tests that attach the
#       # workspaceElement to the DOM are generally slower than those off DOM.
#       jasmine.attachToDOM(workspaceElement)
#
#       expect(workspaceElement.querySelector('.dynamic-macro')).not.toExist()
#
#       # This is an activation event, triggering it causes the package to be
#       # activated.
#       atom.commands.dispatch workspaceElement, 'dynamic-macro:toggle'
#
#       waitsForPromise ->
#         activationPromise
#
#       runs ->
#         # Now we can test for view visibility
#         atomDynamicMacroElement = workspaceElement.querySelector('.dynamic-macro')
#         expect(atomDynamicMacroElement).toBeVisible()
#         atom.commands.dispatch workspaceElement, 'dynamic-macro:toggle'
#         expect(atomDynamicMacroElement).not.toBeVisible()
