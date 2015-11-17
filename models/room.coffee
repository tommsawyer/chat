Utils = require('../utils/utils')

class Room
	constructor: (@participants, @name) ->
		@id = do Math.random
		for client in @participants
			client.enterRoom @

	sendMessage: (from, msg) ->
		client.sendMessage(Utils.generateAnswer 'message', {"message":msg, "sender":from.getNickname()} ) for client in @participants when client.online

	showParticipants: ->
		@participants.map (client) ->
			{ 
				id: client.id,
				name: client.getNickname(),
				isOnline: client.online
			}

	clientExit: (client) ->

class PublicRoom extends Room
	addParticipant: (client) ->
		@participants.push client
		client.enterRoom @
		@sendMessage client, "Подключился ID = #{client.id}"

module.exports = PublicRoom