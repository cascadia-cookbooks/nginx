# nginx Cookbook
This will install the NGINX web server via package. It will install the current
mainline version, currently 1.11

## Requirements
### Supported Platforms
* ubuntu/xenial64
* ubuntu/trusty64
* centos/7
* centos/6
* debian/jessie64
* debian/wheezy64

### Chef
- Chef '>= 12.5'

## Attributes
- TODO

## Usage
Here's an example `nginx` role that will install Nginx.

```ruby
name 'nginx'
description 'install nginx'

override_attributes(
    'nginx' => {
        ...
    }
)

run_list(
    'recipe[cop_nginx::default]'
)
```

## Testing
* http://kitchen.ci
* http://serverspec.org

Testing is handled with ServerSpec, via Test Kitchen, which uses Vagrant to spin up VMs.

ServerSpec and Test Kitchen are bundled in the ChefDK package.

### Dependencies
```bash
$ brew cask install chefdk
```

### Running
Get a listing of your instances with:

```bash
$ kitchen list
```

Run Chef on an instance, in this case default-ubuntu-1204, with:

```bash
$ kitchen converge default-ubuntu-1204
```

Destroy all instances with:

```bash
$ kitchen destroy
```

Run through and test all the instances in serial by running:

```bash
$ kitchen test
```

### Errors

## Notes
* The `Berksfile.lock` file has been purposely omitted, as we don't care about upstream dependencies.
