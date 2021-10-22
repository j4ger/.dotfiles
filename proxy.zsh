export windows_host=`cat /etc/resolv.conf|grep nameserver|awk '{print $2}'`

# setup the most commonly used proxy envvars
export all_proxy="http://$windows_host:7890"
export ALL_PROXY="$all_proxy"
export http_proxy="$all_proxy"
export HTTP_PROXY="$all_proxy"
export https_proxy="$all_proxy"
export HTTPS_PROXY="$all_proxy"
export no_proxy="127.0.0.1,localhost,v04.local"
export NO_PROXY="$no_proxy"

# setup proxychains
sed -i "113c http $windows_host 7890" ~/.proxychains/proxychains.conf
sed -i "14c systemProp.http.proxyHost=$windows_host" ~/.gradle/gradle.properties
sed -i "16c systemProp.https.proxyHost=$windows_host" ~/.gradle/gradle.properties

# setup git proxy
if [[ "`git config --global --get proxy.https`" != "http://$windows_host:7890" ]]
then
    git config --global proxy.https "http://$windows_host:7890"
fi

if [[ "`git config --global --get proxy.http`" != "http://$windows_host:7890" ]]
then
    git config --global proxy.http "http://$windows_host:7890"
fi
