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
	exitRoom: ->
		@inRoom = false
		@room = null


module.exports = Client