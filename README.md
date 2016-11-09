# Mu Pipeline service

Provides and documents pipeline resources to include in a [mu.semte.ch project](https://mu.semte.ch/).

## Model

### Namespaces
- dcterms: http://purl.org/dc/terms/
- pwo: http://purl.org/spar/pwo/
- pip: http://www.big-data-europe.eu/vocabularies/pipeline/

### Resources
#### Pipeline
Big Data pipeline describing a sequence of steps.

**Class:** pwo:Workflow

**Properties:**

Property | Predicate | Description
--- | --- | ---
title | dcterms:title | Name of the pipeline
description | dcterms:description | Description of the pipeline

#### Step
Building blocks of a pipeline.

**Class:** pwd:Step

**Properties:**

Property | Predicate | Description
--- | --- | ---
title | dcterms:title | Name of the step
description | dcterms:description | Description of the step
code | pip:code | Human readable identifier of the step
order | pip:order | Sequence number of the step in a pipeline
status | pip:status | Current status of the step. Value must be one of: `not_started`, `starting`, `running`, `done`, `ready`, `failed`.

## Integrate pipeline service in a mu.semte.ch project
Add the following snippet to your `docker-compose.yml` to include the pipeline service in your project.

```
pipeline:
  image: bde2020/mu-pipeline-service
  links:
    - database:database
```

`database` must be another service defined in your `docker-compose.yml` running a triple store (e.g. [Virtuoso](https://hub.docker.com/r/tenforce/virtuoso/))


Add rules to the `dispatcher.ex` to dispatch requests to the pipeline service. E.g. 

```
  match "/pipelines/*path" do
    Proxy.forward conn, path, "http://pipeline/pipelines/"
  end

  match "/steps/*path" do
    Proxy.forward conn, path, "http://pipeline/steps/"
  end
```

More information how to setup a mu.semte.ch project can be found in [mu-project](https://github.com/mu-semtech/mu-project).
