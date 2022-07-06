# frozen_string_literal: true

# Generate sample users.
users = User.create!(
  [
    { name: 'Admin User',            email: 'example@admin.ru',    admin: true },
    { name: 'Ivan Ivanov',           email: 'ivanov@gmail.com',    admin: false },
    { name: 'Sergey Petrov',         email: 'sergey@gmail.com',    admin: false },
    { name: 'Nikolay Zaharov',       email: 'nikolay@gmail.com',   admin: false },
    { name: 'Ekaterina Naumova',     email: 'ekaterina@gmail.com', admin: false },
    { name: 'Johnny Depp',           email: 'johnny@gmail.com',    admin: false },
    { name: 'Arnold Schwarzenegger', email: 'arnold@gmail.com',    admin: false },
    { name: 'Sylvester Stallone',    email: 'stalone@gmail.com',   admin: false },
    { name: 'Brad Pitt',             email: 'brad@gmail.com',      admin: false },
    { name: 'Angelina Jolie',        email: 'angelina@gmail.com',  admin: false }
  ]
)

# Generate categories.
categories = Category.create!(
  [
    { title: 'HTML' },
    { title: 'Ruby' },
    { title: 'Rails' },
    { title: 'SQL' }
  ]
)

# Generate tests.
tests = Test.create!(
  [
    { title: 'Введение в HTML',     level: 1, category_id: categories[0].id, author_id: users[0].id },
    { title: 'Знакомство с Ruby',   level: 2, category_id: categories[1].id, author_id: users[0].id },
    { title: 'Первые шаги в Rails', level: 3, category_id: categories[2].id, author_id: users[0].id },
    { title: 'Введение в SQL',      level: 1, category_id: categories[3].id, author_id: users[0].id }
  ]
)

# Creating a User relationship with Tests
TestsUser.create!(
  [
    { test_id: tests[0].id, user_id: users[0].id },
    { test_id: tests[1].id, user_id: users[0].id },
    { test_id: tests[2].id, user_id: users[0].id },
    { test_id: tests[3].id, user_id: users[0].id },
    { test_id: tests[1].id, user_id: users[1].id },
    { test_id: tests[2].id, user_id: users[2].id }
  ]
)

# Create questions.
questions = Question.create!(
  [
    # questions HTML test
    { body: 'Что такое HTML?',                                   test_id: tests[0].id },
    { body: 'Что такое тег?',                                    test_id: tests[0].id },
    { body: 'За что отвечает тег <!DOCTYPE html>?',              test_id: tests[0].id },
    { body: 'Что размещается в теге <body>?',                    test_id: tests[0].id },
    { body: 'Выберите все подходящие ответы из списка:',         test_id: tests[0].id },

    # questions Ruby test
    { body: 'Кем был разработан язык Ruby?',                     test_id: tests[1].id },
    { body: 'По исполнению Ruby это -',                          test_id: tests[1].id },
    { body: 'Что такое Class?',                                  test_id: tests[1].id },
    { body: 'Что такое Объект?',                                 test_id: tests[1].id },
    { body: 'Что такое Модуль?',                                 test_id: tests[1].id },
    { body: 'В чем отличие Модуля от Класса?',                   test_id: tests[1].id },

    # questions Rails test
    { body: 'Что такое Rails?',                                  test_id: tests[2].id },
    { body: 'На каком языке написан фреймворк Rails?',           test_id: tests[2].id },
    { body: 'Что такое MVC?',                                    test_id: tests[2].id },
    { body: 'Что такое Active Record?',                          test_id: tests[2].id },
    { body: 'Что такое Контроллер?',                             test_id: tests[2].id },

    # questions SQL test
    { body: 'Что такое SQL?',                                    test_id: tests[3].id },
    { body: 'К какому типу СУБД относится PostgreSQL?',          test_id: tests[3].id },
    { body: 'Что такое индекс?',                                 test_id: tests[3].id },
    { body: 'Что из себя представляет реляционная база данных?', test_id: tests[3].id }
  ]
)

# Create answers.
answers = Answer.create!(
  [
    # answers HTML test
    # 1 question
    { body: 'язык разметки гипертекста',     correct: true,  question_id: questions[0].id },
    { body: 'протокол передачи гипертекста', correct: false, question_id: questions[0].id },
    { body: 'система доменных имён',         correct: false, question_id: questions[0].id },

    # 2 question
    { body: 'это синтаксическая единица языка HTML, которая выделяет или создаёт элемент', correct: true, question_id: questions[1].id },
    { body: 'модель формирования пакетов сетевых данных', correct: false, question_id: questions[1].id },
    { body: 'стандарт записи сетевого адреса', correct: false, question_id: questions[1].id },

    # 3 question
    { body: 'стандарт записи сетевого адреса', correct: false, question_id: questions[2].id },
    { body: 'говорит браузеру, по какому стандарту написана страница', correct: true, question_id: questions[2].id },
    { body: 'задает кодировку страницы',       correct: false, question_id: questions[2].id },

    # 4 question
    { body: 'хранится информация о странице',  correct: false, question_id: questions[3].id },
    { body: 'хранится информация о кодировке', correct: false, question_id: questions[3].id },
    { body: 'размещается весь контент страницы, который пользователь увидит в браузере', correct: true, question_id: questions[3].id },

    # 5 question
    { body: '/users/21 - абсолютная ссылка',              correct: false, question_id: questions[4].id },
    { body: '//google.com - относительная ссылка',        correct: true,  question_id: questions[4].id },
    { body: 'https://vk.com/reu_itc - абсолютная ссылка', correct: true,  question_id: questions[4].id },

    # answers Ruby test
    # 1 question
    { body: 'Гвидо ван Россум', correct: false, question_id: questions[5].id },
    { body: 'Юкихиро Мацумото', correct: true,  question_id: questions[5].id },
    { body: 'Расмус Лердорф',   correct: true,  question_id: questions[5].id },

    # 2 question
    { body: 'компилируемый язык',    correct: false, question_id: questions[6].id },
    { body: 'интерпритируемый язык', correct: true,  question_id: questions[6].id },

    # 3 question
    { body: 'объект базового класса Class', correct: true, question_id: questions[7].id },
    { body: 'своего рода чертеж, абстрактное описание объекта', correct: true, question_id: questions[7].id },
    { body: 'константа', correct: false, question_id: questions[7].id },

    # 4 question
    { body: 'экземпляр какого-либо класса', correct: true, question_id: questions[8].id },
    { body: 'сущность, служащая контейнером для данных и управляющая доступом к этим данным', correct: true, question_id: questions[8].id },
    { body: 'объект базового класса Class', correct: false, question_id: questions[8].id },

    # 5 question
    { body: 'экземпляр какого-либо класса', correct: false, question_id: questions[9].id },
    { body: 'некий контейнер(набор)',       correct: true,  question_id: questions[9].id },
    { body: 'способ группировки методов, констант, классов, других модулей', correct: true, question_id: questions[9].id },

    # 6 question
    { body: 'у Модуля нельзя создать экземпляр', correct: false, question_id: questions[10].id },
    { body: 'отличий нет', correct: true, question_id: questions[10].id },
    { body: 'Модуль не может иметь подклассы, нет иерархии наследования', correct: true, question_id: questions[10].id },

    # answers Rails test
    # 1 question
    { body: 'фреймворк(библиотека)', correct: true, question_id: questions[11].id },
    { body: 'язык программирования', correct: false, question_id: questions[11].id },
    { body: 'специальный Класс, встроенный в язык Ruby', correct: false, question_id: questions[11].id },

    # 2 question
    { body: 'Pyton',      correct: false, question_id: questions[12].id },
    { body: 'JavaScript', correct: false, question_id: questions[12].id },
    { body: 'Ruby',       correct: true,  question_id: questions[12].id },

    # 3 question
    { body: 'библиотека(гем)', correct: false, question_id: questions[13].id },
    { body: 'шаблон (паттерн) программирования, разделяющий архитектуру приложения на три модуля', correct: true, question_id: questions[13].id },
    { body: 'объектное представление базы данных в Rails приложениях', correct: false, question_id: questions[13].id },

    # 4 question
    { body: 'класс Ruby',               correct: false, question_id: questions[14].id },
    { body: 'это C в аббревиатуре MVC', correct: false, question_id: questions[14].id },
    { body: 'это M в MVC - модель - которая является слоем в системе, ответственным за представление бизнес-логики и данных', correct: true, question_id: questions[14].id },

    # 5 question
    { body: 'класс Ruby, унаследованный от ApplicationController', correct: true,  question_id: questions[15].id },
    { body: 'это C в аббревиатуре MVC',                            correct: true,  question_id: questions[15].id },
    { body: 'класс Ruby, отвечающий за визуализацию информации',   correct: false, question_id: questions[15].id },

    # answers SQL test
    # 1 question
    { body: 'язык структурированных запросов',    correct: true,  question_id: questions[16].id },
    { body: 'стандарт записи уникального адреса', correct: false, question_id: questions[16].id },
    { body: 'система управления базами данных',   correct: false, question_id: questions[16].id },

    # 2 question
    { body: 'Файл-серверные',   correct: false, question_id: questions[17].id },
    { body: 'Встраиваемые',     correct: false, question_id: questions[17].id },
    { body: 'Клиент-серверные', correct: true,  question_id: questions[17].id },

    # 3 question
    { body: 'синтаксическая единица языка SQL', correct: false, question_id: questions[18].id },
    { body: 'объект базы данных(таблица) который содержит в себе значение проиндексированного столбца и указатели на запись в таблице', correct: true, question_id: questions[18].id },
    { body: 'связь записи одной таблицы с записью в другой', correct: false, question_id: questions[18].id },

    # 4 question
    { body: 'это упорядоченная информация, связанная между собой определёнными отношениями', correct: true, question_id: questions[19].id },
    { body: 'теоретической основой служит реляционная алгебра', correct: true, question_id: questions[19].id },
    { body: 'это набор правил и критериев, которым должна отвечать база данных', correct: false, question_id: questions[19].id }
  ]
)
