# ----------------------------------------------------------------------------
#  Copyright 2005-2015 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------

class ppaas_base(
  $ensure = 'present',
  $autoupgrade=true,
){

  if ! ($ensure in [ "present", "absent" ]) {
    fail("ensure parameter must be absent or present")
  }

  if ! ("$autoupgrade" in [ 'true', 'false' ]) {
    fail("autoupgrade parameter must be true or false")
  }

# Set local variables based on the desired state
  if $ensure == "present" {
    if $autoupgrade == true {
      $package_ensure = latest
    }
    else {
      $package_ensure = present
    }
  }
  else {
    $package_ensure = absent
  }

  $packages = [
    'nano',
    'curl',
    'wget',
    'zip',
    'unzip',
    'git',
    'tar']

  package { $packages:
    ensure => $package_ensure,
  }

  define printPackages{
    notify { $name:
      message => "Installed package: ${name}",
    }
  }
  printPackages{ $packages: }

}
