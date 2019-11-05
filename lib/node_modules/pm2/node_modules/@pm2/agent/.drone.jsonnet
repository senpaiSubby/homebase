local pipeline(version) = {
    kind: "pipeline",
    name: "node-v" + version,
    steps: [
        {
            name: "tests",
            image: "node:" + version,
            commands: [
                "node -v",
                "yarn -v",
                "uname -r",
                "yarn install 2> /dev/null",
                "export PATH=$PATH:./node_modules/.bin/",
                "curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter",
                "chmod +x ./cc-test-reporter",
                "./cc-test-reporter before-build",
                "cov8 clear",
                "cov8 mocha test/units/InteractorClient.mocha.js",
                "cov8 mocha test/units/InteractorDaemon.mocha.js",
                "cov8 mocha test/units/PM2Client.mocha.js",
                "cov8 mocha test/units/Utility/stacktrace.mocha.js",
                "cov8 mocha test/units/Utility/cache.mocha.js",
                "cov8 mocha test/units/WatchDog.mocha.js",
                "cov8 mocha test/units/push/PushInteractor.mocha.js",
                "cov8 mocha test/units/push/TransactionAggregator.mocha.js",
                "cov8 mocha test/units/reverse/ReverseInteractor.mocha.js",
                "#cov8 mocha test/units/transporters/AxonTransport.mocha.js",
                "cov8 mocha test/units/transporters/WebsocketTransport.mocha.js",
                "cov8 mocha test/units/TransporterInterface.mocha.js",
                "cov8 mocha test/units/PM2Interface.mocha.js",
                "cov8 mocha test/integrations/websocket.mocha.js",
                "#cov8 mocha test/integrations/axon.mocha.js",
                "cov8 report lcov",
                "./cc-test-reporter after-build --exit-code 0 || echo \"Skipping CC coverage upload\" or upload-coverage || echo \"Skipping CC coverage upload\"",
            ],
            environment: {
              NODE_ENV: "test",
              CC_TEST_REPORTER_ID: {
                from_secret: "code_climate_token"
              },
              PM2_HOME: "/tmp"
            },
        },
    ],
    trigger: {
      event: "push"
    },
};

[
    pipeline("6"),
    pipeline("8"),
    pipeline("9"),
    pipeline("10"),
    pipeline("11"),
    {
        kind: "pipeline",
        name: "publish",
        trigger: {
          event: "tag"
        },
        steps: [
          {
            name: "publish",
            image: "plugins/npm",
            settings: {
              username: {
                from_secret: "npm_username"
              },
              password: {
                from_secret: "npm_password"
              },
              email: {
                from_secret: "npm_email"
              },
            },
          },
        ],
    },
    {
        kind: "secret",
        name: "npm_username",
        get: {
          path: "secret/drone/npm",
          name: "username",
        },
    },
    {
        kind: "secret",
        name: "npm_email",
        get: {
          path: "secret/drone/npm",
          name: "email",
        },
    },
    {
        kind: "secret",
        name: "npm_password",
        get: {
          path: "secret/drone/npm",
          name: "password",
        },
    },
    {
        kind: "secret",
        name: "code_climate_token",
        get: {
          path: "secret/drone/codeclimate",
          name: "token_agent",
        },
    },
]