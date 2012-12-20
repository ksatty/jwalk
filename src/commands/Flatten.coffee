_ = require 'underscore'
Command = require './Command'

class Flatten extends Command

     constructor: (@commands) ->

     help: ->
          'prints json in a one line'

     run: (context, args, callback) ->
          console.log()
          if _.isObject(context.pointer)
               console.log JSON.stringify(context.pointer)
          else
               console.log context.pointer
          console.log()
          callback()

module.exports = Flatten
