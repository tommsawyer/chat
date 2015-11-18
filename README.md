# chat
анонимный чат на nodejs

запустить **npm install** для установки coffee-script и ws

запустить **node index.js** для запуска сервера


**Роутинговая система:**

Все сообщения кодируются JSONом в формате: 
{"type":"request_type", "data":"request_data"},
где *request_type* - тип запроса,
*request_data* - параметры запроса

Тип и дата обязательно должны присутствовать и не быть пустыми!

**Системные команды:**

*Получение списка активных клиентов -* 

запрос: {"type":"activeclients", data:"adf"}

ответ: {"type":"activeclients", data:[{id:0.123123, name:"nickname"]}
в data будет массив с объектами, в каждом из которых указан айди и никнейм активного клиента

*Смена никнейма*

запрос: {"type":"changenickname", data:"nickname"}

ответ: {"type":"changenickname"}
Сервер изменит никнейм текущего клиента на указанный в data.

*Получение информации о пользователе*

запрос: {"type":"showclientinfo", data:{"id":"0.123123123"}}
ответ: {"type":"showclientinfo","data":{"id":0.123123123,"name":null,"room":0.36891819164156914}}

получает информацию о пользователе: айди, никнейм, комната.

если айди не указан или неправильный, пришлет информацию о пользователе, который прислал запрос.

**Комнаты:**

*Создание комнаты:*

запрос: {"type":"newchat","data":{"participants":[],"name":"room"}}

в participants указывается массив с клиентами, которые подключаются к комнате сразу после создания, в name - название комнаты

*Получение списка всех комнат:*
запрос: {"type":"getrooms","data":"asd"}

ответ:{"type":"getrooms","data":[{"id":0.793122100410983,"name":"room"}]}

в data массив объектов, каждый хранит айди и название комнаты

*Подключение к комнате:*

запрос: {"type":"enterroom","data":{"id":"room_id"}}

где room_id - айди комнаты, в которую входит клиент

ответ: {"type":"room","data":"Соединение с комнатой room_id установлено"}

после подключения к комнате клиент получает историю сообщений в формате:

ответ: {"type":"history","data":[{"message":"Подключился ID = 0.42202995507977903","time":"19:19:14","senderID":0.42202995507977903,"senderName":0.42202995507977903}]}

в data массив с последними 50тью сообщениями, упорядоченный по времени отправления


*Получение информации о комнате:*

запрос: {"type":"showroominfo","data":{"id":"0.36891819164156914"}}

если айди не указан или неправильный, сервер вернет информацию о текущей комнате клиента, посылающего запрос

ответ: {"type":"showroominfo","data":{"id":0.36891819164156914,"name":"newroom","participants":[{"id":0.42202995507977903,"name":0.42202995507977903,"isOnline":true}]}}

в data объект из трех полей: айди, название комнаты и 
participants - массив с объектами, где хранятся id клиентов, их никнеймы и флаг онлайна(хз откуда он вообще)

**Сообщения:**

*Отправление сообщения:* 

запрос: {"type":"sendmessage","data":"сообщение"}

отправляет сообщение в текущую комнату клиента, если она у него есть

*Получение сообщений:*

Если клиент находится в комнате, сервер будет присылать все сообщения, приходящие в эту комнату в виде: 

ответ:{"type":"message","data":{"message":"asdas","time":"20:00:00" "senderID":0.20686641917563975, "senderName":"nickname"}}

где message - само сообщение, senderID - айди отправителя, senderName - его никнейм, time - время отправки этого сообщения