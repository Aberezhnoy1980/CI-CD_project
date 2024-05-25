import time

counter = 0  # счетчик повторений

with open('output.log', 'a') as logfile:  # открываем файл для добавления текста
    while True:
        counter += 1
        log_message = f"Приложение работает. Повторение №{counter}\n"
        print(log_message)  # вывод сообщения в стандартный поток вывода (stdout)
        logfile.write(log_message)  # запись сообщения в файл
        time.sleep(3)  # ожидание 1 секунды
