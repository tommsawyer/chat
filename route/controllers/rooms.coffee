Room = require '../../models/room'

class Rooms
	constructor: (@server) ->

	createChat: (client, params) =>
		participants = params.participants.map (clientID) =>
			@server.getClientById(clientID)
		room = new Room participants, params.name	
		@server.rooms.push room
		return "#{room.id}"

	enterRoom: (client, params) ->
		room = @server.getRoomByID(params.id)
		room.addParticipant client if room != null && !room.isClientInRoom client

	getRooms: (client, params) ->
		do @server.getRooms

	getHistory: (client, params) ->
		if client.room
			do client.room.getHistory

	showRoomInfo: (client, params) ->
		if params.id
			room = @server.getRoomByID params.id
			return room.getInfo() unless room == null
		do client.room.getInfo unless client.room == null

module.exports = Rooms