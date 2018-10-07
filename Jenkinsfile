#!/usr/bin/env groovy

/**
 * Sample Jenkinsfile for Jenkins2 Pipeline
 * from https://github.com/hotwilson/jenkins2/edit/master/Jenkinsfile
 * by Wilson Mar@gmail.com 
 */
 
import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL

try {
  node ('docker') {
//   checkout scm
   
   stage '\u2776 env'
   /* Only keep the 10 most recent builds. */
   properties([[$class: 'BuildDiscarderProperty',
                strategy: [$class: 'LogRotator', numToKeepStr: '2']]])

   echo "BUILD_CAUSE=${env.BUILD_CAUSE}"
   echo "BUILD_ID=${env.BUILD_ID}"
   echo "BUILD_NUMBER=${env.BUILD_NUMBER}"
   echo "BUILD_TAG=${env.BUILD_TAG}"
   echo "JENKINS_URL=${env.JENKINS_URL}"
   echo "\u2600 BUILD_URL=${env.BUILD_URL}"

   echo "EXECUTOR_NUMBER=${env.EXECUTOR_NUMBER}"
   echo "HOME=${env.HOME}"
   echo "HUDSON_HOME=${env.HUDSON_HOME}"
   echo "WORKSPACE=${env.WORKSPACE}"
   def workspace = pwd()
   echo "\u2600 workspace=${workspace}"

   echo "JOB_NAME=${env.JOB_NAME}"
   echo "JAVA_HOME=${env.JAVA_HOME}"

   echo "PWD=${env.PWD}"
   echo "OLDPWD=${env.OLDPWD}"
   echo "JENKINS=${env.JENKINS}"
   echo "USER=${env.USER}"
   echo "TERM=${env.TERM}"

   echo "LANG=${env.LANG}"
   echo "LOGNAME=${env.LOGNAME}"
   echo "NODE_NAME =${env.NODE_NAME}"

   tokens = "${env.JOB_NAME}".tokenize('/')
   org = tokens[0]
   repo = tokens[1]
   branch = tokens[2]
   // echo 'org/repo/branch=${env.JOB_NAME}'

   stage '\u2777 remote'
   echo "GIT_COMMIT  =${env.GIT_COMMIT}"
   echo "GIT_URL =${env.GIT_URL}"
   echo "GIT_BRANCH =${env.GIT_BRANCH}"
   echo "CVS_BRANCH  =${env.CVS_BRANCH}"
   echo "SVN_REVISION =${env.SVN_REVISION}"

/*
   stage 'getRemote'
   def workspace1 = manager.build.workspace.getRemote()
   echo "workspace1=${workspace1}"



   stage 'collect' 
   sh 'git rev-parse HEAD > GIT_COMMIT'
   def shortCommit = readFile('GIT_COMMIT').take(6)
   def image = docker.build("jenkinsciinfra/bind.build-${shortCommit})")

 
   stage 'Deploy'
   image.push()
*/

} catch (exc) {
    err = caughtError
    currentBuild.result = "FAILURE"
/*
    String recipient = 'infra@lists.jenkins-ci.org'
    mail subject: "${env.JOB_NAME} (${env.BUILD_NUMBER}) failed",
            body: "It appears that ${env.BUILD_URL} is failing, somebody should do something about that",
              to: recipient,
         replyTo: recipient,
    from: 'noreply@ci.jenkins.io'
*/
} finally {
    (currentBuild.result != "ABORTED") && node("master") {
        // Send e-mail notifications for failed or unstable builds.
        // currentBuild.result must be non-null for this step to work.
        step([$class: 'Mailer',
           notifyEveryUnstableBuild: true,
           recipients: "${email_to}",
           sendToIndividuals: true])
    }

    /* Must re-throw exception to propagate error */
    if (err) {
        throw err
    }
}
