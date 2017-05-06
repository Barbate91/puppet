# Class: auth_local_admin
# ===========================
#
# This module uses a username/password hash to act as an "Access Control List" to determine which users should have
# local Administrator accounts on the server. If there is a local Administrator account present on the server that
# is not on the ACL that user will be deleted.
#
# Parameters
# ----------
#
# $credentials  - Array of username and password pairs used to generate users with login credentials
# $acl 		- Array of authorized users for the access control list
# $purge	- List of user accounts to be deleted on next pull
#
# Authors
# -------
#
# Jake Armstrong <jarmstrong@kionetworks.com>
#
# Copyright
# ---------
#
# Copyright 2016 KIO Networks
#
class auth_local_admin (
   $credentials = $auth_local_admin::params::credentials,
   $acl 	= $auth_local_admin::params::credentials.keys,
   $purge	= $auth_local_admin::params::purge,
   )
   inherits auth_local_admin::params {
	case $kernel {
		'windows': {
			$credentials.each |$user| {
      				exec { "Creating Local Administrator account for ${user[0]}":
            				command	=> epp('auth_local_admin/add-user.epp', {'username' => $user[0], 'password' => $user[1]}),
	    				unless 		=> epp('auth_local_admin/verify-user.epp', {'username' => $user[0]}),
            				provider	=> powershell,
					returns		=> [0, 2],
         			}
			}
			exec {"Removing unauthorized Local Administrators":
					command	 => epp('auth_local_admin/remove-user.epp', {'acl' => $acl}),
					provider => powershell,
					returns  => [0, 2],
			}
      		}
		'Linux': {
			$credentials.each |$user| {
				user { "${user[0]}":
					before			=> [Group['wheel'],Exec["${user[0]} Password Enforcement"]],
					ensure			=> 'present',
					managehome		=> yes,
					groups			=> 'mail',
					password_max_age	=> '90',
					shell			=> '/bin/bash',
				}
				exec { "${user[0]} Password Enforcement":
					command			=> "echo ${user[0]}:${user[1]} | chpasswd; chage -d 0 ${user[0]}",
					onlyif			=> epp('auth_local_admin/verify-pwdStatus-linux.epp', {'username' => $user[0]}),
					provider		=> shell,
				}	
			}
			group { "wheel":
					name			=> 'wheel',
					ensure			=> 'present',
					attribute_membership	=> 'inclusive',
					members			=> $acl,
			}
			$purge.each |$user| {
				user { "${user}":
					ensure			=> 'absent',
					managehome		=> yes,
				}
			}
		}
		'FreeBSD': {
			$credentials.each |$user| {
				user { "${user[0]}":
					before			=> [Group['wheel'],Exec["${user[0]} Password Enforcement"]],
					ensure			=> 'present',
					managehome		=> yes,
					password_max_age	=> '90',
					shell			=> '/bin/tcsh',
				}
				exec { "${user[0]} Password Enforcement":
                                        command                 => "echo ${user[1]} | pw usermod ${user[0]} -h 0 -p 0d",
                                        onlyif                  => epp('auth_local_admin/verify-pwdStatus-BSD.epp', {'username' => $user[0]}),
                                        provider                => shell,
                                }
			}
			group { "wheel":
					name			=> 'wheel',
					ensure			=> 'present',
					attribute_membership	=> 'inclusive',
					members			=> $acl,
			}
			$purge.each |$user| {
				user { "${user}":
					ensure			=> 'absent',
					managehome		=> yes,
				}
			}
		}
	}
}
