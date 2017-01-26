koran-kareem.com's Code Source
==============================
اَلسَّلَامُ عَلَيْكُمْ

We're happy to put our website's code source free to download and use.

Please follow the documentation in order to install it, the application is based on Symfony2 framework and it runs on latest stage version of it (2.8.15).

The code was written beg the year 2012, so is not the best :), any suggestion or improvement are welcome.

1) Installation
---------------
Clone the project and install the dependencies:

    php composer.phar install

To install DB schema (it contain already the data for current Reciters, Adhkar, Tilawat,...):
```
    php app/console quran:cleanandcreate
```

Download upload directory and unzip it under web folder, it should be as this path `web/upload`:

https://s3.eu-central-1.amazonaws.com/koran-karrem/upload.zip

2) Install assets + dump
------------------------
To install assets:
```
    php app/console assets:install --symlink
    php app/console assetic:dump
```


3) Clear the Cache
------------------
Like any Symfony2 application to clear the cache use:
```
    php app/console cache:clear
```


4) Run the application in development environment
-------------------------------------------------
Cd to the project root folder, and run the php server through this command 
```
    php -S  127.0.0.1:8080 -t web
```

After you can browse the main page: http://127.0.0.1:8080/app_dev.php


5) Accessing the admin panel
----------------------------
The admin is accessible through http://127.0.0.1:8080/app_dev.php/admin , the default username/password is admin/admin



6) License (GPL)
----------------
GNU General Public License v 3.0


http://www.koran-kareem.com
