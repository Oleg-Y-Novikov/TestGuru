# frozen_string_literal: true

# Create sample admin user.
User.create!(
  name: 'Admin User',
  email: 'example@admin.ru',
  admin: true
)

# Generate sample users.
sample_users = [
  ['Ivan Ivanov',           'ivanov@gmail.com'],
  ['Sergey Petrov',         'sergey@gmail.com'],
  ['Nikolay Zaharov',       'nikolay@gmail.com'],
  ['Ekaterina Naumova',     'ekaterina@gmail.com'],
  ['Johnny Depp',           'johnny@gmail.com'],
  ['Arnold Schwarzenegger', 'arnold@gmail.com'],
  ['Sylvester Stallone',    'sylvester@gmail.com'],
  ['Angelina Jolie',        'angelina@gmail.com'],
  ['Brad Pitt',             'brad@gmail.com']
]

sample_users.each do |name, email|
  User.create!(
    name: name,
    email: email,
    admin: false
  )
end

# Generate categories.
categories = ['HTML', 'Ruby', 'Rails', 'SQL']

categories.each { |category| Category.create!(title: category) }

# Generate tests.
tests = [
  { title: 'Введение в HTML',     level: 1, category_id: 1, author_id: 1 },
  { title: 'Знакомство с Ruby',   level: 2, category_id: 2, author_id: 1 },
  { title: 'Первые шаги в Rails', level: 3, category_id: 3, author_id: 1 },
  { title: 'Введение в SQL',      level: 1, category_id: 4, author_id: 1 }
]

tests.each do |test|
  Test.create!(
    title: test[:title],
    level: test[:level],
    category_id: test[:category_id],
    author_id: test[:author_id]
  )
end

# Creating a user connection with the passed tests
PassedTest.create!(
  [
    { user_id: 1, test_id: 1 },
    { user_id: 1, test_id: 2 },
    { user_id: 1, test_id: 3 },
    { user_id: 1, test_id: 4 },
    { user_id: 2, test_id: 2 },
    { user_id: 3, test_id: 3 }
  ]
)

# Create questions.
questions = [
  # questions HTML test
  { body: 'Что такое HTML?', test_id: 1 },
  { body: 'Что такое тег?', test_id: 1 },
  { body: 'За что отвечает тег <!DOCTYPE html>?', test_id: 1 },
  { body: 'Что размещается в теге <body>?', test_id: 1 },
  { body: 'Выберите все подходящие ответы из списка:', test_id: 1 },

  # questions Ruby test
  { body: 'Кем был разработан язык Ruby?', test_id: 2 },
  { body: 'По исполнению Ruby это -', test_id: 2 },
  { body: 'Что такое Class?', test_id: 2 },
  { body: 'Что такое Объект?', test_id: 2 },
  { body: 'Что такое Модуль?', test_id: 2 },
  { body: 'В чем отличие Модуля от Класса?', test_id: 2 },

  # questions Rails test
  { body: 'Что такое Rails?', test_id: 3 },
  { body: 'На каком языке написан фреймворк Rails?', test_id: 3 },
  { body: 'Что такое MVC?', test_id: 3 },
  { body: 'Что такое Active Record?', test_id: 3 },
  { body: 'Что такое Контроллер?', test_id: 3 },

  # questions SQL test
  { body: 'Что такое SQL?', test_id: 4 },
  { body: 'К какому типу СУБД относится PostgreSQL?', test_id: 4 },
  { body: 'Что такое индекс?', test_id: 4 },
  { body: 'Что из себя представляет реляционная база данных?', test_id: 4 }
]

questions.each do |question|
  Question.create!(
    body: question[:body],
    test_id: question[:test_id]
  )
end

# Create answers.
answers = [
  # answers HTML test
  # 1
  { body: 'язык разметки гипертекста', correct: true, question_id: 1 },
  { body: 'протокол передачи гипертекста', correct: false, question_id: 1 },
  { body: 'система доменных имён', correct: false, question_id: 1 },

  # 2
  { body: 'это синтаксическая единица языка HTML, которая выделяет или создаёт элемент', correct: true, question_id: 2 },
  { body: 'модель формирования пакетов сетевых данных', correct: false, question_id: 2 },
  { body: 'стандарт записи сетевого адреса', correct: false, question_id: 2 },

  # 3
  { body: 'стандарт записи сетевого адреса', correct: false, question_id: 3 },
  { body: 'говорит браузеру, по какому стандарту написана страница', correct: true, question_id: 3 },
  { body: 'задает кодировку страницы', correct: false, question_id: 3 },

  # 4
  { body: 'хранится информация о странице', correct: false, question_id: 4 },
  { body: 'хранится информация о кодировке', correct: false, question_id: 4 },
  { body: 'размещается весь контент страницы, который пользователь увидит в браузере', correct: true, question_id: 4 },

  # 5
  { body: '/users/21 - абсолютная ссылка', correct: false, question_id: 5 },
  { body: '//google.com - относительная ссылка', correct: true, question_id: 5 },
  { body: 'https://vk.com/reu_itc - абсолютная ссылка', correct: true, question_id: 5 },

  # answers Ruby test
  # 1
  { body: 'Гвидо ван Россум', correct: false, question_id: 6 },
  { body: 'Юкихиро Мацумото', correct: true, question_id: 6 },
  { body: 'Расмус Лердорф', correct: true, question_id: 6 },

  # 2
  { body: 'компилируемый язык', correct: false, question_id: 7 },
  { body: 'интерпритируемый язык', correct: true, question_id: 7 },

  # 3
  { body: 'объект базового класса Class', correct: true, question_id: 8 },
  { body: 'своего рода чертеж, абстрактное описание объекта', correct: true, question_id: 8 },
  { body: 'константа', correct: false, question_id: 8 },

  # 4
  { body: 'экземпляр какого-либо класса', correct: true, question_id: 9 },
  { body: 'сущность, служащая контейнером для данных и управляющая доступом к этим данным', correct: true, question_id: 9 },
  { body: 'объект базового класса Class', correct: false, question_id: 9 },

  # 5
  { body: 'экземпляр какого-либо класса', correct: false, question_id: 10 },
  { body: 'некий контейнер(набор)', correct: true, question_id: 10 },
  { body: 'способ группировки методов, констант, классов, других модулей', correct: true, question_id: 10 },

  # 6
  { body: 'у Модуля нельзя создать экземпляр', correct: false, question_id: 11 },
  { body: 'отличий нет', correct: true, question_id: 11 },
  { body: 'Модуль не может иметь подклассы, нет иерархии наследования', correct: true, question_id: 11 },

  # answers Rails test
  # 1
  { body: 'фреймворк(библиотека)', correct: true, question_id: 12 },
  { body: 'язык программирования', correct: false, question_id: 12 },
  { body: 'специальный Класс, встроенный в язык Ruby', correct: false, question_id: 12 },

  # 2
  { body: 'Pyton', correct: false, question_id: 13 },
  { body: 'JavaScript', correct: false, question_id: 13 },
  { body: 'Ruby', correct: true, question_id: 13 },

  # 3
  { body: 'библиотека(гем)', correct: false, question_id: 14 },
  { body: 'шаблон (паттерн) программирования, разделяющий архитектуру приложения на три модуля', correct: true, question_id: 14 },
  { body: 'объектное представление базы данных в Rails приложениях', correct: false, question_id: 14 },

  # 4
  { body: 'класс Ruby', correct: false, question_id: 15 },
  { body: 'это C в аббревиатуре MVC', correct: false, question_id: 15 },
  { body: 'это M в MVC - модель - которая является слоем в системе, ответственным за представление бизнес-логики и данных', correct: true, question_id: 15 },

  # 5
  { body: 'класс Ruby, унаследованный от ApplicationController', correct: true, question_id: 16 },
  { body: 'это C в аббревиатуре MVC', correct: true, question_id: 16 },
  { body: 'класс Ruby, отвечающий за визуализацию информации', correct: false, question_id: 16 },

  # answers SQL test
  # 1
  { body: 'язык структурированных запросов', correct: true, question_id: 17 },
  { body: 'стандарт записи уникального адреса', correct: false, question_id: 17 },
  { body: 'система управления базами данных', correct: false, question_id: 17 },

  # 2
  { body: 'Файл-серверные', correct: false, question_id: 18 },
  { body: 'Встраиваемые', correct: false, question_id: 18 },
  { body: 'Клиент-серверные', correct: true, question_id: 18 },

  # 3
  { body: 'синтаксическая единица языка SQL', correct: false, question_id: 19 },
  { body: 'объект базы данных(таблица) который содержит в себе значение проиндексированного столбца и указатели на запись в таблице', correct: true, question_id: 19 },
  { body: 'связь записи одной таблицы с записью в другой', correct: false, question_id: 19 },

  # 4
  { body: 'это упорядоченная информация, связанная между собой определёнными отношениями', correct: true, question_id: 20 },
  { body: 'теоретической основой служит реляционная алгебра', correct: true, question_id: 20 },
  { body: 'это набор правил и критериев, которым должна отвечать база данных', correct: false, question_id: 20 }
]

answers.each do |answer|
  Answer.create!(
    body: answer[:body],
    correct: answer[:correct],
    question_id: answer[:question_id]
  )
end
