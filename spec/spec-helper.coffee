#
# 以下のvim-modeのspecをコピーしてきたもの
# https://github.com/atom/vim-mode/blob/master/spec/spec-helper.coffee
#
# addEventListenerのところを変更してある。
#

dynamicMacro = require '../lib/atom-dynamic-macro'

beforeEach ->
  atom.workspace ||= {}
  
getEditorElement = (callback) ->
  textEditor = null

  waitsForPromise ->
    atom.workspace.open().then (e) ->
      textEditor = e

  runs ->
    element = atom.views.getView(textEditor)
    element.setUpdatedSynchronously(true)

    dynamicMacro.seq = []

    element.addEventListener "keydown", (e) ->
      seq = dynamicMacro.seq
      seq.push(event)
      seq.shift() if seq.length > 100
      
      #if e.ctrlKey
      atom.keymaps.handleKeyboardEvent(e)
      #else
        #s = String.fromCharCode(parseInt(e.keyIdentifier[2..-1],16)) # "U+0065" => "A"
        #e.path[0].getModel().insertText(s)
        #atom.keymaps.simulateTextInput(e)
        
    element.addEventListener "textInput", (e) ->
      if e.data.match(/^U/)
        s = String.fromCharCode(parseInt(e.data[2..-1],16)) # "U+0065" => "A"
      else
        s = e.data
      e.path[0].getModel().insertText(s)
      
      #atom.keymaps.simulateTextInput(e)
      #console.log e
        
    # mock parent element for the text editor
    document.createElement("html").appendChild(element)

    callback(element)

mockPlatform = (editorElement, platform) ->
  wrapper = document.createElement('div')
  wrapper.className = platform
  wrapper.appendChild(editorElement)

unmockPlatform = (editorElement) ->
  editorElement.parentNode.removeChild(editorElement)

dispatchKeyboardEvent = (target, eventArgs...) ->
  e = document.createEvent('KeyboardEvent')
  e.initKeyboardEvent(eventArgs...)
  # 0 is the default, and it's valid ASCII, but it's wrong.
  # Object.defineProperty(e, 'keyCode', get: -> undefined) if e.keyCode is 0
  Object.defineProperty(e, 'keyCode', get: -> 40) # e.keyCode を設定するため???
  target.dispatchEvent e

dispatchTextEvent = (target, eventArgs...) ->
  e = document.createEvent('TextEvent')
  e.initTextEvent(eventArgs...)
  target.dispatchEvent e

keydown = (key, {element, ctrl, shift, alt, meta, raw}={}) ->
  key = "U+#{key.charCodeAt(0).toString(16)}" unless key is 'escape' or raw?
  element ||= document.activeElement
  eventArgs = [
    false, # bubbles
    true, # cancelable
    null, # view
    key,  # key
    0,    # location
    ctrl, alt, shift, meta
  ]

  canceled = not dispatchKeyboardEvent(element, 'keydown', eventArgs...)
  dispatchKeyboardEvent(element, 'keypress', eventArgs...)
  if not canceled
    if dispatchTextEvent(element, 'textInput', eventArgs...)
      element.value += key
  dispatchKeyboardEvent(element, 'keyup', eventArgs...)

module.exports = {keydown, getEditorElement, mockPlatform, unmockPlatform}
