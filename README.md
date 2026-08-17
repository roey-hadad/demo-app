# demo-app

A deliberately tiny "application" for the Real Time College Jenkins course.
It exists so the pipeline has something real to build, test and archive.

This is the **developer** repository. The `Jenkinsfile` lives here, next to the
code it builds - that is the whole argument of Module 4, slide 31.

## Layout

    Jenkinsfile          the pipeline, versioned with the code
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
