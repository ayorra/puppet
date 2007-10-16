#!/usr/bin/env ruby
#
#  Created by Rick Bradley on 2007-10-16.
#  Copyright (c) 2007. All rights reserved.

require File.dirname(__FILE__) + '/../../../../spec_helper'
require 'puppet/network/http'

describe Puppet::Network::HTTP::MongrelREST, "when initializing" do
    before do
        @mock_mongrel = mock('Mongrel server')
        @params = { :server => @mock_mongrel, :handlers => [ :foo ] }
    end
    
    it "should require access to a Mongrel server" do
        Proc.new { Puppet::Network::HTTP::MongrelREST.new(@params.delete_if {|k,v| :server == k })}.should raise_error(ArgumentError)
    end
    
    it "should require at least one indirection name" do
        Proc.new { Puppet::Network::HTTP::MongrelREST.new(@params.delete_if {|k,v| :handlers == k })}.should raise_error(ArgumentError)        
    end
    
    it "should look up the indirection model from the indirection name" do
        mock_model = mock('indirected model')
        Puppet::Indirector::Indirection.expects(:model).with(:foo).returns(mock_model)
        Puppet::Network::HTTP::MongrelREST.new(@params)
    end
    
    it "should fail if a handler is not indirected" do
        Puppet::Indirector::Indirection.expects(:model).with(:foo).returns(nil)
        Proc.new { Puppet::Network::HTTP::MongrelREST.new(@params) }.should raise_error(ArgumentError)
    end
    
    it "should register a listener for each indirection with the provided Mongrel server"
end

describe Puppet::Network::HTTP::MongrelREST, "when receiving a request" do
    it "should unpack request information from Mongrel"
    it "should unpack parameters from the request for passing to controller methods"    
    it "should call the controller find method if the request represents a singular HTTP GET"
    it "should call the controller search method if the request represents a plural HTTP GET"
    it "should call the controller destroy method if the request represents an HTTP DELETE"
    it "should call the controller save method if the request represents an HTTP PUT"
    it "should serialize the result from the controller method for return back to Mongrel"
    it "should serialize a controller expection result for return back to Mongrel"
end
