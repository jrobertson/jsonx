Gem::Specification.new do |s|
  s.name = 'jsonx'
  s.version = '0.1.3'
  s.summary = 'Transforms JSON into JSONx'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_runtime_dependency('rexle', '~> 1.0', '>=1.0.23')
  s.signing_key = '../privatekeys/jsonx.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/jsonx'
end
