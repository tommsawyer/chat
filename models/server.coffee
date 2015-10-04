Client 	       = require './client'
WebSocket = new require 'ws'
Router         = require '../route/router'
Logger          = require '../utils/logger'
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

		@webSocketServer.on 'connection', (ws) =>
			id = Math.random()
			client = new Client id, ws
			@clients.push client

			@logger.info "Подключился новый клиент с ID = #{id}"

			ws.on 'close', =>
				@clients.splice @clients.indexOf(client), 1
				@logger.info "Отсоединился клиент с ID = #{client.id}"

			ws.on 'message', (msg) =>
				@logger.info "Получена команда '#{msg}' от #{client.id}"
				ws.send @router.parseCommand client, msg

	getClientByWs: (ws) ->
		for client in @clients
			return client if client.ws == ws
		return null

	activeClients: ->
		@clients.length

	isEmpty: ->
		@clients.length == 0

module.exports = new Server