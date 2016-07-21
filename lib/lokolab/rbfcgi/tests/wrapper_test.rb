# Wrapper for applications in Ruby via "mod_fcgid".
#
# Copyright (c) Krystian Pietruszka <kpietru@lokolab.net>
# License MIT

require 'test/unit'
require 'lokolab/rbfcgi/wrapper'

module LokoLab
  module Rbfcgi
    module Tests
      class WrapperTest < Test::Unit::TestCase

        def test_instance_of
          wrapper = LokoLab::Rbfcgi::Wrapper.new()
          assert_instance_of(LokoLab::Rbfcgi::Wrapper, wrapper)
        end
 
        def test_add_custom_path_to_gems_with_invalid_argument_custom_path_to_gems_exception
          assert_raise(ArgumentError) {
            wrapper = LokoLab::Rbfcgi::Wrapper.new()
            custom_path_to_gems = self
            wrapper.add_custom_path_to_gems(custom_path_to_gems)
          }
        end

        def test_add_custom_path_to_gems_with_invalid_argument_sufix_exception
          assert_raise(ArgumentError) {
            wrapper = LokoLab::Rbfcgi::Wrapper.new()
            custom_path_to_gems = '/somedir'
            sufix = self
            wrapper.add_custom_path_to_gems(custom_path_to_gems, sufix)
          }
        end

        def test_add_custom_path_to_gems_returns_self
          wrapper = LokoLab::Rbfcgi::Wrapper.new()
          custom_path_to_gems = '/somedir'
          ret = wrapper.add_custom_path_to_gems(custom_path_to_gems)
          assert_instance_of(LokoLab::Rbfcgi::Wrapper, ret)
        end

        def test_run_checks_global_flag
          wrapper = LokoLab::Rbfcgi::Wrapper.new()
          wrapper.run()
          assert_equal(ENV['lokolab.rbfcgi.wrapper'], 'on')
        end
      end
    end
  end
end

