# demo-app

A deliberately tiny "application" for the Real Time College Jenkins course.
It exists so the pipeline has something real to build, test and archive.

This is the **developer** repository.

## Two Jenkinsfiles, on purpose

| File | What it is |
|---|---|
| `Jenkinsfile` | **The real-world version.** 4 lines. Calls the shared template in `jenkins-devops`. This is what you ship. |
| `Jenkinsfile.full` | **The teaching version.** Every block spelled out, for slides 33-38. Never ship this into 40 repos. |

The thin one is the Jenkins equivalent of GitLab CI's `include:` - the pipeline
lives once, centrally, and each app repo just points at it with its own
parameters. Switch between them with **Configure > Pipeline > Script Path**.

Either way a file must exist here. GitLab needs a `.gitlab-ci.yml` in every repo
too; Jenkins needs a `Jenkinsfile`. Neither lets you have zero file.

## Layout

    Jenkinsfile          4 lines - calls the shared template (real world)
    Jenkinsfile.full     the full pipeline, spelled out (teaching)
    Makefile             build / test / lint / clean
    src/app.sh           the "application"
    tests/run-tests.sh   test harness, writes JUnit XML to reports/

## Run it by hand

    make build VERSION=1.0.0 BUILD=7
    make test
    make lint
    make clean

    ./dist/app.sh --version
    ./dist/app.sh --greet jenkins
    ./dist/app.sh --add 3 4

## Making the tests fail on purpose

    FAIL_TESTS=true make test

The harness still exits 0. Jenkins' `junit` step reads the XML, sees a failure
and marks the build **UNSTABLE (yellow)** - which is the SUCCESS / UNSTABLE /
FAILURE distinction from Module 3, slide 27, demonstrated instead of described.

## Branches to create for the Multibranch demo (slide 39)

    main       -> "Deploy production" stage appears (needs ENVIRONMENT=prod)
    develop    -> "Deploy staging" stage runs
    feature/x  -> neither deploy stage runs

One file, different behaviour per branch, expressed with `when`.
