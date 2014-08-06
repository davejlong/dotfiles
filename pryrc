# -*- mode: ruby -*-
# vi: set ft=ruby :

Pry.config.editor = 'vim'
Pry::Commands.block_command('enable-pry', 'Enable `binding.pry` feature') do
  ENV['DISABLE_PRY'] = nil
end
