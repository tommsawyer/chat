fs = require ('fs')

class Router
	constructor: (@server) ->
		try
			@config = JSON.parse fs.readFileSync "configs/route.json"
			@controllers = {}

			for controller in Object.keys(@config.controllers)
				controllerClass = require @config.controllers[controller]
				@controllers[controller] = new controllerClass @server

		catch e
			@server.logger.error "Невозможно загрузить конфиги - #{e.message}"
			process.exit -1		

	parseCommand: (client, command) ->
		cmd = ""
		try
			cmd = JSON.parse(command)
		catch exception
			@server.logger.error "Некорректный JSON в команде #{command}"
			return @answer "Ошибка", "Некорректный JSON в команде #{command}"
		
		return @answer "Ошибка", "Нет полей type, data" unless cmd.data && cmd.type

		try
			@executeCommand(client, cmd)
		catch exception
			@server.logger.error exception.message
			return @answer "Ошибка", "Неизвестная ошибка на сервере"

	executeCommand: (client, command) ->
		route = @config[command.type]
		return @answer "Ошибка", 'Незвестная команда' if route == undefined

		@answer command.type, @controllers[route.controller][route.method](command.data)

	answer: (type, data) ->
		JSON.stringify {
			type: type,
			data: data
		}

module.exports = Router