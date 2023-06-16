# Website Filter
Простенькая программка для просмотра веб страниц с возможностью блокировки открытия или поиска ссылок, в которых будут присутствовать слова из фильтра.
Пользователь имеет возможность добавлять и удалять слова - ограничения.

## Содержание
- [Технологии](#технологии)
- [Дополнительно](#дополнительно)
- [Скриншоты](#скриншоты-программы)
- [Contributing](#contributing)

## Технологии
- Swift
- UIKit
- Code-only layout
- Auto Layout
- WebKit
- MVC
- Without storyboard

## Дополнительно
В качестве дополнения добавлено правило для фильтра: минимум два символа и без пробелов.
Испльзовалось: Regular expression
```sh
"^([a-zA-Zа-яА-Я]{1,}[^ ])$"
```

## Скриншоты программы:

<img src="https://git.foxminded.ua/foxstudent103423/websitefilter/-/blob/main/Screenshot/Screenshot%202023-06-14%20at%2020.27.09.png" alt="drawing" width="100"/>
<img src="https://git.foxminded.ua/foxstudent103423/websitefilter/-/blob/main/Screenshot/Screenshot%202023-06-14%20at%2020.28.28.png" alt="drawing" width="200"/>
<img src="./Screenshot/Screenshot%202023-06-14%20at%2020.30.04.png" alt="drawing" width="100"/>

## Contributing
Если вы нашли баг или замечание в коде или при работе программы, пожалуйста напишите мне на [ почту](sud85@outlook.com).


### Зачем вы разработали этот проект?
___
В учебных целях. При прохождении курса [Foxminded]((https://lms.foxminded.ua/my/)) по Swift

