.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to modify the default script for Microsoft Windows and Windows PowerShell:

..   # Moved this license/header info out of the code sample; keeping it in the topic just because
..   @rem
..   @rem Author:: Seth Chisamore (<schisamo@opscode.com>)
..   @rem Author:: Michael Goetz (<mpgoetz@opscode.com>)
..   @rem Author:: Julian Dunn (<jdunn@opscode.com>)
..   @rem Copyright:: Copyright (c) 2011-2013 Opscode, Inc.
..   @rem License:: Apache License, Version 2.0
..   @rem
..   @rem Licensed under the Apache License, Version 2.0 (the "License");
..   @rem you may not use this file except in compliance with the License.
..   @rem You may obtain a copy of the License at
..   @rem
..   @rem     http://www.apache.org/licenses/LICENSE-2.0
..   @rem
..   @rem Unless required by applicable law or agreed to in writing, software
..   @rem distributed under the License is distributed on an "AS IS" BASIS,
..   @rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
..   @rem See the License for the specific language governing permissions and
..   @rem limitations under the License.
..   @rem


.. code-block:: bash
   
   @setlocal
   
   <%= "SETX HTTP_PROXY \"#{knife_config[:bootstrap_proxy]}\"" if knife_config[:bootstrap_proxy] %>
   @mkdir <%= bootstrap_directory %>
   
   > <%= bootstrap_directory %>\wget.ps1 (
    <%= win_wget_ps %>
   )
   
   :install
   @rem Install Chef using chef-client MSI installer
   
   <% url="http://reposerver.example.com/chef-client-11.6.0.rc.1-1.windows.msi" -%>
   @set "REMOTE_SOURCE_MSI_URL=<%= url %>"
   @set "LOCAL_DESTINATION_MSI_PATH=<%= local_download_path %>"
   
   @powershell -ExecutionPolicy Unrestricted -NoProfile -NonInteractive "& '<%= bootstrap_directory %>\wget.ps1' '%REMOTE_SOURCE_MSI_URL%' '%LOCAL_DESTINATION_MSI_PATH%'"
   
   @REM Replace install_chef from knife-windows Gem with one that has extra flags to turn on Chef service feature -- only available in Chef >= 11.6.x
   @REM <%= install_chef %>
   @echo Installing Chef Client 11.6.0.rc1 with msiexec
   @msiexec /q /i "%LOCAL_DESTINATION_MSI_PATH%" ADDLOCAL="ChefClientFeature,ChefServiceFeature"
   @endlocal
   
   @echo Writing validation key...
   
   > <%= bootstrap_directory %>\validation.pem (
    <%= validation_key %>
   )
   
   @echo Validation key written.
   
   <% if @config[:encrypted_data_bag_secret] -%>
   > <%= bootstrap_directory %>\encrypted_data_bag_secret (
    <%= encrypted_data_bag_secret %>
   )
   <% end -%>
    
   > <%= bootstrap_directory %>\client.rb (
    <%= config_content %>
   )
   
   > <%= bootstrap_directory %>\first-boot.json (
    <%= run_list %>
   )
   
   <%= start_chef %>







