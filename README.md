# puppet_pot_generator
Library / Gem to generate a gettext style pot file from puppet code.

## Usage

Add this to your Gemfile.

```shell
gem "puppet_pot_generator", :git => 'git@github.com:puppetlabs/puppet_pot_generator.git'
```

Add this to your Rakefile.

```shell
require 'puppet_pot_generator/rake_tasks'
```

And to run the generation.

```shell
rake generate_puppet_pot
```
