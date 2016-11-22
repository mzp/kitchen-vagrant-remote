# Kitchen::Driver::VagrantRemote

A Test Kitchen Driver for Vagrant at remote host.

This driver extends [kitchen-vagrant](https://github.com/test-kitchen/kitchen-vagrant) to execute vagrant at remote host.

## Requirements
Same as [kitchen-vagrant](https://github.com/test-kitchen/kitchen-vagrant).

## Examples

```
$ export REMOTE_USER=$(whoami)
$ export REMOTE_HOST=$(ifconfig en1 | grep 'inet ' | awk '{print $2}')

$ docker-compose build
$ docker-compose run dev bash

# cd example
# bundle
# bundle exec test
```

## Configuration
You can use same configuration as [kitchen-vagrant](https://github.com/test-kitchen/kitchen-vagrant). And more, you can also use following configuration.

### remote_user
User name of remote server.

### remote_host
Host name of remote server.

### remote_root
Root directory of remote server.

The default is `'/private/tmp'`.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

