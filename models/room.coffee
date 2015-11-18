Utils = require('../utils/utils')

class Room
	constructor: (@participants, @name) ->
		@id = do Math.random
		@messages = []
		for client in @participants
			client.enterRoom @

	sendMessage: (from, msg) ->
		timeString = new Date().toTimeString().split(' ')[0] # отрезаем часть с MSK
		message    = {
			"message": 		msg, 
			"time":         		timeString, 
			"senderID":        from.id,
			"senderName": from.getNickname()
		}
		@messages.push message
		client.sendMessage(Utils.generateAnswer 'message',  message) for client in @participants when client.online

	getHistory: () ->
		msgPosition = @messages.length - Math.min(@messages.length, 50)
		@messages.slice msgPosition

	getInfo: ->
		{
			id: @id,
			name: @name,
			participants: @participants.map (client) ->
				{ 
					id: client.id,
					name: client.getNickname(),
					isOnline: client.online
				}
		}

	clientExit: (client) ->

class PublicRoom extends Room
	addParticipant: (client) ->
		@participants.push client
		client.enterRoom @
		@sendMessage client, "Подключился ID = #{client.id}"

module.exports = PublicRoom