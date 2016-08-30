window.namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

# ###
# # Elegant pattern to simulate namespace in CoffeeScript
# #
# # @author Maks
# ###

# do (root = global ? window) ->

#   fn = ->

#     args   = arguments[0]
#     target = root

#     loop
#       for subpackage, obj of args
#         target = target[subpackage] or= {}
#         args   = obj
#       break unless typeof args is 'object'

#     Class        = args
#     target       = root if arguments[0].hasOwnProperty 'global'
#     name         = Class.toString().match(/^function\s(\w+)\(/)[1]
#     target[name] = Class

#   # Aliases
#   root.namespace = fn
#   root.module    = fn