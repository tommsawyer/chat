Utils = require('../utils/utils')

class Client
	constructor: (@id, @ws) ->
		@room = null
		@inSearch = true

	sendMessage: (msg) ->
		@ws.send(msg)

	sendMessageToRoom: (msg) ->
		unless @room == null
			@room.sendMessage(@, msg)

	isInSearch: ->
		@inSearch
	isInRoom: ->
		not room == null

	enterRoom: (room) ->
		@inSearch = false
		@room = room
		@sendMessage Utils.generateAnswer 'room', 'Соединение с собеседником установлено'

	exitRoom: ->
		@room.clientExit @ unless @room == null
		@room = null

module.exports = Client