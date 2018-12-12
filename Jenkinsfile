node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
       
        //checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
dir ('/var/jenkins_home/workspace/ismail') { 
    
     sh('DockerStart')
}
        //app = docker.build("hajaramjoun/getintodevops-hellonode")
    }
}