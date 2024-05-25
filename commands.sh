Git and Docker installed and setuped
// Create remote GIT repositotry (github)
// Create local GIT repository

alex@MacBook-Pro-Aleksandr ~ % mkdir ./Documents/Study/Career/MIPT/service_development/CI:CD_project
alex@MacBook-Pro-Aleksandr ~ % cd ./Documents/Study/Career/MIPT/service_development/CI:CD_project
alex@MacBook-Pro-Aleksandr CI:CD_project % git init
Initialized empty Git repository in /Users/alex/Documents/Study/Career/MIPT/service_development/CI:CD_project/.git/

// Connect with remote repository
alex@MacBook-Pro-Aleksandr CI:CD_project % git remote add origin git@github.com:Aberezhnoy1980/CI-CD_project.git
alex@MacBook-Pro-Aleksandr CI:CD_project % git remote -v
origin	git@github.com:Aberezhnoy1980/CI-CD_project.git (fetch)
origin	git@github.com:Aberezhnoy1980/CI-CD_project.git (push)

// Add .gitignore
alex@MacBook-Pro-Aleksandr CI:CD_project % vim .gitignore
================================
.idea
.gitignore
================================

// Add .py application
alex@MacBook-Pro-Aleksandr CI:CD_project % vim app.py
================================
import time

counter = 0  # счетчик повторений

with open('output.log', 'a') as logfile:  # открываем файл для добавления текста
    while True:
        counter += 1
        log_message = f"Приложение работает. Повторение №{counter}\n"
        print(log_message)  # вывод сообщения в стандартный поток вывода (stdout)
        logfile.write(log_message)  # запись сообщения в файл
        time.sleep(3)  # ожидание 1 секунды
==================================

// Check the application
alex@MacBook-Pro-Aleksandr CI:CD_project % python3 app.py
Приложение работает. Повторение №1

Приложение работает. Повторение №2

Приложение работает. Повторение №3

^CTraceback (most recent call last):
  File "/Users/alex/Documents/Study/Career/MIPT/service_development/CI:CD_project/app.py", line 11, in <module>
    time.sleep(3)  # ожидание 1 секунды
    ^^^^^^^^^^^^^
KeyboardInterrupt

// Check logfile
alex@MacBook-Pro-Aleksandr CI:CD_project % ls -l
total 16
-rw-r--r--  1 alex  staff  575 25 май 12:44 app.py
-rw-r--r--  1 alex  staff  195 25 май 12:45 output.log
alex@MacBook-Pro-Aleksandr CI:CD_project % cat output.log 
Приложение работает. Повторение №1
Приложение работает. Повторение №2
Приложение работает. Повторение №3

// Add README file
alex@MacBook-Pro-Aleksandr CI:CD_project % touch README.md; ls -l
total 16
-rw-r--r--  1 alex  staff    0 25 май 13:30 README.md
-rw-r--r--  1 alex  staff  575 25 май 12:44 app.py
-rw-r--r--  1 alex  staff  195 25 май 12:45 output.log

// Push local repo to remote
alex@MacBook-Pro-Aleksandr CI:CD_project % git add -A; git commit -m"init commit"; git push origin main
[main (root-commit) 0660b75] init commit
 Committer: Aleksandr Berezhnoy <alex@MacBook-Pro-Aleksandr.local>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly. Run the
following command and follow the instructions in your editor to edit
your configuration file:

    git config --global --edit

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 10 files changed, 448 insertions(+)
 create mode 100644 .idea/.gitignore
 create mode 100644 .idea/CICD_project.iml
 create mode 100644 .idea/dbnavigator.xml
 create mode 100644 .idea/inspectionProfiles/profiles_settings.xml
 create mode 100644 .idea/misc.xml
 create mode 100644 .idea/modules.xml
 create mode 100644 .idea/vcs.xml
 create mode 100644 README.md
 create mode 100644 app.py
 create mode 100644 output.log
Enumerating objects: 14, done.
Counting objects: 100% (14/14), done.
Delta compression using up to 8 threads
Compressing objects: 100% (11/11), done.
Writing objects: 100% (14/14), 4.47 KiB | 2.23 MiB/s, done.
Total 14 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), done.
To github.com:Aberezhnoy1980/CI-CD_project.git
 * [new branch]      main -> main
alex@MacBook-Pro-Aleksandr CI:CD_project % git status
On branch main
nothing to commit, working tree clean

// Create and move to the dev branch
alex@MacBook-Pro-Aleksandr CI:CD_project % git checkout -b dev; git branch -a
Switched to a new branch 'dev'
* dev
  main
  remotes/origin/main

// Check remote on github
// Create a Dockerfile
alex@MacBook-Pro-Aleksandr CI:CD_project % vim Dockerfile
============================
# Установка Python из официального базового образа
FROM python:3.9-slim
# Установка рабочей директории внутри будущего контейнера
WORKDIR /app
# Копирование всех файлов приложения в контейнер
COPY app.py /app
# Экспорт порта, на котором будет работать приложение
EXPOSE 8000
# Запуск тестового Python-приложения
CMD ["python", "app.py"]
============================

// Add output.log & .dockerignore in .gitignore and create dockerignore
alex@MacBook-Pro-Aleksandr CI:CD_project % echo output.log '\n'.dockerignore >> .gitignore; cat .gitignore 
.idea
.gitignore
output.log 
.dockerignore
alex@MacBook-Pro-Aleksandr CI:CD_project % vim .dockerignore
=============================
.DS_Store
output.log
.gitignore
.idea
README.md
Dockerfile
=============================

// Start Docker engine
alex@MacBook-Pro-Aleksandr CI:CD_project % open -a Docker

// Check process
alex@MacBook-Pro-Aleksandr CI:CD_project % ps aux | grep dockerd
alex             43081   0,0  0,0 34138740    700 s000  S+    4:52     0:00.00 grep dockerd

// Build image and check
alex@MacBook-Pro-Aleksandr CI:CD_project % docker build -t aberezhnoy1980/ci-cd_project --name ci-cd .
alex@MacBook-Pro-Aleksandr CI:CD_project % docker images | grep aberezhnoy1980/ci-cd_project
aberezhnoy1980/ci-cd_project   latest            fba77470a8d8   59 seconds ago   126MB

// Run container
alex@MacBook-Pro-Aleksandr CI:CD_project % docker run -it aberezhnoy1980/ci-cd_project         
Приложение работает. Повторение №1

Приложение работает. Повторение №2

Приложение работает. Повторение №3

^CTraceback (most recent call last):
  File "/app/app.py", line 11, in <module>
    time.sleep(3)  # ожидание 1 секунды
KeyboardInterrupt
// Check containers
alex@MacBook-Pro-Aleksandr CI:CD_project % docker ps -a
CONTAINER ID   IMAGE                          COMMAND           CREATED          STATUS                        PORTS     NAMES
b685653362e8   aberezhnoy1980/ci-cd_project   "python app.py"   50 seconds ago   Exited (130) 30 seconds ago             friendly_hamilton

// Push image to dockerhub
alex@MacBook-Pro-Aleksandr CI:CD_project % docker push aberezhnoy1980/ci-cd_project        
Using default tag: latest
The push refers to repository [docker.io/aberezhnoy1980/ci-cd_project]
d39f90eee4fc: Pushed 
71847df8dc79: Pushed 
ae96698df02c: Mounted from library/python 
e555c0055a9b: Mounted from library/python 
205262265e50: Mounted from library/python 
146826fa3ca0: Mounted from library/python 
5d4427064ecc: Mounted from library/python 
latest: digest: sha256:ad16b00eef7226c2f65066e305f7f3291b2ae2dc8de611b272f257e7eff6c418 size: 1783

// Check docker repositotry
alex@MacBook-Pro-Aleksandr CI:CD_project % docker search ci-cd_project          
NAME                           DESCRIPTION           STARS     OFFICIAL   AUTOMATED
madhukar15/ci-cd_project                             0                    
harishbitm/ci-cd_project       CI-CD_PROJECT         0                    
aberezhnoy1980/ci-cd_project   Study CI/CD project   0  

// Set up remote server (Cloud.ru - ибо бесплатно)) Публичный ip все равно платно( and connect through SSH
alex@MacBook-Pro-Aleksandr CI:CD_project % ssh ****@****

$ ls -la
total 28
drwxr-x--- 4 alex alex 4096 May 25 15:06 .
drwxr-xr-x 3 root root 4096 May 25 15:03 ..
-rw-r--r-- 1 alex alex  220 Jan  6  2022 .bash_logout
-rw-r--r-- 1 alex alex 3771 Jan  6  2022 .bashrc
drwx------ 2 alex alex 4096 May 25 15:06 .cache
-rw-r--r-- 1 alex alex  807 Jan  6  2022 .profile
drwx------ 2 alex alex 4096 May 25 15:03 .ssh
$ uname -a
Linux alex 5.15.0-69-generic #76-Ubuntu SMP Fri Mar 17 17:19:29 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 qdisc fq_codel state UP group default qlen 1000
    link/ether fa:16:3e:f7:e9:b2 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.7/24 metric 100 brd 10.0.0.255 scope global dynamic enp3s0
       valid_lft 42642sec preferred_lft 42642sec
    inet6 fe80::f816:3eff:fef7:e9b2/64 scope link 
       valid_lft forever preferred_lft forever
$ ping ya.ru -c 4
PING ya.ru (77.88.55.242) 56(84) bytes of data.
64 bytes from ya.ru (77.88.55.242): icmp_seq=1 ttl=245 time=18.8 ms
64 bytes from ya.ru (77.88.55.242): icmp_seq=2 ttl=245 time=11.2 ms
64 bytes from ya.ru (77.88.55.242): icmp_seq=3 ttl=245 time=9.34 ms
64 bytes from ya.ru (77.88.55.242): icmp_seq=4 ttl=245 time=9.26 ms

--- ya.ru ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 9.264/12.133/18.764/3.902 ms

// Install docker service (engine + CLI)
$ sudo apt update
...
Fetched 31.5 MB in 5s (6521 kB/s)                
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
194 packages can be upgraded. Run 'apt list --upgradable' to see them.
// Oficial gpg key Dcoker
sudo apt install apt-transport-https ca-certificates curl software-properties-common

// 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

// Add repository to source
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

// Update packages and install necesssayry components
$ sudo apt-get update
$ sudo apt install docker-ce

// Set up user right (что бы не дергать sudo)
sudo usermod -aG docker $USER
newgrp docker

// Check docker
$ docker --version
Docker version 26.1.3, build b72abbb
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
c1ec31eb5944: Pull complete 
Digest: sha256:266b191e926f65542fa8daaec01a192c4d292bff79426f47300a046e1bc576fd
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

// Run container from our image
$ docker run -it aberezhnoy1980/ci-cd_project
Unable to find image 'aberezhnoy1980/ci-cd_project:latest' locally
latest: Pulling from aberezhnoy1980/ci-cd_project
09f376ebb190: Pull complete 
276709cbedc1: Pull complete 
4e7363ac3b6f: Pull complete 
1f1e6fb6a4a5: Pull complete 
bf8f57a642c4: Pull complete 
4aa1090b3a49: Pull complete 
937981025fe4: Pull complete 
Digest: sha256:ad16b00eef7226c2f65066e305f7f3291b2ae2dc8de611b272f257e7eff6c418
Status: Downloaded newer image for aberezhnoy1980/ci-cd_project:latest
Приложение работает. Повторение №1

Приложение работает. Повторение №2

Приложение работает. Повторение №3

^CTraceback (most recent call last):
  File "/app/app.py", line 11, in <module>
    time.sleep(3)  # ожидание 1 секунды
KeyboardInterrupt

// Delete container
$ docker ps -a
CONTAINER ID   IMAGE         COMMAND    CREATED          STATUS                      PORTS     NAMES
2167fd549006   hello-world   "/hello"   17 minutes ago   Exited (0) 17 minutes ago             inspiring_greider
$ docker rm 2167fd549006; docker ps -a
2167fd549006
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

// Create SSH keys
$ ssh-keygen -t rsa -b 4096 -C "Aberezhnoy1980@gmail.com"
$ sudo cat /home/alex/.ssh/id_rsa

!!!!Могут быть проблемы с ключом (сервер на Ubuntu 22.04 - выше был лог uname). В моем случае их было две ирешением было:

Проблема 1: 2024/05/25 17:39:53 ssh.ParsePrivateKey: ssh: no key found
Решение:
При копировании приватного ключа копировать от и до включительно:
-----BEGIN OPENSSH PRIVATE KEY-----
...
-----END OPENSSH PRIVATE KEY-----

Проблема 2: 2024/05/25 17:39:54 ssh: handshake failed: ssh: unable to authenticate, attempted methods [none publickey], no supported methods remain
Решение: Редактировать конфигурационный файл

$ sudo vim /etc/ssh/sshd_config
=============================== 
CASignatureAlgorithms +ssh-rsa
HostKeyAlgorithms +ssh-rsa
PubkeyAcceptedKeyTypes +ssh-rsa
===============================
и добавление публичного ключа в authorized_keys
и перегрузка ssh
$ sudo systemctl restart ssh
После этого хэндшейк стал проходить успешно

// Set up secrets on github

// Push Dockerfile on github, create PR and start action
alex@MacBook-Pro-Aleksandr CI:CD_project % git status                                       
On branch dev
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	Dockerfile

nothing added to commit but untracked files present (use "git add" to track)
alex@MacBook-Pro-Aleksandr CI:CD_project % git add .; git commit -m"Dockerfile added"; git push origin dev
[dev 156a737] Dockerfile added
 Committer: Aleksandr Berezhnoy <alex@MacBook-Pro-Aleksandr.local>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly. Run the
following command and follow the instructions in your editor to edit
your configuration file:

    git config --global --edit

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 10 insertions(+)
 create mode 100644 Dockerfile
Enumerating objects: 17, done.
Counting objects: 100% (17/17), done.
Delta compression using up to 8 threads
Compressing objects: 100% (14/14), done.
Writing objects: 100% (17/17), 4.97 KiB | 2.48 MiB/s, done.
Total 17 (delta 3), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (3/3), done.
remote: 
remote: Create a pull request for 'dev' on GitHub by visiting:
remote:      https://github.com/Aberezhnoy1980/CI-CD_project/pull/new/dev
remote: 
To github.com:Aberezhnoy1980/CI-CD_project.git
 * [new branch]      dev -> dev

// Check the results on a server (9 минут потому что после перекура - не сразу мне трабла с ключом поддалась)
$ docker ps  
CONTAINER ID   IMAGE                                 COMMAND           CREATED         STATUS         PORTS      NAMES
e75468fe9df0   aberezhnoy1980/ci-cd_project:latest   "python app.py"   9 minutes ago   Up 9 minutes   8000/tcp   main_container
$ docker logs main_container > output.log
$ ls
output.log
$ tail output.log
Приложение работает. Повторение №238

Приложение работает. Повторение №239

Приложение работает. Повторение №240

Приложение работает. Повторение №241

Приложение работает. Повторение №242

// Change code and look at pipline (go to host)

=============================
import time

counter = 0  # счетчик повторений

with open('output.log', 'a') as logfile:  # открываем файл для добавления текста
    while True:
        counter += 2
        log_message = f"Приложение обновлено и работает.CI/CD рулит. Повторение №{counter}\n"
        print(log_message)  # вывод сообщения в стандартный поток вывода (stdout)
        logfile.write(log_message)  # запись сообщения в файл
        time.sleep(1)  # ожидание 1 секунды
=============================
alex@MacBook-Pro-Aleksandr CI:CD_project % git status
On branch dev
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   .idea/misc.xml
	modified:   app.py
	modified:   output.log

no changes added to commit (use "git add" and/or "git commit -a")
alex@MacBook-Pro-Aleksandr CI:CD_project % git add app.py; git commit -m"app's code updated"; git push origin dev;
[dev 0134146] app\'s code updated
 Committer: Aleksandr Berezhnoy <alex@MacBook-Pro-Aleksandr.local>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly. Run the
following command and follow the instructions in your editor to edit
your configuration file:

    git config --global --edit

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 3 insertions(+), 3 deletions(-)
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 371 bytes | 371.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:Aberezhnoy1980/CI-CD_project.git
   156a737..0134146  dev -> dev

// Check github. Make PR and check server
$ docker ps
CONTAINER ID   IMAGE                                 COMMAND           CREATED          STATUS          PORTS      NAMES
88e540b53a6c   aberezhnoy1980/ci-cd_project:latest   "python app.py"   31 seconds ago   Up 30 seconds   8000/tcp   main_container
$ rm output.log
$ docker logs main_container > output.log
$ tail output.log
Приложение обновлено и работает. CI/CD рулит. Повторение №144

Приложение обновлено и работает. CI/CD рулит. Повторение №146

Приложение обновлено и работает. CI/CD рулит. Повторение №148

Приложение обновлено и работает. CI/CD рулит. Повторение №150

Приложение обновлено и работает. CI/CD рулит. Повторение №152

Всё!