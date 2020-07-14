#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'openssl'
require 'fileutils'

class AuthManager
  def initialize(pki_json_file_path:)
    @pki_json_file_path = pki_json_file_path
  end

  def process
    puts "###============== Output From Script Start ===============####"
    puts "                  Time: #{Time.now.utc}      \n\n"
    puts "    Sevice Cert Serial: #{service_certificate.serial.to_s(16)}"
    puts "    Primary Issuer CA : #{primary_issuer_ca_cert.issuer}  "
    puts "    Subject           : #{service_certificate.subject}  "
    puts "    Not Before        : #{service_certificate.not_before} "
    puts "    Not After         : #{service_certificate.not_after} "
    puts "\n    Secondary Issuers : #{secondary_issuers.join(",")} "
    puts "\n###============== Output From Script End ===============####\n\n"
  end

  private

  attr_reader :pki_json_file_path

  def pki_json_file_contents
    @pki_json_file_contents ||= File.read(pki_json_file_path)
  end

  def parsed_pki_json
    @parsed_pki_json ||= JSON.parse(pki_json_file_contents)
  end

  def certificate_details
    parsed_pki_json.fetch('primary').fetch('certificate_details')
  end

  def service_certificate
    @service_certificate ||= OpenSSL::X509::Certificate.new(certificate_details.fetch('certificate'))
  end

  def service_certificate_expiry
    @service_certificate_expiry ||= certificate_details.fetch('expiration')
  end

  def service_private_key
    @service_private_key ||= certificate_details.fetch('private_key')
  end

  def primary_issuer_ca_cert
    @primary_issuer_ca_cert ||= OpenSSL::X509::Certificate.new(certificate_details.fetch('issuing_ca'))
  end

  def secondary_issuers
    secondary_ca_certs = parsed_pki_json.fetch('secondary').map { |secondary| secondary.fetch('ca_details').fetch('certificate') }
    secondary_ca_certs.map do |certificate|
      OpenSSL::X509::Certificate.new(certificate).issuer
    end
  end
end

pki_json_file_path = ARGV.first.to_s

AuthManager.new(pki_json_file_path: pki_json_file_path).process

Kernel.exit(0)
