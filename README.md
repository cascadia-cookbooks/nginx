# nginx Cookbook
This will install the NGINX web server via package. At this time this cookbook only supports Ubuntu 14.04 and 16.04.

It installs and configures NGINX. In time it will also include installment via source and LWRPs for virtual hosts.

## Requirements
### Platforms
- Ubuntu 14.04
- Ubuntu 16.04

### Chef
- Chef '>= 12.5'

### Cookbooks
- apt

## Attributes
- `node['nginx']['install_method']` = method of installation, default `package`.
- `node['nginx']['version']` = Version of NGINX to install, defaults to latest
  stable of package.

## Usage
Here's an example `nginx` role that will install Nginx.

```ruby
name "nginx"
description "install nginx"
override_attributes(
  "nginx" => {
    "install_method" => "package"
  }
)
run_list(
  "recipe[cop_nginx::default]"
)
```

## Notes
* The `Berksfile.lock` file has been purposely omitted, as we don't care about upstream dependencies.
* This cookbook supports testing with Test Kitchen and ServerSpec. Run `kitchen test` to spin up VMs and run tests.
