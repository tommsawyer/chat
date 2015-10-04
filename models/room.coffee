Utils = require('../utils/utils')

class Room
	constructor: (@firstCompanion, @secondCompanion) ->
		@firstCompanion.enterRoom @
		@secondCompanion.enterRoom @

	sendMessage: (from, msg) ->
		if from == @firstCompanion
			@secondCompanion.sendMessage(Utils.generateAnswer 'message', msg)
		else
			@firstCompanion.sendMessage(Utils.generateAnswer 'message', msg)

module.exports = Room