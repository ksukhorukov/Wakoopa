# Wakoopa Statistics

Parse and process statistical information from large log files.

# Components

* Sinatra
* Sqlite3
* Bootrstrap

# Installation

Do the following steps:

```
$ git clone https://github.com/ksukhorukov/Wakoopa
$ rvm use ruby-2.1.5@wakoopa --create
$ bundle
$ rake db:migrate
$ rake data:parse
$ rake statistics:calc
$ chmox +x app.rb
$ ./app.rb
```
Then open  http://localhost:4567 

Enjoy!

### [EOF]