// Предисловие: к сожалению, я не смог придумать пример, который
// был бы полезен для дальнейшей работы:( Я понимаю, что это не
// круто, но, честно, в голову ничего не пришло, а время уже поджимает.


// Что ж, допустим, мы хотим создать контейнер для хранения элементов
// разных типов. Для этого мы создадим класс GenericContainer

class GenericContainer<T> {
    var item: T

    init(item: T) {
        self.item = item
    }
}


// Экстеншен с дженериком

extension GenericContainer {
    func printItem() {
        print("Содержимое контейнера: \(item)")
    }
}


// Пример

let intContainer = GenericContainer(item: 542)
intContainer.printItem()

let stringContainer = GenericContainer(item: "don't even know what to put here")
stringContainer.printItem()


// Теперь реализуем протокол с ассоциативными типами.
// Например, мы хотим создать протокол DictionaryConvertible,
// который позволит объектам преобразовывать себя в словарь

protocol DictionaryConvertible {
    associatedtype Key: Hashable
    associatedtype Value

    func toDictionary() -> [Key: Value]
}


// Пример

struct Person: DictionaryConvertible {
    var name: String
    var age: Int

    func toDictionary() -> [String: Any] {
        return ["name": name, "age": age]
    }
}

let person = Person(name: "Dinar", age: 21)
let dictionary = person.toDictionary()
print(dictionary)


// Теперь стирание с помощью оберток с приватными классами.
// Стирание используется, когда нам нужно хранить объекты разных
// типов с общим базовым типом, например, в массиве.
// Давайте создадим простую обертку для стирания

class AnyContainer {
    private let _printItem: () -> Void

    init<T>(_ container: GenericContainer<T>) {
        _printItem = {
            container.printItem()
        }
    }

    func printItem() {
        _printItem()
    }
}


// Пример

let anyIntContainer = AnyContainer(intContainer)
let anyStringContainer = AnyContainer(stringContainer)

anyIntContainer.printItem()
anyStringContainer.printItem()
