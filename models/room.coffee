Utils = require('../utils/utils')

class Room
	constructor: (@firstCompanion, @secondCompanion) ->
		@firstCompanion.enterRoom @
		@secondCompanion.enterRoom @

	sendMessage: (from, msg) ->
		if from == @firstCompanion
			@secondCompanion.sendMessage(Utils.generateAnswer 'message', msg)
			return @secondCompanion
		else
			@firstCompanion.sendMessage(Utils.generateAnswer 'message', msg)
			return @firstCompanion

	isBothCompanionsActive: ->
		@firstCompanion.room == @ && @secondCompanion.room == @

	clientExit: (client) ->
		@sendMessage(client, 'Соединение с собеседником разорвано').room = null

module.exports = Room