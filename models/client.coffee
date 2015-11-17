Utils = require('../utils/utils')

class Client
	constructor: (@id, @ws) ->
		@room = null
		@name =null
		@online = true

	sendMessage: (msg) ->
		@ws.send(msg)

	sendMessageToRoom: (msg) ->
		unless @room == null
			@room.sendMessage(@, msg)

	isInRoom: ->
		not room == null

	setNickname: (nickname) ->
		@name = nickname

	getNickname: ->
		@name || @id

	enterRoom: (room) ->
		@inSearch = false
		@room = room
		@sendMessage Utils.generateAnswer 'room', "Соединение с комнатой #{room.id} установлено"

	exitRoom: ->
		@room.clientExit @ unless @room == null
		@room = null

	setOffline: ->
		@online = false

module.exports = Client