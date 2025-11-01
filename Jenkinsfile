// Jenkinsfile for Spring PetClinic Application
// Scripted Pipeline with Build and Test Stages

node {
    def mavenHome = tool 'Maven-3.8.6' // Configure Maven version in Jenkins
    def javaHome = tool 'JDK-17' // Configure JDK version in Jenkins
    
    // Environment variables
    env.PATH = "${mavenHome}/bin:${javaHome}/bin:${env.PATH}"
    env.JAVA_HOME = "${javaHome}"
    env.M2_HOME = "${mavenHome}"
    
    stage('Checkout') {
        echo 'Checking out source code...'
        checkout scm
    }
    
    stage('Build') {
        echo 'Building Spring PetClinic application...'
        try {
            sh """
                mvn clean compile -DskipTests
            """
            echo 'Build completed successfully!'
        } catch (Exception e) {
            echo "Build failed: ${e.getMessage()}"
            currentBuild.result = 'FAILURE'
            throw e
        }
    }
    
    stage('Test') {
        echo 'Running tests...'
        try {
            sh """
                mvn test
            """
            echo 'All tests passed successfully!'
        } catch (Exception e) {
            echo "Tests failed: ${e.getMessage()}"
            // Archive test results even if tests fail
            junit 'target/surefire-reports/*.xml'
            currentBuild.result = 'FAILURE'
            throw e
        }
    }
    
    stage('Archive Artifacts') {
        echo 'Archiving build artifacts...'
        try {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            junit 'target/surefire-reports/*.xml'
            echo 'Artifacts archived successfully!'
        } catch (Exception e) {
            echo "Warning: Failed to archive artifacts: ${e.getMessage()}"
        }
    }
    
    stage('Notify') {
        echo 'Build pipeline completed!'
        // You can add email/Slack notifications here
    }
}

