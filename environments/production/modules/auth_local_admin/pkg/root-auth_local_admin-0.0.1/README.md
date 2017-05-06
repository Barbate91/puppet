# auth_local_admin

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with auth_local_admin](#setup)
    * [What auth_local_admin affects](#what-auth_local_admin-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with auth_local_admin](#beginning-with-auth_local_admin)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module manages, via the params, a list of users that should have local Administrator accounts on the server.
It will also delete, other than the default local Administrator, any local Administrator account that is not present within
the list defined in params.pp
 
Leveraging this module will allow a single, enforcable list of local Administrators to be deployed across multiple VMs. Should a
user leave, simply updating the params will automatically delete the user on all servers on their next pull from the Puppet Master.

## Setup

Configuration for this module requires manually modifying the username => password hash in params.pp to have the list of authorized local Administrator accounts to be created and the accounts' initial passwords

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
