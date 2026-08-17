// ============================================================================
//  THE REAL-WORLD VERSION.
//
//  The pipeline itself lives once, in the jenkins-devops repository
//  (vars/buildDemoApp.groovy). This file just says "build me, like this".
//
//  Exactly like GitLab CI:
//      include:
//        - project: 'devops/ci-templates'
//          file:    '/build.yml'
//
//  40 microservices = 40 files that look like this one + ONE template.
// ============================================================================

@Library('rtc-ci@v1') _

buildDemoApp(
    name:     'demo-app',
    version:  '1.0.0',
    runTests: true
)
