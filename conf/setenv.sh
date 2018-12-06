#!/bin/sh

# TTENTION: Adapter les paramètres suivants:
# DEBUT du paramétrage

# Mémoire alloué à l'application Jalios 
SERVER_MEM=2048m

# Spécifier l'IP de la machine pour le monitoring
SERVER_JMX_IP=0.0.0.0

# Port d’écoute pour le monitoring via JMX
SERVER_JMX_PORT=8010

# Nom de la plateforme pour le monitoring
SERVER_JMX_NAME="jalios/leader"

# Taille disque max pour la rotation du monitoring
SERVER_JMX_JMC_SIZE=5g

# Durée maximale pour la rotation du monitoring
SERVER_JMX_JMC_AGE=1d

#(Optional) Override Tomcat's default UMASK of 0027
# UMASK="0007"

# FIN du paramétrage


# Configuration Apache Tomcat
DATETIME=$(date +"%Y-%m-%d-%H-%M-%S");
JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
CLASSPATH="$JAVA_HOME/lib/tools.jar"
CATALINA_PID="$CATALINA_BASE/tomcat.pid"

# Gestion de la mémoire du serveur
JVM_MEM="-Xmx$SERVER_MEM -Xms$SERVER_MEM"

# Gestion des optimisations du Garbage Collector
#JVM_GC="-server -XX:+UseG1GC -XX:MaxMetaspaceSize=512m"

# Gestion des options de la JVM
#  - Server X11 absent
#  - Encoding UTF-8
JVM_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8"

# Gestion du Apache Tomcat Native
#  - Ajout du path /usr/lib/x86_64-linux-gnu/
JVM_OPTS="$JVM_OPTS -Djava.library.path='/usr/java/packages/lib/amd64:/usr/lib64:/lib64:/lib:/usr/lib:/usr/lib/x86_64-linux-gnu/'"


# Gestion des slashs, 
#   Nécessaire pour les configurations:
#     * ayant le domain dans le login des utilisateurs
#     * multi-LDAP
#
#  - the '\' character will be permitted as a path delimiter.
#  -  '%2F' and '%5C' will be permitted as path delimiters
# JVM_OPTS="$JVM_OPTS -Dorg.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=true;-Dorg.apache.catalina.connector.CoyoteAdapter.ALLOW_BACKSLASH=true"


# Activation de Java Management Extensions (JMX)
#  - IP d'accès du serveur : SERVER_JMX_IP
#  - Port d'écoute sur le serveur : SERVER_JMX_PORT
#  - Activation de la préférence pour l'IPv4
#  - Pas de gestion de certificats SSL
#  - Pas de gestion d'authentification
JVM_JMX="-Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=$SERVER_JMX_IP -Dcom.sun.management.jmxremote.port=$SERVER_JMX_PORT -Djava.net.preferIPv4Stack=true"

# Activation de Java Mission Control (JMC)
#JVM_JMC="-XX:+UnlockCommercialFeatures -XX:+FlightRecorder"

# Gestion exposition Java Mission Control (JMC) via Java Management Extensions (JMX)
#JVM_JMX="$JVM_JMX -Dcom.sun.management.jmxremote.rmi.port=$SERVER_JMX_PORT -Dcom.sun.management.jmxremote.autodiscovery=true -Dcom.sun.management.jdp.name=$SERVER_JMX_NAME"

# Activation d'un monitoring continue automatique par défault via JMC
# - Seuil par la taille sur le disque avant rotation  : SERVER_JMX_JMC_SIZE
# - Seuil par la durée d'historisation avant rotation  : SERVER_JMX_JMC_AGE
# - Répertoire de travail (Monitoring temp dir): /opt/jalios/support/jplatform/record
# - Activation des dumps automatique en cas d’arrêt
# - Répertoire des dumps /opt/jalios/support/jplatform/dump/
#JVM_JMC_OPTS="-XX:FlightRecorderOptions=defaultrecording=true,disk=true,repository=/opt/jalios/support/jplatform/record,maxsize=$SERVER_JMX_JMC_SIZE,maxage=$SERVER_JMX_JMC_AGE,dumponexit=true,dumponexitpath=/opt/jalios/support/jplatform/dump/dumponexit-$DATETIME.jfr,settings=profile"

JAVA_OPTS="$JVM_OPTS $JVM_GC $JVM_MEM $JVM_JMX $JVM_JMC $JVM_JMC_OPTS"
