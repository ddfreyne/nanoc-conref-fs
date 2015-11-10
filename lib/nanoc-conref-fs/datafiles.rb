require 'yaml'
require 'active_support/core_ext/hash'

require_relative 'conrefifier'

module Datafiles

  def self.apply_conditionals(config, path, content)
    data_vars = Conrefifier.file_variables(config[:data_variables], path)
    data_vars = { :page => data_vars, :site => { :config => config } }

    content = content.gsub(Conrefifier::BLOCK_SUB) do |match|
      # We must obfuscate Liquid variables while replacing conditionals
      match = match.gsub(/{{/, '~~#~~')
      match = Conrefifier.apply_liquid(match, data_vars)
      match.gsub('~~#~~', '{{')
    end

    doc = YAML.load(content)
    data_keys = "#{path}".gsub(%r{^data/}, '').gsub(%r{/}, '.').gsub(/\.yml/, '').split('.')
    # we don't need to create a nested hash for root-level data files
    if data_keys.length == 1
      { data_keys.first => doc }
    else
      create_nested_hash(data_keys, doc)
    end
  end

  def self.create_nested_hash(keys, final)
    keys.reverse.inject do |mem, var|
      if mem == keys.last
        { var => { mem => final } }
      else
        { var => mem }
      end
    end
  end

  def self.collect_data(dir)
    Dir["#{dir}/**/*.{yaml,yml}"]
  end

  def self.process(config)
    data = {}
    files = collect_data('data')
    files.each do |file|
      content = File.read(file)
      data = data.deep_merge apply_conditionals(config, file, content)
    end
    data
  end
end
