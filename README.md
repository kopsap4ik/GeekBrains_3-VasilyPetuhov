# Клиент-серверные iOS-приложения (GeekBrains).
Сделаны все обязательные пункты и частично пункты со звездочкой.

## Урок 1. Применение паттернов «наблюдатель», «одиночка», «делегат»
1. Добавить в проект синглтон для хранения данных о текущей сессии – Session.
2. Добавить в него свойства:
    token: String – для хранения токена в VK,
    userId: Int – для хранения идентификатора пользователя ВК.

## Урок 1. Применение паттернов «наблюдатель», «одиночка», «делегат»
На основе ПЗ предыдущего урока:
1. Зарегистрировать приложение в ВК;
2. Заменить форму входа на WKWebView для авторизации в ВК;
3. Сохранить токен в синглтоне Session;
4. Использовать токен в запросах к VK API;
5. Реализовать запросы к VK API;
6. Получение списка друзей;
7. Получение фотографий человека;
8. Получение групп текущего пользователя;
9. Получение групп по поисковому запросу;
10. Вывести данные в консоль.
    
P.S.: Парсить данные не нужно, просто вывести в консоль.
P.P.S: Использовать VKSDK нельзя, мы учимся работать с сетью, а не с фреймворком от VK.
