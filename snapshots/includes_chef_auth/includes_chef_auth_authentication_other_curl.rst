.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


An API request can be made using cURL, which is a Bash shell script that requires two utilities: awk and openssl. The following example shows how an authenticated request can be made using the Chef server API and cURL:

.. code-block:: bash

   #!/usr/bin/env bash

   _chef_dir () {
     # Helper function:
     # Recursive function that searches for chef configuration directory
     # It looks upward from the cwd until it hits /.  If no directory is found,
     # ~/.chef is chosen if it exists
     # You could simply hard-code the path below
   
     if [ "$PWD" = "/" ]; then
     if [ -d ".chef" ]; then
       echo "/.chef"
         elif [ -d "$HOME/.chef" ]; then
           echo "$HOME/.chef"
         fi
       return
     fi
     
     if [ -d '.chef' ];then
       echo "${PWD}/.chef"
     else
       (cd ..; _chef_dir)
     fi
   }
   
   _chomp () {
     # helper function to remove newlines
     awk '{printf "%s", $0}'
   }
   
   chef_api_request() {
     # This is the meat-and-potatoes, or rice-and-vegetables, your preference really.
   
     local method path body timestamp chef_server_url client_name hashed_body hashed_path
     local canonical_request headers auth_headers
   
     chef_server_url="https://api.opscode.com/organizations/my_org"
     # '/organizations/ORG_NAME' is needed
     if echo $chef_server_url | grep -q "/organizations/" ; then
       endpoint=/organizations/${chef_server_url#*/organizations/}${2%%\?*}
     else
       endpoint=${2%%\?*}
     fi
     path=${chef_server_url}$2
     client_name="chef_user"
     method=$1
     body=$3
   
     hashed_path=$(echo -n "$endpoint" | openssl dgst -sha1 -binary | openssl enc -base64)
     hashed_body=$(echo -n "$body" | openssl dgst -sha1 -binary | openssl enc -base64)
     timestamp=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
   
     canonical_request="Method:$method\nHashed Path:$hashed_path\nX-Ops-Content-Hash:$hashed_body\nX-Ops-Timestamp:$timestamp\nX-Ops-UserId:$client_name"
     headers="-H X-Ops-Timestamp:$timestamp \
       -H X-Ops-Userid:$client_name \
       -H X-Chef-Version:0.10.4 \
       -H Accept:application/json \
       -H X-Ops-Content-Hash:$hashed_body \
       -H X-Ops-Sign:version=1.0"
 
     auth_headers=$(printf "$canonical_request" | openssl rsautl -sign -inkey \
       "$(_chef_dir)/${client_name}.pem" | openssl enc -base64 | _chomp |  awk '{ll=int(length/60);i=0; \
       while (i<=ll) {printf " -H X-Ops-Authorization-%s:%s", i+1, substr($0,i*60+1,60);i=i+1}}')
    
     case $method in
       GET)
         curl_command="curl $headers $auth_headers $path"
         $curl_command
         ;;
       *)
         echo "Unknown Method. I only know: GET" >&2
         return 1
         ;;
       esac
     }

    chef_api_request "$@"

After saving this shell script to a file named ``chef_api_request``, use it similar to the following:

.. code-block:: bash

   $ bash chef_api_request GET "/clients"
