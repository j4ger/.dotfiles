set -gx windows_host (cat /etc/resolv.conf|grep nameserver|awk '{print $2}')

# setup the most commonly used proxy envvars
set -gx all_proxy "http://$windows_host:7890"
set -gx ALL_PROXY "$all_proxy"
set -gx http_proxy "$all_proxy"
set -gx HTTP_PROXY "$all_proxy"
set -gx https_proxy "$all_proxy"
set -gx HTTPS_PROXY "$all_proxy"
set -gx NO_PROXY 127.0.0.1 localhost v04.local

# setup proxychains
sed -i "113c http $windows_host 7890" ~/.proxychains/proxychains.conf
sed -i "14c systemProp.http.proxyHost=$windows_host" ~/.gradle/gradle.properties
sed -i "16c systemProp.https.proxyHost=$windows_host" ~/.gradle/gradle.properties

# setup git proxy
if [ "`git config --global --get proxy.https`" != "http://$windows_host:7890" ];
    git config --global proxy.https "http://$windows_host:7890"
end
