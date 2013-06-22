cd `dirname $0`/..
if [ -z "$APPSCALE_HOME_RUNTIME" ]; then
    export APPSCALE_HOME_RUNTIME=`pwd`
fi

DESTDIR=$2
APPSCALE_HOME=${DESTDIR}${APPSCALE_HOME_RUNTIME}

. debian/appscale_install_functions.sh

echo "Install AppScale into ${APPSCALE_HOME}"
echo "APPSCALE_HOME in runtime=${APPSCALE_HOME_RUNTIME}"

case "$1" in
    core)
	# scratch install of appscale including post script.
	installappscaleprofile
	. /etc/profile.d/appscale.sh
	installgems
	postinstallgems
	installhaproxy
	postinstallhaproxy
	installnginx
	postinstallnginx
        installpython25
        installpython26
	pip install numpy 
	pip install matplotlib PIL pycrypto lxml xmpppy 
	installappserverjava
	postinstallappserverjava
	installmonitoring
	postinstallmonitoring
	installthrift_fromsource
	postinstallthrift_fromsource
        installtornado_fromsource
 	pip install tornado
	installprotobuf
	postinstallprotobuf
        pip install flexmock nose
	installhadoop
	postinstallhadoop
	installzookeeper
	postinstallzookeeper
        installrabbitmq
        postinstallrabbitmq
	pip install celery
	installservice
	postinstallservice
	setupntpcron
        updatealternatives
	sethosts
        setulimits
	;;
    cassandra)
	installcassandra
	postinstallcassandra
	;;
    hbase)
	installhbase
	postinstallhbase
	;;
    hypertable)
	installhypertable
	postinstallhypertable
	;;
    # for test only. this should be included in core and all.
    zookeeper)
	installzookeeper
	postinstallzookeeper
	;;
    hadoop)
	installhadoop
	postinstallhadoop
	;;
    protobuf-src)
	installprotobuf_fromsource
	postinstallprotobuf
	;;
    rabbit-mq)
        installrabbitmq
        postinstallrabbitmq
        ;; 
    celery)
        installcelery
        ;;
    all)
	# scratch install of appscale including post script.
	installappscaleprofile
	. /etc/profile.d/appscale.sh
	installgems
	postinstallgems
	installhaproxy
	postinstallhaproxy
	installnginx
	postinstallnginx
        installpython25
        installpython26
	pip install numpy 
	pip install matplotlib PIL pycrypto lxml xmpppy 
	installappserverjava
	postinstallappserverjava
	installmonitoring
	postinstallmonitoring
	installthrift_fromsource
	postinstallthrift_fromsource
        installtornado_fromsource
        installflexmock
        installnose
        postinstalltornado
	installprotobuf
	postinstallprotobuf
	installhadoop
	postinstallhadoop
	installzookeeper
	postinstallzookeeper
        installcassandra
	postinstallcassandra
	installhbase
	postinstallhbase
	installhypertable
	postinstallhypertable
        installrabbitmq
        postinstallrabbitmq
        installcelery
	installservice
	postinstallservice
	updatealternatives
	setupntpcron
        sethosts
        setulimits
	;;
esac
