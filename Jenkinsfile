node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/getintodevops/hellonode.git']]])
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
         

        app = docker.build("hajaramjoun/getintodevops-hellonode")
    }
    stage('Test image') {
        /* We test our image with a simple smoke test:
         * Run a curl inside the newly-build Docker image */

        app.inside {
           container = app.run("--name hajar -p 7080:8080") 
            //sh 'curl http://localhost:7080 || exit 1'
        }
    }
}
    