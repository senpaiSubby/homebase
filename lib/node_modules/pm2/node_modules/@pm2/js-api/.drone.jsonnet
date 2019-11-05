local pipeline(version) = {
    kind: "pipeline",
    name: "node-v" + version,
    steps: [
        {
            name: "tests",
            image: "node:" + version,
            commands: [
              "yarn 2> /dev/null",
              "yarn run test",
            ],
            environment: {
              NODE_ENV: "test",
              KEYMETRICS_TOKEN: {
                from_secret: "keymetrics_token",
              },
            },
        },
    ],
    trigger: {
      event: ["push", "tag"]
    },
};

[
    pipeline("4"),
    pipeline("6"),
    pipeline("7"),
    pipeline("8"),
    pipeline("9"),
    pipeline("10"),
    {
        kind: "pipeline",
        name: "build & publish",
        trigger: {
          event: "tag"
        },
        depends_on: [
          "node-v4",
          "node-v6",
          "node-v7",
          "node-v8",
          "node-v9",
          "node-v10",
        ],
        steps: [
          {
            name: "build",
            image: "node:8",
            commands: [
              "yarn 2> /dev/null",
              "mkdir dist",
              "yarn run build",
              "yarn run dist",
            ],
          },
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
        name: "keymetrics_token",
        get: {
          path: "secret/drone/keymetrics",
          name: "token",
        },
    },
]
