a = [1,2,3,4,5,1,2,3,4,5]

#
#
#
find_x = (a) ->
  len = a.length
  for i in [0...len/2-1]
    for j in [0..i]
      # console.log "compare #{len-3-j} and #{len-4-i-j}"
      break if a[len-3-j] != a[len-4-i-j]
  # console.log j
  a[len-2-j..len-3]

#
# 配列の最後に繰り返しがあればその配列を返す
# 
# findRep [1,2,3]                     # => []
# findRep [1,2,3,3]                   # => [3]
# findRep [1,2,3,1,2,3]               # => [1,2,3]
# findRep [1,2,3,3,1,2,3,3]           # => [1,2,3,3]
# findRep [1,2,3], (x,y) -> x+1 == y  # => [3]
#
findRep = (a,compfunc) ->
  compfunc = compfunc ? (a,b) -> a == b
  len = a.length
  res = []
  for i in [0...len/2]
    for j in [0..i]
      break unless compfunc(a[len-2-i-j], a[len-1-j])
    res = a[len-j..len-1] if i == j-1
  res
    
# console.log findRep a
  
# console.log findRep a, (x,y) ->
#   x+1 == y 

console.log findRep [1,2,3]                     # => []
console.log findRep [1,2,3,3]                   # => [3]
console.log findRep [1,2,3,1,2,3]               # => [1,2,3]
console.log findRep [1,2,3,3,1,2,3,3]           # => [1,2,3,3]
console.log findRep [1,2,3], (x,y) -> x+1 == y  # => [3]






