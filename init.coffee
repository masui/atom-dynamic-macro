#
# キー入力をすべて配列に格納しておく
#
window.keySequence = []

dynamic_macro_handler = (event) ->
  seq = window.keySequence
  seq.push(event)
  seq.shift() if seq.length > 100

document.addEventListener 'keydown', dynamic_macro_handler, true
