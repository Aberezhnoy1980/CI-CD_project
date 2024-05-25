import time

counter = 0  # счетчик повторений

with open('output.log', 'a') as logfile:  # открываем файл для добавления текста
    while True:
        counter += 2
        log_message = f"Добавлены файлы листинга команд и README.md. Повторение №{counter}\n"
        print(log_message)  # вывод сообщения в стандартный поток вывода (stdout)
        logfile.write(log_message)  # запись сообщения в файл
        time.sleep(1)  # ожидание 1 секунды
