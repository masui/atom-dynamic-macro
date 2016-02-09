AtomDynamicMacroView = require './atom-dynamic-macro-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomDynamicMacro =
  atomDynamicMacroView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomDynamicMacroView = new AtomDynamicMacroView(state.atomDynamicMacroViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomDynamicMacroView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-dynamic-macro:execute': => @execute()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomDynamicMacroView.destroy()

  serialize: ->
    atomDynamicMacroViewState: @atomDynamicMacroView.serialize()

  execute: ->
    console.log 'AtomDynamicMacro executed!'

    if editor = atom.workspace.getActiveTextEditor()
      editor.insertText('Hello, World!!!!')
