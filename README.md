# Installing Laravel 9.* with php 8.0.* as docker container
Script is slightly modified laravel official [installer script](https://laravel.com/docs/10.x/installation#docker-installation-using-sail) downloaded with the command:
```
curl -s "https://laravel.build/example-app" | bash
```

and install `Laravel 9.*` inside the newly created directory `lvl9-clean`.

### sail - PHP version change
To change PHP version you should update `laravel.test` container in `docker-compose.yml`

Set `build` definition :
```
./vendor/laravel/sail/runtimes/8.0
```

and for the corresponding version you can change the `image` name:
```
image: sail-8.0/app
```

Now you should rebuild your container images:
```
sail build --no-cache
```
and then:
```
sail up
``` 

### Laravel files update

Delete `composer.lock` and run:
```
composer install
```


### Docker update
Stop `sail`:
```
sail down
```
Remove the container containing the `Laravel` application.


Optionally you can rename `lvl9-clean` directory to your own.

Start `sail`:
```
sail up
```
