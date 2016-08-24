Gem::Specification.new do |s|
  s.name    = 'chilean_rut'
  s.version = '0.2'
  s.date    = '2016-08-24'
  s.summary = 'Formato y validacion de RUT Chileno'
  s.authors = ["Gonzalo"]
  s.email   = 'contacto@gonzalorios.cl'
  s.files   = Dir['lib/*']
  s.homepage  = 'https://github.com/xalupeao/chilean_rut'
  s.license   = 'MIT'

  s.add_development_dependency 'test-unit', '~> 3.2', '>= 3.2.1'
  s.add_development_dependency 'pry', '~> 0.10.4'
end
