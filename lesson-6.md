# Продвинутая верстка

## Детальная настройка layout

Достаточно часто возникают задачи, когда требуется донастроить верстку компонентов, после рассчета констрейнтов. Например, изменять положение вложенных элементов, к "констрейнтам" которых у нас нет доступа. Для этого нужно переопределить функцию `layoutSubviews`. 

````
class CustomButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame.origin.x += 10
    }
}
````

Важно! Функцию `layoutSubviews` нельзя вызывать на прямую. Для используются:
* `func setNeedsLayout()` - помечает что текущая верстка невалидная, система пересчитает верстку этого компонента, когда посчитает нужным (оптимизация на уровне UIKit)
* `func layoutIfNeeded()` - если верстка невалидная, ранее вызывалась `setNeedsLayout`, UIKit принудительно пересчитает её в текущем контексте

Рассмотрим на пример обновления константы у констрейнта. 
`someConstraint.constant = 10` - при изменении константы, у вьюх констрейнта вызывается  `setNeedsLayout()`. Если выполнить это внутри анимационного блока:

````
UIView.animate(withDuration: 0.3) {
    self.someConstraint.constant = 10
}
````

То ничего не произойдет, т.к. лайоут помечен как невалидный, и пересчитается потом, а значит анимационный блок нечего захватывать. Чтобы всё заработало нужно добавить вызов  layoutIfNeeded(), после обновления констрейнтов:

````
UIView.animate(withDuration: 0.3) {
    self.someConstraint.constant = 10
    self.view.layoutIfNeeded()
}
````

У UIViewController так же есть функции для настройки собственной реакции на пересчет лайаута:
* `func viewWillLayoutSubviews()` - вызывается перед вызывом `layoutSubviews` у рут вью
* `func viewDidLayoutSubviews()` - вызывается после вызыва `layoutSubviews` у рут вью

### Предпочтительный размер

Для многих системных компонентов не требуется указывать кострейнты размеров (ширину и высоты), т.к. они вычисляются на основе вложенного в них контента. Мы тоже можем так делать, для переопределяем вычисляемое свойство у вью:

````
override var intrinsicContentSize: CGSize {
    return CGSize(width: UIView.noIntrinsicMetric, height: 50)
}
````

В пример выше, мы укзали что у компонета предпочтительная высота 50 pt, а по ширине может быть любой размер

> Важно! Констрейнты имеет более высокий приоритет чем `intrinsicContentSize`, т.е. указав констрейн высоты 60 pt, элемент будет занимать 60, а не 50.

Если intrinsicContentSize динамический, об его изменениях можем уведомлять UIKit функцией `invalidateIntrinsicContentSize`

````
class MyLabel: UIView {
    var text: String? {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        // Calculate size text CoreText.framework
    }
}
````

Если `intrinsicContentSize` вычисляется в рантайме и IB не может вычислить размеры вашего компонента, в Size inspector меню, можно указать placeholder значение `intrinsicContentSize`.

## Домашнее задание

1. Доделать все то что не успели на предыдущих уроках
2. Установить менеджер зависимостей (библиотек) [Carthage](https://github.com/Carthage/Carthage)
3. Установать библиотеку [Alamofire](https://github.com/Alamofire/Alamofire), последняя версия `5.0.0-rc.3`
