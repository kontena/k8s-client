# K8s::Client

[![Build Status](https://travis-ci.com/kontena/k8s-client.svg?branch=master)](https://travis-ci.com/kontena/k8s-client)
[![Gem Version](https://badge.fury.io/rb/k8s-client.svg)](https://badge.fury.io/rb/k8s-client)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/github/kontena/k8s-client/master)


Ruby client library for the Kubernetes (1.11) API

## Highlights

* Clean API for dynamic Kubernetes API Groups / Resources
* Fast API requests using HTTP connection keepalive
* Fast API discovery and resource listings using pipelined HTTP requests
* Typed errors with useful debugging information

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'k8s-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install k8s-client

And then load the code using:

```ruby
require 'k8s-client'
```

## Usage

### Overview
The top-level `K8s::Client` provides access to separate `APIClient` instances for each Kubernetes API Group (`v1`, `apps/v1`, etc.), which in turns provides access to separate `ResourceClient` instances for each API resource type (`nodes`, `pods`, `deployments`, etc.).

Individual resources are returned as `K8s::Resource` instances, which are `RecursiveOpenStruct` instances providing attribute access (`resource.metadata.name`). The resource instances are returned by methods such as `client.api('v1').resource('nodes').get('foo')`, and passed as arguments for `client.api('v1').resource('nodes').create_resource(res)`. Resources can also be loaded from disk using `K8s::Resource.from_files(path)`, and passed to the top-level methods such as `client.create_resource(res)`, which lookup the correct API/Resource client from the resource `apiVersion` and `kind`.

The different `K8s::Error::API` subclasses represent different HTTP response codes, such as `K8s::Error::NotFound` or `K8s::Error::Conflict`.

See [`bin/k8s-client`](bin/k8s-client) for example code.

### Creating a client

#### Unauthenticated client

```ruby
client = K8s.client('https://localhost:6443', ssl_verify_peer: false)
```

The keyword options are [Excon](https://github.com/excon/excon/) options.

#### Client from kubeconfig

```ruby
client = K8s::Client.config(K8s::Config.load_file('~/.kube/config'))
```

#### Supported kubeconfig options

Not all kubeconfig options are supported, only the following kubeconfig options work:

* `current-context`
* `context.cluster`
* `context.user`
* `cluster.server`
* `cluster.insecure_skip_tls_verify`
* `cluster.certificate_authority`
* `cluster.certificate_authority_data`
* `user.client_certificate` + `user.client_key`
* `user.client_certificate_data` + `user.client_key_data`
* `user.token`

##### With overrides

```ruby
client = K8s::Client.config(K8s::Config.load_file('~/.kube/config'),
  server: 'http://localhost:8001',
)
```

#### In-cluster client from pod envs/secrets

```ruby
client = K8s::Client.in_cluster_config
```

### Logging

#### Quiet

To supress any warning messages:

```ruby
K8s::Logging.quiet!
K8s::Transport.quiet!
```

The `K8s::Transport` is quiet by default, but other components may log warnings in the future.

#### Debugging

Log all API requests

```ruby
K8s::Logging.debug!
K8s::Transport.verbose!
```

```
I, [2018-08-09T14:19:50.404739 #1]  INFO -- K8s::Transport: Using config with server=https://167.99.39.233:6443
I, [2018-08-09T14:19:50.629521 #1]  INFO -- K8s::Transport<https://167.99.39.233:6443>: GET /version => HTTP 200: <K8s::API::Version> in 0.224s
I, [2018-08-09T14:19:50.681367 #1]  INFO -- K8s::Transport<https://167.99.39.233:6443>: GET /api/v1 => HTTP 200: <K8s::API::MetaV1::APIResourceList> in 0.046s
I, [2018-08-09T14:19:51.018740 #1]  INFO -- K8s::Transport<https://167.99.39.233:6443>: GET /api/v1/pods => HTTP 200: <K8s::API::MetaV1::List> in 0.316s
```

Using `K8s::Transport.debug!` will also log request/response bodies. The `EXCON_DEBUG=true` env will log all request/response attributes, including headers.

### Prefetching API resources

Operations like mapping a resource `kind` to an API resource URL require knowledge of the API resource lists for the API group. Mapping resources for multiple API groups would require fetching the API resource lists for each API group in turn, leading to additional request latency. This can be optimized using resource prefetching:

```ruby
client.apis(prefetch_resources: true)
```

This will fetch the API resource lists for all API groups in a single pipelined request.

### Listing resources

```ruby
client.api('v1').resource('pods', namespace: 'default').list(labelSelector: {'role' => 'test'}).each do |pod|
  puts "namespace=#{pod.metadata.namespace} pod: #{pod.metadata.name} node=#{pod.spec.nodeName}"
end
```

### Updating resources

```ruby
node = client.api('v1').resource('nodes').get('test-node')

node[:spec][:unschedulable] = true

client.api('v1').resource('nodes').update_resource(node)
```

### Deleting resources

```ruby
pod = client.api('v1').resource('pods', namespace: 'default').delete('test-pod')
```

```ruby
pods = client.api('v1').resource('pods', namespace: 'default').delete_collection(labelSelector: {'role' => 'test'})
```

### Creating resources

#### Programmatically defined resources
```ruby
service = K8s::Resource.new(
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    namespace: 'default',
    name: 'test',
  },
  spec: {
    type: 'ClusterIP',
    ports: [
      { port: 80 },
    ],
    selector: {'app' => 'test'},
  },
)

logger.info "Create service=#{service.metadata.name} in namespace=#{service.metadata.namespace}"

service = client.api('v1').resource('services').create_resource(service)
```

#### From file(s)

```ruby
resources = K8s::Resource.from_files('./test.yaml')

for resource in resources
  resource = client.create_resource(resource)
end
```

### Patching resources

```ruby
client.api('apps/v1').resource('deployments', namespace: 'default').merge_patch('test', {
    spec: { replicas: 3 },
})
```

### Watching resources

```ruby
client.api('v1').resource('pods', namespace: 'default').watch(labelSelector: {'role' => 'test'}) do |watch_event|
  puts "type=#{watch_event.type} pod=#{watch_event.resource.metadata.name}"
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kontena/k8s-client.
