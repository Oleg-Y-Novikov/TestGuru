# frozen_string_literal: true

# Generate sample users.
users = User.create!(
  [
    { first_name: 'Admin',    last_name: 'User',    email: 'example@admin.ru',    admin: true,  password: 'password' },
    { first_name: 'Ivan',     last_name: 'Ivanov',  email: 'ivanov@gmail.com',    admin: false, password: 'password' },
    { first_name: 'Sergey',   last_name: 'Petrov',  email: 'sergey@gmail.com',    admin: false, password: 'password' },
    { first_name: 'Nikolay',  last_name: 'Zaharov', email: 'nikolay@gmail.com',   admin: false, password: 'password' },
    { first_name: 'Johnny',   last_name: 'Depp',    email: 'johnny@gmail.com',    admin: false, password: 'password' },
    { first_name: 'Brad',     last_name: 'Pitt',    email: 'brad@gmail.com',      admin: false, password: 'password' },
    { first_name: 'Angelina', last_name: 'Jolie',   email: 'angelina@gmail.com',  admin: false, password: 'password' }
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
    { title: 'Введение в HTML',     level: 1, category: categories[0], author: users[0] },
    { title: 'Знакомство с Ruby',   level: 2, category: categories[1], author: users[0] },
    { title: 'Первые шаги в Rails', level: 3, category: categories[2], author: users[0] },
    { title: 'Введение в SQL',      level: 1, category: categories[3], author: users[0] }
  ]
)

# Creating a User relationship with Tests
# TestsUser.create!(
#  [
#    { test: tests[0], user: users[0] },
#    { test: tests[1], user: users[0] },
#    { test: tests[2], user: users[0] },
#    { test: tests[3], user: users[0] },
#    { test: tests[1], user: users[1] },
#    { test: tests[2], user: users[2] }
#  ]
# )

# Create questions.
questions = Question.create!(
  [
    # questions HTML test
    { body: 'Что такое HTML?',                                   test: tests[0] },
    { body: 'Что такое тег?',                                    test: tests[0] },
    { body: 'За что отвечает тег <!DOCTYPE html>?',              test: tests[0] },
    { body: 'Что размещается в теге <body>?',                    test: tests[0] },
    { body: 'Выберите все подходящие ответы из списка:',         test: tests[0] },

    # questions Ruby test
    { body: 'Кем был разработан язык Ruby?',                     test: tests[1] },
    { body: 'По исполнению Ruby это -',                          test: tests[1] },
    { body: 'Что такое Class?',                                  test: tests[1] },
    { body: 'Что такое Объект?',                                 test: tests[1] },
    { body: 'Что такое Модуль?',                                 test: tests[1] },
    { body: 'В чем отличие Модуля от Класса?',                   test: tests[1] },

    # questions Rails test
    { body: 'Что такое Rails?',                                  test: tests[2] },
    { body: 'На каком языке написан фреймворк Rails?',           test: tests[2] },
    { body: 'Что такое MVC?',                                    test: tests[2] },
    { body: 'Что такое Active Record?',                          test: tests[2] },
    { body: 'Что такое Контроллер?',                             test: tests[2] },

    # questions SQL test
    { body: 'Что такое SQL?',                                    test: tests[3] },
    { body: 'К какому типу СУБД относится PostgreSQL?',          test: tests[3] },
    { body: 'Что такое индекс?',                                 test: tests[3] },
    { body: 'Что из себя представляет реляционная база данных?', test: tests[3] }
  ]
)

# Create answers.
answers = Answer.create!(
  [
    # answers HTML test
    # 1 question
    { body: 'язык разметки гипертекста',     correct: true,  question: questions[0] },
    { body: 'протокол передачи гипертекста', correct: false, question: questions[0] },
    { body: 'система доменных имён',         correct: false, question: questions[0] },

    # 2 question
    { body: 'это синтаксическая единица языка HTML, которая выделяет или создаёт элемент', correct: true, question: questions[1] },
    { body: 'модель формирования пакетов сетевых данных', correct: false, question: questions[1] },
    { body: 'стандарт записи сетевого адреса', correct: false, question: questions[1] },

    # 3 question
    { body: 'стандарт записи сетевого адреса', correct: false, question: questions[2] },
    { body: 'говорит браузеру, по какому стандарту написана страница', correct: true, question: questions[2] },
    { body: 'задает кодировку страницы',       correct: false, question: questions[2] },

    # 4 question
    { body: 'хранится информация о странице',  correct: false, question: questions[3] },
    { body: 'хранится информация о кодировке', correct: false, question: questions[3] },
    { body: 'размещается весь контент страницы, который пользователь увидит в браузере', correct: true, question: questions[3] },

    # 5 question
    { body: '/users/21 - абсолютная ссылка',              correct: false, question: questions[4] },
    { body: '//google.com - относительная ссылка',        correct: true,  question: questions[4] },
    { body: 'https://vk.com/reu_itc - абсолютная ссылка', correct: true,  question: questions[4] },

    # answers Ruby test
    # 1 question
    { body: 'Гвидо ван Россум', correct: false, question: questions[5] },
    { body: 'Юкихиро Мацумото', correct: true,  question: questions[5] },
    { body: 'Расмус Лердорф',   correct: false, question: questions[5] },

    # 2 question
    { body: 'компилируемый язык',    correct: false, question: questions[6] },
    { body: 'интерпритируемый язык', correct: true,  question: questions[6] },

    # 3 question
    { body: 'объект базового класса Class', correct: true, question: questions[7] },
    { body: 'своего рода чертеж, абстрактное описание объекта', correct: true, question: questions[7] },
    { body: 'константа', correct: false, question: questions[7] },

    # 4 question
    { body: 'экземпляр какого-либо класса', correct: true, question: questions[8] },
    { body: 'сущность, служащая контейнером для данных и управляющая доступом к этим данным', correct: true, question: questions[8] },
    { body: 'объект базового класса Class', correct: false, question: questions[8] },

    # 5 question
    { body: 'экземпляр какого-либо класса', correct: false, question: questions[9] },
    { body: 'некий контейнер(набор)',       correct: true,  question: questions[9] },
    { body: 'способ группировки методов, констант, классов, других модулей', correct: true, question: questions[9] },

    # 6 question
    { body: 'у Модуля нельзя создать экземпляр', correct: true, question: questions[10] },
    { body: 'отличий нет', correct: false, question: questions[10] },
    { body: 'Модуль не может иметь подклассы, нет иерархии наследования', correct: true, question: questions[10] },

    # answers Rails test
    # 1 question
    { body: 'фреймворк(библиотека)', correct: true, question: questions[11] },
    { body: 'язык программирования', correct: false, question: questions[11] },
    { body: 'специальный Класс, встроенный в язык Ruby', correct: false, question: questions[11] },

    # 2 question
    { body: 'Pyton',      correct: false, question: questions[12] },
    { body: 'JavaScript', correct: false, question: questions[12] },
    { body: 'Ruby',       correct: true,  question: questions[12] },

    # 3 question
    { body: 'библиотека(гем)', correct: false, question: questions[13] },
    { body: 'шаблон (паттерн) программирования, разделяющий архитектуру приложения на три модуля', correct: true, question: questions[13] },
    { body: 'объектное представление базы данных в Rails приложениях', correct: false, question: questions[13] },

    # 4 question
    { body: 'класс Ruby',               correct: false, question: questions[14] },
    { body: 'это C в аббревиатуре MVC', correct: false, question: questions[14] },
    { body: 'это M в MVC - модель - которая является слоем в системе, ответственным за представление бизнес-логики и данных', correct: true, question: questions[14] },

    # 5 question
    { body: 'класс Ruby, унаследованный от ApplicationController', correct: true,  question: questions[15] },
    { body: 'это C в аббревиатуре MVC',                            correct: true,  question: questions[15] },
    { body: 'класс Ruby, отвечающий за визуализацию информации',   correct: false, question: questions[15] },

    # answers SQL test
    # 1 question
    { body: 'язык структурированных запросов',    correct: true,  question: questions[16] },
    { body: 'стандарт записи уникального адреса', correct: false, question: questions[16] },
    { body: 'система управления базами данных',   correct: false, question: questions[16] },

    # 2 question
    { body: 'Файл-серверные',   correct: false, question: questions[17] },
    { body: 'Встраиваемые',     correct: false, question: questions[17] },
    { body: 'Клиент-серверные', correct: true,  question: questions[17] },

    # 3 question
    { body: 'синтаксическая единица языка SQL', correct: false, question: questions[18] },
    { body: 'объект базы данных(таблица) который содержит в себе значение проиндексированного столбца и указатели на запись в таблице', correct: true, question: questions[18] },
    { body: 'связь записи одной таблицы с записью в другой', correct: false, question: questions[18] },

    # 4 question
    { body: 'это упорядоченная информация, связанная между собой определёнными отношениями', correct: true, question: questions[19] },
    { body: 'теоретической основой служит реляционная алгебра', correct: true, question: questions[19] },
    { body: 'это набор правил и критериев, которым должна отвечать база данных', correct: false, question: questions[19] }
  ]
)
