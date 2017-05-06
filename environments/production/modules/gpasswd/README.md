# puppet-gpasswd

[![Puppet Forge](http://img.shields.io/puppetforge/v/deric/gpasswd.svg)](https://forge.puppetlabs.com/deric/gpasswd)
[![Build Status](https://travis-ci.org/deric/puppet-gpasswd.png?branch=master)](https://travis-ci.org/deric/puppet-gpasswd)

Puppet-driven local group modification capabilities for Linux systems
gpasswd

This is a module that enhances the native group type on systems
supporting gpasswd to allow for the manipulation of group memebers.

Specifically, it adds the `:manages_members` attribute to the native
Puppet group type. No alterations to your group code are required!

Examples
========

```puppet
group { 'test':
  members => ['foo','bar','baz']
}
```

## Installation

Add to your `Puppetfile`:

```ruby
mod 'deric-gpasswd'
```

development version (master branch from github):
```ruby
mod 'deric-gpasswd', :git => 'https://github.com/deric/puppet-gpasswd.git'
```


License
-------

Apache License 2.0

Authors
-------

  * Trevor Vaughan <tvaughan@onyxpoint.com>
  * Tomas Barton

Support
-------

Please log tickets and issues at our [Gpasswd Github Site](https://github.com/deric/puppet-gpasswd/issues)
