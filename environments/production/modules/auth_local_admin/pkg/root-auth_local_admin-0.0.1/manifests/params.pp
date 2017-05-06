# == Class auth_local_admin::params
#
# This class is meant to be called from auth_local_admin
# It defines the list of users and corresponding passwords to be created
#
# $pwd is the initial password to be created for all accounts
# $credentials is the username/password hash for user accounts to be created
# $purge is the list of user accounts that should be deleted on the next
# pull from the Puppet Master 
#
  class auth_local_admin::params {
    $pwd           = 'Shipcheckstar2!'
    $credentials   = {'jarmstrong' => $pwd}
    $purge         = []
  }
