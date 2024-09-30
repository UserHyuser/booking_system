# README
Booking system Rails test task.

# Init
1. Change your pg db credetials in `config/database.yml`. You can use both: docker or local db.
2. run `bin/setup` & `rails s` if launching without docker.
3. `docker-compose up` if you want to use docker but rub `rails db:seed` manually.

# Architecture
1. Authentification was made with Ruby 3.2.2 & Rails 7.1 without Devise gem.
2. Caching was made for the Events page.
3. I used Creators with Contracts on `dry-contract` for better error handling and not to use validations or callback.
4. Possibility to async booking was made with transaction and locking on DB level. Not the best one but the simpliest solution here. I'd like to discuss that part.

# Initial requirements
Build a simple event booking system using Ruby on Rails with the following core functionalities:

Your task is to build a simple event ticketing system using Ruby on Rails. The system should have the following features:

    User Registration and Authentication: Users should be able to register, login, and logout.
    Ticket Booking: Users should be able to book tickets for an event. A user can book multiple tickets, but not more than the total number of tickets available for the event.
    Viewing Events: Users should be able to view the list of events. Users should also be able to view the events they have created and the tickets they have booked.

Challenges:

    Concurrency Handling: Implement a solution to handle the situation where multiple users are trying to book tickets for the same event at the same time, and the number of tickets requested is more than the number of tickets available.
    Performance: Implement caching to improve the performance of the application. Use Rails' built-in caching mechanisms.
    Use relevant gems and design principles to ensure the code is clean, scalable, and maintainable.

Feel free to keep the application design super simple. You DO NOT need to worry about the frontend part of it.
