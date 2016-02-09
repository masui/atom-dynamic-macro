{CompositeDisposable} = require 'atom'

module.exports = AtomDynamicMacro =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-dynamic-macro:execute': => @execute()

  deactivate: ->
    @subscriptions.dispose()
    @atomDynamicMacroView.destroy()

  serialize: ->

  execute: ->
    console.log 'DynamicMacro executed!'

    if editor = atom.workspace.getActiveTextEditor()
      editor.insertText('Hello, World!!!!')
