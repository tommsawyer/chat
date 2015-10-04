Client 	       = require './client'
WebSocket = new require 'ws'
Router         = require '../route/router'
Logger          = require '../utils/logger'
Room           = require './room'
fs 	       = require 'fs'

class Server
	constructor: ->
		@configs = JSON.parse fs.readFileSync 'configs/server.json'
		@clients  = []
		@logger   = new Logger @configs.loggerLevel
		@router   = new Router  @

	start: (port, host) ->
		@webSocketServer = new WebSocket.Server {
			port: port,
			host: host
		}

		@logger.info "Сервер запущен на #{host}, порт - #{port}"

		setInterval =>
		 	do @searchCompanions
		 , 1000

		@webSocketServer.on 'connection', (ws) =>
			id = Math.random()
			client = new Client id, ws
			@clients.push client

			@logger.info "Подключился новый клиент с ID = #{id}"

			ws.on 'close', =>
				do client.exitRoom
				@clients.splice @clients.indexOf(client), 1
				@logger.info "Отсоединился клиент с ID = #{client.id}"

			ws.on 'message', (msg) =>
				@logger.info "Получена команда '#{msg}' от #{client.id}"
				ws.send @router.parseCommand client, msg

	searchCompanions: ->
		clients = do @clientsInSearch
		while clients.length > 1
			new Room(clients[0], clients[1])
			@logger.info "Соединяю #{clients[0].id} с #{clients[1].id}"
			clients.splice 0, 2

	getClientByWs: (ws) ->
		for client in @clients
			return client if client.ws == ws
		return null

	activeClients: ->
		@clients.length

	clientsInSearch: ->
		results = []
		results.push client for client in @clients when client.isInSearch()
		results

	isEmpty: ->
		@clients.length == 0

module.exports = new Server