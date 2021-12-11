### Assignment #5

# Pokédex

### Opis zadania

Celem zadania jest stworzenie aplikacji **Pokédex** korzystając z [Swift Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html). Aplikacja należy zbudować przy pomocy MVVM. 

⚠️⚠️⚠️ WAŻNA INFORMACJA: Aby korzystać z async/await należy ustawić *iOS Deployment Target* na iOS 15. ⚠️⚠️⚠️

W zadaniu należy pobierać pokemony i je łapać 🪤.
Wykorzystamy do tego api Switter. Dokumentacja jest dostępna [tutaj](https://github.com/DaftMobile/switter).

>Samo API jest dostępne pod adresem [https://switter.app.daftmobile.com](https://switter.app.daftmobile.com).

---

UI aplkacji wygląda bardzo prosto:
1. Text z numerem Pokémona
2. Image obrazek Pokémona (pobrany z endpointu `/pokemon/:number/image`)
3. Pokazuje napis Pokémona

#### Pobieranie

Główną funkcjonalnością aplikacji jest zmienianie aktualnie wybranego Pokémona przy pomocy tapnięcia. Będziesz również musiał zmieniać kolory tła w zależności od aktualnie wybranego Pokémona.

#### Fetch

1. Aplikacja **nie** powinna korzystać z endpointu do pobierania wszystkich Pokémonów!
2. Wchodząc do aplikacji mamy jedynie numer aktualnego Pokémona (1).
3. Tapnięcie powoduje **pobranie** Pokémona o powiększonym o 1 numerze.
4. Szybkie podwójne (Double tap) tapnięcie powoduje **pobranie** Pokémona o pomniejszonym o 1 numerze.
5. W związku z tym nie robimy zapętleń (tapnięcie dwoma palcami nie działa jak mamy wybranego pierwszego Pokémona).

#### Catch

Dodatkową funkcjonalnością jest swipe up. Swipe up powoduje (obviously 💁‍♀️) rzut Pokeballem i złapanie Pokémona przy pomocy calla HTTP do metody `catch` (a konkretnie `/pokemon/:number/catch`). Zauważ, że ta metoda to **POST**, a nie (domyślny) **GET**. Po złapaniu Pokémona odświeżamy widok (przy pomocy danych zwróconych z `catch`) oraz pobieramy nowy obrazek (który powinien być już kolorowy).

>Użyjcie `DragGesture`.

#### Download Progress

W czasie pobierania nowego Pokémona, oraz w czasie pobierania obrazka użytkownik powinien jasno widzieć, że aplikacja coś robi. Proponuję użyć do tego `ProgressView`. Pamiętajcie, że tutaj pobierają się dwie rzeczy – zarówno dane o Pokemonie, jak i obrazek. Zostawiam Wam design pokazania progressu.

Poniżej screenshoty z gotowej aplikacji.
![Simulator Screen Shot - iPhone 12 - 2021-12-06 at 21 05 06](https://user-images.githubusercontent.com/27335471/144915967-37ef4d2e-0179-4b6d-aaa7-0004e6c8ffaa.png)
![Simulator Screen Shot - iPhone 12 - 2021-12-06 at 21 05 15](https://user-images.githubusercontent.com/27335471/144915981-00fcd483-a4b1-4849-9890-dbb0e03189cf.png)
![Simulator Screen Shot - iPhone 12 - 2021-12-06 at 21 05 32](https://user-images.githubusercontent.com/27335471/144915971-c48119a3-6d46-4ccf-9447-909352fd4cae.png)

### Obsługa błędów

Aplikacja powinna wyświetlić prosty alert z `localizedDescription` i przyciskiem ok w przypadku wystąpienia błędu.

### Pomoce

Do zamiany `Int` który jest w formacie hex na `Color` skorzystaj z tego:
```swift
extension Color {
	init(hex: Int) {
		let components = (
			R: CGFloat((hex >> 16) & 0xff) / 255,
			G: CGFloat((hex >> 08) & 0xff) / 255,
			B: CGFloat((hex >> 00) & 0xff) / 255
		)
		self.init(red: components.R, green: components.G, blue: components.B)
	}
}
```

Aby uzyskać uuid urządzenia skorzystaj z tego:
```swift
UIDevice.current.identifierForVendor?.uuidString
```

### Wskazówki

1. [Dokumentacja](https://github.com/DaftMobile/switter) jest super żeby wiedzieć jak działają endpointy
2. [Insomnia](https://insomnia.rest) jest super do testowania i sprawdzania jakich danych się spodziewać
3. Dzisiaj nie ma starter projectu. Sami musicie stworzyć projekt w XCode.
4. Skorzytaj z URLRequest aby dodać header
5. Aby zamienić `Data` na Image użyj `UIImage(data: Data)`
6. Pamiętaj aby updateować UI na wątku Main
7. Gesty mają domyślny priorytet tak jak zostały dodane (ten najpierw dodany jest przed tym później)
8. Więcej o gestach możesz przeczytać [tu](https://www.hackingwithswift.com/books/ios-swiftui/how-to-use-gestures-in-swiftui)

### Kryteria oceny

1. Poprawne pobieranie Pokémonów
2. Poprawna obsługa tapnięć
3. Poprawna obsługa `catch`
4. Wyświetlanie informacji o trwającym requeście
5. Poprawna interakcja z `URLSession` i `SwiftUI`
6. Poprawne korzystanie z `async` i `await`

### Odpowiedzi

Odpowiedzi będą automatycznie przyjmowane o północy z soboty na niedzielę (do końca **11.12.2021**). Pamiętajcie o pushowaniu swoich commitów!

#### Powodzenia! 💪👨‍💻👩‍💻👾
