# concourse_mock

mocks out your pipeline so that things run faster
is great for debugging and refactoring your large pipelines!

![](sample_images/example.png)

example concourse maniefest:
```yaml
jobs:
- name: mock_test
  plan:
  - in_parallel:
      steps:
      - get: your_resource
        params:
          mock:
            files:
            - tasks/destroy-environment/task.yml
        resource: mock_your_resource
  - file: your_resource/tasks/destroy-environment/task.yml
    task: mock_me
resource_types:
- name: mock
  source:
    repository: pnikonowicz/concourse_mock
    tag: latest
  type: docker-image
resources:
- name: mock_your_resource
  source:
    branch: master
    private_key: |
      -----BEGIN RSA PRIVATE KEY-----
      -----END RSA PRIVATE KEY-----
    uri: git@github.com:your_repo.git
  type: mock
```

configure the mock resource the same way that you would your git resource.

include all the files that you don't want to run in your pipeline. 
