koran-kareem.com's Code Source
==============================
اَلسَّلَامُ عَلَيْكُمْ

We're happy to put our website code source free to download and use.

Please follow the documentation in order to install it.

The code was written in year 2012, so is not the best :), any suggestion, improvement are welcome.

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

3) Install assets + dump
------------------------
To install assets:
```
    php app/console assets:install --symlink
    php app/console assetic:dump
```


2) Clear the Cache
------------------
Like any Symfony2 application to clear the cache use:
 
```
    php app/console cache:clear
```


2) Accessing the admin panel
----------------------------
The admin is accessible through `/admin`, the default username/password is admin/admin 



http://www.koran-kareem.com