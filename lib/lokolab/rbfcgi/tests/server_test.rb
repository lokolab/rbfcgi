# Wrapper for applications in Ruby via "mod_fcgid".
#
# Copyright (c) Krystian Pietruszka <kpietru@lokolab.net>
# License MIT

require 'test/unit'
require 'lokolab/rbfcgi/server'

module LokoLab
  module Rbfcgi
    module Tests
      class ServerTest < Test::Unit::TestCase

        def test_instance_of
          server = LokoLab::Rbfcgi::Server.new()
          assert_instance_of(LokoLab::Rbfcgi::Server, server)
        end

        # TODO More tests.
      end
    end
  end
end

