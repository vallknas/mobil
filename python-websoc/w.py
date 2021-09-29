import asyncio
import websockets  #pip install websockets

async def echo(websocket, path): # обработка входящего сообщения
    async for message in websocket: 
        print("Inbound message:\t", message)
        if (message=="Текст"):
            await websocket.send("Пример текстового сообщения")
        elif (message=="Бот"):
          await websocket.send("Бот поддерживает команды \"Текст\" и \"Фото\"")
        elif (message=="Фото"):
            await websocket.send("Команда \"Фото\" будет реализована в следующей версии!")
        else:
            await websocket.send("Сообщение не распознано. Поддерживаются сообщения формата \"Текст\" и \"Фото\"")
# самостоятельный ответ сервера
start_server = websockets.serve(echo, "192.168.137.1", 8000)
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
