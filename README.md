# Домашнее задание к занятию 12 «GitLab»

## Основная часть

### DevOps

В репозитории содержится код проекта на Python. Проект — RESTful API сервис. Ваша задача — автоматизировать сборку образа с выполнением python-скрипта:

1. Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated).
2. Python версии не ниже 3.7.
3. Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`.
4. Создана директория `/python_api`.
5. Скрипт из репозитория размещён в /python_api.
6. Точка вызова: запуск скрипта.
7. При комите в любую ветку должен собираться docker image с форматом имени hello:gitlab-$CI_COMMIT_SHORT_SHA . Образ должен быть выложен в Gitlab registry или yandex registry.   

создал проект barmaq/netology  
наполнил его в соответсвии с требованиями :  
    создал dockerfile с указанным контейнером. поскольку centos7 вышел из поддержки то заменил репозитории на архивные  дописав 
```
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*  
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*  
```
    создал requirements.txt  
```
flask  
flask-jsonpify  
flask-restful  
```
    скопировал python-api.py
  
итог :  
    [репозиторий](https://github.com/barmaq/9-ci-06-gitlab)  
  
собираем, получаем докер image в нашем registry  
![image](/images/image.png) 

### Product Owner

Вашему проекту нужна бизнесовая доработка: нужно поменять JSON ответа на вызов метода GET `/rest/api/get_info`, необходимо создать Issue в котором указать:

1. Какой метод необходимо исправить.
2. Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`.
3. Issue поставить label: feature.

создаем Issue  
![issue](/images/issue.png)   
назначаем его на разработчика  


### Developer

Пришёл новый Issue на доработку, вам нужно:

1. Создать отдельную ветку, связанную с этим Issue.
2. Внести изменения по тексту из задания.
3. Подготовить Merge Request, влить необходимые изменения в `master`, проверить, что сборка прошла успешно.

создаем ветку  
меняем в python скрипте   
в пайтон  скрипте 
```
        return {'version': 3, 'method': 'GET', 'message': 'Already started'}
```
вливаем изменения в master  
![build_issue](/images/build_issue.png) 



### Tester

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:

1. Поднять докер-контейнер с образом `python-api:latest` и проверить возврат метода на корректность.
2. Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый.

пулим докер контейнер, запускаем, првоеряем  
```
docker login barmaq.gitlab.yandexcloud.net:5050  
docker pull barmaq.gitlab.yandexcloud.net:5050/barmaq/netology/hello:gitlab-fc968596  
docker run -p 5290:5290 -d barmaq.gitlab.yandexcloud.net:5050/barmaq/netology/hello:gitlab-fc968596  
docker ps  
curl localhost:5290/get_info  
```
![test](/images/test.png) 

закрываем Issue  
![test_issue](/images/test_issue.png) 

## Итог

[репозиторий](https://github.com/barmaq/9-ci-06-gitlab)  

### Важно 
После выполнения задания выключите и удалите все задействованные ресурсы в Yandex Cloud.

